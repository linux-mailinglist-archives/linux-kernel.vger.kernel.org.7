Return-Path: <linux-kernel+bounces-794945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B1B3EB23
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6911B27AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7B2E6CB2;
	Mon,  1 Sep 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HudxDlQQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F42DF128;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740837; cv=none; b=rowdZp/fsurB7DGAMVNqMK4Dm+DFc0tT8/M5sAhbxl0TTOhXOzFRR7cLXP2/ylHxrH0qfCuJh6UO/n0a2n89RsHN+T8Kp7m71ptTgAzD4hGhl4meVNLNQB//HdOoVlps/CwtHEpPOkuWqFF1YCOxd1xA+HRpewaug2eEGzVbTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740837; c=relaxed/simple;
	bh=sS66a1uDqAjpo1Lw6GFNdsvFX00OUSEuMk0DjRX5HIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uB9VtAfGAQKGhRVGZDTWmyFt876Qu52AkB1CAePvMAD4aOgLGi78G1aKQh6YkVZ0MdXRAIuw35+lFmckpOJn7EofO0MBsdUAZvGEXHDg1ZWpYASUPHPPTiUTwfXTbObc5gi1iObYgjR8F4LM4WV6By4K6rPkGMZaHmcsRXtm89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HudxDlQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAABC4CEF1;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=sS66a1uDqAjpo1Lw6GFNdsvFX00OUSEuMk0DjRX5HIU=;
	h=From:To:Cc:Subject:Date:From;
	b=HudxDlQQBkBCa7rmi6xTphAPfwlZywe9f2SLXiHE02KmMqX7YmXqJ7gWFiCq2B0Hw
	 CUmYPowNkMxCHmPGnISihfKoymnkeGhwHzj/CZX87MI7nzmVPHNvoFBz+RscmIDIv0
	 Qgf9iwRKvKwi4BsC2tk1qt3svtJZaD1HfrSvZ8ggrTMfSLHZRunO/HV0Cuxq7149sV
	 Zu53dJRSx6+ysYLx12qvv/DBJs7Xv0W7JLqANutr3w9AF9HYY5pR+yODoctxX8Tvvg
	 OoWj8MSPoVYXutAvFEOR9NdxSsOzMbpIdQXLBWc9uMV1OYDKmlglERIAdGu3zPVDhH
	 E3k3IITd+nVjA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HLb-1xT0;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 00/15] Split sphinx call logic from docs Makefile
Date: Mon,  1 Sep 2025 17:33:35 +0200
Message-ID: <cover.1756740314.git.mchehab+huawei@kernel.org>
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

Sorry for resending this one. Two e-mails ended being encoded
using base64 (*). The content of this series is identical. The
only difference is that all patches including 05 and 15 are now
in plain text (using 8bit encoding).

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

(*) I just converted by internal mailbomb script to Python, but
EmailMessage is really tricky - I spent most of my time scratching
my head to get it right - It has a confusing set of "policy" rules
and two functions to generate messages. It turns that just using a
good policy is not enough: one needs to use as_bytes() to avoid
base64 encoding.

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


