Return-Path: <linux-kernel+bounces-889881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE466C3EC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4D34EB13C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBC30217B;
	Fri,  7 Nov 2025 07:30:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD21AA1D2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500630; cv=none; b=Ltmia3sHPDbhfK89xT8E+eWCZ11kIJA16FxXt+W7gfBoQsAyRKhvOGd/NBdWu1NtKNymPAPh6q3tBIR1hpoP2WMPhDOJov4jWRU1KTWdRHNmt7v9q1rSarlC4B60rU75j6UCMExIwdfXpac6vgLcHhkyyfcvmKkRdHYftdLxyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500630; c=relaxed/simple;
	bh=2k51oEy1wZDZS3+4S8C70iHgogedvYziIarvQYK/Or8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DUZxkp0mrHkW0mRA/ma98JF/KstPqPyRFuvXYeB0okb0lUgDRcNvsFRa2Ur7K7ZdU5GO7SMqOWAtQdbadsLSGLkOuf4jctLO50wAhBy07aKUyYoQfaSyTMbvVTjYDxfrbLFo8mhg8d3o/mLGi1agsk4PbXuawHREd3W6rIbMR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43322b98837so4883665ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500627; x=1763105427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPxYHjnO12MHR50muRIGPWkB6uCToTIOy8FbrPLJHnk=;
        b=EbEw9KlnLRCnTR3n2TuhDcNvOfzskRGT9NYYXRBUT8qDF3VjxlAOUezs5EMh7w6Ai5
         Dzvb8YbUNb49yxs/t16yrjQt9mnok2kgBKFoA09NGyR/PuRM7Y63oLaE4W9m+zReQpqv
         aZBrFEmFzTUa7E5ij41TVoWt1rtNtI2AlVan2DN86V6UGeb1cyjG88JSAvsCmFafLGkB
         xgrJVWhVJsh1ge1N6QIKYKXvlrqJnEcNjpn9Vj1Jl1PESPnuw4vXYhRJm3DmxLvc789s
         DARRzxx88KFLPEhqMlFz9oIvYNw+g9ATpTvJE7ZASstppvM0ESRDZdPhwjhV2MmQjY84
         BufQ==
X-Gm-Message-State: AOJu0YzFkte7mqBNqFkhxMl41hh08gKJGDYuJcmCo+EyDd7IAouKsXYi
	jd5AN9saoJ1LWOT4gK01v2zMjVFqU6nALqsqXW/ggTSF1CQatwagGvL9X1LVEdpdHzNgHa2qvPx
	s83oSGipdbLYMEBRE9XcOtBgXxi12hFXPx0bud1/lPfGkW01ITMOAPSi5kdnr2Q==
X-Google-Smtp-Source: AGHT+IEG9f5ZU2gL6JNAk7kLQ0ek86EsJmg5GAy4iiUqG6Nju9sSfebPnWAoL2/1yrb8+561PZpLyYpB2WpePb9TjzW75y/6Fw23
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:433:3505:51c2 with SMTP id
 e9e14a558f8ab-4335f3b3bedmr34042285ab.9.1762500627654; Thu, 06 Nov 2025
 23:30:27 -0800 (PST)
Date: Thu, 06 Nov 2025 23:30:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da013.a70a0220.22f260.0024.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in alloc_pid
From: syzbot <syzbot+36d7fcb891b92b056986@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84d39fb9d529 Add linux-next specific files for 20251105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164ea532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=413cf24e78b667b9
dashboard link: https://syzkaller.appspot.com/bug?extid=36d7fcb891b92b056986
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174d2084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a3a114580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49de85e8d717/disk-84d39fb9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fd90ea7659f/vmlinux-84d39fb9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/235e0ee874fe/bzImage-84d39fb9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36d7fcb891b92b056986@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:288 at __ns_ref_active_get include/linux/ns_common.h:288 [inline], CPU#0: syz-executor/5947
WARNING: ./include/linux/ns_common.h:288 at alloc_pid+0xad6/0xc70 kernel/pid.c:285, CPU#0: syz-executor/5947
Modules linked in:
CPU: 0 UID: 0 PID: 5947 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_get include/linux/ns_common.h:288 [inline]
RIP: 0010:alloc_pid+0xad6/0xc70 kernel/pid.c:285
Code: cc e8 8e ab 34 00 be 02 00 00 00 eb 0a e8 82 ab 34 00 be 01 00 00 00 48 89 df e8 35 41 0a 03 e9 84 fa ff ff e8 6b ab 34 00 90 <0f> 0b 90 e9 2c fd ff ff e8 5d ab 34 00 90 0f 0b 90 e9 5b fd ff ff
RSP: 0018:ffffc900034679d8 EFLAGS: 00010293
RAX: ffffffff818cc255 RBX: ffff888027d75998 RCX: ffff888027f95b80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff8880288abc01 R08: ffff888027d7599b R09: 1ffff11004faeb33
R10: dffffc0000000000 R11: ffffed1004faeb34 R12: dffffc0000000000
R13: 1ffff110051157b1 R14: ffff888027d75830 R15: dffffc0000000000
FS:  0000555571fd2500(0000) GS:ffff888125a8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2d78f156c0 CR3: 000000002fc74000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_process+0x18e7/0x3930 kernel/fork.c:2196
 kernel_clone+0x21e/0x840 kernel/fork.c:2609
 __do_sys_clone kernel/fork.c:2750 [inline]
 __se_sys_clone kernel/fork.c:2734 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d78185e13
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffeeee4fee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2d78185e13
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 0000555571fd27d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 000000000001955c R15: 00007ffeeee50080
 </TASK>


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

