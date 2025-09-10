Return-Path: <linux-kernel+bounces-809993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B9B51460
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D207B8F00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB933191CE;
	Wed, 10 Sep 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEKw78Vn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225F30597D;
	Wed, 10 Sep 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501191; cv=none; b=Kg+TZpWbunJcNABO8MhSDaWFdbuVmHWyZdtDgLC9LfwbqHeKewKypbvgcpMTgoE3fr+cXXlaTukMkPYKvQr9oBVgSXxk6V6Zabuqvz9pzcuIvDZtRnz5lCDd412+zZi7dkfkcVjha5m1/DnC5QB2y269H8w9Cmhh5JMgPPbpoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501191; c=relaxed/simple;
	bh=EtZc0KzeipR8AgBQuNi+J3sEH39yN0L1DxNcSndMY6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNxanX4wmS9hFjMc7RlxgFV5MuXbbTm0WntlxX688ojrql9M9ybPsx5m909UfeFiHBibrLBogP07H51f7map3yWzagUcoaLlIQNjokUvPtQnEU438/SWsxtB24PrfMf6sGJU+15tgcY5JK1PpOjdkzpoSDCN9tK6PmSIPezXOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEKw78Vn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757501187; x=1789037187;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EtZc0KzeipR8AgBQuNi+J3sEH39yN0L1DxNcSndMY6E=;
  b=FEKw78VnGQn+J4ABqu49WV4kmjBujf5Mn630temCUygoKck4ObB7joMB
   KO6RHNEn/6H8VDNBwLGK6n8zAx8GIOFDS6RqFuuZKyYVmwZKuoelXIZku
   B0ymMBI3l9GM7MBjhP2mOhxTfSXIi5OD7ScZbC0ba0okY17UGck/uEhBf
   xOLZ3CByzrV6NeCZDa3zpT7Hj0sfcdvSpj1kq7b54rba1t/1Is3tbUL1f
   PzqcSbFs5lcXnMGbgTgiEG9nqLEi3OisQRy1MzLO/0r2+PEEAPMIB3bPt
   a8/EyQBytJSh/9FIBkjhqbXWNulMCx0srmc5U0UPV9YrOuxrXmrwIemGt
   w==;
X-CSE-ConnectionGUID: eiFiCZQUQ9SyLmwuXxGbNg==
X-CSE-MsgGUID: mEkZQY5QSY2NtdYY5heL8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59745521"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59745521"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:46:26 -0700
X-CSE-ConnectionGUID: lxhl3bvKT5ep/S8Qh7Cthg==
X-CSE-MsgGUID: wrmz7a0rTRuLiFDS+edv8w==
X-ExtLoop1: 1
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.72])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:46:20 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Andreas Hindborg <mchehab+huawei@kernel.org>,
 Benno Lossin <mchehab+huawei@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Danilo Krummrich <mchehab+huawei@kernel.org>, Gary
 Guo <gary@garyguo.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Miguel Ojeda <mchehab+huawei@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
Date: Wed, 10 Sep 2025 13:46:17 +0300
Message-ID: <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> There are too much magic inside docs Makefile to properly run
> sphinx-build. Create an ancillary script that contains all
> kernel-related sphinx-build call logic currently at Makefile.
>
> Such script is designed to work both as an standalone command
> and as part of a Makefile. As such, it properly handles POSIX
> jobserver used by GNU make.
>
> On a side note, there was a line number increase due to the
> conversion:
>
>  Documentation/Makefile          |  131 +++----------
>  tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
>  2 files changed, 323 insertions(+), 101 deletions(-)
>
> This is because some things are more verbosed on Python and because
> it requires reading env vars from Makefile. Besides it, this script
> has some extra features that don't exist at the Makefile:
>
> - It can be called directly from command line;
> - It properly return PDF build errors.
>
> When running the script alone, it will only take handle sphinx-build
> targets. On other words, it won't runn make rustdoc after building
> htmlfiles, nor it will run the extra check scripts.

I've always strongly believed we should aim to make it possible to build
the documentation by running sphinx-build directly on the
command-line. Not that it would be the common way to run it, but to not
accumulate things in the Makefile that need to happen before or
after. To promote handling the documentation build in Sphinx. To be able
to debug issues and try new Sphinx versions without all the hacks.

This patch moves a bunch of that logic into a Python wrapper, and I feel
like it complicates matters. You can no longer rely on 'make V=1' to get
the build commands, for instance.

Newer Sphinx versions have the -M option for "make mode". The Makefiles
produced by sphinx-quickstart only have one build target:

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
        @$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

That's all.

The proposed wrapper duplicates loads of code that's supposed to be
handled by sphinx-build directly. Including the target/builder names.

Seems to me the goal should be to figure out *generic* wrappers for
handling parallelism, not Sphinx aware/specific.


BR,
Jani.

>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile          | 131 ++++----------
>  tools/docs/sphinx-build-wrapper | 293 ++++++++++++++++++++++++++++++++
>  2 files changed, 323 insertions(+), 101 deletions(-)
>  create mode 100755 tools/docs/sphinx-build-wrapper
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index deb2029228ed..4736f02b6c9e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -23,21 +23,22 @@ SPHINXOPTS    =
>  SPHINXDIRS    = .
>  DOCS_THEME    =
>  DOCS_CSS      =
> -_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
>  SPHINX_CONF   = conf.py
>  PAPER         =
>  BUILDDIR      = $(obj)/output
>  PDFLATEX      = xelatex
>  LATEXOPTS     = -interaction=batchmode -no-shell-escape
>  
> +PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
> +
> +# Wrapper for sphinx-build
> +
> +BUILD_WRAPPER = $(srctree)/tools/docs/sphinx-build-wrapper
> +
>  # For denylisting "variable font" files
>  # Can be overridden by setting as an env variable
>  FONTS_CONF_DENY_VF ?= $(HOME)/deny-vf
>  
> -ifeq ($(findstring 1, $(KBUILD_VERBOSE)),)
> -SPHINXOPTS    += "-q"
> -endif
> -
>  # User-friendly check for sphinx-build
>  HAVE_SPHINX := $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi)
>  
> @@ -51,63 +52,31 @@ ifeq ($(HAVE_SPHINX),0)
>  
>  else # HAVE_SPHINX
>  
> -# User-friendly check for pdflatex and latexmk
> -HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
> -HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
> +# Common documentation targets
> +infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
> +	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
> +	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
> +		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" \
> +		--builddir="$(BUILDDIR)" \
> +		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
>  
> -ifeq ($(HAVE_LATEXMK),1)
> -	PDFLATEX := latexmk -$(PDFLATEX)
> -endif #HAVE_LATEXMK
> -
> -# Internal variables.
> -PAPEROPT_a4     = -D latex_elements.papersize=a4paper
> -PAPEROPT_letter = -D latex_elements.papersize=letterpaper
> -ALLSPHINXOPTS   = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
> -ALLSPHINXOPTS   += $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
> -ifneq ($(wildcard $(srctree)/.config),)
> -ifeq ($(CONFIG_RUST),y)
> -	# Let Sphinx know we will include rustdoc
> -	ALLSPHINXOPTS   +=  -t rustdoc
> -endif
> +# Special handling for pdfdocs
> +ifeq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)
> +pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
> +else
> +pdfdocs:
> +	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
> +	@echo "  SKIP    Sphinx $@ target."
>  endif
> -# the i18n builder cannot share the environment and doctrees with the others
> -I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
> -
> -# commands; the 'cmd' from scripts/Kbuild.include is not *loopable*
> -loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
> -
> -# $2 sphinx builder e.g. "html"
> -# $3 name of the build subfolder / e.g. "userspace-api/media", used as:
> -#    * dest folder relative to $(BUILDDIR) and
> -#    * cache folder relative to $(BUILDDIR)/.doctrees
> -# $4 dest subfolder e.g. "man" for man pages at userspace-api/media/man
> -# $5 reST source folder relative to $(src),
> -#    e.g. "userspace-api/media" for the linux-tv book-set at ./Documentation/userspace-api/media
> -
> -PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
> -
> -quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
> -      cmd_sphinx = \
> -	PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
> -	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(src)/$5/$(SPHINX_CONF)) \
> -	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
> -	$(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
> -	$(SPHINXBUILD) \
> -	-b $2 \
> -	-c $(abspath $(src)) \
> -	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> -	-D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
> -	$(ALLSPHINXOPTS) \
> -	$(abspath $(src)/$5) \
> -	$(abspath $(BUILDDIR)/$3/$4) && \
> -	if [ "x$(DOCS_CSS)" != "x" ]; then \
> -		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
> -	fi
>  
> +# HTML main logic is identical to other targets. However, if rust is enabled,
> +# an extra step at the end is required to generate rustdoc.
>  htmldocs:
> -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
> -
> +	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
> +	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
> +		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" \
> +		--builddir="$(BUILDDIR)" \
> +		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
>  # If Rust support is available and .config exists, add rustdoc generated contents.
>  # If there are any, the errors from this make rustdoc will be displayed but
>  # won't stop the execution of htmldocs
> @@ -118,49 +87,6 @@ ifeq ($(CONFIG_RUST),y)
>  endif
>  endif
>  
> -texinfodocs:
> -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
> -
> -# Note: the 'info' Make target is generated by sphinx itself when
> -# running the texinfodocs target define above.
> -infodocs: texinfodocs
> -	$(MAKE) -C $(BUILDDIR)/texinfo info
> -
> -linkcheckdocs:
> -	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
> -
> -latexdocs:
> -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
> -
> -ifeq ($(HAVE_PDFLATEX),0)
> -
> -pdfdocs:
> -	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
> -	@echo "  SKIP    Sphinx $@ target."
> -
> -else # HAVE_PDFLATEX
> -
> -pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
> -pdfdocs: latexdocs
> -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	$(foreach var,$(SPHINXDIRS), \
> -	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
> -	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
> -	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
> -	)
> -
> -endif # HAVE_PDFLATEX
> -
> -epubdocs:
> -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
> -
> -xmldocs:
> -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
> -
>  endif # HAVE_SPHINX
>  
>  # The following targets are independent of HAVE_SPHINX, and the rules should
> @@ -172,6 +98,9 @@ refcheckdocs:
>  cleandocs:
>  	$(Q)rm -rf $(BUILDDIR)
>  
> +# Used only on help
> +_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
> +
>  dochelp:
>  	@echo  ' Linux kernel internal documentation in different formats from ReST:'
>  	@echo  '  htmldocs        - HTML'
> diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
> new file mode 100755
> index 000000000000..3256418d8dc5
> --- /dev/null
> +++ b/tools/docs/sphinx-build-wrapper
> @@ -0,0 +1,293 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +import argparse
> +import os
> +import shlex
> +import shutil
> +import subprocess
> +import sys
> +from lib.python_version import PythonVersion
> +
> +LIB_DIR = "../../scripts/lib"
> +SRC_DIR = os.path.dirname(os.path.realpath(__file__))
> +sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
> +
> +from jobserver import JobserverExec
> +
> +MIN_PYTHON_VERSION = PythonVersion("3.7").version
> +PAPER = ["", "a4", "letter"]
> +TARGETS = {
> +    "cleandocs":     { "builder": "clean" },
> +    "linkcheckdocs": { "builder": "linkcheck" },
> +    "htmldocs":      { "builder": "html" },
> +    "epubdocs":      { "builder": "epub",    "out_dir": "epub" },
> +    "texinfodocs":   { "builder": "texinfo", "out_dir": "texinfo" },
> +    "infodocs":      { "builder": "texinfo", "out_dir": "texinfo" },
> +    "latexdocs":     { "builder": "latex",   "out_dir": "latex" },
> +    "pdfdocs":       { "builder": "latex",   "out_dir": "latex" },
> +    "xmldocs":       { "builder": "xml",     "out_dir": "xml" },
> +}
> +
> +class SphinxBuilder:
> +    def is_rust_enabled(self):
> +        config_path = os.path.join(self.srctree, ".config")
> +        if os.path.isfile(config_path):
> +            with open(config_path, "r", encoding="utf-8") as f:
> +                return "CONFIG_RUST=y" in f.read()
> +        return False
> +
> +    def get_path(self, path, use_cwd=False, abs_path=False):
> +        path = os.path.expanduser(path)
> +        if not path.startswith("/"):
> +            if use_cwd:
> +                base = os.getcwd()
> +            else:
> +                base = self.srctree
> +            path = os.path.join(base, path)
> +        if abs_path:
> +            return os.path.abspath(path)
> +        return path
> +
> +    def __init__(self, builddir, verbose=False, n_jobs=None):
> +        self.verbose = None
> +        self.kernelversion = os.environ.get("KERNELVERSION", "unknown")
> +        self.kernelrelease = os.environ.get("KERNELRELEASE", "unknown")
> +        self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
> +        self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
> +        if not verbose:
> +            verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
> +        if verbose is not None:
> +            self.verbose = verbose
> +        parser = argparse.ArgumentParser()
> +        parser.add_argument('-j', '--jobs', type=int)
> +        parser.add_argument('-q', '--quiet', type=int)
> +        sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", ""))
> +        sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
> +        if sphinx_args.quiet is True:
> +            self.verbose = False
> +        if sphinx_args.jobs:
> +            self.n_jobs = sphinx_args.jobs
> +        self.n_jobs = n_jobs
> +        self.srctree = os.environ.get("srctree")
> +        if not self.srctree:
> +            self.srctree = "."
> +            os.environ["srctree"] = self.srctree
> +        self.sphinxbuild = os.environ.get("SPHINXBUILD", "sphinx-build")
> +        self.kerneldoc = self.get_path(os.environ.get("KERNELDOC",
> +                                                      "scripts/kernel-doc.py"))
> +        self.builddir = self.get_path(builddir, use_cwd=True, abs_path=True)
> +
> +        self.config_rust = self.is_rust_enabled()
> +
> +        self.pdflatex_cmd = shutil.which(self.pdflatex)
> +        self.latexmk_cmd = shutil.which("latexmk")
> +
> +        self.env = os.environ.copy()
> +
> +    def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
> +        with JobserverExec() as jobserver:
> +            if jobserver.claim:
> +                n_jobs = str(jobserver.claim)
> +            else:
> +                n_jobs = "auto" # Supported since Sphinx 1.7
> +            cmd = []
> +            cmd.append(sys.executable)
> +            cmd.append(sphinx_build)
> +            if self.n_jobs:
> +                n_jobs = str(self.n_jobs)
> +
> +            if n_jobs:
> +                cmd += [f"-j{n_jobs}"]
> +
> +            if not self.verbose:
> +                cmd.append("-q")
> +            cmd += self.sphinxopts
> +            cmd += build_args
> +            if self.verbose:
> +                print(" ".join(cmd))
> +            return subprocess.call(cmd, *args, **pwargs)
> +
> +    def handle_html(self, css, output_dir):
> +        if not css:
> +            return
> +        css = os.path.expanduser(css)
> +        if not css.startswith("/"):
> +            css = os.path.join(self.srctree, css)
> +        static_dir = os.path.join(output_dir, "_static")
> +        os.makedirs(static_dir, exist_ok=True)
> +        try:
> +            shutil.copy2(css, static_dir)
> +        except (OSError, IOError) as e:
> +            print(f"Warning: Failed to copy CSS: {e}", file=sys.stderr)
> +
> +    def handle_pdf(self, output_dirs):
> +        builds = {}
> +        max_len = 0
> +        for from_dir in output_dirs:
> +            pdf_dir = os.path.join(from_dir, "../pdf")
> +            os.makedirs(pdf_dir, exist_ok=True)
> +            if self.latexmk_cmd:
> +                latex_cmd = [self.latexmk_cmd, f"-{self.pdflatex}"]
> +            else:
> +                latex_cmd = [self.pdflatex]
> +            latex_cmd.extend(shlex.split(self.latexopts))
> +            tex_suffix = ".tex"
> +            has_tex = False
> +            build_failed = False
> +            with os.scandir(from_dir) as it:
> +                for entry in it:
> +                    if not entry.name.endswith(tex_suffix):
> +                        continue
> +                    name = entry.name[:-len(tex_suffix)]
> +                    has_tex = True
> +                    try:
> +                        subprocess.run(latex_cmd + [entry.path],
> +                                       cwd=from_dir, check=True)
> +                    except subprocess.CalledProcessError:
> +                        pass
> +                    pdf_name = name + ".pdf"
> +                    pdf_from = os.path.join(from_dir, pdf_name)
> +                    pdf_to = os.path.join(pdf_dir, pdf_name)
> +                    if os.path.exists(pdf_from):
> +                        os.rename(pdf_from, pdf_to)
> +                        builds[name] = os.path.relpath(pdf_to, self.builddir)
> +                    else:
> +                        builds[name] = "FAILED"
> +                        build_failed = True
> +                    name = entry.name.removesuffix(".tex")
> +                    max_len = max(max_len, len(name))
> +
> +            if not has_tex:
> +                name = os.path.basename(from_dir)
> +                max_len = max(max_len, len(name))
> +                builds[name] = "FAILED (no .tex)"
> +                build_failed = True
> +        msg = "Summary"
> +        msg += "\n" + "=" * len(msg)
> +        print()
> +        print(msg)
> +        for pdf_name, pdf_file in builds.items():
> +            print(f"{pdf_name:<{max_len}}: {pdf_file}")
> +        print()
> +        if build_failed:
> +            sys.exit("PDF build failed: not all PDF files were created.")
> +        else:
> +            print("All PDF files were built.")
> +
> +    def handle_info(self, output_dirs):
> +        for output_dir in output_dirs:
> +            try:
> +                subprocess.run(["make", "info"], cwd=output_dir, check=True)
> +            except subprocess.CalledProcessError as e:
> +                sys.exit(f"Error generating info docs: {e}")
> +
> +    def cleandocs(self, builder):
> +        shutil.rmtree(self.builddir, ignore_errors=True)
> +
> +    def build(self, target, sphinxdirs=None, conf="conf.py",
> +              theme=None, css=None, paper=None):
> +        builder = TARGETS[target]["builder"]
> +        out_dir = TARGETS[target].get("out_dir", "")
> +        if target == "cleandocs":
> +            self.cleandocs(builder)
> +            return
> +        if theme:
> +                os.environ["DOCS_THEME"] = theme
> +        sphinxbuild = shutil.which(self.sphinxbuild, path=self.env["PATH"])
> +        if not sphinxbuild:
> +            sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
> +        if builder == "latex":
> +            if not self.pdflatex_cmd and not self.latexmk_cmd:
> +                sys.exit("Error: pdflatex or latexmk required for PDF generation")
> +        docs_dir = os.path.abspath(os.path.join(self.srctree, "Documentation"))
> +        kerneldoc = self.kerneldoc
> +        if kerneldoc.startswith(self.srctree):
> +            kerneldoc = os.path.relpath(kerneldoc, self.srctree)
> +        args = [ "-b", builder, "-c", docs_dir ]
> +        if builder == "latex":
> +            if not paper:
> +                paper = PAPER[1]
> +            args.extend(["-D", f"latex_elements.papersize={paper}paper"])
> +        if self.config_rust:
> +            args.extend(["-t", "rustdoc"])
> +        if conf:
> +            self.env["SPHINX_CONF"] = self.get_path(conf, abs_path=True)
> +        if not sphinxdirs:
> +            sphinxdirs = os.environ.get("SPHINXDIRS", ".")
> +        sphinxdirs_list = []
> +        for sphinxdir in sphinxdirs:
> +            if isinstance(sphinxdir, list):
> +                sphinxdirs_list += sphinxdir
> +            else:
> +                for name in sphinxdir.split(" "):
> +                    sphinxdirs_list.append(name)
> +        output_dirs = []
> +        for sphinxdir in sphinxdirs_list:
> +            src_dir = os.path.join(docs_dir, sphinxdir)
> +            doctree_dir = os.path.join(self.builddir, ".doctrees")
> +            output_dir = os.path.join(self.builddir, sphinxdir, out_dir)
> +            src_dir = os.path.normpath(src_dir)
> +            doctree_dir = os.path.normpath(doctree_dir)
> +            output_dir = os.path.normpath(output_dir)
> +            os.makedirs(doctree_dir, exist_ok=True)
> +            os.makedirs(output_dir, exist_ok=True)
> +            output_dirs.append(output_dir)
> +            build_args = args + [
> +                "-d", doctree_dir,
> +                "-D", f"kerneldoc_bin={kerneldoc}",
> +                "-D", f"version={self.kernelversion}",
> +                "-D", f"release={self.kernelrelease}",
> +                "-D", f"kerneldoc_srctree={self.srctree}",
> +                src_dir,
> +                output_dir,
> +            ]
> +            try:
> +                self.run_sphinx(sphinxbuild, build_args, env=self.env)
> +            except (OSError, ValueError, subprocess.SubprocessError) as e:
> +                sys.exit(f"Build failed: {repr(e)}")
> +            if target in ["htmldocs", "epubdocs"]:
> +                self.handle_html(css, output_dir)
> +        if target == "pdfdocs":
> +            self.handle_pdf(output_dirs)
> +        elif target == "infodocs":
> +            self.handle_info(output_dirs)
> +
> +def jobs_type(value):
> +    if value is None:
> +        return None
> +    if value.lower() == 'auto':
> +        return value.lower()
> +    try:
> +        if int(value) >= 1:
> +            return value
> +        raise argparse.ArgumentTypeError(f"Minimum jobs is 1, got {value}")
> +    except ValueError:
> +        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive integer, got {value}")
> +
> +def main():
> +    parser = argparse.ArgumentParser(description="Kernel documentation builder")
> +    parser.add_argument("target", choices=list(TARGETS.keys()),
> +                        help="Documentation target to build")
> +    parser.add_argument("--sphinxdirs", nargs="+",
> +                        help="Specific directories to build")
> +    parser.add_argument("--conf", default="conf.py",
> +                        help="Sphinx configuration file")
> +    parser.add_argument("--builddir", default="output",
> +                        help="Sphinx configuration file")
> +    parser.add_argument("--theme", help="Sphinx theme to use")
> +    parser.add_argument("--css", help="Custom CSS file for HTML/EPUB")
> +    parser.add_argument("--paper", choices=PAPER, default=PAPER[0],
> +                        help="Paper size for LaTeX/PDF output")
> +    parser.add_argument("-v", "--verbose", action='store_true',
> +                        help="place build in verbose mode")
> +    parser.add_argument('-j', '--jobs', type=jobs_type,
> +                        help="Sets number of jobs to use with sphinx-build")
> +    args = parser.parse_args()
> +    PythonVersion.check_python(MIN_PYTHON_VERSION)
> +    builder = SphinxBuilder(builddir=args.builddir,
> +                            verbose=args.verbose, n_jobs=args.jobs)
> +    builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
> +                  theme=args.theme, css=args.css, paper=args.paper)
> +
> +if __name__ == "__main__":
> +    main()

-- 
Jani Nikula, Intel

