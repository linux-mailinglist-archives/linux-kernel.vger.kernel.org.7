Return-Path: <linux-kernel+bounces-761346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72643B1F89C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821FA178B28
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9621E834B;
	Sun, 10 Aug 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JplzCGGf"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F884A32
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754807501; cv=none; b=E9AlOkx6HqXMdB7qJv+S5FsJqKoeJ5BXWCPuWH3o5Jk/yJdvipkIhdQkB4p13nRExFK9p+gcqfAqne3xEut4PBbuZvQpKSWkz5q/oUC5UeGa31f96J15H6rLL0UZ9mIXBV/ip6Y1d20zrYt/pTxGkGouBo/L76w0JyXS5bptQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754807501; c=relaxed/simple;
	bh=zT4QjLXYuviXzrrD2qxr/Aaj+dTCFKVPxeZBp2oOHd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZ/Y8U5Usx2gx3kUZtf7fU/C+77Ep4uwvo7jbJcQYtdyT8y2TBjr+1Z9B5q1AezI+21SxUmn+e36YNH53UE0PexZ8QU5DAvS0ZwOYsj81jVPzf4o2xfbLVoHp9DdyRDk9UqQRfIQ6koZ2u+jA8OLjCrKFPU6whaLAUeOru4HPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JplzCGGf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so4445a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754807494; x=1755412294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXi5ucQB+R4RXrYdM/FFE3o3KgvXJZDz39jZn9JOrRw=;
        b=JplzCGGfiPXXoyVFt2pVOFNr1VFumYQOgWI7XDqs6UGSQn4s2DVUI6nJcO5PSQQUfJ
         l0HcDUvbMG8n2eiJXvvdMf8nQURDazhWd6sQJB7xTowWPb9TUKXOzbZERmVTGLitm5fq
         g/tthmcq/2BT+rwYPi9T7UZYHnSMcLrLq3A4H062bHY6N0jh6B9XYgHJm8WKl1gsO1Vs
         w1LtpnQ8YLANYXQW+ol1H9MZwPboIktW9IJn8qQKikwu/kYQKoYQRBEk4N/N8fmu1Yi8
         5VY6ye5LrUaNptMutCPX9EYxH932vL1nY5IYn6JwJym0ZHh/5Y1hEtSqLXLdeKDHiKSP
         onBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754807494; x=1755412294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXi5ucQB+R4RXrYdM/FFE3o3KgvXJZDz39jZn9JOrRw=;
        b=N+oM90nzOsrspTAyBazq+r5ajzfMbLzOlBynEePS8G7R96NxBj4gmfo6PxQ387ALc/
         lJlmw0KH48NQVXkZgcASh6RgaHrfs6IzLDq0TeW6UNEddEDS7XZO4N6DGFB6sjfwZp5w
         QDg9mb+y63KEx2Ode8PT685X3SqQSgvz/ym2gReAGyOJG8J499TWECupoRSp0Lmub42u
         wYZ0XjMYXKvB+IbrT6kBrJmdutQ0ZZj9jYVNsTFfOVQyL9b29ZuUItLpdlgRilVc55Z0
         pFjDAVibguLtAOlCM+YV6D4b7K7lbSmcO30aQYsAnAPQubdBFFThHzMZqSgu4RtNZd88
         mAkw==
X-Forwarded-Encrypted: i=1; AJvYcCU5TcwWkNl5CymrfHj9CJB/I0509KdW7hwz2yzWKOzqUSlANnqE1GgQqQV4+n0TcbAUXsTNvhcidMEF3Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iOGs6JKPlYItgAjgtgJtnQ1HvW9FUXCpF7fQvIwAxv9UqVp5
	ZwqL2vakJqGYHTSX14GpXeVg8zajhB6j9F/xmbRqlcelK2SqGKtyDQQXoTMpYIeskf+C7GtPD0W
	MFhZmNVmUBLgXYYknRewlT0JHsItzPgu3fhuyLYMm
X-Gm-Gg: ASbGncu1GtZJk9vTngfB/GtjJ/0+qMmdNLWOpvo/+8bzCp9V2Y1ZsAAF/1tEfqz4fRc
	Q+spESSsPLg8DusxEWqTfPllyk2aDv9g91YWwqLuhivGGG/cFK35I4ysuUv1Q79VjF6vF/RNyKf
	EfcbpICY3gnTL+/gbJ7m/PTTtd0PTJpw5C2/UtvR0qKZYuSqMe+31jfKiPVbZjdgpVmkTKAPPnU
	ymptL+iKTfkFe4d17/1OfpNrlGQHQ6GVhr7YjF8TBqc2b2AUOMU
X-Google-Smtp-Source: AGHT+IFGC2cCebIbpoCTpzqZIFDhhtklzc2HSYV90zaHkP/thj1IoeN05dKyVtizFsMr1wyY7HZx8k+LLuPgy+ZGTq8=
X-Received: by 2002:a05:6402:52c9:b0:618:1799:5baa with SMTP id
 4fb4d7f45d1cf-61817995bc2mr21649a12.7.1754807493960; Sat, 09 Aug 2025
 23:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807103902.2242717-1-lokeshgidra@google.com>
 <aJT7qQzEs_p36yfI@x1.local> <CA+EESO64MOZaJHyY_mTy6Gqvaz=CkPLHgc-UZ1rg8FXcPyh0aA@mail.gmail.com>
In-Reply-To: <CA+EESO64MOZaJHyY_mTy6Gqvaz=CkPLHgc-UZ1rg8FXcPyh0aA@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sat, 9 Aug 2025 23:31:20 -0700
X-Gm-Features: Ac12FXwWIpWpRcdgTyU_Cxa9yDyWl24_SkIbmVCa98KMH3_AzRy7yCt8WGp4b7o
Message-ID: <CA+EESO6vm6Qs+ZiYFPyXXV6C981U10qo2V7P-OvkaJL2P_0Xvg@mail.gmail.com>
Subject: Re: [PATCH v3] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:29=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Thu, Aug 7, 2025 at 12:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > Hi, Lokesh,
> >
> > On Thu, Aug 07, 2025 at 03:39:02AM -0700, Lokesh Gidra wrote:
> > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is require=
d
> > > for moving present pages. Mitigate this cost by opportunistically
> > > batching present contiguous pages for TLB flushing.
> > >
> > > Without batching, in our testing on an arm64 Android device with UFFD=
 GC,
> > > which uses MOVE ioctl for compaction, we observed that out of the tot=
al
> > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), an=
d
> > > ~20% in vm_normal_folio().
> > >
> > > With batching, the proportion of vm_normal_folio() increases to over
> > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> >
> > Do you know why vm_normal_folio() could be expensive? I still see quite
> > some other things this path needs to do.
> >
> Let's discuss this in Andrew's reply thread.
>
> > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > includes TLB-flush overhead.
> >
> > Indeed this should already prove the optimization, I'm just curious whe=
ther
> > you've run some benchmark on the GC app to show the real world benefit.
> >
> I did! The same benchmark through which I gathered these numbers, when
> run on cuttlefish (qemu android instance on x86_64), the completion
> time of the benchmark went down from ~45mins to ~20mins. The benchmark
> is very GC intensive and the overhead of IPI on vCPUs seems to be
> enormous leading to this drastic improvement.
>
> In another instance, system_server, one of the most critical system
> processes on android, saw over 50% reduction in GC compaction time on
> an arm64 android device.
>
> > >
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > > Changes since v2 [1]
> > > - Addressed VM_WARN_ON failure, per Lorenzo Stoakes
> > > - Added check to ensure all batched pages share the same anon_vma
> > >
> > > Changes since v1 [2]
> > > - Removed flush_tlb_batched_pending(), per Barry Song
> > > - Unified single and multi page case, per Barry Song
> > >
> > > [1] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@=
google.com/
> > > [2] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@g=
oogle.com/
> > >
> > >  mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 128 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index cbed91b09640..78c732100aec 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t =
*dst_pte, pte_t *src_pte,
> > >              pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> > >  }
> > >
> > > -static int move_present_pte(struct mm_struct *mm,
> > > -                         struct vm_area_struct *dst_vma,
> > > -                         struct vm_area_struct *src_vma,
> > > -                         unsigned long dst_addr, unsigned long src_a=
ddr,
> > > -                         pte_t *dst_pte, pte_t *src_pte,
> > > -                         pte_t orig_dst_pte, pte_t orig_src_pte,
> > > -                         pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > -                         spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > -                         struct folio *src_folio)
> > > +/*
> > > + * Checks if the two ptes and the corresponding folio are eligible f=
or batched
> > > + * move. If so, then returns pointer to the folio, after locking it.=
 Otherwise,
> > > + * returns NULL.
> > > + */
> > > +static struct folio *check_ptes_for_batched_move(struct vm_area_stru=
ct *src_vma,
> > > +                                              unsigned long src_addr=
,
> > > +                                              pte_t *src_pte, pte_t =
*dst_pte,
> > > +                                              struct anon_vma *src_a=
non_vma)
> > > +{
> > > +     pte_t orig_dst_pte, orig_src_pte;
> > > +     struct folio *folio;
> > > +
> > > +     orig_dst_pte =3D ptep_get(dst_pte);
> > > +     if (!pte_none(orig_dst_pte))
> > > +             return NULL;
> > > +
> > > +     orig_src_pte =3D ptep_get(src_pte);
> > > +     if (pte_none(orig_src_pte) || !pte_present(orig_src_pte) ||
> >
> > pte_none() check could be removed - the pte_present() check should make
> > sure it's !none.
> >
> Makes sense. I'll make the change in the next version of the patch.
>
> > > +         is_zero_pfn(pte_pfn(orig_src_pte)))
> > > +             return NULL;
> > > +
> > > +     folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > > +     if (!folio || !folio_trylock(folio))
> > > +             return NULL;
> >
> > So here we don't take a refcount anymore, while the 1st folio that got
> > passed in will still has the refcount boosted.  IMHO it would still be
> > better to keep the behavior the same on the 1st and continuous folios..
> >
> > Or if this is intentional, maybe worth some comment.  More below on thi=
s..
> >
> This is indeed intentional, and I'll add a comment in the next
> version. But let me explain:
>
> The first folio needed the refcount as we need to pin the page before
> releasing the src ptl. Also, because split_folio(), if called, expects
> the caller to hold the lock as well as reference on the folio.
>
> The subsequent folios in the batch are always within the ptl critical
> section and neither the splits are required. Therefore, I didn't want
> to unnecessarily increase the work done within the critical section.
> But, please correct me if I'm misunderstanding something.
>
> > > +     if (!PageAnonExclusive(&folio->page) || folio_test_large(folio)=
 ||
> > > +         folio_anon_vma(folio) !=3D src_anon_vma) {
> > > +             folio_unlock(folio);
> > > +             return NULL;
> > > +     }
> > > +     return folio;
> > > +}
> > > +
> > > +static long move_present_ptes(struct mm_struct *mm,
> > > +                           struct vm_area_struct *dst_vma,
> > > +                           struct vm_area_struct *src_vma,
> > > +                           unsigned long dst_addr, unsigned long src=
_addr,
> > > +                           pte_t *dst_pte, pte_t *src_pte,
> > > +                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > > +                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > +                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > +                           struct folio *src_folio, unsigned long le=
n,
> > > +                           struct anon_vma *src_anon_vma)
> >
> > (Not an immediate concern, but this function has potential to win the
> >  max-num-of-parameters kernel function.. :)
>
> I noticed the same when I made the change :) Maybe in a subsequent
> patch if we inline is_pte_pages_stable() and PTL acquire/release in
> move_pages_ptes(), then quite a few parameters can be reduced. But
> then, IMO, even move_pages_ptes() refactoring is required as well.
> >
> > >  {
> > >       int err =3D 0;
> > > +     unsigned long src_start =3D src_addr;
> > > +     unsigned long addr_end;
> > >
> > > +     if (len > PAGE_SIZE) {
> > > +             addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > > +             if (dst_addr + len > addr_end)
> > > +                     len =3D addr_end - dst_addr;
> >
> > Use something like ALIGN() and MIN()?
>
> Will do in the next version.
> >
> > > +
> > > +             addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > > +             if (src_addr + len > addr_end)
> > > +                     len =3D addr_end - src_addr;
> >
> > Same here.
> >
> Will do.
>
> > > +     }
> > > +     flush_cache_range(src_vma, src_addr, src_addr + len);
> > >       double_pt_lock(dst_ptl, src_ptl);
> > >
> > >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > > @@ -1051,31 +1097,54 @@ static int move_present_pte(struct mm_struct =
*mm,
> > >               err =3D -EBUSY;
> > >               goto out;
> > >       }
> > > +     arch_enter_lazy_mmu_mode();
> > > +
> > > +     addr_end =3D src_start + len;
> > > +     while (true) {
> > > +             orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_p=
te);
> > > +             /* Folio got pinned from under us. Put it back and fail=
 the move. */
> > > +             if (folio_maybe_dma_pinned(src_folio)) {
> > > +                     set_pte_at(mm, src_addr, src_pte, orig_src_pte)=
;
> > > +                     err =3D -EBUSY;
> > > +                     break;
> > > +             }
> > >
> > > -     orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> > > -     /* Folio got pinned from under us. Put it back and fail the mov=
e. */
> > > -     if (folio_maybe_dma_pinned(src_folio)) {
> > > -             set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> > > -             err =3D -EBUSY;
> > > -             goto out;
> > > -     }
> > > -
> > > -     folio_move_anon_rmap(src_folio, dst_vma);
> > > -     src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > > +             folio_move_anon_rmap(src_folio, dst_vma);
> > > +             src_folio->index =3D linear_page_index(dst_vma, dst_add=
r);
> > >
> > > -     orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_prot)=
;
> > > -     /* Set soft dirty bit so userspace can notice the pte was moved=
 */
> > > +             orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_pa=
ge_prot);
> > > +             /* Set soft dirty bit so userspace can notice the pte w=
as moved */
> > >  #ifdef CONFIG_MEM_SOFT_DIRTY
> > > -     orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > > +             orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > >  #endif
> > > -     if (pte_dirty(orig_src_pte))
> > > -             orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > > -     orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > > +             if (pte_dirty(orig_src_pte))
> > > +                     orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > > +             orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > > +             set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > > +
> > > +             src_addr +=3D PAGE_SIZE;
> > > +             if (src_addr =3D=3D addr_end)
> > > +                     break;
> > > +             src_pte++;
> > > +             dst_pte++;
> > > +
> > > +             folio_unlock(src_folio);
> > > +             src_folio =3D check_ptes_for_batched_move(src_vma, src_=
addr, src_pte,
> > > +                                                     dst_pte, src_an=
on_vma);
> > > +             if (!src_folio)
> > > +                     break;
> > > +             dst_addr +=3D PAGE_SIZE;
> > > +     }
> > > +
> > > +     arch_leave_lazy_mmu_mode();
> > > +     if (src_addr > src_start)
> > > +             flush_tlb_range(src_vma, src_start, src_addr);
> > >
> > > -     set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > >  out:
> > >       double_pt_unlock(dst_ptl, src_ptl);
> > > -     return err;
> > > +     if (src_folio)
> > > +             folio_unlock(src_folio);
> > > +     return src_addr > src_start ? src_addr - src_start : err;
> > >  }
> > >
> > >  static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct=
 *dst_vma,
> > > @@ -1140,7 +1209,7 @@ static int move_swap_pte(struct mm_struct *mm, =
struct vm_area_struct *dst_vma,
> > >       set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> > >       double_pt_unlock(dst_ptl, src_ptl);
> > >
> > > -     return 0;
> > > +     return PAGE_SIZE;
> > >  }
> > >
> > >  static int move_zeropage_pte(struct mm_struct *mm,
> > > @@ -1154,6 +1223,7 @@ static int move_zeropage_pte(struct mm_struct *=
mm,
> > >  {
> > >       pte_t zero_pte;
> > >
> > > +     flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
> >
> > If it's a zero page hence not writtable, do we still need to flush cach=
e at
> > all?  Looks harmless, but looks like not needed either.
> >
> I just realized when reading your comment that it is indeed not
> required. There is no cacheline to be flushed for the zero-page :)
>
> > >       double_pt_lock(dst_ptl, src_ptl);
> > >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > >                                dst_pmd, dst_pmdval)) {
> > > @@ -1167,20 +1237,19 @@ static int move_zeropage_pte(struct mm_struct=
 *mm,
> > >       set_pte_at(mm, dst_addr, dst_pte, zero_pte);
> > >       double_pt_unlock(dst_ptl, src_ptl);
> > >
> > > -     return 0;
> > > +     return PAGE_SIZE;
> > >  }
> > >
> > >
> > >  /*
> > > - * The mmap_lock for reading is held by the caller. Just move the pa=
ge
> > > - * from src_pmd to dst_pmd if possible, and return true if succeeded
> > > - * in moving the page.
> > > + * The mmap_lock for reading is held by the caller. Just move the pa=
ge(s)
> > > + * from src_pmd to dst_pmd if possible, and return number of bytes m=
oved.
> > >   */
> > > -static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_=
t *src_pmd,
> > > -                       struct vm_area_struct *dst_vma,
> > > -                       struct vm_area_struct *src_vma,
> > > -                       unsigned long dst_addr, unsigned long src_add=
r,
> > > -                       __u64 mode)
> > > +static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pm=
d_t *src_pmd,
> > > +                         struct vm_area_struct *dst_vma,
> > > +                         struct vm_area_struct *src_vma,
> > > +                         unsigned long dst_addr, unsigned long src_a=
ddr,
> > > +                         unsigned long len, __u64 mode)
> > >  {
> > >       swp_entry_t entry;
> > >       struct swap_info_struct *si =3D NULL;
> > > @@ -1196,9 +1265,8 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> > >       struct mmu_notifier_range range;
> > >       int err =3D 0;
> > >
> > > -     flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
> > >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> > > -                             src_addr, src_addr + PAGE_SIZE);
> > > +                             src_addr, src_addr + len);
> > >       mmu_notifier_invalidate_range_start(&range);
> > >  retry:
> > >       /*
> > > @@ -1257,7 +1325,7 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> > >               if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> > >                       err =3D -ENOENT;
> > >               else /* nothing to do to move a hole */
> > > -                     err =3D 0;
> > > +                     err =3D PAGE_SIZE;
> > >               goto out;
> > >       }
> > >
> > > @@ -1375,10 +1443,14 @@ static int move_pages_pte(struct mm_struct *m=
m, pmd_t *dst_pmd, pmd_t *src_pmd,
> > >                       }
> > >               }
> > >
> > > -             err =3D move_present_pte(mm,  dst_vma, src_vma,
> > > -                                    dst_addr, src_addr, dst_pte, src=
_pte,
> > > -                                    orig_dst_pte, orig_src_pte, dst_=
pmd,
> > > -                                    dst_pmdval, dst_ptl, src_ptl, sr=
c_folio);
> > > +             err =3D move_present_ptes(mm, dst_vma, src_vma,
> > > +                                     dst_addr, src_addr, dst_pte, sr=
c_pte,
> > > +                                     orig_dst_pte, orig_src_pte, dst=
_pmd,
> > > +                                     dst_pmdval, dst_ptl, src_ptl, s=
rc_folio,
> > > +                                     len, src_anon_vma);
> > > +             /* folio is already unlocked by move_present_ptes() */
> > > +             folio_put(src_folio);
> > > +             src_folio =3D NULL;
> >
> > So the function above now can move multiple folios but keep holding the
> > 1st's refcount..  This still smells error prone, sooner or later.
> >
> > Would it be slightly better if we take a folio pointer in
> > move_present_ptes(), and releae everything there (including reset the
> > pointer)?
> >
> Yeah this seems cleaner. I'll do so in the next version.
>
Uploaded v4 addressing all the comments here:
https://lore.kernel.org/all/20250810062912.1096815-1-lokeshgidra@google.com=
/

Thanks.
> > Thanks,
> >
> > >       } else {
> > >               struct folio *folio =3D NULL;
> > >
> > > @@ -1732,7 +1804,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> > >  {
> > >       struct mm_struct *mm =3D ctx->mm;
> > >       struct vm_area_struct *src_vma, *dst_vma;
> > > -     unsigned long src_addr, dst_addr;
> > > +     unsigned long src_addr, dst_addr, src_end;
> > >       pmd_t *src_pmd, *dst_pmd;
> > >       long err =3D -EINVAL;
> > >       ssize_t moved =3D 0;
> > > @@ -1775,8 +1847,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> > >       if (err)
> > >               goto out_unlock;
> > >
> > > -     for (src_addr =3D src_start, dst_addr =3D dst_start;
> > > -          src_addr < src_start + len;) {
> > > +     for (src_addr =3D src_start, dst_addr =3D dst_start, src_end =
=3D src_start + len;
> > > +          src_addr < src_end;) {
> > >               spinlock_t *ptl;
> > >               pmd_t dst_pmdval;
> > >               unsigned long step_size;
> > > @@ -1841,6 +1913,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> > >                                                 dst_addr, src_addr);
> > >                       step_size =3D HPAGE_PMD_SIZE;
> > >               } else {
> > > +                     long ret;
> > > +
> > >                       if (pmd_none(*src_pmd)) {
> > >                               if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC=
_HOLES)) {
> > >                                       err =3D -ENOENT;
> > > @@ -1857,10 +1931,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, unsigned long dst_start,
> > >                               break;
> > >                       }
> > >
> > > -                     err =3D move_pages_pte(mm, dst_pmd, src_pmd,
> > > -                                          dst_vma, src_vma,
> > > -                                          dst_addr, src_addr, mode);
> > > -                     step_size =3D PAGE_SIZE;
> > > +                     ret =3D move_pages_ptes(mm, dst_pmd, src_pmd,
> > > +                                           dst_vma, src_vma, dst_add=
r,
> > > +                                           src_addr, src_end - src_a=
ddr, mode);
> > > +                     if (ret > 0)
> > > +                             step_size =3D ret;
> > > +                     else
> > > +                             err =3D ret;
> > >               }
> > >
> > >               cond_resched();
> > >
> > > base-commit: 6e64f4580381e32c06ee146ca807c555b8f73e24
> > > --
> > > 2.50.1.565.gc32cd1483b-goog
> > >
> >
> > --
> > Peter Xu
> >

