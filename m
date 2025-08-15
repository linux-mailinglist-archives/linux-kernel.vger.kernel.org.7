Return-Path: <linux-kernel+bounces-770847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C35B27F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81FEB632E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB155304960;
	Fri, 15 Aug 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz2ke7K1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA62FCBE1;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=pdunVbrezGR4DIkkZywB9sqOk0IgkJm0Id5a+neMvPnJVh2ST91bUNmJpd7Upg7bShQHXHuXyuh68fVMEUMPM7EvQEPOEIFOkJEiqcLixJGrZqAEtdxNVmUGLRHzKwiihSD94Pt7Jljuv5oveZqUiJmxj2oC8XCmY+imo0QYXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=GYr8tmb4fF6RXpmQJmwNpnesZAm+FKFpIMMt22zUWek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERYhz0+qNFOg6NBblDKNFvbZNA2wg7WKefhktowoHqyA1DG8XTn88VwPIlKeqdVLcbJfN4OddWGIBJpWF26NlCznEmVlRlsnbLsKgYeZdvz2neoKr228iTZgBMDifxEgjKabgCt/XrGvdGBFrOq8HVTZsAbjDYCwbst9GBP+t0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz2ke7K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB17FC4CEF7;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258666;
	bh=GYr8tmb4fF6RXpmQJmwNpnesZAm+FKFpIMMt22zUWek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pz2ke7K1JrytdVdkFRYd5y6b7sTYFT+c70cN4MoXzaSP/KAqidpInRrAdKsYMyAYd
	 DYhcBdf4l5lcZetXKlZZaWKOM5cK3izEsxvQXJhldYV1Qez57Z0Q4f7upOXCfaaXYr
	 hGzNOxn5SCaleubtPX9Qaj99SvfjNAB2oeQGmd0DQ4Tkzc0wrCVy9Wt9Lmkt4LUEVb
	 lveu373kP/gmvjlqvFAOdI7UjxNt1XrhIfcM9psgmyDk16rxFdjvgHidZiFtnq84Od
	 6FdPyNm0NtyfKilirzxuOEE8a+26fIVJWgPEqpb6d0TnPnmp5uLvGDWXBUMK4Q0F3x
	 P4GkfLp+ND43g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042oW-0RQD;
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
Subject: [PATCH 05/11] docs: Makefile: cleanup the logic by using sphinx-build-wrapper
Date: Fri, 15 Aug 2025 13:50:33 +0200
Message-ID: <3a62c847a812905f3a4c85f6b984d021ae88188d.1755258303.git.mchehab+huawei@kernel.org>
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

Now that we have a sphinx-build-wrapper capable of handling
all the needed step to build the supported build targets,
cleanup the Makefile.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 127 ++++++++++-------------------------------
 1 file changed, 29 insertions(+), 98 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ed334971acd..4013286bef04 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -19,7 +19,6 @@ endif
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
-SPHINXOPTS    =
 SPHINXDIRS    = .
 DOCS_THEME    =
 DOCS_CSS      =
@@ -29,14 +28,14 @@ PAPER         =
 BUILDDIR      = $(obj)/output
 PDFLATEX      = xelatex
 LATEXOPTS     = -interaction=batchmode -no-shell-escape
+BUILD_WRAPPER = $(srctree)/scripts/sphinx-build-wrapper
+
+PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
 
 # For denylisting "variable font" files
 # Can be overridden by setting as an env variable
 FONTS_CONF_DENY_VF ?= $(HOME)/deny-vf
 
-ifeq ($(findstring 1, $(KBUILD_VERBOSE)),)
-SPHINXOPTS    += "-q"
-endif
 
 # User-friendly check for sphinx-build
 HAVE_SPHINX := $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi)
@@ -51,62 +50,37 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
-# User-friendly check for pdflatex and latexmk
-HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
-HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
+# Common documentation targets
+infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
+	$(Q)@$(srctree)/scripts/sphinx-pre-install --version-check
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+		--sphinxdirs="$(SPHINXDIRS)" \
+		--conf=$(SPHINX_CONF) \
+		--theme=$(DOCS_THEME) \
+		--css=$(DOCS_CSS) \
+		--paper=$(PAPER)
 
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
 
-quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
-      cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media $2 && \
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
+infodocs: texinfodocs
 
+# HTML main logic is identical to other targets. However, if rust is enabled,
+# an extra step at the end is required to generate rustdoc.
 htmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
+	$(Q)@$(srctree)/scripts/sphinx-pre-install --version-check
+	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
+		--sphinxdirs="$(SPHINXDIRS)" \
+		--conf=$(SPHINX_CONF) \
+		--theme=$(DOCS_THEME) \
+		--css=$(DOCS_CSS) \
+		--paper=$(PAPER)
 
 # If Rust support is available and .config exists, add rustdoc generated contents.
 # If there are any, the errors from this make rustdoc will be displayed but
@@ -118,49 +92,6 @@ ifeq ($(CONFIG_RUST),y)
 endif
 endif
 
-texinfodocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
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
-	@$(srctree)/scripts/sphinx-pre-install --version-check
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
-	@$(srctree)/scripts/sphinx-pre-install --version-check
-	$(foreach var,$(SPHINXDIRS), \
-	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
-	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
-	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
-	)
-
-endif # HAVE_PDFLATEX
-
-epubdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
-
-xmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
-
 endif # HAVE_SPHINX
 
 # The following targets are independent of HAVE_SPHINX, and the rules should
-- 
2.50.1


