Return-Path: <linux-kernel+bounces-813841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE60B54B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3091BC35FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A3D302CC1;
	Fri, 12 Sep 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7O3OL3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6287301015;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677594; cv=none; b=UcPfgDT0mG45nTqswD6AxF/rwBACLr5BPGJgWHFwnN33XrLv3tTCDDJ5mDqM43xgiE5BHr6uJ+UwZbxJ6uu4w+tkQt7NBUpfsvXko34rIXeXdc4HsHrJM6trM+ho1UuuCt++iMu90R38t4QfblZITzkCcy1AlBm77vOA3Mna+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677594; c=relaxed/simple;
	bh=ajsDjNRm0K7ntGPXQIC7TJ0zHzWLZyEObLeHZQzcXQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/yFgWyTDva0uaXLLMYZOE+6XIhmlY55fHQVQtcZsKAZ1GhHaoXIkaB80dMG+BwEL0kzOF6t/3tBD/4xNTAK6Wh4BiXw7xBgnzJILA7cfeOGfJgyw5X4hZjBCwSC6g/t6mi3e4oLrwTf/HU6E2RGhsrAfq3YOTMvuhZnDJ4kvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7O3OL3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0F8C4CEF9;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=ajsDjNRm0K7ntGPXQIC7TJ0zHzWLZyEObLeHZQzcXQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=Y7O3OL3VjW/em3TnrVnwa4aQRbe/NQdmkzqSBcDPIZUsmCajH+P9uuhP/ygHC1b9b
	 3dY3ewGYY+po0T/92pEfeUfNnWERiivzppyPI5zqUCk2hth4TuYT21mOz708zsYa7j
	 aZhMwm0j92BoUYa46NGffpxaoOvgqa4lUab+kqoZ1MfcCECn6W0PhJkFVjt+BpNJtF
	 AAjQvOXgNhHePbgzID90g1HtiL83D6Iym3rr+n/8oZXTJiIYTHZHm64zwDW2Sv8KM1
	 Lff3M6uFxHkU1DW+czzi30yWwcGctQixDqh3U8FQ5hz1RgQWSxAQkI9NIMMhrfKzos
	 3JreTEaErOTdA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008Rru-1yXa;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 00/18] Split sphinx call logic from docs Makefile
Date: Fri, 12 Sep 2025 13:46:07 +0200
Message-ID: <cover.1757677427.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This series does a major cleanup at docs Makefile by moving the
actual doc build logic to a helper script (scripts/sphinx-build-wrapper).

Such script was written in a way that it can be called either
directly or via a makefile. When running via makefile, it will
use GNU jobserver to ensure that, when sphinx-build is
called, the number of jobs will match at most what it is
specified by the "-j" parameter.

The first 3 patches do a cleanup at scripts/jobserver-exec
and moves the actual code to a library. Such library is used
by both the jobserver-exec command line and by sphinx-build-wrappper.

The change also gets rid of parallel-wrapper.sh, whose
functions are now part of the wrapper code.

---

v5:
- merged comments with the script;
- placed n_jobs on a separate function;
- nitpick: dropped a for loop used instead of list append.

v4:
- updated references for sphinx-pre-install after its rename;
- added some extra patches to add more options to python_version,
  allowing it to bail out and suggest alternatives;
- added a patch at the end to explicitly break doc builds when
  python3 points to python3.6 or older.

v3:
- rebased on the top of docs-next;
- added two patches to build man files that were on a separate
  patch series.

v2:
- there's no generic exception handler anymore;
- it moves sphinx-pre-install to tools/docs;
- the logic which ensures a minimal Python version got moved
  to a library, which is now used by both pre-install and wrapper;
- The first wrapper (05/13) doesn't contain comments (except for
  shebang and SPDX). The goal is to help showing the size increase
  when moving from Makefile to Python. Some file increase is
  unavoidable, as Makefile is more compact: no includes, multple
  statements per line, no argparse, etc;
- The second patch adds docstrings and comments. It has almost
  the same size of the code itself;
- I moved the venv logic to a third wrapper patch;
- I fixed an issue at the paraller build logic;
- There are no generic except blocks anymore.

Mauro Carvalho Chehab (18):
  scripts/jobserver-exec: move the code to a class
  scripts/jobserver-exec: move its class to the lib directory
  scripts/jobserver-exec: add a help message
  scripts: sphinx-pre-install: move it to tools/docs
  tools/docs: python_version: move version check from sphinx-pre-install
  tools/docs: python_version: drop a debug print
  tools/docs: python_version: allow check for alternatives and bail out
  tools/docs: sphinx-build-wrapper: add a wrapper for sphinx-build
  tools/docs: sphinx-build-wrapper: add support to run inside venv
  docs: parallel-wrapper.sh: remove script
  docs: Makefile: document latex/PDF PAPER= parameter
  tools/docs: sphinx-build-wrapper: add an argument for LaTeX
    interactive mode
  tools/docs,scripts: sphinx-*: prevent sphinx-build crashes
  tools/docs: sphinx-build-wrapper: allow building PDF files in parallel
  docs: add support to build manpages from kerneldoc output
  tools: kernel-doc: add a see also section at man pages
  scripts: kdoc_parser.py: warn about Python version only once
  tools/docs: sphinx-* break documentation bulds on openSUSE

 Documentation/Makefile                        | 136 +---
 Documentation/doc-guide/kernel-doc.rst        |  29 +-
 Documentation/doc-guide/sphinx.rst            |   4 +-
 Documentation/sphinx/kerneldoc-preamble.sty   |   2 +-
 Documentation/sphinx/parallel-wrapper.sh      |  33 -
 .../translations/it_IT/doc-guide/sphinx.rst   |   4 +-
 .../translations/zh_CN/doc-guide/sphinx.rst   |   4 +-
 Documentation/translations/zh_CN/how-to.rst   |   2 +-
 MAINTAINERS                                   |   3 +-
 Makefile                                      |   2 +-
 scripts/jobserver-exec                        |  88 +-
 scripts/lib/jobserver.py                      | 149 ++++
 scripts/lib/kdoc/kdoc_files.py                |   5 +-
 scripts/lib/kdoc/kdoc_output.py               |  84 +-
 scripts/lib/kdoc/kdoc_parser.py               |   7 +-
 scripts/split-man.pl                          |  28 -
 tools/docs/lib/python_version.py              | 178 ++++
 tools/docs/sphinx-build-wrapper               | 770 ++++++++++++++++++
 {scripts => tools/docs}/sphinx-pre-install    | 135 +--
 19 files changed, 1296 insertions(+), 367 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
 create mode 100755 scripts/lib/jobserver.py
 delete mode 100755 scripts/split-man.pl
 create mode 100644 tools/docs/lib/python_version.py
 create mode 100755 tools/docs/sphinx-build-wrapper
 rename {scripts => tools/docs}/sphinx-pre-install (93%)

-- 
2.51.0


