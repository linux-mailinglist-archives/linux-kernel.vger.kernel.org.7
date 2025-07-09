Return-Path: <linux-kernel+bounces-723163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF6EAFE3DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1140C189EBBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549DA275867;
	Wed,  9 Jul 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzep0bER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF423C8CE;
	Wed,  9 Jul 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052670; cv=none; b=jQYY1oA5c6wibimBr3UAAgFxspz9pkQl1C1T3RzxFUaIH0s8MBWHWWh9qwx7I7bAlI92rLSJxBRX11CEsAVZ0iIzwzSESBEb5Z2fPIjcwmnFX+jtIJn6XKHbtywEfCFyH3yAilG7iPUE7p/eKf/8wjHLOKolfpQDGakL0WxsODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052670; c=relaxed/simple;
	bh=7bbFxl8i5cBdOiGQUdEGTwaL5IU2WGOWRkOjhSCtgJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiqtn1CL4ryhriFZCAlXJhlErtTa8h369lNLGwthHBTDAieBk9F2QxkTFm7oSZGrBV4YTCVopRCkxicSCFknG1fmdseovnco0FM+42/0H/tb2VWqOiClrOoRLst3wV9o3OOUbNfAMFpy1OKfF8vNvJB18r+7DiuVPd2XSb5dERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzep0bER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B4C4CEEF;
	Wed,  9 Jul 2025 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052670;
	bh=7bbFxl8i5cBdOiGQUdEGTwaL5IU2WGOWRkOjhSCtgJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rzep0bERNeYLZLPkTgoY26CGoXg7qOol9Rcpuy7olBWb7joER23N+wFcG5StHMy86
	 f27kG3QEBFstYhiW2lezXYopWY0yDFsivUklL0wI6mRh2/j1z7SOPyY6L+Ju/c074s
	 /tQgL5wXx0DlEjHy1X8aA9b4ZQpscrlI4r9IMf9fvs2Zhx0BkhGPXx1GARMLENi//5
	 yZa60xCX3TLDSloMjXCyMfmwt8Io53lcb+d14AgO9EWu56oU3tCgcjCeAQ+HUkmJcr
	 fXmRCCJnGiiILYmJvYMTOXGHpIfRmzmyO+h+GiJBrMBXAMDKWQEzyDsA6HKiX8c29E
	 zNJxz5aq9FfqQ==
Date: Wed, 9 Jul 2025 11:17:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Sai Vishnu M
 <saivishnu725@gmail.com>
Subject: Re: [PATCH 00/15] Translate sphinx-pre-install to Python
Message-ID: <20250709111745.380db248@foz.lan>
In-Reply-To: <9148ae7f-7954-421e-b5dc-366651f0bc48@gmail.com>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
	<d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
	<87bjpu69q3.fsf@trenco.lwn.net>
	<9148ae7f-7954-421e-b5dc-366651f0bc48@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Tue, 8 Jul 2025 23:56:01 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Tue, 08 Jul 2025 08:25:08 -0600, Jonathan Corbet wrote:
> > Akira Yokosawa <akiyks@gmail.com> writes:
> >  =20
> >> Hi Mauro,
> >>
> >> On Mon, 30 Jun 2025 23:34:48 +0200, Mauro Carvalho Chehab wrote:
> >> [...]
> >> =20
> >>> The test script also ran the install procedure for system,
> >>> venv and native Sphinx install. =20
> >>
> >> Which install procedure did you test?  The short one with the "--no-pd=
f"
> >> option?
> >>
> >> I am asking because installing the full list of packages in podman run
> >> of opensuse/leap:15.6 didn't complete successfully for me.
> >>
> >> And by the look of things, you stopped at installation, because you are
> >> well aware of all the issues in running "make htmldocs" and its friends
> >> after the install.
> >>
> >> I assume you (or somebody else) are going to update the script once th=
is
> >> series is applied to make the suggested lists of packages be useful for
> >> newcomers. =20
> >=20
> > Thanks for testing this out.
> >=20
> > My question would be: are the results somehow worse than those provided
> > by the existing, Perl script? =20
>=20
> Not at all.  Mauro made some improvements WRT opensuse/leap over the perl
> one, but there remain a lot of rooms for improvements here and there.=20

On my tests, the results are better, and more variants are supported.
Those are the current results for my test script (on the version I'm=20
yet to submit):

AlmaLinux release 9.6 (Sage Margay):
------------------------------------
  PASSED 1 - OS: AlmaLinux release 9.6 (Sage Margay), Python: 3.9.21, hostn=
ame: almalinux-test
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
  PASSED 1 - OS: CentOS Stream release 9, Python: 3.9.23, hostname: centos-=
test
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
  PASSED 1 - OS: openEuler release 25.03, Python: 3.11.11, hostname: openeu=
ler-test
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.1.3, Docutils 0.21.2

OpenMandriva Lx 4.3:
--------------------
  PASSED 1 - OS: OpenMandriva Lx 4.3, Python: 3.9.8, hostname: openmandriva=
-test
  FAILED 2 - System packages:  Error: Unable to find a match: ensurepip
  FAILED 3 - Sphinx on venv
  PASSED 4 - Sphinx package: Sphinx Sphinx 4.3.2, Docutils 0.17

openSUSE Tumbleweed:
--------------------
  PASSED 1 - OS: openSUSE Tumbleweed, Python: 3.13.5, hostname: opensuse-te=
st
  PASSED 2 - System packages: Packages installed.
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 8.2.3, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 8.2.3, Docutils 0.21.2

Rocky Linux release 8.9 (Green Obsidian):
-----------------------------------------
  PASSED 1 - OS: Rocky Linux release 8.9 (Green Obsidian), Python: 3.6.8, h=
ostname: rockylinux8-test
  PASSED 2 - System packages: Packages installed.
  FAILED 3 - Sphinx on venv:  No Sphinx version!
  FAILED 4 - Sphinx package:  No Sphinx version!

Rocky Linux release 9.6 (Blue Onyx):
------------------------------------
  PASSED 1 - OS: Rocky Linux release 9.6 (Blue Onyx), Python: 3.9.21, hostn=
ame: rockylinux-test
  FAILED 2 - System packages:  Errors during downloading metadata for repos=
itory 'epel':   - Curl error (28): Timeout was reached for http://ftp.redir=
is.es/mirror/fedora-epel/9/Everything/x86_64/repodata/repomd.xml [Operation=
 too slow. Less than 1000 bytes/sec transferred the last 30 seconds]   - Cu=
rl error (28): Timeout was reached for https://mirror.yandex.ru/epel/9/Ever=
ything/x86_64/repodata/repomd.xml [Failed to connect to mirror.yandex.ru po=
rt 443: Connection timed out]   - Downloading successful, but checksum does=
n't match. Calculated: ae3b260e2d12fd111887d36ddd99b22dda9d038b2ce8b1240495=
e7dedf3eeca4a85e5c1ef10488649c614a3029cb790a0230dbd1a9bb1d20d5d868bcd3ce3bb=
6(sha512)  Expected: 0b6aa1cb918981a1fa6712a14d80968d6bf4e7f121268f90cd5573=
edb21a36b40f6ec34f8668180c4048eb01afd2938941af61d61304383c858917ed7f2b98de(=
sha512)    - Curl error (28): Timeout was reached for https://fr2.rpmfind.n=
et/linux/epel/9/Everything/x86_64/repodata/repomd.xml [Operation timed out =
after 30000 milliseconds with 0 out of 0 bytes received] Error: Failed to d=
ownload metadata for repo 'epel': Cannot download repomd.xml: Cannot downlo=
ad repodata/repomd.xml: All mirrors were tried
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 3.4.3, Docutils 0.16

Springdale Open Enterprise Linux release 9.2 (Parma):
-----------------------------------------------------
  PASSED 1 - OS: Springdale Open Enterprise Linux release 9.2 (Parma), Pyth=
on: 3.9.16, hostname: springdalelinux-test
  FAILED 2 - System packages:  Error:   Problem: package ImageMagick-6.9.13=
.25-1.el9.x86_64 requires libMagickCore-6.Q16.so.7()(64bit), but none of th=
e providers can be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64=
 requires libMagickWand-6.Q16.so.7()(64bit), but none of the providers can =
be installed   - package ImageMagick-6.9.13.25-1.el9.x86_64 requires ImageM=
agick-libs(x86-64) =3D 6.9.13.25-1.el9, but none of the providers can be in=
stalled   - conflicting requests   - nothing provides libraw_r.so.23()(64bi=
t) needed by ImageMagick-libs-6.9.13.25-1.el9.x86_64
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2
  PASSED 4 - Sphinx package: Sphinx Sphinx 3.4.3, Docutils 0.16

Ubuntu 24.04.2 LTS:
-------------------
  PASSED 1 - OS: Ubuntu 24.04.2 LTS, Python: 3.12.3, hostname: ubuntu-lts-t=
est
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
=3D=3D=3D=3D=3D=3D=3D

  PASSED: AlmaLinux release 9.6 (Sage Margay) (4 passed, 0 failed, 0 skippe=
d)
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
  PARTIAL: Rocky Linux release 8.9 (Green Obsidian) (2 passed, 2 failed, 0 =
skipped)
  PARTIAL: Rocky Linux release 9.6 (Blue Onyx) (3 passed, 1 failed, 0 skipp=
ed)
  PARTIAL: Springdale Open Enterprise Linux release 9.2 (Parma) (3 passed, =
1 failed, 0 skipped)
  PASSED: Ubuntu 24.04.2 LTS (4 passed, 0 failed, 0 skipped)
  PASSED: Ubuntu 25.04 (4 passed, 0 failed, 0 skipped)

So, basically:

- OpenMandriva LX 4.3 (*):
  - I didn't find a way to make pip work there. Not critical, as
    Sphinx installs as package.
  - Perl script is not OK for it.

- RHEL8 variants:
  - Installing Sphinx as packages is not possible (Python 3.6)
  - Installing as venv is possible, but I need to adjust the script.
  - Perl script is not OK for it.

- The error with Rocky Linux 9 is just because its mirrors are slow
  now. It passed already on previous tests.

Yeah, there will always be room for improvements.=20

(*) Testing this one was not easy, as the docker image for it is
    half-broken. The image:

	https://hub.docker.com/r/openmandriva/4.0

   is for LX4.0, but dnf points to wrong repositories. I had to do
   some tricks to fix the repositories to the ones that actually exist
   those days, using the tricks below:

        "sed s,enabled=3D1,enabled=3D0, -i /etc/yum.repos.d/*"
        "sed s,4.0,4.3, -i /etc/yum.repos.d/openmandriva-x86_64.repo"
        "dnf update --repo release-x86_64 --releasever 4.3 -y"
        "rm -rf /var/lib/rpm; rpm --rebuilddb"
        "sed -i \"/^\\[openmandriva-x86_64\\]/,/^\\[/ s/^enabled=3D0/enable=
d=3D1/\" /etc/yum.repos.d/openmandriva-x86_64.repo"
        "sed -i \"/^\\[updates-x86_64\\]/,/^\\[/ s/^enabled=3D0/enabled=3D1=
/\" /etc/yum.repos.d/openmandriva-x86_64.repo"
        "dnf install -y passwd which net-tools openssh-server git python3 t=
ar diffutils --releasever 4.3 -y"
        "groupadd -r sshd || true"
        "useradd -r -g sshd -s /sbin/nologin -c 'Privilege-separated SSH' s=
shd || true"

   The above upgrades the container to LX 4.3 on a not recommended way ;-)
   It also prepares the container to start sshd if one needs to copy files
   to it via scp (sometimes I do, when I want to quickly test changes at the
   scripts).

   I couldn't find any newer container repository that could be installed
   either via lxc or docker.
=09
> I've been ignoring sphinx-pre-install all these years, but the impressive
> test results presented in this cover-letter made me test it.
>=20
> >                                If this change regresses things, we
> > obviously do not want to proceed.  If it reproduces the old behavior in
> > a more maintainable language, then hopefully it is a step toward fixing
> > things in the long run ... ? =20
>=20
> Yes, translation into python would help a lot, I guess.

That's what I'm hoping as well ;-)

Regards,
Mauro

