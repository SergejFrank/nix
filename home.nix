{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = "/home/sfrank";

    packages = with pkgs; [
      direnv
      docker
      docker-compose
      fzf
      git
      graalvm17-ce
      htop
      nix-direnv
      ripgrep
      ripgrep-all
      tree
      tldr
    ];

    stateVersion = "22.11";
    username = "sfrank";

    sessionVariables  = { HMPROFILE = "sfrank"; };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.git = {
    enable = true;
    userName = "Sergej Frank";
    userEmail = "git@sergej-frank.de";
  };


  programs.bash = {
      initExtra = ''
        export ABC=abc
     '';
  };

  programs.home-manager.enable = true;
}
