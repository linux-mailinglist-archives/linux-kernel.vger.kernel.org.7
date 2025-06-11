Return-Path: <linux-kernel+bounces-681113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135EAD4EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C251886F86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0222417C3;
	Wed, 11 Jun 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDfK1dP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424823FC5F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631346; cv=none; b=O6qF+ZE0vFiYmqklrpZnk74QbqZkHrc+wU3u7skWClqpGP2FJ671eyRVqApflSzwwr77u+C0NX0WfY5CmoSZO0LcZYp9erhyuW8hXof2N+DPRnBlNmlZrUn2OiovNN2NoKnuBRgKo5wqd1cC2/TA4IxKpbMPc9WevkfX+eFpaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631346; c=relaxed/simple;
	bh=yTO9uxOi42yW7SZL06qosFQkiiQUmDffdoWv9dfSvko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5a5slMNnvW7DQRaeIR3Xb7ZjSt2pdzZkXG/7YMrCU3hbyBbEl8jQFQs3dbI8pWrR3TpMGfJsiypk8bhI7e6hV1l/XkNW7r8oNYOm6A4ab0GXDPhDlV8GIJ4ApDwby6abJGnIGHb61QJsXmT9IKewoBFX8iuifp3pDIZg7hd570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDfK1dP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36050C4CEEE;
	Wed, 11 Jun 2025 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749631345;
	bh=yTO9uxOi42yW7SZL06qosFQkiiQUmDffdoWv9dfSvko=;
	h=From:To:Cc:Subject:Date:From;
	b=dDfK1dP5J3dnQtjICKgaDbI2fwEBPgcsuwg+psGrlkWMY5bNbmrVO0NdnskXHBziD
	 8TPwX/On+T2jC8dD21Ib3i22I6zXgwXpgnJgjytkVQvKLo1X7bq94Kex9iWKz0uP96
	 ofDl4sz/snFyOsAEl1jVAermVvakna7gI3JwO0ngNeJlUEm3wckXkZYccrxJ03S0n9
	 OMetaua773/MAAhStAiPwFyTisAOXPyl9hky8ETPMYtb+d8joMcRi2CyQj68fYI3xn
	 X4/SwUP3wc2ZDKN+yI+LDBNL11Qo886Ijw0zVi/NwTflSCDcDbWnQTsz5O0+N8aw1O
	 LF7ntkSudxqnw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid invalid wait context issue
Date: Wed, 11 Jun 2025 16:42:18 +0800
Message-ID: <20250611084218.62774-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

=============================
[ BUG: Invalid wait context ]
6.13.0-rc1 #84 Tainted: G           O
-----------------------------
cat/56160 is trying to lock:
ffff888105c86648 (&cprc->stat_lock){+.+.}-{3:3}, at: update_general_status+0x32a/0x8c0 [f2fs]
other info that might help us debug this:
context-{5:5}
2 locks held by cat/56160:
 #0: ffff88810a002a98 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0x56/0x4c0
 #1: ffffffffa0462638 (f2fs_stat_lock){....}-{2:2}, at: stat_show+0x29/0x1020 [f2fs]
stack backtrace:
CPU: 0 UID: 0 PID: 56160 Comm: cat Tainted: G           O       6.13.0-rc1 #84
Tainted: [O]=OOT_MODULE
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 <TASK>
 dump_stack_lvl+0x88/0xd0
 dump_stack+0x14/0x20
 __lock_acquire+0x8d4/0xbb0
 lock_acquire+0xd6/0x300
 _raw_spin_lock+0x38/0x50
 update_general_status+0x32a/0x8c0 [f2fs]
 stat_show+0x50/0x1020 [f2fs]
 seq_read_iter+0x116/0x4c0
 seq_read+0xfa/0x130
 full_proxy_read+0x66/0x90
 vfs_read+0xc4/0x350
 ksys_read+0x74/0xf0
 __x64_sys_read+0x1d/0x20
 x64_sys_call+0x17d9/0x1b80
 do_syscall_64+0x68/0x130
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f2ca53147e2

- seq_read
 - stat_show
  - raw_spin_lock_irqsave(&f2fs_stat_lock, flags)
  : f2fs_stat_lock is raw_spinlock_t type variable
  - update_general_status
   - spin_lock(&sbi->cprc_info.stat_lock);
   : stat_lock is spinlock_t type variable

The root cause is the lock order is incorrect [1], we should not acquire
spinlock_t lock after raw_spinlock_t lock, as if CONFIG_PREEMPT_LOCK is
on, spinlock_t is implemented based on rtmutex, which can sleep after
holding the lock.

To fix this issue, let's use change f2fs_stat_lock lock type from
raw_spinlock_t to spinlock_t, it's safe due to:
- we don't need to use raw version of spinlock as the path is not
performance sensitive.
- we don't need to use irqsave version of spinlock as it won't be
used in irq context.

Quoted from [1]:

"Extend lockdep to validate lock wait-type context.

The current wait-types are:

	LD_WAIT_FREE,		/* wait free, rcu etc.. */
	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */

Where lockdep validates that the current lock (the one being acquired)
fits in the current wait-context (as generated by the held stack).

This ensures that there is no attempt to acquire mutexes while holding
spinlocks, to acquire spinlocks while holding raw_spinlocks and so on. In
other words, its a more fancy might_sleep()."

[1] https://lore.kernel.org/all/20200321113242.427089655@linutronix.de

Fixes: 98237fcda4a2 ("f2fs: use spin_lock to avoid hang")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/debug.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 16c2dfb4f595..3417e7e550b2 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -21,7 +21,7 @@
 #include "gc.h"
 
 static LIST_HEAD(f2fs_stat_list);
-static DEFINE_RAW_SPINLOCK(f2fs_stat_lock);
+static DEFINE_SPINLOCK(f2fs_stat_lock);
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *f2fs_debugfs_root;
 #endif
@@ -439,9 +439,8 @@ static int stat_show(struct seq_file *s, void *v)
 {
 	struct f2fs_stat_info *si;
 	int i = 0, j = 0;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&f2fs_stat_lock, flags);
+	spin_lock(&f2fs_stat_lock);
 	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
 		struct f2fs_sb_info *sbi = si->sbi;
 
@@ -753,7 +752,7 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - paged : %llu KB\n",
 				si->page_mem >> 10);
 	}
-	raw_spin_unlock_irqrestore(&f2fs_stat_lock, flags);
+	spin_unlock(&f2fs_stat_lock);
 	return 0;
 }
 
@@ -765,7 +764,6 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_stat_info *si;
 	struct f2fs_dev_stats *dev_stats;
-	unsigned long flags;
 	int i;
 
 	si = f2fs_kzalloc(sbi, sizeof(struct f2fs_stat_info), GFP_KERNEL);
@@ -817,9 +815,9 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 
 	atomic_set(&sbi->max_aw_cnt, 0);
 
-	raw_spin_lock_irqsave(&f2fs_stat_lock, flags);
+	spin_lock(&f2fs_stat_lock);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
-	raw_spin_unlock_irqrestore(&f2fs_stat_lock, flags);
+	spin_unlock(&f2fs_stat_lock);
 
 	return 0;
 }
@@ -827,11 +825,10 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&f2fs_stat_lock, flags);
+	spin_lock(&f2fs_stat_lock);
 	list_del(&si->stat_list);
-	raw_spin_unlock_irqrestore(&f2fs_stat_lock, flags);
+	spin_unlock(&f2fs_stat_lock);
 
 	kfree(si->dev_stats);
 	kfree(si);
-- 
2.49.0


