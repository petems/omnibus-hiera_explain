hiera_explain Omnibus project
==============================
This project creates full-stack platform-specific packages for
`hiera_explain`!

Why?
------------

[hiera_explain](https://github.com/binford2k/hiera_explain) is an awesome tool. However, as a gem, it can overwrite the binary path for hiera, puppet and facter. Definetly something you want to avoid on your production infrastructure!

The various gems it needs also require newer versions of Ruby, which might not be avaliable on older systems (CentOS 6 is still on 1.8.7 Ruby)

So instead, this repo allows the creation of specific omnibus packages, and installs the hiera configuration under `/opt/hiera_explain`, allowing one to determine issues with your hiera config without having to worry about conflicting with your existing Puppet install:

```
[root@hiera-explain-centos-6]# /opt/hiera_explain/bin/hiera_explain
Backend data directories:
  * yaml: /etc/puppetlabs/code/environments/production/hieradata

Expanded hierarchy:
  * common

File lookup order:
  [ ] /etc/puppetlabs/code/environments/production/hieradata/common.yaml

Priority lookup results:

Array lookup results:

Hash lookup results:
```

Packages are avaliable from the [release page](https://github.com/petems/omnibus-hiera_explain/releases).

Pre-Requite Steps
------------

#### CentOS 6
```
yum install epel* -y;
yum install yajl-devel make gcc yajl-devel https://github.com/feedforce/ruby-rpm/releases/download/2.3.1/ruby-2.3.1-1.el6.x86_64.rpm gcc gcc-c++ gecode-devel gecode-devel  gecode-devel autoconf tree git prepeation preparation patch fakeroot rpmbuild rpm-build patch fakeroot rpm-build -y;
yum install http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm -y;
yum install -y git;
git config --global user.email "you@example.com"
git config --global user.name "Your Name";
gem install bundler;
git clone https://github.com/petems/omnibus-hiera_explain /opt/omnibus-hiera_explain;
cd /opt/omnibus-hiera_explain;
bundle install --binstubs;
bin/omnibus build hiera_explain;
```


Installation
------------
You must have a sane Ruby 1.9+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ bundle install --binstubs
```

Usage
-----
### Build

You create a platform-specific package using the `build project` command:

```shell
$ bin/omnibus build hiera_explain
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. For example, running this command
on a MacBook Pro will generate a Mac OS X package. After the build completes
packages will be available in the `pkg/` folder.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bin/omnibus clean hiera_explain
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/hiera_explain`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bin/omnibus clean hiera_explain--purge
```

### Publish

Omnibus has a built-in mechanism for releasing to a variety of "backends", such
as Amazon S3. You must set the proper credentials in your `omnibus.rb` config
file or specify them via the command line.

```shell
$ bin/omnibus publish path/to/*.deb --backend s3
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bin/omnibus help
```

Kitchen-based Build Environment
-------------------------------
Every Omnibus project ships will a project-specific
[Berksfile](http://berkshelf.com/) that will allow you to build your omnibus projects on all of the projects listed
in the `.kitchen.yml`. You can add/remove additional platforms as needed by
changing the list found in the `.kitchen.yml` `platforms` YAML stanza.

This build environment is designed to get you up-and-running quickly. However,
there is nothing that restricts you to building on other platforms. Simply use
the [omnibus cookbook](https://github.com/opscode-cookbooks/omnibus) to setup
your desired platform and execute the build steps listed above.

The default build environment requires Test Kitchen and VirtualBox for local
development. Test Kitchen also exposes the ability to provision instances using
various cloud providers like AWS, DigitalOcean, or OpenStack. For more
information, please see the [Test Kitchen documentation](http://kitchen.ci).

Once you have tweaked your `.kitchen.yml` (or `.kitchen.local.yml`) to your
liking, you can bring up an individual build environment using the `kitchen`
command.

```shell
$ bin/kitchen converge ubuntu-1204
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login ubuntu-1204
[vagrant@ubuntu...] $ cd hiera_explain
[vagrant@ubuntu...] $ bundle install
[vagrant@ubuntu...] $ ...
[vagrant@ubuntu...] $ bin/omnibus build hiera_explain
```

For a complete list of all commands and platforms, run `kitchen list` or
`kitchen help`.
