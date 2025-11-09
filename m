Return-Path: <linux-kernel+bounces-891952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925FCC43E5C
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309C8188887E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A602F5A22;
	Sun,  9 Nov 2025 13:02:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC42EBBA1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762693324; cv=none; b=VWjEg9tdcsjpsf9IDEMWAE2U65Ho6eU0FlpZYWUSTQfOQMfM/xr9mkbfPtT5NpahsWwO7BPTtX/iTCX30FIXA2PSYD7LLO5deQFcmHUu+KhVg/W1xPAtCdiQgitSjhomOHSZNTsYPuFFXPh+IEUIbbRblwvP19vs2pgKdy3EQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762693324; c=relaxed/simple;
	bh=7YGkiBIgdSQWGXXXzMFRJg7hyhRfOkJoKlTV+EfOgYE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u0HvjIkmfveqorRtqbs4hXYe3O0VVAQ2aj9LKaHy+UPaYi0X4Airdkx+ngUly86xyenaFa3q50KcznXEsXooTmC68KjtUFzcMOSNV4N2cEGR2/HazbPLPY96WeLX9rfjuxEwrJ/42MXtQ1i+U5vFsgEF7ZvPcqKFvUd9NoxBNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43330d77c3aso83446095ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 05:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762693322; x=1763298122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWF9duusjyLRXyYOm5taZYra/qiTkEiBrfd5i+t8lcg=;
        b=AALo4YRqORAx2tHtfdZ/+92aLZV2Ovp3ExILkyZ0j0YUu7hWFBJdMPYieNg6B+r5cB
         kqp1dS0+dARNxmLSNaW+ZlmAMdHfL10vSxEAwh2ckl4IwLPuOakVlwI4TgwcCc/CCQKF
         6njk6ZiJRf1AzUlr+mHTYrL5E7fipuko95ToL9gmUYLYlkaIywH/1Urh8SRUihdo6Xnt
         x2ERruLo1RclZNYmWG3cdzfOxdWTWj3/9Y1fdDgFsSJBh906kFUkQUNOaW5xwMl8yOrk
         jFFAXijhmir/hDRQQFgAtdFdiRjdC4uBoG1ZZSwyljA5PmhhBQmA6Zb1fNm0UqsZK96O
         oT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbi17jstwrmrMO8iN9y1cMZdp8OUC28hGeabe53z5zBnC/fASX6WGW5mCepyL9fnUQLjN33j+oEv+7C+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxPESucg9GCSATQSVo0BhMQgbinwD2WWrB5fl/cuNt59++c7/
	qKSpAVyD8nXAxAgtqebN9xPbi0h4h5RD5OxlyhB0a/eZo0rRSnj/rKnnvRtV1iPO+29M7QLbWPw
	+JDBVnUgaJ3JjlyHUjNbq5uu4JMSEpzhacfVdAZQ302BLvqolY17i/0OMze8=
X-Google-Smtp-Source: AGHT+IFxTLXe4vy7G0gwzeLerANAIswgyzmiV/sDO8Wnx+5KNAC4qijX0dB9vheP5NImqcVWuw26y8WfrIv5+8cZhbbJl17XESj7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8d:b0:433:79e4:7adb with SMTP id
 e9e14a558f8ab-43379e47d20mr30319755ab.11.1762693322186; Sun, 09 Nov 2025
 05:02:02 -0800 (PST)
Date: Sun, 09 Nov 2025 05:02:02 -0800
In-Reply-To: <20251109122513.1139397-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691090ca.a70a0220.22f260.00b2.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: About to unlock rwsem we don't own!

After security_path_chown: owner=ffff888033982480
After notify_change: owner=0, error=0
BUG: About to unlock rwsem we don't own!
  inode=ffff8880112b4f80
  i_rwsem.owner=0
  current=ffff888033982480
  delegated_inode=0000000000000000
CPU: 0 UID: 0 PID: 5838 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 chown_common+0x659/0x700 fs/open.c:803
 do_fchownat+0x161/0x270 fs/open.c:834
 __do_sys_fchownat fs/open.c:849 [inline]
 __se_sys_fchownat fs/open.c:846 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd235d8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd236c11038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007fd235fe6090 RCX: 00007fd235d8efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007fd235e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd235fe6128 R14: 00007fd235fe6090 R15: 00007ffe7f7950f8
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880112b5058, owner = 0x0, curr 0xffff888033982480, list empty
WARNING: CPU: 0 PID: 5838 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5838 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5838 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 20 ff 6a 8b 48 c7 c6 40 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 c3 35 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 34 7d 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc90002a3fbf0 EFLAGS: 00010296
RAX: 9a6f5dfb05cd2e00 RBX: ffff8880112b5058 RCX: ffff888033982480
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba684 R12: 0000000000000000
R13: ffff8880112b50b0 R14: ffff8880112b5058 R15: 1ffff11002256a0c
FS:  00007fd236c116c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf3f3f7f50 CR3: 0000000059dc8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:990 [inline]
 chown_common+0x4e3/0x700 fs/open.c:805
 do_fchownat+0x161/0x270 fs/open.c:834
 __do_sys_fchownat fs/open.c:849 [inline]
 __se_sys_fchownat fs/open.c:846 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd235d8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd236c11038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007fd235fe6090 RCX: 00007fd235d8efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007fd235e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd235fe6128 R14: 00007fd235fe6090 R15: 00007ffe7f7950f8
 </TASK>


Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168e517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1126517c580000


