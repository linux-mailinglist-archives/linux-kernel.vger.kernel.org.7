Return-Path: <linux-kernel+bounces-835631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26907BA7A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605131894B96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 00:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB61A8F84;
	Mon, 29 Sep 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihch2MzV"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6A2F879
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107538; cv=none; b=NAB8PQoUGo04KcxxukFQdE0Mv4HBlGFxAfBqZiBvzin013No5FdCWdC1PlOa5NGbAFFPJ7KrY905Zp4kKYGjjBPaLwEaCjf/v8V4F2iNZN0gX0OjfiNJkrhgGVgZE+HaKupzsdyDd0kW7yKfarJEAxEYRZ3L7OS2IdzcizvD94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107538; c=relaxed/simple;
	bh=az2qVx7SYHL3BhBMA6u0WND6D2hI2oGlinCWrXWc4pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJ+7aJ4wHSpVpOgwdgcd2NiUnK2mKzzD1XUApioiDRv3iVLHkgoFy8DfTo/X+0e7HNIDB5qpZu7Ypds1aduPaV5eBYeamZ+W7wNteCSwTtLQMAOjxNje4mEgt6qQkjDY9oRpooGwfEi2DFB2MT6p65WAqJXgrICRospkuMg/R/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihch2MzV; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b5506b28c98so2753573a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759107536; x=1759712336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORs2gycvYbnBEoguqR6oKSNFoMATmvXOvwD+L187YZo=;
        b=ihch2MzV2W1fxr1LPOVe3Bmhh+gbcb2yI74WRpyKlpNb7cqKH8jRwk+DSFNOMqVxXw
         ZqZA6AmTsFbBnY5k6Z/oM2NHSbq8DvaTzr/46c0ivmLeL5EFxbpTF+HUf9rRi8xwmr/f
         yXHXrKR8jjrCOF1hUwO13zrcg807STHjK+Na9O90f8QGua/LgIVRGuHGBrlBR2HKxHmu
         3+uGucmG9FbpVjWLDb0Xa+DXqO7n4I/+/MnEYK4lPAcro/ysBrmaDicA3JQLLPDFz8PQ
         L8M5EYvntzjCvnGMXzrqTmDAXO27kNVXzfl7MFMoJ+iIkOFtTlReTvNHfrIqzH9x/sfA
         xuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107536; x=1759712336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORs2gycvYbnBEoguqR6oKSNFoMATmvXOvwD+L187YZo=;
        b=maS/uomzixV9W8INFBwV6y768htIu3TXxzEOyCf46w60bnF5eWtLblgqFfetbzAyq6
         jJzTFMLJVsvf2Nt6k0SD/Rb45H/MGFFgcVznWEx9DcdtvxDjjYgMMwzt4BWx5E74l6tM
         sMHVBOVhypqM4mpfXKkyY3m+s3gDdkLAI81UPcWDyAu6ybnjLnN+2AX3mCO2zEabfxE1
         EnYVbx9iCORpx25oPOE3PXv7KBqlLvPy7oSEqqKOBgGA2BbOCxpo6zlef6Nr7ubEHSAZ
         bJyF9owxjgi+GKrGz092bsVijV6Uo90/rOW+xg9ewjN84my0915IvrQF6SP7tWb+wJXE
         OHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdsvxAkRPZbNtYusdMmHenyZZc9Rb8FGIBt9DMwzjmqyaJYblccRfoVErnFvyYnA3VP+QpcNeC2zvKvek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGWTzu8HP3ca9OMiR1+KslvXdqgLW2MD3Hkv+MeK+oEUUZcG5
	EUsHUAo41uYZcMRZB6N1y82Gc9Jz0HkpMgoVWQOFhStVXUXK2KRIN0HeZdMdeCCW3vYR0LRI+Kq
	xUkaw0T/qKSSKQ2aLVo3rR3EK8YwuWzQ=
X-Gm-Gg: ASbGnctdOcS2eW0gGBa5ArkBaaqjkRwx/aNvG/0toUwMCeWvKtMSlVGv7QNvcsgC60t
	L9ptT/AGwwOmMdnwGJ8XE//dmD/jsQVDYzl7WPjRA5nVyXH5LKS31ZhM0HSR9tk5sZBTYJMsVpO
	jhJdj8jOHT2l+lsGlMgg3s0V0i/XcHYt179s9Srp3wjtN0vS9fHt1T6ZPrQozDfNVEd//zz8OVM
	wIUZeNmytBaAcBCBVW0wOrEv/nq
X-Google-Smtp-Source: AGHT+IEdKd/2f3BIPX8+CygnGdwjwhF1+QMfyj3p0x4KG1dJssR+VKdv7FmMNZsXXawlRu74HGb/awoBUT3TBuZICKA=
X-Received: by 2002:a17:902:ecc3:b0:269:4759:904b with SMTP id
 d9443c01a7336-27ed4ade041mr179270045ad.58.1759107536398; Sun, 28 Sep 2025
 17:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927064926.1496579-1-jianyungao89@gmail.com>
In-Reply-To: <20250927064926.1496579-1-jianyungao89@gmail.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Mon, 29 Sep 2025 08:58:44 +0800
X-Gm-Features: AS18NWAUhnnwQ1CHLLzDZsDFdPRBZuLB6p-5ELHUMzymLqEllF6uCWerrHJaZYU
Message-ID: <CAHP3+4B9LBqODc-YoLogQBLawzqCwBpABi0bNpQ6aNRWuDavtQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Fix some typos in hugetlb module
To: linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Superseded by: 20250929002608.1633825-1-jianyungao89@gmail.com .
Please ignore / Please drop.

Thanks,
Jianyun

On Sat, Sep 27, 2025 at 2:49=E2=80=AFPM jianyun.gao <jianyungao89@gmail.com=
> wrote:
>
> There are som typos in the code comments as follows:
>
>   differenciate =3D=3D> differentiate
>   refernece =3D=3D> reference
>   permissons =3D=3D> permissions
>   indepdenent =3D=3D> independent
>   Spliting =3D=3D> Splitting
>
> Just fix it.
>
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
>  mm/hugetlb.c         | 6 +++---
>  mm/hugetlb_vmemmap.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index eed59cfb5d21..8ff9edd09504 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2954,7 +2954,7 @@ typedef enum {
>          * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
>          * that currently vma_needs_reservation() has an unwanted side
>          * effect to either use end() or commit() to complete the
> -        * transaction.  Hence it needs to differenciate from NEEDED.
> +        * transaction.  Hence it needs to differentiate from NEEDED.
>          */
>         MAP_CHG_ENFORCED =3D 2,
>  } map_chg_state;
> @@ -5998,7 +5998,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb,=
 struct vm_area_struct *vma,
>         /*
>          * If we unshared PMDs, the TLB flush was not recorded in mmu_gat=
her. We
>          * could defer the flush until now, since by holding i_mmap_rwsem=
 we
> -        * guaranteed that the last refernece would not be dropped. But w=
e must
> +        * guaranteed that the last reference would not be dropped. But w=
e must
>          * do the flushing before we return, as otherwise i_mmap_rwsem wi=
ll be
>          * dropped and the last reference to the shared PMDs page might b=
e
>          * dropped as well.
> @@ -7179,7 +7179,7 @@ long hugetlb_change_protection(struct vm_area_struc=
t *vma,
>                 } else if (unlikely(is_pte_marker(pte))) {
>                         /*
>                          * Do nothing on a poison marker; page is
> -                        * corrupted, permissons do not apply.  Here
> +                        * corrupted, permissions do not apply.  Here
>                          * pte_marker_uffd_wp()=3D=3Dtrue implies !poison
>                          * because they're mutual exclusive.
>                          */
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ba0fb1b6a5a8..e6f79b2c63ee 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -75,7 +75,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *h=
ead, unsigned long start,
>         if (likely(pmd_leaf(*pmd))) {
>                 /*
>                  * Higher order allocations from buddy allocator must be =
able to
> -                * be treated as indepdenent small pages (as they can be =
freed
> +                * be treated as independent small pages (as they can be =
freed
>                  * individually).
>                  */
>                 if (!PageReserved(head))
> @@ -684,7 +684,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct =
hstate *h,
>                 ret =3D hugetlb_vmemmap_split_folio(h, folio);
>
>                 /*
> -                * Spliting the PMD requires allocating a page, thus lets=
 fail
> +                * Splitting the PMD requires allocating a page, thus let=
s fail
>                  * early once we encounter the first OOM. No point in ret=
rying
>                  * as it can be dynamically done on remap with the memory
>                  * we get back from the vmemmap deduplication.
> @@ -715,7 +715,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct =
hstate *h,
>                 /*
>                  * Pages to be freed may have been accumulated.  If we
>                  * encounter an ENOMEM,  free what we have and try again.
> -                * This can occur in the case that both spliting fails
> +                * This can occur in the case that both splitting fails
>                  * halfway and head page allocation also failed. In this
>                  * case __hugetlb_vmemmap_optimize_folio() would free mem=
ory
>                  * allowing more vmemmap remaps to occur.
> --
> 2.34.1
>

