Return-Path: <linux-kernel+bounces-834733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4CBA562A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AE61B23CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5F2BE048;
	Fri, 26 Sep 2025 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4h1RjR+i"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B01EDA02
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929339; cv=none; b=OWUO3egD46h9MasPDehHP64gsrg/Ua0qf6CvjA+OPNL1qZwGlRD54ESI7Rz3zk97IGfFhtp3KltMkIZtAK6MEAXw4Iz8YkOpR9qczXXGF0Gq1PR8ox6hU5cHEBZsKwt0TD2vI+Xj2BfCmR0Oze+r5KCEQxiGzgxCt50NoDsjCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929339; c=relaxed/simple;
	bh=3PS/HJ0o/rgA4uwsSFvaSulCjPklTA4fqgSVnAufEpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTGQX40WJB7Gp5CGebGZbw45n5eKA794twPw4g9qBk6b3yRDBGrftH/q6NwWMU2tax6wW657iIJd/GB+ezGiE6Cn5w3ZjUzlZYRkr7JUVMxjA7u9puLO0yVoRhfnupeUDqNuW8jVJPh2ec/6AQySYh1oJR2YP3kZ8CqUGf4LxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4h1RjR+i; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4de60f19a57so212321cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758929335; x=1759534135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyHmJ1OLWtshcn0vntnSFMqZ7njQsSsL7v8kUFCynNA=;
        b=4h1RjR+i+RGmYEHrvolW4hvJYAVvmZ7PBrDByxkLssciSiVaxVOyPdal6oabgMY2TL
         5zDNJ5bKsCvE1UHASlECNaHcvQDPbsTpnVjVA1+OnybUUfod3pje5w5blM14+JTcning
         cwYBP2wziDq6tT1QJt9JbwWabN1F8ox8JNSQK/CAl2BIA1zimpCV0CEF1EcJ45OjHITA
         EvoHIInYcv2xpz0Q+sYvpYPAqcgn7NIJXwfnTu0EC5hJE3m34bMnsDKMFrtRKhqQleTV
         bsl7k778a6Wa6hntlim23MsylmNuZgGaUoDyPknbKOrsSGKI49WiQbRgrTIAj1PIxeOm
         iLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758929335; x=1759534135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyHmJ1OLWtshcn0vntnSFMqZ7njQsSsL7v8kUFCynNA=;
        b=xL60M2aztjgTu0MH46IuADnO3e6EPZX+bcP+acf1UIx9i4Vx8KNaACDu5ypDNTHf6/
         uv42KavdJ9IJBh9jjq3NCQgxULIa9cLABQkuMk+JhrUZSomqXPfzb5lVeKtMnARwZZjA
         y+MrpEjbFa/tmWXYmvGo04TSzttKPQY2S3jkJ1jhzznAjYAq9QlM3+/9oakx2R8uNHV+
         XkC9FKYs8CsWoIx6N607zeeQXqisi1ZEMI0lpHG8dBSvHVL0x11dcQn3YlNNLKNGvvnt
         IMeXL0sxJRmsgFoTT4FVZ2zd8ru9eVVu7GiaNo1CL0DbqenkzK9IckzhEN7FffEQDnaV
         5PWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJKHif/VdDA5Z35xY4zujX+sdZ/0sKdahbIP6ex0rtvd3qqX4T7nNqtlXH+Bt6KR7Ceg8HaL9A7u+D4JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbt0GhuGYmWuwUTLvQCkXPo8+iSdZkoyDtISUDSsFVDXid7zK0
	hXNr2DpedueZ01C5LClwAgaR0v2kvePf0kGPqL6InxevHrK0VAPYE3VDqX0Ok4fgPSt6DBpGcEp
	gzVIrc44zAEG47TquoRRXjOA4ebXhL57RfVJWpQJbZtQ/rlekz0hurGajzb4=
X-Gm-Gg: ASbGncuteor0KXLQgBXY9hgUEY9+Z1QPzM5JApVJbbOQ3O6hKA+j5AkvA4kZpwbgjfD
	wW5eD7aqahxvNLCFQESw8CUifO2OBmEsbKkG2hu6T+MEHGLc1uPtvi/o4jsJA344X+NCFzcnEmQ
	JHbOAx0aIuI/ZRX9pAhkoo6tctmPUKiJ9iwDkus3h7myhXdeyOjcRdhMHklhd+swELrGiLPHA5F
	/WtEPboXW0xadvdjsLUHug=
X-Google-Smtp-Source: AGHT+IEXgiREHqQHkfYfJbW0FjcZi0xJazfXduFxPLBHIQZs17nA8li3k5fv3C7MSckGpkzyuliLv2q6dzvLuCA44Cg=
X-Received: by 2002:a05:622a:94:b0:4b3:19b2:d22 with SMTP id
 d75a77b69052e-4dec82b1f37mr2996671cf.13.1758929334818; Fri, 26 Sep 2025
 16:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-13-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-13-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 16:28:43 -0700
X-Gm-Features: AS18NWAKMh82GOavYFTT6IjqXbKZ5pfBFaMk3uAlrOuFS1_KHUbuvk1adjY968Q
Message-ID: <CAJuCfpGYgOVG7hpZJ7MED_ALXZfKgUuRcPN3YYjx6k_t-dGXhg@mail.gmail.com>
Subject: Re: [PATCH v8 13/23] tools/testing: Add support for changes to slab
 for sheaves
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
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The slab changes for sheaves requires more effort in the testing code.
> Unite all the kmem_cache work into the tools/include slab header for
> both the vma and maple tree testing.
>
> The vma test code also requires importing more #defines to allow for
> seamless use of the shared kmem_cache code.
>
> This adds the pthread header to the slab header in the tools directory
> to allow for the pthread_mutex in linux.c.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

The patch does several things and could be split in 3 (code
refactoring, kmem_cache_create change, new definitions like
_slab_flag_bits) but I don't think it's worth a respin.

> ---
>  tools/include/linux/slab.h        | 137 ++++++++++++++++++++++++++++++++=
++++--
>  tools/testing/shared/linux.c      |  26 ++------
>  tools/testing/shared/maple-shim.c |   1 +
>  tools/testing/vma/vma_internal.h  |  92 +------------------------
>  4 files changed, 142 insertions(+), 114 deletions(-)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index c87051e2b26f5a7fee0362697fae067076b8e84d..c5c5cc6db5668be2cc94c2906=
5ccfa7ca7b4bb08 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -4,11 +4,31 @@
>
>  #include <linux/types.h>
>  #include <linux/gfp.h>
> +#include <pthread.h>
>
> -#define SLAB_PANIC 2
>  #define SLAB_RECLAIM_ACCOUNT    0x00020000UL            /* Objects are r=
eclaimable */
>
>  #define kzalloc_node(size, flags, node) kmalloc(size, flags)
> +enum _slab_flag_bits {
> +       _SLAB_KMALLOC,
> +       _SLAB_HWCACHE_ALIGN,
> +       _SLAB_PANIC,
> +       _SLAB_TYPESAFE_BY_RCU,
> +       _SLAB_ACCOUNT,
> +       _SLAB_FLAGS_LAST_BIT
> +};
> +
> +#define __SLAB_FLAG_BIT(nr)    ((unsigned int __force)(1U << (nr)))
> +#define __SLAB_FLAG_UNUSED     ((unsigned int __force)(0U))
> +
> +#define SLAB_HWCACHE_ALIGN     __SLAB_FLAG_BIT(_SLAB_HWCACHE_ALIGN)
> +#define SLAB_PANIC             __SLAB_FLAG_BIT(_SLAB_PANIC)
> +#define SLAB_TYPESAFE_BY_RCU   __SLAB_FLAG_BIT(_SLAB_TYPESAFE_BY_RCU)
> +#ifdef CONFIG_MEMCG
> +# define SLAB_ACCOUNT          __SLAB_FLAG_BIT(_SLAB_ACCOUNT)
> +#else
> +# define SLAB_ACCOUNT          __SLAB_FLAG_UNUSED
> +#endif
>
>  void *kmalloc(size_t size, gfp_t gfp);
>  void kfree(void *p);
> @@ -23,6 +43,86 @@ enum slab_state {
>         FULL
>  };
>
> +struct kmem_cache {
> +       pthread_mutex_t lock;
> +       unsigned int size;
> +       unsigned int align;
> +       unsigned int sheaf_capacity;
> +       int nr_objs;
> +       void *objs;
> +       void (*ctor)(void *);
> +       bool non_kernel_enabled;
> +       unsigned int non_kernel;
> +       unsigned long nr_allocated;
> +       unsigned long nr_tallocated;
> +       bool exec_callback;
> +       void (*callback)(void *);
> +       void *private;
> +};
> +
> +struct kmem_cache_args {
> +       /**
> +        * @align: The required alignment for the objects.
> +        *
> +        * %0 means no specific alignment is requested.
> +        */
> +       unsigned int align;
> +       /**
> +        * @sheaf_capacity: The maximum size of the sheaf.
> +        */
> +       unsigned int sheaf_capacity;
> +       /**
> +        * @useroffset: Usercopy region offset.
> +        *
> +        * %0 is a valid offset, when @usersize is non-%0
> +        */
> +       unsigned int useroffset;
> +       /**
> +        * @usersize: Usercopy region size.
> +        *
> +        * %0 means no usercopy region is specified.
> +        */
> +       unsigned int usersize;
> +       /**
> +        * @freeptr_offset: Custom offset for the free pointer
> +        * in &SLAB_TYPESAFE_BY_RCU caches
> +        *
> +        * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
> +        * outside of the object. This might cause the object to grow in =
size.
> +        * Cache creators that have a reason to avoid this can specify a =
custom
> +        * free pointer offset in their struct where the free pointer wil=
l be
> +        * placed.
> +        *
> +        * Note that placing the free pointer inside the object requires =
the
> +        * caller to ensure that no fields are invalidated that are requi=
red to
> +        * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
> +        * details).
> +        *
> +        * Using %0 as a value for @freeptr_offset is valid. If @freeptr_=
offset
> +        * is specified, %use_freeptr_offset must be set %true.
> +        *
> +        * Note that @ctor currently isn't supported with custom free poi=
nters
> +        * as a @ctor requires an external free pointer.
> +        */
> +       unsigned int freeptr_offset;
> +       /**
> +        * @use_freeptr_offset: Whether a @freeptr_offset is used.
> +        */
> +       bool use_freeptr_offset;
> +       /**
> +        * @ctor: A constructor for the objects.
> +        *
> +        * The constructor is invoked for each object in a newly allocate=
d slab
> +        * page. It is the cache user's responsibility to free object in =
the
> +        * same state as after calling the constructor, or deal appropria=
tely
> +        * with any differences between a freshly constructed and a reall=
ocated
> +        * object.
> +        *
> +        * %NULL means no constructor.
> +        */
> +       void (*ctor)(void *);
> +};
> +
>  static inline void *kzalloc(size_t size, gfp_t gfp)
>  {
>         return kmalloc(size, gfp | __GFP_ZERO);
> @@ -37,9 +137,38 @@ static inline void *kmem_cache_alloc(struct kmem_cach=
e *cachep, int flags)
>  }
>  void kmem_cache_free(struct kmem_cache *cachep, void *objp);
>
> -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size=
,
> -                       unsigned int align, unsigned int flags,
> -                       void (*ctor)(void *));
> +
> +struct kmem_cache *
> +__kmem_cache_create_args(const char *name, unsigned int size,
> +               struct kmem_cache_args *args, unsigned int flags);
> +
> +/* If NULL is passed for @args, use this variant with default arguments.=
 */
> +static inline struct kmem_cache *
> +__kmem_cache_default_args(const char *name, unsigned int size,
> +               struct kmem_cache_args *args, unsigned int flags)
> +{
> +       struct kmem_cache_args kmem_default_args =3D {};
> +
> +       return __kmem_cache_create_args(name, size, &kmem_default_args, f=
lags);
> +}
> +
> +static inline struct kmem_cache *
> +__kmem_cache_create(const char *name, unsigned int size, unsigned int al=
ign,
> +               unsigned int flags, void (*ctor)(void *))
> +{
> +       struct kmem_cache_args kmem_args =3D {
> +               .align  =3D align,
> +               .ctor   =3D ctor,
> +       };
> +
> +       return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
> +
> +#define kmem_cache_create(__name, __object_size, __args, ...)           =
\
> +       _Generic((__args),                                              \
> +               struct kmem_cache_args *: __kmem_cache_create_args,     \
> +               void *: __kmem_cache_default_args,                      \
> +               default: __kmem_cache_create)(__name, __object_size, __ar=
gs, __VA_ARGS__)
>
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list);
>  int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t s=
ize,
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 0f97fb0d19e19c327aa4843a35b45cc086f4f366..97b8412ccbb6d222604c7b397=
c53c65618d8d51b 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -16,21 +16,6 @@ int nr_allocated;
>  int preempt_count;
>  int test_verbose;
>
> -struct kmem_cache {
> -       pthread_mutex_t lock;
> -       unsigned int size;
> -       unsigned int align;
> -       int nr_objs;
> -       void *objs;
> -       void (*ctor)(void *);
> -       unsigned int non_kernel;
> -       unsigned long nr_allocated;
> -       unsigned long nr_tallocated;
> -       bool exec_callback;
> -       void (*callback)(void *);
> -       void *private;
> -};
> -
>  void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)=
(void *))
>  {
>         cachep->callback =3D callback;
> @@ -234,23 +219,26 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep=
, gfp_t gfp, size_t size,
>  }
>
>  struct kmem_cache *
> -kmem_cache_create(const char *name, unsigned int size, unsigned int alig=
n,
> -               unsigned int flags, void (*ctor)(void *))
> +__kmem_cache_create_args(const char *name, unsigned int size,
> +                         struct kmem_cache_args *args,
> +                         unsigned int flags)
>  {
>         struct kmem_cache *ret =3D malloc(sizeof(*ret));
>
>         pthread_mutex_init(&ret->lock, NULL);
>         ret->size =3D size;
> -       ret->align =3D align;
> +       ret->align =3D args->align;
> +       ret->sheaf_capacity =3D args->sheaf_capacity;
>         ret->nr_objs =3D 0;
>         ret->nr_allocated =3D 0;
>         ret->nr_tallocated =3D 0;
>         ret->objs =3D NULL;
> -       ret->ctor =3D ctor;
> +       ret->ctor =3D args->ctor;
>         ret->non_kernel =3D 0;
>         ret->exec_callback =3D false;
>         ret->callback =3D NULL;
>         ret->private =3D NULL;
> +
>         return ret;
>  }
>
> diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/map=
le-shim.c
> index 640df76f483e09f3b6f85612786060dd273e2362..9d7b743415660305416e972fa=
75b56824211b0eb 100644
> --- a/tools/testing/shared/maple-shim.c
> +++ b/tools/testing/shared/maple-shim.c
> @@ -3,5 +3,6 @@
>  /* Very simple shim around the maple tree. */
>
>  #include "maple-shared.h"
> +#include <linux/slab.h>
>
>  #include "../../../lib/maple_tree.c"
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 6b6e2b05918c9f95b537f26e20a943b34082825a..d5b87fa6a133f6d676488de25=
38c509e0f0e1d54 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -26,6 +26,7 @@
>  #include <linux/mm.h>
>  #include <linux/rbtree.h>
>  #include <linux/refcount.h>
> +#include <linux/slab.h>
>
>  extern unsigned long stack_guard_gap;
>  #ifdef CONFIG_MMU
> @@ -509,65 +510,6 @@ struct pagetable_move_control {
>                 .len_in =3D len_,                                        =
 \
>         }
>
> -struct kmem_cache_args {
> -       /**
> -        * @align: The required alignment for the objects.
> -        *
> -        * %0 means no specific alignment is requested.
> -        */
> -       unsigned int align;
> -       /**
> -        * @useroffset: Usercopy region offset.
> -        *
> -        * %0 is a valid offset, when @usersize is non-%0
> -        */
> -       unsigned int useroffset;
> -       /**
> -        * @usersize: Usercopy region size.
> -        *
> -        * %0 means no usercopy region is specified.
> -        */
> -       unsigned int usersize;
> -       /**
> -        * @freeptr_offset: Custom offset for the free pointer
> -        * in &SLAB_TYPESAFE_BY_RCU caches
> -        *
> -        * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
> -        * outside of the object. This might cause the object to grow in =
size.
> -        * Cache creators that have a reason to avoid this can specify a =
custom
> -        * free pointer offset in their struct where the free pointer wil=
l be
> -        * placed.
> -        *
> -        * Note that placing the free pointer inside the object requires =
the
> -        * caller to ensure that no fields are invalidated that are requi=
red to
> -        * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
> -        * details).
> -        *
> -        * Using %0 as a value for @freeptr_offset is valid. If @freeptr_=
offset
> -        * is specified, %use_freeptr_offset must be set %true.
> -        *
> -        * Note that @ctor currently isn't supported with custom free poi=
nters
> -        * as a @ctor requires an external free pointer.
> -        */
> -       unsigned int freeptr_offset;
> -       /**
> -        * @use_freeptr_offset: Whether a @freeptr_offset is used.
> -        */
> -       bool use_freeptr_offset;
> -       /**
> -        * @ctor: A constructor for the objects.
> -        *
> -        * The constructor is invoked for each object in a newly allocate=
d slab
> -        * page. It is the cache user's responsibility to free object in =
the
> -        * same state as after calling the constructor, or deal appropria=
tely
> -        * with any differences between a freshly constructed and a reall=
ocated
> -        * object.
> -        *
> -        * %NULL means no constructor.
> -        */
> -       void (*ctor)(void *);
> -};
> -
>  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
>  {
>         mas_pause(&vmi->mas);
> @@ -652,38 +594,6 @@ static inline void vma_init(struct vm_area_struct *v=
ma, struct mm_struct *mm)
>         vma->vm_lock_seq =3D UINT_MAX;
>  }
>
> -struct kmem_cache {
> -       const char *name;
> -       size_t object_size;
> -       struct kmem_cache_args *args;
> -};
> -
> -static inline struct kmem_cache *__kmem_cache_create(const char *name,
> -                                                    size_t object_size,
> -                                                    struct kmem_cache_ar=
gs *args)
> -{
> -       struct kmem_cache *ret =3D malloc(sizeof(struct kmem_cache));
> -
> -       ret->name =3D name;
> -       ret->object_size =3D object_size;
> -       ret->args =3D args;
> -
> -       return ret;
> -}
> -
> -#define kmem_cache_create(__name, __object_size, __args, ...)           =
\
> -       __kmem_cache_create((__name), (__object_size), (__args))
> -
> -static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflag=
s)
> -{
> -       return calloc(1, s->object_size);
> -}
> -
> -static inline void kmem_cache_free(struct kmem_cache *s, void *x)
> -{
> -       free(x);
> -}
> -
>  /*
>   * These are defined in vma.h, but sadly vm_stat_account() is referenced=
 by
>   * kernel/fork.c, so we have to these broadly available there, and tempo=
rarily
>
> --
> 2.51.0
>

