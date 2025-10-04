Return-Path: <linux-kernel+bounces-842035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C198BB8D17
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 14:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA0D3C46A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F9221299;
	Sat,  4 Oct 2025 12:11:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE6175BF
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759579865; cv=none; b=P2c+9qOh919gV55Mk9WMno7qLY4zdZVtuCLfbpWOb7hKQa1ryOTdZjlRR4Hs6aKXwhOLtHKwcilUnDUIVJPxEFruQyOqGekH2dkoNKpOctH5CA7KH3YJilaIkMr9WpVTfa+5z3winVPBeozCNIFQkkUZjj2ayZthAivMig4gpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759579865; c=relaxed/simple;
	bh=kWGZIrNYNjXY4Ydc1N/G9VJiHaYdOEzyzEc/cvoT97I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GvgK+k+MnIqg38JKnbPaFGBeMlyESvFAbMyk5VNYRB6fDS0lJrJhDlLr305T0qnOQ8+yNJR7AlCxYnWT2mGPGJRoR70QBQFSpzHzm5tlGt61Aw/dooZAlpcyOyVLL1I+G2WfZRw12+wzF6RqzcouryQisHfoKuKPtHB7InewpCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42e71d1a064so31385985ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 05:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759579862; x=1760184662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqMcp+uBoGDybCpsFRsDhwIW/IIOCpCVWq4IQ6B03Ck=;
        b=oXkxwff0W2kBF+lU3t79huyXp+gXKNns8FMXylTtbf3W9TFdyx8TMA5ImuMYZcW1/X
         kYtEpqKpSri/C8O7tigq0WJwApoYoPpHsPD/JJdSGTd3oTIJgGx3FXb9FkduXdGJ9O0a
         ezPPmj3H7oZLVYWO1zqlxHu9K//qF6qed3L97o0U/dBLGLqC4/70fL/eVoR4Zyd9NHqt
         mR5vYU9/EjQTqjGvVCAf6s1sUc/Fc6Lf81Iwf4T/CjRhNuAf2odQ1uruNEbkwe3lUJNi
         SWia+CCJ/Cb5dU7Ul52F1Xtq/1rQ8ShSCcPJrl3UyWAYAkTiUQl3Jwn88h5dxklU0slz
         mjNw==
X-Forwarded-Encrypted: i=1; AJvYcCVI63kp/AHBTP4uOK5pe9KV0CM8H/rdDr0WxuMkhLCw+zjuvPZ4XJr5mfvKCXhG6O5RosN45BYnrxuVXkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/ODeEMm7NlHLoL+dculbmI2OuAE9itRAbhO04klJHt2qFBD6
	s5I4djAj/+syEeW9CqTnr1VarJSiJ8G38IwsPfhB090D7WLUcAm/RjYHzBMWuI1NIo07cVvlJzG
	d+ACnV3yLPDXngnQhO1xtatzzo3pR502WjJ+ZPdGpZ4/8KDDYXBunFPYz5ko=
X-Google-Smtp-Source: AGHT+IEozIoipJ6w2LwKbwLJdezyTezB3VyU4ggrIMYCbNWrtLEzRoHuCjqMFQpvCjjqX7RvzQnrHrIBEqH97v0WQa4+Gj+5kOg1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:42d:8c0b:fbcd with SMTP id
 e9e14a558f8ab-42e7acec3e6mr86622655ab.4.1759579862565; Sat, 04 Oct 2025
 05:11:02 -0700 (PDT)
Date: Sat, 04 Oct 2025 05:11:02 -0700
In-Reply-To: <20251004100604.8082-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e10ed6.050a0220.396d9c.066e.GAE@google.com>
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in
 afs_dynroot_readdir (2)
From: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in afs_dynroot_readdir

==================================================================
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir_cells fs/afs/dynroot.c:299 [inline]
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir+0x106f/0x12e0 fs/afs/dynroot.c:363
Read of size 4 at addr ffff8880283cf948 by task syz.0.1618/9809

CPU: 0 UID: 0 PID: 9809 Comm: syz.0.1618 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 afs_dynroot_readdir_cells fs/afs/dynroot.c:299 [inline]
 afs_dynroot_readdir+0x106f/0x12e0 fs/afs/dynroot.c:363
 iterate_dir+0x293/0xaf0 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64 fs/readdir.c:396 [inline]
 __x64_sys_getdents64+0x13c/0x2c0 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe27498eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe27587a038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fe274be5fa0 RCX: 00007fe27498eec9
RDX: 0000000000000055 RSI: 00002000000007c0 RDI: 0000000000000003
RBP: 00007fe274a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe274be6038 R14: 00007fe274be5fa0 R15: 00007ffd3fb02548
 </TASK>

Allocated by task 9807:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 afs_alloc_cell fs/afs/cell.c:137 [inline]
 afs_lookup_cell+0x61d/0x1680 fs/afs/cell.c:265
 afs_dynroot_lookup_cell fs/afs/dynroot.c:111 [inline]
 afs_dynroot_lookup+0x3d8/0xd60 fs/afs/dynroot.c:159
 __lookup_slow+0x251/0x460 fs/namei.c:1816
 lookup_slow fs/namei.c:1833 [inline]
 walk_component+0x353/0x5b0 fs/namei.c:2151
 lookup_last fs/namei.c:2652 [inline]
 path_lookupat+0x142/0x6d0 fs/namei.c:2676
 filename_lookup+0x224/0x5f0 fs/namei.c:2705
 do_linkat+0x14c/0x5a0 fs/namei.c:4991
 __do_sys_link fs/namei.c:5045 [inline]
 __se_sys_link fs/namei.c:5043 [inline]
 __x64_sys_link+0x7d/0xa0 fs/namei.c:5043
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2514 [inline]
 slab_free mm/slub.c:6566 [inline]
 kfree+0x2b8/0x6d0 mm/slub.c:6773
 afs_cell_destroy+0x21c/0x310 fs/afs/cell.c:525
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x799/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3123
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 insert_work+0x36/0x230 kernel/workqueue.c:2186
 __queue_work+0x97e/0x1160 kernel/workqueue.c:2341
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:669 [inline]
 afs_put_cell.part.0+0x1ab/0x240 fs/afs/cell.c:570
 afs_put_cell fs/afs/cell.c:558 [inline]
 afs_manage_cell_work+0x6de/0x1940 fs/afs/cell.c:860
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880283cf800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 328 bytes inside of
 freed 1024-byte region [ffff8880283cf800, ffff8880283cfc00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x283c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b026dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b026dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a0f201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5894, tgid 5894 (syz-executor), ts 75218089779, free_ts 73045805122
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_slab_page mm/slub.c:3032 [inline]
 allocate_slab mm/slub.c:3203 [inline]
 new_slab+0xa5/0x360 mm/slub.c:3257
 ___slab_alloc+0xdc4/0x1ae0 mm/slub.c:4627
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4746
 __slab_alloc_node mm/slub.c:4822 [inline]
 slab_alloc_node mm/slub.c:5233 [inline]
 __do_kmalloc_node mm/slub.c:5602 [inline]
 __kmalloc_node_noprof+0x4dd/0x8a0 mm/slub.c:5609
 kmalloc_array_node_noprof include/linux/slab.h:1075 [inline]
 alloc_slab_obj_exts+0x3a/0xd0 mm/slub.c:2115
 account_slab mm/slub.c:3157 [inline]
 allocate_slab mm/slub.c:3222 [inline]
 new_slab+0x283/0x360 mm/slub.c:3257
 ___slab_alloc+0xdc4/0x1ae0 mm/slub.c:4627
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4746
 __slab_alloc_node mm/slub.c:4822 [inline]
 slab_alloc_node mm/slub.c:5233 [inline]
 __kmalloc_cache_noprof+0x477/0x780 mm/slub.c:5719
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 alloc_netdev_mqs+0xed3/0x1550 net/core/dev.c:11976
 rtnl_create_link+0xc08/0xf90 net/core/rtnetlink.c:3641
 rtnl_newlink_create net/core/rtnetlink.c:3823 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0xb69/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6954
page last free pid 5852 tgid 5852 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 discard_slab mm/slub.c:3301 [inline]
 __put_partials+0x130/0x170 mm/slub.c:3848
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4946 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 __kmalloc_cache_noprof+0x274/0x780 mm/slub.c:5719
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 tomoyo_environ security/tomoyo/domain.c:633 [inline]
 tomoyo_find_next_domain+0xbd2/0x20b0 security/tomoyo/domain.c:888
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12e/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x1b9/0x1e0 security/security.c:1341
 search_binary_handler fs/exec.c:1660 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve fs/exec.c:1754 [inline]
 bprm_execve+0x81a/0x1640 fs/exec.c:1730
 do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1860
 do_execve fs/exec.c:1934 [inline]
 __do_sys_execve fs/exec.c:2010 [inline]
 __se_sys_execve fs/exec.c:2005 [inline]
 __x64_sys_execve+0x8e/0xb0 fs/exec.c:2005
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880283cf800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880283cf880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880283cf900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff8880283cf980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880283cfa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         cbf33b8e Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16533942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e82a64dcfd006b7
dashboard link: https://syzkaller.appspot.com/bug?extid=ae8ad52680705c162471
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113b9ee2580000


