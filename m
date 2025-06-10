Return-Path: <linux-kernel+bounces-680284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E251FAD42F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 21:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81637177C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45F026460D;
	Tue, 10 Jun 2025 19:36:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37D2135D1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584192; cv=none; b=Euy1PXyG6O8kzKhuKY2G0DYJErZJzyePcJwTnqVx0SetRMoccMC201IFmZ3wx3kdqMpwvnjPszTyYksHIl19hZPGqa9yEH6If8wbRIoQq5c+DIdExzFmBepOWD9Y9UUKRhp8QaZOO5y3i4ho8EoL6eX0AuFDwKMv38uYR8LrZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584192; c=relaxed/simple;
	bh=3dhV5GqDavXSST+amA9fuuzurdDjUghC05BZc9imIv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iNdZ9AcMB+KK/JYmtnyGl1wiLX0SUC7Pvxs8Ibzv9OsYN0tW5JLXkejUwzZE0Ug3TPyRfrp2Z1Weoifliqs79Nj0TK/ZxRbRS4NXFac7yRuUS70XSlPJ+v5ejXhdcFQZjcZpPis1VzqaNUk0lJsDbCYoiVdB7nbaUX50vyJucwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86463467dddso550893839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 12:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749584190; x=1750188990;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tDqX/66dNoKzBq1LgpqJrNhrAp82BKueX+2DAvRNlg=;
        b=NJkwdNLtO/7Ckj1zCFzixu+ec+fbMzsAW8BuRhsJruufTzvY1xVoKonBS1Lwi/g9vV
         psKiPvhd5Eq06xfK84grjPkCFTm7fueXpAjLsHdkcykfPjgdqwq0zEX2ugaZug29ogeO
         37uX88QtCiTFgDFXz18JkjKm9cHsR2krN1QPN147ikoxQMRu9Ujw+ppaYx5Hp4v+LYW0
         pvU5oTT+P+YpglgHN3TbXJ7mZ1bDL7ZBrzdzAmJceiTCsj/QkpTvwon8APNo7cHs2nCT
         XXquVQaBNrUahXrJSSIvN3mYy7+p76h0lR0UD5lnqgksKRmJ62Qt6HBum8KjQgA3bKxQ
         +gxw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8sV1MvZMkhyh44P9wdzcg6DmoVBDl1HmiklpHuzvmCRxK97CGfiAL9k6ZWGY6j52fwv1lzCZWa1n/6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmowUznwKAiW9zAFS9NJ1vjiRzrc1Gsxyc6FxIlGeCqdwZxMT
	A1i/rwYyF0S3ETW5L1ruIYsCZavR3b9fUf24p1sCvT4bKO/nkxvfXFimQKSFOD8eDvCgbPkdP5r
	hcHszGblhNSV5w2xO2qMTmkzz7o6BaN6JzTuf2B86z0N6uU0rcYgFNF9b9i8=
X-Google-Smtp-Source: AGHT+IGnHJtB7diXzuzXXrtGs+HqYC5dcoHcOKNs32PzvB9MJ7TsFGc2qw+HmI39wAZ2EannPzH2q3+D1AmYkHLTcmiCAbe6Uxhx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2587:b0:3dc:7df8:c830 with SMTP id
 e9e14a558f8ab-3ddf423919emr7130065ab.7.1749584189760; Tue, 10 Jun 2025
 12:36:29 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:36:29 -0700
In-Reply-To: <68488453.a70a0220.27c366.0068.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6848893d.050a0220.33aa0e.0361.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] divide error in bch2_sb_members_v2_to_text
From: syzbot <syzbot+7c8101d4d0ba2eb511d7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b27cc623e01b Add linux-next specific files for 20250610
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15386a82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=846e731334efc0f8
dashboard link: https://syzkaller.appspot.com/bug?extid=7c8101d4d0ba2eb511d7
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175a260c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1129e9d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c0c417339c8/disk-b27cc623.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa29c0f3a1fa/vmlinux-b27cc623.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b902a80b6e7e/bzImage-b27cc623.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2fc50b6bfeb8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c8101d4d0ba2eb511d7@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor227 Not tainted 6.16.0-rc1-next-20250610-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:bch2_sb_members_v2_to_text+0x10a/0x3c0 fs/bcachefs/sb-members.c:347
Code: 49 89 f4 49 c1 ec 03 43 0f b6 0c 34 84 c9 48 89 b4 24 a0 00 00 00 0f 85 67 02 00 00 0f b7 0e 48 89 c2 48 c1 ea 20 74 07 48 99 <48> f7 f9 eb 04 31 d2 f7 f1 48 89 84 24 b0 00 00 00 48 8b 84 24 c8
RSP: 0018:ffffc9000434ed40 EFLAGS: 00010a02
RAX: ffff88807b3f8368 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffffffffffff RSI: ffff88807b3f8338 RDI: 000000000000000e
RBP: ffffc9000434ef70 R08: 000000000000003a R09: 000000000000003a
R10: dffffc0000000000 R11: ffffffff844fcfb0 R12: 1ffff1100f67f067
R13: 000000000000000b R14: dffffc0000000000 R15: 1ffff92000869dc4
FS:  000055556af99380(0000) GS:ffff888125c4b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056367c34f6a8 CR3: 00000000770e4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_sb_field_validate+0x1c6/0x280 fs/bcachefs/super-io.c:1380
 bch2_sb_validate+0x14bd/0x1980 fs/bcachefs/super-io.c:552
 __bch2_read_super+0xba4/0x1040 fs/bcachefs/super-io.c:925
 bch2_fs_open+0x1fe/0x2570 fs/bcachefs/super.c:2382
 bch2_fs_get_tree+0x437/0x14f0 fs/bcachefs/fs.c:2473
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1802
 do_new_mount+0x24a/0xa40 fs/namespace.c:3885
 do_mount fs/namespace.c:4222 [inline]
 __do_sys_mount fs/namespace.c:4433 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4410
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb499d6198a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1a446798 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe1a4467b0 RCX: 00007fb499d6198a
RDX: 0000200000000000 RSI: 0000200000011a40 RDI: 00007ffe1a4467b0
RBP: 0000200000000000 R08: 00007ffe1a4467f0 R09: 00000000000119f3
R10: 00000000028080c9 R11: 0000000000000282 R12: 0000200000011a40
R13: 0000000000000004 R14: 0000000000000003 R15: 00007ffe1a4467f0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_sb_members_v2_to_text+0x10a/0x3c0 fs/bcachefs/sb-members.c:347
Code: 49 89 f4 49 c1 ec 03 43 0f b6 0c 34 84 c9 48 89 b4 24 a0 00 00 00 0f 85 67 02 00 00 0f b7 0e 48 89 c2 48 c1 ea 20 74 07 48 99 <48> f7 f9 eb 04 31 d2 f7 f1 48 89 84 24 b0 00 00 00 48 8b 84 24 c8
RSP: 0018:ffffc9000434ed40 EFLAGS: 00010a02
RAX: ffff88807b3f8368 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffffffffffff RSI: ffff88807b3f8338 RDI: 000000000000000e
RBP: ffffc9000434ef70 R08: 000000000000003a R09: 000000000000003a
R10: dffffc0000000000 R11: ffffffff844fcfb0 R12: 1ffff1100f67f067
R13: 000000000000000b R14: dffffc0000000000 R15: 1ffff92000869dc4
FS:  000055556af99380(0000) GS:ffff888125d4b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056367c3149f8 CR3: 00000000770e4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 89 f4             	mov    %rsi,%r12
   3:	49 c1 ec 03          	shr    $0x3,%r12
   7:	43 0f b6 0c 34       	movzbl (%r12,%r14,1),%ecx
   c:	84 c9                	test   %cl,%cl
   e:	48 89 b4 24 a0 00 00 	mov    %rsi,0xa0(%rsp)
  15:	00
  16:	0f 85 67 02 00 00    	jne    0x283
  1c:	0f b7 0e             	movzwl (%rsi),%ecx
  1f:	48 89 c2             	mov    %rax,%rdx
  22:	48 c1 ea 20          	shr    $0x20,%rdx
  26:	74 07                	je     0x2f
  28:	48 99                	cqto
* 2a:	48 f7 f9             	idiv   %rcx <-- trapping instruction
  2d:	eb 04                	jmp    0x33
  2f:	31 d2                	xor    %edx,%edx
  31:	f7 f1                	div    %ecx
  33:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  3a:	00
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	84 24 c8             	test   %ah,(%rax,%rcx,8)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

