Return-Path: <linux-kernel+bounces-859717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C7BEE66A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1B3BE148
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61632E8DF0;
	Sun, 19 Oct 2025 14:12:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DED1684B0
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883125; cv=none; b=u4y0uoQKl12Y94Ims4KYE3I8VTNjJyPX/HYA+86AOlxszwr5HRf18dRvI3MiKZaiI1DQHhclXib/r2dXPXvjk8gtC4PaO1O4Kmpn/IRErqOoTAdxNwUthlcWk47Rs5i8NcokKj8iExCjPV7pUp3Mq0/+4isPqaZyNEB4qDrEom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883125; c=relaxed/simple;
	bh=DoYKogX2JLtTnKfeeu0Qtgk4cy2dtBYnDlV9TPMC3Z4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IrSr//O4XZRKqJLVJVvgVU6qx9QP5DlvhEgQvVqiwRxbY5mlEBLfM/ZY2YaLUMSCcbU21z0wn4lQopx8f4qMO/Dwhzbn2r9vG3nAPOJZiN+ZPVoIcc9O8Zp817X7rL5mZIYLASWyWSCobMgjvqXjq0MO2RsfqdeYnuqd8WvvGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c6b6ce73so78143355ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760883122; x=1761487922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79E6Qv/AgVxKQT+O8kVqakRwLr+Wq5BB41vvUirlAEc=;
        b=ZEyUAw+beX0rr5jNzWbqmAuZqAycblFcyLRfoCna6Zs6ASR4o1EASWtyjWeGcrKyqx
         jOmgWn47sf0SwxswJSNJ72uu63bI6X36RGN22JV+B94+0JRh/oQ5O2RJWTUEp+2hDqhO
         3+gmlYmjW5dQIa2RaJfHGg9fN6VSCDwspZ3qU2yxfiaE7/dwbGU4JOvIBya3njDEdbf/
         N7m/yFX5YmHm6QZKXWBxaSpjpyMIP312F/K3QJcmi38yIAST3CPcU3UweNMNsd2XKZjs
         hgoLf8krpLnpNeaeoADmfba2IILwSrKqTGusl8VXiLgUdwNTbt4U3/E84eRyFs9nGf0M
         7UKw==
X-Gm-Message-State: AOJu0YyGSpCb7ipfrYICYflyFwtZND93LXdeXloZzlUCGvJAHTBG/ICD
	7Mbu9vCBA5i0D94TcU1rjpThqoETYksXXX3Ns9nu1b6O4BC4wrutPsNapI+eMvG0fnyJtcfIY5y
	3yHRvui35aH0Okv4I9kbrO0zgh3EJ8E9x9Fz6N23udD3VS1Kj3yK9YO0iNx8=
X-Google-Smtp-Source: AGHT+IFWf+2DQxPpLvCJDTLU0FcvzkDy6aULk337uWAPAReHruv6zd6N+txvoPZPG6PzuhwOPyN3tKD96Rg10a8O6rKQ1z0JPMQG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:430:b7c4:6617 with SMTP id
 e9e14a558f8ab-430c527bc80mr158372395ab.15.1760883122523; Sun, 19 Oct 2025
 07:12:02 -0700 (PDT)
Date: Sun, 19 Oct 2025 07:12:02 -0700
In-Reply-To: <c5cfbnfdsztbsqq4g2po4aruqzgxssx7rlnqtxojw2aafjyfpx@qwvgxpbdixmj>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f4f1b2.050a0220.1be48.0002.GAE@google.com>
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
From: syzbot <syzbot+2860e75836a08b172755@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in nr_add_node

==================================================================
BUG: KASAN: slab-use-after-free in nr_add_node+0x2b65/0x2bd0 net/netrom/nr_route.c:249
Read of size 4 at addr ffff8880265a73b0 by task syz.0.5221/17351

CPU: 0 UID: 0 PID: 17351 Comm: syz.0.5221 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 nr_add_node+0x2b65/0x2bd0 net/netrom/nr_route.c:249
 nr_rt_ioctl+0x11b7/0x29b0 net/netrom/nr_route.c:652
 nr_ioctl+0x19a/0x2d0 net/netrom/af_netrom.c:1254
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9fdb8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff9fe9f1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff9fdde5fa0 RCX: 00007ff9fdb8efc9
RDX: 0000200000000280 RSI: 000000000000890b RDI: 0000000000000004
RBP: 00007ff9fdc11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff9fdde6038 R14: 00007ff9fdde5fa0 R15: 00007ffd8e5d4ad8
 </TASK>

Allocated by task 17330:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 nr_add_node+0xe4e/0x2bd0 net/netrom/nr_route.c:146
 nr_rt_ioctl+0x11b7/0x29b0 net/netrom/nr_route.c:652
 nr_ioctl+0x19a/0x2d0 net/netrom/af_netrom.c:1254
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 17351:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2530 [inline]
 slab_free mm/slub.c:6619 [inline]
 kfree+0x2b8/0x6d0 mm/slub.c:6826
 nr_neigh_put include/net/netrom.h:143 [inline]
 nr_neigh_put include/net/netrom.h:137 [inline]
 nr_add_node+0x2389/0x2bd0 net/netrom/nr_route.c:247
 nr_rt_ioctl+0x11b7/0x29b0 net/netrom/nr_route.c:652
 nr_ioctl+0x19a/0x2d0 net/netrom/af_netrom.c:1254
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880265a7380
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
 freed 64-byte region [ffff8880265a7380, ffff8880265a73c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x265a7
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b4428c0 ffffea0000b7abc0 dead000000000004
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 132, tgid 132 (kworker/0:2), ts 9597767021, free_ts 8864964788
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3046 [inline]
 allocate_slab mm/slub.c:3219 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3273
 ___slab_alloc+0xdc4/0x1ae0 mm/slub.c:4643
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4762
 __slab_alloc_node mm/slub.c:4838 [inline]
 slab_alloc_node mm/slub.c:5260 [inline]
 __do_kmalloc_node mm/slub.c:5633 [inline]
 __kmalloc_noprof+0x501/0x880 mm/slub.c:5646
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kmalloc_array_noprof include/linux/slab.h:1003 [inline]
 drm_atomic_state_init+0x17b/0x320 drivers/gpu/drm/drm_atomic.c:137
 drm_atomic_state_alloc drivers/gpu/drm/drm_atomic.c:176 [inline]
 drm_atomic_state_alloc+0xd3/0x120 drivers/gpu/drm/drm_atomic.c:166
 drm_atomic_helper_dirtyfb+0xc8/0x780 drivers/gpu/drm/drm_damage_helper.c:128
 drm_fbdev_shmem_helper_fb_dirty+0x1cc/0x340 drivers/gpu/drm/drm_fbdev_shmem.c:118
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:380 [inline]
 drm_fb_helper_damage_work+0x27e/0x5f0 drivers/gpu/drm/drm_fb_helper.c:403
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 vfree+0x1fd/0xb50 mm/vmalloc.c:3440
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3359
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880265a7280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880265a7300: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>ffff8880265a7380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff8880265a7400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880265a7480: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135d0de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bd03cd980000


