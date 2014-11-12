#!/bin/sh

PROG="tsuru-setup"

if [ -z "${TSURU_USER}" ]; then
    echo "${PROG}: Please set the TSURU_USER environment variable before running this script"
    exit 1
fi

if [ -z "${TSURU_TARGET}" ]; then
    echo "${PROG}: Please set the TSURU_TARGET environment variable before running this script"
    exit 2
fi

echo
echo "*********************************************"
echo "  Installing tsuru packages"
echo "*********************************************"
echo

if [ "$(uname)" = "Darwin" ]; then
    brew tap tsuru/homebrew-tsuru
    brew install tsuru tsuru-admin crane
elif [ "$(uname)" = "Linux" ]; then
    if [ "$(lsb_release -s -i)" = "Ubuntu" ]; then
        set -x
        sudo apt-add-repository --yes ppa:tsuru/ppa
        { set +x; } 2>/dev/null
        echo
        set -x
        sudo apt-get update --yes
        { set +x; } 2>/dev/null
        echo
        set -x
        sudo apt-get install --yes expect tsuru-client tsuru-admin crane
        { set +x; } 2>/dev/null
    fi
fi

echo
echo "*********************************************"
echo "  Adding tsuru target"
echo "*********************************************"
echo

set -x
tsuru target-add default ${TSURU_TARGET} --set-current
{ set +x; } 2>/dev/null

echo
echo "*********************************************"
echo "  Doing tsuru login"
echo "*********************************************"
echo

expect <<__EOF__
set timeout -1
spawn tsuru login ${TSURU_USER}
expect -exact "Password: "
send -- "${TSURU_PASSWORD}\r"
expect eof
__EOF__

echo
echo "*********************************************"
echo "  Doing tsuru key-add"
echo "*********************************************"
echo

set -x
tsuru key-add
{ set +x; } 2>/dev/null

echo
echo "*********************************************"
echo "  Suggest that user change password"
echo "*********************************************"
echo

echo "You should change your password. Do:"
echo
echo "    tsuru change-password"
