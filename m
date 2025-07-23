Return-Path: <linux-kernel+bounces-743202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902CFB0FBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C6A567F59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804182356BA;
	Wed, 23 Jul 2025 20:49:39 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768120D4E9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303778; cv=none; b=tPkzrgUh8Ok8UlLco0qWO2xGpK6BVI93sDzfKJ/5ZM6FRUgXl3AbzsTScd6UqIQb0yfvsBgneD1LungEOpuGPEnyRRXPYTfsAGqzFeHea46O8pKL42FM5QLoDm94KbJESAFMRW2HkzqYE4vmACBj67dD5d5+QA16KHbnuVoEvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303778; c=relaxed/simple;
	bh=2VtCpma8kQ4XCug/g8Yl0FNjZgZlKKjGl1fGocw3uhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2r+NeAE49BJW+c8W6ddmcBCvJo18XC3Gfv5vv/nXjvH+3ZfDObIx8VjF7a01pR4PJ7zmtxMmM0iVDPU7GX3onuZzguL+8hRQCiHlXGWAXVqzdtbsx15mwNEQmJGIlEJ8FtRdPAS1T3A/E8QOnB/HaNTmQS94rame9vgsjKLHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87326a81ceaso154702039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753303776; x=1753908576;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+V7/YlQ3Z6nlVFehAL6mq5YqFrwURSZuYwhX5QZxUY=;
        b=uDUP7D6IxfTeZfwssK+JYgX/kT0k1itbPfoa2AMQql7ZCn7Y4SaHoSCa50sC1iZynB
         6TTIOYx/IWqmzRaSMJg+RQJLzxcA+JJ1EVL9aLz1Q8SsAN7f+F4rfVK4bZWvOorAl0FI
         yqNn1PfkrFRZxXvO6BAKyLhu3wOlhMOFRMCfmBkJdZmYLA0OQta36SqaoXH/lrz3Rkgc
         bUwZp2yhPT2gjP1EYtVFkHlJ0hOMhY8Niw9nTU5LNKuP6GNcND0SUR5lCtMU8/tieeUQ
         L7GnB5To7KuPtOT3L4BznaRkMQrVXDtgBTxqQ0kOm1Yu83sBkPGG05vuPbuepWF3sqrt
         SyWg==
X-Forwarded-Encrypted: i=1; AJvYcCVDh9oFBHvJjNFlxRMNj/eGn+lpP10vZGtO0r7cArM0NVrY96tgVVT2D4agff3p9zcRgTdVMphh7a/5JKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbrmMTAqJnqiyfMUr6jploxtlV7q51gDdYBBck8aSN/uFyvp9
	HtyVxAMAtLYtdrAb8kz8IBYT2Yfoe6P8O5vP9Mx7Eq0ApHOQK9gFgQMcqHQcQUdpJyTjBi94LLU
	yyr/iGwtV1wWU4ARh8aS97KTDZKegOvHQAlyCP5dYUj+QBCSd/ZrgH4XknUo=
X-Google-Smtp-Source: AGHT+IETVSC6aRWv42tuf8zrCjrOWVFITfvsedCZsmTOFgcDMujBpEmOdpaolOm6H5mZTQvvFsar9/eDSw/x7jWW6RZZ6uh7+zc5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a0b:b0:87c:1c2a:3cd2 with SMTP id
 ca18e2360f4ac-87c65659b31mr684144339f.5.1753303776001; Wed, 23 Jul 2025
 13:49:36 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:49:35 -0700
In-Reply-To: <6836e09f.a70a0220.253bc2.00c7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68814adf.a00a0220.2f88df.0002.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in
 gfs2_qd_dealloc (3)
From: syzbot <syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    01a412d06bc5 Merge tag 'pull-ufs-fix' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150e6fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132aff22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144380a2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-01a412d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8229e4edb67d/vmlinux-01a412d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e07d86da9da/bzImage-01a412d0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5c2db4a05d12/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=110e6fd4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
BUG: KASAN: slab-use-after-free in gfs2_qd_dealloc+0x81/0xe0 fs/gfs2/quota.c:112
Write of size 4 at addr ffff888036404a80 by task pool_workqueue_/3

CPU: 0 UID: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.16.0-rc7-syzkaller-00018-g01a412d06bc5 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
 gfs2_qd_dealloc+0x81/0xe0 fs/gfs2/quota.c:112
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lockdep_unregister_key+0x2c5/0x310 kernel/locking/lockdep.c:6619
Code: 65 48 8b 05 3d 20 02 11 48 3b 44 24 10 0f 84 26 fe ff ff e8 fd 17 d1 09 e8 28 19 d1 09 41 f7 c7 00 02 00 00 74 bd fb 40 84 ed <75> bc eb cd 90 0f 0b 90 e9 19 ff ff ff 90 0f 0b 90 e9 2a ff ff ff
RSP: 0018:ffffc90000157c00 EFLAGS: 00000246
RAX: de469ecdd1056e00 RBX: ffff8880408f6538 RCX: de469ecdd1056e00
RDX: ffffffff93643318 RSI: ffffffff8d9ace67 RDI: ffffffff8be29ec0
RBP: ffff8880408f6500 R08: 0000000000000000 R09: ffffffff81ab49a8
R10: dffffc0000000000 R11: fffffbfff1f43f5f R12: 0000000000000000
R13: 0000000000001000 R14: 0000000000000001 R15: 0000000000000202
 wq_unregister_lockdep kernel/workqueue.c:4818 [inline]
 pwq_release_workfn+0x6d5/0x870 kernel/workqueue.c:5114
 kthread_worker_fn+0x504/0xb60 kernel/kthread.c:1010
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5598:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 init_sbd fs/gfs2/ops_fstype.c:78 [inline]
 gfs2_fill_super+0x11c/0x20e0 fs/gfs2/ops_fstype.c:1128
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5598:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 free_sbd fs/gfs2/ops_fstype.c:71 [inline]
 gfs2_fill_super+0x153d/0x20e0 fs/gfs2/ops_fstype.c:1319
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888036404000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2688 bytes inside of
 freed 8192-byte region [ffff888036404000, ffff888036406000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36400
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801a442280 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801a442280 0000000000000000 0000000000000001
head: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
head: 04fff00000000003 ffffea0000d90001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5553, tgid 5553 (syz.0.17), ts 108777604926, free_ts 108757444960
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 init_sbd fs/gfs2/ops_fstype.c:78 [inline]
 gfs2_fill_super+0x11c/0x20e0 fs/gfs2/ops_fstype.c:1128
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5562 tgid 5562 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3186
 put_cpu_partial+0x17c/0x250 mm/slub.c:3261
 __slab_free+0x2f7/0x400 mm/slub.c:4513
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 vm_area_alloc+0x24/0x140 mm/vma_init.c:31
 __mmap_new_vma mm/vma.c:2452 [inline]
 __mmap_region mm/vma.c:2622 [inline]
 mmap_region+0xcc7/0x1f30 mm/vma.c:2692
 do_mmap+0xc45/0x10d0 mm/mmap.c:561
 vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888036404980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036404a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888036404a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888036404b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036404b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	65 48 8b 05 3d 20 02 	mov    %gs:0x1102203d(%rip),%rax        # 0x11022045
   7:	11
   8:	48 3b 44 24 10       	cmp    0x10(%rsp),%rax
   d:	0f 84 26 fe ff ff    	je     0xfffffe39
  13:	e8 fd 17 d1 09       	call   0x9d11815
  18:	e8 28 19 d1 09       	call   0x9d11945
  1d:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  24:	74 bd                	je     0xffffffe3
  26:	fb                   	sti
  27:	40 84 ed             	test   %bpl,%bpl
* 2a:	75 bc                	jne    0xffffffe8 <-- trapping instruction
  2c:	eb cd                	jmp    0xfffffffb
  2e:	90                   	nop
  2f:	0f 0b                	ud2
  31:	90                   	nop
  32:	e9 19 ff ff ff       	jmp    0xffffff50
  37:	90                   	nop
  38:	0f 0b                	ud2
  3a:	90                   	nop
  3b:	e9 2a ff ff ff       	jmp    0xffffff6a


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

