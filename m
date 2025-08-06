Return-Path: <linux-kernel+bounces-758099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B8B1CACD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15DB16E002
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03119DFAB;
	Wed,  6 Aug 2025 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UttnNqoc"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA651586C8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501464; cv=none; b=uyqlwSfCZJLa5wMLq5COrEJff2qnRdg+EUXZ1gNJeSwjS4ZLIy3b1/Cmb2dN1LIHGZ2ZutUL2HyZkPxf3g2awK/0hjd/InaOP5wHGSvpS9hwe3tVn5fuofVYrNWU6YMCAV51x0XlI/JhxTW/I19GBYWjsH8B0GM6xWZXJAc3gQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501464; c=relaxed/simple;
	bh=ifz/jLXVCJwYbx1zwgm/RXTrChVFKnJMUhFs/l8vA2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecjpQQiy9GESYsqyl4EZmxcSY8vh1nqS0YGtFvIdoTzdEyaZQTMPCeZiIE29LSopPUpX8dKY0JIx4PzYBHGNLXNICOJVnr8wfcZFcWtOsZKuHJ1FObSkJKqu43YC0sV6KWKR3P2kJSjLHHXB4vKUYuVbPJE6rAZ2YCcithIKL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UttnNqoc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso815a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754501460; x=1755106260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O1zwfL/UYqQtx8ceSMM8iZ39OAphqSN6A4Iks0YaB0=;
        b=UttnNqocG7CUT6N+o73u0iJ31+5vprhMskvCO/ktPx9/LqnklrVLk3oDSKXjU8nXFW
         g+ovRyuj+ZFk7cucsE9trGIUD+PgqrK7dLAvEAo17dX2E2FRfypr51qwfu6u2Birk881
         nTPjNVwbU1P/RqOncIgr5i9b+P4v3bMU81Kl2wJtf54t0Cj3+aJVcJIp3Cd6QpVIyC3v
         nUATmB3/+PAK61Wc9Ey8spNqKlbwHgOq/vO7pWbju4a9D98Fl6o7vvrsy14RtHWzM3ye
         0yJ2eMFGyU8qj+QJtbI53KOO9iOAqRRZT3ekyTTyIwARbbsPclJeWfTFEx5azhoAEaIt
         q3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501460; x=1755106260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O1zwfL/UYqQtx8ceSMM8iZ39OAphqSN6A4Iks0YaB0=;
        b=mHtN24idRrO+KlT81p1RlyTqnv9bVuJuvcMgWouvqWVQLRGiVksCSfikiwn/TwQnjt
         digpfKFmDs4zyHWQhbqLxkZOHsHQVb1g1JqLDw5blvafmoyGdivSYQafk7ORhmaKbaaX
         u2TsO2qTdSQoFoDv8eTL3TuPPt+upRfd62LGzaDbuTM4Szqx9oHCfIrDl5DFOD1nbPqZ
         ZaPMYZl2ASuujEnQhNCzPfVU/jkMQn1RxqdSBh/kQ7Dvj23QpqJt6BZba/Nto12za/RL
         aQteI9g4nhWlCEAJSm2xP3y2yVlNQvlSQ3u9viZWekagx82YV47DXxoAi+m+bOLI0a/Q
         vIWA==
X-Forwarded-Encrypted: i=1; AJvYcCUUtIa0Hc9vr27HG+ZQDRoojxyKX8ykvqlE9CPuxmw6nsqMCe7Yo8yVZCLC27paj5Xh10XqYQ7i3ZxUet0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzOGm3pEgQfn8YKxmztIxOAdzhzeaQoYitB1qL2JZ0ZvcDdyQ
	lIyzAjeL4w3g6zW5xURCInMJXm/ojYRSeCrZTtFSPaN9Ud3ANcnpygOLzPmsTldpGakGvKGTdzI
	YbUou82lOoWSunDTx5uFK5oOupHWz9NGHQIrWpPwQDfZ2Dp2hBKAxM6yiLxY=
X-Gm-Gg: ASbGnctgmz2m3cO56S/ygnt+H9t/eyP4k7SlT+yJo726VVEc4l1Vl6HcfiB2QygrgZG
	fmkJy3g0tBaCBbciz8hq92gmp4i7uyg+vdxg8836jXFqVF6JWCYZTli8MoIQx3+jfHTTHD1APAO
	9G5qQNfNTH8shDIHS5Alb8Uhbo1g/2bfHlvXMTJdEoXRAkkgcIx2Q/UEmBpHmu45MoFg4cN5pdd
	tFl1yWaniYF0XywAuqVNWDuU+8MhtnSV8muYQWYyA==
X-Google-Smtp-Source: AGHT+IGZYHqMO6nOext8IXEfZFnlVxuTzvfAsD1ASp7WlH8v9FRFw+U7OqG6LSsKKeEwE87Emf/LUxOiCHp7W6/3mQY=
X-Received: by 2002:a05:6402:3082:b0:615:60d2:c013 with SMTP id
 4fb4d7f45d1cf-61797e7bc1amr91621a12.3.1754501459967; Wed, 06 Aug 2025
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805121410.1658418-1-lokeshgidra@google.com> <a00a8cca-e435-434f-855c-a3b56f2aece4@lucifer.local>
In-Reply-To: <a00a8cca-e435-434f-855c-a3b56f2aece4@lucifer.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 6 Aug 2025 10:30:47 -0700
X-Gm-Features: Ac12FXwSYt0WGCr2k_VsdRbGveIp_87zZmB7V02_hsc1VeZ3C2syDDfiVLignxw
Message-ID: <CA+EESO6F4=jQujGU35EPp_EVtHRHEG7b7_izLv1-NJW_VFvGRw@mail.gmail.com>
Subject: Re: [PATCH v2] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 10:18=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Andrew - Could we drop this for now, please, it's splatting and has broke=
n
> mm-new.
>
> Lokesh - could you make sure to run the mm self tests with CONFIG_DBUG_VM
> set before you submit please? As this is splat is occurring immediately o=
n
> uffd-unit-tests.

Sincere apologies. Will be extra careful from now on.
>
> On Tue, Aug 05, 2025 at 05:14:10AM -0700, Lokesh Gidra wrote:
> > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > for moving present pages. Mitigate this cost by opportunistically
> > batching present contiguous pages for TLB flushing.
> >
> > Without batching, in our testing on an arm64 Android device with UFFD G=
C,
> > which uses MOVE ioctl for compaction, we observed that out of the total
> > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > ~20% in vm_normal_folio().
> >
> > With batching, the proportion of vm_normal_folio() increases to over
> > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > includes TLB-flush overhead.
> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> > Changes since v1 [1]
> > - Removed flush_tlb_batched_pending(), per Barry Song
> > - Unified single and multi page case, per Barry Song
>
> Splat, decoded via scripts/decode_stacktrace.sh:
>
> $ sudo ./uffd-unit-tests
> Testing UFFDIO_API (with syscall)... done
> Testing UFFDIO_API (with /dev/userfaultfd)... done
> Testing register-ioctls on anon... done
> Testing register-ioctls on shmem... done
> Testing register-ioctls on shmem-private... done
> Testing register-ioctls on hugetlb... skipped [reason: memory allocation =
failed]
> Testing register-ioctls on hugetlb-private... skipped [reason: memory all=
ocation failed]
> Testing zeropage on anon... done
> Testing zeropage on shmem... done
> Testing zeropage on shmem-private... done
> Testing zeropage on hugetlb... skipped [reason: memory allocation failed]
> Testing zeropage on hugetlb-private... skipped [reason: memory allocation=
 failed]
> Testing move on anon... [   12.230740] Kernel panic - not syncing: kernel=
: panic_on_warn set ...
> [   12.231322] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Arch Linux 1.17.0-1-1 04/01/2014
> [   12.231655] Call Trace:
> [   12.231748]  <TASK>
> [   12.231830] dump_stack_lvl (lib/dump_stack.c:122)
> [   12.231963] vpanic (kernel/panic.c:448)
> [   12.232088] panic (kernel/panic.c:312 kernel/panic.c:303)
> [   12.232199] ? move_pages (mm/userfaultfd.c:1964 (discriminator 2))
>
> Appears to be:
>
>         VM_WARN_ON_ONCE(err > 0);
>
> [   12.232341] check_panic_on_warn.cold (kernel/panic.c:327)
> [   12.232502] __warn.cold (kernel/panic.c:839)
> [   12.232628] ? move_pages (mm/userfaultfd.c:1964 (discriminator 2))
> [   12.232764] report_bug (lib/bug.c:176 lib/bug.c:215)
> [   12.232891] handle_bug (arch/x86/kernel/traps.c:338 (discriminator 1))
> [   12.233034] ? move_pages (mm/userfaultfd.c:1964 (discriminator 2))
> [   12.233174] exc_invalid_op (arch/x86/kernel/traps.c:392 (discriminator=
 3))
> [   12.233312] asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
> [   12.233460] RIP: 0010:move_pages (mm/userfaultfd.c:1964 (discriminator=
 2))
> [ 12.233615] Code: 5e 41 5f c3 cc cc cc cc 49 89 c5 e9 e1 fe ff ff eb c4 =
e9 6d ff ff ff 90 0f 0b 90 45 31 ff eb cf 90 0f 0b 90 48 85 d2 7e c6 90 <0f=
> 0b 90 eb b9 90 0f 0b 90 f7 c1 ff 0f 00 00 0f 84 4e fe ff ff 90
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   5e                      pop    %rsi
>    1:   41 5f                   pop    %r15
>    3:   c3                      ret
>    4:   cc                      int3
>    5:   cc                      int3
>    6:   cc                      int3
>    7:   cc                      int3
>    8:   49 89 c5                mov    %rax,%r13
>    b:   e9 e1 fe ff ff          jmp    0xfffffffffffffef1
>   10:   eb c4                   jmp    0xffffffffffffffd6
>   12:   e9 6d ff ff ff          jmp    0xffffffffffffff84
>   17:   90                      nop
>   18:   0f 0b                   ud2
>   1a:   90                      nop
>   1b:   45 31 ff                xor    %r15d,%r15d
>   1e:   eb cf                   jmp    0xffffffffffffffef
>   20:   90                      nop
>   21:   0f 0b                   ud2
>   23:   90                      nop
>   24:   48 85 d2                test   %rdx,%rdx
>   27:   7e c6                   jle    0xffffffffffffffef
>   29:   90                      nop
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   90                      nop
>   2d:   eb b9                   jmp    0xffffffffffffffe8
>   2f:   90                      nop
>   30:   0f 0b                   ud2
>   32:   90                      nop
>   33:   f7 c1 ff 0f 00 00       test   $0xfff,%ecx
>   39:   0f 84 4e fe ff ff       je     0xfffffffffffffe8d
>   3f:   90                      nop
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   90                      nop
>    3:   eb b9                   jmp    0xffffffffffffffbe
>    5:   90                      nop
>    6:   0f 0b                   ud2
>    8:   90                      nop
>    9:   f7 c1 ff 0f 00 00       test   $0xfff,%ecx
>    f:   0f 84 4e fe ff ff       je     0xfffffffffffffe63
>   15:   90                      nop
> [   12.234294] RSP: 0018:ffffafeb00483d70 EFLAGS: 00010206
> [   12.234484] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0000002
> [   12.234738] RDX: 0000000000001000 RSI: ffff90afbb433078 RDI: ffff90afb=
c7f0080
> [   12.234997] RBP: ffff90afbc7f0000 R08: ffff90b037cae540 R09: 000000000=
0000001
> [   12.235255] R10: ffffffffffffffff R11: 0000000000000003 R12: ffff90af0=
1acb980
> [   12.235508] R13: ffff90afbc7f0240 R14: ffffefc386e80b00 R15: 000000000=
0001000
> [   12.235764] userfaultfd_ioctl (fs/userfaultfd.c:1925 fs/userfaultfd.c:=
2046)
> [   12.235917] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:598 fs/ioctl.c:5=
84 fs/ioctl.c:584)
> [   12.236065] ? ksys_read (./include/linux/file.h:63 ./include/linux/fil=
e.h:80 ./include/linux/file.h:85 fs/read_write.c:706)
> [   12.236202] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminat=
or 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [   12.236345] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
130)
> [   12.236524] RIP: 0033:0x7f457600fecd
> [ 12.236658] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   04 25                   add    $0x25,%al
>    2:   28 00                   sub    %al,(%rax)
>    4:   00 00                   add    %al,(%rax)
>    6:   48 89 45 c8             mov    %rax,-0x38(%rbp)
>    a:   31 c0                   xor    %eax,%eax
>    c:   48 8d 45 10             lea    0x10(%rbp),%rax
>   10:   c7 45 b0 10 00 00 00    movl   $0x10,-0x50(%rbp)
>   17:   48 89 45 b8             mov    %rax,-0x48(%rbp)
>   1b:   48 8d 45 d0             lea    -0x30(%rbp),%rax
>   1f:   48 89 45 c0             mov    %rax,-0x40(%rbp)
>   23:   b8 10 00 00 00          mov    $0x10,%eax
>   28:   0f 05                   syscall
>   2a:*  89 c2                   mov    %eax,%edx                <-- trapp=
ing instruction
>   2c:   3d 00 f0 ff ff          cmp    $0xfffff000,%eax
>   31:   77 1a                   ja     0x4d
>   33:   48 8b 45 c8             mov    -0x38(%rbp),%rax
>   37:   64 48 2b 04 25 28 00    sub    %fs:0x28,%rax
>   3e:   00 00
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   89 c2                   mov    %eax,%edx
>    2:   3d 00 f0 ff ff          cmp    $0xfffff000,%eax
>    7:   77 1a                   ja     0x23
>    9:   48 8b 45 c8             mov    -0x38(%rbp),%rax
>    d:   64 48 2b 04 25 28 00    sub    %fs:0x28,%rax
>   14:   00 00
> [   12.237333] RSP: 002b:00007f4569dfed20 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [   12.237599] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f457=
600fecd
> [   12.237854] RDX: 00007f4569dfeda0 RSI: 00000000c028aa05 RDI: 000000000=
0000009
> [   12.238129] RBP: 00007f4569dfed70 R08: 0000000000000000 R09: 000000000=
0000000
> [   12.238384] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffb=
974ba60
> [   12.238636] R13: 00007fffb974b830 R14: 00007f4569dffcdc R15: 00007fffb=
974b937
> [   12.238890]  </TASK>
> [   12.239094] Kernel Offset: 0x33000000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [   12.239480] ---[ end Kernel panic - not syncing: kernel: panic_on_warn=
 set ... ]---

