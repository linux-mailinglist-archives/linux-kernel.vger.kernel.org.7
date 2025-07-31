Return-Path: <linux-kernel+bounces-751622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DDB16B90
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43FE7A818D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F9242D79;
	Thu, 31 Jul 2025 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV64E5tl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA8241C8C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940055; cv=none; b=TYNkg40UIKEXZHAN4Ek+2rc+6EUMFHb+c2EDJ1JQHRf3XF5ugCl7df+x7I7krO6GCwDBRHZ31NNuNd9Mi9DwUc99jEABQAd2PTfDuCxjVBVxkl4TJo0s/q6UYgmFhF3E+jcQjOL1qoQt4dOShFAgFuiO/7xtBjWhfGVcsKG05H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940055; c=relaxed/simple;
	bh=70nlEbBpf/kwmKcOZVIITRr5X3u+Y97vLaywevfKKTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic8oKYkeC3+9lSNhZBTzDpHcSJ8T8rKgJv8A5culbF4/ooZG+663t06A1KTrSfaFk/peYdl1nhWRgTlwoTN4IxyqJbXD+AEF6Na+P/Z3/rbGgyM/ZT5hulJJhXVHVkjjOWWeT9nW7rdcO68qHZFWXZi82y3ajapCkp86sG6inpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV64E5tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B6FC4CEF6;
	Thu, 31 Jul 2025 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753940054;
	bh=70nlEbBpf/kwmKcOZVIITRr5X3u+Y97vLaywevfKKTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rV64E5tlXseB7DEcdMXGkg5+3uZ29ChDiKGj3zXkwN7RmVQoyNFN+QWFT50XbuQXl
	 /ayM8s+z8xFnZc0sGGRjWJehB+d8Xy1w4KVf63jHVk6uaBcdaX287RM0/J5RvZZgIO
	 DNbCyFrtT94QkHKEtPb4oumTW3k/n6Af8yFmC+h8wSmbLSoqqO4h3BupNO5yAOi2Sb
	 PwfyWmxUu6KSkFb3xFp0rkTj0CNkC/T0u4v9cp6hF6vWV+Nv0cRvQ+fXVioSDCZVF4
	 NV/9Dzai8CdzSrFqf0fq59+tz2NZ3aApDOU3xCvAOp2IEVp7jBI0mWGKK4e5XONahe
	 xndcaOPB4YDlw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH 2/2] f2fs: add time stats of checkpoint for debug
Date: Thu, 31 Jul 2025 13:34:05 +0800
Message-ID: <20250731053405.1127197-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
In-Reply-To: <20250731053405.1127197-1-chao@kernel.org>
References: <20250731053405.1127197-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpoint was blocked for 18643 ms
Step 0: 0 ms
Step 1: 38 ms
Step 2: 63 ms
Step 3: 4 ms
Step 4: 0 ms
Step 5: 0 ms
Step 6: 9 ms
Step 7: 0 ms
Step 8: 18277 ms
Step 9: 249 ms

Cc: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h       | 22 +++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 02806e2edce4..bbe07e3a6c75 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1442,6 +1442,34 @@ u64 f2fs_get_sectors_written(struct f2fs_sb_info *sbi)
 	return get_sectors_written(sbi->sb->s_bdev);
 }
 
+static inline void stat_cp_time(struct cp_control *cpc, enum cp_time type)
+{
+	cpc->stats.times[type] = ktime_get();
+}
+
+static inline void check_cp_time(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+{
+	unsigned long long sb_diff, cur_diff;
+	enum cp_time ct;
+
+	sb_diff = (u64)ktime_ms_delta(sbi->cp_stats.times[CP_TIME_END],
+					sbi->cp_stats.times[CP_TIME_START]);
+	cur_diff = (u64)ktime_ms_delta(cpc->stats.times[CP_TIME_END],
+					cpc->stats.times[CP_TIME_START]);
+
+	if (cur_diff > sb_diff) {
+		sbi->cp_stats = cpc->stats;
+		if (cur_diff < CP_LONG_LATENCY_THRESHOLD)
+			return;
+
+		f2fs_warn(sbi, "checkpoint was blocked for %llu ms", cur_diff);
+		for (ct = CP_TIME_START; ct < CP_TIME_MAX - 1; ct++)
+			f2fs_warn(sbi, "Step#%d: %llu ms", ct,
+				(u64)ktime_ms_delta(cpc->stats.times[ct + 1],
+						cpc->stats.times[ct]));
+	}
+}
+
 static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -1459,6 +1487,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* Flush all the NAT/SIT pages */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 
+	stat_cp_time(cpc, CP_TIME_SYNC_META);
+
 	/* start to update checkpoint, cp ver is already updated previously */
 	ckpt->elapsed_time = cpu_to_le64(get_mtime(sbi, true));
 	ckpt->free_segment_count = cpu_to_le32(free_segments(sbi));
@@ -1555,20 +1585,26 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+	stat_cp_time(cpc, CP_TIME_SYNC_CP_META);
+
 	/* Wait for all dirty meta pages to be submitted for IO */
 	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
+	stat_cp_time(cpc, CP_TIME_WAIT_DIRTY_META);
 
 	/* wait for previous submitted meta pages writeback */
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
+	stat_cp_time(cpc, CP_TIME_WAIT_CP_DATA);
 
 	/* flush all device cache */
 	err = f2fs_flush_device_cache(sbi);
 	if (err)
 		return err;
+	stat_cp_time(cpc, CP_TIME_FLUSH_DEVICE);
 
 	/* barrier and flush checkpoint cp pack 2 page if it can */
 	commit_checkpoint(sbi, ckpt, start_blk);
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
+	stat_cp_time(cpc, CP_TIME_WAIT_LAST_CP);
 
 	/*
 	 * invalidate intermediate page cache borrowed from meta inode which are
@@ -1613,6 +1649,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long long ckpt_ver;
 	int err = 0;
 
+	stat_cp_time(cpc, CP_TIME_START);
+
 	if (f2fs_readonly(sbi->sb) || f2fs_hw_is_readonly(sbi))
 		return -EROFS;
 
@@ -1624,6 +1662,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (cpc->reason != CP_RESIZE)
 		f2fs_down_write(&sbi->cp_global_sem);
 
+	stat_cp_time(cpc, CP_TIME_LOCK);
+
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
 		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
 		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
@@ -1639,6 +1679,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (err)
 		goto out;
 
+	stat_cp_time(cpc, CP_TIME_OP_LOCK);
+
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
 
 	f2fs_flush_merged_writes(sbi);
@@ -1678,6 +1720,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	f2fs_flush_sit_entries(sbi, cpc);
 
+	stat_cp_time(cpc, CP_TIME_FLUSH_META);
+
 	/* save inmem log status */
 	f2fs_save_inmem_curseg(sbi);
 
@@ -1695,6 +1739,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	stat_inc_cp_count(sbi);
 stop:
 	unblock_operations(sbi);
+	stat_cp_time(cpc, CP_TIME_END);
+	check_cp_time(sbi, cpc);
 
 	if (cpc->reason & CP_RECOVERY)
 		f2fs_notice(sbi, "checkpoint: version = %llx", ckpt_ver);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c036af1a885a..691af2a6c159 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -269,11 +269,32 @@ enum {
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
+enum cp_time {
+	CP_TIME_START,		/* begin */
+	CP_TIME_LOCK,		/* after cp_global_sem */
+	CP_TIME_OP_LOCK,	/* after block_operation */
+	CP_TIME_FLUSH_META,	/* after flush sit/nat */
+	CP_TIME_SYNC_META,	/* after sync_meta_pages */
+	CP_TIME_SYNC_CP_META,	/* after sync cp meta pages */
+	CP_TIME_WAIT_DIRTY_META,/* after wait on dirty meta */
+	CP_TIME_WAIT_CP_DATA,	/* after wait on cp data */
+	CP_TIME_FLUSH_DEVICE,	/* after flush device cache */
+	CP_TIME_WAIT_LAST_CP,	/* after wait on last cp pack */
+	CP_TIME_END,		/* after unblock_operation */
+	CP_TIME_MAX,
+};
+
+/* time cost stats of checkpoint */
+struct cp_stats {
+	ktime_t times[CP_TIME_MAX];
+};
+
 struct cp_control {
 	int reason;
 	__u64 trim_start;
 	__u64 trim_end;
 	__u64 trim_minlen;
+	struct cp_stats stats;
 };
 
 /*
@@ -1650,6 +1671,7 @@ struct f2fs_sb_info {
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
 	long interval_time[MAX_TIME];		/* to store thresholds */
 	struct ckpt_req_control cprc_info;	/* for checkpoint request control */
+	struct cp_stats cp_stats;		/* for time stat of checkpoint */
 
 	struct inode_management im[MAX_INO_ENTRY];	/* manage inode cache */
 
-- 
2.49.0


