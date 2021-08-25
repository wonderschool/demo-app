#!/usr/bin/env bash

rm artifact.json

echo "Creating artifact.."
gimlet artifact create \
--repository "laszlocph/gimletd-test-repo" \
--sha "0fda000842458a21b575c3ac9a83fcea79ac04bb" \
--created "2021-08-12T14:09:31+02:00" \
--branch "main" \
--event "push" \
--authorName "Laszlo Fogas" \
--authorEmail "laszlo@laszlo.cloud" \
--committerName "Laszlo Fogas" \
--committerEmail "laszlo@laszlo.cloud" \
--message "Triggering a deploy" \
--url "https://github.com/laszlocph/gimletd-test-repo/commit/0fda000842458a21b575c3ac9a83fcea79ac04bb" \
> artifact.json

echo "Attaching Gimlet manifests.."
for file in .gimlet/*
do
    if [[ -f $file ]]; then
    gimlet artifact add -f artifact.json --envFile $file
    fi
done

gimlet artifact add -f artifact.json --var SHA=0fda000842458a21b575c3ac9a83fcea79ac04bb

# gimlet artifact push -f artifact.json