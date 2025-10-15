Return-Path: <linux-kernel+bounces-854541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A68BDEAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1E734E85B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671CB322A2A;
	Wed, 15 Oct 2025 13:09:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F131354D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533750; cv=none; b=ZNmYjO4J/j7UpGDLQguxBxCyQOqQUTuhNZyA9DkCvLmD4Bp102+80Ntuh93FDvgpzx8/Nk8UuQ6jXvg9f7RT1FEg25gHBxEuODbB9i9UQbogueZfDhgQkuEY6M2gmZ4/XYcUrPq5owGKWWFZwlvREQC/XJT3mcPN5NNKeTw4f6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533750; c=relaxed/simple;
	bh=8vhPaa1475rTiCTPmpDRr/hFN/p6YVRmvBRad1sLs58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMOKHHZ3OtvmGSs0WCufWmmo2veYOfKED0tLn+vlnyCgWevnXAhbk9DiqNLDyHQSRzHSR1GR16cz0/+6BOVauJtjEBrpwpus+Nhwdj/B9fQR1oGTVAgNeFXEIziWJCe6/z7m/kRdOe9ISosjzqTlreg7O+9R9+pLouvdU26ne+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79CA5106F;
	Wed, 15 Oct 2025 06:09:00 -0700 (PDT)
Received: from [10.1.31.33] (e122027.cambridge.arm.com [10.1.31.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022D03F6A8;
	Wed, 15 Oct 2025 06:09:05 -0700 (PDT)
Message-ID: <55781116-2c73-40d0-849f-4d8ba21d13f9@arm.com>
Date: Wed, 15 Oct 2025 14:09:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] drm/panfrost: Check sgt to know whether pages
 are already mapped
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
 <20251015000930.356073-6-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251015000930.356073-6-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2025 01:09, Adrián Larumbe wrote:
> In the MMU's page fault ISR for a heap object, determine whether the
> faulting address belongs to a 2MiB block that was already mapped by
> checking its corresponding sgt in the Panfrost BO.
> 
> This is done in preparation for a future commit in which the MMU mapping
> helper might fail, but the page array is left populated, so this cannot
> be used as a check for an early bail-out.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index cf272b167feb..ba32d99ed854 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -600,10 +600,12 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  		refcount_set(&bo->base.pages_use_count, 1);
>  	} else {
>  		pages = bo->base.pages;
> -		if (pages[page_offset]) {
> -			/* Pages are already mapped, bail out. */
> -			goto out;
> -		}
> +	}
> +
> +	sgt = &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
> +	if (sgt->sgl) {
> +		/* Pages are already mapped, bail out. */
> +		goto out;
>  	}
>  
>  	mapping = bo->base.base.filp->f_mapping;
> @@ -625,7 +627,6 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  		}
>  	}
>  
> -	sgt = &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
>  	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
>  	if (ret)


