Return-Path: <linux-kernel+bounces-874632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E31C16BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598F71C273ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19334D4F5;
	Tue, 28 Oct 2025 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlvWkAOt"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966334FF50
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682272; cv=none; b=dNlpQpXHYVy6UBPrBXpnZbAj5dhl3bY6CYSedEn3kFYvViGLfV+DhEjMdbhc5QoEw90xQHCuuPmNoUlDViTu6SNHURNZW0gTSoVkfRnL9ff2G3pkdzXSaPnc3dVROTAG2Ir6w6on668xf3FFM8TpoOcYW7OROYxHS47dEHZ2zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682272; c=relaxed/simple;
	bh=WIEkkOtTRi4Tg7Vn4nXnOi0itFtJNK1QxhxwSLvXlAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4tJZTF+ekApeacakfVcf8af6x5pF//bM3q4ahb9Bn5DF34TYEl3TpfH0mxq5HO4zYMxRIp8aDVcw7HCiqecgpEsC2EdXpAiFE7CpL4z8bFpHnq+Zz9684F68jZP5tPGzRSNUA3DLBIFuOcyZ0Gq/ewdmLdO+6o0sCVEbdD1TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlvWkAOt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ea12242d2eso22431cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761682269; x=1762287069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=272mfK03DhLZ+PWwFMbt/hjHyzJqiJdlddFvMA6SlA0=;
        b=IlvWkAOtPlv02gwgeErA0sc9AqWJLiGQx8j6V62nAOV3FFPJ6it5ckQ+jJ7v7fKyGx
         6eRjppfilOi0P9AN1pKN21LMWwDmnWb/FjWsJD4pl9L9qeuoGOc8oiip2Xyk4RbamUzp
         EfcVUnHgg2ePt6F1sXm1lSG4tDa601bAAXdleRYRBwflbVm3GBv3Ire/+vPlqIFz5yJs
         WJya5zbl7X9nMf8kWKrLNQ0bSo/qAE5yNEVo1N56r1Nbu86rka3+jkfXVqpl7j65VHnQ
         owIcHnaW9Z3IGAS7An0miWR6y+YPjAFe01HWOJmvFoUmb3fMGTzABJdQhfd+eSPexCQt
         +fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682269; x=1762287069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=272mfK03DhLZ+PWwFMbt/hjHyzJqiJdlddFvMA6SlA0=;
        b=v4d37cGK7ozFjZ/pkZL5daBNubCxLKaNABIemqS9O4T549Jpd2rimKSHxOokWpx0c+
         ePFoFp0oTZrbNdWxMGM4BULerI14EFWKZusuavp93sX9RO8/SkgroKNRwPpyN1dMPMm3
         H02bsYT5skuPQbzuXOEDMYpbVoXZyPAwBVsbHkmVNLhItLEg7i0k+keQGzBym3IJNjec
         7WVlvhe1lCTufY5VBF451WkJHlo7IpPcgM2ywptn6Nc9wjKle2zkXnQQlKyZOnu5P0NK
         6kNSfomU2/p4ALlmv9QSE2jkhXtV5zZACIJGw5RqZUMgHQmSt+yqJ737MucvIbJSaKd/
         xvgA==
X-Forwarded-Encrypted: i=1; AJvYcCUCZ3CFIEwR2bWEhZWgJHYaDNbqBALHSTyHxwggxP0DLxbCcuYYwbo2s5lIS52Dvu7SNly7ZbNn5fgMBN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWj85SUB3khLrj1mYRwfn9dITSHL5JP5WJF3xMtNZYRBGWKd7c
	mbXlGoiGy3q8G3p7qBVTfoUxs7ngUsXPUg5Q7pBBfmSMlf3IGRJG71dJvv9/zXyimx/d5miW3KI
	yjbCuQbUjRcshcWjj8c5D6Dm2WPLdZUHVFg1ZOdb4
X-Gm-Gg: ASbGncsY/KHKkbg6Nk27Ka4cj15RNb8uwhm9IKPyP4wlX0l+wGs1ZrA4ODygPyAGWXv
	X/WbjYic1qmfN61kqNht+UAJhg/07P07anzFVe+hSn6gEfhlwCj7hQzTrv0LXjmtzXCbGAgfaBP
	/SakwVETbA9ElYGwBehFLxG1VJ/6icaHccP7sJYvysTlSgV55eCTGdAsFwPc81+7mxa6e0fqD6U
	wDl2csSZv5aNQepC+AKogV8psgIx+FgD9bEP7sU7An7tHiQUpSN6AZX2zkvgjjCgUTsBlQ1Nlb6
	jl8KsIpmhk856KjqQT9VM5qKOg==
X-Google-Smtp-Source: AGHT+IHZ8asVKG/p+GFrVFe2FQcRmFBWn+JUKCAiirVC9RvAmQHOreZsnq5pWKHohmAMzCiCmCmV6Iy74RqHQl/cez4=
X-Received: by 2002:ac8:7c44:0:b0:4e7:1e07:959c with SMTP id
 d75a77b69052e-4ed1589cf0emr1560601cf.10.1761682269006; Tue, 28 Oct 2025
 13:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-5-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-5-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 13:10:56 -0700
X-Gm-Features: AWmQ_bmhs1hdkHxO3mmC1NyEAmbGlRZHViudswGppVrbFdffFaapHoJsuste_o8
Message-ID: <CAJuCfpEesdC-yoUb3X+er0Rsm59SiYqXu=i4cHzJDcrO2=QmiQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 4/7] mm/slab: use stride to access slabobj_ext
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
> Use a configurable stride value when accessing slab object extension
> metadata instead of assuming a fixed sizeof(struct slabobj_ext).
>
> Store stride value in free bits of slab->counters field. This allows
> for flexibility in cases where the extension is embedded within
> slab objects.
>
> Since these free bits exist only on 64-bit, any future optimizations
> that need to change stride value cannot be enabled on 32-bit architecture=
s.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

I hope slab_obj_exts() can be removed in the next revision, but otherwise L=
GTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slab.h | 37 +++++++++++++++++++++++++++++++++----
>  mm/slub.c |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index df2c987d950d..22ee28cb55e1 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -83,6 +83,14 @@ struct slab {
>                                                          * that the slab =
was corrupted
>                                                          */
>                                                         unsigned frozen:1=
;
> +#ifdef CONFIG_64BIT
> +                                                       /*
> +                                                        * Some optimizat=
ions use free bits in 'counters' field
> +                                                        * to save memory=
. In case ->stride field is not available,
> +                                                        * such optimizat=
ions are disabled.
> +                                                        */
> +                                                       unsigned short st=
ride;
> +#endif
>                                                 };
>                                         };
>                                 };
> @@ -550,6 +558,26 @@ static inline unsigned long slab_obj_exts(struct sla=
b *slab)
>         return obj_exts & ~OBJEXTS_FLAGS_MASK;
>  }
>
> +#ifdef CONFIG_64BIT
> +static inline void slab_set_stride(struct slab *slab, unsigned short str=
ide)
> +{
> +       slab->stride =3D stride;
> +}
> +static inline unsigned short slab_get_stride(struct slab *slab)
> +{
> +       return slab->stride;
> +}
> +#else
> +static inline void slab_set_stride(struct slab *slab, unsigned short str=
ide)
> +{
> +       VM_WARN_ON_ONCE(stride !=3D sizeof(struct slabobj_ext));
> +}
> +static inline unsigned short slab_get_stride(struct slab *slab)
> +{
> +       return sizeof(struct slabobj_ext);
> +}
> +#endif
> +
>  /*
>   * slab_obj_ext - get the pointer to the slab object extension metadata
>   * associated with an object in a slab.
> @@ -563,13 +591,10 @@ static inline struct slabobj_ext *slab_obj_ext(stru=
ct slab *slab,
>                                                unsigned long obj_exts,
>                                                unsigned int index)
>  {
> -       struct slabobj_ext *obj_ext;
> -
>         VM_WARN_ON_ONCE(!slab_obj_exts(slab));
>         VM_WARN_ON_ONCE(obj_exts !=3D slab_obj_exts(slab));
>
> -       obj_ext =3D (struct slabobj_ext *)obj_exts;
> -       return &obj_ext[index];
> +       return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * =
index);
>  }
>
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -588,6 +613,10 @@ static inline struct slabobj_ext *slab_obj_ext(struc=
t slab *slab,
>         return NULL;
>  }
>
> +static inline void slab_set_stride(struct slab *slab, unsigned int strid=
e) { }
> +static inline unsigned int slab_get_stride(struct slab *slab) { return 0=
; }
> +
> +
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>
>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> diff --git a/mm/slub.c b/mm/slub.c
> index ae73403f8c29..4383740a4d34 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2134,6 +2134,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>  #endif
>         old_exts =3D READ_ONCE(slab->obj_exts);
>         handle_failed_objexts_alloc(old_exts, vec, objects);
> +       slab_set_stride(slab, sizeof(struct slabobj_ext));
> +
>         if (new_slab) {
>                 /*
>                  * If the slab is brand new and nobody can yet access its
> --
> 2.43.0
>

