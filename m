Return-Path: <linux-kernel+bounces-589779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60797A7C9F9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83B818961CA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03751537DA;
	Sat,  5 Apr 2025 15:40:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5076410
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743867628; cv=none; b=LUB6/drBp8N1VJUX+7hUM7H152+8paod5eQig6OXGM3qZDvPiAe04zEAO29117BAfZbtcpBzHqoqfT7bYG4h2qp7+tEOV547oKakEXjz8rXOWNhIUZTjF129UHEf3UnWIt/opO/fzlEoH2KesWG+9r19wDAdwVv5ETHGOud/oZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743867628; c=relaxed/simple;
	bh=yTY+k1LVgPMAzRhGhuW86LLxaO3PJgkP8SG8sFeCq2A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bbiyvt/38OL4Xmg2s6opv5FXpi31RtyqGfaR+E4zMzL+8xlfxhM39ehVTZADfV/kJnxzX4WPTzyceT7+f6S5P9X1DvUadOi01XqxxAniFI5ROBhFZLVPr8t1olM3KhlMRg6lJzPVLyKxnhx/bDZGH86CCOzvJFqCJ75UP4Ij9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso65053085ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Apr 2025 08:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743867626; x=1744472426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1RAKv2fEX5WhjjEw6SMjCzp8OrcM0yiO3TEhhGPozA=;
        b=LzMvPx9ydXfrJYymudrwATEJy7w25ZgdErYL+T5oobIFdbGmBPUbkTHUoZBuZwoovp
         A83CwkeKNfZFOMw6jQXJyyz1l0aVqhlfNd9UrNVDvw67r6rKNh4Opl/aeYQFshtPhPtD
         ssRIe9u7ohfWDwN3ita/dvpbJJQfXDadGmVbxSEpM7t3fWnbSs1LG2wBhvA0baE30zBu
         Qyink9xp5eEz/vbSiXU5z8ZVOqV5rR/wzxV1HeucjI4JOyK8gpe/8doiGnJPhXj/eIjD
         sofQ2TMoHsdkautvj8FFplXhFLAAdaiV7wSjxZPsH2D2cYRZktGQWUWwg9/gyM6JfxB3
         AVZg==
X-Forwarded-Encrypted: i=1; AJvYcCVpM27JdSAXaYKtaOhI0F/fG4Fy5Q/wMzZ2Ho/cAYVWbFlW2k9kfV8mjmRA0/4IVSUKn0FymStnlrREM1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTMoroHKM83pocvs52iMPMfJqe4IkENmVdPhcTzmlR2FnASJb
	E0TkH1+PR3lSYH4s//cYdplw3qWAlpq06WfQUW3M/X4AkdnC2vVm0pBh8aVRfPLUjIye2eJ8vZs
	Ip14W//0ykINmGdkqBFj86lvKtSX6qBvAuaOxZ6bWb/msv76JRCf1GP0=
X-Google-Smtp-Source: AGHT+IFQDF2EeUGuvbG6i/hjrBnP/Fz4AxpxMvbMXhiSzIESbmcbKqBzfFryHedClOMcMQhwHfa2djLtvC4cCzC558c7YCmHB4EI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2505:b0:3d2:b72d:a507 with SMTP id
 e9e14a558f8ab-3d6e3f89bf2mr80465235ab.19.1743867625822; Sat, 05 Apr 2025
 08:40:25 -0700 (PDT)
Date: Sat, 05 Apr 2025 08:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f14ee9.050a0220.0a13.023e.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in relocate_file_extent_cluster
From: syzbot <syzbot+7481815bb47ef3e702e2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a8662bcd2ff1 Merge tag 'v6.15-p3' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1358efb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=7481815bb47ef3e702e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139e67cf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10960d78580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a8662bcd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd06651979f7/vmlinux-a8662bcd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ade9d94d78e/bzImage-a8662bcd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eb056de8bfc4/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=16d62b4c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7481815bb47ef3e702e2@syzkaller.appspotmail.com

R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007ffc55de5790
 </TASK>
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000045: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000228-0x000000000000022f]
CPU: 0 UID: 0 PID: 5332 Comm: syz-executor215 Not tainted 6.14.0-syzkaller-13423-ga8662bcd2ff1 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:relocate_file_extent_cluster+0xe7/0x1750 fs/btrfs/relocation.c:2971
Code: 00 74 08 48 89 df e8 f8 36 24 fe 48 89 9c 24 30 01 00 00 4c 89 74 24 28 4d 8b 76 10 49 8d 9e 98 fe ff ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ca 36 24 fe 4c 8b 3b 48 8b 44 24
RSP: 0018:ffffc9000d3375e0 EFLAGS: 00010203
RAX: 0000000000000045 RBX: 000000000000022c RCX: ffff888000562440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880452db000
RBP: ffffc9000d337870 R08: ffffffff84089251 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff9368a020 R14: 0000000000000394 R15: ffff8880452db000
FS:  000055558bc7b380(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a7a192e740 CR3: 0000000036e2e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0xa1e/0xd50 fs/btrfs/relocation.c:3657
 btrfs_relocate_block_group+0x777/0xd80 fs/btrfs/relocation.c:4011
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
 __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
 btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
 btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb4ef537dd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc55de5728 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc55de5750 RCX: 00007fb4ef537dd9
RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007ffc55de54c6 R09: 00007ffc55de5770
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007ffc55de5790
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:relocate_file_extent_cluster+0xe7/0x1750 fs/btrfs/relocation.c:2971
Code: 00 74 08 48 89 df e8 f8 36 24 fe 48 89 9c 24 30 01 00 00 4c 89 74 24 28 4d 8b 76 10 49 8d 9e 98 fe ff ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ca 36 24 fe 4c 8b 3b 48 8b 44 24
RSP: 0018:ffffc9000d3375e0 EFLAGS: 00010203
RAX: 0000000000000045 RBX: 000000000000022c RCX: ffff888000562440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880452db000
RBP: ffffc9000d337870 R08: ffffffff84089251 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff9368a020 R14: 0000000000000394 R15: ffff8880452db000
FS:  000055558bc7b380(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a7a192e740 CR3: 0000000036e2e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
   4:	89 df                	mov    %ebx,%edi
   6:	e8 f8 36 24 fe       	call   0xfe243703
   b:	48 89 9c 24 30 01 00 	mov    %rbx,0x130(%rsp)
  12:	00
  13:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
  18:	4d 8b 76 10          	mov    0x10(%r14),%r14
  1c:	49 8d 9e 98 fe ff ff 	lea    -0x168(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 ca 36 24 fe       	call   0xfe243703
  39:	4c 8b 3b             	mov    (%rbx),%r15
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

