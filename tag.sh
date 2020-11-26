#!/bin/bash

prefix="test-"
# pre_prefix="pre-"

target_branch=$(git symbolic-ref --short -q HEAD)
echo "当前分支为 ${target_branch}"

if `git status | grep "RELEASE" &>/dev/null`; then
    prefix="pro-"
elif `git status | grep "pre-branch" &>/dev/null`; then
    prefix="pre-"
fi

# echo ${prefix}

# # 当参数大于0且第一个参数为pre 即命名tag前缀
# if [[ $# -gt 0 ]] && [[ $1 == "pre" ]]; then 
#     prefix=${pre_prefix}
# fi

function mi_tag() {
    # git push
    git pull --tags
    local new_tag=$(echo ${prefix}$(date +'%Y%m%d')-$(git tag -l "${prefix}$(date +'%Y%m%d')-*" | wc -l | xargs printf '%02d'))
    echo ${new_tag}
    git tag ${new_tag}
    git push origin $new_tag
    
    echo "\n*******************************************************************************************"
    echo "     1.去往gitlab地址查看构建状态: https://micode.be.xiaomi.com/qiankun/qiankun/pipelines" 
    echo "     ***********************************************" 
    echo "     2.若构建完成则去往CHAOS平台发布代码: https://chaos.pf.xiaomi.com/neo/app/overview?_treeId=12145&_treeSearch=qiankun" 
    echo "*******************************************************************************************\n"

}

mi_tag;