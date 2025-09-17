Return-Path: <linux-kernel+bounces-821572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C38B81A90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1FB7A3B52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EE3002B6;
	Wed, 17 Sep 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RJIBKu5b"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3E2FDC47
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137902; cv=none; b=ApTXHO3PoVt0ZudyiIjqbsBBHo5VW2tRS/A7Ne3H95p1VPuqzPbvI3SXi7S0zBJrRm2mKBzFiN5tifH+wP9Zgv2mXzERC/WiB0hFXzNMDkIumZyY3bFcpaQvXyXCyPVh3JCHlxLsLxK8W4I9FnMFmw+IBnH3XHBsu7jiTleFBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137902; c=relaxed/simple;
	bh=GVy6Pfve9fhUKRVNJRlAnEGSUzecOkZpiquPMdRKjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl6qNMHFtaDVvypaQ/U7KlBlE8rNVBgkN5eINAbswksnkhC/J0MfGPjyBqsys+avukc5UDGD/LTL/VM6fUgyZA+1XrNipO8rFa3rP1Tp6HgxFB+tDS9DsC2flmGO04/v8C2D8sYLX6ix7h5+hpg15dpX3HaqbUiBKBZl+40Xijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RJIBKu5b; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-826311c1774so21132585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758137899; x=1758742699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zn0Is8eeOR4Gu6G7tdLKQq8N5ufCD33SLmEnkNniBDc=;
        b=RJIBKu5b0h3qprG+ngrJFN4NH0JwmH6sGpRaNne4rFsLoHe+58TW49n6vyonBDJmec
         eaKYcbjNbP2h4rIlc5Uf7r+tFLg1W8jtkr9JcE81weP4bksQ4JZ1exvkdyYWercRMOSv
         tgmUcTcRPl/q2uuU2wUiuewrS+BFDWUt7eHssAgLZ7zRDnGviWBDCvnm02m57ckOmbuV
         Dr/1S1RCHXjr232UzQuz5yXqncUf5A5ZoXN7VF+jeh6BIlnWVSmt9lWNx40mLZexixJP
         yo7zESvD4DecqI2N/wIVlVJciDbQ0zIvSJNOEzlDpmsjITZdBWFz15bdGgGkrbqKAv5w
         dOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137899; x=1758742699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn0Is8eeOR4Gu6G7tdLKQq8N5ufCD33SLmEnkNniBDc=;
        b=Vo/6rT4At+DXXCFLzAR89mCgCUrdcchFhcYA2WUGqwjDiH1oj+u2+wnxV+Jl8MeMUK
         Ep+0fSIurJdsbJ66MZhjDafxeAyAJyAAgqtGxS9FVv/86p82rH35B4dwscwWcaFJUHbH
         ZLEH3IM+03Gtf/YqVbj7bDUzZUVsq3mT5FY+sqChhMfoAjQxSw1GUfOtqyyDKIPdDb+V
         wfgDMqtd0Q0F3QjAhF6ciHYxkuLtlNvNttpGxNKQcm39Lt8Zy7pTaP43XSoHymlV05V8
         o2DOjIdwvWfJ/HgoTjJaBAPSDQm+sIGlUCE34y0tyMkKhteUphhw852GiS5XiVsarax+
         jd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHGbVe6d0gapV3YKcVOyI92/NJ/J09HX5WFjJ06KhKOi83iiCS0v+bTD9LmK5TSU4v/Mkn2rcLDAI/MUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9ibWECOvXxSg6K+XmD5h3N6PjVA/XVrzwYS+W942iFkb9XKA
	B+LOaDiiSJOPpkRY9CHLI9/gGECqoiIW/VRt756if6r32PeoTvmTY4f/nnvN4uMWpRI=
X-Gm-Gg: ASbGncvwSe0Q0YdiPm9gOxfasOA3oVYOzPhlqnpxShBW9s7C8U6AB4afMTMKasRHFT/
	0XkDJFw3gW+NkHAtbjFVu1wporwA/Su1wqekCsIuaaxpoS4YKkzq7GmxYtUTJB76383WoWSfK2u
	S4L2tG0Hp6vSDwBkoZJcxUx7KZJ8Z1tMgoi7i07Hc3asIIEQBSWXTrVzyaIlg0vR/QJJdIiffIz
	xCAU3uUVPsBbs5olWX6j5lUVl3K2SRf8Bf5Bp0n7K3lYb1CLy41eIxs/Y5RdfBzKH5Sm62Zu8K3
	qtIDov8FOG60yoD8DQ9kVkbmRq3U3STTS/ML2cvEFVcHNXJXeEc6xYl0m++DUdSrAZ6awCwlS8y
	rFaODgCXc/McyMZJqOn5BH8ZMBOInwapPMNqwwcKSTvuptOmhr0FAvzgT/Gt7KyN0dRzA
X-Google-Smtp-Source: AGHT+IEijZbrq+i+0WS1CBxKV2AIyy3lPGfFcOI06YkWPNxuKICHcEdaLnL2uf7gK6Yw1m11T0+frw==
X-Received: by 2002:a05:620a:4406:b0:810:511f:3885 with SMTP id af79cd13be357-8310da0c6e3mr377680985a.33.1758137899133;
        Wed, 17 Sep 2025 12:38:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836263ab0e4sm34559685a.11.2025.09.17.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:38:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyxys-00000008n8R-0Qxu;
	Wed, 17 Sep 2025 16:38:18 -0300
Date: Wed, 17 Sep 2025 16:38:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250917193818.GK1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-2-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;

Can be:

       struct io_pgtable_cfg *cfg =
               &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;

> +
> +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> +		cfg->pgsize_bitmap, cfg->ias);
> +	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> +		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> +		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);

The entire struct arm_lpae_io_pgtable is exposed to a public header
just for this one print.. Seems undesirable.

Drop the print? Honestly, I prefer this, given the maturity let's not
compromise modularity to print someting nobody will ever read..

Alternatively call a kunit-only exported function to do the print
directly from ops so. smmuv3 has an example how to do that

Either way a precursor patch to adjust it will allow this patch to
avoid publishing most stuff.

> +/*
> + * Calculate the right shift amount to get to the portion describing level l
> + * in a virtual address mapped by the pagetable in d.
> + */
> +#define ARM_LPAE_LVL_SHIFT(l,d)						\
> +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> +	ilog2(sizeof(arm_lpae_iopte)))

Didn't see this being used?

> +#define ARM_LPAE_GRANULE(d)						\
> +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)

Only used by the above print

> +#define ARM_LPAE_PGD_SIZE(d)						\
> +	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)

Only used by the above print

> +#define ARM_LPAE_PTES_PER_TABLE(d)					\
> +	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))

Didn't see this being used?

> +typedef u64 arm_lpae_iopte;

Only used by the defines and the above print.

Jason

