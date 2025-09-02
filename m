Return-Path: <linux-kernel+bounces-795599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D726B3F511
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93AA1A80045
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742782E2850;
	Tue,  2 Sep 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbbV19pM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114F1865FA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793617; cv=none; b=WyFAQM7FeDeddbVqtONIc4bZsf9UZE4Ii+ZLqpraG/TFteRrpJiLS1YMHHYDWEsolawkMtKZ5TBl9jcincoJKOy/kiBLGnBTpCXui78sXxeOeSKzyinJaLxn6CNk91wIOBd23j4K0DD1ruLLgGaiqoSfdCNzCXv1m6PQySGAfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793617; c=relaxed/simple;
	bh=qWx6qbxNFIe0cbRbgv455FO8qIxpNH3ZD+wUr5HSfGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifnuycAWnixAXzGtOHv1a822Fmoq9vEtKbtwSu9HBHbYauXMYUm6bQcbxzfl8FqHstPheV/JpUsWv4BhfoVGJEuOkjLF0iv/Us6gGG+k7lKsrUMTxHVPmaNeEUx/WzYBkdsvSt+Ket1J1tW28cRoKj/SVKn9728/rKOnZDRfs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbbV19pM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04271cfc3eso222259566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756793614; x=1757398414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXpO31qXeYVn+ZP52IVAUF/F/TwtGC3fKI0WbpDerJE=;
        b=gbbV19pMSsOyU7gVU7cj82SzUxxm9YMG4s4NUtIMoiW0YrCiuM6ahVw/Z+KcQNxxmF
         qY+EIgoOitwq7S6TE2ffxU3yYnKm/AVXKqwmT0dOCZR9t1Zubk4Wz1mfzOoVnt/Y5qdc
         x+AT7HQId6iiSG8FiTKk10lqrB5Qa7wVc7RJAy5tIfne+LyyrjrsTC5mAMqPM0F0e4V3
         jEvayz9ijZF3emSGo+8AUJ9lWhEvBJ+0V5wuFNQB+HX62lqnLkWM8rxhx1xidSRxcuqU
         HvBfeq3ZDGA2f5xAgFcihGi4v/Jjve4W/jO4wtm2Rg2otiNclyZc8GStQYQz1p7aJqcF
         HY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756793614; x=1757398414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXpO31qXeYVn+ZP52IVAUF/F/TwtGC3fKI0WbpDerJE=;
        b=KhMJnPkWblC8sjGMATyHqcO/exeuh8ErcUB4ilqsI0dI/bxrDG2hvURD1wgY+fPi9E
         TTorHJYxp7S3mW/Q4JtPAYXJFhiBm8BSfp0Ty984thLSlecI0Sz+D6zGgmwJs+tcKC3b
         ACS5F+mE1fIJRkDWFXJ+x599WmKXDaiwBeGQHbvkUFoEamXnX/uymHWeKjgGeElUTm/I
         r2WPE+RnQzgOjvKfyGxFkhZTwXiaSU54Dt94dlty4lvZJxeUKoM79nzijPXiHVxI0QLi
         6FHXJJcaMKtp/8PfC+EwWI+d9MXpNnMpQYOqxI061/2H076YnKg6+4NJ9KPyMWkAutC2
         QFoA==
X-Forwarded-Encrypted: i=1; AJvYcCXrSnH4oN2yz63SSYXuzZB+ZBcwuTCjYusjgKBqxiWeA0OULHBaT6to0cz4iwNCaETPmYL6nH12lSZCAjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdt2ULPxtBGw8hH7d7BDtcaQFCTxivVzn65iNMB3sGdyEQ2yid
	nBDO165KqyCoHx0Uxj61ko5ItygyWP2cswiwYLEetflRw/MJpq7k86Jp21w/cvtqF8TxEW5kxO9
	gCYOcvhJ1xLRBXuAnJR6voQlTfEcI0mA=
X-Gm-Gg: ASbGncsFJYNXFwgfBvR42u9EJylOrk9ZXIR3GdwBIoDdVWu213BziU7qrQxhvBA/EjS
	t3TQfredFRwvJaOSF3ObDvhiBgQVe9j6luE0kBMJeej7poTA5OMkgXGgHTVyWaboUxJe2VRiVtp
	jN3KDuIFmVvKr3BokEGL1yJ3JMWBJhRzL00ez0JD2gs12/Ugp1zbn2yERhpzUX5AMYIOtJqTcHU
	pGOQ1vgPLKEiQRCUcGMQg==
X-Google-Smtp-Source: AGHT+IFditCyGR6d3RrnKjk54ELZjip4tSsePu5eIAfrFlKYOz3nmi1u2hedAsaela6WNYcSOUPTayCPxoWIfadjBDg=
X-Received: by 2002:a17:907:bb8b:b0:b04:1d07:40de with SMTP id
 a640c23a62f3a-b041d074816mr660378266b.23.1756793614053; Mon, 01 Sep 2025
 23:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <CAGsJ_4xoN35Av2H70o+dwGzhKrAnm7gppEseG0MgAUPQt2TygQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xoN35Av2H70o+dwGzhKrAnm7gppEseG0MgAUPQt2TygQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Sep 2025 14:12:57 +0800
X-Gm-Features: Ac12FXzRHhSHkOm9GhOsn7XLeGu7L3HAsBD5D0dA66RleOcvQAaQbN42xrE1ngQ
Message-ID: <CAMgjq7Au2n7PO6yb7wyCJbvFceGj6cpQCp+kVTewPjU=WhmXKQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:14=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Aug 23, 2025 at 3:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Always use swap_cache_get_folio for swap cache folio look up. The reaso=
n
> > we are not using it in all places is that it also updates the readahead
> > info, and some callsites want to avoid that.
> >
> > So decouple readahead update with swap cache lookup into a standalone
> > helper, let the caller call the readahead update helper if that's
> > needed. And convert all swap cache lookups to use swap_cache_get_folio.
> >
> > After this commit, there are only three special cases for accessing swa=
p
> > cache space now: huge memory splitting, migration and shmem replacing,
> > because they need to lock the Xarray. Following commits will wrap their
> > accesses to the swap cache too with special helpers.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Nice! This has cleaned up the confusing mix of using
> swap_cache_get_folio with VMA, filemap_get_entry,
> swap_cache_get_folio without VMA, and filemap_get_folio.
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks!

>
> Do we have any potential "dropbehind" cases for anonymous folios?
> I guess not for now.
>

Right, dropbehind doesn't apply to anon yet.

> __filemap_get_folio()
> {
>         if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
>                 folio_clear_dropbehind(folio);
> }
>
> Can we mention something about it in the changelog?

I can add some words about it in the commit message. One can easily
tell that if we want dropbehind for anon, swap_caceh_get_folio will be
the right place to handle related logics.

Now with swap_cache_get_folio being the only place for swap cache
lookup, and in the next phase we'll make the swap cache layer the
unified way to do swap synchronization and never bypass it, maybe
dropbehind will be easier to do too.

>
> Best regards
> Barry
>

