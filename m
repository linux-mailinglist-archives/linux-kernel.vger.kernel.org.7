Return-Path: <linux-kernel+bounces-756270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA3B1B21C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA83A4BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B123D288;
	Tue,  5 Aug 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ugptp+lx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26C22333D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390201; cv=none; b=Npo7x61Dphx6BBKoq5A8WSigUFc9hu9oTJMBAMxIItw8cwJoJWDrQYh4hoIKBhRoOCWWTKYMZt9RVZBZftw3eFp585IZJbSeHxDPrTvMW6Pr66kjbeiHVsYuG/blXH0uEKSUYcHUwG2gM6ZSiT4iRmG0ofOhWEJ0bMzmd2+qAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390201; c=relaxed/simple;
	bh=0VcDl+wvR1JpW2jTwNyszSz+oqaKcsrjjfTJFLIJnjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch24nIqhwa+W7B/NrGnqqLdalET1sJnC5wdZkwZTIXifGAtWpSi9Q0p0ooT4U0CJmMBR6iprSoNV8CVgpnMgOKK/TO21UxN6rbWMhbliDxLfdH8bc7GnocCSljja9jX71T8mOxP55kiV0wMTBdgXVXlzGCpv6nvELAGNOroGdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ugptp+lx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso12282a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754390195; x=1754994995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flYd0l6wlhO1kycZFNP4VtdlMKPos7NnhaXuJWucl9w=;
        b=Ugptp+lx5bNEMQ1bdiIy//ErGs9p77NTObtQlN71/Bk3j56fM/GcxKbOBHf5h1kDtP
         hAZXh574Fgd649TTOdbjK/dDJvTw/mYNIDYwbAYI4x03O++JbWIp/Ox4qs2G943/LGEj
         qOs4E2A4jeEUz6ab7C9q9tMj+TqcXd1srLTNPg5HYXzRnZK4aOuScdtGV5C8v4Kj9CnG
         FgDgierlVPmzxLO7oJhd8i/1AWSDiqlLfRuKnc1jr4dLdflcqgyOxX/4yEZ+hpoksJ/P
         49G4dgUlo+Tsdyc14uGgpl1Vn8WXITr3aD4EpRJeqQjvVwqsRTr6oAB/4+3iM4f4QQCv
         ZzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390195; x=1754994995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flYd0l6wlhO1kycZFNP4VtdlMKPos7NnhaXuJWucl9w=;
        b=DqJ/xItO2ebCALFuRa7FVq1zA8TKjn4ZadLG8MyR/RVF7xyFx66fr4Uoe2n5AEN2Y7
         Fj7CHBJiTY+vjwZ92sTwMmLND8ybkrwevLrzmlZ5i9Mu5FGs4Q3RPqKJyno0PGSVXQtB
         5yfHUZmUxnYM/AMcRXWukhzJ26/cL2C0qOkJOB8RcpmcCQdFhPj78yie+y8UqZRdM4MP
         bZaSend7BYFs4cllIzNfGmBs3PLeknDK5bb0zu4IuCJkgMYF0tUsxyDzg2XvhSTl1xMR
         u16OtNTyng3s1GzQbznApEcdtQmkkzznfVeiH9lJtkEuvzJIL6fnLbt0Iwc2/bqb6e6l
         j2hw==
X-Forwarded-Encrypted: i=1; AJvYcCU6N+kwoBfiISx6U19q6aLC0N5MrANUbuvE2gXxcvXMVhOfH3gw6v/r+uwH2Frn1QpJi1iRfL85GRZCv58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7lvQPZ9qPPn5k9v+jP4CyTJOWNomPBfKf0IlfI/Kr/Krswaq
	iATugWbSYZVyuuJEeMROyVGJTV8pedtk3CaqN6vIpSsh2/UCa1j1mrtRxXELGj/r9aSu1tLYjOz
	rUiWisFbyPAtuDXZthDEnDQ9VNb5pQz7yOB1A7ZJ7
X-Gm-Gg: ASbGncuFXL/Aje82USlSvnu9OKRK7E6sqIUNnDRQzaZWGfMWXVXE7kU0W7ZXnlQ8Ivb
	YafYNWfGATE/Ka3Q/x2cY6+92ek07W1LAabo1haNfGbYPH40xOim8DnCRBUxluR4WzJ7X9xuBF7
	HwrHLenwxQTefsJd7Oe0zAHqoLxOgssocyqtSIZ87e3l3X3NySmXffM0I92y28pQPaKMbbkK1WR
	6LD4bKjDcfh++xmxPXoZJErx3swLlYFWVGsFkbfeg==
X-Google-Smtp-Source: AGHT+IEKIxB3NV5wlCPKPv8vT9luYio/LExjAKeWprQDsnxwJRaBfQS1ZtSlMRl35+07ZwxzeRZTNMtuqejiewPOSJg=
X-Received: by 2002:a05:6402:20d8:b0:617:4dd4:d39d with SMTP id
 4fb4d7f45d1cf-617847c8f11mr43996a12.4.1754390194361; Tue, 05 Aug 2025
 03:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731104726.103071-1-lokeshgidra@google.com>
 <CAGsJ_4yJ5mtk_mp3r=PsMZOnHdtEk2Q_UTDjwy=4cmV8mcz+mg@mail.gmail.com>
 <CA+EESO4d_iriWeLit6RbODxxMPLnns64cuo+gkQhbYebZdHDdA@mail.gmail.com> <CAGsJ_4y7WmQaFCZsxqfLD8c6qG0NuN2Hyqxq6mgHTpCMcRuyNw@mail.gmail.com>
In-Reply-To: <CAGsJ_4y7WmQaFCZsxqfLD8c6qG0NuN2Hyqxq6mgHTpCMcRuyNw@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 5 Aug 2025 03:36:21 -0700
X-Gm-Features: Ac12FXznEDF-mMQDb-Lp9bbITxres8ak3k8eIW7caylSRtM-PIsflY8r3osXfbY
Message-ID: <CA+EESO59gMnyPE1WmEpt8+mF8-6o9FBRH9QAUzdP4+i1ptdW8w@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: opportunistic TLB-flush batching for present
 pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 3:21=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Tue, Aug 5, 2025 at 2:30=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
> >
> > On Mon, Aug 4, 2025 at 9:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > On Thu, Jul 31, 2025 at 6:47=E2=80=AFPM Lokesh Gidra <lokeshgidra@goo=
gle.com> wrote:
> > > >
> > > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is requi=
red
> > > > for moving present pages. Mitigate this cost by opportunistically
> > > > batching present contiguous pages for TLB flushing.
> > > >
> > > > Without batching, in our testing on an arm64 Android device with UF=
FD GC,
> > > > which uses MOVE ioctl for compaction, we observed that out of the t=
otal
> > > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), =
and
> > > > ~20% in vm_normal_folio().
> > > >
> > > > With batching, the proportion of vm_normal_folio() increases to ove=
r
> > > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > > includes TLB-flush overhead.
> > > >
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > ---
> > > >  mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++----------=
----
> > > >  1 file changed, 127 insertions(+), 52 deletions(-)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 8253978ee0fb..2465fb234671 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -1026,18 +1026,62 @@ static inline bool is_pte_pages_stable(pte_=
t *dst_pte, pte_t *src_pte,
> > > >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> > > >  }
> > > >
> > > > -static int move_present_pte(struct mm_struct *mm,
> > > > -                           struct vm_area_struct *dst_vma,
> > > > -                           struct vm_area_struct *src_vma,
> > > > -                           unsigned long dst_addr, unsigned long s=
rc_addr,
> > > > -                           pte_t *dst_pte, pte_t *src_pte,
> > > > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > > > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > > -                           spinlock_t *dst_ptl, spinlock_t *src_pt=
l,
> > > > -                           struct folio *src_folio)
> > > > +/*
> > > > + * Checks if the two ptes and the corresponding folio are eligible=
 for batched
> > > > + * move. If so, then returns pointer to the folio, after locking i=
t. Otherwise,
> > > > + * returns NULL.
> > > > + */
> > > > +static struct folio *check_ptes_for_batched_move(struct vm_area_st=
ruct *src_vma,
> > > > +                                                unsigned long src_=
addr,
> > > > +                                                pte_t *src_pte, pt=
e_t *dst_pte)
> > > > +{
> > > > +       pte_t orig_dst_pte, orig_src_pte;
> > > > +       struct folio *folio;
> > > > +
> > > > +       orig_dst_pte =3D ptep_get(dst_pte);
> > > > +       if (!pte_none(orig_dst_pte))
> > > > +               return NULL;
> > > > +
> > > > +       orig_src_pte =3D ptep_get(src_pte);
> > > > +       if (pte_none(orig_src_pte))
> > > > +               return NULL;
> > > > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_=
src_pte)))
> > > > +               return NULL;
> > > > +
> > > > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > > > +       if (!folio || !folio_trylock(folio))
> > > > +               return NULL;
> > > > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(fo=
lio)) {
> > > > +               folio_unlock(folio);
> > > > +               return NULL;
> > > > +       }
> > > > +       return folio;
> > > > +}
> > > > +
> > > > +static long move_present_ptes(struct mm_struct *mm,
> > > > +                             struct vm_area_struct *dst_vma,
> > > > +                             struct vm_area_struct *src_vma,
> > > > +                             unsigned long dst_addr, unsigned long=
 src_addr,
> > > > +                             pte_t *dst_pte, pte_t *src_pte,
> > > > +                             pte_t orig_dst_pte, pte_t orig_src_pt=
e,
> > > > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > > +                             spinlock_t *dst_ptl, spinlock_t *src_=
ptl,
> > > > +                             struct folio *src_folio, unsigned lon=
g len)
> > > >  {
> > > >         int err =3D 0;
> > > > +       unsigned long src_start =3D src_addr;
> > > > +       unsigned long addr_end;
> > > > +
> > > > +       if (len > PAGE_SIZE) {
> > > > +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > > > +               if (dst_addr + len > addr_end)
> > > > +                       len =3D addr_end - dst_addr;
> > > >
> > > > +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > > > +               if (src_addr + len > addr_end)
> > > > +                       len =3D addr_end - src_addr;
> > > > +       }
> > > > +       flush_cache_range(src_vma, src_addr, src_addr + len);
> > > >         double_pt_lock(dst_ptl, src_ptl);
> > > >
> > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, or=
ig_src_pte,
> > > > @@ -1051,31 +1095,60 @@ static int move_present_pte(struct mm_struc=
t *mm,
> > > >                 err =3D -EBUSY;
> > > >                 goto out;
> > > >         }
> > > > +       /* Avoid batching overhead for single page case */
> > > > +       if (len > PAGE_SIZE) {
> > > > +               flush_tlb_batched_pending(mm);
> > >
> > > What=E2=80=99s confusing to me is that they track the unmapping of mu=
ltiple
> > > consecutive PTEs and defer TLB invalidation until later.
> > > In contrast, you=E2=80=99re not tracking anything and instead call
> > > flush_tlb_range() directly, which triggers the flush immediately.
> > >
> > > It seems you might be combining two different batching approaches.
> >
> > These changes I made are in line with how mremap() does batching. See
> > move_ptes() in mm/mremap.c
> >
> > From the comment in flush_tlb_batched_pending() [1] it seems necessary
> > in this case too. Please correct me if I'm wrong. I'll be happy to
> > remove it if it's not required.
> >
> > [1] https://elixir.bootlin.com/linux/v6.16/source/mm/rmap.c#L728
>
> Whether we need flush_tlb_batched_pending() has nothing to do with your
> patch. It's entirely about synchronizing with other pending TLBIs, such a=
s
> those from try_to_unmap_one() and try_to_migrate_one().
>
> In short, if it's needed, it's needed regardless of whether your patch is
> applied or whether you're dealing with len > PAGE_SIZE.
>
> >
> > > From what I can tell, you're essentially using flush_range
> > > as a replacement for flushing each entry individually.
> >
> > That's correct. The idea is to reduce the number of IPIs required for
> > flushing the TLB entries. Since it is quite common that the ioctl is
> > invoked with several pages in one go, this greatly benefits.
> >
> > >
> > > > +               arch_enter_lazy_mmu_mode();
> > > > +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, s=
rc_pte);
> > > > +       } else
> > > > +               orig_src_pte =3D ptep_clear_flush(src_vma, src_addr=
, src_pte);
> > > > +
> > > > +       addr_end =3D src_start + len;
> > > > +       do {
> > > > +               /* Folio got pinned from under us. Put it back and =
fail the move. */
> > > > +               if (folio_maybe_dma_pinned(src_folio)) {
> > > > +                       set_pte_at(mm, src_addr, src_pte, orig_src_=
pte);
> > > > +                       err =3D -EBUSY;
> > > > +                       break;
> > > > +               }
> > > >
> > > > -       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pt=
e);
> > > > -       /* Folio got pinned from under us. Put it back and fail the=
 move. */
> > > > -       if (folio_maybe_dma_pinned(src_folio)) {
> > > > -               set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> > > > -               err =3D -EBUSY;
> > > > -               goto out;
> > > > -       }
> > > > -
> > > > -       folio_move_anon_rmap(src_folio, dst_vma);
> > > > -       src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > > > +               folio_move_anon_rmap(src_folio, dst_vma);
> > > > +               src_folio->index =3D linear_page_index(dst_vma, dst=
_addr);
> > > >
> > > > -       orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_p=
rot);
> > > > -       /* Set soft dirty bit so userspace can notice the pte was m=
oved */
> > > > +               orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->v=
m_page_prot);
> > > > +               /* Set soft dirty bit so userspace can notice the p=
te was moved */
> > > >  #ifdef CONFIG_MEM_SOFT_DIRTY
> > > > -       orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > > > +               orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > > >  #endif
> > > > -       if (pte_dirty(orig_src_pte))
> > > > -               orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > > > -       orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > > > +               if (pte_dirty(orig_src_pte))
> > > > +                       orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > > > +               orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma)=
;
> > > > +               set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > > > +
> > > > +               src_addr +=3D PAGE_SIZE;
> > > > +               if (src_addr =3D=3D addr_end)
> > > > +                       break;
> > > > +               src_pte++;
> > > > +               dst_pte++;
> > > >
> > > > -       set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > > > +               folio_unlock(src_folio);
> > > > +               src_folio =3D check_ptes_for_batched_move(src_vma, =
src_addr, src_pte, dst_pte);
> > > > +               if (!src_folio)
> > > > +                       break;
> > > > +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, s=
rc_pte);
> > > > +               dst_addr +=3D PAGE_SIZE;
> > > > +       } while (true);
> > > > +
> > > > +       if (len > PAGE_SIZE) {
> > > > +               arch_leave_lazy_mmu_mode();
> > > > +               if (src_addr > src_start)
> > > > +                       flush_tlb_range(src_vma, src_start, src_add=
r);
> > > > +       }
> > >
> > > Can't we just remove the `if (len > PAGE_SIZE)` check and unify the
> > > handling for both single-page and multi-page cases?
> >
> > We certainly can. Initially it seemed to me that lazy/batched
> > invalidation has its own overhead and I wanted to avoid that in the
> > single-page case because the ioctl does get called for single pages
> > quite a bit. That too in time sensitive code paths. However, on a
> > deeper relook now, I noticed it's not really that different.
> >
> > I'll unify in the next patch. Thanks for the suggestion.
>
> Yes, that would be nice =E2=80=94 especially since flush_tlb_batched_pend=
ing()
> is not needed in this patch.
>
> Whether it's needed for uffd_move is a separate matter and should be
> addressed in a separate patch, if necessary =E2=80=94 for example, if the=
re's a
> similar race as described in Commit 3ea277194daa
> ("mm, mprotect: flush TLB if potentially racing with a parallel reclaim
> leaving stale TLB entries").
>
>
>
>             CPU0                            CPU1
>
>             ----                            ----
>
>                                             user accesses memory using RW=
 PTE
>
>                                             [PTE now cached in TLB]
>
>             try_to_unmap_one()
>
>             =3D=3D> ptep_get_and_clear()
>
>             =3D=3D> set_tlb_ubc_flush_pending()
>
>                                             mprotect(addr, PROT_READ)
>
>                                             =3D=3D> change_pte_range()
>
>                                             =3D=3D> [ PTE non-present - n=
o flush ]
>
>
>
>                                             user writes using cached RW P=
TE
>
>             ...
>
>             try_to_unmap_flush()
>
Thanks so much for clarifying. I understand the issue now. I'll think
about whether we need it in userfaultfd_move or not. But as you said
that is for a separate patch, if needed.

I'll upload v2 in some time.

> Thanks
> Barry

