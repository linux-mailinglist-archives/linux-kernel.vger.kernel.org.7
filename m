Return-Path: <linux-kernel+bounces-770841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E251CB27F92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3931B64614
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43AC301469;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j25J8fVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624D287279;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=fM0dOWlyX83uQFjVwebvarE3Xmv0W8KT8+EPhhLFybl0Xv0WRl7l38SVkOSaoE5753YS6INOzUzsCMH8poiaUt42IP9JLe9nrDqRaRtYQsCGxrOZ75n2puYkihSFmuoaoUmOxCTdcl7mP3BG2opLHuTVxjr1CVSydllOu75ec0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=sYk4mJd+UWrLz9Ei9ZPyoYmT4cWG5qlsc0OeM9aNUz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhxpKC5scaEXSkTj8S70lWffMla6KSuVx7+aq2QE/rsVrbWt+5BmMPUlUCjHgD7OtUFSNySmUBPFTnVwCreufRUND1ARDGDYtBrgJQe3kNtVBmkmIbNyWUuddMDwrFDbyjp0v0a/UTu1HvRzqLls1xJot0N/HLP7SfDxVuv7f9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j25J8fVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41E7C4CEF9;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258665;
	bh=sYk4mJd+UWrLz9Ei9ZPyoYmT4cWG5qlsc0OeM9aNUz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j25J8fVxjsK4GpVhTMfuFJSURqWFBKvVoxk1POR/DNfXU8Bz7X8i+spGhVPlG2++u
	 v4KcXVzNMacLYDoeB4A4ARH4pRPnDjRfb98kB63zcO5ZTEeiG0Rhooz0OTPwDONYER
	 NwuVGiy9q0HtUaaik6i+nJ3EV6G1aq5gKbDDbxk7vBMqXr3W8vs9vBxnRGKBswoEsV
	 8PTUZ9FQYzlSsqdp8og5ilIGslKUu8mIdgYXmz0BMOswZzT4jueF7p5jUSjDdJ8kaF
	 W31BQhwbKZYViO43q8C1/DOfn46xtq79nBjq+ZDx41gejJ7+ew4rnilHcDsHutTdK+
	 POGfgiAm4+7uw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042oa-0YFn;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] docs: parallel-wrapper.sh: remove script
Date: Fri, 15 Aug 2025 13:50:34 +0200
Message-ID: <fe3bf7324d275ab1cb096ec792e4f8b34af7c2b6.1755258303.git.mchehab+huawei@kernel.org>
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

The only usage of this script was docs Makefile. Now that
it is using the new sphinx-build-wrapper, which has inside
the code from parallel-wrapper.sh, we can drop this script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parallel-wrapper.sh | 33 ------------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh

diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphinx/parallel-wrapper.sh
deleted file mode 100644
index e54c44ce117d..000000000000
--- a/Documentation/sphinx/parallel-wrapper.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Figure out if we should follow a specific parallelism from the make
-# environment (as exported by scripts/jobserver-exec), or fall back to
-# the "auto" parallelism when "-jN" is not specified at the top-level
-# "make" invocation.
-
-sphinx="$1"
-shift || true
-
-parallel="$PARALLELISM"
-if [ -z "$parallel" ] ; then
-	# If no parallelism is specified at the top-level make, then
-	# fall back to the expected "-jauto" mode that the "htmldocs"
-	# target has had.
-	auto=$(perl -e 'open IN,"'"$sphinx"' --version 2>&1 |";
-			while (<IN>) {
-				if (m/([\d\.]+)/) {
-					print "auto" if ($1 >= "1.7")
-				}
-			}
-			close IN')
-	if [ -n "$auto" ] ; then
-		parallel="$auto"
-	fi
-fi
-# Only if some parallelism has been determined do we add the -jN option.
-if [ -n "$parallel" ] ; then
-	parallel="-j$parallel"
-fi
-
-exec "$sphinx" $parallel "$@"
-- 
2.50.1


