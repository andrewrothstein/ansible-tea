#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://gitea.com/gitea/tea/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local dotexe=${4:-""}
    local platform="${os}-${arch}"
    local file="tea-${ver}-${platform}${dotexe}"
    local dlfile=$DIR/$file
    # https://gitea.com/gitea/tea/releases/download/v0.9.2/tea-0.9.2-darwin-amd64
    local url=$MIRROR/v${ver}/$file
    if [ ! -e $dlfile ];
    then
        curl -sSLf -o $dlfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $dlfile | awk '{ print $1 }')
}

dl_ver ()
{
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux amd64
    dl $ver linux arm-5
    dl $ver linux arm-6
    dl $ver linux arm-7
    dl $ver linux arm64
    dl $ver windows amd64 .exe
}

dl_ver ${1:-0.11.1}
