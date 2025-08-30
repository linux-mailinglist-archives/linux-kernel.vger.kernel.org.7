Return-Path: <linux-kernel+bounces-793103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2926B3CE87
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12787A5C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F32D8777;
	Sat, 30 Aug 2025 18:03:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EB2741CD
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756577015; cv=none; b=dsaGvP+wEOvLPw5HzNchJeVZr5wX+njBli+cu9RQnLt9ytHADx170y5fjv+BTjwRJ4I0VPwDOVr4ywDsBqaYjz2WtzwQQEhZCs5C6jAxYuS6RwgDjxkP2DO1gw7eUbmUvZWuhW14XtMpCdjNd1G5VZvrGP2CjNphVqN5l82apLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756577015; c=relaxed/simple;
	bh=hdj9CuNvUL2qLsfWQqzcQGBGGcXsEsqeJOYPfSil7BQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TzC/5cpB6rM1qM9CbylS38HkcIl0B22BTS3OpqKT4hCfbLmxQ3tiP7hCdmiX2T8N8bfLDCQZotC2HapeAJzZpV6LAf+xYVY0Jq+xDiKtLMRerTCCMKfWNYoMseRPsfhyIjw+G/bGonHZs2s+jiER9HtLDnEqzXvFWM0BVzeDRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ea2bd7b667so83883475ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756577013; x=1757181813;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0EmFDrtnTB27c9P1CgT1xWyHibY7Jm3IDK1ySTEc4U=;
        b=CvfJRzsscMsRtyENH1IQitsv+3VNCYhJuym9HQ2x32SfPlgdPQghlAtDXVp+6I+pwh
         A6Op6CRaoKOd4ttk9QMdHoeOn1zyueSYzsCvbwxCF165PVdMVwwg/IiCDWuZ5Zp7W37e
         sTL2B4+cxxzLrh4lVqNRfS+yH0aIXITRHIIxeDKIOobosuUc4fbgbKim85kls1u2r8FK
         JmJsFrsubFKPcJpq5xfcytALW6Gh4O6+1zRxRLB7JYMIPnbHI6MmZs0vRGGWTgnA1zlU
         3tfoBlvo58VU+vetpVcWvEjMVYS158Sxly+XURUI0uVoN6V5uh5LvEuY3IhEkT3LgF5N
         3xcg==
X-Forwarded-Encrypted: i=1; AJvYcCUmYn+uR6oI6EyxaCswWV+C4TGvGwFTkTu0JYCnQgT7O3m4yhgnvqiGw8kmWb+O9me9HiiCs2wXuCQFB8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HzPueReuWtaDh133rAFUYovwotjp4wJ6iCcPfDHnBewLeGDA
	sZcQ2CJHz2BxNy/1WylMrV7ByISEYw8Zz4Gmo7NR86AaIsPw73egreGNDh/3o8dvhMNS5dU+IsK
	5kuYhYy7rJKUKCUkG/SQuByokhzM7SnVW8N+SVtJ3J3hT85s7qRmMCATOMvc=
X-Google-Smtp-Source: AGHT+IG32OKZdP/wR5LsTpXnN7zPnfxInIheNy/NLRAyHRxnx4lf1Ppw0rVZprhjee1dorUQDzs2sKZopzbmRoTgayJB7NX6CAfu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:3f3:42ba:5a9 with SMTP id
 e9e14a558f8ab-3f4027b88cemr54329045ab.31.1756577012922; Sat, 30 Aug 2025
 11:03:32 -0700 (PDT)
Date: Sat, 30 Aug 2025 11:03:32 -0700
In-Reply-To: <68a28720.050a0220.e29e5.0080.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b33cf4.a00a0220.1337b0.0025.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in xfs_trans_alloc
From: syzbot <syzbot+ab02e4744b96de7d3499@syzkaller.appspotmail.com>
To: cem@kernel.org, hch@infradead.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15474242580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=ab02e4744b96de7d3499
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10891a62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a32a62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f4f2ae1e66f9/mount_3.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12458e34580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab02e4744b96de7d3499@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24 at fs/xfs/xfs_trans.c:256 xfs_trans_alloc+0x3e4/0x898 fs/xfs/xfs_trans.c:256
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Workqueue: xfs-inodegc/loop0 xfs_inodegc_worker
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : xfs_trans_alloc+0x3e4/0x898 fs/xfs/xfs_trans.c:256
lr : xfs_trans_alloc+0x3e4/0x898 fs/xfs/xfs_trans.c:256
sp : ffff800097ce77e0
x29: ffff800097ce7860 x28: ffff0000c2490130 x27: 0000000000000000
x26: ffff0000c2490000 x25: dfff800000000000 x24: 1ffff00012f9cf18
x23: dfff800000000000 x22: ffff0000c249043c x21: ffff0000c2490440
x20: ffff0000c2490438 x19: 0000000000000004 x18: 1fffe000337a0688
x17: ffff800093507000 x16: ffff80008b007230 x15: 0000000000000001
x14: 1fffe0001e61bbb5 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e61bbb6 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c1ae8000 x7 : ffff800081e80e40 x6 : 0000000000000000
x5 : ffff800097ce78e0 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000004 x0 : 0000000000000004
Call trace:
 xfs_trans_alloc+0x3e4/0x898 fs/xfs/xfs_trans.c:256 (P)
 xfs_attr_inactive+0xec/0x2b0 fs/xfs/xfs_attr_inactive.c:343
 xfs_inactive+0x7ac/0xb74 fs/xfs/xfs_inode.c:1464
 xfs_inodegc_inactivate fs/xfs/xfs_icache.c:1944 [inline]
 xfs_inodegc_worker+0x320/0x83c fs/xfs/xfs_icache.c:1990
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
irq event stamp: 1049032
hardirqs last  enabled at (1049031): [<ffff80008b028e88>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (1049031): [<ffff80008b028e88>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:202
hardirqs last disabled at (1049032): [<ffff80008b001bfc>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (1048974): [<ffff8000803d88a0>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (1048974): [<ffff8000803d88a0>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (1048959): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

