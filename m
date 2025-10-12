Return-Path: <linux-kernel+bounces-849760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76967BD0CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648F41897977
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA1245031;
	Sun, 12 Oct 2025 21:35:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD421CFFD
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304932; cv=none; b=gEDeWxCDZj/wx82fDpHfb6t8lRSc2vpu+F8kyc3Wxu3dUYU9f7swcY8BdToO4thl9rhG908oy4G2lPfj6gdk6LgGbFCs3AZkcF3czZAtOiUt2qIZTPaDAFJ9KrCqJFgXoatTvrdU6p97rL3ESapIKHqQrqWFRBEsU7JYns4Ymyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304932; c=relaxed/simple;
	bh=n5f6K5I9qJtjZmu0wVLb6/9j12YuJnY3OkDnJyNabEI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FHcbwovaSbbT7xH8oGFiUyipWDyEK/OxuJb456xPrQSfNt1PLtp41gewjCWJFLzluYOU5lOe30mlyAt6aHsib2f9cdb+iBuw1DLVXk0chnzT5in0Uu7vbua6AS52OeTExKsVsWAhsprPKSWx/K7OJ29hnFpo9o9QsKcojyLvYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42a076e4f9eso129602405ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760304930; x=1760909730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEb3jchtK4R0ZydGVnahMUZyWP+mwIRTiaWd4kcSJw8=;
        b=BGScuVADst0hy0D+Eb8eGKkmCjg3yuYgtiAyTGDX8jw6jhulUwcGZShiNvCdWZyuAh
         6CJU5mRD7aGtjEWUygQWTcv9da3b/z/tOKw2kq09avdtGOSfLBlPOlolGPr/pwlbBt/+
         OgEzOian9ypBeGSvvA+h4SkE4+AzJ1h+iWStHzp+8oOsTl0czfE+Hl933t4cLVhivzJy
         oeGiFycSJITCcrpe281Kbfq7Bf3s6+t/aD40T4W/Ud0B219Av5gSLOQAq7p5QMgnHaXS
         oo7pd/1z6d6mDLJzk7LayXi7uBAe/gCFQOghautW7xvMCgCza4RDbmll27vPbDkmAxmk
         XwiA==
X-Forwarded-Encrypted: i=1; AJvYcCUr/tX1HnOGfP0WSAz/vnDtSsHqt/IhL6oZrEWsBlXTDaneUvXMPoth4LN0wJmnXPpfSplZlf5W+5DXBsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZC/YJ3G5bwhw5obBASAqU8iyotCndzGWp+OQhRaSyzlwPedd
	RevqDsyRcYmGuUcBjHjfdYLq8JK6AyRHnNhHiAYl4unYLH9lkap4hSajzrUb0PCl1pe7E7ZQlEk
	+z9eSu+/sXOstRZ6/5xEYGbVAg4sAvOId8CWo47Z25yG/vIaqjecOy79a7o0=
X-Google-Smtp-Source: AGHT+IGIBRV5LPjIhzSPju4tzqJl48jLymReZA+MjG7wIwLOGNYs1CTbyxa1ItYdv2q1bRiCR/Blby5WMSZZHlRUIe2btD7hi2Sf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216d:b0:42f:8eeb:499d with SMTP id
 e9e14a558f8ab-42f8eeb4a47mr144513605ab.8.1760304929709; Sun, 12 Oct 2025
 14:35:29 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:35:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ec1f21.050a0220.ac43.0010.GAE@google.com>
Subject: [syzbot] [net?] WARNING in xfrm6_tunnel_net_exit (4)
From: syzbot <syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8765f467912f Merge tag 'irq_urgent_for_v6.18_rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16eb5b34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/afb0dad890ad/disk-8765f467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/620faf492b85/vmlinux-8765f467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7784fba6e17c/bzImage-8765f467.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at net/ipv6/xfrm6_tunnel.c:341 xfrm6_tunnel_net_exit+0x7e/0x100 net/ipv6/xfrm6_tunnel.c:341
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm6_tunnel_net_exit+0x7e/0x100 net/ipv6/xfrm6_tunnel.c:341
Code: 38 44 12 f8 4b 83 3c 2c 00 75 19 e8 0c 94 ac f7 49 81 fd f8 07 00 00 74 1d e8 fe 93 ac f7 49 83 c5 08 eb c9 e8 f3 93 ac f7 90 <0f> 0b 90 49 81 fd f8 07 00 00 75 e3 48 81 c3 00 08 00 00 45 31 f6
RSP: 0018:ffffc90000117890 EFLAGS: 00010293
RAX: ffffffff8a13affd RBX: ffff8880403b4000 RCX: ffff88801c2bdac0
RDX: 0000000000000000 RSI: ffffffff8d7e835a RDI: ffff8880403b40b8
RBP: ffffc90000117990 R08: ffffffff8f9e1177 R09: 1ffffffff1f3c22e
R10: dffffc0000000000 R11: fffffbfff1f3c22f R12: ffff8880403b4000
R13: 00000000000000b8 R14: ffff88805ae1a480 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d0c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3845a0 CR3: 000000003cee6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:695
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

