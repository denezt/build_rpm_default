# RPMBUILD Tools
## Default Scripts for Building Red Hat Packages using RPMBUILD

PURPOSE:  *Automate the building of RPM Packages.* <br/>
OS TYPE:   *Red Hat Linux*<br/>
DIFFICULTY: *Advanced*<br/>

``` bash
# Run once before starting build process. 
~> ./install_prereqs.sh
```
``` bash
# Display the help menu.
~> ./create_build_user.sh --help
```
``` bash
# Starts the build process
~> ./create_build_user.sh --start
```
After running the _'create_build_user'_ script you can then execute switch user command:

``` bash
~> su - build
```
``` sh
[build@build-machine ~]$
```
Now, you can start the _`rpmbuild`_ process.
``` sh
# Builds the Complete RPM source and binaries.
[build@build-machine ~]$ rpmbuild -ba displaymsg-1.0/displaymsg.spec
```

### Additional Commands:
``` bash
rpm -i -v /home/build/rpmbuild/RPMS/x86_64/displaymsg-1.0-1.x86_64.rpm
```
Outputs:
> Preparing packages...<br/>
> displaymsg-1.0-1.x86_64<br/>

