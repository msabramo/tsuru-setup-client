tsuru-setup-client
==================

A script to automate setting up the tsuru client software

Compatibility
-------------

Tested on:

- OS X 10.9.4 (with [Homebrew](http://brew.sh) installed)
- Ubuntu 14.04

Run it
------

Customize the variables for your environment:

```bash
export TSURU_TARGET=tsuru.yourcompany.com:8080
export TSURU_USER=${USER}@yourcompany.com
export TSURU_PASSWORD=defaultpassword
```

and then run the script:

```bash
curl -sk https://raw.githubusercontent.com/msabramo/tsuru-setup-client/master/tsuru-setup-client.sh | bash
```
