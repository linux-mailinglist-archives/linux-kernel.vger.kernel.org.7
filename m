Return-Path: <linux-kernel+bounces-818575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F17B59393
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D196E1BC6FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391553090C6;
	Tue, 16 Sep 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHR3nvZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F43054E1;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018216; cv=none; b=m7Gqa7hbxuQMOCTFHqlkdIIDC9BxNGgU8pPG6AsOFPkDnqA6d97K9v2ph6or/rDTaDjtGOSxUWCTUYEVv/mQeGDgnVWglmv9t+eIVuKlnIkQMQJeaZMu77JU401epBcMu7EbmE/HBp7qYGiEBVCr1e/BveeuswNUQqGQuDYBXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018216; c=relaxed/simple;
	bh=fnTPEr295iKUMZRb112PItsVBFn7TVmO7VSK+qWICNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5EqtdzhfXD2w7NspNTziPWp4K5WcTCbQVM9OSlHcc9zI22fOixWOsacjqg4dZW54X4BPTP/aeO5JX19DcxTibzqvk/qKnjo9a/BUBoMtDcTRbmDkBbpz08S8hvBgfgaswLS0Aqygv+Tt8wUfclEJOfXXsbou1wrY75/A7jfIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHR3nvZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B5AC4CEEB;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018216;
	bh=fnTPEr295iKUMZRb112PItsVBFn7TVmO7VSK+qWICNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHR3nvZ3m+F5KGL98CuL/Dx5IPBljFgQuTUuUHVj75oGRVYQltzEpm45bG1ifm4XP
	 W3wrzX432834yVTTBc7c7/5DFLrQ9SJcbZIvpDOmyUV19VmqG6zD1kA8WcsHSqPC1i
	 ZNG2Cxc4hItLOolpjJRrOtQq7iKel73dPj/+XGlCd7uvBc7ZmwyeEuD4xm3wERdEtr
	 Om5XAQNM9Dh/Bx1VTaZG7hyJ6YmePOhR6FTHopT0iIhq0AkDE49bB93jwkHy7ia2fP
	 lkEAEXmW3iYES8CzoppIXed1CXhGIQI0r09PZDzNkiModGBGMpkDLZ2qdHK/2Xj9TV
	 SgwFZjfshXZPg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBP2-3PqL;
	Tue, 16 Sep 2025 12:23:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/21] tools/docs: python_version: move version check from sphinx-pre-install
Date: Tue, 16 Sep 2025 12:22:43 +0200
Message-ID: <91b4fdce958c8004c8e8637699eaf971181694bc.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The sphinx-pre-install code has some logic to deal with Python
version, which ensures that a minimal version will be enforced
for documentation build logic.

Move it to a separate library to allow re-using its code.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/lib/python_version.py | 133 +++++++++++++++++++++++++++++++
 tools/docs/sphinx-pre-install    | 120 +++-------------------------
 2 files changed, 146 insertions(+), 107 deletions(-)
 create mode 100644 tools/docs/lib/python_version.py

diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_version.py
new file mode 100644
index 000000000000..0519d524e547
--- /dev/null
+++ b/tools/docs/lib/python_version.py
@@ -0,0 +1,133 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2017-2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+"""
+Handle Python version check logic.
+
+Not all Python versions are supported by scripts. Yet, on some cases,
+like during documentation build, a newer version of python could be
+available.
+
+This class allows checking if the minimal requirements are followed.
+
+Better than that, PythonVersion.check_python() not only checks the minimal
+requirements, but it automatically switches to a the newest available
+Python version if present.
+
+"""
+
+import os
+import re
+import subprocess
+import sys
+
+from glob import glob
+
+class PythonVersion:
+    """
+    Ancillary methods that checks for missing dependencies for different
+    types of types, like binaries, python modules, rpm deps, etc.
+    """
+
+    def __init__(self, version):
+        """�nitialize self.version tuple from a version string"""
+        self.version = self.parse_version(version)
+
+    @staticmethod
+    def parse_version(version):
+        """Convert a major.minor.patch version into a tuple"""
+        return tuple(int(x) for x in version.split("."))
+
+    @staticmethod
+    def ver_str(version):
+        """Returns a version tuple as major.minor.patch"""
+        return ".".join([str(x) for x in version])
+
+    def __str__(self):
+        """Returns a version tuple as major.minor.patch from self.version"""
+        return self.ver_str(self.version)
+
+    @staticmethod
+    def get_python_version(cmd):
+        """
+        Get python version from a Python binary. As we need to detect if
+        are out there newer python binaries, we can't rely on sys.release here.
+        """
+
+        kwargs = {}
+        if sys.version_info < (3, 7):
+            kwargs['universal_newlines'] = True
+        else:
+            kwargs['text'] = True
+
+        result = subprocess.run([cmd, "--version"],
+                                stdout = subprocess.PIPE,
+                                stderr = subprocess.PIPE,
+                                **kwargs, check=False)
+
+        version = result.stdout.strip()
+
+        match = re.search(r"(\d+\.\d+\.\d+)", version)
+        if match:
+            return PythonVersion.parse_version(match.group(1))
+
+        print(f"Can't parse version {version}")
+        return (0, 0, 0)
+
+    @staticmethod
+    def find_python(min_version):
+        """
+        Detect if are out there any python 3.xy version newer than the
+        current one.
+
+        Note: this routine is limited to up to 2 digits for python3. We
+        may need to update it one day, hopefully on a distant future.
+        """
+        patterns = [
+            "python3.[0-9]",
+            "python3.[0-9][0-9]",
+        ]
+
+        # Seek for a python binary newer than min_version
+        for path in os.getenv("PATH", "").split(":"):
+            for pattern in patterns:
+                for cmd in glob(os.path.join(path, pattern)):
+                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
+                        version = PythonVersion.get_python_version(cmd)
+                        if version >= min_version:
+                            return cmd
+
+        return None
+
+    @staticmethod
+    def check_python(min_version):
+        """
+        Check if the current python binary satisfies our minimal requirement
+        for Sphinx build. If not, re-run with a newer version if found.
+        """
+        cur_ver = sys.version_info[:3]
+        if cur_ver >= min_version:
+            ver = PythonVersion.ver_str(cur_ver)
+            print(f"Python version: {ver}")
+
+            return
+
+        python_ver = PythonVersion.ver_str(cur_ver)
+
+        new_python_cmd = PythonVersion.find_python(min_version)
+        if not new_python_cmd:
+            print(f"ERROR: Python version {python_ver} is not spported anymore\n")
+            print("       Can't find a new version. This script may fail")
+            return
+
+        # Restart script using the newer version
+        script_path = os.path.abspath(sys.argv[0])
+        args = [new_python_cmd, script_path] + sys.argv[1:]
+
+        print(f"Python {python_ver} not supported. Changing to {new_python_cmd}")
+
+        try:
+            os.execv(new_python_cmd, args)
+        except OSError as e:
+            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index 954ed3dc0645..d6d673b7945c 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -32,20 +32,10 @@ import subprocess
 import sys
 from glob import glob
 
+from lib.python_version import PythonVersion
 
-def parse_version(version):
-    """Convert a major.minor.patch version into a tuple"""
-    return tuple(int(x) for x in version.split("."))
-
-
-def ver_str(version):
-    """Returns a version tuple as major.minor.patch"""
-
-    return ".".join([str(x) for x in version])
-
-
-RECOMMENDED_VERSION = parse_version("3.4.3")
-MIN_PYTHON_VERSION = parse_version("3.7")
+RECOMMENDED_VERSION = PythonVersion("3.4.3").version
+MIN_PYTHON_VERSION = PythonVersion("3.7").version
 
 
 class DepManager:
@@ -235,95 +225,11 @@ class AncillaryMethods:
 
         return None
 
-    @staticmethod
-    def get_python_version(cmd):
-        """
-        Get python version from a Python binary. As we need to detect if
-        are out there newer python binaries, we can't rely on sys.release here.
-        """
-
-        result = SphinxDependencyChecker.run([cmd, "--version"],
-                                            capture_output=True, text=True)
-        version = result.stdout.strip()
-
-        match = re.search(r"(\d+\.\d+\.\d+)", version)
-        if match:
-            return parse_version(match.group(1))
-
-        print(f"Can't parse version {version}")
-        return (0, 0, 0)
-
-    @staticmethod
-    def find_python():
-        """
-        Detect if are out there any python 3.xy version newer than the
-        current one.
-
-        Note: this routine is limited to up to 2 digits for python3. We
-        may need to update it one day, hopefully on a distant future.
-        """
-        patterns = [
-            "python3.[0-9]",
-            "python3.[0-9][0-9]",
-        ]
-
-        # Seek for a python binary newer than MIN_PYTHON_VERSION
-        for path in os.getenv("PATH", "").split(":"):
-            for pattern in patterns:
-                for cmd in glob(os.path.join(path, pattern)):
-                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
-                        version = SphinxDependencyChecker.get_python_version(cmd)
-                        if version >= MIN_PYTHON_VERSION:
-                            return cmd
-
-    @staticmethod
-    def check_python():
-        """
-        Check if the current python binary satisfies our minimal requirement
-        for Sphinx build. If not, re-run with a newer version if found.
-        """
-        cur_ver = sys.version_info[:3]
-        if cur_ver >= MIN_PYTHON_VERSION:
-            ver = ver_str(cur_ver)
-            print(f"Python version: {ver}")
-
-            # This could be useful for debugging purposes
-            if SphinxDependencyChecker.which("docutils"):
-                result = SphinxDependencyChecker.run(["docutils", "--version"],
-                                                    capture_output=True, text=True)
-                ver = result.stdout.strip()
-                match = re.search(r"(\d+\.\d+\.\d+)", ver)
-                if match:
-                    ver = match.group(1)
-
-                print(f"Docutils version: {ver}")
-
-            return
-
-        python_ver = ver_str(cur_ver)
-
-        new_python_cmd = SphinxDependencyChecker.find_python()
-        if not new_python_cmd:
-            print(f"ERROR: Python version {python_ver} is not spported anymore\n")
-            print("       Can't find a new version. This script may fail")
-            return
-
-        # Restart script using the newer version
-        script_path = os.path.abspath(sys.argv[0])
-        args = [new_python_cmd, script_path] + sys.argv[1:]
-
-        print(f"Python {python_ver} not supported. Changing to {new_python_cmd}")
-
-        try:
-            os.execv(new_python_cmd, args)
-        except OSError as e:
-            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
-
     @staticmethod
     def run(*args, **kwargs):
         """
         Excecute a command, hiding its output by default.
-        Preserve comatibility with older Python versions.
+        Preserve compatibility with older Python versions.
         """
 
         capture_output = kwargs.pop('capture_output', False)
@@ -527,11 +433,11 @@ class MissingCheckers(AncillaryMethods):
         for line in result.stdout.split("\n"):
             match = re.match(r"^sphinx-build\s+([\d\.]+)(?:\+(?:/[\da-f]+)|b\d+)?\s*$", line)
             if match:
-                return parse_version(match.group(1))
+                return PythonVersion.parse_version(match.group(1))
 
             match = re.match(r"^Sphinx.*\s+([\d\.]+)\s*$", line)
             if match:
-                return parse_version(match.group(1))
+                return PythonVersion.parse_version(match.group(1))
 
     def check_sphinx(self, conf):
         """
@@ -542,7 +448,7 @@ class MissingCheckers(AncillaryMethods):
                 for line in f:
                     match = re.match(r"^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]", line)
                     if match:
-                        self.min_version = parse_version(match.group(1))
+                        self.min_version = PythonVersion.parse_version(match.group(1))
                         break
         except IOError:
             sys.exit(f"Can't open {conf}")
@@ -562,8 +468,8 @@ class MissingCheckers(AncillaryMethods):
             sys.exit(f"{sphinx} didn't return its version")
 
         if self.cur_version < self.min_version:
-            curver = ver_str(self.cur_version)
-            minver = ver_str(self.min_version)
+            curver = PythonVersion.ver_str(self.cur_version)
+            minver = PythonVersion.ver_str(self.min_version)
 
             print(f"ERROR: Sphinx version is {curver}. It should be >= {minver}")
             self.need_sphinx = 1
@@ -1304,7 +1210,7 @@ class SphinxDependencyChecker(MissingCheckers):
             else:
                 if self.need_sphinx and ver >= self.min_version:
                     return (f, ver)
-                elif parse_version(ver) > self.cur_version:
+                elif PythonVersion.parse_version(ver) > self.cur_version:
                     return (f, ver)
 
         return ("", ver)
@@ -1411,7 +1317,7 @@ class SphinxDependencyChecker(MissingCheckers):
             return
 
         if self.latest_avail_ver:
-            latest_avail_ver = ver_str(self.latest_avail_ver)
+            latest_avail_ver = PythonVersion.ver_str(self.latest_avail_ver)
 
         if not self.need_sphinx:
             # sphinx-build is present and its version is >= $min_version
@@ -1507,7 +1413,7 @@ class SphinxDependencyChecker(MissingCheckers):
         else:
             print("Unknown OS")
         if self.cur_version != (0, 0, 0):
-            ver = ver_str(self.cur_version)
+            ver = PythonVersion.ver_str(self.cur_version)
             print(f"Sphinx version: {ver}\n")
 
         # Check the type of virtual env, depending on Python version
@@ -1613,7 +1519,7 @@ def main():
 
     checker = SphinxDependencyChecker(args)
 
-    checker.check_python()
+    PythonVersion.check_python(MIN_PYTHON_VERSION)
     checker.check_needs()
 
 # Call main if not used as module
-- 
2.51.0


