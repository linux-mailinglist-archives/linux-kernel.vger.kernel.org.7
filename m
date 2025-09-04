Return-Path: <linux-kernel+bounces-800167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE6B4343B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D7E7AE03C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF042D0628;
	Thu,  4 Sep 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn6VDm4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148A2BE64F;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=m13hmeAKwmURjgvBKsAwjFN7CGGR1eIlnsMPweU/D31b1tG0RfFrBFEDlDXqgkTR9fIJYFoNQCvWMfcDCz38qMRwbptsZRWWNXuaGc60sZ9yPLfdXdbMW+a1+4YpYKUQNmqEe1O1I9bKIDlLoT/Bg2OyJrvniOX6+OLivoI89YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=NUhSPmiiTFsElbsHN+7oaJO/ADQMrAks9oZl6F2vjkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uUrZJeynukpae/MpzmsHrGBua8vZBkjn4/OIJkeMyUOMzzoUl6JUsRYy5tf/ppZoM1rJo0j/f0YAuDsac4S6dUUJYFJM7w/Gznhx32/Ft1wVYGA6SoOIaPVLxs1e8shwkIZbsXY4+ZRsHQ/7aY6R/cbn+TxISmBpXYtyQmJHJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn6VDm4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF44C4CEFD;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=NUhSPmiiTFsElbsHN+7oaJO/ADQMrAks9oZl6F2vjkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qn6VDm4Jyb2dcVKfDIz0GiUixG5RI6Vxw24KrCt90SGg8AuPD8mMx2ANNsvaDmxkt
	 GT21I6YRC0wdzlA/amMOwTh7fC3Gaes88TD8jEwu55TRBCBV/8uNm4M2/ZNZgeNn/K
	 beYPmZqq76e8lN9KAUcqU2a5NlnC/4tIu+RBmMsiqng+nixVteWlhV9zoTKpAwtApO
	 JUjdO9WXdzULOtdthY2ytfizXn8Cm9yAFHMeIKiNZ4+zvtXsteiZj1LtsAMeYmcPc8
	 xtGrVHgzQZFvYhAQDSV0bYD6w+0hMISAyiw5ySS3vJsJfKhubRY4ljTjL36Oh6yfZI
	 2Tk+qSFz/aypg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jP6-2j0A;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 00/19] Split sphinx call logic from docs Makefile
Date: Thu,  4 Sep 2025 09:33:00 +0200
Message-ID: <cover.1756969623.git.mchehab+huawei@kernel.org>
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

I opted to pick patches from:
   https://lore.kernel.org/linux-doc/cover.1756916565.git.mchehab+huawei@kernel.org/T/#t

re-ordering them to make more sense.

The last patch breaks doc build when Python3 < 3.7, as requested,
or when sphinx-pre-install suggests to install an updated Sphinx
version. Matteu suggested adding a PYTHON env to allow overriding it,
but this won't would work with sphinx-pre-install, which is meant to
be executed with older python versions, but still requires to run
python from the suggested package to check if package install
succeded. Currently, sphinx-pre-install recomments to install a newer
Python on 3 distribution types:

    - 3.11 on openSuse Leap;
    - 3.9 on RHEL8 and RHEL8-based distros;
    - 3.13 on openSUSE Thumbleweed.

Patch 19 breaks sphinx-pre-install for those, and adding PYTHON
env won't properly fix it. ATM, I can't think on a good non-hacky
solution, as the only way I can think is to let sphinx-pre-install
(and sphinx-build-wrapper) execute python3.x instead of python3.

---

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

Mauro Carvalho Chehab (19):
  scripts/jobserver-exec: move the code to a class
  scripts/jobserver-exec: move its class to the lib directory
  scripts/jobserver-exec: add a help message
  scripts: sphinx-pre-install: move it to tools/docs
  tools/docs: python_version: move version check from sphinx-pre-install
  tools/docs: python_version: drop a debug print
  tools/docs: python_version: allow check for alternatives and bail out
  tools/docs: sphinx-build-wrapper: add a wrapper for sphinx-build
  tools/docs: sphinx-build-wrapper: add comments and blank lines
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
 scripts/jobserver-exec                        |  88 +--
 scripts/lib/jobserver.py                      | 149 ++++
 scripts/lib/kdoc/kdoc_files.py                |   5 +-
 scripts/lib/kdoc/kdoc_output.py               |  84 +-
 scripts/lib/kdoc/kdoc_parser.py               |   7 +-
 scripts/split-man.pl                          |  28 -
 tools/docs/lib/python_version.py              | 178 +++++
 tools/docs/sphinx-build-wrapper               | 739 ++++++++++++++++++
 {scripts => tools/docs}/sphinx-pre-install    | 135 +---
 19 files changed, 1265 insertions(+), 367 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
 create mode 100755 scripts/lib/jobserver.py
 delete mode 100755 scripts/split-man.pl
 create mode 100644 tools/docs/lib/python_version.py
 create mode 100755 tools/docs/sphinx-build-wrapper
 rename {scripts => tools/docs}/sphinx-pre-install (93%)

-- 
2.51.0


