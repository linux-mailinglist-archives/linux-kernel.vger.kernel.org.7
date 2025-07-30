Return-Path: <linux-kernel+bounces-751090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACFB1652F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7279189D39D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615E2DE1FA;
	Wed, 30 Jul 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avW8JJ/6"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C02E3711
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895384; cv=none; b=gdy5z+JBvlz54R+6kUq0NlAWZvshQjbO3b5nxYZ47oYiKagVAxdz3LOMIqxie8Rp6WIScBcwA0GKcrcSlp80C8K1N9B2/tsbf3lskIddxafRBlDtfN3138zLBPT6I5oRN4L2ItdQGZAP5PR1SESg4jXgmILoCYEcpPt47tiVJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895384; c=relaxed/simple;
	bh=k5ncFBnW+Wu6v822BYRwgF5xjxSMo7Aj8+4CFE3L/CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYNGBTJoko7pjkqvcqFjSLf1e3i/Cx9/QUfC1dDkOObesHfvjPea4otaypNzOYHGpIS595Y9Y9lGqH+/RBkO441oI0Knd2q0obtSShTdWQkO919TKAVamHDTVOU3EQh1fv3jO32jQ6Pi3aP2ymMHQCpXdng/Eij1iu5UnastOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avW8JJ/6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab86a29c98so13971cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753895381; x=1754500181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ornz5fkkifiDR+ny9GBtOpxaRpztQtp4fA2guzhOWYY=;
        b=avW8JJ/6zUDIdU6PF5okyJThf1cEEOzCfxGjJe2y2bSjZNCmOWOzpa3I8zOxH/rgFP
         y4QUKx9uUO7zDozPH3GC3HRjehMLFLa/cIG4IABEm3o91U9obGRK7o8EHexd5I8Xdgwk
         ClA+H89kR2L2LdXNwM+wbrhwAGZga2OY/qig9Q1mIF8A+RAY3bEsUac3P8a5auxsntAl
         +inlVuGKjPVxQY1zGCeGSoBh+LjxvjO5926Nu03W30P23ajp6CQLpYhaqyv53rBP3cEG
         SJrcF2uWcGzpvu58IMFRqfeuwAA9tAbe59gZpxJ2Av5Kr08d+iWVYvYZcGgUPIt2OR29
         oH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895381; x=1754500181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ornz5fkkifiDR+ny9GBtOpxaRpztQtp4fA2guzhOWYY=;
        b=S5NZwxpJhhsG/KcQx//FREBz7PVm3LLb0/9RpB7tOm3W843rEdUHgtDXJKAOv/cBjs
         CplURRq4rutnc/oxIoBidghxohyv5WuC4uLYgmEL9WmIUxtCF5rtUCF2g7ycL6A3Z10Y
         yVVP9yumMEBSDgp4skQd1qHPDkhd3mP/GUI14lSxA/jhwtuB7qNWmZY8y0iq3fcp/zp+
         elmazLYJPdyASBWqCYo+1lfzLjvg9/7I7TuenxrCM0v/VOK4Wm+16zIm2uA47lKxYdCB
         nLP+qxXprnBWn1jetjFQWP9bOYi3Amo0xch6rxlsPxUCr2+WaZeRTadnF+Mw2G660DlF
         fxHw==
X-Forwarded-Encrypted: i=1; AJvYcCVn44yYkFhpT9GLNaMiisBQkA5UJQnC4MV+RdFqjAfF4RrOvpjmD2DEEVKnvPklr++apGq6Q1PDXKvWQqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3M1we99BghulLGs+4b3vgiZJivjXWEljKu+nvXrwTRna7IGPg
	exJAOh4MvVLE67sACZImiRuZrBXkEmYBfBGa6YGT6elugky2HeOUeWek3QKrp4606s6I/D5MIVL
	SHFZLHILYoLRvgzCeuEmf3yhDJf33vNPgzuhwT3eg
X-Gm-Gg: ASbGncsRY86Edzc3qOjKuUddFImUh5l3/8sIgUwwLqNWAYFjZtpsj2ZJI7kaylK24kn
	HfXaAMTGWj5+DbusC8LgtUc5QL726rX/dBn3aTlzZF1WmgE3JBJGzNBGd5F0ZDzMp/IbmMp98qJ
	35jiF36Bo21KJZls4cEvpmDvFAVpN6S7S4G5rhUn66C9GdBY5UrmiE2mQrlvOyJRpLAzQaf0jWn
	FYrpcUFRzCiR2j/iAFmCyLsgZ7ZV7ARh6z93g==
X-Google-Smtp-Source: AGHT+IHJSGoncxy6snA63ICBiOwoo+mkeZNRxbOighGafxurDE8wizkpCLimPwYtssEQItZCmnQsCPsYpjGYx5A8nV4=
X-Received: by 2002:a05:622a:281:b0:4aa:cba2:2e67 with SMTP id
 d75a77b69052e-4aedf66ab3dmr4744811cf.21.1753895380766; Wed, 30 Jul 2025
 10:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68794b5c.a70a0220.693ce.0050.GAE@google.com> <aIfmv-qSxKxWgzur@x1.local>
 <CAJuCfpFjvSQs2SomPpafw=H-z3fOBy_+K3qkdPa8wz_pH_C1pQ@mail.gmail.com>
 <CA+EESO7goQHuAdobDvWMaYGiVw30g1=o_f5UzBceeSbS2n5MtA@mail.gmail.com> <CAJuCfpGGpQ4s+z2AAs3YwgHASVUqx4tEi=1BMeqW8_wL_acq_w@mail.gmail.com>
In-Reply-To: <CAJuCfpGGpQ4s+z2AAs3YwgHASVUqx4tEi=1BMeqW8_wL_acq_w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 30 Jul 2025 10:09:29 -0700
X-Gm-Features: Ac12FXy9U8CDMEZDRh4a79HB_hxWTB9tzdWfnoQgViYYKcrZcwYxF8AOn0Jg8Dk
Message-ID: <CAJuCfpEirT6MS2kGnp0q0Ykke+_0tWu-zrrJmhsOraPqdH0zwA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in move_pages
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Peter Xu <peterx@redhat.com>, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:51=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Jul 29, 2025 at 1:08=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > On Mon, Jul 28, 2025 at 7:51=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Mon, Jul 28, 2025 at 9:08=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > Copy Lokesh and Suren.
> >
> > Thanks Peter!
> > >
> > > Thanks! I'll take a closer look tomorrow morning.
> > >
> > I think the issue is that we are incorrectly handling src holes in the
> > THP case. The reproducer is setting 'mode' to
> > UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it seems like the src address is
> > indeed untouched at the time MOVE ioctl is invoked and hence likely
> > has a hole.
> >
> > When this mode is set, we (correctly) don't fail with -ENOENT, but
> > then instead of skipping the page, we keep going with THP move, which
> > involves fetching the folio unconditionally from the src_pmd, which is
> > expected to have no page mapped there.
> >
> > Suren, can you please double check if my hypothesis is correct?
>
> I think in the case of a hole the prior call to pmd_trans_huge_lock()
> would return NULL and we would not handle it as THP move.
> I was able to reproduce the crash, though the call stack is a bit
> different. Will try to figure it out.

Ok, pmd_trans_huge_lock() actually confused non-present PMD with a
swap/migration entry and does not return NULL in such cases. I posted
a fix here: https://lore.kernel.org/all/20250730170733.3829267-1-surenb@goo=
gle.com/

>
> > > >
> > > > On Thu, Jul 17, 2025 at 12:13:32PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    e8352908bdcd Add linux-next specific files for 20=
250716
> > > > > git tree:       linux-next
> > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17f81=
382580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7b0e=
60e17dc5717
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db446dbe=
27035ef6bd6c2
> > > > > compiler:       Debian clang version 20.1.7 (++20250616065708+614=
6a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D100=
41382580000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10eb1=
58c580000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/ae8cc81c=
1781/disk-e8352908.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/57aaea99189=
6/vmlinux-e8352908.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/feb871=
619bd4/bzImage-e8352908.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.co=
m
> > > > >
> > > > > BUG: unable to handle page fault for address: ffffea6000391008
> > > > > #PF: supervisor read access in kernel mode
> > > > > #PF: error_code(0x0000) - not-present page
> > > > > PGD 13fff8067 P4D 13fff8067 PUD 0
> > > > > Oops: Oops: 0000 [#1] SMP KASAN PTI
> > > > > CPU: 1 UID: 0 PID: 5860 Comm: syz-executor832 Not tainted 6.16.0-=
rc6-next-20250716-syzkaller #0 PREEMPT(full)
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 05/07/2025
> > > > > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > > > > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > > > > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9=
 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b =
1b 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > > > > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > > > > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > > > > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > > > > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > > > > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  userfaultfd_move fs/userfaultfd.c:1923 [inline]
> > > > >  userfaultfd_ioctl+0x2e8b/0x4c80 fs/userfaultfd.c:2046
> > > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > > >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> > > > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> > > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > RIP: 0033:0x7ff3570d6519
> > > > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > > > RSP: 002b:00007ff35708f218 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
> > > > > RAX: ffffffffffffffda RBX: 00007ff357160308 RCX: 00007ff3570d6519
> > > > > RDX: 0000200000000180 RSI: 00000000c028aa05 RDI: 0000000000000003
> > > > > RBP: 00007ff357160300 R08: 0000000000000000 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35712d074
> > > > > R13: 0000200000000180 R14: 0000200000000188 R15: 00002000002b9000
> > > > >  </TASK>
> > > > > Modules linked in:
> > > > > CR2: ffffea6000391008
> > > > > ---[ end trace 0000000000000000 ]---
> > > > > RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> > > > > RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> > > > > Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9=
 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b =
1b 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> > > > > RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> > > > > RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > > > > R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> > > > > R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> > > > > FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> > > > > ----------------
> > > > > Code disassembly (best guess):
> > > > >    0: c1 ec 06                shr    $0x6,%esp
> > > > >    3: 4b 8d 1c 2c             lea    (%r12,%r13,1),%rbx
> > > > >    7: 48 83 c3 08             add    $0x8,%rbx
> > > > >    b: 48 89 d8                mov    %rbx,%rax
> > > > >    e: 48 c1 e8 03             shr    $0x3,%rax
> > > > >   12: 48 b9 00 00 00 00 00    movabs $0xdffffc0000000000,%rcx
> > > > >   19: fc ff df
> > > > >   1c: 80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
> > > > >   20: 74 08                   je     0x2a
> > > > >   22: 48 89 df                mov    %rbx,%rdi
> > > > >   25: e8 9a 30 f4 ff          call   0xfff430c4
> > > > > * 2a: 48 8b 1b                mov    (%rbx),%rbx <-- trapping ins=
truction
> > > > >   2d: 48 89 de                mov    %rbx,%rsi
> > > > >   30: 48 83 e6 01             and    $0x1,%rsi
> > > > >   34: 31 ff                   xor    %edi,%edi
> > > > >   36: e8 59 70 8f ff          call   0xff8f7094
> > > > >   3b: 48 89 d8                mov    %rbx,%rax
> > > > >   3e: 48                      rex.W
> > > > >   3f: 83                      .byte 0x83
> > > > >
> > > > >
> > > > > ---
> > > > > This report is generated by a bot. It may contain errors.
> > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > >
> > > > > syzbot will keep track of this issue. See:
> > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > >
> > > > > If the report is already addressed, let syzbot know by replying w=
ith:
> > > > > #syz fix: exact-commit-title
> > > > >
> > > > > If you want syzbot to run the reproducer, reply with:
> > > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > > If you attach or paste a git patch, syzbot will apply it before t=
esting.
> > > > >
> > > > > If you want to overwrite report's subsystems, reply with:
> > > > > #syz set subsystems: new-subsystem
> > > > > (See the list of subsystem names on the web dashboard)
> > > > >
> > > > > If the report is a duplicate of another one, reply with:
> > > > > #syz dup: exact-subject-of-another-report
> > > > >
> > > > > If you want to undo deduplication, reply with:
> > > > > #syz undup
> > > > >
> > > >
> > > > --
> > > > Peter Xu
> > > >

