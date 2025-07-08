Return-Path: <linux-kernel+bounces-722140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB0AFD5C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956731C2372C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBD2E6D16;
	Tue,  8 Jul 2025 17:52:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8F2E6D03
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997150; cv=none; b=qPqhWTb23iqF3N3fdiNLjO+JR60ulCot3pxloZ4nOQKAOO5HsS4JSpvHmmD6GeKNH9MCdl30peOate0XfTtaje0HWKNyunY3rYKwxWEgazYqPIq+nttoH2xVtYlgGC5NFJqdQUNXSkSMSSvpLylK7eaCtyhZQXMqImWp5iZdlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997150; c=relaxed/simple;
	bh=rMh6Me1fZTZTpBCyYMHZBX5uT7A2qfFff5s0z7m6SfM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PCIUquRQHPowz+xzZPeytSUbhQPz9oHGFSmN28N+QkE0WXjWTu4LvCa7+VCMlD3xPW3Ruxo1zoHlmdnlRmNC7VLp52rnjx6YC2FVmimsyluP7cmzbHJMv5cU+o8HH8efzOWV47pPF2aPpLg9MGlY1hQ2q1WWOPHnDGzr3HIa0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e1618f03c9so4220985ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997148; x=1752601948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWnidTTeSra3WF98GI4dV5FN+0aF0vTBcFMmeL1ZvCk=;
        b=Nj2jEAMfcnTBj0zJNSUdltmBgACbn923aD/Z2/CTiC7Vx/BEJmhSMj+hGCk2gxYN8k
         2GFn5PRBS5Zhq7Tv1FzteX/FoDs5E4Fev/XDiyzeeEbbe8J1XGZWstySaafFs0tMBsex
         ivs3QFS4kEins2EMMIJx7xCpchu2xwtUja6a13BriZ/flMAWnJTspPm9pZmQODki4KiN
         Rsn8XB8TJxeAedAlOngzLZDNmv7V0fUlxIb6rP8dh54tgTnutwR10Vlam/tfJ8W80I+5
         cJ8xvrFzAIqyueXoQp4TIkg4E7LmUxhKzwe9eMgQRAFrs64zzY3T2NhhZYVGZtYs4cbR
         UQfw==
X-Forwarded-Encrypted: i=1; AJvYcCVKA08RPOLdfow4AKZVY1me5u/Lrp53soX+O84CAmt/cSAqm6TP27d6vujfsl0eCTS5XxvRgiYs4ag2p9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+Jbi4am//u4tchB1Dv0JLn7wYwIE+a5nGKhG/XwbTIypLVY+
	FAHY0av2n/jjr3ojfDAb+nu+5NWFF5KndRQurOfSiXnsySJhE3iBsK1Zre43oPzzpveISJkE7TV
	qn8//noRDhKXwM7y6y34Qc/ak1Lm1a+HfnC2QnvF0z5pTNYLQ+07p3BPeBuk=
X-Google-Smtp-Source: AGHT+IGW/048da5zHXurQSN7syVQ1cbpRMtzZBF6b0MhkvexY8CN/0/5qbUxPQbspCfJ/GFlNEdqmhamrHDV5hiNpp693+ZduZ1M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:b0:3df:4cf8:dd46 with SMTP id
 e9e14a558f8ab-3e135564fa8mr136193525ab.10.1751997147070; Tue, 08 Jul 2025
 10:52:27 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:52:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d5adb.050a0220.1ffab7.0018.GAE@google.com>
Subject: [syzbot] [mm?] stack segment fault in mtree_range_walk
From: syzbot <syzbot+8d7491ac5a289af56d5a@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13eedf70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=8d7491ac5a289af56d5a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e15582580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101edf70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/disk-26ffb3d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinux-26ffb3d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/bzImage-26ffb3d6.xz

The issue was bisected to:

commit 6772c457a86536f3496bf5b3716f34a5ac125783
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Tue Jun 24 19:33:59 2025 +0000

    fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl under per-vma locks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cad582580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11cad582580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16cad582580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d7491ac5a289af56d5a@syzkaller.appspotmail.com
Fixes: 6772c457a865 ("fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl under per-vma locks")

Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6058 Comm: syz.0.18 Not tainted 6.16.0-rc4-next-20250704-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:mtree_range_walk+0x2d7/0x840 lib/maple_tree.c:2773
Code: 00 00 48 8d 04 2b 48 83 f8 01 0f 84 b4 00 00 00 e8 6e c6 4f f6 49 83 c4 08 48 ff c3 eb ac e8 60 c6 4f f6 31 db e9 e1 00 00 00 <80> 7d 00 00 74 07 31 ff e8 3c 63 b4 f6 4c 8b 2c 25 00 00 00 00 48
RSP: 0018:ffffc900039df9a0 EFLAGS: 00010297
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000005
RDX: ffffffff8b6fe83a RSI: ffffffff8f893390 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff888025693c00 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f67b2a0b6c0(0000) GS:ffff888125ce7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67b2a0af98 CR3: 0000000075f14000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mas_state_walk lib/maple_tree.c:3630 [inline]
 mas_walk lib/maple_tree.c:4933 [inline]
 mas_find_setup lib/maple_tree.c:6012 [inline]
 mas_find+0x8e9/0xd30 lib/maple_tree.c:6052
 vma_next include/linux/mm.h:864 [inline]
 lock_next_vma+0x101/0xdc0 mm/mmap_lock.c:216
 get_next_vma fs/proc/task_mmu.c:182 [inline]
 query_vma_find_by_addr fs/proc/task_mmu.c:516 [inline]
 query_matching_vma+0x28f/0x4b0 fs/proc/task_mmu.c:545
 do_procmap_query fs/proc/task_mmu.c:637 [inline]
 procfs_procmap_ioctl+0x406/0xce0 fs/proc/task_mmu.c:748
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67b1b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67b2a0b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67b1db6080 RCX: 00007f67b1b8e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
RBP: 00007f67b1c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f67b1db6080 R15: 00007ffdeba76008
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mtree_range_walk+0x2d7/0x840 lib/maple_tree.c:2773
Code: 00 00 48 8d 04 2b 48 83 f8 01 0f 84 b4 00 00 00 e8 6e c6 4f f6 49 83 c4 08 48 ff c3 eb ac e8 60 c6 4f f6 31 db e9 e1 00 00 00 <80> 7d 00 00 74 07 31 ff e8 3c 63 b4 f6 4c 8b 2c 25 00 00 00 00 48
RSP: 0018:ffffc900039df9a0 EFLAGS: 00010297
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000005
RDX: ffffffff8b6fe83a RSI: ffffffff8f893390 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff888025693c00 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f67b2a0b6c0(0000) GS:ffff888125ce7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67b2a0af98 CR3: 0000000075f14000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
   6:	48 83 f8 01          	cmp    $0x1,%rax
   a:	0f 84 b4 00 00 00    	je     0xc4
  10:	e8 6e c6 4f f6       	call   0xf64fc683
  15:	49 83 c4 08          	add    $0x8,%r12
  19:	48 ff c3             	inc    %rbx
  1c:	eb ac                	jmp    0xffffffca
  1e:	e8 60 c6 4f f6       	call   0xf64fc683
  23:	31 db                	xor    %ebx,%ebx
  25:	e9 e1 00 00 00       	jmp    0x10b
* 2a:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp) <-- trapping instruction
  2e:	74 07                	je     0x37
  30:	31 ff                	xor    %edi,%edi
  32:	e8 3c 63 b4 f6       	call   0xf6b46373
  37:	4c 8b 2c 25 00 00 00 	mov    0x0,%r13
  3e:	00
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

