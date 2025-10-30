Return-Path: <linux-kernel+bounces-879221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADACC2292C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D2C3BDBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5533B949;
	Thu, 30 Oct 2025 22:35:33 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318233B96B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863732; cv=none; b=WwVayaj1VeMukAPiFaU6BP5TfvD5OOo9lQGnf/6ijq65MOWwDY9Axyt6RYqXpVwn29ArHM2V4cl6nU2rRppjsB48mNemThJW+eKdbdz/1FBLG5gP3ge1Ya+iN2S2nAdufL7M5tabipJHLpuSPivifB/aOijzsdKmD+74F2NnU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863732; c=relaxed/simple;
	bh=pHhiEmcH4TfrXRWRl9ZT/C5yKUB2Ot9b0HrCeVjExVY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I+/6ZHBdUMiuP/IblxQEMtCobpwOW9bwEGZk1dVANia1pGnUzi9O1CmYa2CkQE1tDQ1x9EitQNYQtSvcOr9wq7LFQTZ9p62/Y+Ul48AbSUc4dFSiruTASMz2WnBwXj6j5ZhOZntCaKiGkMR+wSLkbRaEK6iiW4McoZtI2nrnUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93e4da7a183so180920639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863730; x=1762468530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fp+4+kCVvDg0f5kqZQEqrS4jtPcNoNwju4JpJrSlTyM=;
        b=Cm61QHGF6RSt1dicjy5VAD872JM2BqMqxifJRXOtQiQ+m+0imUw29ICSyV5iSdXztu
         bGXhW4AS0vyRjJE2qWpPbom1Bakm34YyltVvH/GJraWB/ptjiFZjExvK7Hq8qSleKGu2
         XgQnRrMm4rWlCwksPWTTIpXn2nB6UytVmLccAJMN60WTfvojo5bZcAr1KpGxFcWHjUz0
         O+MissAhJyrHqsI0hOfhum3bOAZ+MU9vYbShBcpLwJ02p8nuAjFO4EmgIuPhIa2lRrbz
         4tqUKXDQ26br71eThuDnKS1ZCjjJ8xUpLrOBeCnQbf7HcDWyltO7M//7MQC1alT1mz0E
         2KZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxv0UJv6hdy8bX0vsSutd12Keewlnf7P9/zShfTy3D8RWBUOuY8AI+EGCbC+JxuBmgX/vGno04TsytDDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygKOS4uGw2uHsKUn2uO2pvW+xWswmJKgInD/6rRujb1CuY3q5
	KXNbE+WQDaOwKbSuCdHQNGXjq2mW9nno4mmh++NI+HK1mDayoJHjBnB+M5k9Yvk7lQqxWVDdlix
	kUAzMQRK/N72CgzmiVPXK87W/pPh2zgS299kJVoyyEJZe1nsCny6KBsxjAoo=
X-Google-Smtp-Source: AGHT+IHknQ7ZbSDfRhb0aP3Ovs7zHXUMcbOpMt8WvY7Z5XLulnLyyblNnCvDDAxofqtD6d+MJY7tvzUOvTYsVwGjDl2rRdYvDBaQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228b:b0:433:5b1:671f with SMTP id
 e9e14a558f8ab-4330d1e1888mr18194775ab.24.1761863730175; Thu, 30 Oct 2025
 15:35:30 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903e832.050a0220.3344a1.044e.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING in ni_rename (2)
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, bigeasy@linutronix.de, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e53642b87a4f Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca5932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d8e30dbafb5c1260479
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17273fe2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15374fe2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69a7713b158/disk-e53642b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7138dd74fe48/vmlinux-e53642b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e715eea6ae3e/bzImage-e53642b8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cd997f980581/mount_0.gz

The issue was bisected to:

commit d2d6422f8bd17c6bb205133e290625a564194496
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri Sep 6 10:59:04 2024 +0000

    x86: Allow to enable PREEMPT_RT.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e84e14580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e84e14580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e84e14580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com
Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5981 at fs/ntfs3/frecord.c:3030 ni_rename+0xee/0x100 fs/ntfs3/frecord.c:3029
Modules linked in:
CPU: 1 UID: 0 PID: 5981 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ni_rename+0xee/0x100 fs/ntfs3/frecord.c:3029
Code: 8b 05 e6 5b a0 0e 48 3b 44 24 10 75 22 44 89 e0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 09 1b c2 07 cc e8 a3 d9 bc fe 90 <0f> 0b 90 eb c5 e8 88 5c be 07 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc90004327a98 EFLAGS: 00010293
RAX: ffffffff8301e45d RBX: 00000000fffffffe RCX: ffff888032795a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000fffffffe R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac52f R12: 0000000000000000
R13: ffff88803c0e0000 R14: ffff888057118f60 R15: ffff888057116ba0
FS:  0000555590f59500(0000) GS:ffff888126efc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f59c3aa1000 CR3: 000000003a7e2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ntfs_rename+0x735/0xbf0 fs/ntfs3/namei.c:332
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c2c65efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd158f078 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f3c2c8b5fa0 RCX: 00007f3c2c65efc9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000200000000580
RBP: 00007f3c2c6e1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3c2c8b5fa0 R14: 00007f3c2c8b5fa0 R15: 0000000000000002
 </TASK>


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

