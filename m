Return-Path: <linux-kernel+bounces-835191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1EFBA677B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CC817E901
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57475280A5A;
	Sun, 28 Sep 2025 04:00:26 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3D27FD46
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759032025; cv=none; b=oA7TtbEBFriOyCddDD/hsTzrV12T929n/ahEwYYl9DFF8QMcWtx6OSDPknSqn8W28rklMG05iQ4u18EmoUKDZ5IgCgDON6F4RBaeNIdFmD2vEJ7wMW4sxjXRpwvG/nz6jrFvEIINQbNSaroB+KDx+AgqehS94evHIBSx9K8B20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759032025; c=relaxed/simple;
	bh=N6RrpTNVVm0W2Z9XIhvBkTRWBF3/RkmVg7Fo7JK6ATA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L0go/jQvoxGRvtpWve+02HifmgzRq4XOdeBHGz/7ghfI6ZF5rmkS4LSyqMTAZBdLu6tpWTevT5H1T5MDLLTinGtX2EwPR3s2TbFOT/OSJrcFSnpbXBzkB1UHWEg8KIk4GHb1qG1VBHNjxTDM65iXxh8edSgEZUFhe9hizA4qn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42af09092b9so6256035ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759032023; x=1759636823;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1MwWPMU1guCbRwAc9ialRltr/m9ie/XtonTgIUgF18=;
        b=OjKG1NHSKEar/Sk1q+3cXmdlLsZ8yGa0qyZl/0cGvKyGfY8/1gthUIXEp3gzvTsKWG
         7gZH9kUjse81QnkATKLRfGDPBNZfeQEzVTioMh6DlFzl9YUit7wBVUI/yTR/Yf4RvDFK
         GWS62tOJD4Wkd/kwK7Rcfl+tVaN4Fh3bWIozkx7nLUgBse6uFCr042sOOo9Xe9AdOdaQ
         qPAz6N7rQ7lHdQjE9RL3YmXf6BioO0pHTm/t8Ts97OVjkxYoZv82hzXcaav82EvMED9/
         nDC5QrD3M2dr1RXcfFMOUFLBARIF4zNu2BAovduT/9rfDlsqGbSRCS9SoD9wboQW3egR
         /xWA==
X-Gm-Message-State: AOJu0Yz121SGKDou2YgAdtgJP1AGEz8RjBqlkpah8ggLNzO0+cRwylGP
	yzj9ukkS6NzKPiL26snX7rfqP4aa94Wpfva3pSzkfwQ7fg62QL+tSPIu9nXmq6kzb+cz9r4pYdN
	8r/RXGQHNuP04IANJJeB6uPKVn2BKLihNDjrCzsdk+7flo8tXqj8LXCIP+Pp2/w==
X-Google-Smtp-Source: AGHT+IHQUbxj6SFaQK0dV/cOg3LHDQgPukVeDeTYOJ2D5ans7FZq13YlVr1eXY2HnW50u+SqwaEZXrE34mbDpw+2JkFk/ju03Thu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c03:b0:41f:bff3:d65e with SMTP id
 e9e14a558f8ab-425955ca629mr186305525ab.7.1759032023444; Sat, 27 Sep 2025
 21:00:23 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:00:23 -0700
In-Reply-To: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8b2d7.050a0220.25d7ab.046b.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
Author: xandfury@gmail.com

syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3ac864c2d9bb Add linux-next specific files for 20250818
> git tree:       linux-next
> console+strace: <https://syzkaller.appspot.com/x/log.txt?x=3D137064425800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D6d1acc6b9e1f=
ca1b>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D30c83da54e948f=
6e9436>
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D141586f058=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D124c9ba25800=
00>
>
> Downloadable assets:
> disk image: <https://storage.googleapis.com/syzbot-assets/37dbe82593f0/di=
sk-3ac864c2.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/d2fea0824445/vmlin=
ux-3ac864c2.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/6f2a83735a01/=
bzImage-3ac864c2.xz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
> shift exponent 32 is too large for 32-bit type =E2=80=99int=E2=80=99
> CPU: 0 UID: 0 PID: 5861 Comm: syz-executor379 Not tainted 6.17.0-rc2-next=
-20250818-syzkaller #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>  v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
>  v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
>  do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
>  do_mount fs/namespace.c:4138 [inline]
>  __do_sys_mount fs/namespace.c:4349 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4326
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff35edd46a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeee8a4078 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00002000000025c0 RCX: 00007ff35edd46a9
> RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
> RBP: 0000200000000280 R08: 0000200000000280 R09: 00007ffeee8a4258
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35ee1d017
> R13: 00007ffeee8a4248 R14: 0000000000000001 R15: 0000000000000001
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

