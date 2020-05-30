#!/bin/bash
set -e
set -o pipefail

# Read Snippet helper
readSnippet(){ IFS=$'\n' read -r -d '' "${1}" || true; }

# Enables Disqus comments when ${DISQUS_SHORTNAME} is set
# for the casper theme
# https://ghost.org/integrations/disqus/
function disqusCasperSetup ()
{
    declare -r casperPostFile="${GHOST_CONTENT}/themes/casper/post.hbs"
    declare -r disqusSnippetFile="${GHOST_INSTALL}/disqus.txt";
    local REPLACE;
    local CONTENT;
    # Don't indent this heredoc section
readSnippet REPLACE <<'EOF'
            {{\!--
            <section class="post-full-comments">
                If you want to embed comments, this is a good place to do it!
            </section>
            --}}
EOF

    if [[ -n "${DISQUS_SHORTNAME}" && -f "${casperPostFile}" && -f "${disqusSnippetFile}" ]]; then
        REPLACE=$(echo "${REPLACE}" | sed -e ':a' -e 'N' -e '$!ba' -e 's#\n#\\n#g')
        CONTENT=$(sed -e ':a' -e 'N' -e '$!ba' -e 's#\n#\\n#g' "${disqusSnippetFile}")
        echo "Setup disqus for shortname \"${DISQUS_SHORTNAME}\""
        sed -i -e ':a' -e 'N' -e '$!ba' -e "s#${REPLACE}#${CONTENT}#" "${casperPostFile}"
    fi
    return 0
}

# allow the container to be started with `--user`
if [[ "$*" == node*current/index.js* ]] && [ "$(id -u)" = '0' ]; then
    find "${GHOST_CONTENT}" \! -user node -exec chown node '{}' +
    disqusCasperSetup
    exec su-exec node "${BASH_SOURCE[0]}" "$@"
fi

if [[ "$*" == node*current/index.js* ]]; then
    baseDir="${GHOST_INSTALL}/content.orig"
    for src in "$baseDir"/*/ "$baseDir"/themes/*; do
        src="${src%/}"
        target="${GHOST_CONTENT}/${src#$baseDir/}"
        mkdir -p "$(dirname "$target")"
        if [ ! -e "$target" ]; then
            tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
        fi
    done
    disqusCasperSetup
fi

exec "$@"