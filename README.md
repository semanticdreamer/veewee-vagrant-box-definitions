#veewee-vagrant-box-definitions

Create custom [Vagrant] [vagrant] (development) server boxes (i386, 32-Bit) with [VeeWee] [veewee].

Why *custom*?

* To be used with [VirtualBox] [virtualbox] version **4.1.8**: VirualBox guest additions 4.1.8 get installed.
* [Ruby] [ruby]-friendly development environment: in case of *Ubuntu 10.04.4 Lucid Lynx Server Vagrant box* latest [RubyGems] [rubygems] version is installed.
* Properly named boxes, e.g. "debian-6.0.4-squeeze-server".
* [Veewee] [veewee] build steps wrapped by shell scripts, incl. option to delete tmp file artifacts.
* Intended to be used (shared) as *git submodule* with other projects.

Add as submodule:

    git submodule add git@github.com:semanticdreamer/veewee-vagrant-box-definitions.git ./veewee
    git submodule init && git submodule update

##Building Blocks

* [Ruby] [ruby]
* [Virtual Box] [virtualbox] - a general-purpose full virtualizer for x86 hardware.
* [Vagrant] [vagrant] - a tool for building and distributing virtualized development environments.
* [VeeWee] [veewee] - a tool to easily build vagrant base boxes (or kvm, virtualbox and fusion images).

##Requirements

* *nix OS (preferably either Mac OS X or a flavour of Linux, e.g. Debian/ Ubuntu)
* [Ruby] [ruby] installed
* [rubygems] [rubygems] installed

##Setup

Install [Virtual Box] [virtualbox], version **4.1.8**.

Install [Vagrant] [vagrant] and [VeeWee] [veewee] as a *RubyGem*:

    gem install vagrant veewee

##Build boxe(s) of choice

The `build.sh` script will also add the created box to your local vagrant environment (`vagrant box add...`).

    $./build.sh
    
    Usage:
        build.sh veewee-definition
    
    Available Veewee definitions:
    
    "debian-6.0.4-squeeze-server"
    "ubuntu-10.04.4-lucid-lynx-server"

##Build and Usage Example

In order to build `debian-6.0.4-squeeze-server.box`:

    ./build.sh build-debian-6.0.4-squeeze-server

Configuring the Project to use the Box: `Vagrantfile`

    Vagrant::Config.run do |config|
      config.vm.box = "debian-6.0.4-squeeze-server"
    end


[vagrant]: http://vagrantup.com/  "Vagrant"
[veeWee]: https://github.com/jedi4ever/veewee "Veewee"
[ruby]: http://www.ruby-lang.org/ "Ruby"
[rubygems]: http://rubygems.org/ "RubyGem"
[virtualbox]: http://www.virtualbox.org/ "VirtualBox"
