Return-Path: <linux-kernel+bounces-757386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AAFB1C187
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 365CD4E1EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB521CC44;
	Wed,  6 Aug 2025 07:43:43 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6C21ABC8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466223; cv=none; b=SzIW6lTH5L9sjPIRZLXb4qZGcMFuft64dhx5+qcdij5yKnPMGobVDCEwn7WPuGFR+JuRCFX1sESmrbs4QHKL5NItkVrRGAxxvyrS8HNLiJzo7MJs7ZUIH6zUnUMWLkGUsz493GJXdDr9yDvUfeyhge0FWro5By0EtgnILqEOZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466223; c=relaxed/simple;
	bh=L4AofNB68ilVon8P/Vu85cxNOvl2ivQq4/GZyJ1I+2U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lp12kgijzZEDf2KUGT/epEiDFDzSKIV+Eg6bc365XnbhasIPajHuc54EvoM3p7hEqpYZtXQ+4CnmXEw3W6Oc4uPHngg6THK2S65p8eIVC/UL7Ytb2k322vX9eLDd/mpIVOlzcXNdGYcXnnLBiIlxSKIBcH1m6g5cewpUYEig/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8649be94fa1so1108065139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754466218; x=1755071018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRGuKT6QrKliWgsUCET6ezjgzIPpJgz36J4X3QKXBxI=;
        b=fCun+b8u+X/HCLU6mR/wLvnGe4L0tEl7IREnf9xHOs+cNGScu6tyzem2RG1W5M0cKe
         dAgpSr/ZNezhZVd9MJyI1tR4IbTETEUkApr0QYoIL6mri3Mavu19b3E3/lZ9MZMV3V6w
         aHxbI0mmQewBk9K5IDLZfxb88zU/jpk+Zjkv20oidBOC434sRGLgJuaOVdl1grQjBknO
         1OnrfYWXwmvUDHpMvhYJbJhtnLgGcSHb4lihO5dQ6s8nGLlH7Emq8+msBd49hg5Ld17c
         6cUqN0XRqGe7GhpSLxTTZzvAFXo8OHwQxxOuQ/nDT2XO5c9eEo1y0IcVRFoi9rBPxPh5
         RHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyqpiO5sv8KRiKlVFp3Tlc9/pZik8IvP5Z+Iwh2MaQFgcrStP/VMhS7se1yMOEwGYFgBMZ4xgMu3qmMIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+a6DEUtuJDVHUJ6IZ9Z7hOaWQLhLaCobPyCgLKt5thiq1rAIv
	jL/Yys2g7GTXSXchg1CDxE0PH+GXTddY8s4n6l2VQvX1/RGHCkR64C0FxTkRICEB4MP34Lz3Vg1
	YewW8o7woV1E0LZQVNBSpL/1lXd47p45338Z+zCCemtuHP0M5UmvCnY2Zogo=
X-Google-Smtp-Source: AGHT+IFssaKUpcvjB89EazSePj/sDisMWSpwHZ2yGmOn3v0iZWw+w8izZFUWIAQleFm1s54vcLfKjBSPYWpQ3QSUeSOJGKUJh0VT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b07:b0:881:81b7:1058 with SMTP id
 ca18e2360f4ac-8819f070216mr352963239f.7.1754466218392; Wed, 06 Aug 2025
 00:43:38 -0700 (PDT)
Date: Wed, 06 Aug 2025 00:43:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689307aa.050a0220.7f033.003c.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in __pte_offset_map_lock (2)
From: syzbot <syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, rppt@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5998f2bca43e Merge tag 'exfat-for-6.17-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136cc434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb90b5976661bfd8
dashboard link: https://syzkaller.appspot.com/bug?extid=45ad2baf16fce6bc81f3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102eb6a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134d16a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/616a65da77ea/disk-5998f2bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f3838a6bd07/vmlinux-5998f2bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/298a57ed56ee/bzImage-5998f2bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6221 Comm: syz.2.42 Not tainted 6.16.0-syzkaller-11741-g5998f2bca43e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:199
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003cdf6d8 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b92232e RDI: dffffc0000000003
RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8b92232e
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881246ce000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e8b1dff98 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x13/0x50 mm/kasan/common.c:567
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0xfc/0x350 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0x10f/0x310 mm/pgtable-generic.c:401
 pte_offset_map_lock include/linux/mm.h:3029 [inline]
 zap_pte_range mm/memory.c:1712 [inline]
 zap_pmd_range mm/memory.c:1818 [inline]
 zap_pud_range mm/memory.c:1847 [inline]
 zap_p4d_range mm/memory.c:1868 [inline]
 unmap_page_range+0xacf/0x42c0 mm/memory.c:1889
 unmap_single_vma.constprop.0+0x153/0x240 mm/memory.c:1932
 unmap_vmas+0x218/0x470 mm/memory.c:1976
 exit_mmap+0x1b9/0xb90 mm/mmap.c:1280
 __mmput+0x12a/0x410 kernel/fork.c:1129
 mmput+0x62/0x70 kernel/fork.c:1152
 exit_mm kernel/exit.c:582 [inline]
 do_exit+0x7c7/0x2bf0 kernel/exit.c:949
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x14fa/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f412178eb69
Code: Unable to access opcode bytes at 0x7f412178eb3f.
RSP: 002b:00007ffcf2965e78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f412178eb69
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcf2965edc R08: 0000000af2965f6f R09: 00000000000927c0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00000000000927c0 R14: 00000000000215e0 R15: 00007ffcf2965f30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:199
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003cdf6d8 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b92232e RDI: dffffc0000000003
RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8b92232e
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881246ce000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e8b1dff98 CR3: 000000000e380000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	66 0f 1f 00          	nopw   (%rax)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ef 03          	shr    $0x3,%rdi
  27:	48 01 c7             	add    %rax,%rdi
* 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
  2d:	3c 07                	cmp    $0x7,%al
  2f:	0f 96 c0             	setbe  %al
  32:	c3                   	ret
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)
  3c:	84 00                	test   %al,(%rax)


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

