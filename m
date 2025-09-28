Return-Path: <linux-kernel+bounces-835120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38CBA6536
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF133B0E32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86481C1F05;
	Sun, 28 Sep 2025 01:00:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE812F2E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021235; cv=none; b=ar6QqHpI+abibWaSfwDlwfapaJJGt2E7j8QqKvqvRn+vCbdDnw0rmyl+i1UEForEFSFHKpklgdiCJD1dsT+Qrptw7fBu8JMP0UzKLnE/9ZiX5kZq9l72gF44+T8FXmVP+RRKuBIwYxc0ADRtfgf6UQnWyJe9kdMrTQyRiCoGhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021235; c=relaxed/simple;
	bh=TzYRh5sblrI6BzE9NE/V2EqU6ZR3wlxA82JQ7Os7urY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QSzfWVnjUxwZN/QCmLYBXHBTZjk2LkxqJULNf/m1yc/yIvyZcf5fqQQ1xpLxXvO/sxGxpl5OEwbO3dnStHVV5sB9heyNAFL88kdmPxBjHZyNC0fsg72KGv6ontLAgqgMmJy58oGYngTgRgIYU7M4z0fgXqSDGDwFbUNH+pP/vG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso44547475ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759021233; x=1759626033;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEnCSgE0NRskL2q2KJaQ5F6zwb8agSrf+momI7/IM/c=;
        b=WtFzAOuNa0z4+D+560XBy/+lXt6ZcbzdlRpYm/frjB9QufN/DapivaN6B0dJi3f1BL
         X1xwvLmR5SqBiFd2dPGpvalqBB+PjyuKUvE90z4aCdD5tuQ0lffHxAd7HusiDKi5E0Sx
         gba1Cb/3F8bKsMtKiKi+W7jw34x2LLrgNLw4PePgrFNkZ4L8P8tLSTjgT8tM8zcEYMa6
         uZMfNJuQ9LV860cg2JMfx7iKQTZf2w1HvSLZMDUa5g3lX6Wz3Yp+1Jg1xAWGE6xfl9AA
         Xi8C9etsNhG4g091y3c0ZNIj8CJHvIF9SduOg21yaKGCZTtKWejyw2Vca5r7/TphjFRy
         spBQ==
X-Gm-Message-State: AOJu0YxcRDZHEE9ZaCzzRMQUsv5xTpR0xPft5WQnye8pu0neyrdAnh0/
	2uNod1DfvR59hPZYdKwufaboFJpkAy0nosZmVjyX0lEni6nWemA/98Un/uQwcq4b/vhlMROeJ1Q
	+pmOnauMQFevKbSk3DosuiAyVCHTz/SUoIxwnGo9dyw2Xdx1iXqrILCw4ILtogw==
X-Google-Smtp-Source: AGHT+IGKFeNNkq8x2IbzFynNHowAy0gCa/lhpbMmKZoa6BxYnabEZIv5/zZoSrWk4cFDiEEYC2e8NerCYLhUtzGgCkY/cbDjSIQj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe6:b0:426:a2d3:28d3 with SMTP id
 e9e14a558f8ab-426a2d32b42mr117665985ab.13.1759021232991; Sat, 27 Sep 2025
 18:00:32 -0700 (PDT)
Date: Sat, 27 Sep 2025 18:00:32 -0700
In-Reply-To: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d888b0.050a0220.25d7ab.0431.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in
 dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
Author: xandfury@gmail.com

syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 arch=
i..
> git tree:       upstream
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D134fc6405800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3Dfc6f8ce8c536=
9043>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D9e90a1c5eedb9d=
c4c6cc>
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D118f028798=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D128f8a5f9800=
00>
>
> Downloadable assets:
> disk image (non-bootable): <https://storage.googleapis.com/syzbot-assets/=
7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlin=
ux-c2ee9f59.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/a00efacc2604/=
bzImage-c2ee9f59.xz>
> mounted in repro: <https://storage.googleapis.com/syzbot-assets/0a96c5cc2=
569/mount_0.gz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
>
> ERROR: (device loop0): remounting filesystem as read-only
> ERROR: (device loop0): dbDiscardAG: -EIO
> ERROR: (device loop0): dbAllocBits: leaf page corrupt
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:3028:55
> shift exponent 32 is too large for 32-bit type =E2=80=99u32=E2=80=99 (aka=
 =E2=80=99unsigned int=E2=80=99)
> CPU: 0 UID: 0 PID: 5092 Comm: syz-executor128 Not tainted 6.12.0-rc4-syzk=
aller-00047-gc2ee9f594da8 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>  dbFindBits+0x11a/0x1d0 fs/jfs/jfs_dmap.c:3028
>  dbAllocDmapLev+0x1e9/0x4a0 fs/jfs/jfs_dmap.c:1985
>  dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1825
>  dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
>  dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
>  jfs_ioc_trim+0x45a/0x6b0 fs/jfs/jfs_discard.c:105
>  jfs_ioctl+0x2cd/0x3e0 fs/jfs/ioctl.c:131
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f54e7034c99
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd37b5c358 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f54e7034c99
> RDX: 00000000200000c0 RSI: 00000000c0185879 RDI: 0000000000000004
> RBP: 00007f54e70ad5f0 R08: 000055557b4874c0 R09: 000055557b4874c0
> R10: 000055557b4874c0 R11: 0000000000000246 R12: 00007ffd37b5c380
> R13: 00007ffd37b5c5a8 R14: 431bde82d7b634db R15: 00007f54e707d03b
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

