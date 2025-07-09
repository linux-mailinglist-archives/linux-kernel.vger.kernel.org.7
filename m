Return-Path: <linux-kernel+bounces-723783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC23EAFEAFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD667BD419
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18E2EA73E;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRA/3C19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AAD2E54D9;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=pIHCC+33yCbPTdUg8AN4qewAALoFiPjcTaoa7jiAhe2a+LldK2EQhw2t/B5iL3GL65aSiC/GMiocCfm5zhq2uAaBtKULv1ujaMwjvXTh0VKT3kqNCOFVvhF/XtYPhCQml7fXw8h4opCzjAKcsSnWrY6IVFdZ2CEz+EHHMGwmJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=T/BO/r7ruuwzhv5h5BilZiiuHJFOxxfSdm5kmnIByFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUcHwTIkA2mV/DEC+wYHTBTZi2eec9CrDZUyB5eSkYIIfhiAE0gFBiLm6OymoGk+l1nRmra3BS1aZqGEcULCuKi04ZOTezLKnqP8XIE7xUgN+IlXNEqkRkTkgj0VoEe5H+7jbnx2Yb49Gu+C7jkRti6/FWPrCBe53PbUkgRv7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRA/3C19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9642C116D0;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=T/BO/r7ruuwzhv5h5BilZiiuHJFOxxfSdm5kmnIByFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRA/3C194bWoeDgBAgbO6R+yeuDwe7Dsw+SLxJa0fUQ1qIJ+cnOHexGv9MQ7dcwc3
	 CJ4Fz2cVdvhsSi7o30ajQay/q6bvvP4rxN5ET+BT6Lb4qaKyVm6T28txN4Pdkwe6W4
	 C9ny4qSsOaCKIr5vzq0PdCWCqh1hyiiWqjU9XLIJnIn33YExDc7tfvs9L73Z2tm6na
	 12oOWhaX5qYAA1q+xtf1QXKW4EHnT0kk0diBXdhHfrMp6IY1ZGMpWwbg8ic+F34Pb+
	 3GgVeuukjmvJLbOOgUSY56S/sWL6QoCvG8G8LPg6Z+U65L9BNwtuPMrLnTE8H3BScU
	 9KrFqmqJwY2iA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDj-3Qqo;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/39] scripts: sphinx-pre-install: rework install command logic
Date: Wed,  9 Jul 2025 15:52:05 +0200
Message-ID: <d11d556651ea9de7762d3b103cf847c2043e26fb.1752067814.git.mchehab+huawei@kernel.org>
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

Cleanup the code to remove some redundancy and to let it be
clearer about the command install instructions.

Ensure that special instructions will be shown only once,
before the actual install command.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 179 ++++++++++++++++------------------
 test_script.py                |   4 +-
 2 files changed, 84 insertions(+), 99 deletions(-)

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
diff --git a/test_script.py b/test_script.py
index ab07595d7dc6..2bc6a757e19e 100755
--- a/test_script.py
+++ b/test_script.py
@@ -563,12 +563,12 @@ class SphinxDepsChecker:
                 # Just remove the entire venv directory
                 cmd = ["rm", "-r", "sphinx_latest/"]
             else:
-                uninstall_cmd = pm_config['uninstall_cmd'].copy()
+                uninstall_cmd = pm_config['uninstall_cmd']
                 if not uninstall_cmd:
                     print(f"WARNING: no uninstall_cmd for {pkg_manager}")
                     continue
 
-                cmd = uninstall_cmd + data['packages']
+                cmd = uninstall_cmd.copy() + data['packages']
 
             try:
                 result = await self.cmd.run(cmd, f"[{pkg_manager}]")
-- 
2.49.0


