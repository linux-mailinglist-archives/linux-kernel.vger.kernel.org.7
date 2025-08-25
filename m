Return-Path: <linux-kernel+bounces-785194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18493B34768
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C3816EAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E93019A2;
	Mon, 25 Aug 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1yQLSey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4A2FE06F;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139449; cv=none; b=oVMQ5naWEA1JNmosYQJpZJcBwEdKFnOPcATtpkmvBkQpNmzMPs5Fhc+D6RcvXzOsUalxo7WrPW67orN9VkMR1xebfGR5FEAGYWu++50yiVd8iAbSw3jkPKJdRCPVFtYLOGSDKdzU6so+/ypwX38LujMorL3ypPQcazWYihF7S7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139449; c=relaxed/simple;
	bh=vVMKlKNXIWqTUAgQ0OfDfdnw/Qqi34KoxBHr44+YOAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIuMldPTm4PC/kEWUS+CunwJ+hLc7aVRFYN8cv294AYcG0xYJjAsw0XhC3eWewdpbmwMDzmSEFh3U7eAVFlbvXJXnuQDsu7ilqGmEegxpO22guNjG/p9nLGI6y2V9VzkUdYeIRWfk+BEPZwbQu/BU1uZf6JzA2mcLqk0SNLkKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1yQLSey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CF1C19423;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139449;
	bh=vVMKlKNXIWqTUAgQ0OfDfdnw/Qqi34KoxBHr44+YOAg=;
	h=From:To:Cc:Subject:Date:From;
	b=a1yQLSeyANUJuVo8YWqNlpBfRTt5qnxjqggmvRgb82T8792MEf77ABh9ZN8SiYPNP
	 M8+pUVcLK/yA4NEdeiu5ScLrAp9GvbGRSJ6zgx9KbxFIlONn/G0EG9eLFOV9ApuczI
	 +n3RHjbtGTFbIdiaLv9a6HkdH3U7hrYIRtxzs4M2Mc6aGaYpYUbG2NlbAu7S5VVwiw
	 ezRCNTzR89dj6gsRJTPP/Zm/70e8lVTD1bBbQTk/dgK0fd9VF3dA4SWpF0WX/OtV9I
	 W4naQnz2qNJZJv3vw3Me9pduqpg6PZFeCZq7LpFz4p1jWhgUF8ymeiPQSKd1S/w24H
	 uGCaVsmzG/n1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqa5n-0000000HALF-0aIB;
	Mon, 25 Aug 2025 18:30:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 00/13] Split sphinx call logic from docs Makefile
Date: Mon, 25 Aug 2025 18:30:27 +0200
Message-ID: <cover.1756138805.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

This series is now on top of:
	https://lore.kernel.org/linux-doc/0ad4fefca2855603c66d513474a687058e780931@intel.com/

As I'm expecting that the oner one (although it is bigger)
won't cause too much noise, as it impacts only the media builds,
and remove a hack that would otherwise require some code here.

While version 2 has the same features and almost the same code,
I did some changes to make easier to review:

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

Mauro Carvalho Chehab (13):
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

 Documentation/Makefile                     | 133 +----
 Documentation/sphinx/parallel-wrapper.sh   |  33 --
 scripts/jobserver-exec                     |  88 +--
 scripts/lib/jobserver.py                   | 149 +++++
 tools/docs/lib/python_version.py           | 133 +++++
 tools/docs/sphinx-build-wrapper            | 660 +++++++++++++++++++++
 {scripts => tools/docs}/sphinx-pre-install | 134 +----
 7 files changed, 1022 insertions(+), 308 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
 create mode 100755 scripts/lib/jobserver.py
 create mode 100644 tools/docs/lib/python_version.py
 create mode 100755 tools/docs/sphinx-build-wrapper
 rename {scripts => tools/docs}/sphinx-pre-install (93%)

-- 
2.51.0


