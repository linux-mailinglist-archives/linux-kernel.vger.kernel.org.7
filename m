Return-Path: <linux-kernel+bounces-758613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E2B1D164
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3DE18C0B03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D91E520C;
	Thu,  7 Aug 2025 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhKxs/og"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886B1E32A2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754539241; cv=none; b=lVZykCL9GWqGOsjAC6NSxYYcoNZL6EU/Mu8NzX6Ij2rmU12d3nAjqJqF2JSNXiEfZfNKSYiKyTcPkrPCYBi6yHDqxv5MEt0ORY5Xj4V4BlQEAt5/y3g2GKZt+fTjklP5PfXDKnfej+pcRAFtYrjVheBnVIdrDw/gXN8jTGJPWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754539241; c=relaxed/simple;
	bh=J69EE3KRuZ7GD4kBtdS/XSaP++KQecRr00/rp4QbhdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz30PWpQh6/JqlHCrixU064jBSByVXJAq4TvGX0XOBcHlDp0s51Cow4H+zlYt7Zf5SZ7UgXDUJ2zuP97DOfuWcHAoPkuzN3hdfbJhOzHnkIL8xQg3Ls2r4J4t5Now+yObN4iWdK6HgsQFChoJ6bwRagPGs1SKj5rv43DOmOga5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhKxs/og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EDBC4CEF1;
	Thu,  7 Aug 2025 04:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754539240;
	bh=J69EE3KRuZ7GD4kBtdS/XSaP++KQecRr00/rp4QbhdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JhKxs/ogHsMXCaLwxwq/fKwMRCI2jUa1C4T8hygj9/mrX0FCC3KElpXajM2cbgNgh
	 H3hN+BFqHa/+IzddU93Yq1PH8TI4ZnEETIbBu0eIngoIH3SYaDWZTAalcrReiSL8PF
	 XO54RD1aT2XzoCLOJ/Fo6G9AwPieTSgEyRBe48YToyh2bFutbmM3bmWfjCc+zPCmRg
	 704ilncmRUOwhOOqdKQrilJbBqzzloltqvRKTFRZunrOvIjt9mv6neqDk3/LwAXoBX
	 x9VIgT+T1GombC+pI4x9fC0bU1iO6MlHOYMyTYIubE7l4dBBqYpWSxZohrrZbR3ovQ
	 sZdZBYCtkQVow==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: dump more information for f2fs_{enable,disable}_checkpoint()
Date: Thu,  7 Aug 2025 12:00:26 +0800
Message-ID: <20250807040026.3834543-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807040026.3834543-1-chao@kernel.org>
References: <20250807040026.3834543-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes as below:
- print more logs for f2fs_{enable,disable}_checkpoint()
- account and dump time stats for f2fs_enable_checkpoint()

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 411265c75698..67788177c75b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2618,15 +2618,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 restore_flag:
 	sbi->gc_mode = gc_mode;
 	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
+	f2fs_info(sbi, "f2fs_disable_checkpoint() finish, err:%d", err);
 	return err;
 }
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
+	long long start, writeback, end;
+
+	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
+					get_pages(sbi, F2FS_DIRTY_META),
+					get_pages(sbi, F2FS_DIRTY_NODES),
+					get_pages(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_update_time(sbi, ENABLE_TIME);
 
+	start = ktime_get();
+
 	/* we should flush all the data to keep data consistency */
 	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
 		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
@@ -2635,6 +2644,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 		if (f2fs_time_over(sbi, ENABLE_TIME))
 			break;
 	}
+	writeback = ktime_get();
 
 	sync_inodes_sb(sbi->sb);
 
@@ -2653,6 +2663,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
+
+	end = ktime_get();
+
+	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
+					ktime_ms_delta(writeback, start),
+					ktime_ms_delta(end, writeback));
 }
 
 static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
-- 
2.49.0


