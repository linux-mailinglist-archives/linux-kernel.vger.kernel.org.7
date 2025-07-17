Return-Path: <linux-kernel+bounces-734806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4806B08689
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92487B0B79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BEC221FB8;
	Thu, 17 Jul 2025 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWBDXgca"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F6221F2D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737054; cv=none; b=qMyqYa2lrl3SXVVCuO7H6fJTWI7x96t0jtxFlyUXT7eRP9gkmgf4O9nhrYOjPAGAFdhtKP0wWCrkPzHVvOv9D0YiVas3IURJO6LJggOSeJ6Jg8pJkEBi0nygxbxWiXFtOKoo/A/iTHAivJUeONFEg3qSffqhaapeS5sFoxIO6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737054; c=relaxed/simple;
	bh=iLhzbbB7DAAxVrNZpn9R8/crsoEMUDnPJf4FnVwDO38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlDFmS3xcXjTTNxAVv1cmNvn2q/Lizdr5codQwt9Qpz1n2jln3zKS50oRb6PH8gNNNWsgrW85Vy30pFCERXmkaQMV/fBNedAOxdBPkfsG6KmJM5WVKr/VdEUc7kRqEUPx00aTr9XxvtRgywpgmYABYqTGWuqMlKBR6+41JKaPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWBDXgca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfCPGePoOp3LYY/EgVnEL9WU60m9R4sUTYWVjJ8p3AQ=;
	b=IWBDXgcaOWZYGHB5UQIE9sVwMcdQ3SGK68V0g1EWdBMOdP9f+WV7mDO8ThLaAOcEYy+y+9
	OmSYFEslJLUoDgnJ+OYjgMZKIPnu3PY/IBNAkD4IjTy4K5QQqcDvN0P6uwwhOfqTDzCary
	+BCEs3ga5xjLgHeiIuzd60STdYhZs84=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-UQSNDmkLMxuJ11u_rFQcMQ-1; Thu, 17 Jul 2025 03:24:09 -0400
X-MC-Unique: UQSNDmkLMxuJ11u_rFQcMQ-1
X-Mimecast-MFC-AGG-ID: UQSNDmkLMxuJ11u_rFQcMQ_1752737049
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-710e75f9229so8886027b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737049; x=1753341849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfCPGePoOp3LYY/EgVnEL9WU60m9R4sUTYWVjJ8p3AQ=;
        b=W/S0un/ayb6BRjfVUW8LyTVvtVpi2IWp09B/Ggve2s9zGdxqvYOAWBCicrDOa4CbpL
         G6gRtwX8HJPMzPAXWY1eisxBOEfi2ClSz/bPwfHJVfvqowWiO7kG/60xgbDoTtC7AEQA
         1JKMBhwGhaQXNw/x1uMMxRxzIwHvK+UHVI1uQ3Q1lPHYUGdGnUFx1M0sSCbbR9iusrts
         ns1A3a03reVDZUfIL58m4zNNRM0lVlh9SLIrOMqklqfZpqTzCUOoZmhIJIH+ivWOq8Id
         gu7mwT3njT6u+ZnD+I8s3DfQMYobvlE7PxDjqe/kR2jYa9vLT4Z39KZ2W+4Le0sZ31Ux
         Hkaw==
X-Forwarded-Encrypted: i=1; AJvYcCWGLKqvjt9AvKFQeFEEuMOjMlfozCVmvlFimjAUfBc2qeADdR2Dq1EWffQh4RtbVH7JRMOS9c2AV49F7RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEV+3k13nVbU3grxWCqPncFofQPqgLPjOGyOrUZ9qLdHH5oGc
	IjsCwTXrSc7u8qKYop5W6qrpouyf2LOdVA7Gf47XtEpOHD2jOJs0bqapBtTrqdcUy6tZbxyGTMQ
	D7cm31oM8mXhRdhAfuO1sRVO8qwAdxynBSLrGLsKP1fRfSMMKJ7sKWGmDOp6UHhc2Tndtfh3/Wt
	MjCp1kO0CS3XzdqO1sn341LFnxonqCe+h0F3g2RVxv
X-Gm-Gg: ASbGncuUvMD7RWxgNQCIR2Ai7Lef7tKNYgPcZkoZBPPcRDahAETj2gHpz8Ri1Rj5HSh
	NlQwYG4JkOpD01LRtopIX+Ax9L0dNQ74c5UG5/MJvSX7xWdAp6gSJnDIKVpfLp3T/oeGreevZXM
	5sc95dZkNc3uXlmez0Nji0ITc=
X-Received: by 2002:a05:690c:9a83:b0:714:250:833a with SMTP id 00721157ae682-71835178c52mr75128737b3.27.1752737048791;
        Thu, 17 Jul 2025 00:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfJvKaPzv08Vi4PZEJPmCDSNU/tGELVSQ+5Z8J3b7WhlI4rCEfMfiHtnXHhhga1V1PSe4f41mdlF7ouQLMBAo=
X-Received: by 2002:a05:690c:9a83:b0:714:250:833a with SMTP id
 00721157ae682-71835178c52mr75128277b3.27.1752737048378; Thu, 17 Jul 2025
 00:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-7-npache@redhat.com>
 <82cd57c2-d72f-423a-8dbc-d9b64d1d469b@redhat.com>
In-Reply-To: <82cd57c2-d72f-423a-8dbc-d9b64d1d469b@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:23:42 -0600
X-Gm-Features: Ac12FXxiLSehaUAA88Omm39G4YDE8fV_Jkcck06oY9gUgXBKp4aUCgW1_s9ZvsQ
Message-ID: <CAA1CXcAFyQDZ_n2TLSLVCY0dqt0tudwaOceb+i9tDOLNo9rzZw@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] khugepaged: introduce collapse_scan_bitmap for
 mTHP support
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
> > khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> > To add mTHP support we use this scan to instead record chunks of utiliz=
ed
> > sections of the PMD.
> >
> > collapse_scan_bitmap uses a stack struct to recursively scan a bitmap
> > that represents chunks of utilized regions. We can then determine what
> > mTHP size fits best and in the following patch, we set this bitmap whil=
e
> > scanning the anon PMD. A minimum collapse order of 2 is used as this is
> > the lowest order supported by anon memory.
> >
> > max_ptes_none is used as a scale to determine how "full" an order must
> > be before being considered for collapse.
> >
> > When attempting to collapse an order that has its order set to "always"
> > lets always collapse to that order in a greedy manner without
> > considering the number of bits set.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> Any reason this should not be squashed into the actual mTHP collapse patc=
h?
I wanted to keep them seperate to conceptually separate the bitmap and
collapse, but given youre the second person to point this out, I went
ahead and squashed them and their commit messages to be one commit.
>
> In particular
>
> a) The locking changes look weird without the bigger context
>
> b) The compiler complains about unused functions
>
> > ---
> >   include/linux/khugepaged.h |  4 ++
> >   mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++---=
-
> >   2 files changed, 89 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index ff6120463745..0f957711a117 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -1,6 +1,10 @@
> >   /* SPDX-License-Identifier: GPL-2.0 */
> >   #ifndef _LINUX_KHUGEPAGED_H
> >   #define _LINUX_KHUGEPAGED_H
> > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> > +#define KHUGEPAGED_MIN_MTHP_NR       (1<<KHUGEPAGED_MIN_MTHP_ORDER)
>
> "1 << "
Ah there is a mix of these ("1<<" vs "1 << ") being used across the
kernel. Fixed it thank you.
>
> > +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPA=
GED_MIN_MTHP_ORDER))
> > +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP=
_ORDER))
> >
> >   extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ee54e3c1db4e..59b2431ca616 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
> >
> >   static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +struct scan_bit_state {
> > +     u8 order;
> > +     u16 offset;
> > +};
> > +
> >   struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -102,6 +107,18 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /*
> > +      * bitmap used to collapse mTHP sizes.
> > +      * 1bit =3D order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> > +      */
> > +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> > +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> > +};
> > +
> > +struct collapse_control khugepaged_collapse_control =3D {
> > +     .is_khugepaged =3D true,
> >   };
> >
> >   /**
> > @@ -838,10 +855,6 @@ static void khugepaged_alloc_sleep(void)
> >       remove_wait_queue(&khugepaged_wait, &wait);
> >   }
> >
> > -struct collapse_control khugepaged_collapse_control =3D {
> > -     .is_khugepaged =3D true,
> > -};
> > -
> >   static bool collapse_scan_abort(int nid, struct collapse_control *cc)
> >   {
> >       int i;
> > @@ -1115,7 +1128,8 @@ static int alloc_charge_folio(struct folio **foli=
op, struct mm_struct *mm,
> >
> >   static int collapse_huge_page(struct mm_struct *mm, unsigned long add=
ress,
> >                             int referenced, int unmapped,
> > -                           struct collapse_control *cc)
> > +                           struct collapse_control *cc, bool *mmap_loc=
ked,
> > +                               u8 order, u16 offset)
>
> Indent broken.
Fixed!
>
> >   {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > @@ -1134,8 +1148,12 @@ static int collapse_huge_page(struct mm_struct *=
mm, unsigned long address,
> >        * The allocation can take potentially a long time if it involves
> >        * sync compaction, and we do not need to hold the mmap_lock duri=
ng
> >        * that. We will recheck the vma after taking it again in write m=
ode.
> > +      * If collapsing mTHPs we may have already released the read_lock=
.
> >        */
> > -     mmap_read_unlock(mm);
> > +     if (*mmap_locked) {
> > +             mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> > +     }
> >
> >       result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> >       if (result !=3D SCAN_SUCCEED)
> > @@ -1272,12 +1290,72 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >   out_up_write:
> >       mmap_write_unlock(mm);
> >   out_nolock:
> > +     *mmap_locked =3D false;
> >       if (folio)
> >               folio_put(folio);
> >       trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
> >       return result;
> >   }
> >
> > +/* Recursive function to consume the bitmap */
> > +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long ad=
dress,
> > +                     int referenced, int unmapped, struct collapse_con=
trol *cc,
> > +                     bool *mmap_locked, unsigned long enabled_orders)
> > +{
> > +     u8 order, next_order;
> > +     u16 offset, mid_offset;
> > +     int num_chunks;
> > +     int bits_set, threshold_bits;
> > +     int top =3D -1;
> > +     int collapsed =3D 0;
> > +     int ret;
> > +     struct scan_bit_state state;
> > +     bool is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORDER=
));
> > +
> > +     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit_state)
> > +             { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> > +
> > +     while (top >=3D 0) {
> > +             state =3D cc->mthp_bitmap_stack[top--];
> > +             order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> > +             offset =3D state.offset;
> > +             num_chunks =3D 1 << (state.order);
> > +             // Skip mTHP orders that are not enabled
>
>
> /* */
>
> Same applies to the other instances.
Thank you! Fixed all instances
>
> --
> Cheers,
>
> David / dhildenb
>


