# personal.zsh

# Kubernetes docker aliases
alias start_kubectl='docker run --rm -it -v ~/.kube:/root/.kube alpine/k8s:1.24.12 sh'
alias start_kubectl_mount_current_dir='docker run --rm -it -v ~/.kube:/root/.kube -v ./:/apps alpine/k8s:1.24.12 sh'

alias e="$EDITOR_BULK ~/.zshrc ~/.zsh/aliases.zsh ~/.zsh/custom.zsh ~/.zsh/distro/ubuntu.zsh ~/.zsh/distro/archlinux.zsh ~/.zsh/exports.zsh ~/.zsh/functions.zsh ~/.zsh/personal.zsh ~/.zsh/plugins.zsh ~/.zsh/tasks.zsh ~/.zsh/themes.zsh"