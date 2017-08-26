#!/bin/bash

TARGET="/opt/puppetlabs/puppet/modules"

puppet module install puppetlabs-apt --version 4.1.0 --target-dir $TARGET
puppet module install puppetlabs-stdlib --version 4.19.0 --target-dir $TARGET
puppet module install puppet-archive --version 2.0.0 --target-dir $TARGET
puppet module install maestrodev-ssh_keygen --version 999.999.999 --target-dir $TARGET
puppet module install puppetlabs-java --version 2.1.0 --ignore-dependencies --target-dir $TARGET
