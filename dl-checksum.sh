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
    local file="tea-${ver}-${platform}${dotexe}.sha256"
    local dlfile=$DIR/$file
    # https://gitea.com/gitea/tea/releases/download/v0.9.2/tea-0.9.2-darwin-amd64.sha256
    local url=$MIRROR/v${ver}/$file
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(curl -sSLf $url | awk '{ print $1}')
}

dl_ver ()
{
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux 386
    dl $ver linux amd64
    dl $ver linux arm
    dl $ver linux arm64
    dl $ver windows 386 .exe
    dl $ver windows amd64 .exe
}

dl_ver ${1:-0.9.2}
