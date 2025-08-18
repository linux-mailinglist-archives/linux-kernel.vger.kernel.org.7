Return-Path: <linux-kernel+bounces-773171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED205B29C53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61441894643
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDB275B1C;
	Mon, 18 Aug 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnGAIkW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3519F11F;
	Mon, 18 Aug 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506000; cv=none; b=dHJqkTN7ZR+OLfeFnPnqGt9JdOi8uFOXBOJBOr8/Tk1JzniI/TANAyjZgTuwEsaKonZHi97nVc2KJfaxoRwNrijdeXSvn+qJ1fPZ1ikxu739DmnAYz023qrdoEvE/eN7VYFToJ9MAnQOtShg+w3u++xpSECHS3GkN93EgFDMOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506000; c=relaxed/simple;
	bh=pYAaqP2Z34eSekDi/tgb+A1zbYWB8vn32mAMQm0lxJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EL/n4UUmGLyzKpg2JV2Z1Jzgu49ElzyWaaYp95Yo6K2PlmwsMco2cbB4Z9D8RfQji4fYR2QOZ6/8ZIOfS21ev4laKxL8ejwPVPmr/cjMiqyIMcfnHe+uNyhcxqzHp82MWTPcekrO1f8uT4D3wMeDSQ3OEBx4pv+qWW8lQnEDk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnGAIkW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D871C4CEED;
	Mon, 18 Aug 2025 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755506000;
	bh=pYAaqP2Z34eSekDi/tgb+A1zbYWB8vn32mAMQm0lxJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AnGAIkW9gzI1LJV8VZWIep4dfESGqIL4NRTSltVG0+fwhfOI0K9rwaSxkspdmi4CO
	 WD/Guw/RfR7td6xMbUoh7QzI5AMGYmTfHyBinzGJY2TQjhyZGq7Ka7WBGnmRD8UswM
	 Zt6dIwSx+8jZnNLMiikRBYJo5XfyxeRDxc0cuxgfh4ZcckD3BICNkhtATRsrjmF2Ph
	 t1QqCF9r1+O78I5m4nNPmMHGlIXF9n1lwVYzYST76gfoZtSjqI1vQCMEnqkKy6sdeN
	 cVDHL98KFpm50CFgGwwMA4A3I7/W5M442pwaRXPA7jy6R+zgG0HszabO1nN76OJehb
	 HqOQDKyBVOvFg==
Date: Mon, 18 Aug 2025 10:33:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250818103316.526eaa8e@foz.lan>
In-Reply-To: <42232742-6409-4f07-9f9f-ee1e0ba4d1f2@oracle.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<42232742-6409-4f07-9f9f-ee1e0ba4d1f2@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 17 Aug 2025 17:32:24 +0200
Vegard Nossum <vegard.nossum@oracle.com> escreveu:

> (trimmed Ccs)
> 
> Hi Mauro,
> 
> Thank you for testing on OL. I'm wondering about some of the results,
> however...
> 
> On 15/08/2025 13:36, Mauro Carvalho Chehab wrote:
> > Oracle Linux Server release 9.6:
> > --------------------------------
> >      PASSED: OS detection: Oracle Linux Server release 9.6
> >      SKIPPED (Sphinx Sphinx 3.4.3): System packages
> >      SKIPPED (Sphinx already installed either as venv or as native package): Sphinx on venv
> >      SKIPPED (Sphinx already installed either as venv or as native package): Sphinx package
> >      PASSED: Clean documentation: Build time: 0:00, return code: 0
> >      PASSED: Build HTML documentation: Build time: 0:06, return code: 0  
> 
> How is the html PASSED with the build time only 6 seconds, that looks
> rather odd to me.
> 
> >      PARTIAL: Build PDF documentation: Test failed (Build time: 0:07, return code: 2)
> > 
> >    PDF docs:
> >    ---------
> >        PASSED: latex: FAILED (no .tex)  
> 
> This doesn't seem like it PASSED either if it FAILED.

The issue here is actually due to the way my test tool works. It basically
runs distros via lxc and use lxc-attach to run a test script (I also
use podman for a few containers, when there's no container via lxc).

Well, attaching to a container doesn't set language. If sphinx-build is
called without language, it crashes badly: nothing works on it. 
Even --version crashes:

	$ sphinx-build --version
	Traceback (most recent call last):
	  File "/usr/bin/sphinx-build", line 8, in <module>
	    sys.exit(main())
	             ~~~~^^
	  File "/usr/lib/python3/dist-packages/sphinx/cmd/build.py", line 546, in main
	    locale.setlocale(locale.LC_ALL, '')
	    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
	  File "/usr/lib/python3.13/locale.py", line 615, in setlocale
	    return _setlocale(category, locale)
	locale.Error: unsupported locale setting

	$ LC_ALL=C sphinx-build --version
	sphinx-build 8.1.3

The crash happens at the the main() function for the build command at:
/usr/lib/python3/dist-packages/sphinx/cmd/build.py. It tries to set locale 
to '', using what it is recommended at
https://docs.python.org/3/library/locale.html, but Python crashes.

An sphinx-build workaround logic would be for it to do:

	def main(argv: Sequence[str] = (), /) -> int:
	    try:
	        locale.setlocale(locale.LC_ALL, '')
	    except:
	        locale.setlocale(locale.LC_ALL, 'C')

Such issue is present on all versions of Sphinx, as far as I'm aware.

Now, as sphinx-build is doing what Python library recommends,
IMO, the root cause should be fixed: Python internal library should
handle this better, as if one doesn't care about the actual locale,
passing just '', it should fallback to "C" instead of crashing.

In any case, as kernel build has to support legacy Python and Sphinx
versions, I sent a patch addressing such issue via the new
sphinx-build-wrapper I'm proposing:

	https://lore.kernel.org/linux-doc/461e00fe7ce75eaac90d98572bb93910b39361e2.1755258303.git.mchehab+huawei@kernel.org/

It sounds I ended placing the run results before such fix. I'll
submit a v2 with the right logs.

> I tried on OL 9.5 and got:
> 
> """
> $ scripts/sphinx-pre-install
> ...
> You should run:
> 
>          sudo yum install -y ImageMagick graphviz
> ...
>          sudo yum install -y python3-sphinx
> """
> 
> But I actually need to do this:
> 
> sudo yum --enablerepo=ol9_developer_EPEL install -y ImageMagick graphviz
> 
> and then
> 
> sudo yum --enablrepo=ol9_codeready_builder install -y python3-sphinx
> 
> respectively.

The logic at sphinx-pre-install assumes that the needed repositories
are enabled. The rationale is that each distro has its own particular
way to split packages between repositories, and this varies a from
time to time. For instance, up to CentOS 8 and RHEL8, the EPEL repository
contained all non-officially supported packages, which includes Sphinx.
On version 9 of most of such distros, this was named CRB, although this is
not consistent over the variations. So, for instance,

On OpenEuler, it doesn't need to set any extra repository.
On Almalinux, CentOS and Rockylinux it does set crb:

      - "dnf config-manager --set-enabled crb"

On OL, it sets those:

      - "sudo dnf install -y oraclelinux-release-el9 epel-release"
      - "dnf config-manager --set-enabled base latest ol9_appstream ol9_developer_EPEL ol9_codeready_builder"

On RHEL using the "redhat/ubi8" docker container, the extra repos are
behind a paywall.

> After this, I see a bunch of red warnings but 'make htmldocs' succeeds
> and after 33 minutes.

Those warnings exist on upstream.

> 
> For pdfdocs and latexdocs, respectively, I get:
> 
> $ make pdfdocs
> Documentation/Makefile:156: The 'xelatex' command was not found. Make 
> sure you have it installed and in PATH to produce PDF output.
>    SKIP    Sphinx pdfdocs target.

If you install the needed repositories and all recommentations from
sphinx-pre-install, you should be able to build pdfs.

I Just ran it here from a container I re-created from scratch, and got:

Oracle Linux Server release 9.6:
--------------------------------
    PASSED: OS detection: Oracle Linux Server release 9.6
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx Sphinx 3.4.3
    PASSED: Clean documentation: Build time: 0:00, return code: 0
    PASSED: Build HTML documentation: Build time: 3:57, return code: 0
    PASSED: Build PDF documentation: Build time: 10:09, return code: 0

  PDF docs:
  ---------
      PASSED: dev-tools: pdf/dev-tools.pdf
      PASSED: tools: pdf/tools.pdf
      PASSED: filesystems: pdf/filesystems.pdf
      PASSED: w1: pdf/w1.pdf
      PASSED: maintainer: pdf/maintainer.pdf
      PASSED: process: pdf/process.pdf
      PASSED: isdn: pdf/isdn.pdf
      PASSED: fault-injection: pdf/fault-injection.pdf
      PASSED: iio: pdf/iio.pdf
      PASSED: scheduler: pdf/scheduler.pdf
      PASSED: staging: pdf/staging.pdf
      PASSED: fpga: pdf/fpga.pdf
      PASSED: power: pdf/power.pdf
      PASSED: leds: pdf/leds.pdf
      PASSED: edac: pdf/edac.pdf
      PASSED: PCI: pdf/PCI.pdf
      PASSED: firmware-guide: pdf/firmware-guide.pdf
      PASSED: cpu-freq: pdf/cpu-freq.pdf
      PASSED: mhi: pdf/mhi.pdf
      PASSED: wmi: pdf/wmi.pdf
      PASSED: timers: pdf/timers.pdf
      PASSED: accel: pdf/accel.pdf
      PASSED: hid: pdf/hid.pdf
      PASSED: userspace-api: pdf/userspace-api.pdf
      PASSED: spi: pdf/spi.pdf
      PASSED: networking: pdf/networking.pdf
      PASSED: virt: pdf/virt.pdf
      PASSED: nvme: pdf/nvme.pdf
      PASSED: translations: pdf/translations.pdf
      PASSED: input: pdf/input.pdf
      PASSED: tee: pdf/tee.pdf
      PASSED: doc-guide: pdf/doc-guide.pdf
      PASSED: cdrom: pdf/cdrom.pdf
      PASSED: gpu: pdf/gpu.pdf
      PASSED: i2c: pdf/i2c.pdf
      PASSED: RCU: pdf/RCU.pdf
      PASSED: watchdog: pdf/watchdog.pdf
      PASSED: usb: pdf/usb.pdf
      PASSED: rust: pdf/rust.pdf
      PASSED: crypto: pdf/crypto.pdf
      PASSED: kbuild: pdf/kbuild.pdf
      PASSED: livepatch: pdf/livepatch.pdf
      PASSED: mm: pdf/mm.pdf
      PASSED: locking: pdf/locking.pdf
      PASSED: infiniband: pdf/infiniband.pdf
      PASSED: driver-api: pdf/driver-api.pdf
      PASSED: bpf: pdf/bpf.pdf
      PASSED: devicetree: pdf/devicetree.pdf
      PASSED: block: pdf/block.pdf
      PASSED: target: pdf/target.pdf
      PASSED: arch: pdf/arch.pdf
      PASSED: pcmcia: pdf/pcmcia.pdf
      PASSED: scsi: pdf/scsi.pdf
      PASSED: netlabel: pdf/netlabel.pdf
      PASSED: sound: pdf/sound.pdf
      PASSED: security: pdf/security.pdf
      PASSED: accounting: pdf/accounting.pdf
      PASSED: admin-guide: pdf/admin-guide.pdf
      PASSED: core-api: pdf/core-api.pdf
      PASSED: fb: pdf/fb.pdf
      PASSED: peci: pdf/peci.pdf
      PASSED: trace: pdf/trace.pdf
      PASSED: misc-devices: pdf/misc-devices.pdf
      PASSED: kernel-hacking: pdf/kernel-hacking.pdf
      PASSED: hwmon: pdf/hwmon.pdf

Summary
=======
  PASSED - Oracle Linux Server release 9.6 (7 tests)


PS.: I'm using both this series and the sphinx-build-wrapper one,
as it has a summary at the end which checks what PDF file was
actually built.

Btw, I'm enclosing at the end the logs I got from my test toolset.

I dropped several messages from the log, as the full log is 137k
lines:

$ wc -l container_tests.log oracle_report.log 
  72107 container_tests.log
  65596 oracle_report.log
 137703 total

but I preserved the most relevant logs.

-

Those are the logs containing the preparation steps done to create the
Container

2025-08-18 09:33:23,302 [oracle DEBUG] Executing: sudo lxc-create -n oracle-test -t download -- --dist oracle --release 9 --arch amd64
2025-08-18 09:33:24,021 [oracle DEBUG] Executing: sudo mkdir -p /var/lib/lxc/oracle-test
2025-08-18 09:33:24,061 [oracle DEBUG] Executing: sudo sh -c cat > /var/lib/lxc/oracle-test/config <<EOF
lxc.arch = x86_64
lxc.pty.max = 1024
lxc.tty.max = 4
lxc.net.0.type = veth
lxc.net.0.link = lxcbr0
lxc.net.0.flags = up
lxc.net.0.hwaddr = 00:16:3e:5b:89:e7
lxc.cap.drop = mac_admin mac_override sys_time sys_module sys_rawio
lxc.cgroup.devices.allow = a
lxc.cgroup2.devices.allow = a
lxc.mount.auto = proc sys cgroup
lxc.rootfs.path = /var/lib/lxc/oracle-test/rootfs

2025-08-18 09:33:25,398 [oracle DEBUG] Executing: sudo lxc-attach -n oracle-test -- env LANG=C.UTF-8 sh -c sudo dnf install -y oraclelinux-release-el9 epel-release
2025-08-18 09:33:37,730 [oracle DEBUG] Executing: sudo lxc-attach -n oracle-test -- env LANG=C.UTF-8 sh -c dnf config-manager --set-enabled base latest ol9_appstream ol9_developer_EPEL ol9_codeready_builder
2025-08-18 09:33:37,885 [oracle DEBUG] Executing: sudo lxc-attach -n oracle-test -- env LANG=C.UTF-8 sh -c dnf install -y which openssh-server git python3 tar make diffutils

# Here, I'm copying the Kernel from the host via tarball, as this is
# faster than using git clone and transfers less files, as I'm 
# placing there just the files needed for docs build
2025-08-18 09:34:11,001 [oracle DEBUG] Executing: sudo lxc-attach -n oracle-test -- tar xpf - --no-same-owner -C /

# Here, I execute my test script
2025-08-18 09:34:16,322 [oracle DEBUG] Executing: sudo lxc-attach -n oracle-test -- env LANG=C.UTF-8 sh -c cd /root && LC_ALL=C ./docs-build.py

---

This is the output of my docs-build.py test script, which reads the
install instructions from sphinx-pre-install, executes them and
build html and pdf:


TEST REPORT: ORACLE

Generated: 2025-08-18 09:50:28
Stage: Tests

TEST RESULTS:

Status: SUCCESS
Return Code: 0

STANDARD OUTPUT:

VALIDATE: cd /root && LC_ALL=C ./docs-build.py
---------------------------------------------

 $ ./scripts/sphinx-pre-install
 Python version: 3.9.21
 Detected OS: Oracle Linux Server release 9.6.
 
 Warning: build optional deps missing:	ImageMagick graphviz
 ERROR: Python mandatory deps missing:	python3-pyyaml
 ERROR: PDF mandatory deps missing:	dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts google-noto-sans-cjk-ttc-fonts latexmk librsvg2-tools texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-collection-fontsrecommended texlive-collection-latex texlive-ctex texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xecjk texlive-xetex-bin
 
 You should run:
 	sudo dnf install ImageMagick dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts google-noto-sans-cjk-ttc-fonts graphviz latexmk librsvg2-tools python3-pyyaml texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-collection-fontsrecommended texlive-collection-latex texlive-ctex texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xecjk texlive-xetex-bin
 
 Note: RHEL-based distros typically require extra repositories.
 For most, enabling epel and crb are enough:
 	sudo dnf install -y epel-release
 	sudo dnf config-manager --set-enabled crb
 Yet, some may have other required repositories. Those commands could be useful:
 	sudo dnf repolist all
 	sudo dnf repoquery --available --info <pkgs>
 	sudo dnf config-manager --set-enabled '*' # enable all - probably not what you want
 
 Sphinx needs to be installed either:
 1) via pip/pypi with:
 
 	/usr/bin/python3 -m venv sphinx_latest
 	. sphinx_latest/bin/activate
 	pip install -r ./Documentation/sphinx/requirements.txt
 
     If you want to exit the virtualenv, you can use:
 	deactivate
 
 2) As a package with:
 
 	sudo dnf install python3-sphinx
 
    Please note that Sphinx currentlys produce false-positive
    warnings when the same name is used for more than one type (functions,
    structs, enums,...). This is known Sphinx bug. For more details, see:
 	https://github.com/sphinx-doc/sphinx/pull/8313
 

Installing section: system_install with dnf
===========================================

 $ dnf install -y --setopt=install_weak_deps=False ImageMagick dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts google-noto-sans-cjk-ttc-fonts graphviz latexmk librsvg2-tools python3-pyyaml texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-collection-fontsrecommended texlive-collection-latex texlive-ctex texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xecjk texlive-xetex-bin
 Last metadata expiration check: 0:00:22 ago on Mon Aug 18 07:33:55 2025.
 Dependencies resolved.
 ===================================================================================================
  Package                                Arch    Version                   Repository           Size
 ===================================================================================================
 Installing:
  ImageMagick                            x86_64  6.9.13.25-1.el9           ol9_developer_EPEL  103 k
...
  zziplib                                x86_64  0.13.71-11.el9_4          ol9_appstream        95 k
 
 Transaction Summary
 ===================================================================================================
 Install  428 Packages
 
 Total download size: 598 M
 Installed size: 1.2 G
 Downloading Packages:
 (1/428): dejavu-sans-fonts-2.37-18.el9.noarch.r 4.2 MB/s | 1.3 MB     00:00    
...
 (428/428): urw-base35-p052-fonts-20200910-6.el9 491 kB/s | 987 kB     00:02    
 --------------------------------------------------------------------------------
 Total                                           9.8 MB/s | 598 MB     01:01     
 Running transaction check
 Transaction check succeeded.
 Running transaction test
 Transaction test succeeded.
 Running transaction
   Running scriptlet: texlive-base-9:20200406-26.el9_2.noarch                1/1 
   Preparing        :                                                        1/1 
   Running scriptlet: texlive-base-9:20200406-26.el9_2.noarch              1/428 
...
   Verifying        : zziplib-0.13.71-11.el9_4.x86_64                    428/428 
 
 Installed:
   ImageMagick-6.9.13.25-1.el9.x86_64                                            
   ImageMagick-libs-6.9.13.25-1.el9.x86_64                                       
   LibRaw-0.21.1-1.el9.x86_64                                                    
   adobe-mappings-cmap-20171205-12.el9.noarch                                    
   adobe-mappings-cmap-deprecated-20171205-12.el9.noarch                         
   adobe-mappings-pdf-20180407-10.el9.noarch                                     
   atk-2.36.0-5.el9.x86_64                                                       
   avahi-libs-0.8-22.el9_6.1.x86_64                                              
   cairo-1.17.4-7.el9.x86_64                                                     
   cairo-gobject-1.17.4-7.el9.x86_64                                             
   crypto-policies-scripts-20250128-1.git5269e22.el9.noarch                      
   cups-libs-1:2.3.3op2-33.el9.x86_64                                            
   dejavu-sans-fonts-2.37-18.el9.noarch                                          
   dejavu-sans-mono-fonts-2.37-18.el9.noarch                                     
   dejavu-serif-fonts-2.37-18.el9.noarch                                         
   desktop-file-utils-0.26-6.el9.x86_64                                          
   fontconfig-2.14.0-2.el9_1.x86_64                                              
   fonts-filesystem-1:2.0.5-7.el9.1.noarch                                       
   freetype-2.10.4-10.el9_5.x86_64                                               
   fribidi-1.0.10-6.el9.2.x86_64                                                 
   gd-2.3.2-3.el9.x86_64                                                         
   gdk-pixbuf2-2.42.6-6.el9_6.x86_64                                             
   gdk-pixbuf2-modules-2.42.6-6.el9_6.x86_64                                     
   ghostscript-9.54.0-19.el9_6.x86_64                                            
   ghostscript-tools-fonts-9.54.0-19.el9_6.x86_64                                
   ghostscript-tools-printing-9.54.0-19.el9_6.x86_64                             
   google-droid-sans-fonts-20200215-11.el9.2.noarch                              
   google-noto-cjk-fonts-common-20230817-2.el9.noarch                            
   google-noto-sans-cjk-ttc-fonts-20230817-2.el9.noarch                          
   graphite2-1.3.14-9.el9.x86_64                                                 
   graphviz-2.44.0-26.el9.x86_64                                                 
   gtk-update-icon-cache-3.24.31-5.el9.x86_64                                    
   gtk2-2.24.33-8.el9.x86_64                                                     
   harfbuzz-2.7.4-10.el9.x86_64                                                  
   hicolor-icon-theme-0.17-13.el9.noarch                                         
   imath-3.1.2-1.el9.x86_64                                                      
   info-6.7-15.el9.x86_64                                                        
   jasper-libs-2.0.28-3.el9.x86_64                                               
   jbig2dec-libs-0.19-7.el9.x86_64                                               
   jbigkit-libs-2.1-23.el9.x86_64                                                
   langpacks-core-font-en-3.0-16.el9.noarch                                      
   latexmk-4.86a-1.el9.noarch                                                    
   lcms2-2.12-3.el9.x86_64                                                       
   libICE-1.0.10-8.el9.x86_64                                                    
   libSM-1.2.3-10.el9.x86_64                                                     
   libX11-1.7.0-11.el9.x86_64                                                    
   libX11-common-1.7.0-11.el9.noarch                                             
   libXau-1.0.9-8.el9.x86_64                                                     
   libXaw-1.0.13-19.el9.x86_64                                                   
   libXcomposite-0.4.5-7.el9.x86_64                                              
   libXcursor-1.2.0-7.el9.x86_64                                                 
   libXdamage-1.1.5-7.el9.x86_64                                                 
   libXext-1.3.4-8.el9.x86_64                                                    
   libXfixes-5.0.3-16.el9.x86_64                                                 
   libXft-2.3.3-8.el9.x86_64                                                     
   libXi-1.7.10-8.el9.x86_64                                                     
   libXinerama-1.1.4-10.el9.x86_64                                               
   libXmu-1.1.3-8.el9.x86_64                                                     
   libXpm-3.5.13-10.el9.x86_64                                                   
   libXrandr-1.5.2-8.el9.x86_64                                                  
   libXrender-0.9.10-16.el9.x86_64                                               
   libXt-1.2.0-6.el9.x86_64                                                      
   libdatrie-0.2.13-4.el9.x86_64                                                 
   libfontenc-1.1.3-17.el9.x86_64                                                
   libgs-9.54.0-19.el9_6.x86_64                                                  
   libicu-67.1-10.el9_6.x86_64                                                   
   libijs-0.35-15.el9.x86_64                                                     
   libjpeg-turbo-2.0.90-7.el9.x86_64                                             
   liblqr-1-0.4.2-19.el9.x86_64                                                  
   libpaper-1.1.28-4.el9.x86_64                                                  
   libpng-2:1.6.37-12.el9.x86_64                                                 
   libraqm-0.8.0-1.el9.x86_64                                                    
   librsvg2-2.50.7-3.el9.x86_64                                                  
   librsvg2-tools-2.50.7-3.el9.x86_64                                            
   libthai-0.1.28-8.el9.x86_64                                                   
   libtiff-4.4.0-13.el9.x86_64                                                   
   libwebp-1.2.0-8.el9_3.x86_64                                                  
   libwmf-lite-0.2.12-10.el9.x86_64                                              
   libxcb-1.13.1-9.el9.x86_64                                                    
   mailcap-2.1.49-5.el9.noarch                                                   
   mkfontscale-1.2.1-3.el9.x86_64                                                
   nspr-4.35.0-17.el9_2.x86_64                                                   
   nss-3.101.0-10.el9_2.x86_64                                                   
   nss-softokn-3.101.0-10.el9_2.x86_64                                           
   nss-softokn-freebl-3.101.0-10.el9_2.x86_64                                    
   nss-sysinit-3.101.0-10.el9_2.x86_64                                           
   nss-util-3.101.0-10.el9_2.x86_64                                              
   openexr-libs-3.1.1-3.el9.x86_64                                               
   openjpeg2-2.4.0-8.el9.x86_64                                                  
   pango-1.48.7-3.el9.x86_64                                                     
   perl-Compress-Raw-Bzip2-2.101-5.el9.x86_64                                    
   perl-Compress-Raw-Zlib-2.101-5.el9.x86_64                                     
   perl-Data-Dump-1.23-18.el9.noarch                                             
   perl-Digest-HMAC-1.03-29.el9.noarch                                           
   perl-Digest-SHA-1:6.02-461.el9.x86_64                                         
   perl-Encode-Locale-1.05-21.el9.noarch                                         
   perl-File-Copy-2.34-481.1.el9_6.noarch                                        
   perl-File-Listing-6.14-4.el9.noarch                                           
   perl-Filter-2:1.60-4.el9.x86_64                                               
   perl-HTML-Parser-3.76-3.el9.x86_64                                            
   perl-HTML-Tagset-3.20-47.el9.noarch                                           
   perl-HTTP-Cookies-6.10-4.el9.noarch                                           
   perl-HTTP-Date-6.05-7.el9.noarch                                              
   perl-HTTP-Message-6.29-3.el9.noarch                                           
   perl-HTTP-Negotiate-6.01-30.el9.noarch                                        
   perl-I18N-Langinfo-0.19-481.1.el9_6.x86_64                                    
   perl-IO-Compress-2.102-4.el9.noarch                                           
   perl-IO-HTML-1.004-4.el9.noarch                                               
   perl-LWP-MediaTypes-6.04-9.el9.noarch                                         
   perl-NTLM-1.09-30.el9.noarch                                                  
   perl-Net-HTTP-6.21-3.el9.noarch                                               
   perl-Text-Unidecode-1.30-16.el9.noarch                                        
   perl-Time-HiRes-4:1.9764-462.el9.x86_64                                       
   perl-TimeDate-1:2.33-6.el9.noarch                                             
   perl-Try-Tiny-0.30-13.el9.noarch                                              
   perl-Unicode-Normalize-1.27-461.el9.x86_64                                    
   perl-WWW-RobotRules-6.02-30.el9.noarch                                        
   perl-XML-Parser-2.46-9.0.1.el9.x86_64                                         
   perl-XML-XPath-1.44-11.el9.noarch                                             
   perl-encoding-4:3.00-462.el9.x86_64                                           
   perl-libwww-perl-6.53-4.el9.noarch                                            
   perl-locale-1.09-481.1.el9_6.noarch                                           
   perl-meta-notation-5.32.1-481.1.el9_6.noarch                                  
   perl-open-1.12-481.1.el9_6.noarch                                             
   perl-sigtrap-1.09-481.1.el9_6.noarch                                          
   pixman-0.40.0-6.el9_3.x86_64                                                  
   poppler-21.01.0-21.el9.x86_64                                                 
   poppler-data-0.4.9-9.el9.noarch                                               
   python3-pyyaml-5.4.1-6.0.1.el9.x86_64                                         
   ruby-3.0.7-165.el9_5.x86_64                                                   
   ruby-libs-3.0.7-165.el9_5.x86_64                                              
   shared-mime-info-2.1-5.el9.x86_64                                             
   teckit-2.5.9-8.el9.x86_64                                                     
   texlive-adobemapping-9:20200406-37.el9.noarch                                 
   texlive-ae-9:20200406-26.el9_2.noarch                                         
   texlive-algorithms-9:20200406-26.el9_2.noarch                                 
   texlive-alphalph-9:20200406-26.el9_2.noarch                                   
   texlive-amscls-9:20200406-26.el9_2.noarch                                     
   texlive-amsfonts-9:20200406-26.el9_2.noarch                                   
   texlive-amsmath-9:20200406-26.el9_2.noarch                                    
   texlive-anyfontsize-9:20200406-26.el9_2.noarch                                
   texlive-arphic-9:20200406-26.el9_2.noarch                                     
   texlive-ascmac-9:20200406-37.el9.noarch                                       
   texlive-atbegshi-9:20200406-26.el9_2.noarch                                   
   texlive-attachfile-9:20200406-26.el9_2.noarch                                 
   texlive-atveryend-9:20200406-26.el9_2.noarch                                  
   texlive-auxhook-9:20200406-26.el9_2.noarch                                    
   texlive-avantgar-9:20200406-26.el9_2.noarch                                   
   texlive-babel-9:20200406-26.el9_2.noarch                                      
   texlive-babel-english-9:20200406-26.el9_2.noarch                              
   texlive-babelbib-9:20200406-26.el9_2.noarch                                   
   texlive-base-9:20200406-26.el9_2.noarch                                       
   texlive-beamer-9:20200406-26.el9_2.noarch                                     
   texlive-bera-9:20200406-26.el9_2.noarch                                       
   texlive-beton-9:20200406-26.el9_2.noarch                                      
   texlive-bibtex-9:20200406-26.el9_2.x86_64                                     
   texlive-bidi-9:20200406-26.el9_2.noarch                                       
   texlive-bigintcalc-9:20200406-26.el9_2.noarch                                 
   texlive-bitset-9:20200406-26.el9_2.noarch                                     
   texlive-bookman-9:20200406-26.el9_2.noarch                                    
   texlive-bookmark-9:20200406-26.el9_2.noarch                                   
   texlive-booktabs-9:20200406-26.el9_2.noarch                                   
   texlive-breakurl-9:20200406-26.el9_2.noarch                                   
   texlive-capt-of-9:20200406-26.el9_2.noarch                                    
   texlive-caption-9:20200406-26.el9_2.noarch                                    
   texlive-carlisle-9:20200406-26.el9_2.noarch                                   
   texlive-catchfile-9:20200406-26.el9_2.noarch                                  
   texlive-changepage-9:20200406-26.el9_2.noarch                                 
   texlive-charter-9:20200406-26.el9_2.noarch                                    
   texlive-chngcntr-9:20200406-26.el9_2.noarch                                   
   texlive-cjk-9:20200406-26.el9_2.noarch                                        
   texlive-cjkpunct-9:20200406-37.el9.noarch                                     
   texlive-cm-9:20200406-26.el9_2.noarch                                         
   texlive-cm-super-9:20200406-26.el9_2.noarch                                   
   texlive-cmap-9:20200406-26.el9_2.noarch                                       
   texlive-cmextra-9:20200406-26.el9_2.noarch                                    
   texlive-cns-9:20200406-26.el9_2.noarch                                        
   texlive-collection-basic-9:20200406-26.el9_2.noarch                           
   texlive-collection-fontsrecommended-9:20200406-26.el9_2.noarch                
   texlive-collection-latex-9:20200406-26.el9_2.noarch                           
   texlive-colorprofiles-9:20200406-26.el9_2.noarch                              
   texlive-colortbl-9:20200406-26.el9_2.noarch                                   
   texlive-convbkmk-9:20200406-37.el9.noarch                                     
   texlive-courier-9:20200406-26.el9_2.noarch                                    
   texlive-csquotes-9:20200406-26.el9_2.noarch                                   
   texlive-ctex-9:20200406-37.el9.noarch                                         
   texlive-currfile-9:20200406-26.el9_2.noarch                                   
   texlive-dvipdfmx-9:20200406-26.el9_2.x86_64                                   
   texlive-dvips-9:20200406-26.el9_2.x86_64                                      
   texlive-ec-9:20200406-26.el9_2.noarch                                         
   texlive-enctex-9:20200406-26.el9_2.noarch                                     
   texlive-enumitem-9:20200406-26.el9_2.noarch                                   
   texlive-environ-9:20200406-26.el9_2.noarch                                    
   texlive-epstopdf-pkg-9:20200406-26.el9_2.noarch                               
   texlive-eqparbox-9:20200406-26.el9_2.noarch                                   
   texlive-eso-pic-9:20200406-26.el9_2.noarch                                    
   texlive-etex-9:20200406-26.el9_2.noarch                                       
   texlive-etex-pkg-9:20200406-26.el9_2.noarch                                   
   texlive-etexcmds-9:20200406-26.el9_2.noarch                                   
   texlive-etoolbox-9:20200406-26.el9_2.noarch                                   
   texlive-euenc-9:20200406-26.el9_2.noarch                                      
   texlive-euler-9:20200406-26.el9_2.noarch                                      
   texlive-euro-9:20200406-26.el9_2.noarch                                       
   texlive-eurosym-9:20200406-26.el9_2.noarch                                    
   texlive-everyhook-9:20200406-37.el9.noarch                                    
   texlive-fancybox-9:20200406-26.el9_2.noarch                                   
   texlive-fancyhdr-9:20200406-26.el9_2.noarch                                   
   texlive-fancyvrb-9:20200406-26.el9_2.noarch                                   
   texlive-fandol-9:20200406-37.el9.noarch                                       
   texlive-filecontents-9:20200406-26.el9_2.noarch                               
   texlive-filehook-9:20200406-26.el9_2.noarch                                   
   texlive-firstaid-9:20200406-37.el9.noarch                                     
   texlive-fix2col-9:20200406-26.el9_2.noarch                                    
   texlive-float-9:20200406-26.el9_2.noarch                                      
   texlive-fncychap-9:20200406-26.el9_2.noarch                                   
   texlive-fonts-tlwg-9:20200406-26.el9_2.noarch                                 
   texlive-fontspec-9:20200406-26.el9_2.noarch                                   
   texlive-footmisc-9:20200406-26.el9_2.noarch                                   
   texlive-fp-9:20200406-26.el9_2.noarch                                         
   texlive-fpl-9:20200406-26.el9_2.noarch                                        
   texlive-framed-9:20200406-26.el9_2.noarch                                     
   texlive-garuda-c90-9:20200406-26.el9_2.noarch                                 
   texlive-geometry-9:20200406-26.el9_2.noarch                                   
   texlive-gettitlestring-9:20200406-26.el9_2.noarch                             
   texlive-glyphlist-9:20200406-26.el9_2.noarch                                  
   texlive-graphics-9:20200406-26.el9_2.noarch                                   
   texlive-graphics-cfg-9:20200406-26.el9_2.noarch                               
   texlive-graphics-def-9:20200406-26.el9_2.noarch                               
   texlive-grfext-9:20200406-26.el9_2.noarch                                     
   texlive-grffile-9:20200406-26.el9_2.noarch                                    
   texlive-helvetic-9:20200406-26.el9_2.noarch                                   
   texlive-hobsub-9:20200406-26.el9_2.noarch                                     
   texlive-hologo-9:20200406-26.el9_2.noarch                                     
   texlive-hycolor-9:20200406-26.el9_2.noarch                                    
   texlive-hyperref-9:20200406-26.el9_2.noarch                                   
   texlive-hyph-utf8-9:20200406-26.el9_2.noarch                                  
   texlive-hyphen-base-9:20200406-26.el9_2.noarch                                
   texlive-hyphenex-9:20200406-26.el9_2.noarch                                   
   texlive-ifmtarg-9:20200406-26.el9_2.noarch                                    
   texlive-ifplatform-9:20200406-26.el9_2.noarch                                 
   texlive-iftex-9:20200406-26.el9_2.noarch                                      
   texlive-index-9:20200406-26.el9_2.noarch                                      
   texlive-infwarerr-9:20200406-26.el9_2.noarch                                  
   texlive-intcalc-9:20200406-26.el9_2.noarch                                    
   texlive-ipaex-9:20200406-37.el9.noarch                                        
   texlive-japanese-otf-9:20200406-37.el9.noarch                                 
   texlive-japanese-otf-uptex-9:20200406-37.el9.noarch                           
   texlive-kastrup-9:20200406-26.el9_2.noarch                                    
   texlive-knuth-lib-9:20200406-26.el9_2.noarch                                  
   texlive-knuth-local-9:20200406-26.el9_2.noarch                                
   texlive-koma-script-9:20200406-26.el9_2.noarch                                
   texlive-kpathsea-9:20200406-26.el9_2.x86_64                                   
   texlive-kvdefinekeys-9:20200406-26.el9_2.noarch                               
   texlive-kvoptions-9:20200406-26.el9_2.noarch                                  
   texlive-kvsetkeys-9:20200406-26.el9_2.noarch                                  
   texlive-l3backend-9:20200406-26.el9_2.noarch                                  
   texlive-l3kernel-9:20200406-26.el9_2.noarch                                   
   texlive-l3packages-9:20200406-26.el9_2.noarch                                 
   texlive-latex-9:20200406-26.el9_2.noarch                                      
   texlive-latex-base-dev-9:20200406-37.el9.noarch                               
   texlive-latex-firstaid-dev-9:20200406-37.el9.noarch                           
   texlive-latex-fonts-9:20200406-26.el9_2.noarch                                
   texlive-latexconfig-9:20200406-26.el9_2.noarch                                
   texlive-letltxmacro-9:20200406-26.el9_2.noarch                                
   texlive-lib-9:20200406-26.el9_2.x86_64                                        
   texlive-listings-9:20200406-26.el9_2.noarch                                   
   texlive-lm-9:20200406-26.el9_2.noarch                                         
   texlive-lm-math-9:20200406-26.el9_2.noarch                                    
   texlive-ltxcmds-9:20200406-26.el9_2.noarch                                    
   texlive-ltxmisc-9:20200406-26.el9_2.noarch                                    
   texlive-lua-alt-getopt-9:20200406-26.el9_2.noarch                             
   texlive-luahbtex-9:20200406-26.el9_2.x86_64                                   
   texlive-lualatex-math-9:20200406-26.el9_2.noarch                              
   texlive-lualibs-9:20200406-26.el9_2.noarch                                    
   texlive-luaotfload-9:20200406-26.el9_2.noarch                                 
   texlive-luatex-9:20200406-26.el9_2.x86_64                                     
   texlive-luatex85-9:20200406-26.el9_2.noarch                                   
   texlive-luatexbase-9:20200406-26.el9_2.noarch                                 
   texlive-luatexja-9:20200406-37.el9.noarch                                     
   texlive-makecmds-9:20200406-26.el9_2.noarch                                   
   texlive-makeindex-9:20200406-26.el9_2.x86_64                                  
   texlive-manfnt-font-9:20200406-26.el9_2.noarch                                
   texlive-marginnote-9:20200406-26.el9_2.noarch                                 
   texlive-marvosym-9:20200406-26.el9_2.noarch                                   
   texlive-mathpazo-9:20200406-26.el9_2.noarch                                   
   texlive-mdwtools-9:20200406-26.el9_2.noarch                                   
   texlive-memoir-9:20200406-26.el9_2.noarch                                     
   texlive-metafont-9:20200406-26.el9_2.x86_64                                   
   texlive-mflogo-9:20200406-26.el9_2.noarch                                     
   texlive-mflogo-font-9:20200406-26.el9_2.noarch                                
   texlive-mfnfss-9:20200406-26.el9_2.noarch                                     
   texlive-mfware-9:20200406-26.el9_2.x86_64                                     
   texlive-minitoc-9:20200406-26.el9_2.noarch                                    
   texlive-modes-9:20200406-26.el9_2.noarch                                      
   texlive-mparhack-9:20200406-26.el9_2.noarch                                   
   texlive-mptopdf-9:20200406-26.el9_2.noarch                                    
   texlive-ms-9:20200406-26.el9_2.noarch                                         
   texlive-multido-9:20200406-26.el9_2.noarch                                    
   texlive-multirow-9:20200406-26.el9_2.noarch                                   
   texlive-natbib-9:20200406-26.el9_2.noarch                                     
   texlive-ncntrsbk-9:20200406-26.el9_2.noarch                                   
   texlive-needspace-9:20200406-26.el9_2.noarch                                  
   texlive-norasi-c90-9:20200406-26.el9_2.noarch                                 
   texlive-notoccite-9:20200406-26.el9_2.noarch                                  
   texlive-oberdiek-9:20200406-26.el9_2.noarch                                   
   texlive-palatino-9:20200406-26.el9_2.noarch                                   
   texlive-paralist-9:20200406-26.el9_2.noarch                                   
   texlive-parallel-9:20200406-26.el9_2.noarch                                   
   texlive-parskip-9:20200406-26.el9_2.noarch                                    
   texlive-pdfcolmk-9:20200406-26.el9_2.noarch                                   
   texlive-pdfescape-9:20200406-26.el9_2.noarch                                  
   texlive-pdftex-9:20200406-26.el9_2.x86_64                                     
   texlive-pdftexcmds-9:20200406-26.el9_2.noarch                                 
   texlive-pgf-9:20200406-26.el9_2.noarch                                        
   texlive-placeins-9:20200406-26.el9_2.noarch                                   
   texlive-plain-9:20200406-26.el9_2.noarch                                      
   texlive-platex-9:20200406-37.el9.noarch                                       
   texlive-platex-tools-9:20200406-37.el9.noarch                                 
   texlive-polyglossia-9:20200406-26.el9_2.noarch                                
   texlive-pslatex-9:20200406-26.el9_2.noarch                                    
   texlive-psnfss-9:20200406-26.el9_2.noarch                                     
   texlive-pspicture-9:20200406-26.el9_2.noarch                                  
   texlive-pst-3d-9:20200406-26.el9_2.noarch                                     
   texlive-pst-arrow-9:20200406-26.el9_2.noarch                                  
   texlive-pst-coil-9:20200406-26.el9_2.noarch                                   
   texlive-pst-eps-9:20200406-26.el9_2.noarch                                    
   texlive-pst-fill-9:20200406-26.el9_2.noarch                                   
   texlive-pst-grad-9:20200406-26.el9_2.noarch                                   
   texlive-pst-math-9:20200406-26.el9_2.noarch                                   
   texlive-pst-node-9:20200406-26.el9_2.noarch                                   
   texlive-pst-plot-9:20200406-26.el9_2.noarch                                   
   texlive-pst-text-9:20200406-26.el9_2.noarch                                   
   texlive-pst-tools-9:20200406-26.el9_2.noarch                                  
   texlive-pst-tree-9:20200406-26.el9_2.noarch                                   
   texlive-pstricks-9:20200406-26.el9_2.noarch                                   
   texlive-pstricks-add-9:20200406-26.el9_2.noarch                               
   texlive-ptex-9:20200406-37.el9.x86_64                                         
   texlive-ptex-base-9:20200406-37.el9.noarch                                    
   texlive-ptex-fonts-9:20200406-37.el9.noarch                                   
   texlive-pxfonts-9:20200406-26.el9_2.noarch                                    
   texlive-qstest-9:20200406-26.el9_2.noarch                                     
   texlive-refcount-9:20200406-26.el9_2.noarch                                   
   texlive-rerunfilecheck-9:20200406-26.el9_2.noarch                             
   texlive-rsfs-9:20200406-26.el9_2.noarch                                       
   texlive-sansmathaccent-9:20200406-26.el9_2.noarch                             
   texlive-sauerj-9:20200406-26.el9_2.noarch                                     
   texlive-setspace-9:20200406-26.el9_2.noarch                                   
   texlive-showexpl-9:20200406-26.el9_2.noarch                                   
   texlive-soul-9:20200406-26.el9_2.noarch                                       
   texlive-stringenc-9:20200406-26.el9_2.noarch                                  
   texlive-sttools-9:20200406-37.el9.noarch                                      
   texlive-subfig-9:20200406-26.el9_2.noarch                                     
   texlive-svn-prov-9:20200406-26.el9_2.noarch                                   
   texlive-symbol-9:20200406-26.el9_2.noarch                                     
   texlive-tabulary-9:20200406-26.el9_2.noarch                                   
   texlive-tex-9:20200406-26.el9_2.x86_64                                        
   texlive-tex-gyre-9:20200406-26.el9_2.noarch                                   
   texlive-tex-gyre-math-9:20200406-26.el9_2.noarch                              
   texlive-tex-ini-files-9:20200406-26.el9_2.noarch                              
   texlive-texlive-common-doc-9:20200406-26.el9_2.noarch                         
   texlive-texlive-docindex-9:20200406-26.el9_2.noarch                           
   texlive-texlive-en-9:20200406-26.el9_2.noarch                                 
   texlive-texlive-msg-translations-9:20200406-26.el9_2.noarch                   
   texlive-texlive-scripts-9:20200406-26.el9_2.noarch                            
   texlive-texlive.infra-9:20200406-26.el9_2.noarch                              
   texlive-threeparttable-9:20200406-26.el9_2.noarch                             
   texlive-thumbpdf-9:20200406-26.el9_2.noarch                                   
   texlive-times-9:20200406-26.el9_2.noarch                                      
   texlive-tipa-9:20200406-26.el9_2.noarch                                       
   texlive-titlesec-9:20200406-26.el9_2.noarch                                   
   texlive-tools-9:20200406-26.el9_2.noarch                                      
   texlive-translator-9:20200406-26.el9_2.noarch                                 
   texlive-trimspaces-9:20200406-26.el9_2.noarch                                 
   texlive-ttfutils-9:20200406-37.el9.x86_64                                     
   texlive-txfonts-9:20200406-26.el9_2.noarch                                    
   texlive-ucs-9:20200406-26.el9_2.noarch                                        
   texlive-uhc-9:20200406-26.el9_2.noarch                                        
   texlive-ulem-9:20200406-26.el9_2.noarch                                       
   texlive-underscore-9:20200406-26.el9_2.noarch                                 
   texlive-unicode-data-9:20200406-26.el9_2.noarch                               
   texlive-unicode-math-9:20200406-26.el9_2.noarch                               
   texlive-uniquecounter-9:20200406-26.el9_2.noarch                              
   texlive-updmap-map-9:20200406-26.el9_2.noarch                                 
   texlive-uplatex-9:20200406-37.el9.noarch                                      
   texlive-upquote-9:20200406-26.el9_2.noarch                                    
   texlive-uptex-9:20200406-37.el9.x86_64                                        
   texlive-uptex-base-9:20200406-37.el9.noarch                                   
   texlive-uptex-fonts-9:20200406-37.el9.noarch                                  
   texlive-url-9:20200406-26.el9_2.noarch                                        
   texlive-utopia-9:20200406-26.el9_2.noarch                                     
   texlive-varwidth-9:20200406-26.el9_2.noarch                                   
   texlive-wadalab-9:20200406-26.el9_2.noarch                                    
   texlive-wasy-9:20200406-26.el9_2.noarch                                       
   texlive-wasy-type1-9:20200406-26.el9_2.noarch                                 
   texlive-wasysym-9:20200406-26.el9_2.noarch                                    
   texlive-wrapfig-9:20200406-26.el9_2.noarch                                    
   texlive-xcjk2uni-9:20200406-37.el9.noarch                                     
   texlive-xcolor-9:20200406-26.el9_2.noarch                                     
   texlive-xdvi-9:20200406-26.el9_2.x86_64                                       
   texlive-xecjk-9:20200406-26.el9_2.noarch                                      
   texlive-xetex-9:20200406-26.el9_2.x86_64                                      
   texlive-xetexconfig-9:20200406-26.el9_2.noarch                                
   texlive-xifthen-9:20200406-26.el9_2.noarch                                    
   texlive-xkeyval-9:20200406-26.el9_2.noarch                                    
   texlive-xpinyin-9:20200406-37.el9.noarch                                      
   texlive-xunicode-9:20200406-26.el9_2.noarch                                   
   texlive-zapfchan-9:20200406-26.el9_2.noarch                                   
   texlive-zapfding-9:20200406-26.el9_2.noarch                                   
   texlive-zhmetrics-9:20200406-37.el9.noarch                                    
   texlive-zhmetrics-uptex-9:20200406-37.el9.noarch                              
   texlive-zhnumber-9:20200406-37.el9.noarch                                     
   texlive-zref-9:20200406-26.el9_2.noarch                                       
   urw-base35-bookman-fonts-20200910-6.el9.noarch                                
   urw-base35-c059-fonts-20200910-6.el9.noarch                                   
   urw-base35-d050000l-fonts-20200910-6.el9.noarch                               
   urw-base35-fonts-20200910-6.el9.noarch                                        
   urw-base35-fonts-common-20200910-6.el9.noarch                                 
   urw-base35-gothic-fonts-20200910-6.el9.noarch                                 
   urw-base35-nimbus-mono-ps-fonts-20200910-6.el9.noarch                         
   urw-base35-nimbus-roman-fonts-20200910-6.el9.noarch                           
   urw-base35-nimbus-sans-fonts-20200910-6.el9.noarch                            
   urw-base35-p052-fonts-20200910-6.el9.noarch                                   
   urw-base35-standard-symbols-ps-fonts-20200910-6.el9.noarch                    
   urw-base35-z003-fonts-20200910-6.el9.noarch                                   
   xdg-utils-1.1.3-13.el9_6.noarch                                               
   xml-common-0.6.3-58.el9.noarch                                                
   xorg-x11-fonts-ISO8859-1-100dpi-7.5-33.el9.noarch                             
   zziplib-0.13.71-11.el9_4.x86_64                                               
 
 Complete!
Additional packages installed: x86_64, 6
Check for docutils with /usr/bin/python3
 $ /usr/bin/python3 -c try: import docutils; print(docutils.__version__)
except: pass
Python version: 3.9.21
Detected OS: Oracle Linux Server release 9.6.

Note: RHEL-based distros typically require extra repositories.
For most, enabling epel and crb are enough:
	sudo dnf install -y epel-release
	sudo dnf config-manager --set-enabled crb
Yet, some may have other required repositories. Those commands could be useful:
	sudo dnf repolist all
	sudo dnf repoquery --available --info <pkgs>
	sudo dnf config-manager --set-enabled '*' # enable all - probably not what you want

Sphinx needs to be installed either:
1) via pip/pypi with:

	/usr/bin/python3 -m venv sphinx_latest
	. sphinx_latest/bin/activate
	pip install -r ./Documentation/sphinx/requirements.txt

    If you want to exit the virtualenv, you can use:
	deactivate

2) As a package with:

	sudo dnf install python3-sphinx

   Please note that Sphinx currentlys produce false-positive
   warnings when the same name is used for more than one type (functions,
   structs, enums,...). This is known Sphinx bug. For more details, see:
	https://github.com/sphinx-doc/sphinx/pull/8313

All optional dependencies are met.

Can't build as 1 mandatory dependency is missing


Installing section: venv with pip
=================================

 $ /usr/bin/python3 -m venv sphinx_latest
 $ pip install --no-input -r ./Documentation/sphinx/requirements.txt
 Collecting alabaster
   Downloading alabaster-0.7.16-py3-none-any.whl (13 kB)
 Collecting Sphinx
   Downloading sphinx-7.4.7-py3-none-any.whl (3.4 MB)
 Collecting pyyaml
   Downloading PyYAML-6.0.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (737 kB)
 Collecting sphinxcontrib-htmlhelp>=2.0.0
   Downloading sphinxcontrib_htmlhelp-2.1.0-py3-none-any.whl (98 kB)
 Collecting babel>=2.13
   Downloading babel-2.17.0-py3-none-any.whl (10.2 MB)
 Collecting packaging>=23.0
   Downloading packaging-25.0-py3-none-any.whl (66 kB)
 Collecting Pygments>=2.17
   Downloading pygments-2.19.2-py3-none-any.whl (1.2 MB)
 Collecting sphinxcontrib-qthelp
   Downloading sphinxcontrib_qthelp-2.0.0-py3-none-any.whl (88 kB)
 Collecting snowballstemmer>=2.2
   Downloading snowballstemmer-3.0.1-py3-none-any.whl (103 kB)
 Collecting importlib-metadata>=6.0
   Downloading importlib_metadata-8.7.0-py3-none-any.whl (27 kB)
 Collecting sphinxcontrib-applehelp
   Downloading sphinxcontrib_applehelp-2.0.0-py3-none-any.whl (119 kB)
 Collecting sphinxcontrib-serializinghtml>=1.1.9
   Downloading sphinxcontrib_serializinghtml-2.0.0-py3-none-any.whl (92 kB)
 Collecting sphinxcontrib-devhelp
   Downloading sphinxcontrib_devhelp-2.0.0-py3-none-any.whl (82 kB)
 Collecting requests>=2.30.0
   Downloading requests-2.32.4-py3-none-any.whl (64 kB)
 Collecting docutils<0.22,>=0.20
   Downloading docutils-0.21.2-py3-none-any.whl (587 kB)
 Collecting Jinja2>=3.1
   Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
 Collecting imagesize>=1.3
   Downloading imagesize-1.4.1-py2.py3-none-any.whl (8.8 kB)
 Collecting sphinxcontrib-jsmath
   Downloading sphinxcontrib_jsmath-1.0.1-py2.py3-none-any.whl (5.1 kB)
 Collecting tomli>=2
   Downloading tomli-2.2.1-py3-none-any.whl (14 kB)
 Collecting zipp>=3.20
   Downloading zipp-3.23.0-py3-none-any.whl (10 kB)
 Collecting MarkupSafe>=2.0
   Downloading MarkupSafe-3.0.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (20 kB)
 Collecting charset_normalizer<4,>=2
   Downloading charset_normalizer-3.4.3-cp39-cp39-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (152 kB)
 Collecting certifi>=2017.4.17
   Downloading certifi-2025.8.3-py3-none-any.whl (161 kB)
 Collecting urllib3<3,>=1.21.1
   Downloading urllib3-2.5.0-py3-none-any.whl (129 kB)
 Collecting idna<4,>=2.5
   Downloading idna-3.10-py3-none-any.whl (70 kB)
 Installing collected packages: zipp, urllib3, MarkupSafe, idna, charset-normalizer, certifi, tomli, sphinxcontrib-serializinghtml, sphinxcontrib-qthelp, sphinxcontrib-jsmath, sphinxcontrib-htmlhelp, sphinxcontrib-devhelp, sphinxcontrib-applehelp, snowballstemmer, requests, Pygments, packaging, Jinja2, importlib-metadata, imagesize, docutils, babel, alabaster, Sphinx, pyyaml
 Successfully installed Jinja2-3.1.6 MarkupSafe-3.0.2 Pygments-2.19.2 Sphinx-7.4.7 alabaster-0.7.16 babel-2.17.0 certifi-2025.8.3 charset-normalizer-3.4.3 docutils-0.21.2 idna-3.10 imagesize-1.4.1 importlib-metadata-8.7.0 packaging-25.0 pyyaml-6.0.2 requests-2.32.4 snowballstemmer-3.0.1 sphinxcontrib-applehelp-2.0.0 sphinxcontrib-devhelp-2.0.0 sphinxcontrib-htmlhelp-2.1.0 sphinxcontrib-jsmath-1.0.1 sphinxcontrib-qthelp-2.0.0 sphinxcontrib-serializinghtml-2.0.0 tomli-2.2.1 urllib3-2.5.0 zipp-3.23.0
Additional packages installed: Jinja2-3, 1, 6, MarkupSafe-3, 0, 2, Pygments-2, 19, 2, Sphinx-7, 4, 7, alabaster-0, 7, 16, babel-2, 17, 0, certifi-2025, 8, 3, charset-normalizer-3, 4, 3, docutils-0, 21, 2, idna-3, 10, imagesize-1, 4, 1, importlib-metadata-8, 7, 0, packaging-25, 0, pyyaml-6, 0, 2, requests-2, 32, 4, snowballstemmer-3, 0, 1, sphinxcontrib-applehelp-2, 0, 0, sphinxcontrib-devhelp-2, 0, 0, sphinxcontrib-htmlhelp-2, 1, 0, sphinxcontrib-jsmath-1, 0, 1, sphinxcontrib-qthelp-2, 0, 0, sphinxcontrib-serializinghtml-2, 0, 0, tomli-2, 2, 1, urllib3-2, 5, 0, zipp-3, 23, 0

Installing section: venv with pip
=================================

 $ /usr/bin/python3 -m venv sphinx_latest
 $ pip install --no-input -r ./Documentation/sphinx/requirements.txt
 Requirement already satisfied: alabaster in ./sphinx_latest/lib/python3.9/site-packages (from -r ./Documentation/sphinx/requirements.txt (line 2)) (0.7.16)
 Requirement already satisfied: Sphinx in ./sphinx_latest/lib/python3.9/site-packages (from -r ./Documentation/sphinx/requirements.txt (line 3)) (7.4.7)
 Requirement already satisfied: pyyaml in ./sphinx_latest/lib/python3.9/site-packages (from -r ./Documentation/sphinx/requirements.txt (line 4)) (6.0.2)
 Requirement already satisfied: Pygments>=2.17 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.19.2)
 Requirement already satisfied: Jinja2>=3.1 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (3.1.6)
 Requirement already satisfied: babel>=2.13 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.17.0)
 Requirement already satisfied: sphinxcontrib-serializinghtml>=1.1.9 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.0.0)
 Requirement already satisfied: sphinxcontrib-devhelp in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.0.0)
 Requirement already satisfied: tomli>=2 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.2.1)
 Requirement already satisfied: sphinxcontrib-qthelp in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.0.0)
 Requirement already satisfied: importlib-metadata>=6.0 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (8.7.0)
 Requirement already satisfied: snowballstemmer>=2.2 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (3.0.1)
 Requirement already satisfied: sphinxcontrib-applehelp in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.0.0)
 Requirement already satisfied: imagesize>=1.3 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (1.4.1)
 Requirement already satisfied: sphinxcontrib-htmlhelp>=2.0.0 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.1.0)
 Requirement already satisfied: requests>=2.30.0 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.32.4)
 Requirement already satisfied: packaging>=23.0 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (25.0)
 Requirement already satisfied: docutils<0.22,>=0.20 in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (0.21.2)
 Requirement already satisfied: sphinxcontrib-jsmath in ./sphinx_latest/lib/python3.9/site-packages (from Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (1.0.1)
 Requirement already satisfied: zipp>=3.20 in ./sphinx_latest/lib/python3.9/site-packages (from importlib-metadata>=6.0->Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (3.23.0)
 Requirement already satisfied: MarkupSafe>=2.0 in ./sphinx_latest/lib/python3.9/site-packages (from Jinja2>=3.1->Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (3.0.2)
 Requirement already satisfied: certifi>=2017.4.17 in ./sphinx_latest/lib/python3.9/site-packages (from requests>=2.30.0->Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2025.8.3)
 Requirement already satisfied: urllib3<3,>=1.21.1 in ./sphinx_latest/lib/python3.9/site-packages (from requests>=2.30.0->Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (2.5.0)
 Requirement already satisfied: charset_normalizer<4,>=2 in ./sphinx_latest/lib/python3.9/site-packages (from requests>=2.30.0->Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (3.4.3)
 Requirement already satisfied: idna<4,>=2.5 in ./sphinx_latest/lib/python3.9/site-packages (from requests>=2.30.0->Sphinx->-r ./Documentation/sphinx/requirements.txt (line 3)) (3.10)
Check for docutils on venv with sphinx_latest/bin/python
 $ sphinx_latest/bin/python -c try: import docutils; print(docutils.__version__)
except: pass
 0.21.2
 $ sphinx-build --version
 sphinx-build 7.4.7

Installing section: package_install with dnf
============================================

 $ dnf install -y --setopt=install_weak_deps=False python3-sphinx
 Last metadata expiration check: 0:02:20 ago on Mon Aug 18 07:33:55 2025.
 Dependencies resolved.
 ================================================================================================
  Package                                 Arch    Version            Repository              Size
 ================================================================================================
 Installing:
  python3-sphinx                          noarch  1:3.4.3-8.el9      ol9_codeready_builder  2.9 M
 Installing dependencies:
  python3-babel                           noarch  2.9.1-2.el9        ol9_appstream          6.6 M
  python3-chardet                         noarch  4.0.0-5.0.1.el9    base                   350 k
  python3-docutils                        noarch  0.16-6.el9         ol9_appstream          2.0 M
  python3-idna                            noarch  2.10-7.0.1.el9_4.1 base                   129 k
  python3-imagesize                       noarch  1.2.0-6.el9        ol9_codeready_builder   27 k
  python3-jinja2                          noarch  2.11.3-8.el9_5     ol9_appstream          329 k
  python3-markupsafe                      x86_64  1.1.1-12.el9       ol9_appstream           52 k
  python3-packaging                       noarch  20.9-5.0.1.el9     ol9_appstream          117 k
  python3-pygments                        noarch  2.7.4-4.el9        ol9_codeready_builder  2.6 M
  python3-pyparsing                       noarch  2.4.7-9.el9        base                   163 k
  python3-pysocks                         noarch  1.7.1-12.0.1.el9   base                    46 k
  python3-pytz                            noarch  2021.1-5.el9       ol9_appstream           73 k
  python3-requests                        noarch  2.25.1-10.el9_6    latest                 179 k
  python3-setuptools                      noarch  53.0.0-13.el9_6.1  latest                 1.3 M
  python3-snowballstemmer                 noarch  1.9.0-10.el9       ol9_codeready_builder  231 k
  python3-sphinx-theme-alabaster          noarch  0.7.12-13.el9      ol9_codeready_builder   48 k
  python3-sphinxcontrib-applehelp         noarch  1.0.2-5.el9        ol9_codeready_builder  103 k
  python3-sphinxcontrib-devhelp           noarch  1.0.2-5.el9        ol9_codeready_builder   95 k
  python3-sphinxcontrib-htmlhelp          noarch  1.0.3-6.el9        ol9_codeready_builder  109 k
  python3-sphinxcontrib-jsmath            noarch  1.0.1-12.el9       ol9_codeready_builder   33 k
  python3-sphinxcontrib-qthelp            noarch  1.0.3-5.el9        ol9_codeready_builder  101 k
  python3-sphinxcontrib-serializinghtml   noarch  1.1.4-5.el9        ol9_codeready_builder  103 k
  python3-urllib3                         noarch  1.26.5-6.el9       base                   310 k
 
 Transaction Summary
 ================================================================================================
 Install  24 Packages
 
 Total download size: 18 M
 Installed size: 61 M
 Downloading Packages:
 (1/24): python3-idna-2.10-7.0.1.el9_4.1.noarch. 831 kB/s | 129 kB     00:00    
 (2/24): python3-pyparsing-2.4.7-9.el9.noarch.rp 901 kB/s | 163 kB     00:00    
 (3/24): python3-chardet-4.0.0-5.0.1.el9.noarch. 1.5 MB/s | 350 kB     00:00    
 (4/24): python3-pysocks-1.7.1-12.0.1.el9.noarch 611 kB/s |  46 kB     00:00    
 (5/24): python3-requests-2.25.1-10.el9_6.noarch 7.3 MB/s | 179 kB     00:00    
 (6/24): python3-urllib3-1.26.5-6.el9.noarch.rpm 3.9 MB/s | 310 kB     00:00    
 (7/24): python3-setuptools-53.0.0-13.el9_6.1.no  15 MB/s | 1.3 MB     00:00    
 (8/24): python3-docutils-0.16-6.el9.noarch.rpm   20 MB/s | 2.0 MB     00:00    
 (9/24): python3-babel-2.9.1-2.el9.noarch.rpm     37 MB/s | 6.6 MB     00:00    
 (10/24): python3-jinja2-2.11.3-8.el9_5.noarch.r 2.3 MB/s | 329 kB     00:00    
 (11/24): python3-packaging-20.9-5.0.1.el9.noarc 1.7 MB/s | 117 kB     00:00    
 (12/24): python3-pytz-2021.1-5.el9.noarch.rpm   1.6 MB/s |  73 kB     00:00    
 (13/24): python3-markupsafe-1.1.1-12.el9.x86_64 304 kB/s |  52 kB     00:00    
 (14/24): python3-snowballstemmer-1.9.0-10.el9.n 3.9 MB/s | 231 kB     00:00    
 (15/24): python3-pygments-2.7.4-4.el9.noarch.rp  25 MB/s | 2.6 MB     00:00    
 (16/24): python3-imagesize-1.2.0-6.el9.noarch.r 214 kB/s |  27 kB     00:00    
 (17/24): python3-sphinx-theme-alabaster-0.7.12- 939 kB/s |  48 kB     00:00    
 (18/24): python3-sphinxcontrib-devhelp-1.0.2-5. 1.9 MB/s |  95 kB     00:00    
 (19/24): python3-sphinx-3.4.3-8.el9.noarch.rpm   23 MB/s | 2.9 MB     00:00    
 (20/24): python3-sphinxcontrib-htmlhelp-1.0.3-6 1.4 MB/s | 109 kB     00:00    
 (21/24): python3-sphinxcontrib-jsmath-1.0.1-12. 412 kB/s |  33 kB     00:00    
 (22/24): python3-sphinxcontrib-serializinghtml- 1.7 MB/s | 103 kB     00:00    
 (23/24): python3-sphinxcontrib-qthelp-1.0.3-5.e 1.2 MB/s | 101 kB     00:00    
 (24/24): python3-sphinxcontrib-applehelp-1.0.2-  51 kB/s | 103 kB     00:02    
 --------------------------------------------------------------------------------
 Total                                           6.8 MB/s |  18 MB     00:02     
 Running transaction check
 Transaction check succeeded.
 Running transaction test
 Transaction test succeeded.
 Running transaction
   Preparing        :                                                        1/1 
   Installing       : python3-setuptools-53.0.0-13.el9_6.1.noarch           1/24 
   Installing       : python3-idna-2.10-7.0.1.el9_4.1.noarch                2/24 
   Installing       : python3-sphinxcontrib-serializinghtml-1.1.4-5.el9.    3/24 
   Installing       : python3-sphinxcontrib-qthelp-1.0.3-5.el9.noarch       4/24 
   Installing       : python3-sphinxcontrib-jsmath-1.0.1-12.el9.noarch      5/24 
   Installing       : python3-sphinxcontrib-htmlhelp-1.0.3-6.el9.noarch     6/24 
   Installing       : python3-sphinxcontrib-devhelp-1.0.2-5.el9.noarch      7/24 
   Installing       : python3-sphinxcontrib-applehelp-1.0.2-5.el9.noarch    8/24 
   Installing       : python3-sphinx-theme-alabaster-0.7.12-13.el9.noarc    9/24 
   Installing       : python3-snowballstemmer-1.9.0-10.el9.noarch          10/24 
   Installing       : python3-pygments-2.7.4-4.el9.noarch                  11/24 
   Installing       : python3-imagesize-1.2.0-6.el9.noarch                 12/24 
   Installing       : python3-pytz-2021.1-5.el9.noarch                     13/24 
   Installing       : python3-babel-2.9.1-2.el9.noarch                     14/24 
   Installing       : python3-markupsafe-1.1.1-12.el9.x86_64               15/24 
   Installing       : python3-jinja2-2.11.3-8.el9_5.noarch                 16/24 
   Installing       : python3-docutils-0.16-6.el9.noarch                   17/24 
   Installing       : python3-pysocks-1.7.1-12.0.1.el9.noarch              18/24 
   Installing       : python3-urllib3-1.26.5-6.el9.noarch                  19/24 
   Installing       : python3-pyparsing-2.4.7-9.el9.noarch                 20/24 
   Installing       : python3-packaging-20.9-5.0.1.el9.noarch              21/24 
   Installing       : python3-chardet-4.0.0-5.0.1.el9.noarch               22/24 
   Installing       : python3-requests-2.25.1-10.el9_6.noarch              23/24 
   Installing       : python3-sphinx-1:3.4.3-8.el9.noarch                  24/24 
   Running scriptlet: python3-sphinx-1:3.4.3-8.el9.noarch                  24/24 
   Verifying        : python3-chardet-4.0.0-5.0.1.el9.noarch                1/24 
   Verifying        : python3-idna-2.10-7.0.1.el9_4.1.noarch                2/24 
   Verifying        : python3-pyparsing-2.4.7-9.el9.noarch                  3/24 
   Verifying        : python3-pysocks-1.7.1-12.0.1.el9.noarch               4/24 
   Verifying        : python3-urllib3-1.26.5-6.el9.noarch                   5/24 
   Verifying        : python3-requests-2.25.1-10.el9_6.noarch               6/24 
   Verifying        : python3-setuptools-53.0.0-13.el9_6.1.noarch           7/24 
   Verifying        : python3-babel-2.9.1-2.el9.noarch                      8/24 
   Verifying        : python3-docutils-0.16-6.el9.noarch                    9/24 
   Verifying        : python3-jinja2-2.11.3-8.el9_5.noarch                 10/24 
   Verifying        : python3-markupsafe-1.1.1-12.el9.x86_64               11/24 
   Verifying        : python3-packaging-20.9-5.0.1.el9.noarch              12/24 
   Verifying        : python3-pytz-2021.1-5.el9.noarch                     13/24 
   Verifying        : python3-imagesize-1.2.0-6.el9.noarch                 14/24 
   Verifying        : python3-pygments-2.7.4-4.el9.noarch                  15/24 
   Verifying        : python3-snowballstemmer-1.9.0-10.el9.noarch          16/24 
   Verifying        : python3-sphinx-1:3.4.3-8.el9.noarch                  17/24 
   Verifying        : python3-sphinx-theme-alabaster-0.7.12-13.el9.noarc   18/24 
   Verifying        : python3-sphinxcontrib-applehelp-1.0.2-5.el9.noarch   19/24 
   Verifying        : python3-sphinxcontrib-devhelp-1.0.2-5.el9.noarch     20/24 
   Verifying        : python3-sphinxcontrib-htmlhelp-1.0.3-6.el9.noarch    21/24 
   Verifying        : python3-sphinxcontrib-jsmath-1.0.1-12.el9.noarch     22/24 
   Verifying        : python3-sphinxcontrib-qthelp-1.0.3-5.el9.noarch      23/24 
   Verifying        : python3-sphinxcontrib-serializinghtml-1.1.4-5.el9.   24/24 
 
 Installed:
   python3-babel-2.9.1-2.el9.noarch                                              
   python3-chardet-4.0.0-5.0.1.el9.noarch                                        
   python3-docutils-0.16-6.el9.noarch                                            
   python3-idna-2.10-7.0.1.el9_4.1.noarch                                        
   python3-imagesize-1.2.0-6.el9.noarch                                          
   python3-jinja2-2.11.3-8.el9_5.noarch                                          
   python3-markupsafe-1.1.1-12.el9.x86_64                                        
   python3-packaging-20.9-5.0.1.el9.noarch                                       
   python3-pygments-2.7.4-4.el9.noarch                                           
   python3-pyparsing-2.4.7-9.el9.noarch                                          
   python3-pysocks-1.7.1-12.0.1.el9.noarch                                       
   python3-pytz-2021.1-5.el9.noarch                                              
   python3-requests-2.25.1-10.el9_6.noarch                                       
   python3-setuptools-53.0.0-13.el9_6.1.noarch                                   
   python3-snowballstemmer-1.9.0-10.el9.noarch                                   
   python3-sphinx-1:3.4.3-8.el9.noarch                                           
   python3-sphinx-theme-alabaster-0.7.12-13.el9.noarch                           
   python3-sphinxcontrib-applehelp-1.0.2-5.el9.noarch                            
   python3-sphinxcontrib-devhelp-1.0.2-5.el9.noarch                              
   python3-sphinxcontrib-htmlhelp-1.0.3-6.el9.noarch                             
   python3-sphinxcontrib-jsmath-1.0.1-12.el9.noarch                              
   python3-sphinxcontrib-qthelp-1.0.3-5.el9.noarch                               
   python3-sphinxcontrib-serializinghtml-1.1.4-5.el9.noarch                      
   python3-urllib3-1.26.5-6.el9.noarch                                           
 
 Complete!
Additional packages installed: noarch, 1

Installing section: package_install with dnf
============================================

 $ dnf install -y --setopt=install_weak_deps=False python3-sphinx
 Last metadata expiration check: 0:02:25 ago on Mon Aug 18 07:33:55 2025.
 Package python3-sphinx-1:3.4.3-8.el9.noarch is already installed.
 Dependencies resolved.
 Nothing to do.
 Complete!
Check for docutils with /usr/bin/python3
 $ /usr/bin/python3 -c try: import docutils; print(docutils.__version__)
except: pass
 0.16
 $ sphinx-build --version
 sphinx-build 3.4.3
Default subset: Oracle Linux Server release 9.6
 $ hostname

Installation commands processed
TAP version 14
1..1
# Subtest: Oracle Linux Server release 9.6
    1..7
    ok 1 - OS detection: Oracle Linux Server release 9.6
    ok 2 - System packages: Packages installed
    ok 3 - Sphinx on venv: Sphinx Sphinx 7.4.7
    ok 4 - Sphinx package: Sphinx Sphinx 3.4.3
    ok 5 - Clean documentation: Build time: 0:00, return code: 0
    ok 6 - Build HTML documentation: Build time: 3:57, return code: 0
    ok 7 - Build PDF documentation: Build time: 10:09, return code: 0
    # Subtest: PDF docs
        1..65
        ok 1 - dev-tools: pdf/dev-tools.pdf
        ok 2 - tools: pdf/tools.pdf
        ok 3 - filesystems: pdf/filesystems.pdf
        ok 4 - w1: pdf/w1.pdf
        ok 5 - maintainer: pdf/maintainer.pdf
        ok 6 - process: pdf/process.pdf
        ok 7 - isdn: pdf/isdn.pdf
        ok 8 - fault-injection: pdf/fault-injection.pdf
        ok 9 - iio: pdf/iio.pdf
        ok 10 - scheduler: pdf/scheduler.pdf
        ok 11 - staging: pdf/staging.pdf
        ok 12 - fpga: pdf/fpga.pdf
        ok 13 - power: pdf/power.pdf
        ok 14 - leds: pdf/leds.pdf
        ok 15 - edac: pdf/edac.pdf
        ok 16 - PCI: pdf/PCI.pdf
        ok 17 - firmware-guide: pdf/firmware-guide.pdf
        ok 18 - cpu-freq: pdf/cpu-freq.pdf
        ok 19 - mhi: pdf/mhi.pdf
        ok 20 - wmi: pdf/wmi.pdf
        ok 21 - timers: pdf/timers.pdf
        ok 22 - accel: pdf/accel.pdf
        ok 23 - hid: pdf/hid.pdf
        ok 24 - userspace-api: pdf/userspace-api.pdf
        ok 25 - spi: pdf/spi.pdf
        ok 26 - networking: pdf/networking.pdf
        ok 27 - virt: pdf/virt.pdf
        ok 28 - nvme: pdf/nvme.pdf
        ok 29 - translations: pdf/translations.pdf
        ok 30 - input: pdf/input.pdf
        ok 31 - tee: pdf/tee.pdf
        ok 32 - doc-guide: pdf/doc-guide.pdf
        ok 33 - cdrom: pdf/cdrom.pdf
        ok 34 - gpu: pdf/gpu.pdf
        ok 35 - i2c: pdf/i2c.pdf
        ok 36 - RCU: pdf/RCU.pdf
        ok 37 - watchdog: pdf/watchdog.pdf
        ok 38 - usb: pdf/usb.pdf
        ok 39 - rust: pdf/rust.pdf
        ok 40 - crypto: pdf/crypto.pdf
        ok 41 - kbuild: pdf/kbuild.pdf
        ok 42 - livepatch: pdf/livepatch.pdf
        ok 43 - mm: pdf/mm.pdf
        ok 44 - locking: pdf/locking.pdf
        ok 45 - infiniband: pdf/infiniband.pdf
        ok 46 - driver-api: pdf/driver-api.pdf
        ok 47 - bpf: pdf/bpf.pdf
        ok 48 - devicetree: pdf/devicetree.pdf
        ok 49 - block: pdf/block.pdf
        ok 50 - target: pdf/target.pdf
        ok 51 - arch: pdf/arch.pdf
        ok 52 - pcmcia: pdf/pcmcia.pdf
        ok 53 - scsi: pdf/scsi.pdf
        ok 54 - netlabel: pdf/netlabel.pdf
        ok 55 - sound: pdf/sound.pdf
        ok 56 - security: pdf/security.pdf
        ok 57 - accounting: pdf/accounting.pdf
        ok 58 - admin-guide: pdf/admin-guide.pdf
        ok 59 - core-api: pdf/core-api.pdf
        ok 60 - fb: pdf/fb.pdf
        ok 61 - peci: pdf/peci.pdf
        ok 62 - trace: pdf/trace.pdf
        ok 63 - misc-devices: pdf/misc-devices.pdf
        ok 64 - kernel-hacking: pdf/kernel-hacking.pdf
        ok 65 - hwmon: pdf/hwmon.pdf
ok 1 - Oracle Linux Server release 9.6

-

Here, I dropped the full logs for html and pdf, as they were a way too bigger>

That's the end of the pdfdocs build target:

Summary
=======
Oracle Linux Server release 9.6:
    OS detection             : PASSED: Oracle Linux Server release 9.6
    System packages          : PASSED: Packages installed
    Sphinx on venv           : PASSED: Sphinx Sphinx 7.4.7
    Sphinx package           : PASSED: Sphinx Sphinx 3.4.3
    Clean documentation      : PASSED: Build time: 0:00, return code: 0
    Build HTML documentation : PASSED: Build time: 3:57, return code: 0
    Build PDF documentation  : PASSED: Build time: 10:09, return code: 0
    PDF docs:
        dev-tools                : PASSED: pdf/dev-tools.pdf
        tools                    : PASSED: pdf/tools.pdf
        filesystems              : PASSED: pdf/filesystems.pdf
        w1                       : PASSED: pdf/w1.pdf
        maintainer               : PASSED: pdf/maintainer.pdf
        process                  : PASSED: pdf/process.pdf
        isdn                     : PASSED: pdf/isdn.pdf
        fault-injection          : PASSED: pdf/fault-injection.pdf
        iio                      : PASSED: pdf/iio.pdf
        scheduler                : PASSED: pdf/scheduler.pdf
        staging                  : PASSED: pdf/staging.pdf
        fpga                     : PASSED: pdf/fpga.pdf
        power                    : PASSED: pdf/power.pdf
        leds                     : PASSED: pdf/leds.pdf
        edac                     : PASSED: pdf/edac.pdf
        PCI                      : PASSED: pdf/PCI.pdf
        firmware-guide           : PASSED: pdf/firmware-guide.pdf
        cpu-freq                 : PASSED: pdf/cpu-freq.pdf
        mhi                      : PASSED: pdf/mhi.pdf
        wmi                      : PASSED: pdf/wmi.pdf
        timers                   : PASSED: pdf/timers.pdf
        accel                    : PASSED: pdf/accel.pdf
        hid                      : PASSED: pdf/hid.pdf
        userspace-api            : PASSED: pdf/userspace-api.pdf
        spi                      : PASSED: pdf/spi.pdf
        networking               : PASSED: pdf/networking.pdf
        virt                     : PASSED: pdf/virt.pdf
        nvme                     : PASSED: pdf/nvme.pdf
        translations             : PASSED: pdf/translations.pdf
        input                    : PASSED: pdf/input.pdf
        tee                      : PASSED: pdf/tee.pdf
        doc-guide                : PASSED: pdf/doc-guide.pdf
        cdrom                    : PASSED: pdf/cdrom.pdf
        gpu                      : PASSED: pdf/gpu.pdf
        i2c                      : PASSED: pdf/i2c.pdf
        RCU                      : PASSED: pdf/RCU.pdf
        watchdog                 : PASSED: pdf/watchdog.pdf
        usb                      : PASSED: pdf/usb.pdf
        rust                     : PASSED: pdf/rust.pdf
        crypto                   : PASSED: pdf/crypto.pdf
        kbuild                   : PASSED: pdf/kbuild.pdf
        livepatch                : PASSED: pdf/livepatch.pdf
        mm                       : PASSED: pdf/mm.pdf
        locking                  : PASSED: pdf/locking.pdf
        infiniband               : PASSED: pdf/infiniband.pdf
        driver-api               : PASSED: pdf/driver-api.pdf
        bpf                      : PASSED: pdf/bpf.pdf
        devicetree               : PASSED: pdf/devicetree.pdf
        block                    : PASSED: pdf/block.pdf
        target                   : PASSED: pdf/target.pdf
        arch                     : PASSED: pdf/arch.pdf
        pcmcia                   : PASSED: pdf/pcmcia.pdf
        scsi                     : PASSED: pdf/scsi.pdf
        netlabel                 : PASSED: pdf/netlabel.pdf
        sound                    : PASSED: pdf/sound.pdf
        security                 : PASSED: pdf/security.pdf
        accounting               : PASSED: pdf/accounting.pdf
        admin-guide              : PASSED: pdf/admin-guide.pdf
        core-api                 : PASSED: pdf/core-api.pdf
        fb                       : PASSED: pdf/fb.pdf
        peci                     : PASSED: pdf/peci.pdf
        trace                    : PASSED: pdf/trace.pdf
        misc-devices             : PASSED: pdf/misc-devices.pdf
        kernel-hacking           : PASSED: pdf/kernel-hacking.pdf
        hwmon                    : PASSED: pdf/hwmon.pdf


/root/sphinx_latest/bin/python3 sphinx_latest/bin/sphinx-build -j4 -b latex -c /root/Documentation -D latex_elements.papersize=a4paper -d /root/Documentation/output/.doctrees -D kerneldoc_bin=scripts/kernel-doc.py -D version=6.17.0-rc1 -D release= -D kerne
ldoc_srctree=. /root/Documentation /root/Documentation/output/latex

Summary
=======
dev-tools      : pdf/dev-tools.pdf
tools          : pdf/tools.pdf
filesystems    : pdf/filesystems.pdf
w1             : pdf/w1.pdf
maintainer     : pdf/maintainer.pdf
process        : pdf/process.pdf
isdn           : pdf/isdn.pdf
fault-injection: pdf/fault-injection.pdf
iio            : pdf/iio.pdf
scheduler      : pdf/scheduler.pdf
staging        : pdf/staging.pdf
fpga           : pdf/fpga.pdf
power          : pdf/power.pdf
leds           : pdf/leds.pdf
edac           : pdf/edac.pdf
PCI            : pdf/PCI.pdf
firmware-guide : pdf/firmware-guide.pdf
cpu-freq       : pdf/cpu-freq.pdf
mhi            : pdf/mhi.pdf
wmi            : pdf/wmi.pdf
timers         : pdf/timers.pdf
accel          : pdf/accel.pdf
hid            : pdf/hid.pdf
userspace-api  : pdf/userspace-api.pdf
spi            : pdf/spi.pdf
networking     : pdf/networking.pdf
virt           : pdf/virt.pdf
nvme           : pdf/nvme.pdf
translations   : pdf/translations.pdf
input          : pdf/input.pdf
tee            : pdf/tee.pdf
doc-guide      : pdf/doc-guide.pdf
cdrom          : pdf/cdrom.pdf
gpu            : pdf/gpu.pdf
i2c            : pdf/i2c.pdf
RCU            : pdf/RCU.pdf
watchdog       : pdf/watchdog.pdf
usb            : pdf/usb.pdf
rust           : pdf/rust.pdf
crypto         : pdf/crypto.pdf
kbuild         : pdf/kbuild.pdf
livepatch      : pdf/livepatch.pdf
mm             : pdf/mm.pdf
locking        : pdf/locking.pdf
infiniband     : pdf/infiniband.pdf
driver-api     : pdf/driver-api.pdf
bpf            : pdf/bpf.pdf
devicetree     : pdf/devicetree.pdf
block          : pdf/block.pdf
target         : pdf/target.pdf
arch           : pdf/arch.pdf
pcmcia         : pdf/pcmcia.pdf
scsi           : pdf/scsi.pdf
netlabel       : pdf/netlabel.pdf
sound          : pdf/sound.pdf
security       : pdf/security.pdf
accounting     : pdf/accounting.pdf
admin-guide    : pdf/admin-guide.pdf
core-api       : pdf/core-api.pdf
fb             : pdf/fb.pdf
peci           : pdf/peci.pdf
trace          : pdf/trace.pdf
misc-devices   : pdf/misc-devices.pdf
kernel-hacking : pdf/kernel-hacking.pdf
hwmon          : pdf/hwmon.pdf

All PDF files were built.


1 of 1 validate commands succeeded





