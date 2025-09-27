Return-Path: <linux-kernel+bounces-834751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D6BA56B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7F87A3B68
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860F1C7013;
	Sat, 27 Sep 2025 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shMDT+/n"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE81946C8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932927; cv=none; b=g3KQnHPmGx1wAOzObM7BtD1238+HuNvZhNCPUnokzaafdQv0FWETofr8ybjkYrzYv4m00PdB+TH7fDcKjIQVQITE4GC+t7vmDH9L/bFESscYIdv3nx9s9iBxMzYsZzfB4pzsH7dGRNrY72XPREcknoo/P4MIn6hJ2fPfB39oOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932927; c=relaxed/simple;
	bh=+EsN0XlVqOmDE1DhVZwSYNEJYhlnK3dmBdK7UbcW/tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmtUKuKILnk2OOI9R7Muj8RoQCLZY33dmcChxNO9EMOX3RA/3v8AdHb50kmkswPTyFn36Q2Ju5yeNplJvLazmoudJVIspAgsLc6Sf1udwQv533mVoVmMFnCMd0VA2EsV+zZdfv9Lk5X9OXl7vaWPLx9SOnihdwewYBwcvmloEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shMDT+/n; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso78201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758932925; x=1759537725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lL1xNsKEteMXMKmX3O4zRiD5wAUnbo9gdCrODnH6YU=;
        b=shMDT+/n4eP6ZyrA/a1HrFNs8cz1fKEOV1AAkg6jv1n7mscWcCmKSZKVsx5rZZmXg7
         5dOQFoW6x4Iv+Hiv/JZMx+LiKn/gLSis2eXAdg5iUVqdS8pM9p6W9XvFiPAP/4zuONqZ
         f32jqs+MT+7Klmd2ib7oRzm3Dg1o6iv6fYkTNLpDYvGNVbxbzPChVE/Q0uOtOMtXWjmI
         rT0UN7GoSsYhl3URr8U4E36wYcFseZxYkyDWuNuO/2YeC982ZCR3tt/P4xkiNtHjtHTT
         wck//Zo7+kuW1H1SHyAvBXiPFUvN5Lpj6q1gWxT+NselMwwD6Kzx7ER2QCziDEDAZMKg
         GReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932925; x=1759537725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lL1xNsKEteMXMKmX3O4zRiD5wAUnbo9gdCrODnH6YU=;
        b=ouqsZuAW2UP+AdAK20rpzgf1pzcMLJjv6lYkFQ2A38w/AQMzS+yHx2wPnzJ96lvrrt
         7hUzE268/D3JeKs6GsW/HvwrSPuQoVz+mCTVQckQ6AwO9t3UgMu7Q5glMirM0UTGFUEc
         WLSOsNR0yL9EF5E5CqVM94yihr22WFeD91FVB/aGoFmB9jNrzqCZ2ywX5sOsXDp3FzuV
         n+VGreeOFLKJKuSOqmsM+hQdP25y9BUewHWv/5V78N9uvEgRAOWLHtHdIv6GxI8nmxaH
         MQrM27JQXxfEWaqH3qBhYh3Q6Ofy/tBJWDSUh5Bexb0u1eN2FGg3Qhmec9ADbSso9saG
         z0ww==
X-Forwarded-Encrypted: i=1; AJvYcCXOaXwaXmDFtKwqRK/0TiUaK7OxWS4z4KR7FnoeTyworHb9u6Fb1pk9gVZFgP4NjboL1L/WmEeyxABFh70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGaiEg3QDfVfMvOKY/rkhCZa93xtChYP6wNMt+n9j2qiDVvqG
	wTEDeBo4CsfMTw7lTZLmnNJ92AVUHY0tegqLItqKuBaOPE2a4VvoHH2lYEPp9gwlwI8xBaUJnc6
	pgMbvZDDKRqUrOWlcOrtTYaFRGVvkVg0+29+eF0hm0+Lkc5138V16pU76APk=
X-Gm-Gg: ASbGncsfQ3wR7Q4gFSXVqnV7N1yz7eQHX+kVCabCR+qOp/KMEEKc9HvQBOJAiq7A9lj
	zQdopEuBHqNCevNErHqb1HoUDyQq9PnfnT4KGop6UNveluRfdzQG4iYa8HSjAfDcKfnUsx7hFvq
	WSrzId4P3ZaJSLMsDc3yiLsu8uquA4nBpculj/NV13OL3aFKLUJzOp0Efp2SQ6LwFyFRR3Y+vIR
	u8zXOurlCPj
X-Google-Smtp-Source: AGHT+IH5IFJR77Y9edST6Xxl+0Cot4RzHoKBIGdLSAKbGPf4fsdiUsyYbAo8BpYxzO/JKdii+i+G1WOVfpK48XW3h2k=
X-Received: by 2002:a05:622a:2cd:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4dec6b1f86cmr2934011cf.5.1758932924368; Fri, 26 Sep 2025
 17:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-20-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-20-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 17:28:33 -0700
X-Gm-Features: AS18NWANsOMOuXdXD-T691vO4VKx0kp2e8h8yCDMUhco_cBrMY2tOuwxOaQ01iY
Message-ID: <CAJuCfpEQzHM8hwTLXj8evuWHcUWvsM+HecwkLgP3i-A30rAtHQ@mail.gmail.com>
Subject: Re: [PATCH v8 20/23] tools/testing: Add support for prefilled slab sheafs
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>
> Add the prefilled sheaf structs to the slab header and the associated
> functions to the testing/shared/linux.c file.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  tools/include/linux/slab.h   | 28 ++++++++++++++
>  tools/testing/shared/linux.c | 89 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 117 insertions(+)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index c5c5cc6db5668be2cc94c29065ccfa7ca7b4bb08..94937a699402bd1f31887dfb5=
2b6fd0a3c986f43 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -123,6 +123,18 @@ struct kmem_cache_args {
>         void (*ctor)(void *);
>  };
>
> +struct slab_sheaf {
> +       union {
> +               struct list_head barn_list;
> +               /* only used for prefilled sheafs */
> +               unsigned int capacity;
> +       };
> +       struct kmem_cache *cache;
> +       unsigned int size;
> +       int node; /* only used for rcu_sheaf */
> +       void *objects[];
> +};
> +
>  static inline void *kzalloc(size_t size, gfp_t gfp)
>  {
>         return kmalloc(size, gfp | __GFP_ZERO);
> @@ -173,5 +185,21 @@ __kmem_cache_create(const char *name, unsigned int s=
ize, unsigned int align,
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list);
>  int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t s=
ize,
>                           void **list);
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
>
>  #endif         /* _TOOLS_SLAB_H */
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 97b8412ccbb6d222604c7b397c53c65618d8d51b..4ceff7969b78cf8e33cd1e021=
c68bc9f8a02a7a1 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -137,6 +137,12 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep,=
 size_t size, void **list)
>         if (kmalloc_verbose)
>                 pr_debug("Bulk free %p[0-%zu]\n", list, size - 1);
>
> +       if (cachep->exec_callback) {
> +               if (cachep->callback)
> +                       cachep->callback(cachep->private);
> +               cachep->exec_callback =3D false;
> +       }
> +
>         pthread_mutex_lock(&cachep->lock);
>         for (int i =3D 0; i < size; i++)
>                 kmem_cache_free_locked(cachep, list[i]);
> @@ -242,6 +248,89 @@ __kmem_cache_create_args(const char *name, unsigned =
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
> +       if (s->exec_callback) {
> +               if (s->callback)
> +                       s->callback(s->private);
> +               s->exec_callback =3D false;
> +       }
> +
> +       capacity =3D max(size, s->sheaf_capacity);
> +
> +       sheaf =3D calloc(1, sizeof(*sheaf) + sizeof(void *) * capacity);
> +       if (!sheaf)
> +               return NULL;
> +
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
> +       if (sheaf->size)
> +               kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
> +
> +       free(sheaf);
> +}
> +
> +void *
> +kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
> +               struct slab_sheaf *sheaf)
> +{
> +       void *obj;
> +
> +       if (sheaf->size =3D=3D 0) {
> +               printf("Nothing left in sheaf!\n");
> +               return NULL;
> +       }
> +
> +       obj =3D sheaf->objects[--sheaf->size];
> +       sheaf->objects[sheaf->size] =3D NULL;
> +
> +       return obj;
> +}
> +
>  /*
>   * Test the test infrastructure for kem_cache_alloc/free and bulk counte=
rparts.
>   */
>
> --
> 2.51.0
>

