Return-Path: <linux-kernel+bounces-890856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800AC412F9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E89C4EA68E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB0331A6E;
	Fri,  7 Nov 2025 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmcpT4SX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnp5iNt9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BA2BE020
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538517; cv=none; b=BWuCREp9hxdZXpLJljIeYlQ6N8My8o1bH2vZoKmdAKDOj94zn5S7Ka1E7d3Vs32DyH8Y3RrOScptZRSY5urS65snzq+/8oVYrSCjC2mz3Yspa6lBIOXfP4B5cAN+AI2BLdngdlsTTA/3cQkKc6pdxQn6Mu8lU0ulH9XKhYrLAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538517; c=relaxed/simple;
	bh=mgm8qxjZEYmIZNBjWTRuwvARGl9cfquNJwY3c7URdeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VteD0uL90KHvpECbT+3qMkAaKpF/49W0zAINXmu/w/DReIPNXnNqeD6gw/9AhXLR8U+jrM6CPcxKaXH5bDlG55a8KESasXUmiKmfe0DqSDAeVeVBoIgBCCiuOGvMI6d/zBgqmbRjZurtBYSP+gs5QXhV2Xu0wtn+mresHuew9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmcpT4SX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnp5iNt9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762538514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o03EPvkF1Ee4HFaXHVj6CmMYvciS5SYoQDAqRDI5EK0=;
	b=OmcpT4SXGLKWuh8NUpyQFpQRR6P2D28moBB1/IpspwYOHTxb/BAV3jmCIPRvLLfd1yWWeC
	fwLirwkOn0qB3F3r8fJP6gqI9SVVcw4/w8wTinQTeuXME+sTGIGmXqf6CCMmQDG+hZ4ES/
	oCsefX/Ehkxzrdd95J2aHvLl2vtG2Ro=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-5CQl73DgNF-mbtscRTdjZg-1; Fri, 07 Nov 2025 13:01:53 -0500
X-MC-Unique: 5CQl73DgNF-mbtscRTdjZg-1
X-Mimecast-MFC-AGG-ID: 5CQl73DgNF-mbtscRTdjZg_1762538513
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-785d6471f4dso14183327b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762538513; x=1763143313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o03EPvkF1Ee4HFaXHVj6CmMYvciS5SYoQDAqRDI5EK0=;
        b=bnp5iNt9ithRbtOzMQRjCBPcCeO19aLSPVaQjDgza7vISLJqQB6J+ZcqI+tRjM1YoI
         DKAAUYCBH+yn8JGKFXHe61Id01qmxOdIkNQiQ8TBpk70e/1/oqEy73imIJt9IK2DkJyG
         7gUIRuI5d+hHqZXlNGGAb0iP8Rg3c7T0B2pJz/3BXpf2AX0cG1770QK6QrpWG+s5pZuD
         1RptKPgG2svsDYq/aAsUzNMyEoEcFMWKjjdMRY78KoJwVTVbxD/IYyp530ZTUa2KfDh3
         /GZS5l1UOmV3SssayaulUuAgL7JZWk1pPDnBWvGMCaO8aWcjpNLnsYwP2VEzeHiOhqUa
         bJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538513; x=1763143313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o03EPvkF1Ee4HFaXHVj6CmMYvciS5SYoQDAqRDI5EK0=;
        b=ccWAOCoJtHSxkPEyylunNF0CNXQDTEGpZKxAq8gboKHB4vKOt9uZ6kL8z/cdmuALsN
         BL7gTCQb2onUx0yfiqtbnikMhXL5LhTU77jIYWjK8WqwJKZiw7yoovI2gbYYJMdbdWFh
         UKdl26upKOBIrqEWwO/WpP8fwknDkBTaPXHHLqYH4d10vnWwbL/iruFG0ADOUSAsgPrG
         Pv+QutdyGXaPXvJ0zTLNsq6h+UVnrGxP77laf7fZNmmC9e8WApeZG1n9UenR0H2sE8FE
         axd/1PwTEQNuEML6yBtUD2WrB+U9eXNqvYG129NOTrDDQrXKBcRJUAe1bP49Di5WPck9
         B6Qw==
X-Gm-Message-State: AOJu0YwAnKNBRjo8JZFlcH79tgeYDF+wH2xlkWFe2pZlFVgTNj1yuNEs
	3+njvR+SegGh03+jN5k3VifufSIPpKXjR5acWs+pI1uzsucLudaej+XbeEAptKw9bzrAwMe1DNU
	b/wNRojCkLFW8rJFZk2BJ4Siju5hEKlv0UZBz2hkGvok8iuZqVXjmbSPA0ntYPDnNaaThiw9UcW
	m9q0KCaU6/OqmaROxFzmhDib0WYjOcY+Pi1JHAqvNp
X-Gm-Gg: ASbGncu6BVSg7HR/P8PVVxx7h3fnd9DQvOrvP5RWpa+UgzEyQVfu7wdjoKAX2kG98TD
	YY8SFelFFmO2bPJQVGkWsqx2eVGY9lWsshnqBCQZzK18dCUISyIYrI1S2iGJYfYjgHvsGC9Ytac
	fDTT5MkIckQpHvwiB2QSTmh3x19A8T6aGFli1vPSpN7/yAqbhtwKNxDcf7MQjQ6Do4ILkPvA==
X-Received: by 2002:a05:690e:2417:b0:63f:b4d8:1f3c with SMTP id 956f58d0204a3-640c42dac2dmr2587356d50.35.1762538512614;
        Fri, 07 Nov 2025 10:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjLDv5pucIrLunFcmpT5DImh7xOQHAmSWOhb/WF5swQ3zC4ISlOHgSzClnhRgLhl4xOKSEVGJksfqOFQroVQk=
X-Received: by 2002:a05:690e:2417:b0:63f:b4d8:1f3c with SMTP id
 956f58d0204a3-640c42dac2dmr2587310d50.35.1762538511869; Fri, 07 Nov 2025
 10:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-12-npache@redhat.com>
 <5b2dbd05-094f-452a-8067-d342b2819af9@lucifer.local>
In-Reply-To: <5b2dbd05-094f-452a-8067-d342b2819af9@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 7 Nov 2025 11:01:23 -0700
X-Gm-Features: AWmQ_bnZCljbkWgTreWCIKIWGk5V1YSCEzkc_26ghNPznQVbhA9Vnvap7t_CMZI
Message-ID: <CAA1CXcDG8=89uPcptkRv23JfmczAGp6_KQMQOFhQ6Uivo-33kw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 11/15] khugepaged: introduce
 collapse_allowable_orders helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:13PM -0600, Nico Pache wrote:
> > Add collapse_allowable_orders() to generalize THP order eligibility. Th=
e
> > function determines which THP orders are permitted based on collapse
> > context (khugepaged vs madv_collapse).
> >
> > This consolidates collapse configuration logic and provides a clean
> > interface for future mTHP collapse support where the orders may be
> > different.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> With nits below adddressed, LGTM so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you!

> > ---
> >  mm/khugepaged.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0dbbe04c31fe..89a105124790 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -489,7 +489,16 @@ static unsigned int collapse_max_ptes_none(unsigne=
d int order, bool full_scan)
> >       max_ptes_none =3D min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - =
1);
> >
> >       return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > +}
> > +
> > +/* Check what orders are allowed based on the vma and collapse type */
> > +static unsigned long collapse_allowable_orders(struct vm_area_struct *=
vma,
> > +                     vm_flags_t vm_flags, bool is_khugepaged)
> > +{
> > +     enum tva_type tva_flags =3D is_khugepaged ? TVA_KHUGEPAGED : TVA_=
FORCED_COLLAPSE;
> > +     unsigned long orders =3D BIT(HPAGE_PMD_ORDER);
>
> Nit, but can const-ify.

It becomes a function of is_khugepaged in a later patch.

>
> >
> > +     return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders)=
;
> >  }
> >
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> > @@ -497,7 +506,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vm=
a,
> >  {
> >       if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> >           hugepage_pmd_enabled()) {
> > -             if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED=
, PMD_ORDER))
> > +             if (collapse_allowable_orders(vma, vm_flags, true))
>
> If we have a 'mystery meat' boolean parameter can we always use the conve=
ntion of:
>
> collapse_allowable_orders(vma, vm_flags, /*is_khugepaged=3D*/true)
>
> Please? Same goes for other invocations obviously.

Sounds good! I'll fix those up.

Thanks,
-- Nico

>
>
> >                       __khugepaged_enter(vma->vm_mm);
> >       }
> >  }
> > @@ -2567,7 +2576,7 @@ static unsigned int collapse_scan_mm_slot(unsigne=
d int pages, int *result,
> >                       progress++;
> >                       break;
> >               }
> > -             if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUG=
EPAGED, PMD_ORDER)) {
> > +             if (!collapse_allowable_orders(vma, vma->vm_flags, true))=
 {
> >  skip:
> >                       progress++;
> >                       continue;
> > @@ -2873,7 +2882,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
unsigned long start,
> >       BUG_ON(vma->vm_start > start);
> >       BUG_ON(vma->vm_end < end);
> >
> > -     if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLA=
PSE, PMD_ORDER))
> > +     if (!collapse_allowable_orders(vma, vma->vm_flags, false))
> >               return -EINVAL;
> >
> >       cc =3D kmalloc(sizeof(*cc), GFP_KERNEL);
> > --
> > 2.51.0
> >
>


