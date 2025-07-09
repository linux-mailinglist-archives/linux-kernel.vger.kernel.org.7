Return-Path: <linux-kernel+bounces-723804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10935AFEB2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207D8172675
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826462EE264;
	Wed,  9 Jul 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os5ODMwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7A2E7174;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=JiOhKv5z+FzPNEHPs5mZi4AhGTaLuqZTKSzIZb30oB363tFzi/tlRG+N5OC6sco1YwI8HpjTrwWDQ9R3X7aV1C2lGYI0IJJ5xeB322Z+4CzfiVdN1qZIuR25muln9HSnCmPPREVSqj9SBLLEeATXw+amZb6vMSkHZaLSSU4iIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=RueffcvRIDBMi87r9z1UtD/9fAlr6jNpZ48zD4mdxEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btXqD9fAz/15uH/kXHJFtLt1tS0nol+LmjGwdj0ZpY988/Al5HXODx5pLWTEXkVCSR1mQwvmGImpmDRnHhlAiIsQtuGYR4O+RCT3YnezL/qX2+x8c7M++qkLOAqLMSc+9vxkuxSjhKNyId2BDAxQ5gba7GzzzTuQXpoyzFR0Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os5ODMwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE659C2BCAF;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069142;
	bh=RueffcvRIDBMi87r9z1UtD/9fAlr6jNpZ48zD4mdxEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Os5ODMwmRMfr1p9vKuQy8CQir2xKw3QFxr8Uzjkc465O5171W3mLLREHt2U1towi4
	 qooZjWT5BMgqaKp1+aBmfFS4balt+ljGSx3XyAOmtUlr8hR/xBiYZBBAOsbVBfq+Xu
	 dW2sgeWoBLSWqVMVVLZ7bPQLJ9+M9tEwrjfmQ69qDzV7NNAtqZF/5dIMH2N9ytx7NZ
	 A6b5tHge5xw11uhNZ5u2UIOCpqlxL4f58qhaBpf/pqLzDWeYYgdZyM9zYnRfh7x+bm
	 emtKv3ha3oZXRtFYJxPC3WOJPOZgXKxFVh7YAlmmsQ1gWI+mMACCjtIAyvijK0vSuw
	 a1mfbmEdT6WBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDM-2pom;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/39] scripts: sphinx-pre-install: move missing logic to a separate class
Date: Wed,  9 Jul 2025 15:51:58 +0200
Message-ID: <b7fe13c07cf1d88b37d1ba3a3d6bb6a073a8c6c5.1752067814.git.mchehab+huawei@kernel.org>
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

Better manage dependencies by placing them on a distro-independent
class.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 251 +++++++++++++++++++---------------
 1 file changed, 138 insertions(+), 113 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 592223fa686f..47dce1fcddfb 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -32,7 +32,7 @@ RECOMMENDED_VERSION = parse_version("3.4.3")
 MIN_PYTHON_VERSION = parse_version("3.7")
 
 
-class DepType:
+class DepManager:
 
     # Internal types of dependencies.
     _SYS_TYPE = 0
@@ -53,11 +53,18 @@ class DepType:
     PYTHON_OPTIONAL = (_PHY_TYPE, False)
     PDF_OPTIONAL = (_PDF_TYPE, True)
 
+    def __init__(self, pdf):
+        self.missing = {}
+        self.run = {}
+        self.need = 0
+        self.optional = 0
+        self.pdf = pdf
+
     @staticmethod
     def name(dtype):
-        if dtype[0] == DepType._SYS_TYPE:
+        if dtype[0] == DepManager._SYS_TYPE:
             msg = "build"
-        elif dtype[0] == DepType._PHY_TYPE:
+        elif dtype[0] == DepManager._PHY_TYPE:
             msg = "Python"
         else:
             msg = "PDF"
@@ -73,11 +80,75 @@ class DepType:
 
     @staticmethod
     def is_pdf(dtype):
-        if (dtype[0] == DepType._PDF_TYPE):
+        if (dtype[0] == DepManager._PDF_TYPE):
             return True
 
         return False
 
+    def add_package(self, package, dtype):
+        is_optional = DepManager.is_optional(dtype)
+        self.missing[package] = dtype
+        if is_optional:
+            self.optional += 1
+        else:
+            self.need += 1
+
+    def del_package(self, package):
+        if package in self.missing:
+            del self.missing[package]
+
+    def clear_deps(self):
+        """
+        Clear dependencies without changing needed/optional.
+
+        This is an ackward way to have a separate section to recommend
+        a package after system main dependencies.
+
+        TODO: rework the logic to prevent needing it
+        """
+
+        self.missing = {}
+
+    def check_missing(self, progs):
+        self.run = {}
+
+        for prog, dtype in sorted(self.missing.items()):
+            # At least on some LTS distros like CentOS 7, texlive doesn't
+            # provide all packages we need. When such distros are
+            # detected, we have to disable PDF output.
+            #
+            # So, we need to ignore the packages that distros would
+            # need for LaTeX to work
+            if DepManager.is_pdf(dtype) and not self.pdf:
+                self.optional -= 1
+                continue
+
+            if not dtype in self.run:
+                self.run[dtype] = []
+
+            self.run[dtype].append(progs.get(prog, prog))
+
+        install = []
+        for dtype in self.run.keys():
+            install += self.run[dtype]
+
+        return " ".join(sorted(set(install)))
+
+    def warn_install(self):
+
+        output_msg = ""
+
+        for dtype in sorted(self.run.keys()):
+            progs = " ".join(sorted(set(self.run[dtype])))
+
+            try:
+                name = DepManager.name(dtype)
+                output_msg += f'{name}:\t{progs}\n'
+            except KeyError:
+                raise KeyError(f"ERROR!!!: invalid dtype for {progs}: {dtype}")
+
+        if output_msg:
+            print(f"\n{output_msg}\n")
 
 class SphinxDependencyChecker:
     # List of required texlive packages on Fedora and OpenSuse
@@ -120,10 +191,8 @@ class SphinxDependencyChecker:
         self.virtualenv = args.virtualenv
         self.version_check = args.version_check
 
-        self.missing = {}
+        self.deps = DepManager(self.pdf)
 
-        self.need = 0
-        self.optional = 0
         self.need_symlink = 0
         self.need_sphinx = 0
         self.need_pip = 0
@@ -270,64 +339,18 @@ class SphinxDependencyChecker:
     # Methods to check if a feature exists
     #
 
-    def check_missing(self, progs):
-        run = {}
-
-        for prog, dtype in sorted(self.missing.items()):
-            # At least on some LTS distros like CentOS 7, texlive doesn't
-            # provide all packages we need. When such distros are
-            # detected, we have to disable PDF output.
-            #
-            # So, we need to ignore the packages that distros would
-            # need for LaTeX to work
-            if DepType.is_pdf(dtype) and not self.pdf:
-                self.optional -= 1
-                continue
-
-            if not dtype in run:
-                run[dtype] = []
-
-            run[dtype].append(prog)
-
-        output_msg = ""
-
-        for dtype in sorted(run.keys()):
-            progs = " ".join(run[dtype])
-
-            if self.verbose_warn_install:
-                try:
-                    name = DepType.name(dtype)
-                    output_msg += f'{name}:\t{progs}\n'
-                except KeyError:
-                    raise KeyError(f"ERROR!!!: invalid dtype for {progs}: {dtype}")
-
-            self.install += " " + progs
-
-        if output_msg:
-            print(f"\n{output_msg}\n")
-
-        self.install = self.install.lstrip()
-
-    def add_package(self, package, dtype):
-        is_optional = DepType.is_optional(dtype)
-        self.missing[package] = dtype
-        if is_optional:
-            self.optional += 1
-        else:
-            self.need += 1
-
     def check_missing_file(self, files, package, dtype):
         for f in files:
             if os.path.exists(f):
                 return
-        self.add_package(package, dtype)
+        self.deps.add_package(package, dtype)
 
     def check_program(self, prog, dtype):
         found = self.which(prog)
         if found:
             return found
 
-        self.add_package(prog, dtype)
+        self.deps.add_package(prog, dtype)
 
         return None
 
@@ -340,52 +363,52 @@ class SphinxDependencyChecker:
         # add it as a mandatory package, as some parts of the doc builder
         # needs it.
         if not self.which("perl"):
-            self.add_package("perl", DepType.SYSTEM_MANDATORY)
-            self.add_package(prog, dtype)
+            self.deps.add_package("perl", DepManager.SYSTEM_MANDATORY)
+            self.deps.add_package(prog, dtype)
             return
 
         try:
             self.run(["perl", f"-M{prog}", "-e", "1"], check=True)
         except subprocess.CalledProcessError:
-            self.add_package(prog, dtype)
+            self.deps.add_package(prog, dtype)
 
     def check_python_module(self, module, is_optional=False):
         if is_optional:
-            dtype = DepType.PYTHON_OPTIONAL
+            dtype = DepManager.PYTHON_OPTIONAL
         else:
-            dtype = DepType.PYTHON_MANDATORY
+            dtype = DepManager.PYTHON_MANDATORY
 
         try:
             self.run([self.python_cmd, "-c", f"import {module}"], check=True)
         except subprocess.CalledProcessError:
-            self.add_package(module, dtype)
+            self.deps.add_package(module, dtype)
 
     def check_rpm_missing(self, pkgs, dtype):
         for prog in pkgs:
             try:
                 self.run(["rpm", "-q", prog], check=True)
             except subprocess.CalledProcessError:
-                self.add_package(prog, dtype)
+                self.deps.add_package(prog, dtype)
 
     def check_pacman_missing(self, pkgs, dtype):
         for prog in pkgs:
             try:
                 self.run(["pacman", "-Q", prog], check=True)
             except subprocess.CalledProcessError:
-                self.add_package(prog, dtype)
+                self.deps.add_package(prog, dtype)
 
     def check_missing_tex(self, is_optional=False):
         if is_optional:
-            dtype = DepType.PDF_OPTIONAL
+            dtype = DepManager.PDF_OPTIONAL
         else:
-            dtype = DepType.PDF_MANDATORY
+            dtype = DepManager.PDF_MANDATORY
 
         kpsewhich = self.which("kpsewhich")
         for prog, package in self.texlive.items():
 
             # If kpsewhich is not there, just add it to deps
             if not kpsewhich:
-                self.add_package(package, dtype)
+                self.deps.add_package(package, dtype)
                 continue
 
             # Check if the package is needed
@@ -396,11 +419,11 @@ class SphinxDependencyChecker:
 
                 # Didn't find. Add it
                 if not result.stdout.strip():
-                    self.add_package(package, dtype)
+                    self.deps.add_package(package, dtype)
 
             except subprocess.CalledProcessError:
                 # kpsewhich returned an error. Add it, just in case
-                self.add_package(package, dtype)
+                self.deps.add_package(package, dtype)
 
     def get_sphinx_fname(self):
         if "SPHINXBUILD" in os.environ:
@@ -478,6 +501,17 @@ class SphinxDependencyChecker:
                 return f.read().strip()
         return ""
 
+    def check_missing(self, progs):
+        self.install += self.deps.check_missing(progs)
+        if self.verbose_warn_install:
+            self.deps.warn_install()
+
+        if not self.deps.need and not self.deps.optional:
+            return False
+
+        return True
+
+
     #
     # Distro-specific hints methods
     #
@@ -511,13 +545,11 @@ class SphinxDependencyChecker:
             }
 
             for package, files in pdf_pkgs.items():
-                self.check_missing_file(files, package, DepType.PDF_MANDATORY)
+                self.check_missing_file(files, package, DepManager.PDF_MANDATORY)
 
-            self.check_program("dvipng", DepType.PDF_MANDATORY)
+            self.check_program("dvipng", DepManager.PDF_MANDATORY)
 
-        self.check_missing(progs)
-
-        if not self.need and not self.optional:
+        if self.check_missing(progs):
             return
 
         if self.verbose_warn_install:
@@ -575,7 +607,7 @@ class SphinxDependencyChecker:
             # RHEL 8 uses Python 3.6, which is not compatible with
             # the build system anymore. Suggest Python 3.11
             if rel == 8:
-                self.add_package("python39", DepType.SYSTEM_MANDATORY)
+                self.deps.add_package("python39", DepManager.SYSTEM_MANDATORY)
                 self.recommend_python = True
 
             if self.first_hint:
@@ -597,22 +629,18 @@ class SphinxDependencyChecker:
                 "/usr/share/fonts/google-noto-sans-cjk-fonts/NotoSansCJK-Regular.ttc",
             ]
 
-            self.check_missing_file(pdf_pkgs, noto_sans_redhat, DepType.PDF_MANDATORY)
+            self.check_missing_file(pdf_pkgs, noto_sans_redhat, DepManager.PDF_MANDATORY)
 
-            self.check_rpm_missing(fedora_tex_pkgs, DepType.PDF_MANDATORY)
+            self.check_rpm_missing(fedora_tex_pkgs, DepManager.PDF_MANDATORY)
 
-            self.check_missing_tex(DepType.PDF_MANDATORY)
+            self.check_missing_tex(DepManager.PDF_MANDATORY)
 
             # There's no texlive-ctex on RHEL 8 repositories. This will
             # likely affect CJK pdf build only.
             if not fedora and rel == 8:
-                if "texlive-ctex" in self.missing:
-                    del self.missing["texlive-ctex"]
+                self.deps.del_package("texlive-ctex")
 
-
-        self.check_missing(progs)
-
-        if not self.need and not self.optional:
+        if self.check_missing(progs):
             return
 
         if self.verbose_warn_install:
@@ -659,7 +687,7 @@ class SphinxDependencyChecker:
             if rel == 15:
                 if not self.which(self.python_cmd):
                     self.recommend_python = True
-                    self.add_package(self.python_cmd, DepType.SYSTEM_MANDATORY)
+                    self.deps.add_package(self.python_cmd, DepManager.SYSTEM_MANDATORY)
 
                 progs.update({
                     "python-sphinx": "python311-Sphinx",
@@ -681,12 +709,11 @@ class SphinxDependencyChecker:
         # "Noto Sans CJK SC" on openSUSE
 
         if self.pdf:
-            self.check_rpm_missing(suse_tex_pkgs, DepType.PDF_MANDATORY)
+            self.check_rpm_missing(suse_tex_pkgs, DepManager.PDF_MANDATORY)
         if self.pdf:
             self.check_missing_tex()
-        self.check_missing(progs)
 
-        if not self.need and not self.optional:
+        if self.check_missing(progs):
             return
 
         if self.verbose_warn_install:
@@ -730,13 +757,12 @@ class SphinxDependencyChecker:
                 "/usr/share/fonts/TTF/NotoSans-Regular.ttf",
             ]
 
-            self.check_missing_file(pdf_pkgs, noto_sans, DepType.PDF_MANDATORY)
-            self.check_rpm_missing(tex_pkgs, DepType.PDF_MANDATORY)
+            self.check_missing_file(pdf_pkgs, noto_sans, DepManager.PDF_MANDATORY)
+            self.check_rpm_missing(tex_pkgs, DepManager.PDF_MANDATORY)
 
-        self.check_missing(progs)
-
-        if not self.need and not self.optional:
+        if self.check_missing(progs):
             return
+
         if self.verbose_warn_install:
             print("You should run:")
         print(f"\n\tsudo {packager_cmd} {self.install}")
@@ -759,7 +785,7 @@ class SphinxDependencyChecker:
         ]
 
         if self.pdf:
-            self.check_pacman_missing(archlinux_tex_pkgs, DepType.PDF_MANDATORY)
+            self.check_pacman_missing(archlinux_tex_pkgs, DepManager.PDF_MANDATORY)
 
             self.check_missing_file(
                 ["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
@@ -767,10 +793,9 @@ class SphinxDependencyChecker:
                 2,
             )
 
-        self.check_missing(progs)
-
-        if not self.need and not self.optional:
+        if self.check_missing(progs):
             return
+
         if self.verbose_warn_install:
             print("You should run:")
         print(f"\n\tsudo pacman -S {self.install}")
@@ -797,11 +822,9 @@ class SphinxDependencyChecker:
                 ],
             }
             for package, files in pdf_pkgs.items():
-                self.check_missing_file(files, package, DepType.PDF_MANDATORY)
+                self.check_missing_file(files, package, DepManager.PDF_MANDATORY)
 
-        self.check_missing(progs)
-
-        if not self.need and not self.optional:
+        if self.check_missing(progs):
             return
 
         if self.verbose_warn_install:
@@ -1039,16 +1062,18 @@ class SphinxDependencyChecker:
 
         print("\n2) As a package with:")
 
-        old_need = self.need
-        old_optional = self.optional
-        self.missing = {}
+        old_need = self.deps.need
+        old_optional = self.deps.optional
+
         self.pdf = False
         self.optional = 0
         self.install = ""
         old_verbose = self.verbose_warn_install
         self.verbose_warn_install = 0
 
-        self.add_package("python-sphinx", DepType.PYTHON_MANDATORY)
+        self.deps.clear_deps()
+
+        self.deps.add_package("python-sphinx", DepManager.PYTHON_MANDATORY)
 
         self.check_distros()
 
@@ -1111,7 +1136,7 @@ class SphinxDependencyChecker:
             print("\n")
         else:
             if self.need_sphinx:
-                self.need += 1
+                self.deps.need += 1
 
         # Suggest newer versions if current ones are too old
         if self.latest_avail_ver and self.latest_avail_ver >= self.min_version:
@@ -1190,20 +1215,20 @@ class SphinxDependencyChecker:
                 self.check_python_module("ensurepip")
 
         # Check for needed programs/tools
-        self.check_perl_module("Pod::Usage", DepType.SYSTEM_MANDATORY)
+        self.check_perl_module("Pod::Usage", DepManager.SYSTEM_MANDATORY)
 
-        self.check_program("make", DepType.SYSTEM_MANDATORY)
-        self.check_program("gcc", DepType.SYSTEM_MANDATORY)
+        self.check_program("make", DepManager.SYSTEM_MANDATORY)
+        self.check_program("gcc", DepManager.SYSTEM_MANDATORY)
 
-        self.check_program("dot", DepType.SYSTEM_OPTIONAL)
-        self.check_program("convert", DepType.SYSTEM_OPTIONAL)
+        self.check_program("dot", DepManager.SYSTEM_OPTIONAL)
+        self.check_program("convert", DepManager.SYSTEM_OPTIONAL)
 
         self.check_python_module("yaml")
 
         if self.pdf:
-            self.check_program("xelatex", DepType.PDF_MANDATORY)
-            self.check_program("rsvg-convert", DepType.PDF_MANDATORY)
-            self.check_program("latexmk", DepType.PDF_MANDATORY)
+            self.check_program("xelatex", DepManager.PDF_MANDATORY)
+            self.check_program("rsvg-convert", DepManager.PDF_MANDATORY)
+            self.check_program("latexmk", DepManager.PDF_MANDATORY)
 
         # Do distro-specific checks and output distro-install commands
         self.check_distros()
-- 
2.49.0


