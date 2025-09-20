Return-Path: <linux-kernel+bounces-825432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CECB8BC99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1C01BC6954
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9F1C84A2;
	Sat, 20 Sep 2025 01:15:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E113D638
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330907; cv=none; b=BgOMuG7uKJCQucNCTYwaDgs9AlRuFIwj7qzNYYxd27vOiFD75qq+c6+xgi3lVcXxkRQ89A5mSnhhcBIwat6+Y5l3YiN7AKEzyjkxZRZw+GtrIUXxjRnKC9nDeMSrkwQey3/06vSifjcBfluUqqwXrgPwyMqWH7qDJQPA+mXrq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330907; c=relaxed/simple;
	bh=DB/GFGkS8aKNGYeyXxRZI3snoffbX/p/4E4ZTzP4UMM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AwCIprgB/Jfj5/XCCcF/WlvMaD68AksYWl9/I8sXZB5FuDVuJ3F2KD8m8I7QhIyug43fK0kVinQp183c3vOZNSbQFee06uOmbxmKLXUE73oCq8/p+ZBzqf9Y45yKdYNoIt6+Xo3MDsyV4HXxhd/QSemurzmWQLUUUjHNFnqkpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8876712ea4bso578407439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758330903; x=1758935703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCAxMeqCdfMkJ4yRsv9UGnJmb0axf7cnFBNw8jyVeaQ=;
        b=PRlnlPVq3nGALiB2f2W97WnTf5UnSnM5RWan2ciJl4zYP+ubJoV0FTMoBSdtTIy8ih
         g3/1U8bx+pB0E9N3inB7OvIOe6WnaHumsEs3Ln8WfarhqkHfYJDkh84rw9erpf/yQBGt
         fV9XgmWPDiaOD6ghzh092SIbSZteLeVx1k8Pwhy/ojc5kF44oSk8B8Pyze1JItLeiYsT
         mZsYaN5UZtJimEQR2c+/D0+rqReUJVhCSiXernrG6R0uPHTuplJ5l0Ja+00dUzee90AD
         FNXEBsgkmkE2646b5jN8IS5/gsWEmr2Gw9Z+rbWAy8vXzeuXpVAhXCMAdFopEc5qLalQ
         PTuA==
X-Forwarded-Encrypted: i=1; AJvYcCU3yQ99pOzfHf4SwmUswodChOJi0+LbzaVaksNe+5G2Lhs/YoWiq8+CpFZFMHAgr3tULbWPzOxw88JzhRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBR9J/qIUyL6Ll7I9indu2YrDbUVwuykyV8iZV/pCdTmc5nFeX
	WcAeeODmwv/1Y+CPM/P9lgGMbyECtMP3/LiuC0xafIVkizF0VjQBuoXiAup9hroCB/hNOUMWH+f
	sGX4QHj6CfsGXZ1p5MonyxOx5WjUamRjqbKFXaufJxOAGhRWylkTFwTe0BXg=
X-Google-Smtp-Source: AGHT+IGunvPAb6JbLloJHVqCsAMOuX1/DjL0GlMTdb47huZa5bHr7radLQ/lvQGcSTVhRQmpfl6XsKLVv0A2SDYRxK9vr98N2oLl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c7:b0:424:388:6ced with SMTP id
 e9e14a558f8ab-4248192733bmr88771405ab.14.1758330903531; Fri, 19 Sep 2025
 18:15:03 -0700 (PDT)
Date: Fri, 19 Sep 2025 18:15:03 -0700
In-Reply-To: <20250920004306.7233-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce0017.050a0220.13cd81.000d.GAE@google.com>
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
From: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __alloc_skb

------------[ cut here ]------------
WARNING: mm/page_alloc.c:5135 at __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5135, CPU#1: dhcpcd/5527
Modules linked in:
CPU: 1 UID: 0 PID: 5527 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5135
Code: 74 10 4c 89 e7 89 54 24 0c e8 f4 b7 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 25 c9 b7 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc90000a086e0 EFLAGS: 00010246
RAX: ffffc90000a08700 RBX: 0000000000000014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90000a08748
RBP: ffffc90000a087c8 R08: ffffc90000a08747 R09: 0000000000000000
R10: ffffc90000a08720 R11: fffff520001410e9 R12: 0000000000000000
R13: 1ffff920001410e0 R14: 0000000000060820 R15: dffffc0000000000
FS:  00007f141af9a740(0000) GS:ffff8881258a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fc915d6138 CR3: 000000007caf0000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:5543
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5574
 __do_kmalloc_node mm/slub.c:5590 [inline]
 __kmalloc_node_track_caller_noprof+0x133/0x800 mm/slub.c:5711
 kmalloc_reserve+0x1b8/0x290 net/core/skbuff.c:609
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 __netdev_alloc_skb+0x108/0x970 net/core/skbuff.c:734
 rx_submit+0x100/0xab0 drivers/net/usb/usbnet.c:-1
 rx_alloc_submit+0xa6/0x140 drivers/net/usb/usbnet.c:1538
 usbnet_bh+0x9a5/0xd70 drivers/net/usb/usbnet.c:1607
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3607
 tasklet_action+0xc/0x70 kernel/softirq.c:952
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:queue_work_on+0x1f7/0x270 kernel/workqueue.c:2397
Code: 4d 85 ff 75 16 e8 b9 ce 35 00 eb 15 e8 b2 ce 35 00 e8 9d 57 03 0a 4d 85 ff 74 ea e8 a3 ce 35 00 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 04 2e 00 00 00 00 66 43 c7 44 2e 09 00 00 43 c6 44 2e 0b 00
RSP: 0018:ffffc900034a7600 EFLAGS: 00000293
RAX: ffffffff818a4a7d RBX: ffff8880560d9201 RCX: ffff88802eb3bc80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900034a76f8 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
R10: dffffc0000000000 R11: fffffbfff1fc9b6f R12: 0000000000000000
R13: dffffc0000000000 R14: 1ffff92000694ec8 R15: 0000000000000200
 queue_work include/linux/workqueue.h:669 [inline]
 usbnet_open+0x5c6/0xce0 drivers/net/usb/usbnet.c:958
 __dev_open+0x470/0x880 net/core/dev.c:1682
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9630
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9693
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1199
 inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0xdc/0x300 net/socket.c:1241
 sock_ioctl+0x576/0x790 net/socket.c:1362
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f141b09a378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007fff3eacfd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007f141b09a378
RDX: 00007fff3eadff10 RSI: 0000000000008914 RDI: 0000000000000012
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff3eaf00b0
R13: 00007f141af9a6c8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
----------------
Code disassembly (best guess):
   0:	4d 85 ff             	test   %r15,%r15
   3:	75 16                	jne    0x1b
   5:	e8 b9 ce 35 00       	call   0x35cec3
   a:	eb 15                	jmp    0x21
   c:	e8 b2 ce 35 00       	call   0x35cec3
  11:	e8 9d 57 03 0a       	call   0xa0357b3
  16:	4d 85 ff             	test   %r15,%r15
  19:	74 ea                	je     0x5
  1b:	e8 a3 ce 35 00       	call   0x35cec3
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 04 2e 00 00 00 	movq   $0x0,(%r14,%r13,1) <-- trapping instruction
  31:	00
  32:	66 43 c7 44 2e 09 00 	movw   $0x0,0x9(%r14,%r13,1)
  39:	00
  3a:	43 c6 44 2e 0b 00    	movb   $0x0,0xb(%r14,%r13,1)


Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b15c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f2a0e2580000


