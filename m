Return-Path: <linux-kernel+bounces-810165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE1EB516CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819401C84383
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A43168EA;
	Wed, 10 Sep 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCF2uPNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8E264638;
	Wed, 10 Sep 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507072; cv=none; b=gDJTKwpt6B3Wf+7r9wZcLNPmPUzrKeIclykD3nIX4eRNs8L36H1N7f1ztmCKB7ZnpSpBtZIesHM2Ke40fIYQRHYSBvLnzRUTqjUf23qw3rl6DlAK2HTQbV9i5irGBk6AGNVE2j3WemAVEiv4uMTZCpoY1a7mXmYfl+SvGVoFvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507072; c=relaxed/simple;
	bh=dLMSaw/k3LKVYx+mrNApFSAFiUQF8+6vrHM9mvBP03A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxWvyOnNCs70wvuUfMzZ5RsgwEgW/iHvyszLhglkPPo/jIeaf34tAxGxpQkcfREoj8kFdNOi0IqoFeLOatuCH/w8rY9Mg/em3e+PMfc3UZDdKwYHHKBBoCaX9H88srQBiaZPckftNbNAMF2JHC2Iv8VCS2LqTM+InYav4wIxzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCF2uPNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA029C4CEF0;
	Wed, 10 Sep 2025 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757507072;
	bh=dLMSaw/k3LKVYx+mrNApFSAFiUQF8+6vrHM9mvBP03A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCF2uPNVeFaLEM3vJ37pALV4ZnW+iE1pas9hXYJ1gXBdzLGFR2E3ss8FUkwNmEynC
	 Cjl7hv9BQq0IJMdiGvhg9rTlCq1Fxp9uerUwKNILR+riBJfnuv8Fp5P6tL/kAkTbrg
	 YXPN9zah3atXW3ssJ1QzRoz5dEK54++mDBbpiyBjcxiXQafmEpIkOdjl4n2kDz7dXh
	 WKe3Nzf3wo52s44xZhCHhBkzYg8sehb4uYaUhaYy8FmJDMyOUC2BDAyk5IojgHctGw
	 GRazh7wGdkUOJpsgiqPEDWZRxnLG6w6HpQ3ojiAr/LZAn/tHjYvrDa49ZpFxUPDUtA
	 NnEtH2ODss0Jw==
Date: Wed, 10 Sep 2025 14:24:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] tools/docs: python_version: move version check
 from sphinx-pre-install
Message-ID: <20250910142427.61347215@foz.lan>
In-Reply-To: <12f948d2bb995d9321ce07d8765e00bcbd822402@intel.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<784ca5070326558220cc275deaa046a274badebe.1756969623.git.mchehab+huawei@kernel.org>
	<12f948d2bb995d9321ce07d8765e00bcbd822402@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 10 Sep 2025 13:14:33 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wr=
ote:
> > The sphinx-pre-install code has some logic to deal with Python
> > version, which ensures that a minimal version will be enforced
> > for documentation build logic.
> >
> > Move it to a separate library to allow re-using its code.
> >
> > No functional changes.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tools/docs/lib/python_version.py | 133 +++++++++++++++++++++++++++++++
> >  tools/docs/sphinx-pre-install    | 120 +++-------------------------
> >  2 files changed, 146 insertions(+), 107 deletions(-)
> >  create mode 100644 tools/docs/lib/python_version.py
> >
> > diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_v=
ersion.py
> > new file mode 100644
> > index 000000000000..0519d524e547
> > --- /dev/null
> > +++ b/tools/docs/lib/python_version.py
> > @@ -0,0 +1,133 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2017-2025 Mauro Carvalho Chehab <mchehab+huawei@kernel=
.org>
> > +
> > +"""
> > +Handle Python version check logic.
> > +
> > +Not all Python versions are supported by scripts. Yet, on some cases,
> > +like during documentation build, a newer version of python could be
> > +available.
> > +
> > +This class allows checking if the minimal requirements are followed.
> > +
> > +Better than that, PythonVersion.check_python() not only checks the min=
imal
> > +requirements, but it automatically switches to a the newest available
> > +Python version if present.
> > +
> > +"""
> > +
> > +import os
> > +import re
> > +import subprocess
> > +import sys
> > +
> > +from glob import glob
> > +
> > +class PythonVersion:
> > +    """
> > +    Ancillary methods that checks for missing dependencies for differe=
nt
> > +    types of types, like binaries, python modules, rpm deps, etc.
> > +    """
> > +
> > +    def __init__(self, version):
> > +        """=EF=BF=BD=EF=BF=BDnitialize self.version tuple from a versi=
on string"""
> > +        self.version =3D self.parse_version(version)
> > +
> > +    @staticmethod
> > +    def parse_version(version):
> > +        """Convert a major.minor.patch version into a tuple"""
> > +        return tuple(int(x) for x in version.split(".")) =20
>=20
> I've written a few quick and dirty semver parsers myself, and it saddens
> me to think of adding a simplistic one in the kernel.
>=20
> I'm just wondering, are we doomed to reinventing the wheels in our
> reluctance to depend on anything else?

What do you propose instead, using only internal libs(*)?

In any case, import a library just for one or two single-line
functions seem overkill to me.

(*) As this is used by sphinx-pre-install, which is the script which=20
    checks for missing dependencies, whatever we pick, it should not
    use external libs.

>=20
> > +
> > +    @staticmethod
> > +    def ver_str(version):
> > +        """Returns a version tuple as major.minor.patch"""
> > +        return ".".join([str(x) for x in version])
> > +
> > +    def __str__(self):
> > +        """Returns a version tuple as major.minor.patch from self.vers=
ion"""
> > +        return self.ver_str(self.version)
> > +
> > +    @staticmethod
> > +    def get_python_version(cmd):
> > +        """
> > +        Get python version from a Python binary. As we need to detect =
if
> > +        are out there newer python binaries, we can't rely on sys.rele=
ase here.
> > +        """
> > +
> > +        kwargs =3D {}
> > +        if sys.version_info < (3, 7): =20
>=20
> Checking for things that EOL'd four years ago. Why are we doing this to
> ourselves? Why should we take on maintenance of code that jumps through
> hoops for things that nobody supports anymore?
>=20
> In Documentation/process/changes.rst we've declared Python 3.9 as
> minimum, which is also the oldest version supported by upstream (until
> next month). Even Debian oldoldstable (that's two olds) has 3.9.
>
> We're talking about the documentation build. I can undertand being more
> conservative about the kernel build in general, but IMHO this is just
> extra work for absolutely no users out there. And I'm not advocating for
> bleeding edge here.
>=20
> We could just throw out a lot of crap by setting newer but still
> moderately concervative required Python (and Sphinx) versions, and bail
> out on older version. Let the user figure out how to get them.
>=20
> We don't do this for any other tools either.
>=20
> I'm saying that instead of refactoring this overgrown logic to a
> separate file and class, it should be nuked out of the kernel
> completely.

True, but latest SUSE and openSUSE distros (not counting Thumbleweed
rolling version one) still have Python 3.6 as the main version.

They provide 3.9 as well, but the detection script needs to work with
3.6 to discover that.

If we don't have something like that, we should probably return
using the Perl version of sphinx-pre-install script, which is
a lot more compatible with different distros.

> > +            kwargs['universal_newlines'] =3D True
> > +        else:
> > +            kwargs['text'] =3D True
> > +
> > +        result =3D subprocess.run([cmd, "--version"],
> > +                                stdout =3D subprocess.PIPE,
> > +                                stderr =3D subprocess.PIPE,
> > +                                **kwargs, check=3DFalse)
> > +
> > +        version =3D result.stdout.strip()
> > +
> > +        match =3D re.search(r"(\d+\.\d+\.\d+)", version)
> > +        if match:
> > +            return PythonVersion.parse_version(match.group(1))
> > +
> > +        print(f"Can't parse version {version}")
> > +        return (0, 0, 0)
> > +
> > +    @staticmethod
> > +    def find_python(min_version):
> > +        """
> > +        Detect if are out there any python 3.xy version newer than the
> > +        current one.
> > +
> > +        Note: this routine is limited to up to 2 digits for python3. We
> > +        may need to update it one day, hopefully on a distant future.
> > +        """
> > +        patterns =3D [
> > +            "python3.[0-9]",
> > +            "python3.[0-9][0-9]",
> > +        ]
> > +
> > +        # Seek for a python binary newer than min_version
> > +        for path in os.getenv("PATH", "").split(":"):
> > +            for pattern in patterns:
> > +                for cmd in glob(os.path.join(path, pattern)):
> > +                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
> > +                        version =3D PythonVersion.get_python_version(c=
md)
> > +                        if version >=3D min_version:
> > +                            return cmd
> > +
> > +        return None
> > +
> > +    @staticmethod
> > +    def check_python(min_version):
> > +        """
> > +        Check if the current python binary satisfies our minimal requi=
rement
> > +        for Sphinx build. If not, re-run with a newer version if found.
> > +        """
> > +        cur_ver =3D sys.version_info[:3]
> > +        if cur_ver >=3D min_version:
> > +            ver =3D PythonVersion.ver_str(cur_ver)
> > +            print(f"Python version: {ver}")
> > +
> > +            return
> > +
> > +        python_ver =3D PythonVersion.ver_str(cur_ver)
> > +
> > +        new_python_cmd =3D PythonVersion.find_python(min_version)
> > +        if not new_python_cmd:
> > +            print(f"ERROR: Python version {python_ver} is not spported=
 anymore\n")
> > +            print("       Can't find a new version. This script may fa=
il")
> > +            return
> > +
> > +        # Restart script using the newer version =20
>=20
> I thought the whole idea of restarting was completely rejected by
> approximately everyone?!

This patch is just moving the code. There is a patch after this one
changing the behavior.

> BR,
> Jani.
>=20
>=20
> > +        script_path =3D os.path.abspath(sys.argv[0])
> > +        args =3D [new_python_cmd, script_path] + sys.argv[1:]
> > +
> > +        print(f"Python {python_ver} not supported. Changing to {new_py=
thon_cmd}")
> > +
> > +        try:
> > +            os.execv(new_python_cmd, args)
> > +        except OSError as e:
> > +            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
> > diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-inst=
all
> > index 954ed3dc0645..d6d673b7945c 100755
> > --- a/tools/docs/sphinx-pre-install
> > +++ b/tools/docs/sphinx-pre-install
> > @@ -32,20 +32,10 @@ import subprocess
> >  import sys
> >  from glob import glob
> > =20
> > +from lib.python_version import PythonVersion
> > =20
> > -def parse_version(version):
> > -    """Convert a major.minor.patch version into a tuple"""
> > -    return tuple(int(x) for x in version.split("."))
> > -
> > -
> > -def ver_str(version):
> > -    """Returns a version tuple as major.minor.patch"""
> > -
> > -    return ".".join([str(x) for x in version])
> > -
> > -
> > -RECOMMENDED_VERSION =3D parse_version("3.4.3")
> > -MIN_PYTHON_VERSION =3D parse_version("3.7")
> > +RECOMMENDED_VERSION =3D PythonVersion("3.4.3").version
> > +MIN_PYTHON_VERSION =3D PythonVersion("3.7").version
> > =20
> > =20
> >  class DepManager:
> > @@ -235,95 +225,11 @@ class AncillaryMethods:
> > =20
> >          return None
> > =20
> > -    @staticmethod
> > -    def get_python_version(cmd):
> > -        """
> > -        Get python version from a Python binary. As we need to detect =
if
> > -        are out there newer python binaries, we can't rely on sys.rele=
ase here.
> > -        """
> > -
> > -        result =3D SphinxDependencyChecker.run([cmd, "--version"],
> > -                                            capture_output=3DTrue, tex=
t=3DTrue)
> > -        version =3D result.stdout.strip()
> > -
> > -        match =3D re.search(r"(\d+\.\d+\.\d+)", version)
> > -        if match:
> > -            return parse_version(match.group(1))
> > -
> > -        print(f"Can't parse version {version}")
> > -        return (0, 0, 0)
> > -
> > -    @staticmethod
> > -    def find_python():
> > -        """
> > -        Detect if are out there any python 3.xy version newer than the
> > -        current one.
> > -
> > -        Note: this routine is limited to up to 2 digits for python3. We
> > -        may need to update it one day, hopefully on a distant future.
> > -        """
> > -        patterns =3D [
> > -            "python3.[0-9]",
> > -            "python3.[0-9][0-9]",
> > -        ]
> > -
> > -        # Seek for a python binary newer than MIN_PYTHON_VERSION
> > -        for path in os.getenv("PATH", "").split(":"):
> > -            for pattern in patterns:
> > -                for cmd in glob(os.path.join(path, pattern)):
> > -                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
> > -                        version =3D SphinxDependencyChecker.get_python=
_version(cmd)
> > -                        if version >=3D MIN_PYTHON_VERSION:
> > -                            return cmd
> > -
> > -    @staticmethod
> > -    def check_python():
> > -        """
> > -        Check if the current python binary satisfies our minimal requi=
rement
> > -        for Sphinx build. If not, re-run with a newer version if found.
> > -        """
> > -        cur_ver =3D sys.version_info[:3]
> > -        if cur_ver >=3D MIN_PYTHON_VERSION:
> > -            ver =3D ver_str(cur_ver)
> > -            print(f"Python version: {ver}")
> > -
> > -            # This could be useful for debugging purposes
> > -            if SphinxDependencyChecker.which("docutils"):
> > -                result =3D SphinxDependencyChecker.run(["docutils", "-=
-version"],
> > -                                                    capture_output=3DT=
rue, text=3DTrue)
> > -                ver =3D result.stdout.strip()
> > -                match =3D re.search(r"(\d+\.\d+\.\d+)", ver)
> > -                if match:
> > -                    ver =3D match.group(1)
> > -
> > -                print(f"Docutils version: {ver}")
> > -
> > -            return
> > -
> > -        python_ver =3D ver_str(cur_ver)
> > -
> > -        new_python_cmd =3D SphinxDependencyChecker.find_python()
> > -        if not new_python_cmd:
> > -            print(f"ERROR: Python version {python_ver} is not spported=
 anymore\n")
> > -            print("       Can't find a new version. This script may fa=
il")
> > -            return
> > -
> > -        # Restart script using the newer version
> > -        script_path =3D os.path.abspath(sys.argv[0])
> > -        args =3D [new_python_cmd, script_path] + sys.argv[1:]
> > -
> > -        print(f"Python {python_ver} not supported. Changing to {new_py=
thon_cmd}")
> > -
> > -        try:
> > -            os.execv(new_python_cmd, args)
> > -        except OSError as e:
> > -            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
> > -
> >      @staticmethod
> >      def run(*args, **kwargs):
> >          """
> >          Excecute a command, hiding its output by default.
> > -        Preserve comatibility with older Python versions.
> > +        Preserve compatibility with older Python versions.
> >          """
> > =20
> >          capture_output =3D kwargs.pop('capture_output', False)
> > @@ -527,11 +433,11 @@ class MissingCheckers(AncillaryMethods):
> >          for line in result.stdout.split("\n"):
> >              match =3D re.match(r"^sphinx-build\s+([\d\.]+)(?:\+(?:/[\d=
a-f]+)|b\d+)?\s*$", line)
> >              if match:
> > -                return parse_version(match.group(1))
> > +                return PythonVersion.parse_version(match.group(1))
> > =20
> >              match =3D re.match(r"^Sphinx.*\s+([\d\.]+)\s*$", line)
> >              if match:
> > -                return parse_version(match.group(1))
> > +                return PythonVersion.parse_version(match.group(1))
> > =20
> >      def check_sphinx(self, conf):
> >          """
> > @@ -542,7 +448,7 @@ class MissingCheckers(AncillaryMethods):
> >                  for line in f:
> >                      match =3D re.match(r"^\s*needs_sphinx\s*=3D\s*[\'\=
"]([\d\.]+)[\'\"]", line)
> >                      if match:
> > -                        self.min_version =3D parse_version(match.group=
(1))
> > +                        self.min_version =3D PythonVersion.parse_versi=
on(match.group(1))
> >                          break
> >          except IOError:
> >              sys.exit(f"Can't open {conf}")
> > @@ -562,8 +468,8 @@ class MissingCheckers(AncillaryMethods):
> >              sys.exit(f"{sphinx} didn't return its version")
> > =20
> >          if self.cur_version < self.min_version:
> > -            curver =3D ver_str(self.cur_version)
> > -            minver =3D ver_str(self.min_version)
> > +            curver =3D PythonVersion.ver_str(self.cur_version)
> > +            minver =3D PythonVersion.ver_str(self.min_version)
> > =20
> >              print(f"ERROR: Sphinx version is {curver}. It should be >=
=3D {minver}")
> >              self.need_sphinx =3D 1
> > @@ -1304,7 +1210,7 @@ class SphinxDependencyChecker(MissingCheckers):
> >              else:
> >                  if self.need_sphinx and ver >=3D self.min_version:
> >                      return (f, ver)
> > -                elif parse_version(ver) > self.cur_version:
> > +                elif PythonVersion.parse_version(ver) > self.cur_versi=
on:
> >                      return (f, ver)
> > =20
> >          return ("", ver)
> > @@ -1411,7 +1317,7 @@ class SphinxDependencyChecker(MissingCheckers):
> >              return
> > =20
> >          if self.latest_avail_ver:
> > -            latest_avail_ver =3D ver_str(self.latest_avail_ver)
> > +            latest_avail_ver =3D PythonVersion.ver_str(self.latest_ava=
il_ver)
> > =20
> >          if not self.need_sphinx:
> >              # sphinx-build is present and its version is >=3D $min_ver=
sion
> > @@ -1507,7 +1413,7 @@ class SphinxDependencyChecker(MissingCheckers):
> >          else:
> >              print("Unknown OS")
> >          if self.cur_version !=3D (0, 0, 0):
> > -            ver =3D ver_str(self.cur_version)
> > +            ver =3D PythonVersion.ver_str(self.cur_version)
> >              print(f"Sphinx version: {ver}\n")
> > =20
> >          # Check the type of virtual env, depending on Python version
> > @@ -1613,7 +1519,7 @@ def main():
> > =20
> >      checker =3D SphinxDependencyChecker(args)
> > =20
> > -    checker.check_python()
> > +    PythonVersion.check_python(MIN_PYTHON_VERSION)
> >      checker.check_needs()
> > =20
> >  # Call main if not used as module =20
>=20



Thanks,
Mauro

