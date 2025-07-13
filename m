Return-Path: <linux-kernel+bounces-729040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C94B030F5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BC71899558
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB1278173;
	Sun, 13 Jul 2025 12:09:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7113A3ED
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752408576; cv=none; b=FloyRvncwg1mM1tsJ5ikVs9KfWC4p5cjEK8P6HJeqI58tQqvNjhIdK/YLXv6TvcEtYpr5QORSVGnTreOOHEpIt1hp4pwEEaBikvcuFh+JQZBmto4Uk4kULs8HZCpujxgH+LJE2WixhjiiIuiOfG6lckZJVRCXQpFmiZFSax4nZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752408576; c=relaxed/simple;
	bh=56fmDJvgEZg/VnGGAehxYWlx4ljr7Z0Cp+2fK+iyhl0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ONiRe9eBhdfn7ienccGo+dQDDzVIYST2C9zOh4ZedDUELA6/YfdCH0IupTtJURtQtrTM35XaXEoBiwkgcJqci7IHte+DAvTXO+OlIPL/OQXMktdD1OF9LgbRJTaXPHI+C2ue4K9ftmjW14XBtrxLmKEV8knevooJGgqpRpcSSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3de3b5b7703so22372165ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752408573; x=1753013373;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3cwTQLC5R4SLbD+9XHrah08xKAi2BGFgVZj4N+ZVFg=;
        b=W4b+gNQmbEDnfGk9VWR98fqccjdPlyXP4nKd1BnraZ9X2LBFbR+8AyZzogyAvl+aJ+
         0UZTJyMd4vAjaHZvFABP5dYXoolqGjbMfYLCNCIWr+g/gRCKm9J7QvuPUQjyoc/7ya4M
         ScuAu3I9tr1tlDmQTpYkY8bY+Rg2r4myoZ954htWp81NAa2cmOeCU+gzIRWXATzOeRES
         nr/6sU+6Sf5K+SebaIQSqolsTtP9IVqr/Axi+Hq6B3PH0jKFccToeMW5kx1t3Vc1x3Vq
         1X8w1AoBecCXeC1+0RyMFh1Fb14VWgm6n1FgUc3yAW1bO/rENs5ONdVtI9+NH09a9hVd
         Z1bw==
X-Forwarded-Encrypted: i=1; AJvYcCWN1GBd2JgZH5RLEO2K5/J1qOrfp8bsIQnug7fgrN1XKjxz8x8Di02aJRC4P8vExhw12kQ2TwSiAf17kRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgu7io2pgXB+NsKScnuMlqWB+BY+57vSG0UcuTM3ciSC8dfBu
	nRfoBReq/W3e0daIEA5ObplKSApI2wiVa1L0EnQVEhlZH3gojSBPtf2N2FAudtBK2cAKjKYjuEF
	RkwX3XL1jypNQu40yF/1JKXdZx8KuS0JyqTaAGyyXIPaVnquy6R0YyWZybG4=
X-Google-Smtp-Source: AGHT+IF/sdmuFG+aLsMPa+lyr4HadJAMo/dT4p1mYz5njEbg21DG+GDooDVJjcrOb8/5pK0UoLIxqXELQ9fVtZoouLMyEjGtz0wA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:3df:2cd5:80c1 with SMTP id
 e9e14a558f8ab-3e2541dc704mr83576395ab.4.1752408573397; Sun, 13 Jul 2025
 05:09:33 -0700 (PDT)
Date: Sun, 13 Jul 2025 05:09:33 -0700
In-Reply-To: <68653bfd.a00a0220.270cb1.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873a1fd.a70a0220.3b380f.002f.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
From: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14725d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76c2fb9aa0954fb8
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f50f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12725d82580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33ae17bacfc2/disk-3f31a806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f476e6d9400a/vmlinux-3f31a806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ae9e3684ea3/bzImage-3f31a806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com

microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
=====================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x5a1/0x2630 drivers/usb/core/urb.c:430
 usb_submit_urb+0x5a1/0x2630 drivers/usb/core/urb.c:430
 usb_start_wait_urb+0xc2/0x320 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x27c/0x5b0 drivers/usb/core/message.c:154
 usbhid_raw_request+0x4ab/0x690 drivers/hid/usbhid/hid-core.c:-1
 __hid_request+0x2bd/0x500 drivers/hid/hid-core.c:1989
 hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1950 [inline]
 hidinput_connect+0x3bf5/0x5cc0 drivers/hid/hid-input.c:2327
 hid_connect+0x6b4/0x3440 drivers/hid/hid-core.c:2239
 hid_hw_start+0xfc/0x1e0 drivers/hid/hid-core.c:2354
 ms_probe+0x2e5/0x890 drivers/hid/hid-microsoft.c:391
 __hid_device_probe drivers/hid/hid-core.c:2724 [inline]
 hid_device_probe+0x536/0xab0 drivers/hid/hid-core.c:2761
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d1/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:799
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:829
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:957
 bus_for_each_drv+0x3e0/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1029
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3692
 hid_add_device+0x5ed/0x7b0 drivers/hid/hid-core.c:2907
 usbhid_probe+0x1fec/0x2660 drivers/hid/usbhid/hid-core.c:1435
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d1/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:799
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:829
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:957
 bus_for_each_drv+0x3e0/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1029
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3692
 usb_set_configuration+0x3493/0x3b70 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xfc/0x290 drivers/usb/core/generic.c:250
 usb_probe_device+0x38d/0x690 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d1/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:799
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:829
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:957
 bus_for_each_drv+0x3e0/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1029
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3692
 usb_new_device+0x104b/0x20c0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x5588/0x7580 drivers/usb/core/hub.c:5948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3321
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3402
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e0/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x96d/0x12f0 mm/slub.c:4347
 __kmemdup_nul mm/util.c:63 [inline]
 kstrdup+0x8a/0x2a0 mm/util.c:83
 kstrdup_const+0x5e/0x90 mm/util.c:103
 __kernfs_new_node+0x6e/0xa70 fs/kernfs/dir.c:633
 kernfs_new_node+0x1f0/0x370 fs/kernfs/dir.c:713
 kernfs_create_dir_ns+0x9a/0x2b0 fs/kernfs/dir.c:1083
 sysfs_create_dir_ns+0x19c/0x540 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0xeed/0x1840 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_init_and_add+0x371/0x4e0 lib/kobject.c:457
 netdev_queue_add_kobject net/core/net-sysfs.c:1976 [inline]
 netdev_queue_update_kobjects+0x358/0xbf0 net/core/net-sysfs.c:2035
 register_queue_kobjects net/core/net-sysfs.c:2098 [inline]
 netdev_register_kobject+0x3be/0x4f0 net/core/net-sysfs.c:2340
 register_netdevice+0x1b41/0x25d0 net/core/dev.c:11105
 cfg80211_register_netdevice+0x1a3/0x410 net/wireless/core.c:1490
 ieee80211_if_add+0x1ebc/0x2a60 net/mac80211/iface.c:2271
 ieee80211_register_hw+0x5548/0x5920 net/mac80211/main.c:1606
 mac80211_hwsim_new_radio+0x50ee/0x7a70 drivers/net/wireless/virtual/mac80211_hwsim.c:5565
 hwsim_new_radio_nl+0x16f9/0x2fd0 drivers/net/wireless/virtual/mac80211_hwsim.c:6249
 genl_family_rcv_msg_doit+0x335/0x3f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xacf/0xc10 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x54a/0x680 net/netlink/af_netlink.c:2552
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xee2/0x1290 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:727
 __sys_sendto+0x593/0x720 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2183
 x64_sys_call+0x3c0b/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 12-14 of 65535 are uninitialized
Memory access of size 65535 starts at ffff8880527e8be1

CPU: 1 UID: 0 PID: 42 Comm: kworker/1:1 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

