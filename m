Return-Path: <linux-kernel+bounces-640509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FEAB05C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 00:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC45F4E6FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479792248BF;
	Thu,  8 May 2025 22:03:26 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A21A2390
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741805; cv=none; b=HlbT9ozE3tOzv2Bb3sqtycfj5f6woPG7DGXBU+VNgTI1cv99AlIBZitSnRwleA5F5PI8+LXjeZLLkSzo0Ogvb2QsjNc4NLsZdfrqwkqNUlEIb9kZKxilupeMhzrrVdNTsb1qLMGj9jj/3c6iaSMkzYo0ycw7QpuaWKXr8Ly/Lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741805; c=relaxed/simple;
	bh=TX+PctmJWWfUvqvfJtiy2aN8LhpIEpGF4yfTFqHhX+c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kvT2dSQUUSy+6oVFkLNwbbtOc8iWEafouxxNtouX2RsMYjuJYWKdJ1mo1aiFR8I0tlyid7qVdimBsTwD3X95Om6jCDDk2SpwufCh6X+SRO43pt7tO4IrppettAiW50h5XNFUl7K8u5EfkkmPqWCZfG5+sMLxLTLuSnrLNdtvPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3da6fe3c8e7so16084785ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 15:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741803; x=1747346603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2Z8O17rdEqEnRr33DkcLROoYgxs4zBnoOEpWAuvAG0=;
        b=eXTAmqoch+MGd8XI5+QCEdVadYUA+nuWA89TYpr9Yra/v53nvBF8cs8tlYDE4iEH2G
         n52jngIUFY54IkGIkL3xwiqouiKzw2FzroLQxYyYkJZD9cIFv2P96fKrVnmPip3u/unq
         RKJVqFTU2FUqr1J8HMl8yd6Hi3i7pXG03Gig/t35SoY9zrgTZPo7AaMVI59QFhfnE3dN
         lSF0r8tO/0lqfP/R8753g5UOo/Lm/DyuxbXQsq7CTjCqUos/eceW/9RlG1VgZg68vGc6
         UbmkFQpeyYXeHGAF1SoX6Z3h7nr/s1sy2At47xETqjMdQtc5NkyPKlNXpOwIP3go6/lp
         i6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX71oEEjRK1Yokqsz3JBMGjfeCzCXJPEsbQ6uiZFZYP5tqoXk7zrp8WmhJveRlkrBm7gwlyfaxhvr9h1v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO54auVlaBGYgM+2yWZqU/YSCDlRnT5ADtx0/AO40QcztyeWZ3
	yfrtM7WnResmrDe7+UQaJuQFsCst3ST9I7AytWW/e8TbVHDHEg5pcsBROecH//mbf/8qqQ9JLLf
	zBT/SAGDnGVjJfCz8ZNxQvvUcQyc29/1ITSij3QIU6CpBaddRDnTQF5c=
X-Google-Smtp-Source: AGHT+IHxzrHRtjHFxDbutITwcVlk4+TYbna9fFGlHlwJa/ckaHIs61Q7Bz6rJEHARK84pTAShXCVCWvepZBBnvbE8Omnr+pAZvkS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349f:b0:3d8:2178:5c63 with SMTP id
 e9e14a558f8ab-3da7e1e26a7mr18304465ab.4.1746741803270; Thu, 08 May 2025
 15:03:23 -0700 (PDT)
Date: Thu, 08 May 2025 15:03:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681d2a2b.050a0220.a19a9.011e.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_drop (2)
From: syzbot <syzbot+a2ab250fa8de8ee78a3f@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0f4c8dd9d2d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=143350f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=868079b7b8989c3c
dashboard link: https://syzkaller.appspot.com/bug?extid=a2ab250fa8de8ee78a3f
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/463c704c2ee6/disk-e0f4c8dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bb99dd967d9/vmlinux-e0f4c8dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/505fe552b9a8/Image-e0f4c8dd.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2ab250fa8de8ee78a3f@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_conn_timeout on wq hci4
WARNING: CPU: 1 PID: 26 at kernel/workqueue.c:2258 __queue_work+0xe38/0x1230 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 26 Comm: kworker/1:1 Not tainted 6.15.0-rc4-syzkaller-ge0f4c8dd9d2d #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events l2cap_chan_timeout
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_work+0xe38/0x1230 kernel/workqueue.c:2256
lr : __queue_work+0xe38/0x1230 kernel/workqueue.c:2256
sp : ffff8000977277c0
x29: ffff800097727810 x28: 1fffe0001aa28400 x27: ffff0000d53712c0
x26: ffff0000ee275000 x25: dfff800000000000 x24: 0000000000000008
x23: ffff0000ee2751c0 x22: 0000000004208060 x21: 1fffe0001dc4ea38
x20: ffff800092804000 x19: ffff0000d4f38960 x18: 00000000ffffffff
x17: 0000000000000000 x16: ffff80008ada5d6c x15: 0000000000000001
x14: 1fffe00036711ae2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff600036711ae3 x10: 0000000000ff0100 x9 : 321ee84465be0000
x8 : 321ee84465be0000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800097727118 x4 : ffff80008f3f4fa0 x3 : ffff8000807ab99c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __queue_work+0xe38/0x1230 kernel/workqueue.c:2256 (P)
 __queue_delayed_work+0xfc/0x2c8 kernel/workqueue.c:2509
 queue_delayed_work_on+0xe4/0x194 kernel/workqueue.c:2561
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 hci_conn_drop+0x174/0x280 include/net/bluetooth/hci_core.h:1663
 l2cap_chan_del+0x228/0x470 net/bluetooth/l2cap_core.c:671
 l2cap_chan_close+0x424/0x684 net/bluetooth/l2cap_core.c:-1
 l2cap_chan_timeout+0x120/0x280 net/bluetooth/l2cap_core.c:431
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 104354
hardirqs last  enabled at (104353): [<ffff8000804152dc>] __cancel_work+0x158/0x218 kernel/workqueue.c:4344
hardirqs last disabled at (104354): [<ffff80008041090c>] queue_delayed_work_on+0x54/0x194 kernel/workqueue.c:2557
softirqs last  enabled at (104348): [<ffff800089026b4c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (104348): [<ffff800089026b4c>] release_sock+0x14c/0x1ac net/core/sock.c:3726
softirqs last disabled at (104346): [<ffff800089026a34>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (104346): [<ffff800089026a34>] release_sock+0x34/0x1ac net/core/sock.c:3715
---[ end trace 0000000000000000 ]---


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

