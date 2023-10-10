if status --is-interactive
    switch (uname)
        case Linux
            [ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
            abbr --add --global up 'sudo apt update && apt list --upgradable'
            abbr --add --global upg 'sudo apt upgrade'
            abbr --add --global docker 'sudo docker'
            abbr --add --global dc 'sudo docker-compose'
        case Darwin
            [ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
            abbr --add --global dc 'docker-compose'
    end

    if type -q $pyenv
        status is-login; and pyenv init --path | source
        pyenv init - | source
    end

    set -g theme_nerd_fonts yes

    abbr --add --global gam 'git commit -v --amend'
    abbr --add --global gap 'git add -p'
    abbr --add --global gb 'git branch'
    abbr --add --global gba 'git branch --all'
    abbr --add --global gcb 'git branch | tac | fzf | xargs -r git checkout'
    abbr --add --global gci 'git commit -v'
    abbr --add --global gcl 'git clean -fdxn'
    abbr --add --global gco 'git checkout'
    abbr --add --global gcp 'git checkout -p'
    abbr --add --global gfi 'git commit -v --fixup'
    abbr --add --global gfp 'git fetch -p'
    abbr --add --global gg 'git grep'
    abbr --add --global gl 'git log --oneline --graph'
    abbr --add --global gla 'git log --oneline --graph --all'
    abbr --add --global gls 'git ls-files'
    abbr --add --global gp 'git pull'
    abbr --add --global gs 'git status'

    abbr --add --global tigb 'tig (git branch | fzf | sed "s/ //g")'

    abbr --add --global k 'kubectl'
    abbr --add --global kd 'kubectl --kubeconfig /home/joel/.kube/config-dev'
    abbr --add --global ks 'kubectl --kubeconfig /home/joel/.kube/config-staging'
    abbr --add --global kp 'kubectl get pods --field-selector status.phase=Pending --sort-by=.metadata.creationTimestamp -n'
    abbr --add --global kr 'kubectl get pods --field-selector status.phase=Running --sort-by=.metadata.creationTimestamp -n'

    abbr --add --global p2r 'jq -r ".default | to_entries[] | .key + .value.version"'
    abbr --add --global py 'python3'
end
