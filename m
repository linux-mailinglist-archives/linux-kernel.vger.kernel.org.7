Return-Path: <linux-kernel+bounces-821578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B02B81AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2896A464598
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22887301715;
	Wed, 17 Sep 2025 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mc3/QFNL"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A92F83AF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138299; cv=none; b=gg1mrv9B5Kie6KZ4cnIqS4OxHY/UF7zUcc/jFJYrxQDdusQWhKT+EpHLi6VN1jdpjgb3nMF3pnZ8iNxUXF87kD018bTS/Pztz0H7nVIQ88uABQhteW23+b+oWMSy00LYU3AUccLE/s03dwFi2DQrONF454Rvy2lJskKr+z9dky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138299; c=relaxed/simple;
	bh=HLKx0GiRwIp8fXPajp8PRXDm4byAL6g/vh4Y94c8CQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aimXaMtfm29xdlRka7xvnDYBh79Mn1iFIRoUarZBcUijsA5IH1NxIGimP+gaCIFrr0v+IDX1Cblw2P0fx+SGgFwZc0yYpakTr8L0EAiOJf8P7Nfl1I8YGCYWKTjb70tKNwb71j8eolo40tx9P00+AVw/wW3T4/TUnE6KwjbyBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mc3/QFNL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8112c7d196eso22086485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758138295; x=1758743095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nETMo+04waFS4tfkt/oU/2PbphAdE89qyUaowMAocVw=;
        b=Mc3/QFNLZPN9THukEQ8ZSCi98k7Vbj+eclyjT4MamNEnESMBm87yt1VuXwmP4+ZpV2
         vm0ZkvY0oGmKhcbm8NCWFqC0e/IZicRybRUcvt1I+jFcgJR4geRro/Oa4Y/CHpiCr6Lr
         n9mK7biDUtsvwEM0M0+iwMIS0w4zA7Udj1dXb4d4i+YySIF6P0F7SCsXVp5Z7icTYcsf
         WR+GpcaRqlo3EGG6By8PqRVUwdHkbCZhpcoAW9SUn4EABegsylbrE92Ihy4jVd6dIF3h
         zjfEGRdWhLFSkPXpcQ+2I5QFf1cgwsWn3gZraTJft53lKYOpLzgy9kVUEzcEc/dprp2z
         ENmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138295; x=1758743095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nETMo+04waFS4tfkt/oU/2PbphAdE89qyUaowMAocVw=;
        b=DWfrGnKNTqEfU24JMCi1zwvNqtPd8jbu1RWgKzhkBKqYt0KQnqCJQ4GjwL8ZuTQXDH
         WW+KdNJhwtkzXaZ7um42nVwWKd71Wb2RKk9hAREAmvem+uClE6pME4d0gjmY1H6L3j2t
         BwN7Py8vxx1sulbiqzah2G0fgJ33S/215Xr581BmuKrK9FGTRX+BTsi9hbluENOpKAPj
         Tym/nk0VGgVUO1u9pe3COyRxc+2AAgXJMf6dRQ6hs9zBAhlkfRIV//UCrghgFlsSiuCu
         Eet+XQipULHvdYT+nKBVkGpVdkOaqJx8uKZ4dHmLNvZvaqNpEma61bPWP5u9IkLCmFYb
         sTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMbH3puRRKFA+TSX8yJQw9HhGVQtIPWxh8iXdTo785J55M4O8/l8+4hm2vpyOJOmM3/O538IcAr3BWAeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3bYghND1j+Iy3//JX4H33/FGdLx4OV8AuNKvOyz/gZ0+0tbi
	T51ND18Hwjs5Uctkjzu7OqsHZWYAXJ/00qIrYzcunmUKets8EFK7lPn1CjgfM26W4ww=
X-Gm-Gg: ASbGnctu7EYvslSbx/J/gINiM5o00+93qkIe2H70rvpLR2pyJcViGpdSpwpYNJdLXkC
	wIJ0JDL4ecT+qYHWwTRMPqN/+Xu9Wd7Av4wRSjsDwIKLp0GwV4b9f7++bOW4rdgJN+JzCmrjBDz
	AXHEtM92lX32TB1dd26OTGZL0xZSmp0cRGCrHTgNJRfwgQVDnfB3IuSVnfTRPTe1JKZ6I5p9Vmu
	oAMV0+rIvi3Hq9WXtaMbVjDqXHUTIU0qp9/EdxCpeOwTiK1XpZsV5pIVMoNft1p/PhaNS6pFYIV
	+7+OfLlx7l3Yzwo7fFSAxGFRf87IF0v17Fcn9WlonjbGQSHNzdLAdjYO0rGbRTDY72C/5GzHuYq
	aESZLXpevonHmI/vCgFQSVIJiFaN46AVu+/mZdmfhldnxWZivkAhWzOYMCly8ushpTSupNl0tQ3
	BiF08=
X-Google-Smtp-Source: AGHT+IFWc58Oz1xzWWA03oRckYRJXsuyaaVLiWkScgdlR7Du/xYkSuwaIG4g5CNkm13Bqx94hJ05Vw==
X-Received: by 2002:a05:620a:28d6:b0:811:3f8a:24a6 with SMTP id af79cd13be357-83111e2b756mr414673885a.53.1758138295331;
        Wed, 17 Sep 2025 12:44:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631a7fc2fsm32683485a.54.2025.09.17.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:44:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyy5G-00000008nBQ-1aLu;
	Wed, 17 Sep 2025 16:44:54 -0300
Date: Wed, 17 Sep 2025 16:44:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20250917194454.GM1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-4-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:40PM +0000, Mostafa Saleh wrote:
> Integrate the selftests as part of kunit, this makes the test
> available through debugfs.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 93 +++++++++++++-----------
>  2 files changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 553522ef3ca9..f7e6d1db6ce6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE
>  
>  config IOMMU_IO_PGTABLE_LPAE_SELFTEST

This should probably be renamed to xxx_KUNIT_TEST

>  	tristate "LPAE selftests"
> -	depends on IOMMU_IO_PGTABLE_LPAE
> +	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT

I wonder if it should be:

  	select IOMMU_IO_PGTABLE_LPAE
  	depends on KUNIT
        default KUNIT_ALL_TESTS

?

At least the default should be there

>  	help
>  	  Enable self-tests for LPAE page table allocator. This performs
>  	  a series of page-table consistency checks during boot.

"kunit tests" here as well

> -subsys_initcall(arm_lpae_do_selftests);

Oh so it does drop the initcall, the coverletter is a bit confusing then.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

