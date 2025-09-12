Return-Path: <linux-kernel+bounces-813441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88911B5456E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E263BA63D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F826F288;
	Fri, 12 Sep 2025 08:32:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D82258EF9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665927; cv=none; b=tkueejXvtrBm13jdrGMm17N25qy+G5S8zeT28ja/r8Pmz1zi5nI7MBTNZ1xwMjoIhDmF9gQxI89rOxCmNIoJlqO83oJuVr/9kLuFODSwJN9IrpfDNegl6LTn8Q9hbgLh+DoWgzw71xzQlrM0T+TkY78CPkW02raYI8t8/z7qMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665927; c=relaxed/simple;
	bh=oMqpEuWLjgQPsicdAlQByOZoWjuhOxySa2+OC4V8/4E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mcmkR81G1c7D9gSbyxReslBavtT5sxbyw5Y9UB7thUMjuNlepOA4Um65FaFgdtwIbShcn2TbyaoCpaFonpnP4LGERCtg7uU2RNdedmRy0pysmBzM2CsOj56qNnEmiZm7ItM0/P+EaV3ScRZi8Wqmfr0gXVrCpKtjXzhoqPBht+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-40194dd544eso21179195ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665924; x=1758270724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y095gH/Haho3W9ffFwwkp8K/js02CMjG2hd/4H4v0C4=;
        b=wCwwQk6iaJ5F9KoeQjqTAC4wChne/QKEPzDmYIi1nnDqpwMYvgUErUsER8HxsYrti7
         xlhp5jyZsjJTdBkty8IAP6atY/ZHrUOtv6S3V5q30N/s44Fg7kaAjmpCEAWr6sKOHRf4
         p5GULdIeNtfLWO6DB5DZbtulBtpMqJqceKcp6sBVQ2lLMjrLFcCckBuNWDw6RXo12VrZ
         vaQ+VcfqygllGX7+2ceJrQ3igrRQxeD/rP1niQSenzSMzMVHBdNLXTtrQUETWebAvBtL
         3XruvgS2HW6keQiWsw62KFMU/hsB/7bbkd4AygtRjOYs3K4OKXpMvwbRC4yJV83MNZkZ
         mQmA==
X-Gm-Message-State: AOJu0YyaJEKMB1JHI5kI6JJweF0o5FtCwQCwskoHmjZwKKKL/Ubj5WlG
	+0J405PI4HndCL2TNKvwpoT5w3sI2wzL3XaA923V7Jrwavd1Mh203Ydo5FyfGPC8KNNcmUDy2IT
	AejlLP4/3eEO9uHdB4RpxC8i0K85m3/dWo0FG0Ysdu8u2YgBx0rMxbGiVjN0=
X-Google-Smtp-Source: AGHT+IGLojI017PYcOQk4Ue8NS3+sWtO0EhvFRPW2PwfvKVFmw7yzRJXMGJEBS5VIsSn1vRpK46GP+0xVYtXDt8x1v3rbyh0T54a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3f7:8b02:285c with SMTP id
 e9e14a558f8ab-420a51c37b3mr40590795ab.29.1757665924247; Fri, 12 Sep 2025
 01:32:04 -0700 (PDT)
Date: Fri, 12 Sep 2025 01:32:04 -0700
In-Reply-To: <CAPrAcgMXXKyOCec=SXF6_MD4csgODiO41d0hQ_KsBsRmzoxk+w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c3da84.050a0220.2ff435.0356.GAE@google.com>
Subject: Re: [syzbot] [net?] [usb?] WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rtl8150_start_xmit/usb_submit_urb

------------[ cut here ]------------
URB ffff888024e5b900 submitted while active
WARNING: drivers/usb/core/urb.c:380 at usb_submit_urb+0xf8c/0x18b0 drivers/usb/core/urb.c:380, CPU#1: kworker/u8:8/3539
Modules linked in:
CPU: 1 UID: 0 PID: 3539 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:usb_submit_urb+0xf8c/0x18b0 drivers/usb/core/urb.c:380
Code: 00 00 00 e8 36 e0 85 fa e9 25 f1 ff ff e8 2c e0 85 fa c6 05 35 0c 95 08 01 90 48 c7 c7 a0 aa 56 8c 48 89 de e8 65 6f 49 fa 90 <0f> 0b 90 90 e9 ec f0 ff ff e8 06 e0 85 fa c6 05 77 61 ab 08 01 41
RSP: 0018:ffffc90000a08a20 EFLAGS: 00010246
RAX: e78eb3a935e39000 RBX: ffff888024e5b900 RCX: ffff888030b43c80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c7a6c8 R12: 0000000000000820
R13: ffff888074fffa82 R14: ffff888024e5b908 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881258a7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c81342b078 CR3: 000000007e68c000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 rtl8150_start_xmit+0x2cb/0x5f0 drivers/net/usb/rtl8150.c:696
 __netdev_start_xmit include/linux/netdevice.h:5222 [inline]
 netdev_start_xmit include/linux/netdevice.h:5231 [inline]
 xmit_one net/core/dev.c:3839 [inline]
 dev_hard_start_xmit+0x2d7/0x830 net/core/dev.c:3855
 sch_direct_xmit+0x241/0x4b0 net/sched/sch_generic.c:344
 qdisc_restart net/sched/sch_generic.c:409 [inline]
 __qdisc_run+0xb16/0x15f0 net/sched/sch_generic.c:417
 qdisc_run+0xc2/0x230 include/net/pkt_sched.h:126
 net_tx_action+0x7c9/0x980 net/core/dev.c:5685
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 netif_addr_unlock_bh include/linux/netdevice.h:4823 [inline]
 __dev_mc_add net/core/dev_addr_lists.c:873 [inline]
 dev_mc_add+0xd0/0x120 net/core/dev_addr_lists.c:886
 igmp6_group_added+0x225/0x800 net/ipv6/mcast.c:681
 __ipv6_dev_mc_inc+0x897/0xa50 net/ipv6/mcast.c:972
 addrconf_join_solict net/ipv6/addrconf.c:2246 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:4099 [inline]
 addrconf_dad_work+0x3d0/0x14b0 net/ipv6/addrconf.c:4227
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1668b362580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9134e501f17b95a4
dashboard link: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152a6362580000


