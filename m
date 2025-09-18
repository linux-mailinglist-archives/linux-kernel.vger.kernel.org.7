Return-Path: <linux-kernel+bounces-786728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56927B3661E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D661BC51A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563A34F467;
	Tue, 26 Aug 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKDhKoTs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691E226861
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216007; cv=none; b=C5Q0uPWKqu1wcmJRA/tA3mSiSC3keaNzdCjYbNzbuMNOB2d1lX11YU6EfQiKYVV8B79V8RAGfJTAwfBr227V4SIvIK94DCkxItUq5KsySJFSLRatCqitJ7SA/op+MrJFTDisnU2b9VZriX6tDQha87JSRaZLuy8J8M2ZK2Gsaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216007; c=relaxed/simple;
	bh=aEW8TLxUhDGilGZ76RbUuftqJyu2PcJJHQluxIUny4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKMBHGfiJhHJ4hTmBD5a5OD9H3Z9VFvW2tMLThbZafwOSiwZKQyZrpEQpmOEbCFuDVDUU4eoRjQwGzduYFZVYuZcw1Pn7D2qIrgOKXMVvUs7u+kKOqHU8/YZjKnoCHxDdoRs7QK3IriM9jsFqHv4HA0ex85h0xa4CfZPR4Axw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKDhKoTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756216004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3uSnnXl39wQmO2qN0SfNv5WwjyU8sgsdnwZmwwH7nE=;
	b=eKDhKoTsthIR9V7IhXSbPghTDdugCXkVV46ldrBc66dVlpk1/uObmMGOtyv/sLZRrtNK9e
	6JKRP+7TDZ7zxV/Bi5WNLM8ScHecCOvYwoW3QzYdA1LYv12Twk6oDkyMYXDdFUDE5kRwQD
	18JmH7PfiT8twGP1duX5/YxuolrRETM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-VgLx-toZOS-G7hRJpzkoTQ-1; Tue, 26 Aug 2025 09:46:43 -0400
X-MC-Unique: VgLx-toZOS-G7hRJpzkoTQ-1
X-Mimecast-MFC-AGG-ID: VgLx-toZOS-G7hRJpzkoTQ_1756216003
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e931c89608dso7398648276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216003; x=1756820803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3uSnnXl39wQmO2qN0SfNv5WwjyU8sgsdnwZmwwH7nE=;
        b=orDUQlCSFB6POBIA/2WRBsd8l4JexXyZ14+u1sPIZNeBjZ/xqDl+NOJzycqrcTGACE
         mZUNZvfS4KEJtRuw4uO/+O7PGqxdby6egzoMLY57Z5TVrjH4BUhNArKP4tpTsX8m6Mmi
         VHphpEbfL8VQ6o6vFG5Go/XwkuCG/5Ct+ScRWz6Pd3mT/pdDxC2OBDFE8QaN/3CSyRiC
         lSz6Q94SVfuZLx4U7AaxtphVozCJjiueguBe7rBLiluzKo60yJ2zLB3tvjmSW4gf7rmQ
         NzV0/uvJNMflaVHoMbUqX9NJ7IEeBcthBEu4VBvwFBnLYkyobGQTf0GSX9GlLshH19Xr
         k3lg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPC3fu4xDAQUuuxwLo2I8YornoCcWnv9nn3/KB1YVJ2a1JocFQO98oszrT/GVmfnNRKkDF6sfptzmbVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymh8ePnM7vn2lTM/OZe/fTD9Of6rb31fx5RouXDWJ742TuvR/F
	huRyQgxUwLStZf7Hrhe/++N8NfeYvZ+plGvgIMKYdBdFFlHx5j1JwSrAPGMI++Pku1GeoLVvR4n
	Uhah0JZ+J+zBEhh+YNJVBW/tBrpG4PEwC63wJBCWUSbWwSS+6FuuLho/a2JyTeN9Ow4AU8y06tv
	C//RL+vvGA1Hh5QjMttW3FwZ3Xkl4j2s7NyimxLVk1
X-Gm-Gg: ASbGncs0bk/6zXMoiR8pdM8f8xiI5IsPRVpiNv0Fysefmqk/w7Jw+q9yh5qKC32XSLM
	uZkwBZXIldaAv4Y6ogVXrIaY9uJPOACMD4seovA7iFP7/OxwuBtPEUbwgDxQn60gOd+TsswGsyK
	Hn4zJZC0TDNUtF7ScY1ze1YrI=
X-Received: by 2002:a05:6902:1505:b0:e90:11bb:397c with SMTP id 3f1490d57ef6-e951c2e6476mr17866634276.10.1756216002401;
        Tue, 26 Aug 2025 06:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuxDJCtt4uGtkkNwYc+l5uBaWSrMn5+Sn6RTFNkIfr9/PHfQUvWNUMSRZXgQlOWs52bnkehKXLBXOH5bnIPQs=
X-Received: by 2002:a05:6902:1505:b0:e90:11bb:397c with SMTP id
 3f1490d57ef6-e951c2e6476mr17866565276.10.1756216001425; Tue, 26 Aug 2025
 06:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819134205.622806-4-npache@redhat.com>
 <20250824013746.bvsz3vajjj2kphrl@master>
In-Reply-To: <20250824013746.bvsz3vajjj2kphrl@master>
From: Nico Pache <npache@redhat.com>
Date: Tue, 26 Aug 2025 07:46:14 -0600
X-Gm-Features: Ac12FXyLvLHJcV0w6rar3RVrCz2fxN5NrCxMe4grcCkIazMUynhHT0ZTM7eshuk
Message-ID: <CAA1CXcBskENLPGB3zCNu0UpPqMMRtSiQuAdLPDPsEZt6ne6JnA@mail.gmail.com>
Subject: Re: [PATCH v10 03/13] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
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

On Sat, Aug 23, 2025 at 7:37=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> Hi, Nico
>
> Some nit below.
>
> On Tue, Aug 19, 2025 at 07:41:55AM -0600, Nico Pache wrote:
> >For khugepaged to support different mTHP orders, we must generalize this
> >to check if the PMD is not shared by another VMA and the order is enable=
d.
> >
> >To ensure madvise_collapse can support working on mTHP orders without th=
e
> >PMD order enabled, we need to convert hugepage_vma_revalidate to take a
> >bitmap of orders.
> >
> >No functional change in this patch.
> >
> >Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >Acked-by: David Hildenbrand <david@redhat.com>
> >Co-developed-by: Dev Jain <dev.jain@arm.com>
> >Signed-off-by: Dev Jain <dev.jain@arm.com>
> >Signed-off-by: Nico Pache <npache@redhat.com>
> >---
> > mm/khugepaged.c | 13 ++++++++-----
> > 1 file changed, 8 insertions(+), 5 deletions(-)
> >
> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >index b7b98aebb670..2d192ec961d2 100644
> >--- a/mm/khugepaged.c
> >+++ b/mm/khugepaged.c
>
> There is a comment above this function, which says "revalidate vma before
> taking mmap_lock".
>
> I am afraid it is "after taking mmap_lock"? or "after taking mmap_lock ag=
ain"?
Good catch, never noticed that. I updated the comment!
>
> >@@ -917,7 +917,7 @@ static int collapse_find_target_node(struct collapse=
_control *cc)
> > static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long =
address,
> >                                  bool expect_anon,
> >                                  struct vm_area_struct **vmap,
> >-                                 struct collapse_control *cc)
> >+                                 struct collapse_control *cc, unsigned =
long orders)
> > {
> >       struct vm_area_struct *vma;
> >       enum tva_type type =3D cc->is_khugepaged ? TVA_KHUGEPAGED :
> >@@ -930,9 +930,10 @@ static int hugepage_vma_revalidate(struct mm_struct=
 *mm, unsigned long address,
> >       if (!vma)
> >               return SCAN_VMA_NULL;
> >
> >+      /* Always check the PMD order to insure its not shared by another=
 VMA */
> >       if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> >               return SCAN_ADDRESS_RANGE;
> >-      if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER)=
)
> >+      if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, orders))
> >               return SCAN_VMA_CHECK;
> >       /*
> >        * Anon VMA expected, the address may be unmapped then
>
> Below is a comment, "thp_vma_allowable_order may return".
>
> Since you use thp_vma_allowable_orders, maybe we need to change the comme=
nt
> too.
Ack! Thanks for the review!
>
> >@@ -1134,7 +1135,8 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> >-      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> >+      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> >+                                       BIT(HPAGE_PMD_ORDER));
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> >@@ -1168,7 +1170,8 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> >-      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
> >+      result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc,
> >+                                       BIT(HPAGE_PMD_ORDER));
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> >@@ -2807,7 +2810,7 @@ int madvise_collapse(struct vm_area_struct *vma, u=
nsigned long start,
> >                       mmap_read_lock(mm);
> >                       mmap_locked =3D true;
> >                       result =3D hugepage_vma_revalidate(mm, addr, fals=
e, &vma,
> >-                                                       cc);
> >+                                                       cc, BIT(HPAGE_PM=
D_ORDER));
> >                       if (result  !=3D SCAN_SUCCEED) {
> >                               last_fail =3D result;
> >                               goto out_nolock;
> >--
> >2.50.1
> >
>
> --
> Wei Yang
> Help you, Help me
>


