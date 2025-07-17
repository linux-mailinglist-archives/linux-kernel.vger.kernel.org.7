Return-Path: <linux-kernel+bounces-734804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34060B08686
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3DCA44EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB321E098;
	Thu, 17 Jul 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uwwaw/is"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB521E08B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737010; cv=none; b=BL47pX4G/OzwOmPyoIG4aJt1vlrK35h6kcx5j27fSK7kKabUrXxgB24dNKdR9zEZjF9glrAPIjUSPU2p2OzW7/NXSOyxaZUYGgEutW0hUtFtNjbpVbnuLhhgWk0Nxc71XdQuFAblPkHEvS7qZrTkATqyASSLGzBbXm30rsDnv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737010; c=relaxed/simple;
	bh=FKIBHb7WsiCcqxyCiXSuimCxqY3BRuP7EWyNXI3p7XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2me9GMvF5dqIPXrfqAKDlJ9roF4XfbLmnGhUPwMwPo7wxsTKQsF3bjVhanJKiMdv3N/BPy1uFCOGRFzuUG64W1AzerX84y3m+qsfQWMToWD/C+hKJDGc4e6wkhmmddJmBYpEWu5aG0e026AyX1JxJ9ijJNUYajScHsblloy2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uwwaw/is; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc1S4HRN10CMKK/JwiubHJK1ene59WEJkUCJ4n6yCBE=;
	b=Uwwaw/ise3e/7l8ovasxRBvvjwkh2pl/+tXUuW45bkfUJtm+y/crkOOumQiDEEGwvhISRn
	gCrrFjt0L2MVqvJpEyUMAJ+f3LW2vyHSL354B37hcMA2GM7Q0X1dwthN/Dqi1UfxTGgHMg
	t/lDjCCH3//kxmKfpwpQSg2MCREk1p0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-MiXpmwUvO8KkBdHrVXYT9A-1; Thu, 17 Jul 2025 03:23:26 -0400
X-MC-Unique: MiXpmwUvO8KkBdHrVXYT9A-1
X-Mimecast-MFC-AGG-ID: MiXpmwUvO8KkBdHrVXYT9A_1752737005
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-718409595cbso10625677b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737005; x=1753341805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc1S4HRN10CMKK/JwiubHJK1ene59WEJkUCJ4n6yCBE=;
        b=MLqXo2cgIfozHkwXAJOtbu4zmSjtO+YAaXAzWn66v2liqVNNcp2EHLgOkGemGRHvwZ
         eWJdyCUABhQws9/V6JYJbdToVPGXqD+sEeTjlxDhpLhxPippJ4acCKcApmwbYAR8FJI1
         7tosr6T/v669z08TP0kIwtgNxPToEG+aNbSWRdiwP1JeofHuZKBdXN0hJGK8VFjZmMPi
         7g8BmtlgU45TzorM0aKScpZLnhj8Upr52kh+LJz689yiYV4CpdhGfLvb+j73RgFIM4GC
         wE3ixHe9JEgF/cP/jsdn3dTL6InU7yqMdltjMc9Vh99fI85m+7OmaZRV95csihNiosc8
         4npg==
X-Forwarded-Encrypted: i=1; AJvYcCWJvfQn/GwB7+urX64I7sDGfG7Jl/c91lw/3z3F9kgnpl0wbI5nMuxBbYPrn/k8nkRfzoAboffvIthXqbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXlkhI47Ud7MINc7Zro2Sp2MSkqbckgeV4HlbzbjJTdWVgEj7
	P0J3qVYkOJkkovGW1m4z0mDkI/BiSzytm1FDlrlVCKFPldMwk3Q0WrgFbF5vL5zgZcr9+AAuzTo
	12O3GypZEc4z01qyfjbl2nADJBy6i4gRLzOOIcdeDfjsBxm5TapS3aqQnte2ZPPLW1V8VgyV9nO
	mzykjaxRhD9jkW+yYN0VduWxrrd7rN4j9NmHGMtfnh
X-Gm-Gg: ASbGncvIedaU0aDVHd9TFkX/JI203JQk/Zyf7I9M1INLB8gzHd90c81T1MYN9q0gUN2
	HS7JTc0GGCbQ3DXC5AKzC+Oa0NJviMAwO8CCHkgaa04temo6NbCVfzQy+Q5BQOkoYcZsnbnLnr9
	WlJUxOmtOL00qUHHzLZX3P1c8=
X-Received: by 2002:a05:690c:688e:b0:70b:6651:b3e2 with SMTP id 00721157ae682-71834f3630bmr86143347b3.6.1752737005212;
        Thu, 17 Jul 2025 00:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrnspdqqX7aF+30GpKsaj5N3vowL7QVfLxGl9seZtaQy9Qba+TSioCVG5Kge/qXEG9ECo0HmCjXxEtp9vaAjM=
X-Received: by 2002:a05:690c:688e:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-71834f3630bmr86142767b3.6.1752737004540; Thu, 17 Jul 2025
 00:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-6-npache@redhat.com>
 <d2f622f6-3ef2-4227-b672-2fbd3a7dc931@redhat.com>
In-Reply-To: <d2f622f6-3ef2-4227-b672-2fbd3a7dc931@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:22:58 -0600
X-Gm-Features: Ac12FXyE2i46MbTFKcgd5mrUuWOmp87pUm27jhY9X8v9F0TQ52kTkKs7hjcEIPs
Message-ID: <CAA1CXcBuJfUs_dhzo1CM2B-nDpptAwi+bFGXPn7oxAinmRUggA@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:53=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:31, Nico Pache wrote:
> > generalize the order of the __collapse_huge_page_* functions
> > to support future mTHP collapse.
> >
> > mTHP collapse can suffer from incosistant behavior, and memory waste
> > "creep". disable swapin and shared support for mTHP collapse.
> >
> > No functional changes in this patch.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++-----------------=
-
> >   1 file changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index cc9a35185604..ee54e3c1db4e 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -552,15 +552,17 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >                                       unsigned long address,
> >                                       pte_t *pte,
> >                                       struct collapse_control *cc,
> > -                                     struct list_head *compound_pageli=
st)
> > +                                     struct list_head *compound_pageli=
st,
> > +                                     u8 order)
>
> u8 ... (applies to all instances)
Fixed all instances of this (other than those that need to stay)
>
> >   {
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       bool writable =3D false;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- order);
>
> "scaled_max_ptes_none" maybe?
done!
>
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + (1 << order);
> >            _pte++, address +=3D PAGE_SIZE) {
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || (pte_present(pteval) &&
> > @@ -568,7 +570,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> >                           (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                          none_or_zero <=3D scaled_none)) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -596,8 +598,8 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >               /* See hpage_collapse_scan_pmd(). */
> >               if (folio_maybe_mapped_shared(folio)) {
> >                       ++shared;
> > -                     if (cc->is_khugepaged &&
> > -                         shared > khugepaged_max_ptes_shared) {
> > +                     if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> > +                         shared > khugepaged_max_ptes_shared)) {
>
> Please add a comment why we do something different with PMD. As
> commenting below, does this deserve a TODO?
>
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> >                               goto out;
> > @@ -698,13 +700,14 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >                                               struct vm_area_struct *vm=
a,
> >                                               unsigned long address,
> >                                               spinlock_t *ptl,
> > -                                             struct list_head *compoun=
d_pagelist)
> > +                                             struct list_head *compoun=
d_pagelist,
> > +                                             u8 order)
> >   {
> >       struct folio *src, *tmp;
> >       pte_t *_pte;
> >       pte_t pteval;
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + (1 << order);
> >            _pte++, address +=3D PAGE_SIZE) {
> >               pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > @@ -751,7 +754,8 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >                                            pmd_t *pmd,
> >                                            pmd_t orig_pmd,
> >                                            struct vm_area_struct *vma,
> > -                                          struct list_head *compound_p=
agelist)
> > +                                          struct list_head *compound_p=
agelist,
> > +                                          u8 order)
> >   {
> >       spinlock_t *pmd_ptl;
> >
> > @@ -768,7 +772,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >        * Release both raw and compound pages isolated
> >        * in __collapse_huge_page_isolate.
> >        */
> > -     release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> > +     release_pte_pages(pte, pte + (1 << order), compound_pagelist);
> >   }
> >
> >   /*
> > @@ -789,7 +793,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >   static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
> >               pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> >               unsigned long address, spinlock_t *ptl,
> > -             struct list_head *compound_pagelist)
> > +             struct list_head *compound_pagelist, u8 order)
> >   {
> >       unsigned int i;
> >       int result =3D SCAN_SUCCEED;
> > @@ -797,7 +801,7 @@ static int __collapse_huge_page_copy(pte_t *pte, st=
ruct folio *folio,
> >       /*
> >        * Copying pages' contents is subject to memory poison at any ite=
ration.
> >        */
> > -     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +     for (i =3D 0; i < (1 << order); i++) {
> >               pte_t pteval =3D ptep_get(pte + i);
> >               struct page *page =3D folio_page(folio, i);
> >               unsigned long src_addr =3D address + i * PAGE_SIZE;
> > @@ -816,10 +820,10 @@ static int __collapse_huge_page_copy(pte_t *pte, =
struct folio *folio,
> >
> >       if (likely(result =3D=3D SCAN_SUCCEED))
> >               __collapse_huge_page_copy_succeeded(pte, vma, address, pt=
l,
> > -                                                 compound_pagelist);
> > +                                                 compound_pagelist, or=
der);
> >       else
> >               __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> > -                                              compound_pagelist);
> > +                                              compound_pagelist, order=
);
> >
> >       return result;
> >   }
> > @@ -994,11 +998,11 @@ static int check_pmd_still_valid(struct mm_struct=
 *mm,
> >   static int __collapse_huge_page_swapin(struct mm_struct *mm,
> >                                      struct vm_area_struct *vma,
> >                                      unsigned long haddr, pmd_t *pmd,
> > -                                    int referenced)
> > +                                    int referenced, u8 order)
> >   {
> >       int swapped_in =3D 0;
> >       vm_fault_t ret =3D 0;
> > -     unsigned long address, end =3D haddr + (HPAGE_PMD_NR * PAGE_SIZE)=
;
> > +     unsigned long address, end =3D haddr + (PAGE_SIZE << order);
> >       int result;
> >       pte_t *pte =3D NULL;
> >       spinlock_t *ptl;
> > @@ -1029,6 +1033,15 @@ static int __collapse_huge_page_swapin(struct mm=
_struct *mm,
> >               if (!is_swap_pte(vmf.orig_pte))
> >                       continue;
> >
> > +             /* Dont swapin for mTHP collapse */
>
> Should we turn this into a TODO, because it's something to figure out
> regarding the scaling etc?
Good idea, I changed both of these into TODOs
>
> > +             if (order !=3D HPAGE_PMD_ORDER) {
> > +                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
> > +                     pte_unmap(pte);
> > +                     mmap_read_unlock(mm);
> > +                     result =3D SCAN_EXCEED_SWAP_PTE;
> > +                     goto out;
> > +             }
> > +
> >               vmf.pte =3D pte;
> >               vmf.ptl =3D ptl;
> >               ret =3D do_swap_page(&vmf);
> > @@ -1149,7 +1162,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> >               result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                                                  referenced);
>  > +                            referenced, HPAGE_PMD_ORDER);
>
> Indent messed up. Feel free to exceed 80 chars if it aids readability.
Fixed!
>
> >               if (result !=3D SCAN_SUCCEED)
> >                       goto out_nolock;
> >       }
> > @@ -1197,7 +1210,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> >       if (pte) {
> >               result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > -                                                   &compound_pagelist)=
;
> > +                                     &compound_pagelist, HPAGE_PMD_ORD=
ER);
>
> Dito.
Fixed!
>
>
> Apart from that, nothing jumped at me
>
> Acked-by: David Hildenbrand <david@redhat.com>
Thanks for the ack! I fixed the compile issue you noted too.
>
> --
> Cheers,
>
> David / dhildenb
>


