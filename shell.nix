with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    git
    gnumake
    jq
    kind
    kubectl
    kubevirt
  ];
  shellHook = ''
    source <(kind completion bash)
    source <(kubectl completion bash)
    source <(virtctl completion bash)

    alias k=kubectl
    complete -o default -F __start_kubectl k
  '';
}
