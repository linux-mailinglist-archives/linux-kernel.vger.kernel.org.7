Return-Path: <linux-kernel+bounces-723784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EABAFEB15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F09174321
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC482E9EB9;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnys81ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96914A923;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=tdStE/k8AwE1DEQDV2olHnvmZExc9wIm768RvkB+01nmj2Xuha1RVujvNhs4deYIJfV4ZePc0uOMEGp9ATHEwJLFKI6cimXc7dN+FnIfPmrTPumDZbUmv/41ghOUzqLp9T++rQAyaYpAJDM2ZF3+0P9nUK0gafWt1UeWKWuympc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=ckGp0WRssE+oimBMmclIVlh9lOxqZRkzDaDvYyhl6lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEb7y/aAjmj/sRA4y8DLV8rbsKmc7IcdNruu10TQiMrngWPQBCGht4Osc72S8TiPlYke213UVNs3xD50x2m57u6kMT+EfrfxFwBFi+JXZ6PYtHuN3cXgH6TLwwyTXibxMzzwElK33i3Nzo6JDmhE8UM2EwKQcQsMT5bpsXq799A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnys81ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7364C2BCB1;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=ckGp0WRssE+oimBMmclIVlh9lOxqZRkzDaDvYyhl6lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnys81edmiAA9iLWLUEU0c/lIftdgTvJEm1vrj/8rkLLPrTrW6oR9gAgvYmZoMO9F
	 yxflOSX4Y1qRKrjQaMzp3CfYzR/cNOoYceih5fs+9OGMnPaYYit7Vh/T/2AS1YjHKu
	 GGvGqeS2LkmVqsnUFDk19W2zi2uFgVDM+qIXZz0xypmPdh/oMkoFgogUIF+jNhsdgb
	 BqJ09QHZ8G+zHB/a8ulEwGF1dBNj4admf/i8SuhwZa6A6OXIhVwk/SuSFjj+M+UiCW
	 C1kFDrF0BY2Lkddov9JO87/COMBms5evpYFXjTCY6PSk4gKabUScGglk+tnKCDtUsB
	 PawcQAClhxgQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDc-3GDR;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/39] scripts: sphinx-pre-install: add docstring documentation
Date: Wed,  9 Jul 2025 15:52:03 +0200
Message-ID: <c13c7032ceb29c08740c06d8c2f41c6bd33d66be.1752067814.git.mchehab+huawei@kernel.org>
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

This program is somewhat complex. Add some docstring documentation,
explaining what each function and class is supposed to do.

Most of the focus here were to describe the ancillary functions used
to detect dependency needs.

The main SphinxDependencyChecker still requires a lot of care,
and probably need to be reorganized to clearly split the 4 types
of output it produces:

- Need to upgrade Python binary;
- System install needs;
- Virtual env install needs;
- Python install needs via system packages, to run Sphinx
  natively.

Yet, for now, I'm happy of having it a lot better documented
than its Perl version.

-

While here, rename a parameter to have its usage better
documented.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 110 +++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 8 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 1dc3f19804ab..1c96f6692e9a 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -9,6 +9,22 @@
 # Don't add changes not compatible with it, it is meant to report
 # incompatible python versions.
 
+"""
+Dependency checker for Sphinx documentation Kernel build.
+
+This module provides tools to check for all required dependencies needed to
+build documentation using Sphinx, including system packages, Python modules
+and LaTeX packages for PDF generation.
+
+It detect packages for a subset of Linux distributions used by Kernel
+maintainers, showing hints and missing dependencies.
+
+The main class SphinxDependencyChecker handles the dependency checking logic
+and provides recommendations for installing missing packages. It supports both
+system package installations and  Python virtual environments. By default,
+system pacage install is recommended.
+"""
+
 import argparse
 import os
 import re
@@ -75,7 +91,7 @@ class DepManager:
                        distro namespace, organized by type.
         - need: total number of needed dependencies. Never cleaned.
         - optional: total number of optional dependencies. Never cleaned.
-        - pdf: PDF support is enabled?
+        - pdf: Is PDF support enabled?
         """
         self.missing = {}
         self.missing_pkg = {}
@@ -565,6 +581,13 @@ class MissingCheckers(AncillaryMethods):
         return ""
 
     def check_missing(self, progs):
+        """
+        Check for missing dependencies using the provided program mapping.
+
+        The actual distro-specific programs are mapped via progs argument.
+
+        Returns True if there are missing dependencies, False otherwise.
+        """
         self.install += self.deps.check_missing(progs)
         if self.verbose_warn_install:
             self.deps.warn_install()
@@ -633,8 +656,18 @@ class MissingCheckers(AncillaryMethods):
         return system_release
 
 class SphinxDependencyChecker(MissingCheckers):
+    """
+    Main class for checking Sphinx documentation build dependencies.
 
+    - Check for missing system packages;
+    - Check for missing Python modules;
+    - Check for missing LaTeX packages needed by PDF generation;
+    - Propose Sphinx install via Python Virtual environment;
+    - Propose Sphinx install via distro-specific package install.
+    """
     def __init__(self, args):
+        """Initialize checker variables"""
+
         # List of required texlive packages on Fedora and OpenSuse
         texlive = {
             "amsfonts.sty":       "texlive-amsfonts",
@@ -705,6 +738,9 @@ class SphinxDependencyChecker(MissingCheckers):
     #
 
     def give_debian_hints(self):
+        """
+        Provide package installation hints for Debian-based distros.
+        """
         progs = {
             "Pod::Usage":    "perl-modules",
             "convert":       "imagemagick",
@@ -745,6 +781,10 @@ class SphinxDependencyChecker(MissingCheckers):
         print(f"\n\tsudo apt-get install {self.install}")
 
     def give_redhat_hints(self):
+        """
+        Provide package installation hints for RedHat-based distros
+        (Fedora, RHEL and RHEL-based variants).
+        """
         progs = {
             "Pod::Usage":       "perl-Pod-Usage",
             "convert":          "ImageMagick",
@@ -837,6 +877,10 @@ class SphinxDependencyChecker(MissingCheckers):
         print(f"\n\tsudo dnf install -y {self.install}")
 
     def give_opensuse_hints(self):
+        """
+        Provide package installation hints for openSUSE-based distros
+        (Leap and Tumbleweed).
+        """
         progs = {
             "Pod::Usage":    "perl-Pod-Usage",
             "convert":       "ImageMagick",
@@ -909,6 +953,9 @@ class SphinxDependencyChecker(MissingCheckers):
         print(f"\n\tsudo zypper install --no-recommends {self.install}")
 
     def give_mageia_hints(self):
+        """
+        Provide package installation hints for Mageia and OpenMandriva.
+        """
         progs = {
             "Pod::Usage":    "perl-Pod-Usage",
             "convert":       "ImageMagick",
@@ -956,6 +1003,9 @@ class SphinxDependencyChecker(MissingCheckers):
         print(f"\n\tsudo {packager_cmd} {self.install}")
 
     def give_arch_linux_hints(self):
+        """
+        Provide package installation hints for ArchLinux.
+        """
         progs = {
             "convert":      "imagemagick",
             "dot":          "graphviz",
@@ -989,6 +1039,9 @@ class SphinxDependencyChecker(MissingCheckers):
         print(f"\n\tsudo pacman -S {self.install}")
 
     def give_gentoo_hints(self):
+        """
+        Provide package installation hints for Gentoo.
+        """
         progs = {
             "convert":       "media-gfx/imagemagick",
             "dot":           "media-gfx/graphviz",
@@ -1107,7 +1160,12 @@ class SphinxDependencyChecker(MissingCheckers):
     #
 
     def check_distros(self):
-        # OS-specific hints logic
+        """
+        OS-specific hints logic. Seeks for a hinter. If found, provide
+        package-manager-specific install commands.
+
+        Otherwise, just lists the missing dependencies.
+        """
         os_hints = {
             re.compile("Red Hat Enterprise Linux"):   self.give_redhat_hints,
             re.compile("Fedora"):                     self.give_redhat_hints,
@@ -1159,10 +1217,22 @@ class SphinxDependencyChecker(MissingCheckers):
     # Common dependencies
     #
     def deactivate_help(self):
+        """
+        Print a helper message to disable a virtual environment.
+        """
+
         print("\n    If you want to exit the virtualenv, you can use:")
         print("\tdeactivate")
 
     def get_virtenv(self):
+        """
+        Give a hint about how to activate an already-existing virtual
+        environment containing sphinx-build.
+
+        Returns a tuble with (activate_cmd_path, sphinx_version) with
+        the newest available virtual env.
+        """
+
         cwd = os.getcwd()
 
         activates = []
@@ -1207,6 +1277,14 @@ class SphinxDependencyChecker(MissingCheckers):
         return ("", ver)
 
     def recommend_sphinx_upgrade(self):
+        """
+        Check if Sphinx needs to be upgraded.
+
+        Returns a tuple with the higest available Sphinx version if found.
+        Otherwise, returns None to indicate either that no upgrade is needed
+        or no venv was found.
+        """
+
         # Avoid running sphinx-builds from venv if cur_version is good
         if self.cur_version and self.cur_version >= RECOMMENDED_VERSION:
             self.latest_avail_ver = self.cur_version
@@ -1247,6 +1325,9 @@ class SphinxDependencyChecker(MissingCheckers):
         return self.latest_avail_ver
 
     def recommend_package(self):
+        """
+        Recommend installing Sphinx as a distro-specific package.
+        """
 
         print("\n2) As a package with:")
 
@@ -1270,11 +1351,19 @@ class SphinxDependencyChecker(MissingCheckers):
         self.verbose_warn_install = old_verbose
 
     def recommend_sphinx_version(self, virtualenv_cmd):
-        # The logic here is complex, as it have to deal with different versions:
-        #	- minimal supported version;
-        #	- minimal PDF version;
-        #	- recommended version.
-        # It also needs to work fine with both distro's package and venv/virtualenv
+        """
+        Provide recommendations for installing or upgrading Sphinx based
+        on current version.
+
+        The logic here is complex, as it have to deal with different versions:
+
+        - minimal supported version;
+        - minimal PDF version;
+        - recommended version.
+
+        It also needs to work fine with both distro's package and
+        venv/virtualenv
+        """
 
         if self.recommend_python:
             print("\nPython version is incompatible with doc build.\n" \
@@ -1369,6 +1458,10 @@ class SphinxDependencyChecker(MissingCheckers):
               "\thttps://github.com/sphinx-doc/sphinx/pull/8313")
 
     def check_needs(self):
+        """
+        Main method that checks needed dependencies and provides
+        recommendations.
+        """
         self.python_cmd = sys.executable
 
         # Check if Sphinx is already accessible from current environment
@@ -1451,6 +1544,7 @@ Process some flags related to Sphinx installation and documentation build.
 
 
 def main():
+    """Main function"""
     parser = argparse.ArgumentParser(description=DESCRIPTION)
 
     parser.add_argument(
@@ -1481,6 +1575,6 @@ def main():
     checker.check_python()
     checker.check_needs()
 
-
+# Call main if not used as module
 if __name__ == "__main__":
     main()
-- 
2.49.0


