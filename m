Return-Path: <linux-kernel+bounces-755986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A623B1AE63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD237AD8F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3F21FF2E;
	Tue,  5 Aug 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe5Mo//i"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E8221DB0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375451; cv=none; b=YSrR6VW7X2FTnCQ/yeLkHRFzU0hdiCdw4cKHVGH/4UpnCCUT3hc3PlP9GrCK0utrVTbCK7ziFU7cf24qZd1BO3J1egq710N0ow0ckouyCxjCuVjCqVmTFEoelc/g6To01cTCv0/yxv35ZYIOynWrm2nWUE9f4wgKucQzaGzE5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375451; c=relaxed/simple;
	bh=9v+02nBu4QirZ31FzIYj1wx+6UyfksfbtdE2jdpYJFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxjtiF7/ym15uvAn8kawn7X8//T8yZyXjhKPpvKFdcL8B++/090rZO5ZLy34b5fIZckTVYULF2P1NAUTfyFnWx6f/2k6y9QwTE3puE2sMP3sjnbmk1RnL6fN9x4bhyLQsLwray1SmdlQTHkWiR4z0rf4tH0gQ9+2t8otWAmnQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe5Mo//i; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso9630a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754375447; x=1754980247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jKCzNiBFP4betutlAHF95RVjFqwZC+QyEzLLbZpDpU=;
        b=Qe5Mo//iEOAA6/F7UUKORDP+lGJKVyobg99Vz/Ck/11a7wwXP+5CwtefPHNcZ/Ou/R
         vMdjIxnKE4XSTHQnV3iun8w0XxjPvbOmLgpyzAqcWjYiV0FaACm9uPj4cHnYtqwKS21e
         nPDvVeXSVYmuUYV74fui3U3bC/XpPDND8W8OGfBnl+Ft0YQ6YUFbAaxMYR95W578w6M4
         ibNCnF4uiS7yTezn4qHj73k0BB46Qo66JT5mLX/1FIn/oRJHp0+Kt9LcWwq5cr6SnG8r
         OAo5tU+gxsa+BrxTwmy3GRe8iLch68zMWTdyt4KFK5p8AZfZE/ZZ0frUvWqTQB39setO
         c0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754375447; x=1754980247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jKCzNiBFP4betutlAHF95RVjFqwZC+QyEzLLbZpDpU=;
        b=LF1Bg6vhgnc6kJs2Innvw97rYbHG2Dk4KzEF9JY8cJg6Ob8jevYbspvbvEO12JaNgg
         Tid3LX56xy4YqbiHqPZSc8FZOXO+HxTxHgQZbA9uuMkr2gtP2p/a6uTZTyP7Z+tCSeAt
         CkvF6d8IKU+QTF38lRU+j5d29Y0o2W+eHztxs/d/H5OpBWa9Ck5eiMtIl/4Ach/exWqm
         YBMcAn2DVhDyaFurNAc43TxTQ4AhdU3pvfHw1DUKOm7aHzKP3GAHoMPJ+xn2ur48AGX2
         cBvevqPeWTKma9azCEuJ1GIw7Vk6EpfRcLe9sVBUyCw4aFppUgMPoVCSv2Jvc0xA165q
         tM4w==
X-Forwarded-Encrypted: i=1; AJvYcCUoMUTP+JzVx0e9/GCVRebghyn3gS664lo020OX0r9DRvb5K0f8Zxru3Kogn5awQkfK52ZYQ1lsmTEHg9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ295sjEj3UvwblYs6bke1HXtRwSceNuZh4g9zEIjF2bjcygvT
	daXFHahDfUBVhXE8AToxdwc4k1dF/BlyBu9WKLU7NEKdCNsnVwyQTT7nDeizpMlS6jT8phMQCiP
	wIRsltsTNqA1jwFt8rvofGeyp+QCdBmHbWnH0hFEsudWeHENXvXHk2316+kLR3g==
X-Gm-Gg: ASbGncsZkemyCDujtHhHGhwB9UCIpf6kev41RgkdfgUciutVDysOoADh4B7CPF6Qj9p
	CPl0KRrUANRxqwaw8OYU0gde89WqH+zZHbONu0TXHgc9ztA6tSTdlHsMJB31oxTF/COhSTujKAA
	KtDzZNzXE6YOwaM6QNerVlhrs2739xsQAWCPju7n3wdmDT1+00Ew5Ln6KnIOdfRFYfJ2hQLRZUM
	p4dpDJKIg==
X-Google-Smtp-Source: AGHT+IF9dyc8YKAvaICZJqlHqULJ/wR5cCC0kOw7URmA5UotgvJ3JQZgE4a/yTHHwWj7ulJFSDFnaIqvUefbB3nwqTw=
X-Received: by 2002:a50:8ac7:0:b0:615:6167:4835 with SMTP id
 4fb4d7f45d1cf-61784827174mr16808a12.7.1754375447152; Mon, 04 Aug 2025
 23:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731104726.103071-1-lokeshgidra@google.com> <CAGsJ_4yJ5mtk_mp3r=PsMZOnHdtEk2Q_UTDjwy=4cmV8mcz+mg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yJ5mtk_mp3r=PsMZOnHdtEk2Q_UTDjwy=4cmV8mcz+mg@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 4 Aug 2025 23:30:35 -0700
X-Gm-Features: Ac12FXwPLT837tjNVzFz6ic90cBYQizv07IErS2ipoubEYgqHnUpZl2nCWBF-FE
Message-ID: <CA+EESO4d_iriWeLit6RbODxxMPLnns64cuo+gkQhbYebZdHDdA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: opportunistic TLB-flush batching for present
 pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, Jul 31, 2025 at 6:47=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
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
> >  mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 127 insertions(+), 52 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 8253978ee0fb..2465fb234671 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1026,18 +1026,62 @@ static inline bool is_pte_pages_stable(pte_t *d=
st_pte, pte_t *src_pte,
> >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> >  }
> >
> > -static int move_present_pte(struct mm_struct *mm,
> > -                           struct vm_area_struct *dst_vma,
> > -                           struct vm_area_struct *src_vma,
> > -                           unsigned long dst_addr, unsigned long src_a=
ddr,
> > -                           pte_t *dst_pte, pte_t *src_pte,
> > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                           struct folio *src_folio)
> > +/*
> > + * Checks if the two ptes and the corresponding folio are eligible for=
 batched
> > + * move. If so, then returns pointer to the folio, after locking it. O=
therwise,
> > + * returns NULL.
> > + */
> > +static struct folio *check_ptes_for_batched_move(struct vm_area_struct=
 *src_vma,
> > +                                                unsigned long src_addr=
,
> > +                                                pte_t *src_pte, pte_t =
*dst_pte)
> > +{
> > +       pte_t orig_dst_pte, orig_src_pte;
> > +       struct folio *folio;
> > +
> > +       orig_dst_pte =3D ptep_get(dst_pte);
> > +       if (!pte_none(orig_dst_pte))
> > +               return NULL;
> > +
> > +       orig_src_pte =3D ptep_get(src_pte);
> > +       if (pte_none(orig_src_pte))
> > +               return NULL;
> > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_=
pte)))
> > +               return NULL;
> > +
> > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > +       if (!folio || !folio_trylock(folio))
> > +               return NULL;
> > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(folio)=
) {
> > +               folio_unlock(folio);
> > +               return NULL;
> > +       }
> > +       return folio;
> > +}
> > +
> > +static long move_present_ptes(struct mm_struct *mm,
> > +                             struct vm_area_struct *dst_vma,
> > +                             struct vm_area_struct *src_vma,
> > +                             unsigned long dst_addr, unsigned long src=
_addr,
> > +                             pte_t *dst_pte, pte_t *src_pte,
> > +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                             struct folio *src_folio, unsigned long le=
n)
> >  {
> >         int err =3D 0;
> > +       unsigned long src_start =3D src_addr;
> > +       unsigned long addr_end;
> > +
> > +       if (len > PAGE_SIZE) {
> > +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > +               if (dst_addr + len > addr_end)
> > +                       len =3D addr_end - dst_addr;
> >
> > +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > +               if (src_addr + len > addr_end)
> > +                       len =3D addr_end - src_addr;
> > +       }
> > +       flush_cache_range(src_vma, src_addr, src_addr + len);
> >         double_pt_lock(dst_ptl, src_ptl);
> >
> >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > @@ -1051,31 +1095,60 @@ static int move_present_pte(struct mm_struct *m=
m,
> >                 err =3D -EBUSY;
> >                 goto out;
> >         }
> > +       /* Avoid batching overhead for single page case */
> > +       if (len > PAGE_SIZE) {
> > +               flush_tlb_batched_pending(mm);
>
> What=E2=80=99s confusing to me is that they track the unmapping of multip=
le
> consecutive PTEs and defer TLB invalidation until later.
> In contrast, you=E2=80=99re not tracking anything and instead call
> flush_tlb_range() directly, which triggers the flush immediately.
>
> It seems you might be combining two different batching approaches.

These changes I made are in line with how mremap() does batching. See
move_ptes() in mm/mremap.c

From the comment in flush_tlb_batched_pending() [1] it seems necessary
in this case too. Please correct me if I'm wrong. I'll be happy to
remove it if it's not required.

[1] https://elixir.bootlin.com/linux/v6.16/source/mm/rmap.c#L728

> From what I can tell, you're essentially using flush_range
> as a replacement for flushing each entry individually.

That's correct. The idea is to reduce the number of IPIs required for
flushing the TLB entries. Since it is quite common that the ioctl is
invoked with several pages in one go, this greatly benefits.

>
> > +               arch_enter_lazy_mmu_mode();
> > +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_p=
te);
> > +       } else
> > +               orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, sr=
c_pte);
> > +
> > +       addr_end =3D src_start + len;
> > +       do {
> > +               /* Folio got pinned from under us. Put it back and fail=
 the move. */
> > +               if (folio_maybe_dma_pinned(src_folio)) {
> > +                       set_pte_at(mm, src_addr, src_pte, orig_src_pte)=
;
> > +                       err =3D -EBUSY;
> > +                       break;
> > +               }
> >
> > -       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> > -       /* Folio got pinned from under us. Put it back and fail the mov=
e. */
> > -       if (folio_maybe_dma_pinned(src_folio)) {
> > -               set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> > -               err =3D -EBUSY;
> > -               goto out;
> > -       }
> > -
> > -       folio_move_anon_rmap(src_folio, dst_vma);
> > -       src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > +               folio_move_anon_rmap(src_folio, dst_vma);
> > +               src_folio->index =3D linear_page_index(dst_vma, dst_add=
r);
> >
> > -       orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_prot)=
;
> > -       /* Set soft dirty bit so userspace can notice the pte was moved=
 */
> > +               orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_pa=
ge_prot);
> > +               /* Set soft dirty bit so userspace can notice the pte w=
as moved */
> >  #ifdef CONFIG_MEM_SOFT_DIRTY
> > -       orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> > +               orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> >  #endif
> > -       if (pte_dirty(orig_src_pte))
> > -               orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > -       orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > +               if (pte_dirty(orig_src_pte))
> > +                       orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> > +               orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> > +               set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > +
> > +               src_addr +=3D PAGE_SIZE;
> > +               if (src_addr =3D=3D addr_end)
> > +                       break;
> > +               src_pte++;
> > +               dst_pte++;
> >
> > -       set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> > +               folio_unlock(src_folio);
> > +               src_folio =3D check_ptes_for_batched_move(src_vma, src_=
addr, src_pte, dst_pte);
> > +               if (!src_folio)
> > +                       break;
> > +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_p=
te);
> > +               dst_addr +=3D PAGE_SIZE;
> > +       } while (true);
> > +
> > +       if (len > PAGE_SIZE) {
> > +               arch_leave_lazy_mmu_mode();
> > +               if (src_addr > src_start)
> > +                       flush_tlb_range(src_vma, src_start, src_addr);
> > +       }
>
> Can't we just remove the `if (len > PAGE_SIZE)` check and unify the
> handling for both single-page and multi-page cases?

We certainly can. Initially it seemed to me that lazy/batched
invalidation has its own overhead and I wanted to avoid that in the
single-page case because the ioctl does get called for single pages
quite a bit. That too in time sensitive code paths. However, on a
deeper relook now, I noticed it's not really that different.

I'll unify in the next patch. Thanks for the suggestion.
>
>
> Thanks
> Barry

