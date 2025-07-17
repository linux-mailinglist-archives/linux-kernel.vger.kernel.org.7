Return-Path: <linux-kernel+bounces-734805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95533B08685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F241A64255
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D32206BE;
	Thu, 17 Jul 2025 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkAZihGx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F621E091
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737024; cv=none; b=VkAmk6J6mtsJn8mTRkJje10vfSZ9O3TW1nIzK9td+aC+b0mvnhriNEIOe8PTh4QOoQvKVV51eBxQK7yg93Mpigt4dnb5Y3Yl0HDyL6HLqGJGEsktWIMfKwL+lLvHfHDwDXjTbCEddm4XKbV5sYRqLo6TUCUEs61B57VKH0U8AhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737024; c=relaxed/simple;
	bh=izJ7p1OU0lCyCKa4cgyAx8Vf4UaU956Ivc4z6abcz2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0+t9z8EQIb4SKYnFgbqJiT236Zt7mHNEIAd25p3aL53NNnOFbZOjFyhRH8Di5dbZODqHUIGq9T5Huof8RHNOaYPS9bIilqI6L3OrohjHq2B3RRQ1+Hkm/oumTXxi7id+aQz516ySY6e4LOjHDjB/MYWS6RYlj9Y0mytxiTe3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkAZihGx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xka/ZuoT5H83UsFhmNwZ/doTSozyLFCxoHnEvCahLTQ=;
	b=TkAZihGxMNPFvkhynSbnz0oymNpx4EJMvEOofcaU9/j/cq6yj5/n6oscG8ShmEPrYcJs2O
	5z0WIV7i2AZ+ETXxvRbwBFH6xTgfVG/ZXa7yKSMchctmpTv4BEsym8Jmgh26vAIzp2Dr06
	6JPary6fPKMEZ6RssnyTD0RQ+1fE67Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-HTfz1ESNP2m5lNAsjBbg7Q-1; Thu, 17 Jul 2025 03:23:40 -0400
X-MC-Unique: HTfz1ESNP2m5lNAsjBbg7Q-1
X-Mimecast-MFC-AGG-ID: HTfz1ESNP2m5lNAsjBbg7Q_1752737019
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7140227e02fso8093947b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737019; x=1753341819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xka/ZuoT5H83UsFhmNwZ/doTSozyLFCxoHnEvCahLTQ=;
        b=E61B2jLogvwnKxS9QArCyhhfx+nf3n6Yd4KnQrXfsJZ5oxaTiCWgzKdNT3WjPfHf41
         +jtPMDQC7gni1lXkSOzMKfLLf213cRf8GGfbnR65xMXfAcBMnz9pQr8LJEWRtTf7FQxE
         f6Z+GXYhsHvApzo6rntN5j5AzVLeiDu6PmsmIzHMF6dELloUnJVzzZpFOicYGW+vYEam
         uJ1FFBS/ydwvTlvMirpnJBnxmSjYT6rlD0fxHoqx2FONEAeQsU6VKK8D5LPGkx7e5+Qu
         /WXWNt+t/Mk81AYAqh7RBIXtEIZQ5jnj3fYEDzvXXw5IcKSett1YTlHYVlVY9uQyC8WT
         J+GA==
X-Forwarded-Encrypted: i=1; AJvYcCUQUmfxRAogaqjpJMqkJwZ3vI7+dS4JM2IjpYW/bWW/IMVoi22NbyOWwvcq1lZodPk8oqACFh6NP4/Dhwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbX3KSn7CqggJknUy1P14lZXD46IQP11YhH4gO12f660S4tPb9
	/i1hFDwxzRRC4/kz4KVTbnAeyQ7eLmx49wJpBUmoDCFhku7b/m0nkQMwvQEWY8P5P843+q4gJLT
	DZNL6Ci5toV43Dw7Pxrxa0PIbemtxeS9gU/Av3P8TKgy/ZlbzXUGFtBg6aSYvTX86h+VDY8hY7o
	P/rCyIanPE2+c4bNcnM7nl5WXClcaYTJSBZeCNZCwq
X-Gm-Gg: ASbGncv0Jy7Fnz9RhXsjFkCWzz2mPbEgbMInufRz6AMKWxBej6KmdlyaMBE79lFXu0H
	D3ifSTIrcBF9VzjJD4xR/iD2pVkU+SqL1ywrQD+sZMs6g66zt97By001VQ8TTEj6clwa/svEJnP
	7dyELdcWDHQ45ZsxCgubhPbQ8=
X-Received: by 2002:a05:690c:1c:b0:714:13:357a with SMTP id 00721157ae682-7183733e754mr75568637b3.20.1752737019372;
        Thu, 17 Jul 2025 00:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG062fQmQMTtzQaORYO8BQfLpIhFpvKSjhTVlHbWcaYDeY88CgnYk46dQY+VDz9L5BhRQfpAlIpXIV3Coe2VM0=
X-Received: by 2002:a05:690c:1c:b0:714:13:357a with SMTP id
 00721157ae682-7183733e754mr75568367b3.20.1752737018858; Thu, 17 Jul 2025
 00:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-6-npache@redhat.com>
 <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
In-Reply-To: <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:23:12 -0600
X-Gm-Features: Ac12FXxSdZgIpFjqwS2OfbfxZpFjuP_7yWTzmxJmAa7_DtUsx7oTR3r9FbXes2k
Message-ID: <CAA1CXcBsCagKHJndYTKr=NyNCDxvJ=wf_wo0AubFoUe=r+Rdyw@mail.gmail.com>
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

On Wed, Jul 16, 2025 at 8:03=E2=80=AFAM David Hildenbrand <david@redhat.com=
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
> >   {
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       bool writable =3D false;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- order);
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
> > +             if (order !=3D HPAGE_PMD_ORDER) {
> > +                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
>
> Doesn't compile. This is introduced way later in this series.
Whoops I stupidly applied this fixup to the wrong commit.
>
> Using something like
>
> git rebase -i mm/mm-unstable --exec "make -j16"
Ah I remember you showing me this in the past! Need to start using it
more-- Thank you.

>
> You can efficiently make sure that individual patches compile cleanly.
>
> --
> Cheers,
>
> David / dhildenb
>


