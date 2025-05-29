Return-Path: <linux-kernel+bounces-666450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF26AC76EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6A81C00128
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2D24889B;
	Thu, 29 May 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhutgSwl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848001DDA09
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491293; cv=none; b=tTM0+yoFuUbGDmiHzjKeDXWaKKrDG6KzggJnpDkwTJSJNCni5ASz2kBgYqg1GXErUE/pIHqdNp5ZD9gb1Bw5J0DUMj2eaeMHfWxyG7NHyfby1CuokPKOERi1zNW+rZH7EKhEevPU7SJpbWKo65rHQqJNcAu9OeHY7Xo7cLlq0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491293; c=relaxed/simple;
	bh=6zwi+lwpja8jONgGrSjw+PBtVi0OoLrrndZJYTEkhXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH49Ugd50LfTKD4bT0zzkxL0fQZ+KsEkjcuMOCs8CixFC92+04p9afHrcNTcRkmhh/F4KVrBvN8rx4BTnt4BtjCPaBdCTT7xtmnzUo8KVeKkwqFsbDKB4irSIzKa/qo7LpqGL1jLiQr6YhTtoAbO69xzHBWmYghBcDVWfvxdtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhutgSwl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748491290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdZD3eLj8BPhi4SnBTvGR++g8kVMb0vmyEhX37mJ42w=;
	b=LhutgSwlDEvadKS5kIXwJD29LuV+fmGq9K6cCHb8apuZjY0magpxDKXGr9ViJ74ivuTLIo
	bUCgosYwcALaV8ozE5C5xZS51MGxrKibn8gk8Uu4+9xWCoNwBJuLUA9pf20CrfL3UrVcMR
	z0625U/FVZzzVRKaBCJwDQBsw54s+bI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-9tBP-JF1NFKYdoK1xYMJXg-1; Thu, 29 May 2025 00:01:26 -0400
X-MC-Unique: 9tBP-JF1NFKYdoK1xYMJXg-1
X-Mimecast-MFC-AGG-ID: 9tBP-JF1NFKYdoK1xYMJXg_1748491286
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e84239a18so9641777b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748491286; x=1749096086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdZD3eLj8BPhi4SnBTvGR++g8kVMb0vmyEhX37mJ42w=;
        b=xHlUvu7t1/yD+sU+W7WMtQO0iKbI/6xNxXUv/xkNmu3pApHVtPnbkIZ2wwlZzlrHQR
         Wzxiz72JodT5QXxTvBUCIILZ/f0SlIkNwNkZTOH/tjhQTsOLyUWLL7V8PHN5XenY1WPf
         v3RY+Oo6z5XrQD50mp7Olv1YdvULirzbQXYfcyQfM2PKfPNdNZKJKpXPklpvs2schWE5
         yoUDPLMg/kdEyo5ER69gi2gw9J220d10BPbnB1uJ2IQpPNSsbHsgEjzettDDimFxXYY6
         XwYaQG5ujgYPC1OFZl7K+PS9+RMc91hZ1T20AEllq5U2BhSDBmI+8dsa7c6+DnQK2H2C
         Xzdg==
X-Forwarded-Encrypted: i=1; AJvYcCUvjthN9jrTH+oTcUN7VbYNhWErT57Hes1kqrZz2Lw95hz9cM1Gp5aCzqOLC9/F/QxPd1LjWXC3YGKFpVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRFc49I2S4yVshj/xjT5x90lXSz/vUHxSukzd2dCdR4uc6uMk
	hLTcmVQBi7tiGdWxoBXqbER9F0CV3LOZ4kksHZZ3cZXBI/uNkVx+IHKSc/i8blYDxYDqRP0wwu2
	qJfiKC6QJroe/fRRFfPoEmrwMyoX4w7oexQu21/C/4mmcltD999iMdTupSPBlZ5F5ZZBRK8WyaX
	SJUA7xT/eUqTSRYnoTTo43pD3Hz5yOa3Y9qT+fz7Ao
X-Gm-Gg: ASbGncsub3iiBElqhqJGrljKE7IrCbHQVvEIUdmu7iSdL+gXeqzyDhLRw94fpkyP4R/
	lar/vHFoEovAbU/jUxWQTdxz8OPz5KasiP7ZLyLSupvRWYcQ5P2Id8P2QOWwJWWj26Ij3q+A=
X-Received: by 2002:a05:690c:4a13:b0:702:52fb:4649 with SMTP id 00721157ae682-70e2da99718mr278493737b3.27.1748491286033;
        Wed, 28 May 2025 21:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/yZLcLc3txNpeZouVWYk/6Xmo1Cjg1FspO8FQ3zV/IYnHesrozNpZ0luNE/6fjxJki5Y088qo5VH9wGT2Cho=
X-Received: by 2002:a05:690c:4a13:b0:702:52fb:4649 with SMTP id
 00721157ae682-70e2da99718mr278492977b3.27.1748491285627; Wed, 28 May 2025
 21:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-4-npache@redhat.com>
 <469db7d1-ba99-4dc7-af13-b5fe850d4031@linux.alibaba.com>
In-Reply-To: <469db7d1-ba99-4dc7-af13-b5fe850d4031@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 28 May 2025 22:00:59 -0600
X-Gm-Features: AX0GCFvp2IzRLPRT1BH86a_zgN-TzhadgRt8Zk5HbZpa3tiDelBNICuvN8qwjx4
Message-ID: <CAA1CXcA4a3pJ_dJ77TvRRimPiNYacyRe5GMY=iUEz-27NHCVxQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
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
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:55=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/5/15 11:22, Nico Pache wrote:
> > For khugepaged to support different mTHP orders, we must generalize thi=
s
> > to check if the PMD is not shared by another VMA and the order is
> > enabled.
> >
> > No functional change in this patch.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5457571d505a..0c4d6a02d59c 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -920,7 +920,7 @@ static int khugepaged_find_target_node(struct colla=
pse_control *cc)
> >   static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned lon=
g address,
> >                                  bool expect_anon,
> >                                  struct vm_area_struct **vmap,
> > -                                struct collapse_control *cc)
> > +                                struct collapse_control *cc, int order=
)
> >   {
> >       struct vm_area_struct *vma;
> >       unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> > @@ -934,7 +934,7 @@ static int hugepage_vma_revalidate(struct mm_struct=
 *mm, unsigned long address,
> >
> >       if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>
> Sorry, I missed this before. Should we also change 'PMD_ORDER' to
> 'order' for the thp_vma_suitable_order()?
This was changed since the last version (v5) due to an email from Hugh.
https://lore.kernel.org/lkml/7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.co=
m/

As I noted in my reply to him, although he was not able to reproduce
an issue due to this, we always need to revalidate the PMD order to
verify the PMD range is not shared by another VMA.

-- Nico
>
> >               return SCAN_ADDRESS_RANGE;
> > -     if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_O=
RDER))
> > +     if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, order=
))
> >               return SCAN_VMA_CHECK;
> >       /*
> >        * Anon VMA expected, the address may be unmapped then
> > @@ -1130,7 +1130,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> > @@ -1164,7 +1164,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> > @@ -2782,7 +2782,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
struct vm_area_struct **prev,
> >                       mmap_read_lock(mm);
> >                       mmap_locked =3D true;
> >                       result =3D hugepage_vma_revalidate(mm, addr, fals=
e, &vma,
> > -                                                      cc);
> > +                                                      cc, HPAGE_PMD_OR=
DER);
> >                       if (result  !=3D SCAN_SUCCEED) {
> >                               last_fail =3D result;
> >                               goto out_nolock;
>


