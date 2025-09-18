Return-Path: <linux-kernel+bounces-813850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB74B54B81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905696868C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA930748A;
	Fri, 12 Sep 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCx20zNd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19555301491;
	Fri, 12 Sep 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677595; cv=none; b=k+s+WfppzW9Gow2P15S+6unuapaf1rXvQS84Aktzn1WOGtZO0T/5qAswwC9MS8emuRpaOm3nlNGOsTK5jXxp6fRddZx5Ywx+kf8RMN60ZHeNstRHG7Cqyxvo3XOYJL0TM7tTauqLjJFWamS6V/Qduo9h+bYuvgVjXmevHRL4Ohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677595; c=relaxed/simple;
	bh=clJ3qCwiVt3YkH3nV3uVNkNZaAb+4sP6xwAAtvLuYLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TtEVm3hBRZ/ZCFzBVg2FULLldQgpiRK3Rc9EcC/9zxpSLnY983oHeqCEM9JQVIx1rmnB4ZUup8F5uSye1Hg7eDNZSLaIXyJA04dVNkSo+150ntU3xaH/FZpmBjYRRHJoAbqAi81pS2lWdwOjo+2s9d6gzjcdzrqV7Qx2FjlN/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCx20zNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D048C4CEFD;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=clJ3qCwiVt3YkH3nV3uVNkNZaAb+4sP6xwAAtvLuYLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCx20zNdw6xSLImGuY0+JLgnHfnS9ovuHulrvK/XA2Dk0TQ84Cy4Zv3c9h3cimSy5
	 EzBx11tPqFT8Ze03fBQINZu0skTp0lmKHYWhWKjrnZMqRHdfplTBIpian3ADiE520C
	 xf0uN1ib3AXFB86Q71mFXqgv6We8IzxiBn2Nl+wnWnU0wPw9/9/sTh/NBu3mC6kiVE
	 moyKyUY6QN4Na+hhe9bMSQ2A6s5wEURcuBsCnbTNYuSF/YeR5Dh5emzsTsKoNVjE4T
	 e5UHUN81cMXNOOZvz7iwQrsDdmDs0YNPgP2pFs/MJfRsPuQ6MLBg4oWK6FAC1A79gM
	 blTSVOm2D8I0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008RsP-2swJ;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v5 08/18] tools/docs: sphinx-build-wrapper: add a wrapper for sphinx-build
Date: Fri, 12 Sep 2025 13:46:15 +0200
Message-ID: <caabf42e1553fcd66438b8324c11d6ad94c1db59.1757677427.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757677427.git.mchehab+huawei@kernel.org>
References: <cover.1757677427.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

On a side note, there was a line number increase due to the
conversion (ignoring comments) is:

 Documentation/Makefile          |  131 +++----------
 tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
 2 files changed, 323 insertions(+), 101 deletions(-)

Comments and descriptions adds:
 tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-

So, about half of the script are comments/descriptions.

This is because some things are more verbosed on Python and because
it requires reading env vars from Makefile. Besides it, this script
has some extra features that don't exist at the Makefile:

- It can be called directly from command line;
- It properly return PDF build errors.

When running the script alone, it will only take handle sphinx-build
targets. On other words, it won't runn make rustdoc after building
htmlfiles, nor it will run the extra check scripts.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile          | 131 ++------
 tools/docs/sphinx-build-wrapper | 576 ++++++++++++++++++++++++++++++++
 2 files changed, 606 insertions(+), 101 deletions(-)
 create mode 100755 tools/docs/sphinx-build-wrapper

diff --git a/Documentation/Makefile b/Documentation/Makefile
index deb2029228ed..4736f02b6c9e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -23,21 +23,22 @@ SPHINXOPTS    =
 SPHINXDIRS    = .
 DOCS_THEME    =
 DOCS_CSS      =
-_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
 BUILDDIR      = $(obj)/output
 PDFLATEX      = xelatex
 LATEXOPTS     = -interaction=batchmode -no-shell-escape
 
+PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
+
+# Wrapper for sphinx-build
+
+BUILD_WRAPPER = $(srctree)/tools/docs/sphinx-build-wrapper
+
 # For denylisting "variable font" files
 # Can be overridden by setting as an env variable
 FONTS_CONF_DENY_VF ?= $(HOME)/deny-vf
 
-ifeq ($(findstring 1, $(KBUILD_VERBOSE)),)
-SPHINXOPTS    += "-q"
-endif
-
 # User-friendly check for sphinx-build
 HAVE_SPHINX := $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
@@ -51,63 +52,31 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
-# User-friendly check for pdflatex and latexmk
-HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
-HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
+# Common documentation targets
+infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
+	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" \
+		--builddir="$(BUILDDIR)" \
+		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
 
-ifeq ($(HAVE_LATEXMK),1)
-	PDFLATEX := latexmk -$(PDFLATEX)
-endif #HAVE_LATEXMK
-
-# Internal variables.
-PAPEROPT_a4     = -D latex_elements.papersize=a4paper
-PAPEROPT_letter = -D latex_elements.papersize=letterpaper
-ALLSPHINXOPTS   = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
-ALLSPHINXOPTS   += $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
-ifneq ($(wildcard $(srctree)/.config),)
-ifeq ($(CONFIG_RUST),y)
-	# Let Sphinx know we will include rustdoc
-	ALLSPHINXOPTS   +=  -t rustdoc
-endif
+# Special handling for pdfdocs
+ifeq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)
+pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
+else
+pdfdocs:
+	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
+	@echo "  SKIP    Sphinx $@ target."
 endif
-# the i18n builder cannot share the environment and doctrees with the others
-I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
-
-# commands; the 'cmd' from scripts/Kbuild.include is not *loopable*
-loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
-
-# $2 sphinx builder e.g. "html"
-# $3 name of the build subfolder / e.g. "userspace-api/media", used as:
-#    * dest folder relative to $(BUILDDIR) and
-#    * cache folder relative to $(BUILDDIR)/.doctrees
-# $4 dest subfolder e.g. "man" for man pages at userspace-api/media/man
-# $5 reST source folder relative to $(src),
-#    e.g. "userspace-api/media" for the linux-tv book-set at ./Documentation/userspace-api/media
-
-PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
-
-quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
-      cmd_sphinx = \
-	PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
-	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(src)/$5/$(SPHINX_CONF)) \
-	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
-	$(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
-	$(SPHINXBUILD) \
-	-b $2 \
-	-c $(abspath $(src)) \
-	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
-	-D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
-	$(ALLSPHINXOPTS) \
-	$(abspath $(src)/$5) \
-	$(abspath $(BUILDDIR)/$3/$4) && \
-	if [ "x$(DOCS_CSS)" != "x" ]; then \
-		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
-	fi
 
+# HTML main logic is identical to other targets. However, if rust is enabled,
+# an extra step at the end is required to generate rustdoc.
 htmldocs:
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
-
+	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" \
+		--builddir="$(BUILDDIR)" \
+		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
 # If Rust support is available and .config exists, add rustdoc generated contents.
 # If there are any, the errors from this make rustdoc will be displayed but
 # won't stop the execution of htmldocs
@@ -118,49 +87,6 @@ ifeq ($(CONFIG_RUST),y)
 endif
 endif
 
-texinfodocs:
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
-
-# Note: the 'info' Make target is generated by sphinx itself when
-# running the texinfodocs target define above.
-infodocs: texinfodocs
-	$(MAKE) -C $(BUILDDIR)/texinfo info
-
-linkcheckdocs:
-	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
-
-latexdocs:
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
-
-ifeq ($(HAVE_PDFLATEX),0)
-
-pdfdocs:
-	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
-	@echo "  SKIP    Sphinx $@ target."
-
-else # HAVE_PDFLATEX
-
-pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
-pdfdocs: latexdocs
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	$(foreach var,$(SPHINXDIRS), \
-	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
-	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
-	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
-	)
-
-endif # HAVE_PDFLATEX
-
-epubdocs:
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
-
-xmldocs:
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
-
 endif # HAVE_SPHINX
 
 # The following targets are independent of HAVE_SPHINX, and the rules should
@@ -172,6 +98,9 @@ refcheckdocs:
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
 
+# Used only on help
+_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
+
 dochelp:
 	@echo  ' Linux kernel internal documentation in different formats from ReST:'
 	@echo  '  htmldocs        - HTML'
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
new file mode 100755
index 000000000000..9e17c0dbaccd
--- /dev/null
+++ b/tools/docs/sphinx-build-wrapper
@@ -0,0 +1,576 @@
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
+import shlex
+import shutil
+import subprocess
+import sys
+
+from lib.python_version import PythonVersion
+
+LIB_DIR = "../../scripts/lib"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
+
+from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
+
+#
+#  Some constants
+#
+MIN_PYTHON_VERSION = PythonVersion("3.7").version
+PAPER = ["", "a4", "letter"]
+
+TARGETS = {
+    "cleandocs":     { "builder": "clean" },
+    "linkcheckdocs": { "builder": "linkcheck" },
+    "htmldocs":      { "builder": "html" },
+    "epubdocs":      { "builder": "epub",    "out_dir": "epub" },
+    "texinfodocs":   { "builder": "texinfo", "out_dir": "texinfo" },
+    "infodocs":      { "builder": "texinfo", "out_dir": "texinfo" },
+    "latexdocs":     { "builder": "latex",   "out_dir": "latex" },
+    "pdfdocs":       { "builder": "latex",   "out_dir": "latex" },
+    "xmldocs":       { "builder": "xml",     "out_dir": "xml" },
+}
+
+
+#
+# SphinxBuilder class
+#
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
+    def get_path(self, path, use_cwd=False, abs_path=False):
+        """
+        Ancillary routine to handle patches the right way, as shell does.
+
+        It first expands "~" and "~user". Then, if patch is not absolute,
+        join self.srctree. Finally, if requested, convert to abspath.
+        """
+
+        path = os.path.expanduser(path)
+        if not path.startswith("/"):
+            if use_cwd:
+                base = os.getcwd()
+            else:
+                base = self.srctree
+
+            path = os.path.join(base, path)
+
+        if abs_path:
+            return os.path.abspath(path)
+
+        return path
+
+    def get_sphinx_extra_opts(self, n_jobs):
+        """
+        Get the number of jobs to be used for docs build passed via command
+        line and desired sphinx verbosity.
+
+        The number of jobs can be on different places:
+
+        1) It can be passed via "-j" argument;
+        2) The SPHINXOPTS="-j8" env var may have "-j";
+        3) if called via GNU make, -j specifies the desired number of jobs.
+           with GNU makefile, this number is available via POSIX jobserver;
+        4) if none of the above is available, it should default to "-jauto",
+           and let sphinx decide the best value.
+        """
+
+        #
+        # SPHINXOPTS env var, if used, contains extra arguments to be used
+        # by sphinx-build time. Among them, it may contain sphinx verbosity
+        # and desired number of parallel jobs.
+        #
+        parser = argparse.ArgumentParser()
+        parser.add_argument('-j', '--jobs', type=int)
+        parser.add_argument('-q', '--quiet', type=int)
+
+        #
+        # Other sphinx-build arguments go as-is, so place them
+        # at self.sphinxopts, using shell parser
+        #
+        sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", ""))
+
+        #
+        # Build a list of sphinx args, honoring verbosity here if specified
+        #
+
+        verbose = self.verbose
+        sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
+        if sphinx_args.quiet is True:
+            verbose = False
+
+        #
+        # If the user explicitly sets "-j" at command line, use it.
+        # Otherwise, pick it from SPHINXOPTS args
+        #
+        if n_jobs:
+            self.n_jobs = n_jobs
+        elif sphinx_args.jobs:
+            self.n_jobs = sphinx_args.jobs
+        else:
+            self.n_jobs = None
+
+        if not verbose:
+            self.sphinxopts += ["-q"]
+
+    def __init__(self, builddir, verbose=False, n_jobs=None):
+        """Initialize internal variables"""
+        self.verbose = None
+
+        #
+        # Normal variables passed from Kernel's makefile
+        #
+        self.kernelversion = os.environ.get("KERNELVERSION", "unknown")
+        self.kernelrelease = os.environ.get("KERNELRELEASE", "unknown")
+        self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
+        self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
+
+        if not verbose:
+            verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
+
+        if verbose is not None:
+            self.verbose = verbose
+
+        #
+        # Source tree directory. This needs to be at os.environ, as
+        # Sphinx extensions use it
+        #
+        self.srctree = os.environ.get("srctree")
+        if not self.srctree:
+            self.srctree = "."
+            os.environ["srctree"] = self.srctree
+
+        #
+        # Now that we can expand srctree, get other directories as well
+        #
+        self.sphinxbuild = os.environ.get("SPHINXBUILD", "sphinx-build")
+        self.kerneldoc = self.get_path(os.environ.get("KERNELDOC",
+                                                      "scripts/kernel-doc.py"))
+        self.builddir = self.get_path(builddir, use_cwd=True, abs_path=True)
+
+        self.config_rust = self.is_rust_enabled()
+
+        #
+        # Get directory locations for LaTeX build toolchain
+        #
+        self.pdflatex_cmd = shutil.which(self.pdflatex)
+        self.latexmk_cmd = shutil.which("latexmk")
+
+        self.env = os.environ.copy()
+
+        self.get_sphinx_extra_opts(n_jobs)
+
+    def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
+        """
+        Executes sphinx-build using current python3 command.
+
+        When calling via GNU make, POSIX jobserver is used to tell how
+        many jobs are still available from a job pool. claim all remaining
+        jobs, as we don't want sphinx-build to run in parallel with other
+        jobs.
+
+        Despite that, the user may actually force a different value than
+        the number of available jobs via command line.
+
+        The "with" logic here is used to ensure that the claimed jobs will
+        be freed once subprocess finishes
+        """
+
+        with JobserverExec() as jobserver:
+            if jobserver.claim:
+                #
+                # when GNU make is used, claim available jobs from jobserver
+                #
+                n_jobs = str(jobserver.claim)
+            else:
+                #
+                # Otherwise, let sphinx decide by default
+                #
+                n_jobs = "auto"
+
+            #
+            # If explicitly requested via command line, override default
+            #
+            if self.n_jobs:
+                n_jobs = str(self.n_jobs)
+
+            cmd = [sys.executable, sphinx_build]
+            cmd += [f"-j{n_jobs}"]
+            cmd += self.sphinxopts
+            cmd += build_args
+
+            if self.verbose:
+                print(" ".join(cmd))
+
+            return subprocess.call(cmd, *args, **pwargs)
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
+            #
+            # Process each .tex file
+            #
+
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
+                    #
+                    # LaTeX PDF error code is almost useless for us:
+                    # any warning makes it non-zero. For kernel doc builds it
+                    # always return non-zero even when build succeeds.
+                    # So, let's do the best next thing: check if all PDF
+                    # files were built. If they're, print a summary and
+                    # return 0 at the end of this function
+                    #
+                    try:
+                        subprocess.run(latex_cmd + [entry.path],
+                                       cwd=from_dir, check=True)
+                    except subprocess.CalledProcessError:
+                        pass
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
+        if build_failed:
+            sys.exit("PDF build failed: not all PDF files were created.")
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
+    def cleandocs(self, builder):           # pylint: disable=W0613
+        """Remove documentation output directory"""
+        shutil.rmtree(self.builddir, ignore_errors=True)
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
+        #
+        # Cleandocs doesn't require sphinx-build
+        #
+        if target == "cleandocs":
+            self.cleandocs(builder)
+            return
+
+        if theme:
+            os.environ["DOCS_THEME"] = theme
+
+        #
+        # Other targets require sphinx-build, so check if it exists
+        #
+        sphinxbuild = shutil.which(self.sphinxbuild, path=self.env["PATH"])
+        if not sphinxbuild:
+            sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
+
+        if builder == "latex":
+            if not self.pdflatex_cmd and not self.latexmk_cmd:
+                sys.exit("Error: pdflatex or latexmk required for PDF generation")
+
+        docs_dir = os.path.abspath(os.path.join(self.srctree, "Documentation"))
+
+        #
+        # Fill in base arguments for Sphinx build
+        #
+        kerneldoc = self.kerneldoc
+        if kerneldoc.startswith(self.srctree):
+            kerneldoc = os.path.relpath(kerneldoc, self.srctree)
+
+        args = [ "-b", builder, "-c", docs_dir ]
+
+        if builder == "latex":
+            if not paper:
+                paper = PAPER[1]
+
+            args.extend(["-D", f"latex_elements.papersize={paper}paper"])
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
+        #
+        # sphinxdirs can be a list or a whitespace-separated string
+        #
+        sphinxdirs_list = []
+        for sphinxdir in sphinxdirs:
+            if isinstance(sphinxdir, list):
+                sphinxdirs_list += sphinxdir
+            else:
+                sphinxdirs_list += sphinxdir.split()
+
+        #
+        # Step 1:  Build each directory in separate.
+        #
+        # This is not the best way of handling it, as cross-references between
+        # them will be broken, but this is what we've been doing since
+        # the beginning.
+        #
+        output_dirs = []
+        for sphinxdir in sphinxdirs_list:
+            src_dir = os.path.join(docs_dir, sphinxdir)
+            doctree_dir = os.path.join(self.builddir, ".doctrees")
+            output_dir = os.path.join(self.builddir, sphinxdir, out_dir)
+
+            #
+            # Make directory names canonical
+            #
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
+            try:
+                self.run_sphinx(sphinxbuild, build_args, env=self.env)
+            except (OSError, ValueError, subprocess.SubprocessError) as e:
+                sys.exit(f"Build failed: {repr(e)}")
+
+            #
+            # Ensure that each html/epub output will have needed static files
+            #
+            if target in ["htmldocs", "epubdocs"]:
+                self.handle_html(css, output_dir)
+
+        #
+        # Step 2: Some targets (PDF and info) require an extra step once
+        #         sphinx-build finishes
+        #
+        if target == "pdfdocs":
+            self.handle_pdf(output_dirs)
+        elif target == "infodocs":
+            self.handle_info(output_dirs)
+
+def jobs_type(value):
+    """
+    Handle valid values for -j. Accepts Sphinx "-jauto", plus a number
+    equal or bigger than one.
+    """
+    if value is None:
+        return None
+
+    if value.lower() == 'auto':
+        return value.lower()
+
+    try:
+        if int(value) >= 1:
+            return value
+
+        raise argparse.ArgumentTypeError(f"Minimum jobs is 1, got {value}")
+    except ValueError:
+        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive integer, got {value}")  # pylint: disable=W0707
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
+    parser.add_argument("--builddir", default="output",
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
+    parser.add_argument('-j', '--jobs', type=jobs_type,
+                        help="Sets number of jobs to use with sphinx-build")
+
+    args = parser.parse_args()
+
+    PythonVersion.check_python(MIN_PYTHON_VERSION)
+
+    builder = SphinxBuilder(builddir=args.builddir,
+                            verbose=args.verbose, n_jobs=args.jobs)
+
+    builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
+                  theme=args.theme, css=args.css, paper=args.paper)
+
+if __name__ == "__main__":
+    main()
-- 
2.51.0


