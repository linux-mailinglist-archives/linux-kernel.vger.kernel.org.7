Return-Path: <linux-kernel+bounces-847502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A3BCB048
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152081A64E77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21828466D;
	Thu,  9 Oct 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmdJAbTm"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD41A9FAE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047622; cv=none; b=s1RwVekxM1maNGfsll1tLzPAgG3zz+th9t+q87jkVPA6TA8zOxEXFM/IhR8nyrPwFiurgpL10NMq8HpauYPGH72Gu7FN5GhUzDmePpygM6L28ChyVA81jSzujf5l7dKrqFwy1QVisBGO6Rj7Z6nJRs9HteJZPqrJ6oEqWIv4x4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047622; c=relaxed/simple;
	bh=b+kVu64W4YkXirJNR7i26ojLtJf2de5r6wtdyqDzIcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLyvE/YaP2CQKt3hTTwq9s5VNU3IkMtQg5JD2iURIksNz/7XUlwvZQ01xCfsLsWLqhh1nG/WNWvind4RYTxRHdj6Mddm7iVgcIAL5M+PJ0Q+UFQBzK3rfvtSYaqYF9GyvxdntMObuWbA8fBzIOJAaPSePvqrgeXMz29wL0a1Qpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmdJAbTm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4de66881569so170331cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760047619; x=1760652419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlEp65t3/r1w5/97ThJ9eeOglST5IrSHuEXDGNVNbOc=;
        b=WmdJAbTmedVRRfNHLtNaFW0uFnpmaGCgjAq+wWH6rYBZnXhUNUNqCbmjmdnj06F9M3
         v2ZLOc2FLyiEzvOXCWxsoWWHUwmmn/CGwi+9aQP52SDOGjO53RWbvuMe9uU+T+i4/4yU
         QAvvciUfoOOgWrKoBItwK37hJHYD65kr5ghEdkyCLgEGPEAVp9wwmYVso+ryTGHkf6nw
         qkqish1X/4udDCvkyW9gyccmKcyjv2mYV35DnXOMysr0X/60j32jr2CH9hSQzTZ2Kwk5
         mJs9LwSmXtLnMID0nIDZ+tAgq3liG2GOUaIEB2NCG3cBTzqCO5Rk3sig9E+hfDrY/yXY
         6kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047619; x=1760652419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlEp65t3/r1w5/97ThJ9eeOglST5IrSHuEXDGNVNbOc=;
        b=lHCXz2ulMup1LwgHOF1hTcKdF16tbywh/bxku8ZoQwdeXWxcl0LOeCexbvET76N5jA
         P873lzFdleSV0uwVYVhQrCxV9g5shnvLC5pQ1Gkb1+h98Ytr0cqwkHg+cu0n1ExbxtnU
         eghuDFKzDWaVgp/yZOyZ3kr+/hx7oe9JYq37zMFflqTQDFXm6d46OB5/hbrxUKFWbxAo
         uTpVgG+8Q9AxrThtrhE7orKIy8NYUhwgknOnVFwbyimfIDOjuNVuPDTQKf/7jdfKYsvO
         Ju7K19L/AqxJyfj1gl1R/gOVz1hZBAI3JYIRntdAzabvKfrDYFJN2QY8NM2oPt4LdOig
         bUJw==
X-Forwarded-Encrypted: i=1; AJvYcCWQxsGoCDtakgok+n+sntaWFJYLnWVqy6AoMGCVZ1EGypSeZ6t1q5yA/UQXWuzj9YkzA+czlgySG1Zdl0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztavDtiKVAUlKW4qRQFNbwTCacMYgfXo8HGKJfBulNjnLszooC
	jHB1MEhG073siC/d4x7zAFtlU5/4MDTe8fp5mlIY4yiS0x9iz7BesgKZBev3tczZWYPCpVXuDsJ
	nYdpheCuH4rXQvmoelLrEdEGSY4CJ9OpwSX6RM3HN
X-Gm-Gg: ASbGncvciSZ5WAi8ARIydVX/ZYyQLBAlcZ65tjSfUTbtt88Ds42xeIVF5+mHBpSjHca
	SKAjMH8gd//sbnyp2u9Q3yuBLjXBUoqOYzDRt+fOhEUjYoRT7TsgWXR2ec/ybdISGRz2FkOiIGI
	2XEPGWWUd+A0pEy6GJqnHb2pM7qRlYnKJCEXCRYMfuqPJZNF6SwwFhy2CVKL89ivY3HaRWFK3G8
	aoJsMOTLB0jY85bMGrerkEEe3ZUoQcJWI5Bl2uD/znxDf5hVce/Yt8UGO0Ic+6I/88N
X-Google-Smtp-Source: AGHT+IERZQpJX9hE0bC6WTKurcVPhSoZLTlrGwQ5Ug+T41unZKeDzLgnQctgi06vGm2U9lB+iVVirsfe4bZ/c5tLWbY=
X-Received: by 2002:ac8:578d:0:b0:4cf:dc5c:8c76 with SMTP id
 d75a77b69052e-4e6eac11cc2mr17782711cf.11.1760047618991; Thu, 09 Oct 2025
 15:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009071512.3952240-2-robertpang@google.com>
In-Reply-To: <20251009071512.3952240-2-robertpang@google.com>
From: Robert Pang <robertpang@google.com>
Date: Thu, 9 Oct 2025 15:06:47 -0700
X-Gm-Features: AS18NWCfE1wBXqN_6Tp5jyWUdcoFx09Fx_BokV_HvKtpCCcDF6ESVuu-J7OCYNw
Message-ID: <CAJhEC05VTcS-=jsDUoyybQ5Cc33DbPXqJ=5FxfVxo06xfugwAQ@mail.gmail.com>
Subject: Re: [PATCH v2] bcache: add "clock" cache replacement policy
To: Coly Li <colyli@fnnas.com>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apology for missing the change log earlier:
v2: Add "clock" cache replacement policy to admin-guide/bcache.rst and
performance results.
v1: initial version.

On Thu, Oct 9, 2025 at 12:17=E2=80=AFAM Robert Pang <robertpang@google.com>=
 wrote:
>
> This new policy extends the FIFO policy to approximate the classic clock =
policy
> (O(n) time complexity) by considering bucket priority, similar to the LRU
> policy.
>
> This clock policy addresses the high IO latency (1-2 seconds) experienced=
 on
> multi-terabyte cache devices when the free list is empty due to the defau=
lt LRU
> policy. The LRU policy's O(n log n) complexity for sorting priorities for=
 the
> entire bucket list causes this delay.
>
> Here are the average execution times (in microseconds) of the LRU and the=
 clock
> replacement policies:
>
> SSD Size  Bucket Count  LRU (us)  Clock (us)
> 375 GB      1536000       58292        1163
> 750 GB      3072000      121769        1729
> 1.5 TB      6144000      244012        3862
> 3 TB       12288000      496569        6428
> 6 TB       24576000     1067628       14298
> 9 TB       36864000     1564348       25763
>
> Signed-off-by: Robert Pang <robertpang@google.com>
> ---
>  Documentation/admin-guide/bcache.rst |  2 +-
>  drivers/md/bcache/alloc.c            | 34 ++++++++++++++++++++++++----
>  drivers/md/bcache/bcache_ondisk.h    |  1 +
>  drivers/md/bcache/sysfs.c            |  1 +
>  4 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/bcache.rst b/Documentation/admin-g=
uide/bcache.rst
> index 6fdb495ac466..2be2999c7de4 100644
> --- a/Documentation/admin-guide/bcache.rst
> +++ b/Documentation/admin-guide/bcache.rst
> @@ -616,7 +616,7 @@ bucket_size
>    Size of buckets
>
>  cache_replacement_policy
> -  One of either lru, fifo or random.
> +  One of either lru, fifo, random or clock.
>
>  discard
>    Boolean; if on a discard/TRIM will be issued to each bucket before it =
is
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 48ce750bf70a..c65c48eab169 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -69,7 +69,8 @@
>  #include <linux/random.h>
>  #include <trace/events/bcache.h>
>
> -#define MAX_OPEN_BUCKETS 128
> +#define MAX_OPEN_BUCKETS       128
> +#define CHECK_PRIO_SLICES      16
>
>  /* Bucket heap / gen */
>
> @@ -211,19 +212,41 @@ static void invalidate_buckets_lru(struct cache *ca=
)
>         }
>  }
>
> -static void invalidate_buckets_fifo(struct cache *ca)
> +/*
> + * When check_prio is true, this FIFO policy examines the priority of th=
e
> + * buckets and invalidates only the ones below a threshold in the priori=
ty
> + * ladder. As it goes, the threshold will be raised if not enough bucket=
s are
> + * invalidated. Empty buckets are also invalidated. This evaulation rese=
mbles
> + * the LRU policy, and is used to approximate the classic clock-sweep ca=
che
> + * replacement algorithm.
> + */
> +static void invalidate_buckets_fifo(struct cache *ca, bool check_prio)
>  {
>         struct bucket *b;
>         size_t checked =3D 0;
> +       size_t check_quota =3D 0;
> +       uint16_t prio_threshold =3D ca->set->min_prio;
>
>         while (!fifo_full(&ca->free_inc)) {
>                 if (ca->fifo_last_bucket <  ca->sb.first_bucket ||
>                     ca->fifo_last_bucket >=3D ca->sb.nbuckets)
>                         ca->fifo_last_bucket =3D ca->sb.first_bucket;
>
> +               if (check_prio && checked >=3D check_quota) {
> +                       BUG_ON(ca->set->min_prio > INITIAL_PRIO);
> +                       prio_threshold +=3D
> +                               DIV_ROUND_UP(INITIAL_PRIO - ca->set->min_=
prio,
> +                                            CHECK_PRIO_SLICES);
> +                       check_quota +=3D DIV_ROUND_UP(ca->sb.nbuckets,
> +                                                   CHECK_PRIO_SLICES);
> +               }
> +
>                 b =3D ca->buckets + ca->fifo_last_bucket++;
>
> -               if (bch_can_invalidate_bucket(ca, b))
> +               if (bch_can_invalidate_bucket(ca, b) &&
> +                   (!check_prio ||
> +                    b->prio <=3D prio_threshold ||
> +                    !GC_SECTORS_USED(b)))
>                         bch_invalidate_one_bucket(ca, b);
>
>                 if (++checked >=3D ca->sb.nbuckets) {
> @@ -269,11 +292,14 @@ static void invalidate_buckets(struct cache *ca)
>                 invalidate_buckets_lru(ca);
>                 break;
>         case CACHE_REPLACEMENT_FIFO:
> -               invalidate_buckets_fifo(ca);
> +               invalidate_buckets_fifo(ca, false);
>                 break;
>         case CACHE_REPLACEMENT_RANDOM:
>                 invalidate_buckets_random(ca);
>                 break;
> +       case CACHE_REPLACEMENT_CLOCK:
> +               invalidate_buckets_fifo(ca, true);
> +               break;
>         }
>  }
>
> diff --git a/drivers/md/bcache/bcache_ondisk.h b/drivers/md/bcache/bcache=
_ondisk.h
> index 6620a7f8fffc..d45794e01fe1 100644
> --- a/drivers/md/bcache/bcache_ondisk.h
> +++ b/drivers/md/bcache/bcache_ondisk.h
> @@ -288,6 +288,7 @@ BITMASK(CACHE_REPLACEMENT,          struct cache_sb, =
flags, 2, 3);
>  #define CACHE_REPLACEMENT_LRU          0U
>  #define CACHE_REPLACEMENT_FIFO         1U
>  #define CACHE_REPLACEMENT_RANDOM       2U
> +#define CACHE_REPLACEMENT_CLOCK                3U
>
>  BITMASK(BDEV_CACHE_MODE,               struct cache_sb, flags, 0, 4);
>  #define CACHE_MODE_WRITETHROUGH                0U
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 826b14cae4e5..c8617bad0648 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -45,6 +45,7 @@ static const char * const cache_replacement_policies[] =
=3D {
>         "lru",
>         "fifo",
>         "random",
> +       "clock",
>         NULL
>  };
>
> --
> 2.51.0.710.ga91ca5db03-goog
>

