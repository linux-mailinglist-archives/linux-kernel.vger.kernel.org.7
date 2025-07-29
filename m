Return-Path: <linux-kernel+bounces-749743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A465B1525D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108E97A5F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69628C02E;
	Tue, 29 Jul 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29eVYl2a"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F823DE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811500; cv=none; b=JT8FtgNNB8QgFkmMv59ujGd/+NcLwWnYd0eDtpQ5D94Z3yCGB1ernBU1+baeZZvqNpPX/f0XmJBSJCZgPNrZdtwKujf+AElkpQvovkzmGgNzBut0JqeozXZ4ifC2JR3hmvqPpmPp1+ozPVxpeAi8UsoS93n1eACu6kDOcFFXdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811500; c=relaxed/simple;
	bh=dRL179cXTylxuftYVoxVRhQ+lkfIJIwei8FefbLGr2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5+9UOA6G6gyAy+L1AlCAr8jAQ/ugC1DMpWU6+ISdM+N6Egret0K0ksQo135WEZsDNWDAFUx3IX6/2eG+LHhCl179tA/nAvljubvgU0b8G7OO1EMMk9QGc5Ro2SfdM2O7nFzNC0HltE4PS/YcABojjqy4yQCWDFAPcS/0Jjs+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29eVYl2a; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab3855fca3so37591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753811498; x=1754416298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUV4bd9jQv9HI6OBSP2N2WpkOCN1WYWoK2UgBJjsg9Y=;
        b=29eVYl2aglxOBh8HFUmVHo6qUXx14nJhkt1miItSApfopw9v5ndHJBY7Hc3wuT8Kfg
         k8ULoT1vgfKfDNWhZXCJGblEKcm63BQgZxCWrfDQlak+Wc08uIJvJuXlC6dYMz3nkn+t
         Ka9zNiIfpnZTpHnqE8H+8S/phlATmwkl1KzF5szKOA/pn/RAJSZ7V1Kh6xdOzZv6hvSZ
         ILdYZhAlgeajcTgZU8LQ9Xqg9PhXC1COtjG7eUUfylT8twf/ss4vuXIMexXnEhWpEHCF
         CObouX40M4Scx5YZ9t2et6m24hkTz8IDIOcUPvd0iyiu9Z6Mndd6Qs9qhJGbjF+MlttM
         0TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753811498; x=1754416298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUV4bd9jQv9HI6OBSP2N2WpkOCN1WYWoK2UgBJjsg9Y=;
        b=JXb98ScDWJ36O+rGCkFwuW14VVXcGnRhldgOPkOEFzRrWP9CINBiuQ2lgfLyITTzHo
         GsdRepzh1hz4iMjs806ZyiGz+SBVKvLQJSF5jP0l0KnKT6ciHrX8b7EJoBvhnJcjWT/w
         rCaLlMSzKi6p8UXBSuJVBHA9TOMgc078L4pemRRZktNgDME+yyJJGy3aRnvv3eIOO+Zl
         4FR9V+i1AMHlsFC22KTJ6jnGh+YoNtIIETZTztEIsWGa1gXmgoeNcghMRTZDmFJkrA8q
         QikoNobF43dr6epeeSfzh8a1CMpegqS8S+zp+ckgQCQ1XsorFuGxcTuleSI5JGzpZVpW
         CENg==
X-Forwarded-Encrypted: i=1; AJvYcCW+MQ94ZE1hhOnE4xaQrfgwOytbM/otQPB9fA3FMTV9XTOtHo9CP234fFyCuINc1iesQK+zBajJ50/r5qI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95y+PlesdwZ/2rm1M98h/5eTAT7/Ws3TS/I/J7iA4dE7gA1DA
	bFYpHsQ7Ux5YIrngSqgfRI/PK/w1/vrtkheysFETq5WHY++vBA78TaK4CbcRs0MENJQiueRYn68
	ka9lGMcEVQ4cec8J6AM9HuKAkIbfRu3K9c39zL6Rz
X-Gm-Gg: ASbGncuD1p1O5sqMQNLP1C977eEllfjGaDGJRXAgZx4UimKt20WdwjcqPT27u0uULyg
	TdFrDHz+Dv4icAs2/7N8QtRgJmssjSX/nWFIA/VlQpOZHjYjxUDx/VRawdsOklbGcH0kbMrOpfK
	fjLIXR7bPAiUgexvIj24F1EX+BpHoabNecmuzvsIe7c8ECJGxFRAdAz12QIu2kmeHOJTXav97UA
	iSZpIwHsQvQlq9fPHgExLvEvaBBU5WSkDoDpA==
X-Google-Smtp-Source: AGHT+IEKQ1ZSdA0dCGB/QidlUmKWUeKgpTvh58U9nFdnK2Ys0CFX4j/XIXq5wjXiXS9G9FXtIrhwbcQSHH40WD4PyYQ=
X-Received: by 2002:a05:622a:1916:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4aeddd1e930mr3161cf.9.1753811497192; Tue, 29 Jul 2025 10:51:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68794b5c.a70a0220.693ce.0050.GAE@google.com> <aIfmv-qSxKxWgzur@x1.local>
 <CAJuCfpFjvSQs2SomPpafw=H-z3fOBy_+K3qkdPa8wz_pH_C1pQ@mail.gmail.com> <CA+EESO7goQHuAdobDvWMaYGiVw30g1=o_f5UzBceeSbS2n5MtA@mail.gmail.com>
In-Reply-To: <CA+EESO7goQHuAdobDvWMaYGiVw30g1=o_f5UzBceeSbS2n5MtA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Jul 2025 10:51:26 -0700
X-Gm-Features: Ac12FXydOXggkkwOKVSAz6ykCOejwKRuh2-g1yX-kFBa882Gm_XdDezYtwexigs
Message-ID: <CAJuCfpGGpQ4s+z2AAs3YwgHASVUqx4tEi=1BMeqW8_wL_acq_w@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in move_pages
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Peter Xu <peterx@redhat.com>, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:08=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> On Mon, Jul 28, 2025 at 7:51=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Mon, Jul 28, 2025 at 9:08=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > Copy Lokesh and Suren.
>
> Thanks Peter!
> >
> > Thanks! I'll take a closer look tomorrow morning.
> >
> I think the issue is that we are incorrectly handling src holes in the
> THP case. The reproducer is setting 'mode' to
> UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it seems like the src address is
> indeed untouched at the time MOVE ioctl is invoked and hence likely
> has a hole.
>
> When this mode is set, we (correctly) don't fail with -ENOENT, but
> then instead of skipping the page, we keep going with THP move, which
> involves fetching the folio unconditionally from the src_pmd, which is
> expected to have no page mapped there.
>
> Suren, can you please double check if my hypothesis is correct?

I think in the case of a hole the prior call to pmd_trans_huge_lock()
would return NULL and we would not handle it as THP move.
I was able to reproduce the crash, though the call stack is a bit
different. Will try to figure it out.

> > >
> > > On Thu, Jul 17, 2025 at 12:13:32PM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e8352908bdcd Add linux-next specific files for 2025=
0716
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17f8138=
2580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7b0e60=
e17dc5717
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db446dbe27=
035ef6bd6c2
> > > > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a=
88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10041=
382580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10eb158=
c580000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/ae8cc81c17=
81/disk-e8352908.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/57aaea991896/=
vmlinux-e8352908.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/feb87161=
9bd4/bzImage-e8352908.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > >
> > > > BUG: unable to handle page fault for address: ffffea6000391008
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 13fff8067 P4D 13fff8067 PUD 0
> > > > Oops: Oops: 0000 [#1] SMP KASAN PTI
> > > > CPU: 1 UID: 0 PID: 5860 Comm: syz-executor832 Not tainted 6.16.0-rc=
6-next-20250716-syzkaller #0 PREEMPT(full)
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 05/07/2025
> > > > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > > > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > > > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 0=
0 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b=
 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > > > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > > > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > > > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > > > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > > > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > > > Call Trace:
> > > >  <TASK>
> > > >  userfaultfd_move fs/userfaultfd.c:1923 [inline]
> > > >  userfaultfd_ioctl+0x2e8b/0x4c80 fs/userfaultfd.c:2046
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> > > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7ff3570d6519
> > > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007ff35708f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010
> > > > RAX: ffffffffffffffda RBX: 00007ff357160308 RCX: 00007ff3570d6519
> > > > RDX: 0000200000000180 RSI: 00000000c028aa05 RDI: 0000000000000003
> > > > RBP: 00007ff357160300 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35712d074
> > > > R13: 0000200000000180 R14: 0000200000000188 R15: 00002000002b9000
> > > >  </TASK>
> > > > Modules linked in:
> > > > CR2: ffffea6000391008
> > > > ---[ end trace 0000000000000000 ]---
> > > > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > > > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > > > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 0=
0 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b=
 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > > > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > > > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > > > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > > > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > > > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > > > ----------------
> > > > Code disassembly (best guess):
> > > >    0: c1 ec 06                shr    $0x6,%esp
> > > >    3: 4b 8d 1c 2c             lea    (%r12,%r13,1),%rbx
> > > >    7: 48 83 c3 08             add    $0x8,%rbx
> > > >    b: 48 89 d8                mov    %rbx,%rax
> > > >    e: 48 c1 e8 03             shr    $0x3,%rax
> > > >   12: 48 b9 00 00 00 00 00    movabs $0xdffffc0000000000,%rcx
> > > >   19: fc ff df
> > > >   1c: 80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
> > > >   20: 74 08                   je     0x2a
> > > >   22: 48 89 df                mov    %rbx,%rdi
> > > >   25: e8 9a 30 f4 ff          call   0xfff430c4
> > > > * 2a: 48 8b 1b                mov    (%rbx),%rbx <-- trapping instr=
uction
> > > >   2d: 48 89 de                mov    %rbx,%rsi
> > > >   30: 48 83 e6 01             and    $0x1,%rsi
> > > >   34: 31 ff                   xor    %edi,%edi
> > > >   36: e8 59 70 8f ff          call   0xff8f7094
> > > >   3b: 48 89 d8                mov    %rbx,%rax
> > > >   3e: 48                      rex.W
> > > >   3f: 83                      .byte 0x83
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > If the report is already addressed, let syzbot know by replying wit=
h:
> > > > #syz fix: exact-commit-title
> > > >
> > > > If you want syzbot to run the reproducer, reply with:
> > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > If you attach or paste a git patch, syzbot will apply it before tes=
ting.
> > > >
> > > > If you want to overwrite report's subsystems, reply with:
> > > > #syz set subsystems: new-subsystem
> > > > (See the list of subsystem names on the web dashboard)
> > > >
> > > > If the report is a duplicate of another one, reply with:
> > > > #syz dup: exact-subject-of-another-report
> > > >
> > > > If you want to undo deduplication, reply with:
> > > > #syz undup
> > > >
> > >
> > > --
> > > Peter Xu
> > >

