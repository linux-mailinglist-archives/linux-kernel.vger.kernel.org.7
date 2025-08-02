Return-Path: <linux-kernel+bounces-754241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E94B19099
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35026175F43
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691B21D3F8;
	Sat,  2 Aug 2025 23:17:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608D2BAF7
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754176624; cv=none; b=APXrbIPwXNqaL6SdlVJzvmiuVbaWanuk3vqf/sNRwPnX+rdNPlG71NRwDdKmDg4Ff6yygueawWov3Ul+YrOUGymRcmY2mCH9QVY8vN5tAUQKP3t74mnuggbBwGhbpWD+72YJ6xoUSDA3QjybzZ/6gVn8tZwCBXDzz7Ux44uzFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754176624; c=relaxed/simple;
	bh=8PSYRoqsepb3UkQNjlWtyS4E8AnfZLYn5yiAadYKEuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NQYIhsHNzb5d1YbqJtYDxbNCKEQHE2pbvQVpRKIf99tYa1pGeoPHmG0xPxOp/tTltiDP4eTi2exgtyElFYAaPPtHJNiQWAY0iQ3UHB999yjs/e+d30csFfiirQQqB7baWErHcvUVFW5JqsvtMHtTJ7U6yggT0LPcYETClI4hOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c1d70dabdso198113439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 16:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754176622; x=1754781422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqfVxlFUdazMCAr833nD+NMEo77zVzJ5pxvtGUP227w=;
        b=uz0DxI0UFfZqST4URP4b6KXk2b6cXGRPN4muSuykSTTM2AjISA8bFMjWUmbXStFxgQ
         Ug1rlFuM1rHW2nAsINjl6sesFnFJwPvexrjELh13qjCAlYoIsXcq2JAh1KaJsZQgr/sl
         2NLzAFS2ytKG4JkACrNIITFWM59d3uKeyNhT2ZP8E6S5SF3+3A58lyEncdfj/9tdThaj
         6i/I0CbsgsuKmnIiN5jeU0hbaquyReNHKyIpWISMemfqSuffsnDx/3SqNPNPV6HpiTxx
         +ySDzp+Z+Z8NZ5WdL0vZNmvj5cM7pRxZ7QsYnG/8LunIAWPksIW1E9mrXRHIcYhNaLnG
         /87A==
X-Gm-Message-State: AOJu0YwjrBbVC0iHJxs8MfLhu25w5wd02jNURCXnFuyznR+PGC04JHAs
	QuNfD7YQfm3uunw3leLI45WzJnoBR0qK7CWIZFfYU89OdFQCwXNDv1Vbc5jyrg8GHr7GbAIPh51
	dw52D+X6Hik7rlz5fVZc3GDf7eUYeSBiUITPueQGUTig+CTV+nLDsF31hEPU=
X-Google-Smtp-Source: AGHT+IETLrKhRfooNVU1OWIxg8XatjxSM/wCP3aC+j2sc/KWo9SzF5hY8cRjF2J0i4QT7uQBN66miLb2Ma2RKZEtZwUl+YLSfVEe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc4:b0:3e2:c538:e178 with SMTP id
 e9e14a558f8ab-3e416109b6bmr87524115ab.1.1754176621823; Sat, 02 Aug 2025
 16:17:01 -0700 (PDT)
Date: Sat, 02 Aug 2025 16:17:01 -0700
In-Reply-To: <CALkFLL+Rdkg+-WA+Jb10QfnPoiYpVqHRi+NUvNiAw=XLe6kuhg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e9c6d.050a0220.3627e7.0000.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ujwal.kundur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_KEYS too low!

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 17006 Comm: syz.0.1967 Not tainted 6.16.0-syzkaller-g186f3edfdd41-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 register_lock_class+0x2e8/0x320 kernel/locking/lockdep.c:1332
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 blk_freeze_acquire_lock block/blk.h:738 [inline]
 blk_freeze_queue_start block/blk-mq.c:184 [inline]
 blk_mq_freeze_queue_nomemsave+0xd5/0x120 block/blk-mq.c:205
 blk_mq_freeze_queue include/linux/blk-mq.h:934 [inline]
 elevator_change+0xd5/0x320 block/elevator.c:666
 elevator_set_default+0x186/0x260 block/elevator.c:742
 blk_register_queue+0x35d/0x400 block/blk-sysfs.c:905
 __add_disk+0x677/0xd50 block/genhd.c:528
 add_disk_fwnode+0xfc/0x480 block/genhd.c:597
 add_disk include/linux/blkdev.h:773 [inline]
 nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1973
 nbd_genl_connect+0x919/0x18f0 drivers/block/nbd.c:2114
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe578b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe579a4d038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe578db5fa0 RCX: 00007fe578b8e929
RDX: 0000000020000000 RSI: 0000200000001ac0 RDI: 0000000000000004
RBP: 00007fe578c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe578db5fa0 R15: 00007ffe9f356178
 </TASK>


Tested on:

commit:         186f3edf Merge tag 'pinctrl-v6.17-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ea7f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18eb6d916c138763
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eddcf0580000


