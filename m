Return-Path: <linux-kernel+bounces-875559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB9C1941C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6CA1CC4669
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E9D31D749;
	Wed, 29 Oct 2025 08:56:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9572605
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728169; cv=none; b=YNFl66n20PCX9I8NVXMekQ0eznrZlzV6vu2icFkS7QYKpRZMni2kf66t7iIN6B19ZvAGlYgqcFr0Q+JBxrDpCHHxOZxgTFgRPlSkJA0vKpdNeiUxX5LohcUwVLe0CdcP8O9nBSRppiSPgxSQPKFp1wgsin+iM3lHpk+uy/75x/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728169; c=relaxed/simple;
	bh=pRMiCWSmdT/39sskvln9Lqj9GrFM1iAS3l+Wg1mhgRo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nVcwNEAIEaPihh5afVwpeMZ1QLz9a7axVVR0VHwrjWlSjSmuC76RAe63ftRRm+SEF9eK0ioz2mJNlB7u5HUezJcekELXL55nUpTMRUNyWYdvpSASCl2eq3NkbkPUxCDJKzyei4CXBPEGAD51t6pznXs5PvJFgsxW1olvGjl8dXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-945a4849260so1218054339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728164; x=1762332964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q95Sls47uHI2sdq/CKZcmwiu4lQuAkZZzY8a8EnVOnQ=;
        b=KwO3YTJp6HGyGaKyq/O1bKe8P+zLs0XqFMNcMYOeOf7im28btMPlHYQOIqpNWj4vt9
         prN1Xgwo1MQhQMeUFxvI+5MP3pmjSkqb8F3iwz7BPbGrakCJbB4wRyC9DLxvq1aDmeTk
         uBlJc6z0gNwUhqPgOQ8l8KG4kMpF+cY1WQ4RtfE4MgZz8J1tM44urapogONNJIntTQ4/
         w0GIfkLBlANFxUCBTUK19qjhQn1Runig/jMI3HJrn5tpJAdLbcUUTYjIOKhuxx5qdHCu
         0Z5Ee6W4MQilKO7Z9yRoUcopNygzQfkbcb8UCwSnJeCYv2si82YDkAG+FBl6J7SHHkQG
         5X2w==
X-Forwarded-Encrypted: i=1; AJvYcCXKRVFVCGVIurEWoXQ3qbjt0lffUcAocMEFFYK9vKvdxwZljxusula3+UBso3LFi5eYOAdlsgUPlINbCbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVs9sIj+6LSuNiafepKFPmqgZ1mUQHHwGPVE4eqsEjUFtf9+r
	W4bvNuF9e3LTi9T+WYLXDUm7HRvK1mbD/fMSvqiaw55eJDl0My5HQN24CaDs1nTtkD82lpv9avI
	ZEutlfVJ2/TR2/YGn3sw2YBPWEdHiWYJx/Rtr6SiSDMeBd9YnW3hHww8gppw=
X-Google-Smtp-Source: AGHT+IFAS4ZC2PGYzsZs5L7Y+5rjiz1mF7L2BDEq8vyRYdSXjv7wVtSCHh5tdHSx9TSX2UuEKkiUVigIAADVE3pyEeGcgUg75L45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:340e:b0:430:c78c:75d6 with SMTP id
 e9e14a558f8ab-432f8fc7ec8mr32392195ab.2.1761728164235; Wed, 29 Oct 2025
 01:56:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:56:04 -0700
In-Reply-To: <20251029062153.ZEpQh%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901d6a4.050a0220.3344a1.041a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
-936049278 + -1759288793 cannot be represented in type 'int'
CPU: 0 PID: 6874 Comm: syz-executor Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <IRQ>
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x466/0x7b0 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 geneve_xmit_skb drivers/net/geneve.c:1004 [inline]
 geneve_xmit+0x1d05/0x2140 drivers/net/geneve.c:1117
 __netdev_start_xmit include/linux/netdevice.h:4824 [inline]
 netdev_start_xmit include/linux/netdevice.h:4838 [inline]
 xmit_one net/core/dev.c:3601 [inline]
 dev_hard_start_xmit+0x294/0x780 net/core/dev.c:3617
 __dev_queue_xmit+0x1678/0x28b0 net/core/dev.c:4203
 neigh_output include/net/neighbour.h:509 [inline]
 ip6_finish_output2+0x1020/0x1490 net/ipv6/ip6_output.c:130
 NF_HOOK+0x45/0x2c0 include/linux/netfilter.h:297
 mld_sendpack+0x5f9/0xa70 net/ipv6/mcast.c:1676
 mld_send_cr net/ipv6/mcast.c:1972 [inline]
 mld_ifc_timer_expire+0x7e1/0x990 net/ipv6/mcast.c:2471
 call_timer_fn+0x105/0x440 kernel/time/timer.c:1444
 expire_timers kernel/time/timer.c:1489 [inline]
 __run_timers+0x5d8/0x7a0 kernel/time/timer.c:1783
 run_timer_softirq+0x19/0x30 kernel/time/timer.c:1796
 __do_softirq+0x23c/0x8ae kernel/softirq.c:298
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x6d/0xb0 arch/x86/kernel/irq_64.c:77
 do_softirq+0xa9/0xf0 kernel/softirq.c:343
 __local_bh_enable_ip+0x10e/0x170 kernel/softirq.c:195
 rcu_read_unlock_bh include/linux/rcupdate.h:806 [inline]
 __dev_queue_xmit+0x1824/0x28b0 net/core/dev.c:4230
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:297 [inline]
 __netlink_deliver_tap+0x50e/0x740 net/netlink/af_netlink.c:315
 netlink_deliver_tap+0x175/0x180 net/netlink/af_netlink.c:328
 __netlink_sendskb net/netlink/af_netlink.c:1257 [inline]
 netlink_sendskb+0x64/0x140 net/netlink/af_netlink.c:1266
 netlink_ack+0x8c0/0xc00 net/netlink/af_netlink.c:2473
 netlink_rcv_skb+0x1fc/0x390 net/netlink/af_netlink.c:2509
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x7b7/0x9b0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x968/0xb50 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:651 [inline]
 __sock_sendmsg+0x15c/0x170 net/socket.c:663
 __sys_sendto+0x323/0x430 net/socket.c:2005
 __do_sys_sendto net/socket.c:2017 [inline]
 __se_sys_sendto net/socket.c:2013 [inline]
 __x64_sys_sendto+0xda/0xf0 net/socket.c:2013
 do_syscall_64+0x34/0x50 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1
RIP: 0033:0x7f2fd8c899e3
Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 81 7b 21 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
RSP: 002b:00007fff58713e38 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2fd99fd620 RCX: 00007f2fd8c899e3
RDX: 0000000000000020 RSI: 00007f2fd99fd670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fff58713e54 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f2fd99fd670 R15: 0000000000000000
================================================================================


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=12be9932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39182a54870857eb
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16911258580000


