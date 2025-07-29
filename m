Return-Path: <linux-kernel+bounces-749074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A96B149C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E294E603E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B422750EA;
	Tue, 29 Jul 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0VuPc/w"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B17130AC8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776496; cv=none; b=Fc31WvZ9kgErN0myC47o7HnVGpx1eDztnNanOINw/cDz4eNx/o61YY65seLIsvsKJrVjWIPoWMPQBAzndnEeRlWVtCfhG/gguojPN2zyOviuqEvBS2pg1OyFbEdnvTFP40TCa8Q8a7nqlar5Z8V7vNy9XQ+mZEXML4ZzuV9XqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776496; c=relaxed/simple;
	bh=CHjpdbZgxEH+Phb69bElHylCFSF3bwCO54M/ot/I0ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeWDHtDLYLOcSiZn7pPGRickyMkD5Tw69tye2slBljzTJiv+jdwQzQWo1fMkCR+OuKKHFEFXgq0lk5R+YZ0F/tuVUKEq0IqIHhHxU1G7ZbLdPLnE8ETuqmbgKMx8NUX1KKdFCAuIFEgAuBctCzejPwgfHNcQ/mZcJQ1diM5ngAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0VuPc/w; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6154c7b3ee7so8896a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776493; x=1754381293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D+GIvBwkRTfSk18WRWL6ADC9Bi5jFYdl5q9R36jCus=;
        b=l0VuPc/w4sSVQv5sHKnaWX2Nori/w/OY0JRuZ6EPgsY2ZyrjLWKCjiG7xT+bTBVqbL
         9A1ZiXQBK5SMvMZGnE07AHyC/h+T58iwT/505pVo/HDn0GMYGiIiEl6iQjP6jtjzWgox
         bD8iNOM2SdhZM17L+/v2VAVUg8QXhESr3aU/GO6gKG/mwrjxFrca2xZ7yFUz6gv10pt2
         8unHpSCAFIIaNTU3HqgBeRZjiKa+/ye19amvl54CAI4UsKlg9vHZ78ea71MPlcaV7pjV
         Ez8+2AiegICIWd4682EXkXB61M/eFfR5/1Wr+sHQyod9GuQ7NNuKwAlexFxsdLZRq33Z
         1qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776493; x=1754381293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D+GIvBwkRTfSk18WRWL6ADC9Bi5jFYdl5q9R36jCus=;
        b=EaNBuoaVc2vbSU4wcgUP+68hAhJ61ofdBp2T/OTuG+YGqdtOE24Z6Un/9sDc4FEiGm
         +xu8eIk4UP2fet5jR2a7wJ9fWBlWzXiYqonTUvaDZVd4Q9bp8ZX+S7Dfpl0P1nRgQAY1
         5N3n24c/aXd/4wJ3k/ZjcP5zGhPmOSuvXFKoh5RBsKoIgF0tuzIqGGl5u7LIpxHFd96U
         0gMLs/Ih4OS8B7kwLvIBMueh3PNyC8GZH6t3BDOqEj4E/F7NMJjTBkaK2/sR78/4W8v0
         9BiR7ounPYBTV+ZmgOYdmD0HUEk/g0Rr+t7wxBLt18EYXpJ672JsTgyuafjSqk5yIuK6
         tI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmpWnnZUBTVuSmIbhFZySAi+5ph0VbG2f18w4PMDm3rpEdyyjdJ7/l7XQP4mUBnfo9yAxH71IPwO8rnA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRHbabj4U08wQSLZA5H30CuFpdNUqtFiWORbu1os4ZWFuzHjV
	S1tQLuWq7DFxyR27nB7p9y43MtbKJhbF1Nk81EVZGCJ1gte5oysBtzdKNCUtYunbaqBvjmugHMX
	v0t9fmAJZZ/6+ClTan7L8Ji49c2H6w1Ot/e+qTkQ0jRczzcVMSPXSMav9TxTZqA==
X-Gm-Gg: ASbGncsbGJcO12/2iBmRBvpgyh5g7BjlaiwBixzF/P03V0GOlqWxCR0ueYzv7hpugdS
	VoVXvzLxia5LceSShUZxDHXL5uTVhA2nn+Xc30WJAYiv5sKPSyH6S3z1dLFKtlifbFrPXQ1UIOS
	MyHIk3koPbCxL3J4T0xhsNVXTAUQQmVgOSaJKDngsql6gHZQl2UxqoV04F7Lte+s+4Igsh9VqsD
	Xka1m2xN/Uv14RYp1wUlewb5TfnuD2L43VXeRTF
X-Google-Smtp-Source: AGHT+IGcXvGdAr6TvJhNCZ95eVsXRkJ3K3zE7LGz4EXE22eFx4/bx/BVWxGUSrbt/vmRmWcZ+uRVkIWt7pYofe7iL3s=
X-Received: by 2002:a50:ccdc:0:b0:615:5ae7:a3ae with SMTP id
 4fb4d7f45d1cf-6156a4ce799mr41920a12.1.1753776492388; Tue, 29 Jul 2025
 01:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68794b5c.a70a0220.693ce.0050.GAE@google.com> <aIfmv-qSxKxWgzur@x1.local>
 <CAJuCfpFjvSQs2SomPpafw=H-z3fOBy_+K3qkdPa8wz_pH_C1pQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFjvSQs2SomPpafw=H-z3fOBy_+K3qkdPa8wz_pH_C1pQ@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 29 Jul 2025 01:08:00 -0700
X-Gm-Features: Ac12FXwTYz44HDx6ZFsvx6WVYP8tmyPvMZumxmqvdy7Xwd974aHyc3U4TnXF0DU
Message-ID: <CA+EESO7goQHuAdobDvWMaYGiVw30g1=o_f5UzBceeSbS2n5MtA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in move_pages
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 7:51=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jul 28, 2025 at 9:08=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > Copy Lokesh and Suren.

Thanks Peter!
>
> Thanks! I'll take a closer look tomorrow morning.
>
I think the issue is that we are incorrectly handling src holes in the
THP case. The reproducer is setting 'mode' to
UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it seems like the src address is
indeed untouched at the time MOVE ioctl is invoked and hence likely
has a hole.

When this mode is set, we (correctly) don't fail with -ENOENT, but
then instead of skipping the page, we keep going with THP move, which
involves fetching the folio unconditionally from the src_pmd, which is
expected to have no page mapped there.

Suren, can you please double check if my hypothesis is correct?
> >
> > On Thu, Jul 17, 2025 at 12:13:32PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e8352908bdcd Add linux-next specific files for 202507=
16
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17f813825=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7b0e60e1=
7dc5717
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db446dbe2703=
5ef6bd6c2
> > > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88=
f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1004138=
2580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10eb158c5=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ae8cc81c1781=
/disk-e8352908.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/57aaea991896/vm=
linux-e8352908.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/feb871619b=
d4/bzImage-e8352908.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > >
> > > BUG: unable to handle page fault for address: ffffea6000391008
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 13fff8067 P4D 13fff8067 PUD 0
> > > Oops: Oops: 0000 [#1] SMP KASAN PTI
> > > CPU: 1 UID: 0 PID: 5860 Comm: syz-executor832 Not tainted 6.16.0-rc6-=
next-20250716-syzkaller #0 PREEMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 05/07/2025
> > > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 =
00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 4=
8 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > > Call Trace:
> > >  <TASK>
> > >  userfaultfd_move fs/userfaultfd.c:1923 [inline]
> > >  userfaultfd_ioctl+0x2e8b/0x4c80 fs/userfaultfd.c:2046
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7ff3570d6519
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ff35708f218 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 00007ff357160308 RCX: 00007ff3570d6519
> > > RDX: 0000200000000180 RSI: 00000000c028aa05 RDI: 0000000000000003
> > > RBP: 00007ff357160300 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35712d074
> > > R13: 0000200000000180 R14: 0000200000000188 R15: 00002000002b9000
> > >  </TASK>
> > > Modules linked in:
> > > CR2: ffffea6000391008
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 =
00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 4=
8 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > > ----------------
> > > Code disassembly (best guess):
> > >    0: c1 ec 06                shr    $0x6,%esp
> > >    3: 4b 8d 1c 2c             lea    (%r12,%r13,1),%rbx
> > >    7: 48 83 c3 08             add    $0x8,%rbx
> > >    b: 48 89 d8                mov    %rbx,%rax
> > >    e: 48 c1 e8 03             shr    $0x3,%rax
> > >   12: 48 b9 00 00 00 00 00    movabs $0xdffffc0000000000,%rcx
> > >   19: fc ff df
> > >   1c: 80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
> > >   20: 74 08                   je     0x2a
> > >   22: 48 89 df                mov    %rbx,%rdi
> > >   25: e8 9a 30 f4 ff          call   0xfff430c4
> > > * 2a: 48 8b 1b                mov    (%rbx),%rbx <-- trapping instruc=
tion
> > >   2d: 48 89 de                mov    %rbx,%rsi
> > >   30: 48 83 e6 01             and    $0x1,%rsi
> > >   34: 31 ff                   xor    %edi,%edi
> > >   36: e8 59 70 8f ff          call   0xff8f7094
> > >   3b: 48 89 d8                mov    %rbx,%rax
> > >   3e: 48                      rex.W
> > >   3f: 83                      .byte 0x83
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >
> >
> > --
> > Peter Xu
> >

