Return-Path: <linux-kernel+bounces-887709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADCC38ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DD694EF9D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F721C9F4;
	Thu,  6 Nov 2025 02:54:30 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCC17C21E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397669; cv=none; b=NTTY5/6ozqRy6Gjs9JEuoDJYRom+JoIfNqkRDWoy5hkTT4AxWfYIQs/cPsUrhAlYrvpb8RojMUhDJs1XFkiAWjei7wJ0unNtPEXW4J9mHG8SaGeQUMZ4dIxHLMDWseTpEP7yLXotitAzJudMsRvpg2nf7gTaZ+VU+gSSeFpt3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397669; c=relaxed/simple;
	bh=qrGEkGra5j98bJMzjQzAJXtPpE30oBhsxO10OksrtLI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pp6y4DYXmW0wiucprNJ5SqYBcEvOZuY0nXuuyW1/hKR1xNX29GG+7I5elXBMCSsIiWKVjoay5/7Qm/VZ4+zMKVKSQN5/DvYg4NSmZLgR7udCqet+5E+3mR36/9kzc6HhKBhz0GPfnYgkBzAwm2DXdSNVg4JdRI4QtoeSt2ST+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9487727ded6so35009639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397667; x=1763002467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vG4bs2DC+NoYMtYykNrQy07iMBFVQIXSddGX1ni3cUI=;
        b=GKH9fEJjasoexUAZ8qQn1SiC2pHXeQ3Y+1+duS43jonEG866Jdbp86ovrR92lqKg6H
         QeyZ0PcopvxSCO7YBufFNsgKN0+qV+u0XWGg2KfL41LdJXt62toH4d+fHiypHJhI1RgV
         oDx10EvRXBpW4roQVw71TvETrTtWZ2PfoKZz5hw7sHptTNOgHDkjOT+WPgkJR5IZ2H8V
         bK+H0BGioZ4sDClA0Pxg9dgcM8bBg8djsYogiaYYE70AdmhZfxKO06J6+0hvuc81SVlp
         Z/nAWgboJQnlSF7L6ULzKi/l8HmExG5dItVM/H2cK5pfCd9xwYvMZh3enBXUTy1RKggh
         USlA==
X-Forwarded-Encrypted: i=1; AJvYcCVWMkCl+g3XOKlmqXxaD+60E7f2x8jEVAArbwv+MrQBCVN/V+vYday4SOp/wlaeFUt6Bcv+QSiRSNABCj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjjb2ANwFPjvJ7WXElcA4uGElA4ciHVRr341rtAzDg9KUP16EB
	7nyZ2eKGbiXgFvHhAucq6vYnaeYouA5RVxR9GLNk+w4Is7B9KEvkUk7zdIkUIrjBHrxjg6wPzRJ
	nm3Pe1jvXtcEz9IJk6Pf1dd1/hY9YWYQ1Tv8wKSTwrglV74naOfYoB0+wPmE=
X-Google-Smtp-Source: AGHT+IGtdTIA91zAJQ2TgCzlEercS4ulNz5M6y7JUUqIYKcEEVMYc+eHfgNEBULHqM0jmaeFUyK+mfEifBK1G6ztgAdy+N0O1aUW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f84:b0:948:63ba:6a5 with SMTP id
 ca18e2360f4ac-94869cbfb33mr1048547639f.3.1762397666672; Wed, 05 Nov 2025
 18:54:26 -0800 (PST)
Date: Wed, 05 Nov 2025 18:54:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c0de2.050a0220.2e3c35.0014.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_unlink_sibling (2)
From: syzbot <syzbot+a0ec0dbf8642550c291a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    691d401c7e0e Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1120017c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=a0ec0dbf8642550c291a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5eaccda03e4f/disk-691d401c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0df5294a69bc/vmlinux-691d401c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4f242731772/bzImage-691d401c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0ec0dbf8642550c291a@syzkaller.appspotmail.com

zswap: compressor  not available
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.1930/13313 is trying to acquire lock:
ffff888140450220 (&root->kernfs_iattr_rwsem){++++}-{4:4}, at: kernfs_unlink_sibling+0xa3/0x320 fs/kernfs/dir.c:424

but task is already holding lock:
ffff888140450188 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x3d/0x110 fs/kernfs/dir.c:1712

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #11 (&root->kernfs_rwsem){++++}-{4:4}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x38/0x840 fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xfc/0x1a0 fs/kernfs/dir.c:1093
       internal_create_group+0x34d/0xf30 fs/sysfs/group.c:170
       cpuhp_invoke_callback+0x3d5/0xa10 kernel/cpu.c:195
       cpuhp_issue_call+0x1c0/0x980 kernel/cpu.c:2365
       __cpuhp_setup_state_cpuslocked+0x3a1/0x7b0 kernel/cpu.c:2511
       __cpuhp_setup_state+0xf4/0x300 kernel/cpu.c:2540
       do_one_initcall+0x123/0x6e0 init/main.c:1283
       do_initcall_level init/main.c:1345 [inline]
       do_initcalls init/main.c:1361 [inline]
       do_basic_setup init/main.c:1380 [inline]
       kernel_init_freeable+0x5c8/0x920 init/main.c:1593
       kernel_init+0x1c/0x2b0 init/main.c:1483
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #10 (cpuhp_state_mutex){+.+.}-{4:4}:

-> #9 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:491
       static_key_enable+0x12/0x20 kernel/jump_label.c:222
       tcp_enable_tx_delay net/ipv4/tcp.c:3592 [inline]
       do_tcp_setsockopt+0x1ce9/0x2500 net/ipv4/tcp.c:4123
       tcp_setsockopt+0xe2/0x100 net/ipv4/tcp.c:4144
       smc_setsockopt+0x1b6/0xa00 net/smc/af_smc.c:3097
       do_sock_setsockopt+0xf3/0x1d0 net/socket.c:2360
       __sys_setsockopt+0x120/0x1a0 net/socket.c:2385
       __do_sys_setsockopt net/socket.c:2391 [inline]
       __se_sys_setsockopt net/socket.c:2388 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2388
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #8 (k-sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       __inet_bind+0x893/0xc50 net/ipv4/af_inet.c:524
       inet_bind_sk net/ipv4/af_inet.c:464 [inline]
       inet_bind_sk+0xb8/0xf0 net/ipv4/af_inet.c:444
       mptcp_bind+0x18e/0x1e0 net/mptcp/protocol.c:3872
       __sys_bind_socket net/socket.c:1874 [inline]
       __sys_bind_socket net/socket.c:1866 [inline]
       __sys_bind+0x1a7/0x260 net/socket.c:1905
       __do_sys_bind net/socket.c:1910 [inline]
       __se_sys_bind net/socket.c:1908 [inline]
       __x64_sys_bind+0x72/0xb0 net/socket.c:1908
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x67/0x440 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:319
       recv_work+0x671/0xa80 drivers/block/nbd.c:1024
       process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
       process_scheduled_works kernel/workqueue.c:3346 [inline]
       worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
       kthread+0x3c5/0x780 kernel/kthread.c:463
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1146 [inline]
       nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1210
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
       blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       blk_finish_plug block/blk-core.c:1249 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
       submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2444
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x723/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:701
       do_dentry_open+0x982/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1202
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
       blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       blk_finish_plug block/blk-core.c:1249 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
       submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2444
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x723/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:701
       do_dentry_open+0x982/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1439
       blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
       blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
       elevator_switch+0x17d/0x810 block/elevator.c:588
       elevator_change+0x391/0x5d0 block/elevator.c:691
       elevator_set_default+0x2e9/0x380 block/elevator.c:767
       blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:942
       __add_disk+0x74a/0xf00 block/genhd.c:528
       add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1987
       nbd_init+0x1a2/0x3c0 drivers/block/nbd.c:2702
       do_one_initcall+0x123/0x6e0 init/main.c:1283
       do_initcall_level init/main.c:1345 [inline]
       do_initcalls init/main.c:1361 [inline]
       do_basic_setup init/main.c:1380 [inline]
       kernel_init_freeable+0x5c8/0x920 init/main.c:1593
       kernel_init+0x1c/0x2b0 init/main.c:1483
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       elevator_change+0x17d/0x5d0 block/elevator.c:689
       elv_iosched_store+0x315/0x3c0 block/elevator.c:824
       queue_attr_store+0x26b/0x310 block/blk-sysfs.c:869
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d3/0x11d0 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#62){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4399
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4446
       nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1957
       nbd_init+0x1a2/0x3c0 drivers/block/nbd.c:2702
       do_one_initcall+0x123/0x6e0 init/main.c:1283
       do_initcall_level init/main.c:1345 [inline]
       do_initcalls init/main.c:1361 [inline]
       do_basic_setup init/main.c:1380 [inline]
       kernel_init_freeable+0x5c8/0x920 init/main.c:1593
       kernel_init+0x1c/0x2b0 init/main.c:1483
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4921 [inline]
       slab_alloc_node mm/slub.c:5256 [inline]
       kmem_cache_alloc_noprof+0x5b/0x6e0 mm/slub.c:5287
       __kernfs_iattrs+0x124/0x3e0 fs/kernfs/inode.c:36
       kernfs_iattrs fs/kernfs/inode.c:61 [inline]
       __kernfs_setattr+0x4d/0x3c0 fs/kernfs/inode.c:74
       kernfs_iop_setattr+0xda/0x120 fs/kernfs/inode.c:128
       notify_change+0x6d2/0x12a0 fs/attr.c:546
       do_truncate+0x1d7/0x230 fs/open.c:68
       handle_truncate fs/namei.c:3596 [inline]
       do_open fs/namei.c:3979 [inline]
       path_openat+0x2678/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_iattr_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       down_write+0x92/0x200 kernel/locking/rwsem.c:1590
       kernfs_unlink_sibling+0xa3/0x320 fs/kernfs/dir.c:424
       __kernfs_remove+0x2c0/0x8a0 fs/kernfs/dir.c:1514
       kernfs_remove_by_name_ns+0x68/0x110 fs/kernfs/dir.c:1717
       kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
       sysfs_unmerge_group+0xe7/0x170 fs/sysfs/group.c:402
       rpm_sysfs_remove drivers/base/power/sysfs.c:823 [inline]
       dpm_sysfs_remove+0x7f/0xb0 drivers/base/power/sysfs.c:832
       device_del+0x1a0/0x9f0 drivers/base/core.c:3853
       device_unregister+0x1d/0xc0 drivers/base/core.c:3919
       usb_remove_ep_devs+0x42/0x80 drivers/usb/core/endpoint.c:189
       remove_intf_ep_devs drivers/usb/core/message.c:1266 [inline]
       usb_disable_device+0x309/0x7d0 drivers/usb/core/message.c:1417
       usb_set_configuration+0x12cd/0x1e20 drivers/usb/core/message.c:2066
       bConfigurationValue_store+0x100/0x180 drivers/usb/core/sysfs.c:105
       dev_attr_store+0x58/0x80 drivers/base/core.c:2437
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d3/0x11d0 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &root->kernfs_iattr_rwsem --> cpuhp_state_mutex --> &root->kernfs_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&root->kernfs_rwsem);
                               lock(cpuhp_state_mutex);
                               lock(&root->kernfs_rwsem);
  lock(&root->kernfs_iattr_rwsem);

 *** DEADLOCK ***

5 locks held by syz.0.1930/13313:
 #0: ffff888025596d38 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1232
 #1: ffff888030458420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #2: ffff888052eae088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #3: ffff888028a8e198 (&dev->mutex){....}-{4:4}, at: device_lock_interruptible include/linux/device.h:919 [inline]
 #3: ffff888028a8e198 (&dev->mutex){....}-{4:4}, at: bConfigurationValue_store+0xde/0x180 drivers/usb/core/sysfs.c:102
 #4: ffff888140450188 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x3d/0x110 fs/kernfs/dir.c:1712

stack backtrace:
CPU: 1 UID: 0 PID: 13313 Comm: syz.0.1930 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 down_write+0x92/0x200 kernel/locking/rwsem.c:1590
 kernfs_unlink_sibling+0xa3/0x320 fs/kernfs/dir.c:424
 __kernfs_remove+0x2c0/0x8a0 fs/kernfs/dir.c:1514
 kernfs_remove_by_name_ns+0x68/0x110 fs/kernfs/dir.c:1717
 kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
 sysfs_unmerge_group+0xe7/0x170 fs/sysfs/group.c:402
 rpm_sysfs_remove drivers/base/power/sysfs.c:823 [inline]
 dpm_sysfs_remove+0x7f/0xb0 drivers/base/power/sysfs.c:832
 device_del+0x1a0/0x9f0 drivers/base/core.c:3853
 device_unregister+0x1d/0xc0 drivers/base/core.c:3919
 usb_remove_ep_devs+0x42/0x80 drivers/usb/core/endpoint.c:189
 remove_intf_ep_devs drivers/usb/core/message.c:1266 [inline]
 usb_disable_device+0x309/0x7d0 drivers/usb/core/message.c:1417
 usb_set_configuration+0x12cd/0x1e20 drivers/usb/core/message.c:2066
 bConfigurationValue_store+0x100/0x180 drivers/usb/core/sysfs.c:105
 dev_attr_store+0x58/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed9ab8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed9b9dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fed9ade5fa0 RCX: 00007fed9ab8efc9
RDX: 0000000000000003 RSI: 0000200000000000 RDI: 000000000000000b
RBP: 00007fed9ac11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fed9ade6038 R14: 00007fed9ade5fa0 R15: 00007ffee3bb7e58
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

