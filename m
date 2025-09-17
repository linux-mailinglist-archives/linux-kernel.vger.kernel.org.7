Return-Path: <linux-kernel+bounces-821616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B4B81BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275617B6DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7C284670;
	Wed, 17 Sep 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djDWCmsB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AD4690
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140421; cv=none; b=C36krE4bMErj7WMK6IaO+OaP8ZLROD8GHZLVqW27qMGtzJ2Vie1Zkvqx9cmYfm2htVe0JSF4xsduVXQjwjOO1zDQi1DMp7VKERc3Ge3pyOOkPciXGfrMIpB9Q22nteCYc0pB9eF3gcY3GzlGiuoB7XH+Y5Hk2IBJlZ7dWx1qEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140421; c=relaxed/simple;
	bh=4omv285GFnETMoPBdlr9gFLdRl2gv0X9eXz/X1i159w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I032InVS/33Pm3s8uDcvBB/0v8rTaKCRfUXBEJfygfXyhABchLu7Cumzxem/yj8BpXyoRNhqdTGLppH/cNUuCEOmh5K0yM2leoqnZK+cO1C1azjqI+VnBaZ5l5YPMpZ3Wosgu/fP3LxXsjHcxiPLjPCqI4j2XcbUVoNTgMFgC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djDWCmsB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f30011eceso4565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758140418; x=1758745218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XoUhSQnd7IfUTabpSDtGCH3l3cdjv1ByOw0labXn8P4=;
        b=djDWCmsBb3GoJ2Qq8EtHTMhmOztT6mhRsRGiULILHtMO8WymB3NSwtPNl4nctbhwxZ
         cKzRdftgB1Jdkx4TriKgnRZM0t94smxitnEwxLfq7Hazhqf/67I0sZBaqSGIphxMyTa9
         RPIrVi2XJT+tFM2UOWlS7LIivZLAgtFF8xS60JKaEhMmbHgFU64tX+uturlK/KWo9Bzs
         fN71wJJxMe6eqXghYoaxfcuY+xpg8ggg5eEo46LrpDaMnAGFBrtL2MUDcAQUykYn8nH0
         yBsgrYt4PNLidPO0KrWOxisxkY/wfrKDgHfEhdbXob7Sw2ylO1O6Ok2S+8mbkBjbsdSf
         qIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140418; x=1758745218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoUhSQnd7IfUTabpSDtGCH3l3cdjv1ByOw0labXn8P4=;
        b=TIAInPTDdMfdaYR4ASZcfHNm/TavG6oUQVun+9E0BOuiI3nQCg1opOgg3cVya5WQ1c
         skfW/hushHOPsux53asjQ19P+pgHwXedrqXx2oW3anRGn2SuXmpxLhLfjfe2L+qMOG+q
         hbhn6dCBeQPS1TjmSTEyC6ZH9BmYXekiScTbMWrZV6eXd7vP8fyNeqek7Wlrt6wmBDlo
         3QhM2RrjL0GQraFobWELAu97ulTJPLTlB/R9iuQKPskIXosqswmv36w5gUfKtM3sSMkw
         kjZLvCvBL0E1hNksvBU8WPustPQPkR9swfd00ZZHs6nIha+/1XiZxO05cun4YIUDqvF5
         wSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg4zgX639GGc0Nkq57V8lSugaOh/SC2HV/keuYEI5AE6sWY8uo5xIcAo+Gdz0H9B/za5PYedoUGRd/Y5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNh362gqB4nyJJxAIrc+zTKbUCAXP7AUQtAUnf+m74XtW+blE
	vyLCFwNjkkSaVmxiZX1sVJmEXtPzlG7bN5v3zmfSichHi345c5aVhgscI47eHrEczg==
X-Gm-Gg: ASbGnctEEe+IsDt5SMpJTYxXBdBkag4N7sk7jSLg2ktLMi5W4VlEFDuKpD7oba8BVto
	vOdKRq6YHFGlmBYySeY/0dBQ6yYNtjIiNJwQ3Gv/UsVnMDkcGCPdm/wnS4+GfSonqHFGxlcnjU+
	AyT0kaMMJjhlq32e73Mh2nLPdSzbeIKtpPXkebZN1KGmeZsorOVCHTTI/hVutyxeNS9Cv7YnIpU
	Sd5kwwGRRmgNvA+0dvMFA2FoTjmRjl7rQIWjT9E2oNzPTKBrBJ39/9ILNyz/rWhUutRUs9LfQDm
	yar0uOkZTsiFg+0xxROzqmxLI1mzMvw51P51WfSub0TwXUHd5ipN/OPLAxZF1aLIzBkLLqTb26r
	sR5/UKUZtuCnTxuXgSLiRl/5l9WnH0vfeenXVCiSjutT35LEEzZ2ZqGqjkaguYvHHsvqIK5cxSu
	3eqBTmE0+Widzt
X-Google-Smtp-Source: AGHT+IGL88nN+OqGfm1HaJnu3LWbX2CcWRBICMmdu5JCioCD/g1gYZjfAdwJ3rB3P8WH9nqDGiZ/5Q==
X-Received: by 2002:a05:600c:a404:b0:45b:9bcb:205 with SMTP id 5b1f17b1804b1-461e37283d8mr1338655e9.5.1758140417528;
        Wed, 17 Sep 2025 13:20:17 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm9659905e9.3.2025.09.17.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:20:16 -0700 (PDT)
Date: Wed, 17 Sep 2025 20:20:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMsX_HafW3rLs5dQ@google.com>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
 <20250917193818.GK1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917193818.GK1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 04:38:18PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > +{
> > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> 
> Can be:
> 
>        struct io_pgtable_cfg *cfg =
>                &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;

There are a bunch of other formatting issues here also, but I wanted to
move the code as is, so with “--color-moved” you can see the exact
difference, otherwise, it’s harder to review.

I can add a patch before to fix those + the printing as you suggested
next.

> 
> > +
> > +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> > +		cfg->pgsize_bitmap, cfg->ias);
> > +	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> > +		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> > +		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> 
> The entire struct arm_lpae_io_pgtable is exposed to a public header
> just for this one print.. Seems undesirable.
> 
> Drop the print? Honestly, I prefer this, given the maturity let's not
> compromise modularity to print someting nobody will ever read..
> 
> Alternatively call a kunit-only exported function to do the print
> directly from ops so. smmuv3 has an example how to do that
> 
> Either way a precursor patch to adjust it will allow this patch to
> avoid publishing most stuff.

I don’t have a strong opinion about this, but I am more inclined to
keep the prints considering it’s a low-level test for the page table,
and such parameters would be useful to understand the failures.

Moving arm_lpae_dump_ops() to the core library will leak the kunit
struct, but we can drop the kunit_err and rely on pr_err().

I know this is not relevant to this series, but the KVM driver will
need to expose arm_lpae_io_pgtable anyway.

>
> > +/*
> > + * Calculate the right shift amount to get to the portion describing level l
> > + * in a virtual address mapped by the pagetable in d.
> > + */
> > +#define ARM_LPAE_LVL_SHIFT(l,d)						\
> > +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> > +	ilog2(sizeof(arm_lpae_iopte)))
> 
> Didn't see this being used?

Yes, my bad, I will move it and the other one back.

Thanks,
Mostafa

> 
> > +#define ARM_LPAE_GRANULE(d)						\
> > +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
> 
> Only used by the above print
> 
> > +#define ARM_LPAE_PGD_SIZE(d)						\
> > +	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
> 
> Only used by the above print
> 
> > +#define ARM_LPAE_PTES_PER_TABLE(d)					\
> > +	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
> 
> Didn't see this being used?
> 
> > +typedef u64 arm_lpae_iopte;
> 
> Only used by the defines and the above print.
> 
> Jason

