Return-Path: <linux-kernel+bounces-737219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1755B0A963
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B2C1C82521
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB7D2E7177;
	Fri, 18 Jul 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qrij6asb"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69F2DCF4A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859561; cv=none; b=o+8Hj/2vYZANdtLHt0zBgs6O60nOoRK1ONLjcnJk/IYjLUrtffnNMluxdd3xSI8MH3X4vV0lUm65DAhNW70JrKcEcKEkSi4G6WX5mUJfBhqJH0s6JuogDGPZdcu3RiCwIPc5KjbfYhjpkx7bKvSkb4etuiq4DZTnXnsHLsjrH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859561; c=relaxed/simple;
	bh=/ltMyYnjc0AVI0Un+YpPBaBDEvqMnt9slgLNo9Zxviw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQZq66mrp4w/70W27sKCjv8WSpUWCNqlugqbscrlNExNGK9fGwwQ8R/jEG1ZP7kZAxMvH4L+vYle3jtHP6lkGcG9NaqrXMa/s/QUlHqL39xIKnKWoHWc2iIUeInfMe455hxNNMlj8aUJ7rEr4ohaZmtq0j8YWGrv89vtO+DX6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qrij6asb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Jul 2025 13:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752859545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RkUd4lEkByUmKRguon71FptVYiu+lg85ACzVgMkMt/s=;
	b=qrij6asbYRv378VHa9T9cLv/hck+58nIpo68rW4QKd/F90/PRhsGiIhTkiTbA6pp1LBcpG
	GEGcGGVe2FZbLhzS66pnsMHEuM5ii302W3Dftxy4sTen5xvsmYZrpnqZfOG9jEkdxbmZ8K
	WWmpiQg0Hwr/Elo5ZLa9tFb++dZjFVA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+2b98caf09c41174a9697@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Write in
 bch2_get_next_dev
Message-ID: <ci6d4nck2pydr7gprqmv5v5rudgx5wrt5xumkzrewnwol2p2z7@t6ksfe4l3ayu>
References: <zqlwuyi7g6sfxrehampc2r5bzgoobattjujzavfp6pvlyqa3k3@pin45zzim2z3>
 <687a7fe2.a00a0220.3af5df.002d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687a7fe2.a00a0220.3af5df.002d.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 18, 2025 at 10:09:54AM -0700, syzbot wrote:
> > On Fri, Jul 18, 2025 at 09:09:35AM -0700, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    024e09e444bd Add linux-next specific files for 20250717
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=107317d4580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=99c60e2181be9059
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=2b98caf09c41174a9697
> >> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ad7d8c580000
> >> 
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/0a89a1e83302/disk-024e09e4.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/e2264946780a/vmlinux-024e09e4.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/d684a7204e1c/bzImage-024e09e4.xz
> >> mounted in repro: https://storage.googleapis.com/syzbot-assets/5f7f631c7091/mount_2.gz
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+2b98caf09c41174a9697@syzkaller.appspotmail.com
> >> 
> >> ==================================================================
> >> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> >> BUG: KASAN: slab-use-after-free in atomic_long_inc_return include/linux/atomic/atomic-instrumented.h:3609 [inline]
> >> BUG: KASAN: slab-use-after-free in bch2_dev_get fs/bcachefs/sb-members.h:114 [inline]
> >> BUG: KASAN: slab-use-after-free in bch2_get_next_dev+0x38f/0x4e0 fs/bcachefs/sb-members.h:145
> >> Write of size 8 at addr ffff888029ae2040 by task kworker/u9:0/51
> >> 
> >> CPU: 1 UID: 0 PID: 51 Comm: kworker/u9:0 Not tainted 6.16.0-rc6-next-20250717-syzkaller #0 PREEMPT(full) 
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> >> Workqueue: bcachefs_journal journal_write_done
> >> Call Trace:
> >>  <TASK>
> >>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >>  print_address_description mm/kasan/report.c:378 [inline]
> >>  print_report+0xca/0x230 mm/kasan/report.c:480
> >>  kasan_report+0x118/0x150 mm/kasan/report.c:593
> >>  check_region_inline mm/kasan/generic.c:-1 [inline]
> >>  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
> >>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> >>  atomic_long_inc_return include/linux/atomic/atomic-instrumented.h:3609 [inline]
> >>  bch2_dev_get fs/bcachefs/sb-members.h:114 [inline]
> >>  bch2_get_next_dev+0x38f/0x4e0 fs/bcachefs/sb-members.h:145
> >>  bch2_do_discards+0x20/0x160 fs/bcachefs/alloc_background.c:1935
> >>  journal_write_done+0x11b9/0x13f0 fs/bcachefs/journal_io.c:1822
> >>  process_one_work kernel/workqueue.c:3239 [inline]
> >>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
> >>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
> >>  kthread+0x70e/0x8a0 kernel/kthread.c:463
> >>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >>  </TASK>
> >> 
> >> Allocated by task 7622:
> >>  kasan_save_stack mm/kasan/common.c:47 [inline]
> >>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
> >>  kasan_kmalloc include/linux/kasan.h:260 [inline]
> >>  __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4396
> >>  kmalloc_noprof include/linux/slab.h:905 [inline]
> >>  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >>  __bch2_dev_alloc+0xa7/0xc30 fs/bcachefs/super.c:1487
> >>  bch2_dev_alloc+0xcd/0x180 fs/bcachefs/super.c:1558
> >>  bch2_fs_alloc fs/bcachefs/super.c:1068 [inline]
> >>  bch2_fs_open+0x256f/0x2760 fs/bcachefs/super.c:2395
> >>  bch2_fs_get_tree+0x44f/0x1540 fs/bcachefs/fs.c:2440
> >>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
> >>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
> >>  do_mount fs/namespace.c:4133 [inline]
> >>  __do_sys_mount fs/namespace.c:4344 [inline]
> >>  __se_sys_mount+0x317/0x410 fs/namespace.c:4321
> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> 
> >> Freed by task 7622:
> >>  kasan_save_stack mm/kasan/common.c:47 [inline]
> >>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
> >>  poison_slab_object mm/kasan/common.c:247 [inline]
> >>  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
> >>  kasan_slab_free include/linux/kasan.h:233 [inline]
> >>  slab_free_hook mm/slub.c:2417 [inline]
> >>  slab_free mm/slub.c:4680 [inline]
> >>  kfree+0x18e/0x440 mm/slub.c:4879
> >>  kobject_cleanup lib/kobject.c:689 [inline]
> >>  kobject_release lib/kobject.c:720 [inline]
> >>  kref_put include/linux/kref.h:65 [inline]
> >>  kobject_put+0x22b/0x480 lib/kobject.c:737
> >>  bch2_fs_free+0x4b3/0x5c0 fs/bcachefs/super.c:749
> >>  bch2_fs_get_tree+0xb76/0x1540 fs/bcachefs/fs.c:2572
> >>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
> >>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
> >>  do_mount fs/namespace.c:4133 [inline]
> >>  __do_sys_mount fs/namespace.c:4344 [inline]
> >>  __se_sys_mount+0x317/0x410 fs/namespace.c:4321
> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> 
> >> Last potentially related work creation:
> >>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
> >>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
> >>  insert_work+0x3d/0x330 kernel/workqueue.c:2187
> >>  __queue_work+0xcd2/0xfb0 kernel/workqueue.c:2342
> >>  queue_work_on+0x181/0x270 kernel/workqueue.c:2393
> >>  bch2_btree_node_read_done+0x159b/0x5560 fs/bcachefs/btree_io.c:1156
> >>  btree_node_read_work+0x4ee/0xfa0 fs/bcachefs/btree_io.c:1444
> >>  bch2_btree_node_read+0x83e/0x2aa0 fs/bcachefs/btree_io.c:1865
> >>  __bch2_btree_root_read fs/bcachefs/btree_io.c:1906 [inline]
> >>  bch2_btree_root_read+0x5e5/0x780 fs/bcachefs/btree_io.c:1928
> >>  read_btree_roots+0x2b7/0x850 fs/bcachefs/recovery.c:602
> >>  bch2_fs_recovery+0x2513/0x38a0 fs/bcachefs/recovery.c:985
> >>  bch2_fs_start+0xa0f/0xcc0 fs/bcachefs/super.c:1216
> >>  bch2_fs_get_tree+0xb39/0x1540 fs/bcachefs/fs.c:2456
> >>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
> >>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
> >>  do_mount fs/namespace.c:4133 [inline]
> >>  __do_sys_mount fs/namespace.c:4344 [inline]
> >>  __se_sys_mount+0x317/0x410 fs/namespace.c:4321
> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> 
> >> The buggy address belongs to the object at ffff888029ae2000
> >>  which belongs to the cache kmalloc-4k of size 4096
> >> The buggy address is located 64 bytes inside of
> >>  freed 4096-byte region [ffff888029ae2000, ffff888029ae3000)
> >> 
> >> The buggy address belongs to the physical page:
> >> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29ae0
> >> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> >> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> >> page_type: f5(slab)
> >> raw: 00fff00000000040 ffff88801a442140 dead000000000122 0000000000000000
> >> raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
> >> head: 00fff00000000040 ffff88801a442140 dead000000000122 0000000000000000
> >> head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
> >> head: 00fff00000000003 ffffea0000a6b801 00000000ffffffff 00000000ffffffff
> >> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> >> page dumped because: kasan: bad access detected
> >> page_owner tracks the page as allocated
> >> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 59, tgid 59 (kworker/u8:4), ts 293379161383, free_ts 284295390486
> >>  set_page_owner include/linux/page_owner.h:32 [inline]
> >>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
> >>  prep_new_page mm/page_alloc.c:1859 [inline]
> >>  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
> >>  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
> >>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
> >>  alloc_slab_page mm/slub.c:2487 [inline]
> >>  allocate_slab+0x8a/0x370 mm/slub.c:2655
> >>  new_slab mm/slub.c:2709 [inline]
> >>  ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
> >>  __slab_alloc mm/slub.c:3981 [inline]
> >>  __slab_alloc_node mm/slub.c:4056 [inline]
> >>  slab_alloc_node mm/slub.c:4217 [inline]
> >>  __do_kmalloc_node mm/slub.c:4364 [inline]
> >>  __kmalloc_node_track_caller_noprof+0x2f8/0x4e0 mm/slub.c:4384
> >>  kmalloc_reserve+0x136/0x290 net/core/skbuff.c:600
> >>  __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
> >>  alloc_skb include/linux/skbuff.h:1336 [inline]
> >>  nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:761 [inline]
> >>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:818 [inline]
> >>  nsim_dev_trap_report_work+0x29a/0xb80 drivers/net/netdevsim/dev.c:864
> >>  process_one_work kernel/workqueue.c:3239 [inline]
> >>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
> >>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
> >>  kthread+0x70e/0x8a0 kernel/kthread.c:463
> >>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >> page last free pid 7530 tgid 7530 stack trace:
> >>  reset_page_owner include/linux/page_owner.h:25 [inline]
> >>  free_pages_prepare mm/page_alloc.c:1395 [inline]
> >>  __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
> >>  discard_slab mm/slub.c:2753 [inline]
> >>  __put_partials+0x156/0x1a0 mm/slub.c:3218
> >>  put_cpu_partial+0x17c/0x250 mm/slub.c:3293
> >>  __slab_free+0x2d5/0x3c0 mm/slub.c:4550
> >>  qlink_free mm/kasan/quarantine.c:163 [inline]
> >>  qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
> >>  kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
> >>  __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
> >>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >>  slab_post_alloc_hook mm/slub.c:4180 [inline]
> >>  slab_alloc_node mm/slub.c:4229 [inline]
> >>  __do_kmalloc_node mm/slub.c:4364 [inline]
> >>  __kmalloc_node_track_caller_noprof+0x216/0x4e0 mm/slub.c:4384
> >>  __do_krealloc mm/slub.c:4942 [inline]
> >>  krealloc_noprof+0x124/0x340 mm/slub.c:4995
> >>  bch2_printbuf_make_room+0x1f5/0x360 fs/bcachefs/printbuf.c:59
> >>  bch2_prt_printf+0x282/0x740 fs/bcachefs/printbuf.c:186
> >>  bch2_btree_path_to_text_short+0x148/0xde0 fs/bcachefs/btree_iter.c:1516
> >>  __bch2_trans_paths_to_text+0xe5/0x190 fs/bcachefs/btree_iter.c:1589
> >>  bch2_trans_update_max_paths+0x15f/0x390 fs/bcachefs/btree_iter.c:1625
> >>  btree_path_alloc+0x89a/0xa70 fs/bcachefs/btree_iter.c:1718
> >>  bch2_path_get+0x8bd/0x1540 fs/bcachefs/btree_iter.c:1774
> >> 
> >> Memory state around the buggy address:
> >>  ffff888029ae1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>  ffff888029ae1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >> >ffff888029ae2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>                                            ^
> >>  ffff888029ae2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>  ffff888029ae2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> ==================================================================
> >> 
> >> 
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >> 
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >> 
> >> If the report is already addressed, let syzbot know by replying with:
> >> #syz fix: exact-commit-title
> >> 
> >> If you want syzbot to run the reproducer, reply with:
> >> #syz test: git://repo/address.git branch-or-commit-hash
> >> If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > #syz test:
> 
> want either no args or 2 args (repo, branch), got 7

#syz test: git://evilpiepirate.org/bcachefs.git bcachefs-testing

