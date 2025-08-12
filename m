Return-Path: <linux-kernel+bounces-764986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAEBB229A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA845878FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B612874FE;
	Tue, 12 Aug 2025 13:53:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38717283FD7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006785; cv=none; b=Ro5MfSqG1Q3M6o9ysPeBUQJXkp8wArp72z0vDhe+81UFuUq7h/WgLWnDoBCgQDz9iwliLtEWcLY81gJvPTM9UPZZ2Rt1vzHU9mPwz6mte8+IjzFmPRW/DYOAewX+CU6oC8JhcrzavJtqBp7BysCQSA9Wtzb5UNH2avgW07A1/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006785; c=relaxed/simple;
	bh=8z6ywu5e8Nf4HVGO2a2m/RH2+JWWTlwSp8xC9kznyeI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=npdk//XbP6OKKKgTw9M/kajMUBtXWyUfwVFwu8DwolGNwFcAp6Qbvh61tHdB8u80+NO+eq+VGHeo/pUZZ25AtfLLxB1GEEFcnyiuNbWwdzddZXL4TQmlUKgBPA32zcgKBAnkQkpHfDsJ/CqhOVTghojcB/qMRUCTkeabuA9pduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e405c4c009so142736565ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006782; x=1755611582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP34dO8CbiQO1ORBbzjDSLe50amCknElm5INSoQuNp4=;
        b=Zxbbs54rxCl25WtpNmu2qFs+pCCQVzmHC9Upx1+R3rXEtdKri5SMfflvERSe2qVIc0
         xAxChNLXO+kDKB7W1jb6U78FubPH8fvGheOXu9cVUuRSqesO9UKFp+g0lwG2UKlyAkWs
         ZIqf+MoLRiAfY5XInEa0sxBo7wu2fxCVAewd+0nlpQKoGV2ZeiunACpTjmR1eT/l4ggD
         ltx2IM/ekURB3OdRHQeKabMSHiKbyXsSC0tNFEhtrJ0w7SwjRYcTxa8sfmk6Ip46uNTx
         WoXkR6LMTvGfKHGgQ87ZW+Y1CFr7yhiA3ohVKNfXbj1sDFwrBgzh4IveEI3l8JiTYAHZ
         ibmg==
X-Forwarded-Encrypted: i=1; AJvYcCUwOcaxk4UHommw18y5xQA+q0wjq93C0LJ8z3ejxeVXGukTG4alX5Jndmtz9BpGDWD3CklAlZdwayh5i2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmc9nZYUQ0YiPXW02pswQw7sySQtg+8lJRNgLOgXZnYgFYxoZU
	8Q4TZS836fAUGRJVfP9H11dWXzB8bWmWs4zFJZOT/jNWuCE/5QZd2pVe2qK3qv0rXT68nM+uSl3
	D6lIZwVa3aMybdQTT1t0kXsWf2vX519p7y4bRlBEHzlSgihp5hkDYRc4gQII=
X-Google-Smtp-Source: AGHT+IHSKSGmqx7FZAB7tnSW+Bda+KSKJoGwNEgSEGuQ+FvG3j8Z4J+LRi6+BNrtchOiCzqTgPzKGXBNRXSeaXO7feEiU7Lgzk1D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:0:b0:3e5:4942:88bc with SMTP id
 e9e14a558f8ab-3e549428c06mr158053155ab.10.1755006782112; Tue, 12 Aug 2025
 06:53:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:53:02 -0700
In-Reply-To: <20250812133111.4277-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b473e.050a0220.7f033.012b.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in udp_tunnel_nic_device_sync_work

netdevsim netdevsim1 eth3: set [1, 0] type 2 family 0 port 6081 - 0
==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:577 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x147/0x1360 kernel/locking/mutex.c:760
Read of size 8 at addr ffff88803f2c5eb0 by task kworker/u4:10/3078

CPU: 0 UID: 0 PID: 3078 Comm: kworker/u4:10 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
 __mutex_lock+0x147/0x1360 kernel/locking/mutex.c:760
 udp_tunnel_nic_device_sync_work+0x39/0xa50 net/ipv4/udp_tunnel_nic.c:737
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7292:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 udp_tunnel_nic_alloc net/ipv4/udp_tunnel_nic.c:756 [inline]
 udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:833 [inline]
 udp_tunnel_nic_netdevice_event+0x854/0x19f0 net/ipv4/udp_tunnel_nic.c:931
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1038 [inline]
 nsim_create+0xb76/0xfc0 drivers/net/netdevsim/netdev.c:1110
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4ec/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7304:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x18e/0x440 mm/slub.c:4879
 udp_tunnel_nic_free net/ipv4/udp_tunnel_nic.c:785 [inline]
 udp_tunnel_nic_unregister net/ipv4/udp_tunnel_nic.c:910 [inline]
 udp_tunnel_nic_netdevice_event+0x1332/0x19f0 net/ipv4/udp_tunnel_nic.c:942
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 unregister_netdevice_many_notify+0x14d7/0x1ff0 net/core/dev.c:12148
 unregister_netdevice_many net/core/dev.c:12211 [inline]
 unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12055
 unregister_netdevice include/linux/netdevice.h:3382 [inline]
 nsim_destroy+0x1dd/0x6a0 drivers/net/netdevsim/netdev.c:1145
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1473
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1485 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1707
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:983
 devlink_reload+0x1b6/0x8d0 net/devlink/dev.c:461
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xbaf/0xfb0 kernel/workqueue.c:2343
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:307 [inline]
 __udp_tunnel_nic_add_port+0xb71/0xd60 net/ipv4/udp_tunnel_nic.c:523
 udp_tunnel_nic_add_port include/net/udp_tunnel.h:371 [inline]
 udp_tunnel_push_rx_port+0x17d/0x200 net/ipv4/udp_tunnel_core.c:111
 geneve_offload_rx_ports+0xd7/0x160 drivers/net/geneve.c:1188
 geneve_netdevice_event+0x6a/0x80 drivers/net/geneve.c:-1
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers+0x88/0xc0 net/core/dev.c:2281
 udp_tunnel_get_rx_info include/net/udp_tunnel.h:438 [inline]
 udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:855 [inline]
 udp_tunnel_nic_netdevice_event+0x134d/0x19f0 net/ipv4/udp_tunnel_nic.c:931
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1038 [inline]
 nsim_create+0xb76/0xfc0 drivers/net/netdevsim/netdev.c:1110
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4ec/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xcd2/0xfb0 kernel/workqueue.c:2339
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 udp_tunnel_nic_device_sync net/ipv4/udp_tunnel_nic.c:307 [inline]
 __udp_tunnel_nic_add_port+0xb71/0xd60 net/ipv4/udp_tunnel_nic.c:523
 udp_tunnel_nic_add_port include/net/udp_tunnel.h:371 [inline]
 udp_tunnel_push_rx_port+0x17d/0x200 net/ipv4/udp_tunnel_core.c:111
 geneve_offload_rx_ports+0xd7/0x160 drivers/net/geneve.c:1188
 geneve_netdevice_event+0x6a/0x80 drivers/net/geneve.c:-1
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers+0x88/0xc0 net/core/dev.c:2281
 udp_tunnel_get_rx_info include/net/udp_tunnel.h:438 [inline]
 udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:855 [inline]
 udp_tunnel_nic_netdevice_event+0x134d/0x19f0 net/ipv4/udp_tunnel_nic.c:931
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1038 [inline]
 nsim_create+0xb76/0xfc0 drivers/net/netdevsim/netdev.c:1110
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4ec/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803f2c5e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 176 bytes inside of
 freed 256-byte region [ffff88803f2c5e00, ffff88803f2c5f00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3f2c5
ksm flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a441b40 ffffea00011756c0 dead000000000003
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5917, tgid 5917 (syz-executor), ts 171623469790, free_ts 171406955544
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
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4391
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 devl_region_create+0x14f/0x380 net/devlink/region.c:1058
 nsim_dev_dummy_region_init drivers/net/netdevsim/dev.c:581 [inline]
 nsim_drv_probe+0x614/0xba0 drivers/net/netdevsim/dev.c:1619
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 pagetable_free include/linux/mm.h:2898 [inline]
 pagetable_dtor_free include/linux/mm.h:2996 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88803f2c5d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803f2c5e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803f2c5e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88803f2c5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803f2c5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103535a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ecc5a2580000


