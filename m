Return-Path: <linux-kernel+bounces-887691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A269C38E26
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C159189DD9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FE233735;
	Thu,  6 Nov 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp6UJxkZ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F881DF25F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396760; cv=none; b=qJVtycAxHj8hJ69wWkk5Pm7DwewnGSkGdfqRlka3Zk+HDKkmJWYpiFHrSeYZjrmhAUJx1/IH86MbTuJbgFYx47eq/ms3gPary6bzucz9Lcvn9FzCMCjHJvWySrmupYwVZwEZF9o0fBG73Bcz28fmEj0LkrX1E2RGUN1uJc68daQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396760; c=relaxed/simple;
	bh=P4wGWJkm8gOctpm2JR1V83NPDjbvnu7PRXyFxGiiAHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1RbO5aFAaXKbRHWUBh135ZOp8OYtywEXdV0cKnPrK1xgYhdyJZ0ITS2/r2zW6sdfnv4y+72Ok/pnU4UZ81VTJKdqoN+7QcbJEURuhNhh51mlXrnoo5vajHFiWSQXw1BeJolqGQi2EzhJe4FIxEHtcacRcnL8jbwdHqEQeSv4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp6UJxkZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so295477f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762396757; x=1763001557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewoAJCSF8NH/dTxpovl4STEPgaBdVGC9xI+etM7pZH8=;
        b=cp6UJxkZ1gFNVSj6GNbcxQnqWKSXuaQzZorbV/UdINM4oUSSFdvQjnLzjtDB644com
         xT94NCd0wQiFGm8lf1b5kqMcAqS5UH15bROydhqs7tZANuDNOcoFBy8xiKiSuHlexdC1
         1U8dibLakopdm/OrtcxJ92YH82jfjbRkoiOIN82Hq/ttfvx9uzNTdIyqqIE1cqIllUFp
         5WGsKFHk2567zF4getVOLEr+0Kdc6oCHGrFQVDaBTEXlu5waqjrnd9O34jbwLnGliFcx
         pPaWtKAy8ZnPemAfYLMJGc9AN1xZdvJa2TbSkn5lgDq1ZBPi2WtqTlnWeO1sFKmp4JGB
         chkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396757; x=1763001557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewoAJCSF8NH/dTxpovl4STEPgaBdVGC9xI+etM7pZH8=;
        b=oz1a+gZ81OBSW2ruIVP5hEvJHyOfv5eWoBIHlhKp9aoI6v9+JhMu9bGpFgoV6wHtTT
         8a5kfJHIr/CMn4VaK2i+Nd1Ns6RBWD9inmUIxHJkADgDn+MQ+wTSPcTRDrZq4A5V6Z1W
         Y2/WoCfMfcTDIXzkOu4lVkyXqOxo4E85fHr4YR9bBH0z/s/ueHLZBqnpBzCic/ozlS5L
         OXi949xCk47xCWQJ9VmDuRoPGL7rDcRH5zeBj6cCAhaZkYGNbIduMtcMKhlT2E4tGuI0
         hqHjSAl6C0/J+mziwkXIOrA76NybtO4VAd0UMmLhSl/XZUNeYEUIQoy1OmFRpjmXIG9X
         Qgig==
X-Forwarded-Encrypted: i=1; AJvYcCWlD2kSKWgwztNV0NMxRr391Fue5TrnWAZCgQrPgDsnPw42TqeALvtd03dhTiF+1MdYDsTP8veP8k33vWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyziI4sQd7D+cJMzS+M9JjuvRxsOza/mNaSo5pjhE/fdJEY+Yf2
	ibBk6MJSt54H0e42dvEojodtwtGXHZOHNzNtUy/fjrzqKluOgwsEcggTCg7N0+DsigYTLUCxfG6
	Q9araMW/ZKk1HKKzNrC7gJ1GdcguwSvI=
X-Gm-Gg: ASbGncucLMyAcRTTN1m3GzIV0u6qwXUDSpu8spgnjtA4/26FNxIgjO1cY4E8ofgPwXB
	E4hUAi92EvI6kn92T9K71Za/AfElhOu2ZTjVIwIy4FtwAlzYU9HrWbXQYq/PrGCDIv1rOEZY5UZ
	63HNYgJPcRasMc6QDZa8ACjhWw4xGwnRqGVg5WTawDochmtK9vraNIztxTzt/cLmoO3m8qxdL5q
	NxRg7maq4nsSzD3I80eLla25k8pfD2Lw2PXEuyAKgD3akJNNzhcbnD9BQjHJxGBk3P+6oQqGY6M
	VvPUZliq/zVzmajTk0W3uFWtB/2d
X-Google-Smtp-Source: AGHT+IEMYxYr58b+9gWCWiOxY19wV2YuCXhlo+gockn3ye5gvJ4AIE1Hket4divhHgZldaCGzsJU+k/vwey2D9OfBOE=
X-Received: by 2002:a05:6000:2dca:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-429e32e36eamr4631215f8f.16.1762396757374; Wed, 05 Nov 2025
 18:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz> <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
In-Reply-To: <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:39:06 -0800
X-Gm-Features: AWmQ_bnDlj12yke_m0UY9rM9to7dPxs3SzBTZ6_PfSj5mhKDDRMWfaCanTzBLeU
Message-ID: <CAADnVQJY_iZ5a1_GbZ7HUot7tMwpxFyABEdrRU3tcMWPnVyGjg@mail.gmail.com>
Subject: Re: [PATCH 2/5] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> but it's conceptually the wrong layer, as KFENCE allocations should only
> happen when objects are actually handed out from slab to its users.
>
> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> was refilled with KFENCE objects. Continuing like this would also
> complicate the upcoming sheaf refill changes.
>
> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> to the places that return slab objects to users. slab_alloc_node() is
> already covered (see above). Add kfence_alloc() to
> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> prefilled sheafs, with a comment that the caller should not expect the
> sheaf size to decrease after every allocation because of this
> possibility.
>
> For kmem_cache_alloc_bulk() implement a different strategy to handle
> KFENCE upfront and rely on internal batched operations afterwards.
> Assume there will be at most once KFENCE allocation per bulk allocation
> and then assign its index in the array of objects randomly.
>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 074abe8e79f8..0237a329d4e5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5540,6 +5540,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, g=
fp_t gfp,
>   *
>   * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUN=
T
>   * memcg charging is forced over limit if necessary, to avoid failure.
> + *
> + * It is possible that the allocation comes from kfence and then the she=
af
> + * size is not decreased.
>   */
>  void *
>  kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> @@ -5551,7 +5554,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cac=
he *s, gfp_t gfp,
>         if (sheaf->size =3D=3D 0)
>                 goto out;
>
> -       ret =3D sheaf->objects[--sheaf->size];
> +       ret =3D kfence_alloc(s, s->object_size, gfp);
> +
> +       if (likely(!ret))
> +               ret =3D sheaf->objects[--sheaf->size];

Judging by this direction you plan to add it to kmalloc/alloc_from_pcs too?
If so it will break sheaves+kmalloc_nolock approach in
your prior patch set, since kfence_alloc() is not trylock-ed.
Or this will stay kmem_cache specific?

