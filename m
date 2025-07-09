Return-Path: <linux-kernel+bounces-722558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57745AFDC1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2648163A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C13FE4;
	Wed,  9 Jul 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neGkYcop"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D65661
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019881; cv=none; b=JRIU50ct62LBJ4WiKuTmAeSKAcHH6wPdsB7NLF8Wp6GrPbtybZ29xNvyxy9QBRUdr8XzQTijNCTyDdgORO5BTVxQsOIsI7S0HndJf9ZUKe/yBYk4NQ6QIC2g0IBnnTGiSyWO7A5P99CwHO9oLeX/bg3+7qNA4EAh3X6DMRrP/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019881; c=relaxed/simple;
	bh=bfLDi0sxeTpVagF2rvnkiOtbra7VZbAxPMQqmK9DvPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIaU1uuYZbbmVbmF3P3k1kYNRy7ot8xoEUOkg+qZ2EdjYdoc+EyRv0uxnJBVtbImh0HnIXdn4xiMzHt6Fs5sywaPgwQcT41ZSkd3YeXA1RT07wkJukOpmQNijDAVn6xf+4mYxelNazazL9ZGLESGMQarToM1PCjUjE80Opyg3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=neGkYcop; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5ac8fae12so206831cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752019879; x=1752624679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TareOnxwISX+lcaXM73qp5CVhC7/Qy48266uBzG4H9I=;
        b=neGkYcopKmCWYGqUGrxk3SvG9gdqWwe1v8UDxxLvjDBgek/mo1ibSVD9mxB0MrgS/k
         j9EZ4w0I0cEbNKf8+igubmEAtojClYxh+gbyC3NY/NNUS9Axxzm2eGGdFLaOCkEXu11V
         aTsQSuWqYXBRXzQjhrjM8yavuK3hV54rjAwbEB6/zfFau1y3gXtOzeOljSaPYxEajx8u
         oLekAaKmr2hquiMX2rHD3GW7zGIDA2qv7ITd0Eo3gBMb+QKxR/TWfgZEmmfbE1uWbTVi
         JMiLBsAypymazIVa7xY/zJEig9agFbbfVBohfA/ghZvRmHUA9lc3ni0KLnXiv0rbQtxL
         NBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752019879; x=1752624679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TareOnxwISX+lcaXM73qp5CVhC7/Qy48266uBzG4H9I=;
        b=gidbry971muX8+vQOxW3KBAeyb1otu8J2hS60z5ebKXFZYle9GVtgX/ALa7yf0Dhey
         52E1ohtZfFXYAH8SwrkxDEzEnCcu/tn7ef+rExl2DCYeueQw5q/05fuhui2C4K5yx9q1
         l/kAjOmimFPjOZ3wO9Ba0qKbusouvDKuimTq17UoaJEFc8djsCWc2JNzqxZSMXXemezd
         mndNIkcaFngA9m+XhvC86ccKzMMzBAhV0gsqYEx/Zh/QmlZbhHsQhJsObq79mgEr7qHA
         AcoBWlCXSgBKws+QVIN8Ue2nTnM+FKEYyIcvfrZl4j/SMH0jvs4ma9PjU14Xx02KsBS4
         mvyw==
X-Forwarded-Encrypted: i=1; AJvYcCVmP6PI9X5Etygi5cW5jYJ6LBNz3xsoGnO29r4yBED4UXIcIhgr4j0J8gXLPwzv43vPFFHX/ULLRumYbio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJJNkCUOqrbLZzcaTqq9G8xrPj32W8Tz/nu+JII0tS05TKNCZ
	lj7bln7d6E7utQUDUmfM7I4//JC74i94DPHnVh2YLK6pU61MzXKv0BqC0Vegt20y1B4JoetuN2O
	8yNBHIUoVg/4JuT2j/4Gu30suhIoGvxtOeRWCPDJd
X-Gm-Gg: ASbGncsAezWOpN2SY0M1A6JjBMMWb5geF9qJ6XrNZTU3/o48qWYVBNGE9bEZzeC1UyK
	Vt8IU4x5iRbmEb6DX4ZAsdWil+eWfm/FWu4BNd59jLFc88ApCf0hGJAwdT7jeEQKjud9M7XDF7i
	e3X+8X+sUnhz1Co2RIjSyyN6YAjVB7cLL/VIQsyAs1VA==
X-Google-Smtp-Source: AGHT+IF4A1y1FOvYj1uWjT8cHk05m4R14gEJm0srliKNkuJSA6GnkleKeFrd2bqjmojI9cEN94lXzNXKVGxam9TlkxE=
X-Received: by 2002:a05:622a:8c16:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4a9de110275mr885711cf.15.1752019878226; Tue, 08 Jul 2025
 17:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686d5adb.050a0220.1ffab7.0018.GAE@google.com>
In-Reply-To: <686d5adb.050a0220.1ffab7.0018.GAE@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 17:11:07 -0700
X-Gm-Features: Ac12FXylKbEqBMTG7W7-HNcs-CbE_beeX-JQtMBomIOQmtVogjJgziXjbs2Im0Q
Message-ID: <CAJuCfpHECsKQjB4LAipo-wab==0BUzwv9rEHjviv3m1_KrqnKA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] stack segment fault in mtree_range_walk
To: syzbot <syzbot+8d7491ac5a289af56d5a@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 10:52=E2=80=AFAM syzbot
<syzbot+8d7491ac5a289af56d5a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13eedf7058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e4f88512ae53=
408
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8d7491ac5a289af=
56d5a
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14e15582580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D101edf7058000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/dis=
k-26ffb3d6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinu=
x-26ffb3d6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/b=
zImage-26ffb3d6.xz
>
> The issue was bisected to:
>
> commit 6772c457a86536f3496bf5b3716f34a5ac125783

This is also the previous version of my patchset that is not in
linux-next anymore.

> Author: Suren Baghdasaryan <surenb@google.com>
> Date:   Tue Jun 24 19:33:59 2025 +0000
>
>     fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl under per-vma locks
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12cad58258=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D11cad58258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16cad58258000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+8d7491ac5a289af56d5a@syzkaller.appspotmail.com
> Fixes: 6772c457a865 ("fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl unde=
r per-vma locks")
>
> Oops: stack segment: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 6058 Comm: syz.0.18 Not tainted 6.16.0-rc4-next-202507=
04-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> RIP: 0010:mtree_range_walk+0x2d7/0x840 lib/maple_tree.c:2773
> Code: 00 00 48 8d 04 2b 48 83 f8 01 0f 84 b4 00 00 00 e8 6e c6 4f f6 49 8=
3 c4 08 48 ff c3 eb ac e8 60 c6 4f f6 31 db e9 e1 00 00 00 <80> 7d 00 00 74=
 07 31 ff e8 3c 63 b4 f6 4c 8b 2c 25 00 00 00 00 48
> RSP: 0018:ffffc900039df9a0 EFLAGS: 00010297
> RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000005
> RDX: ffffffff8b6fe83a RSI: ffffffff8f893390 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffff888025693c00 R09: 0000000000000003
> R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f67b2a0b6c0(0000) GS:ffff888125ce7000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f67b2a0af98 CR3: 0000000075f14000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  mas_state_walk lib/maple_tree.c:3630 [inline]
>  mas_walk lib/maple_tree.c:4933 [inline]
>  mas_find_setup lib/maple_tree.c:6012 [inline]
>  mas_find+0x8e9/0xd30 lib/maple_tree.c:6052
>  vma_next include/linux/mm.h:864 [inline]
>  lock_next_vma+0x101/0xdc0 mm/mmap_lock.c:216
>  get_next_vma fs/proc/task_mmu.c:182 [inline]
>  query_vma_find_by_addr fs/proc/task_mmu.c:516 [inline]
>  query_matching_vma+0x28f/0x4b0 fs/proc/task_mmu.c:545
>  do_procmap_query fs/proc/task_mmu.c:637 [inline]
>  procfs_procmap_ioctl+0x406/0xce0 fs/proc/task_mmu.c:748
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f67b1b8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f67b2a0b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f67b1db6080 RCX: 00007f67b1b8e929
> RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
> RBP: 00007f67b1c10b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f67b1db6080 R15: 00007ffdeba76008
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:mtree_range_walk+0x2d7/0x840 lib/maple_tree.c:2773
> Code: 00 00 48 8d 04 2b 48 83 f8 01 0f 84 b4 00 00 00 e8 6e c6 4f f6 49 8=
3 c4 08 48 ff c3 eb ac e8 60 c6 4f f6 31 db e9 e1 00 00 00 <80> 7d 00 00 74=
 07 31 ff e8 3c 63 b4 f6 4c 8b 2c 25 00 00 00 00 48
> RSP: 0018:ffffc900039df9a0 EFLAGS: 00010297
> RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000005
> RDX: ffffffff8b6fe83a RSI: ffffffff8f893390 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffff888025693c00 R09: 0000000000000003
> R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f67b2a0b6c0(0000) GS:ffff888125ce7000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f67b2a0af98 CR3: 0000000075f14000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:   00 00                   add    %al,(%rax)
>    2:   48 8d 04 2b             lea    (%rbx,%rbp,1),%rax
>    6:   48 83 f8 01             cmp    $0x1,%rax
>    a:   0f 84 b4 00 00 00       je     0xc4
>   10:   e8 6e c6 4f f6          call   0xf64fc683
>   15:   49 83 c4 08             add    $0x8,%r12
>   19:   48 ff c3                inc    %rbx
>   1c:   eb ac                   jmp    0xffffffca
>   1e:   e8 60 c6 4f f6          call   0xf64fc683
>   23:   31 db                   xor    %ebx,%ebx
>   25:   e9 e1 00 00 00          jmp    0x10b
> * 2a:   80 7d 00 00             cmpb   $0x0,0x0(%rbp) <-- trapping instru=
ction
>   2e:   74 07                   je     0x37
>   30:   31 ff                   xor    %edi,%edi
>   32:   e8 3c 63 b4 f6          call   0xf6b46373
>   37:   4c 8b 2c 25 00 00 00    mov    0x0,%r13
>   3e:   00
>   3f:   48                      rex.W
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

