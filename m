Return-Path: <linux-kernel+bounces-835187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25061BA675F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2266178D27
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086227702E;
	Sun, 28 Sep 2025 03:58:05 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419842765ED
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031884; cv=none; b=sgzGBaEgkpcoMUdXaR/8Ms4jKqbIYtkfxJ6v0+if8EjD1VIlCso7cg5lV2oMc461Ry4R3KG6/hOw7SG4rRhOOnhOOQaOMTs/Wtyj6VlS90lSXCzjWwrIGpE1RMLo4SXK2Wls61swJ/s6IeXvrnPDmFohyY+xa080Z88MMpRhKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031884; c=relaxed/simple;
	bh=f3JHu4nfUvLE6vV8Ffcyvr7ljbsaJmoR+A1W6GrCImI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H78j8cztyJ+0j2jsUIvKer8qNF+hXsaEyeDUxYniEBSMljXmV6tLHONvQNhDwjTS6pSx6YWkQxn/+/EaQpp6YxiDxesno69XeNvF5HjhbviU3hW62L5Eil6GeWKWrT0DE6kuEQ+NQ1UjiHzFLS9CLdiPoKvZqTTSrS24LNgdzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42594e15f1bso50233585ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759031882; x=1759636682;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/KoNG0Q81c1fUt+OzeQR+FVRJ7Sq65drhXqtHFOtCg=;
        b=I5VRLD5O37QalscOV3z1W0qPdHbVXcSgy7eMJNKokZnrAKg8KzU91BUyrJi3nCe++Y
         GWAnVaTrFHOpmYWL0iKxdguUdFErrIhS2uLKDVyIvKfbmwZAwkkmgB7Xzq3YhQ1Ipozl
         EMXw+OD8mOv2edZlA20ABIOmT42O5j8sfcuRSznhyuNVUVYkeziMJMs2aA57PNeYRh9g
         nxymwfruPqExvswy2Ou8cwlRbj3CuvMAdL+vhI3OW+AL7l8uTsn28fqcMXjUXcGhsFJH
         jYMURpSDe+fGkO3ljHar2bp8cqM/L/q9upIrq/i9DjVujzC1SR4b4vrO3CdyG7ilOopj
         0Adg==
X-Gm-Message-State: AOJu0YxPztPJwnbgexM4TECyo4LW9V8YtdFtmDkZvyCT5euDxVRw/d3r
	FYFZK5HV6+AZX83QDOQTrxgVd0v8ofYjYOEMW995MLewPOt2SZldAXhANZ88M/pdo8h5nLYJ5jR
	Z1pIKCoGfL/xGmnB1HImICxz8a0rFuxbY4/Y4L0JyVIjBFSa4WYb54VAQ6X7gkg==
X-Google-Smtp-Source: AGHT+IGqOr5ScpK/A7vdXw/V2tXTATart1c+7vf3rH1PHFdfu1/jvD8DusH1Er+Ec9DUWihSMG/3/vpYLqOsJpQWwG2c9jRlf/bE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:427:85d4:84b5 with SMTP id
 e9e14a558f8ab-42785d496e8mr101972465ab.26.1759031882384; Sat, 27 Sep 2025
 20:58:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:58:02 -0700
In-Reply-To: <67afa060.050a0220.21dd3.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8b24a.050a0220.25d7ab.0469.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indire=
ct
Author: xandfury@gmail.com

syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    128c8f96eb86 Merge tag =E2=80=99drm-fixes-2025-02-14=E2=
=80=99 of <https://g>..
> git tree:       upstream
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D15908bf85800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D40c8b8384bc4=
7ab0>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D270f1c719ee7ba=
ab9941>
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D149a87df98=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D167a8f185800=
00>
>
> Downloadable assets:
> disk image: <https://storage.googleapis.com/syzbot-assets/da4c858d8649/di=
sk-128c8f96.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/4bd8410dd596/vmlin=
ux-128c8f96.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/038939e96f8b/=
bzImage-128c8f96.xz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in drivers/scsi/sg.c:1897:13
> shift exponent 64 is too large for 32-bit type =E2=80=99int=E2=80=99
> CPU: 1 UID: 0 PID: 5832 Comm: syz-executor361 Not tainted 6.14.0-rc2-syzk=
aller-00185-g128c8f96eb86 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 12/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x24f/0x3f0 lib/ubsan.c:468
>  sg_build_indirect.cold+0x1b/0x20 drivers/scsi/sg.c:1897
>  sg_build_reserve+0xc4/0x180 drivers/scsi/sg.c:2007
>  sg_add_sfp drivers/scsi/sg.c:2189 [inline]
>  sg_open+0xc37/0x1910 drivers/scsi/sg.c:348
>  chrdev_open+0x237/0x6a0 fs/char_dev.c:414
>  do_dentry_open+0x735/0x1c40 fs/open.c:956
>  vfs_open+0x82/0x3f0 fs/open.c:1086
>  do_open fs/namei.c:3830 [inline]
>  path_openat+0x1e88/0x2d80 fs/namei.c:3989
>  do_filp_open+0x20c/0x470 fs/namei.c:4016
>  do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
>  do_sys_open fs/open.c:1443 [inline]
>  __do_sys_openat fs/open.c:1459 [inline]
>  __se_sys_openat fs/open.c:1454 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1454
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1dc41ca3e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeaa93f3d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007ffeaa93f5a8 RCX: 00007f1dc41ca3e9
> RDX: 000000000008a002 RSI: 00004000000000c0 RDI: ffffffffffffff9c
> RBP: 00007f1dc423d610 R08: 00007ffeaa93f5a8 R09: 00007ffeaa93f5a8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffeaa93f598 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> =E2=80=94[ end trace ]=E2=80=94
>
>
> =E2=80=94
> This report is generated by a bot. It may contain errors.
> See <https://goo.gl/tpsmEJ> for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> <https://goo.gl/tpsmEJ#status> for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report=E2=80=99s subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

