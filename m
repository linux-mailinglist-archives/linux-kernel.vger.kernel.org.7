Return-Path: <linux-kernel+bounces-874357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EDC16214
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0953AAD90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE8934B1A1;
	Tue, 28 Oct 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qZW45Tk"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738034B40D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672161; cv=none; b=i61d6r3N4btcKbzmVZ/h7ss8fljPLkwW4878KlzJpnctwHSEi8CPs2ba3mSV60GsxdAZHDrlX2yXKCb86O/eZyc77AY8iFa0IJ3dwKeeT0+C8bgVNKtfxq96v2ocXrP5qHnXf2+lNifyK1ZQLBXtw1E3C48FrjAcTz/C9YMKJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672161; c=relaxed/simple;
	bh=czfMh/vqBpBe75z8OObBCid+NjEj0Nwd1XTPGM1Rih8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTqZDkjHWTCrS4pTIyTCT0aupnMrlNnuLtTtdHH/qRHPuttJGYfM1HWsjZ9/qFQQoRet4eyeFpGG8YHNwl5UeRLmlNwGASXioFqLQbBRevU3dQocDIcIfqgMHahbLdojGzsP+m7DowlK+MNncgmZpfmNCSPuzzSr2eed9AGI4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qZW45Tk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso23091cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761672157; x=1762276957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXkInKYza36OKEjDJ9gQla/X4/pbEXOW59mglWVYVe0=;
        b=2qZW45Tkj7JoP1BwSLq/31YPaaLAUwl8m+SqaOSCrgqK/kdXKWiIlxfcN51QEVwv18
         E5SgA5WACPnds2Ja6eB7fn821NcBUEQvnpC4lLOPMhDjKtCCKlUxnaViuNcxlmMGMslp
         JoRMOgzou/e+lPcj9Oh0x21+GWoMv8l8VuXNP8TXNm9eb1cijCEUU1I+Ocjk1gInfH17
         msullDmMRc9aBMmei++FAPXo18o4CCuX6670yHWfKSdpzsKuLDHNJ5I0KVkwdE4SG4oB
         OFOn83UGPQRDhmB/ooJ+8usDXUf3z1+PwmMgeKiu9nnidwJQz/SAIDTZ2lZQBA1lurxw
         hiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672157; x=1762276957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXkInKYza36OKEjDJ9gQla/X4/pbEXOW59mglWVYVe0=;
        b=QM4YN74uGn6CbzzO+ejs+NED5eUkntR3Qn2nvE0BTbpc3fmytExZ2ygkqm/dQxmcvC
         Wg/en+5qOUG10omG8/61RrZm5A0rJ1wqtlFngLEK6uVyU5A17JpcU57/3Acu/NHoKuR2
         vXLFSmv9b/tUZlaXn3avz2rK79LBBWtszNpoEPH6ueDeruUHVZ3kgT1qv+judgng9hS1
         T/VcQtPF0ugRyMLxIwT6Arb1dn5GJgh2NFqNbHxaULaqsqRM3wgopxiwU4v2WRXcLCD/
         iISum5B0gqLuGLSU5uP83er0cIWzS3lPiv799uJ7CF9EyvZE4aERZ/7EsyeBi8VNo0ii
         T9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM6IvwdNWkTu0YZVV/e0oPEZAyIVYH14bdR84PPEiDuFyjpZgu7+Ldqmq1Uzm2f6b2Dg9Yj9BGFnwBiEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwWNeXJp38O9a9c4LkG5NPjuTxt3TZW5CzWfNcfhYeEuqyjwy
	bSdc4X1BZgI2oYKuaWhP5+zUcTYp7Gr2qsiuWTynyJlv53jmA4u/zrYNZVZ2QTvRWB4gEpcSv5t
	EFEamKOIoRJsJW+ODRXvY/ciS5gNb0xmIpFE/ZMgkoWshh7CczkxiUWX1vJE=
X-Gm-Gg: ASbGncs6hefWUwDq2dw8IYogiplTub29/DmGngEYHoQ6jENldZQatCBfmFl/APvgKep
	TTyunfh8uAbVUOKWOLlzTES4TaV/2ZBRAsYeeSe4MpxoH08tjzo+oRiYW8l7ZsIJI5hSNP46O+g
	x04QLcql3+8HUG4GmYk712/k2+pZJI4zIhKIqY/k/Q+ko5PLmbLfUR3js3kWcQzYDFx+o8ornhr
	KHJ3vFhBDA+w74cs0K3Q8kLbBomj8NCY88nI6P+/IeoZfkIAHKiBVltoj0ShVZprSJiWOM4gn29
	rs/ce5+MaTdc9U0TrmqwOecR3Q==
X-Google-Smtp-Source: AGHT+IHn/oTfm/JuwLti1FuzoxQ+/oX/hUBOtVlQ025ocwE7vk9a+/tdWJJNQoH1S/B6JBQomz11gO7zAkAgU9yuzGA=
X-Received: by 2002:a05:622a:244d:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ed157de56amr256901cf.2.1761672157120; Tue, 28 Oct 2025
 10:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-3-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-3-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 10:22:24 -0700
X-Gm-Features: AWmQ_blgmjSynkbbdCoPvFJY7HzNhE5kHecWMsBfPzVUZdQoPVaPzHQJsWkzclk
Message-ID: <CAJuCfpGo=m9vdRQCqa-2MtAb9GBNsF4+6YXm7vzGFYtqsOzq1A@mail.gmail.com>
Subject: Re: [RFC PATCH V3 2/7] ext4: specify the free pointer offset for ext4_inode_cache
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
> Convert ext4_inode_cache to use the kmem_cache_args interface and
> specify a free pointer offset.
>
> Since ext4_inode_cache uses a constructor, the free pointer would be
> placed after the object to overwriting fields used by the constructor.
> However, some fields such as ->i_flags are not used by the constructor
> and can safely be repurposed for the free pointer.
>
> Specify the free pointer offset at i_flags to reduce the object size.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  fs/ext4/super.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 699c15db28a8..2860e0ee913f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1474,12 +1474,20 @@ static void init_once(void *foo)
>
>  static int __init init_inodecache(void)
>  {
> -       ext4_inode_cachep =3D kmem_cache_create_usercopy("ext4_inode_cach=
e",
> -                               sizeof(struct ext4_inode_info), 0,
> -                               SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
> -                               offsetof(struct ext4_inode_info, i_data),
> -                               sizeof_field(struct ext4_inode_info, i_da=
ta),
> -                               init_once);
> +       struct kmem_cache_args args =3D {
> +               .align =3D 0,
> +               .useroffset =3D offsetof(struct ext4_inode_info, i_data),
> +               .usersize =3D sizeof_field(struct ext4_inode_info, i_data=
),
> +               .use_freeptr_offset =3D true,
> +               .freeptr_offset =3D offsetof(struct ext4_inode_info, i_fl=
ags),

Hi Harry,
AFAIK freeptr_offset can be used only with SLAB_TYPESAFE_BY_RCU caches
(see https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/slab.h=
#L302)
and check at https://elixir.bootlin.com/linux/v6.18-rc3/source/mm/slab_comm=
on.c#L234
should fail otherwise. The cache you are changing does not seem to
have this flag set.
Thanks,
Suren.

> +               .ctor =3D init_once,
> +       };
> +
> +       ext4_inode_cachep =3D kmem_cache_create("ext4_inode_cache",
> +                               sizeof(struct ext4_inode_info),
> +                               &args,
> +                               SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT);
> +
>         if (ext4_inode_cachep =3D=3D NULL)
>                 return -ENOMEM;
>         return 0;
> --
> 2.43.0
>

