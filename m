Return-Path: <linux-kernel+bounces-765187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB0B22CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C872621DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB092FDC27;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut14kbE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D22F83AF;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=ZS8hkB2ab0SLyrHW9HFnFsu3klJ30qOOCkpDZ5b0n7/En6Fo11u+y+4j/+3bhDRh2+EU0Q931tUZzkHH/VugabDkzoLEwE9GwOjUu2BmKm9hT5VKj9ZPMhcUM6NWm5aXflSNO3ZoHkEgE2RzRKXR7TX36wa2i9+qo6+XlAPxLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=FbaXRUc/2LhlVOjM23W2WjLiwG7E6R+Z0hI5EFxslxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXG7di6ortikFRhUqiMjxDmg8RlX4+icT5U0dj4L1rT9AVmLQA4pOUtp3mCyY8A3hSSjzs+gaGl0eKl8exYS6uqDvndjER/rBShcF07OxhsV0L/UFGLSA9B9Oz3qS8q3j9r+F6mqxV4XjzbvtGEgXZ45Z2AL5DUuH9KlGBcXCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut14kbE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15A6C4AF18;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=FbaXRUc/2LhlVOjM23W2WjLiwG7E6R+Z0hI5EFxslxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ut14kbE/HQDAJ09VzDqQ6b7H8eSyNHa8Di/LEjowgNl57kFBjQx/xgBCnGX6aIiK/
	 HiYeE/isG0yA5YTMnSpQlv7Sph/l/TNFMKp4SzudH9yjr4F2KBAKlWjHgTs0XZPqkr
	 ZbDfsC0vSsCdvmipAkclB/1nZyZ+Z3F0r/ZRM6PiVCbXbxi7OBHFmsCK3HZCEmPMvi
	 2ucFNiQmU3FONNAcOkoLp7BHU9p5QRdoDnd1XvdvhMEySm9fnGQtP6YV1GCm11SEjI
	 tvBOI8Nso2NS70Ob43pWMovxwZlg6C+p17XGgV0rmZgVdDrwBrctd4EDD63VfCAxBh
	 5CEqN3/lTx/Aw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kX4-3p8W;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/39] scripts: sphinx-pre-install: move get_system_release()
Date: Tue, 12 Aug 2025 17:52:46 +0200
Message-ID: <4b42a85bbb6575bb34a58cf66019038c4afa1d5b.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


