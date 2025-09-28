Return-Path: <linux-kernel+bounces-835563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03EBA775D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9318944E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29D334BA3B;
	Sun, 28 Sep 2025 19:59:14 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7A27145C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759089554; cv=none; b=GeqAFY/S6NdOHQ86T0cJPp7DJrUugXXLA/R0S1T7xAxVJl4ccG3+wgVLdqdY3Kzlt9QdbMpNbQvb/6AEUMNZZIYjvUnTWQ8zRAfSweEeLacrCWvtGWmtwR74oYN56j4uhGzrNWSU0LU3YZmBp4V11vIBavoaOiGM5zl7TW9/i8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759089554; c=relaxed/simple;
	bh=XoIYaBJLkyk4JNVW9Kxbn3N/eprtAWi2l/oAPpzkCP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SaH2smh8juQ5ppHHwmeaUJ/g1tMKMNmeZSbYv0z7JPjQ/hcuf4QWhqb11pEmXK+QkFVQu1tkO3KGOaibYX76E553jRThrtbOBDz7YEnLJKjwX+4h9EOm5UNQhj59fJoyzyWCwixM7zegYNSxSqRjn9H+n9AhpguaI2u9tOz1DUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42570afa5d2so114414245ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759089551; x=1759694351;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJhv0g1E9+2Qtqehu0FCOc8axGEsXT/9pJzaYZvrURs=;
        b=n+dQQqd8QInHXV9jfDZ+IRMvGJd0VabX+HRP3saq/X6YuTnoKbImeDVC2PqvsHl8f9
         vv+uEBt/Qmev1HLvik/jUkqHe2Mrq/1pdjc4mzB1TV2/TY/MpErkvorBIbDy4W7+uhI3
         tm8eei1vceD2ueWvK+BtOmrsC+F1+gNwc65SUq63vOFAGIqRYYKoi+e1ziewUSHt1Pag
         cPc47Q5qAUaVWzHpN1ctG928MgK36d/sPfPv8B1fWC0Z3jPhnYG4gWzHzMTDZDQgbCcm
         U8Fzfk/cgM3gHg9bLQJxc+WsFOk8mjFSkhh5bxBN8L3LcBoAcsuMhLUJ4qM9fB1u9DOI
         lVRg==
X-Gm-Message-State: AOJu0YwHx9dXpI89A9agRTXJU15xkq4c/vD3/oq43gmjF7ntWn04OfwD
	GiXzRXHA8uKxY+6d6JorujbvI4NSZnTU/MWLIdoXYzDn4ENuquGD6/LqaKQAaYFdatNwQJI3eeO
	073iVMR9EzbKkTc2OsdGdceFkaXCzKjSG2LjaZRZXhLMQQftTv5DLga6BIO6U8w==
X-Google-Smtp-Source: AGHT+IGoSqfksVEs2qQsBXFHs9ZfqZB/iZQfZiXjh75Ltkd3Po+jEbOeB2CB61XigSOTmm4dYHa8TN0wtPfL6KZGS6LcDvxZy/wP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:424:805a:be8c with SMTP id
 e9e14a558f8ab-425955ed522mr203786595ab.8.1759089550850; Sun, 28 Sep 2025
 12:59:10 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:59:10 -0700
In-Reply-To: <68129156.050a0220.3a872c.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d9938e.a70a0220.10c4b.0026.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit (3)
From: syzbot <syzbot+4c1966e88c28fa96e053@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit (3)
Author: xandfury@gmail.com

syzbot <syzbot+4c1966e88c28fa96e053@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f1a3944c860b Merge tag =E2=80=99bpf-fixes=E2=80=99 of git=
://git.kernel.org..
> git tree:       upstream
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D10d550d45800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D90837c100b88=
a636>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D4c1966e88c28fa=
96e053>
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd=
6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D1250a27058=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D14d550d45800=
00>
>
> Downloadable assets:
> disk image (non-bootable): <https://storage.googleapis.com/syzbot-assets/=
7feb34a89c2a/non_bootable_disk-f1a3944c.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/fbe8c2bb0602/vmlin=
ux-f1a3944c.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/b4268e0ec733/=
bzImage-f1a3944c.xz>
> mounted in repro: <https://storage.googleapis.com/syzbot-assets/10b2c3823=
00e/mount_0.gz>
>   fsck result: failed (log: <https://syzkaller.appspot.com/x/fsck.log?x=
=3D14f49d74580000>)
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+4c1966e88c28fa96e053@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 32768
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2629:11
> shift exponent 110 is too large for 32-bit type =E2=80=99int=E2=80=99
> CPU: 0 UID: 0 PID: 5303 Comm: syz-executor956 Not tainted 6.15.0-rc3-syzk=
aller-00283-gf1a3944c860b #0 PREEMPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:231
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:492
>  dbSplit+0x1f8/0x200 fs/jfs/jfs_dmap.c:2629
>  dbAdjCtl+0x34c/0xa20 fs/jfs/jfs_dmap.c:2521
>  dbAllocDmap fs/jfs/jfs_dmap.c:2032 [inline]
>  dbAllocNear+0x2ee/0x3d0 fs/jfs/jfs_dmap.c:1243
>  dbAlloc+0x933/0xba0 fs/jfs/jfs_dmap.c:828
>  ea_write+0x374/0xdd0 fs/jfs/xattr.c:232
>  ea_put fs/jfs/xattr.c:619 [inline]
>  __jfs_setxattr+0xa01/0x1120 fs/jfs/xattr.c:792
>  __jfs_xattr_set+0xda/0x170 fs/jfs/xattr.c:941
>  __vfs_setxattr+0x439/0x480 fs/xattr.c:200
>  __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
>  vfs_setxattr+0x16b/0x2f0 fs/xattr.c:321
>  do_setxattr fs/xattr.c:636 [inline]
>  filename_setxattr+0x274/0x600 fs/xattr.c:665
>  path_setxattrat+0x364/0x3a0 fs/xattr.c:713
>  __do_sys_lsetxattr fs/xattr.c:754 [inline]
>  __se_sys_lsetxattr fs/xattr.c:750 [inline]
>  __x64_sys_lsetxattr+0xbf/0xe0 fs/xattr.c:750
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdaa19996b9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe3d43d28 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
> RAX: ffffffffffffffda RBX: 0000200000000200 RCX: 00007fdaa19996b9
> RDX: 0000000000000000 RSI: 0000200000000200 RDI: 0000200000000040
> RBP: 00002000000000c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000040
> R13: 0031656c69662f2e R14: 0000000000000001 R15: 0000000000000001
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

