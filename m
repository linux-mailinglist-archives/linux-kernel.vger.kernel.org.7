Return-Path: <linux-kernel+bounces-845049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3342BC35DF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 717004E4079
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FCD2BF3DB;
	Wed,  8 Oct 2025 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spE6ZDj/"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78529992A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759900375; cv=none; b=YvkPMZJAd3eri8IhE3O3T8Dxp6P6nnVIGfEYKVFUhsRT/9q5+DGxi0dmCp6K0CHu+RdiV1a/2JB5jQ6fxFlX1t+RA2rwC2z1m4aZNeiSk3J4N7VYqlUtOvi2d9qGsH1ptJzaDbXud2DhyDCLfCAh72cFBjFZzP0XL5R80Oi2bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759900375; c=relaxed/simple;
	bh=26+P/l6pN90Nq8tF2HiBv9SoOmisERtfZoPROoat7fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDh8AMg3RfspxbeYtLoYV7+uNY4Zk7Pn2tmKrYOCbShC3/RJk+SHvpA6vfGY6a9mRY7oLh2dPvdXl3cEArTieYzySlcuOrd+cr9H62SRo/Al7KarvGWy8EKPzdYxrC9AXVJenyhEsE2PPgEEPMyf5rdYGtFoNb38citCe0v3mXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spE6ZDj/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de66881569so298231cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759900372; x=1760505172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yQmSM/uaUVo69YQQYMlxvfL/vSIDIF2Y6rwq0Ar82A=;
        b=spE6ZDj/6rrUU/0pIXeNPXzA6NyVVa68B3zTg7TES6fheSnaUf7t+eprfRFxJO1m01
         1+2YO4b8rAFJjZt83sThZiIbzK3LFZXWpJxLqGusrPcWzz+9lYLTtlRm4DVbLC/EVZGS
         UqlVMEhVazDZP8/R2yx9RROrvlGxkDEHLEYmzNAF7wlKdu+qw5uoI5EVaWax/L6qmfad
         +Jd7tQZivsa1UrHADjPw8CF6QaLz81eYHsdd9VXC/kADZVRfgcjWa9qCC+NavVLSkdPt
         FA+G0kVE+/Bq3imLsYhpYDUVJxGtI5btjlAa70dkHKa+MRFiP7pj3RW9BW9GVJcxhrP5
         RmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759900372; x=1760505172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yQmSM/uaUVo69YQQYMlxvfL/vSIDIF2Y6rwq0Ar82A=;
        b=pWbNusNPPe4ZSvduYPm9KpamGqUc546d8jfJtnw4EoNoMZx55ficy0hkiepZvBg33h
         ZncEN80aQkWRdHsE53vjCSdsXi8Xq7N3umaqE263qMYEy/1646DMCywEbh+4QoIH9lx6
         ktb6sIKqQxYWzo6DtEWNnpzDQc5dYpefdn3AkWXomDx2IZLkljv+WQbn9/6Fs+HBUyL7
         O5ryjr1y1dVKbxjVv2YbPhzKM1WzwOWh5K+3U81em2yzMyb1iiOOQ/y0Z9rYFcrsPRZE
         m1PmU0voz2v3RIywmAxGYFRer2p4bEk2YtMfqgj8ykW07vNBXECsM6Hq92DwWY59trQ9
         vjLg==
X-Forwarded-Encrypted: i=1; AJvYcCXsq8pDtXwUpsmYKSbA7J2gd1JATT8khgrK/qbMox3HNowmdeJNoeDXgC0weTinw0kgNsfbFqL7I4oWdYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QdFZQ91eQlLDxEGabSPXhboCzoNujDVNytTpTFf0SsSq9ZhD
	rdKbuUI79p+zZ8bFG1hrt17nWlz4FfQ4yjvrWWvtr7vphDAWbOWOZBEOIU2TUBGb9i0IhbrB/Js
	DXkGVGY753trbQLnXWp982SqT/VwB45M96cpMtWk3
X-Gm-Gg: ASbGncsFOpz7Kbmt1OjnwdkxVPPivAolBXu7fISwHakpiCLCWmxLbT4Ci3ytZkU6GaN
	8RlkWp07za2syFyRa3e7MdEjUpavFixAmvzMexHiwg906GtMG4iopRObV/uULUCfNFO9e5P+iXe
	pRePCjf5lupLot0sErNCtZrb7kTOocx3xDrBTxXz3E+lzR6qysEDlgBMWeioan02KmUPYmm/ukl
	LiHI9dFqrk/t0ayfPbZT7MeMe+eZa9OTb/H
X-Google-Smtp-Source: AGHT+IG4sJFeuvb2AG5gI/HcK2YarilPlghpf1YyHM33PbZY6ifrEjxisgBmR6nILvWsrmH2xE6QBwG4UzAAPiPY334=
X-Received: by 2002:ac8:5884:0:b0:4e5:7832:45b9 with SMTP id
 d75a77b69052e-4e6eac0ce76mr4568981cf.9.1759900371989; Tue, 07 Oct 2025
 22:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006231845.3082485-2-robertpang@google.com> <744rdoputvsokkcgud6j7lrs5hlqnxy6oc2sjfxcvxancdinez@stncekhcbzzz>
In-Reply-To: <744rdoputvsokkcgud6j7lrs5hlqnxy6oc2sjfxcvxancdinez@stncekhcbzzz>
From: Robert Pang <robertpang@google.com>
Date: Tue, 7 Oct 2025 22:12:40 -0700
X-Gm-Features: AS18NWCUzEFtQrDEbshIUyM5znvWlVvRGg_Vm4zKqD_eTwWgNFSHL6-dck2o2zg
Message-ID: <CAJhEC05B7qLDnxeAwqJfnuJiv4NuK6YaY4B37fP=q1RZB9p_bA@mail.gmail.com>
Subject: Re: [PATCH] bcache: add "clock" cache replacement policy
To: Coly Li <colyli@fnnas.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Coly

Thank you for your quick look at this patch.

On Mon, Oct 6, 2025 at 10:20=E2=80=AFPM Coly Li <colyli@fnnas.com> wrote:
>
> On Mon, Oct 06, 2025 at 04:18:46PM +0800, Robert Pang wrote:
> > This new policy extends the FIFO policy to approximate the classic cloc=
k policy
> > (O(n) time complexity) by considering bucket priority, similar to the L=
RU
> > policy.
> >
>
> Current bcache GC is single thread, clock is good here. BTW, could you pl=
ease
> also add the clock entry into bcache kernel document,
> - Documentation/admin-guide/bcache.rst
> - Documentation/ABI/testing/sysfs-block-bcache

There is no reference to cache_replacement_policy in
sysfs-block-bcache currently. Will add the clock entry in bcache.rst.

> > This policy addresses the high IO latency (1-2 seconds) experienced on
>   ^^^^^^^^^^^-> I assume this policy means LRU, am I correct?

That's correct.

> > multi-terabyte cache devices when the free list is empty. The default L=
RU
> > policy's O(n log n) complexity for sorting priorities for the entire bu=
cket
> > list causes this delay.
> >
>
> Can you provide performance numbers about lock replacement algorithm and =
add
> them into the commit log?
>
> Yes, for performance optimization, we always need to see the difference m=
ade
> by this improvement.

Will do it quickly.

Best regards
Robert Pang

> Thanks.
>
> Coly Li
>
>
>
> > Signed-off-by: Robert Pang <robertpang@google.com>
> > ---
> >  drivers/md/bcache/alloc.c         | 34 +++++++++++++++++++++++++++----
> >  drivers/md/bcache/bcache_ondisk.h |  1 +
> >  drivers/md/bcache/sysfs.c         |  1 +
> >  3 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> > index 48ce750bf70a..c65c48eab169 100644
> > --- a/drivers/md/bcache/alloc.c
> > +++ b/drivers/md/bcache/alloc.c
> > @@ -69,7 +69,8 @@
> >  #include <linux/random.h>
> >  #include <trace/events/bcache.h>
> >
> > -#define MAX_OPEN_BUCKETS 128
> > +#define MAX_OPEN_BUCKETS     128
> > +#define CHECK_PRIO_SLICES    16
> >
> >  /* Bucket heap / gen */
> >
> > @@ -211,19 +212,41 @@ static void invalidate_buckets_lru(struct cache *=
ca)
> >       }
> >  }
> >
> > -static void invalidate_buckets_fifo(struct cache *ca)
> > +/*
> > + * When check_prio is true, this FIFO policy examines the priority of =
the
> > + * buckets and invalidates only the ones below a threshold in the prio=
rity
> > + * ladder. As it goes, the threshold will be raised if not enough buck=
ets are
> > + * invalidated. Empty buckets are also invalidated. This evaulation re=
sembles
> > + * the LRU policy, and is used to approximate the classic clock-sweep =
cache
> > + * replacement algorithm.
> > + */
> > +static void invalidate_buckets_fifo(struct cache *ca, bool check_prio)
> >  {
> >       struct bucket *b;
> >       size_t checked =3D 0;
> > +     size_t check_quota =3D 0;
> > +     uint16_t prio_threshold =3D ca->set->min_prio;
> >
> >       while (!fifo_full(&ca->free_inc)) {
> >               if (ca->fifo_last_bucket <  ca->sb.first_bucket ||
> >                   ca->fifo_last_bucket >=3D ca->sb.nbuckets)
> >                       ca->fifo_last_bucket =3D ca->sb.first_bucket;
> >
> > +             if (check_prio && checked >=3D check_quota) {
> > +                     BUG_ON(ca->set->min_prio > INITIAL_PRIO);
> > +                     prio_threshold +=3D
> > +                             DIV_ROUND_UP(INITIAL_PRIO - ca->set->min_=
prio,
> > +                                          CHECK_PRIO_SLICES);
> > +                     check_quota +=3D DIV_ROUND_UP(ca->sb.nbuckets,
> > +                                                 CHECK_PRIO_SLICES);
> > +             }
> > +
> >               b =3D ca->buckets + ca->fifo_last_bucket++;
> >
> > -             if (bch_can_invalidate_bucket(ca, b))
> > +             if (bch_can_invalidate_bucket(ca, b) &&
> > +                 (!check_prio ||
> > +                  b->prio <=3D prio_threshold ||
> > +                  !GC_SECTORS_USED(b)))
> >                       bch_invalidate_one_bucket(ca, b);
> >
> >               if (++checked >=3D ca->sb.nbuckets) {
> > @@ -269,11 +292,14 @@ static void invalidate_buckets(struct cache *ca)
> >               invalidate_buckets_lru(ca);
> >               break;
> >       case CACHE_REPLACEMENT_FIFO:
> > -             invalidate_buckets_fifo(ca);
> > +             invalidate_buckets_fifo(ca, false);
> >               break;
> >       case CACHE_REPLACEMENT_RANDOM:
> >               invalidate_buckets_random(ca);
> >               break;
> > +     case CACHE_REPLACEMENT_CLOCK:
> > +             invalidate_buckets_fifo(ca, true);
> > +             break;
> >       }
> >  }
> >
> > diff --git a/drivers/md/bcache/bcache_ondisk.h b/drivers/md/bcache/bcac=
he_ondisk.h
> > index 6620a7f8fffc..d45794e01fe1 100644
> > --- a/drivers/md/bcache/bcache_ondisk.h
> > +++ b/drivers/md/bcache/bcache_ondisk.h
> > @@ -288,6 +288,7 @@ BITMASK(CACHE_REPLACEMENT,                struct ca=
che_sb, flags, 2, 3);
> >  #define CACHE_REPLACEMENT_LRU                0U
> >  #define CACHE_REPLACEMENT_FIFO               1U
> >  #define CACHE_REPLACEMENT_RANDOM     2U
> > +#define CACHE_REPLACEMENT_CLOCK              3U
> >
> >  BITMASK(BDEV_CACHE_MODE,             struct cache_sb, flags, 0, 4);
> >  #define CACHE_MODE_WRITETHROUGH              0U
> > diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> > index 826b14cae4e5..c8617bad0648 100644
> > --- a/drivers/md/bcache/sysfs.c
> > +++ b/drivers/md/bcache/sysfs.c
> > @@ -45,6 +45,7 @@ static const char * const cache_replacement_policies[=
] =3D {
> >       "lru",
> >       "fifo",
> >       "random",
> > +     "clock",
> >       NULL
> >  };
> >
> > --
> > 2.51.0.710.ga91ca5db03-goog

