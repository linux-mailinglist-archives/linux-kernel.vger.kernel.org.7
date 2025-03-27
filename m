Return-Path: <linux-kernel+bounces-579150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1CA74028
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16B37A5ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8E1A8F68;
	Thu, 27 Mar 2025 21:19:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C31D5170
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110346; cv=none; b=VN0IzxrnLyWCySqHcVC9EtiyD9t4mAq8wWeLubmgeap8oInBIrUMSrXPx4FDvmMB8K+2zf2mT4SmTcAHkQOO6F70vvzGwUhHTkB2ZVg52WiqHHw8unCp3mnk0APIt4yGzu9TX+quMHsS5gsdDLVwpiWIBh3O1byjvWhUHBfc9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110346; c=relaxed/simple;
	bh=aCPLkAPNqHPfXXYpF+u5DulW2UrdR85yULyiD3AkK84=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PW0WlO3MtrryFymXcuNxrv/THTP/69Olj7/kgERsJywIJdqW827/JlE7SbTCIJJhp6qSyOB/vOZNo6Ji46wLCYOtgnCBxA1CUI49T/Aphg46DqY+qCTr2wJt8X8885Q2xlVVIR5DKPQBFSB3NJVfbLwIQnFpbA2tFMFMmWnJ2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cf64584097so17537835ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743110343; x=1743715143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezyr0ftPfuRnIP/8/87RsgAT60DJXR7veyvFu9Xiw84=;
        b=DFwbo20aC1h19EQaeJlXmjOoK0C7U+4d3b7bVeVHB0e0KkoeomXPcawndqLwZX/VuY
         3l387t8ipQTPvW5U13yMa3l6V6tQmAltgw3Yzmwso7ZvAqy5Vyj80ug7MFF2M0VVWBWI
         LFhGQ3+oPTtjKmgci0Gk79zdo2s+5T24qqUHnKAe1GQiw8OpMYX2OPaPejA+5G64PMNm
         v3JZI/xB0OuAK1nhKX1IZ0bu4KTEPJb1ayhTnVCQXjcsOPjv+gLrcGaIVBdO1pvLo7gQ
         5IjfYcbZATUwE3mjZo1XeKF9BrfkloWMdvHBba7Ag3VcFFBqKJfeeMjh+wyINRxVjmRS
         BZdA==
X-Forwarded-Encrypted: i=1; AJvYcCUQx74QZaiKleDzN0rFvuL7q9yeH52jutSblPkwmNNQTr6tBAkYH5qN8Ndy4cwgYono0WDFBMCvKz47Hng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxii2mGW6aarJfGli7DuuM0G0uKLkOOlrZ+jJxEHWSNDLYyI6OP
	ZIshLIEmaFtca+VPJoQFBPpMelVo49EDaMFNGZB5WFYBR6DmWAuTg5GzyCcdz8udWqA38XrC+ex
	qnvMjRk55PNKEY2+fSknck4fa8zq6Dvlmpls3gkIkLtxM12jCZAMiN4M=
X-Google-Smtp-Source: AGHT+IFsGXdWVqU303kA5D+rW++qjzNC9PAP4fF99w7bb3PZFy5VjrvILDf0672csmbEocTzep7lHYv7wyQ7x+6KqjIhmfvgIGtd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:3d4:3ab3:daf0 with SMTP id
 e9e14a558f8ab-3d5ccdca0ebmr64790405ab.7.1743110343462; Thu, 27 Mar 2025
 14:19:03 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:19:03 -0700
In-Reply-To: <377fbe51-2e56-4538-89c5-eb91c13a2559@amd.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e5c0c7.050a0220.2f068f.004c.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in p9_conn_cancel

==================================================================
BUG: KASAN: slab-use-after-free in p9_conn_cancel+0x900/0x910 net/9p/trans_fd.c:205
Read of size 8 at addr ffff88807b19ea50 by task syz-executor/6595

CPU: 0 UID: 0 PID: 6595 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 p9_conn_cancel+0x900/0x910 net/9p/trans_fd.c:205
 p9_conn_destroy net/9p/trans_fd.c:927 [inline]
 p9_fd_close+0x3c5/0x590 net/9p/trans_fd.c:951
 p9_client_destroy+0xce/0x480 net/9p/client.c:1077
 v9fs_session_close+0x49/0x2d0 fs/9p/v9fs.c:506
 v9fs_kill_super+0x4d/0xa0 fs/9p/vfs_super.c:196
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1373
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x24ed/0x26c0 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1f978bb7c
Code: Unable to access opcode bytes at 0x7fa1f978bb52.
RSP: 002b:00007ffd5c5893b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007fa1f978bb7c
RDX: 0000000000000030 RSI: 00007ffd5c589470 RDI: 00000000000000f9
RBP: 00007ffd5c58941c R08: 0000000000000000 R09: 0079746972756365
R10: 00007ffd5c588d70 R11: 0000000000000246 R12: 0000000000000258
R13: 00000000000927c0 R14: 0000000000019c1d R15: 00007ffd5c589470
 </TASK>

Allocated by task 52:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x226/0x3d0 mm/slub.c:4160
 p9_tag_alloc+0x9c/0x870 net/9p/client.c:281
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_rpc+0x1c3/0xc10 net/9p/client.c:691
 p9_client_write+0x31f/0x680 net/9p/client.c:1645
 v9fs_issue_write+0xe2/0x180 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x92/0x110 fs/netfs/write_issue.c:233
 netfs_retry_write_stream fs/netfs/write_collect.c:184 [inline]
 netfs_retry_writes fs/netfs/write_collect.c:361 [inline]
 netfs_collect_write_results fs/netfs/write_collect.c:529 [inline]
 netfs_write_collection_worker+0x3e10/0x47d0 fs/netfs/write_collect.c:551
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5192:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free_after_rcu_debug+0x115/0x340 mm/slub.c:4648
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:655
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:671
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:544
 slab_free_hook mm/slub.c:2299 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x305/0x4c0 mm/slub.c:4700
 p9_req_put net/9p/client.c:409 [inline]
 p9_req_put+0x1c6/0x250 net/9p/client.c:402
 p9_client_rpc+0x591/0xc10 net/9p/client.c:761
 p9_client_write+0x31f/0x680 net/9p/client.c:1645
 v9fs_issue_write+0xe2/0x180 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x92/0x110 fs/netfs/write_issue.c:233
 netfs_retry_write_stream fs/netfs/write_collect.c:184 [inline]
 netfs_retry_writes fs/netfs/write_collect.c:361 [inline]
 netfs_collect_write_results fs/netfs/write_collect.c:529 [inline]
 netfs_write_collection_worker+0x3e10/0x47d0 fs/netfs/write_collect.c:551
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88807b19e990
 which belongs to the cache p9_req_t of size 208
The buggy address is located 192 bytes inside of
 freed 208-byte region [ffff88807b19e990, ffff88807b19ea60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b19e
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88814c7a0140 ffffea0001dd70c0 0000000000000006
raw: 0000000000000000 00000000000f000f 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6752, tgid 6751 (syz.0.17), ts 91802565462, free_ts 91788017536
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x221/0x2470 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab mm/slub.c:2574 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2627
 ___slab_alloc+0xda4/0x1880 mm/slub.c:3815
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_noprof+0xfa/0x3d0 mm/slub.c:4160
 p9_tag_alloc+0x9c/0x870 net/9p/client.c:281
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_rpc+0x1c3/0xc10 net/9p/client.c:691
 p9_client_version net/9p/client.c:930 [inline]
 p9_client_create+0xc65/0x1200 net/9p/client.c:1036
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa30 fs/9p/vfs_super.c:122
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1814
page last free pid 6750 tgid 6748 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xa7b/0x14f0 mm/page_alloc.c:2704
 folios_put_refs+0x587/0x7b0 mm/swap.c:962
 free_pages_and_swap_cache+0x45f/0x510 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 exit_mmap+0x3df/0xb20 mm/mmap.c:1680
 __mmput+0x12a/0x4c0 kernel/fork.c:1353
 mmput+0x62/0x70 kernel/fork.c:1375
 exit_mm kernel/exit.c:570 [inline]
 do_exit+0x9bf/0x2d70 kernel/exit.c:925
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x24ed/0x26c0 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807b19e900: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff88807b19e980: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807b19ea00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                 ^
 ffff88807b19ea80: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b19eb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
==================================================================


Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fafde4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110a3804580000


