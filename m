Return-Path: <linux-kernel+bounces-874611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F1C16B03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C281403AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4643502A2;
	Tue, 28 Oct 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En50DAfU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDF2D0625
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681286; cv=none; b=CVxdSHpFIYg/Gzr/WPLCzaiClg/lfLAMtKGNGpBbZFrgrjFexx9k+AHpipgdXNUIgmDq9Lg3s1W6sm+Me5+b5EeEOj2jC6m6B6FGkGIE//2LIUWzB5UOiZzuCt2hXcnJM9JbpyxvRgglbBaxnUe3m1fOWIRXQQwVsjVZZWSWNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681286; c=relaxed/simple;
	bh=sLuFwvAwHUNO/skdE7BzrktYPRAzXyoh3REUgst9oAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvTvnjWdxxLMfdXiA8oWpis+lU9aJrg8nx/cOgpgCdCCkwb39qkUuOob4CJRswLXgdzX8DJyO5U/fES3qjtvJJXFug5Dzfv+Irb9lS0+AQwm3xWFHAt5zgN5k90UUwlYHleZKNgtMTHnItaRHYr2Vp60RK6WgUbSQlEWb6gQnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En50DAfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8B7C4CEE7;
	Tue, 28 Oct 2025 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761681286;
	bh=sLuFwvAwHUNO/skdE7BzrktYPRAzXyoh3REUgst9oAM=;
	h=From:To:Cc:Subject:Date:From;
	b=En50DAfURMwXsnoO7ty2KsDNFEjyMIKRKv83LzWhaGEwphyfErYT9jDhE8kZx78vh
	 kvCCpMWW4uLtZN/bi9mSSJtQw7/wNqe6HrW53e40W6gEV8Y2tJ3fDMVHsa/zyQcWsL
	 rW2NHErauKIyGnpIezZG0fLiURuQpLtXiwHKIE+MvpS8/qdP9pmI8Y0Hbmu06OFrmG
	 j/wDKnOUVaM3PsQ8VwsK0m+w9wYdUdqLM18ioVCkjbz6+7cYI31ABz42zaOZSa++os
	 1RmG0YjIihIRyTs9Fp+9/eWg7c+4eMJeb/fqS3FSMC7iy6B8KvzktN/rK4ZGeeQehb
	 Fm0nChBPrKTsA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add fadvise tracepoint
Date: Tue, 28 Oct 2025 19:54:44 +0000
Message-ID: <20251028195444.3181203-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a tracepoint in the fadvise call path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  2 ++
 include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6d42e2d28861..4a81089c5df3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 	struct inode *inode = file_inode(filp);
 	int err;
 
+	trace_f2fs_fadvise(inode, offset, len, advice);
+
 	if (advice == POSIX_FADV_SEQUENTIAL) {
 		if (S_ISFIFO(inode->i_mode))
 			return -ESPIPE;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index edbbd869078f..b7f5317b5980 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
 		__entry->ret)
 );
 
+TRACE_EVENT(f2fs_fadvise,
+
+	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
+
+	TP_ARGS(inode, offset, len, advice),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, size)
+		__field(loff_t,	offset)
+		__field(loff_t,	len)
+		__field(int,	advice)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->size	= inode->i_size;
+		__entry->offset	= offset;
+		__entry->len	= len;
+		__entry->advice	= advice;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
+		show_dev_ino(__entry),
+		(unsigned long long)__entry->size,
+		__entry->offset,
+		__entry->len,
+		__entry->advice)
+);
+
 TRACE_EVENT(f2fs_map_blocks,
 	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
 		 int ret),
-- 
2.51.1.851.g4ebd6896fd-goog


