Return-Path: <linux-kernel+bounces-753319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D9B1817D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D8B625B48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0423D29A;
	Fri,  1 Aug 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGUWevl9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4D1E32D3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050065; cv=none; b=IR7uyivW2MaKmVG0vxEz6j+MLHPjbtbPMFHxr9BOJFPlR3bNsTiqLYlQ11sutOVL1NK6DnNpzPI8rOd8lLRwNLXMjS5FgXyc9bCl7rgfcErRFQ8T4UeVDHOenTg0L6GH0HzubS8fZ8ZWiqX8F36+6G1UDcphKMpQu5HjDjpfgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050065; c=relaxed/simple;
	bh=TXR6NDjPQDzHqSTcE0PpR7LNPI7PgE4N3GKdq+ZOXmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbeQS4BzgRmSKpL0+RGu+Bj1GfFZpICCDAGUaKWxTUmGHfDFIKhHOvNVe4HOC3i1GifOpcC/vS/YvOrYnNP6/ya7NX4Q96lcgZR+sUDn73NxjBtJfaNAfHP3Gphh7b+hoCmxyZpn8gUHOTX75qiT80uLXAQY39zpKmQgsa7IUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGUWevl9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754050062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcVkJvAFktjZzpTROsYrYOV6ej0May6QulP0eELUUGk=;
	b=QGUWevl9jJWaFYgjGIebmDOy6Z16IKNe2b3Nm2LKgouQGgW3UY+C9+epb+r+OEK37qQjTh
	j9yvUirJfz9/MNvoI+DE4tzq1RIPa+R8p0VvfufLkpbweKQydufZFfOo44oR3NMn8URs5Z
	183063T19umpEHj0jcL/SiftRWKZ28A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-8Nz8dw8kO5-vJRAXvU0www-1; Fri, 01 Aug 2025 08:07:41 -0400
X-MC-Unique: 8Nz8dw8kO5-vJRAXvU0www-1
X-Mimecast-MFC-AGG-ID: 8Nz8dw8kO5-vJRAXvU0www_1754050060
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32eaaa0e729so5681171fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 05:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754050059; x=1754654859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcVkJvAFktjZzpTROsYrYOV6ej0May6QulP0eELUUGk=;
        b=qaaw+77sB8BjuVQDZrzu9CdB0u9NKuYX0UUHytdHSQb9cfQFvugCtarAW7MroID6T6
         DEVTdMRICzo2uaLZ71e4kB2jgJM5XxhB58dvsJaGbrtmmHBMlGtzd/WfLjBRhRUkPRnf
         +fH4Jo29b6P5TxIgzLC7ZlTm+0eOlRpHFbnundsdWkG4ooHVJ/1riPblpU5N5VEwIxc9
         Ta/id2iufzuhrmJhGoIzp2/YAdQL07ONKgytjRQJoBehFO9rKn74hxLZE9FpW6YgqQcj
         CY22rWx+afYvwwJRaxcu35VZadh43xD6XVYtbD5P6nn5XwgKHhYFvDzVhMd+qrisrJ7B
         sFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUwXFd5WIaF2AkwFD+O18fmIq9bEh01caukL4Cdpj8u/hUU9AUOitmb+rBgp3d5bVTEB1Dgr1qztXh0Rak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzdqqCyZqk99gKl9Qk1jQn7J47SIMtEEhMPLUxogYwTuLqVNW
	c+zoGLxMNjkLZKAfLPYiYiuqrfEemHr1DoauHPFo9DEJ+DiUPkMuYfCByLjvz5olL0R1QbT0PTr
	ESCMoQwFnxMXm3K6VXqw1gag6Vtm2N5fHW7cmLbLuebvShiKALJ9y2BAkWHV25luoXWkNOjDCka
	sKe8Ts0BjHyFRrIW+rWFl+lgDHlE4mLJvpDx4aPvdkvzcLhLL4+hw=
X-Gm-Gg: ASbGncs7HwqkjfVW7Vz1QlbNhz7TiZEYWQ2tdOW3C8t1WIu6IUS5fbRQOOUt4tLJcNw
	ebs6B2eXMj9FN4Vlp8hC6Gqip+CLkh80R8tRWqJl/jZvvdpK2404DfTRpobHQDHqvjgRudmz//l
	GprWHuZj0WHNDRqUhZpKd1637OPX9Wgva4vYCV0MW1MyJOR4CxSz46Ug==
X-Received: by 2002:a2e:a99f:0:b0:32b:2fe7:afd0 with SMTP id 38308e7fff4ca-33224b00238mr32838131fa.17.1754050059387;
        Fri, 01 Aug 2025 05:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErzCTJ0JPGgTZ810B7ZKHAzyLHojikjQluDbWBCj3g+zyJvBRB3nhTWnMnSoeIVFKv10zRnrn2EXPbKyqguwE=
X-Received: by 2002:a2e:a99f:0:b0:32b:2fe7:afd0 with SMTP id
 38308e7fff4ca-33224b00238mr32837991fa.17.1754050058787; Fri, 01 Aug 2025
 05:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731214051.4115182-1-herton@redhat.com> <d1445c9c-6603-4ff2-9cac-2a60ed4efe4b@arm.com>
In-Reply-To: <d1445c9c-6603-4ff2-9cac-2a60ed4efe4b@arm.com>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Fri, 1 Aug 2025 09:07:27 -0300
X-Gm-Features: Ac12FXzQbuG9oWdYcAUVTKImH2V2xdXvEOKO3v2EIfcXnrjlcY_54iviXNlugjQ
Message-ID: <CAJmZWFGgxaWU6UW_agPYBLcBPFu3Ji4yRDXRnVMHPLNgiW315A@mail.gmail.com>
Subject: Re: [PATCH] mm/debug_vm_pgtable: clear page table entries at destroy_args()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 11:41=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Herton,
>
> On 01/08/25 3:10 AM, Herton R. Krzesinski wrote:
> > The mm/debug_vm_pagetable test allocates manually page table entries fo=
r the
> > tests it runs, using also its manually allocated mm_struct. That in its=
elf is
> > ok, but when it exits, at destroy_args() it fails to clear those entrie=
s with
> > the *_clear functions.
> >
> > The problem is that leaves stale entries. If another process allocates
> > an mm_struct with a pgd at the same address, it may end up running into
> > the stale entry. This is happening in practice on a debug kernel with
>
> Should not the allocators ensure that the allocated memory elements are
> all cleaned up before using them ?

I did not saw anything which cleaned them. all the pgd/pud etc. alloc
functions do not clean them, so I think that's the default behaviour
from what I understand. I also used crash utility on a live kernel
reading the pgd address from the mm_struct that was allocated from the
debug_vm_pgtable test and already freed and saw that it was populated
even after it was freed.

>
> > CONFIG_DEBUG_VM_PGTABLE=3Dy, for example this is the output with some
> > extra debugging I added (it prints a warning trace if pgtables_bytes go=
es
> > negative, in addition to the warning at check_mm() function):
> >
> > [    2.539353] debug_vm_pgtable: [get_random_vaddr         ]: random_va=
ddr is 0x7ea247140000
> > [    2.539366] kmem_cache info
> > [    2.539374] kmem_cachep 0x000000002ce82385 - freelist 0x000000000000=
0000 - offset 0x508
> > [    2.539447] debug_vm_pgtable: [init_args                ]: args->mm =
is 0x000000002267cc9e
> > (...)
> > [    2.552800] WARNING: CPU: 5 PID: 116 at include/linux/mm.h:2841 free=
_pud_range+0x8bc/0x8d0
> > [    2.552816] Modules linked in:
> > [    2.552843] CPU: 5 UID: 0 PID: 116 Comm: modprobe Not tainted 6.12.0=
-105.debug_vm2.el10.ppc64le+debug #1 VOLUNTARY
> > [    2.552859] Hardware name: IBM,9009-41A POWER9 (architected) 0x4e020=
2 0xf000005 of:IBM,FW910.00 (VL910_062) hv:phyp pSeries
> > [    2.552872] NIP:  c0000000007eef3c LR: c0000000007eef30 CTR: c000000=
0003d8c90
> > [    2.552885] REGS: c0000000622e73b0 TRAP: 0700   Not tainted  (6.12.0=
-105.debug_vm2.el10.ppc64le+debug)
> > [    2.552899] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=
  CR: 24002822  XER: 0000000a
> > [    2.552954] CFAR: c0000000008f03f0 IRQMASK: 0
> > [    2.552954] GPR00: c0000000007eef30 c0000000622e7650 c000000002b1ac0=
0 0000000000000001
> > [    2.552954] GPR04: 0000000000000008 0000000000000000 c0000000007eef3=
0 ffffffffffffffff
> > [    2.552954] GPR08: 00000000ffff00f5 0000000000000001 000000000000004=
8 0000000000004000
> > [    2.552954] GPR12: 00000003fa440000 c000000017ffa300 c0000000051d9f8=
0 ffffffffffffffdb
> > [    2.552954] GPR16: 0000000000000000 0000000000000008 000000000000000=
a 60000000000000e0
> > [    2.552954] GPR20: 4080000000000000 c0000000113af038 00007fffcf13000=
0 0000700000000000
> > [    2.552954] GPR24: c000000062a6a000 0000000000000001 8000000062a6800=
0 0000000000000001
> > [    2.552954] GPR28: 000000000000000a c000000062ebc600 000000000000200=
0 c000000062ebc760
> > [    2.553170] NIP [c0000000007eef3c] free_pud_range+0x8bc/0x8d0
> > [    2.553185] LR [c0000000007eef30] free_pud_range+0x8b0/0x8d0
> > [    2.553199] Call Trace:
> > [    2.553207] [c0000000622e7650] [c0000000007eef30] free_pud_range+0x8=
b0/0x8d0 (unreliable)
> > [    2.553229] [c0000000622e7750] [c0000000007f40b4] free_pgd_range+0x2=
84/0x3b0
> > [    2.553248] [c0000000622e7800] [c0000000007f4630] free_pgtables+0x45=
0/0x570
> > [    2.553274] [c0000000622e78e0] [c0000000008161c0] exit_mmap+0x250/0x=
650
> > [    2.553292] [c0000000622e7a30] [c0000000001b95b8] __mmput+0x98/0x290
> > [    2.558344] [c0000000622e7a80] [c0000000001d1018] exit_mm+0x118/0x1b=
0
> > [    2.558361] [c0000000622e7ac0] [c0000000001d141c] do_exit+0x2ec/0x87=
0
> > [    2.558376] [c0000000622e7b60] [c0000000001d1ca8] do_group_exit+0x88=
/0x150
> > [    2.558391] [c0000000622e7bb0] [c0000000001d1db8] sys_exit_group+0x4=
8/0x50
> > [    2.558407] [c0000000622e7be0] [c00000000003d810] system_call_except=
ion+0x1e0/0x4c0
> > [    2.558423] [c0000000622e7e50] [c00000000000d05c] system_call_vector=
ed_common+0x15c/0x2ec
> > (...)
> > [    2.558892] ---[ end trace 0000000000000000 ]---
> > [    2.559022] BUG: Bad rss-counter state mm:000000002267cc9e type:MM_A=
NONPAGES val:1
> > [    2.559037] BUG: non-zero pgtables_bytes on freeing mm: -6144
> >
> > Here the modprobe process ended up with an allocated mm_struct from the
> > mm_struct slab that was used before by the debug_vm_pgtable test. That =
is not a
> > problem, since the mm_struct is initialized again etc., however, if it =
ends up
> > using the same pgd table, it bumps into the old stale entry when cleari=
ng/freeing
> > the page table entries, so it tries to free an entry already gone (that=
 one
> > which was allocated by the debug_vm_pgtable test), which also explains =
the
>
> How did you ensure that it was allocated from debug_vm_pgtable ? Trace pr=
ints during
> its execution and then matching up the addresses ? Just curious.

Usually the mm_struct address would match, but the problem is the pgd
address, the pgd address allocated for the mm_struct matched. Yes
trace prints and the problem happening with same mm_struct->pgd. Also
disabling CONFIG_DEBUG_VM_PGTABLE also made the problem go away. It
was "easy" to reproduce on a powerpc machine (with a reboot loop, in
my case sometimes on a 50 or 100 times, since the test executes only
on early boot), if another process after it got the same mm->pgd by
accident it would get the problem (from experience looking into the
issue, it would happen on boot with udev firing lots of modprobe and
one eventually got the mm_struct from the slab and same pgd that was
used before). What lead me investigating into this was that I saw some
reports of "BUG: non-zero pgtables_bytes on freeing mm" messages
reports, sometimes then followed by corruption/panic usually related
to page table entries, on that reboot loop test. Then I was able to
determine that CONFIG_DEBUG_VM_PGTABLE was to blame, and from there
find out that even disabling the tests manually, only allocing the
pgtable entries was enough to trigger the issue.

>
> > negative pgtables_bytes since it's accounting for not allocated entries=
 in the
> > current process. As far as I looked pgd_{alloc,free} etc. does not clea=
r entries,
> So should they clear entries or doing so would add to overall latency ?
>
> > and clearing of the entries is explicitly done in the free_pgtables->
> > free_pgd_range->free_p4d_range->free_pud_range->free_pmd_range->
> > free_pte_range path. However, the debug_vm_pgtable test does not call
> > free_pgtables, since it allocates mm_struct and entries manually for it=
s test
> > and eg. not goes through page faults. So it also should clear manually =
the
> > entries before exit at destroy_args().
>
> Makes sense.
>
> >
> > This problem was noticed on a reboot X number of times test being done
> > on a powerpc host, with a debug kernel with CONFIG_DEBUG_VM_PGTABLE
> > enabled. Depends on the system, but on a 100 times reboot loop the
> > problem could manifest once or twice, if a process ends up getting the
> > right mm->pgd entry with the stale entries used by mm/debug_vm_pagetabl=
e.
> > After using this patch, I couldn't reproduce/experience the problems
> > anymore. I was able to reproduce the problem as well on latest upstream
> > kernel (6.16).
>
> Seems like a very rare case i.e both to reproduce and also to confirm if =
this patch
> here has indeed solved the problem. Just wondering - did you try to repro=
duce this
> problem on any other platform than powerpc ?

I only tried and then reproduced on ppc, since all reports I saw was
reproducing on it, didn't saw reports on other architectures. I tested
the patch on ppc/x86/s390/arm64 with a bigger X times reboot loop test
(for the test, a 200 times reboot loop). From my understanding,
another process getting the same mm->pgd was the key, so if a process
got lucky enough it triggers the issue.

>
> >
> > I also modified destroy_args() to use mmput() instead of mmdrop(), ther=
e
> > is no reason to hold mm_users reference and not release the mm_struct
> > entirely, and in the output above with my debugging prints I already
> > had patched it to use mmput, it did not fix the problem, but helped
> > in the debugging as well.
>
> Makes sense.
>
> >
> > Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> > ---
> >  mm/debug_vm_pgtable.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index 7731b238b534..0f5ddefd128a 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -1041,29 +1041,34 @@ static void __init destroy_args(struct pgtable_=
debug_args *args)
> >
> >       /* Free page table entries */
> >       if (args->start_ptep) {
> > +             pmd_clear(args->pmdp);
> >               pte_free(args->mm, args->start_ptep);
> >               mm_dec_nr_ptes(args->mm);
> >       }
> >
> >       if (args->start_pmdp) {
> > +             pud_clear(args->pudp);
> >               pmd_free(args->mm, args->start_pmdp);
> >               mm_dec_nr_pmds(args->mm);
> >       }
> >
> >       if (args->start_pudp) {
> > +             p4d_clear(args->p4dp);
> >               pud_free(args->mm, args->start_pudp);
> >               mm_dec_nr_puds(args->mm);
> >       }
> >
> > -     if (args->start_p4dp)
> > +     if (args->start_p4dp) {
> > +             pgd_clear(args->pgdp);
> >               p4d_free(args->mm, args->start_p4dp);
> > +     }
> >
> >       /* Free vma and mm struct */
> >       if (args->vma)
> >               vm_area_free(args->vma);
> >
> >       if (args->mm)
> > -             mmdrop(args->mm);
> > +             mmput(args->mm);
> >  }
> >
> >  static struct page * __init
> A quick test on arm64 platform looked fine. It might be better to get thi=
s
> enabled and tested on multiple platforms via linux-next.
>


