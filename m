Return-Path: <linux-kernel+bounces-751621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36FFB16B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8171665A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5D1FAC54;
	Thu, 31 Jul 2025 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXN9TUYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D6323D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940053; cv=none; b=OezVdWG9xNWOmDS4Sr+At9MuBwuvHvyvCBKPFVcKbKsUH0d/r/JndTCX/++13BIPc5bUy7KQPn8rCoq6yW1gsQTcYtOc6+Vogn+3sOB6a+/okUe3q7NCtYL8e2Wd42jhfS4re24Z7025bupgBtbFNlk0jO6EubcBVXoS6HEONco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940053; c=relaxed/simple;
	bh=8z0/TBMD8fWuIra7ndYVRz3me/9CIVnmVPKQkLavtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQdOyhbF82pufHcvYzXXGFzbvJOKfvoNdJ5Yv862rh0lPOU1W5J2iB3tmzAUKCbfv1KdtzBHY6lAaNHGFe+eC0L1OMoVqevITU+CoY5hW5kIjXhgASHyw2qsaVeojQdgBIfMtfr42ay2N2t7YtfZVKMFc3W0TDw9c6Ci4q5LALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXN9TUYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0E9C4CEEF;
	Thu, 31 Jul 2025 05:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753940052;
	bh=8z0/TBMD8fWuIra7ndYVRz3me/9CIVnmVPKQkLavtJM=;
	h=From:To:Cc:Subject:Date:From;
	b=rXN9TUYZiDZyvM25EnRczrjD2kVSUBwl2yIwtm4spxoyRjzRRO7fjIAWB8Ks/HBiu
	 MQUIgOabigE7VDZa0NQd9gFI7Lvm2UeS9Cvb95gzKY+bf32efIwjwt1a+UnO8oTQsm
	 51VfjE2zKdMZ0v2hVIxaOnxemIqMnaEYgm36Ptkjq1nOehnn2fy8TCuBg7/YHykUYG
	 H4OMf0HJy1qv7OIOR5qwgtyJyUukBon0pXjTGqcXvWZW4LnbhIiIqSK3WIx2u/32+7
	 BYHluDbbhXKcHVAS9aR04ENDBI6kzq1vV66mAoUToHbGEBGJhM2cp84jIjRuP3wy8g
	 L394YL/T4FRFw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH 1/2] f2fs: dump more information when checkpoint was blocked for long time
Date: Thu, 31 Jul 2025 13:34:04 +0800
Message-ID: <20250731053405.1127197-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/299 w/ mode=lfs will cause long time latency of checkpoint,
let's dump more information once we hit case.

CP merge:
  - Queued :    0
  - Issued :    1
  - Total :    1
  - Cur time : 9765(ms)
  - Peak time : 9765(ms)

F2FS-fs (vdc): blocked on checkpoint for 9765 ms
CPU: 11 UID: 0 PID: 237 Comm: kworker/u128:29 Tainted: G           O        6.16.0-rc3+ #409 PREEMPT(voluntary)
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: writeback wb_workfn (flush-253:32)
Call Trace:
 <TASK>
 dump_stack_lvl+0x6e/0xa0
 f2fs_issue_checkpoint+0x268/0x280
 f2fs_write_node_pages+0x6a/0x2c0
 do_writepages+0xd0/0x170
 __writeback_single_inode+0x56/0x4c0
 writeback_sb_inodes+0x22a/0x550
 __writeback_inodes_wb+0x4c/0xf0
 wb_writeback+0x300/0x400
 wb_workfn+0x3de/0x500
 process_one_work+0x230/0x5c0
 worker_thread+0x1da/0x3d0
 kthread+0x10d/0x250
 ret_from_fork+0x164/0x190
 ret_from_fork_asm+0x1a/0x30

Cc: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 7 +++++++
 fs/f2fs/f2fs.h       | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index db3831f7f2f5..02806e2edce4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1778,6 +1778,7 @@ static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
 	llist_for_each_entry_safe(req, next, dispatch_list, llnode) {
 		diff = (u64)ktime_ms_delta(ktime_get(), req->queue_time);
 		req->ret = ret;
+		req->delta_time = diff;
 		complete(&req->wait);
 
 		sum_diff += diff;
@@ -1873,6 +1874,12 @@ int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi)
 	else
 		flush_remained_ckpt_reqs(sbi, &req);
 
+	if (unlikely(req.delta_time >= CP_LONG_LATENCY_THRESHOLD)) {
+		f2fs_warn_ratelimited(sbi,
+			"blocked on checkpoint for %u ms", cprc->peak_time);
+		dump_stack();
+	}
+
 	return req.ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b9058518b54e..c036af1a885a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -334,7 +334,10 @@ struct ckpt_req {
 	struct completion wait;		/* completion for checkpoint done */
 	struct llist_node llnode;	/* llist_node to be linked in wait queue */
 	int ret;			/* return code of checkpoint */
-	ktime_t queue_time;		/* request queued time */
+	union {
+		ktime_t queue_time;	/* request queued time */
+		ktime_t delta_time;	/* time in queue */
+	};
 };
 
 struct ckpt_req_control {
@@ -350,6 +353,9 @@ struct ckpt_req_control {
 	unsigned int peak_time;		/* peak wait time in msec until now */
 };
 
+/* a time threshold that checkpoint was blocked for, unit: ms */
+#define CP_LONG_LATENCY_THRESHOLD	5000
+
 /* for the bitmap indicate blocks to be discarded */
 struct discard_entry {
 	struct list_head list;	/* list head */
-- 
2.49.0


