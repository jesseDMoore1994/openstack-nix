{
  users.users.adtran = {
    isNormalUser  = true;
    home  = "/home/adtran";
    extraGroups  = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$Cx3OegZfydDHQjAo$E0yK.txQ7usDAw80GdMxW./ScR81yH8CxHNG/dVbIuHiTKfpaVhOYl5LLd2j7NsgANc/RES6ZeKcfSP69UeMm/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKm+gtptToHUWVIVd52pDPXcw4oDnno5ZrCkYIv79lUr jesse@jessemoore.dev" 
      # content of authorized_keys file
      # note: ssh-copy-id will add user@clientmachine after the public key
      # but we can remove the "@clientmachine" part
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 5000 ];
  };
  services.nix-serve.enable = true;
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    # passwordAuthentication = false;
    # kbdInteractiveAuthentication = false;
    #permitRootLogin = "yes";
  };
  system.stateVersion = "23.05";
}
