Return-Path: <linux-kernel+bounces-778908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D0B2EC94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE417BFDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A324EA90;
	Thu, 21 Aug 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="JQ8+1MeG"
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19B22A4CC;
	Thu, 21 Aug 2025 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749156; cv=none; b=lGo1oHZgCn6BidYz6FHYIyWA8F9MWxrfnkedMOVIJN+dySQxeGSgyBSTl7mOACaMoMQqZkzydBFV//KbfLBDEXmD6CtlQDkD+08T++TjyNAvbFc8EGvIM7xwotyZiVhu+KxCX8Yq2+fDSU84Cw2vXaJlczRZxpEMVUJmqtXXtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749156; c=relaxed/simple;
	bh=vU/7DfLIzVQlb2KsyyZUZ8QbhmpI+WLM+loYFKQYEmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bkk3F1BEe1agYEOAYzugFiUmFKecp6ct8JKtnoqpwBillv+XvgTws3oYW/Fx9VIcFNBcZE8Xe1mIhhJTWoKid5P3WqtEiR05AZzq5Y55T34CkXtf+M7/L7BqseZY8yPDbQNm08CbDQC8+l6diqmu/C48yxgNwrnvqovasBRs4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=JQ8+1MeG; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from localhost.lan (unknown [1.193.56.173])
	by smtp.qiye.163.com (Hmail) with ESMTP id 201320bad;
	Thu, 21 Aug 2025 09:43:20 +0800 (GMT+08:00)
From: Dewei Meng <mengdewei@cqsoftware.com.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ivan.orlov0322@gmail.com,
	Dewei Meng <mengdewei@cqsoftware.com.cn>
Subject: [PATCH] ALSA: timer: fix ida_free call while not allocated
Date: Thu, 21 Aug 2025 09:43:17 +0800
Message-ID: <20250821014317.40786-1-mengdewei@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98ca4b78a003abkunm6b477d99c436a3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0kYVkxPGUMeQ04ZQxpKS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOTVVKTEhZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JQ8+1MeGkZdij7eihC7l8Q4zvMaties06cko9zs2sDnqczuBv7e+cffoAN7XEd0cjte7BFs1/k+59SUfctz5WVSH07Jr8sASmjduC8nVzKPkv+QIUZzPqS4w3modEF5OE2wKHvhxdy+Ifkyo4UzXLlTcx7pEpIKjI8boYBFuH7w=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=it3PEl0g7u8iEnUcpVXvvyK9eW0H/7fi+YnwNQNqrjI=;
	h=date:mime-version:subject:message-id:from;

In the snd_utimer_create() function, if the kasprintf() function return
NULL, snd_utimer_put_id() will be called, finally use ida_free()
to free the unallocated id 0.

the syzkaller reported the following information:
  ------------[ cut here ]------------
  ida_free called for id=0 which is not allocated.
  WARNING: CPU: 1 PID: 1286 at lib/idr.c:592 ida_free+0x1fd/0x2f0 lib/idr.c:592
  Modules linked in:
  CPU: 1 UID: 0 PID: 1286 Comm: syz-executor164 Not tainted 6.15.8 #3 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
  RIP: 0010:ida_free+0x1fd/0x2f0 lib/idr.c:592
  Code: f8 fc 41 83 fc 3e 76 69 e8 70 b2 f8 (...)
  RSP: 0018:ffffc900007f79c8 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: 1ffff920000fef3b RCX: ffffffff872176a5
  RDX: ffff88800369d200 RSI: 0000000000000000 RDI: ffff88800369d200
  RBP: 0000000000000000 R08: ffffffff87ba60a5 R09: 0000000000000000
  R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f6f1abc1740(0000) GS:ffff8880d76a0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f6f1ad7a784 CR3: 000000007a6e2000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   snd_utimer_put_id sound/core/timer.c:2043 [inline] [snd_timer]
   snd_utimer_create+0x59b/0x6a0 sound/core/timer.c:2184 [snd_timer]
   snd_utimer_ioctl_create sound/core/timer.c:2202 [inline] [snd_timer]
   __snd_timer_user_ioctl.isra.0+0x724/0x1340 sound/core/timer.c:2287 [snd_timer]
   snd_timer_user_ioctl+0x75/0xc0 sound/core/timer.c:2298 [snd_timer]
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:907 [inline]
   __se_sys_ioctl fs/ioctl.c:893 [inline]
   __x64_sys_ioctl+0x198/0x200 fs/ioctl.c:893
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x7b/0x160 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]

The utimer->id should be set properly before the kasprintf() function,
ensures the snd_utimer_put_id() function will free the allocated id.

Fixes: 37745918e0e75 ("ALSA: timer: Introduce virtual userspace-driven timers")
Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
---
 sound/core/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 3ce12264eed8..d9fff5c87613 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2139,14 +2139,14 @@ static int snd_utimer_create(struct snd_timer_uinfo *utimer_info,
 		goto err_take_id;
 	}
 
+	utimer->id = utimer_id;
+
 	utimer->name = kasprintf(GFP_KERNEL, "snd-utimer%d", utimer_id);
 	if (!utimer->name) {
 		err = -ENOMEM;
 		goto err_get_name;
 	}
 
-	utimer->id = utimer_id;
-
 	tid.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
 	tid.dev_class = SNDRV_TIMER_CLASS_GLOBAL;
 	tid.card = -1;
-- 
2.43.5


