Return-Path: <linux-kernel+bounces-793258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2084B3D141
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A8D17C4F8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28321883E;
	Sun, 31 Aug 2025 07:41:41 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA62223DD6
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756626100; cv=none; b=VKuq+sgncK0HnUNz7Dodg7bjROrRAGhMFtrHY5lT5wsy5ZoyOAsUOiIerKWXxi8/BDtJ7jVKZkEhRMk5w4/aoKIkQPrE0azpSCUgn4XhmeqpfaMG8iV96pR70qtI/Ly4qDttpVVKdzRI6BnPpTnIBf/HAdF01wVgxa/Mjpvbb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756626100; c=relaxed/simple;
	bh=8nr67gVyyZKjY7PKeXmJpMXzu5A7tCccq25JncPkEbU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s78OOxMy0fyTw7wgH+8+SG07NdieD2Q/jcHI6GHr8HhJadQPy2TUooZoC6AwLWWag8ZvvG0xpBmput0Q5TgFqtj7Jf9RDZZ8iZcymWJgo3wbDAxy5otkZm5dTL8ZLkGs8XIHqA+9hlqexnpPREMPOI5vHdX/7ic3Kc1H7g7KDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ec58544f79so80977175ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 00:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756626097; x=1757230897;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeJotRqxdN6VwivRreKnFdgIwWHqq/3rkGWb2aH+kPg=;
        b=LuUKZ4u9jz+xVCqGNZ6OzkHZpZl1zTT6Tft4B7ke7KYdWrxOFFr9DuwAD1cds0mF1T
         IL7QCMweUkTWGPWzo33T3jAcNeR4w17yrzPhn205H0XWO/PfNf/Wu0Mc4+AtzHO0QemN
         qIOKV1DPHs78ePwnJcO1dLGxI5QVEb//4fWdgyW3eQkinZH8tl4JlIG5kcHRgpx5bQXf
         c57+wTAon/l9XfUimIvBZkWQzAHrfGEblL+uwo0uuAGdJLwvq08HwhVAIv9OJvb2uDm2
         nJxMmvV27md1b8OarkkznsYoo7bUF941WKJ4PJt+xyvQSX0wne7JI6BAim8BKkFtHnfE
         k4nA==
X-Forwarded-Encrypted: i=1; AJvYcCWMdylfXOazEyes34UEOIE9I5BUGPkHVea6ODlE4pm4f62ltT0gYpxIuSJ8agUvxxPyVSNTs40EVTD1tIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPlYrY8/4bqpY+sFmwfC9wFCd9fuJSy9mMOgDpp9aPY4p4ZcT
	/cgDPWOV3T631Sxdb45IAkmTVUbcmfm2RxIstI3VeWIpSPTjxjHA6PuXSaUKepp37HKx904mtq+
	uTjfASz4TQv5E5TEvU+tRxSmlFTBYwvwZHi+UJJxTJbOAF+LpJoA01CHiy4A=
X-Google-Smtp-Source: AGHT+IF9NDR37bO8te3y/GJ5u3S6nJ5t7/U+M1SoAMh+MnopTs3GIJo06LLZOMOBLoMM4zZj67c2AmJ63Mn35foUhx6ThSpVUwtv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:3f0:af3f:e9e4 with SMTP id
 e9e14a558f8ab-3f3ffda4bb8mr94513785ab.3.1756626097206; Sun, 31 Aug 2025
 00:41:37 -0700 (PDT)
Date: Sun, 31 Aug 2025 00:41:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b3fcb1.050a0220.3db4df.01b0.GAE@google.com>
Subject: [syzbot] [kernel?] possible deadlock in device_create_groups_vargs
From: syzbot <syzbot+99692edebf9576c94c17@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16189462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=99692edebf9576c94c17
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ec4ed1fe8eb/disk-fab1beda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd7a428a93af/vmlinux-fab1beda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/599820edb83a/bzImage-fab1beda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99692edebf9576c94c17@syzkaller.appspotmail.com

block nbd9: NBD_DISCONNECT
block nbd9: Send disconnect failed -22
block nbd9: Disconnected due to user request.
block nbd9: shutting down sockets
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.902/10729 is trying to acquire lock:
ffffffff8e75b280 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8e75b280 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4131 [inline]
ffffffff8e75b280 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4209 [inline]
ffffffff8e75b280 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x57/0x3b0 mm/slub.c:4281

but task is already holding lock:
ffffffff908e8fa8 (uevent_sock_mutex){+.+.}-{4:4}, at: uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
ffffffff908e8fa8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
ffffffff908e8fa8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (uevent_sock_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
       kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
       kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608
       device_add+0x10dd/0x1aa0 drivers/base/core.c:3670
       device_create_groups_vargs+0x1f8/0x270 drivers/base/core.c:4371
       device_create+0xed/0x130 drivers/base/core.c:4410
       msr_device_create+0x31/0x70 arch/x86/kernel/msr.c:251
       cpuhp_invoke_callback+0x3d5/0xa10 kernel/cpu.c:195
       cpuhp_thread_fun+0x47e/0x6f0 kernel/cpu.c:1105
       smpboot_thread_fn+0x3f4/0xae0 kernel/smpboot.c:160
       kthread+0x3c5/0x780 kernel/kthread.c:463
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #8 (cpuhp_state-up){+.+.}-{0:0}:
       cpuhp_lock_acquire kernel/cpu.c:104 [inline]
       cpuhp_thread_fun+0x193/0x6f0 kernel/cpu.c:1082
       smpboot_thread_fn+0x3f4/0xae0 kernel/smpboot.c:160
       kthread+0x3c5/0x780 kernel/kthread.c:463
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #7 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:491
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       udp_tunnel_encap_enable include/net/udp_tunnel.h:201 [inline]
       setup_udp_tunnel_sock+0x53a/0x680 net/ipv4/udp_tunnel_core.c:91
       l2tp_tunnel_register+0x9c8/0xbe0 net/l2tp/l2tp_core.c:1679
       pppol2tp_tunnel_get.constprop.0+0x3f0/0x540 net/l2tp/l2tp_ppp.c:672
       pppol2tp_connect+0xb1b/0x1ce0 net/l2tp/l2tp_ppp.c:720
       __sys_connect_file+0x141/0x1a0 net/socket.c:2086
       __sys_connect+0x13b/0x160 net/socket.c:2105
       __do_sys_connect net/socket.c:2111 [inline]
       __se_sys_connect net/socket.c:2108 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2108
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3733
       lock_sock include/net/sock.h:1667 [inline]
       inet_autobind+0x1a/0x1a0 net/ipv4/af_inet.c:178
       inet_send_prepare+0x31b/0x530 net/ipv4/af_inet.c:837
       inet_sendmsg+0x43/0x140 net/ipv4/af_inet.c:848
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg net/socket.c:729 [inline]
       sock_sendmsg+0x37f/0x470 net/socket.c:752
       __sock_xmit+0x1e7/0x4f0 drivers/block/nbd.c:574
       sock_xmit drivers/block/nbd.c:602 [inline]
       send_disconnects drivers/block/nbd.c:1395 [inline]
       nbd_disconnect+0x392/0x550 drivers/block/nbd.c:1410
       nbd_disconnect_and_put+0x2e/0x1c0 drivers/block/nbd.c:2245
       nbd_genl_disconnect+0x396/0x570 drivers/block/nbd.c:2291
       genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg net/socket.c:729 [inline]
       ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
       __sys_sendmsg+0x16d/0x220 net/socket.c:2700
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
       blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1220
       blk_finish_plug block/blk-core.c:1247 [inline]
       blk_finish_plug block/blk-core.c:1244 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
       submit_bio_noacct+0xc20/0x1ed0 block/blk-core.c:874
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2413
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
       read_mapping_folio include/linux/pagemap.h:991 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x277/0x3f0 block/fops.c:691
       do_dentry_open+0x982/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1095
       do_open fs/namei.c:3887 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4046
       do_filp_open+0x20b/0x470 fs/namei.c:4073
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
       blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1220
       blk_finish_plug block/blk-core.c:1247 [inline]
       blk_finish_plug block/blk-core.c:1244 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
       submit_bio_noacct+0xc20/0x1ed0 block/blk-core.c:874
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2413
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
       read_mapping_folio include/linux/pagemap.h:991 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x277/0x3f0 block/fops.c:691
       do_dentry_open+0x982/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1095
       do_open fs/namei.c:3887 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4046
       do_filp_open+0x20b/0x470 fs/namei.c:4073
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1429
       blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
       blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
       elevator_switch+0x17d/0x810 block/elevator.c:588
       elevator_change+0x391/0x580 block/elevator.c:690
       elevator_set_default+0x2e9/0x380 block/elevator.c:766
       blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:904
       __add_disk+0x74a/0xf00 block/genhd.c:528
       add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
       add_disk include/linux/blkdev.h:774 [inline]
       nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1973
       nbd_init+0x181/0x320 drivers/block/nbd.c:2680
       do_one_initcall+0x120/0x6e0 init/main.c:1269
       do_initcall_level init/main.c:1331 [inline]
       do_initcalls init/main.c:1347 [inline]
       do_basic_setup init/main.c:1366 [inline]
       kernel_init_freeable+0x5c2/0x910 init/main.c:1579
       kernel_init+0x1c/0x2b0 init/main.c:1469
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       queue_requests_store+0x1c7/0x310 block/blk-sysfs.c:80
       queue_attr_store+0x26b/0x310 block/blk-sysfs.c:831
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d0/0x11d0 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#61){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4400
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4447
       nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1943
       nbd_init+0x181/0x320 drivers/block/nbd.c:2680
       do_one_initcall+0x120/0x6e0 init/main.c:1269
       do_initcall_level init/main.c:1331 [inline]
       do_initcalls init/main.c:1347 [inline]
       do_basic_setup init/main.c:1366 [inline]
       kernel_init_freeable+0x5c2/0x910 init/main.c:1579
       kernel_init+0x1c/0x2b0 init/main.c:1469
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4248
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4131 [inline]
       slab_alloc_node mm/slub.c:4209 [inline]
       kmem_cache_alloc_node_noprof+0x57/0x3b0 mm/slub.c:4281
       __alloc_skb+0x2b2/0x380 net/core/skbuff.c:659
       alloc_skb include/linux/skbuff.h:1336 [inline]
       alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
       uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
       kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
       kobject_uevent_env+0xca4/0x1870 lib/kobject_uevent.c:608
       nbd_config_put+0x4fc/0x750 drivers/block/nbd.c:1429
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1745
       blkdev_put_whole+0xad/0xf0 block/bdev.c:721
       bdev_release+0x47e/0x6d0 block/bdev.c:1144
       blkdev_release+0x15/0x20 block/fops.c:699
       __fput+0x402/0xb70 fs/file_table.c:468
       task_work_run+0x14d/0x240 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
       do_syscall_64+0x3f6/0x490 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpuhp_state-up --> uevent_sock_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(uevent_sock_mutex);
                               lock(cpuhp_state-up);
                               lock(uevent_sock_mutex);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz.4.902/10729:
 #0: ffff888027003358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x15a/0x6d0 block/bdev.c:1128
 #1: ffff888026ff9a30 (&nbd->config_lock){+.+.}-{4:4}, at: refcount_dec_and_mutex_lock+0x51/0xc0 lib/refcount.c:118
 #2: ffffffff908e8fa8 (uevent_sock_mutex){+.+.}-{4:4}, at: uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 #2: ffffffff908e8fa8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 #2: ffffffff908e8fa8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608

stack backtrace:
CPU: 1 UID: 0 PID: 10729 Comm: syz.4.902 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
 fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4248
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4131 [inline]
 slab_alloc_node mm/slub.c:4209 [inline]
 kmem_cache_alloc_node_noprof+0x57/0x3b0 mm/slub.c:4281
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xca4/0x1870 lib/kobject_uevent.c:608
 nbd_config_put+0x4fc/0x750 drivers/block/nbd.c:1429
 nbd_release+0xb7/0x190 drivers/block/nbd.c:1745
 blkdev_put_whole+0xad/0xf0 block/bdev.c:721
 bdev_release+0x47e/0x6d0 block/bdev.c:1144
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x490 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9f5758ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f5837c038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f9f577b6090 RCX: 00007f9f5758ebe9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000002
RBP: 00007f9f57611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9f577b6128 R14: 00007f9f577b6090 R15: 00007ffeb6e33448
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

