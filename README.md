# JMM Remote Fieldcam

These are the configuration files and some notes about the Jayhawk Model Masters Fieldcam:

http://jayhawkmodelmasters.com/webcam.html

The fieldcam is run on a Raspberry Pi but as the field is off\-grid and only has solar power, the system must be configured very carefully to be adminstrated over a consumer LTE connection, which does not allow incoming connections for remote administration.

Version 1 proved mostly reliable, but not reliable enough.  This project documents the efforts and changes for version 2.

## Hardware

* Raspberry Pi Model 2 or better (this changes as we consider the actual computer disposable
* Raspberry Pi Camera Module V2-8 Megapixel
* Netgear LTE Broadband Modem https://smile.amazon.com/gp/product/B01N5ASNTE
* Netgeat MIMO Antenna https://smile.amazon.com/Netgear-6000450-MIMO-Antenna-Connectors/dp/B00DN3J03O

We tried a consumer hotspot and is continously overheated, overcharged the battery and had a poor connection.


## Primary Changes for Version 2

### Logging

The RPi sends logs to https://papertrailapp.com/ for monitoring purposes. Version 1 fieldcam did this as well right before retirement, to generate an estimate around log events.  The fieldcams generate about 100MB of logs per month, meaning they can fit in the free tier of many cloud log providers.

### AWS Systems Manager

Version 2 was bootstrapped as a managed instance using the AWS Systems Manager from the beginning.  Version 1 was done later.  This was not a pleasant experience and the Activation process for managed instances in AWS SSM is obtuse and error prone.  However, once it starts working it is as reliable as the internet connection.

### Ansible and Ansible-pull

Version 1 used a reverse SSH tunnel through a VPS for administration.  It was unreliable and slow.
Version 2 uses Ansible with the ansible-pull script to get its configurations from a git repository.  AWS SSM is available as a backup.
