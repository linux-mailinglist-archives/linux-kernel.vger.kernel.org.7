Return-Path: <linux-kernel+bounces-824815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A655B8A355
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB2B3B1163
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5732315D4A;
	Fri, 19 Sep 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJhtR63y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAA26056E;
	Fri, 19 Sep 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294607; cv=none; b=C54rPyDEriSrVo6DAOT07jZr0vUN2867Pk696HovJVnZ5wrEl91auBvlq8ktZCFH19+QFehJSWXSBZU2BglE1t3hJHfbmKBslyOZgqt7MQnnwPl7/rrvduZN9zyZ2P2KgaLOyzEGOFSc6+vlx6GGxD4pywsZISd6aUZPxitI66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294607; c=relaxed/simple;
	bh=d+U0ApuT0lf/mrZa1eeHe/NYSYYBWpqLUfCWZxik1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua3GAzgjk6utpK2G25r+L5RDrKZy1jxZxylsTt6jCzjfD419gCbX4vo3mxLVAPC9FuFZYEZf/w0N8+BWEv3272uXab3KKLEB2xvSYTlM4gfW8DVFwpi0L/kVtvO7LQL7K1vow7e7r9mVACdnUs52g0jWO1rp+TNIeaI1uNHKfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJhtR63y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC892C4CEF1;
	Fri, 19 Sep 2025 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758294606;
	bh=d+U0ApuT0lf/mrZa1eeHe/NYSYYBWpqLUfCWZxik1qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJhtR63y5aBBJtlNEYa7aFVNz5ZUik882lUfttax+hZUvKKZrzo3YrBuVJuMc5IvI
	 /7BswJhphrLLIrAtxlpY6vZ5t4+ikjscLYiyq9jZQr4nRqa/feUUP2apH6m7u5JPUp
	 tEIzDG+pKWs8ZgHPJxXYQyT+Y8xbuwOploYKwueNk58mtt7NgCifcqTok1wZzz8rqP
	 Byi7DAhgVqz4hAmnIgZaRsXE96a9QHBtfzdYDBMHzwZ6cDdtO+kaHs8DR3Tzeod0Uv
	 0zjyNt9i+4loo/rhDHxJ2uQ7ledThZOaJ989opQbth6TfmvWfy+j43MkPdPnssfv1Z
	 MqqfGtgoQWV4Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzckO-0000000443h-3Wpo;
	Fri, 19 Sep 2025 17:10:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: conf.py: get rid of load_config.py
Date: Fri, 19 Sep 2025 17:10:00 +0200
Message-ID: <65ce87136d8f4a74e88e956a3a5bc3ba9a528be4.1758294450.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758294450.git.mchehab+huawei@kernel.org>
References: <cover.1758294450.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile              |  4 --
 Documentation/conf.py               | 15 +++-----
 Documentation/sphinx/load_config.py | 60 -----------------------------
 3 files changed, 5 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/sphinx/load_config.py

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6ccd5db1dcbd..9663e7a31feb 100644
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
-- 
2.51.0


