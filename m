Return-Path: <linux-kernel+bounces-782482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F48B320E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A77F64022E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFC43126CB;
	Fri, 22 Aug 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpKFzXqs"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7330F54F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881815; cv=none; b=ivSjSg3AMBqxY77ZqtzS+/Qzja/QGQaappg/T6IGONSwm6EeV6WQz6eLBcWWjra2vs5stH50Uzxep2Vpzcm3WqbeWXAvs/sltn3WXG10XSDm4UYf+gBQdP3yuniwaNj0Kjbu1aQCkEdfP7SVKC7mFuEqd6BLXWZ1l/cl3eJyge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881815; c=relaxed/simple;
	bh=K05aXzlURLhkW124leoe2bLJaZuJFdfYu3qH+zEKcLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfJb546uWSpR2ySVphI2cn3K3jN+4s9VsuAhv1k+LThmc8yXEHKW9Ek5wZoqN4RqSzRxoCuQIvjh4+IhzkZwnQEKZxD+mnUZwPfdOFaJLLrTF6IBwEgqjCoRDy0MhuU2LmoUU5fLulKi7kN7FYEy1cZFXxOR8pQjTL0a94jakqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpKFzXqs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b12b123e48so15671cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755881813; x=1756486613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7+mb346Ky9SrnqlMzxSuOIuQ43DVNmx39imjsZeCx8=;
        b=UpKFzXqsKT/UFbyOxtHYMXOqwSgEuGVBFq+Pcr7vRmUBPq45HojYGF/d8wSlWMnzPW
         6+EkXjdm9p7YuWv87OJBageq5YwRmBVfdRMUFJp78eL/E3eln+uC+o7nf9d0vgk1Og9Z
         nQFJAoVgso1pEFKgkkMqY7GDi/K+lQ3KWWKAzWt85IY8xlh43rHv/YBeD69AW6Ik05iV
         u7LQmKdWbw3wrFPQtDOXObPAJQm5TEjlIZJGv+k0IYiGvu09IpsddsHR313sVDKWP2uR
         oSu1TSjk6cKkaKJbGnZbYBHOjqIh0JGzzdw4HItnIAPlUspB94+GVqs20mxvHY+DhzEt
         Q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755881813; x=1756486613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7+mb346Ky9SrnqlMzxSuOIuQ43DVNmx39imjsZeCx8=;
        b=TRY8M6tr5DmR2h4a+21wNU3phbLTWBWPN7BcDfnqF4+fK8H4xHd2dJGXne3NOSQwxG
         c/eyA8FEMDcY7LbcclgAnRwBdi+bgRMVR1ipc8CAZUKiLzSJ8qy/yzzlibcOvOS84oR8
         R/wKEu8WHPCwocc2otq9tGcuzOubxTL4mze9v9VfJYX8McAd5pc3B7QY3GE0MYtPYuUp
         lRLvIJscqv3MgaA8i2SwgGNEO3Ppxz+vTRwMbUQPzyb6c2VWGBG3bMwkmYVm+SEYp3Jw
         JVFUTyLNjXQV6dPlXPsc5mpNn16l+wVbB1XrdNYjzgBtQB8dqAyukXZS8iN43KnqfRCk
         h7+w==
X-Forwarded-Encrypted: i=1; AJvYcCWUvZuFJ99jn/HyRcqLOZD6jAZAcbF+EplgKTHz8G5ApcD/Cpf5ZKtukmcTxs5eaRYfiZ/V0LYttGLDNiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZM+RdB8KhsfQfUeik3UBm2Mg51o0yZDnNHFEkEiVAzloScA0M
	XnM5zThPwzUoOp8xf+EGfrCqsNgxuXVg5PEPFS2ZAJzu0o+Xi3gAZCyRSfon75Jx7SJCcMWR/zi
	pDM8KBdUd0XwKXVA8LTg/DHrYiDuS/PcfwSMA2SBc
X-Gm-Gg: ASbGncufuJ5PmVsiXJzBO20feuojmNo4XXGkoCjZYNFgU9d0FtJXk/HOrdq6UqXq+Rp
	1AJoD+KtzGi9ErXUPnIyNOgZpQsVHhzUsE3AbK0vEvARKOqzp10ChECme0WW+ZCxpqFNfHRh8YU
	DdZdXBTmeE7nAMRstT5+u21gVq+P2egPA4YK/adsPkYZiSGzVH3tx1xMnsjJ3DOjJXTbWhZdrDA
	N3X4B85HiVQxWZhUg1ZriU=
X-Google-Smtp-Source: AGHT+IGw7Pkt+nPa5BqQmI3rSxIkNU+66I2ZSYPqvhJbttn+d3hLj7BStxnMej4LA7KUyYMX/ZtTCnEAprY29Edcnos=
X-Received: by 2002:a05:622a:28a:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4b2ac55b35cmr5874671cf.9.1755881812465; Fri, 22 Aug 2025
 09:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-6-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-6-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 09:56:41 -0700
X-Gm-Features: Ac12FXx75l6CZ6aDpuoDjkLGCAv-mu9WsReIJ33ovw1NXAgsqe14IMrJ0Uqvw-s
Message-ID: <CAJuCfpEsVE7Jae7PqWvgTtm38C5MPFx43+dDyYzfKLMQFuE_3A@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] tools: Add sheaves support to testing infrastructure
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Allocate a sheaf and fill it to the count amount.  Does not fill to the
> sheaf limit to detect incorrect allocation requests.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  tools/include/linux/slab.h   | 24 +++++++++++++
>  tools/testing/shared/linux.c | 84 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index d1444e79f2685edb828adbce8b3fbb500c0f8844..1962d7f1abee154e1cda5dba2=
8aef213088dd198 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -23,6 +23,13 @@ enum slab_state {
>         FULL
>  };
>
> +struct slab_sheaf {
> +       struct kmem_cache *cache;
> +       unsigned int size;
> +       unsigned int capacity;
> +       void *objects[];
> +};
> +
>  struct kmem_cache_args {
>         unsigned int align;
>         unsigned int sheaf_capacity;
> @@ -80,4 +87,21 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, s=
ize_t size, void **list);
>  int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t s=
ize,
>                           void **list);
>
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int s=
ize);
> +
> +void *
> +kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf);
> +
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf);
> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf **sheafp, unsigned int size);
> +
> +static inline unsigned int kmem_cache_sheaf_size(struct slab_sheaf *shea=
f)
> +{
> +       return sheaf->size;
> +}
> +
>  #endif         /* _TOOLS_SLAB_H */
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index f998555a1b2af4a899a468a652b04622df459ed3..e0255f53159bd3a1325d49192=
283dd6790a5e3b8 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -181,6 +181,12 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep,=
 gfp_t gfp, size_t size,
>         if (kmalloc_verbose)
>                 pr_debug("Bulk alloc %zu\n", size);
>
> +       if (cachep->exec_callback) {
> +               if (cachep->callback)
> +                       cachep->callback(cachep->private);
> +               cachep->exec_callback =3D false;
> +       }
> +
>         pthread_mutex_lock(&cachep->lock);
>         if (cachep->nr_objs >=3D size) {
>                 struct radix_tree_node *node;
> @@ -270,6 +276,84 @@ __kmem_cache_create_args(const char *name, unsigned =
int size,
>         return ret;
>  }
>
> +struct slab_sheaf *
> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int s=
ize)
> +{
> +       struct slab_sheaf *sheaf;
> +       unsigned int capacity;
> +
> +       if (size > s->sheaf_capacity)
> +               capacity =3D size;
> +       else
> +               capacity =3D s->sheaf_capacity;

nit:
capacity =3D max(size, s->sheaf_capacity);

> +
> +       sheaf =3D malloc(sizeof(*sheaf) + sizeof(void *) * s->sheaf_capac=
ity * capacity);

Should this really be `sizeof(void *) * s->sheaf_capacity * capacity`
or just `sizeof(void *) * capacity` ?


> +       if (!sheaf) {
> +               return NULL;
> +       }
> +
> +       memset(sheaf, 0, size);
> +       sheaf->cache =3D s;
> +       sheaf->capacity =3D capacity;
> +       sheaf->size =3D kmem_cache_alloc_bulk(s, gfp, size, sheaf->object=
s);
> +       if (!sheaf->size) {
> +               free(sheaf);
> +               return NULL;
> +       }
> +
> +       return sheaf;
> +}
> +
> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                struct slab_sheaf **sheafp, unsigned int size)
> +{
> +       struct slab_sheaf *sheaf =3D *sheafp;
> +       int refill;
> +
> +       if (sheaf->size >=3D size)
> +               return 0;
> +
> +       if (size > sheaf->capacity) {
> +               sheaf =3D kmem_cache_prefill_sheaf(s, gfp, size);
> +               if (!sheaf)
> +                       return -ENOMEM;
> +
> +               kmem_cache_return_sheaf(s, gfp, *sheafp);
> +               *sheafp =3D sheaf;
> +               return 0;
> +       }
> +
> +       refill =3D kmem_cache_alloc_bulk(s, gfp, size - sheaf->size,
> +                                      &sheaf->objects[sheaf->size]);
> +       if (!refill)
> +               return -ENOMEM;
> +
> +       sheaf->size +=3D refill;
> +       return 0;
> +}
> +
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +                struct slab_sheaf *sheaf)
> +{
> +       if (sheaf->size) {
> +               //s->non_kernel +=3D sheaf->size;

Above comment seems obsolete.

> +               kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
> +       }
> +       free(sheaf);
> +}
> +
> +void *
> +kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf)
> +{
> +       if (sheaf->size =3D=3D 0) {
> +               printf("Nothing left in sheaf!\n");
> +               return NULL;
> +       }
> +

Should we clear sheaf->objects[sheaf->size] for additional safety?

> +       return sheaf->objects[--sheaf->size];
> +}
> +
>  /*
>   * Test the test infrastructure for kem_cache_alloc/free and bulk counte=
rparts.
>   */
>
> --
> 2.50.1
>

