Return-Path: <linux-kernel+bounces-895340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871CC4D874
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D783A95CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3930FC3C;
	Tue, 11 Nov 2025 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuMp5FD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB717B43F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861961; cv=none; b=N/iTKKh0y8Opbdp5y2V7ZOhSVVNz3QUbBNEOy7Mg9cnxgLms6DKikj636c5MNYZWtkYongOi/W8rQjiK2c7to72Wh1y3f9iFD3BmaYsdPtZTG/Ng6LbdyKcc+BZsqPZS+D5XM06VvnJXLrcfeLzTpyZBSON1d0b0cW1Smcf2pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861961; c=relaxed/simple;
	bh=f0XE65b1NgWCvWIatN8NS71lYVsIlzHRSSg7H2dpm7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flTkmU+84JlBAo0B8ypoReibfDvQfYIIBSR1qqK9E3DFwTRdaayI5WUq9IPV0DjjS/JSHH6x4smh8i36UoNb9zVuscZX9fbMnMchsoA7iU8xaedLmPtFL09IP1iZznLpbNOhCTAhFazSL51B+BrVRZ0hk60M8+JISL4WQkUMGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuMp5FD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB72EC4AF09;
	Tue, 11 Nov 2025 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861960;
	bh=f0XE65b1NgWCvWIatN8NS71lYVsIlzHRSSg7H2dpm7A=;
	h=From:To:Cc:Subject:Date:From;
	b=YuMp5FD5viR69Xb+Kw7yMefvAmTyOqe3b/5502NN+jDM0hOuOtF5n7rS6S1OIYmjo
	 4uy+R1eMPG7+O0XIWWYMjpKwYPTr6NPrhpS7eznky6QjE90rAKaFesCLFoa3icKX0f
	 XGo+eeL9Lxgwhd98jsl/MBFsEeoOjXmkIwwCaCX+6Q74Y0LbzsSq1bx2UYQTIPjTUa
	 neFlzpbvvLwXkEtMXZwqS7dqxsIWGoWeHs/dXYSFwse1s+R671yzdY05LqVXs3nJbA
	 +8AllaFZuHKc5O1AEMjQd0F8a+aBN6Ue1f2s7Yx3atn/iUKTluh+PPneV/990Pd6+4
	 xizHAwUPllBww==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: introduce f2fs_schedule_timeout()
Date: Tue, 11 Nov 2025 19:52:28 +0800
Message-ID: <20251111115229.1729729-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In f2fs retry logic, we will call f2fs_io_schedule_timeout() to sleep as
uninterruptible state (waiting for IO) for a while, however, in several
paths below, we are not blocked by IO:
- f2fs_write_single_data_page() return -EAGAIN due to racing on cp_rwsem.
- f2fs_quota_write() and __replace_atomic_write_block() failed due to
no memory.
- f2fs_flush_device_cache() failed to submit preflush command.
- __issue_discard_cmd_range() sleeps periodically in between two in batch
discard submissions.

So, in order to reveal state of task more accurate, let's introduce
f2fs_schedule_timeout() and call it in above paths in where we are waiting
for non-IO reasons.

Then we can get real reason of uninterruptible sleep for a thread in
tracepoint, perfetto, etc.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/compress.c   |  4 ++--
 fs/f2fs/data.c       |  4 ++--
 fs/f2fs/f2fs.h       | 22 +++++++++++++++-------
 fs/f2fs/segment.c    |  6 +++---
 fs/f2fs/super.c      |  4 ++--
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bbe07e3a6c75..4c401b5b2933 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1318,7 +1318,7 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 			f2fs_submit_merged_write(sbi, DATA);
 
 		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
-		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
 }
@@ -1974,7 +1974,7 @@ void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi)
 
 	/* Let's wait for the previous dispatched checkpoint. */
 	while (atomic_read(&cprc->queued_ckpt))
-		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 }
 
 void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 716004ba44dc..148bb925b03b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1057,7 +1057,7 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 		f2fs_submit_merged_write(F2FS_I_SB(cc->inode), DATA);
 		while (atomic_read(&cic->pending_pages) !=
 					(cc->valid_nr_cpages - submitted + 1))
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 	}
 
 	/* Cancel writeback and stay locked. */
@@ -1574,7 +1574,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				 */
 				if (IS_NOQUOTA(cc->inode))
 					goto out;
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 				goto retry_write;
 			}
 			goto out;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d8e163cc7308..48c20386f031 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3150,8 +3150,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
-						f2fs_io_schedule_timeout(
-							DEFAULT_IO_TIMEOUT);
+						f2fs_schedule_timeout(
+							DEFAULT_SCHEDULE_TIMEOUT);
 						goto retry_write;
 					}
 					goto next;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a4439175eabf..0d0e0a01a659 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -656,8 +656,8 @@ enum {
 
 #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
 
-/* congestion wait timeout value, default: 20ms */
-#define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
+/* IO/non-IO congestion wait timeout value, default: 20ms */
+#define	DEFAULT_SCHEDULE_TIMEOUT	(msecs_to_jiffies(20))
 
 /* timeout value injected, default: 1000ms */
 #define DEFAULT_FAULT_TIMEOUT	(msecs_to_jiffies(1000))
@@ -4919,22 +4919,30 @@ static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
 }
 
-static inline void f2fs_io_schedule_timeout(long timeout)
+static inline void __f2fs_schedule_timeout(long timeout, bool io)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	io_schedule_timeout(timeout);
+	if (io)
+		io_schedule_timeout(timeout);
+	else
+		schedule_timeout(timeout);
 }
 
+#define f2fs_io_schedule_timeout(timeout)		\
+			__f2fs_schedule_timeout(timeout, true)
+#define f2fs_schedule_timeout(timeout)			\
+			__f2fs_schedule_timeout(timeout, false)
+
 static inline void f2fs_io_schedule_timeout_killable(long timeout)
 {
 	while (timeout) {
 		if (fatal_signal_pending(current))
 			return;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-		if (timeout <= DEFAULT_IO_TIMEOUT)
+		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+		if (timeout <= DEFAULT_SCHEDULE_TIMEOUT)
 			return;
-		timeout -= DEFAULT_IO_TIMEOUT;
+		timeout -= DEFAULT_SCHEDULE_TIMEOUT;
 	}
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8d26cc7f8add..58a5d6bc675f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -234,7 +234,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 			goto retry;
 		}
 		return err;
@@ -750,7 +750,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		do {
 			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
 			if (ret)
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 		} while (ret && --count);
 
 		if (ret) {
@@ -3462,7 +3462,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 			goto next;
 		}
 skip:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c2161b3469b3..b43aeb830f27 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2652,7 +2652,7 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* we should flush all the data to keep data consistency */
 	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
 		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
-		f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 
 		if (f2fs_time_over(sbi, ENABLE_TIME))
 			break;
@@ -3139,7 +3139,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&folio, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
-- 
2.49.0


