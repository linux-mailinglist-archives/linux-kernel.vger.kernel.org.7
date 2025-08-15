Return-Path: <linux-kernel+bounces-770840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E6DB27F84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CAD3B28C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EAF301016;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTjHLg0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666B3B1AB;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=TKlBrhwq5wCU8nMzTr8DzHOKxNqQFysJHtD36MVah0+fWQ7MOdS3s/sh9c6mbYh6sKhiCU0vb5qDKz1juHhmpFuwyRRoLAFOgB6rGF77fq5o8+pgjZyhN4ixArL4szirG5v9AUcAX2G0DRadTzMfshPImBoTrXDn1/nQJ8k4Sos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=nldqsF3EOmQUIwjzdXAE0KBnBekNdat4KRfd+U9Y8V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUWNPMU1T9myPJ2fgv/Q5gPI2e5c7dldbpLwagXj/6Uzizbwa8AKg2oJdJcJ0T/5OFMqDJmDdinaNj4IqBV3VYDLVK3DzTue8q7Lhl0itDz4K/T9H6B8oMztE8BGBWAWqkGfcXYaqcp3rv8uHqBzT8XPSQkB/ztRUU86qb+/rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTjHLg0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA5AC4CEF0;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258665;
	bh=nldqsF3EOmQUIwjzdXAE0KBnBekNdat4KRfd+U9Y8V8=;
	h=From:To:Cc:Subject:Date:From;
	b=KTjHLg0V0d6MZpKmtqEEl/E3JIgAOp1uXyr635HAqIObJ94g2gsbtSpmJRRsihArX
	 kmSjqS/6cYfjdhBoTYw7dSR5SPcqoSYWr9bT2ZFlb82yMklMMzUzX97Y3lbVL1QffF
	 OYHjfyFIZiUHliIy4jOLs6S4rLrKkKZCK3IQYX3k7VhRTp/hYEjzI/RJCvsJvA2QTE
	 XdW/kQ1l5GzHuwS2YiYPkwzqVr7TiHSCVFXqvzqhHf27IhKrPATIr/HsR7p7qC6G5T
	 FnbX4kGXSPcqrFYwKGswyqxRlrrUTKoshtASTwh8BK7TgktzrK788FAuuLza39ZOLD
	 v7nYRmXcNmEJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxb-000000042oD-432r;
	Fri, 15 Aug 2025 13:51:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH 00/11] Split sphinx call logic from docs Makefile
Date: Fri, 15 Aug 2025 13:50:28 +0200
Message-ID: <cover.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This series does a major cleanup at docs Makefile by moving the
actual doc build logic to a helper script (scripts/sphinx-build-wrapper).

Such script was written in a way that it can be called either
directly or via a makefile. When running via makefile, it will
use GNU jobserver to ensure that, when sphinx-build is
called, the number of jobs will match at most what it is
specified by the "-j" parameter.

The first 3 patches do a cleanup at scripts/jobserver-exec
and moves the actual code to a library. Such library is used
by both the jobserver-exec command line and by 
sphinx-build-wrappper.

The change also gets rid of parallel-wrapper.sh, whose
functions are now part of the wrapper code.

Mauro Carvalho Chehab (11):
  scripts/jobserver-exec: move the code to a class
  scripts/jobserver-exec: move its class to the lib directory
  scripts/jobserver-exec: add a help message
  scripts: sphinx-build-wrapper: add a wrapper for sphinx-build
  docs: Makefile: cleanup the logic by using sphinx-build-wrapper
  docs: parallel-wrapper.sh: remove script
  docs: Makefile: document latex/PDF PAPER= parameter
  scripts/sphinx-build-wrapper: restore SPHINXOPTS parsing
  scripts: sphinx-build-wrapper: add an argument for LaTeX interactive
    mode
  scripts: sphinx-*: prevent sphinx-build crashes
  docs: Makefile: cleanup the logic by using sphinx-build-wrapper

 .pylintrc                                |   2 +-
 Documentation/Makefile                   | 140 ++---
 Documentation/sphinx/parallel-wrapper.sh |  33 --
 scripts/jobserver-exec                   |  88 +--
 scripts/lib/jobserver.py                 | 149 +++++
 scripts/sphinx-build-wrapper             | 696 +++++++++++++++++++++++
 scripts/sphinx-pre-install               |  14 +-
 7 files changed, 922 insertions(+), 200 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
 create mode 100755 scripts/lib/jobserver.py
 create mode 100755 scripts/sphinx-build-wrapper

-- 
2.50.1



