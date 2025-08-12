Return-Path: <linux-kernel+bounces-765193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E90B22C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506B350840E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4318C2FDC4C;
	Tue, 12 Aug 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6dIQV36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF92F83C6;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=nK/Q7MAvDTHLLmGNXFFDOnRlII21DUprQKpwqOBVcNAmsXjYecStHB7+D9x77UsN0W0xd1vtsHSRaHBdFL4HixVlJ1padz/LWXxsDu3M+lT9RW8HtRdP5r7DQL5PYEU4N3u9Qp1BuhRtsOqqdGL3b9cpcGt9fk6BE3Fk/shuumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=EfKmBy4QIHSzGscGS5Y8OctZQzKZJ5DYq4JstfRaNUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVTgU2ZmCeE2xsVKq2I9XJ7bgW1+sqNjhB8Jm6XynXrJdMSagen3cy5kUM5kqgKGKHeBYYbgN0d4Bm50cZqhGpDrLgyjvEyK3CcYqgaOLvChBumk5Vr/qrGtCuE3zeVVy/dUVkSSgWX5L9hP0Vcg36KkMOWl/nrLTjfKFEUxV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6dIQV36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D13C2BCAF;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=EfKmBy4QIHSzGscGS5Y8OctZQzKZJ5DYq4JstfRaNUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6dIQV36U7+hp935zIBXvRB9oYiU62/WJCsd8Q4IEeqMF3Dj9adcK8oDaUK+p3FKz
	 Z/YpG0IkffbL94H510pdfQlyLm2xin2tiSVgwOVBVy4T+oZCpYltLEIgV8PDWvthwM
	 RcT1VTD1GcHE3jbtrnHXzwW8APRfAzx7pqdC2+XAY3mxPRnxl0T0o/C8wAqN1Kl4H8
	 CV6uhmdH6L+vKzveWd74U2TwhVpu1/hGw6JmkFwuSwaMXxt8Iwfehs9VD6mt6XfUta
	 ssPFB1g6QwRke09mib1bQZRkT8WSuZl7Wp7/Ds18wwfkSbqBppHeST/YYV2T59aFpc
	 8r6SLmi3lZcmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ9-00000006kXK-07sO;
	Tue, 12 Aug 2025 17:53:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/39] scripts: sphinx-pre-install: rework install command logic
Date: Tue, 12 Aug 2025 17:52:50 +0200
Message-ID: <a6120449d9cc14346e867d1ef8944ae28ddbf3f6.1754992972.git.mchehab+huawei@kernel.org>
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

Cleanup the code to remove some redundancy and to let it be
clearer about the command install instructions.

Ensure that special instructions will be shown only once,
before the actual install command.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 179 ++++++++++++++++------------------
 1 file changed, 82 insertions(+), 97 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 1b11162da9fb..7dfe5c2a6cc2 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -213,7 +213,7 @@ class DepManager:
                 raise KeyError(f"ERROR!!!: invalid dtype for {progs}: {dtype}")
 
         if output_msg:
-            print(f"\n{output_msg}\n")
+            print(f"\n{output_msg}")
 
 class AncillaryMethods:
     """
@@ -583,23 +583,6 @@ class MissingCheckers(AncillaryMethods):
                 return f.read().strip()
         return ""
 
-    def check_missing(self, progs):
-        """
-        Check for missing dependencies using the provided program mapping.
-
-        The actual distro-specific programs are mapped via progs argument.
-
-        Returns True if there are missing dependencies, False otherwise.
-        """
-        self.install += self.deps.check_missing(progs)
-        if self.verbose_warn_install:
-            self.deps.warn_install()
-
-        if not self.deps.need and not self.deps.optional:
-            return False
-
-        return True
-
     def get_system_release(self):
         """
         Determine the system type. There's no unique way that would work
@@ -722,7 +705,7 @@ class SphinxDependencyChecker(MissingCheckers):
         self.recommend_python = None
 
         # Certain hints are meant to be shown only once
-        self.first_hint = True
+        self.distro_msg = None
 
         self.latest_avail_ver = (0, 0, 0)
         self.venv_ver = (0, 0, 0)
@@ -732,6 +715,33 @@ class SphinxDependencyChecker(MissingCheckers):
         self.conf = prefix + "Documentation/conf.py"
         self.requirement_file = prefix + "Documentation/sphinx/requirements.txt"
 
+    def get_install_progs(self, progs, cmd, extra=None):
+        """
+        Check for missing dependencies using the provided program mapping.
+
+        The actual distro-specific programs are mapped via progs argument.
+        """
+        install = self.deps.check_missing(progs)
+
+        if self.verbose_warn_install:
+            self.deps.warn_install()
+
+        if not install:
+            return
+
+        if cmd:
+            if self.verbose_warn_install:
+                msg = "You should run:"
+            else:
+                msg = ""
+
+            if extra:
+                msg += "\n\t" + extra.replace("\n", "\n\t")
+
+            return(msg + "\n\tsudo " + cmd + " " + install)
+
+        return None
+
     #
     # Distro-specific hints methods
     #
@@ -772,12 +782,7 @@ class SphinxDependencyChecker(MissingCheckers):
 
             self.check_program("dvipng", DepManager.PDF_MANDATORY)
 
-        if self.check_missing(progs):
-            return
-
-        if self.verbose_warn_install:
-            print("You should run:")
-        print(f"\n\tsudo apt-get install {self.install}")
+        return self.get_install_progs(progs, "apt-get install")
 
     def give_redhat_hints(self):
         """
@@ -838,18 +843,16 @@ class SphinxDependencyChecker(MissingCheckers):
                 self.deps.add_package("python39", DepManager.SYSTEM_MANDATORY)
                 self.recommend_python = True
 
-            if self.first_hint:
-                print("Note: RHEL-based distros typically require extra repositories.\n" \
-                      "For most, enabling epel and crb are enough:\n" \
-                      "\tsudo dnf install -y epel-release", \
-                      "\tsudo dnf config-manager --set-enabled crb\n" \
-                      "Yet, some may have other required repositories. Those commands could be useful:\n" \
-                      "\tsudo dnf repolist all\n" \
-                      "\tsudo dnf repoquery --available --info <pkgs>\n",
-                      "\tsudo dnf config-manager --set-enabled '*' # enable all - probably not what you want")
-
-                self.first_hint = False
-
+            if not self.distro_msg:
+                self.distro_msg = \
+                    "Note: RHEL-based distros typically require extra repositories.\n" \
+                    "For most, enabling epel and crb are enough:\n" \
+                    "\tsudo dnf install -y epel-release\n" \
+                    "\tsudo dnf config-manager --set-enabled crb\n" \
+                    "Yet, some may have other required repositories. Those commands could be useful:\n" \
+                    "\tsudo dnf repolist all\n" \
+                    "\tsudo dnf repoquery --available --info <pkgs>\n" \
+                    "\tsudo dnf config-manager --set-enabled '*' # enable all - probably not what you want"
 
         if self.pdf:
             pdf_pkgs = [
@@ -868,13 +871,7 @@ class SphinxDependencyChecker(MissingCheckers):
             if not fedora and rel == 8:
                 self.deps.del_package("texlive-ctex")
 
-        if self.check_missing(progs):
-            return
-
-        if self.verbose_warn_install:
-            print("You should run:")
-
-        print(f"\n\tsudo dnf install -y {self.install}")
+        return self.get_install_progs(progs, "dnf install")
 
     def give_opensuse_hints(self):
         """
@@ -945,12 +942,7 @@ class SphinxDependencyChecker(MissingCheckers):
         if self.pdf:
             self.check_missing_tex()
 
-        if self.check_missing(progs):
-            return
-
-        if self.verbose_warn_install:
-            print("You should run:")
-        print(f"\n\tsudo zypper install --no-recommends {self.install}")
+        return self.get_install_progs(progs, "zypper install --no-recommends")
 
     def give_mageia_hints(self):
         """
@@ -995,12 +987,7 @@ class SphinxDependencyChecker(MissingCheckers):
             self.check_missing_file(pdf_pkgs, noto_sans, DepManager.PDF_MANDATORY)
             self.check_rpm_missing(tex_pkgs, DepManager.PDF_MANDATORY)
 
-        if self.check_missing(progs):
-            return
-
-        if self.verbose_warn_install:
-            print("You should run:")
-        print(f"\n\tsudo {packager_cmd} {self.install}")
+        return self.get_install_progs(progs, packager_cmd)
 
     def give_arch_linux_hints(self):
         """
@@ -1023,20 +1010,15 @@ class SphinxDependencyChecker(MissingCheckers):
         ]
 
         if self.pdf:
-            self.check_pacman_missing(archlinux_tex_pkgs, DepManager.PDF_MANDATORY)
+            self.check_pacman_missing(archlinux_tex_pkgs,
+                                      DepManager.PDF_MANDATORY)
 
-            self.check_missing_file(
-                ["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
-                "noto-fonts-cjk",
-                2,
-            )
+            self.check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
+                                    "noto-fonts-cjk",
+                                    DepManager.PDF_MANDATORY)
 
-        if self.check_missing(progs):
-            return
 
-        if self.verbose_warn_install:
-            print("You should run:")
-        print(f"\n\tsudo pacman -S {self.install}")
+        return self.get_install_progs(progs, "pacman -S")
 
     def give_gentoo_hints(self):
         """
@@ -1065,13 +1047,6 @@ class SphinxDependencyChecker(MissingCheckers):
             for package, files in pdf_pkgs.items():
                 self.check_missing_file(files, package, DepManager.PDF_MANDATORY)
 
-        if self.check_missing(progs):
-            return
-
-        if self.verbose_warn_install:
-            print("You should run:")
-        print("\n")
-
         # Handling dependencies is a nightmare, as Gentoo refuses to emerge
         # some packages if there's no package.use file describing them.
         # To make it worse, compilation flags shall also be present there
@@ -1104,7 +1079,10 @@ class SphinxDependencyChecker(MissingCheckers):
             "zziblib": "dev-libs/zziplib sdl",
         }
 
-        if self.first_hint:
+        extra_cmds = ""
+        if not self.distro_msg:
+            self.distro_msg = "Note: Gentoo requires package.use to be adjusted before emerging packages"
+
             use_base = "/etc/portage/package.use"
             files = glob(f"{use_base}/*")
 
@@ -1148,23 +1126,23 @@ class SphinxDependencyChecker(MissingCheckers):
 
                 # emit a code to setup missing USE
                 if install:
-                    print(f"\tsudo su -c 'echo \"{portage}\" > {use_base}/{fname}'")
-
-            self.first_hint = False
+                    extra_cmds += (f"sudo su -c 'echo \"{portage}\" > {use_base}/{fname}'\n")
 
         # Now, we can use emerge and let it respect USE
-        print(f"\tsudo emerge --ask --changed-use --binpkg-respect-use=y {self.install}")
+        return self.get_install_progs(progs,
+                                      "emerge --ask --changed-use --binpkg-respect-use=y",
+                                      extra_cmds)
 
-    #
-    # Dispatch the check to an os_specific hinter
-    #
-
-    def check_distros(self):
+    def get_install(self):
         """
-        OS-specific hints logic. Seeks for a hinter. If found, provide
-        package-manager-specific install commands.
+        OS-specific hints logic. Seeks for a hinter. If found, use it to
+        provide package-manager specific install commands.
 
-        Otherwise, just lists the missing dependencies.
+        Otherwise, outputs install instructions for the meta-packages.
+
+        Returns a string with the command to be executed to install the
+        the needed packages, if distro found. Otherwise, return just a
+        list of packages that require installation.
         """
         os_hints = {
             re.compile("Red Hat Enterprise Linux"):   self.give_redhat_hints,
@@ -1195,9 +1173,7 @@ class SphinxDependencyChecker(MissingCheckers):
         # If the OS is detected, use per-OS hint logic
         for regex, os_hint in os_hints.items():
             if regex.search(self.system_release):
-                os_hint()
-
-                return
+                return os_hint()
 
         #
         # Fall-back to generic hint code for other distros
@@ -1207,11 +1183,12 @@ class SphinxDependencyChecker(MissingCheckers):
         if self.pdf:
             self.check_missing_tex()
 
-        self.check_missing(progs)
+        self.distro_msg = \
+            f"I don't know distro {self.system_release}.\n" \
+            "So, I can't provide you a hint with the install procedure.\n" \
+            "There are likely missing dependencies.\n"
 
-        print(f"I don't know distro {self.system_release}.")
-        print("So, I can't provide you a hint with the install procedure.")
-        print("There are likely missing dependencies.")
+        return self.get_install_progs(progs, None)
 
     #
     # Common dependencies
@@ -1336,7 +1313,6 @@ class SphinxDependencyChecker(MissingCheckers):
 
         self.pdf = False
         self.deps.optional = 0
-        self.install = ""
         old_verbose = self.verbose_warn_install
         self.verbose_warn_install = 0
 
@@ -1344,7 +1320,9 @@ class SphinxDependencyChecker(MissingCheckers):
 
         self.deps.add_package("python-sphinx", DepManager.PYTHON_MANDATORY)
 
-        self.check_distros()
+        cmd = self.get_install()
+        if cmd:
+            print(cmd)
 
         self.deps.need = old_need
         self.deps.optional = old_optional
@@ -1511,7 +1489,14 @@ class SphinxDependencyChecker(MissingCheckers):
             self.check_program("latexmk", DepManager.PDF_MANDATORY)
 
         # Do distro-specific checks and output distro-install commands
-        self.check_distros()
+        cmd = self.get_install()
+        if cmd:
+            print(cmd)
+
+        # If distro requires some special instructions, print here.
+        # Please notice that get_install() needs to be called first.
+        if self.distro_msg:
+            print("\n" + self.distro_msg)
 
         if not self.python_cmd:
             if self.need == 1:
-- 
2.50.1


