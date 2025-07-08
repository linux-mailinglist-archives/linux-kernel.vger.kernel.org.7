Return-Path: <linux-kernel+bounces-722141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B79AFD5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CCC7A9CE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624FE2E717F;
	Tue,  8 Jul 2025 17:52:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5B2E6D08
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997150; cv=none; b=ctS7+5GQyOMtGnB7KGTVCdNcDFy0T0rjfe98VRX7nC3DFgb2PnkJc/Lk8wpSaW3YMDFkzOc6QL5waKpjI0Zd3iPFwXYzS8E+RtrjhXut+kybn9G8WepqPSB1IwB6w2+ajZ+M11+p7Cn/iZhhI2jrro2JUQFXkqCcARjM7wCGRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997150; c=relaxed/simple;
	bh=raqfKm1Ddhkys2uymzfmJ5mW14IHvpYEkzirh2O/1QY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JdDTLSbZ2cQOuBELg/MbucfuAz/F1h0xweBxwEXsMywV+pZtIVoQ49n3lisGhPY62Inl1WTEkHHmHgloEfvtflSwBqqbQATtIYMPjUHiXL0wagwQxxzSzJlINqcelUPOAmwHkQzFHj4agXKTkrLwRyvU2bxW2ESXFpRouUM6S9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd5cd020dso104607185ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997148; x=1752601948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ny6or7BKp9ehynMnqSKdVfi1cxR+4gT3nWksYBIqyNo=;
        b=qNMIG3X5FdTF7jnnnjAn3wfL7CLSIkk/9jQdbQtcXyehx5mv4ZhjNTI7xTHZY5yVHh
         brFn8OnyAnXVG6fMKAGCVla5bvEV9POkP1grsgrNwRcAVE0dMMY97vo255uMWcUNzsap
         cl8SFHUhQupSHoO+Z70yhdFA9hVjFTKVQustR2luXNt7h++fPRT93CzcdE1rbboLylOr
         hWymtdEIEdutiJfcKV63kEyRxRCru9TzoIlEnfouNkM5QDQL/kmNAzk659/bWNXZo8SK
         ZuTTuaUMTv/d67gGBiYgIWLdRno4T5uKAq0++b7DCbLYarIf0hV8SFw4fqjdq04tTteC
         5xlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ByJJKJ664bCOUE0eEfmSTNEBZ7PW1Y8WdFuUXiuMIxu1fGTytqW4jrw6MFrinY/D7RyAcZal2Nkhh+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWno1r7FR5eF4LiQQu6W4wu80BfQAHO/wAA5adrtiH2UZtRcu
	kMhj/Yioy6FuS1irP0mgeag5qd1RnZ/yJawYlAW15Cv6A1wSm2HpvRCz7yFLTM/IgBEKRLtJFSw
	b3fP5lPDS2Rfv0JAKZdV/KoIjBgQPvPQE+QEzT5HBn/00GAWOU1YOeG/1edE=
X-Google-Smtp-Source: AGHT+IEJMOFc+Tzu3aAKQYVyDD//jl/FNtdHH7hxJxOxuUhrp1eglGzrhLPjCvjahKddZpuDYIQMFy3NSLGAugdYxo1TkXWuNfcQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1527:b0:3e0:4f66:310a with SMTP id
 e9e14a558f8ab-3e1355a8e41mr169189265ab.16.1751997147727; Tue, 08 Jul 2025
 10:52:27 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:52:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d5adb.050a0220.1ffab7.001a.GAE@google.com>
Subject: [syzbot] [kernel?] divide error in comedi_inc_scan_progress
From: syzbot <syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1250d28c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51185bd4f40ad44
dashboard link: https://syzkaller.appspot.com/bug?extid=af53dea94b16396bc646
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f933e0e4a6c5/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a82be954c91b/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66dbc3de1264/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 9896 Comm: syz.3.1000 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:comedi_inc_scan_progress+0x1cc/0x340 drivers/comedi/drivers.c:556
Code: 00 00 00 03 43 2c 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 14 11 84 d2 74 09 80 fa 03 0f 8e 53 01 00 00 31 d2 <f7> b3 80 00 00 00 89 53 2c e8 a6 76 cd f8 48 8d 7b 34 48 b8 00 00
RSP: 0018:ffffc90000007da0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: ffff88807af3e400 RCX: 1ffff1100f5e7c90
RDX: 0000000000000000 RSI: ffffffff88ee6f98 RDI: ffff88807af3e480
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000002 R15: 0000000010000000
FS:  00007f7abf9b16c0(0000) GS:ffff888124718000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000084030 CR3: 00000000317d4000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 comedi_buf_write_samples+0x406/0x640 drivers/comedi/comedi_buf.c:603
 aio_iiro_16_cos+0x132/0x160 drivers/comedi/drivers/aio_iiro_16.c:69
 __handle_irq_event_percpu+0x22c/0x7d0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x28e/0xab0 kernel/irq/chip.c:797
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:254 [inline]
 call_irq_handler arch/x86/kernel/irq.c:266 [inline]
 __common_interrupt+0xdf/0x250 arch/x86/kernel/irq.c:292
 common_interrupt+0xba/0xe0 arch/x86/kernel/irq.c:285
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0xd7b/0x1510 kernel/smp.c:885
Code: e8 6a 19 0c 00 45 85 ed 74 46 48 8b 14 24 49 89 d6 49 89 d5 49 c1 ee 03 41 83 e5 07 4d 01 e6 41 83 c5 03 e8 07 1e 0c 00 f3 90 <41> 0f b6 06 41 38 c5 7c 08 84 c0 0f 85 6f 05 00 00 8b 43 08 31 ff
RSP: 0018:ffffc9000214f2b8 EFLAGS: 00000246
RAX: 0000000000080000 RBX: ffff8880b853fe20 RCX: ffffc9000f741000
RDX: 0000000000080000 RSI: ffffffff81afc8a9 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000003 R14: ffffed10170a7fc5 R15: ffff8880b843b580
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1052
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x4a0/0x1790 arch/x86/mm/tlb.c:1451
 flush_tlb_page arch/x86/include/asm/tlbflush.h:324 [inline]
 ptep_clear_flush+0x136/0x180 mm/pgtable-generic.c:101
 wp_page_copy mm/memory.c:3635 [inline]
 do_wp_page+0x1683/0x4f20 mm/memory.c:4030
 handle_pte_fault mm/memory.c:6085 [inline]
 __handle_mm_fault+0x2223/0x5490 mm/memory.c:6212
 handle_mm_fault+0x589/0xd10 mm/memory.c:6381
 do_user_addr_fault+0x7a6/0x1370 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_nocheck_4+0x3/0x10 arch/x86/lib/putuser.S:104
Code: d9 0f 01 cb 89 01 31 c9 0f 01 ca c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 01 cb <89> 01 31 c9 0f 01 ca e9 c1 5a 03 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000214f9f8 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000200000084030
RDX: 0000000000080000 RSI: ffffffff89561a63 RDI: 0000000000000005
RBP: ffffc9000214fd98 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
R13: 0000200000084000 R14: ffffc9000214fddc R15: 0000000000000002
 ____sys_recvmsg+0x2ee/0x6b0 net/socket.c:2799
 ___sys_recvmsg+0x114/0x1a0 net/socket.c:2828
 do_recvmmsg+0x2fe/0x750 net/socket.c:2923
 __sys_recvmmsg net/socket.c:2997 [inline]
 __do_sys_recvmmsg net/socket.c:3020 [inline]
 __se_sys_recvmmsg net/socket.c:3013 [inline]
 __x64_sys_recvmmsg+0x22a/0x280 net/socket.c:3013
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7abeb8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7abf9b1038 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f7abedb6160 RCX: 00007f7abeb8e929
RDX: 0000000000010106 RSI: 00002000000000c0 RDI: 0000000000000008
RBP: 00007f7abec10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7abedb6160 R15: 00007fff425d3008
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:comedi_inc_scan_progress+0x1cc/0x340 drivers/comedi/drivers.c:556
Code: 00 00 00 03 43 2c 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 14 11 84 d2 74 09 80 fa 03 0f 8e 53 01 00 00 31 d2 <f7> b3 80 00 00 00 89 53 2c e8 a6 76 cd f8 48 8d 7b 34 48 b8 00 00
RSP: 0018:ffffc90000007da0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: ffff88807af3e400 RCX: 1ffff1100f5e7c90
RDX: 0000000000000000 RSI: ffffffff88ee6f98 RDI: ffff88807af3e480
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000002 R15: 0000000010000000
FS:  00007f7abf9b16c0(0000) GS:ffff888124718000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000084030 CR3: 00000000317d4000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	03 43 2c             	add    0x2c(%rbx),%eax
   5:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
   c:	fc ff df
   f:	48 89 f9             	mov    %rdi,%rcx
  12:	48 c1 e9 03          	shr    $0x3,%rcx
  16:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
  1a:	84 d2                	test   %dl,%dl
  1c:	74 09                	je     0x27
  1e:	80 fa 03             	cmp    $0x3,%dl
  21:	0f 8e 53 01 00 00    	jle    0x17a
  27:	31 d2                	xor    %edx,%edx
* 29:	f7 b3 80 00 00 00    	divl   0x80(%rbx) <-- trapping instruction
  2f:	89 53 2c             	mov    %edx,0x2c(%rbx)
  32:	e8 a6 76 cd f8       	call   0xf8cd76dd
  37:	48 8d 7b 34          	lea    0x34(%rbx),%rdi
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

