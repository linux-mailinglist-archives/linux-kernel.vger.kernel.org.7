Return-Path: <linux-kernel+bounces-881849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98BC29102
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 683AB4E3289
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6243D1A3154;
	Sun,  2 Nov 2025 15:20:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F24C6E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096807; cv=none; b=R5IHETg8/qdaisB9D+R3CYyXzEB8Szsorz/X9KhK+tAbmp93GAinpKBzoOV3cTduQ+pdNF76dlfNToEThDY+Sne3Lwz+6T9lVEmRu+fozww3tillYOAgiz/m56J6QBim++9tQ/jQRZeDDeeCmaBPOf6BotaknXCGe1EmZLN2nak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096807; c=relaxed/simple;
	bh=hO7IEwGd60ovJLXkE2tRuuw1PoUh9J9QHWtp2+Ang0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tc6mEtetZkFBv76OVfD0ZS+dRuYdQoCIuM4qr6xxpfPPF0QzY1VZsZaIHWrYXTFlLmYtjM/B8tZ25wyEFzMcag3ZjmsovSyjPXGEU0CgMu/LV04e/Rr8PxjbjT+LyGzzu+TZWORZrBz3vWFc/gUXuMIA5mPdr9Udv2HqCsSnwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940e4cf730aso1074741439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762096803; x=1762701603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRTsd+Zhc/a2fpgymWBHlQsL6ixf4JOp/SzLVhw0CDk=;
        b=BHKwNMmZOKod3gQgiADr7MYwvga3AmDEdqF5Zfp0Xj5mI/UtCf8DYQBbyATfL8A8ZD
         Gdvyp8IAhtc/Z57sRv0SjKu35qRmUm3u0P9nnIq0rwLw98FPQ4b8CUc5nEK1U6pAobHM
         x4FgNiRPP8GtmgYZkKT1CViQZWxiDa6LPGE8lG1GMwE/RbCiSuL8C9pzlSdNnj26czve
         z74H5owsTcFmWRaHK56hBTxLcqMjwHnp+qDwnigBfK2OGkH/WqLC/VfDs1bOuyK1bAMw
         BVkn6FZRUWJTTcoKxonnn00At+ZpHyFuHwT4+IEXcD7ShwaJ8a/aKYYPZU1JW2BCMImD
         k9+w==
X-Forwarded-Encrypted: i=1; AJvYcCV27J51Fcp0o6v72nn9xDnYURn15akiLqCwb+uBeDDbuKlFCx6No5o+0CL8dEAq4H6EOeqWKNWSeqMnx2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ge40tEwFe10fqzxwWzvgz90btiUeDjtPgryTKIAfyRNuLUo/
	yDoeDy5DABWoSZR1Fgv3qSmGxfD2SR1NajOyxLKhMF1s5FG/P9UF8BgCAZ5tk0n4gdsx6v2gM0d
	PjGw6v8lL8Ksz1vycbql0AqRXibH3N0OZIAmRK/a4WyYQcNE+U0gStYry3zs=
X-Google-Smtp-Source: AGHT+IFI+fZEincqhV5iHRZlobngghn5YCNeYwxvAP9nLuM+QKweIzGaqyzCa0+Pf8Cu7ezQ8tH0NjJzxnUieYJLue1Sz60KBfR2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2701:b0:433:377:abd with SMTP id
 e9e14a558f8ab-4330d1c8c26mr136457985ab.22.1762096803558; Sun, 02 Nov 2025
 07:20:03 -0800 (PST)
Date: Sun, 02 Nov 2025 07:20:03 -0800
In-Reply-To: <74426506.3493273.1762095398029@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690776a3.a70a0220.eb9ff.036b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in minix_rename

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6413 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 0 UID: 0 PID: 6413 Comm: syz.3.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: 70 07 00 00 be 08 00 00 00 e8 47 dc e7 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d e9 d2 6f f2 08 cc e8 7c cf 82 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc90004097a30 EFLAGS: 00010293
RAX: ffffffff823cd494 RBX: ffff88805b449520 RCX: ffff88802e99bc80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f5a5977 R09: 1ffffffff1eb4b2e
R10: dffffc0000000000 R11: fffffbfff1eb4b2f R12: 1ffff1100b6892ad
R13: ffff88805b449520 R14: ffff88805b449568 R15: dffffc0000000000
FS:  00007faba32196c0(0000) GS:ffff8881263c8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c64da1440 CR3: 0000000060b56000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2655 [inline]
 minix_rename+0x44e/0x7d0 fs/minix/namei.c:229
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faba238e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faba3219038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007faba25b6080 RCX: 00007faba238e929
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000200000001980
RBP: 00007faba2410b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007faba25b6080 R15: 00007ffc2921a008
 </TASK>


Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122ab258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=824b00f06adfda3c
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137ad704580000


