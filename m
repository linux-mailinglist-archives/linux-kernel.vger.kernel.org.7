Return-Path: <linux-kernel+bounces-674047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B4ACE935
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 07:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0477A174A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 05:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CD91D2F42;
	Thu,  5 Jun 2025 05:16:34 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B138190692
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749100593; cv=none; b=Z4TJtevcQWmuBP3q8ylmmpDfrws90Bmg57Ipj55VtId8I8gBywHEhg94TecQ6xCilcqcJ8NJdjT+bLEUah1gcQy2Bwy5JelqhY2zLGZKxTNb7UzVcWfNQc8eIzNN8ubaV3a6aoOdeffvoK/qaCeerwlFuTLLLcZaqpLPr2kxFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749100593; c=relaxed/simple;
	bh=CYL58g7kYDc1rH0y5+w0eOYo16sWWvSaOQfSGz/KHzo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zcn9G2CFLWTeemhvFOseEqKh6N8vAIfcDo51bJZEJElaNcS97OkFED7KSJpfH8UFrNHsHrsaGxhhkINDesW3mzWdbQwW6rmHGLnY8CeT579w5UsDf+AgWqpTqCnCgkkCc9ZqENmEpbi7Dkx46PxsZ1jKgb6vuxlrb8RByzv9Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cff1087deso112671039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 22:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749100591; x=1749705391;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzfoMGaWZi7K+F5w93H5VmQc+4wXzeXQZAhXGH3uZrE=;
        b=KaYjT2Y0x7KPHEcTuXx15Q2Gn7iDuiUEi7O/4noqR+7ajKh1JL5w9BOjkpwbeEO2IE
         UXIkdPzdQdqjlBk5IzCAndtNmVA8rTkPm+4XbXGyDQ3bqk2PgX+MXtPcyT1dEpZB+GQj
         28z//9gWcNZ9Hx6gJcWSKnqP+stdZO71CYyzMyPMupIEIwulmLIrXWEPH1DDXtC5MUH2
         sbqBktftagh5WMeTBSsWCBkUbaVLzB1Q69nuNM48Uto66s+gB9RJNeRU79s6gY6yxEt/
         mD+A2e7dXXFSAYy7z5MdIM5D8Wvbo0AodKLh6O466Om2tx1SX1d1PI3cXvysjOKvRgoS
         /d+w==
X-Forwarded-Encrypted: i=1; AJvYcCUI5SslnArr3R+l5r7SxPEw7POdX6nUgcR2J83G/5bBwvWClx2UhbaeLBvRRQZfKDVTLX1eu2mJeu7C97s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6Zmo9kPVpcJS0VaSVQS1WKX4q65xvIPc5UpgTEI4ngeKcOyy
	uXXpM7jc9dzhky9BGRH2u9yH9b/LaYsHZpN0Q+N+Q+rk8I7GhqO+7wlaHswwK8qapbEwrqdInb0
	M1tLav7FnxOatQq2Xn+0qk4GHhb3zAx8bRQ7FqQ5/Kb/EjfeIJzfUe3WapiU=
X-Google-Smtp-Source: AGHT+IGL9CPGtTJctwG9cugoEq4QaqsKV0ucSk5e5D2W64n5w+zRUS3hZWmiQpgCRrXXzvnR5oDsXcTZ9M0cnlaYHuCmaWpvXLCk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8d:b0:3db:6fb2:4b95 with SMTP id
 e9e14a558f8ab-3ddbedd422fmr77706325ab.18.1749100591318; Wed, 04 Jun 2025
 22:16:31 -0700 (PDT)
Date: Wed, 04 Jun 2025 22:16:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6841282f.050a0220.2461cf.000d.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_begin_nolock (2)
From: syzbot <syzbot+f34f8bb121f222fb1f38@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a83b350b5be Add linux-next specific files for 20250530
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=125f200c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28859360c84ac63d
dashboard link: https://syzkaller.appspot.com/bug?extid=f34f8bb121f222fb1f38
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e18e458d13c9/disk-3a83b350.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1c40854811c/vmlinux-3a83b350.xz
kernel image: https://storage.googleapis.com/syzbot-assets/571f670b130a/bzImage-3a83b350.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f34f8bb121f222fb1f38@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ocfs2/aops.c:1389!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6894 Comm: syz.4.220 Not tainted 6.15.0-next-20250530-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ocfs2_populate_write_desc fs/ocfs2/aops.c:1389 [inline]
RIP: 0010:ocfs2_write_begin_nolock+0x42e0/0x4340 fs/ocfs2/aops.c:1687
Code: 00 eb 05 e8 82 54 28 fe 49 bd 00 00 00 00 00 fc ff df e9 23 fe ff ff e8 fe dc cd 07 e8 69 54 28 fe 90 0f 0b e8 61 54 28 fe 90 <0f> 0b e8 59 54 28 fe 90 0f 0b e8 51 54 28 fe 90 0f 0b e8 49 54 28
RSP: 0018:ffffc90019b97240 EFLAGS: 00010293
RAX: ffffffff83980b4f RBX: 0000000000000002 RCX: ffff88802530da00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc90019b97800 R08: ffff88802530da00 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff88805b968010
FS:  00005555780fd500(0000) GS:ffff888125c53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2f56bd CR3: 00000000675d4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ocfs2_page_mkwrite fs/ocfs2/mmap.c:93 [inline]
 ocfs2_page_mkwrite+0x600/0xc40 fs/ocfs2/mmap.c:144
 do_page_mkwrite+0x14a/0x310 mm/memory.c:3378
 wp_page_shared mm/memory.c:3779 [inline]
 do_wp_page+0x268d/0x5800 mm/memory.c:3998
 handle_pte_fault mm/memory.c:6105 [inline]
 __handle_mm_fault+0x1144/0x5620 mm/memory.c:6232
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6401
 do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f79671566ab
Code: fa 10 73 2d 83 fa 08 73 46 83 fa 04 73 16 83 fa 01 7c 10 8a 0e 74 0a 0f b7 74 16 fe 66 89 74 17 fe 88 0f c3 8b 4c 16 fc 8b 36 <89> 4c 17 fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5
RSP: 002b:00007fff1cbdc378 EFLAGS: 00010202
RAX: 00002000000005c0 RBX: 0000000000000004 RCX: 0000000000737562
RDX: 0000000000000006 RSI: 0000000075622f2e RDI: 00002000000005c0
RBP: 00007f79673b7ba0 R08: 00007f7967000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 00007f79673b5fac
R13: 00007fff1cbdc470 R14: fffffffffffffffe R15: 00007fff1cbdc490
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_populate_write_desc fs/ocfs2/aops.c:1389 [inline]
RIP: 0010:ocfs2_write_begin_nolock+0x42e0/0x4340 fs/ocfs2/aops.c:1687
Code: 00 eb 05 e8 82 54 28 fe 49 bd 00 00 00 00 00 fc ff df e9 23 fe ff ff e8 fe dc cd 07 e8 69 54 28 fe 90 0f 0b e8 61 54 28 fe 90 <0f> 0b e8 59 54 28 fe 90 0f 0b e8 51 54 28 fe 90 0f 0b e8 49 54 28
RSP: 0018:ffffc90019b97240 EFLAGS: 00010293
RAX: ffffffff83980b4f RBX: 0000000000000002 RCX: ffff88802530da00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc90019b97800 R08: ffff88802530da00 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff88805b968010
FS:  00005555780fd500(0000) GS:ffff888125c53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005561c2044660 CR3: 00000000675d4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

