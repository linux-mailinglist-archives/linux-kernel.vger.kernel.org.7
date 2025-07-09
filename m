Return-Path: <linux-kernel+bounces-723767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F3AFEADC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5D9546C31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E052E613F;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXJtMjxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D312D59E4;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=eoORsFl/V+1Oh350T7DBtCHRZRD+9hXi1084luubOOcPZrvWJ3adEHyFJEvrukIr+9jE2TdIiIN/YhUwyVHhb+lpAtkY+gtyxEdx3rbZS8gLJWYy8GoWHfzhjWeiTMvL9T3wlYvD4D1iE21yv4HB+d9ByRwQk5FR2dQR9jOxaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=FoKtf/c/yT5JEXk7gdX1daqHGqUOZCrT4NHefe9FPOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8D9wwQatzVH0JvNGjJbG7jY1kZuGwfrZXkNXz6xUxwM5RLUSnO49NcjmRSDtbPIBXNIout7SrtRwMxVNmDpW0H86bFZG6tAH3PoEKCiVy+N2iQK89iOzUrpntgbk4Ya9k7EZxinnULh6xSxpovktQjZDjZBcs9e00JFLbfndm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXJtMjxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B007C4CEF6;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=FoKtf/c/yT5JEXk7gdX1daqHGqUOZCrT4NHefe9FPOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXJtMjxoETigvjM0rkv6JUeq/6EB6RHT7c7AkcGPMlWVLWkrOlybAGGkltrM27AU+
	 oAkFCntn5xyInmfiT7PODYPSFLyFH8S6ZT0s6zJzD2Y8TWgHwNCwl4kPz6nIsEMIo0
	 dWBF/dXaT46GjDKdwUwB7L2sXUz7VtKYXq0hvGV0Shw+YkHmmd+LpEn6HW97pNslVI
	 32Opx51gzQa+a+inJKHOdQK1gD8JWYBURoAtO89AA5XqApCHUhNPtSwWbvbmv6q2n1
	 Dd89IcWQz/dMr0e3Ewj6U/d1AwgthsJ2dfR8ZSeNzPDE97Oq5/DvSlxeHsmwMRIbZ6
	 Q3T4U0q2t2zHA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECL-14G9;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/39] scripts: sphinx-pre-install: run on a supported version
Date: Wed,  9 Jul 2025 15:51:37 +0200
Message-ID: <31312cbc957e9379fd86d1c58174a407004bc054.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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
2.49.0


