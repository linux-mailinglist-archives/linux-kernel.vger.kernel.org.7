Return-Path: <linux-kernel+bounces-820643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1AB7D1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B73D174470
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9C330EDD;
	Wed, 17 Sep 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghikJ8NO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D9393DF1;
	Wed, 17 Sep 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111358; cv=none; b=E1OJcIDj5OnTs9K3up6feJm7GeZ6pOpK/x5LeX96OR+wOL7k0r0zxuE+d4jDCpZGiJj7PsdCs6NnfEBmyorJpO22mb+acrZU1ksk5lWky5P0/nrnw49QQO16ZPDpcjDmBsCv9WqALGsXVwhVpNyBFxpApxH8n2V6Wqhodd+3OU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111358; c=relaxed/simple;
	bh=+6TvP4G2cDhLKPN/soKTsxtFrnu65L1eQKi7+8h+GhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQiezdJhy6JmcIsnmehTkLNpY58Ndkd1/cQxvPpQMFgHb0Q60hcz3ygq6gk8YjWUlHY3X1chpszGmebSmtLu1uMUBdz8rre/bcPurofnQXBaH6Io837x1OwhKd491AysvoRu8iGQyPG/A2cJ3msm+eOuUATt8lL/INxorRTBMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghikJ8NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF4C4CEFA;
	Wed, 17 Sep 2025 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111358;
	bh=+6TvP4G2cDhLKPN/soKTsxtFrnu65L1eQKi7+8h+GhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghikJ8NOjsQIFxBgoQW6Vu23pH614OFo/RrSiFtqYzlStrR/RkWxOJrwQultaX2mS
	 GeR8hAIkzqbtrsEQpxyTQ4LknCeey2q/QRQdgORCktxpO+24Q4RPFhRfO6UPyk/llh
	 Hb2SuzZ4+l+yKqg0e4XWhhcdhkzD+lvoq4/62HWAqplto2N/vLybtTXcuAWhvw2WgI
	 zcfWLUZO3VkQep1EqwgBFGEzm+MmI+lB9fqtPc7d4nAV7MtgD6z+8wZ3sPE4IM1FMC
	 q1YnJoh4DMbyQqcg2KsYEWUu5ibAZf/1A4HtBczcmrwISS1/MKAcfPTilMNJASgEon
	 TLWakWufRiCuw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGdk-19ZW;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/24] tools/docs: sphinx-pre-install: allow check for alternatives and bail out
Date: Wed, 17 Sep 2025 14:15:03 +0200
Message-ID: <7d5855d9649bb928369b885b5c1e733197f3140f.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-pre-install | 48 +++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index fa12e01fc7fe..895220c6d4f8 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -254,7 +254,7 @@ class AncillaryMethods:
         return (0, 0, 0)
 
     @staticmethod
-    def find_python():
+    def find_python(min_version):
         """
         Detect if are out there any python 3.xy version newer than the
         current one.
@@ -263,21 +263,25 @@ class AncillaryMethods:
         may need to update it one day, hopefully on a distant future.
         """
         patterns = [
-            "python3.[0-9]",
             "python3.[0-9][0-9]",
+            "python3.[0-9]",
         ]
 
         # Seek for a python binary newer than MIN_PYTHON_VERSION
+        python_cmd = []
         for path in os.getenv("PATH", "").split(":"):
             for pattern in patterns:
                 for cmd in glob(os.path.join(path, pattern)):
                     if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
                         version = SphinxDependencyChecker.get_python_version(cmd)
-                        if version >= MIN_PYTHON_VERSION:
-                            return cmd
+                        if version >= min_version:
+                            python_cmd.append((version, cmd))
+
+        return sorted(python_cmd, reverse=True)
 
     @staticmethod
-    def check_python():
+    def check_python(min_version, show_alternatives=False, bail_out=False,
+                     success_on_error=False):
         """
         Check if the current python binary satisfies our minimal requirement
         for Sphinx build. If not, re-run with a newer version if found.
@@ -301,18 +305,42 @@ class AncillaryMethods:
 
         python_ver = ver_str(cur_ver)
 
-        new_python_cmd = SphinxDependencyChecker.find_python()
-        if not new_python_cmd:
+        available_versions = SphinxDependencyChecker.find_python(min_version)
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
@@ -1612,7 +1640,7 @@ def main():
 
     checker = SphinxDependencyChecker(args)
 
-    checker.check_python()
+    checker.check_python(MIN_PYTHON_VERSION)
     checker.check_needs()
 
 # Call main if not used as module
-- 
2.51.0


