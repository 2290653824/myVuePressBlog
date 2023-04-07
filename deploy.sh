#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
# set -e


push_addr=`git remote get-url -push origin` # git提交地址，也可以手动设置，比如：push_addr=git@github.com:xugaoyi/vuepress-theme-vdoing.git
commit_info=`git describe --all --always --long`
dist_path=docs/.vuepress/dist # 打包生成的文件夹路径
push_branch=gh-pages # 推送的分支

# 生成静态文件
# npm run build

# 进入生成的文件夹
cd $dist_path

git init
git checkout -b master
git config --global user.email "2290653824@qq.com"
git config --global user.name "zhengjian"
git add -A
git commit -m "deploy, $commit_info"
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "当前所在分支：${current_branch}"
# git push -f $push_addr HEAD:$push_branch
git push -f https://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@github.com/2290653824/2290653824.github.io HEAD:master --force


cd -
rm -rf $dist_path