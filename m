Return-Path: <linux-kernel+bounces-847083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD23BC9D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6508919E4AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059720DD72;
	Thu,  9 Oct 2025 15:37:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4790204F93
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024250; cv=none; b=XOQ2ipwgO/9+fk6tW1y0qAggcTgenREPXIjq1PjaBtCgpQWLS7UDsOmLfebgmVJbrtLRSuwPxw6uy1K73aLk5GILPYhA9r66sCScYeqUlaqxttt0cGQZhcppm7H5GE6jE8kZjxauLP0zAkLEWyt+xT5LlC+LP6aLTOUTXccFiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024250; c=relaxed/simple;
	bh=lee6iMYDbyoIcw1h6fRWUUN9c+DgVjtUDtVNoDEyAg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OO9TBeQrrOijSBbrEB44CDb3U5s/diMVjV8KiDB83GAQcRonlt/kYvWR41/9xM6XJSnCdumliuNzYm6TjGBTV4QmzybC12JNQUjGeStO7AsX/OfqjtbBc0YrGS3D3OH793K+wnBItpidAho/CA5qUoPbR+hTiO5mopvJa50cEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F181688;
	Thu,  9 Oct 2025 08:37:20 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52DC83F59E;
	Thu,  9 Oct 2025 08:37:25 -0700 (PDT)
Message-ID: <88e18ee6-ee17-4a6e-8ba7-e33bd18766f0@arm.com>
Date: Thu, 9 Oct 2025 16:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] drm/panfrost: Remove unused device property
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
 <20251007150216.254250-11-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251007150216.254250-11-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2025 16:01, Adrián Larumbe wrote:
> The as_in_use_mask device state variable is no longer in use.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 45d77cda8b89..e61c4329fd07 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -147,7 +147,6 @@ struct panfrost_device {
>  	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
>  
>  	spinlock_t as_lock;
> -	unsigned long as_in_use_mask;
>  	unsigned long as_alloc_mask;
>  	unsigned long as_faulty_mask;
>  	struct list_head as_lru_list;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 7bf386d25453..69699b3c756a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -719,7 +719,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
>  		pm_runtime_put_autosuspend(pfdev->base.dev);
>  
>  		clear_bit(mmu->as, &pfdev->as_alloc_mask);
> -		clear_bit(mmu->as, &pfdev->as_in_use_mask);
>  		list_del(&mmu->list);
>  	}
>  	spin_unlock(&pfdev->as_lock);


