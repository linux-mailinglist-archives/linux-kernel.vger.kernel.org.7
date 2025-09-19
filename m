Return-Path: <linux-kernel+bounces-824519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D479FB89745
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A325A30BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE113D638;
	Fri, 19 Sep 2025 12:30:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACB4502F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285034; cv=none; b=nfj8+KSR7uVAJUKJP6yKMLGIJqX2dqs8NyocPybhJQJ7jHoSAEaIC46LQYAgFYEN8R9FcvxbDAarA2wRXfajefmR7oB/FRl7wiwD2p0LPERiY1sVuxtI6gq1spPBoTdAxCM0rc02SJRhnkORQmTU9mgGIVccbvA2qQ95tAWbcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285034; c=relaxed/simple;
	bh=jj+inExAUbsFvsAoHvcW6L6sYHa02yk0gKG/4O/EIfI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rxVCeo364UFYSnbk/r7MmpWN/PUgMGUij/9STU4AGFU637e8dvDOGqjhmDRrP1/LdbCtWg3AXFIku3rqry/0f5O8eVIFmtJpDkq+CmZ2BXcgjB9s5CX4HF2CRR12Wad3XfHj7/q+Dob3Zc5cL+qqu39DUMxWegnZqy+jJ0wAbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42408b5749aso43332735ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285032; x=1758889832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfmW+GAM56h3CvQewvV1CQQSb+YXqeP7gXYwDwlkbDI=;
        b=g26AhTjeML7I1ThoLd3xabu9WdqaxQYUfxFiUR05cvksoqAT5h8G6U5kiFQjuhZXi/
         e0kIC46yV8Mg7iQCsIQPqdMjnxSfVfjqH7wi/btKpDUBt4AToFe0GyWAXba6j4xu0Q3t
         ofgHt+S6K/zdkiWimj9g007hrSJAWY9Ha0ehmWGoXI0nftJ//NINeupIieW6hoihkJk+
         CeMawGopZwQAmhsVhpoxraXMa/FoYvB+uRyLtvQWtRX4Tg7uGGzYiEAkxBdiJxXwUwq9
         a2fVRP/Z4OahZafQMcJeiawuri4KDMcBKwArUTxb3orX97AKgKsetWxc178Cy2poYu57
         uD4w==
X-Forwarded-Encrypted: i=1; AJvYcCVFs5Li9B+/VMhBeFq0+howlwosziZVVp6AmfsIpRPy6Vz8SjAuALKPObwJMa4Ygw/roWTMi+a5X2G98hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwOvPQ6onxnZ4scBGgYIgvSX5PEffwanfCX4RtDN6RsFMaQd8
	12eaRyEUH1H8HdiZ3ddVoqeon3OqMIrBWkqrGBNxBRdB3WC/Ld9lZKXVSo7/uNhPOH1uACoPK3K
	Lc05mXX0iaxYOFQAdP5K4hJubGKilnUd9pqPoPd2nPTDG4v6v40byk691ez8=
X-Google-Smtp-Source: AGHT+IHuHQvi7jWB2wMCGFEBNaVivefmUoLBpiF4aCIEWV/q4WZ5Vh5vWhUfCvJfaUz5ZUQR+kG2FTmzSoBj/tyIm+ej7FnkuAF9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-4248177d40emr46555385ab.9.1758285032406; Fri, 19 Sep 2025
 05:30:32 -0700 (PDT)
Date: Fri, 19 Sep 2025 05:30:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd4ce8.050a0220.ba58e.045e.GAE@google.com>
Subject: [syzbot] [overlayfs?] WARNING in ovl_create_real (3)
From: syzbot <syzbot+59732cea2887c2408d94@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1511e762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=59732cea2887c2408d94
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f83ec76b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdedf70f8797/vmlinux-f83ec76b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bf9318d9242/bzImage-f83ec76b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59732cea2887c2408d94@syzkaller.appspotmail.com

overlayfs: ...falling back to redirect_dir=nofollow.
overlayfs: ...falling back to index=off.
overlayfs: ...falling back to uuid=null.
------------[ cut here ]------------
WARNING: CPU: 3 PID: 2192 at fs/overlayfs/dir.c:208 ovl_create_real+0x50f/0x780 fs/overlayfs/dir.c:208
Modules linked in:
CPU: 3 UID: 0 PID: 2192 Comm: syz.3.9488 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ovl_create_real+0x50f/0x780 fs/overlayfs/dir.c:208
Code: 84 74 fc ff ff e8 b1 32 81 fe 48 63 ed e9 96 fc ff ff e8 a4 32 81 fe e9 2e fd ff ff 48 89 dd e9 84 fc ff ff e8 92 32 81 fe 90 <0f> 0b 90 e8 89 32 81 fe 48 89 ee 48 c7 c7 00 f0 ff ff e8 ea 2d 81
RSP: 0018:ffffc90007e9f4f0 EFLAGS: 00010283
RAX: 00000000000151fe RBX: ffff888038a89d60 RCX: ffffc9002b804000
RDX: 0000000000080000 RSI: ffffffff833a6aae RDI: ffff888038a89dc8
RBP: ffff888038a89d60 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880332f66a0
R13: ffff888031447c20 R14: 000000000000a000 R15: 000000000000a000
FS:  00007f83766e46c0(0000) GS:ffff8880d69b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ef21ff8 CR3: 0000000032996000 CR4: 0000000000352ef0
DR0: 0000000000000002 DR1: 0000000000000005 DR2: 8000000000000000
DR3: 1000000100000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ovl_create_temp+0x64/0xb0 fs/overlayfs/dir.c:229
 ovl_copy_up_workdir fs/overlayfs/copy_up.c:782 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:1001 [inline]
 ovl_copy_up_one+0xc18/0x38e0 fs/overlayfs/copy_up.c:1202
 ovl_copy_up_flags+0x18d/0x200 fs/overlayfs/copy_up.c:1257
 ovl_rename+0x813/0x1710 fs/overlayfs/dir.c:1145
 vfs_rename+0xfba/0x22c0 fs/namei.c:5129
 do_renameat2+0x7f9/0xc50 fs/namei.c:5278
 __do_sys_renameat2 fs/namei.c:5312 [inline]
 __se_sys_renameat2 fs/namei.c:5309 [inline]
 __x64_sys_renameat2+0xe7/0x130 fs/namei.c:5309
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f837578eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83766e4038 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f83759d5fa0 RCX: 00007f837578eba9
RDX: ffffffffffffff9c RSI: 0000200000000180 RDI: ffffffffffffff9c
RBP: 00007f8375811e19 R08: 0000000000000002 R09: 0000000000000000
R10: 0000200000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f83759d6038 R14: 00007f83759d5fa0 R15: 00007ffd8123fe08
 </TASK>


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

