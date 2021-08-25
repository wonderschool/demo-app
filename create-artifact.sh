#!/usr/bin/env bash

rm artifact.json

echo "Creating artifact.."
gimlet artifact create \
--repository "laszlocph/gimletd-test-repo" \
--sha "b4f08b375865e0c484c0c98282e61860df99d129" \
--created "2021-08-12T14:09:31+02:00" \
--branch "main" \
--event "push" \
--authorName "Laszlo Fogas" \
--authorEmail "laszlo@laszlo.cloud" \
--committerName "Laszlo Fogas" \
--committerEmail "laszlo@laszlo.cloud" \
--message "Triggering a deploy" \
--url "https://github.com/laszlocph/gimletd-test-repo/commit/b4f08b375865e0c484c0c98282e61860df99d129" \
> artifact.json

echo "Attaching Gimlet manifests.."
for file in .gimlet/*
do
    if [[ -f $file ]]; then
    gimlet artifact add -f artifact.json --envFile $file
    fi
done

# gimlet artifact push -f artifact.json