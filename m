Return-Path: <linux-kernel+bounces-770850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC4AB27F96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC079B620BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38D30498C;
	Fri, 15 Aug 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRGZFgqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1313009ED;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=WOYXu/r5mL5YX8Cc5qyiFqPt07+j+fLMtPStEkwV2h1HMaPSiAu6V2gmlSM7eGnUbGa7lAyKSur6Nlwupu3XO02QbEg3WjfXEmDmb7gSlBdfGzg17yEwVMWVBM5fK1hcoRTBzS9Ypxtx0JeDkNIdeorFdT19NrRGbwE8rQEjN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=zumhMRghLThqkpHf4QwjSWnxlXD8mXBUhoe7SLsig1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4ACOw4Fkvu5MqM8G6xZX71OKDycjFaudEUKMfa2tLsOqYHKpXP2lyTTAqfcJXoSBcCuqj13WkZlGw3FaXsE0UMqhaLkeKnI/bvoenN9dyucT0Gj0xZROnifpC4s25BccqWeTXSryqfFKjaV3MY16flajum8w2TbfdTKsN4GzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRGZFgqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BCC4CEF8;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258666;
	bh=zumhMRghLThqkpHf4QwjSWnxlXD8mXBUhoe7SLsig1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRGZFgqSQixi8wGJlByklO+ePIz27GiRzUoLm1djZgzEY+bcZRg+zVW2DH4IwgLjZ
	 sv7AZFdUcTZyodzNZX1/JGPkYWuZThk+o3f2v6VI98cn1Vs2nCJ0UjT7Jc0z+NbfIQ
	 UWzC/N9xe7N15fH7NwK9c9fLkmCOdmQ/TDgO1OlF4iCHlfQTPxIR2nTuXX0R8bzNRn
	 5huQRR4kBx/snn1z7zE5O0e6vTdcxIEezVY14ZtMLDSJ5VDALpwQCes0NPhsIuxUMH
	 Nlqg3zcTnmAohNDBfluRvuxiA0byAWHaL7vF5KNd7TeDzS8MYZdaIAB5A54RMgxfMW
	 aZbR4GA/l+9Fg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042oS-0K5P;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for sphinx-build
Date: Fri, 15 Aug 2025 13:50:32 +0200
Message-ID: <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are too much magic inside docs Makefile to properly run
sphinx-build. Create an ancillary script that contains all
kernel-related sphinx-build call logic currently at Makefile.

Such script is designed to work both as an standalone command
and as part of a Makefile. As such, it properly handles POSIX
jobserver used by GNU make.

It should be noticed that, when running the script alone,
it will only take care of sphinx-build and cleandocs target.
As such:

- it won't run "make rustdoc";
- no extra checks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .pylintrc                    |   2 +-
 scripts/sphinx-build-wrapper | 627 +++++++++++++++++++++++++++++++++++
 2 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100755 scripts/sphinx-build-wrapper

diff --git a/.pylintrc b/.pylintrc
index 30b8ae1659f8..f1d21379254b 100644
--- a/.pylintrc
+++ b/.pylintrc
@@ -1,2 +1,2 @@
 [MASTER]
-init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
+init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi"]'
diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
new file mode 100755
index 000000000000..5c728956b53c
--- /dev/null
+++ b/scripts/sphinx-build-wrapper
@@ -0,0 +1,627 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
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
+import argparse
+import os
+import re
+import shlex
+import shutil
+import subprocess
+import sys
+
+from glob import glob
+
+LIB_DIR = "lib"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
+
+from jobserver import JobserverExec                  # pylint: disable=C0413
+
+
+def parse_version(version):
+    """Convert a major.minor.patch version into a tuple"""
+    return tuple(int(x) for x in version.split("."))
+
+def ver_str(version):
+    """Returns a version tuple as major.minor.patch"""
+
+    return ".".join([str(x) for x in version])
+
+# Minimal supported Python version needed by Sphinx and its extensions
+MIN_PYTHON_VERSION = parse_version("3.7")
+
+# Default value for --venv parameter
+VENV_DEFAULT = "sphinx_latest"
+
+# List of make targets and its corresponding builder and output directory
+TARGETS = {
+    "cleandocs": {
+        "builder": "clean",
+    },
+    "htmldocs": {
+        "builder": "html",
+    },
+    "epubdocs": {
+        "builder": "epub",
+        "out_dir": "epub",
+    },
+    "texinfodocs": {
+        "builder": "texinfo",
+        "out_dir": "texinfo",
+    },
+    "infodocs": {
+        "builder": "texinfo",
+        "out_dir": "texinfo",
+    },
+    "latexdocs": {
+        "builder": "latex",
+        "out_dir": "latex",
+    },
+    "pdfdocs": {
+        "builder": "latex",
+        "out_dir": "latex",
+    },
+    "xmldocs": {
+        "builder": "xml",
+        "out_dir": "xml",
+    },
+    "linkcheckdocs": {
+        "builder": "linkcheck"
+    },
+}
+
+# Paper sizes. An empty value will pick the default
+PAPER = ["", "a4", "letter"]
+
+class SphinxBuilder:
+    """
+    Handles a sphinx-build target, adding needed arguments to build
+    with the Kernel.
+    """
+
+    def is_rust_enabled(self):
+        """Check if rust is enabled at .config"""
+        config_path = os.path.join(self.srctree, ".config")
+        if os.path.isfile(config_path):
+            with open(config_path, "r", encoding="utf-8") as f:
+                return "CONFIG_RUST=y" in f.read()
+        return False
+
+    def get_path(self, path, abs_path=False):
+        """
+        Ancillary routine to handle patches the right way, as shell does.
+
+        It first expands "~" and "~user". Then, if patch is not absolute,
+        join self.srctree. Finally, if requested, convert to abspath.
+        """
+
+        path = os.path.expanduser(path)
+        if not path.startswith("/"):
+            path = os.path.join(self.srctree, path)
+
+        if abs_path:
+            return os.path.abspath(path)
+
+        return path
+
+    def __init__(self, venv=None, verbose=False):
+        """Initialize internal variables"""
+        self.venv = venv
+        self.verbose = verbose
+
+        # Normal variables passed from Kernel's makefile
+        self.kernelversion = os.environ.get("KERNELVERSION", "unknown")
+        self.kernelrelease = os.environ.get("KERNELRELEASE", "unknown")
+        self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
+        self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
+
+        # Source tree directory. This needs to be at os.environ, as
+        # Sphinx extensions and media uAPI makefile needs it
+        self.srctree = os.environ.get("srctree")
+        if not self.srctree:
+            self.srctree = "."
+            os.environ["srctree"] = self.srctree
+
+        # Now that we can expand srctree, get other directories as well
+        self.sphinxbuild = os.environ.get("SPHINXBUILD", "sphinx-build")
+        self.kerneldoc = self.get_path(os.environ.get("KERNELDOC",
+                                                      "scripts/kernel-doc.py"))
+        self.obj = os.environ.get("obj", "Documentation")
+        self.builddir = self.get_path(os.path.join(self.obj, "output"),
+                                      abs_path=True)
+
+        # Media uAPI needs it
+        os.environ["BUILDDIR"] = self.builddir
+
+        # Detect if rust is enabled
+        self.config_rust = self.is_rust_enabled()
+
+        # Get directory locations for LaTeX build toolchain
+        self.pdflatex_cmd = shutil.which(self.pdflatex)
+        self.latexmk_cmd = shutil.which("latexmk")
+
+        self.env = os.environ.copy()
+
+        # If venv parameter is specified, run Sphinx from venv
+        if venv:
+            bin_dir = os.path.join(venv, "bin")
+            if os.path.isfile(os.path.join(bin_dir, "activate")):
+                # "activate" virtual env
+                self.env["PATH"] = bin_dir + ":" + self.env["PATH"]
+                self.env["VIRTUAL_ENV"] = venv
+                if "PYTHONHOME" in self.env:
+                    del self.env["PYTHONHOME"]
+                print(f"Setting venv to {venv}")
+            else:
+                sys.exit(f"Venv {venv} not found.")
+
+    def run_sphinx(self, sphinx_build, sphinx_args, *args, **pwargs):
+        """
+        Executes sphinx-build using current python3 command and setting
+        -j parameter if possible to run the build in parallel.
+        """
+
+        with JobserverExec() as jobserver:
+            if jobserver.claim:
+                parallelism = str(jobserver.claim)
+            else:
+                # As Sphinx has parallelism since version 1.7, we don't need
+                # any check here.
+                parallelism = "auto"
+
+            cmd = []
+
+            if self.venv:
+                cmd.append("python")
+            else:
+                cmd.append(sys.executable)
+
+            cmd.append(sphinx_build)
+
+            if parallelism:
+                cmd.append("-j" + parallelism)
+
+            cmd += sphinx_args
+
+            if self.verbose:
+                print(" ".join(cmd))
+
+            rc = subprocess.call(cmd, *args, **pwargs)
+
+    def handle_html(self, css, output_dir):
+        """
+        Extra steps for HTML and epub output.
+
+        For such targets, we need to ensure that CSS will be properly
+        copied to the output _static directory
+        """
+
+        if not css:
+            return
+
+        css = os.path.expanduser(css)
+        if not css.startswith("/"):
+            css = os.path.join(self.srctree, css)
+
+        static_dir = os.path.join(output_dir, "_static")
+        os.makedirs(static_dir, exist_ok=True)
+
+        try:
+            shutil.copy2(css, static_dir)
+        except (OSError, IOError) as e:
+            print(f"Warning: Failed to copy CSS: {e}", file=sys.stderr)
+
+    def handle_pdf(self, output_dirs):
+        """
+        Extra steps for PDF output.
+
+        As PDF is handled via a LaTeX output, after building the .tex file,
+        a new build is needed to create the PDF output from the latex
+        directory.
+        """
+        builds = {}
+        max_len = 0
+
+        for from_dir in output_dirs:
+            pdf_dir = os.path.join(from_dir, "../pdf")
+            os.makedirs(pdf_dir, exist_ok=True)
+
+            if self.latexmk_cmd:
+                latex_cmd = [self.latexmk_cmd, f"-{self.pdflatex}"]
+            else:
+                latex_cmd = [self.pdflatex]
+
+            latex_cmd.extend(shlex.split(self.latexopts))
+
+            tex_suffix = ".tex"
+
+            # Process each .tex file
+            has_tex = False
+            build_failed = False
+            with os.scandir(from_dir) as it:
+                for entry in it:
+                    if not entry.name.endswith(tex_suffix):
+                        continue
+
+                    name = entry.name[:-len(tex_suffix)]
+                    has_tex = True
+
+                    try:
+                        subprocess.run(latex_cmd + [entry.path],
+                                       cwd=from_dir, check=True)
+                    except subprocess.CalledProcessError:
+                        # LaTeX PDF error code is almost useless: it returns
+                        # error codes even when build succeeds but has warnings.
+                        pass
+
+                    # Instead of checking errors, let's do the next best thing:
+                    # check if the PDF file was actually created.
+
+                    pdf_name = name + ".pdf"
+                    pdf_from = os.path.join(from_dir, pdf_name)
+                    pdf_to = os.path.join(pdf_dir, pdf_name)
+
+                    if os.path.exists(pdf_from):
+                        os.rename(pdf_from, pdf_to)
+                        builds[name] = os.path.relpath(pdf_to, self.builddir)
+                    else:
+                        builds[name] = "FAILED"
+                        build_failed = True
+
+                    name = entry.name.removesuffix(".tex")
+                    max_len = max(max_len, len(name))
+
+            if not has_tex:
+                name = os.path.basename(from_dir)
+                max_len = max(max_len, len(name))
+                builds[name] = "FAILED (no .tex)"
+                build_failed = True
+
+        msg = "Summary"
+        msg += "\n" + "=" * len(msg)
+        print()
+        print(msg)
+
+        for pdf_name, pdf_file in builds.items():
+            print(f"{pdf_name:<{max_len}}: {pdf_file}")
+
+        print()
+
+        # return an error if a PDF file is missing
+
+        if build_failed:
+            sys.exit(f"PDF build failed: not all PDF files were created.")
+        else:
+            print("All PDF files were built.")
+
+    def handle_info(self, output_dirs):
+        """
+        Extra steps for Info output.
+
+        For texinfo generation, an additional make is needed from the
+        texinfo directory.
+        """
+
+        for output_dir in output_dirs:
+            try:
+                subprocess.run(["make", "info"], cwd=output_dir, check=True)
+            except subprocess.CalledProcessError as e:
+                sys.exit(f"Error generating info docs: {e}")
+
+    def get_make_media(self):
+        """
+        The media uAPI requires an additional Makefile target.
+        """
+
+        mediadir = f"{self.obj}/userspace-api/media"
+
+        make = os.environ.get("MAKE", "make")
+        build = os.environ.get("build", "-f $(srctree)/scripts/Makefile.build obj")
+
+        # Check if the script was started outside docs Makefile
+        if not os.environ.get("obj"):
+            mediadir = os.path.abspath(mediadir)
+
+        # the build makefile var contains macros that require expand
+        make_media = f"{make} {build}={mediadir}"
+        make_media = make_media.replace("$(", "${").replace(")", "}")
+        make_media = os.path.expandvars(make_media)
+
+        # As it also contains multiple arguments, use shlex to split it
+        return shlex.split(make_media)
+
+    def prepare_media(self, builder):
+        """
+        Run userspace-api/media Makefile.
+
+        The logic behind it are from the initial ports to Sphinx.
+        They're old and need to be replaced by a proper Sphinx extension.
+        While we don't do that, we need to explicitly call media Makefile
+        to build some files.
+        """
+
+        cmd = self.get_make_media() + [builder]
+
+        if self.verbose:
+            print(" ".join(cmd))
+
+        with JobserverExec() as jobserver:
+            rc = jobserver.run(cmd, env=self.env)
+
+        if rc:
+            cmd_str = " ".join(cmd)
+            sys.exit(f"Failed to run {cmd_str}")
+
+    def cleandocs(self, builder):
+
+        shutil.rmtree(self.builddir, ignore_errors=True)
+
+        self.prepare_media(builder)
+
+    def build(self, target, sphinxdirs=None, conf="conf.py",
+              theme=None, css=None, paper=None):
+        """
+        Build documentation using Sphinx. This is the core function of this
+        module. It prepares all arguments required by sphinx-build.
+        """
+
+        builder = TARGETS[target]["builder"]
+        out_dir = TARGETS[target].get("out_dir", "")
+
+        # Cleandocs doesn't require sphinx-build
+        if target == "cleandocs":
+            self.cleandocs(builder)
+            return
+
+        # Other targets require sphinx-build
+        sphinxbuild = shutil.which(self.sphinxbuild, path=self.env["PATH"])
+        if not sphinxbuild:
+            sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
+
+        self.prepare_media(builder)
+
+        if builder == "latex":
+            if not self.pdflatex_cmd and not self.latexmk_cmd:
+                sys.exit("Error: pdflatex or latexmk required for PDF generation")
+
+        docs_dir = os.path.abspath(os.path.join(self.srctree, "Documentation"))
+
+        # Prepare base arguments for Sphinx build
+        kerneldoc = self.kerneldoc
+        if kerneldoc.startswith(self.srctree):
+            kerneldoc = os.path.relpath(kerneldoc, self.srctree)
+
+        # Prepare common Sphinx options
+        args = [
+            "-b", builder,
+            "-c", docs_dir,
+        ]
+
+        if builder == "latex":
+            if not paper:
+                paper = PAPER[1]
+
+            args.extend(["-D", f"latex_elements.papersize={paper}paper"])
+
+        if not self.verbose:
+            args.append("-q")
+
+        if self.config_rust:
+            args.extend(["-t", "rustdoc"])
+
+        if conf:
+            self.env["SPHINX_CONF"] = self.get_path(conf, abs_path=True)
+
+        if not sphinxdirs:
+            sphinxdirs = os.environ.get("SPHINXDIRS", ".")
+
+        # sphinxdirs can be a list or a whitespace-separated string
+        sphinxdirs_list = []
+        for sphinxdir in sphinxdirs:
+            if isinstance(sphinxdir, list):
+                sphinxdirs_list += sphinxdir
+            else:
+                for name in sphinxdir.split(" "):
+                    sphinxdirs_list.append(name)
+
+        # Build each directory
+        output_dirs = []
+        for sphinxdir in sphinxdirs_list:
+            src_dir = os.path.join(docs_dir, sphinxdir)
+            doctree_dir = os.path.join(self.builddir, ".doctrees")
+            output_dir = os.path.join(self.builddir, sphinxdir, out_dir)
+
+            # Make directory names canonical
+            src_dir = os.path.normpath(src_dir)
+            doctree_dir = os.path.normpath(doctree_dir)
+            output_dir = os.path.normpath(output_dir)
+
+            os.makedirs(doctree_dir, exist_ok=True)
+            os.makedirs(output_dir, exist_ok=True)
+
+            output_dirs.append(output_dir)
+
+            build_args = args + [
+                "-d", doctree_dir,
+                "-D", f"kerneldoc_bin={kerneldoc}",
+                "-D", f"version={self.kernelversion}",
+                "-D", f"release={self.kernelrelease}",
+                "-D", f"kerneldoc_srctree={self.srctree}",
+                src_dir,
+                output_dir,
+            ]
+
+            # Execute sphinx-build
+            try:
+                self.run_sphinx(sphinxbuild, build_args, env=self.env)
+            except Exception as e:
+                sys.exit(f"Build failed: {e}")
+
+            # Ensure that html/epub will have needed static files
+            if target in ["htmldocs", "epubdocs"]:
+                self.handle_html(css, output_dir)
+
+        # PDF and Info require a second build step
+        if target == "pdfdocs":
+            self.handle_pdf(output_dirs)
+        elif target == "infodocs":
+            self.handle_info(output_dirs)
+
+    @staticmethod
+    def get_python_version(cmd):
+        """
+        Get python version from a Python binary. As we need to detect if
+        are out there newer python binaries, we can't rely on sys.release here.
+        """
+
+        result = subprocess.run([cmd, "--version"], check=True,
+                                stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                universal_newlines=True)
+        version = result.stdout.strip()
+
+        match = re.search(r"(\d+\.\d+\.\d+)", version)
+        if match:
+            return parse_version(match.group(1))
+
+        print(f"Can't parse version {version}")
+        return (0, 0, 0)
+
+    @staticmethod
+    def find_python():
+        """
+        Detect if are out there any python 3.xy version newer than the
+        current one.
+
+        Note: this routine is limited to up to 2 digits for python3. We
+        may need to update it one day, hopefully on a distant future.
+        """
+        patterns = [
+            "python3.[0-9]",
+            "python3.[0-9][0-9]",
+        ]
+
+        # Seek for a python binary newer than MIN_PYTHON_VERSION
+        for path in os.getenv("PATH", "").split(":"):
+            for pattern in patterns:
+                for cmd in glob(os.path.join(path, pattern)):
+                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
+                        version = SphinxBuilder.get_python_version(cmd)
+                        if version >= MIN_PYTHON_VERSION:
+                            return cmd
+
+        return None
+
+    @staticmethod
+    def check_python():
+        """
+        Check if the current python binary satisfies our minimal requirement
+        for Sphinx build. If not, re-run with a newer version if found.
+        """
+        cur_ver = sys.version_info[:3]
+        if cur_ver >= MIN_PYTHON_VERSION:
+            return
+
+        python_ver = ver_str(cur_ver)
+
+        new_python_cmd = SphinxBuilder.find_python()
+        if not new_python_cmd:
+            sys.exit(f"Python version {python_ver} is not supported anymore.")
+
+        # Restart script using the newer version
+        script_path = os.path.abspath(sys.argv[0])
+        args = [new_python_cmd, script_path] + sys.argv[1:]
+
+        print(f"Python {python_ver} not supported. Changing to {new_python_cmd}")
+
+        try:
+            os.execv(new_python_cmd, args)
+        except OSError as e:
+            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
+
+def main():
+    """
+    Main function. The only mandatory argument is the target. If not
+    specified, the other arguments will use default values if not
+    specified at os.environ.
+    """
+    parser = argparse.ArgumentParser(description="Kernel documentation builder")
+
+    parser.add_argument("target", choices=list(TARGETS.keys()),
+                        help="Documentation target to build")
+    parser.add_argument("--sphinxdirs", nargs="+",
+                        help="Specific directories to build")
+    parser.add_argument("--conf", default="conf.py",
+                        help="Sphinx configuration file")
+
+    parser.add_argument("--theme", help="Sphinx theme to use")
+
+    parser.add_argument("--css", help="Custom CSS file for HTML/EPUB")
+
+    parser.add_argument("--paper", choices=PAPER, default=PAPER[0],
+                        help="Paper size for LaTeX/PDF output")
+
+    parser.add_argument("-v", "--verbose", action='store_true',
+                        help="place build in verbose mode")
+
+    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
+                        default=None,
+                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
+
+    args = parser.parse_args()
+
+    if not args.verbose:
+        args.verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
+
+    SphinxBuilder.check_python()
+
+    builder = SphinxBuilder(venv=args.venv, verbose=args.verbose)
+
+    builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
+                  theme=args.theme, css=args.css, paper=args.paper)
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1


