#!/usr/bin/perl
use warnings;
use strict;

use Module::Build;

Module::Build->new(
    module_name => 'URI::Title::iTMS',
    license => 'perl',
    requires => {
      'URI::Title'        => 1,
      'Net::iTMS'         => 0,
    },
    create_makefile_pl => 'traditional',
)->create_build_script;

