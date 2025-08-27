Return-Path: <linux-kernel+bounces-788884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18379B38BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EAA16AC45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411430E0CD;
	Wed, 27 Aug 2025 21:55:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5493081C3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331733; cv=none; b=q3qAlJpeWo5yoajHVDOF9U863mgjAUwxx5s/8T62tpIs/ygkb23rmg3OuhdgrtbZCro5BnA8zmJT830ZZMTirel5ZpKLXadyca3EBCGg7rFBMwK9jhIXBMHNV7bwSTPRI365CBwqp6DOsCZQ3/qawl7A7N7rx5k9Jx+qq7gkZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331733; c=relaxed/simple;
	bh=fekcYIpj6NxQjUC7dhUDgp2J22u0DhmISBwjnMhI4+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bMTNpZKfPF0x53BMh6NPgrwzUdwVhn8r0smQFRt7BzjQYDcRzcWHZ1DVmQB9mHA5YcrcXeiCo0RuO0OThPKEdlArosPhFg/ez23J2pP/S31cMTv2dgFJ6ScMysByDFGyF0af8TuugcsSCnvuVGYlPxBo+pZba7Legpld2prXJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3eec8f5dc91so3880865ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331731; x=1756936531;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xF+jtFQ9b8zMRrU/Cm5qYAVQe6xzCcpYtRD3ii11fhQ=;
        b=sdO7syIbWIQfciZ7sZxm4Tn0y37zWWNlGAzUFp5XbTB0Cc0BAk+8SkT8J8UvFsXOIp
         SeJK/mbsjDmXNOj69S7BvKXcuToGIzp8UsniKPJxeMxNDDZhsUar5bXytKTaVTQzfRma
         t/Lngd4saQ8oAf1k0//CxAmxMmxblisTrKYNQdCrxAQD0J88BmLKI9XyNbAYwQ7Y0z8J
         W5RtzcaPjqiAkGDL8w/A6OeoTvgn3+R094VUfLC1zrCeJU8Fb3PQGRx9J3knYypFHqDC
         ag5ea6S+xGlqE8HhF6Rped408syGcU53fe/cqmWZXZ25o+eMUhANF3csMeH7p9bZoGC2
         5DSg==
X-Forwarded-Encrypted: i=1; AJvYcCXR+8bJn05Cq3xUibNccQS9KkEzCcAVq5KHNd94ZOioExbPVsTYzRT9eQu7yFdlM5kk1WJqIdXvZ3EjFSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuib9qeJD/4T4RUyBnd6TY4gayGBvDYrrpG4p3SW+KmU/1QVeB
	qUys+jXKe/PzdWgLQ6xlUxLyX2StewDZPTvqOwWylxcJC4LOjxeOTf2rvwcGFi8pC5Uj5sIHPF0
	5d0kxP141bg5I2rDy7MSEmc9L3zHwPHYbGP7luVGV776yMgSdrvIL39+ZnOI=
X-Google-Smtp-Source: AGHT+IES9W9i5BDPnigPWHyPwFFVK8HYOg02PCDU4wDRx1cddarSx3N77jLS8b/A0OljZ6ZaxmpeRG+Ewn6Lzi0PSQIKRrS28joC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:3f0:78c3:8fc5 with SMTP id
 e9e14a558f8ab-3f078c392cdmr43149115ab.5.1756331731412; Wed, 27 Aug 2025
 14:55:31 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:55:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af7ed3.a00a0220.2929dc.0004.GAE@google.com>
Subject: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
From: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fecc42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c94858580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea7bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/page_alloc.c:5124 at __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5124, CPU#0: dhcpcd/5530
Modules linked in:
CPU: 0 UID: 0 PID: 5530 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5124
Code: 74 10 4c 89 e7 89 54 24 0c e8 f4 11 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 fe aa b7 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc90000007780 EFLAGS: 00010246
RAX: ffffc90000007700 RBX: 0000000000000014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900000077e8
RBP: ffffc90000007870 R08: ffffc900000077e7 R09: 0000000000000000
R10: ffffc900000077c0 R11: fffff52000000efd R12: 0000000000000000
R13: 1ffff92000000ef4 R14: 0000000000060820 R15: dffffc0000000000
FS:  00007f4fd75a9740(0000) GS:ffff8881257c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffebb07e018 CR3: 000000001dadc000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:4306
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4337
 __do_kmalloc_node mm/slub.c:4353 [inline]
 __kmalloc_node_track_caller_noprof+0x34d/0x4a0 mm/slub.c:4384
 kmalloc_reserve+0x1b8/0x290 net/core/skbuff.c:608
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
 __netdev_alloc_skb+0x108/0x970 net/core/skbuff.c:733
 rx_submit+0x100/0xab0 drivers/net/usb/usbnet.c:-1
 rx_alloc_submit+0xa6/0x140 drivers/net/usb/usbnet.c:1538
 usbnet_bh+0x9a5/0xd70 drivers/net/usb/usbnet.c:1607
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3579
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 __dev_open+0x694/0x880 net/core/dev.c:1690
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9549
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9612
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1200
 inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4fd76a9378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007ffc26f40168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 00007f4fd76a9378
RDX: 00007ffc26f50360 RSI: 0000000000008914 RDI: 0000000000000016
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc26f60500
R13: 00007f4fd75a96c8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


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

