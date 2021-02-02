<<<<<<< HEAD
# Singularity container for sPHENIX and EIC-sPHENIX

Singularity container for sPHENIX and EIC-sPHENIX allow collaborators to run sPHENIX RCF/SDCC environment with the nightly builds on your local computers or on external high-performance computing clusters. 

This repository includes the instruction and local update macro for this Singularity container.

**Daily validations:** `updatebuild.sh --build=new` 
[![Build Status](https://web.racf.bnl.gov/jenkins-sphenix/buildStatus/icon?job=sPHENIX%2Fsingularity-download-validation)](https://web.racf.bnl.gov/jenkins-sphenix/job/sPHENIX/job/singularity-download-validation/) 

[![Macros](https://img.shields.io/badge/standard%20macros-git-green.svg)](https://github.com/sPHENIX-Collaboration/macros)
[![Tutorials](https://img.shields.io/badge/tutorials-git-green.svg)](https://github.com/sPHENIX-Collaboration/tutorials)
[![Doxygen](https://img.shields.io/badge/code%20reference-Doxygen-green.svg)](https://sphenix-collaboration.github.io/doxygen/)
[![Last Commit](https://img.shields.io/github/last-commit/sPHENIX-Collaboration/Singularity.svg)](https://github.com/sPHENIX-Collaboration/Singularity/commits/master)

# How to download

sPHENIX and EIC-sPHENIX software can be obtained to your local computing environment in two ways. You can use both - there is no collision between these two options. Which you use is determined by the start of the singularity container (look closely - for option 1 you use /cvmfs:/cvmfs which mounts our cvmfs volume under /cvmfs, for option 2 you use cvmfs:/cvmfs which mounts your local copy under /cvmfs)

1. **[Option-1 Mount sPHENIX CVMFS](#option-1-mount-sphenix-cvmfs)**: sPHENIX container, software and builds are distribute on [CVMFS](https://www.racf.bnl.gov/docs/services/cvmfs/info) since Nov 2018. Like RCF/SDCC computing cluster at BNL, external collaborating computing center could also mount the `/cvmfs/sphenix.opensciencegrid.org` (*preferred choice*) or `/cvmfs/sphenix.sdcc.bnl.gov/` CVMFS repository, which automatically obtain, buffer and update all sPHENIX build files. `/cvmfs/sphenix.opensciencegrid.org` is also distributed by default throughout the [Open Science Grid](opensciencegrid.org). 
2. **[Option-2 Download sPHENIX build via HTTPS archive](#option-2-download-sphenix-build-via-https-archive)**: one can also directly download the files for sPHENIX build to a local folder via [the nightly refreshed HTTPS archive](https://sphenix.sdcc.bnl.gov/WWW/user/phnxbld/sPHENIX/Singularity/). 

The advantage of **Option-1 Mount sPHENIX CVMFS** is that it mounts all sPHENIX builds and software and perform automatic caching and updates. This would be suitable for the case of a computing center or server environment. However, it requires constant network connection to function. Therefore, if you wish to use sPHENIX/EIC-sPHENIX software on a laptop during travel, **Option-2 Downloading sPHENIX build via HTTPS archive** would work best. All download instructions are the same for sPHENIX and EIC-sPHENIX. 

*Note*: although singularity container are supported under [MacOS](#mac-installation) and Windows Linux Subsystem, it runs best under Linux. Therefore, for Windows and Mac user, it would produce most smooth experience to run Option2 within a Linux virtual machine, such as [an Unbuntu VirtualBox](VirtualBox.md).

## Option-1: Mount sPHENIX CVMFS

1. On your local system, install [Singularity](https://sylabs.io/singularity/). 

    - *Note: Singularity installation may require host to support local compilation. E.g. on Ubuntu, it can be obtained via `sudo apt-get install libtool m4 automake`*

2. Install [CVMFS from CERN](https://cernvm.cern.ch/portal/filesystem/quickstart). CERN support build packages under (various Linux distribution and MAC)[https://cernvm.cern.ch/portal/filesystem/downloads].

    - *Note: for loading `/cvmfs/sphenix.opensciencegrid.org` by default, you may need to add `CVMFS_STRICT_MOUNT=no` to `/etc/cvmfs/default.local`.*

3. [**Optional**] *this step only applies to mounting `/cvmfs/sphenix.sdcc.bnl.gov/` in order to reproduce identical CVMFS structure with SDCC/RCF. However, use of `/cvmfs/sphenix.opensciencegrid.org` is more convenient and this step can be skipped*. 

Copy these three configuration and key files to your local computer from RCF (e.g. from any interactive RCF computer nodes):

```
/etc/cvmfs/keys/sdcc.bnl.gov/sphenix.sdcc.bnl.gov.pub
/etc/cvmfs/config.d/sphenix.sdcc.bnl.gov.local
/etc/cvmfs/domain.d/sdcc.bnl.gov.local
```

   Add `sphenix.sdcc.bnl.gov` to `CVMFS_REPOSITORIES` in `/etc/cvmfs/default.local`. e.g. 
```
CVMFS_REPOSITORIES=sphenix.sdcc.bnl.gov
```
   You may also need to specify `CVMFS_HTTP_PROXY` in `/etc/cvmfs/default.local` from your local computing to access the `http://cvmfs.sdcc.bnl.gov:8000/` server. For direct network access, `CVMFS_HTTP_PROXY=DIRECT` would work. 

   After completing step 2 and 3, please confirm you can read local path `/cvmfs/sphenix.sdcc.bnl.gov/`, which should show same content as that on RCF interactive nodes. 
   
4. launch singularity container for sPHENIX and EIC-sPHENIX with following command


  - For `/cvmfs/sphenix.opensciencegrid.org` users:

```
singularity shell -B /cvmfs:/cvmfs /cvmfs/sphenix.opensciencegrid.org/singularity/rhic_sl7_ext.simg
source /cvmfs/sphenix.opensciencegrid.org/x8664_sl7/opt/sphenix/core/bin/sphenix_setup.sh -n   # setup sPHENIX environment in the singularity container shell. Note the shell is bash by default
root # give a test
```

*For Singularity v3+, in particular CERN computing users: `rhic_sl7_ext.simg` might be slow to load under certain Singularity security settings at your computing center. In that case, please load with an alternative image: `singularity shell -B /cvmfs:/cvmfs /cvmfs/sphenix.opensciencegrid.org/singularity/rhic_sl7_ext`*

  - For `/cvmfs/sphenix.sdcc.bnl.gov` users:

```
singularity shell -B /cvmfs:/cvmfs /cvmfs/sphenix.sdcc.bnl.gov/singularity/rhic_sl7_ext.simg
source /opt/sphenix/core/bin/sphenix_setup.sh -n   # setup sPHENIX environment in the singularity container shell. Note the shell is bash by default
root # give a test
```

## Option-2: Download sPHENIX build via HTTPS archive


1. On your local system, install [Singularity](https://sylabs.io/singularity/). 

    - *Note: Singularity installation may require host to support local compilation. E.g. on Ubuntu, it can be obtained via `sudo apt-get install libtool m4 automake`*

2. Download this repository:

```
git clone https://github.com/sPHENIX-Collaboration/Singularity.git
cd Singularity/
```

3. Run the download/update macro [updatebuild.sh](./updatebuild.sh).

```
./updatebuild.sh
```

This macro download the current release of sPHENIX/EIC-sPHENIX Singularity container and nightly build libs. The total download size is about 5 GB  and decompressed disk usage is about 10 GB. Two build versions are supported with default as the `new` build, as well as the `root5` build with `./updatebuild.sh --build=root5`. The new build with gcc 8.3 can be downloaded using `./updatebuild.sh --sysname=gcc-8.3`


4. Start the container with 

```
singularity shell -B cvmfs:/cvmfs cvmfs/sphenix.sdcc.bnl.gov/singularity/rhic_sl7_ext.simg
source /opt/sphenix/core/bin/sphenix_setup.sh -n   # setup sPHENIX environment in the singularity container shell. Note the shell is bash by default
root # give a test
```
*Please note the slight difference in singularity shell commands for option 1 and option 2*

5. To get daily build update, run the download/update macro [updatebuild.sh](./updatebuild.sh) to sync build files again. 


# What's next

After entering the Singularity container, you can source sPHENIX environment and interact with it in the same way as on RCF: 

```
computer:~/> singularity shell <options depending on which of the two downloading options above>
Singularity: Invoking an interactive shell within container...
Singularity rhic_sl7_ext.simg:~/> source /opt/sphenix/core/bin/sphenix_setup.sh -n  
# or source /cvmfs/sphenix.opensciencegrid.org/x8664_sl7/opt/sphenix/core/bin/sphenix_setup.sh -n # if using sphenix.opensciencegrid.org
# or source /cvmfs/sphenix.opensciencegrid.org/gcc-8.3/opt/sphenix/core/bin/sphenix_setup.sh -n # if using gcc v8
Singularity rhic_sl7_ext.simg:~/> lsb_release  -a         # Verify same environment shows up as that on RCF
LSB Version:	:core-4.1-amd64:core-4.1-ia32:core-4.1-noarch
Distributor ID:	Scientific
Description:	Scientific Linux release 7.3 (Nitrogen)
Release:	7.3
Codename:	Nitrogen
```

This bring up a shell environment which is identical to sPHENIX RCF. Meanwhile, it use your local file system for non-system files, e.g. it directly work on your code or data directories. Singularity container also support running in the [command mode or background mode](https://sylabs.io/docs/). 

Next, please try [the sPHENIX simulation tutorial](https://github.com/sPHENIX-Collaboration/macros). 

Please discuss on [sPHENIX software email list](https://lists.bnl.gov/mailman/listinfo/sphenix-software-l) and [meeting](https://indico.bnl.gov/categoryDisplay.py?categId=88) regarding any question or suggestion.

# Troubleshooting

## MacOS installation

Singularity runs under linux OS. But in macOS, it require another layer of virtual machine to generate a linux environment first ([read more on Singularity docs](https://www.sylabs.io/guides/2.5/user-guide/quick_start.html#installation)). The easiest approach would be using the container [within a Unbuntu VirtualBox](VirtualBox.md). Alternatively, Here is [a more detailed guild on the macOS installation of sPHENIX container](./OSX_installationguide.md). 

## Windows installation

The easiest approach is to install [Virtual Box](https://www.virtualbox.org/) running our [within a Unbuntu VirtualBox](VirtualBox.md).

## 3D accelerated Graphics

The container is built for batch computing. It could be tricky to bring up 3D-accelerated graphics for Geant4 display. 
* On Linux, binding local X IPC socket folder to the singularity container could help enabling local hardware 3D acceleration, e.g. `singularity -B /tmp/.X11-unix:/tmp/.X11-unix ....` followed with `setenv DISPLAY unix:0.0` in the container. 
* On MacOS and Windows, accelerated graphics runs well with [a Linux VirtualBox](VirtualBox.md) with graphical acceleration enabled in the VirtualBox. 
* On MacOS John H. have developed [a note on how to get the 3D graphics working on MAC](https://indico.bnl.gov/event/4046/contributions/25558/attachments/21219/28796/singularity_mac_haggerty_20181217.pdf). 

## Clean download in Option-2

Occasionally, local download cache can become corrupt, e.g. after an interrupted `updatebuild.sh` call. If you encounter a problem executing container, it is always useful to first try clean up the local download buffer by removing the `./cvmfs` folder and download again. Or you can run `./updatebuild.sh --clean <other options>` which force a clean download (default is incremental updates). 

If you have RCF credentials, you can also compare your local output with the daily test runs of the default simulation macro in the container following these links: `updatebuild.sh --build=new` 
[![Build Status](https://web.racf.bnl.gov/jenkins-sphenix/buildStatus/icon?job=sPHENIX%2Fsingularity-download-validation)](https://web.racf.bnl.gov/jenkins-sphenix/job/sPHENIX/job/singularity-download-validation/) , 
`--build=root5`
[![Build Status](https://web.racf.bnl.gov/jenkins-sphenix/buildStatus/icon?job=sPHENIX%2Fsingularity-download-validation-root5)](https://web.racf.bnl.gov/jenkins-sphenix/job/sPHENIX/job/singularity-download-validation-root5/)
=======

# Welcome

This is the standard macros respository for [sPHENIX collaboration](https://www.sphenix.bnl.gov/). Following is the 10-min tutorial on using the sPHENIX macros from [this wiki link](https://wiki.bnl.gov/sPHENIX/index.php/Tutorial/sPHENIX_simulation).

[![Build Status](https://web.sdcc.bnl.gov/jenkins-sphenix/buildStatus/icon?job=sPHENIX/sPHENIX_CoreSoftware_MasterBranch)](https://web.sdcc.bnl.gov/jenkins-sphenix/job/sPHENIX/job/sPHENIX_CoreSoftware_MasterBranch/)
[![Doxygen](https://img.shields.io/badge/code%20reference-Doxygen-green.svg)](https://www.phenix.bnl.gov/WWW/sPHENIX/doxygen/html/)
[![Singularity](https://img.shields.io/badge/container-Singularity%20via%20CVMFS-green.svg)](https://github.com/sPHENIX-Collaboration/Singularity)

[![Open Issues](https://img.shields.io/github/issues/sPHENIX-Collaboration/macros.svg)](https://github.com/sPHENIX-Collaboration/macros/issues)
[![Open Pull Request](https://img.shields.io/github/issues-pr/sPHENIX-Collaboration/macros.svg)](https://github.com/sPHENIX-Collaboration/macros/pulls)
[![Monthly Commits](https://img.shields.io/github/commit-activity/m/sPHENIX-Collaboration/macros.svg)](https://github.com/sPHENIX-Collaboration/macros/commits/master)
[![Last Commit](https://img.shields.io/github/last-commit/sPHENIX-Collaboration/macros.svg)](https://github.com/sPHENIX-Collaboration/macros/commits/master)

# Get started

Please follow [SPHENIX software day-1 checklist](https://wiki.bnl.gov/sPHENIX/index.php/SPHENIX_software_day-1_checklist) to get started on [RHIC computing facility at BNL](https://www.racf.bnl.gov/), or follow the [sPHENIX container setup](https://github.com/sPHENIX-Collaboration/Singularity) for your own computing environment.

# Check out macro repository

Download the newest macro repository from GitHub:

```
[jinhuang@rcas2073 test]$ git clone https://github.com/sPHENIX-Collaboration/macros.git
Cloning into 'macros'...
remote: Counting objects: 1125, done.
remote: Total 1125 (delta 0), reused 0 (delta 0), pack-reused 1125
Receiving objects: 100% (1125/1125), 181.75 KiB | 0 bytes/s, done.
Resolving deltas: 100% (471/471), done.
Checking connectivity... done.
[jinhuang@rcas2073 test]$ cd macros/detectors
[jinhuang@rcas2073 detectors]$ # here are all the subdirectories with macros to run sPHENIX, fsPHENIX and EIC detector simulations
```

The default sPHENIX simulation + reconstruction macro is Fun4All_G4_sPHENIX.C, which is self-explanatory. It is not a black box!. You are welcome to open/edit it to work for your purpose of study.

# Try an event display

Then let's see what is implemented by firing up one event:
```
[jinhuang@rcas2072 sPHENIX]$ source /opt/sphenix/core/bin/sphenix_setup.csh -n   # setup sPHENIX environment if not already done so
# Note, for bash users, please use /opt/sphenix/core/bin/sphenix_setup.sh instead
[jinhuang@rcas2072 sPHENIX]$ root
root [] .x Fun4All_G4_sPHENIX.C(-1) // here negative value in event number start an event display of one event
root [] .L DisplayOn.C 
root [] PHG4Reco* g4 = DisplayOn()
root [] Fun4AllServer *se = Fun4AllServer::instance();
root [] se->run(1)
root [] displaycmd() # this one show more Geant4 command we can run from the ROOT prompt
```


# Run more events

This is simpler, just run with first parameter as the intended number of event:
```
[jinhuang@rcas2072 sPHENIX]$ source /opt/sphenix/core/bin/sphenix_setup.csh -n   # setup sPHENIX environment if not already done so
[jinhuang@rcas2072 sPHENIX]$ root
root [] .x Fun4All_G4_sPHENIX.C(10) // run 10 events
```

# What next?

Now you are able to run the whole sPHENIX simulation + reconstruction chain. Many next-step topics are listed in the [software](https://wiki.bnl.gov/sPHENIX/index.php/Software) page. And specifically, to use the simulation for your study, a few thing you might want to try:

* Checkout the [evaluator Ntuples](https://wiki.bnl.gov/sPHENIX/index.php/Tracking) output from your 10 events for a generic look of the reconstructed data.
* Run [sPHENIX software tutorials](https://github.com/sPHENIX-Collaboration/tutorials).
* [Write your analysis module for more dedicated analysis](https://wiki.bnl.gov/sPHENIX/index.php/Example_of_using_DST_nodes), for which the module produced the evaluator NTuple ([CaloEvaluator](https://sphenix-collaboration.github.io/doxygen/dd/d59/classCaloEvaluator.html), [JetEvaluator](https://sphenix-collaboration.github.io/doxygen/dd/d59/classCaloEvaluator.html), [SvtxEvaluator](https://sphenix-collaboration.github.io/doxygen/d6/d11/classSvtxEvaluator.html)) can usually serve as good examples.
>>>>>>> 3db245ce2110e3a3650bd2fc9a6ddcda7826b285
