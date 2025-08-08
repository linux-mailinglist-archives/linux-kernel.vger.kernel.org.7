Return-Path: <linux-kernel+bounces-760382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5EB1EA67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F463A68DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D527E04F;
	Fri,  8 Aug 2025 14:32:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4761527B4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663528; cv=none; b=pVjRXFzFDBDsnC7KdzboC6XAYkVNaPezNN39vSHRAGR3CLKDaTg/RZNlLR8Zp5FGoXkxeiITUAr8ks7wFcGfFCdjLCtpILRj170yO6De3BAXKv7onrrfHqLhUwIu+6dadxbbponJPegctRZAlBuEh7gttHyyOo2OsOMY2+S4ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663528; c=relaxed/simple;
	bh=viLyU8AKGc78/rSErafJ4ifD5r4Bv489AXrInWfZyU4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YaUsjjhAtS5BqJ70VLDa09r29fQGzn1NgXUwNxFiZPY88oGfPmJig20kYBLZteBMOvPcqkwUsn5W8XBOEwyNykC9f6k8knD52ocKQdq/CpaFLzw/ARkUMqQlkyxdt+5zcVVd3FpVxCGJXACDn+M9K1bsvbukHiBy7syXWLWdvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e51497bdbeso15979975ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663525; x=1755268325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k78xn3WdicNXeWMMHS/3Mh3YhVq4EG9b8nHL/iXNZOI=;
        b=BM9tmxOkFeiFLcqx15R3iZ2LYpT0z8n9GUkda/sqeUyebCQHjgCXKZkhR67UbBbOgM
         s0L7496zg0M45GHMhrqfsgFv4zn5PIEzU5WlxaA0xBYPXeFLeEpc09TP7xUoqzBD0El5
         FrLyPRLSSclgJXjhXataTQQdChfBTaSWp4GIuhARk8/ixVi9IMNhiapNbvUGUCRFI3A7
         svHm5p2Mswte3lmobZkkmxBYhwAgMATmWqPAjEKFIyTLVU5BUWoEPJKGDGNsCQvF4YKY
         SK1ghhMwt/0quK5bxKI5HroaVH+uLnqwjhwsI+MpFYLxOqan1lM9tq30jAMoNK/DtqjA
         T++A==
X-Forwarded-Encrypted: i=1; AJvYcCXMPd0E5lULK0GWvsFYfrI8s+3KL4lR0sQ3PvoLMY376NUYKhzCTcpGPrEMJTU+cCfcF2vAbxahM430ww0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwSABufhqmBZr6keeC5/aRGKlDU+akOeBMnu/DQmOEZrkwM8w
	+I2KKEY+yVZepwPVBlPjQjbB9k3CpG/rIlDJ6kJa1bW5cssd/Da9O2v7gibe9aYEBoYFg+XRa39
	V9T042fdp3lo9kFcAVNkCtswHL4YvD6svw2xY1eB02RbAUxG3szAX/NLmjJ0=
X-Google-Smtp-Source: AGHT+IEnOF73cF0hZB816tzVyVSAHzfW6lEj12mYe9CSwylwlOSliqExqw9bshn5RU+2CO/gdoP7hqvdtL/CfR7VzGqdQss1JbFM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e90:b0:3e3:fd72:969a with SMTP id
 e9e14a558f8ab-3e533088692mr51445055ab.4.1754663525387; Fri, 08 Aug 2025
 07:32:05 -0700 (PDT)
Date: Fri, 08 Aug 2025 07:32:05 -0700
In-Reply-To: <20250808135614.4022-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68960a65.050a0220.7f033.006c.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
From: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in __lock_sock

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:178
Read of size 1 at addr ffff888031e00958 by task kworker/u8:4/59

CPU: 1 UID: 0 PID: 59 Comm: kworker/u8:4 Not tainted 6.16.0-syzkaller-12063-g37816488247d-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: kkcmd kcm_tx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:568
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __lock_sock+0x156/0x2b0 net/core/sock.c:3171
 lock_sock_nested+0x9f/0x100 net/core/sock.c:3738
 lock_sock include/net/sock.h:1667 [inline]
 kcm_tx_work+0x31/0x180 net/kcm/kcmsock.c:718
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6724:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 sk_prot_alloc+0x57/0x220 net/core/sock.c:2233
 sk_alloc+0x3a/0x370 net/core/sock.c:2295
 kcm_clone net/kcm/kcmsock.c:1524 [inline]
 kcm_ioctl+0x214/0xff0 net/kcm/kcmsock.c:1569
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6725:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 sk_prot_free net/core/sock.c:2276 [inline]
 __sk_destruct+0x4d2/0x660 net/core/sock.c:2373
 kcm_release+0x528/0x5c0 net/kcm/kcmsock.c:1736
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc0/0x240 net/socket.c:1439
 __fput+0x44c/0xa70 fs/file_table.c:468
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xcd2/0xfb0 kernel/workqueue.c:2339
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 kcm_unattach+0x863/0xe90 net/kcm/kcmsock.c:1433
 kcm_unattach_ioctl net/kcm/kcmsock.c:1490 [inline]
 kcm_ioctl+0x794/0xff0 net/kcm/kcmsock.c:1557
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xcd2/0xfb0 kernel/workqueue.c:2339
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 kcm_attach net/kcm/kcmsock.c:1313 [inline]
 kcm_attach_ioctl net/kcm/kcmsock.c:1341 [inline]
 kcm_ioctl+0xe52/0xff0 net/kcm/kcmsock.c:1547
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888031e00780
 which belongs to the cache KCM of size 1792
The buggy address is located 472 bytes inside of
 freed 1792-byte region [ffff888031e00780, ffff888031e00e80)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x31e00
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880291be401
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88814c5fa780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080110011 00000000f5000000 ffff8880291be401
head: 00fff00000000040 ffff88814c5fa780 dead000000000122 0000000000000000
head: 0000000000000000 0000000080110011 00000000f5000000 ffff8880291be401
head: 00fff00000000003 ffffea0000c78001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6692, tgid 6688 (syz.0.17), ts 157441443200, free_ts 157382453488
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
 sk_prot_alloc+0x57/0x220 net/core/sock.c:2233
 sk_alloc+0x3a/0x370 net/core/sock.c:2295
 kcm_clone net/kcm/kcmsock.c:1524 [inline]
 kcm_ioctl+0x214/0xff0 net/kcm/kcmsock.c:1569
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5235 tgid 5235 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2753 [inline]
 __put_partials+0x156/0x1a0 mm/slub.c:3218
 put_cpu_partial+0x17c/0x250 mm/slub.c:3293
 __slab_free+0x2d5/0x3c0 mm/slub.c:4550
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2918 [inline]
 getname_maybe_null include/linux/fs.h:2925 [inline]
 vfs_fstatat+0x43/0x170 fs/stat.c:370
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888031e00800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031e00880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888031e00900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888031e00980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031e00a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         37816488 Merge tag 'net-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164c41a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112661a2580000


