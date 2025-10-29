Return-Path: <linux-kernel+bounces-875164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F231C185AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 545F74E1086
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4FD285CBA;
	Wed, 29 Oct 2025 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PqYOGQ/9"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417A548EE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716974; cv=none; b=AW+2DV3JXeTbyGBo4FWMZYqmpYXhjCDitFu7QXJM/LmWs3mOMaBLFsblDrUmb24AVxqPgiYQScMiQyEHmEFt5z2OkK2v9xi/bp8P/pqvZ6ZK+ssWexTrbYWJAueLHqCMmD0qPE7ot02P20u3wjcnsmvHVQ8GcQ+a7TWJINNF7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716974; c=relaxed/simple;
	bh=i9nZDRnEwyvPp5vcQa+S60dKBZnKT1lD1zcRI5dEako=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z0csgV5tEK3kEoNTlNZhZZuREZOQSD6Stq026ipcXdXKt89wv8Y5OhqFG1jKE2dDMnMKXUj1HN4XwzReOj5azldFYMhiQjPJrrC+53aoZEui3lonhJy2t961y/IuGJ273dnyorUC7iZBTF0zszx9DV85mKA3Xz6YF2sesqbW2bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PqYOGQ/9; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ah
	BDHQILa49HMxw2JVQIr3vlbvr0IPNaE4CDQOjDzdM=; b=PqYOGQ/9a97Dbun4gb
	/xbyIQLX9q97D4B0gn3vjllOKgJMkOK06BQ1xvLP8/n4jm6VHh2j1s0uL66BKEXo
	fdw4ESGdwv4s81Lt8Nokrr3E/m7bqrD33o1gG6a1jrKnS4P3SB0ZH1Fsnma1Hzi5
	Zr2zlBJ7AfdIHBbjFqgoQFxlw=
Received: from gt-ubuntu22-04-cmd-v3-0-32gb-25m.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgC3n4CRowFppQEJAg--.44871S2;
	Wed, 29 Oct 2025 13:18:10 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	daehojeong@google.com,
	linux-kernel@vger.kernel.org,
	Xiaole He <hexiaole1994@126.com>,
	stable@kernel.org
Subject: [PATCH v1] f2fs: fix uninitialized one_time_gc in victim_sel_policy
Date: Wed, 29 Oct 2025 13:18:07 +0800
Message-Id: <20251029051807.3804-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCkvCgC3n4CRowFppQEJAg--.44871S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF17uFW8XrWUtr4xJr1kXwb_yoW5ZF1fpF
	W5K3ZxAr9rZryj9rW8t3WkGr1Fka9rCrn7JrZ3Cw429w4kGwnYqF1vka4xZF1xCFWkCw15
	JFyjgr4Yqws0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_OzVkUUUUU=
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbiexT1BmkBn51aMwAAsf

The one_time_gc field in struct victim_sel_policy is conditionally
initialized but unconditionally read, leading to undefined behavior
that triggers UBSAN warnings.

In f2fs_get_victim() at fs/f2fs/gc.c:774, the victim_sel_policy
structure is declared without initialization:

    struct victim_sel_policy p;

The field p.one_time_gc is only assigned when the 'one_time' parameter
is true (line 789):

    if (one_time) {
        p.one_time_gc = one_time;
        ...
    }

However, this field is unconditionally read in subsequent get_gc_cost()
at line 395:

    if (p->one_time_gc && (valid_thresh_ratio < 100) && ...)

When one_time is false, p.one_time_gc contains uninitialized stack
memory. Hence p.one_time_gc is an invalid bool value.

UBSAN detects this invalid bool value:

    UBSAN: invalid-load in fs/f2fs/gc.c:395:7
    load of value 77 is not a valid value for type '_Bool'
    CPU: 3 UID: 0 PID: 1297 Comm: f2fs_gc-252:16 Not tainted 6.18.0-rc3
    #5 PREEMPT(voluntary)
    Hardware name: OpenStack Foundation OpenStack Nova,
    BIOS 1.13.0-1ubuntu1.1 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x70/0x90
     dump_stack+0x14/0x20
     __ubsan_handle_load_invalid_value+0xb3/0xf0
     ? dl_server_update+0x2e/0x40
     ? update_curr+0x147/0x170
     f2fs_get_victim.cold+0x66/0x134 [f2fs]
     ? sched_balance_newidle+0x2ca/0x470
     ? finish_task_switch.isra.0+0x8d/0x2a0
     f2fs_gc+0x2ba/0x8e0 [f2fs]
     ? _raw_spin_unlock_irqrestore+0x12/0x40
     ? __timer_delete_sync+0x80/0xe0
     ? timer_delete_sync+0x14/0x20
     ? schedule_timeout+0x82/0x100
     gc_thread_func+0x38b/0x860 [f2fs]
     ? gc_thread_func+0x38b/0x860 [f2fs]
     ? __pfx_autoremove_wake_function+0x10/0x10
     kthread+0x10b/0x220
     ? __pfx_gc_thread_func+0x10/0x10 [f2fs]
     ? _raw_spin_unlock_irq+0x12/0x40
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x11a/0x160
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

This issue is reliably reproducible with the following steps on a
100GB SSD /dev/vdb:

    mkfs.f2fs -f /dev/vdb
    mount /dev/vdb /mnt/f2fs_test
    fio --name=gc --directory=/mnt/f2fs_test --rw=randwrite \
        --bs=4k --size=8G --numjobs=12 --fsync=4 --runtime=10 \
        --time_based
    echo 1 > /sys/fs/f2fs/vdb/gc_urgent

The uninitialized value causes incorrect GC victim selection, leading
to unpredictable garbage collection behavior.

Fix by zero-initializing the entire victim_sel_policy structure to
ensure all fields have defined values.

Fixes: e791d00bd06c ("f2fs: add valid block ratio not to do excessive GC for one time GC")
Cc: stable@kernel.org
Signed-off-by: Xiaole He <hexiaole1994@126.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a7708cf80c04..56e372c23a78 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -771,7 +771,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct sit_info *sm = SIT_I(sbi);
-	struct victim_sel_policy p;
+	struct victim_sel_policy p = {0};
 	unsigned int secno, last_victim;
 	unsigned int last_segment;
 	unsigned int nsearched;
-- 
2.34.1


