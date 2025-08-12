Return-Path: <linux-kernel+bounces-765194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E812B22CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67325604DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2422FDC55;
	Tue, 12 Aug 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYSn9tzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BAA2F83C5;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=ruJXncmPJO0Dqq9nQYK3SNuzLA7eCozGkaYKwLwrnTnHtirJaxXy07K+wrl3P6nJhbRAFnQ45o0fGMbfknANahGD0XvBmk7KtUpsRXFYGRNwOSeuV/EM4K6v26UgxMh6Hn+YUrfSE6f8IsI2NQmVPSsUTgUpqZltGdmS6XMGNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=at2mdtprGw43Jj2RV+t0cp9yhUlxFfCUk1YC8d9y9g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eoBfn7mOYTyqPsXZ6zbHzlpq6k5zawTj5N6vvJcXD4nGnaP7MGbR91B/A/hxNaCUaAz+3KB9ircoOVkHYUWk7gwbFSazzbRCNYBGPrSv1eMAdmeLi3DpBw1zaI7+POv6Z9E4B9+fy1f8iXGv8PUQLCamSK/f+iUcInZycqbkz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYSn9tzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB951C4AF0E;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=at2mdtprGw43Jj2RV+t0cp9yhUlxFfCUk1YC8d9y9g8=;
	h=From:To:Cc:Subject:Date:From;
	b=HYSn9tzSd9SOwYzwZWJ6Cezfojdu9/xSFsqaN/R5TGai/3kr1y3uCpn+MDaX1S4GV
	 9ZwBwduJYlNsVCoq2Rm/IJaASnmQ/Q3mduiCKro7pA3FH1q4aBw8/olopEJQ50EyBf
	 vjxXy5Reu1L3qYyHQzny2mrkPoQ/TNxR756kGQ5PfBKZzSn8VKaiPOxDFesG8JDhGA
	 fWOsoiaC2cXmGHxaQ4smvkVFDYTfbnk4E9IGxzhImvJz3OJqUtjI9XbZ23ICXs0dTf
	 8mLsN3DY08XT774Y8ddT76WooTDtKlrRlugZP9XRSvNVY+iaqH+NE0A28bpyt41W3F
	 pCXzzlVgTW4uA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVD-0CwU;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <mchehab+huawei@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	llvm@lists.linux.dev
Subject: [PATCH v2 00/39] Translate sphinx-pre-install to Python
Date: Tue, 12 Aug 2025 17:52:17 +0200
Message-ID: <cover.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

that's the second version of the patch series which converts
sphinx-pre-install to Python.

The core patches are basically the same as on v1, but it has lots of
fixes over the original script after testing sphinx-install on 22
distros.

Please notice that I have a separate patch series addressing issues
that are specific to PDF generation.

Test Results Summary:
====================

  PASSED - AlmaLinux release 9.6 (Sage Margay) (4 tests)
  PASSED - Amazon Linux release 2023 (Amazon Linux) (4 tests)
  PASSED - Arch Linux (4 tests)
  PASSED - CentOS Stream release 9 (4 tests)
  PASSED - Debian GNU/Linux 12 (4 tests)
  PASSED - Devuan GNU/Linux 5 (4 tests)
  PASSED - Fedora release 42 (Adams) (4 tests)
  PASSED - Gentoo Base System release 2.17 (4 tests)
  PASSED - Kali GNU/Linux 2025.2 (4 tests)
  PASSED - Mageia 9 (4 tests)
  PASSED - Linux Mint 22 (4 tests)
  PASSED - openEuler release 25.03 (4 tests)
  PARTIAL - OpenMandriva Lx 4.3 (4 tests)
	ensurepip package doesn't exist there. So, venv install failed.
	Installed via package worked
  PASSED - openSUSE Leap 15.6 (4 tests)
  PASSED - openSUSE Tumbleweed (4 tests)
  PASSED - Oracle Linux Server release 9.6 (4 tests)
  FAILED - Red Hat Enterprise Linux release 8.10 (Ootpa) (4 tests)
	I couldn't test properly, as it requires a repository under
	paywall. I suspect It should work fine
  PARTIAL - Rocky Linux release 8.9 (Green Obsidian) (4 tests)
	Install via package didn't work. Instaling via venv works.
  PASSED - Rocky Linux release 9.6 (Blue Onyx) (4 tests)
  PARTIAL - Springdale Open Enterprise Linux release 9.2 (Parma) (4 tests)
	Failed to install ImageMagick (affects pdf only)
  PASSED - Ubuntu 24.04.2 LTS (4 tests)
  PASSED - Ubuntu 25.04 (4 tests)

In short, I expect that, for all the above, the script will properly
recommend the right packages to have sphinx-build working.

A more detailed list of tests that passed/failed and detected Sphinx
versions can be seeing below:

AlmaLinux release 9.6 (Sage Margay):
------------------------------------
    PASSED: OS detection: AlmaLinux release 9.6 (Sage Margay)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Amazon Linux release 2023 (Amazon Linux):
-----------------------------------------
    PASSED: OS detection: Amazon Linux release 2023 (Amazon Linux)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Arch Linux:
-----------
    PASSED: OS detection: Arch Linux
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.2.3

CentOS Stream release 9:
------------------------
    PASSED: OS detection: CentOS Stream release 9
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Debian GNU/Linux 12:
--------------------
    PASSED: OS detection: Debian GNU/Linux 12
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 5.3.0

Devuan GNU/Linux 5:
-------------------
    PASSED: OS detection: Devuan GNU/Linux 5
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 5.3.0

Fedora release 42 (Adams):
--------------------------
    PASSED: OS detection: Fedora release 42 (Adams)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

Gentoo Base System release 2.17:
--------------------------------
    PASSED: OS detection: Gentoo Base System release 2.17
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.2.3

Kali GNU/Linux 2025.2:
----------------------
    PASSED: OS detection: Kali GNU/Linux 2025.2
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

Mageia 9:
---------
    PASSED: OS detection: Mageia 9
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 6.1.3
    PASSED: Sphinx package: Sphinx 6.1.3

Linux Mint 22:
--------------
    PASSED: OS detection: Linux Mint 22
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.1.3
    PASSED: Sphinx package: Sphinx 4.3.2

openEuler release 25.03:
------------------------
    PASSED: OS detection: openEuler release 25.03
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

OpenMandriva Lx 4.3:
--------------------
    PASSED: OS detection: OpenMandriva Lx 4.3
    FAILED: System packages:  Error: Unable to find a match: ensurepip
    FAILED: Sphinx on venv: Installation failed
    PASSED: Sphinx package: Sphinx 4.3.2

openSUSE Leap 15.6:
-------------------
    PASSED: OS detection: openSUSE Leap 15.6
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 7.2.6

openSUSE Tumbleweed:
--------------------
    PASSED: OS detection: openSUSE Tumbleweed
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.2.3

Oracle Linux Server release 9.6:
--------------------------------
    PASSED: OS detection: Oracle Linux Server release 9.6
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Red Hat Enterprise Linux release 8.10 (Ootpa):
----------------------------------------------
    PASSED: OS detection: Red Hat Enterprise Linux release 8.10 (Ootpa)
    FAILED: System packages:  Error: Unable to find a match: google-noto-sans-cjk-ttc-fonts librsvg2-tools texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-collection-fontsrecommended texlive-collection-latex texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xecjk texlive-xetex-bin
    FAILED: Sphinx on venv: No Sphinx version detected
    FAILED: Sphinx package: No Sphinx version detected

Rocky Linux release 8.9 (Green Obsidian):
-----------------------------------------
    PASSED: OS detection: Rocky Linux release 8.9 (Green Obsidian)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    FAILED: Sphinx package: No Sphinx version detected

Rocky Linux release 9.6 (Blue Onyx):
------------------------------------
    PASSED: OS detection: Rocky Linux release 9.6 (Blue Onyx)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Springdale Open Enterprise Linux release 9.2 (Parma):
-----------------------------------------------------
    PASSED: OS detection: Springdale Open Enterprise Linux release 9.2 (Parma)
    FAILED: System packages:  Error:   Problem: package ImageMagick-6.9.13.25-1.el9.x86_64 requires libMagickCore-6.Q16.so.7()(64bit), but none of the providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires libMagickWand-6.Q16.so.7()(64bit), but none of the providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires ImageMagick-libs(x86-64) = 6.9.13.25-1.el9, but none of the providers can be installed   - conflicting requests   - nothing provides libraw_r.so.23()(64bit) needed by ImageMagick-libs-6.9.13.25-1.el9.x86_64
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Ubuntu 24.04.2 LTS:
-------------------
    PASSED: OS detection: Ubuntu 24.04.2 LTS
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 7.2.6

Ubuntu 25.04:
-------------
    PASSED: OS detection: Ubuntu 25.04
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

Summary
=======
  PASSED - AlmaLinux release 9.6 (Sage Margay) (4 tests)
  PASSED - Amazon Linux release 2023 (Amazon Linux) (4 tests)
  PASSED - Arch Linux (4 tests)
  PASSED - CentOS Stream release 9 (4 tests)
  PASSED - Debian GNU/Linux 12 (4 tests)
  PASSED - Devuan GNU/Linux 5 (4 tests)
  PASSED - Fedora release 42 (Adams) (4 tests)
  PASSED - Gentoo Base System release 2.17 (4 tests)
  PASSED - Kali GNU/Linux 2025.2 (4 tests)
  PASSED - Mageia 9 (4 tests)
  PASSED - Linux Mint 22 (4 tests)
  PASSED - openEuler release 25.03 (4 tests)
  FAILED - OpenMandriva Lx 4.3 (4 tests)
  PASSED - openSUSE Leap 15.6 (4 tests)
  PASSED - openSUSE Tumbleweed (4 tests)
  PASSED - Oracle Linux Server release 9.6 (4 tests)
  FAILED - Red Hat Enterprise Linux release 8.10 (Ootpa) (4 tests)
  FAILED - Rocky Linux release 8.9 (Green Obsidian) (4 tests)
  PASSED - Rocky Linux release 9.6 (Blue Onyx) (4 tests)
  FAILED - Springdale Open Enterprise Linux release 9.2 (Parma) (4 tests)
  PASSED - Ubuntu 24.04.2 LTS (4 tests)
  PASSED - Ubuntu 25.04 (4 tests)
(base) mchehab@foz /new_devel/mchehab_scripts $ ktap_reader.py /tmp/test_logs/*

AlmaLinux release 9.6 (Sage Margay):
------------------------------------
    PASSED: OS detection: AlmaLinux release 9.6 (Sage Margay)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Amazon Linux release 2023 (Amazon Linux):
-----------------------------------------
    PASSED: OS detection: Amazon Linux release 2023 (Amazon Linux)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Arch Linux:
-----------
    PASSED: OS detection: Arch Linux
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.2.3

CentOS Stream release 9:
------------------------
    PASSED: OS detection: CentOS Stream release 9
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Debian GNU/Linux 12:
--------------------
    PASSED: OS detection: Debian GNU/Linux 12
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 5.3.0

Devuan GNU/Linux 5:
-------------------
    PASSED: OS detection: Devuan GNU/Linux 5
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 5.3.0

Fedora release 42 (Adams):
--------------------------
    PASSED: OS detection: Fedora release 42 (Adams)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

Gentoo Base System release 2.17:
--------------------------------
    PASSED: OS detection: Gentoo Base System release 2.17
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.2.3

Kali GNU/Linux 2025.2:
----------------------
    PASSED: OS detection: Kali GNU/Linux 2025.2
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

Mageia 9:
---------
    PASSED: OS detection: Mageia 9
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 6.1.3
    PASSED: Sphinx package: Sphinx 6.1.3

Linux Mint 22:
--------------
    PASSED: OS detection: Linux Mint 22
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.1.3
    PASSED: Sphinx package: Sphinx 4.3.2

openEuler release 25.03:
------------------------
    PASSED: OS detection: openEuler release 25.03
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

OpenMandriva Lx 4.3:
--------------------
    PASSED: OS detection: OpenMandriva Lx 4.3
    FAILED: System packages:  Error: Unable to find a match: ensurepip
    PARTIAL: Sphinx on venv: Installation failed
    PASSED: Sphinx package: Sphinx 4.3.2

openSUSE Leap 15.6:
-------------------
    PASSED: OS detection: openSUSE Leap 15.6
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 7.2.6

openSUSE Tumbleweed:
--------------------
    PASSED: OS detection: openSUSE Tumbleweed
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.2.3

Oracle Linux Server release 9.6:
--------------------------------
    PASSED: OS detection: Oracle Linux Server release 9.6
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Red Hat Enterprise Linux release 8.10 (Ootpa):
----------------------------------------------
    PASSED: OS detection: Red Hat Enterprise Linux release 8.10 (Ootpa)
    FAILED: System packages:  Error: Unable to find a match: google-noto-sans-cjk-ttc-fonts librsvg2-tools texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-capt-of texlive-cmap texlive-collection-fontsrecommended texlive-collection-latex texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-luatex85 texlive-mdwtools texlive-multirow texlive-needspace texlive-oberdiek texlive-parskip texlive-polyglossia texlive-psnfss texlive-tabulary texlive-threeparttable texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-xecjk texlive-xetex-bin
    PARTIAL: Sphinx on venv: No Sphinx version detected
    PARTIAL: Sphinx package: No Sphinx version detected

Rocky Linux release 8.9 (Green Obsidian):
-----------------------------------------
    PASSED: OS detection: Rocky Linux release 8.9 (Green Obsidian)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PARTIAL: Sphinx package: No Sphinx version detected

Rocky Linux release 9.6 (Blue Onyx):
------------------------------------
    PASSED: OS detection: Rocky Linux release 9.6 (Blue Onyx)
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Springdale Open Enterprise Linux release 9.2 (Parma):
-----------------------------------------------------
    PASSED: OS detection: Springdale Open Enterprise Linux release 9.2 (Parma)
    FAILED: System packages:  Error:   Problem: package ImageMagick-6.9.13.25-1.el9.x86_64 requires libMagickCore-6.Q16.so.7()(64bit), but none of the providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires libMagickWand-6.Q16.so.7()(64bit), but none of the providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires ImageMagick-libs(x86-64) = 6.9.13.25-1.el9, but none of the providers can be installed   - conflicting requests   - nothing provides libraw_r.so.23()(64bit) needed by ImageMagick-libs-6.9.13.25-1.el9.x86_64
    PASSED: Sphinx on venv: Sphinx 7.4.7
    PASSED: Sphinx package: Sphinx 3.4.3

Ubuntu 24.04.2 LTS:
-------------------
    PASSED: OS detection: Ubuntu 24.04.2 LTS
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 7.2.6

Ubuntu 25.04:
-------------
    PASSED: OS detection: Ubuntu 25.04
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx 8.2.3
    PASSED: Sphinx package: Sphinx 8.1.3

---

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
  docs: Makefile: switch to the new scripts/sphinx-pre-install.py
  scripts: sphinx-pre-install.pl: get rid of the old script
  scripts: sphinx-pre-install: update mandatory system deps
  scripts: sphinx-pre-install: add support for RHEL8-based distros
  scripts: sphinx-pre-install: add a warning for Debian-based distros
  scripts: sphinx-pre-install: some adjustments related to venv

 scripts/sphinx-pre-install | 2641 ++++++++++++++++++++++--------------
 1 file changed, 1589 insertions(+), 1052 deletions(-)

-- 
2.50.1


