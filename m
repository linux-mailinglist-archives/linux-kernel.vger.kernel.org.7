Return-Path: <linux-kernel+bounces-800170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A6B43442
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE07B1891770
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EF2D1F64;
	Thu,  4 Sep 2025 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQUj1LE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B62BE655;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=oMa+VKoqy8oqz/Yj3n8VOz7HEY98ibVutBN0vRl11P9rqJLs7Jn+AGnivWhEr9jrc/Uy7NLzqxmbSOftk4Jwukz9xA5OEbdjkczEuzyC0rGNP7ifWGyJsmH0A8T5/2uMBzBA/w/KILl/OlJoBGEOrw+5tLHhisgBkO98Qmn6WdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=YKT7sd1ZkHa51vLkotcuMyzse1qM4BPzGd7zz31OQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gO+ojEAouUzdR11SUxWl5qZAp1YiJbKtHKO1/S6NTDkZOEdpvvP5OrcCaqEUHr/arstOfP6DP2E3L965LXrt8PYiJuY19N/d9n+Z9UQNTsiI+gLG7IWX/1Zayr8Naai6/6VWpvv9tJndnFAM+gryJaEcUj1OadhwEcLl7gtql9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQUj1LE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C8C4CEFC;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971207;
	bh=YKT7sd1ZkHa51vLkotcuMyzse1qM4BPzGd7zz31OQF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQUj1LE1vVMzhb/QKi25DXkDIG8pXRMiNbojybUJZQSwn+rXRIRsrOrxGlxdTvnQe
	 vmrTzNmUqnURgXbTLzTf3qOpjHqPy296N261azoM5dXJVEeIR5hPCsa1UuKouqvvh2
	 SWvdMoMeVckWgytMUpcJ6sE2rH3hZFZ/LyAbJKSjerhg0MzbRy/AJY5g1HnP8HMi9Z
	 VPAagqGCgOMGRUR7njW5ynot/SLoJT0fp0GOhp+w303DTZLJjaiSCj3dsXGZIO5E5t
	 qnIbtql3au1r5ufIXdf/5h3jOdVk/t34WgqwiwD1IDkW7TlhbDu8C/Q5ln72C10GJ5
	 zwJ8paEEshTlA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPj-3nDk;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v4 09/19] tools/docs: sphinx-build-wrapper: add comments and blank lines
Date: Thu,  4 Sep 2025 09:33:09 +0200
Message-ID: <e55f276939016551ee13e72712e198736bfbc9ce.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

To help seing the actual size of the script when it was added,
I opted to strip out all comments from the original script.

Add them here:

 tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-
 1 file changed, 257 insertions(+), 4 deletion(-)

As the code from the script has 288 lines of code, it means that
about half of the script are comments.

Also ensure pylint won't report any warnings.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 262 +++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 4 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 3256418d8dc5..ea9f8e17b0bc 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -1,21 +1,71 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+#
+# pylint: disable=R0902, R0912, R0913, R0914, R0915, R0917, C0103
+#
+# Converted from docs Makefile and parallel-wrapper.sh, both under
+# GPLv2, copyrighted since 2008 by the following authors:
+#
+#    Akira Yokosawa <akiyks@gmail.com>
+#    Arnd Bergmann <arnd@arndb.de>
+#    Breno Leitao <leitao@debian.org>
+#    Carlos Bilbao <carlos.bilbao@amd.com>
+#    Dave Young <dyoung@redhat.com>
+#    Donald Hunter <donald.hunter@gmail.com>
+#    Geert Uytterhoeven <geert+renesas@glider.be>
+#    Jani Nikula <jani.nikula@intel.com>
+#    Jan Stancek <jstancek@redhat.com>
+#    Jonathan Corbet <corbet@lwn.net>
+#    Joshua Clayton <stillcompiling@gmail.com>
+#    Kees Cook <keescook@chromium.org>
+#    Linus Torvalds <torvalds@linux-foundation.org>
+#    Magnus Damm <damm+renesas@opensource.se>
+#    Masahiro Yamada <masahiroy@kernel.org>
+#    Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+#    Maxim Cournoyer <maxim.cournoyer@gmail.com>
+#    Peter Foley <pefoley2@pefoley.com>
+#    Randy Dunlap <rdunlap@infradead.org>
+#    Rob Herring <robh@kernel.org>
+#    Shuah Khan <shuahkh@osg.samsung.com>
+#    Thorsten Blum <thorsten.blum@toblux.com>
+#    Tomas Winkler <tomas.winkler@intel.com>
+
+
+"""
+Sphinx build wrapper that handles Kernel-specific business rules:
+
+- it gets the Kernel build environment vars;
+- it determines what's the best parallelism;
+- it handles SPHINXDIRS
+
+This tool ensures that MIN_PYTHON_VERSION is satisfied. If version is
+below that, it seeks for a new Python version. If found, it re-runs using
+the newer version.
+"""
+
 import argparse
 import os
 import shlex
 import shutil
 import subprocess
 import sys
+
 from lib.python_version import PythonVersion
 
 LIB_DIR = "../../scripts/lib"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from jobserver import JobserverExec
+from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 
+#
+#  Some constants
+#
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
 PAPER = ["", "a4", "letter"]
+
 TARGETS = {
     "cleandocs":     { "builder": "clean" },
     "linkcheckdocs": { "builder": "linkcheck" },
@@ -28,8 +78,19 @@ TARGETS = {
     "xmldocs":       { "builder": "xml",     "out_dir": "xml" },
 }
 
+
+#
+# SphinxBuilder class
+#
+
 class SphinxBuilder:
+    """
+    Handles a sphinx-build target, adding needed arguments to build
+    with the Kernel.
+    """
+
     def is_rust_enabled(self):
+        """Check if rust is enabled at .config"""
         config_path = os.path.join(self.srctree, ".config")
         if os.path.isfile(config_path):
             with open(config_path, "r", encoding="utf-8") as f:
@@ -37,41 +98,88 @@ class SphinxBuilder:
         return False
 
     def get_path(self, path, use_cwd=False, abs_path=False):
+        """
+        Ancillary routine to handle patches the right way, as shell does.
+
+        It first expands "~" and "~user". Then, if patch is not absolute,
+        join self.srctree. Finally, if requested, convert to abspath.
+        """
+
         path = os.path.expanduser(path)
         if not path.startswith("/"):
             if use_cwd:
                 base = os.getcwd()
             else:
                 base = self.srctree
+
             path = os.path.join(base, path)
+
         if abs_path:
             return os.path.abspath(path)
+
         return path
 
     def __init__(self, builddir, verbose=False, n_jobs=None):
+        """Initialize internal variables"""
         self.verbose = None
+
+        #
+        # Normal variables passed from Kernel's makefile
+        #
         self.kernelversion = os.environ.get("KERNELVERSION", "unknown")
         self.kernelrelease = os.environ.get("KERNELRELEASE", "unknown")
         self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
         self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
+
         if not verbose:
             verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
+
         if verbose is not None:
             self.verbose = verbose
+
+        #
+        # As we handle number of jobs and quiet in separate, we need to pick
+        # both the same way as sphinx-build would pick, optionally accepts
+        # whitespaces or not. So let's use argparse to handle argument expansion
+        #
         parser = argparse.ArgumentParser()
         parser.add_argument('-j', '--jobs', type=int)
         parser.add_argument('-q', '--quiet', type=int)
+
+        #
+        # Other sphinx-build arguments go as-is, so place them
+        # at self.sphinxopts, using shell parser
+        #
         sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", ""))
+
+        #
+        # Build a list of sphinx args
+        #
         sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
         if sphinx_args.quiet is True:
             self.verbose = False
+
         if sphinx_args.jobs:
             self.n_jobs = sphinx_args.jobs
+
+        #
+        # If the command line argument "-j" is used override SPHINXOPTS
+        #
+
         self.n_jobs = n_jobs
+
+        #
+        # Source tree directory. This needs to be at os.environ, as
+        # Sphinx extensions use it
+        #
         self.srctree = os.environ.get("srctree")
         if not self.srctree:
             self.srctree = "."
             os.environ["srctree"] = self.srctree
+
+        #
+        # Now that we can expand srctree, get other directories as well
+        #
         self.sphinxbuild = os.environ.get("SPHINXBUILD", "sphinx-build")
         self.kerneldoc = self.get_path(os.environ.get("KERNELDOC",
                                                       "scripts/kernel-doc.py"))
@@ -79,20 +187,36 @@ class SphinxBuilder:
 
         self.config_rust = self.is_rust_enabled()
 
+        #
+        # Get directory locations for LaTeX build toolchain
+        #
         self.pdflatex_cmd = shutil.which(self.pdflatex)
         self.latexmk_cmd = shutil.which("latexmk")
 
         self.env = os.environ.copy()
 
     def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
+        """
+        Executes sphinx-build using current python3 command and setting
+        -j parameter if possible to run the build in parallel.
+        """
+
         with JobserverExec() as jobserver:
             if jobserver.claim:
                 n_jobs = str(jobserver.claim)
             else:
                 n_jobs = "auto" # Supported since Sphinx 1.7
+
             cmd = []
+
             cmd.append(sys.executable)
+
             cmd.append(sphinx_build)
+
+            #
+            # Override auto setting, if explicitly passed from command line
+            # or via SPHINXOPTS
+            #
             if self.n_jobs:
                 n_jobs = str(self.n_jobs)
 
@@ -101,59 +225,100 @@ class SphinxBuilder:
 
             if not self.verbose:
                 cmd.append("-q")
+
             cmd += self.sphinxopts
             cmd += build_args
+
             if self.verbose:
                 print(" ".join(cmd))
             return subprocess.call(cmd, *args, **pwargs)
 
     def handle_html(self, css, output_dir):
+        """
+        Extra steps for HTML and epub output.
+
+        For such targets, we need to ensure that CSS will be properly
+        copied to the output _static directory
+        """
+
         if not css:
             return
+
         css = os.path.expanduser(css)
         if not css.startswith("/"):
             css = os.path.join(self.srctree, css)
+
         static_dir = os.path.join(output_dir, "_static")
         os.makedirs(static_dir, exist_ok=True)
+
         try:
             shutil.copy2(css, static_dir)
         except (OSError, IOError) as e:
             print(f"Warning: Failed to copy CSS: {e}", file=sys.stderr)
 
     def handle_pdf(self, output_dirs):
+        """
+        Extra steps for PDF output.
+
+        As PDF is handled via a LaTeX output, after building the .tex file,
+        a new build is needed to create the PDF output from the latex
+        directory.
+        """
         builds = {}
         max_len = 0
+
         for from_dir in output_dirs:
             pdf_dir = os.path.join(from_dir, "../pdf")
             os.makedirs(pdf_dir, exist_ok=True)
+
             if self.latexmk_cmd:
                 latex_cmd = [self.latexmk_cmd, f"-{self.pdflatex}"]
             else:
                 latex_cmd = [self.pdflatex]
+
             latex_cmd.extend(shlex.split(self.latexopts))
+
             tex_suffix = ".tex"
+
+            #
+            # Process each .tex file
+            #
+
             has_tex = False
             build_failed = False
             with os.scandir(from_dir) as it:
                 for entry in it:
                     if not entry.name.endswith(tex_suffix):
                         continue
+
                     name = entry.name[:-len(tex_suffix)]
                     has_tex = True
+
+                    #
+                    # LaTeX PDF error code is almost useless for us:
+                    # any warning makes it non-zero. For kernel doc builds it
+                    # always return non-zero even when build succeeds.
+                    # So, let's do the best next thing: check if all PDF
+                    # files were built. If they're, print a summary and
+                    # return 0 at the end of this function
+                    #
                     try:
                         subprocess.run(latex_cmd + [entry.path],
                                        cwd=from_dir, check=True)
                     except subprocess.CalledProcessError:
                         pass
+
                     pdf_name = name + ".pdf"
                     pdf_from = os.path.join(from_dir, pdf_name)
                     pdf_to = os.path.join(pdf_dir, pdf_name)
+
                     if os.path.exists(pdf_from):
                         os.rename(pdf_from, pdf_to)
                         builds[name] = os.path.relpath(pdf_to, self.builddir)
                     else:
                         builds[name] = "FAILED"
                         build_failed = True
+
                     name = entry.name.removesuffix(".tex")
                     max_len = max(max_len, len(name))
 
@@ -162,58 +327,100 @@ class SphinxBuilder:
                 max_len = max(max_len, len(name))
                 builds[name] = "FAILED (no .tex)"
                 build_failed = True
+
         msg = "Summary"
         msg += "\n" + "=" * len(msg)
         print()
         print(msg)
+
         for pdf_name, pdf_file in builds.items():
             print(f"{pdf_name:<{max_len}}: {pdf_file}")
+
         print()
+
         if build_failed:
             sys.exit("PDF build failed: not all PDF files were created.")
         else:
             print("All PDF files were built.")
 
     def handle_info(self, output_dirs):
+        """
+        Extra steps for Info output.
+
+        For texinfo generation, an additional make is needed from the
+        texinfo directory.
+        """
+
         for output_dir in output_dirs:
             try:
                 subprocess.run(["make", "info"], cwd=output_dir, check=True)
             except subprocess.CalledProcessError as e:
                 sys.exit(f"Error generating info docs: {e}")
 
-    def cleandocs(self, builder):
+    def cleandocs(self, builder):           # pylint: disable=W0613
+        """Remove documentation output directory"""
         shutil.rmtree(self.builddir, ignore_errors=True)
 
     def build(self, target, sphinxdirs=None, conf="conf.py",
               theme=None, css=None, paper=None):
+        """
+        Build documentation using Sphinx. This is the core function of this
+        module. It prepares all arguments required by sphinx-build.
+        """
+
         builder = TARGETS[target]["builder"]
         out_dir = TARGETS[target].get("out_dir", "")
+
+        #
+        # Cleandocs doesn't require sphinx-build
+        #
         if target == "cleandocs":
             self.cleandocs(builder)
             return
+
         if theme:
-                os.environ["DOCS_THEME"] = theme
+            os.environ["DOCS_THEME"] = theme
+
+        #
+        # Other targets require sphinx-build, so check if it exists
+        #
         sphinxbuild = shutil.which(self.sphinxbuild, path=self.env["PATH"])
         if not sphinxbuild:
             sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
+
         if builder == "latex":
             if not self.pdflatex_cmd and not self.latexmk_cmd:
                 sys.exit("Error: pdflatex or latexmk required for PDF generation")
+
         docs_dir = os.path.abspath(os.path.join(self.srctree, "Documentation"))
+
+        #
+        # Fill in base arguments for Sphinx build
+        #
         kerneldoc = self.kerneldoc
         if kerneldoc.startswith(self.srctree):
             kerneldoc = os.path.relpath(kerneldoc, self.srctree)
+
         args = [ "-b", builder, "-c", docs_dir ]
+
         if builder == "latex":
             if not paper:
                 paper = PAPER[1]
+
             args.extend(["-D", f"latex_elements.papersize={paper}paper"])
+
         if self.config_rust:
             args.extend(["-t", "rustdoc"])
+
         if conf:
             self.env["SPHINX_CONF"] = self.get_path(conf, abs_path=True)
+
         if not sphinxdirs:
             sphinxdirs = os.environ.get("SPHINXDIRS", ".")
+
+        #
+        # sphinxdirs can be a list or a whitespace-separated string
+        #
         sphinxdirs_list = []
         for sphinxdir in sphinxdirs:
             if isinstance(sphinxdir, list):
@@ -221,17 +428,32 @@ class SphinxBuilder:
             else:
                 for name in sphinxdir.split(" "):
                     sphinxdirs_list.append(name)
+
+        #
+        # Step 1:  Build each directory in separate.
+        #
+        # This is not the best way of handling it, as cross-references between
+        # them will be broken, but this is what we've been doing since
+        # the beginning.
+        #
         output_dirs = []
         for sphinxdir in sphinxdirs_list:
             src_dir = os.path.join(docs_dir, sphinxdir)
             doctree_dir = os.path.join(self.builddir, ".doctrees")
             output_dir = os.path.join(self.builddir, sphinxdir, out_dir)
+
+            #
+            # Make directory names canonical
+            #
             src_dir = os.path.normpath(src_dir)
             doctree_dir = os.path.normpath(doctree_dir)
             output_dir = os.path.normpath(output_dir)
+
             os.makedirs(doctree_dir, exist_ok=True)
             os.makedirs(output_dir, exist_ok=True)
+
             output_dirs.append(output_dir)
+
             build_args = args + [
                 "-d", doctree_dir,
                 "-D", f"kerneldoc_bin={kerneldoc}",
@@ -241,31 +463,54 @@ class SphinxBuilder:
                 src_dir,
                 output_dir,
             ]
+
             try:
                 self.run_sphinx(sphinxbuild, build_args, env=self.env)
             except (OSError, ValueError, subprocess.SubprocessError) as e:
                 sys.exit(f"Build failed: {repr(e)}")
+
+            #
+            # Ensure that each html/epub output will have needed static files
+            #
             if target in ["htmldocs", "epubdocs"]:
                 self.handle_html(css, output_dir)
+
+        #
+        # Step 2: Some targets (PDF and info) require an extra step once
+        #         sphinx-build finishes
+        #
         if target == "pdfdocs":
             self.handle_pdf(output_dirs)
         elif target == "infodocs":
             self.handle_info(output_dirs)
 
 def jobs_type(value):
+    """
+    Handle valid values for -j. Accepts Sphinx "-jauto", plus a number
+    equal or bigger than one.
+    """
     if value is None:
         return None
+
     if value.lower() == 'auto':
         return value.lower()
+
     try:
         if int(value) >= 1:
             return value
+
         raise argparse.ArgumentTypeError(f"Minimum jobs is 1, got {value}")
     except ValueError:
-        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive integer, got {value}")
+        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive integer, got {value}")  # pylint: disable=W0707
 
 def main():
+    """
+    Main function. The only mandatory argument is the target. If not
+    specified, the other arguments will use default values if not
+    specified at os.environ.
+    """
     parser = argparse.ArgumentParser(description="Kernel documentation builder")
+
     parser.add_argument("target", choices=list(TARGETS.keys()),
                         help="Documentation target to build")
     parser.add_argument("--sphinxdirs", nargs="+",
@@ -274,18 +519,27 @@ def main():
                         help="Sphinx configuration file")
     parser.add_argument("--builddir", default="output",
                         help="Sphinx configuration file")
+
     parser.add_argument("--theme", help="Sphinx theme to use")
+
     parser.add_argument("--css", help="Custom CSS file for HTML/EPUB")
+
     parser.add_argument("--paper", choices=PAPER, default=PAPER[0],
                         help="Paper size for LaTeX/PDF output")
+
     parser.add_argument("-v", "--verbose", action='store_true',
                         help="place build in verbose mode")
+
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
+
     args = parser.parse_args()
+
     PythonVersion.check_python(MIN_PYTHON_VERSION)
+
     builder = SphinxBuilder(builddir=args.builddir,
                             verbose=args.verbose, n_jobs=args.jobs)
+
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
 
-- 
2.51.0


