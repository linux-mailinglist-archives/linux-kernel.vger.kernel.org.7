Return-Path: <linux-kernel+bounces-731038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4BB04DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04AC3A5363
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586112C374E;
	Tue, 15 Jul 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPir47qk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742527281C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546395; cv=none; b=VUgloxn7X1jpN6cjjPKCEcGdGEsCL0zluVj0uhsaab/efphtsdSihHReGgJWgl6dWwAYpORLdXvFIwWoXS+lzMlLRAC98ASciZN1jB3XizC0NeogHrerGcD9U9SExz4x+fDzTPowKa6n+JGQ/2NjxEsnzBp+AXvJ8HhNM5/JlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546395; c=relaxed/simple;
	bh=LDF8ELnAISm2MY+yWCwH0B1RSYhTFfoVGF4gO7BZFuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evtmGIdPa+wjiLemYQePU3/npBIGwpHvO/2Ttw8CmkGXtKSVgLf8k+foZ3RwrOvJViN5ZMHllRq2uMfatk9WtT60OhtosF28mWxxbgXBi0pO7dQg7APSvEtSWgVuPXIoRglM5IUUplvA0niV5G2Jgb5vmJ7+2QGwEsy7TSFlmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPir47qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C93FC4CEED;
	Tue, 15 Jul 2025 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752546394;
	bh=LDF8ELnAISm2MY+yWCwH0B1RSYhTFfoVGF4gO7BZFuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=WPir47qkdxmJERwcpkN40L8CweIOxH4yrHvniCI93JWbM288BdEhCoRNoLUtz/vZ0
	 G/keyEKUZhwNdG1ElP40v0AF/siFjB1xlst1Mgq8bSbeM9KwSFhvdgcdB/7BWy0aw4
	 o2dzo2ZcBDdjTqnfFMyH/URtAKR9eILSesr0DaCRTSk7OTGD2GF7dr4qjV+OB9uPq6
	 SFWayFp/XYLOQSNLy0hfVS2G3WlYLFoXEdOzgwOWXxzndccn5UpXEr+akwX6hf98wO
	 nYvqL8IvSfb5fFlrf8MSNGh+Of9qQQXUYPE+kYpWEnJx/eS3C6p5oZA+clekgcp1Du
	 jEW+9ahY8oHIw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs_io: fix doc of test_lookup_perf
Date: Tue, 15 Jul 2025 10:26:29 +0800
Message-ID: <20250715022629.486521-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change as below:
- add an entry for test_lookup_perf in manual
- fix wrong parameter in usage of test_lookup_perf

Signed-off-by: Chao Yu <chao@kernel.org>
---
 man/f2fs_io.8           | 3 +++
 tools/f2fs_io/f2fs_io.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index e0f659e..0d69b5f 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -184,6 +184,9 @@ Get i_advise value and info in file
 .TP
 \fBioprio\fR \fI[hint] [file]\fR
 Set ioprio to the file. The ioprio can be ioprio_write.
+.TP
+\fBtest_lookup_perf\fR \fI[-i] [-v] <dir> <num_files>\fR
+Measure readdir/stat speed
 .SH AUTHOR
 This version of
 .B f2fs_io
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 8e81ba9..f282190 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -2241,7 +2241,7 @@ static void do_test_create_perf(int argc, char **argv, const struct cmd_desc *cm
 
 #define test_lookup_perf_desc "measure readdir/stat speed"
 #define test_lookup_perf_help						\
-"f2fs_io test_lookup_perf [-s] [-S] <dir> <num_files>\n\n"		\
+"f2fs_io test_lookup_perf [-i] [-v] <dir> <num_files>\n\n"		\
 "Measures readdir/stat performance.\n"				\
 "  <dir>          The target directory in where it will test on.\n"	\
 "  <num_files>    The total number of files the test will initialize or test.\n"\
-- 
2.49.0


