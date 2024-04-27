# bootparamd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with bootparamd](#setup)
    * [What bootparamd affects](#what-bootparamd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bootparamd](#beginning-with-bootparamd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages bootparamd on OpenBSD.

## Module Description

The module configures and manages the bootparamd service.

## Setup

### What bootparamd affects

* configures /etc/bootparams
* manages bootparamd service

### Setup Requirements **OPTIONAL**

The module depends on bodgit-portmap to configure portmap.

### Beginning with bootparamd

In the very simplest case, you just include the following:

```
include bootparamd
```

Configuration example for Hiera:

```
bootparamd::bootparams:
  node1:
    nfsrootserver: "192.168.1.23"
    nfsrootpath: '/export/node1'
```

## Limitations

This version works for OpenBSD bootparamd.

## Development

Report issues or PRs at the GitHub repository here: https://github.com/buzzdeee/buzzdeee-bootparamd
