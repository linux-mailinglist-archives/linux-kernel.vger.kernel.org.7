Return-Path: <linux-kernel+bounces-874418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD89C1649C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43623BCD67
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87326B2D5;
	Tue, 28 Oct 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hGLHRNV"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99234BA5B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673411; cv=none; b=cP8KGa7/AFYr47tIplSmgz5tToH8BZUJXqLKf5JsEMrPj9EGWLNPbOhG+h6N9m+ME7QhcFKcpMhkUqVMiiA1FHKc92CbYykxgDKxRIG6mhvIV9dTCG5Qp+UrZ4ym0f6FpOl1LxZFhe3T3EEX/WOxUL+2wTRruOqd2kHz7G5iTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673411; c=relaxed/simple;
	bh=OJsTYMzbe/UDLrK6Bw+bsAXFWG7YtvhKytf26d44Q68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtDHFHd+cnmtmqNuGZk/WBVD2Mo+EmDcfSJDCWwRvhu51C9vq72QGVIpuM8Os2l/X415IXc2HCYhZLrxLlAVyztLwU2C8cgBXtmb1d6wn9ltPmM/WbCV9Sh4vlPli9rHDXCCC6OHBNj5UI/gXWaV5UfR8tFTooYP+K6Ly50mVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hGLHRNV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eccff716f4so31471cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761673408; x=1762278208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm84HDvajvdUeYx0RetHD/996j4kdkLd2nXgDOVyMuw=;
        b=0hGLHRNV7cCeSwAeH+GuHFgtA8k5j+LWuR2nhN0elJcozyqqKbfxnwsAeZ/SVMwyxO
         ElWekUQEzyrULtBVoQJvDMDFGFpF9fTlitKzfzVz/jj8hTGjpId2P0UZDWWcZZJlR6OI
         gCiB2/TS9wOIUN+Rf3JUH4zdk7l7H1xAN2nLbukIHwQYkpmylq104gUamdkON6s/vs+F
         kF0pPtvk3H/NclTvnd705OgakJYf63UyiH7as2vOzQX12vUztOKk5O1GwRouxUPtl9NU
         Ge1i8wEN4/XmevbzxUQLu1u/fSOir0KpJzUQgDbhTK22fWJ5wqHKxHtad0YVsle2YHda
         HVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673408; x=1762278208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm84HDvajvdUeYx0RetHD/996j4kdkLd2nXgDOVyMuw=;
        b=qvFwqSj/U6DqsbTex+JUUiejG3KTKUWz48unei1xjY95l1kq2uk4zU6dL1gN4Brs3k
         /h95gcs9huDvykK1T9P22BwkQvdAAI1fIWWChjkl5sKy7BJjRP9yV/nW0q437/9I5PjL
         0S8I5u3et1xKgdOhofYSjAmvlzzoZGvd9wAYLw+IkySTWhJTwqIfajCefRwMexP6fH24
         oN/WyeFNiyw5yJk8qSwObM+ZiKRYhSVr7mEFRx8rC7FeJThWzTQgSOqpSVDCYsk5023u
         GePCvp1C/gGVK6jw9vTHDuvs/SQeAHxZeeUJDCb3NC94yI6u9W1Oi5FwoTvPWEquBjY2
         twrw==
X-Forwarded-Encrypted: i=1; AJvYcCWN9kSI96xChzK6sgOlCIER3TytkrgkrdPvyu+ssVLSW6PYAcqJuW4DJ+tgpRBPuH+xncRlZmwCB19NwIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/K0ckHMCdM1hrGIM1BM6BrBp4+oH2rxeL+yJLswLBGG/4jaZ
	Hz/wl7LU4LFiF3JVEzjMkilfzvpOCx8pqLW8az1i877Wiuhf/llFDhIkTNXkVnuBWv7MoUcNXh9
	EGTqO0HBt+FkMiII4u5Ypbzbotp1aI2aIW9mvjC2s
X-Gm-Gg: ASbGnctVQx2BCxVETJ9dT5j8GX5ysTdKs1JYZd818LRpfyYdBkLVq3pZ/52pHjbcAxp
	g8AD9qYkcFm9BGO6BtR+Otaos30WkXMAJY8cvnSzFB3fpS9pSSljsmFjdcmooGQtx+pUsYKmoaz
	oQKvTd7AoUKB5q3qsCsoq46LD33XpKMGaxoMa+lTUHjaRPKB7Gp3hbAo+v7nkhbU0hSSDvvgoqu
	AB/hbAU6InzkA3A21OvmY4PPgAhXchanukf375lb5+N8zwee4kHz+KcKINqI+/niMAT9k9K9sgG
	Skeaoia7YajAkH6mzR0WKlc5hg==
X-Google-Smtp-Source: AGHT+IHqOw0wVAMZdI9HPTfn0JRAVi2UYS5cUsNnlCDAZHhG876N53Uqz0wugy8aVXJs9k9838Yo4Ajkv/Cn41vL3UM=
X-Received: by 2002:ac8:57c4:0:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4ed1593d02dmr323231cf.13.1761673407812; Tue, 28 Oct 2025
 10:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-2-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-2-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 10:43:16 -0700
X-Gm-Features: AWmQ_bkEq6fU-X83NBs-FScowfdztSWFRPMtVvCpjCocisVvI5BwLCPHsCScVHY
Message-ID: <CAJuCfpF5gG63njY436vctG-Tzbco8X9a1w3YA=u1AGrRqxVshg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 1/7] mm/slab: allow specifying freepointer offset
 when using constructor
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
> When a slab cache has a constructor, the free pointer is placed after the
> object because certain fields must not be overwritten even after the
> object is freed.
>
> However, some fields that the constructor does not care can safely be
> overwritten. Allow specifying the free pointer offset within the object,
> reducing the overall object size when some fields can be reused for the
> free pointer.

Documentation explicitly says that ctor currently isn't supported with
custom free pointers:
https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/slab.h#L318
It obviously needs to be updated but I suspect there was a reason for
this limitation. Have you investigated why it's not supported? I
remember looking into it when I was converting vm_area_struct cache to
use SLAB_TYPESAFE_BY_RCU but I can't recall the details now...

>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slab_common.c | 2 +-
>  mm/slub.c        | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 932d13ada36c..2c2ed2452271 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -231,7 +231,7 @@ static struct kmem_cache *create_cache(const char *na=
me,
>         err =3D -EINVAL;
>         if (args->use_freeptr_offset &&
>             (args->freeptr_offset >=3D object_size ||
> -            !(flags & SLAB_TYPESAFE_BY_RCU) ||
> +            (!(flags & SLAB_TYPESAFE_BY_RCU) && !args->ctor) ||
>              !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
>                 goto out;
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 462a39d57b3a..64705cb3734f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7781,7 +7781,8 @@ static int calculate_sizes(struct kmem_cache_args *=
args, struct kmem_cache *s)
>         s->inuse =3D size;
>
>         if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset)=
 ||
> -           (flags & SLAB_POISON) || s->ctor ||
> +           (flags & SLAB_POISON) ||
> +           (s->ctor && !args->use_freeptr_offset) ||
>             ((flags & SLAB_RED_ZONE) &&
>              (s->object_size < sizeof(void *) || slub_debug_orig_size(s))=
)) {
>                 /*
> @@ -7802,7 +7803,8 @@ static int calculate_sizes(struct kmem_cache_args *=
args, struct kmem_cache *s)
>                  */
>                 s->offset =3D size;
>                 size +=3D sizeof(void *);
> -       } else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_of=
fset) {
> +       } else if (((flags & SLAB_TYPESAFE_BY_RCU) || s->ctor) &&
> +                       args->use_freeptr_offset) {
>                 s->offset =3D args->freeptr_offset;
>         } else {
>                 /*
> --
> 2.43.0
>

