Return-Path: <linux-kernel+bounces-818602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED618B593DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C02C3B68E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F182F7AB3;
	Tue, 16 Sep 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnCKAVOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D44222585;
	Tue, 16 Sep 2025 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018720; cv=none; b=qqkSNLlwl7iE5jMVZAf0xPS5usBTOD6122e5ylXbY5t1mUTRKCh1TVSlHNkzRLSo4nUyhQ4BPfE+fDIzzmcLfQ9jkPwpvM9KPd5/mD5AawlwN7pWjqXQ44ye4O54/q3l4sL+rjprAqpHudwumkYCGMSHdEA5whb8Bm6xkIBV+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018720; c=relaxed/simple;
	bh=ZLPLivDTAutjPFOUV+q9lUE51DcX3BO/iRXmITTKbv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo1CH1izukrabclSaczWmsLGXWHr40okFMMHDbvaS2R27QKt7bCir/3FPginNZYIT4GrphUcVIkXOVVRLoaUiCprRsb1VIjcOXlOzm/dYJWILaHv58sXfdPub8V5CWBWvcyXDiMuQ9KmMs53FqHSgnOMmPBywAnxr6qnbEIXBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnCKAVOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BAEC4CEEB;
	Tue, 16 Sep 2025 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018719;
	bh=ZLPLivDTAutjPFOUV+q9lUE51DcX3BO/iRXmITTKbv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LnCKAVOGVmM30keYkt2BiIdZr593g2UUFMPMJI5X/gcqw1yOT3/u7xcIpzqk7tZ2d
	 BLkpbKPGssCyevSfRpsOWsJen5dDP2CkYLd30+yrkKC187M/OzrvI8YcF6SWRbE3Z7
	 CMTuqleKSMGm3I1hOENv0YoW0Ok+LtRslCGQSgw2iv28bhCuFDXoyiOi0ZiL/gDgyH
	 nC4v3+YdNsMRjIUBXDZB/B91auBqbqnpGnySmF5/FNmn+iJ1g0L7k6I4wsJtel/X75
	 gpUif8SSy7WRtetMN1QA1TLwCbKGOqzLjsX27I1p2UkBspHxzDyYEjgaslfd4apOsW
	 gfzv3qx4EEafg==
Date: Tue, 16 Sep 2025 12:31:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/21] Split sphinx call logic from docs Makefile
Message-ID: <20250916123156.4434aa19@foz.lan>
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 16 Sep 2025 12:22:36 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Hi Jon,
> 
> This series should probably be called:
> 
>     "Move the trick-or-treat build hacks accumulated over time
>      into a single place and document them."
> 
> as this reflects its main goal. As such:
> 
> - it places the jobserver logic on a library;
> - it removes sphinx/parallel-wrapper.sh;
> - the code now properly implements a jobserver-aware logic
>   to do the parallelism when called via GNU make, failing back to
>   "-j" when there's  no jobserver;
> - converts check-variable-fonts.sh to Python and uses it via
>   function call;
> - drops an extra script to generate man pages, adding a makefile
>   target for it;
> - ensures that return code is 0 when PDF successfully builds;
> - about half of the script is comments and documentation.
> 
> I tried to do my best to document all tricks that are inside the
> script. This way, the docs build steps is now documented.
> 
> It should be noticed that it is out of the scope of this series
> to change the implementation. Surely the process can be improved,
> but first let's consolidate and document everything on a single
> place.
> 
> Such script was written in a way that it can be called either
> directly or via a Makefile. Running outside Makefile is
> interesting specially when debug is needed. The command line
> interface replaces the need of having lots of env vars before
> calling sphinx-build:
> 
>     $ ./tools/docs/sphinx-build-wrapper --help
>     usage: sphinx-build-wrapper [-h]
>            [--sphinxdirs SPHINXDIRS [SPHINXDIRS ...]] [--conf CONF]
>            [--builddir BUILDDIR] [--theme THEME] [--css CSS] [--paper {,a4,letter}] [-v]
>            [-j JOBS] [-i] [-V [VENV]]
>            {cleandocs,linkcheckdocs,htmldocs,epubdocs,texinfodocs,infodocs,mandocs,latexdocs,pdfdocs,xmldocs}
> 
>     Kernel documentation builder
> 
>     positional arguments:
>       {cleandocs,linkcheckdocs,htmldocs,epubdocs,texinfodocs,infodocs,mandocs,latexdocs,pdfdocs,xmldocs}
>                             Documentation target to build
> 
>     options:
>       -h, --help            show this help message and exit
>       --sphinxdirs SPHINXDIRS [SPHINXDIRS ...]
>                             Specific directories to build
>       --conf CONF           Sphinx configuration file
>       --builddir BUILDDIR   Sphinx configuration file
>       --theme THEME         Sphinx theme to use
>       --css CSS             Custom CSS file for HTML/EPUB
>       --paper {,a4,letter}  Paper size for LaTeX/PDF output
>       -v, --verbose         place build in verbose mode
>       -j, --jobs JOBS       Sets number of jobs to use with sphinx-build
>       -i, --interactive     Change latex default to run in interactive mode
>       -V, --venv [VENV]     If used, run Sphinx from a venv dir (default dir: sphinx_latest)
> 
> the only mandatory argument is the target, which is identical with
> "make" targets.
> 
> The call inside Makefile doesn't use the last four arguments. They're
> there to help identifying problems at the build:
> 
>     -v makes the output verbose;
>     -j helps to test parallelism;
>     -i runs latexmk in interactive mode, allowing to debug PDF
>        build issues;
>     -V is useful when testing it with different venvs.
> 
> When used with GNU make (or some other make which implements jobserver),
> a call like:
> 
>     make -j <targets> htmldocs
> 
> will make the wrapper to automatically use POSIX jobserver to claim 
> the number of available job slots, calling sphinx-build with a
> "-j" parameter reflecting it. ON such case, the default can be
> overriden via SPHINXDIRS argument.
> 
> Visiable changes when compared with the old behavior:

Visiable -> Visible

> When V=0, the only visible difference is that:
> - pdfdocs target now returns 0 on success, 1 on failures.
>   This addresses an issue over the current process where we
>   it always return success even on failures;
> - it will now print the name of PDF files that failed to build,
>   if any.
> 
> In verbose mode, sphinx-build-wrapper and sphinx-build command lines
> are now displayed.

It will also print a summary of all PDF built files, for pdfdocs
target in verbose mode.

> 
> ---
> 
> v6:
> - On success, PDF output is identical as before when V=0;
> - when V=1 is used, PDF output will print a build summary,
>   as on v5;
> - solved a problem when multiple PDF files have the same
>   basename but are located on different directories;
> - merged a patch series converting check-variable-fonts.sh
>   to Python. Its logic is now called directly without running
>   a subprocess.
> - venv patch moved to the end.
> 
> v5:
> - merged comments with the script;
> - placed n_jobs on a separate function;
> - nitpick: dropped a for loop used instead of list append.
> 
> v4:
> - updated references for sphinx-pre-install after its rename;
> - added some extra patches to add more options to python_version,
>   allowing it to bail out and suggest alternatives;
> - added a patch at the end to explicitly break doc builds when
>   python3 points to python3.6 or older.
> 
> v3:
> - rebased on the top of docs-next;
> - added two patches to build man files that were on a separate
>   patch series.
> 
> v2:
> - there's no generic exception handler anymore;
> - it moves sphinx-pre-install to tools/docs;
> - the logic which ensures a minimal Python version got moved
>   to a library, which is now used by both pre-install and wrapper;
> - The first wrapper (05/13) doesn't contain comments (except for
>   shebang and SPDX). The goal is to help showing the size increase
>   when moving from Makefile to Python. Some file increase is
>   unavoidable, as Makefile is more compact: no includes, multple
>   statements per line, no argparse, etc;
> - The second patch adds docstrings and comments. It has almost
>   the same size of the code itself;
> - I moved the venv logic to a third wrapper patch;
> - I fixed an issue at the paraller build logic;
> - There are no generic except blocks anymore.
> 
> 
> Mauro Carvalho Chehab (21):
>   scripts/jobserver-exec: move the code to a class
>   scripts/jobserver-exec: move its class to the lib directory
>   scripts/jobserver-exec: add a help message
>   scripts: check-variable-fonts.sh: convert to Python
>   tools/docs: check-variable-fonts.py: split into a lib and an exec file
>   scripts: sphinx-pre-install: move it to tools/docs
>   tools/docs: python_version: move version check from sphinx-pre-install
>   tools/docs: python_version: drop a debug print
>   tools/docs: python_version: allow check for alternatives and bail out
>   tools/docs: sphinx-build-wrapper: add a wrapper for sphinx-build
>   docs: parallel-wrapper.sh: remove script
>   docs: Makefile: document latex/PDF PAPER= parameter
>   tools/docs: sphinx-build-wrapper: add an argument for LaTeX
>     interactive mode
>   tools/docs,scripts: sphinx-*: prevent sphinx-build crashes
>   tools/docs: sphinx-build-wrapper: allow building PDF files in parallel
>   tools/docs: sphinx-build-wrapper: Fix output for duplicated names
>   docs: add support to build manpages from kerneldoc output
>   tools: kernel-doc: add a see also section at man pages
>   scripts: kdoc_parser.py: warn about Python version only once
>   tools/docs: sphinx-* break documentation bulds on openSUSE
>   tools/docs: sphinx-build-wrapper: add support to run inside venv
> 
>  Documentation/Makefile                        | 136 +--
>  Documentation/doc-guide/kernel-doc.rst        |  29 +-
>  Documentation/doc-guide/sphinx.rst            |   4 +-
>  Documentation/sphinx/kerneldoc-preamble.sty   |   2 +-
>  Documentation/sphinx/parallel-wrapper.sh      |  33 -
>  .../translations/it_IT/doc-guide/sphinx.rst   |   4 +-
>  .../translations/zh_CN/doc-guide/sphinx.rst   |   4 +-
>  Documentation/translations/zh_CN/how-to.rst   |   2 +-
>  MAINTAINERS                                   |   4 +-
>  Makefile                                      |   2 +-
>  scripts/check-variable-fonts.sh               | 115 ---
>  scripts/jobserver-exec                        |  88 +-
>  scripts/lib/jobserver.py                      | 149 ++++
>  scripts/lib/kdoc/kdoc_files.py                |   5 +-
>  scripts/lib/kdoc/kdoc_output.py               |  84 +-
>  scripts/lib/kdoc/kdoc_parser.py               |   7 +-
>  scripts/split-man.pl                          |  28 -
>  tools/docs/check-variable-fonts.py            |  23 +
>  tools/docs/lib/latex_fonts.py                 | 162 ++++
>  tools/docs/lib/python_version.py              | 178 ++++
>  tools/docs/sphinx-build-wrapper               | 791 ++++++++++++++++++
>  {scripts => tools/docs}/sphinx-pre-install    | 135 +--
>  22 files changed, 1502 insertions(+), 483 deletions(-)
>  delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
>  delete mode 100755 scripts/check-variable-fonts.sh
>  create mode 100755 scripts/lib/jobserver.py
>  delete mode 100755 scripts/split-man.pl
>  create mode 100755 tools/docs/check-variable-fonts.py
>  create mode 100755 tools/docs/lib/latex_fonts.py
>  create mode 100644 tools/docs/lib/python_version.py
>  create mode 100755 tools/docs/sphinx-build-wrapper
>  rename {scripts => tools/docs}/sphinx-pre-install (93%)
> 



Thanks,
Mauro

