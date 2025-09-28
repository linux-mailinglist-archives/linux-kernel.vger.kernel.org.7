Return-Path: <linux-kernel+bounces-835170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA1BA66E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CF2177BA7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3EE254864;
	Sun, 28 Sep 2025 03:23:00 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5813A86C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759029780; cv=none; b=ZefW2Dq4Gp5TYJuEbVxHnGqYH5JHgSiQ+sWftdJeqqNlOfx5Y0CNXtOis2lftqhMfhsANuVNKePdtsxBUqOYmwa4lD6GC3nKW4oOSDS/Uk+veCJpkefFR3rqig3zo6RVLazhDbwHmkfSZGq3GDI+sVxQXrbjCgtx+DEhGNZgV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759029780; c=relaxed/simple;
	bh=ZPCvqdV7Kp0U4U95dY+1rRuZMONNSN0tEiD6BrodCRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NVhRxbpv1JKqeBajEIcZwGjRstHsNd+q3a+b+Tc/lTpRnMA6wwFYiu0l1bs9f+BPiyFcVU7jzo82UgUm9rkmdt7KPBzhqKAVeTLro6JvUv5gKAUs4NehXT0hP8sxXeCCcSz9JOlUTI6/RMjp0CI9WOqg3r+aXTq/XlWgFP6NSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-425788b03a0so92851905ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759029778; x=1759634578;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRHBuN2XINbVkHcW2/nwEUT805Ogg3w8BsgWxIsJhIQ=;
        b=wFE+ZJcJjlvYYFSJBC8PZjzrrtcCb7n0Kx5zbQ+pHOjU6ZtFdHC35tLLRfMIeJAcXm
         r+REOcnywi8stYQEEEUwqv9HvHmHRYTjgLeoIbWrc0I00n9JJpBtGMzAqlGBv0mdLAI2
         QGqUr8jeEJOaukMsPwfXoMpTmDv4MxsIpvdEXGEPiVqdq3NzZXFQt2GKGm4Ila5go0pX
         yUw9fY1pyFVLZee01MsQK8+TQ49gm5qCHZUGGPQd2zdzHJUZNYc+fDlwbZC6WvaW2ShP
         nPNOaok9FBhkOk6iQW44E8XRKH5nQSAqANSQcKbKVMsfwO/cnVFtccRoSaH5P9N7ezr2
         5NYg==
X-Gm-Message-State: AOJu0YynANpxSA9fiZLDuO/dKIM8mhDrgkLazS2U9c3gi8MiLCtGWWy1
	SaDYulS8KX2+yFRgxFY3tC2XuHQSC4j1yYKsoHuozOQiJzlGDiVW2kiXBNxHBS2OaE5AxdI0yq9
	V+vS5zYTjhckzurrzUyH/TKY9qD5ojfK56YL+OX178X7U+z+0tnRF0UiURjDQJA==
X-Google-Smtp-Source: AGHT+IFGDh7ToEpTget4UxI2fSuAuvPFiYpkatgLaRIPMOZavqAG6r2HH/5/KTKck8HlFsmIDxvAVCXZYoGmPSP2bjaeLlBCFXtZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:424:1c9a:cadf with SMTP id
 e9e14a558f8ab-425955ed4d8mr212017405ab.3.1759029777736; Sat, 27 Sep 2025
 20:22:57 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:22:57 -0700
In-Reply-To: <68122507.050a0220.3a872c.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8aa11.050a0220.25d7ab.045e.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in
 jfs_statfs (3)
From: syzbot <syzbot+13ba7f3e9a17f77250fe@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in jfs_statfs (3)
Author: xandfury@gmail.com

syzbot <syzbot+13ba7f3e9a17f77250fe@syzkaller.appspotmail.com> writes:

> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    475c850a7fdd Add linux-next specific files for 20250606
> git tree:       linux-next
> console+strace: <https://syzkaller.appspot.com/x/log.txt?x=3D11fe2a825800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D28859360c84a=
c63d>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D13ba7f3e9a17f7=
7250fe>
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e0775=
7-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D11c79a0c58=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D162aa9d45800=
00>
>
> Downloadable assets:
> disk image: <https://storage.googleapis.com/syzbot-assets/2f1cf8485b7a/di=
sk-475c850a.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/976adb9f739e/vmlin=
ux-475c850a.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/0ac20b1308b7/=
bzImage-475c850a.xz>
> mounted in repro: <https://storage.googleapis.com/syzbot-assets/fad6178a7=
95b/mount_0.gz>
>   fsck result: failed (log: <https://syzkaller.appspot.com/x/fsck.log?x=
=3D122aa9d4580000>)
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+13ba7f3e9a17f77250fe@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 32768
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
> shift exponent 115 is too large for 64-bit type =E2=80=99s64=E2=80=99 (ak=
a =E2=80=99long long=E2=80=99)
> CPU: 1 UID: 0 PID: 5841 Comm: syz-executor190 Not tainted 6.15.0-next-202=
50606-syzkaller #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>  jfs_statfs+0x4d1/0x550 fs/jfs/super.c:140
>  statfs_by_dentry fs/statfs.c:66 [inline]
>  vfs_statfs+0x144/0x2d0 fs/statfs.c:90
>  ovl_check_namelen fs/overlayfs/super.c:388 [inline]
>  ovl_lower_dir fs/overlayfs/super.c:404 [inline]
>  ovl_get_lowerstack fs/overlayfs/super.c:1150 [inline]
>  ovl_fill_super+0x9d9/0x35d0 fs/overlayfs/super.c:1416
>  vfs_get_super fs/super.c:1323 [inline]
>  get_tree_nodev+0xbb/0x150 fs/super.c:1342
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1802
>  do_new_mount+0x24a/0xa40 fs/namespace.c:3874
>  do_mount fs/namespace.c:4211 [inline]
>  __do_sys_mount fs/namespace.c:4422 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4399
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8347037a39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdd0158b28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f8347037a39
> RDX: 0000200000000000 RSI: 0000200000000140 RDI: 0000000000000000
> RBP: 00007f834708005e R08: 00002000000003c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
> R13: 65756e69746e6f63 R14: 633d73726f727265 R15: 0000000000000001
>  </TASK>
> =E2=80=94[ end trace ]=E2=80=94
>
>
> =E2=80=94
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

