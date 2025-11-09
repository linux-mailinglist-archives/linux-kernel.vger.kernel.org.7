Return-Path: <linux-kernel+bounces-891986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BBC43FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0105B4E579D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDED2FDC41;
	Sun,  9 Nov 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFuraX6l"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084D2FD1B9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697934; cv=none; b=JYk8RwO9Dr2CBGYtq2Ect/PTX176k0AX7CRI10csmU2Pvy8sRhbPOuB22dwzq90b9TW97rFNWcsAXWIwtdZhwgdeFT/epVbCJOf7rWv74PDBLyLCPlinxOBl7V36U5wc7BJgKZJsjB+l2lp8haHPUzL5CG5aIeVN1brZ68s+qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697934; c=relaxed/simple;
	bh=AAnUYD0PHLBPV+08TMxtjolyZ3g6iS51lym7EijTY/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTyzI9mRNCvHTTh3SNmeX27hBKJRY0jM5/PmpBTIDYTYjB4uRbbM3voKGJ3GbLTgMzRvabe/+Wdgn4ZCIz0Hp9SnPceiPU++jISzF+gLWVn9njNiVHv4TKRGciP9m5q8wAwv77MZbzxLx47O6j8A0qpbECaQUPqvhXbjppTd44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFuraX6l; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so4031427a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762697931; x=1763302731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSrLYa2dbPu1Sk4hzGvFs9D1jZAxpdigfTc1UtzFttE=;
        b=CFuraX6l8/T6Lr8a3/KA3XhYSuuFWwlIEfhXqgSefomb/VYiTA/KTx1AhSkbCkKn/x
         a/o6xDH+ziI4Kpcs3i5bkyCE1YIjPvdrO5rXGy8A3T9fc1uY+dyrzs3moLwgPbJqhp3a
         rN76oKbGk2FRTv1MKyGd+pDz3CXoiK3ufWAF6M2l1u8alv5t5RTNjWmSK0s0uEPFJ7EZ
         JBT/rKiRwP77kWbea+JoUs7w/uwdroMuMw88ST3EaDuHRiVOEYjU40ZStuNkP1M2swpE
         XRcaAypxuiAvvfCTxNimp1Omaa1nB+73Q8Zv0+XHO3YqmGevvVf/2Qz55TMs1Jo2DHzm
         gi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697931; x=1763302731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSrLYa2dbPu1Sk4hzGvFs9D1jZAxpdigfTc1UtzFttE=;
        b=oska1znSQBpZf3jkZ825eHsExDqLdov+XdqHFgn5ScLzjHq400aMNMvww2aG2jq7kv
         XDi5ZiOymVVDRH5Y2AboOADF8yMeAB8XRyh+T1WFkE+BNE8TJ4l5udCzGv0Vbqt5b6FK
         0sYCyIKHxMJyiv3nkPXgJAwvaT5WhADeXLVfjyMzxukwG9g604NO3NyoEvIX+7FxHhui
         7qic83wrxJRcy1z4zwcQwyvstb9j7NI1dg4jaSQ/G3eFucm0/ud+RFXU2xo9lVZfojl2
         qgFLJdQBDVTMx5AsH5jyI2bWDJSBkvq323pwphEjMVBY3qG/8UnLY/qPHGND+KymcjGI
         H4yg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2H/cEVMbk5ZsvQulNz+HsK1NJSkS8esvQm84Iinm/Z/30ewKaw6CzCj3imD3MK6nvtAklMU10JxaNWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvyyu+tAaTUuDFCRp0JO6FfR0/smEyOTE3UGhqmFKk3Bgv8p90
	LMFQ/zdco4oZxPjylaYfiDarozllWjubwx+rMSrfiHWIx5Ai6vIzoiJ2GOoHFliZEfKA0Eqp/DM
	wfanU6RsNXXIox1Fk1ePQ6ye8Vecl/aU=
X-Gm-Gg: ASbGncsNlahliUI844F2iwxSQHR8qLwbI5Gt88oJyGdWBgclPqAY+QxQ2ov6F3rpsYJ
	KVtTU766hWBNaW6yk/4yf0iOY7+6g1gD2HhsnuSuE26naPvzTnPvHgYS+cX2Wpz6pG+LKuwTu+n
	eTsvveUKcqerCI+qhvvarRAb/idvdvaYhL4y6tx5V48QldPO+Y21Yl3H/tXp765BWIVCsoKFjd3
	3RfvNW9oxUh8OhXnwzbKe789sok13u7iD5000TND58QoXJ9Nt71REWeCc9t
X-Google-Smtp-Source: AGHT+IEFDYvsYRL8O6CxREB+DW6VxZZXLsTpZLPIrxXNxvx3A3g34J7Gi7p7SIrZCX1x3uFDQOBusJmADrd7jl8WQdk=
X-Received: by 2002:a05:6402:4559:b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-6415e6fedc3mr3643226a12.22.1762697930903; Sun, 09 Nov 2025
 06:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-13-3d43f3b6ec32@tencent.com> <CAGsJ_4xquj2Kbc2qu0vtY6Q+-q3sg56BgKEdPs8eHtKxLBk0gQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xquj2Kbc2qu0vtY6Q+-q3sg56BgKEdPs8eHtKxLBk0gQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 9 Nov 2025 22:18:14 +0800
X-Gm-Features: AWmQ_bmqWlRo-KjW5ZzDR65b3A1_5mUxCTTaqf_DSjWOrCz23X79oa3MbbRzFFg
Message-ID: <CAMgjq7CDXh5OWy5BMXzNPCSuMQfODTdFPOhpCDGXrhisNfAGdg@mail.gmail.com>
Subject: Re: [PATCH 13/19] mm, swap: remove workaround for unsynchronized swap
 map cache state
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:07=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> >  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask=
,
> >                                      struct mempolicy *mpol, pgoff_t il=
x,
> > -                                    bool *new_page_allocated,
> > -                                    bool skip_if_exists)
> > +                                    bool *new_page_allocated)
> >  {
> >         struct swap_info_struct *si =3D __swap_entry_to_info(entry);
> >         struct folio *folio;
> > @@ -548,8 +542,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t en=
try, gfp_t gfp_mask,
> >         if (!folio)
> >                 return NULL;
> >         /* Try add the new folio, returns existing folio or NULL on fai=
lure. */
> > -       result =3D __swap_cache_prepare_and_add(entry, folio, gfp_mask,
> > -                                             false, skip_if_exists);
> > +       result =3D __swap_cache_prepare_and_add(entry, folio, gfp_mask,=
 false);
> >         if (result =3D=3D folio)
> >                 *new_page_allocated =3D true;
> >         else
> > @@ -578,7 +571,7 @@ struct folio *swapin_folio(swp_entry_t entry, struc=
t folio *folio)
> >         unsigned long nr_pages =3D folio_nr_pages(folio);
> >
> >         entry =3D swp_entry(swp_type(entry), round_down(offset, nr_page=
s));
> > -       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, tru=
e, false);
> > +       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, tru=
e);
> >         if (swapcache =3D=3D folio)
> >                 swap_read_folio(folio, NULL);
> >         return swapcache;
>
> I wonder if we could also drop the "charged" =E2=80=94 it doesn=E2=80=99t=
 seem
> difficult to move the charging step before
> __swap_cache_prepare_and_add(), even for swap_cache_alloc_folio()?

Hi Barry, thanks for the review and suggestion.

It may cause much more serious cgroup thrashing. Charge may cause
reclaim, so races swapin will have a much larger race window and cause
a lot of repeated folio alloc / charge.

This param exists because anon / shmem does their own charge for large
folio swapin, and then inserts the folio into the swap cache, which is
causing more memory pressure already. I think ideally we want to unify
all alloc & charging for swap in folio allocation, and have a
swap_cache_alloc_folio that supports `orders`. For raced swapin only
one will insert a folio successfully into the swap cache and charge
it, which should make the race window very tiny or maybe avoid
redundant folio allocation completely with further work. I did some
tests and it shows that it will improve the memory usage and avoid
some OOM under pressure for (m)THP.

BTW with current SWAP_HAS_CACHE design, we also have redundant folio
alloc for order 0 when under global pressure, as folio alloc is done
before setting SWAP_HAS_CACHE.  But having SWAP_HAS_CACHE set then do
the folio alloc will increase the chance of hitting the idle/busy loop
on SWAP_HAS_CACHE which is also kind of problematic. We should be able
to clean it up in later phases.

