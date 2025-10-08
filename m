Return-Path: <linux-kernel+bounces-845250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD6BC4273
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA723A4ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B52F3C39;
	Wed,  8 Oct 2025 09:26:32 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76631339A4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915591; cv=none; b=c67rRHGd7m698OWtTbYpB9Pok/gXwWtVqSbGUrQheozNV8XUNfUq02byycVDJb624kPdX179ZDgk0CGsj0dBYsaO3LL/x4C2cPdES1SF0AM3xmqXcOrPbxKNjSM8OGrtQxqpcTtAFtcnj7wZPjixUASiRwVemRbHWHsq/rPoCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915591; c=relaxed/simple;
	bh=nz+c2kuYVkZRgwjpNRQsNqPyMGHbpWRfVruXeIH560M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KXsnYQasuZOarpJlLUS1AzGa3UD2x4DgxFNOWxYWGb6QT7jVKJZgf2jKcCFyixu3T9bM+ZciGPyq7CsGX1YbMZcBIX6lMMVV/6LnZuMlVkZyD5hq5bCmbgN3QkMtQMMnSUuANogfT4Y7ol0gRgrvx1SHvef7G+HXTH0ntpmkBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-90c806bc886so835227939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759915589; x=1760520389;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaQ+SRrsY49kLdOhOtgjkzyTAmPbZ04Ra1Jw9sz5kaY=;
        b=CLgLBLH3w62SUNFEuSZAz2Tg9I0KzsfF4+z6trsln0JhDuEYLKo9JiiwlE7ir7muAC
         7CwDZSadry4Qi/c6Kj05ObgviuCeR8uAElBqo3+WekVXZsPiWTlpIyH76+1Xg1EzVlLq
         6av8+ldj4XMZQEG1SQ+cCHjRNVXG9K8YSz3xdbc3vNRCxuqK8j19mRxSqOtuDaXkQS7M
         WBZt/OJ4rnkteZCMY/cWIMF3MjvDfKJJBIsZG5Kjt9es92f85eHK+3e0QdliaoBeQObI
         d2galb3ZqyvDxR9rgewj8lp0c3QbzCqvg7oppZOWWpRzD6flVmcdyLZpXKlBRvs5MsRj
         qlwA==
X-Forwarded-Encrypted: i=1; AJvYcCUrFChV99cU0K+bii8Dy17jxFoSLmcArxveDIS27An1k/HB/jNCxKL9riJAMPeTl/WjbO+O51KdWsKDnGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hguAUs9/epdO33gnfVX6apl02xyB/PSRf75vX0yw2JPJWHr8
	StlF3LSu/58FmBU/NxCetO6ejBe32NqR2hEFeaCA6TBJXOJw+xRrxF17Np5dZMDo/UooxX0pZlx
	0vRABUgJ+/HMXJBRdsOHvE9KeQPKH1wEitspov0hklYVFq8/cjvAjZIXaHxg=
X-Google-Smtp-Source: AGHT+IFRv5HL3iPejAiIX0WRu0p0iNt8SvzRl/BAc8kFIrO4gkfSoHTN0swBnlYaicAEfuPe81R30BJR7nEiw63q0rfpM7REmPc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b89:b0:90a:ce21:ae1e with SMTP id
 ca18e2360f4ac-93bd18f2a3bmr267343339f.5.1759915588821; Wed, 08 Oct 2025
 02:26:28 -0700 (PDT)
Date: Wed, 08 Oct 2025 02:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e62e44.050a0220.256323.0037.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_node_dentry
From: syzbot <syzbot+83216a2fa490a1ab9f48@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    47a8d4b89844 Add linux-next specific files for 20251003
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157d5334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cc2d3410fac6d84
dashboard link: https://syzkaller.appspot.com/bug?extid=83216a2fa490a1ab9f48
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05c7c78e80df/disk-47a8d4b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ce88580b6ed/vmlinux-47a8d4b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61b82985f2f8/bzImage-47a8d4b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83216a2fa490a1ab9f48@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.6.1473/17520 is trying to acquire lock:
ffffffff8e245220 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8e245220 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4898 [inline]
ffffffff8e245220 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:5222 [inline]
ffffffff8e245220 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:5603 [inline]
ffffffff8e245220 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node_track_caller_noprof+0x9e/0x800 mm/slub.c:5713

but task is already holding lock:
ffff888140450988 (&root->kernfs_rwsem){++++}-{4:4}, at: class_rwsem_read_constructor include/linux/rwsem.h:253 [inline]
ffff888140450988 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_node_dentry+0x32c/0x620 fs/kernfs/mount.c:261

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (&root->kernfs_rwsem){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1093
       internal_create_group+0x419/0x1110 fs/sysfs/group.c:170
       cpuhp_invoke_callback+0x445/0x860 kernel/cpu.c:195
       cpuhp_issue_call+0x430/0x7a0 kernel/cpu.c:-1
       __cpuhp_setup_state_cpuslocked+0x3df/0x6c0 kernel/cpu.c:2511
       __cpuhp_setup_state+0x3f/0x60 kernel/cpu.c:2540
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #8 (cpuhp_state_mutex){+.+.}-{4:4}:

-> #7 (cpu_hotplug_lock){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:491
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       udp_tunnel_encap_enable include/net/udp_tunnel.h:203 [inline]
       setup_udp_tunnel_sock+0x34f/0x550 net/ipv4/udp_tunnel_core.c:92
       l2tp_tunnel_register+0xcb6/0x1320 net/l2tp/l2tp_core.c:1679
       pppol2tp_tunnel_get net/l2tp/l2tp_ppp.c:662 [inline]
       pppol2tp_connect+0x87c/0x1750 net/l2tp/l2tp_ppp.c:710
       __sys_connect_file net/socket.c:2102 [inline]
       __sys_connect+0x316/0x440 net/socket.c:2121
       __do_sys_connect net/socket.c:2127 [inline]
       __se_sys_connect net/socket.c:2124 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2124
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1424 [inline]
       nbd_config_put+0x342/0x790 drivers/block/nbd.c:1448
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1753
       bdev_release+0x536/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:702
       __fput+0x44c/0xa70 fs/file_table.c:468
       task_work_run+0x1d4/0x260 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
       do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1439
       elevator_switch+0x12b/0x640 block/elevator.c:588
       elevator_change+0x315/0x4c0 block/elevator.c:691
       elevator_set_default+0x186/0x260 block/elevator.c:767
       blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:942
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfc/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1981
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       elevator_change+0x1e5/0x4c0 block/elevator.c:689
       elevator_set_none+0x42/0xb0 block/elevator.c:782
       blk_mq_elv_switch_none block/blk-mq.c:5032 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5075 [inline]
       blk_mq_update_nr_hw_queues+0x598/0x1ab0 block/blk-mq.c:5133
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1486
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2236
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:742
       ____sys_sendmsg+0x505/0x830 net/socket.c:2630
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
       __sys_sendmsg net/socket.c:2716 [inline]
       __do_sys_sendmsg net/socket.c:2721 [inline]
       __se_sys_sendmsg net/socket.c:2719 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4399 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4446
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1951
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4898 [inline]
       slab_alloc_node mm/slub.c:5222 [inline]
       __do_kmalloc_node mm/slub.c:5603 [inline]
       __kmalloc_node_track_caller_noprof+0x9e/0x800 mm/slub.c:5713
       __kmemdup_nul mm/util.c:64 [inline]
       kstrdup+0x42/0x100 mm/util.c:84
       kernfs_node_dentry+0x444/0x620 fs/kernfs/mount.c:267
       cgroup_do_get_tree+0x24e/0x340 kernel/cgroup/cgroup.c:2289
       cgroup_get_tree+0x9a/0x1b0 kernel/cgroup/cgroup.c:2328
       vfs_get_tree+0x92/0x2b0 fs/super.c:1751
       vfs_cmd_create+0xa2/0x200 fs/fsopen.c:231
       __do_sys_fsconfig fs/fsopen.c:473 [inline]
       __se_sys_fsconfig+0x78e/0x8d0 fs/fsopen.c:350
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpuhp_state_mutex --> &root->kernfs_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&root->kernfs_rwsem);
                               lock(cpuhp_state_mutex);
                               lock(&root->kernfs_rwsem);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz.6.1473/17520:
 #0: ffff88807dfd6470 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig fs/fsopen.c:471 [inline]
 #0: ffff88807dfd6470 (&fc->uapi_mutex){+.+.}-{4:4}, at: __se_sys_fsconfig+0x758/0x8d0 fs/fsopen.c:350
 #1: ffff8880327c20e0 (&type->s_umount_key#58){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #1: ffff8880327c20e0 (&type->s_umount_key#58){+.+.}-{4:4}, at: super_lock+0x25c/0x3b0 fs/super.c:121
 #2: ffff888140450988 (&root->kernfs_rwsem){++++}-{4:4}, at: class_rwsem_read_constructor include/linux/rwsem.h:253 [inline]
 #2: ffff888140450988 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_node_dentry+0x32c/0x620 fs/kernfs/mount.c:261

stack backtrace:
CPU: 0 UID: 0 PID: 17520 Comm: syz.6.1473 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
 fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4898 [inline]
 slab_alloc_node mm/slub.c:5222 [inline]
 __do_kmalloc_node mm/slub.c:5603 [inline]
 __kmalloc_node_track_caller_noprof+0x9e/0x800 mm/slub.c:5713
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 kernfs_node_dentry+0x444/0x620 fs/kernfs/mount.c:267
 cgroup_do_get_tree+0x24e/0x340 kernel/cgroup/cgroup.c:2289
 cgroup_get_tree+0x9a/0x1b0 kernel/cgroup/cgroup.c:2328
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 vfs_cmd_create+0xa2/0x200 fs/fsopen.c:231
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0x78e/0x8d0 fs/fsopen.c:350
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f83f8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f84dc0038 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f4f841e5fa0 RCX: 00007f4f83f8eec9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f4f84011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4f841e6038 R14: 00007f4f841e5fa0 R15: 00007ffe96681dd8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

