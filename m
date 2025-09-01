Return-Path: <linux-kernel+bounces-794808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD51B3E794
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610FC7AF26B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2089934A318;
	Mon,  1 Sep 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTTZiBve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAA341668;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737758; cv=none; b=HTpW4vUOzNHgKs8KMz8A1sz9vmA0PSuedCv5OOJFTzMO3b7IF/mTVA3OK6Ev+HSeCl0j55H9igMY9zNtn/0Vl2B/3UIQfBVjjOFCzms0MwjE9bWs/HSVeweQLoF+FCQKxNBpyjCamm7JSxgg5TZljfYlZXGLxDk0zwgxuf0pAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737758; c=relaxed/simple;
	bh=oD4FBcBQjtiNTF4iSRqBZutlnQxTGiilKL7CoiFSPug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxKgGQKIZDKnPT1uZZckrTSsXRdM2R1vcvIFNjbKFd18z4MD8hSrLxF7B0/S2yy6ucOdqTfBnmA2Iryg5VLPdEozUsQnrmhhS+bjX0O9LnkksYVcFzVblDj5njfrIbfW7HZjtmCfVslRJWNPMDQJMVQkHLgXRIWKkg6tXWVpWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTTZiBve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9FFC4CEF1;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=oD4FBcBQjtiNTF4iSRqBZutlnQxTGiilKL7CoiFSPug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTTZiBveIIwBvm5/zzdb6SWF1NYjKfzv1HsAunt5Jg3D7B9CfbuEh4NrJb07LRlMd
	 Bnc50hA5FVLm9ExDs9jOydNkzGnylwdI4AyMlC9oGy4ASIH5zabKfSqhxenMFqLHEl
	 z/QeT6M+4glB9no4LK0UX5R9bcSZU358BIZB6nGzE+J4i3SUqYPuchAMawT237wbCG
	 1qdYoZAqcWO8UuR+CZ+p7KAUl84YthrgxuXx9csMrAiKT3qXwWyjb+hPZdNeyw4XWJ
	 WLffOQ5Yq9dkFbGn5GX1obucRmwI9P4oMJC5epHQS5vBCCC18N7xaj2t54DHIA7P/C
	 0SNanTMxxWy8g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3U-2aPm;
	Mon, 01 Sep 2025 16:42:35 +0200
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
Subject: [PATCH v3 06/15] tools/docs: sphinx-build-wrapper: add a wrapper for
  sphinx-build
Date: Mon,  1 Sep 2025 16:42:22 +0200
Message-ID: <5c0343b17cf6413006db577c3e2060552cc6ea3a.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are too much magic inside docs Makefile to properly run=0D
sphinx-build. Create an ancillary script that contains all=0D
kernel-related sphinx-build call logic currently at Makefile.=0D
=0D
Such script is designed to work both as an standalone command=0D
and as part of a Makefile. As such, it properly handles POSIX=0D
jobserver used by GNU make.=0D
=0D
On a side note, there was a line number increase due to the=0D
conversion:=0D
=0D
$ git show|diffstat -p1=0D
 Documentation/Makefile          |  129 +++-------------=0D
 tools/docs/sphinx-build-wrapper |  288 +++++++++++++++++++++++++++++++++++=
++=0D
 2 files changed, 316 insertions(+), 101 deletions(-)=0D
=0D
This is because some things are more verbosed on Python and because=0D
it requires reading env vars from Makefile. Besides it, this script=0D
has some extra features that don't exist at the Makefile:=0D
=0D
- It can be called directly from command line;=0D
- It properly return PDF build errors.=0D
=0D
When running the script alone, it will only take handle sphinx-build=0D
targets. On other words, it won't runn make rustdoc after building=0D
htmlfiles, nor it will run the extra check scripts.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 Documentation/Makefile          | 129 ++++----------=0D
 tools/docs/sphinx-build-wrapper | 288 ++++++++++++++++++++++++++++++++=0D
 2 files changed, 316 insertions(+), 101 deletions(-)=0D
 create mode 100755 tools/docs/sphinx-build-wrapper=0D
=0D
diff --git a/Documentation/Makefile b/Documentation/Makefile=0D
index deb2029228ed..2b0ed8cd5ea8 100644=0D
--- a/Documentation/Makefile=0D
+++ b/Documentation/Makefile=0D
@@ -23,21 +23,22 @@ SPHINXOPTS    =3D=0D
 SPHINXDIRS    =3D .=0D
 DOCS_THEME    =3D=0D
 DOCS_CSS      =3D=0D
-_SPHINXDIRS   =3D $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%=
,$(wildcard $(srctree)/Documentation/*/index.rst)))=0D
 SPHINX_CONF   =3D conf.py=0D
 PAPER         =3D=0D
 BUILDDIR      =3D $(obj)/output=0D
 PDFLATEX      =3D xelatex=0D
 LATEXOPTS     =3D -interaction=3Dbatchmode -no-shell-escape=0D
 =0D
+PYTHONPYCACHEPREFIX ?=3D $(abspath $(BUILDDIR)/__pycache__)=0D
+=0D
+# Wrapper for sphinx-build=0D
+=0D
+BUILD_WRAPPER =3D $(srctree)/tools/docs/sphinx-build-wrapper=0D
+=0D
 # For denylisting "variable font" files=0D
 # Can be overridden by setting as an env variable=0D
 FONTS_CONF_DENY_VF ?=3D $(HOME)/deny-vf=0D
 =0D
-ifeq ($(findstring 1, $(KBUILD_VERBOSE)),)=0D
-SPHINXOPTS    +=3D "-q"=0D
-endif=0D
-=0D
 # User-friendly check for sphinx-build=0D
 HAVE_SPHINX :=3D $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then ech=
o 1; else echo 0; fi)=0D
 =0D
@@ -51,63 +52,29 @@ ifeq ($(HAVE_SPHINX),0)=0D
 =0D
 else # HAVE_SPHINX=0D
 =0D
-# User-friendly check for pdflatex and latexmk=0D
-HAVE_PDFLATEX :=3D $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo=
 1; else echo 0; fi)=0D
-HAVE_LATEXMK :=3D $(shell if which latexmk >/dev/null 2>&1; then echo 1; e=
lse echo 0; fi)=0D
+# Common documentation targets=0D
+infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:=0D
+	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \=0D
+		--sphinxdirs=3D"$(SPHINXDIRS)" --conf=3D$(SPHINX_CONF) \=0D
+		--theme=3D$(DOCS_THEME) --css=3D$(DOCS_CSS) --paper=3D$(PAPER)=0D
 =0D
-ifeq ($(HAVE_LATEXMK),1)=0D
-	PDFLATEX :=3D latexmk -$(PDFLATEX)=0D
-endif #HAVE_LATEXMK=0D
-=0D
-# Internal variables.=0D
-PAPEROPT_a4     =3D -D latex_elements.papersize=3Da4paper=0D
-PAPEROPT_letter =3D -D latex_elements.papersize=3Dletterpaper=0D
-ALLSPHINXOPTS   =3D -D kerneldoc_srctree=3D$(srctree) -D kerneldoc_bin=3D$=
(KERNELDOC)=0D
-ALLSPHINXOPTS   +=3D $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)=0D
-ifneq ($(wildcard $(srctree)/.config),)=0D
-ifeq ($(CONFIG_RUST),y)=0D
-	# Let Sphinx know we will include rustdoc=0D
-	ALLSPHINXOPTS   +=3D  -t rustdoc=0D
-endif=0D
+# Special handling for pdfdocs=0D
+ifeq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)=0D
+pdfdocs: DENY_VF =3D XDG_CONFIG_HOME=3D$(FONTS_CONF_DENY_VF)=0D
+else=0D
+pdfdocs:=0D
+	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it =
installed and in PATH to produce PDF output.)=0D
+	@echo "  SKIP    Sphinx $@ target."=0D
 endif=0D
-# the i18n builder cannot share the environment and doctrees with the othe=
rs=0D
-I18NSPHINXOPTS  =3D $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .=0D
-=0D
-# commands; the 'cmd' from scripts/Kbuild.include is not *loopable*=0D
-loop_cmd =3D $(echo-cmd) $(cmd_$(1)) || exit;=0D
-=0D
-# $2 sphinx builder e.g. "html"=0D
-# $3 name of the build subfolder / e.g. "userspace-api/media", used as:=0D
-#    * dest folder relative to $(BUILDDIR) and=0D
-#    * cache folder relative to $(BUILDDIR)/.doctrees=0D
-# $4 dest subfolder e.g. "man" for man pages at userspace-api/media/man=0D
-# $5 reST source folder relative to $(src),=0D
-#    e.g. "userspace-api/media" for the linux-tv book-set at ./Documentati=
on/userspace-api/media=0D
-=0D
-PYTHONPYCACHEPREFIX ?=3D $(abspath $(BUILDDIR)/__pycache__)=0D
-=0D
-quiet_cmd_sphinx =3D SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)=0D
-      cmd_sphinx =3D \=0D
-	PYTHONPYCACHEPREFIX=3D"$(PYTHONPYCACHEPREFIX)" \=0D
-	BUILDDIR=3D$(abspath $(BUILDDIR)) SPHINX_CONF=3D$(abspath $(src)/$5/$(SPH=
INX_CONF)) \=0D
-	$(PYTHON3) $(srctree)/scripts/jobserver-exec \=0D
-	$(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \=0D
-	$(SPHINXBUILD) \=0D
-	-b $2 \=0D
-	-c $(abspath $(src)) \=0D
-	-d $(abspath $(BUILDDIR)/.doctrees/$3) \=0D
-	-D version=3D$(KERNELVERSION) -D release=3D$(KERNELRELEASE) \=0D
-	$(ALLSPHINXOPTS) \=0D
-	$(abspath $(src)/$5) \=0D
-	$(abspath $(BUILDDIR)/$3/$4) && \=0D
-	if [ "x$(DOCS_CSS)" !=3D "x" ]; then \=0D
-		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(=
DOCS_CSS)) $(BUILDDIR)/$3/_static/; \=0D
-	fi=0D
 =0D
+# HTML main logic is identical to other targets. However, if rust is enabl=
ed,=0D
+# an extra step at the end is required to generate rustdoc.=0D
 htmldocs:=0D
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var))=
)=0D
-=0D
+	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \=0D
+		--sphinxdirs=3D"$(SPHINXDIRS)" --conf=3D$(SPHINX_CONF) \=0D
+		--theme=3D$(DOCS_THEME) --css=3D$(DOCS_CSS) --paper=3D$(PAPER)=0D
 # If Rust support is available and .config exists, add rustdoc generated c=
ontents.=0D
 # If there are any, the errors from this make rustdoc will be displayed bu=
t=0D
 # won't stop the execution of htmldocs=0D
@@ -118,49 +85,6 @@ ifeq ($(CONFIG_RUST),y)=0D
 endif=0D
 endif=0D
 =0D
-texinfodocs:=0D
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texin=
fo,$(var)))=0D
-=0D
-# Note: the 'info' Make target is generated by sphinx itself when=0D
-# running the texinfodocs target define above.=0D
-infodocs: texinfodocs=0D
-	$(MAKE) -C $(BUILDDIR)/texinfo info=0D
-=0D
-linkcheckdocs:=0D
-	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(v=
ar)))=0D
-=0D
-latexdocs:=0D
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$=
(var)))=0D
-=0D
-ifeq ($(HAVE_PDFLATEX),0)=0D
-=0D
-pdfdocs:=0D
-	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it =
installed and in PATH to produce PDF output.)=0D
-	@echo "  SKIP    Sphinx $@ target."=0D
-=0D
-else # HAVE_PDFLATEX=0D
-=0D
-pdfdocs: DENY_VF =3D XDG_CONFIG_HOME=3D$(FONTS_CONF_DENY_VF)=0D
-pdfdocs: latexdocs=0D
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
-	$(foreach var,$(SPHINXDIRS), \=0D
-	   $(MAKE) PDFLATEX=3D"$(PDFLATEX)" LATEXOPTS=3D"$(LATEXOPTS)" $(DENY_VF)=
 -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.=
sh || exit; \=0D
-	   mkdir -p $(BUILDDIR)/$(var)/pdf; \=0D
-	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUI=
LDDIR)/$(var)/pdf/; \=0D
-	)=0D
-=0D
-endif # HAVE_PDFLATEX=0D
-=0D
-epubdocs:=0D
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(v=
ar)))=0D
-=0D
-xmldocs:=0D
-	@$(srctree)/tools/docs/sphinx-pre-install --version-check=0D
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var=
)))=0D
-=0D
 endif # HAVE_SPHINX=0D
 =0D
 # The following targets are independent of HAVE_SPHINX, and the rules shou=
ld=0D
@@ -172,6 +96,9 @@ refcheckdocs:=0D
 cleandocs:=0D
 	$(Q)rm -rf $(BUILDDIR)=0D
 =0D
+# Used only on help=0D
+_SPHINXDIRS   =3D $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%=
,$(wildcard $(srctree)/Documentation/*/index.rst)))=0D
+=0D
 dochelp:=0D
 	@echo  ' Linux kernel internal documentation in different formats from Re=
ST:'=0D
 	@echo  '  htmldocs        - HTML'=0D
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrap=
per=0D
new file mode 100755=0D
index 000000000000..df469af8a4ef=0D
--- /dev/null=0D
+++ b/tools/docs/sphinx-build-wrapper=0D
@@ -0,0 +1,288 @@=0D
+#!/usr/bin/env python3=0D
+# SPDX-License-Identifier: GPL-2.0=0D
+import argparse=0D
+import os=0D
+import shlex=0D
+import shutil=0D
+import subprocess=0D
+import sys=0D
+from lib.python_version import PythonVersion=0D
+=0D
+LIB_DIR =3D "../../scripts/lib"=0D
+SRC_DIR =3D os.path.dirname(os.path.realpath(__file__))=0D
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))=0D
+=0D
+from jobserver import JobserverExec=0D
+=0D
+MIN_PYTHON_VERSION =3D PythonVersion("3.7").version=0D
+PAPER =3D ["", "a4", "letter"]=0D
+TARGETS =3D {=0D
+    "cleandocs":     { "builder": "clean" },=0D
+    "linkcheckdocs": { "builder": "linkcheck" },=0D
+    "htmldocs":      { "builder": "html" },=0D
+    "epubdocs":      { "builder": "epub",    "out_dir": "epub" },=0D
+    "texinfodocs":   { "builder": "texinfo", "out_dir": "texinfo" },=0D
+    "infodocs":      { "builder": "texinfo", "out_dir": "texinfo" },=0D
+    "latexdocs":     { "builder": "latex",   "out_dir": "latex" },=0D
+    "pdfdocs":       { "builder": "latex",   "out_dir": "latex" },=0D
+    "xmldocs":       { "builder": "xml",     "out_dir": "xml" },=0D
+}=0D
+=0D
+class SphinxBuilder:=0D
+    def is_rust_enabled(self):=0D
+        config_path =3D os.path.join(self.srctree, ".config")=0D
+        if os.path.isfile(config_path):=0D
+            with open(config_path, "r", encoding=3D"utf-8") as f:=0D
+                return "CONFIG_RUST=3Dy" in f.read()=0D
+        return False=0D
+=0D
+    def get_path(self, path, abs_path=3DFalse):=0D
+        path =3D os.path.expanduser(path)=0D
+        if not path.startswith("/"):=0D
+            path =3D os.path.join(self.srctree, path)=0D
+        if abs_path:=0D
+            return os.path.abspath(path)=0D
+        return path=0D
+=0D
+    def __init__(self, verbose=3DFalse, n_jobs=3DNone):=0D
+        self.verbose =3D None=0D
+        self.kernelversion =3D os.environ.get("KERNELVERSION", "unknown")=
=0D
+        self.kernelrelease =3D os.environ.get("KERNELRELEASE", "unknown")=
=0D
+        self.pdflatex =3D os.environ.get("PDFLATEX", "xelatex")=0D
+        self.latexopts =3D os.environ.get("LATEXOPTS", "-interaction=3Dbat=
chmode -no-shell-escape")=0D
+        if not verbose:=0D
+            verbose =3D bool(os.environ.get("KBUILD_VERBOSE", "") !=3D "")=
=0D
+        if verbose is not None:=0D
+            self.verbose =3D verbose=0D
+        parser =3D argparse.ArgumentParser()=0D
+        parser.add_argument('-j', '--jobs', type=3Dint)=0D
+        parser.add_argument('-q', '--quiet', type=3Dint)=0D
+        sphinxopts =3D shlex.split(os.environ.get("SPHINXOPTS", ""))=0D
+        sphinx_args, self.sphinxopts =3D parser.parse_known_args(sphinxopt=
s)=0D
+        if sphinx_args.quiet is True:=0D
+            self.verbose =3D False=0D
+        if sphinx_args.jobs:=0D
+            self.n_jobs =3D sphinx_args.jobs=0D
+        self.n_jobs =3D n_jobs=0D
+        self.srctree =3D os.environ.get("srctree")=0D
+        if not self.srctree:=0D
+            self.srctree =3D "."=0D
+            os.environ["srctree"] =3D self.srctree=0D
+        self.sphinxbuild =3D os.environ.get("SPHINXBUILD", "sphinx-build")=
=0D
+        self.kerneldoc =3D self.get_path(os.environ.get("KERNELDOC",=0D
+                                                      "scripts/kernel-doc.=
py"))=0D
+        self.obj =3D os.environ.get("obj", "Documentation")=0D
+        self.builddir =3D self.get_path(os.path.join(self.obj, "output"),=
=0D
+                                      abs_path=3DTrue)=0D
+=0D
+        self.config_rust =3D self.is_rust_enabled()=0D
+=0D
+        self.pdflatex_cmd =3D shutil.which(self.pdflatex)=0D
+        self.latexmk_cmd =3D shutil.which("latexmk")=0D
+=0D
+        self.env =3D os.environ.copy()=0D
+=0D
+    def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):=0D
+        with JobserverExec() as jobserver:=0D
+            if jobserver.claim:=0D
+                n_jobs =3D str(jobserver.claim)=0D
+            else:=0D
+                n_jobs =3D "auto" # Supported since Sphinx 1.7=0D
+            cmd =3D []=0D
+            cmd.append(sys.executable)=0D
+            cmd.append(sphinx_build)=0D
+            if self.n_jobs:=0D
+                n_jobs =3D str(self.n_jobs)=0D
+=0D
+            if n_jobs:=0D
+                cmd +=3D [f"-j{n_jobs}"]=0D
+=0D
+            if not self.verbose:=0D
+                cmd.append("-q")=0D
+            cmd +=3D self.sphinxopts=0D
+            cmd +=3D build_args=0D
+            if self.verbose:=0D
+                print(" ".join(cmd))=0D
+            return subprocess.call(cmd, *args, **pwargs)=0D
+=0D
+    def handle_html(self, css, output_dir):=0D
+        if not css:=0D
+            return=0D
+        css =3D os.path.expanduser(css)=0D
+        if not css.startswith("/"):=0D
+            css =3D os.path.join(self.srctree, css)=0D
+        static_dir =3D os.path.join(output_dir, "_static")=0D
+        os.makedirs(static_dir, exist_ok=3DTrue)=0D
+        try:=0D
+            shutil.copy2(css, static_dir)=0D
+        except (OSError, IOError) as e:=0D
+            print(f"Warning: Failed to copy CSS: {e}", file=3Dsys.stderr)=
=0D
+=0D
+    def handle_pdf(self, output_dirs):=0D
+        builds =3D {}=0D
+        max_len =3D 0=0D
+        for from_dir in output_dirs:=0D
+            pdf_dir =3D os.path.join(from_dir, "../pdf")=0D
+            os.makedirs(pdf_dir, exist_ok=3DTrue)=0D
+            if self.latexmk_cmd:=0D
+                latex_cmd =3D [self.latexmk_cmd, f"-{self.pdflatex}"]=0D
+            else:=0D
+                latex_cmd =3D [self.pdflatex]=0D
+            latex_cmd.extend(shlex.split(self.latexopts))=0D
+            tex_suffix =3D ".tex"=0D
+            has_tex =3D False=0D
+            build_failed =3D False=0D
+            with os.scandir(from_dir) as it:=0D
+                for entry in it:=0D
+                    if not entry.name.endswith(tex_suffix):=0D
+                        continue=0D
+                    name =3D entry.name[:-len(tex_suffix)]=0D
+                    has_tex =3D True=0D
+                    try:=0D
+                        subprocess.run(latex_cmd + [entry.path],=0D
+                                       cwd=3Dfrom_dir, check=3DTrue)=0D
+                    except subprocess.CalledProcessError:=0D
+                        pass=0D
+                    pdf_name =3D name + ".pdf"=0D
+                    pdf_from =3D os.path.join(from_dir, pdf_name)=0D
+                    pdf_to =3D os.path.join(pdf_dir, pdf_name)=0D
+                    if os.path.exists(pdf_from):=0D
+                        os.rename(pdf_from, pdf_to)=0D
+                        builds[name] =3D os.path.relpath(pdf_to, self.buil=
ddir)=0D
+                    else:=0D
+                        builds[name] =3D "FAILED"=0D
+                        build_failed =3D True=0D
+                    name =3D entry.name.removesuffix(".tex")=0D
+                    max_len =3D max(max_len, len(name))=0D
+=0D
+            if not has_tex:=0D
+                name =3D os.path.basename(from_dir)=0D
+                max_len =3D max(max_len, len(name))=0D
+                builds[name] =3D "FAILED (no .tex)"=0D
+                build_failed =3D True=0D
+        msg =3D "Summary"=0D
+        msg +=3D "\n" + "=3D" * len(msg)=0D
+        print()=0D
+        print(msg)=0D
+        for pdf_name, pdf_file in builds.items():=0D
+            print(f"{pdf_name:<{max_len}}: {pdf_file}")=0D
+        print()=0D
+        if build_failed:=0D
+            sys.exit("PDF build failed: not all PDF files were created.")=
=0D
+        else:=0D
+            print("All PDF files were built.")=0D
+=0D
+    def handle_info(self, output_dirs):=0D
+        for output_dir in output_dirs:=0D
+            try:=0D
+                subprocess.run(["make", "info"], cwd=3Doutput_dir, check=
=3DTrue)=0D
+            except subprocess.CalledProcessError as e:=0D
+                sys.exit(f"Error generating info docs: {e}")=0D
+=0D
+    def cleandocs(self, builder):=0D
+        shutil.rmtree(self.builddir, ignore_errors=3DTrue)=0D
+=0D
+    def build(self, target, sphinxdirs=3DNone, conf=3D"conf.py",=0D
+              theme=3DNone, css=3DNone, paper=3DNone):=0D
+        builder =3D TARGETS[target]["builder"]=0D
+        out_dir =3D TARGETS[target].get("out_dir", "")=0D
+        if target =3D=3D "cleandocs":=0D
+            self.cleandocs(builder)=0D
+            return=0D
+        if theme:=0D
+                os.environ["DOCS_THEME"] =3D theme=0D
+        sphinxbuild =3D shutil.which(self.sphinxbuild, path=3Dself.env["PA=
TH"])=0D
+        if not sphinxbuild:=0D
+            sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")=0D
+        if builder =3D=3D "latex":=0D
+            if not self.pdflatex_cmd and not self.latexmk_cmd:=0D
+                sys.exit("Error: pdflatex or latexmk required for PDF gene=
ration")=0D
+        docs_dir =3D os.path.abspath(os.path.join(self.srctree, "Documenta=
tion"))=0D
+        kerneldoc =3D self.kerneldoc=0D
+        if kerneldoc.startswith(self.srctree):=0D
+            kerneldoc =3D os.path.relpath(kerneldoc, self.srctree)=0D
+        args =3D [ "-b", builder, "-c", docs_dir ]=0D
+        if builder =3D=3D "latex":=0D
+            if not paper:=0D
+                paper =3D PAPER[1]=0D
+            args.extend(["-D", f"latex_elements.papersize=3D{paper}paper"]=
)=0D
+        if self.config_rust:=0D
+            args.extend(["-t", "rustdoc"])=0D
+        if conf:=0D
+            self.env["SPHINX_CONF"] =3D self.get_path(conf, abs_path=3DTru=
e)=0D
+        if not sphinxdirs:=0D
+            sphinxdirs =3D os.environ.get("SPHINXDIRS", ".")=0D
+        sphinxdirs_list =3D []=0D
+        for sphinxdir in sphinxdirs:=0D
+            if isinstance(sphinxdir, list):=0D
+                sphinxdirs_list +=3D sphinxdir=0D
+            else:=0D
+                for name in sphinxdir.split(" "):=0D
+                    sphinxdirs_list.append(name)=0D
+        output_dirs =3D []=0D
+        for sphinxdir in sphinxdirs_list:=0D
+            src_dir =3D os.path.join(docs_dir, sphinxdir)=0D
+            doctree_dir =3D os.path.join(self.builddir, ".doctrees")=0D
+            output_dir =3D os.path.join(self.builddir, sphinxdir, out_dir)=
=0D
+            src_dir =3D os.path.normpath(src_dir)=0D
+            doctree_dir =3D os.path.normpath(doctree_dir)=0D
+            output_dir =3D os.path.normpath(output_dir)=0D
+            os.makedirs(doctree_dir, exist_ok=3DTrue)=0D
+            os.makedirs(output_dir, exist_ok=3DTrue)=0D
+            output_dirs.append(output_dir)=0D
+            build_args =3D args + [=0D
+                "-d", doctree_dir,=0D
+                "-D", f"kerneldoc_bin=3D{kerneldoc}",=0D
+                "-D", f"version=3D{self.kernelversion}",=0D
+                "-D", f"release=3D{self.kernelrelease}",=0D
+                "-D", f"kerneldoc_srctree=3D{self.srctree}",=0D
+                src_dir,=0D
+                output_dir,=0D
+            ]=0D
+            try:=0D
+                self.run_sphinx(sphinxbuild, build_args, env=3Dself.env)=0D
+            except (OSError, ValueError, subprocess.SubprocessError) as e:=
=0D
+                sys.exit(f"Build failed: {repr(e)}")=0D
+            if target in ["htmldocs", "epubdocs"]:=0D
+                self.handle_html(css, output_dir)=0D
+        if target =3D=3D "pdfdocs":=0D
+            self.handle_pdf(output_dirs)=0D
+        elif target =3D=3D "infodocs":=0D
+            self.handle_info(output_dirs)=0D
+=0D
+def jobs_type(value):=0D
+    if value is None:=0D
+        return None=0D
+    if value.lower() =3D=3D 'auto':=0D
+        return value.lower()=0D
+    try:=0D
+        if int(value) >=3D 1:=0D
+            return value=0D
+        raise argparse.ArgumentTypeError(f"Minimum jobs is 1, got {value}"=
)=0D
+    except ValueError:=0D
+        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive inte=
ger, got {value}")=0D
+=0D
+def main():=0D
+    parser =3D argparse.ArgumentParser(description=3D"Kernel documentation=
 builder")=0D
+    parser.add_argument("target", choices=3Dlist(TARGETS.keys()),=0D
+                        help=3D"Documentation target to build")=0D
+    parser.add_argument("--sphinxdirs", nargs=3D"+",=0D
+                        help=3D"Specific directories to build")=0D
+    parser.add_argument("--conf", default=3D"conf.py",=0D
+                        help=3D"Sphinx configuration file")=0D
+    parser.add_argument("--theme", help=3D"Sphinx theme to use")=0D
+    parser.add_argument("--css", help=3D"Custom CSS file for HTML/EPUB")=0D
+    parser.add_argument("--paper", choices=3DPAPER, default=3DPAPER[0],=0D
+                        help=3D"Paper size for LaTeX/PDF output")=0D
+    parser.add_argument("-v", "--verbose", action=3D'store_true',=0D
+                        help=3D"place build in verbose mode")=0D
+    parser.add_argument('-j', '--jobs', type=3Djobs_type,=0D
+                        help=3D"Sets number of jobs to use with sphinx-bui=
ld")=0D
+    args =3D parser.parse_args()=0D
+    PythonVersion.check_python(MIN_PYTHON_VERSION)=0D
+    builder =3D SphinxBuilder(verbose=3Dargs.verbose, n_jobs=3Dargs.jobs)=
=0D
+    builder.build(args.target, sphinxdirs=3Dargs.sphinxdirs, conf=3Dargs.c=
onf,=0D
+                  theme=3Dargs.theme, css=3Dargs.css, paper=3Dargs.paper)=
=0D
+=0D
+if __name__ =3D=3D "__main__":=0D
+    main()=0D
-- =0D
2.51.0=0D
=0D

