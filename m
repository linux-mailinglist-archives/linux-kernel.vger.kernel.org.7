Return-Path: <linux-kernel+bounces-760568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256EB1ED06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC7C16CAB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAA28727B;
	Fri,  8 Aug 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1S9Y9lN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CD26D4CE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670617; cv=none; b=hfE+dcWq+G0slOFsYfL+82/8v40vkAeTTMAfS4aXIR4nd2TZxaFDMLb86T1ptgPTBNqOGFeDLW/EPCd9FEWvUjq5Uq0rA3lhxMPEUKnoBTghoBEzMyf4LTogcCBRlgcWkiAExnLhGsHzVR/w784pBOt3rqdvn1sJ8YJuFaoirw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670617; c=relaxed/simple;
	bh=xcnKbLMGfwl3/KluqTGwWrXMPYzrvL0O+Af2VbCk7hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5fG17oWD2WEqvFLRECY6cxE3DYSmry6MsKJxxe3uuROk45aMoK6cf70B3VcMtnU8/t7W1Pqs5MXNRbUZjIkdEwHr1E//KaMM82PRWKsg5adqO5J83kKkjvslf3i1y4Mx3csBBEpZtoGPnWdwHcKRJk8BydRiiI6RgTn9457D6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1S9Y9lN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso64a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754670613; x=1755275413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWV9QwkXPZK1Qghst1uCIV4QuYfeCzvomcNngf/dKhQ=;
        b=G1S9Y9lN6m960/mr3IURAJ8NB6MysmJROeeut3UXYqtya7uTMaUS/Gcbs02sNVPHuZ
         jvDhvkAv35J+lWhkcZ8gguF9PFL3Xl+SnKM5m2jhyowrjGEheH9FvrGUy5Y3XhQAAmfp
         vIkpTwrLlUYYWA8PN+Jb5ETJ+r/6rBMB2O20DMcrzbAH7CgwEcWR/c4HPkw3rXJvrdF4
         0O4ZQ3euEmKGOf3O/X6ikP3+WJLlYs30Ho+C2hZ8vRi08ZuE/sDmOTDIhl0Ad+xPh2xi
         EmHEbwT/e1VAc2ceNIYXhFlwLuzIjrziYaqMxjuR8+Atpkecsss8MpnRunwAX0DAuXLg
         PSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670613; x=1755275413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWV9QwkXPZK1Qghst1uCIV4QuYfeCzvomcNngf/dKhQ=;
        b=NDc9I51vhg8h2IjAIxG34mBjIgbp/eoZNYb78oc9nNQRLMeQPnxQ3Dsnjyiuizm2b1
         0hxT+Jzb8av6X1KSRZLbBNcUcxH0gnx7aVgfE/llo2wen/ldmJ1z5DeLsgt9TTGp3Pju
         +h4gbgvIv9V/3mhDNXwLV/OjHsl0IDcR3fyA4JRijN79De/b0e0J+Xa4Xr/f6FBWEH94
         SFFBr3IP+VxJ3s9iKmSMWjPDOEUbk3g7PRgfxlvYPb+R3AT4PKHk27rMhyCidevRv02l
         24sH8TjCNITPWpY4C6S4lWl71WW94a2r6rzDmJiEv6FY+k9Z1zV9gEjuYEpEp1xEgYqO
         YqUg==
X-Forwarded-Encrypted: i=1; AJvYcCU1+aI8C96pCtDZOLKCzJTqlK8HSDGdAIdQhTI04lNmrbGZVNk0HZpOG/vHQaOi71uDawYnWlES1egNBLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDF16bQVnhmLJAMLnopB02L8mbGIynJlTkBf8TTnsFUUMTeDWR
	RGEgPSoE1rrPGRuUOMVjiPw9HrVQ5sUW1G2dAgN0hU99vLa0KneDrXnFjbLltaCV8TRcuxRTn2s
	wFwZH9Gao7VXp7/rSSUpDOyt3s+wf1c8cYmNj4xuS
X-Gm-Gg: ASbGncuW1i6Od1fYEqjOLBVgD5Hdabgomqc3ASR4n/F2ssav39SMXN0a6T7Jr0xrfgD
	SuB/9vP8yeJtEVogTKrE/muWe3EZgcM1KICb5YwepdMvCEMbFJ95k3pvH6fbzJiF7J/7OO2rnQc
	HcyBhvm+P90Y+laLsLrBTeOn2kIKv++t1f/v6CxQeMl6dJg+zemcE0DfZxb7Gp6zsS4x0DgpuOp
	orUWcp3uDvbvmoN8eLQvi/cipc7aqS79MZzXFp5Mg==
X-Google-Smtp-Source: AGHT+IHdaRzqv6KSEiv7U1HgWpOv1AKdGvvGjyCHn8b0cDtVtz+uvaVh4JfUcQLJcE6lfwfpxVea51BO8uxympmKKog=
X-Received: by 2002:a05:6402:454c:b0:615:8f13:631c with SMTP id
 4fb4d7f45d1cf-617f97cd75dmr21044a12.6.1754670612646; Fri, 08 Aug 2025
 09:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807103902.2242717-1-lokeshgidra@google.com> <aJT7qQzEs_p36yfI@x1.local>
In-Reply-To: <aJT7qQzEs_p36yfI@x1.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 8 Aug 2025 09:29:58 -0700
X-Gm-Features: Ac12FXzqRi15F68wnnO-I1R5kEwpb0zFIawNui9NvknJboGfTBscByADew0UZGU
Message-ID: <CA+EESO64MOZaJHyY_mTy6Gqvaz=CkPLHgc-UZ1rg8FXcPyh0aA@mail.gmail.com>
Subject: Re: [PATCH v3] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 12:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Lokesh,
>
> On Thu, Aug 07, 2025 at 03:39:02AM -0700, Lokesh Gidra wrote:
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
>
> Do you know why vm_normal_folio() could be expensive? I still see quite
> some other things this path needs to do.
>
Let's discuss this in Andrew's reply thread.

> > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > includes TLB-flush overhead.
>
> Indeed this should already prove the optimization, I'm just curious wheth=
er
> you've run some benchmark on the GC app to show the real world benefit.
>
I did! The same benchmark through which I gathered these numbers, when
run on cuttlefish (qemu android instance on x86_64), the completion
time of the benchmark went down from ~45mins to ~20mins. The benchmark
is very GC intensive and the overhead of IPI on vCPUs seems to be
enormous leading to this drastic improvement.

In another instance, system_server, one of the most critical system
processes on android, saw over 50% reduction in GC compaction time on
an arm64 android device.

> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> > Changes since v2 [1]
> > - Addressed VM_WARN_ON failure, per Lorenzo Stoakes
> > - Added check to ensure all batched pages share the same anon_vma
> >
> > Changes since v1 [2]
> > - Removed flush_tlb_batched_pending(), per Barry Song
> > - Unified single and multi page case, per Barry Song
> >
> > [1] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@go=
ogle.com/
> > [2] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@goo=
gle.com/
> >
> >  mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 128 insertions(+), 51 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..78c732100aec 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t *d=
st_pte, pte_t *src_pte,
> >              pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> >  }
> >
> > -static int move_present_pte(struct mm_struct *mm,
> > -                         struct vm_area_struct *dst_vma,
> > -                         struct vm_area_struct *src_vma,
> > -                         unsigned long dst_addr, unsigned long src_add=
r,
> > -                         pte_t *dst_pte, pte_t *src_pte,
> > -                         pte_t orig_dst_pte, pte_t orig_src_pte,
> > -                         pmd_t *dst_pmd, pmd_t dst_pmdval,
> > -                         spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                         struct folio *src_folio)
> > +/*
> > + * Checks if the two ptes and the corresponding folio are eligible for=
 batched
> > + * move. If so, then returns pointer to the folio, after locking it. O=
therwise,
> > + * returns NULL.
> > + */
> > +static struct folio *check_ptes_for_batched_move(struct vm_area_struct=
 *src_vma,
> > +                                              unsigned long src_addr,
> > +                                              pte_t *src_pte, pte_t *d=
st_pte,
> > +                                              struct anon_vma *src_ano=
n_vma)
> > +{
> > +     pte_t orig_dst_pte, orig_src_pte;
> > +     struct folio *folio;
> > +
> > +     orig_dst_pte =3D ptep_get(dst_pte);
> > +     if (!pte_none(orig_dst_pte))
> > +             return NULL;
> > +
> > +     orig_src_pte =3D ptep_get(src_pte);
> > +     if (pte_none(orig_src_pte) || !pte_present(orig_src_pte) ||
>
> pte_none() check could be removed - the pte_present() check should make
> sure it's !none.
>
Makes sense. I'll make the change in the next version of the patch.

> > +         is_zero_pfn(pte_pfn(orig_src_pte)))
> > +             return NULL;
> > +
> > +     folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > +     if (!folio || !folio_trylock(folio))
> > +             return NULL;
>
> So here we don't take a refcount anymore, while the 1st folio that got
> passed in will still has the refcount boosted.  IMHO it would still be
> better to keep the behavior the same on the 1st and continuous folios..
>
> Or if this is intentional, maybe worth some comment.  More below on this.=
.
>
This is indeed intentional, and I'll add a comment in the next
version. But let me explain:

The first folio needed the refcount as we need to pin the page before
releasing the src ptl. Also, because split_folio(), if called, expects
the caller to hold the lock as well as reference on the folio.

The subsequent folios in the batch are always within the ptl critical
section and neither the splits are required. Therefore, I didn't want
to unnecessarily increase the work done within the critical section.
But, please correct me if I'm misunderstanding something.

> > +     if (!PageAnonExclusive(&folio->page) || folio_test_large(folio) |=
|
> > +         folio_anon_vma(folio) !=3D src_anon_vma) {
> > +             folio_unlock(folio);
> > +             return NULL;
> > +     }
> > +     return folio;
> > +}
> > +
> > +static long move_present_ptes(struct mm_struct *mm,
> > +                           struct vm_area_struct *dst_vma,
> > +                           struct vm_area_struct *src_vma,
> > +                           unsigned long dst_addr, unsigned long src_a=
ddr,
> > +                           pte_t *dst_pte, pte_t *src_pte,
> > +                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > +                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                           struct folio *src_folio, unsigned long len,
> > +                           struct anon_vma *src_anon_vma)
>
> (Not an immediate concern, but this function has potential to win the
>  max-num-of-parameters kernel function.. :)

I noticed the same when I made the change :) Maybe in a subsequent
patch if we inline is_pte_pages_stable() and PTL acquire/release in
move_pages_ptes(), then quite a few parameters can be reduced. But
then, IMO, even move_pages_ptes() refactoring is required as well.
>
> >  {
> >       int err =3D 0;
> > +     unsigned long src_start =3D src_addr;
> > +     unsigned long addr_end;
> >
> > +     if (len > PAGE_SIZE) {
> > +             addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > +             if (dst_addr + len > addr_end)
> > +                     len =3D addr_end - dst_addr;
>
> Use something like ALIGN() and MIN()?

Will do in the next version.
>
> > +
> > +             addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > +             if (src_addr + len > addr_end)
> > +                     len =3D addr_end - src_addr;
>
> Same here.
>
Will do.

> > +     }
> > +     flush_cache_range(src_vma, src_addr, src_addr + len);
> >       double_pt_lock(dst_ptl, src_ptl);
> >
> >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> > @@ -1051,31 +1097,54 @@ static int move_present_pte(struct mm_struct *m=
m,
> >               err =3D -EBUSY;
> >               goto out;
> >       }
> > +     arch_enter_lazy_mmu_mode();
> > +
> > +     addr_end =3D src_start + len;
> > +     while (true) {
> > +             orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte=
);
> > +             /* Folio got pinned from under us. Put it back and fail t=
he move. */
> > +             if (folio_maybe_dma_pinned(src_folio)) {
> > +                     set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> > +                     err =3D -EBUSY;
> > +                     break;
> > +             }
> >
> > -     orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> > -     /* Folio got pinned from under us. Put it back and fail the move.=
 */
> > -     if (folio_maybe_dma_pinned(src_folio)) {
> > -             set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> > -             err =3D -EBUSY;
> > -             goto out;
> > -     }
> > -
> > -     folio_move_anon_rmap(src_folio, dst_vma);
> > -     src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > +             folio_move_anon_rmap(src_folio, dst_vma);
> > +             src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> >
> > -     orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_prot);
> > -     /* Set soft dirty bit so userspace can notice the pte was moved *=
/
> > +             orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page=
_prot);
> > +             /* Set soft dirty bit so userspace can notice the pte was=
 moved */
> >  #ifdef CONFIG_MEM_SOFT_DIRTY
> > -     orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > +             orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> >  #endif
> > -     if (pte_dirty(orig_src_pte))
> > -             orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > -     orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > +             if (pte_dirty(orig_src_pte))
> > +                     orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > +             orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > +             set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > +
> > +             src_addr +=3D PAGE_SIZE;
> > +             if (src_addr =3D=3D addr_end)
> > +                     break;
> > +             src_pte++;
> > +             dst_pte++;
> > +
> > +             folio_unlock(src_folio);
> > +             src_folio =3D check_ptes_for_batched_move(src_vma, src_ad=
dr, src_pte,
> > +                                                     dst_pte, src_anon=
_vma);
> > +             if (!src_folio)
> > +                     break;
> > +             dst_addr +=3D PAGE_SIZE;
> > +     }
> > +
> > +     arch_leave_lazy_mmu_mode();
> > +     if (src_addr > src_start)
> > +             flush_tlb_range(src_vma, src_start, src_addr);
> >
> > -     set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> >  out:
> >       double_pt_unlock(dst_ptl, src_ptl);
> > -     return err;
> > +     if (src_folio)
> > +             folio_unlock(src_folio);
> > +     return src_addr > src_start ? src_addr - src_start : err;
> >  }
> >
> >  static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *=
dst_vma,
> > @@ -1140,7 +1209,7 @@ static int move_swap_pte(struct mm_struct *mm, st=
ruct vm_area_struct *dst_vma,
> >       set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> >       double_pt_unlock(dst_ptl, src_ptl);
> >
> > -     return 0;
> > +     return PAGE_SIZE;
> >  }
> >
> >  static int move_zeropage_pte(struct mm_struct *mm,
> > @@ -1154,6 +1223,7 @@ static int move_zeropage_pte(struct mm_struct *mm=
,
> >  {
> >       pte_t zero_pte;
> >
> > +     flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
>
> If it's a zero page hence not writtable, do we still need to flush cache =
at
> all?  Looks harmless, but looks like not needed either.
>
I just realized when reading your comment that it is indeed not
required. There is no cacheline to be flushed for the zero-page :)

> >       double_pt_lock(dst_ptl, src_ptl);
> >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> >                                dst_pmd, dst_pmdval)) {
> > @@ -1167,20 +1237,19 @@ static int move_zeropage_pte(struct mm_struct *=
mm,
> >       set_pte_at(mm, dst_addr, dst_pte, zero_pte);
> >       double_pt_unlock(dst_ptl, src_ptl);
> >
> > -     return 0;
> > +     return PAGE_SIZE;
> >  }
> >
> >
> >  /*
> > - * The mmap_lock for reading is held by the caller. Just move the page
> > - * from src_pmd to dst_pmd if possible, and return true if succeeded
> > - * in moving the page.
> > + * The mmap_lock for reading is held by the caller. Just move the page=
(s)
> > + * from src_pmd to dst_pmd if possible, and return number of bytes mov=
ed.
> >   */
> > -static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t =
*src_pmd,
> > -                       struct vm_area_struct *dst_vma,
> > -                       struct vm_area_struct *src_vma,
> > -                       unsigned long dst_addr, unsigned long src_addr,
> > -                       __u64 mode)
> > +static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_=
t *src_pmd,
> > +                         struct vm_area_struct *dst_vma,
> > +                         struct vm_area_struct *src_vma,
> > +                         unsigned long dst_addr, unsigned long src_add=
r,
> > +                         unsigned long len, __u64 mode)
> >  {
> >       swp_entry_t entry;
> >       struct swap_info_struct *si =3D NULL;
> > @@ -1196,9 +1265,8 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >       struct mmu_notifier_range range;
> >       int err =3D 0;
> >
> > -     flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> > -                             src_addr, src_addr + PAGE_SIZE);
> > +                             src_addr, src_addr + len);
> >       mmu_notifier_invalidate_range_start(&range);
> >  retry:
> >       /*
> > @@ -1257,7 +1325,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >               if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> >                       err =3D -ENOENT;
> >               else /* nothing to do to move a hole */
> > -                     err =3D 0;
> > +                     err =3D PAGE_SIZE;
> >               goto out;
> >       }
> >
> > @@ -1375,10 +1443,14 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> >                       }
> >               }
> >
> > -             err =3D move_present_pte(mm,  dst_vma, src_vma,
> > -                                    dst_addr, src_addr, dst_pte, src_p=
te,
> > -                                    orig_dst_pte, orig_src_pte, dst_pm=
d,
> > -                                    dst_pmdval, dst_ptl, src_ptl, src_=
folio);
> > +             err =3D move_present_ptes(mm, dst_vma, src_vma,
> > +                                     dst_addr, src_addr, dst_pte, src_=
pte,
> > +                                     orig_dst_pte, orig_src_pte, dst_p=
md,
> > +                                     dst_pmdval, dst_ptl, src_ptl, src=
_folio,
> > +                                     len, src_anon_vma);
> > +             /* folio is already unlocked by move_present_ptes() */
> > +             folio_put(src_folio);
> > +             src_folio =3D NULL;
>
> So the function above now can move multiple folios but keep holding the
> 1st's refcount..  This still smells error prone, sooner or later.
>
> Would it be slightly better if we take a folio pointer in
> move_present_ptes(), and releae everything there (including reset the
> pointer)?
>
Yeah this seems cleaner. I'll do so in the next version.

> Thanks,
>
> >       } else {
> >               struct folio *folio =3D NULL;
> >
> > @@ -1732,7 +1804,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
> >  {
> >       struct mm_struct *mm =3D ctx->mm;
> >       struct vm_area_struct *src_vma, *dst_vma;
> > -     unsigned long src_addr, dst_addr;
> > +     unsigned long src_addr, dst_addr, src_end;
> >       pmd_t *src_pmd, *dst_pmd;
> >       long err =3D -EINVAL;
> >       ssize_t moved =3D 0;
> > @@ -1775,8 +1847,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
> >       if (err)
> >               goto out_unlock;
> >
> > -     for (src_addr =3D src_start, dst_addr =3D dst_start;
> > -          src_addr < src_start + len;) {
> > +     for (src_addr =3D src_start, dst_addr =3D dst_start, src_end =3D =
src_start + len;
> > +          src_addr < src_end;) {
> >               spinlock_t *ptl;
> >               pmd_t dst_pmdval;
> >               unsigned long step_size;
> > @@ -1841,6 +1913,8 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
> >                                                 dst_addr, src_addr);
> >                       step_size =3D HPAGE_PMD_SIZE;
> >               } else {
> > +                     long ret;
> > +
> >                       if (pmd_none(*src_pmd)) {
> >                               if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
> >                                       err =3D -ENOENT;
> > @@ -1857,10 +1931,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >                               break;
> >                       }
> >
> > -                     err =3D move_pages_pte(mm, dst_pmd, src_pmd,
> > -                                          dst_vma, src_vma,
> > -                                          dst_addr, src_addr, mode);
> > -                     step_size =3D PAGE_SIZE;
> > +                     ret =3D move_pages_ptes(mm, dst_pmd, src_pmd,
> > +                                           dst_vma, src_vma, dst_addr,
> > +                                           src_addr, src_end - src_add=
r, mode);
> > +                     if (ret > 0)
> > +                             step_size =3D ret;
> > +                     else
> > +                             err =3D ret;
> >               }
> >
> >               cond_resched();
> >
> > base-commit: 6e64f4580381e32c06ee146ca807c555b8f73e24
> > --
> > 2.50.1.565.gc32cd1483b-goog
> >
>
> --
> Peter Xu
>

