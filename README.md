# Puppet Helper for CloudSigma

This is a script that helps you manage your CloudSigma architecture in Puppet by exporting meta data as 'facts'. The way this works is that the each server has a serial device attached (`/dev/ttyS1` on Linux). By polling this interface, we get JSON back that we can expose to Puppet. For more technical details on how this works please take a look at the [Server Contextualization](https://autodetect.cloudsigma.com/docs/server_context.html) documentation.

## Installation

On most systems, the device (`/dev/ttyS1`) cannot be read by any user. Hence, you might need to either run facter as root (or via sudo), or grant your user access to read to the device.

The script is written in Ruby and relies on two different Gems. Since it is assumed you have Ruby installed (you are running Puppet after all), here are the Gems you need to install:

    sudo gem install serialport json

Once you have installed the Gems, you need to copy `cloudsigma.rb` to your facter-folder. Depending on your installation, this may differ (`sudo find / -type d -iname facter` should give you an idea). On Ubuntu 12.04 with the Puppet installed from Canonical's repository, the path is `/usr/lib/ruby/1.8/facter`.


## Usage

With the file installed, you should be able to run facter and get the facts exposed. All exported variables are starts with 'cs_'.

Here's an example of how it may look.

    $ sudo facter |grep cs_
    cs_cpu => 1000
    cs_cpus_instead_of_cores => false
    cs_enable_numa => false
    cs_mem => 536870912
    cs_name => MyServer
    cs_smp => 1
    cs_tags =>
    cs_uuid => 6cc039ad-d024-4ecf-b0de-83dbc297f9ba
    cs_vnc_password => abc123

Currently only these variables are exposed. More variables will be added (including user-defined meta data).

## Limitations

This tool should be considered an 'alpha', and has only been tested on Ubuntu 12.04. Bug reports are welcome.

Given the above information, it not come as a surprise that this tool does not support Windows.
