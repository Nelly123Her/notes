# OpenBSD configuration Minix OS

### Install packages
```sh
pkg_add git
```

### Uninstall packages
```sh
pkg_delete git
```
### Enable demons
```sh
rcctl enable sshd
```
### Starting demons

```sh
rcctl start sshd
```
### Restarting demons
```sh
rcctl restart  sshd
```