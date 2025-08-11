Return-Path: <linux-kernel+bounces-762556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65EEB2086B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB29179315
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D22D374B;
	Mon, 11 Aug 2025 12:10:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051091FF7C5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914204; cv=none; b=TvDmJSInM1eFly5SiA44BspPgHBMdsUEFzt6a0UJJUX+Buf/8hgB111Z4M8soaByc/KLuRPeiPqhXb9R0JIr2y2+/uuEFxf8NRyVE6yl1vyTXXen5lE7UFinmUoKhFE9VRAZ3A++sT5pHZH1PqTZaajFmLqBhRANJAdaz/ZEri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914204; c=relaxed/simple;
	bh=WK8BLbu4zcbrr7zAD4Ni+EMiEXtO/asYiH3Hxnv5PUs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=caL5kn2mEI/Hi7b5DbWYIoSd2xSGc2Q01T2OSkfL75ZU3pu58iaMQF0rpLfz+xICfnih98KiYJYNXnQaVfKlF282L1a2Pxu/WyEXaijutckkW9n029Ml5zvf+UDOEsP0h0KINtkJ4Y6L7U0F47uiFQ4/r85nJRjZKWPCBBCzm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8818b1512c2so398755539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914202; x=1755519002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CixOtvGZ44uJvm8NlZgJ9QgLrtaQdbBbTc3WcQWcOEY=;
        b=oyliv+sy5Mcn/9MRXOTaOZ8Ht7Yinqc1NZUYZzLdfA4j/KGedKjPXng8Kwp3/1lBKm
         s1CVNJvJZVDbGvEabhbcLSEM+jvfvDCQmZJx8SMQLnbs6ad1CvNO3oaeVr1PuVEal9+C
         BOm15pJZtTqQHUR+efL3PDaKkU2tpcRxPEBWlnB/jC4ir1DWRMk+N0nP5O0RxBEdI6r1
         Ei77KZpKvIa6plJ63z7hWv6V5kjq+psV+/k/aYBFg2OG7HsJDg5frVCewnNcICRrH2Lz
         ELj7VLvVPzh7UwI9F4MGdbzCSNSkoj+U2VtO0+TemcCdFnZzZSzvc+rrlXI/c2iiRObt
         eO/w==
X-Forwarded-Encrypted: i=1; AJvYcCUWyVYWuUrMh3Gx/Sph+5Wm/B1WnAvvOC8JGnpgoOrWUCfXsIPK5L7VyPF3PEUGvAxoGncAE02ZbTYnfOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bJS/A+eJk2bNzw/UqAlV4nKLm05GQqf6SvHfD4MGsm3wasLk
	s6NvxW1zQisU0OB9JWvE3SFmSWG1I4+7nAjDw1eEKIo5zRIS3JbqdUaeQ/KDG5iy3rqXr74Ktm0
	HurKuIY/fgGkiBW0vkYT7kJ241rMAU8kgKaaUS9xKZ0aOX1fS/syh+HdubIU=
X-Google-Smtp-Source: AGHT+IFFaSSqcK2VVcYkcpHOcQ04/ZKBNEPCi2ZO/mBAqvFdf64pnCfIxm+g6ma5g3Sg9n/oRSz/MJ5ncwcmQrnshBzA6lcRqvVT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168c:b0:881:9f3e:803d with SMTP id
 ca18e2360f4ac-883f10d943amr2377308639f.0.1754914202044; Mon, 11 Aug 2025
 05:10:02 -0700 (PDT)
Date: Mon, 11 Aug 2025 05:10:02 -0700
In-Reply-To: <5a259275-e284-49b5-80d4-929c60b5c1cc@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6899dd9a.a70a0220.7865.003d.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
From: syzbot <syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in f2fs_write_end_io

F2FS-fs (loop3): inconsistent node block, node_type:0, nid:11, node_footer[nid:0,ino:0,ofs:0,cpver:0,blkaddr:0]
------------[ cut here ]------------
kernel BUG at fs/f2fs/data.c:362!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6596 Comm: udevd Not tainted 6.17.0-rc1-syzkaller-00023-g637a17c27a3d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:f2fs_write_end_io+0xb52/0xb60 fs/f2fs/data.c:361
Code: e8 d3 f8 14 fe e9 91 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c e3 f6 ff ff 48 89 df e8 49 f9 14 fe e9 d6 f6 ff ff e8 2f bc b3 fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000a08c98 EFLAGS: 00010246
RAX: ffffffff840bee61 RBX: 0000000000000000 RCX: ffff88802bcc1e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 000000000000000b
RBP: ffff888032b70780 R08: ffffea0001c68b47 R09: 1ffffd400038d168
R10: dffffc0000000000 R11: fffff9400038d169 R12: 0000000000000006
R13: ffffea0001c68b40 R14: 000000000000000b R15: dffffc0000000000
FS:  00007ff87043e880(0000) GS:ffff888125d54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555da2608 CR3: 00000000297cc000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 blk_update_request+0x57e/0xe60 block/blk-mq.c:989
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1151
 blk_complete_reqs block/blk-mq.c:1226 [inline]
 blk_done_softirq+0x107/0x160 block/blk-mq.c:1231
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0x2b5/0x3e0 kernel/locking/lockdep.c:5893
Code: 51 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f7 44 24 20 00 02 00 00 75 56 f7 c3 00 02 00 00 74 01 fb 65 48 8b 05 8b 52 ff 10 <48> 3b 44 24 28 0f 85 8b 00 00 00 48 83 c4 30 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc9000405f7f0 EFLAGS: 00000206
RAX: c28614321895e300 RBX: 0000000000000202 RCX: c28614321895e300
RDX: 0000000000000000 RSI: ffffffff8db908ee RDI: ffffffff8be25680
RBP: ffff88802bcc28f0 R08: ffffc9000405fc88 R09: 0000000000000000
R10: ffffc9000405f978 R11: fffff5200080bf31 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8e139ee0 R15: ffff88802bcc1e00
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 vfs_fstatat+0x122/0x170 fs/stat.c:376
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff86fd11b0a
Code: 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 b9 f2 0d 00 f7
RSP: 002b:00007ffe39f06778 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00007ffe39f06c10 RCX: 00007ff86fd11b0a
RDX: 00007ffe39f06780 RSI: 00007ffe39f06c10 RDI: 00000000ffffff9c
RBP: 0000559859a37910 R08: 0000000000000000 R09: 0000000000000020
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe39f06810
R13: 00007ffe39f07045 R14: 00005598470f0ca4 R15: 00005598470f0bcc
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_end_io+0xb52/0xb60 fs/f2fs/data.c:361
Code: e8 d3 f8 14 fe e9 91 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c e3 f6 ff ff 48 89 df e8 49 f9 14 fe e9 d6 f6 ff ff e8 2f bc b3 fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000a08c98 EFLAGS: 00010246
RAX: ffffffff840bee61 RBX: 0000000000000000 RCX: ffff88802bcc1e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 000000000000000b
RBP: ffff888032b70780 R08: ffffea0001c68b47 R09: 1ffffd400038d168
R10: dffffc0000000000 R11: fffff9400038d169 R12: 0000000000000006
R13: ffffea0001c68b40 R14: 000000000000000b R15: dffffc0000000000
FS:  00007ff87043e880(0000) GS:ffff888125d54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555da2608 CR3: 00000000297cc000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	51                   	push   %rcx
   1:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   8:	00 00
   a:	9c                   	pushf
   b:	8f 44 24 20          	pop    0x20(%rsp)
   f:	f7 44 24 20 00 02 00 	testl  $0x200,0x20(%rsp)
  16:	00
  17:	75 56                	jne    0x6f
  19:	f7 c3 00 02 00 00    	test   $0x200,%ebx
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 8b 52 ff 	mov    %gs:0x10ff528b(%rip),%rax        # 0x10ff52b5
  29:	10
* 2a:	48 3b 44 24 28       	cmp    0x28(%rsp),%rax <-- trapping instruction
  2f:	0f 85 8b 00 00 00    	jne    0xc0
  35:	48 83 c4 30          	add    $0x30,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


Tested on:

commit:         637a17c2 f2fs: fix to do sanity check on node footer i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common
console output: https://syzkaller.appspot.com/x/log.txt?x=1026f434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f6e4cb78ac1b7bb
dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

