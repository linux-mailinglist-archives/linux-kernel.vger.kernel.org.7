Return-Path: <linux-kernel+bounces-748835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABDB14682
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76711791DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340C1B4257;
	Tue, 29 Jul 2025 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNBqu/Ne"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFCD515
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757474; cv=none; b=Vyyzmuj6oL0tZ9Zx2U3AIuWqiIBI4UEiv2k+F23sJMjH1l+6aw27CLtJQd/wat1Iepvbhviqbo1seHrXjnC9YAnEqe6vX9yBpg00IxwVw2inGCOlYLh6bhDQO53gJccgBnxm6MaXTPVF+qy0X4/PAqMggklNtjTKsyGRNrrWkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757474; c=relaxed/simple;
	bh=DbN6hFSCHwouBBA11ucPdMLitCnbZ60NUOsyUkfToTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwwTIAYuZZqH/Og79hu4jI8qYGSGXCMAYa5hEGsi4StdjHY9g8upFwfqghIOhYSofDQl/SQkuWAFTl3Ny+VlFkCwC2tSQ8Q1FBSNAN7imJs+f//q+gGJFZ8V97nBIO0uFBIZJey5Un3gVyIf7aP0Q78JRTaDLbTmHFfF/Gkp8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNBqu/Ne; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso76181cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753757471; x=1754362271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP4nJ7QVKuQ6dIL817mkYQc9jCgroNaq8Iqx4W9HDXs=;
        b=fNBqu/NeTVnnfUW9aNNZLTU/t4e5nujMPe1YYJeytdzrz+MUE8mm0mGGmWIrve01wL
         1rKCXNHFveKKmRPTKgbbPF+ECIRH7Owtw7P1WcI6KkiuDsrPGTF31OvvZZGzem9E5QXf
         x2gbWDabV+/DxYYO8jA3drO/qBdpGurU0C3PQFUIlKM7VzkrfKk5VWpyz3WwlLDHJm7Z
         wIN8zcBsKeGd1yiOID6bnvDlxPadbdnyNYfl7N3JMrePtEDliQa9K8IzCD9S/hIJnmPY
         pDhfbVW46agHE1lBUoCF/826R1wkcJdFh6PY4Ugzlax05QGbPJjCYp9j/XreaPXL8mW+
         lDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757471; x=1754362271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP4nJ7QVKuQ6dIL817mkYQc9jCgroNaq8Iqx4W9HDXs=;
        b=TpCA4lLnlEgqJQjuJ90nU+I5L2qXi7RjRqZG6+phO9RLxLM+hzV0UzaszpOuRDDx/s
         3IF4/Bi/D23V0M88i4r7icw4t6qbplE6QCl1fniqo0lhoyMyTJMU/ME++wvxBxBzqeF0
         1Rh3KwYpQF3v1xmEa1XRuftqAi/grjm3pceSYYNv77gbKrniSJHJ8uMQz32828Or5LLl
         e95OMck4tVcKx0VsYyR3AZ9mTMq2UpfQHQS8LC6D6X44oM0WsSsdRv0YaIMXxyixIzE/
         P5PbigA+9MRmhUHhz/2Q4klBCkZYXicN7JAv57/YffGC6QLplAXm2wQSlgH3IDAr7vVz
         8iGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzCCSdheNnJEHa7a9uGiT94fzQ5ko1juNmsQ+VNkfrwXGq7ZCkRMg8DdR7ZBZACtOBjtWuBiio5wCzGuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZX9SUI8rrpveQHIwa3yGSodF8oiCy+3/b7e61Rfmr7OgHaW1
	tPHuRKPcuEOHQiDeKIfcOVwsjElXozmZWSapgALQPRieA86e96ORbr/W5K3fyAVDMFcGhYXB2wt
	x9UoE/ULtufBiNx2L9x7CkJJgH/RRjE/yWs64t6Yp
X-Gm-Gg: ASbGncvJk7Pg0p3cve5+k2DZcOY4Lj25TBkYmSYZ/LuLjPvEnuUw5/UJOyRZ0qxOT6+
	h6MhcNIweAyozs12kckOkXdXraZLaJDw2V9/R6fe3VIPQAJSvKxLSV+OOp5sqE4cMnrcF82HXJr
	entumocf577l9ZRq2Kit2ePnmgfkMZOK2pnMoXc9R1smqoJr/XsFaO/IYmBMT+0Ymy7Pd2lX0lt
	5unA3gN5/LupmJtcptd86Bbwe0RGskCoTQ=
X-Google-Smtp-Source: AGHT+IGyI4KuVMOu/ABy9Gmqs9xFZsf4rHRJ3lGsTjRW6FqT11tApijS68uAhbGR/B5/E2Yy8R0tlPFH4KUT9S2LiBc=
X-Received: by 2002:a05:622a:215:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4aecf9d2793mr1190081cf.23.1753757471101; Mon, 28 Jul 2025
 19:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68794b5c.a70a0220.693ce.0050.GAE@google.com> <aIfmv-qSxKxWgzur@x1.local>
In-Reply-To: <aIfmv-qSxKxWgzur@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Jul 2025 02:51:00 +0000
X-Gm-Features: Ac12FXxkdhvQM-2FTNyBaLgIo3h_qmvhR-ZEgqZTcFlI_763WaZT8GyJ4e8N0TM
Message-ID: <CAJuCfpFjvSQs2SomPpafw=H-z3fOBy_+K3qkdPa8wz_pH_C1pQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in move_pages
To: Peter Xu <peterx@redhat.com>
Cc: syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:08=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Copy Lokesh and Suren.

Thanks! I'll take a closer look tomorrow morning.

>
> On Thu, Jul 17, 2025 at 12:13:32PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e8352908bdcd Add linux-next specific files for 20250716
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17f81382580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7b0e60e17d=
c5717
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db446dbe27035e=
f6bd6c2
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D100413825=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10eb158c580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ae8cc81c1781/d=
isk-e8352908.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/57aaea991896/vmli=
nux-e8352908.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/feb871619bd4=
/bzImage-e8352908.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> >
> > BUG: unable to handle page fault for address: ffffea6000391008
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 13fff8067 P4D 13fff8067 PUD 0
> > Oops: Oops: 0000 [#1] SMP KASAN PTI
> > CPU: 1 UID: 0 PID: 5860 Comm: syz-executor832 Not tainted 6.16.0-rc6-ne=
xt-20250716-syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/07/2025
> > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00=
 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 48 =
89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  userfaultfd_move fs/userfaultfd.c:1923 [inline]
> >  userfaultfd_ioctl+0x2e8b/0x4c80 fs/userfaultfd.c:2046
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7ff3570d6519
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ff35708f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007ff357160308 RCX: 00007ff3570d6519
> > RDX: 0000200000000180 RSI: 00000000c028aa05 RDI: 0000000000000003
> > RBP: 00007ff357160300 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35712d074
> > R13: 0000200000000180 R14: 0000200000000188 R15: 00002000002b9000
> >  </TASK>
> > Modules linked in:
> > CR2: ffffea6000391008
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00=
 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 48 =
89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > ----------------
> > Code disassembly (best guess):
> >    0: c1 ec 06                shr    $0x6,%esp
> >    3: 4b 8d 1c 2c             lea    (%r12,%r13,1),%rbx
> >    7: 48 83 c3 08             add    $0x8,%rbx
> >    b: 48 89 d8                mov    %rbx,%rax
> >    e: 48 c1 e8 03             shr    $0x3,%rax
> >   12: 48 b9 00 00 00 00 00    movabs $0xdffffc0000000000,%rcx
> >   19: fc ff df
> >   1c: 80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
> >   20: 74 08                   je     0x2a
> >   22: 48 89 df                mov    %rbx,%rdi
> >   25: e8 9a 30 f4 ff          call   0xfff430c4
> > * 2a: 48 8b 1b                mov    (%rbx),%rbx <-- trapping instructi=
on
> >   2d: 48 89 de                mov    %rbx,%rsi
> >   30: 48 83 e6 01             and    $0x1,%rsi
> >   34: 31 ff                   xor    %edi,%edi
> >   36: e8 59 70 8f ff          call   0xff8f7094
> >   3b: 48 89 d8                mov    %rbx,%rax
> >   3e: 48                      rex.W
> >   3f: 83                      .byte 0x83
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
>
> --
> Peter Xu
>

