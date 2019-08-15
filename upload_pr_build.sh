#!/bin/bash
# loosely based on https://medium.com/onfido-tech/travis-surge-github-auto-deploy-every-pr-branch-and-tag-a6c8c790831f
REPO_SLUG_ARRAY=(${TRAVIS_REPO_SLUG//\// })
REPO_OWNER=${REPO_SLUG_ARRAY[0]}
REPO_NAME=${REPO_SLUG_ARRAY[1]}
RESUME_PDF=resume.pdf
RESUME_DOCX=resume.docx
FILEBIN=https://filebin.net

if [ "$TRAVIS_PULL_REQUEST" != "false" ]
then
  FILEBIN_BIN=${REPO_OWNER}-${REPO_NAME}-pr-${TRAVIS_PULL_REQUEST}
  curl --data-binary @./${RESUME_PDF} -H "filename: ${RESUME_PDF}" -H "bin: ${FILEBIN_BIN}" $FILEBIN
  curl --data-binary @./${RESUME_DOCX} -H "filename: ${RESUME_DOCX}" -H "bin: ${FILEBIN_BIN}" $FILEBIN
  GITHUB_PR_COMMENTS=https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments
  UPLOAD_BIN=${FILEBIN}/${FILEBIN_BIN}
  curl -H "Authorization: token ${api_key}" --request POST ${GITHUB_PR_COMMENTS} --data '{"body":"Travis automatic upload: '${UPLOAD_BIN}'"}'
else
  echo "Not a PR build; nothing to do here"
fi