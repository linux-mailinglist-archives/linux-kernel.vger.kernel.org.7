Return-Path: <linux-kernel+bounces-723802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A013AFEB22
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D105664F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756B2ED86E;
	Wed,  9 Jul 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqF6ZGnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13D2E6D0A;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=JvN4b3LoAZ3/4yzF5v51114W2li8aFeiDVYVi7TnIe2TMtajY0QcVwIMq+kB45TcdHiWmIbWpYSshc6+WtWbLMjTMYdFFLoIjaLthKXHUOY/uEKsQfSW7mhkugHovh7CPAK9RPSXJDf6Y5C/VZig0mkrGQX7Ty16fJV8AlVlwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=k07T+F39In0bF6GHHTnnGiCYiH8jJBwsGqiEHYdTlR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAj/cSQ/tB/44dMFMBEvsVsBdme4nwR0jleTw2OCWtLslVbwP4BgjN1yNj3WadZaDydBOHtOPxELAnTIpY0oie6nUL1WoU6QYeedJyivTYYW08xMx3ErY0jlxOXi+h/KvMO8zOk+8bBb0MK0aiq33dIypre8ZWJj4PwD49Jfi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqF6ZGnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C83C116D0;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=k07T+F39In0bF6GHHTnnGiCYiH8jJBwsGqiEHYdTlR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqF6ZGnjQ//5C9N/SIXj4MbRo98/RKIqu3V4asAw4rlaxhwa60YqdL7Wj9zVtIRYV
	 WqlhtHvUpaJ0LOwT4tIm/MRrlkchbGALRtSub59CLNiI+1GcwDY+daoD/fp1Wr9K06
	 RJwOYuIROALQhJum2weSSWb/owWVKbwhLue2ByYmBzFvPBI8wBpVZvrW7c4VB0ZLbN
	 JV9WMTW1ftYCmAXeXfpGofQgl/zeZ1tu1xMqrVORZ/bCJNhU6jc0ql7Im5pT8V7eKy
	 R0S1IfYaHPj2NwxxDQVwR5sFpRISDGAhwFHsdDUOOQhCZ/Nk+NNncoBSr3qp6louvW
	 koM/LLFJPSybA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDV-35dz;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/39] scripts: sphinx-pre-install: move get_system_release()
Date: Wed,  9 Jul 2025 15:52:01 +0200
Message-ID: <36abd1990595a79d6a6d479d80fe29f981d1ca26.1752067814.git.mchehab+huawei@kernel.org>
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

The code at get_system_release() is actually a helper function,
independent from the actual Sphinx verification checker. Move
it to MissingCheckers class, where other checkers are present.

With that, the entire distro-specific handler logic, with
all its complexity is confined at SphinxDependencyChecker
class.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 115 +++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 9127487bd4d7..593982f350b3 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -456,6 +456,64 @@ class MissingCheckers(AncillaryMethods):
 
         return True
 
+    def get_system_release(self):
+        """
+        Determine the system type. There's no unique way that would work
+        with all distros with a minimal package install. So, several
+        methods are used here.
+
+        By default, it will use lsb_release function. If not available, it will
+        fail back to reading the known different places where the distro name
+        is stored.
+
+        Several modern distros now have /etc/os-release, which usually have
+        a decent coverage.
+        """
+
+        system_release = ""
+
+        if self.which("lsb_release"):
+            result = self.run(["lsb_release", "-d"], capture_output=True, text=True)
+            system_release = result.stdout.replace("Description:", "").strip()
+
+        release_files = [
+            "/etc/system-release",
+            "/etc/redhat-release",
+            "/etc/lsb-release",
+            "/etc/gentoo-release",
+        ]
+
+        if not system_release:
+            for f in release_files:
+                system_release = self.catcheck(f)
+                if system_release:
+                    break
+
+        # This seems more common than LSB these days
+        if not system_release:
+            os_var = {}
+            try:
+                with open("/etc/os-release", "r", encoding="utf-8") as f:
+                    for line in f:
+                        match = re.match(r"^([\w\d\_]+)=\"?([^\"]*)\"?\n", line)
+                        if match:
+                            os_var[match.group(1)] = match.group(2)
+
+                system_release = os_var.get("NAME", "")
+                if "VERSION_ID" in os_var:
+                    system_release += " " + os_var["VERSION_ID"]
+                elif "VERSION" in os_var:
+                    system_release += " " + os_var["VERSION"]
+            except IOError:
+                pass
+
+        if not system_release:
+            system_release = self.catcheck("/etc/issue")
+
+        system_release = system_release.strip()
+
+        return system_release
+
 class SphinxDependencyChecker(MissingCheckers):
 
     def __init__(self, args):
@@ -499,7 +557,7 @@ class SphinxDependencyChecker(MissingCheckers):
         self.need_pip = 0
         self.rec_sphinx_upgrade = 0
 
-        self.system_release = ""
+        self.system_release = self.get_system_release()
         self.python_cmd = ""
         self.activate_cmd = ""
 
@@ -1193,7 +1251,6 @@ class SphinxDependencyChecker(MissingCheckers):
               "\thttps://github.com/sphinx-doc/sphinx/pull/8313")
 
     def check_needs(self):
-        self.get_system_release()
         self.python_cmd = sys.executable
 
         # Check if Sphinx is already accessible from current environment
@@ -1270,60 +1327,6 @@ class SphinxDependencyChecker(MissingCheckers):
 
         print("Needed package dependencies are met.")
 
-    def get_system_release(self):
-        """
-        Determine the system type. There's no unique way that would work
-        with all distros with a minimal package install. So, several
-        methods are used here.
-
-        By default, it will use lsb_release function. If not available, it will
-        fail back to reading the known different places where the distro name
-        is stored.
-
-        Several modern distros now have /etc/os-release, which usually have
-        a decent coverage.
-        """
-
-        if self.which("lsb_release"):
-            result = self.run(["lsb_release", "-d"], capture_output=True, text=True)
-            self.system_release = result.stdout.replace("Description:", "").strip()
-
-        release_files = [
-            "/etc/system-release",
-            "/etc/redhat-release",
-            "/etc/lsb-release",
-            "/etc/gentoo-release",
-        ]
-
-        if not self.system_release:
-            for f in release_files:
-                self.system_release = self.catcheck(f)
-                if self.system_release:
-                    break
-
-        # This seems more common than LSB these days
-        if not self.system_release:
-            os_var = {}
-            try:
-                with open("/etc/os-release", "r", encoding="utf-8") as f:
-                    for line in f:
-                        match = re.match(r"^([\w\d\_]+)=\"?([^\"]*)\"?\n", line)
-                        if match:
-                            os_var[match.group(1)] = match.group(2)
-
-                self.system_release = os_var.get("NAME", "")
-                if "VERSION_ID" in os_var:
-                    self.system_release += " " + os_var["VERSION_ID"]
-                elif "VERSION" in os_var:
-                    self.system_release += " " + os_var["VERSION"]
-            except IOError:
-                pass
-
-        if not self.system_release:
-            self.system_release = self.catcheck("/etc/issue")
-
-        self.system_release = self.system_release.strip()
-
 DESCRIPTION = """
 Process some flags related to Sphinx installation and documentation build.
 """
-- 
2.49.0


