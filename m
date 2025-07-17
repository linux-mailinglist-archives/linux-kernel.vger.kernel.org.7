Return-Path: <linux-kernel+bounces-734810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF6B0868F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA801898FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266A2264BC;
	Thu, 17 Jul 2025 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8fpDqOO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583092264B1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737131; cv=none; b=FHXVFpvZaS6DbhkCWRWJgt0aBxkRT/d4YyDSt/sGDKBXpGNkhKQ/VHQmgsTEkiROMUuCl9v45hOCVBSHvFTnQzqZp7i4jEhEDGKmKOe5XUOydLJqLq3LQ4sNuTos64u08OPSkWdhvQDy0bioM4ni9PcjGDPay8TpOMhvnF4tvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737131; c=relaxed/simple;
	bh=j58zeUSOM0h/p9sADyLgvkI2QIcTR+seK1bRLizS8o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRCwIPNCsmpI0oLOdGLl/n3AU6KSJVGlfORCZ7t4prgv/TmzLZ9aJKm1Ja2dEbaDgjzpAIU/idvfadeXOOE+Ziqco0tOrKHNaXUNM72gAOhshEiYE5xLd+Z4H7h9+fyCov2SWnPzS2ZgNGKj51hooXRHyVXBoKE/k7z89B7vjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8fpDqOO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2qRJ0vhUxgZfAdGXu3qCJFwuvYHORHNNQHgAFNdhP0=;
	b=a8fpDqOOZ14SwwHWKQdxHb4j+ZjFwg9OBglWpTZswPtgDIaNVMepVTXocNqFPIBAYWw1vV
	93Rw40qd3MspumJe7532WsoS6UOmrY9v2XKA3hVg+5ryKIdKcjTg/omleO5oohlrVIVuGy
	ihR0fk2pFRQaRZEp8SC+8iDVOjrZhlA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-Urc1tNu5PJmnbg1-IsJAXw-1; Thu, 17 Jul 2025 03:25:26 -0400
X-MC-Unique: Urc1tNu5PJmnbg1-IsJAXw-1
X-Mimecast-MFC-AGG-ID: Urc1tNu5PJmnbg1-IsJAXw_1752737126
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-713ff70871dso6651487b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737126; x=1753341926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2qRJ0vhUxgZfAdGXu3qCJFwuvYHORHNNQHgAFNdhP0=;
        b=bkgSm/VvdiNAKXIdIX9bh0EthUfjqPNrNvUxNludk28ExBzMss9L5t48lKZX0GtHSk
         Y/pK3qjrz/LIxz/J24gyX1dU9zJ03kY6YpMxjznezIFeaHIvCxmazDJYuNJT4nCRx1HG
         6jUnMj6/ilR4fxdeg+Uoe6QCBVKfSPIcS6Xt5cU8NCepSEtCu0dJ7Spj5Plf8hl97RYl
         wKrWT70dVMjvdoZQkQj/u0Rqfzl8VYDbrJ4zAl8xixHuNFS0XWUbsTtuOVsZDF0I3N+H
         507f9ky/ej4S44CGo9qY9XOw5GgoS+42bpLBjoGQ81j2yU6t8zUcNH/4dBI0oBti1lKX
         7udQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdy8MPVx1KmSsndld7ccuBBSdp04Fg184Tjp8tcHnYpERdljiwbiCKbfgGRDUcIW8TNCNXfJQ5ZsK2YDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jeh3VM0IPmR9dmG2rpzTIyopSWzUNtOyMomPgSrlohzT60Fl
	HuokGGzt1KKUc6Lx0sVGMILj33/XCh5U2hy50iXnbK/wBbGPhbRTiTF3sHfBfbpHugAo5GnPbcp
	h05incFPlgH/khRDTeFaZ8yEyDGg8w04Ue0sBrZDduOqJhlCPE1s+ULAug6Odb+9GyRc2O8YCxS
	Ul3xNncHJLm/AYe2M6+8gKeCZi0rgRRuqP65yUzHYE
X-Gm-Gg: ASbGncvPqURJZuY34EjNs/NIROS1dqNo6OpKHXSZhUXimCSlurHt8Y2PWp1QVzMKxRW
	tMoroXe4JO6/Z24Q4xMoS/u3Orx3VSpex80ShJMJ7fxtmHtMFKfO5tOGrYRPj3ivD5oK/ueGiC1
	lzKzH/ZttYXaxnp+Z+Q0uA1Yo=
X-Received: by 2002:a05:690c:6c8f:b0:70a:2675:70b3 with SMTP id 00721157ae682-71837475aaemr81219637b3.17.1752737126010;
        Thu, 17 Jul 2025 00:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3zLwOVx14CX9ZFk5M7NptbR4Vtkv7y2swdOQcVV2bdsXyIwCQieST6so7r6GPy5LTDbi4OxzkmKDiHQeVo40=
X-Received: by 2002:a05:690c:6c8f:b0:70a:2675:70b3 with SMTP id
 00721157ae682-71837475aaemr81219087b3.17.1752737125474; Thu, 17 Jul 2025
 00:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-9-npache@redhat.com>
 <290d669f-e358-471a-95b7-c46f974742d0@redhat.com>
In-Reply-To: <290d669f-e358-471a-95b7-c46f974742d0@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:24:58 -0600
X-Gm-Features: Ac12FXw-dqZQr1iCc1PpyFCVkqA86TGy_82hTQcSrhEKTcjVPQocXibYjfgQIuE
Message-ID: <CAA1CXcAciHMz7RCAqFZcnDk-nvhfd-G7QSdMub1aYzKAq8pdHw@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] khugepaged: skip collapsing mTHP to smaller orders
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

On Wed, Jul 16, 2025 at 8:32=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:32, Nico Pache wrote:
> > khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> > some pages being unmapped. Skip these cases until we have a way to chec=
k
> > if its ok to collapse to a smaller mTHP size (like in the case of a
> > partially mapped folio).
> >
> > This patch is inspired by Dev Jain's work on khugepaged mTHP support [1=
].
> >
> > [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.c=
om/
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5d7c5be9097e..a701d9f0f158 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -612,7 +612,12 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >               folio =3D page_folio(page);
> >               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
> >
> > -             /* See hpage_collapse_scan_pmd(). */
> > +             if (order !=3D HPAGE_PMD_ORDER && folio_order(folio) >=3D=
 order) {
> > +                     result =3D SCAN_PTE_MAPPED_HUGEPAGE;
> > +                     goto out;
> > +             }
>
> Probably worth adding a TODO in the code like
>
> /*
>   * TODO: In some cases of partially-mapped folios, we'd actually
>   * want to collapse.
>   */
Done! Good idea with these TODOs!
>
> Acked-by: David Hildenbrand <david@redhat.com>
Thank you :)
>
> --
> Cheers,
>
> David / dhildenb
>


