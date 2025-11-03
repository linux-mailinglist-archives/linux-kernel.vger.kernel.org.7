Return-Path: <linux-kernel+bounces-882531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D55C2AACC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E318919BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC72E5B1B;
	Mon,  3 Nov 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj093Jdg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BE2D3724
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160588; cv=none; b=GeQMchRqwQAAY68uUsRX5r/eitsnFTlRboZjPGtC88BTfpL/pGP5qzFQDjMSQVMZQK1J+77SJEZwh6SSb6deHEvFbkfGhjCU9kxwZ+E98rYnUuQKwctbTJBQBGAu9JtKxMpbNvhTCvT4i0DxkZnXX3000QYIQClkREO+j+jvBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160588; c=relaxed/simple;
	bh=Pa72IXf4xbZdZimOfk8VkXqmKv4rgsNAd1NsJpg70jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLaYICR+03YUpIPsNt3JnDfCg3ixs0KA0MjhIXy4A4CY8wyukvlp3giAQDxKqXJrO67pSUUSrfZFIjhdT2Qkyy2pYKasrTGxuyig7kRMInjcSkOOFvblHmW4uRfgUYtYUWLe01jpSCHUXq5EsCzTqvX8cEnV60xzhNN/J9S9a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj093Jdg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d78062424so819710566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762160585; x=1762765385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T7VVeR5SZ1Y+UtEgoxTT2SUnCxjpaxNBL714fyXlfQ=;
        b=lj093JdglNsIJAsMClF4qzA2wxcjyqE/Z+8L1o+qMKovncGgSz8cqpgJnS1SCiPAJR
         WhDGtWBVZWVphc5OkGB6isFoYfXt7QH1W3eSvr4MuoC0e3KjlHrXJyIzpIZG5E7+VFSN
         F/TN9GXQA2nhwwzScRX28qEQOUClN2le1yV+gJoLyzXh0iaxERlrGhQhdlXxhcZyg7Zu
         vO1cbxUaCbhbQTiillOozoq5U9P8xwtd3pQgqcGkYEI0YUwON7RXO4C9M1fPWTGNd7dH
         SNnqWNijYmQ/DOh03qmegE9LpY7bICC2v8yyNQGGlj2AcCYRqpdgiAvZfEmxfqHZvUpX
         rATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762160585; x=1762765385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T7VVeR5SZ1Y+UtEgoxTT2SUnCxjpaxNBL714fyXlfQ=;
        b=rjIj9qTmNL3xLTHJVdbJMJXFWahFgD8+Te94WmTXuccjZXg+AofsMG8au1Y35IGGW+
         uoIld/ggTlIlBzJFRGzvtoY/28vWcsXK/ieNIwPkaAAn64f730p5XjRqwzYDMdoncPEq
         nc1rfEg4Cl+0yBjwkCSo8G7NKWsNrhiBy38O6iWQM3JTkUjydvgWMCO4RyFpONwC9mDa
         NX8viRJQhZmAYeWFvgCyHQ3wk0yHQMnu7wYg8TJsYX2E1AEPmAT+qSRM1L/DCTzTba89
         WlVVyp8v6C0TaF7u0rCC2bCvtbOogREObOQNzddG5vhz8GAe+w0wRNL5y5YLH0spG7cZ
         seYw==
X-Forwarded-Encrypted: i=1; AJvYcCVykIfCHo4xfiexRBzTKL9p6b6wkuIrhLIH/U98SM2VGgch9jlc4LcZNke5FSpAaQbh+zq1E/rNTo65Vs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonTnDIHCjH23C7JD9kXOabJtMpiahyrgsSMfXHnBQ5srVWqFt
	8AOIM+mLHIz/L3LxP16Rs+8RI4/v82a/Uw5jUr9BUEexBOqc2cp1WrfUc83KEdx2Jkc18w1aQ8p
	Wdm7rlthrSkUcIGQUMRT3yvuZQJPpDTY=
X-Gm-Gg: ASbGncsHcMWCdOv6Q1nXxBB2jYYBEwIa8cGkAhIqm7DIkZ/mgWYLMzPHfrDWReD1Ok0
	WbN6AcutIMEJnDgbXLDyQp5rB5wsUT4lGAMznhJhfaWwJRhz1RT1Yjt+QF4Otr5WoRtBW0DwIjA
	mqhTslXKYhAyaj/Zs18FaNw0YPIhW/OSIQcTkE/Bd+nhDNQLEYhgome/J2O7/0vMBYntUxVfRLQ
	Lrn7gqr8NxdVApYLDXTfL/QDtCfodisHv5lYgc0bmyEaefZarqDv7kCrDbyPJdLamJ0CHnBRyw=
X-Google-Smtp-Source: AGHT+IFCBRuHUUpuZZVGb4J6LbfjdzLPr770yQ4KDIf8nZ/dKWtpeEeM9Jjed5KRUXQQcX5vBySRqJsHRHWU8GqbVS0=
X-Received: by 2002:a17:907:3d0a:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b7070732726mr1059895366b.47.1762160584911; Mon, 03 Nov 2025
 01:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-1-3d43f3b6ec32@tencent.com> <ufy26fqfvaxqjywneec3hcuky7ozpa2fm63pxcuuberrvicffv@bkblomeix35w>
 <CAGsJ_4x1P0ypm70De7qDcDxqvY93GEPW6X2sBS_xfSUem5_S2w@mail.gmail.com>
In-Reply-To: <CAGsJ_4x1P0ypm70De7qDcDxqvY93GEPW6X2sBS_xfSUem5_S2w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 3 Nov 2025 17:02:28 +0800
X-Gm-Features: AWmQ_bmASoQJptoYUDSSf0xtLCvU3CgV-TSaLDOVl7Wku35dACNX6xNRDzn0jTc
Message-ID: <CAMgjq7A+OBoH71qo=Vt65BeV7M9uOvkJ+9pQX2eq4-tqcKwVwg@mail.gmail.com>
Subject: Re: [PATCH 01/19] mm/swap: rename __read_swap_cache_async to swap_cache_alloc_folio
To: Barry Song <baohua@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:28=E2=80=AFPM Barry Song <baohua@kernel.org> wrote=
:
> > > +/**
> > > + * swap_cache_alloc_folio - Allocate folio for swapped out slot in s=
wap cache.
> > > + * @entry: the swapped out swap entry to be binded to the folio.
> > > + * @gfp_mask: memory allocation flags
> > > + * @mpol: NUMA memory allocation policy to be applied
> > > + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> > > + * @new_page_allocated: sets true if allocation happened, false othe=
rwise
> > > + * @skip_if_exists: if the slot is a partially cached state, return =
NULL.
> > > + *                  This is a workaround that would be removed short=
ly.
> > > + *
> > > + * Allocate a folio in the swap cache for one swap slot, typically b=
efore
> > > + * doing IO (swap in or swap out). The swap slot indicated by @entry=
 must
> > > + * have a non-zero swap count (swapped out). Currently only supports=
 order 0.

Hi Yosry and Barry, thanks for the review.

> >
> > Is it used for swap in? That's confusing because the next sentence
> > mention that it needs to be already swapped out.

Yes, swap in is the typical user, swap_vma_readahead calls this
function directly, allocate a folio then initiate the swap in IO.

I'm not sure why it is confusing. A swapped out slot getting swapped
in seems a very common thing?

> >
> > I suspect you're referring to the zswap writeback use case, but in this
> > case we're still "swapping-in" the folio from zswap to swap it out to
> > disk. I'd avoid mentioning swap in here because it's confusing.

Oh, I thought the zswap writeback is considered a kind of swap out :),
since it's technically writing data from ram to swap device.

>
> I assume you mean avoiding any mention of swap-out? As for swap-out, we=
=E2=80=99re
> swapping a folio out from the LRU =E2=80=94 we=E2=80=99re not allocating =
a new folio.
>
> BTW, this sentence also feels a bit odd to me. I=E2=80=99d prefer removin=
g
> =E2=80=9Cswap out=E2=80=9D from
> =E2=80=9Cdoing IO (swap in or swap out)=E2=80=9D.

How about "doing IO (e.g. swap in or zswap writeback)"? Swap-in is a
very common user, and zswap writeback can be mentioned explicitly.

>
> Thanks
> Barry

