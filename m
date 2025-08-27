Return-Path: <linux-kernel+bounces-787753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84187B37A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7193AA7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF6D3126AC;
	Wed, 27 Aug 2025 06:44:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6A18FDDB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277046; cv=none; b=MnpuzeqWfqqjmYZpAmqUkl7szUj5jBsLXVzBJWM1hK9ae8ZjFIyrIwhxBI0fAXOMTu/lgwUfXSwZ3jdrKOejUucLpaE2JAY8gv97Aw9HsRSyNKbZDaXO/W+Ssps+1ZKHrTF7SKfUiSO6qRUuC0eDJbK0frSKzb2UQ++U9qLFEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277046; c=relaxed/simple;
	bh=U9LTAweUuSf6BHsATQjY125GEOAYBMNyGIlNk1KDM8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b2bRjmcJPHtFaOrZtzkSAXTS3yykc4T9LWVziaY1pbiFrLEYIsIV5r8cavBxC1HT0VA/YlBwlTEpMisXu6wOz9evQFemyQDQm/fZ7nvQEEUfGOJSJ5eb/FkIeDg1v5WE76IetigDiVQ4xKjyeW5BAent4+YB/lprq/mvptJ+pPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eea931c037so54137495ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277043; x=1756881843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKo7oW3auFYjwhQGWrNtptmthq41J3swkF5oBFWbLes=;
        b=XVvsnFm6nWoBN5UvRM4bFSO/Y/7jf22A9fC+apAmaaugSL4ZrD2BR5RK5TZII+aK+u
         uESKWUFHrwebwkcvJSYgLDUCGu2IFPQKBSZ0sLk2I78IGRJNPyQLEX0JGnNo6xXmfOdr
         A/ZAwaGlD2oWrTZ3ULs3nakWe3Csui6fOaX5HOJ8UoS8zug1HkuAWFiWY5OLNMOLHVDK
         a9fsh0RI3PuSlNq7TcAn1oqDvSuf1pD/jF+DPCWHPK/Jt7RTvGu37ANioKOPeI6lt+El
         sCoFpxHvhlMrVGSuMtziGmZGwZng6n3S3nQz4FVrrcgYBSyg0H6uVxBxLya8cPVhf5YN
         /0kA==
X-Forwarded-Encrypted: i=1; AJvYcCWinxPF3f9GBWiwfa/ueQGkpI5DX5fD43R4FZjbj08AWSzMWQYWsMKeKR6oupEWzIE4n3G0D2CPxTkSfr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsO44l+ksa/H5Q9qUPcpiwb9fp5/zogrhxFO1IkkyYBoiw2kb
	fdpn+1UYd8y9excHjdlfPfDJ4CFLZSd1ngFrk3UeT/mgS3/F6ZUGT2U1tJLfTzeDXxy5qYpzDmS
	2FCsl/a0Bn2XQdQS67Pm/+yeUjwUub0WjNmbbnMdCxgaAU2gNbFzE2d0h8X4=
X-Google-Smtp-Source: AGHT+IEYBS4Q+NPboZczswNNqZ0JnPN9We4MEczlha5CumSIhRpcHmMWZ3jOSZvyXpFrb1sNm+78TSesGGRrPVP10ArBWdCKK5k3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c86:b0:3ee:1a2d:f73d with SMTP id
 e9e14a558f8ab-3ee1a2df976mr100776615ab.27.1756277043621; Tue, 26 Aug 2025
 23:44:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:44:03 -0700
In-Reply-To: <20250827051822.5784-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aea933.a70a0220.3cafd4.000e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in xfrm_state_flush

------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at net/xfrm/xfrm_state.c:801 __xfrm_state_destroy net/xfrm/xfrm_state.c:801 [inline]
WARNING: CPU: 0 PID: 49 at net/xfrm/xfrm_state.c:801 xfrm_state_put include/net/xfrm.h:929 [inline]
WARNING: CPU: 0 PID: 49 at net/xfrm/xfrm_state.c:801 xfrm_state_flush+0x627/0x740 net/xfrm/xfrm_state.c:957
Modules linked in:
CPU: 0 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:__xfrm_state_destroy net/xfrm/xfrm_state.c:801 [inline]
RIP: 0010:xfrm_state_put include/net/xfrm.h:929 [inline]
RIP: 0010:xfrm_state_flush+0x627/0x740 net/xfrm/xfrm_state.c:957
Code: 3f 8b 02 f8 48 8b 2b 48 85 ed 0f 84 dd 00 00 00 48 83 c5 f8 0f 84 d3 00 00 00 e8 54 1f 9f f7 e9 b3 fc ff ff e8 4a 1f 9f f7 90 <0f> 0b 90 e9 68 fe ff ff e8 3c 1f 9f f7 48 8b 7c 24 20 be 03 00 00
RSP: 0018:ffffc90000b97820 EFLAGS: 00010293
RAX: ffffffff8a208be6 RBX: 0000000000000001 RCX: ffff888022abbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000005
RBP: ffff888029974440 R08: ffff8880299744ab R09: 1ffff1100532e895
R10: dffffc0000000000 R11: ffffed100532e896 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125c1a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50d6d1d440 CR3: 000000004dc26000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm6_tunnel_net_exit+0x3c/0x100 net/ipv6/xfrm6_tunnel.c:337
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f39ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1519dc42580000


