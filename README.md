puppet-sshkeys
==============
Puppet module to manage ssh public keys.

[![Build Status](https://travis-ci.org/fraenki/puppet-sshkeys.svg?branch=master)](https://travis-ci.org/fraenki/puppet-sshkeys)

* [Introduction](#introduction)
* [Features](#features)
* [Requirements](#requirements)
* [How to use it](#how-to-use-it)
  * [sshkeys](#sshkeys)
  * [sshkeys::user](#sshkeysuser)
  * [sshkeys::key](#sshkeyskey)
* [Contributing](#contributing)
* [License and copyright](#license-and-copyright)

Introduction
============

Why again another module for this? Initially inspired by [erwbgy/ssh][erwbgy/ssh], but in the end I was missing a module for ssh key management only, which could be used with/without hiera, without any big dependencies(which might result to the conflicts, because somebody would use another module).

So this module is only a wrapper around the core puppet types: [User][puppet_user] and [Ssh_authorized_key][puppet_sshkey]

Features
========
 - Management of ssh public keys
 - No dependencies to other modules
 - Can be used with and without Hiera
 - Ensures that only allowed/configured keys are deployed, e.g. with drop of all unmanaged keys

Requirements
============
 - Puppet >3.6 because of [purge_ssh_keys][puppet_relnotes]
 - [Puppetlabs Stdlib][puppet_stdlib]

How to use it
=============

This are usage examples which do not cover everything, see the definitions in the folder manifests for all possible parameters, especially for the [sshkeys::user](#sshkeysuser) type.

## sshkeys
This is the top class which can be just included somewhere: with according parameters it will create all required resources from the types [sshkeys::user](#sshkeysuser) and [sshkeys::key](#sshkeyskey).

**Usage without hiera lookups:**
```
  class{'sshkeys':
    users => {
      'sometestuser' => {
        'home' => '/home/sometestuser',
        'keys' => {
          'first-test-key' => {
            type => 'ssh-rsa',
            key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          },
          'second-test-key' => {
            type => 'ssh-rsa',
            key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
          },
        },
      },
      'sometestuser2' => {
        'home' => '/home/sometestuser2',
        'keys' => {
          'first-test-key' => {
            type => 'ssh-rsa',
            key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          },
        },
      },
    },
  }
```

**Usage with hiera lookups:**
```
# hash with keys in the hiera structure. The hash is merged with hiera_hash lookup
sshkeys::keys:
  first-test-key:
    type: 'ssh-rsa'
    key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r'
  second-test-key:
    type: 'ssh-rsa'
    key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR'
# hash with users in the hiera structure. The hash is merged with hiera_hash lookup
sshkeys::users:
  sometestuser:
    home: /home/sometestuser
    keys:
      - first-test-key
      - second-test-key
  sometestuser2:
    home: /home/sometestuser2
    keys:
      - first-test-key
```

```
  include sshkeys
  #or assign it via hiera, ENC
```

## sshkeys::user

sshkeys::user supports all important parameters for useradd [User](puppet_user) provider. It extends the [User](puppet_user) type with a possibility to manage the keys of a particular user, it can be used as drop-in replacement for [User](puppet_user) type. Parameter "home" has to be specified to allow the ssh key management.

**Usage without hiera lookups:**

```
  sshkeys::user{'sometestuser':
    home => '/home/sometestuser',
    keys => {
      'first-test-key' => {
        type => 'ssh-rsa',
        key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
      },
      'second-test-key' => {
        type => 'ssh-rsa',
        key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
      },
    },
  }
```

**Usage with hiera lookups:**

```
# hash with keys in the hiera structure. The hash is merged with hiera_hash lookup
sshkeys::keys:
  first-test-key:
    type: 'ssh-rsa'
    key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r'
  second-test-key:
    type: 'ssh-rsa'
    key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR'
```

```
  sshkeys::user{'sometestuser':
    home => '/home/sometestuser',
    keys => ( 'first-test-key', 'second-test-key'),
  }
```

## sshkeys::key
You can use this directly, but the only advantage over ssh_authorized_key is a possibility of hiera lookup for the keys.

**Usage without hiera lookups (just the same like ssh_authrozied_key):**

```
  sshkeys::key { "some-uniq-name":
    key_name => 'first-test-key',
    user     => 'sometestuser',
    type     => 'ssh-rsa',
    key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
  }
```

**Usage with hiera lookups:**

```
# hash with keys in the hiera structure. The hash is merged with hiera_hash lookup
sshkeys::keys:
  first-test-key:
    type: 'ssh-rsa'
    key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r'
  second-test-key:
    type: 'ssh-rsa'
    key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR'
```

```
  sshkeys::key { "some-uniq-name1":
    key_name => 'first-test-key',
    user     => 'sometestuser',
  }
  sshkeys::key { "some-uniq-name2":
    key_name => 'second-test-key',
    user     => 'sometestuser',
  }
```

Contributing
============

Please use [GitHub Pull requests][github_pullreq] for this.

License and copyright
=====================
Copyright 2014 Artem Sidorenko and contributors.

See the COPYRIGHT file at the top-level directory of this distribution
and at https://github.com/artem-sidorenko/puppet-sshkeys/blob/master/COPYRIGHT



[erwbgy/ssh]: https://forge.puppetlabs.com/erwbgy/ssh
[puppet_user]: http://docs.puppetlabs.com/references/latest/type.html#user
[puppet_sshkey]: http://docs.puppetlabs.com/references/latest/type.html#sshauthorizedkey
[puppet_relnotes]: http://docs.puppetlabs.com/puppet/latest/reference/release_notes.html#feature-purging-unmanaged-ssh-authorized-keys
[puppet_stdlib]: https://forge.puppetlabs.com/puppetlabs/stdlib
[github_pullreq]: https://help.github.com/articles/using-pull-requests
