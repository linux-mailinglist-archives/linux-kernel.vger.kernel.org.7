Return-Path: <linux-kernel+bounces-806041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEBAB4913C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E411B27B52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037F30CD8A;
	Mon,  8 Sep 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmA2KeqP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F01309F1E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341260; cv=none; b=bX/2xsM2AfHsaip/tbzALO/+4toMMWCoao/dCRpBWmdeKD9MJB6WHcoZEiSA/pcIS9mwHIJhF7+dWj4HFSndaCjpcX6lFoTq5EPewypt1sW2j7X5Fk5IaAY0FmJ3rsLYpW9y8Zk8zadvZZ/0PJtymIXmobuPFOACSo2ZiTlfVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341260; c=relaxed/simple;
	bh=b8ncZIsdimp1wsfc6ryoznSfRyx0FTPPFy91vGEGgEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5Qxb9rU14YQS5KatYT70aUzzV9hxRA1oQQv3hWeVm6pvi+gFXh4yklUnsOv6svF5DzMZZDe8P47+YUyFxNRNEcCf4A6eUnxXmp405VBPKWKUQmLyubgffcF8moSPlWfKhXaU9TJAXk+eECITrB37rUzYg2KVvS8Lpx0bG36vKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmA2KeqP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b046f6fb230so742738266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341257; x=1757946057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOy2TPlN5JXWLcExWt6lVoT6k+kRkkXUKtWGZoNSAmU=;
        b=HmA2KeqPBfXgzOjs8uoZALMEBmHBghf2gcb5WB4aC7gHlp0TCYoJPE6pseHKK+QjP4
         ibWoohG01OcV54isW3YKgNEbQhnSxL73IxLdkT+twQ4fufaGSI/VE7nrm/OXwf8cCRDg
         07psxkztWIVCmy9x6S/rkG3EAG4aYn59ojqDhUK2FMMLPgkousdLlQJvHS2N5EC+S5Jm
         E3+K0jaA/xH+tJkstGKxHiqGRNl1AKQWkKWpeEfHYlGmI4EAdgplqD77WK9+gUU7qzaA
         c2BxR5wZjRNex5hZoHGxYfMrJXLJwWrNVc7fgZT2/MuFaf7IjksLMRNJnYLZdPcy1zcz
         MKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341257; x=1757946057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOy2TPlN5JXWLcExWt6lVoT6k+kRkkXUKtWGZoNSAmU=;
        b=JnVyS9CEBSO5oTMImFgUkG73dUbpWWc81yucTYh8m7ocm8Dk9kGJXmmeawet/owcvW
         AzP2kt/3fixzGmTqh6k6j5XvOFcQk9bFM8CtvQtnoDG36r845XjubjHS+W1EPII1VS9U
         TtAD8uVrNGZe+L5gFpVy9AYt2GABtRIt5JJa/+7Atd+5o2FS1m4gB6eU+TLCO+JhneOk
         hlWOuvsvTsBEDmPXqp2i3WMYmL1JvZHSunOpK9l0pv2/h6BEiGWa3vMWpRA+KsU9kCLu
         vvFM4Tuv/DKwo5cvj4Ze4kFnqAbiAcPgJ/I3nuG9nUm2CB7xa2Hwl9PNDYAgTlJ+fhum
         vV8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuOSnIm/FfzOsJFRoe6nyeBlloqlh5GoAC1e0F+eW7wbooW+7887Z6dUlunOr/eE2HjWXmP+S2w1Z2Tf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbUsol9Fp9KZ6u0V9TuXj+yEGemtL/lqVp9wzGVGaPtwq2Kss
	IGT123R+jPa3eh0SiiZRIeDHnLk/0b0lPW0tOVDuEkGE/Z8MJ3I4myt6muXx3TitkqZEkfTBxZp
	9PXiDYPHi2FMxF2EO/jwmL8A3iBt3pE0=
X-Gm-Gg: ASbGncscpfffHa2fHs8Q1cXhghb1md0TfsBJZ1SbWN+tdLs1pqb8uhK/k2k/SUvd76l
	ueY4AT0KrJRvidE/uxGRG7P1h9pqJ3quK4cmTyyjJjaTxb+4gyYT6JgXzWf3a5DFDGfhFdcMck1
	xoCRMbH3+jC1evdofiFdOiam76thdUC1PH141l3VbeiwJGU5EDnGIP54MG7gMUAxKLUoinltV50
	ErIe9xpHns=
X-Google-Smtp-Source: AGHT+IHGFsX570E/VHGBXZt+zZXEXJgo4U38E2ZbxJaZoVpP66CpF09TmzF+SNrTXecT+dNlCcyFYGvP8VrEBxeK46s=
X-Received: by 2002:a17:907:cd07:b0:b04:3402:391c with SMTP id
 a640c23a62f3a-b0493245ddbmr1259469766b.24.1757341253628; Mon, 08 Sep 2025
 07:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-11-ryncsn@gmail.com>
 <c2ff433c-35d4-45e4-bf06-e725726fa515@redhat.com>
In-Reply-To: <c2ff433c-35d4-45e4-bf06-e725726fa515@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 22:20:17 +0800
X-Gm-Features: AS18NWCLmEE5VtBcECnw9xE7lkKHrNT7pK6YNCKNupmeqEcDIpM6mw3F9Q4YvgQ
Message-ID: <CAMgjq7AsYz+pDTCU5PWoNPN1VJ5Vx8ZLQgF6MT26JUSXr=6__A@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a helper
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:35=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
>
> >
> > +/**
> > + * __swap_cache_replace_folio - Replace a folio in the swap cache.
> > + * @mapping: Swap mapping address space.
> > + * @entry: The first swap entry that the new folio corresponds to.
> > + * @old: The old folio to be replaced.
> > + * @new: The new folio.
> > + *
> > + * Replace a existing folio in the swap cache with a new folio.
> > + *
> > + * Context: Caller must ensure both folios are locked, and lock the
> > + * swap address_space that holds the entries to be replaced.
> > + */
> > +void __swap_cache_replace_folio(struct address_space *mapping,
> > +                             swp_entry_t entry,
> > +                             struct folio *old, struct folio *new)
>
> Can't we just use "new->swap.val" directly and avoid passing in the
> entry, documenting that new->swap.val must be setup properly in advance?

Thanks for the suggestion.

I was thinking about the opposite. I think maybe it's better that the
caller never sets the new folio's entry value, so folio->swap is always
modified in mm/swap_state.c, and let __swap_cache_replace_folio set
new->swap, to make it easier to track the folio->swap
usage.

This can be done easily for migration and shmem parts, the huge split
code will need a bit more cleanup.

It's a trivial change I think. But letting __swap_cache_replace_folio
setup new's swap and flags may deduplicate some code. So I thought
maybe this can be better cleaned up later. So for now I just add a
debug check here that `entry =3D=3D new->swap`.

And the debug check does imply that we can just drop the entry params
in this patch, there will be no feature change.

> Similarly, can't we obtain "mapping" from new?

This is doable. But this patch is only an intermediate patch, next
commit will let the pass in ci instead. Of course the `ci` can be
retrieved from `entry` directly too, but it's the caller's
responsibility to lock the `ci`, so passing in a locked ci explicitly
might be more intuitive? Also might save a tiny bit of CPU time from
recalculating and load the `ci`.


>
> --
> Cheers
>
> David / dhildenb
>
>

