Return-Path: <linux-kernel+bounces-782453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FABB3208B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA8A1CC8261
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7D288C89;
	Fri, 22 Aug 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPpGaxul"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867B2874F0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880116; cv=none; b=ZfY7nPRJDblXWlMweqUHOVb6nj+yW5bYaz5IDttS0WgaTJ2Yz/v8Ea6x+rqUF7QbX6DZeRcahagVvHnS0+hdCtFmDPvXeaio2Ch3zGGgTGTMMa05LqGasDa33wtIOhTm2py5br3BK2mXUS/rjAnGKDuEXmjhihe2Xobopxld+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880116; c=relaxed/simple;
	bh=lbFjMjAiva+RnH+MObTcNPysxHEPqtxiyvAjO7g8pIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crbQS+wSEqmuodMtgxi8jZgL5mEKrSPlDJ+B2aMEIRJn2GYRfOc8okRbXRYzmm46LoxKF9WAVowidCqyEg+Nj1klDQMPK4A+VKcSYkXTtCqkUWliDXxXVV9PMxqzI+/vlryvTHkkihiGZTnACTK1/FkeUVsuN1ZkInCpU3GcBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPpGaxul; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b12b123e48so31cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755880114; x=1756484914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf+lgLCtUqo6j13pKWPsvYiNR6tNGJ0wVHF5rG3wEgE=;
        b=dPpGaxullA2BT5F1Q7j4E/fBAfjQaCKbBPrN5ZopIHspEgffzVR0nuOJs+JyaNyrMX
         dhT8UOoCkIgCB6YOiBcuOQo3ej6wc+08jA1wvhnfdcdDhMPk1YmMXEoLQ3ll62K0/8Wo
         JqyRC9MC/Sj1VjI4Hi0JYpuZIa81MTnJkT+LWP2pvN1+FHn+KlPwRxdntzQwuC+TQBj3
         cFu6JNbKQHNSMV9BUlz3gULxAknpdOXqX+A7Z3t9aOB5haqCmutdWecaCrb+oVCj+7Vm
         grxIKdGGZLO8aYm9cSkTsx2dc8hDs2si4IdokX8Q2FOM13HdDIUP9A7weMVoxmoIkh5e
         i39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880114; x=1756484914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf+lgLCtUqo6j13pKWPsvYiNR6tNGJ0wVHF5rG3wEgE=;
        b=WKBPwpUv+73qL4JOnXCt6Pb7fwpgPYLzZLgsVa9IZTxHpaDHAI86yfIDhy+qutmOyi
         +FGlC21SrLuEdzatcObzLyjFcxqAyHGXB/gLaPDiarzCrQ5WCTi4/+btri7jAY8vdjpN
         q9Ui14W8VugvCB19lZbSpFc/mo5kMkbapORKPYehnLh/MNJxihzDGfhNgY50QzYXjz/+
         yLJ7tImuBGGQIulMAUSR9rAXFylw4k3T1NIG88tabsUDhiYblHs7i2cnc4HIUkUpiMyT
         g97ITGKkGg+gTjUJwrNF+b9cmYvQGiW6y3VRKV/f7GvDZiJbqIx73iSLb0f+JQdPY92S
         BWQg==
X-Forwarded-Encrypted: i=1; AJvYcCV/XPKZxVU6dNtlq12fNJuarZ9ZUXeFL+ImS4aMSObmxQAjntQokWQKiaUmjOe/pYZ8aVoqS0TNjt+Kqyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTNd4sLHkIA3c0c2ae6pBiOkChtlVXVn7omjycwMlaRCRZLOw
	wtqpq9/M4SMAVxd0+6XtXSrPEDfxXbwacqBJ0pCdtuJYXmnk5J1enNz55bPYfvrj2tHIn9lCoon
	G02u2jHeEHylCxYibzKG+N1SZJ4mmpTDOW+VwI3Hr
X-Gm-Gg: ASbGncuErr14jCX9w6/5b+nPnUCtnai9IQ9wB22piV3iL408sIHfeKrtd/jT/DjJv3b
	pNvNrpU4CPOmWCXfyYFrLVuQGw5DAzf/Mu/e+JixiB4FVVbM1tavrEh7gGo6eIHs9zBeh00ZVwa
	Qunxelsdnj5/y5huiM4QQZDQ4Fr0iwSGfXzE7jeOYsKP4jvbGtJiYtUgmVL3pSwBycBmW0rhHJW
	cTI+CS/flrc
X-Google-Smtp-Source: AGHT+IEeB9T4qbL+UK0u9FG3kDDzOikNRJHFqBW5WtIsltP7tBFpOKmY+dFwDmwerpPmhmqCXCSRQaTv+MbAq/hPPUs=
X-Received: by 2002:a05:622a:180b:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b2ac5b8096mr6202121cf.15.1755880113114; Fri, 22 Aug 2025
 09:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-5-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-5-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 09:28:21 -0700
X-Gm-Features: Ac12FXwI69etioIK7mYTuyWUpdhOHZOX0stE9nJoaN7MNJhvTMXHGKoJ0u9Mnow
Message-ID: <CAJuCfpHR=hceuAcnaCr3Hg-3mknvsmYy7jSScA8SATn7iwoN_w@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] tools: Add testing support for changes to rcu
 and slab for sheaves
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
> Make testing work for the slab and rcu changes that have come in with
> the sheaves work.
>
> This only works with one kmem_cache, and only the first one used.
> Subsequent setting of kmem_cache will not update the active kmem_cache
> and will be silently dropped because there are other tests which happen
> after the kmem_cache of interest is set.
>
> The saved active kmem_cache is used in the rcu callback, which passes
> the object to be freed.
>
> The rcu call takes the rcu_head, which is passed in as the field in the
> struct (in this case rcu in the maple tree node), which is calculated by
> pointer math.  The offset of which is saved (in a global variable) for
> restoring the node pointer on the callback after the rcu grace period
> expires.
>
> Don't use any of this outside of testing, please.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Couple nits but otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  tools/include/linux/slab.h            | 41 +++++++++++++++++++++++++++++=
+++---
>  tools/testing/shared/linux.c          | 24 ++++++++++++++++----
>  tools/testing/shared/linux/rcupdate.h | 22 +++++++++++++++++++
>  3 files changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index c87051e2b26f5a7fee0362697fae067076b8e84d..d1444e79f2685edb828adbce8=
b3fbb500c0f8844 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -23,6 +23,12 @@ enum slab_state {
>         FULL
>  };
>
> +struct kmem_cache_args {
> +       unsigned int align;
> +       unsigned int sheaf_capacity;
> +       void (*ctor)(void *);
> +};
> +
>  static inline void *kzalloc(size_t size, gfp_t gfp)
>  {
>         return kmalloc(size, gfp | __GFP_ZERO);
> @@ -37,9 +43,38 @@ static inline void *kmem_cache_alloc(struct kmem_cache=
 *cachep, int flags)
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
> index 0f97fb0d19e19c327aa4843a35b45cc086f4f366..f998555a1b2af4a899a468a65=
2b04622df459ed3 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -20,6 +20,7 @@ struct kmem_cache {
>         pthread_mutex_t lock;
>         unsigned int size;
>         unsigned int align;
> +       unsigned int sheaf_capacity;
>         int nr_objs;
>         void *objs;
>         void (*ctor)(void *);
> @@ -31,6 +32,8 @@ struct kmem_cache {
>         void *private;
>  };
>
> +static struct kmem_cache *kmem_active =3D NULL;
> +
>  void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)=
(void *))
>  {
>         cachep->callback =3D callback;
> @@ -147,6 +150,14 @@ void kmem_cache_free(struct kmem_cache *cachep, void=
 *objp)
>         pthread_mutex_unlock(&cachep->lock);
>  }
>
> +void kmem_cache_free_active(void *objp)
> +{
> +       if (!kmem_active)
> +               printf("WARNING: No active kmem_cache\n");
> +
> +       kmem_cache_free(kmem_active, objp);
> +}
> +
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list)
>  {
>         if (kmalloc_verbose)
> @@ -234,23 +245,28 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep=
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
> +       if (!kmem_active)
> +               kmem_active =3D ret;
> +
>         return ret;
>  }
>
> diff --git a/tools/testing/shared/linux/rcupdate.h b/tools/testing/shared=
/linux/rcupdate.h
> index fed468fb0c78db6f33fb1900c7110ab5f3c19c65..c95e2f0bbd93798e544d7d34e=
0823ed68414f924 100644
> --- a/tools/testing/shared/linux/rcupdate.h
> +++ b/tools/testing/shared/linux/rcupdate.h
> @@ -9,4 +9,26 @@
>  #define rcu_dereference_check(p, cond) rcu_dereference(p)
>  #define RCU_INIT_POINTER(p, v) do { (p) =3D (v); } while (0)
>
> +void kmem_cache_free_active(void *objp);
> +static unsigned long kfree_cb_offset =3D 0;
> +
> +static inline void kfree_rcu_cb(struct rcu_head *head)
> +{
> +       void *objp =3D (void *) ((unsigned long)head - kfree_cb_offset);
> +
> +       kmem_cache_free_active(objp);
> +}
> +
> +#ifndef offsetof
> +#define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
> +#endif
> +

We need a comment here that concurrent kfree_rcu() calls are not
supported because they would override each other's kfree_cb_offset.
Kinda obvious but I think unusual limitations should be explicitly
called out.

> +#define kfree_rcu(ptr, rhv)                                            \
> +do {                                                                   \
> +       if (!kfree_cb_offset)                                           \
> +               kfree_cb_offset =3D offsetof(typeof(*(ptr)), rhv);       =
 \
> +                                                                       \
> +       call_rcu(&ptr->rhv, kfree_rcu_cb);                              \
> +} while (0)

Any specific reason kfree_rcu() is a macro and not a static inline function=
?

> +
>  #endif
>
> --
> 2.50.1
>

