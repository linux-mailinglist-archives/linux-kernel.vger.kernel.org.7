Return-Path: <linux-kernel+bounces-874861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F640C1744A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C31C24D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D496355810;
	Tue, 28 Oct 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV6Vxxcg"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2E199931
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692616; cv=none; b=AEIfDZrQvpJK2O+trhGnsVMcKtLdbhaTzCUegVk3esLaUaMdUzAbxODh3ij43+YCLpYod/RMdwD8P8GGF675qvU7ut4FQkfDrnha+rRUMGz0QXcMrKgGF6TkYrZeb8rEhvmZ+O4fiAwLMoieSwp5JCZnW6s9yOY//Q6JdMFz0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692616; c=relaxed/simple;
	bh=9HuVVNhT7SdBkbVKlmVPoxixH3Fr46fDtVq0c9q7mdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpRo13rKZhDnxiykZRzQgjxekLo+i7whAg6sgqXe3fuZVNsr8ewdUxf8oub4VcdHxxuvZHuNXOsF7Sy0MFvlJdRGxRIAvCFvvv5bgN6MalSexqAgm/k8rxDa6/Lv1xppL4ToIoXC9fgBODe+AEH1MQzo6/SGlEFyUe/dRQ9XYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kV6Vxxcg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ea12242d2eso78871cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761692613; x=1762297413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkCc0HiMOR5b7f9hSisLtYABo21aEVFL1TENQmedR60=;
        b=kV6VxxcgRKKjB7lfcRZt+n+qsYBCBwS2nbAH3EG9T9282JamrRlMNp5HVuaepf4kNn
         B6mgCeABIlPqWnCG2ELLIxpOYgjlj3NZDP4QrnC4ZE3DbLdcVZExdb3e3AgtJCFclPAQ
         pFEZaU2A3X1wLpDMzsj9AvTINAepMWm26RG31WXF0xF0RSSkO4y9nlVWfUhA3LRs5RRi
         Blxo4zNoVXkAGASwfnzEIFavijVKyixdzEB0Wjt67veuzMDcAOvGL1yHAmmHhBueZPo8
         d6G7JJkgWsJ4958yRLCpwI+fNmjhFPWZy/LuzXFE2loUVN1DR1N/jsS+cpOmYOjPr6f2
         8aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692613; x=1762297413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkCc0HiMOR5b7f9hSisLtYABo21aEVFL1TENQmedR60=;
        b=wHkD2c5XOO+h87Zy/py1F+pHVQ94XphBbo2C+jq/qJI0XM9vy1pAcDK2DYHAOqSqAu
         cIvkf0CBCeMpJkbVteB8Db+upgC2vZV/rkZsh20MoBIf7lN0CiHO7WYa0WU7TasyFX8f
         FA+rbbzfFdmemU/PHS7l7zgfly33qWDlRctHP0PCjeeUHAcb5tqlmyOXjNbSRZXaEf6T
         2irVyds4SdJTArOOivCM8oeE5MJSa9+LB4QXCRAj0xHGHqCAAEK4JUzw2s91iZ2UkZsx
         wRV/SWhtS8T5HjooHMa/2SyUxjk04zUHRt657lypfW0R1e8cEyFXl28L/OECmCRlf5nx
         A9nw==
X-Forwarded-Encrypted: i=1; AJvYcCXo5rr+Ze2RZJze1WkuUZ66PdPQxN32LqKud+abweIRxsUH2Mq/kTP9i8ZCFmjUuo1SxAh5aHzek+FwTV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZDULoCwVqo7NUc7A1Wo6tpdEIAkV1rGrez2+pm/2WoHY85pc
	1VwOBwI1AAng6ASaWgNl9i/Ct9z6yfofg51gu9XAOWc5epJN6w1Q5hLN4AyBZxu1iz8JjvBqh6b
	fLKtoKmzy611MrONl/MzdUTrsSHrp92rvXHm9Klu7
X-Gm-Gg: ASbGncs+U8OW2XUf+rmy+zbLaCyWdixAqfopVZ9QsqTECfrWkGcWpD+faZd761mjX28
	438cxeU2JeQCioQRyQRnOuI9TiVTVNSb1m9Xzpfn8vgG46Sz1TrYdO06TAk0tTKUTt1AvD/+qAE
	9A5l4E2FFG8hAv1M9T8Y7bl71llGAedG9Ezb2+Zl/OrHlI9FOSi9fVlGnqSQ3HxHGqOm8GJcOqN
	TNOKpS7iXfGgcfsa5QPdkNH+YNZjnavCwnbrjuXLE7C6pf9u96Litq6J/tCLw/cLCgLmSUJ3YMT
	d+DFkxyNRrlXDY4=
X-Google-Smtp-Source: AGHT+IECtf9j9yYYwTn83cGtMlWRO+L58MiSVVzfRwL7ZACF7lRW0t5eFEDX3F1aP2yNHZmUSVGxHQMgdOvIOlbYDik=
X-Received: by 2002:a05:622a:4d99:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ed1657e9f6mr1478901cf.7.1761692613074; Tue, 28 Oct 2025
 16:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-6-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-6-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 16:03:22 -0700
X-Gm-Features: AWmQ_blkp33Z4IMNKRW2xp9LBJRuH74c1VWBZTuALiMugzMI2usvKqnVdAqBpzQ
Message-ID: <CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 5/7] mm/memcontrol,alloc_tag: handle slabobj_ext
 access under KASAN poison
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@linux.com, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, 
	shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> In the near future, slabobj_ext may reside outside the allocated slab
> object range within a slab, which could be reported as an out-of-bounds
> access by KASAN. To prevent false positives, explicitly disable KASAN
> and KMSAN checks when accessing slabobj_ext.

Hmm. This is fragile IMO. Every time someone accesses slabobj_ext they
should remember to call
metadata_access_enable/metadata_access_disable.
Have you considered replacing slab_obj_ext() function with
get_slab_obj_ext()/put_slab_obj_ext()? get_slab_obj_ext() can call
metadata_access_enable() and return slabobj_ext as it does today.
put_slab_obj_ext() will simple call metadata_access_disable(). WDYT?

>
> While an alternative approach could be to unpoison slabobj_ext,
> out-of-bounds accesses outside the slab allocator are generally more
> common.
>
> Move metadata_access_enable()/disable() helpers to mm/slab.h so that
> it can be used outside mm/slub.c. Wrap accesses to slabobj_ext metadata
> in memcg and alloc_tag code with these helpers.
>
> Call kasan_reset_tag() in slab_obj_ext() before returning the address to
> prevent SW or HW tag-based KASAN from reporting false positives.
>
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 15 ++++++++++++---
>  mm/slab.h       | 24 +++++++++++++++++++++++-
>  mm/slub.c       | 33 +++++++++++++--------------------
>  3 files changed, 48 insertions(+), 24 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2a9dc246e802..38e6e9099ff5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2570,17 +2570,22 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(stru=
ct folio *folio, void *p)
>                 struct slabobj_ext *obj_ext;
>                 struct slab *slab;
>                 unsigned int off;
> +               struct mem_cgroup *memcg;
>
>                 slab =3D folio_slab(folio);
>                 obj_exts =3D slab_obj_exts(slab);
>                 if (!obj_exts)
>                         return NULL;
>
> +               metadata_access_enable();
>                 off =3D obj_to_index(slab->slab_cache, slab, p);
>                 obj_ext =3D slab_obj_ext(slab, obj_exts, off);
> -               if (obj_ext->objcg)
> -                       return obj_cgroup_memcg(obj_ext->objcg);
> -
> +               if (obj_ext->objcg) {
> +                       memcg =3D obj_cgroup_memcg(obj_ext->objcg);
> +                       metadata_access_disable();
> +                       return memcg;
> +               }
> +               metadata_access_disable();
>                 return NULL;
>         }
>
> @@ -3197,9 +3202,11 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cach=
e *s, struct list_lru *lru,
>
>                 obj_exts =3D slab_obj_exts(slab);
>                 off =3D obj_to_index(s, slab, p[i]);
> +               metadata_access_enable();
>                 obj_ext =3D slab_obj_ext(slab, obj_exts, off);
>                 obj_cgroup_get(objcg);
>                 obj_ext->objcg =3D objcg;
> +               metadata_access_disable();
>         }
>
>         return true;
> @@ -3210,6 +3217,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, s=
truct slab *slab,
>  {
>         size_t obj_size =3D obj_full_size(s);
>
> +       metadata_access_enable();
>         for (int i =3D 0; i < objects; i++) {
>                 struct obj_cgroup *objcg;
>                 struct slabobj_ext *obj_ext;
> @@ -3226,6 +3234,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, s=
truct slab *slab,
>                                  slab_pgdat(slab), cache_vmstat_idx(s));
>                 obj_cgroup_put(objcg);
>         }
> +       metadata_access_disable();
>  }
>
>  /*
> diff --git a/mm/slab.h b/mm/slab.h
> index 22ee28cb55e1..13f4ca65cb42 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -591,10 +591,14 @@ static inline struct slabobj_ext *slab_obj_ext(stru=
ct slab *slab,
>                                                unsigned long obj_exts,
>                                                unsigned int index)
>  {
> +       struct slabobj_ext *obj_ext;
> +
>         VM_WARN_ON_ONCE(!slab_obj_exts(slab));
>         VM_WARN_ON_ONCE(obj_exts !=3D slab_obj_exts(slab));
>
> -       return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * =
index);
> +       obj_ext =3D (struct slabobj_ext *)(obj_exts +
> +                                        slab_get_stride(slab) * index);
> +       return kasan_reset_tag(obj_ext);
>  }
>
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -625,6 +629,24 @@ static inline enum node_stat_item cache_vmstat_idx(s=
truct kmem_cache *s)
>                 NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
>  }
>
> +/*
> + * slub is about to manipulate internal object metadata.  This memory li=
es
> + * outside the range of the allocated object, so accessing it would norm=
ally
> + * be reported by kasan as a bounds error.  metadata_access_enable() is =
used
> + * to tell kasan that these accesses are OK.
> + */
> +static inline void metadata_access_enable(void)
> +{
> +       kasan_disable_current();
> +       kmsan_disable_current();
> +}
> +
> +static inline void metadata_access_disable(void)
> +{
> +       kmsan_enable_current();
> +       kasan_enable_current();
> +}
> +
>  #ifdef CONFIG_MEMCG
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru =
*lru,
>                                   gfp_t flags, size_t size, void **p);
> diff --git a/mm/slub.c b/mm/slub.c
> index 4383740a4d34..13acc9437ef5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -973,24 +973,6 @@ static slab_flags_t slub_debug;
>  static char *slub_debug_string;
>  static int disable_higher_order_debug;
>
> -/*
> - * slub is about to manipulate internal object metadata.  This memory li=
es
> - * outside the range of the allocated object, so accessing it would norm=
ally
> - * be reported by kasan as a bounds error.  metadata_access_enable() is =
used
> - * to tell kasan that these accesses are OK.
> - */
> -static inline void metadata_access_enable(void)
> -{
> -       kasan_disable_current();
> -       kmsan_disable_current();
> -}
> -
> -static inline void metadata_access_disable(void)
> -{
> -       kmsan_enable_current();
> -       kasan_enable_current();
> -}
> -
>  /*
>   * Object debugging
>   */
> @@ -2042,9 +2024,11 @@ static inline void mark_objexts_empty(struct slabo=
bj_ext *obj_exts)
>                 struct slabobj_ext *ext =3D slab_obj_ext(obj_exts_slab,
>                                                        slab_exts, offs);
>
> +               metadata_access_enable();
>                 /* codetag should be NULL */
>                 WARN_ON(ext->ref.ct);
>                 set_codetag_empty(&ext->ref);
> +               metadata_access_disable();
>         }
>  }
>
> @@ -2245,8 +2229,11 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache =
*s, void *object, gfp_t flags)
>          * If other users appear then mem_alloc_profiling_enabled()
>          * check should be added before alloc_tag_add().
>          */
> -       if (likely(obj_ext))
> +       if (likely(obj_ext)) {
> +               metadata_access_enable();
>                 alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size)=
;
> +               metadata_access_disable();
> +       }
>  }
>
>  static inline void
> @@ -2272,11 +2259,13 @@ __alloc_tagging_slab_free_hook(struct kmem_cache =
*s, struct slab *slab, void **p
>         if (!obj_exts)
>                 return;
>
> +       metadata_access_enable();
>         for (i =3D 0; i < objects; i++) {
>                 unsigned int off =3D obj_to_index(s, slab, p[i]);
>
>                 alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s-=
>size);
>         }
> +       metadata_access_disable();
>  }
>
>  static inline void
> @@ -2394,8 +2383,12 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
>         if (obj_exts) {
>                 off =3D obj_to_index(s, slab, p);
>                 obj_ext =3D slab_obj_ext(slab, obj_exts, off);
> -               if (unlikely(obj_ext->objcg))
> +               metadata_access_enable();
> +               if (unlikely(obj_ext->objcg)) {
> +                       metadata_access_disable();
>                         return true;
> +               }
> +               metadata_access_disable();
>         }
>
>         return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
> --
> 2.43.0
>

