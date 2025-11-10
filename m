Return-Path: <linux-kernel+bounces-893400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD3C47441
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C24044E7DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7940A312838;
	Mon, 10 Nov 2025 14:41:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87B1B6CE9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785665; cv=none; b=Eq5g6sxXgXxq23YCJZ2tfbnXFct2ZMj2AePYzIx+E6tQ1HbFDxprHCLVaV6IxqEksGArKRne2cBhvsYtXYQNnalxdhsjJ0uaDP0v/u99X9f73j6Xq5FfJAI9rrEGt5ILUfAzfzDxZYDmzrJf4S++uOwKWtkxlHROWzts/p8Doz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785665; c=relaxed/simple;
	bh=uuqBUdXn+cKtUXyNo1bRp0+sfganSSly9sNPL5XUwzo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KKJBfEmi0yMyrn6MIvSdtsHwun6zl17qp5xA9mnooeipI+VqkgUnCLowxkdF26aahevwM8lbRYyrIW+cecFMzob1SgDowquvk7sAikUMr11pBK6nLgCSFOD8ZKJSpRw/PvUesjBGzuBbbTCTTVKU9ta4X+E3C0+X34WJJsh9NzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43300f41682so26294285ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785661; x=1763390461;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU5y1DP+AlV9jL4iBHUt12yOIgPEvdyFxK5moU9rU40=;
        b=EsTv5UHP0SHDSKqI9BZBjp9IFutjhh25Z8S9Wh6cEC46aTfJaTWn8QYSlKr+D8qpRu
         seQTozRpk2Jj9vlEmIn248xK8zotnbIa+IA9jrkLGC+PSgwBq7qi3m8+vIj2Serwcgs2
         oVBaJpK3Ry2Ry3Fn9F5d/6hgNMkDC0SBopKqzg5GwiEdVImG26KfAj8hQnAlRw5DdIPu
         Yr2zANWAjFdLzku0BMbgoRnlSTMBvZYo1vGKChmUQXjF2vXJtFAM5fFN0/2350LkRo7S
         WM1gTaOF2actEOPPY/BWCxu2sxvinuEfydeFEse/kO9XVY3UxYYC00dc6K5YwDVNu3xb
         vA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdQJz0ndrvZPahGfhR07QCjiKtwn279p7xc1qr/mwJphKC0u4hqoDL3igUfIQYWOwOtTqdgdhlKN4kff0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEElXlywhr/7kTDwixurhnlIAROwFxbdSN5jsBm+mYVDbbD/zL
	AINr3QYrsKBbtir2WiXFFBcxmpCR8XPhWJ3UphhTEHFkwJjKzi1RjG9So4ERwTXdYTUPd9k0p5h
	xQ5rQ4Zb3Y7woL9jE7zzAvjbEcRKdjgk/L+WwKg8EgXgfYEIDG3li22IpCVw=
X-Google-Smtp-Source: AGHT+IGhrndiBoNRVHd3A6XYdM/ugwGZBEHei8fLN7vqopFP367jZb3I+vNctJ56gE4bjQ013tmpEp4K7TNBQMkO3bh2HfbF5lx+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:433:773d:adc0 with SMTP id
 e9e14a558f8ab-433773db12amr94209515ab.17.1762785661505; Mon, 10 Nov 2025
 06:41:01 -0800 (PST)
Date: Mon, 10 Nov 2025 06:41:01 -0800
In-Reply-To: <tencent_89E8A2ED9ECDEC7B1E6C242E516C24970C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911f97d.a70a0220.22f260.00f4.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in txLock

BUG at fs/jfs/jfs_txnmgr.c:662 assert(last)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:662!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6791 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:txLock+0x1b79/0x1cb0 fs/jfs/jfs_txnmgr.c:662
Code: e9 6a f8 ff ff e8 a7 2b 81 fe 48 c7 c7 e0 48 24 8b 48 c7 c6 d9 44 24 8b ba 96 02 00 00 48 c7 c1 e0 49 24 8b e8 88 aa e9 fd 90 <0f> 0b e8 80 2b 81 fe 48 c7 c7 a0 4a 24 8b e8 74 aa e9 fd 48 c7 c7
RSP: 0018:ffffc90004507780 EFLAGS: 00010246
RAX: 000000000000002b RBX: 0000000000000000 RCX: 0fb1e517ffc2aa00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900045078a8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff520008a0e95 R12: 1ffff920006a1200
R13: ffffc90003509000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0164d3d6c0(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f424b06b000 CR3: 0000000022db0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 diWrite+0x444/0x1f40 fs/jfs/jfs_imap.c:654
 txCommit+0x852/0x5430 fs/jfs/jfs_txnmgr.c:1256
 jfs_mkdir+0x856/0xa70 fs/jfs/namei.c:290
 vfs_mkdir+0x306/0x510 fs/namei.c:4453
 do_mkdirat+0x247/0x590 fs/namei.c:4486
 __do_sys_mkdirat fs/namei.c:4503 [inline]
 __se_sys_mkdirat fs/namei.c:4501 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4501
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f016daede17
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0164d3ce68 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f0164d3cef0 RCX: 00007f016daede17
RDX: 00000000000001ff RSI: 0000200000000240 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000200000000240 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000240
R13: 00007f0164d3ceb0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txLock+0x1b79/0x1cb0 fs/jfs/jfs_txnmgr.c:662
Code: e9 6a f8 ff ff e8 a7 2b 81 fe 48 c7 c7 e0 48 24 8b 48 c7 c6 d9 44 24 8b ba 96 02 00 00 48 c7 c1 e0 49 24 8b e8 88 aa e9 fd 90 <0f> 0b e8 80 2b 81 fe 48 c7 c7 a0 4a 24 8b e8 74 aa e9 fd 48 c7 c7
RSP: 0018:ffffc90004507780 EFLAGS: 00010246
RAX: 000000000000002b RBX: 0000000000000000 RCX: 0fb1e517ffc2aa00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900045078a8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff520008a0e95 R12: 1ffff920006a1200
R13: ffffc90003509000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0164d3d6c0(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f424b06b000 CR3: 0000000022db0000 CR4: 00000000003526f0


Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14226412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cb07cd980000


