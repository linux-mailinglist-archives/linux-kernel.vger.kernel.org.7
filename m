Return-Path: <linux-kernel+bounces-825601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D69B8C4E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1767BA56C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6662D29DF;
	Sat, 20 Sep 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtiOIKho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E42BCF6C;
	Sat, 20 Sep 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361235; cv=none; b=TD89Or3asdEQ5XE/po3XTtr45MjItVa5s+1I22nSz7besLWzKlwxgvpmcOpre360w+1KMd4sZb6R6hCHzmwU6IeaosRbPpJeJ6eenlGqREVeoBJqD8m+I6chAs2R68YudBnX3JzkUhJD3AmsC2B6EvZtwEs/T2EhSQC5KXoe6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361235; c=relaxed/simple;
	bh=WHTz4K/+gXPtwbZlcDEI2A9/nF0QW3Djurh6SQGC4UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/bX9MUSJ4cZZ60TrWYgQ5OtVpMgEIftwGP3beJMVhxaYc2gbC6FVgvnMvWBx9JRGrEf1BFCHCntnI6dNvn5BrBcSC6kqEVKEP8V8xZvku4/mrQi8nltfKka3rEf1CL/5SwEPQLPs45Zp878s0GI4G/SPDMbUHbaR5kntlthxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtiOIKho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E2BC4CEFB;
	Sat, 20 Sep 2025 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758361234;
	bh=WHTz4K/+gXPtwbZlcDEI2A9/nF0QW3Djurh6SQGC4UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtiOIKhokvz4pPlAviU9iAJMEvfQ2LpBOUDKRVvGxYrY7jjLD4/TUIUqSNOhP3TG+
	 iShLI6xS4HuPOhCS3iXOqgbaPSrXYsp3zBNkuGkpQd/mXoPOYUFVhhs9nIyCCKIAD/
	 bfT1oEW+YpaHKHS3qejmiehTAE0TboeTdnDTwemNl6UUgKGF6OliU91Ud383QXKRc1
	 n3HRh8TuZAjSvu811k4g4971kVQ0FwoF77Um3D7bhO0uLVi3evf04HoCIvUq7SwqQp
	 TlFOfL/2KqkUPhArCOpauhoBlBR4nCPcJ89dYFylRhuK7ckQrKbYVIf+m9MnVTLnQa
	 XoZd073+6UNew==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzu52-00000004Z30-1c6G;
	Sat, 20 Sep 2025 11:40:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] docs: conf.py: get rid of load_config.py
Date: Sat, 20 Sep 2025 11:40:26 +0200
Message-ID: <ec998f9f268a401ca6aa36e3221d39c97efeccaa.1758361087.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758361087.git.mchehab+huawei@kernel.org>
References: <cover.1758361087.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The code here was meant to handle 3 functions:
1. allow having a separate conf.py file, per subdir;
2. generate a list of latex documents.
3. set "subproject" tag if SPHINXDIRS points to a subdir.

We don't have (1) anymore, and (3) is now properly handled
entirely inside conf.py.

So, only (3) is still needed, and this is a single-line change
at conf.py.

So, drop it, moving the remaining code to conf.py.

While here, drop a duplicated $(RUSTDOC) command-line argument.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile              |  8 +---
 Documentation/conf.py               | 15 +++-----
 Documentation/sphinx/load_config.py | 60 -----------------------------
 tools/docs/sphinx-build-wrapper     |  9 +----
 4 files changed, 9 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/sphinx/load_config.py

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6ccd5db1dcbd..cc4ee55c75ed 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -24,7 +24,6 @@ SPHINXDIRS    = .
 DOCS_THEME    =
 DOCS_CSS      =
 RUSTDOC       =
-SPHINX_CONF   = conf.py
 PAPER         =
 BUILDDIR      = $(obj)/output
 PDFLATEX      = xelatex
@@ -60,8 +59,8 @@ else # HAVE_SPHINX
 # Common documentation targets
 htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
 	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
-	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ $(RUSTDOC)\
-		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" $(RUSTDOC)\
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+		--sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
 		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
 		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
 
@@ -108,9 +107,6 @@ dochelp:
 	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'
 	@echo  '  valid values for SPHINXDIRS are: $(_SPHINXDIRS)'
 	@echo
-	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
-	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
-	@echo
 	@echo  '  make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
 	@echo
 	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 574896cca198..1ea2ae5c6276 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -18,8 +18,6 @@ import sphinx
 # documentation root, use os.path.abspath to make it absolute, like shown here.
 sys.path.insert(0, os.path.abspath("sphinx"))
 
-from load_config import loadConfig               # pylint: disable=C0413,E0401
-
 # Minimal supported version
 needs_sphinx = "3.4.3"
 
@@ -93,8 +91,12 @@ def config_init(app, config):
     # LaTeX and PDF output require a list of documents with are dependent
     # of the app.srcdir. Add them here
 
-    # When SPHINXDIRS is used, we just need to get index.rst, if it exists
+    # Handle the case where SPHINXDIRS is used
     if not os.path.samefile(doctree, app.srcdir):
+        # Add a tag to mark that the build is actually a subproject
+        tags.add("subproject")
+
+        # get index.rst, if it exists
         doc = os.path.basename(app.srcdir)
         fname = "index"
         if os.path.exists(os.path.join(app.srcdir, fname + ".rst")):
@@ -583,13 +585,6 @@ pdf_documents = [
 kerneldoc_bin = "../scripts/kernel-doc.py"
 kerneldoc_srctree = ".."
 
-# ------------------------------------------------------------------------------
-# Since loadConfig overwrites settings from the global namespace, it has to be
-# the last statement in the conf.py file
-# ------------------------------------------------------------------------------
-loadConfig(globals())
-
-
 def setup(app):
     """Patterns need to be updated at init time on older Sphinx versions"""
 
diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx/load_config.py
deleted file mode 100644
index 1afb0c97f06b..000000000000
--- a/Documentation/sphinx/load_config.py
+++ /dev/null
@@ -1,60 +0,0 @@
-# -*- coding: utf-8; mode: python -*-
-# SPDX-License-Identifier: GPL-2.0
-# pylint: disable=R0903, C0330, R0914, R0912, E0401
-
-import os
-import sys
-from sphinx.util.osutil import fs_encoding
-
-# ------------------------------------------------------------------------------
-def loadConfig(namespace):
-# ------------------------------------------------------------------------------
-
-    """Load an additional configuration file into *namespace*.
-
-    The name of the configuration file is taken from the environment
-    ``SPHINX_CONF``. The external configuration file extends (or overwrites) the
-    configuration values from the origin ``conf.py``.  With this you are able to
-    maintain *build themes*.  """
-
-    config_file = os.environ.get("SPHINX_CONF", None)
-    if (config_file is not None
-        and os.path.normpath(namespace["__file__"]) != os.path.normpath(config_file) ):
-        config_file = os.path.abspath(config_file)
-
-        # Let's avoid one conf.py file just due to latex_documents
-        start = config_file.find('Documentation/')
-        if start >= 0:
-            start = config_file.find('/', start + 1)
-
-        end = config_file.rfind('/')
-        if start >= 0 and end > 0:
-            dir = config_file[start + 1:end]
-
-            print("source directory: %s" % dir)
-            new_latex_docs = []
-            latex_documents = namespace['latex_documents']
-
-            for l in latex_documents:
-                if l[0].find(dir + '/') == 0:
-                    has = True
-                    fn = l[0][len(dir) + 1:]
-                    new_latex_docs.append((fn, l[1], l[2], l[3], l[4]))
-                    break
-
-            namespace['latex_documents'] = new_latex_docs
-
-        # If there is an extra conf.py file, load it
-        if os.path.isfile(config_file):
-            sys.stdout.write("load additional sphinx-config: %s\n" % config_file)
-            config = namespace.copy()
-            config['__file__'] = config_file
-            with open(config_file, 'rb') as f:
-                code = compile(f.read(), fs_encoding, 'exec')
-                exec(code, config)
-            del config['__file__']
-            namespace.update(config)
-        else:
-            config = namespace.copy()
-            config['tags'].add("subproject")
-            namespace.update(config)
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index b7e97c10d7dc..bd8e2ed746e7 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -602,7 +602,7 @@ class SphinxBuilder:
         """Remove documentation output directory"""
         shutil.rmtree(self.builddir, ignore_errors=True)
 
-    def build(self, target, sphinxdirs=None, conf="conf.py",
+    def build(self, target, sphinxdirs=None,
               theme=None, css=None, paper=None, deny_vf=None, rustdoc=False):
         """
         Build documentation using Sphinx. This is the core function of this
@@ -653,9 +653,6 @@ class SphinxBuilder:
         if rustdoc:
             args.extend(["-t", "rustdoc"])
 
-        if conf:
-            self.env["SPHINX_CONF"] = self.get_path(conf, abs_path=True)
-
         if not sphinxdirs:
             sphinxdirs = os.environ.get("SPHINXDIRS", ".")
 
@@ -773,8 +770,6 @@ def main():
                         help="Documentation target to build")
     parser.add_argument("--sphinxdirs", nargs="+",
                         help="Specific directories to build")
-    parser.add_argument("--conf", default="conf.py",
-                        help="Sphinx configuration file")
     parser.add_argument("--builddir", default="output",
                         help="Sphinx configuration file")
 
@@ -813,7 +808,7 @@ def main():
                             verbose=args.verbose, n_jobs=args.jobs,
                             interactive=args.interactive)
 
-    builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
+    builder.build(args.target, sphinxdirs=args.sphinxdirs,
                   theme=args.theme, css=args.css, paper=args.paper,
                   rustdoc=args.rustdoc, deny_vf=args.deny_vf)
 
-- 
2.51.0


