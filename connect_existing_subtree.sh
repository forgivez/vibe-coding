#!/bin/bash

echo "📁 [1] 상위 디렉토리 경로 입력 (예: python_project)"
read -p "Category folder (e.g., python_project): " CATEGORY

echo "📦 [2] 프로젝트 폴더명 입력 (예: image-detect)"
read -p "Project folder name: " PROJECT_NAME

echo "🌐 [3] GitHub 리포 주소 입력 (예: https://github.com/yourusername/image-detect.git)"
read -p "GitHub repo URL: " REPO_URL

PROJECT_PATH="$CATEGORY/$PROJECT_NAME"

if [ ! -d "$PROJECT_PATH" ]; then
  echo "❌ 폴더 '$PROJECT_PATH' 가 존재하지 않습니다. 먼저 해당 프로젝트 폴더를 만들어주세요."
  exit 1
fi

echo "🚀 [$PROJECT_PATH] 폴더에서 Git 리포 초기화 및 원격 연결 시작"

# 하위 프로젝트 디렉토리로 이동
cd "$PROJECT_PATH"

# Git 리포 초기화 및 첫 커밋
git init
echo "# $PROJECT_NAME" > README.md
git add .
git commit -m "Initial commit for $PROJECT_NAME"
git remote add origin "$REPO_URL"
git branch -M main
git push -u origin main

# 다시 루트로 이동 (vibe-coding)
cd ../../

echo "🌲 [vibe-coding] 루트에서 subtree 연결 중..."
git subtree add --prefix="$PROJECT_PATH" "$REPO_URL" main --squash

# 커밋 & 푸시
git commit -m "Add $PROJECT_NAME as subtree in $CATEGORY"
git push

echo "✅ 완료: '$PROJECT_NAME' 프로젝트가 subtree로 연결되었습니다."
