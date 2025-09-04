Return-Path: <linux-kernel+bounces-800157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75BB43432
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D306874DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10532C0274;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpX7gU/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24642BE041;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=a9Dp5DcFOWOKXoT1+ZtqcSJzksEhIoZLucR/6xp10XZHyHW85KjFJnM2+WMl5gvzxikF7Y1EMyzkoB6sU39cAJw/Ok59Kaku55BByNkZbe5pK5MGIJ9GDpyGHMzoNelheZaXqFaFAA2k4QcFfY2aPWbCdp5hbxCPpo1g/a1L4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=GdJwj3d3TAyo2Nn7d6rWe+07TNA7IyqQabnELNUF9QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2dDwk0iBnS/AYL94dCWAledmF1v+IN2CW2/y7KbkOFwAdrdUfyoa/1IKHCHc4uNkifslxjATL6u9fcFEvC1dPUKaY8MyLcB9990sWnv9bu5BsWluBWTjGoHzaU1xQcazDqyX2yeRRJ/cqiT5feALOrRoD+J4jwdktiJeQ8lq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpX7gU/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D2DC4CEF9;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=GdJwj3d3TAyo2Nn7d6rWe+07TNA7IyqQabnELNUF9QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpX7gU/PnwgjnFUJJFz5XQmgz2Gmw+nTFuSUrXWFDumuqWaoMFhSGwz+HLusBw4+g
	 Wee2pJRG3UXkdqfY+if9lfmTWUsk7XCwOm7S0HQFni4Gx5g8iOHa02OncqpiGbJUVU
	 XBiRUAzThvMUuxbnNGXTU92+HnLoKtYL5vqRVkTZvwo5le7pg5nEJNxGgGMS+ANuXJ
	 oNEp69EUVr0DQvfMd70uXflRsflAPdJEPCEF4sGpNuxfjaWYOFFbyvZVPf12jx/mcq
	 +5k65Yk4v9lWQmh+w6B3rz0dMMOi/0URbYdEhJ420+pSczJnipvMeu5PVAudyVDNfi
	 ayJDft+dT/yGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPX-3XpJ;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/19] tools/docs: python_version: allow check for alternatives and bail out
Date: Thu,  4 Sep 2025 09:33:07 +0200
Message-ID: <71e8254ce711754b64e9bcb864c4886a1a970e7f.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
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
 tools/docs/lib/python_version.py | 43 ++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_version.py
index 660bfe7d23fa..a9fda2470a26 100644
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
@@ -96,12 +98,13 @@ class PythonVersion:
                     if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
                         version = PythonVersion.get_python_version(cmd)
                         if version >= min_version:
-                            return cmd
+                            python_cmd.append((version, cmd))
 
-        return None
+        return sorted(python_cmd, reverse=True)
 
     @staticmethod
-    def check_python(min_version):
+    def check_python(min_version, show_alternatives=False, bail_out=False,
+                     success_on_error=False):
         """
         Check if the current python binary satisfies our minimal requirement
         for Sphinx build. If not, re-run with a newer version if found.
@@ -113,18 +116,42 @@ class PythonVersion:
 
         python_ver = PythonVersion.ver_str(cur_ver)
 
-        new_python_cmd = PythonVersion.find_python(min_version)
-        if not new_python_cmd:
+        available_versions = PythonVersion.find_python(min_version)
+        if not available_versions:
             print(f"ERROR: Python version {python_ver} is not spported anymore\n")
             print("       Can't find a new version. This script may fail")
             return
 
-        # Restart script using the newer version
         script_path = os.path.abspath(sys.argv[0])
-        args = [new_python_cmd, script_path] + sys.argv[1:]
+
+        # Check possible alternatives
+        if available_versions:
+            new_python_cmd = available_versions[0][1]
+        else:
+            new_python_cmd = None
+
+        if show_alternatives:
+            print("You could run, instead:")
+            for _, cmd in available_versions:
+                args = [cmd, script_path] + sys.argv[1:]
+
+                cmd_str = " ".join(args)
+                print(f"  {cmd_str}")
+            print()
+
+        if bail_out:
+            msg = f"Python {python_ver} not supported. Bailing out"
+            if success_on_error:
+                print(msg, file=sys.stderr)
+                sys.exit(0)
+            else:
+                sys.exit(msg)
 
         print(f"Python {python_ver} not supported. Changing to {new_python_cmd}")
 
+        # Restart script using the newer version
+        args = [new_python_cmd, script_path] + sys.argv[1:]
+
         try:
             os.execv(new_python_cmd, args)
         except OSError as e:
-- 
2.51.0


