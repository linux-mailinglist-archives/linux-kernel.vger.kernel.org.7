Return-Path: <linux-kernel+bounces-835566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F463BA7786
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28C11896036
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12A27E1C8;
	Sun, 28 Sep 2025 20:17:35 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9C1F584C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759090655; cv=none; b=KX3UzS2l2umYxB+8svnPEtW/wII7PfaY7ywnzjT5PR2+7xsBuD4KD8nXCxe0CRg9IAnDo5RMwx7lTsBB+HIrF7n5o6zcWk46/tKX5QDvS35kXeVO2iBAFPSbDlAqs0QhQhzR/xQxcR3+w7KCd1spq00IMJYKkKxaPUeAqbn1uhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759090655; c=relaxed/simple;
	bh=naNy8mVmplw2NgtztPrGWVcmCUvDPdsB4pdyATZPQdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qKqCJiqFqVSAPz0lZa7e4HEfEn+4JiTfjiXow3SXWMEoC8ccWq9kjJ6SsFG58nw6zPXrRzHVtw4Fb5Dm5DpEEsLUW+xBsXnMG8+Fg5FH0Bi5fGjrkljeztZP+evKnHDReH3dSF/Lhou6M6BYJrabA/5O+/3fLQ7+16KZRwk4rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso33243795ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759090651; x=1759695451;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBvyVu8CyTxUmK2GZUmhVMN9pG3tHfIu7Ps1bkilZYI=;
        b=UeNiANvjzgAwUppR0NRRo551lgJjC8k15J9XO1m92CSAo2vj1V2hWw6LvWBuhlGohZ
         O7HZY6s/itS60kc6Ouqni88irBatUY6zDxPZu5I7VKqr5m66cuxXV4Lvaphr5D6noY8x
         f2bjvjS4onazm0DzC+r+rBy+DBcOZ10/DIt5G+jTedO0ahXYqEfzuWUHKG8I8jIdJ/Gg
         AcvVEzgrDXSxVxyBaKM1/qrqr10gnLKwQVKxhKs6ozSX6moApnw4eQORvsLFbV96RAH8
         k0c6MbAfvnq0VPd72Dxd8XRWuwR7S7wc3YLK4edXSj9OgTNbbLJHArUwi+2r6P7UT4nE
         DBTA==
X-Gm-Message-State: AOJu0YxI/K6MCzNieR6IDMXNDIfnOK93RCzUr6ejmJ03xDyzje5ezD28
	+O8hHeYRTWOSSaKuRH7yUU4GfUi5gLZuJbe/9zRYpl8vsu6bYdJ+zurJvL+yzHrosRV0mfN64yY
	7ViXFzu6mODnrFBp2NNVBhuUX27hzRzizKM7z0rDA5iW78BEBVJPXJOoL4OcxbA==
X-Google-Smtp-Source: AGHT+IF1CeY67EazwHnoaUF5LnER/8W1dxpdUJiPZLKt5Xxex54QUepgY379XYhHC2BCTGTmYeUycnA/kuywbLIftvzka4MkOR/T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164a:b0:429:6c5a:61f3 with SMTP id
 e9e14a558f8ab-4296c5a6457mr62328465ab.8.1759090651510; Sun, 28 Sep 2025
 13:17:31 -0700 (PDT)
Date: Sun, 28 Sep 2025 13:17:31 -0700
In-Reply-To: <000000000000c29dab06004a752b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d997db.050a0220.1696c6.0009.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From: syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
Author: xandfury@gmail.com

syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3f01e9fed845 Merge tag =E2=80=99linux-watchdog-6.5-rc2=E2=
=80=99 of git://w..
> git tree:       upstream
> console+strace: <https://syzkaller.appspot.com/x/log.txt?x=3D1310fc5ca800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3De6c2f785de9e=
303f>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3Dfc26c366038b54=
261e53>
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D107f12e8a8=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D174014a2a800=
00>
>
> Downloadable assets:
> disk image: <https://storage.googleapis.com/syzbot-assets/896ca272ae74/di=
sk-3f01e9fe.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/deff7fbe3b2c/vmlin=
ux-3f01e9fe.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/ca3863031cc5/=
bzImage-3f01e9fe.xz>
> mounted in repro: <https://storage.googleapis.com/syzbot-assets/9c7c53054=
80d/mount_0.gz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com
>
> memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D5019 =E2=80=99=
syz-executor590=E2=80=99
> loop0: detected capacity change from 0 to 128
> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D'
> UBSAN: shift-out-of-bounds in fs/befs/super.c:96:9
> shift exponent 3229888891 is too large for 32-bit type =E2=80=99int=E2=80=
=99
> CPU: 0 PID: 5019 Comm: syz-executor590 Not tainted 6.5.0-rc1-syzkaller-00=
006-g3f01e9fed845 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/03/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x221/0x5a0 lib/ubsan.c:387
>  befs_check_sb.cold+0x19/0x6f fs/befs/super.c:96
>  befs_fill_super+0x9b5/0x1110 fs/befs/linuxvfs.c:873
>  mount_bdev+0x315/0x3e0 fs/super.c:1391
>  legacy_get_tree+0x109/0x220 fs/fs_context.c:611
>  vfs_get_tree+0x8d/0x350 fs/super.c:1519
>  do_new_mount fs/namespace.c:3335 [inline]
>  path_mount+0x136e/0x1e70 fs/namespace.c:3662
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount fs/namespace.c:3861 [inline]
>  __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fe1b84908ba
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f
> 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd994dbc28 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffd994dbc30 RCX: 00007fe1b84908ba
> RDX: 0000000020000100 RSI: 0000000020009e40 RDI: 00007ffd994dbc30
> RBP: 0000000000000004 R08: 00007ffd994dbc70 R09: 0000000000009e1f
> R10: 0000000003008001 R11: 0000000000000282 R12: 00007ffd994dbc70
> R13: 0000000000000003 R14: 0000000000010000 R15: 0000000000000001
>  </TASK>
> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D'
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
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to change bug=E2=80=99s subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

