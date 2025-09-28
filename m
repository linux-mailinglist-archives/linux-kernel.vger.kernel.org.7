Return-Path: <linux-kernel+bounces-835175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B7BA670F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D6317E831
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC2254AE7;
	Sun, 28 Sep 2025 03:25:45 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BF1A262A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759029944; cv=none; b=ftcbo0SxB4wcy7duGC2UGwkTvpzwTCzhdt8ZfHQCYDfWedBIgp2cWmqI/FdvbK3aBY/Ygwvi5F5Br32SS5V2M7NWrJqHzcozf6SoTxyWU5oMA71M4nLHXzzzKVoBSzfjNspQsOeBgwq0EWQ93u2+TOkpTRe5PzvXIVx6Zcg7Mj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759029944; c=relaxed/simple;
	bh=ndvAh1089V55es0pZ8GCvpd4P72uPQBGK1mdrrgUkow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QZO7UClxqZVDS/ZEe7u/vn2W/F6XqpX0ZbaQ1nDLIviU6+GHz1BacmhDJVMXzhbLmXlvR6nvHPavY8z3GzztuvjRgxRa/0BrvIm7w/WhqbrOeyEiCnpHAEnYePKv2eYPE7xbz1ReKEd2YADl7sPqKrgbBSIKs44zlbAc6xGPYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-429aa22e058so5363525ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759029942; x=1759634742;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRHEvzjMEylp9BlD+YbDO1evUo2nfIQSYhSMAKeCN24=;
        b=SulPpJ06jKl4fmLnrSA1/ziHkjagiwTT28/OW5q9uAspP6ETb8ci785NB43OPm6+9e
         GBlca+Me+Z3CReTKMSE5EUYrFmpiOY1R2Wty6Wmeuc1iwi9gzT7TUZn10OtyAEoaUitp
         S5cb/+v3YB1YTlvc7ZxhV+cMGQOrFvvUC5im3tUS2MTvrZTRKIWz8Or8zy8FOQScbO6w
         5aY7hJWQuh5hqGFPJ8S2htqX7PdRgUKSXO8HOJtqcZSbKek8NkvVJUdwsxXHNTALncJZ
         978TPkg4GeIxN43C2/oyJUA2cYcGGOy4ulskfSI6Uw7wZbx3eUrfPzMpAeFIncAsZQLs
         Cx9A==
X-Gm-Message-State: AOJu0YzfuP4Xj2D/OTz1fCm3i+/nT2f0IxvjjeCAqCln/sM6gYu/L90w
	XOvYSgRVisKRfqMcijH9a+VnJ4Kk26BZIScXAoJ91laVxFH75E62VcID4nVtoewtyquVrwTEaB3
	bzpFFimfLGDOWap1FGh0uBipEKYAy+PCS5pRZTuFTCAhbHK/LnE+FsFDmuck=
X-Google-Smtp-Source: AGHT+IFUht90BUntjfK4AX6JKWYXXl40k9cUXZJuGDJXCuc65jgaACfaiNP/X/2MW41BQoVqZeRWnb5ME0l7YQxlmBv5J7qdJUvA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d82:b0:426:6097:48fd with SMTP id
 e9e14a558f8ab-42660974c3fmr139547185ab.31.1759029942461; Sat, 27 Sep 2025
 20:25:42 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:25:42 -0700
In-Reply-To: <0000000000005902e205d301dd7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8aab6.050a0220.25d7ab.045f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] UBSAN: shift-out-of-bounds in minix_statfs
From: syzbot <syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in minix_statfs
Author: xandfury@gmail.com

syzbot <syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b8a98b6bf66a Merge tag =E2=80=99pci-v5.16-fixes-2=E2=80=
=99 of git://git.ke..
> git tree:       upstream
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D1342c069b000=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D221ffc09e39e=
bbd1>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D5ad0824204c7bf=
9b67f2>
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D15e8a551b0=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D176da9b9b000=
00>
>
> Bisection is inconclusive: the issue happens on the oldest tested release=
.
>
> bisection log:  <https://syzkaller.appspot.com/x/bisect.txt?x=3D17e8a7bdb=
00000>
> final oops:     <https://syzkaller.appspot.com/x/report.txt?x=3D1418a7bdb=
00000>
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D1018a7bdb000=
00>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 272
> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D'
> UBSAN: shift-out-of-bounds in fs/minix/inode.c:380:57
> shift exponent 65510 is too large for 64-bit type =E2=80=99long unsigned =
int=E2=80=99
> CPU: 0 PID: 3601 Comm: syz-executor657 Not tainted 5.16.0-rc4-syzkaller #=
0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:330
>  minix_statfs.cold+0x17/0x1c fs/minix/inode.c:380
>  statfs_by_dentry+0x133/0x210 fs/statfs.c:66
>  vfs_statfs fs/statfs.c:90 [inline]
>  fd_statfs+0x66/0x100 fs/statfs.c:120
>  __do_sys_fstatfs+0x7a/0xf0 fs/statfs.c:216
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f33e4f00e09
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeedacabd8 EFLAGS: 00000246 ORIG_RAX: 000000000000008a
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f33e4f00e09
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 00007f33e4ec06a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffeedacaa90 R11: 0000000000000246 R12: 00007f33e4ec0730
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
> For information about bisection process see: <https://goo.gl/tpsmEJ#bisec=
tion>
> syzbot can test patches for this issue, for details see:
> <https://goo.gl/tpsmEJ#testing-patches>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

