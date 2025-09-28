Return-Path: <linux-kernel+bounces-835118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B26BA6518
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A26E188B70A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A91A7253;
	Sun, 28 Sep 2025 00:36:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C810E3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759019796; cv=none; b=ox6VE5Hua6mtfpdF68AeEDEsFxJD++bZ6oCUKvGdZzdY9VxBuIsOQrfGN8XW/dvuuGMWc9w3WoRgqdsifZXGH8lxwYelWoB+sx4DVmpn+ZhBFontd1mUeMoyN21nUWw9alXfd7sMEkAUVb0OipYsdb40ZRWbPCA2dGwb4S6VITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759019796; c=relaxed/simple;
	bh=jl1CFGybMjQID4/oiMoomoYa6Nqi1o57Yut2TH5fVK8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=evM9euPoAxjdB4yhub0WoWEUB5YqMUxBchVl3TcU7NLO0O+FA5jvHa3mu86iH+Mh6hx2k0ZBKfGxWUUtInpCr1mE2sL5tr3ReQu3ZFry0mlB5OP99vl2LZlN9lU7ixCeixBcHCoULoKo+mz1vY75y2WVW5PxiRNWpX+roTjF4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9201572ebfbso75271139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 17:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759019794; x=1759624594;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSiVz7xPKubsK0qqcWocNAndgSvRvj8/CbWEA7xbm64=;
        b=AJwmpH1qlzkaeS0C6r93cQ2YJhnxHRoFkgrJkzrn2qoITdK4iXLTvc8HSzE4pdNTuL
         9XCJuLHnFt0wJLZ7e3F8kH497ZVdq1MHmGcY/PGQO56CIfyN2gLw8UoNN6i22ZbI1WLB
         Hq2fNllE0gn7B3FTJl/t9nPmWEhPsf9zMzdroagpZvYhK9EZQ14rknAbNf59N+k7DzGc
         dthSGKhv5DT+ofVTd9bfgClakWXk2XWYHWeiwrqGH1AMyBxHvWN08QqDDYlN+cx0wnZG
         DwvF9wRCnoukZd6LQWUyRaOTS1XGLCiUAqKscyr1QOqUyL1lpgRacQl7VCgM/8qN32QY
         AkxQ==
X-Gm-Message-State: AOJu0YymKva20RMMnNR4C2/I4Y7aFt6YjG96j2Jo0V027lQ/MDaAHY0q
	kQyEj6FOTM51JiIQgPqNPpTSmYidc0Cdhu3vT6Mx+hd50krAJ7LNVy4ITZ6wqiv/avfr3g5Qm2D
	mlXWVwcoHx+XQcXI6kCTa1t4ZRDldG6LZpnLia0/T9orDl4a+5P/ZgfeC6koaGQ==
X-Google-Smtp-Source: AGHT+IH5HhVBdlNvsOqa+2zohPznRgN70XNfq6gj/dpLgGpjJ4t7EUpLQT2xqypKPj51yVc6XlHI2lQE+MNduOFN71s5zCRqphnM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:428:3602:8f46 with SMTP id
 e9e14a558f8ab-4283602934cmr86759365ab.32.1759019793761; Sat, 27 Sep 2025
 17:36:33 -0700 (PDT)
Date: Sat, 27 Sep 2025 17:36:33 -0700
In-Reply-To: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d88311.050a0220.25d7ab.042d.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in aio_iiro_16_attach
From: syzbot <syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in aio_iiro_16_a=
ttach
Author: xandfury@gmail.com

syzbot <syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a79a588fc176 Merge tag =E2=80=99pm-6.16-rc5=E2=80=99 of g=
it://git.kernel.o..
> git tree:       upstream
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D14a4ac8c5800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D5ba6cef8f153=
bfeb>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3Df1bb7e4ea47ea1=
2b535c>
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D12a4ac8c58=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D13fc9c8c5800=
00>
>
> Downloadable assets:
> disk image (non-bootable): <https://storage.googleapis.com/syzbot-assets/=
d900f083ada3/non_bootable_disk-a79a588f.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/c7aa4e6d68b0/vmlin=
ux-a79a588f.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/5d71f2c64f29/=
bzImage-a79a588f.xz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
>
> UBSAN: shift-out-of-bounds in drivers/comedi/drivers/aio_iiro_16.c:180:9
> shift exponent 8550 is too large for 32-bit type =E2=80=99int=E2=80=99
> CPU: 2 UID: 0 PID: 6096 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-0=
0308-ga79a588fc176 #0 PREEMPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:233 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
>  aio_iiro_16_attach drivers/comedi/drivers/aio_iiro_16.c:180 [inline]
>  aio_iiro_16_attach.cold+0x19/0x1e drivers/comedi/drivers/aio_iiro_16.c:1=
64
>  comedi_device_attach+0x3b3/0x900 drivers/comedi/drivers.c:996
>  do_devconfig_ioctl+0x1a7/0x580 drivers/comedi/comedi_fops.c:855
>  comedi_unlocked_ioctl+0x15bb/0x2e90 drivers/comedi/comedi_fops.c:2136
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3eb858e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc84ea1e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f3eb87b5fa0 RCX: 00007f3eb858e929
> RDX: 0000200000000140 RSI: 0000000040946400 RDI: 0000000000000003
> RBP: 00007f3eb8610b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f3eb87b5fa0 R14: 00007f3eb87b5fa0 R15: 0000000000000003
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
 66acb1586737

