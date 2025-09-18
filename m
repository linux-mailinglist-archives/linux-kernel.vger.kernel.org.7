Return-Path: <linux-kernel+bounces-765200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E6B22CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380F1160CED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA92FAC15;
	Tue, 12 Aug 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu/Kta/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC32F83DC;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=tWqey6zS+p4QW6lvwTNY/OVAp40PFZ52MhOSkOkdAYQUfNqUTdaGqhbhmxULzSAzaiYEOu4VhP5fwrbxvCrn4k3ORrj52Zqi8598lHFHrgP9TbGuxNTYNgXX0/22+Pp8D1FI8MJcnM8vnSzy4XRW+c0GR/9jQ0ColLr1yi5tR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=uqIRNdCp3Pn2ZqFb+15hEn/Z/fdxxnN1r1BLsk95MfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz4EAWBeyOU76HSCqIjsKsbVu4ntTYqJSScB9K+8PiM6AMWI6meCPnOQVaYzqHEx80b2Epa31rh1xb6Kss9Xhem2H2eODLNcdMjdTbRplEaB/7sdhJ77Tq+h23wq0ae60oQcM4ioa06Zs8r7Tu/CFui/OEYa/+82gmOYqX/GD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu/Kta/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0797C4AF13;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=uqIRNdCp3Pn2ZqFb+15hEn/Z/fdxxnN1r1BLsk95MfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qu/Kta/PCrcmm37XJCSinv44U/dkHkHQ1Y86eh9tNHGhc57rzVHRQdap4GCh71XQl
	 kwitLSnETOs3re5i6kFhUt5F4XD5608TMyrLGZiNpNldyD8rGtESGv915Lxqd1LK+o
	 Xa7B0UccthRhhp0grRXfTloO+PFP3XCjVe3U/fz+wPHBp9IfMXpsLHgq8J+BBq1zbq
	 V+ekrh01Nl3Bu2A78M/eenhewRupXL6L0TH5Ue2eqojR2tLQnPtE1niyCfXPigPG7j
	 azZccXwbxq7yReE6jwufnirIQxazgC0egGNKJrvcyRC/24j/xL9v2sjyky3+0mSpkX
	 OyfAvijDGaVaA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kX8-3wyT;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/39] scripts: sphinx-pre-install: add documentation for the ancillary classes.
Date: Tue, 12 Aug 2025 17:52:47 +0200
Message-ID: <7421112b14edf5c21cc4cf0f2ee320fcaf874b40.1754992972.git.mchehab+huawei@kernel.org>
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

While here, rename a parameter to have its usage better
documented.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 162 +++++++++++++++++++++++++++++-----
 1 file changed, 140 insertions(+), 22 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 593982f350b3..1dc3f19804ab 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -33,35 +33,62 @@ MIN_PYTHON_VERSION = parse_version("3.7")
 
 
 class DepManager:
+    """
+    Manage package dependencies. There are three types of dependencies:
 
-    # Internal types of dependencies.
+    - System: dependencies required for docs build;
+    - Python: python dependencies for a native distro Sphinx install;
+    - PDF: dependencies needed by PDF builds.
+
+    Each dependency can be mandatory or optional. Not installing an optional
+    dependency won't break the build, but will cause degradation at the
+    docs output.
+    """
+
+    # Internal types of dependencies. Don't use them outside DepManager class.
     _SYS_TYPE = 0
     _PHY_TYPE = 1
     _PDF_TYPE = 2
 
-    # Let's define keys as a tuple with the type and mandatory/optional.
-    # This way, checking for optional or type is easy.
+    # Dependencies visible outside the class.
+    # The keys are tuple with: (type, is_mandatory flag).
+    #
+    # Currently we're not using all optional dep types. Yet, we'll keep all
+    # possible combinations here. They're not many, and that makes easier
+    # if later needed and for the name() method below
 
     SYSTEM_MANDATORY = (_SYS_TYPE, True)
     PYTHON_MANDATORY = (_PHY_TYPE, True)
     PDF_MANDATORY = (_PDF_TYPE, True)
 
-    # Currently we're not using all optional types, but let's keep all
-    # combinations here, as we may end needing them in the future. Also,
-    # it allows a name() function that handles all possibilities.
     SYSTEM_OPTIONAL = (_SYS_TYPE, False)
     PYTHON_OPTIONAL = (_PHY_TYPE, False)
     PDF_OPTIONAL = (_PDF_TYPE, True)
 
     def __init__(self, pdf):
+        """
+        Initialize internal vars:
+
+        - missing: missing dependencies list, containing a distro-independent
+                   name for a missing dependency and its type.
+        - missing_pkg: ancillary dict containing missing dependencies in
+                       distro namespace, organized by type.
+        - need: total number of needed dependencies. Never cleaned.
+        - optional: total number of optional dependencies. Never cleaned.
+        - pdf: PDF support is enabled?
+        """
         self.missing = {}
-        self.run = {}
+        self.missing_pkg = {}
         self.need = 0
         self.optional = 0
         self.pdf = pdf
 
     @staticmethod
     def name(dtype):
+        """
+        Ancillary routine to output a warn/error message reporting
+        missing dependencies.
+        """
         if dtype[0] == DepManager._SYS_TYPE:
             msg = "build"
         elif dtype[0] == DepManager._PHY_TYPE:
@@ -76,16 +103,22 @@ class DepManager:
 
     @staticmethod
     def is_optional(dtype):
+        """Ancillary routine to report if a dependency is optional"""
         return not dtype[1]
 
     @staticmethod
     def is_pdf(dtype):
+        """Ancillary routine to report if a dependency is for PDF generation"""
         if (dtype[0] == DepManager._PDF_TYPE):
             return True
 
         return False
 
     def add_package(self, package, dtype):
+        """
+        Add a package at the self.missing() dictionary.
+        Doesn't update missing_pkg.
+        """
         is_optional = DepManager.is_optional(dtype)
         self.missing[package] = dtype
         if is_optional:
@@ -94,6 +127,10 @@ class DepManager:
             self.need += 1
 
     def del_package(self, package):
+        """
+        Remove a package at the self.missing() dictionary.
+        Doesn't update missing_pkg.
+        """
         if package in self.missing:
             del self.missing[package]
 
@@ -104,13 +141,22 @@ class DepManager:
         This is an ackward way to have a separate section to recommend
         a package after system main dependencies.
 
-        TODO: rework the logic to prevent needing it
+        TODO: rework the logic to prevent needing it.
         """
 
         self.missing = {}
+        self.missing_pkg = {}
 
     def check_missing(self, progs):
-        self.run = {}
+        """
+        Update self.missing_pkg, using progs dict to convert from the
+        agnostic package name to distro-specific one.
+
+        Returns an string with the packages to be installed, sorted and
+        with eventual duplicates removed.
+        """
+
+        self.missing_pkg = {}
 
         for prog, dtype in sorted(self.missing.items()):
             # At least on some LTS distros like CentOS 7, texlive doesn't
@@ -123,23 +169,26 @@ class DepManager:
                 self.optional -= 1
                 continue
 
-            if not dtype in self.run:
-                self.run[dtype] = []
+            if not dtype in self.missing_pkg:
+                self.missing_pkg[dtype] = []
 
-            self.run[dtype].append(progs.get(prog, prog))
+            self.missing_pkg[dtype].append(progs.get(prog, prog))
 
         install = []
-        for dtype in self.run.keys():
-            install += self.run[dtype]
+        for dtype in self.missing_pkg.keys():
+            install += self.missing_pkg[dtype]
 
         return " ".join(sorted(set(install)))
 
     def warn_install(self):
+        """
+        Emit warnings/errors related to missing packages.
+        """
 
         output_msg = ""
 
-        for dtype in sorted(self.run.keys()):
-            progs = " ".join(sorted(set(self.run[dtype])))
+        for dtype in sorted(self.missing_pkg.keys()):
+            progs = " ".join(sorted(set(self.missing_pkg[dtype])))
 
             try:
                 name = DepManager.name(dtype)
@@ -158,6 +207,11 @@ class AncillaryMethods:
 
     @staticmethod
     def which(prog):
+        """
+        Our own implementation of which(). We could instead use
+        shutil.which(), but this function is simple enough.
+        Probably faster to use this implementation than to import shutil.
+        """
         for path in os.environ.get("PATH", "").split(":"):
             full_path = os.path.join(path, prog)
             if os.access(full_path, os.X_OK):
@@ -167,6 +221,10 @@ class AncillaryMethods:
 
     @staticmethod
     def get_python_version(cmd):
+        """
+        Get python version from a Python binary. As we need to detect if
+        are out there newer python binaries, we can't rely on sys.release here.
+        """
 
         result = SphinxDependencyChecker.run([cmd, "--version"],
                                             capture_output=True, text=True)
@@ -181,7 +239,13 @@ class AncillaryMethods:
 
     @staticmethod
     def find_python():
+        """
+        Detect if are out there any python 3.xy version newer than the
+        current one.
 
+        Note: this routine is limited to up to 2 digits for python3. We
+        may need to update it one day, hopefully on a distant future.
+        """
         patterns = [
             "python3.[0-9]",
             "python3.[0-9][0-9]",
@@ -200,7 +264,10 @@ class AncillaryMethods:
 
     @staticmethod
     def check_python():
-
+        """
+        Check if the current python binary satisfies our minimal requirement
+        for Sphinx build. If not, re-run with a newer version if found.
+        """
         cur_ver = sys.version_info[:3]
         if cur_ver >= MIN_PYTHON_VERSION:
             ver = ver_str(cur_ver)
@@ -240,7 +307,10 @@ class AncillaryMethods:
 
     @staticmethod
     def run(*args, **kwargs):
-        """Excecute a command, hiding its output by default"""
+        """
+        Excecute a command, hiding its output by default.
+        Preserve comatibility with older Python versions.
+        """
 
         capture_output = kwargs.pop('capture_output', False)
 
@@ -262,8 +332,15 @@ class AncillaryMethods:
         return subprocess.run(*args, **kwargs)
 
 class MissingCheckers(AncillaryMethods):
+    """
+    Contains some ancillary checkers for different types of binaries and
+    package managers.
+    """
 
     def __init__(self, args, texlive):
+        """
+        Initialize its internal variables
+        """
         self.pdf = args.pdf
         self.virtualenv = args.virtualenv
         self.version_check = args.version_check
@@ -280,17 +357,20 @@ class MissingCheckers(AncillaryMethods):
 
         self.install = ""
 
-    #
-    # Methods to check if a feature exists
-    #
-
     def check_missing_file(self, files, package, dtype):
+        """
+        Does the file exists? If not, add it to missing dependencies.
+        """
         for f in files:
             if os.path.exists(f):
                 return
         self.deps.add_package(package, dtype)
 
     def check_program(self, prog, dtype):
+        """
+        Does the program exists and it is at the PATH?
+        If not, add it to missing dependencies.
+        """
         found = self.which(prog)
         if found:
             return found
@@ -300,6 +380,18 @@ class MissingCheckers(AncillaryMethods):
         return None
 
     def check_perl_module(self, prog, dtype):
+        """
+        Does perl have a dependency? Is it available?
+        If not, add it to missing dependencies.
+
+        Right now, we still need Perl for doc build, as it is required
+        by some tools called at docs or kernel build time, like:
+
+            scripts/documentation-file-ref-check
+
+        Also, checkpatch is on Perl.
+        """
+
         # While testing with lxc download template, one of the
         # distros (Oracle) didn't have perl - nor even an option to install
         # before installing oraclelinux-release-el9 package.
@@ -318,6 +410,10 @@ class MissingCheckers(AncillaryMethods):
             self.deps.add_package(prog, dtype)
 
     def check_python_module(self, module, is_optional=False):
+        """
+        Does a python module exists outside venv? If not, add it to missing
+        dependencies.
+        """
         if is_optional:
             dtype = DepManager.PYTHON_OPTIONAL
         else:
@@ -329,6 +425,9 @@ class MissingCheckers(AncillaryMethods):
             self.deps.add_package(module, dtype)
 
     def check_rpm_missing(self, pkgs, dtype):
+        """
+        Does a rpm package exists? If not, add it to missing dependencies.
+        """
         for prog in pkgs:
             try:
                 self.run(["rpm", "-q", prog], check=True)
@@ -336,6 +435,9 @@ class MissingCheckers(AncillaryMethods):
                 self.deps.add_package(prog, dtype)
 
     def check_pacman_missing(self, pkgs, dtype):
+        """
+        Does a pacman package exists? If not, add it to missing dependencies.
+        """
         for prog in pkgs:
             try:
                 self.run(["pacman", "-Q", prog], check=True)
@@ -343,6 +445,9 @@ class MissingCheckers(AncillaryMethods):
                 self.deps.add_package(prog, dtype)
 
     def check_missing_tex(self, is_optional=False):
+        """
+        Does a LaTeX package exists? If not, add it to missing dependencies.
+        """
         if is_optional:
             dtype = DepManager.PDF_OPTIONAL
         else:
@@ -371,6 +476,9 @@ class MissingCheckers(AncillaryMethods):
                 self.deps.add_package(package, dtype)
 
     def get_sphinx_fname(self):
+        """
+        Gets the binary filename for sphinx-build.
+        """
         if "SPHINXBUILD" in os.environ:
             return os.environ["SPHINXBUILD"]
 
@@ -386,6 +494,9 @@ class MissingCheckers(AncillaryMethods):
         return ""
 
     def get_sphinx_version(self, cmd):
+        """
+        Gets sphinx-build version.
+        """
         try:
             result = self.run([cmd, "--version"],
                               stdout=subprocess.PIPE,
@@ -404,6 +515,9 @@ class MissingCheckers(AncillaryMethods):
                 return parse_version(match.group(1))
 
     def check_sphinx(self, conf):
+        """
+        Checks Sphinx minimal requirements
+        """
         try:
             with open(conf, "r", encoding="utf-8") as f:
                 for line in f:
@@ -441,6 +555,10 @@ class MissingCheckers(AncillaryMethods):
             sys.exit(0)
 
     def catcheck(self, filename):
+        """
+        Reads a file if it exists, returning as string.
+        If not found, returns an empty string.
+        """
         if os.path.exists(filename):
             with open(filename, "r", encoding="utf-8") as f:
                 return f.read().strip()
-- 
2.50.1


