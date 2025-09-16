Return-Path: <linux-kernel+bounces-819389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67961B59FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83663AA5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FBE27E1B1;
	Tue, 16 Sep 2025 17:56:37 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949B2905
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045396; cv=none; b=UMsVzRF8s2JDPWQSPoqEVLKdhwKwGjJg2CwA18o0oJSNWCmLzDZCr2jsjL/tPpo6zcVcvQfbMM1/90ke9lyZ1wskyzVxo3OEjOHNedCn3eyauONUFUv42z9eNh87CxYXvzcJMixuvHJLQyRfLh+hhJO8Th1y6ekBC+s5rRDOZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045396; c=relaxed/simple;
	bh=sIkxmNxwZY3pKnFW8g80KFYKGy+YnrsyWI7Cv3dEb/4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u1sNsG2/x+9ntn9PJrTJsJsb+QZEY7iTM1vrkm7T5exbtJ4crSFf1yVxjzF8TnPdxT1GZjvN9mHsC8ZOVJQHzbEZ149ckiRx24LFeLefeJFrndlno5G47VWouGotLYAAHt1hRKUSKj+MYm5aNbf8mj7Lvo1UbJ9GeiUomL3SVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f736aa339aso152076945ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045394; x=1758650194;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt+EVcMfYkAab4seH7/6hHx6f6De5Lofhg1bLZRxlHo=;
        b=hLSQnF49sqFdRQDdWFX/qCDhBPD1oLACauUdJN0PiYOovYvphJo5pe6k3qJOyNSDx3
         6rkRS+uCkZhi1sBTftYvJS6tVliqn4GaJGffmckbfDEZFiZOBvXj+5ZBapQUd2rpsbIW
         5StjZSQ4JBJR+YqrRlIBUAuTbJsW/6nB9ZMLkjNJBxC8dKKCf4WnVYaRDs1ncHmMzLBW
         1+UaHMb9jhvknEGupkNrsqhZdhGejC4a0UaTFkY5zmWB/m8pGzJksXQqqHwg3TaVCe9i
         8+Nij4Bf/A9F3zaDelWFvPVkuSqQxAzrlwfkLpga5CfvW4tJpqr2zipC2hXz9GNCecQU
         3upA==
X-Forwarded-Encrypted: i=1; AJvYcCU38IAJ0Kz7kRJNmhJAXYgt83yvavQ5G3LMwLwA6kxFT27rjVLbQUehW0MC4/kT6S5JR/NKq8vsKnATnPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1Y5xkShEFfVFuUX1LAe4tOS3q6o+r5slghFeTN7r6wkm2ZUl
	Mi+w+a0kD05l3gJOcikkm6RItjlM3dFMmGSsDUy40u7iS7tTgF4V//vZlEx28NDYFdiOmasRYSK
	FBwnp7HRllQhuYBNEpk9TsSeEmagFMANM617afBbX3PtNrzIs30D3mRv+ka4=
X-Google-Smtp-Source: AGHT+IHlnsOH2Pw34A86srI+GeZUnwPgKUCtNJK2xb3omFAOO90J3Z/Prbeq7Dq4RGTDFpXxNMnVqmJdzEIZ534arbXgcdlbVn2V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250b:b0:424:771:418e with SMTP id
 e9e14a558f8ab-4240771429bmr63791835ab.30.1758045394379; Tue, 16 Sep 2025
 10:56:34 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:56:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9a4d2.050a0220.3c6139.0e63.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in find_match (6)
From: syzbot <syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e2291551827f Merge tag 'probes-fixes-v6.16-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126aad8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=6596516dd2b635ba2350
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091958c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c89382580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e2291551.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8873881d7728/vmlinux-e2291551.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c85b06341ad0/bzImage-e2291551.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6dce6e633409/mount_8.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17c3e7d4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000018: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
CPU: 0 UID: 0 PID: 3043 Comm: kworker/u4:11 Not tainted 6.16.0-rc6-syzkaller-00037-ge2291551827f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__in6_dev_get include/net/addrconf.h:347 [inline]
RIP: 0010:ip6_ignore_linkdown include/net/addrconf.h:443 [inline]
RIP: 0010:find_match+0xa3/0xc90 net/ipv6/route.c:781
Code: 00 00 00 00 00 fc ff df 42 80 7c 25 00 00 74 08 48 89 df e8 cf c4 fc f7 48 89 d8 bb c0 00 00 00 48 03 18 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ae c4 fc f7 48 8b 1b e8 f6 60 48
RSP: 0018:ffffc9000d5ce430 EFLAGS: 00010206
RAX: 0000000000000018 RBX: 00000000000000c0 RCX: 0000000000000000
RDX: ffff88803f90c880 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff1100b37b324 R08: ffffc9000d5ce7c0 R09: ffffc9000d5ce7d0
R10: ffffc9000d5ce620 R11: ffffffff8a26ecd0 R12: dffffc0000000000
R13: 0000000000000002 R14: 1ffff1100b37b326 R15: ffff888059bd9937
FS:  0000000000000000(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd76fadfd8 CR3: 000000000df38000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 rt6_nh_find_match+0xd9/0x150 net/ipv6/route.c:821
 nexthop_for_each_fib6_nh+0x1cd/0x400 net/ipv4/nexthop.c:1516
 __find_rr_leaf+0x461/0x6d0 net/ipv6/route.c:862
 find_rr_leaf net/ipv6/route.c:890 [inline]
 rt6_select net/ipv6/route.c:934 [inline]
 fib6_table_lookup+0x39f/0xa80 net/ipv6/route.c:2232
 ip6_pol_route+0x222/0x1180 net/ipv6/route.c:2268
 pol_lookup_func include/net/ip6_fib.h:617 [inline]
 fib6_rule_lookup+0x348/0x6f0 net/ipv6/fib6_rules.c:125
 ip6_route_output_flags_noref net/ipv6/route.c:2683 [inline]
 ip6_route_output_flags+0x364/0x5d0 net/ipv6/route.c:2695
 ip6_route_output include/net/ip6_route.h:93 [inline]
 ip6_dst_lookup_tail+0x1ae/0x1510 net/ipv6/ip6_output.c:1128
 ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1259
 udp_tunnel6_dst_lookup+0x231/0x3c0 net/ipv6/ip6_udp_tunnel.c:165
 geneve6_xmit_skb drivers/net/geneve.c:957 [inline]
 geneve_xmit+0xd2e/0x2b70 drivers/net/geneve.c:1043
 __netdev_start_xmit include/linux/netdevice.h:5215 [inline]
 netdev_start_xmit include/linux/netdevice.h:5224 [inline]
 xmit_one net/core/dev.c:3830 [inline]
 dev_hard_start_xmit+0x2d4/0x830 net/core/dev.c:3846
 __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4713
 dev_queue_xmit include/linux/netdevice.h:3355 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x11bc/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:317
 mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1868
 ipv6_mc_dad_complete+0x88/0x4b0 net/ipv6/mcast.c:2293
 addrconf_dad_completed+0x6d5/0xd60 net/ipv6/addrconf.c:4339
 addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__in6_dev_get include/net/addrconf.h:347 [inline]
RIP: 0010:ip6_ignore_linkdown include/net/addrconf.h:443 [inline]
RIP: 0010:find_match+0xa3/0xc90 net/ipv6/route.c:781
Code: 00 00 00 00 00 fc ff df 42 80 7c 25 00 00 74 08 48 89 df e8 cf c4 fc f7 48 89 d8 bb c0 00 00 00 48 03 18 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ae c4 fc f7 48 8b 1b e8 f6 60 48
RSP: 0018:ffffc9000d5ce430 EFLAGS: 00010206
RAX: 0000000000000018 RBX: 00000000000000c0 RCX: 0000000000000000
RDX: ffff88803f90c880 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff1100b37b324 R08: ffffc9000d5ce7c0 R09: ffffc9000d5ce7d0
R10: ffffc9000d5ce620 R11: ffffffff8a26ecd0 R12: dffffc0000000000
R13: 0000000000000002 R14: 1ffff1100b37b326 R15: ffff888059bd9937
FS:  0000000000000000(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd76fadfd8 CR3: 000000000df38000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 42 80             	filds  -0x80(%rdx)
   3:	7c 25                	jl     0x2a
   5:	00 00                	add    %al,(%rax)
   7:	74 08                	je     0x11
   9:	48 89 df             	mov    %rbx,%rdi
   c:	e8 cf c4 fc f7       	call   0xf7fcc4e0
  11:	48 89 d8             	mov    %rbx,%rax
  14:	bb c0 00 00 00       	mov    $0xc0,%ebx
  19:	48 03 18             	add    (%rax),%rbx
  1c:	48 89 d8             	mov    %rbx,%rax
  1f:	48 c1 e8 03          	shr    $0x3,%rax
* 23:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  28:	74 08                	je     0x32
  2a:	48 89 df             	mov    %rbx,%rdi
  2d:	e8 ae c4 fc f7       	call   0xf7fcc4e0
  32:	48 8b 1b             	mov    (%rbx),%rbx
  35:	e8                   	.byte 0xe8
  36:	f6 60 48             	mulb   0x48(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

