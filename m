Return-Path: <linux-kernel+bounces-735862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021AB094A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620341C45DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C82FE31C;
	Thu, 17 Jul 2025 19:13:35 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DB259498
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779615; cv=none; b=deVzkUA9chOqRFK8Fc0amgrOW21VwLsql5af/bcEOdBibd3FjARK20R3FXkif63ILVCbYBrw2HTP1NZHyGxHlqfqDT/CQ0XRRA2wQh2S4paG6issgUHALYy+2wwOQYnL0q6eZpSkyXhovsC4JRd4q3+x12vHvJSNYYKVBazIhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779615; c=relaxed/simple;
	bh=7drBQArmul0bNW++/grAft4ilAca/Mnd679QZ+Bn92I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zj6J//ZAxByiOSAx3OkJLBrbFk3ib4v96mdpmpltZ14ZfCtXw42GS0wmSUTQQXcEcGD3FxKPMDJvWAjbIfpwI+1ybTUg/i3K98FzZUCW05C+JZvZ4NNJVEQCK4yHMWRBB2aEwHnjPVpGDXeLhsuq5VwFqlce5vcQCjn5ihzYPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-869e9667f58so251286639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779613; x=1753384413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWdSGCRq+7SVgHzFW0mmkhT41NWWYrMSP/M+TxAFGNI=;
        b=SlDW5AD2yXn/hN/gSelKmNIUeEkf0cYmVJq0kxOes3Xys3pFkWStbdmtoJVYX6GDzK
         wV8Bqb+Umx5dU1ZtZ0BU1QLnVqyAtmWF2S9d8QBjafq3W4YgTrNGSkKSGeKYiNb2pWfB
         xvBnfp04FWA7KZTiT2fKpwkIDFg9N/QrhLFezVnpIdftDfH1c7M+KWohAZdLWRRdxtXZ
         goAsm/7aWmHc2zmWgR0ghC1wS0H70JgEIgK7sL2zeX9Co4MS8zwfA91WeaFFn+ImSODF
         94BAjXQScyc25tGiMezjqoeW0wRg0dy0ZhCSaYsHJZX8y4W3QkLuStGTJRzKDhzKGgCK
         H6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCX/948xJzzI93YcNjIl3eJX4uREURXFhWnwOchIfVE8mqAVjgPOAE4p7xF6IyBrDRmOb8K+px75Ix5cWPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNITdIyhdYXMqddeNTmoA7R3kZJ8Xb9+Vk1ks5TxKiRiAssfl
	iZmXnfAchV9uaCEAkxctUG+N/c2ARxinppw6nLYotDlSH/I3v8mh3oDCVcy0K+f/mTv7tONEC0C
	LFbKEWO/HDfTncXMNB2BGsfoifZCyLE0ZNcW9RDJqstjqftzoh+Wj7xBkz3c=
X-Google-Smtp-Source: AGHT+IFOtEwoW+pIIgXzo3NIwMKX8VH8wayWU79dvKMTTDNcHt64bMPJql7UtkDElqdMDzXnG4soPcCYRJTAKBtOVi0Hz4a/J1il
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:3df:2cd1:f61b with SMTP id
 e9e14a558f8ab-3e282c5298fmr65746315ab.0.1752779612874; Thu, 17 Jul 2025
 12:13:32 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:13:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68794b5c.a70a0220.693ce.0050.GAE@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in move_pages
From: syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8352908bdcd Add linux-next specific files for 20250716
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f81382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7b0e60e17dc5717
dashboard link: https://syzkaller.appspot.com/bug?extid=b446dbe27035ef6bd6c2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10041382580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb158c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae8cc81c1781/disk-e8352908.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57aaea991896/vmlinux-e8352908.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feb871619bd4/bzImage-e8352908.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffea6000391008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13fff8067 P4D 13fff8067 PUD 0 
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5860 Comm: syz-executor832 Not tainted 6.16.0-rc6-next-20250716-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 userfaultfd_move fs/userfaultfd.c:1923 [inline]
 userfaultfd_ioctl+0x2e8b/0x4c80 fs/userfaultfd.c:2046
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff3570d6519
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff35708f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff357160308 RCX: 00007ff3570d6519
RDX: 0000200000000180 RSI: 00000000c028aa05 RDI: 0000000000000003
RBP: 00007ff357160300 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35712d074
R13: 0000200000000180 R14: 0000200000000188 R15: 00002000002b9000
 </TASK>
Modules linked in:
CR2: ffffea6000391008
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	c1 ec 06             	shr    $0x6,%esp
   3:	4b 8d 1c 2c          	lea    (%r12,%r13,1),%rbx
   7:	48 83 c3 08          	add    $0x8,%rbx
   b:	48 89 d8             	mov    %rbx,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  19:	fc ff df
  1c:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  20:	74 08                	je     0x2a
  22:	48 89 df             	mov    %rbx,%rdi
  25:	e8 9a 30 f4 ff       	call   0xfff430c4
* 2a:	48 8b 1b             	mov    (%rbx),%rbx <-- trapping instruction
  2d:	48 89 de             	mov    %rbx,%rsi
  30:	48 83 e6 01          	and    $0x1,%rsi
  34:	31 ff                	xor    %edi,%edi
  36:	e8 59 70 8f ff       	call   0xff8f7094
  3b:	48 89 d8             	mov    %rbx,%rax
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


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

