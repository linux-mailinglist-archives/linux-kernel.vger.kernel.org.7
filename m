Return-Path: <linux-kernel+bounces-723788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39EAFEB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629931888E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33E2EAB6B;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEGh1WOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA62E5B32;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=NyiimrtwUsnuZW/w+A8y2UIEOnVSL3IN/T8WqhDXUZ9kgMs+eBl8xc+0qRcYJ8DU0E/NxVU5IZQh84KLzs9DnFyDDFeahD/GYhOcVjgiG9wC9AP8y+AemDg+q0Ce41C+dnPqG1NKe6GwgC5SkWhkUTdD5b7c5ntXPiyZ44bXwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=CMhF09FFFMGUc6L5nWI64rBCiTAHL7tLnu8zhdqkCMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drzOECAv5XnO1MQ7HqQb3FDGpIXjxaFOWpmC9qCzIrcqrb06JntTRRBoLlOTC/NHzMG0rkPGzgzsTRrHREqiYd7gf1RA7cPSGU/D6HNbmf6Wz1GMB9QU79AcawWS1EPUTFhtqJ3A7gkVo608fwbppKfu7jtl5GFyuRWOQTCODQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEGh1WOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5E5C116B1;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=CMhF09FFFMGUc6L5nWI64rBCiTAHL7tLnu8zhdqkCMI=;
	h=From:To:Cc:Subject:Date:From;
	b=bEGh1WOyCQcywe9cEiH/++df4CkD7AaLzTbr9z7iIteEcKZZwp+TZqOdy4BymQFxr
	 MDGdBpm997QXtUvq2M0Eo2skweyzTW8f7vFbZi5rOBWowEOd7vBQfzdxUK8tmT6O+u
	 kfARSzJzSdc7XJ6lUJE+E1J7GAUc5XA1YZubKgtRo8LOZskLtkeD488anKrfUTO1/a
	 zQsjA4MIUX0EHkIoM2QH3LXUQOBFX0+xApg/dKL3ISIOmSK+3OBS2eVVOdvXSzGj7E
	 mer8FW/5QvIzxOISc0/uZQHa0O7fp+v44YXqQihagKr9I6xWFTUU4cmBP36/irxsEW
	 6nagl+84OxdWA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EC6-0TD9;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	llvm@lists.linux.dev
Subject: [PATCH v2 00/39] Translate sphinx-pre-install to Python
Date: Wed,  9 Jul 2025 15:51:32 +0200
Message-ID: <cover.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Hi Jon,

That's the new version of my series. It got a little bit bigger
(almost twice the size) of the previous verson, as I did lots of
tests to ensure that the script behaves well with several different
versions. The minimal requirement to run the script is Python 3.6.

As this is not compatible with our current build, the script checks
for its python version and re-run with the newest one (if found).
It also provides a mechanism to request a newest Python version,
which was tested with RHEL8-based distros and with OpenSUSE
Leap.

This series port scripts/sphinx-pre-install to Python. It started as
a bug-compatible version with the old logic. I did several cleanups
later on, and better structured its source. 

While testing it with lxc and some Docker images, I opted
to also drop legacy logic from it and to add support for some
additional variants compatible with existing detection logic.

It also fixes some issues that were present at the proposed
install procedures that don't work anymore with new distro
versions.

The tests were done with those containers, obtained from
lxc download templates or via podman run.  I tested with 18
different distributions.

With all of them, at least one version of Sphinx was properly
installed. There are only three partial failures:

OpenMandriva Lx 4:
- python-virtualenv is currently broken at the docker image:
  it doesn't have ensurepip, required for pip to work on venv.
- native package installed fine.

RHEL8-based distros (tested with 2 variants):
 - Python Sphinx native package is version 1.7.x, running with
   Python version 3.6.
- venv installed fine.

one RHEL 9.2-based distro had a problem with ImageMagick
broken dependencies.  Sphinx installed fine. So, only PDF
generation would likely fail there.

For the rest, both venv and native install worked properly.

Please notice that my goal here is to test just this tool.
I didn't try to actually build the docs on every distro. Yet,
I added a couple of hints for some known issues with some
distros.

IMO, the overall picture is that several things got improved
from what we had on Perl. The only drawback is that, when
using Container images, all of the tested ones had perl
installed by default, but a couple of them didn't have Python.

I don't think this is a problem in real life, and anyone that
has a bare minimal development knowledge should be able
to manually install python if needed.

-

Those are the test summary:

AlmaLinux release 9.6 (Sage Margay):
------------------------------------
  PASSED 1 - OS: AlmaLinux release 9.6 (Sage Margay), Python: 3.9.21, hostname: almalinux-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 3.4.3, Docutils 0.16

Arch Linux:
-----------
  PASSED 1 - OS: Arch Linux, Python: 3.13.5
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.2.3, Docutils 0.21.2

CentOS Stream release 9:
------------------------
  PASSED 1 - OS: CentOS Stream release 9, Python: 3.9.23, hostname: centos-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 3.4.3, Docutils 0.16

Debian GNU/Linux 12:
--------------------
  PASSED 1 - OS: Debian GNU/Linux 12, Python: 3.11.2, hostname: debian-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 5.3.0, Docutils 0.19

Devuan GNU/Linux 5:
-------------------
  PASSED 1 - OS: Devuan GNU/Linux 5, Python: 3.11.2, hostname: devuan-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 5.3.0, Docutils 0.19

Fedora release 42 (Adams):
--------------------------
  PASSED 1 - OS: Fedora release 42 (Adams), Python: 3.13.5
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.1.3, Docutils 0.21.2

Gentoo Base System release 2.17:
--------------------------------
  PASSED 1 - OS: Gentoo Base System release 2.17, Python: 3.13.3
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.2.3, Docutils 0.21.2

Kali GNU/Linux 2025.2:
----------------------
  PASSED 1 - OS: Kali GNU/Linux 2025.2, Python: 3.13.3, hostname: kali-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.1.3, Docutils 0.21.2

Mageia 9:
---------
  PASSED 1 - OS: Mageia 9, Python: 3.10.11, hostname: mageia-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.1.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 6.1.3, Docutils 0.19

Linux Mint 22:
--------------
  PASSED 1 - OS: Linux Mint 22, Python: 3.10.12, hostname: mint-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.1.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 4.3.2, Docutils 0.17.1

openEuler release 25.03:
------------------------
  PASSED 1 - OS: openEuler release 25.03, Python: 3.11.11, hostname: openeuler-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.1.3, Docutils 0.21.2

OpenMandriva Lx 4.3:
--------------------
  PASSED 1 - OS: OpenMandriva Lx 4.3, Python: 3.9.8, hostname: openmandriva-test
  FAILED 2 - System packages:  Error: Unable to find a match: ensurepip
  FAILED 3 - Sphinx on venv
  PASSED 4 - Sphinx package: Sphinx Sphinx 4.3.2, Docutils 0.17

openSUSE Tumbleweed:
--------------------
  PASSED 1 - OS: openSUSE Tumbleweed, Python: 3.13.5, hostname: opensuse-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.2.3, Docutils 0.21.2

Rocky Linux release 8.9 (Green Obsidian):
-----------------------------------------
  PASSED 1 - OS: Rocky Linux release 8.9 (Green Obsidian), Python: 3.6.8, hostname: rockylinux8-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2, Python3.9.20
  FAILED 4 - Sphinx package:  No Sphinx version!

Rocky Linux release 9.6 (Blue Onyx):
------------------------------------
  PASSED 1 - OS: Rocky Linux release 9.6 (Blue Onyx), Python: 3.9.21, hostname: rockylinux-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 3.4.3, Docutils 0.16

Springdale Open Enterprise Linux release 9.2 (Parma):
-----------------------------------------------------
  PASSED 1 - OS: Springdale Open Enterprise Linux release 9.2 (Parma), Python: 3.9.16, hostname: springdalelinux-test
  FAILED 2 - System packages:  Error:   Problem: package ImageMagick-6.9.13.25-1.el9.x86_64 requires libMagickCore-6.Q16.so.7()(64bit), but none of the providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires libMagickWand-6.Q16.so.7()(64bit), but none of the providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires ImageMagick-libs(x86-64) = 6.9.13.25-1.el9, but none of the providers can be installed   - conflicting requests   - nothing provides libraw_r.so.23()(64bit) needed by ImageMagick-libs-6.9.13.25-1.el9.x86_64
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 3.4.3, Docutils 0.16

Ubuntu 24.04.2 LTS:
-------------------
  PASSED 1 - OS: Ubuntu 24.04.2 LTS, Python: 3.12.3, hostname: ubuntu-lts-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 7.2.6, Docutils 0.20.1

Ubuntu 25.04:
-------------
  PASSED 1 - OS: Ubuntu 25.04, Python: 3.13.3, hostname: ubuntu-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.1.3, Docutils 0.21.2

Summary
=======

  PASSED: AlmaLinux release 9.6 (Sage Margay) (4 passed, 0 failed, 0 skipped)
  PASSED: Arch Linux (4 passed, 0 failed, 0 skipped)
  PASSED: CentOS Stream release 9 (4 passed, 0 failed, 0 skipped)
  PASSED: Debian GNU/Linux 12 (4 passed, 0 failed, 0 skipped)
  PASSED: Devuan GNU/Linux 5 (4 passed, 0 failed, 0 skipped)
  PASSED: Fedora release 42 (Adams) (4 passed, 0 failed, 0 skipped)
  PASSED: Gentoo Base System release 2.17 (4 passed, 0 failed, 0 skipped)
  PASSED: Kali GNU/Linux 2025.2 (4 passed, 0 failed, 0 skipped)
  PASSED: Mageia 9 (4 passed, 0 failed, 0 skipped)
  PASSED: Linux Mint 22 (4 passed, 0 failed, 0 skipped)
  PASSED: openEuler release 25.03 (4 passed, 0 failed, 0 skipped)
  PARTIAL: OpenMandriva Lx 4.3 (2 passed, 2 failed, 0 skipped)
  PASSED: openSUSE Tumbleweed (4 passed, 0 failed, 0 skipped)
  PARTIAL: Rocky Linux release 8.9 (Green Obsidian) (3 passed, 1 failed, 0 skipped)
  PASSED: Rocky Linux release 9.6 (Blue Onyx) (4 passed, 0 failed, 0 skipped)
  PARTIAL: Springdale Open Enterprise Linux release 9.2 (Parma) (3 passed, 1 failed, 0 skipped)
  PASSED: Ubuntu 24.04.2 LTS (4 passed, 0 failed, 0 skipped)
  PASSED: Ubuntu 25.04 (4 passed, 0 failed, 0 skipped)




Mauro Carvalho Chehab (39):
  scripts: sphinx-pre-install: fix version check for Fedora
  scripts: sphinx-pre-install: rename it to
    scripts/sphinx-pre-install.pl
  scripts: sphinx-pre-install: Convert script to Python
  scripts: sphinx-pre-install: Make it compatible with Python 3.6
  scripts: sphinx-pre-install: run on a supported version
  scripts: sphinx-pre-install: drop obsolete routines
  scripts: sphinx-pre-install: drop support for old virtualenv
  scripts: sphinx-pre-install: Address issues with OpenSUSE Leap 15.x
  scripts: sphinx-pre-install: fix opensuse Leap hint for PyYAML
  scripts: sphinx-pre-install: fix support for gentoo
  scripts: sphinx-pre-install: Address issues with OpenSUSE Tumbleweed
  scripts: sphinx-pre-install: only show portage hints once
  scripts: sphinx-pre-install: cleanup rhel support
  scripts: sphinx-pre-install: output Python and docutils version
  scripts: sphinx-pre-install: add a missing f-string marker
  scripts: sphinx-pre-install: fix Leap support for rsvg-convert
  scripts: sphinx-pre-install: fix rhel recomendations
  scripts: sphinx-pre-install: remove Scientific Linux
  scripts: sphinx-pre-install: improve Gentoo package deps logic
  scripts: sphinx-pre-install: fix OpenMandriva support
  scripts: sphinx-pre-install: move package instructions to a new func
  scripts: sphinx-pre-install: adjust a warning message
  scripts: sphinx-pre-install: better handle Python min version
  scripts: sphinx-pre-install: convert is_optional to a class
  scripts: sphinx-pre-install: better handle RHEL-based distros
  scripts: sphinx-pre-install: move missing logic to a separate class
  scripts: sphinx-pre-install: move ancillary checkers to a separate
    class
  scripts: sphinx-pre-install: add more generic checkers on a class
  scripts: sphinx-pre-install: move get_system_release()
  scripts: sphinx-pre-install: add documentation for the ancillary
    classes.
  scripts: sphinx-pre-install: add docstring documentation
  scripts: sphinx-pre-install: fix several codingstyle issues
  scripts: sphinx-pre-install: rework install command logic
  scripts: sphinx-pre-install: update mandatory system deps
  scripts: sphinx-pre-install: add support for RHEL8-based distros
  scripts: sphinx-pre-install: add a warning for Debian-based distros
  scripts: sphinx-pre-install: some adjustments related to venv
  docs: Makefile: switch to the new scripts/sphinx-pre-install.py
  scripts: sphinx-pre-install.pl: get rid of the old script

 scripts/sphinx-pre-install | 2641 ++++++++++++++++++++++--------------
 test_script.py             |    4 +-
 2 files changed, 1591 insertions(+), 1054 deletions(-)

-- 
2.49.0



