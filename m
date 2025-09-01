Return-Path: <linux-kernel+bounces-794948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD5B3EB22
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ABB3B146A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FE2E6CD1;
	Mon,  1 Sep 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEzXtveK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A842DF12A;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740837; cv=none; b=nLer/VATd6X7/Qu3Cyb3LnWRFDTxfmLRAS2a92DGgqzNuv+lvlv3o4IR62GYx7DCFKiu5rbtdQW+KwwkgYRHbugrfyutMHLH+r+8GYzAS0fm+U8/rexeQGu418t+clT4xtJqKh+xCluqtNFrZbmBiHxOcz4gpXd767UKF5nMO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740837; c=relaxed/simple;
	bh=brnr7+g4wHig23G1b6o7kb1LGInthtVFb7E8U/6ZApU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cN/mg1/8E+tjY6S6OzBkpzdmysHCZM5BRUaMLEIbh3Rrco3a6nsn2fL+htZzs9Cwt+T/b1BZm9xzlGJiJ3hS5EHMKl9xST75bQq9vpQ9ufgEB3tl4lOJ2Hd12UJoEmPYc0OtNylRuGywrKJcWw7iXjIJ+WWIbtgnAgt7Vv9GTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEzXtveK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AD8C4CEFB;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=brnr7+g4wHig23G1b6o7kb1LGInthtVFb7E8U/6ZApU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEzXtveKrHVYdNRR4fpRX4U+IDZ6psKXNRwiO6YyAa4W44oTIfB3l0LQReOoDhUaF
	 Iqd4v71M+K7ipQ2b4gBV7UdL+oWqEof7VAZ+ZVrX9iuOrgnKbV411YAjCnxo6ggWpD
	 tgCjIOYDZN2RYR4hBdwn6PVCWfYHNnIkCtVmBUsZJ4oHo6GV3ftN117LLOjR4YfZqP
	 uqtd2DZ//pH3bBDzdPf1IdK2N4alnTHAi5acyv9+IEXCzij4zPRmi0qUW8dug9VQKw
	 49lsV9fR9G6ndgXMjiL9HtNKOP5rLgq77WgetJcb8qhm4pa94di1aLdsDkaOSTGvis
	 CQ2O3qsOFLFtA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HLu-2bap;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 05/15] tools/docs: sphinx-pre-install: move Python
  version handling to lib
Date: Mon,  1 Sep 2025 17:33:40 +0200
Message-ID: <fb41f4572b36ced30a17c768d723c0f8421fa373.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The sphinx-pre-install code has some logic to deal with Python=0D
version, which ensures that a minimal version will be enforced=0D
for documentation build logic.=0D
=0D
Move it to a separate library to allow re-using its code.=0D
=0D
No functional changes.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 tools/docs/lib/python_version.py | 133 +++++++++++++++++++++++++++++++=0D
 tools/docs/sphinx-pre-install    | 120 +++-------------------------=0D
 2 files changed, 146 insertions(+), 107 deletions(-)=0D
 create mode 100644 tools/docs/lib/python_version.py=0D
=0D
diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_versi=
on.py=0D
new file mode 100644=0D
index 000000000000..0519d524e547=0D
--- /dev/null=0D
+++ b/tools/docs/lib/python_version.py=0D
@@ -0,0 +1,133 @@=0D
+#!/usr/bin/env python3=0D
+# SPDX-License-Identifier: GPL-2.0-or-later=0D
+# Copyright (c) 2017-2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org=
>=0D
+=0D
+"""=0D
+Handle Python version check logic.=0D
+=0D
+Not all Python versions are supported by scripts. Yet, on some cases,=0D
+like during documentation build, a newer version of python could be=0D
+available.=0D
+=0D
+This class allows checking if the minimal requirements are followed.=0D
+=0D
+Better than that, PythonVersion.check_python() not only checks the minimal=
=0D
+requirements, but it automatically switches to a the newest available=0D
+Python version if present.=0D
+=0D
+"""=0D
+=0D
+import os=0D
+import re=0D
+import subprocess=0D
+import sys=0D
+=0D
+from glob import glob=0D
+=0D
+class PythonVersion:=0D
+    """=0D
+    Ancillary methods that checks for missing dependencies for different=0D
+    types of types, like binaries, python modules, rpm deps, etc.=0D
+    """=0D
+=0D
+    def __init__(self, version):=0D
+        """=EF=BF=BD=EF=BF=BDnitialize self.version tuple from a version s=
tring"""=0D
+        self.version =3D self.parse_version(version)=0D
+=0D
+    @staticmethod=0D
+    def parse_version(version):=0D
+        """Convert a major.minor.patch version into a tuple"""=0D
+        return tuple(int(x) for x in version.split("."))=0D
+=0D
+    @staticmethod=0D
+    def ver_str(version):=0D
+        """Returns a version tuple as major.minor.patch"""=0D
+        return ".".join([str(x) for x in version])=0D
+=0D
+    def __str__(self):=0D
+        """Returns a version tuple as major.minor.patch from self.version"=
""=0D
+        return self.ver_str(self.version)=0D
+=0D
+    @staticmethod=0D
+    def get_python_version(cmd):=0D
+        """=0D
+        Get python version from a Python binary. As we need to detect if=0D
+        are out there newer python binaries, we can't rely on sys.release =
here.=0D
+        """=0D
+=0D
+        kwargs =3D {}=0D
+        if sys.version_info < (3, 7):=0D
+            kwargs['universal_newlines'] =3D True=0D
+        else:=0D
+            kwargs['text'] =3D True=0D
+=0D
+        result =3D subprocess.run([cmd, "--version"],=0D
+                                stdout =3D subprocess.PIPE,=0D
+                                stderr =3D subprocess.PIPE,=0D
+                                **kwargs, check=3DFalse)=0D
+=0D
+        version =3D result.stdout.strip()=0D
+=0D
+        match =3D re.search(r"(\d+\.\d+\.\d+)", version)=0D
+        if match:=0D
+            return PythonVersion.parse_version(match.group(1))=0D
+=0D
+        print(f"Can't parse version {version}")=0D
+        return (0, 0, 0)=0D
+=0D
+    @staticmethod=0D
+    def find_python(min_version):=0D
+        """=0D
+        Detect if are out there any python 3.xy version newer than the=0D
+        current one.=0D
+=0D
+        Note: this routine is limited to up to 2 digits for python3. We=0D
+        may need to update it one day, hopefully on a distant future.=0D
+        """=0D
+        patterns =3D [=0D
+            "python3.[0-9]",=0D
+            "python3.[0-9][0-9]",=0D
+        ]=0D
+=0D
+        # Seek for a python binary newer than min_version=0D
+        for path in os.getenv("PATH", "").split(":"):=0D
+            for pattern in patterns:=0D
+                for cmd in glob(os.path.join(path, pattern)):=0D
+                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):=0D
+                        version =3D PythonVersion.get_python_version(cmd)=
=0D
+                        if version >=3D min_version:=0D
+                            return cmd=0D
+=0D
+        return None=0D
+=0D
+    @staticmethod=0D
+    def check_python(min_version):=0D
+        """=0D
+        Check if the current python binary satisfies our minimal requireme=
nt=0D
+        for Sphinx build. If not, re-run with a newer version if found.=0D
+        """=0D
+        cur_ver =3D sys.version_info[:3]=0D
+        if cur_ver >=3D min_version:=0D
+            ver =3D PythonVersion.ver_str(cur_ver)=0D
+            print(f"Python version: {ver}")=0D
+=0D
+            return=0D
+=0D
+        python_ver =3D PythonVersion.ver_str(cur_ver)=0D
+=0D
+        new_python_cmd =3D PythonVersion.find_python(min_version)=0D
+        if not new_python_cmd:=0D
+            print(f"ERROR: Python version {python_ver} is not spported any=
more\n")=0D
+            print("       Can't find a new version. This script may fail")=
=0D
+            return=0D
+=0D
+        # Restart script using the newer version=0D
+        script_path =3D os.path.abspath(sys.argv[0])=0D
+        args =3D [new_python_cmd, script_path] + sys.argv[1:]=0D
+=0D
+        print(f"Python {python_ver} not supported. Changing to {new_python=
_cmd}")=0D
+=0D
+        try:=0D
+            os.execv(new_python_cmd, args)=0D
+        except OSError as e:=0D
+            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")=0D
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install=
=0D
index 954ed3dc0645..d6d673b7945c 100755=0D
--- a/tools/docs/sphinx-pre-install=0D
+++ b/tools/docs/sphinx-pre-install=0D
@@ -32,20 +32,10 @@ import subprocess=0D
 import sys=0D
 from glob import glob=0D
 =0D
+from lib.python_version import PythonVersion=0D
 =0D
-def parse_version(version):=0D
-    """Convert a major.minor.patch version into a tuple"""=0D
-    return tuple(int(x) for x in version.split("."))=0D
-=0D
-=0D
-def ver_str(version):=0D
-    """Returns a version tuple as major.minor.patch"""=0D
-=0D
-    return ".".join([str(x) for x in version])=0D
-=0D
-=0D
-RECOMMENDED_VERSION =3D parse_version("3.4.3")=0D
-MIN_PYTHON_VERSION =3D parse_version("3.7")=0D
+RECOMMENDED_VERSION =3D PythonVersion("3.4.3").version=0D
+MIN_PYTHON_VERSION =3D PythonVersion("3.7").version=0D
 =0D
 =0D
 class DepManager:=0D
@@ -235,95 +225,11 @@ class AncillaryMethods:=0D
 =0D
         return None=0D
 =0D
-    @staticmethod=0D
-    def get_python_version(cmd):=0D
-        """=0D
-        Get python version from a Python binary. As we need to detect if=0D
-        are out there newer python binaries, we can't rely on sys.release =
here.=0D
-        """=0D
-=0D
-        result =3D SphinxDependencyChecker.run([cmd, "--version"],=0D
-                                            capture_output=3DTrue, text=3D=
True)=0D
-        version =3D result.stdout.strip()=0D
-=0D
-        match =3D re.search(r"(\d+\.\d+\.\d+)", version)=0D
-        if match:=0D
-            return parse_version(match.group(1))=0D
-=0D
-        print(f"Can't parse version {version}")=0D
-        return (0, 0, 0)=0D
-=0D
-    @staticmethod=0D
-    def find_python():=0D
-        """=0D
-        Detect if are out there any python 3.xy version newer than the=0D
-        current one.=0D
-=0D
-        Note: this routine is limited to up to 2 digits for python3. We=0D
-        may need to update it one day, hopefully on a distant future.=0D
-        """=0D
-        patterns =3D [=0D
-            "python3.[0-9]",=0D
-            "python3.[0-9][0-9]",=0D
-        ]=0D
-=0D
-        # Seek for a python binary newer than MIN_PYTHON_VERSION=0D
-        for path in os.getenv("PATH", "").split(":"):=0D
-            for pattern in patterns:=0D
-                for cmd in glob(os.path.join(path, pattern)):=0D
-                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):=0D
-                        version =3D SphinxDependencyChecker.get_python_ver=
sion(cmd)=0D
-                        if version >=3D MIN_PYTHON_VERSION:=0D
-                            return cmd=0D
-=0D
-    @staticmethod=0D
-    def check_python():=0D
-        """=0D
-        Check if the current python binary satisfies our minimal requireme=
nt=0D
-        for Sphinx build. If not, re-run with a newer version if found.=0D
-        """=0D
-        cur_ver =3D sys.version_info[:3]=0D
-        if cur_ver >=3D MIN_PYTHON_VERSION:=0D
-            ver =3D ver_str(cur_ver)=0D
-            print(f"Python version: {ver}")=0D
-=0D
-            # This could be useful for debugging purposes=0D
-            if SphinxDependencyChecker.which("docutils"):=0D
-                result =3D SphinxDependencyChecker.run(["docutils", "--ver=
sion"],=0D
-                                                    capture_output=3DTrue,=
 text=3DTrue)=0D
-                ver =3D result.stdout.strip()=0D
-                match =3D re.search(r"(\d+\.\d+\.\d+)", ver)=0D
-                if match:=0D
-                    ver =3D match.group(1)=0D
-=0D
-                print(f"Docutils version: {ver}")=0D
-=0D
-            return=0D
-=0D
-        python_ver =3D ver_str(cur_ver)=0D
-=0D
-        new_python_cmd =3D SphinxDependencyChecker.find_python()=0D
-        if not new_python_cmd:=0D
-            print(f"ERROR: Python version {python_ver} is not spported any=
more\n")=0D
-            print("       Can't find a new version. This script may fail")=
=0D
-            return=0D
-=0D
-        # Restart script using the newer version=0D
-        script_path =3D os.path.abspath(sys.argv[0])=0D
-        args =3D [new_python_cmd, script_path] + sys.argv[1:]=0D
-=0D
-        print(f"Python {python_ver} not supported. Changing to {new_python=
_cmd}")=0D
-=0D
-        try:=0D
-            os.execv(new_python_cmd, args)=0D
-        except OSError as e:=0D
-            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")=0D
-=0D
     @staticmethod=0D
     def run(*args, **kwargs):=0D
         """=0D
         Excecute a command, hiding its output by default.=0D
-        Preserve comatibility with older Python versions.=0D
+        Preserve compatibility with older Python versions.=0D
         """=0D
 =0D
         capture_output =3D kwargs.pop('capture_output', False)=0D
@@ -527,11 +433,11 @@ class MissingCheckers(AncillaryMethods):=0D
         for line in result.stdout.split("\n"):=0D
             match =3D re.match(r"^sphinx-build\s+([\d\.]+)(?:\+(?:/[\da-f]=
+)|b\d+)?\s*$", line)=0D
             if match:=0D
-                return parse_version(match.group(1))=0D
+                return PythonVersion.parse_version(match.group(1))=0D
 =0D
             match =3D re.match(r"^Sphinx.*\s+([\d\.]+)\s*$", line)=0D
             if match:=0D
-                return parse_version(match.group(1))=0D
+                return PythonVersion.parse_version(match.group(1))=0D
 =0D
     def check_sphinx(self, conf):=0D
         """=0D
@@ -542,7 +448,7 @@ class MissingCheckers(AncillaryMethods):=0D
                 for line in f:=0D
                     match =3D re.match(r"^\s*needs_sphinx\s*=3D\s*[\'\"]([=
\d\.]+)[\'\"]", line)=0D
                     if match:=0D
-                        self.min_version =3D parse_version(match.group(1))=
=0D
+                        self.min_version =3D PythonVersion.parse_version(m=
atch.group(1))=0D
                         break=0D
         except IOError:=0D
             sys.exit(f"Can't open {conf}")=0D
@@ -562,8 +468,8 @@ class MissingCheckers(AncillaryMethods):=0D
             sys.exit(f"{sphinx} didn't return its version")=0D
 =0D
         if self.cur_version < self.min_version:=0D
-            curver =3D ver_str(self.cur_version)=0D
-            minver =3D ver_str(self.min_version)=0D
+            curver =3D PythonVersion.ver_str(self.cur_version)=0D
+            minver =3D PythonVersion.ver_str(self.min_version)=0D
 =0D
             print(f"ERROR: Sphinx version is {curver}. It should be >=3D {=
minver}")=0D
             self.need_sphinx =3D 1=0D
@@ -1304,7 +1210,7 @@ class SphinxDependencyChecker(MissingCheckers):=0D
             else:=0D
                 if self.need_sphinx and ver >=3D self.min_version:=0D
                     return (f, ver)=0D
-                elif parse_version(ver) > self.cur_version:=0D
+                elif PythonVersion.parse_version(ver) > self.cur_version:=
=0D
                     return (f, ver)=0D
 =0D
         return ("", ver)=0D
@@ -1411,7 +1317,7 @@ class SphinxDependencyChecker(MissingCheckers):=0D
             return=0D
 =0D
         if self.latest_avail_ver:=0D
-            latest_avail_ver =3D ver_str(self.latest_avail_ver)=0D
+            latest_avail_ver =3D PythonVersion.ver_str(self.latest_avail_v=
er)=0D
 =0D
         if not self.need_sphinx:=0D
             # sphinx-build is present and its version is >=3D $min_version=
=0D
@@ -1507,7 +1413,7 @@ class SphinxDependencyChecker(MissingCheckers):=0D
         else:=0D
             print("Unknown OS")=0D
         if self.cur_version !=3D (0, 0, 0):=0D
-            ver =3D ver_str(self.cur_version)=0D
+            ver =3D PythonVersion.ver_str(self.cur_version)=0D
             print(f"Sphinx version: {ver}\n")=0D
 =0D
         # Check the type of virtual env, depending on Python version=0D
@@ -1613,7 +1519,7 @@ def main():=0D
 =0D
     checker =3D SphinxDependencyChecker(args)=0D
 =0D
-    checker.check_python()=0D
+    PythonVersion.check_python(MIN_PYTHON_VERSION)=0D
     checker.check_needs()=0D
 =0D
 # Call main if not used as module=0D
-- =0D
2.51.0=0D
=0D

