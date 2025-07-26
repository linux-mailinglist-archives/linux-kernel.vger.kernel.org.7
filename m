Return-Path: <linux-kernel+bounces-746578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7ABB12887
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480CB1CC738A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A341D5145;
	Sat, 26 Jul 2025 01:50:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299D13790B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753494606; cv=none; b=lzYQFlK1p+R8CTDBr40B/UbEI78DV9WPy8ZgfF6pJHtrvR9UPodRIgW5KrsCplV15sbPhuLPc+aM6khkp0XlvhLF+tNbJQb5+YXFbyYZP00UQxh000U1IJgOiic5gzXFsCxh8oJG3i960Tp242OlvqurOzG+cA7Mo5+CQOnLCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753494606; c=relaxed/simple;
	bh=3mYHZnC4KnZL1WSzCJVcL2zQrJVgnaRGcbPJEf4Pfbs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y10MXIMdAzbFFPWMgobK1w0jVZEBbe0+rrnzmYrw/rESFYtelCwlQNfVowGmyBNI83j6I10yk77HblidZTAtbAa/fPnUpv/AiXpWF+IqtB7/CIBo26pL2tgRjTVZRXiWqgIbYR6AaIQZfq3dzvTDvnAqP0NqWyHGnxME1vODDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c1d1356f3so293705739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753494603; x=1754099403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg/Id+vv9itUKIrE+rObWVbvYaBpGP9EL11b1CWtznY=;
        b=a5Gjcwi380jpBVlkccQq7a0wSccdTaiJdf4/yFBXcj55ZV8ULNHGbVT0UWJgO5K10y
         WMsB6G+7VoWWxqwVLCEWBfT//neQIN4YvOLjLlefRWBAAEZkdIhveDVWqOhh3JEVgm0M
         I8F1QMdIx3dgQQNEgv1T7YyTDn1sCXwsmENUs6HHKZegdqXb863bGsAIvFn2DusOPszV
         pTFvc5NwyMhOeCxB0oDGthCBEMJhAJSCUCdRFft86Ru5yKpzhsuS46pDsDyaf5TIpf2G
         wZ4DeDy7JneWhJjtMR9VUrB7yi28krRS+Y31so/8kF1eFvPXCId6umcJRnwXb/C4aav6
         lwpw==
X-Forwarded-Encrypted: i=1; AJvYcCVzKT6Eh8xdsuxu97nwcCig31yXN/trr9QIJFGuor/lmoB2sLn6JF7MjmX6ycu7ybKZAjBa5QetUEsFfcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjojx/kxkT/bkh1V5t8zlDYY0p6nnQKMzAkRl4W/pDz9NL5XT8
	74DaG6xaECw6H+mBCGZTG7+6jdoSSQEiZMAw63PuK1xEDPpeLYX93YGpWq8zfXHjL4S/W4K1Oyo
	dvtbUloyzIm8PwpBzqnRs3mSYDd77XBtjCgENmxMRlRZtCz9Lw1WqHOliHEM=
X-Google-Smtp-Source: AGHT+IEkSxp490wKAlx8onaCegAFzfLWBA3J/LXj+mLYRybMcsOhbKl1EfSK1yS3xMhbhKz6AAoh4ygA7iPRwx93vN3/fbfuwG/y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1654:b0:873:de29:612f with SMTP id
 ca18e2360f4ac-8800f0e59d8mr727829439f.3.1753494601954; Fri, 25 Jul 2025
 18:50:01 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:50:01 -0700
In-Reply-To: <tencent_C725DBBA89BB4B333C9E4B1BFA4B341B0708@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68843449.a00a0220.b12ec.0000.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in ucma_create_uevent

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_inc_not_zero include/linux/atomic/atomic-instrumented.h:1536 [inline]
BUG: KASAN: slab-use-after-free in ucma_get_mc drivers/infiniband/core/ucma.c:263 [inline]
BUG: KASAN: slab-use-after-free in ucma_create_uevent+0x8d1/0xd70 drivers/infiniband/core/ucma.c:287
Write of size 4 at addr ffff88802a9566b0 by task kworker/u32:5/1140

CPU: 2 UID: 0 PID: 1140 Comm: kworker/u32:5 Not tainted 6.16.0-rc7-syzkaller-g5f33ebd2018c-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rdma_cm cma_iboe_join_work_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_inc_not_zero include/linux/atomic/atomic-instrumented.h:1536 [inline]
 ucma_get_mc drivers/infiniband/core/ucma.c:263 [inline]
 ucma_create_uevent+0x8d1/0xd70 drivers/infiniband/core/ucma.c:287
 ucma_event_handler+0x102/0x940 drivers/infiniband/core/ucma.c:366
 cma_cm_event_handler+0x97/0x300 drivers/infiniband/core/cma.c:2173
 cma_iboe_join_work_handler+0xca/0x170 drivers/infiniband/core/cma.c:3008
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6548:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 ucma_process_join+0x233/0xb90 drivers/infiniband/core/ucma.c:1480
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1575
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1756
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6548:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 ucma_put_mc drivers/infiniband/core/ucma.c:269 [inline]
 ucma_put_mc drivers/infiniband/core/ucma.c:266 [inline]
 ucma_process_join+0x763/0xb90 drivers/infiniband/core/ucma.c:1534
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1575
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1756
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802a956600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 176 bytes inside of
 freed 192-byte region [ffff88802a956600, ffff88802a9566c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a956
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b8423c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 6445, tgid 6445 (syz-executor), ts 92358145050, free_ts 92277395639
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_slab_page mm/slub.c:2453 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x94/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_noprof+0x2ed/0x500 mm/slub.c:4334
 kmalloc_array_node_noprof include/linux/slab.h:1020 [inline]
 alloc_slab_obj_exts+0x41/0xa0 mm/slub.c:1992
 account_slab mm/slub.c:2578 [inline]
 allocate_slab mm/slub.c:2638 [inline]
 new_slab+0x283/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 kmem_cache_alloc_lru_noprof+0xf4/0x3b0 mm/slub.c:4216
 sock_alloc_inode+0x25/0x1c0 net/socket.c:309
 alloc_inode+0x61/0x240 fs/inode.c:346
 new_inode_pseudo include/linux/fs.h:3364 [inline]
 sock_alloc+0x40/0x280 net/socket.c:622
 __sock_create+0xc1/0x8d0 net/socket.c:1505
page last free pid 23 tgid 23 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 pagetable_free include/linux/mm.h:2884 [inline]
 pagetable_dtor_free include/linux/mm.h:2982 [inline]
 __tlb_remove_table include/asm-generic/tlb.h:220 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x116/0x1a0 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0x79c/0x14e0 kernel/rcu/tree.c:2832
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 run_ksoftirqd kernel/softirq.c:968 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:960
 smpboot_thread_fn+0x3f4/0xae0 kernel/smpboot.c:164
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88802a956580: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a956600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a956680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff88802a956700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a956780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         5f33ebd2 Merge tag 'drm-fixes-2025-07-26' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ea88a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c445d2891161cc81
dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12100782580000


