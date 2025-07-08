Return-Path: <linux-kernel+bounces-721545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F1AFCAA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B9B7B4132
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FF2D9EDA;
	Tue,  8 Jul 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="MJpHElEC"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4422C08AF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978539; cv=none; b=MJ1Diu2wwxu222wRua7SbDoCHk5e1n/UTXxjXZOp7LsEbR/zOiJ+TliON0kWecB18t3gkpDqC2q7oHuHibc2poaun9QmPghJPlWAAodUlD5reF7mXi1eYcJEgk8gTSli7LQCSD1arsVuAQRPFcG6Nd0jun5vE+DruDf0VKCRghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978539; c=relaxed/simple;
	bh=XwwTrK8ElzeWy5cLaY35qNj7Od/dHrKlTxdO7un4THU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIoP0KKPKr20Lny8GEvuaz+mmEQzXcW7w49cvoVXTSxZ3jOOVTJGj3Ti7Q/bV8rlcx1LFbbimsnnBQUNky419bNxZLskk5RUpqQI+5w+iHRYXQaxDucUsu7Yw8L0F50XnYA4akQ7/fLQwJ3z/1SXYAGB8vGgYEDVeNjqo6PbedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=MJpHElEC; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751978534;
	bh=B6oPDzXRDaodBgxTFcDqmw/n3BM7fr1AGqbXoDoa4pI=;
	h=From:Subject:Date:Message-ID;
	b=MJpHElECQ0hvd+b8MlwY4Wk+PGLh86O8jr/JeMhtHt1JftGydVn3lvcUylWZXcbPw
	 dF06EQZBac9Nk+b+5wwnLTl/+S5cHM/lJkA9+i7t09wAotmUIwHmn/VmF1N8JNctEi
	 M/JB78yPjvRKvTP4+wTIxlI5c5IVyDRXk5YgzhxY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686D11FE000063A9; Tue, 8 Jul 2025 20:41:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6580446685194
X-SMAIL-UIID: DE2FADE2B98345E8A58AD1E76D04DAE6-20250708-204135-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9f0d09a59e1e92ee7b43@syzkaller.appspotmail.com>
Cc: david@redhat.com,
	gfs2@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2] KASAN: slab-use-after-free Read in move_to_new_folio (4)
Date: Tue,  8 Jul 2025 20:41:22 +0800
Message-ID: <20250708124124.2980-1-hdanton@sina.com>
In-Reply-To: <686cfef4.050a0220.1ffab7.0005.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 04:20:20 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15daabd4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
> dashboard link: https://syzkaller.appspot.com/bug?extid=9f0d09a59e1e92ee7b43
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156df28c580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d7b8f8e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/88e0e9607487/vmlinux-d7b8f8e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c0e31868d902/bzImage-d7b8f8e2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c8cd0473f7ee/mount_7.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=111d4a8c580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9f0d09a59e1e92ee7b43@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> BUG: KASAN: slab-use-after-free in mapping_inaccessible include/linux/pagemap.h:336 [inline]
> BUG: KASAN: slab-use-after-free in move_to_new_folio+0x182/0x7a0 mm/migrate.c:983
> Read of size 8 at addr ffff8880429ac910 by task kcompactd1/30
> 
> CPU: 0 UID: 0 PID: 30 Comm: kcompactd1 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xd2/0x2b0 mm/kasan/report.c:521
>  kasan_report+0x118/0x150 mm/kasan/report.c:634
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>  mapping_inaccessible include/linux/pagemap.h:336 [inline]

Given truncate_inode_pages_final() [1] in gfs2_evict_inode(), it is
difficult to understand this mapping uaf. 

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/gfs2/super.c?id=d7b8f8e20813#n1441

>  move_to_new_folio+0x182/0x7a0 mm/migrate.c:983
>  migrate_folio_move mm/migrate.c:1301 [inline]
>  migrate_folios_move mm/migrate.c:1653 [inline]
>  migrate_pages_batch+0x1c34/0x2830 mm/migrate.c:1900
>  migrate_pages_sync mm/migrate.c:1930 [inline]
>  migrate_pages+0x1bcc/0x2930 mm/migrate.c:2039
>  compact_zone+0x23f4/0x4ad0 mm/compaction.c:2683
>  compact_node+0x1d2/0x280 mm/compaction.c:2952
>  kcompactd+0xbc8/0x1290 mm/compaction.c:3250
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Allocated by task 5644:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4148 [inline]
>  slab_alloc_node mm/slub.c:4197 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
>  gfs2_glock_get+0x263/0xec0 fs/gfs2/glock.c:1183
>  gfs2_inode_lookup+0x215/0xb10 fs/gfs2/inode.c:135
>  gfs2_dir_search+0x168/0x220 fs/gfs2/dir.c:1667
>  gfs2_lookupi+0x3d9/0x5a0 fs/gfs2/inode.c:340
>  gfs2_jindex_hold fs/gfs2/ops_fstype.c:574 [inline]
>  init_journal+0x54a/0x2260 fs/gfs2/ops_fstype.c:716
>  init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
>  gfs2_fill_super+0x1939/0x20e0 fs/gfs2/ops_fstype.c:1253
>  get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
>  gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1804
>  do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>  do_mount fs/namespace.c:4239 [inline]
>  __do_sys_mount fs/namespace.c:4450 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 15:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2381 [inline]
>  slab_free mm/slub.c:4643 [inline]
>  kmem_cache_free+0x18f/0x400 mm/slub.c:4745
>  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
>  rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2832
>  handle_softirqs+0x286/0x870 kernel/softirq.c:579
>  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
>  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> Last potentially related work creation:
>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
>  __call_rcu_common kernel/rcu/tree.c:3094 [inline]
>  call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3214
>  __gfs2_glock_free+0xb44/0xc90 fs/gfs2/glock.c:172
>  gfs2_glock_free+0x3c/0xa0 fs/gfs2/glock.c:178
>  gfs2_glock_put_eventually fs/gfs2/super.c:1185 [inline]
>  gfs2_evict_inode+0xae7/0x1000 fs/gfs2/super.c:1460
>  evict+0x501/0x9c0 fs/inode.c:810
>  gfs2_jindex_free+0x39c/0x440 fs/gfs2/super.c:79
>  init_journal+0x8f1/0x2260 fs/gfs2/ops_fstype.c:833
>  init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
>  gfs2_fill_super+0x1939/0x20e0 fs/gfs2/ops_fstype.c:1253
>  get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
>  gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1804
>  do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>  do_mount fs/namespace.c:4239 [inline]
>  __do_sys_mount fs/namespace.c:4450 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Second to last potentially related work creation:
>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
>  insert_work+0x3d/0x330 kernel/workqueue.c:2183
>  __queue_work+0xcfc/0xfe0 kernel/workqueue.c:2341
>  queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2561
>  queue_delayed_work include/linux/workqueue.h:677 [inline]
>  gfs2_glock_queue_work fs/gfs2/glock.c:250 [inline]
>  do_xmote+0xce0/0x1220 fs/gfs2/glock.c:839
>  glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1096
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> The buggy address belongs to the object at ffff8880429ac548
>  which belongs to the cache gfs2_glock(aspace) of size 1224
> The buggy address is located 968 bytes inside of
>  freed 1224-byte region [ffff8880429ac548, ffff8880429aca10)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880429acfd8 pfn:0x429ac
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 04fff00000000040 ffff8880327f2640 ffffea000110bf00 0000000000000002
> raw: ffff8880429acfd8 00000000000c0008 00000000f5000000 0000000000000000
> head: 04fff00000000040 ffff8880327f2640 ffffea000110bf00 0000000000000002
> head: ffff8880429acfd8 00000000000c0008 00000000f5000000 0000000000000000
> head: 04fff00000000002 ffffea00010a6b01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5547, tgid 5547 (syz.0.16), ts 128645082054, free_ts 128606732548
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
>  prep_new_page mm/page_alloc.c:1712 [inline]
>  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
>  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
>  alloc_slab_page mm/slub.c:2451 [inline]
>  allocate_slab+0x8a/0x3b0 mm/slub.c:2619
>  new_slab mm/slub.c:2673 [inline]
>  ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
>  __slab_alloc mm/slub.c:3949 [inline]
>  __slab_alloc_node mm/slub.c:4024 [inline]
>  slab_alloc_node mm/slub.c:4185 [inline]
>  kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4204
>  gfs2_glock_get+0x263/0xec0 fs/gfs2/glock.c:1183
>  gfs2_inode_lookup+0x215/0xb10 fs/gfs2/inode.c:135
>  gfs2_lookup_root fs/gfs2/ops_fstype.c:425 [inline]
>  init_sb+0xa30/0x12c0 fs/gfs2/ops_fstype.c:494
>  gfs2_fill_super+0x1605/0x20e0 fs/gfs2/ops_fstype.c:1220
>  get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
>  gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1804
>  do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>  do_mount fs/namespace.c:4239 [inline]
>  __do_sys_mount fs/namespace.c:4450 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4427
> page last free pid 5547 tgid 5547 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1248 [inline]
>  __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
>  stack_depot_save_flags+0x445/0x900 lib/stackdepot.c:678
>  kasan_save_stack mm/kasan/common.c:48 [inline]
>  kasan_save_track+0x4f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4148 [inline]
>  slab_alloc_node mm/slub.c:4197 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
>  __kernfs_new_node+0xd7/0x7e0 fs/kernfs/dir.c:637
>  kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:713
>  kernfs_create_dir_ns+0x44/0x130 fs/kernfs/dir.c:1083
>  sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
>  create_dir lib/kobject.c:73 [inline]
>  kobject_add_internal+0x59f/0xb40 lib/kobject.c:240
>  kobject_add_varg lib/kobject.c:374 [inline]
>  kobject_init_and_add+0x125/0x190 lib/kobject.c:457
>  gfs2_sys_fs_add+0x234/0x450 fs/gfs2/sys.c:737
>  gfs2_fill_super+0x13d6/0x20e0 fs/gfs2/ops_fstype.c:1206
>  get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
>  gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1804
> 
> Memory state around the buggy address:
>  ffff8880429ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880429ac880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8880429ac900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff8880429ac980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880429aca00: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

