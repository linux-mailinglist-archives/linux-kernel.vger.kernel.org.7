Return-Path: <linux-kernel+bounces-756249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B328B1B1D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4413BC447
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0B2580F1;
	Tue,  5 Aug 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya91Pxuu"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB326A0A6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389285; cv=none; b=AhJ9NJwPlDVjGmd9RsSlhk8T6qGGg+l/b8Zuu5vbpINtD23faCUrMtTcpl+3+Iggb+0WA4mdtoz/rPnGhFn3PSj2KUtYKAphZhusK0yaCSk+8tqLAG4IjTpYTLQnl5wiXcSM6brEz+Hxqjs6fj9nWii8aVm264fTj0FVXQiooag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389285; c=relaxed/simple;
	bh=SKsecL5+kgsTLvngjCuiHTZ4KUssDK3u/31CxJg18LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWvLK8g/+9w3Zx1xATbA+i0/pBAcWqj4uoDv07/Vrn4GERo/qmFZAIbtRR3wBUxdFWNG3dDr1qnH8rYv+41Gru8GT9bGe0FUJk0npLRBy8uosNm4OJqrWTerHbf3RaGiDU8Nt61Ev3m+8d48/uHTSKOM05qKgyR8Rn+Wh5Uf49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya91Pxuu; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-500006b3efdso1664007137.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754389279; x=1754994079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KINrld3kBoM9uGnKfXQjYnfgm20s8mcD75wPbUpT8k0=;
        b=Ya91PxuusBkMStqb0ED7SRVlGaWkYa7Qm4M+/OIu5zo1vTdfCWMgccgToOGlO3wlKz
         sMk/jmN/xRNqg3TsZ2fb/EPDWhaOJ1R3XaUuitUrKkzjXY1culPJAoY1xfr+awTalSfZ
         81BSrYdnaO6CJAbsg7pm1NNxITEcdA70Pbsac8jiTjn6A5jReb21pF4E2dxX+qAoGg0m
         kTHfGulopjBwGpSIui/jM6QwJFKCewjNj+B7Q73NRQOdG4ICn+u26Yx+i+okBFtC1UvL
         DAA5quRlceLQYQ+IC0oODnXGHkrL5FM2Yf7QIXSNAbUcVxNTSHrrD7scsEcrDHCe1/ZL
         RkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389279; x=1754994079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KINrld3kBoM9uGnKfXQjYnfgm20s8mcD75wPbUpT8k0=;
        b=IqKpN9gM/w716ArMbUhju4jevXwuJurfQPjfo8l7W5G9Z8Se9I++aDN5fiiIkzE0Pc
         /fsexEuLnlYFzIkxtWLVvARBR8ZAI+hD5REOIQwK1/YYnsXatjctSdLradUjYO9Ll2pf
         PCQi9wGlOBDnYkIAuYbl2hLHHbhfx3etT1rKTbtEgNTqd3D9H9GJR3ERzEBP+W/8i3/T
         AE2M1XDbp962QJj5NX1Qrb6WhRwOGHR8pGDxNydhaoLA/c8jYwlGX1UtZx37Ugs2OBwp
         vKMzg0qfGK7LuovIWBw9UrvgCKseKOkEcdsI/mXV2wZ6H6SDmJbyaSRkzbPG4fOE/5Px
         2KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWINy+CRB0tViNlJyUETMEm6GEoT1MLkDB+W1Wv0ACyB5LOup4SHgsYDg/AFsm5XfcT+JwESn/C32AJ4wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3emiXh1IqalEzcXls2OKZxFyhNQakjszC7kjkrwWfC1Ydo9/
	OVlDh2U/3/mu07fKTIN3QiUhlOH67lUOIkMUghN9TNBRkgdhVxGf4Xh2WfRR1AdeEJxagFXnrcP
	v8pW+rR0UP+LJkqpsZZgMbM2YiRqsifw=
X-Gm-Gg: ASbGncvUBcwubkqF/15j5Uv0wZU+hilX444XdBcH0I+9Ib26+hpRBN4OmIsP7r2qUuI
	sTex8+zBPF+nhcbQN9JuvoRtR2basLNatD5zVaCKthodxmiF5i0A6dTHbtx6qW9ZrGKI5hDV9JL
	UdvKsKzx+RoB7iFvPgskEjth5R8kMqCPBnYqSJcKFah39HNB1wWWTgr0M+2IotuG3Y1dimlle7R
	UgNZxTI/nFWZJUfAw==
X-Google-Smtp-Source: AGHT+IFiRL5PcOs1FQx48CRe5A6PcEXbWyQo/8AusmOYo9ZpAmIECE3WDqbz+GbbDlmaW/1cNGDn7nJP0to2f5oId4M=
X-Received: by 2002:a05:6102:26d3:b0:4fc:156e:1046 with SMTP id
 ada2fe7eead31-4fdc4212c13mr5641344137.20.1754389279324; Tue, 05 Aug 2025
 03:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731104726.103071-1-lokeshgidra@google.com>
 <CAGsJ_4yJ5mtk_mp3r=PsMZOnHdtEk2Q_UTDjwy=4cmV8mcz+mg@mail.gmail.com> <CA+EESO4d_iriWeLit6RbODxxMPLnns64cuo+gkQhbYebZdHDdA@mail.gmail.com>
In-Reply-To: <CA+EESO4d_iriWeLit6RbODxxMPLnns64cuo+gkQhbYebZdHDdA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Aug 2025 18:21:07 +0800
X-Gm-Features: Ac12FXyQkOqRzRVUcG4YdSynxxkbngwEJT937lRNpCEpIlwwe--WfZbW0U12FOI
Message-ID: <CAGsJ_4y7WmQaFCZsxqfLD8c6qG0NuN2Hyqxq6mgHTpCMcRuyNw@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: opportunistic TLB-flush batching for present
 pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:30=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Mon, Aug 4, 2025 at 9:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Thu, Jul 31, 2025 at 6:47=E2=80=AFPM Lokesh Gidra <lokeshgidra@googl=
e.com> wrote:
> > >
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
> > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > includes TLB-flush overhead.
> > >
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 127 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 8253978ee0fb..2465fb234671 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1026,18 +1026,62 @@ static inline bool is_pte_pages_stable(pte_t =
*dst_pte, pte_t *src_pte,
> > >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> > >  }
> > >
> > > -static int move_present_pte(struct mm_struct *mm,
> > > -                           struct vm_area_struct *dst_vma,
> > > -                           struct vm_area_struct *src_vma,
> > > -                           unsigned long dst_addr, unsigned long src=
_addr,
> > > -                           pte_t *dst_pte, pte_t *src_pte,
> > > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > -                           struct folio *src_folio)
> > > +/*
> > > + * Checks if the two ptes and the corresponding folio are eligible f=
or batched
> > > + * move. If so, then returns pointer to the folio, after locking it.=
 Otherwise,
> > > + * returns NULL.
> > > + */
> > > +static struct folio *check_ptes_for_batched_move(struct vm_area_stru=
ct *src_vma,
> > > +                                                unsigned long src_ad=
dr,
> > > +                                                pte_t *src_pte, pte_=
t *dst_pte)
> > > +{
> > > +       pte_t orig_dst_pte, orig_src_pte;
> > > +       struct folio *folio;
> > > +
> > > +       orig_dst_pte =3D ptep_get(dst_pte);
> > > +       if (!pte_none(orig_dst_pte))
> > > +               return NULL;
> > > +
> > > +       orig_src_pte =3D ptep_get(src_pte);
> > > +       if (pte_none(orig_src_pte))
> > > +               return NULL;
> > > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_sr=
c_pte)))
> > > +               return NULL;
> > > +
> > > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > > +       if (!folio || !folio_trylock(folio))
> > > +               return NULL;
> > > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(foli=
o)) {
> > > +               folio_unlock(folio);
> > > +               return NULL;
> > > +       }
> > > +       return folio;
> > > +}
> > > +
> > > +static long move_present_ptes(struct mm_struct *mm,
> > > +                             struct vm_area_struct *dst_vma,
> > > +                             struct vm_area_struct *src_vma,
> > > +                             unsigned long dst_addr, unsigned long s=
rc_addr,
> > > +                             pte_t *dst_pte, pte_t *src_pte,
> > > +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> > > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > +                             spinlock_t *dst_ptl, spinlock_t *src_pt=
l,
> > > +                             struct folio *src_folio, unsigned long =
len)
> > >  {
> > >         int err =3D 0;
> > > +       unsigned long src_start =3D src_addr;
> > > +       unsigned long addr_end;
> > > +
> > > +       if (len > PAGE_SIZE) {
> > > +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > > +               if (dst_addr + len > addr_end)
> > > +                       len =3D addr_end - dst_addr;
> > >
> > > +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > > +               if (src_addr + len > addr_end)
> > > +                       len =3D addr_end - src_addr;
> > > +       }
> > > +       flush_cache_range(src_vma, src_addr, src_addr + len);
> > >         double_pt_lock(dst_ptl, src_ptl);
> > >
> > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig=
_src_pte,
> > > @@ -1051,31 +1095,60 @@ static int move_present_pte(struct mm_struct =
*mm,
> > >                 err =3D -EBUSY;
> > >                 goto out;
> > >         }
> > > +       /* Avoid batching overhead for single page case */
> > > +       if (len > PAGE_SIZE) {
> > > +               flush_tlb_batched_pending(mm);
> >
> > What=E2=80=99s confusing to me is that they track the unmapping of mult=
iple
> > consecutive PTEs and defer TLB invalidation until later.
> > In contrast, you=E2=80=99re not tracking anything and instead call
> > flush_tlb_range() directly, which triggers the flush immediately.
> >
> > It seems you might be combining two different batching approaches.
>
> These changes I made are in line with how mremap() does batching. See
> move_ptes() in mm/mremap.c
>
> From the comment in flush_tlb_batched_pending() [1] it seems necessary
> in this case too. Please correct me if I'm wrong. I'll be happy to
> remove it if it's not required.
>
> [1] https://elixir.bootlin.com/linux/v6.16/source/mm/rmap.c#L728

Whether we need flush_tlb_batched_pending() has nothing to do with your
patch. It's entirely about synchronizing with other pending TLBIs, such as
those from try_to_unmap_one() and try_to_migrate_one().

In short, if it's needed, it's needed regardless of whether your patch is
applied or whether you're dealing with len > PAGE_SIZE.

>
> > From what I can tell, you're essentially using flush_range
> > as a replacement for flushing each entry individually.
>
> That's correct. The idea is to reduce the number of IPIs required for
> flushing the TLB entries. Since it is quite common that the ioctl is
> invoked with several pages in one go, this greatly benefits.
>
> >
> > > +               arch_enter_lazy_mmu_mode();
> > > +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src=
_pte);
> > > +       } else
> > > +               orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, =
src_pte);
> > > +
> > > +       addr_end =3D src_start + len;
> > > +       do {
> > > +               /* Folio got pinned from under us. Put it back and fa=
il the move. */
> > > +               if (folio_maybe_dma_pinned(src_folio)) {
> > > +                       set_pte_at(mm, src_addr, src_pte, orig_src_pt=
e);
> > > +                       err =3D -EBUSY;
> > > +                       break;
> > > +               }
> > >
> > > -       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte)=
;
> > > -       /* Folio got pinned from under us. Put it back and fail the m=
ove. */
> > > -       if (folio_maybe_dma_pinned(src_folio)) {
> > > -               set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> > > -               err =3D -EBUSY;
> > > -               goto out;
> > > -       }
> > > -
> > > -       folio_move_anon_rmap(src_folio, dst_vma);
> > > -       src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > > +               folio_move_anon_rmap(src_folio, dst_vma);
> > > +               src_folio->index =3D linear_page_index(dst_vma, dst_a=
ddr);
> > >
> > > -       orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_pro=
t);
> > > -       /* Set soft dirty bit so userspace can notice the pte was mov=
ed */
> > > +               orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_=
page_prot);
> > > +               /* Set soft dirty bit so userspace can notice the pte=
 was moved */
> > >  #ifdef CONFIG_MEM_SOFT_DIRTY
> > > -       orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > > +               orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > >  #endif
> > > -       if (pte_dirty(orig_src_pte))
> > > -               orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > > -       orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > > +               if (pte_dirty(orig_src_pte))
> > > +                       orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > > +               orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > > +               set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > > +
> > > +               src_addr +=3D PAGE_SIZE;
> > > +               if (src_addr =3D=3D addr_end)
> > > +                       break;
> > > +               src_pte++;
> > > +               dst_pte++;
> > >
> > > -       set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > > +               folio_unlock(src_folio);
> > > +               src_folio =3D check_ptes_for_batched_move(src_vma, sr=
c_addr, src_pte, dst_pte);
> > > +               if (!src_folio)
> > > +                       break;
> > > +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src=
_pte);
> > > +               dst_addr +=3D PAGE_SIZE;
> > > +       } while (true);
> > > +
> > > +       if (len > PAGE_SIZE) {
> > > +               arch_leave_lazy_mmu_mode();
> > > +               if (src_addr > src_start)
> > > +                       flush_tlb_range(src_vma, src_start, src_addr)=
;
> > > +       }
> >
> > Can't we just remove the `if (len > PAGE_SIZE)` check and unify the
> > handling for both single-page and multi-page cases?
>
> We certainly can. Initially it seemed to me that lazy/batched
> invalidation has its own overhead and I wanted to avoid that in the
> single-page case because the ioctl does get called for single pages
> quite a bit. That too in time sensitive code paths. However, on a
> deeper relook now, I noticed it's not really that different.
>
> I'll unify in the next patch. Thanks for the suggestion.

Yes, that would be nice =E2=80=94 especially since flush_tlb_batched_pendin=
g()
is not needed in this patch.

Whether it's needed for uffd_move is a separate matter and should be
addressed in a separate patch, if necessary =E2=80=94 for example, if there=
's a
similar race as described in Commit 3ea277194daa
("mm, mprotect: flush TLB if potentially racing with a parallel reclaim
leaving stale TLB entries").



            CPU0                            CPU1

            ----                            ----

                                            user accesses memory using RW P=
TE

                                            [PTE now cached in TLB]

            try_to_unmap_one()

            =3D=3D> ptep_get_and_clear()

            =3D=3D> set_tlb_ubc_flush_pending()

                                            mprotect(addr, PROT_READ)

                                            =3D=3D> change_pte_range()

                                            =3D=3D> [ PTE non-present - no =
flush ]



                                            user writes using cached RW PTE

            ...

            try_to_unmap_flush()

Thanks
Barry

