# Fetch git repos by their absolute paths listed in the REPOS variable.
# Set this variable in your sysm_include.

MODULE="git_fetch.sh"
DEPS=("git")

if check_deps; then
    CURRENT_DIR="$(pwd)"
    for REPO in $REPOS; do
        cd $REPO
        git fetch
    done
    cd $CURRENT_DIR
fi
