Return-Path: <linux-kernel+bounces-875076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8168C18295
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3691C64FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618F2D7DDA;
	Wed, 29 Oct 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5FOM64f"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA89286887
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708013; cv=none; b=UNQTGOKu22y7wkTxHPXg/Fzc8yiSDZMusbjOIPOAf2h+klGrXF7jEIArebt6kI8YL7cgyCGSHRFwIulDC6IOyuIvBovx5ppk5BkEqRI30fTen2nf8acDltMh7jFDg9Gk0bsnurrCRfsGW6a1ECvmCqlVGNaJQeVFDpQ40T9kpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708013; c=relaxed/simple;
	bh=SIP++6o+k6IcipYfeugLKrXlgVr2Mx3kGzLxkrySjFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3vAnXM7Yykb6PnJATI+4qwfLwGTBeMw+nHmfk7GNUuMBAgbyLYPQ5NtmlEuLSHs5EdtLNdIJFRA3wn1SdHKrt9e+Cs+gFpNIxG694NSWW27tQKL0z+8egGfDT4Y6eEj7UbBkqWEv/gbUFk+0BfmQQ62PvibA4wLGMVxGB3AOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5FOM64f; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ea12242d2eso130551cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761708010; x=1762312810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sWCgjKKhp7TKcKNU9g7Njs3zaKm3E/eeC+3FUQGpNQ=;
        b=w5FOM64fgukX+r7h07DpMYI7lUOz5Hr/kgQ2syyKIYt9SDRWbyeFt0Bd09nNwqm9Wk
         X7UeR6s+KD/VlJq+wt9j3cYiC4st47t4lKQR1bknICZ9mbCpFvP0zWyTWFxHfAHcbBkM
         C86q7A5m+A8k9AG1Fue704S0Qsd5ZcByYhPuc3tDaagJFwIi6SmJjY17UM76YhP9WSR6
         LGB7x3UsZyA24lMaPcPx15HoiXGCjumm7yYGRYNW2CpguRdZPexqnoTwOwrjl9q4ZLDe
         9+fky52j0gi9aKJzrvOIaTLqJ9DAsGv5BjewEmqrXMhfKzHllByjswovEaOh3/6phsd6
         OdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708010; x=1762312810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWCgjKKhp7TKcKNU9g7Njs3zaKm3E/eeC+3FUQGpNQ=;
        b=VYcL7yc1nW7OMtMk8rJ0/zK4qIZA4mfQbuH72eHVyEI+4f3d4HgbthL3BwLLxM8YrU
         GtC4M63uQx2xjAZvLvJGbkZai2TiaVmTSTrZtio+N0/R+6I8EThuy+13QvFM7b+tVBqh
         vs+jdeq3euJ+rZO4aCcY1eF522gKj8VS8Fz1kauUmATzSUKP/S9qje3TpfWIgZg/+zLa
         J6fypX88q12E71HURUEfn+dWheXjstdh+xClqz07cGCmzO9NVAhrh2dlpCF1kbJES1iJ
         3Mw6EuCm4YpFvLtWhcYdMepDMUm8Rftjxea0xOsqqOAxnp5lQhXoOiX0ZpuD6lcTjfEj
         QrVw==
X-Forwarded-Encrypted: i=1; AJvYcCXjFmaZCy4I9crhfKEVSckHfnxQNqov/0iRuXjPwRrDm8JxYEezFhu0o1ubKjzm19F2+p0k3GGLepuItZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCo7DAtkq/srjf4RNhuACsE3UiIIeWm0fXoKS0/0Vls7d/2Pk
	9qNdwOTyFVdV3HQUrLuN3vCyssIZTa0/6P4Ux9dMOREeqbaL67aA6bVSWxlgAb/cMQMby2zcxK8
	prF1anX/gWT+mfnNCXb4txMbN0iWUs8QUH0MO1Vny
X-Gm-Gg: ASbGncu+ufk/FMvYNWT87575I5afDYvc9w7MgPNWeWhJUCj4lx7dXVCZIC5B4TtXcA+
	ZzYNatmRBPs3eiO55vLVhPfdqgTnDqztxdEOo4MIKFQKbp8WALyJqQ5amGAmmNuTPTOf3sKXZtG
	Mt8eG69KuUgeOx2L8cFB0G7k3grR2twttCgg2UJXbAGgBGCR7vE0rjsw3++JBj8DKGh5Bw4oqoc
	znJ5CVUPM6rcUiNmTZYTO42WmlZlmuXccypkCFQlvvsw58Wr8xKddztHjM2Hy9odM//yw==
X-Google-Smtp-Source: AGHT+IEgHBrwGW14wfvE+tNAHLr5vJEtehAhSwoEdeqMmNNr0R+yG/j5eehRFy4Sh6qRX8n2G2p+LqQGRABiqViVmh0=
X-Received: by 2002:a05:622a:244d:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ed157de56amr3957211cf.2.1761708010022; Tue, 28 Oct 2025
 20:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-8-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-8-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 20:19:59 -0700
X-Gm-Features: AWmQ_blp-ZEBcawtFO459XLUyJcG47lh4LXAakbZFQWgL79B818mKpJ-2TDZ1ko
Message-ID: <CAJuCfpHNhes_csqvm9-Z2f-C6XWuyRuXpchNtXwTSXxTpARZSg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 7/7] mm/slab: place slabobj_ext metadata in unused
 space within s->size
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
> When a cache has high s->align value and s->object_size is not aligned
> to it, each object ends up with some unused space because of alignment.
> If this wasted space is big enough, we can use it to store the
> slabobj_ext metadata instead of wasting it.
>
> On my system, this happens with caches like kmem_cache, mm_struct, pid,
> task_struct, sighand_cache, xfs_inode, and others.
>
> To place the slabobj_ext metadata within each object, the existing
> slab_obj_ext() logic can still be used by setting:
>
>   - slab->obj_exts =3D slab_address(slab) + s->red_left_zone +
>                      (slabobj_ext offset)
>   - stride =3D s->size
>
> slab_obj_ext() doesn't need know where the metadata is stored,
> so this method works without adding extra overhead to slab_obj_ext().
>
> A good example benefiting from this optimization is xfs_inode
> (object_size: 992, align: 64). To measure memory savings, 2 millions of
> files were created on XFS.
>
> [ MEMCG=3Dy, MEM_ALLOC_PROFILING=3Dn ]
>
> Before patch (creating 2M directories on xfs):
>   Slab:            6693844 kB
>   SReclaimable:    6016332 kB
>   SUnreclaim:       677512 kB
>
> After patch (creating 2M directories on xfs):
>   Slab:            6697572 kB
>   SReclaimable:    6034744 kB
>   SUnreclaim:       662828 kB (-14.3 MiB)
>
> Enjoy the memory savings!
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/slab.h |  9 ++++++
>  mm/slab_common.c     |  6 ++--
>  mm/slub.c            | 72 ++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 82 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 561597dd2164..fd09674cc117 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -59,6 +59,9 @@ enum _slab_flag_bits {
>         _SLAB_CMPXCHG_DOUBLE,
>  #ifdef CONFIG_SLAB_OBJ_EXT
>         _SLAB_NO_OBJ_EXT,
> +#endif
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +       _SLAB_OBJ_EXT_IN_OBJ,
>  #endif
>         _SLAB_FLAGS_LAST_BIT
>  };
> @@ -244,6 +247,12 @@ enum _slab_flag_bits {
>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
>  #endif
>
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +#define SLAB_OBJ_EXT_IN_OBJ    __SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
> +#else
> +#define SLAB_OBJ_EXT_IN_OBJ    __SLAB_FLAG_UNUSED
> +#endif
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 2c2ed2452271..bfe2f498e622 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
>  struct kmem_cache *kmem_cache;
>
>  /*
> - * Set of flags that will prevent slab merging
> + * Set of flags that will prevent slab merging.
> + * Any flag that adds per-object metadata should be included,
> + * since slab merging can update s->inuse that affects the metadata layo=
ut.
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
>                 SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_NO_MERGE)
> +               SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
>
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> diff --git a/mm/slub.c b/mm/slub.c
> index 8101df5fdccf..7de6e8f8f8c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -970,6 +970,40 @@ static inline bool obj_exts_in_slab(struct kmem_cach=
e *s, struct slab *slab)
>  {
>         return false;
>  }
> +
> +#endif
> +
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +static bool obj_exts_in_object(struct kmem_cache *s)
> +{
> +       return s->flags & SLAB_OBJ_EXT_IN_OBJ;
> +}
> +
> +static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> +{
> +       unsigned int offset =3D get_info_end(s);
> +
> +       if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> +               offset +=3D sizeof(struct track) * 2;
> +
> +       if (slub_debug_orig_size(s))
> +               offset +=3D ALIGN(sizeof(unsigned int),
> +                               __alignof__(unsigned long));
> +
> +       offset +=3D kasan_metadata_size(s, false);
> +
> +       return offset;
> +}
> +#else
> +static inline bool obj_exts_in_object(struct kmem_cache *s)
> +{
> +       return false;
> +}
> +
> +static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *=
s)
> +{
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_SLUB_DEBUG
> @@ -1270,6 +1304,9 @@ static void print_trailer(struct kmem_cache *s, str=
uct slab *slab, u8 *p)
>
>         off +=3D kasan_metadata_size(s, false);
>
> +       if (obj_exts_in_object(s))
> +               off +=3D sizeof(struct slabobj_ext);
> +
>         if (off !=3D size_from_object(s))
>                 /* Beginning of the filler is the free pointer */
>                 print_section(KERN_ERR, "Padding  ", p + off,
> @@ -1439,7 +1476,10 @@ check_bytes_and_report(struct kmem_cache *s, struc=
t slab *slab,
>   *     A. Free pointer (if we cannot overwrite object on free)
>   *     B. Tracking data for SLAB_STORE_USER
>   *     C. Original request size for kmalloc object (SLAB_STORE_USER enab=
led)
> - *     D. Padding to reach required alignment boundary or at minimum
> + *     D. KASAN alloc metadata (KASAN enabled)
> + *     E. struct slabobj_ext to store accounting metadata
> + *        (SLAB_OBJ_EXT_IN_OBJ enabled)
> + *     F. Padding to reach required alignment boundary or at minimum
>   *             one word if debugging is on to be able to detect writes
>   *             before the word boundary.
>   *
> @@ -1468,6 +1508,9 @@ static int check_pad_bytes(struct kmem_cache *s, st=
ruct slab *slab, u8 *p)
>
>         off +=3D kasan_metadata_size(s, false);
>
> +       if (obj_exts_in_object(s))
> +               off +=3D sizeof(struct slabobj_ext);
> +
>         if (size_from_object(s) =3D=3D off)
>                 return 1;
>
> @@ -2250,7 +2293,8 @@ static inline void free_slab_obj_exts(struct slab *=
slab)
>         if (!obj_exts)
>                 return;
>
> -       if (obj_exts_in_slab(slab->slab_cache, slab)) {
> +       if (obj_exts_in_slab(slab->slab_cache, slab) ||
> +                       obj_exts_in_object(slab->slab_cache)) {


I think you need a check for obj_exts_in_object() inside
alloc_slab_obj_exts() to avoid allocating the vector.

>                 slab->obj_exts =3D 0;
>                 return;
>         }
> @@ -2291,6 +2335,21 @@ static void alloc_slab_obj_exts_early(struct kmem_=
cache *s, struct slab *slab)
>                 if (IS_ENABLED(CONFIG_MEMCG))
>                         slab->obj_exts |=3D MEMCG_DATA_OBJEXTS;
>                 slab_set_stride(slab, sizeof(struct slabobj_ext));
> +       } else if (obj_exts_in_object(s)) {
> +               unsigned int offset =3D obj_exts_offset_in_object(s);
> +
> +               slab->obj_exts =3D (unsigned long)slab_address(slab);
> +               slab->obj_exts +=3D s->red_left_pad;
> +               slab->obj_exts +=3D obj_exts_offset_in_object(s);
> +               if (IS_ENABLED(CONFIG_MEMCG))
> +                       slab->obj_exts |=3D MEMCG_DATA_OBJEXTS;
> +               slab_set_stride(slab, s->size);
> +
> +               for_each_object(addr, s, slab_address(slab), slab->object=
s) {
> +                       kasan_unpoison_range(addr + offset,
> +                                            sizeof(struct slabobj_ext));
> +                       memset(addr + offset, 0, sizeof(struct slabobj_ex=
t));
> +               }
>         }
>         metadata_access_disable();
>  }
> @@ -7883,6 +7942,7 @@ static int calculate_sizes(struct kmem_cache_args *=
args, struct kmem_cache *s)
>  {
>         slab_flags_t flags =3D s->flags;
>         unsigned int size =3D s->object_size;
> +       unsigned int aligned_size;
>         unsigned int order;
>
>         /*
> @@ -7997,7 +8057,13 @@ static int calculate_sizes(struct kmem_cache_args =
*args, struct kmem_cache *s)
>          * offset 0. In order to align the objects we have to simply size
>          * each object to conform to the alignment.
>          */
> -       size =3D ALIGN(size, s->align);
> +       aligned_size =3D ALIGN(size, s->align);
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +       if (aligned_size - size >=3D sizeof(struct slabobj_ext))
> +               s->flags |=3D SLAB_OBJ_EXT_IN_OBJ;
> +#endif
> +       size =3D aligned_size;
> +
>         s->size =3D size;
>         s->reciprocal_size =3D reciprocal_value(size);
>         order =3D calculate_order(size);
> --
> 2.43.0
>

