Return-Path: <linux-kernel+bounces-765168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D13B22C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B02621F60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EE2FA81A;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkYLY/qq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704A2F6592;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=ijBWPhEXx1Vz+Il7V8aT9+J57CEU6gsj4DwIaoyx+qfDRyCTtswLHlz+SrOn58QgbBMlM2aY7rTvYWX81NZHncFHbzWg+UPCVNQ1pKId91LmCswVmCE+sLBtQNclb4US7yApVzo7kpZ2mcy70llKOwB6vmIY4atrPyO5BlzaoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=xnQ6IjOnGM/7IpW6FAxRYORGqrWYSQqxyC/SU5roPxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcp/D4YxXa7aHNpGuWHD0QJED5QyiZKgBuKxOEVLqqwQncprXpyXHuFukZjkX9D0LsCTH95BoxOKoekuG3ZHHCx2V6KtgYHwHgs2z47DhbovjNt4a/4/t5rFUsWgphFbwVgSKElu8wAz2/TVkWejr7hibASHfBM02SlIBaHSSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkYLY/qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0B6C4CEFF;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=xnQ6IjOnGM/7IpW6FAxRYORGqrWYSQqxyC/SU5roPxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkYLY/qqDhry6CyCAPVo9mPlJfps2zuZr/Ut5NPCengna0/SEhEWEejOdaCmPdBSU
	 eZqs7Rk2LE7BmbVf+f4ukyLhHcjHGFajJlFWaDcDWkrbru+TMZnP5i9mGnjqNWcm4T
	 JOI4/qAZX60g/yHpnOlwrxJVoA0E9mx+X0Y7Q21O/F+091pPL5wobxz0iMrXJHBuhs
	 XtAsluJc4GFiSzI/pqM53mTmkR7wb40ONzq31sYRwH8AmQucAVzTT0btzRwKlekpH/
	 mmthccgbHaxLWMj4IJC1t1I055vS6c33ldgldHEHbLkanpaygKSEYzyn9ywPKFqi0b
	 he+0Fn2R85ePg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVW-0rGl;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/39] scripts: sphinx-pre-install: run on a supported version
Date: Tue, 12 Aug 2025 17:52:22 +0200
Message-ID: <76627055a7f82f6a79296ddbd873fa5ac8f82a1d.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The scripts/sphinx-pre-install is used to detect problems at
the system environment and adjust it to build the Kernel
documentation. If the version is too old, it won't run, though.

Check if the version which started the script is valid. If not,
seek for a new one that is compatible with documentation
build.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 65 ++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 71d86b230b22..3912359d2bae 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -5,6 +5,9 @@
 # pylint: disable=C0103,C0114,C0115,C0116,C0301
 # pylint: disable=R0902,R0904,R0912,R0915,R1705,R1710,E1121
 
+# Note: this script requires at least Python 3.6 to run.
+# Don't add changes not compatible with it, it is meant to report
+# incompatible python versions.
 
 import argparse
 import os
@@ -16,7 +19,6 @@ from glob import glob
 
 def parse_version(version):
     """Convert a major.minor.patch version into a tuple"""
-#
     return tuple(int(x) for x in version.split("."))
 
 
@@ -27,6 +29,7 @@ def ver_str(version):
 
 
 RECOMMENDED_VERSION = parse_version("3.4.3")
+MIN_PYTHON_VERSION = parse_version("3.7")
 
 
 class SphinxDependencyChecker:
@@ -132,6 +135,65 @@ class SphinxDependencyChecker:
         # Python not found at the PATH
         return python_names[-1]
 
+    @staticmethod
+    def get_python_version(cmd):
+
+        result = SphinxDependencyChecker.run([cmd, "--version"],
+                                            capture_output=True, text=True)
+        version = result.stdout.strip()
+
+        match = re.search(r"(\d+\.\d+\.\d+)", version)
+        if match:
+            return parse_version(match.group(1))
+
+        print(f"Can't parse version {version}")
+        return (0, 0, 0)
+
+    @staticmethod
+    def find_python():
+
+        patterns = [
+            "python3.[0-9]",
+            "python3.[0-9][0-9]",
+        ]
+
+        new_python_cmd = None
+
+        # Seek for a python binary newer than MIN_PYTHON_VERSION
+        for path in os.getenv("PATH", "").split(":"):
+            for pattern in patterns:
+                for cmd in glob(os.path.join(path, pattern)):
+                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
+                        version = SphinxDependencyChecker.get_python_version(cmd)
+                        if version >= MIN_PYTHON_VERSION:
+                            return(cmd)
+
+    @staticmethod
+    def check_python():
+
+        cur_ver = sys.version_info[:3]
+        if cur_ver >= MIN_PYTHON_VERSION:
+            return
+
+        python_ver = ver_str(cur_ver)
+
+        new_python_cmd = SphinxDependencyChecker.find_python()
+        if not new_python_cmd:
+            print(f"ERROR: Python version {python_ver} is not spported anymore")
+            print(f"       Can't find a new version. This script may fail")
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
+
     @staticmethod
     def run(*args, **kwargs):
         """Excecute a command, hiding its output by default"""
@@ -1107,6 +1169,7 @@ def main():
 
     checker = SphinxDependencyChecker(args)
 
+    checker.check_python()
     checker.check_needs()
 
 
-- 
2.50.1


