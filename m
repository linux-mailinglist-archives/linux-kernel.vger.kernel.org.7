Return-Path: <linux-kernel+bounces-794806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65FB3E78D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEB317F727
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F134321A;
	Mon,  1 Sep 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrutU7Qr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D733CE81;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737757; cv=none; b=f9f1CmvWkk746z21f7N8JH9pFItqPMB+JTt/+kKky0U2ESL0gGK9iftPz/ZctAbkHmZZ7m65Eg6uBKzcvlis3bdcJWrb6Lf+udcTYgQPm2trpVhOIWi7YXcJUg9zf9lGrVZoTQ8ZpavxcC6IcDDYgB/AUIP2z7nnN2AKhJdeZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737757; c=relaxed/simple;
	bh=nQ3gIU2kA+cmRASdBGDYsjHIFhH1K/da7nJkfvh0maA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pQySJ/7QyXA1gXFwD68JTMiCgTJAaj36PXFzer1NLnCCzi/nDjeOW9N3P45lu3VKLljctVjz6LLosR1sjYs6FbtN9yqGxJz8XWqjbL7Cm9ZE5MwFWuzdfIcYy9Ovm29D7tQYC6S5LdMPNu0Un7EQGwA/7CnyMzY0IW5w3qks5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrutU7Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D819C4CEF5;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=nQ3gIU2kA+cmRASdBGDYsjHIFhH1K/da7nJkfvh0maA=;
	h=From:To:Cc:Subject:Date:From;
	b=UrutU7QrCDQF1bffalexFhKdeu/QgcxiqN8VGjYdkCcYYU47ju5eNlUahJRT6Gdiy
	 tcZqJDKkx28t7Xe9Eczp7qM2aFj7VgNCyxSUTVKZSVHhwJtw1iD0lBre707slEUHcV
	 y1Uu7FSxkup/MmxZb2JEbAJaVdz7EiiUurd1SnsAjkSXmvCHbGAOVi0AnyyiCs2D9v
	 uC/8aKF31RQAG3Y6/9E6IdGMf70/BTWbH7+eTIVocdoAgBin2c2Uz87pHFAXka09Oj
	 aPCU2oJU3/HMaAAJvbYE3QiPHMK96fjl722B9ng/cPiR007oRlXB6yeqJjNBHUKdQw
	 Z6O/I/CX+Fo1Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G37-1mbI;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] Split sphinx call logic from docs Makefile
Date: Mon,  1 Sep 2025 16:42:16 +0200
Message-ID: <cover.1756737440.git.mchehab+huawei@kernel.org>
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

I added two patches at the end adding an extra target: "mandocs".
The patches came from a series I sent in separate with 2 patches.

---

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

Mauro Carvalho Chehab (15):
  scripts/jobserver-exec: move the code to a class
  scripts/jobserver-exec: move its class to the lib directory
  scripts/jobserver-exec: add a help message
  scripts: sphinx-pre-install: move it to tools/docs
  tools/docs: sphinx-pre-install: move Python version handling to lib
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

 Documentation/Makefile                     | 134 +---
 Documentation/doc-guide/kernel-doc.rst     |  29 +-
 Documentation/sphinx/parallel-wrapper.sh   |  33 -
 Makefile                                   |   2 +-
 scripts/jobserver-exec                     |  88 +--
 scripts/lib/jobserver.py                   | 149 +++++
 scripts/lib/kdoc/kdoc_files.py             |   5 +-
 scripts/lib/kdoc/kdoc_output.py            |  84 ++-
 scripts/split-man.pl                       |  28 -
 tools/docs/lib/python_version.py           | 133 ++++
 tools/docs/sphinx-build-wrapper            | 731 +++++++++++++++++++++
 {scripts => tools/docs}/sphinx-pre-install | 134 +---
 12 files changed, 1194 insertions(+), 356 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
 create mode 100755 scripts/lib/jobserver.py
 delete mode 100755 scripts/split-man.pl
 create mode 100644 tools/docs/lib/python_version.py
 create mode 100755 tools/docs/sphinx-build-wrapper
 rename {scripts => tools/docs}/sphinx-pre-install (93%)

-- 
2.51.0


