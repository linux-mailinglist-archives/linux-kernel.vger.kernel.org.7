Return-Path: <linux-kernel+bounces-888779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88324C3BE47
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D166B4643F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0732E6B0;
	Thu,  6 Nov 2025 14:50:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D6338F4D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440605; cv=none; b=d0PBxRsNRnu669Hu10x6isGWeBiOn8LZJiu3/ZsAZc9ux9Y25A+xGhycAD4q2cFZGIFmDBZ82BusL+lXgxA18EE9rcOc9M97UyXdGVmxEcSA7SE1UPF3sV0jlhOf9M8O1azW9k9/zEzLNUXu3VR4CjerT7l6gg++G4mYRu2UqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440605; c=relaxed/simple;
	bh=ClVvygpaOszgex7pKkwlz391W0vuTBEZ6f908Cjeocg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kTPTeEFOYlDJ+pcNbjcvzUiWy4OUbV7ntt1v7R4poWNwmw5OJQxE2iWK63Ja30P2yDvUdELR1yfWYKPZS8yXLPC8WlpOGMAP4rxaZPOfNn46Mr1P1Ht9sqyQEmXBv71TWlGFdTsydSzb4zwJm7v9waYu4d2Iqy5V380ju/M8Ey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-432fb58f876so12659805ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440602; x=1763045402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw+sKt4Hrlg5vf9DTrG+ekoXY8UKf3ME2/d1QEC3xrc=;
        b=P7SZgHmz+LmjFuwr8WB+b8Y/pc89w8NrGyPy4nPGf18anyRmgOUjLXXluUkpEFStdE
         1Gz1PRh28TOb9N4UUY3llPUzDOusDuhTCyR+KF3F6YYcKh3wLhb1CW1ODw8OQgzBYVwT
         1DM3gk/CCBNbE8mKO+ZecETXinDJV4zBVybhGq57UEPTmkAp9yVWtyZ1nQhGA0oeJlGZ
         bk/WXNdCtamDAKtKVR9UEp7oKETu1pZ5Z2Ax4mcr5XoRMRzEf+DBXCTpg3QSRKhrgyh5
         NqN0z4E5MgVlYzki+tAlyyGn8vLr/wcpgnQqBpRgmijrj8vnZooe4Ef3wjSk3czDLJUd
         sVbA==
X-Gm-Message-State: AOJu0Yzt9BnJhyumXXsZRIE+bk79dwl9mLKTlP5MdOv1XgdScIBdwwxs
	qOp9NA0Mw0hfqVT33qOtMJftgzYtLGOeza3Wf/PBcGXBw09Mo89vGkhHoOSgWmH68mrhSV0aftO
	yFTwk1YziKXumxFB2RtvzBcFI5D/ljfwCnKhOehkMPbw5cEhbvWdSGGk3/20=
X-Google-Smtp-Source: AGHT+IGq7Ey5WtLU7pFFvW72e3TkDw6Dt2d2KpMSigiVUzT/tJwyU/in9mvEFWoTnW8Vmi6BKMp43is1dmGP+uJ2KZH4UY8gOcoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330e:b0:430:c90d:10ae with SMTP id
 e9e14a558f8ab-433407dfcc7mr111141735ab.32.1762440602586; Thu, 06 Nov 2025
 06:50:02 -0800 (PST)
Date: Thu, 06 Nov 2025 06:50:02 -0800
In-Reply-To: <CAPrAcgMMMYxF=Cw+rwEHuPJJ=4bCyukCh8ptS9M4iQTbWEd+yw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690cb59a.050a0220.3d0d33.015e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in handle_tx (2)
From: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ser_release

==================================================================
BUG: KASAN: slab-use-after-free in ser_release+0x39c/0x3b0 drivers/net/caif/caif_serial.c:303
Read of size 8 at addr ffff8880355fed98 by task kworker/3:0/34

CPU: 3 UID: 0 PID: 34 Comm: kworker/3:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events ser_release
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 ser_release+0x39c/0x3b0 drivers/net/caif/caif_serial.c:303
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6406:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5642 [inline]
 __kvmalloc_node_noprof+0x3a3/0x9c0 mm/slub.c:7100
 alloc_netdev_mqs+0xd7/0x1550 net/core/dev.c:11900
 ldisc_open+0x155/0x970 drivers/net/caif/caif_serial.c:331
 tty_ldisc_open+0x9f/0x120 drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x32b/0x780 drivers/tty/tty_ldisc.c:563
 tiocsetd drivers/tty/tty_io.c:2429 [inline]
 tty_ioctl+0xc2d/0x1680 drivers/tty/tty_io.c:2728
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 34:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x2b8/0x6d0 mm/slub.c:6837
 device_release+0xa4/0x240 drivers/base/core.c:2565
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 netdev_run_todo+0x7e9/0x1320 net/core/dev.c:11601
 ser_release+0x1ca/0x3b0 drivers/net/caif/caif_serial.c:298
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880355fe000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3480 bytes inside of
 freed 4096-byte region [ffff8880355fe000, ffff8880355ff000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x355f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802c472741
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b04c280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff88802c472741
head: 00fff00000000040 ffff88801b04c280 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 ffff88802c472741
head: 00fff00000000003 ffffea0000d57e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6200, tgid 6200 (udevd), ts 91632676821, free_ts 89805144993
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab mm/slub.c:3228 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3282
 ___slab_alloc+0xdae/0x1a60 mm/slub.c:4651
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 __do_kmalloc_node mm/slub.c:5641 [inline]
 __kvmalloc_node_noprof+0x5aa/0x9c0 mm/slub.c:7100
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x830/0x12d0 fs/seq_file.c:210
 proc_reg_read_iter+0x11b/0x310 fs/proc/inode.c:295
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0x8bf/0xcf0 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6346 tgid 6346 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 vfree+0x1fd/0xb50 mm/vmalloc.c:3440
 kcov_put kernel/kcov.c:439 [inline]
 kcov_put kernel/kcov.c:435 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:535
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x150/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x86f/0x2bf0 kernel/exit.c:966
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1107
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7c0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x85/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880355fec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880355fed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880355fed80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880355fee00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880355fee80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         dc77806c Merge tag 'rust-fixes-6.18' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13702a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f009a9a8d50667
dashboard link: https://syzkaller.appspot.com/bug?extid=827272712bd6d12c79a4
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a29084580000


