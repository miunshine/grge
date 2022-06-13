{ pkgs, config, lib, ... }:
{
  # Disable my right arrow key, since it is broken.
  systemd.services.keycode-swap = {
    enable = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.kbd}/bin/setkeycodes e04d 0
    '';
  };
}
