# odmpy-watch
watch directory for odm files and run odmpy to download. Folders mapped from NAS via CIFS so cannot use inotify etc. need cache=none option in mount.cifs to prevent error on file move.

```
/etc/systemd/system/odmpy.service
sudo systemctl daemon-reload
sudo systemctl enable odmpy.service 
sudo systemctl start odmpy.service 
```
