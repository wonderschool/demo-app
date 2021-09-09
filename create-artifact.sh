#!/usr/bin/env bash

HASH=$(git log -1 --format=%H)
DATE=$(git log -1 --format=%cI)
MESSAGE=$(git log -1 --format=%s)

rm artifact.json

echo "Creating artifact.."
gimlet artifact create \
--repository "laszlocph/gimletd-test-repo" \
--sha "$HASH" \
--created "$DATE" \
--branch "main" \
--event "push" \
--authorName "Laszlo Fogas" \
--authorEmail "laszlo@laszlo.cloud" \
--committerName "Laszlo Fogas" \
--committerEmail "laszlo@laszlo.cloud" \
--message "$MESSAGE" \
--url "https://github.com/laszlocph/gimletd-test-repo/commit/$HASH" \
> artifact.json

echo "Attaching Gimlet manifests.."
for file in .gimlet/*
do
    if [[ -f $file ]]; then
    gimlet artifact add -f artifact.json --envFile $file
    fi
done

gimlet artifact add -f artifact.json --var SHA=$HASH

# gimlet artifact push -f artifact.json