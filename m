Return-Path: <linux-kernel+bounces-765202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7A9B22CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5EB7B19B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DD2FAC10;
	Tue, 12 Aug 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqo3h9nH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08982F83D9;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=rZCJyWIXXoujR9clT/Xq/Wu3uVGrB+dQ5mxAn24p3CRg6Q1fwMYuhe8X+2yZLrFG6DcSTKsJFD2NpKxNOeHuBcbN2rPvWIDrsNA9jnSza+ZMhnxjKTA1/JrHd3MYF7HEVphFFEpDHxBP/QuoNBZn/jAiJWjFfN4iKlj3mQv5BXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=+W2ENmXHnB15Oyz3OVQYWghVzWvLQQcm9saVuC/Busc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqC5uOIkQ6O1zqH3D/6c8y08v4pVlCET5JO2314Kc+YJv2igN6ZmOIqZTxyLDQ3Aj5aV/AlcX8bokqrGt95CwvPHVF3I89aea+TrezuZdkzjaY9btOY80rohmvSF3VkJO4gfA0ab5OXeUXcLptkxEgiIrA2pUIENyTe8bOBrc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqo3h9nH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC792C4AF16;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=+W2ENmXHnB15Oyz3OVQYWghVzWvLQQcm9saVuC/Busc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqo3h9nHupLJZVEyZT08RG0RMiCQKuuPDCocRlXJOeGKl5xt6fu8gwSd1xZvChUsb
	 FpZhNSH+hy/vjVHL53GDwPds1fSogya4yewEGVzWTAZ7s/LT4Q1ub38PQ5vtELL5Nu
	 oy/gxFCqgrC7IwFAtnl7MZ0xBebR0vqWh9wx6y0+7iybuhtpwE2KF2M8epDnfySz4t
	 UNxZW4PkbjH+/2hAF9T2Tc1f7lzp9RIWr3nDMQ9xbrdz7nvvc/gcOBt+O/o0CQpUum
	 iwOJbC7Fn+w128JA8KYpqkBSbfuEanqz62/9ras7Ppl+64TYw38ek5120a3wLcU5FX
	 Hl0mf2OWi8U+Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kXC-43tu;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/39] scripts: sphinx-pre-install: add docstring documentation
Date: Tue, 12 Aug 2025 17:52:48 +0200
Message-ID: <0cadab2cab3f78ae6d9f378e92a45125fbc5188f.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


