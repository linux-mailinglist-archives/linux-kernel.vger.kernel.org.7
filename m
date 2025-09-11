Return-Path: <linux-kernel+bounces-812867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EDFB53DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEC61C80388
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAA21D5BC;
	Thu, 11 Sep 2025 21:38:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6252D3228
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626706; cv=none; b=ml0py7gPskwb5xWpYXKlGEK0iP25FfP/YRYuwIb+pXFfRxgBS27otcWe0zQ14Rff3dpC6oLl+7wfrzPEYbm62T4Fetatta/LhrGUicU45FEE2itmsB7yy3+98ENkebCPLOepraZ0c5wEQahe9S0E58jfCuq1SFCiTHI0mle3l6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626706; c=relaxed/simple;
	bh=IZbaO6g6SAscLT4vUqffFhHnBdMEV4zjAbkOHPMt+uE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S5WJx6X9IdyRJYn98pVAzgIjtFcVhgNNTJ1QFxrnsMHaFMVbL1KxpcXBeR0+3zSq6IEZuP2wY9mPGUGSdwNxxbaeWndsjGZCPAYBvnFnFrQZMva/TgejjVYdZ6RKDCN5cNzbYi+PYNjPYiWPxuhLhOabqis2AH3bRmH6qbFRziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-402abd9bfadso16181885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626704; x=1758231504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUMF+4VQq9rzXdYWjwLdgCiiF7EYCYCawpQEVgSeP2g=;
        b=FnzB2Nnt2naWsknyxry4v8REfZ8T6HdfMMznmBuPunnruBVM+8WCSL+l0fzefoPbzq
         5zSephC64+1wxtTGCW5xQdE0RIvTyXmFPPMGoft2zf0Sy1gc9re9FT0BoECtpxG1kZfL
         Y+HPklLdFGTkbLRu8S7IjqZ/XfckOmvLVOUxgTud7Lp2jFRVoIiB/fB9RSJ3bDU5ihzo
         UD+GY98wCcDw9Otacr843zKfjYBKTZ5EeRLPJMpbRZDoOg0Q9B6GZN9evG8F1DZ5JH4L
         3FSOepXwlsSC59dz1Z4np27RwWGizwrmKJyZxQwqxuPnK3UWoO1dM7sONcoDxugRSQyh
         HUcg==
X-Forwarded-Encrypted: i=1; AJvYcCX0rch41ARTLMhhGsj4WGICRxTlBToGwU5JNQmEds4aX/BS/ciRbR0PCNizfB/KkFM/vROHdCTuZzp1iUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkh5+kUOncDvNVBMMHtevHZ4JF74p4I9u78SY+4ixyE69EIZkc
	oBYJ+pEEZdsxLrM7Iyq/ibMs1PaaBHMmAM+xO8hnYSCJ+tgf1X2o+W89Lxl4HKIfRWmg0NVwnRV
	Qgnb48AU4ni5LKzrWgrsz2lxyVv4QXettIjWAGehHE+p2EqHl7VeySCR9iPI=
X-Google-Smtp-Source: AGHT+IG8Sx0rNbrDTIEYkb3uBm+qNubemryNApZ2m8Lif56ufjYH44PRgREVlBtdedBFy226ib9AcAl0mvnEKFZ5cYbcg+J5kshg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3783:b0:41f:6b74:e245 with SMTP id
 e9e14a558f8ab-420a4268885mr16635975ab.23.1757626704173; Thu, 11 Sep 2025
 14:38:24 -0700 (PDT)
Date: Thu, 11 Sep 2025 14:38:24 -0700
In-Reply-To: <6860c5d3.a00a0220.c1739.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c34150.050a0220.3c6139.0045.GAE@google.com>
Subject: Re: [syzbot] [crypto?] possible deadlock in padata_do_serial
From: syzbot <syzbot+bd936ccd4339cea66e6b@syzkaller.appspotmail.com>
To: daniel.m.jordan@oracle.com, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    02ffd6f89c50 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124f6934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1f4909b95fa1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=bd936ccd4339cea66e6b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e46b12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1598a47c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-02ffd6f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/56f3c676fa83/vmlinux-02ffd6f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b17e95e57bfa/bzImage-02ffd6f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd936ccd4339cea66e6b@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/u32:5/96 is trying to acquire lock:
ffffe8fefc53dbc8 (&pd_list->lock){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffe8fefc53dbc8 (&pd_list->lock){+...}-{3:3}, at: padata_find_next kernel/padata.c:256 [inline]
ffffe8fefc53dbc8 (&pd_list->lock){+...}-{3:3}, at: padata_reorder kernel/padata.c:309 [inline]
ffffe8fefc53dbc8 (&pd_list->lock){+...}-{3:3}, at: padata_do_serial+0x7bd/0xd20 kernel/padata.c:379

but task is already holding lock:
ffffe8fefc53dc18 (&pd_list->lock){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffe8fefc53dc18 (&pd_list->lock){+...}-{3:3}, at: padata_reorder kernel/padata.c:300 [inline]
ffffe8fefc53dc18 (&pd_list->lock){+...}-{3:3}, at: padata_do_serial+0x697/0xd20 kernel/padata.c:379

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&pd_list->lock);
  lock(&pd_list->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u32:5/96:
 #0: ffff888022495148 ((wq_completion)pdecrypt_parallel){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc9000167fd10 ((work_completion)(&pw->pw_work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
 #2: ffffe8fefc53dc18 (&pd_list->lock){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffe8fefc53dc18 (&pd_list->lock){+...}-{3:3}, at: padata_reorder kernel/padata.c:300 [inline]
 #2: ffffe8fefc53dc18 (&pd_list->lock){+...}-{3:3}, at: padata_do_serial+0x697/0xd20 kernel/padata.c:379

stack backtrace:
CPU: 2 UID: 0 PID: 96 Comm: kworker/u32:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: pdecrypt_parallel padata_parallel_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x1133/0x1ce0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 padata_find_next kernel/padata.c:256 [inline]
 padata_reorder kernel/padata.c:309 [inline]
 padata_do_serial+0x7bd/0xd20 kernel/padata.c:379
 pcrypt_aead_dec+0x5b/0x70 crypto/pcrypt.c:140
 padata_parallel_worker+0x62/0xb0 kernel/padata.c:157
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

