{
  systemd.services.disable-backlight = {
    description = "Disable the fucking light";
    wantedBy = [ "default.target" ];
#    partOf = [ "user@1000.service" ];
    script = "echo 0 > /sys/devices/platform/sony-laptop/kbd_backlight";
  };
}

#{
#  systemd.user.services = {
#    disable-backlight = {
#      serviceConfig = {
#        Unit = {
#          Description =
#            "Disables the useless Sony VAIO keyboard backlight";
#          WantedBy = [ "default.target" ];
#        };
#    
#        Service = {
#          ExecStart =
#            "echo > 0 /sys/devices/platform/sony-laptop/kbd_backlight";
#          Restart = "on-failure";
#        };
#      };
#    };
#  };
#}
