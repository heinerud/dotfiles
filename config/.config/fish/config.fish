if status --is-interactive
    switch (uname)
        case Linux
            source /usr/share/autojump/autojump.fish
            abbr --add --global up 'sudo apt update && apt list --upgradable'
            abbr --add --global upg 'sudo apt upgrade'
            abbr --add --global d 'sudo docker'
            abbr --add --global docker 'sudo docker'
            abbr --add --global dc 'sudo docker compose'
            abbr --add --global kd 'kubectl --kubeconfig /home/joel/.kube/config-dev'
            abbr --add --global ks 'kubectl --kubeconfig /home/joel/.kube/config-staging'
        case Darwin
            fish_add_path /opt/homebrew/bin
            fish_add_path /opt/homebrew/sbin
            source /opt/homebrew/share/autojump/autojump.fish
            abbr --add --global d 'docker'
            abbr --add --global dc 'docker compose'
            abbr --add --global kd 'kubectl --kubeconfig /Users/joel/.kube/config-dev'
            abbr --add --global ks 'kubectl --kubeconfig /Users/joel/.kube/config-staging'
    end


    fzf --fish | source

    set -g theme_nerd_fonts yes

    fish_add_path --global ~/.local/bin

    abbr --add --global adev 'ansible-playbook site.yml -i inventories/development/ -l app1.test --ask-vault-pass --check'
    abbr --add --global astaging 'ansible-playbook site.yml -i inventories/staging/ -l app1.staging.smarteye.se --ask-vault-pass --check'
    abbr --add --global aprod 'ansible-playbook site.yml -i inventories/production/ -l app1.smarteye.se --ask-vault-pass --check'

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
    abbr --add --global gst 'git stash'
    abbr --add --global gstp 'git stash pop'

    abbr --add --global tigb 'tig (git branch | fzf | sed "s/ //g")'
    abbr --add --global lg 'lazygit'

    abbr --add --global k 'kubectl'
    abbr --add --global kp 'kubectl get pods --field-selector status.phase=Pending --sort-by=.metadata.creationTimestamp -n'
    abbr --add --global kr 'kubectl get pods --field-selector status.phase=Running --sort-by=.metadata.creationTimestamp -n'
    abbr --add --global ke 'kubectl get events --sort-by=.metadata.creationTimestamp -n'

    abbr --add --global p2r 'jq -r ".default | to_entries[] | .key + .value.version"'
    abbr --add --global py 'python3'
end
