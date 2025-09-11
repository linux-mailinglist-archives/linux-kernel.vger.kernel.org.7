Return-Path: <linux-kernel+bounces-812000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0D1B53172
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D925809DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68231A54D;
	Thu, 11 Sep 2025 11:52:29 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111D3168E3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591548; cv=none; b=MXZa2rO0nddDHPlrYCy5wvYrDy8DrMriznH8QzBuZ/A1NG+MwA2JZFImZb8N9OhmhFeceZ1F/ed3yFlPYRevbl6SPepWDqGJKcNoTgsm8s+k0paNyY2RhHajJE6O07njolHaHoDIRZD1XJp6HNXGoOl0p6gXS3RPo1bYMnjnwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591548; c=relaxed/simple;
	bh=9I1dDeFisZPnn+Dj5yfAWExpYnabZbSAjwN3+8HYvKY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tUrlch4Harb1dfbL4IJg1LBh6mpSyCg7jZRqIDKclcesIEXVeNNUW0xI9vr0+s2KWh2IU4ppCmqQcP0ghzJW1B/9gJ/vjgbbyOM4U1KYZOwZvNOB6cRPKJgkkX7K5Nnnh7hH9nIHqDTuHkvqriTLq/oLtpXZL5JbTaGuzghvrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-887ee7475faso148100239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757591546; x=1758196346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtoXk8z03mWc2+w7zwKiztYGHI1iB1uUwX6rxxpxAcU=;
        b=ZpnJNxtxnuxTp8JnpZq3Ddulut2GPXe7xvtFzmxKAFvPu0E8MuX0WUYOfGbAgbMWxP
         pBneQXkUrCNCzwxRzK4CA1Ye5KUVRI4GyKpLDCPTqtZR805htKZPoFx7T/SIFMYw/8Oo
         nH23adZ+IYY3ylUTBl06h0om4+PYqfY35iw9nZ1Ph+E+6vxOsVh7Xfpskkef6nu9K/Qf
         hwVNatDH24AjrkKZBEbCy4uob5QCbvExt7iB0y5klTKQjilWL36wDXGySzEISDc91+dj
         bosPFPvf+BCn9+lXdwbJ1YFjgVgfh7Kza1ws21bm/WILg6c6qwnZ0Xo/pTjC6pSTHRzm
         Phnw==
X-Forwarded-Encrypted: i=1; AJvYcCUCW1g4bq5mwPERg8Tuw83Gxpn8MtprS9nCoVfQihRBx6xHQxDCpDouFInCi1suM6fSxq5S90G8KDQ8qps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuuyxzrqqxy3POf102dZNt+fpEqwz3KsCBKrUr9nFL+X42Rir+
	F4n4CtLWSWcmEquBV0vO2MPvFtVCx+6hbX/qoQlOCw0w0hkmAduAlallwOO5QMFL8/QYIK2EUoP
	a/BuX06BzeZKkBmvY8J7IB/dfRVITd5I55qYMxzA7r9P7dGDZoSWiG0fVdQk=
X-Google-Smtp-Source: AGHT+IFYDX+BJN9kmL9kfvs21waufLxbmjzXrq1W+X1L98qiMLcKz0YIm1LnUBkU40f4IVH2y6OMbFpUda2Gr1cY4h0gwae6Ih0I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3781:b0:3f6:54d1:451e with SMTP id
 e9e14a558f8ab-3fd8cdbe2b1mr276938355ab.1.1757591545786; Thu, 11 Sep 2025
 04:52:25 -0700 (PDT)
Date: Thu, 11 Sep 2025 04:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c2b7f9.050a0220.3c6139.003d.GAE@google.com>
Subject: [syzbot] [wpan?] KMSAN: uninit-value in crc_ccitt (3)
From: syzbot <syzbot+29d74bf076f40407a62a@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b236920731dd Merge tag 'rust-fixes-6.17-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1451fa42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ee07385471829e7
dashboard link: https://syzkaller.appspot.com/bug?extid=29d74bf076f40407a62a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a67f2d67e93e/disk-b2369207.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59e5d1fccb4a/vmlinux-b2369207.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f501250ee790/bzImage-b2369207.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29d74bf076f40407a62a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc_ccitt_byte include/linux/crc-ccitt.h:13 [inline]
BUG: KMSAN: uninit-value in crc_ccitt+0x21e/0x2a0 lib/crc/crc-ccitt.c:60
 crc_ccitt_byte include/linux/crc-ccitt.h:13 [inline]
 crc_ccitt+0x21e/0x2a0 lib/crc/crc-ccitt.c:60
 ieee802154_tx+0x2c4/0x7e0 net/mac802154/tx.c:74
 ieee802154_hot_tx net/mac802154/tx.c:207 [inline]
 ieee802154_subif_start_xmit+0x183/0x290 net/mac802154/tx.c:239
 __netdev_start_xmit include/linux/netdevice.h:5222 [inline]
 netdev_start_xmit include/linux/netdevice.h:5231 [inline]
 xmit_one net/core/dev.c:3839 [inline]
 dev_hard_start_xmit+0x22c/0xa30 net/core/dev.c:3855
 sch_direct_xmit+0x3b2/0xcf0 net/sched/sch_generic.c:344
 __dev_xmit_skb net/core/dev.c:4114 [inline]
 __dev_queue_xmit+0x3588/0x5e60 net/core/dev.c:4691
 dev_queue_xmit include/linux/netdevice.h:3361 [inline]
 dgram_sendmsg+0xcdb/0x16d0 net/ieee802154/socket.c:689
 ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:729
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2614
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2703
 x64_sys_call+0x1dfd/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable rf created at:
 __schedule+0x3b/0x7790 kernel/sched/core.c:6827
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x17d/0x3c0 kernel/sched/core.c:7058

CPU: 0 UID: 0 PID: 7766 Comm: syz.2.4465 Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


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

