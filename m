Return-Path: <linux-kernel+bounces-867275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7C2C021CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D5C3AB9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EAA337BB5;
	Thu, 23 Oct 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+7c0vPE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D46337116
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232890; cv=none; b=aorSriUGRLflJ4NtbyCaPowWBXMG7n7NyCaoc6cXhaRMrtUU8T84rlTvF3cc4daBfXXSr6vtQQbZ9T23NQX03i6cWnomaOLDs2/OuAPb1kUrBG4kJ/J/a9DRK4r71YIcjL0Hmj0kwme1L4097gmoznWsBVbkDtJ2udROQq+72FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232890; c=relaxed/simple;
	bh=GkL9WA5K+ltHnePlGyw1wMGJQ1UFA0pchGig9Ct/wWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsKWaqJmV3WO+gYIIqBLd+xZLycwom/tiZpngmYHJS+60zMQr4ZSg6IbypQbdNvul0DNM81HvZnssrkE4fl+NdAAE36h2HcXSAWSN/AYAuwb4iE7Ne8okHJ0zlFy2ralKOvJp2LLPlBRL0RAskESCvz+iyjYTpO/mB9PQLx6RWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+7c0vPE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29476dc9860so5862325ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761232888; x=1761837688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2jwrgWQY1h1RtIcpPrpzP6Qz2BnEli8aRyjgsdjGiM=;
        b=3+7c0vPEqX/ppGqhsw/TDBYGHrSy2DzUgUUJTrOXirqcLXHR3Um9eUsfAPc+51e8eW
         ckwybn/WMsmH6A6aIGKh/+qquR2ILg7bQ3nMBLcyD4fZxYLTV/wvNoYMDNWoRvTc17eq
         xikMvD3hxcrevL8p5iC8KLPhucCG8V6IlXc1iwcblihJTZc6lzTADczOAR6kEC3avkLX
         NkwReVx0ZPbQidJEiraDACDprUDLSHDu4c1/Dh1e/+qQWzDk5ameUTJBCMoAYnQQuhGk
         i5XrSpNCzfX3t53v/WWVAHBxmMzT95qu0WyRDUWD1KLUmQX3dFCtvML1Z3DIz2vijKzU
         5zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232888; x=1761837688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2jwrgWQY1h1RtIcpPrpzP6Qz2BnEli8aRyjgsdjGiM=;
        b=Kab30ANFwYJ3I30rthSsfJWmH+RF9NJacPdIIekdKjtmBqP9fXIwKnKZHf77Bcyno1
         A0IZOXizOA76FHJxQkhiDEQ4BYrV8weV1hCYAjODzNBXAoezD7aFSyJ5GuZjXbIXymh4
         +UwaS+SsgwoJzRkpdgzz2M7LosH5j+/CrDZwZPhvemFlnHCyud/E+U4cnzUwJTSSXzca
         9SoUVDgI52asLIw5PckdUW8MSRNp5tDbKymPrxBVYf65DXk47vq7gaLRugQ8TK1k1WgP
         e6mA5uKA3JZesRu2e2yKo/KhqH1jbuU/V9BaKGDb+y11wDuVLA2wIMFZHIVtFUjJAaZn
         nZxg==
X-Forwarded-Encrypted: i=1; AJvYcCVDpa2nM9szCaz+ms4giPfmpc8a7uzcfoUHc9wfNqb7wsL9LjlSSEWI/oyVb+XvUPNq7MD46SVHW5XtYaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVS47wmk2Af0oY5rbzeuv8ABLHGwykqyWbobMnbJMRCxvIDzHt
	40E3NmdJZvxaFIEFqxUuNcuXmiQ6+DIUMkC/Ff5MeevLg8ENIwqcnFCT9HXBkhEbDNv7lgxu1c0
	jxESSvtDPuN5y82xm1LaMch7x9flTlFTgxRBhNtHY
X-Gm-Gg: ASbGncth5klWKph/8aCvzRxSGL4uf4YfKgEjzxicGGsjQF3Eb0WYQvjvhbKzkIvY0wA
	dxI8/5s2hk8VeaO0OqNzU/LBZjpzUYMkP7HALFDCT+v/6Up0JSbEbELJD7DDimfQN/uNZj5mRj/
	+naB7ZzvkO+z2GR7logy8PeNG37W121cqIUGTWr4mbeTknirnf8Sx+oRQVZdevz6P6BIArJ93CE
	tXY2aURmcyZ6UiWur618pximLafG3gxf25gOEewN2dsc9tLHVg11vIoSoUfztKG38RDj0BQ5ck/
	iOMF/5mbgfl0elkfBkZpV9irH/j+MXYYOhrU
X-Google-Smtp-Source: AGHT+IEWgZ7UzgS2PohV24hBKhF9JtPcksvlA1uoFSx8c8CFEwNgsBYtAGAlA8K3H24IvkOMh8whAfHS8cAKsM7wQww=
X-Received: by 2002:a17:902:e746:b0:28d:195a:7d79 with SMTP id
 d9443c01a7336-290c9c897cemr312219295ad.5.1761232888223; Thu, 23 Oct 2025
 08:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
From: Marco Elver <elver@google.com>
Date: Thu, 23 Oct 2025 17:20:51 +0200
X-Gm-Features: AS18NWBMguvD9NqZ0MBG1ww1DA9Wez_eaadFg_kTQ6tj-ZGocLoyPMGw450Hbw4
Message-ID: <CANpmjNM06dVYKrraAb-XfF02u8+Jnh-rA5rhCEws4XLqVxdfWg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/19] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:53, Vlastimil Babka <vbabka@suse.cz> wrote:
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
> index 87a1d2f9de0d..4731b9e461c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5530,6 +5530,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>   *
>   * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>   * memcg charging is forced over limit if necessary, to avoid failure.
> + *
> + * It is possible that the allocation comes from kfence and then the sheaf
> + * size is not decreased.
>   */
>  void *
>  kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> @@ -5541,7 +5544,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>         if (sheaf->size == 0)
>                 goto out;
>
> -       ret = sheaf->objects[--sheaf->size];
> +       ret = kfence_alloc(s, s->object_size, gfp);
> +
> +       if (likely(!ret))
> +               ret = sheaf->objects[--sheaf->size];
>
>         init = slab_want_init_on_alloc(gfp, s);
>
> @@ -7361,14 +7367,8 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>         local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>
>         for (i = 0; i < size; i++) {
> -               void *object = kfence_alloc(s, s->object_size, flags);
> -
> -               if (unlikely(object)) {
> -                       p[i] = object;
> -                       continue;
> -               }
> +               void *object = c->freelist;
>
> -               object = c->freelist;
>                 if (unlikely(!object)) {
>                         /*
>                          * We may have removed an object from c->freelist using
> @@ -7449,6 +7449,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>                                  void **p)
>  {
>         unsigned int i = 0;
> +       void *kfence_obj;
>
>         if (!size)
>                 return 0;
> @@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>         if (unlikely(!s))
>                 return 0;
>
> +       /*
> +        * to make things simpler, only assume at most once kfence allocated
> +        * object per bulk allocation and choose its index randomly
> +        */
> +       kfence_obj = kfence_alloc(s, s->object_size, flags);
> +
> +       if (unlikely(kfence_obj)) {
> +               if (unlikely(size == 1)) {
> +                       p[0] = kfence_obj;
> +                       goto out;
> +               }
> +               size--;
> +       }
> +
>         if (s->cpu_sheaves)
>                 i = alloc_from_pcs_bulk(s, size, p);
>
> @@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>                 if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
>                         if (i > 0)
>                                 __kmem_cache_free_bulk(s, i, p);
> +                       if (kfence_obj)
> +                               __kfence_free(kfence_obj);
>                         return 0;
>                 }
>         }
>
> +       if (unlikely(kfence_obj)) {

Might be nice to briefly write a comment here in code as well instead
of having to dig through the commit logs.

The tests still pass? (CONFIG_KFENCE_KUNIT_TEST=y)

> +               int idx = get_random_u32_below(size + 1);
> +
> +               if (idx != size)
> +                       p[size] = p[idx];
> +               p[idx] = kfence_obj;
> +
> +               size++;
> +       }
> +
> +out:
>         /*
>          * memcg and kmem_cache debug support and memory initialization.
>          * Done outside of the IRQ disabled fastpath loop.
>
> --
> 2.51.1

