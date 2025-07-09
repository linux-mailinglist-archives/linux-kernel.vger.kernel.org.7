Return-Path: <linux-kernel+bounces-722696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92971AFDDDA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236057AC30C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3F1E0DD9;
	Wed,  9 Jul 2025 03:08:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492DFEEC0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030485; cv=none; b=qqRKXXfjfiEWw1kSITx8mpOtaIFCeFCL3obg6MaFChX+ye8g04LhEgOS8VcsTHF6QvCANVdXTjGEX0JiJHz+L5mV3WmNgJxNImUTyvgU43waqoSaqK7pzwxIbS9V2QzTi6Od6/pvDADIX2mWnplWZxRduLaH1mYUKRjtsxcUM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030485; c=relaxed/simple;
	bh=jGJBh6Z89/LW/SgNuJcFhbQqVqipNt1fZ/+hX2i2VK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UryWg2rTm2VaKIX0kxk6DYL0O9TalWeBqgk43EQSC84LXRjflVvsoGGe6RU4dR98/nQH14qc5POi8dk0CLoC0WkNAhP+fIcTc7/Jhj1SBzm+3L6dvpkLSBWql4hnxCYUQxXEw8JfxSvrClmXISwmKGgi0YeGh3gBiE1GciKhMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so564570039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 20:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752030482; x=1752635282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJYTY4m4cbbG4ivSqJ7zPvpAlkuQSuatcqD1JFBJQn8=;
        b=QBtLkqeVpmy68/k7aJYdUW2y3s2pv1ltSVKsFBzDUyjTTxDs2w1taLr2o1urFHNN6n
         ndS/vrQM3bVHP4hZkNDhebHm7y9Chvt4RhqenrKgelISP+8M9uRhBVbJXASuKJ05dSNu
         UEzSawgjwdAMPCQ4FSObOMdDcPZj+bngZSJJTUOcJ9WR+XL50taw8p8b3S81u8jRDiwM
         mNRRgx3j08g3LBRY2+74ZEvE2WyIfvzt8D2nseowj9QDlY2XIan+5pmJRFcBdEkk621T
         zJr+lOWwGQYcqgCxAT9cXyE4FKt9DgZGlJmaLSOsYutDfOjJnOQNh3+538Nw4naLSSbW
         tQrA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHGEFOtkkRnQRRpN45h0jDxewU7Q+F6dJcL+RV3bxV9fDa0L1/6nB/p4y89B/AUz4VJYXuqSC8g/7bQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tekI1Y7W6aBHxy+y8pjcl5R/O5YCYWxzs7i5l8xyb1fDXmGG
	tq+jCJlgKdHu393Gm4VN1cewwYJKyS4XEY6f7ZQHjOOE8g3jUoGBu4V0w+JJOKFFxyV7FPX3UdG
	7WlQ0sVB2Y8ECxLEVd+jvrRIA2LppQOhqLfDiJRYMotw8fJtHE7mHmxINhCc=
X-Google-Smtp-Source: AGHT+IFcDq11qaN1bSwsyiYVd76+FszNGqqg95/rMHoXMQ5bWIJU1j6czvKkSqRwB1+b/XYNRp1OF1brjnQZYt4AwnfERdO7zpiu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3dd:dd39:324c with SMTP id
 e9e14a558f8ab-3e167016a7emr10343635ab.9.1752030482344; Tue, 08 Jul 2025
 20:08:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 20:08:02 -0700
In-Reply-To: <tencent_1483A44448B76A9774E6C953790367296005@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ddd12.050a0220.1ffab7.002e.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ucma_create_uevent

==================================================================
BUG: KASAN: slab-use-after-free in ucma_create_uevent+0xadb/0xb30 drivers/infiniband/core/ucma.c:275
Read of size 8 at addr ffff888022289610 by task kworker/u32:2/46

CPU: 1 UID: 0 PID: 46 Comm: kworker/u32:2 Not tainted 6.16.0-rc5-syzkaller-g733923397fd9-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rdma_cm cma_iboe_join_work_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 ucma_create_uevent+0xadb/0xb30 drivers/infiniband/core/ucma.c:275
 ucma_event_handler+0x102/0x940 drivers/infiniband/core/ucma.c:351
 cma_cm_event_handler+0x97/0x300 drivers/infiniband/core/cma.c:2173
 cma_iboe_join_work_handler+0xca/0x170 drivers/infiniband/core/cma.c:3008
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6542:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 ucma_process_join+0x237/0xa30 drivers/infiniband/core/ucma.c:1465
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1557
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1738
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6542:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 ucma_process_join+0x3b9/0xa30 drivers/infiniband/core/ucma.c:1516
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1557
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1738
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888022289600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 freed 192-byte region [ffff888022289600, ffff8880222896c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22289
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b8423c0 ffffea0000aeb500 dead000000000003
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3951737580, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __tty_alloc_driver drivers/tty/tty_io.c:3336 [inline]
 __tty_alloc_driver+0xbb/0x4a0 drivers/tty/tty_io.c:3326
 vty_init+0xdd/0x420 drivers/tty/vt/vt.c:3822
 tty_init+0x179/0x1c0 drivers/tty/tty_io.c:3649
 chr_dev_init+0xfb/0x170 drivers/char/mem.c:759
 do_one_initcall+0x120/0x6e0 init/main.c:1274
 do_initcall_level init/main.c:1336 [inline]
 do_initcalls init/main.c:1352 [inline]
 do_basic_setup init/main.c:1371 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1584
 kernel_init+0x1c/0x2b0 init/main.c:1474
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888022289500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888022289580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888022289600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888022289680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888022289700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         73392339 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17363582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fa6c6703a4b2315
dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bfca8c580000


