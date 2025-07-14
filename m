Return-Path: <linux-kernel+bounces-730550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16CB0462C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8133B7756
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635E32641EE;
	Mon, 14 Jul 2025 17:09:34 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807826058D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512973; cv=none; b=AbQjzUN2vMLURmkWE1kNVGvHaZhBZ4R3eSFrk9z2G1b4YhalKWHN96GSakjWsDNR+6gsUCxcMwANojWBGCqe2seMHR6utH/7r99pCwquQYC0HCldYjRPAos/YUCOCgTcVz5dwnmPjZuZ9a17Op2NVWeJSwKhX7pchG0r6xUDk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512973; c=relaxed/simple;
	bh=39bFvnJEESuESqjvyUbtlwm31P33ZHBjhVfFP2QCF7A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TPl+ReiiqQv/tw5k/jjdz7jUUBtGMSI9NYgpuhd1iaAEVpAt4eughZC4OFOOZYA9SJ93CdjrEqQeCUB07LXNvsqXCeinYME7BGqjtG2xndarBeLIZliLnO71J11Tzm11vSSksqZC7NI/UkH1KbI9OS5zzOdsb4YX4vs7wsmlNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cfccca327so935862339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512971; x=1753117771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kef4cmQDmLoqR2oiSccK0CODHTQOskLt7lSz4gaW7D0=;
        b=uqSobAEOv+o1rKSMeAixr1dD+xKyCvsP7aZvCHIP9rTz6muaYWpcYpGoODfnz9JR1Y
         EYHnQtDYIBjduhIRQNWMcCAhLG7I5zcI7YQDB2yI/6EVMAIfcrz2RDuKMuWXOP7Bf4/0
         IvHh+bSD0ND6tZ8xSORLuuR6XcNeiwxJlBIdaxekRCj+t1Uh5iA7P5VrMFl52HM1RVUA
         exqjrm1cy50Ng89omr7btYCAJt9OBZSF+FDJtHkhrTeBVO9uFXb6b9fGM0sU0ONxr1HI
         FMSUFhmy8n0wibmI++H7zrBtaUBRvryJOwLDrQXVV3vfCDVNigfz9qoAUHkyuBW1o991
         3VQw==
X-Forwarded-Encrypted: i=1; AJvYcCUOsqELRK8ZmOjApuDXKKWksgR/uYzb9nZFFyGIam9i3bHu5fTNMprydAQgBcPU5Q9f4LVUU9N9UAYNEM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nEQX0/2Oze4Qx8UbensxUrcnVOaiFyr3uU0HIjZNlBYpunXT
	7SnGgHiLc+QLyYPkcZ7sT0dPK5lAluXyZI/GqrTzOMCwVee0GIiPxc/fsy7X8Do93gXQnwfRclm
	vyGG0bWoTR8k9znSVWlys2tZvms5hjtuU0o6sxClYarjXP5vcAwUOfSdvrZ8=
X-Google-Smtp-Source: AGHT+IFNiIXxC/8DIJIB9EkW1GamIQQFH0pWMLQSXxRh5h6vr4vNf13CoXsemrS1ZQ6yhgOkqQoRhuBR1e6RBgi85H2ZkZ0VQ6Ye
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150f:b0:875:bc13:3c26 with SMTP id
 ca18e2360f4ac-87977f75d82mr1800660039f.4.1752512971190; Mon, 14 Jul 2025
 10:09:31 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:09:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687539cb.a70a0220.18f9d4.0004.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in mas_start
From: syzbot <syzbot+ffe421482ad9d307c03f@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a62b7a37e6fc Add linux-next specific files for 20250711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d45d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb4e3ec360fcbd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe421482ad9d307c03f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1177018c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1577018c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7965e5d0fd00/disk-a62b7a37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3f74e66ef93/vmlinux-a62b7a37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90b196a2a6e8/bzImage-a62b7a37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe421482ad9d307c03f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 0 UID: 0 PID: 6062 Comm: syz.0.19 Not tainted 6.16.0-rc5-next-20250711-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:mas_root lib/maple_tree.c:844 [inline]
RIP: 0010:mas_start+0x10c/0x560 lib/maple_tree.c:1377
Code: 85 4e 02 00 00 c6 43 3c 00 48 8b 44 24 30 80 3c 28 00 74 08 48 89 df e8 f2 1b b3 f6 4c 8b 33 49 83 c6 48 4c 89 f0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 f7 e8 d6 1b b3 f6 4d 8b 26 e8 fe ec 08 00
RSP: 0018:ffffc90003367a08 EFLAGS: 00010206

RAX: 0000000000000009 RBX: ffff8880762e8d18 RCX: 1ffff1100ec5d1aa
RDX: 1ffff1100ec5d1aa RSI: 0000000000000001 RDI: ffff8880762e8d40
RBP: dffffc0000000000 R08: ffff88801dfd1e00 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000000 R12: 0000200001000000
R13: ffff8880762e8d30 R14: 0000000000000048 R15: ffff8880762e8d50
FS:  00007ff7b5a9d6c0(0000) GS:ffff888125bc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7b5a9cf98 CR3: 000000007604c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mas_state_walk lib/maple_tree.c:3629 [inline]
 mas_walk lib/maple_tree.c:4939 [inline]
 mas_find_setup lib/maple_tree.c:6018 [inline]
 mas_find+0x8aa/0xd30 lib/maple_tree.c:6058
 vma_next include/linux/mm.h:864 [inline]
 lock_next_vma+0x101/0xdc0 mm/mmap_lock.c:216
 get_next_vma fs/proc/task_mmu.c:182 [inline]
 query_vma_find_by_addr fs/proc/task_mmu.c:512 [inline]
 query_matching_vma+0x319/0x5c0 fs/proc/task_mmu.c:544
 do_procmap_query fs/proc/task_mmu.c:629 [inline]
 procfs_procmap_ioctl+0x3f9/0xd50 fs/proc/task_mmu.c:747
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff7b4b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff7b5a9d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff7b4db6080 RCX: 00007ff7b4b8e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
RBP: 00007ff7b4c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff7b4db6080 R15: 00007ffde30986a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mas_root lib/maple_tree.c:844 [inline]
RIP: 0010:mas_start+0x10c/0x560 lib/maple_tree.c:1377
Code: 85 4e 02 00 00 c6 43 3c 00 48 8b 44 24 30 80 3c 28 00 74 08 48 89 df e8 f2 1b b3 f6 4c 8b 33 49 83 c6 48 4c 89 f0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 f7 e8 d6 1b b3 f6 4d 8b 26 e8 fe ec 08 00
RSP: 0018:ffffc90003367a08 EFLAGS: 00010206
RAX: 0000000000000009 RBX: ffff8880762e8d18 RCX: 1ffff1100ec5d1aa
RDX: 1ffff1100ec5d1aa RSI: 0000000000000001 RDI: ffff8880762e8d40
RBP: dffffc0000000000 R08: ffff88801dfd1e00 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000000 R12: 0000200001000000
R13: ffff8880762e8d30 R14: 0000000000000048 R15: ffff8880762e8d50
FS:  00007ff7b5a9d6c0(0000) GS:ffff888125bc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7b5a9cf98 CR3: 000000007604c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	85 4e 02             	test   %ecx,0x2(%rsi)
   3:	00 00                	add    %al,(%rax)
   5:	c6 43 3c 00          	movb   $0x0,0x3c(%rbx)
   9:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
   e:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 f2 1b b3 f6       	call   0xf6b31c0e
  1c:	4c 8b 33             	mov    (%rbx),%r14
  1f:	49 83 c6 48          	add    $0x48,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 d6 1b b3 f6       	call   0xf6b31c0e
  38:	4d 8b 26             	mov    (%r14),%r12
  3b:	e8 fe ec 08 00       	call   0x8ed3e


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

