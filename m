Return-Path: <linux-kernel+bounces-723805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A1AFEB1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB213B8A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8712ED872;
	Wed,  9 Jul 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6N1llrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7B2E7177;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=b9yofZQ3Z0WTo3ZGiqQK8zhTsekkfwzYrrAosDp/8q1TdtvxapdmuGn2Tc6WDw3rCzAFq2lrrgYEGcQ0NhhK8NDE/CwxQZHhGv1DbnPvlU1SpI13cIQ1XQJ99b1IGp14LN6K1eyY5/NUS8pfalH6BRu2b5BCu1oxboSFESiBbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=Lb/swLtGUBLG9dhOwLjNirOq60YQwIykYqGM9+QNXCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7TXU1GzYW0zJNfYXu6W8YS+cKhebJ59SnFPv7jTH4+pZkXSE/NIlxgb/3/pvtOphmhBPO5nG4d87mbsPkav+Qt2C/16vbOgZjCbJ1pVFfQZxiyIopQUzewauHoGZ3pKw4JWOUkjlSYO42gFsxJ4oXd4sPHlVBlGjGTzmjTY45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6N1llrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4001C2BC87;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069142;
	bh=Lb/swLtGUBLG9dhOwLjNirOq60YQwIykYqGM9+QNXCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6N1llrc0K4NqKc9MGpXhHUIeSxRSTaU3g5DpL4BPwQKO690KwqTl0IDPqFbreX3r
	 uRpGMmGDS1otbgvukJCSOPZ4g7yVM1qfbT7uIWOUiVZ+YOJjbCTJtB2jy5o0+flEDf
	 FqAugLtsw0zEX8aieyRFUu9NF9wgqQ2inkmfj0dc4v3I1oSGPHPH514K+TF3A7BVde
	 HeNfg/NIrdspGc4QptOUdAnZ49t4v2wF9yOUdKqKwIqC7Dj+Z/Pu0R7jp/7goxPmJ6
	 CEquu2TTLtjccTl8q6hvlhPpZ/zWTYWHvl56NNZfHpQNUPC+V1IzdTjixh/IZxPnTQ
	 wJw8LOL90OiFg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDG-2e1D;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/39] scripts: sphinx-pre-install: convert is_optional to a class
Date: Wed,  9 Jul 2025 15:51:56 +0200
Message-ID: <d72512c0a27f0976f87b68e6b65729404dba17ba.1752067814.git.mchehab+huawei@kernel.org>
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

When is_optional was added in Perl, it was a boolean. With
time, it ended becoming a sort of enum, which makes the
module harder to maintain.

Convert it to a enum-like class and add more options to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 192 +++++++++++++++++++++++-----------
 1 file changed, 130 insertions(+), 62 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index a5c777e529ec..0963da21c27b 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -32,6 +32,53 @@ RECOMMENDED_VERSION = parse_version("3.4.3")
 MIN_PYTHON_VERSION = parse_version("3.7")
 
 
+class DepType:
+
+    # Internal types of dependencies.
+    _SYS_TYPE = 0
+    _PHY_TYPE = 1
+    _PDF_TYPE = 2
+
+    # Let's define keys as a tuple with the type and mandatory/optional.
+    # This way, checking for optional or type is easy.
+
+    SYSTEM_MANDATORY = (_SYS_TYPE, True)
+    PYTHON_MANDATORY = (_PHY_TYPE, True)
+    PDF_MANDATORY = (_PDF_TYPE, True)
+
+    # Currently we're not using all optional types, but let's keep all
+    # combinations here, as we may end needing them in the future. Also,
+    # it allows a name() function that handles all possibilities.
+    SYSTEM_OPTIONAL = (_SYS_TYPE, False)
+    PYTHON_OPTIONAL = (_PHY_TYPE, False)
+    PDF_OPTIONAL = (_PDF_TYPE, True)
+
+    @staticmethod
+    def name(dtype):
+        if dtype[0] == DepType._SYS_TYPE:
+            msg = "build"
+        elif dtype[0] == DepType._PHY_TYPE:
+            msg = "Python"
+        else:
+            msg = "PDF"
+
+        if dtype[1]:
+            return f"ERROR: {msg} mandatory deps missing"
+        else:
+            out = f"Warning: {msg} optional deps missing"
+
+    @staticmethod
+    def is_optional(dtype):
+        return not dtype[1]
+
+    @staticmethod
+    def is_pdf(dtype):
+        if (dtype[0] == DepType._PDF_TYPE):
+            return True
+
+        return False
+
+
 class SphinxDependencyChecker:
     # List of required texlive packages on Fedora and OpenSuse
     texlive = {
@@ -223,56 +270,68 @@ class SphinxDependencyChecker:
     # Methods to check if a feature exists
     #
 
-    # Note: is_optional has 3 states:
-    #   - 0: mandatory
-    #   - 1: optional, but nice to have
-    #   - 2: LaTeX optional - pdf builds without it, but may have visual impact
-
     def check_missing(self, progs):
-        for prog, is_optional in sorted(self.missing.items()):
+        run = {}
+
+        for prog, dtype in sorted(self.missing.items()):
             # At least on some LTS distros like CentOS 7, texlive doesn't
             # provide all packages we need. When such distros are
             # detected, we have to disable PDF output.
             #
             # So, we need to ignore the packages that distros would
             # need for LaTeX to work
-            if is_optional == 2 and not self.pdf:
+            if DepType.is_pdf(dtype) and not self.pdf:
                 self.optional -= 1
                 continue
 
+            if not dtype in run:
+                run[dtype] = []
+
+            run[dtype].append(prog)
+
+        output_msg = ""
+
+        for dtype in sorted(run.keys()):
+            progs = " ".join(run[dtype])
+
             if self.verbose_warn_install:
-                if is_optional:
-                    print(f'Warning: better to also install "{prog}".')
-                else:
-                    print(f'ERROR: please install "{prog}", otherwise, build won\'t work.')
+                try:
+                    name = DepType.name(dtype)
+                    output_msg += f'{name}:\t{progs}\n'
+                except KeyError:
+                    raise KeyError(f"ERROR!!!: invalid dtype for {progs}: {dtype}")
 
-            self.install += " " + progs.get(prog, prog)
+            self.install += " " + progs
+
+        if output_msg:
+            print(f"\n{output_msg}\n")
 
         self.install = self.install.lstrip()
 
-    def add_package(self, package, is_optional):
-        self.missing[package] = is_optional
+    def add_package(self, package, dtype):
+        is_optional = DepType.is_optional(dtype)
+        self.missing[package] = dtype
         if is_optional:
             self.optional += 1
         else:
             self.need += 1
 
-    def check_missing_file(self, files, package, is_optional):
+    def check_missing_file(self, files, package, dtype):
         for f in files:
             if os.path.exists(f):
                 return
-        self.add_package(package, is_optional)
+        self.add_package(package, dtype)
 
-    def check_program(self, prog, is_optional):
+    def check_program(self, prog, dtype):
         found = self.which(prog)
         if found:
             return found
 
-        self.add_package(prog, is_optional)
+        self.add_package(prog, dtype)
 
         return None
 
-    def check_perl_module(self, prog, is_optional):
+    def check_perl_module(self, prog, dtype):
         # While testing with lxc download template, one of the
         # distros (Oracle) didn't have perl - nor even an option to install
         # before installing oraclelinux-release-el9 package.
@@ -281,46 +340,52 @@ class SphinxDependencyChecker:
         # add it as a mandatory package, as some parts of the doc builder
         # needs it.
         if not self.which("perl"):
-            self.add_package("perl", 0)
-            self.add_package(prog, is_optional)
+            self.add_package("perl", DepType.SYSTEM_MANDATORY)
+            self.add_package(prog, dtype)
             return
 
         try:
             self.run(["perl", f"-M{prog}", "-e", "1"], check=True)
         except subprocess.CalledProcessError:
-            self.add_package(prog, is_optional)
+            self.add_package(prog, dtype)
 
-    def check_python_module(self, module, is_optional):
-        # FIXME: is it needed at the Python version? Maybe due to venv?
-        if not self.python_cmd:
-            return
+    def check_python_module(self, module, is_optional=False):
+        if is_optional:
+            dtype = DepType.PYTHON_OPTIONAL
+        else:
+            dtype = DepType.PYTHON_MANDATORY
 
         try:
             self.run([self.python_cmd, "-c", f"import {module}"], check=True)
         except subprocess.CalledProcessError:
-            self.add_package(module, is_optional)
+            self.add_package(module, dtype)
 
-    def check_rpm_missing(self, pkgs, is_optional):
+    def check_rpm_missing(self, pkgs, dtype):
         for prog in pkgs:
             try:
                 self.run(["rpm", "-q", prog], check=True)
             except subprocess.CalledProcessError:
-                self.add_package(prog, is_optional)
+                self.add_package(prog, dtype)
 
-    def check_pacman_missing(self, pkgs, is_optional):
+    def check_pacman_missing(self, pkgs, dtype):
         for prog in pkgs:
             try:
                 self.run(["pacman", "-Q", prog], check=True)
             except subprocess.CalledProcessError:
-                self.add_package(prog, is_optional)
+                self.add_package(prog, dtype)
+
+    def check_missing_tex(self, is_optional=False):
+        if is_optional:
+            dtype = DepType.PDF_OPTIONAL
+        else:
+            dtype = DepType.PDF_MANDATORY
 
-    def check_missing_tex(self, is_optional):
         kpsewhich = self.which("kpsewhich")
         for prog, package in self.texlive.items():
 
             # If kpsewhich is not there, just add it to deps
             if not kpsewhich:
-                self.add_package(package, is_optional)
+                self.add_package(package, dtype)
                 continue
 
             # Check if the package is needed
@@ -331,11 +396,11 @@ class SphinxDependencyChecker:
 
                 # Didn't find. Add it
                 if not result.stdout.strip():
-                    self.add_package(package, is_optional)
+                    self.add_package(package, dtype)
 
             except subprocess.CalledProcessError:
                 # kpsewhich returned an error. Add it, just in case
-                self.add_package(package, is_optional)
+                self.add_package(package, dtype)
 
     def get_sphinx_fname(self):
         if "SPHINXBUILD" in os.environ:
@@ -446,9 +511,9 @@ class SphinxDependencyChecker:
             }
 
             for package, files in pdf_pkgs.items():
-                self.check_missing_file(files, package, 2)
+                self.check_missing_file(files, package, DepType.PDF_MANDATORY)
 
-            self.check_program("dvipng", 2)
+            self.check_program("dvipng", DepType.PDF_MANDATORY)
 
         self.check_missing(progs)
 
@@ -518,7 +583,7 @@ class SphinxDependencyChecker:
             # RHEL 8 uses Python 3.6, which is not compatible with
             # the build system anymore. Suggest Python 3.11
             if rel == 8:
-                self.add_package("python39", 0)
+                self.add_package("python39", DepType.SYSTEM_MANDATORY)
                 self.recommend_python = True
 
             if self.first_hint:
@@ -540,13 +605,13 @@ class SphinxDependencyChecker:
                 "/usr/share/fonts/google-noto-sans-cjk-fonts/NotoSansCJK-Regular.ttc",
             ]
 
-            self.check_missing_file(pdf_pkgs, noto_sans_redhat, 2)
+            self.check_missing_file(pdf_pkgs, noto_sans_redhat, DepType.PDF_MANDATORY)
 
             if not old:
-                self.check_rpm_missing(fedora26_opt_pkgs, 2)
-                self.check_rpm_missing(fedora_tex_pkgs, 2)
+                self.check_rpm_missing(fedora26_opt_pkgs, DepType.PDF_MANDATORY)
+                self.check_rpm_missing(fedora_tex_pkgs, DepType.PDF_MANDATORY)
 
-            self.check_missing_tex(2)
+            self.check_missing_tex()
 
         self.check_missing(progs)
 
@@ -601,7 +666,7 @@ class SphinxDependencyChecker:
             if rel == 15:
                 if not self.which(self.python_cmd):
                     self.recommend_python = True
-                    self.add_package(self.python_cmd, 0)
+                    self.add_package(self.python_cmd, DepType.SYSTEM_MANDATORY)
 
                 progs.update({
                     "python-sphinx": "python311-Sphinx",
@@ -623,9 +688,9 @@ class SphinxDependencyChecker:
         # "Noto Sans CJK SC" on openSUSE
 
         if self.pdf:
-            self.check_rpm_missing(suse_tex_pkgs, 2)
+            self.check_rpm_missing(suse_tex_pkgs, DepType.PDF_MANDATORY)
         if self.pdf:
-            self.check_missing_tex(2)
+            self.check_missing_tex()
         self.check_missing(progs)
 
         if not self.need and not self.optional:
@@ -672,8 +737,8 @@ class SphinxDependencyChecker:
                 "/usr/share/fonts/TTF/NotoSans-Regular.ttf",
             ]
 
-            self.check_missing_file(pdf_pkgs, noto_sans, 2)
-            self.check_rpm_missing(tex_pkgs, 2)
+            self.check_missing_file(pdf_pkgs, noto_sans, DepType.PDF_MANDATORY)
+            self.check_rpm_missing(tex_pkgs, DepType.PDF_MANDATORY)
 
         self.check_missing(progs)
 
@@ -701,7 +766,7 @@ class SphinxDependencyChecker:
         ]
 
         if self.pdf:
-            self.check_pacman_missing(archlinux_tex_pkgs, 2)
+            self.check_pacman_missing(archlinux_tex_pkgs, DepType.PDF_MANDATORY)
 
             self.check_missing_file(
                 ["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
@@ -739,7 +804,7 @@ class SphinxDependencyChecker:
                 ],
             }
             for package, files in pdf_pkgs.items():
-                self.check_missing_file(files, package, 2)
+                self.check_missing_file(files, package, DepType.PDF_MANDATORY)
 
         self.check_missing(progs)
 
@@ -878,7 +943,7 @@ class SphinxDependencyChecker:
         #
         progs = {"sphinx-build": "sphinx"}
         if self.pdf:
-            self.check_missing_tex(2)
+            self.check_missing_tex()
 
         self.check_missing(progs)
 
@@ -990,7 +1055,7 @@ class SphinxDependencyChecker:
         old_verbose = self.verbose_warn_install
         self.verbose_warn_install = 0
 
-        self.add_package("python-sphinx", 0)
+        self.add_package("python-sphinx", DepType.PYTHON_MANDATORY)
 
         self.check_distros()
 
@@ -1010,6 +1075,7 @@ class SphinxDependencyChecker:
                   "Please upgrade it and re-run.\n")
             return
 
+
         # Version is OK. Nothing to do.
         if self.cur_version != (0, 0, 0) and self.cur_version >= RECOMMENDED_VERSION:
             return
@@ -1128,21 +1194,23 @@ class SphinxDependencyChecker:
 
             else:
                 virtualenv_cmd = f"{self.python_cmd} -m venv"
-                self.check_python_module("ensurepip", 0)
+                self.check_python_module("ensurepip")
 
         # Check for needed programs/tools
-        self.check_perl_module("Pod::Usage", 0)
-        self.check_python_module("yaml", 0)
-        self.check_program("make", 0)
-        self.check_program("gcc", 0)
-        self.check_program("dot", 1)
-        self.check_program("convert", 1)
+        self.check_perl_module("Pod::Usage", DepType.SYSTEM_MANDATORY)
+
+        self.check_program("make", DepType.SYSTEM_MANDATORY)
+        self.check_program("gcc", DepType.SYSTEM_MANDATORY)
+
+        self.check_program("dot", DepType.SYSTEM_OPTIONAL)
+        self.check_program("convert", DepType.SYSTEM_OPTIONAL)
+
+        self.check_python_module("yaml")
 
         if self.pdf:
-            # Extra PDF files - should use 2 for LaTeX is_optional
-            self.check_program("xelatex", 2)
-            self.check_program("rsvg-convert", 2)
-            self.check_program("latexmk", 2)
+            self.check_program("xelatex", DepType.PDF_MANDATORY)
+            self.check_program("rsvg-convert", DepType.PDF_MANDATORY)
+            self.check_program("latexmk", DepType.PDF_MANDATORY)
 
         # Do distro-specific checks and output distro-install commands
         self.check_distros()
-- 
2.49.0


