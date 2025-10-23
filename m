Return-Path: <linux-kernel+bounces-867219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8377C01E45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 743873591FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993463314C4;
	Thu, 23 Oct 2025 14:49:02 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF433033F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230942; cv=none; b=kq2cNUeXE+qo6CXkVi1ckLbLgezDO1tAS0uK7cS9UXW6/uUhdVNmnfD4XWmeX/OzVHAewa08JhIQi2+lV2VzIWlQay57yT63XmvtcB/mtWVcCu803OHPD3z6zC+mMKMj7nq9fccm6Bwiylo8r9k9nVb2VRlA94QR2jekXlYijts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230942; c=relaxed/simple;
	bh=3oxn4ycbxEA020j/HQZXhaxObqXyhghj+ocKU2znsxY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TyzFe5PlqEuT+pFYgE32Zb/NaMLs4D873zcNRtdMO3v1m8VJ9pkvciWluO1Rf+460VFPTa3rmdD0PRX/p3MoABro4R79Uj4zeG4UHX8BGf5TpyacFrlCKXIauestYHaTc5apUR/uxu5QlX5QgAhow4wxfqTfQ9p5ogizmhlTFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430d082fc3dso30450905ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230939; x=1761835739;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWy/bLDmqOcCE1HGZWszvszm2EzBf9WFx/xwTwbSyqA=;
        b=kGyGp3coE1GYM59sVQSSwUUWDCwGRI1QEUEsogygG1qrYyC+ocjXkiEyjpNZVLcW/s
         ir0iyz7APj579rB1RLHeA2VwzbISfRl9VPjPD5A8GrWUWst2VILODQTZtj0wF03/31bZ
         ciyfD6hdGJTeGGXOKfKAs8hP8c+QOQYB428giKG3Gb8aAuLHPK1yXWSdoSeJbrUu+EjD
         0UX3PdVbIxHyRN6H/B0+9No0tn1safFjiq6PaCtt9Lzmx+3jecXD8E7F+yM9uzc3G1lC
         pY6FQERikvGLkAydL6zF+3jhmOaxeXZ2ec5vGfff/03VMPs7nucx3uaKpQ0OH1sVt7BK
         /zoA==
X-Gm-Message-State: AOJu0YygHK/oeE33/uTpnDo19AApBLCDIW3vWsIBUYJQZuxHDnz4JZrW
	EVJjiaiHgXjAJoWYYo8gcnUE3ohYmwab5GGoF2zaeoxz5VeViS6DltcPqsRq22co0TDxCJul3Mf
	e0xn+MCbMAKnpPGz/+bQtIA71exfF5kvpyJbv5ZLkHcT0qHI/NBPbC9PrRsbPaw==
X-Google-Smtp-Source: AGHT+IH+kMf6z8XXdjtKw1GPakOL2cmwVdVEjCQ4zbo3PZRtctvpjOz7qSHC6iEK50Gd8vYZc2g1MfSpQtjNnjYE5FvMBGwMfpuM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148a:b0:430:a013:b523 with SMTP id
 e9e14a558f8ab-430c52aa249mr372203305ab.25.1761230939221; Thu, 23 Oct 2025
 07:48:59 -0700 (PDT)
Date: Thu, 23 Oct 2025 07:48:59 -0700
In-Reply-To: <68f9bea1.a70a0220.3bf6c6.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa405b.a00a0220.9662e.0006.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [hfs?] kernel BUG in hfs_new_inode
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_new_inode
Author: ekffu200098@gmail.com

#syz test

On Thu, Oct 23, 2025 at 2:35=E2=80=AFPM syzbot
<syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    552c50713f27 Merge tag 'vfio-v6.18-rc3' of https://github=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1231d73458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D216353986aa62=
c5d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D17cc9bb6d8d69b4=
139f0
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10e953e2580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D176d7c5858000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/822137407e34/dis=
k-552c5071.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c352dbdc77fe/vmlinu=
x-552c5071.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/96bd9d9f8c50/b=
zImage-552c5071.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d008a2751b=
bd/mount_0.gz
>
> The issue was bisected to:
>
> commit a06ec283e125e334155fe13005c76c9f484ce759
> Author: Viacheslav Dubeyko <slava@dubeyko.com>
> Date:   Tue Jun 10 23:16:09 2025 +0000
>
>     hfs: add logic of correcting a next unused CNID
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11b4e3e258=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13b4e3e258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15b4e3e258000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
> Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
>
> loop0: detected capacity change from 0 to 64
> hfs: unable to loca[  123.243188][ T5988] hfs: unable to locate alternate=
 MDB
> hfs: continuing without an alternate MDB
> ------------[ cut here ]------------
> kernel BUG at fs/hfs/inode.c:222!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5988 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{=
RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:hfs_new_inode+0xbc4/0xbd0 fs/hfs/inode.c:222
> Code: 89 f1 80 e1 07 fe c1 38 c1 0f 8c 15 fa ff ff 4c 89 f7 e8 0f 6f 8b f=
f e9 08 fa ff ff e8 b5 b7 29 ff 90 0f 0b e8 ad b7 29 ff 90 <0f> 0b e8 a5 b7=
 29 ff 90 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900040af848 EFLAGS: 00010293
> RAX: ffffffff829555d3 RBX: ffff8880335088c8 RCX: ffff888026d23c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed1005214608 R12: ffff8880290a3000
> R13: 1ffff110073d90f3 R14: 0000000100000000 R15: ffff8880335088c8
> FS:  00007f6c84dde6c0(0000) GS:ffff888126cc2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e263fff CR3: 000000003276a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  hfs_create+0x2a/0xe0 fs/hfs/dir.c:198
>  lookup_open fs/namei.c:3796 [inline]
>  open_last_lookups fs/namei.c:3895 [inline]
>  path_openat+0x1500/0x3840 fs/namei.c:4131
>  do_filp_open+0x1fa/0x410 fs/namei.c:4161
>  do_sys_openat2+0x121/0x1c0 fs/open.c:1437
>  do_sys_open fs/open.c:1452 [inline]
>  __do_sys_openat fs/open.c:1468 [inline]
>  __se_sys_openat fs/open.c:1463 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1463
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6c8576efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6c84dde038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f6c859c5fa0 RCX: 00007f6c8576efc9
> RDX: 0000000000000042 RSI: 00002000000002c0 RDI: ffffffffffffff9c
> RBP: 00007f6c857f1f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000058 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f6c859c6038 R14: 00007f6c859c5fa0 R15: 00007fffc4216518
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:hfs_new_inode+0xbc4/0xbd0 fs/hfs/inode.c:222
> Code: 89 f1 80 e1 07 fe c1 38 c1 0f 8c 15 fa ff ff 4c 89 f7 e8 0f 6f 8b f=
f e9 08 fa ff ff e8 b5 b7 29 ff 90 0f 0b e8 ad b7 29 ff 90 <0f> 0b e8 a5 b7=
 29 ff 90 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900040af848 EFLAGS: 00010293
> RAX: ffffffff829555d3 RBX: ffff8880335088c8 RCX: ffff888026d23c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed1005214608 R12: ffff8880290a3000
> R13: 1ffff110073d90f3 R14: 0000000100000000 R15: ffff8880335088c8
> FS:  00007f6c84dde6c0(0000) GS:ffff888126cc2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e263fff CR3: 000000003276a000 CR4: 00000000003526f0
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/68f9bea1.a70a0220.3bf6c6.0032.GAE%40google.com.

