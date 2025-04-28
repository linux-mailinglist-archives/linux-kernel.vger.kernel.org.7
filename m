Return-Path: <linux-kernel+bounces-623329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2717AA9F42E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F647461216
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47D2797AB;
	Mon, 28 Apr 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQya8zTS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F78279793
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853292; cv=none; b=R5p5TPfsPnj5TSTkwTBy/tIhpvBc1n6a/ffoYmk9MMcFSrccHxHubXBI/sN67zk2J5rk72/I0apHiQDkc2n309DtgDjJVy7GOZxNq7Aj15+Ey+ToOT9U79YFhAObZ4c1kzlXO89uh3qlzVhglpAYdutizI2onLbxZDf5HBN9sRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853292; c=relaxed/simple;
	bh=S4pf5df7gPKDRNUt679p+IGvhuV0gWOWRwj3sJZ3isI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pxe3450MfkGMoucJi7Ze0r9DYCgS1ZTmsgo9e0KQsUBVBs4A58eN4YWj7lzYLdUNTUiZKm5cX1ym/FGKnKDhZuWuiaQIidrlALEgGsrroasR438YHSqi1EUcPK+TzXZz0OHQwBgP69D5FOYWDSid+AAyVeDc0GKHWiWTqGT4Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQya8zTS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745853289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjjyMBRvSNsS6dnqJloTlotMI0xOp2Rm/B1dpZszNbY=;
	b=WQya8zTS7LyhU6yI4Ip5ZF4nZnpzMYWbf8bLp0013cYeKf6tHFM7Db33hLAysovAzRiOS/
	QBpKNYCidUakAs95yB0PhQ2EJm4lFEJwBBOyESsTNJTR/rqvknsnCgAzx8QVqx/tVjZun+
	CIRYl+yGjQ5oC15xdx49h4pxdCPNH/Q=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-1fDANRGLMn-RY7C1Ns4MTQ-1; Mon, 28 Apr 2025 11:14:48 -0400
X-MC-Unique: 1fDANRGLMn-RY7C1Ns4MTQ-1
X-Mimecast-MFC-AGG-ID: 1fDANRGLMn-RY7C1Ns4MTQ_1745853287
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e72ecef490dso7002334276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 08:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853287; x=1746458087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjjyMBRvSNsS6dnqJloTlotMI0xOp2Rm/B1dpZszNbY=;
        b=WRXDlg3v1ffkGh5xyw8Ry4Ogtxll6qDJD2GHkqU0uYc1JcdGDTh0v5y2eJIza4Ydo6
         3yDJ0IgmMfxZfmct9geoMhC60V0BS9Y4tJ9nVQiEUYNXocYpkFkbh8d9AKmMH2+S/lGk
         q/IgutfVbkSdSg/WKbBbPcHwWN8ftMsDsXznYycjBPC71xrkzrIQU19YooMkU6dAO5+G
         Jo6QGY39BQxvcJsMhdBOI6AjdYsFL8hxX+iNsmSX1uJcyxemjPWSC/p5O3NW75tj5VKy
         yx9O9gTxvFhgsRLmnMx3ysHFlyrrC5AnzTYMYRsLk7WQxrTtYUyAVtRpeg7V8zsYWj+K
         8D8g==
X-Forwarded-Encrypted: i=1; AJvYcCVoxh3bHurF/D8oj2wRXQPsxTdiJ7v8tTYPAjjhW1lsN9bHMNV1POxaOaR0+QJL+Q3M6UkGGBsyxyyNcv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyApRuJz8NBP/1gpXgxkoQHfKhq05OylJg7k5r9d5olXRBu78gM
	90lsCj9qYM99NQPeJ33fbEUgwP/Z2k0h8ch/yxfb65OnhzbUQPPth4Irbp48r9vtWTmbH1usGds
	dGY60HqWJi8+x2P9x6CnR8M5nXwSPdP5ehzDavI3TS4lOI1RMC3PBheUoXLMJFnmidVOuZ6Zp8w
	/luv9Ixnk9gHKSSEN5gAjBaEZxrIrQL9CI7ELg
X-Gm-Gg: ASbGncuTw+HKy65H5oQGMKQfY1qnV7Bw0O1wLTnXjTp5TPcsdu4tkh/VQDbhZ8M4d5D
	LkK12xX/auCFcKYqcI9hV0cnGJQlbVrR3C+j6maLbR1tx1sCrWNwPM/bDPWW1+kV0EU4GGguCm7
	unB11tepU=
X-Received: by 2002:a05:6902:1691:b0:e72:b82f:a62 with SMTP id 3f1490d57ef6-e732338428emr12388828276.11.1745853287364;
        Mon, 28 Apr 2025 08:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQdul3A5EarKqlA5mZybRLGXZ4/QGFzm5O/Rn0LlhZDMqb+AyohF9IHRKyVUz9+QLono3O44QqHXuutalBV+w=
X-Received: by 2002:a05:6902:1691:b0:e72:b82f:a62 with SMTP id
 3f1490d57ef6-e732338428emr12388775276.11.1745853286923; Mon, 28 Apr 2025
 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417000238.74567-1-npache@redhat.com> <20250417000238.74567-8-npache@redhat.com>
 <3f52af67-489d-46b0-867f-202b59864692@linux.alibaba.com>
In-Reply-To: <3f52af67-489d-46b0-867f-202b59864692@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 28 Apr 2025 09:14:20 -0600
X-Gm-Features: ATxdqUE1-ghfmwQWJLFqSCetfoKF9b5qAMQVrSq3Yt4f4-WqyBvTxhAi8tnCnig
Message-ID: <CAA1CXcAMeEsg7zVkftrZ2mfy9yuB-XiwXmNcn684xR7p-B0RxA@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] khugepaged: add mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org, 
	peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:22=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/4/17 08:02, Nico Pache wrote:
> > Introduce the ability for khugepaged to collapse to different mTHP size=
s.
> > While scanning PMD ranges for potential collapse candidates, keep track
> > of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> > represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. I=
f
> > mTHPs are enabled we remove the restriction of max_ptes_none during the
> > scan phase so we dont bailout early and miss potential mTHP candidates.
> >
> > After the scan is complete we will perform binary recursion on the
> > bitmap to determine which mTHP size would be most efficient to collapse
> > to. max_ptes_none will be scaled by the attempted collapse order to
> > determine how full a THP must be to be eligible.
> >
> > If a mTHP collapse is attempted, but contains swapped out, or shared
> > pages, we dont perform the collapse.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 88 insertions(+), 34 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 83230e9cdf3a..ece39fd71fe6 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1136,13 +1136,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >   {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > -     pte_t *pte;
> > +     pte_t *pte, mthp_pte;
> >       pgtable_t pgtable;
> >       struct folio *folio;
> >       spinlock_t *pmd_ptl, *pte_ptl;
> >       int result =3D SCAN_FAIL;
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> > +     unsigned long _address =3D address + offset * PAGE_SIZE;
> >
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> > @@ -1158,12 +1159,13 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >               *mmap_locked =3D false;
> >       }
> >
> > -     result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > +     result =3D alloc_charge_folio(&folio, mm, cc, order);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> > +     *mmap_locked =3D true;
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, o=
rder);
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> > @@ -1181,13 +1183,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >                * released when it fails. So we jump out_nolock directly=
 in
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> > -             result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                             referenced, HPAGE_PMD_ORDER);
> > +             result =3D __collapse_huge_page_swapin(mm, vma, _address,=
 pmd,
> > +                             referenced, order);
> >               if (result !=3D SCAN_SUCCEED)
> >                       goto out_nolock;
> >       }
> >
> >       mmap_read_unlock(mm);
> > +     *mmap_locked =3D false;
> >       /*
> >        * Prevent all access to pagetables with the exception of
> >        * gup_fast later handled by the ptep_clear_flush and the VM
> > @@ -1197,7 +1200,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, o=
rder);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> > @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >       vma_start_write(vma);
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -                             address + HPAGE_PMD_SIZE);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address=
,
> > +                             _address + (PAGE_SIZE << order));
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> > +
> >       /*
> >        * This removes any huge TLB entry from the CPU so we won't allow
> >        * huge and small TLB entries for the same virtual address to
> > @@ -1226,10 +1230,10 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >       mmu_notifier_invalidate_range_end(&range);
> >       tlb_remove_table_sync_one();
> >
> > -     pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> > +     pte =3D pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
> >       if (pte) {
> > -             result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > -                                     &compound_pagelist, HPAGE_PMD_ORD=
ER);
> > +             result =3D __collapse_huge_page_isolate(vma, _address, pt=
e, cc,
> > +                                     &compound_pagelist, order);
> >               spin_unlock(pte_ptl);
> >       } else {
> >               result =3D SCAN_PMD_NULL;
> > @@ -1258,8 +1262,8 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       anon_vma_unlock_write(vma->anon_vma);
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > -                                        vma, address, pte_ptl,
> > -                                        &compound_pagelist, HPAGE_PMD_=
ORDER);
> > +                                        vma, _address, pte_ptl,
> > +                                        &compound_pagelist, order);
> >       pte_unmap(pte);
>
> pte is unmapped here, but...
>
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> >               goto out_up_write;
> > @@ -1270,20 +1274,35 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >        * write.
> >        */
> >       __folio_mark_uptodate(folio);
> > -     pgtable =3D pmd_pgtable(_pmd);
> > -
> > -     _pmd =3D folio_mk_pmd(folio, vma->vm_page_prot);
> > -     _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > -
> > -     spin_lock(pmd_ptl);
> > -     BUG_ON(!pmd_none(*pmd));
> > -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
> > -     folio_add_lru_vma(folio, vma);
> > -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -     set_pmd_at(mm, address, pmd, _pmd);
> > -     update_mmu_cache_pmd(vma, address, pmd);
> > -     deferred_split_folio(folio, false);
> > -     spin_unlock(pmd_ptl);
> > +     if (order =3D=3D HPAGE_PMD_ORDER) {
> > +             pgtable =3D pmd_pgtable(_pmd);
> > +             _pmd =3D folio_mk_pmd(folio, vma->vm_page_prot);
> > +             _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > +
> > +             spin_lock(pmd_ptl);
> > +             BUG_ON(!pmd_none(*pmd));
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +             set_pmd_at(mm, address, pmd, _pmd);
> > +             update_mmu_cache_pmd(vma, address, pmd);
> > +             deferred_split_folio(folio, false);
> > +             spin_unlock(pmd_ptl);
> > +     } else { //mTHP
>
> (Nit: use '/* xxx */' format)
>
> > +             mthp_pte =3D mk_pte(&folio->page, vma->vm_page_prot);
> > +             mthp_pte =3D maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> > +
> > +             spin_lock(pmd_ptl);
> > +             folio_ref_add(folio, (1 << order) - 1);
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order=
));
>
> You still used the unmapped pte? Looks incorrect to me.
Ah, I need to move the unmap to after we collapse. Only effects
highmem, but it should be an easy fix!

Thanks!
>
> > +             update_mmu_cache_range(NULL, vma, _address, pte, (1 << or=
der));
> > +
> > +             smp_wmb(); /* make pte visible before pmd */
> > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > +             spin_unlock(pmd_ptl);
> > +     }
> >
> >       folio =3D NULL;
> >
> > @@ -1364,31 +1383,58 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >   {
> >       pmd_t *pmd;
> >       pte_t *pte, *_pte;
> > +     int i;
> >       int result =3D SCAN_FAIL, referenced =3D 0;
> >       int none_or_zero =3D 0, shared =3D 0;
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       unsigned long _address;
> > +     unsigned long enabled_orders;
> >       spinlock_t *ptl;
> >       int node =3D NUMA_NO_NODE, unmapped =3D 0;
> > +     bool is_pmd_only;
> >       bool writable =3D false;
> > -
> > +     int chunk_none_count =3D 0;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- KHUGEPAGED_MIN_MTHP_ORDER);
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> >       result =3D find_pmd_or_thp_or_none(mm, address, &pmd);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out;
> >
> > +     bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > +     bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> >       nodes_clear(cc->alloc_nmask);
> > +
> > +     enabled_orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
> > +             tva_flags, THP_ORDERS_ALL_ANON);
> > +
> > +     is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORDER));
> > +
> >       pte =3D pte_offset_map_lock(mm, pmd, address, &ptl);
> >       if (!pte) {
> >               result =3D SCAN_PMD_NULL;
> >               goto out;
> >       }
> >
> > -     for (_address =3D address, _pte =3D pte; _pte < pte + HPAGE_PMD_N=
R;
> > -          _pte++, _address +=3D PAGE_SIZE) {
> > +     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +             /*
> > +              * we are reading in KHUGEPAGED_MIN_MTHP_NR page chunks. =
if
> > +              * there are pages in this chunk keep track of it in the =
bitmap
> > +              * for mTHP collapsing.
> > +              */
> > +             if (i % KHUGEPAGED_MIN_MTHP_NR =3D=3D 0) {
> > +                     if (chunk_none_count <=3D scaled_none)
> > +                             bitmap_set(cc->mthp_bitmap,
> > +                                        i / KHUGEPAGED_MIN_MTHP_NR, 1)=
;
> > +
> > +                     chunk_none_count =3D 0;
> > +             }
> > +
> > +             _pte =3D pte + i;
> > +             _address =3D address + i * PAGE_SIZE;
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (is_swap_pte(pteval)) {
> >                       ++unmapped;
> > @@ -1411,10 +1457,11 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >                       }
> >               }
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > +                     ++chunk_none_count;
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> > -                         (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                         (!cc->is_khugepaged || !is_pmd_only ||
> > +                             none_or_zero <=3D khugepaged_max_ptes_non=
e)) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -1510,6 +1557,7 @@ static int khugepaged_scan_pmd(struct mm_struct *=
mm,
> >                                                                    addr=
ess)))
> >                       referenced++;
> >       }
> > +
> >       if (!writable) {
> >               result =3D SCAN_PAGE_RO;
> >       } else if (cc->is_khugepaged &&
> > @@ -1522,8 +1570,12 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
> >   out_unmap:
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> > -             result =3D collapse_huge_page(mm, address, referenced,
> > -                                         unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
> > +             result =3D khugepaged_scan_bitmap(mm, address, referenced=
, unmapped, cc,
> > +                            mmap_locked, enabled_orders);
> > +             if (result > 0)
> > +                     result =3D SCAN_SUCCEED;
> > +             else
> > +                     result =3D SCAN_FAIL;
> >       }
> >   out:
> >       trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenc=
ed,
> > @@ -2479,11 +2531,13 @@ static int khugepaged_collapse_single_pmd(unsig=
ned long addr,
> >                       fput(file);
> >                       if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> >                               mmap_read_lock(mm);
> > +                             *mmap_locked =3D true;
> >                               if (khugepaged_test_exit_or_disable(mm))
> >                                       goto end;
> >                               result =3D collapse_pte_mapped_thp(mm, ad=
dr,
> >                                                                !cc->is_=
khugepaged);
> >                               mmap_read_unlock(mm);
> > +                             *mmap_locked =3D false;
> >                       }
> >               } else {
> >                       result =3D khugepaged_scan_pmd(mm, vma, addr,
>


