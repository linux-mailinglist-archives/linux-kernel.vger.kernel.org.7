Return-Path: <linux-kernel+bounces-899862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF34EC59031
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47A74268E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F29302156;
	Thu, 13 Nov 2025 16:44:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C6264638
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052275; cv=none; b=EmvHSP7BhVcUDM/5csnYUylWxLE1YaZvafGBtXrJHL7PD7LNpYl6k/U5vriILOs2oavh6S6BihKT8x31v8IKf9lZTctdzVh2ZjhWDSD3I1PNAqCTpyKoBDK/GPd+ViR8cmcuhsU0l9+Phrhb38krzjQnRM0f16AEJ2u49aZTspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052275; c=relaxed/simple;
	bh=Rb/r9qORZ0p4+buSqlPGhVhIHiba8wIgHkZ/KFORVos=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AmfwcSqpFU+Hkm4mErlVEGxYrDzP37uoI4fHyw8H0amy0SblA2bAkQFH4iR1RgkJnaGHaVldHxBV2TVb5/LNqBWa7itW83Cng4lqVAU6x5ByFc7BAB6CsxqSxMAJ3RpXLwJbCXRuLWrVnZFuUylttFP+sDMMntrFjADuRgVELbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43373024b5eso12600535ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052273; x=1763657073;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hWwj6fy0/rB4RTGq3xc0Fnf3TBZ5FQ1+cI6MAHTftw=;
        b=UFDS9oGpvGjKYOM3DDaWYZ7E1gM7as012pZJBH4b7mBG5+dtfIdvicXiLB5IISN098
         ++ptZxZFd4aUZZ5u6stGeGtYsIs63dgnl+CH8ahqLCQ8CdybLPmNIr00kuNCQ+FBThOQ
         oxubNs2MtN1iKDgp7rDIltFVhmNmjh6rj0tAO0FLSeRM/ZZrBRZYncbKOIQfzyAdwzMy
         aF29oeVglC1bI5RHWOpXhV4K+1xY7MOu2oqsNF22EpYjW+tjnb5X05W9arorsUFHB9Fw
         EOuO/AjhLdjcS0h8P6RtS0RUpV+be0G4gN/cqPRsBbVMcN3sQgsV19GeLNlyEeNu7KXX
         oC4A==
X-Forwarded-Encrypted: i=1; AJvYcCW10RVNNIGuiFUXng3fZKT0u6RCpDP/56wJ0wx7OUYW1tis8RHNy0kY0+chQXvJEPwK622NF9F82uYPjbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9+OuWUeoyoTfCrsCxXNbyCdxul8MGlGcBHEX0pY+BfHgceG3
	GXxdO8+XFysgJYXF9AXUz0rkhIeHcKpWDAxdE9fL5XzkSDze/MoaTUAVsi76IbEkfs5O/1qmj48
	9K8530okZ/FQvEL5R03Q3SA5ws/sn73A3x1qbKGe4TUEmAvBcrcCHbW8ZmnM=
X-Google-Smtp-Source: AGHT+IHre4HCgG9GhvCzJ0gFY0mlLiuN0+e+eYoIL2GvRl8FPVjZMC7Eur1YKvNmwVrxt2BFGjOPilXW+o48jPUq2OZKPCwspRhH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:433:6c42:1817 with SMTP id
 e9e14a558f8ab-4348c878307mr2690715ab.6.1763052273319; Thu, 13 Nov 2025
 08:44:33 -0800 (PST)
Date: Thu, 13 Nov 2025 08:44:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69160af1.050a0220.3565dc.002d.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (3)
From: syzbot <syzbot+18d274a59b87cf80e86d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    439fc29dfd3b Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15484412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=18d274a59b87cf80e86d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87634fccbb6c/disk-439fc29d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d7897eed027/vmlinux-439fc29d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/388814b7d484/bzImage-439fc29d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18d274a59b87cf80e86d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 23212 at mm/page_table_check.c:191 page_table_check_pte_flags mm/page_table_check.c:191 [inline]
WARNING: CPU: 0 PID: 23212 at mm/page_table_check.c:191 __page_table_check_ptes_set+0x13e/0x2f0 mm/page_table_check.c:204
Modules linked in:
CPU: 0 UID: 0 PID: 23212 Comm: syz.0.4613 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:page_table_check_pte_flags mm/page_table_check.c:191 [inline]
RIP: 0010:__page_table_check_ptes_set+0x13e/0x2f0 mm/page_table_check.c:204
Code: b8 00 00 00 00 00 00 00 70 49 39 c7 74 21 48 b8 00 00 00 00 00 00 00 6c 49 39 c7 75 1d e8 3a 29 8f ff eb 10 e8 33 29 8f ff 90 <0f> 0b 90 eb 10 e8 28 29 8f ff 90 0f 0b 90 eb 05 e8 1d 29 8f ff 31
RSP: 0000:ffffc9000fd27990 EFLAGS: 00010287
RAX: ffffffff8230ea9d RBX: 00000000397c2c67 RCX: 0000000000080000
RDX: ffffc9000c8da000 RSI: 00000000000042d3 RDI: 00000000000042d4
RBP: 0000000000000001 R08: ffffea0000e5f087 R09: 1ffffd40001cbe10
R10: dffffc0000000000 R11: fffff940001cbe11 R12: 0000000000000001
R13: 00000000397c2c67 R14: ffff8880525baff0 R15: ffff88801a05ab00
FS:  0000000000000000(0000) GS:ffff88812613b000(0063) knlGS:00000000f54bdb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000080ffe000 CR3: 0000000077a7e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
 set_ptes include/linux/pgtable.h:292 [inline]
 do_swap_page+0x5248/0x5b20 mm/memory.c:4970
 handle_pte_fault mm/memory.c:6180 [inline]
 __handle_mm_fault+0xe55/0x5400 mm/memory.c:6318
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6487
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0023:0xf70ef1f0
Code: 50 6a 00 e8 c2 10 14 00 8b 5c 24 2c 8b 4c 24 28 83 c4 20 8b 55 40 89 03 03 11 85 f6 74 18 31 c0 8d b4 26 00 00 00 00 8d 76 00 <89> 02 83 c0 01 83 c2 04 39 c6 75 f4 83 c4 1c 89 f8 5b 5e 5f 5d c3
RSP: 002b:00000000f54bd540 EFLAGS: 00010202
RAX: 0000000000000800 RBX: 00000000800000c0 RCX: 0000000080000000
RDX: 0000000080ffdfff RSI: 0000000000000efe RDI: 0000000000000008
RBP: 0000000080000140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	50                   	push   %rax
   1:	6a 00                	push   $0x0
   3:	e8 c2 10 14 00       	call   0x1410ca
   8:	8b 5c 24 2c          	mov    0x2c(%rsp),%ebx
   c:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  10:	83 c4 20             	add    $0x20,%esp
  13:	8b 55 40             	mov    0x40(%rbp),%edx
  16:	89 03                	mov    %eax,(%rbx)
  18:	03 11                	add    (%rcx),%edx
  1a:	85 f6                	test   %esi,%esi
  1c:	74 18                	je     0x36
  1e:	31 c0                	xor    %eax,%eax
  20:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  27:	8d 76 00             	lea    0x0(%rsi),%esi
* 2a:	89 02                	mov    %eax,(%rdx) <-- trapping instruction
  2c:	83 c0 01             	add    $0x1,%eax
  2f:	83 c2 04             	add    $0x4,%edx
  32:	39 c6                	cmp    %eax,%esi
  34:	75 f4                	jne    0x2a
  36:	83 c4 1c             	add    $0x1c,%esp
  39:	89 f8                	mov    %edi,%eax
  3b:	5b                   	pop    %rbx
  3c:	5e                   	pop    %rsi
  3d:	5f                   	pop    %rdi
  3e:	5d                   	pop    %rbp
  3f:	c3                   	ret


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

