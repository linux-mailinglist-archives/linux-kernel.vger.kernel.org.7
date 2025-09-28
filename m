Return-Path: <linux-kernel+bounces-835158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99501BA668D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016B8189B81A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38D24468C;
	Sun, 28 Sep 2025 02:54:52 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A070809
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028091; cv=none; b=pNpEss7Fx64e9BGuO6fo0curQMvg/PEgme+2AUXEXkJyX15c0iFS10EH9jADjAIHAZm2IKI1lAKeQJ3jPakpaJHBxbQS4Ct3L8jTWiW3v9RmH6cyCnC5RiH5P6XUkPAew5EOLkQj2FgmYNoUf67a+DgPPF7+j23G7TkI3AWDExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028091; c=relaxed/simple;
	bh=4vfFIxAjhZk87y1746FuODGuKJFpG2Xhl8IktKe6+jE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=btIE3M22tsgOi8LDr94hhGI4Y93n8WysW0rNigupUF5+VanqhPjfWquG2eoXhoLU47/qxB2hydlYO/t/tBrI/lGWalZJUFAXY96f0t/m3G+KV5sdmpMLtfQUEHTfWwfYGsjtCfu+RzJX0V4RA/nZPYfJNC+pStWd/eUnAfiZjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-4257626a814so49380925ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028089; x=1759632889;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuZ88odN4FEu7v7Xh8TONLpylsbds/NQqp7peyH8Bjg=;
        b=je2lo4p7ecLr3Xu3tywrvhEbyCUvR6iFTXhHfg4mVt1tCnstBYEOP177zYu97vaQnk
         C/9CJg5eU+9XBVSN9xqJ/hvv78cu3D8Ai/v3/892p2dNX//hftFMSazHnDyYBMYUii/z
         fGD522Fb8w+3icG5fy02Eppa5gzELg0/rjOBCdnZPGxEiwjagcdH4CUU1m5oTwKrx6rc
         pIf6tX7fxVwbaNJ5BjeDqinm2oiwB3TMqoduWx7o4fGLnNdhLQF5c7dyWVAvfOYdSl7M
         Rogn++W21ukNOGvrCWotAgWi/e2GiltkPhdOQJbm6at+/1AtmOQSBdJvCvaJA8nloCoA
         iz4g==
X-Gm-Message-State: AOJu0YydgaDmZl0aBrEoQcALrTzAZs09Mn0NAc32G8d8AcMNQRRMIqBJ
	AUrYJpa/equYYKnhAA1087FdEfija840udPG8eYmxyFej4QLbpneuJaF0STSwLOYv5T8vSchiCS
	BLSTMW/1uvqurFU6BpgE+76bqzQvoHv1Qc7GxMY2e7NCluvIOfQKGnpWLX71+iw==
X-Google-Smtp-Source: AGHT+IH0nBFNcKnUJ5i5hCptxnX8uSw8TcN+nD1y13rj0H/QuxZTXfBVaODFRefQz+NLAW3mSkBpTtfXIWmzpjKc4IfIqfGuF9i/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0a:b0:428:9913:509c with SMTP id
 e9e14a558f8ab-42899135187mr60277755ab.18.1759028089373; Sat, 27 Sep 2025
 19:54:49 -0700 (PDT)
Date: Sat, 27 Sep 2025 19:54:49 -0700
In-Reply-To: <0000000000002e9eb506178cdd71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8a379.a00a0220.102ee.0023.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
From: syzbot <syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
Author: xandfury@gmail.com

syzbot <syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
> git tree:       linux-next
> console+strace: <https://syzkaller.appspot.com/x/log.txt?x=3D146317549800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D8ab537f51a6a=
0d98>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D13e8cd4926977f=
8337b6>
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D15123b1f18=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D16b7da2f1800=
00>
>
> Downloadable assets:
> disk image: <https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/di=
sk-9221b281.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlin=
ux-9221b281.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/df12e5073c97/=
bzImage-9221b281.xz>
> mounted in repro: <https://storage.googleapis.com/syzbot-assets/41dea5c97=
7c2/mount_0.gz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 32768
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:319:16
> shift exponent 108 is too large for 64-bit type =E2=80=99s64=E2=80=99 (ak=
a =E2=80=99long long=E2=80=99)
> CPU: 0 PID: 5090 Comm: syz-executor421 Not tainted 6.9.0-rc6-next-2024050=
3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>  extBalloc fs/jfs/jfs_extent.c:319 [inline]
>  extAlloc+0xe5c/0x1010 fs/jfs/jfs_extent.c:122
>  jfs_get_block+0x41b/0xe60 fs/jfs/inode.c:248
>  __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2128
>  __block_write_begin fs/buffer.c:2177 [inline]
>  block_write_begin+0x9b/0x1e0 fs/buffer.c:2236
>  jfs_write_begin+0x31/0x70 fs/jfs/inode.c:299
>  generic_perform_write+0x322/0x640 mm/filemap.c:4016
>  generic_file_write_iter+0xaf/0x310 mm/filemap.c:4137
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4d15f6f639
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff3dae85f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fff3dae87c8 RCX: 00007f4d15f6f639
> RDX: 00000000fffffef2 RSI: 0000000020000240 RDI: 0000000000000004
> RBP: 00007f4d15fe8610 R08: 0000000000000000 R09: 00007fff3dae87c8
> R10: 0000000000006162 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff3dae87b8 R14: 0000000000000001 R15: 0000000000000001
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

