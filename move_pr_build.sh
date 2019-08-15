#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" != "false" ]
then
  mkdir -p build/pr-${TRAVIS_PULL_REQUEST}
  mv resume.pdf build/pr-${TRAVIS_PULL_REQUEST}/
  mv resume.docx build/pr-${TRAVIS_PULL_REQUEST}/
fi