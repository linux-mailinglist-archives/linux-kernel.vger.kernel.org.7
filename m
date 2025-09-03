Return-Path: <linux-kernel+bounces-799003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74798B425C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA27956379C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DD2857F0;
	Wed,  3 Sep 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKMi0DJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E0285057;
	Wed,  3 Sep 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914301; cv=none; b=oKraLeLO6qY7Gpk4PaWxNlhj1zdVsZJLXz6tLDJiHbvCVWd59PHVBac5kHkDfDgCZk4Q2UOcJ31JLfuY554T8gBWKocqOsMkp3ZOWeSWapSY5V7adYUDCo3FFfGNIx121o8udk4UY91RQ5xMDxiAtr6/vypxBMS4/KFH2PisEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914301; c=relaxed/simple;
	bh=FBWucXdyWLLs836/YCptcNQxfVLAAZk1Il0uQKnptzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5zCV7mUry4bIWEJVQrT3/KdAzIkOvEHmOBFLFhYylyiyJBtkWuBieX9GpPJ0OMm7pDXUlFQ9PO+g6L38rd5Vagq88+snXkGgcXZ0wRjCwtocIn0xT3/HYu1veYCV+pSmsGZvuQVcjWy0/E6dRZW8Q4poqGaF9BPwBJ9jDqdaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKMi0DJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8AFC4CEF7;
	Wed,  3 Sep 2025 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914301;
	bh=FBWucXdyWLLs836/YCptcNQxfVLAAZk1Il0uQKnptzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKMi0DJqQI+p7ljivn/WK9A+PQYpv+F007yL8E9Sp2AKCRb/kTwQDBcmYSrz8Dqma
	 QXjzqDbbVOrHKKDFdAMGvw3ijum71EYXk27vpvbUQRIslVbfkrobVm6Suv4yXDO0RP
	 t4AqTTyAPehpNbeH1dEJaTSNyUvLB84QhpuP27snJlMGKxYNuxk8pkvgmcx/WD8w5P
	 I5xGqaaucIFZ9SI99PRAg04M6B7vEyaUrSlWrk9ALvpIrf/6Em0+lmueWkb37so8gB
	 nYH7kEeiknMS5j1eV6DFXwjKnmpK7pcDi6wtN60DacuzctCROFc0ykAoVh4tSreWMD
	 iTj71C6CdjsCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utpfP-00000007N6X-2Rz4;
	Wed, 03 Sep 2025 17:44:59 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/3] tools/docs: python_version: allow check for alternatives and bail out
Date: Wed,  3 Sep 2025 17:44:35 +0200
Message-ID: <a02a0e633b18af57106bd599c69b3540a9ecc468.1756913837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756913837.git.mchehab+huawei@kernel.org>
References: <cover.1756913837.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The caller script may not want an automatic execution of the new
version. Add two parameters to allow showing alternatives and to
bail out if version is incompatible.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/lib/python_version.py | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_version.py
index 660bfe7d23fa..e2e9f9a3d421 100644
--- a/tools/docs/lib/python_version.py
+++ b/tools/docs/lib/python_version.py
@@ -85,10 +85,12 @@ class PythonVersion:
         may need to update it one day, hopefully on a distant future.
         """
         patterns = [
-            "python3.[0-9]",
             "python3.[0-9][0-9]",
+            "python3.[0-9]",
         ]
 
+        python_cmd = []
+
         # Seek for a python binary newer than min_version
         for path in os.getenv("PATH", "").split(":"):
             for pattern in patterns:
@@ -96,12 +98,12 @@ class PythonVersion:
                     if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
                         version = PythonVersion.get_python_version(cmd)
                         if version >= min_version:
-                            return cmd
+                            python_cmd.append((version, cmd))
 
-        return None
+        return sorted(python_cmd, reverse=True)
 
     @staticmethod
-    def check_python(min_version):
+    def check_python(min_version, show_alternatives=False, bail_out=False):
         """
         Check if the current python binary satisfies our minimal requirement
         for Sphinx build. If not, re-run with a newer version if found.
@@ -113,18 +115,33 @@ class PythonVersion:
 
         python_ver = PythonVersion.ver_str(cur_ver)
 
-        new_python_cmd = PythonVersion.find_python(min_version)
-        if not new_python_cmd:
+        available_versions = PythonVersion.find_python(min_version)
+        if not available_versions:
             print(f"ERROR: Python version {python_ver} is not spported anymore\n")
             print("       Can't find a new version. This script may fail")
             return
 
-        # Restart script using the newer version
+        # Check possible alternatives
+        if available_versions:
+            new_python_cmd = available_versions[0][1]
+        else:
+            new_python_cmd = None
+
         script_path = os.path.abspath(sys.argv[0])
         args = [new_python_cmd, script_path] + sys.argv[1:]
 
+        if show_alternatives:
+            print("Available Python versions:")
+            for _, cmd in available_versions:
+                print(f"  {cmd}")
+            print()
+
+        if bail_out:
+            sys.exit(f"Python {python_ver} not supported. Bailing out")
+
         print(f"Python {python_ver} not supported. Changing to {new_python_cmd}")
 
+        # Restart script using the newer version
         try:
             os.execv(new_python_cmd, args)
         except OSError as e:
-- 
2.51.0


