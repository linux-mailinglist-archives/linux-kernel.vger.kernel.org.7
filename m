Return-Path: <linux-kernel+bounces-643541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62786AB2E73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 06:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A0A3B3840
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 04:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE3254B06;
	Mon, 12 May 2025 04:50:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A013CF9C
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747025427; cv=none; b=uko4cuxtRuStuVlWnzKh9VZ/AC+z4c8gIS5IQA2KaWUeIk0/3rgnrHD3TUHTDOdeVpNK5zCu/TYoW1VLz+kio6lgUI4+4eTr8Tugyk33efUNHpzUZtDJlgGl6fKh5lzpg5fiLs5lKXgV/ztA8BaLqFSaaEM0NlGJLGfGYXMpAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747025427; c=relaxed/simple;
	bh=7Xiskqa7L+6rqLDvsgiMDhwevWUAy74479EhXc1gaB4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CVXX0Lmc/5BdzOZaxZv0jB3VFsyda2UnNl+r8r81QBRsOMGj2i0mdw8LPa8VT04IUD6awWMStRXUhcoMUujGo+AL5tp9l5f+3uFnlw0GW3x46rFEByyluYPi4X/LMh+doZCoQpL2AZ67Mh0Q4d+enhYXzjL6Kyj/X8zNwZuXH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3da717e86b1so41744045ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 21:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747025425; x=1747630225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvJXPWPUEdy3W8iN/5cmgWQxRUqmS/kAUen/zOjXUpc=;
        b=pXaUL4BV/gC2unvO3D/DX6hScy87OqWIBk8PTgeFBnE66sFAkBYg+pKkWrMk/d68Wd
         ibTJwjk2TIRidflLlnJ53DTclkCQVvFwW8kQNlSpDj2YBbFNiwZjl3ZE7A8zS7E9LtfZ
         1eA5rOoD2PKAXjY/yWx/LbGOaYx35SiqJh+TyfWEBpXQtPaXQCNFSDDDLniGXzEV1721
         shQnvbXiXpwJdhsSvpKesf+d9yZLJUgMWp0U4/Ph66/ZWP9ndvcFWxaZFofmw1KPhsiK
         +EZaYRbAbAr3CCkI/ZhZFvBWzPmHkZy0a8AdIFgobsVBaPQar5ELQJiDu7iJ1i03cTJj
         ezMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbAs+pkUCyE1g5/JCbsuQhKPrTOQDlIyerr8N2N16wB6IfMtsElfwYazioA5BXDffadvKQ5TQL4jyCAvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnrMWnH5n7WaToWVRIYWxZxp7KXuXFxSOnlhy8o8/eN4gPSQs
	1nsbmCnk6ER7QL9KL3phyQT9Zz3FOpSQ4D7+fFP23pstlMoik+yFUezledm3KxjIym47fx/bdmE
	4FTguZzLZuiO8csVqMpqFuGiS7cODLhNsJnyMlyWEzRUfSEytm6aLQFU=
X-Google-Smtp-Source: AGHT+IF2kufo9obcv02xgHnNGM9USzbpuxmaorBxbj9nUck6bXII8IoqV+dX6ca7PA1yqjKIv9/MUbHDF1UmlYu/8OspE566AuBd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:3d8:975:b808 with SMTP id
 e9e14a558f8ab-3da7e1e1a99mr134014655ab.5.1747025424839; Sun, 11 May 2025
 21:50:24 -0700 (PDT)
Date: Sun, 11 May 2025 21:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68217e10.050a0220.f2294.004c.GAE@google.com>
Subject: [syzbot] [net?] WARNING in neigh_parms_release
From: syzbot <syzbot+873424263816aca3b472@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707df3375124 Merge tag 'media/v6.15-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145e98f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=925afd2bdd38a581
dashboard link: https://syzkaller.appspot.com/bug?extid=873424263816aca3b472
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-707df337.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abde9f240928/vmlinux-707df337.xz
kernel image: https://storage.googleapis.com/syzbot-assets/756b0378e0b9/zImage-707df337.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+873424263816aca3b472@syzkaller.appspotmail.com

veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
------------[ cut here ]------------
WARNING: CPU: 1 PID: 22523 at lib/ref_tracker.c:228 ref_tracker_free+0x190/0x298 lib/ref_tracker.c:228
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 UID: 0 PID: 22523 Comm: kworker/u8:3 Not tainted 6.15.0-rc5-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Workqueue: netns cleanup_net
Call trace: 
[<802019e4>] (dump_backtrace) from [<80201ae0>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:828227fc r5:00000000 r4:82257c34
[<80201ac8>] (show_stack) from [<80220020>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201ac8>] (show_stack) from [<80220020>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<8021ffcc>] (dump_stack_lvl) from [<80220060>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82a70d4c
[<80220048>] (dump_stack) from [<802025f8>] (panic+0x120/0x374 kernel/panic.c:354)
[<802024d8>] (panic) from [<802619e8>] (check_panic_on_warn kernel/panic.c:243 [inline])
[<802024d8>] (panic) from [<802619e8>] (get_taint+0x0/0x1c kernel/panic.c:238)
 r3:8280c604 r2:00000001 r1:8223e7fc r0:822462fc
 r7:809673f4
[<80261974>] (check_panic_on_warn) from [<80261b4c>] (__warn+0x80/0x188 kernel/panic.c:749)
[<80261acc>] (__warn) from [<80261dcc>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:776)
 r8:00000009 r7:822b2274 r6:e06e9b54 r5:84151800 r4:00000000
[<80261c58>] (warn_slowpath_fmt) from [<809673f4>] (ref_tracker_free+0x190/0x298 lib/ref_tracker.c:228)
 r10:00000000 r9:84a31b00 r8:84f63c00 r7:00000000 r6:00000000 r5:854c5988
 r4:84ce19cc
[<80967264>] (ref_tracker_free) from [<8155d35c>] (netdev_tracker_free include/linux/netdevice.h:4351 [inline])
[<80967264>] (ref_tracker_free) from [<8155d35c>] (netdev_put include/linux/netdevice.h:4368 [inline])
[<80967264>] (ref_tracker_free) from [<8155d35c>] (netdev_put include/linux/netdevice.h:4364 [inline])
[<80967264>] (ref_tracker_free) from [<8155d35c>] (neigh_parms_release+0x7c/0xc4 net/core/neighbour.c:1709)
 r8:84f63c00 r7:00000000 r6:00000000 r5:84ce1680 r4:854c5980
[<8155d2e0>] (neigh_parms_release) from [<81804d0c>] (addrconf_ifdown+0x6ac/0x764 net/ipv6/addrconf.c:4008)
 r5:84f63b84 r4:84f63c00
[<81804660>] (addrconf_ifdown) from [<8180aee0>] (addrconf_notify+0x98/0x770 net/ipv6/addrconf.c:3777)
 r10:e06e9d90 r9:84a67000 r8:8180ae48 r7:00000006 r6:84a31b00 r5:84f63c00
 r4:84c9e000
[<8180ae48>] (addrconf_notify) from [<802926cc>] (notifier_call_chain+0x60/0x1b4 kernel/notifier.c:85)
 r10:e06e9d90 r9:84a67000 r8:8180ae48 r7:00000000 r6:ffffffd1 r5:829e490c
 r4:829e5764
[<8029266c>] (notifier_call_chain) from [<80292904>] (raw_notifier_call_chain+0x20/0x28 kernel/notifier.c:453)
 r10:00000000 r9:84a67000 r8:847e6080 r7:00000000 r6:84a31b00 r5:00000006
 r4:e06e9d90
[<802928e4>] (raw_notifier_call_chain) from [<8154bb5c>] (call_netdevice_notifiers_info+0x54/0xa0 net/core/dev.c:2176)
[<8154bb08>] (call_netdevice_notifiers_info) from [<81557090>] (call_netdevice_notifiers_extack net/core/dev.c:2214 [inline])
[<8154bb08>] (call_netdevice_notifiers_info) from [<81557090>] (call_netdevice_notifiers net/core/dev.c:2228 [inline])
[<8154bb08>] (call_netdevice_notifiers_info) from [<81557090>] (unregister_netdevice_many_notify+0x54c/0xbc4 net/core/dev.c:11982)
 r6:00000001 r5:84c9e000 r4:000000c0
[<81556b44>] (unregister_netdevice_many_notify) from [<8155846c>] (unregister_netdevice_many net/core/dev.c:12046 [inline])
[<81556b44>] (unregister_netdevice_many_notify) from [<8155846c>] (default_device_exit_batch+0x304/0x384 net/core/dev.c:12538)
 r10:e06e9e70 r9:829d1ec4 r8:e06e9e90 r7:82c1f980 r6:e06e9e70 r5:84a31bf8
 r4:84a31afc
[<81558168>] (default_device_exit_batch) from [<81539c88>] (ops_exit_list+0x64/0x68 net/core/net_namespace.c:177)
 r10:84914380 r9:829d1ec4 r8:829d1ec4 r7:e06e9e90 r6:829d2584 r5:e06e9e90
 r4:829d2584
[<81539c24>] (ops_exit_list) from [<8153c0e8>] (cleanup_net+0x2b0/0x49c net/core/net_namespace.c:654)
 r7:e06e9e90 r6:829d1e80 r5:82c1f940 r4:829d2584
[<8153be38>] (cleanup_net) from [<802873bc>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r10:8300f070 r9:8301bc15 r8:84151800 r7:8300e600 r6:8301bc00 r5:829d1e98
 r4:85556800
[<80287208>] (process_one_work) from [<80288004>] (process_scheduled_works kernel/workqueue.c:3319 [inline])
[<80287208>] (process_one_work) from [<80288004>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3400)
 r10:61c88647 r9:84151800 r8:8555682c r7:82804d40 r6:8300e600 r5:8300e620
 r4:85556800
[<80287e08>] (worker_thread) from [<8028f074>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:85556800 r8:80287e08 r7:eb221e60 r6:85556e00 r5:84151800
 r4:00000001
[<8028ef48>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xe06e9fb0 to 0xe06e9ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8028ef48
 r4:8556ee80
Rebooting in 86400 seconds..


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

