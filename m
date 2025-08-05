Return-Path: <linux-kernel+bounces-756454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72108B1B4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FA77AF9D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD2274FEF;
	Tue,  5 Aug 2025 13:12:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D522749D5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399552; cv=none; b=lMrHvpuIcWaikuNU+PUZAgMUkXDpQ1cqsLEBXee74tPxwSbaIqlLfflU0nfwGe3gec0N3+/4PY9mM/ngOTLdDqafBpmC/YbpN+5OLIboJl72G4M0ANKLiYoL3MyfqrgUEZ9ynxGLSFLMrbmTcPT7C3HZktn4pysSsq+Uc8Mvt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399552; c=relaxed/simple;
	bh=/t03lzd8/7QINjTVGelfiTmEZafD6lv/kDZwplhgTnI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E0syKh/QM6hVZUdfhsm5b30r5nZmdWvmVI9Ae1xv/yFqbN9Dm9awXn4SLvKzOTKl2i4g/zVW2vsHuDh2jMYi2azsOFftGH+azQZnrO40HcuJBLvH7P3v8Uk47XpencsEPHyL9FwcUBwa95P++8bJRxmpcrgkIMGrEYKX+gngjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8760733a107so562166139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399550; x=1755004350;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+hOl7ITSTvQM1EGXhs8atnZCtU2c9fVtZP265OJS18=;
        b=Xv1fsUDj239k90Aj9/y8bSMMwnQI+hpf/v+McSqkS5QXN0LxCKlYVBlzF5VQu5R3Ko
         F19n7MeIdQgVfl8nB7OBLFhjOveO249Kzz4QdzrC9q+l3LRPq6vRFHxOMwAGRAL2Lx6r
         BKYrbllYy8N+wOj1Cekg3IlxYAXwXdKGjwaQNFuFeTqDmaaSk/LycJn0ssZKEq1dU0Nx
         z9RY53dQmM2ZEHxIAtu/O38hFP+vOnnbHJhb3wB5XDaZbWN/NaObdScogAl/9Bj2ezb6
         3YSI/Eg2Q4fNxv/LktqNR2M2gPUmwd6Vi46gzRTEzyRfsiUDWwRL3fUwBOtYIDXArSR6
         +5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIbB9Kxr9R816oCEzpoj+QS5Btr9Y7FF6D9eNLylDs6JIjbM/Gy/U8HDvE2LwgGlIKU69bXBX1wKvcKjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sRfOOOItHMbv8HMv1MQxUeWeMMfCjPW1SlBmqVMXlQtxjwnK
	bMAuxbniWzn4SLHxF3aZo0qLE6l49p931o42NI2cc1Rq0ekd0Xo5ZSA3H/XAkcSrxwkAouqN7BL
	Wbw8Xnelj748xpeclgINULwvJF0gN5ZCjyTqrKgeZj+EjlMzX2Mae+FRjMRI=
X-Google-Smtp-Source: AGHT+IEvz4CnfbTiC9e6iN5vAfO76dB8ilb2CUfg7JjGClMgNTLtg5n3fwlsllddBOzFweYTWie0ImgiVdIBr5DiRyJ22Hn1OIUA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:da:b0:874:e108:8e3a with SMTP id
 ca18e2360f4ac-881683e7e9dmr2243698039f.12.1754399549996; Tue, 05 Aug 2025
 06:12:29 -0700 (PDT)
Date: Tue, 05 Aug 2025 06:12:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6892033d.050a0220.7f033.0023.GAE@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in __bch2_err_trace
From: syzbot <syzbot+8f3825f100f660b04204@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    afec768a6a8f Add linux-next specific files for 20250805
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b886a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=8f3825f100f660b04204
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d205bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1732a6a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f60d231fbf08/disk-afec768a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb1709601601/vmlinux-afec768a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f528f37da74c/bzImage-afec768a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3808cc003493/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f3825f100f660b04204@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
Oops: general protection fault, probably for non-canonical address 0xdffffc00000096c2: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x000000000004b610-0x000000000004b617]
CPU: 0 UID: 0 PID: 5865 Comm: syz-executor145 Not tainted 6.16.0-next-20250805-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__bch2_err_trace+0x2c/0x230 fs/bcachefs/bcachefs.h:1150
Code: 57 41 56 41 55 41 54 53 89 f3 49 89 fe 49 bd 00 00 00 00 00 fc ff df e8 62 96 65 fd 4d 8d be 10 b6 04 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 ff e8 a5 00 c9 fd 49 8b 07 65 48 ff 80
RSP: 0018:ffffc9000408f648 EFLAGS: 00010202
RAX: 00000000000096c2 RBX: 00000000fffff716 RCX: ffff88807ed35a00
RDX: 0000000000000000 RSI: 00000000fffff716 RDI: 0000000000000000
RBP: ffffc9000408f970 R08: ffff88807a554000 R09: ffff88807a554000
R10: ffff888148d3f300 R11: ffff88802ffd0380 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000004b610
FS:  00005555840bd380(0000) GS:ffff888125c24000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb4e035000 CR3: 0000000071f12000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bch2_fs_open+0x130f/0x27f0 fs/bcachefs/super.c:2546
 bch2_fs_get_tree+0x44f/0x1540 fs/bcachefs/fs.c:2430
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa418864bba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff62abeef8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff62abef10 RCX: 00007fa418864bba
RDX: 00002000000058c0 RSI: 0000200000000000 RDI: 00007fff62abef10
RBP: 0000200000000000 R08: 00007fff62abef50 R09: 000000000000591b
R10: 0000000000000000 R11: 0000000000000282 R12: 00002000000058c0
R13: 00007fff62abef50 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_err_trace+0x2c/0x230 fs/bcachefs/bcachefs.h:1150
Code: 57 41 56 41 55 41 54 53 89 f3 49 89 fe 49 bd 00 00 00 00 00 fc ff df e8 62 96 65 fd 4d 8d be 10 b6 04 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 ff e8 a5 00 c9 fd 49 8b 07 65 48 ff 80
RSP: 0018:ffffc9000408f648 EFLAGS: 00010202
RAX: 00000000000096c2 RBX: 00000000fffff716 RCX: ffff88807ed35a00
RDX: 0000000000000000 RSI: 00000000fffff716 RDI: 0000000000000000
RBP: ffffc9000408f970 R08: ffff88807a554000 R09: ffff88807a554000
R10: ffff888148d3f300 R11: ffff88802ffd0380 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000004b610
FS:  00005555840bd380(0000) GS:ffff888125d24000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555d2b962148 CR3: 0000000071f12000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	57                   	push   %rdi
   1:	41 56                	push   %r14
   3:	41 55                	push   %r13
   5:	41 54                	push   %r12
   7:	53                   	push   %rbx
   8:	89 f3                	mov    %esi,%ebx
   a:	49 89 fe             	mov    %rdi,%r14
   d:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  14:	fc ff df
  17:	e8 62 96 65 fd       	call   0xfd65967e
  1c:	4d 8d be 10 b6 04 00 	lea    0x4b610(%r14),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 a5 00 c9 fd       	call   0xfdc900de
  39:	49 8b 07             	mov    (%r15),%rax
  3c:	65                   	gs
  3d:	48                   	rex.W
  3e:	ff                   	.byte 0xff
  3f:	80                   	.byte 0x80


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

