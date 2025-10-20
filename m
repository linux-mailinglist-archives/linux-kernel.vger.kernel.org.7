Return-Path: <linux-kernel+bounces-860417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE18BF016A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7233A4EF938
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5CF2ECEA8;
	Mon, 20 Oct 2025 09:06:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E1221F39
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951213; cv=none; b=PrD/LNEIPTS+tjejTYtVTH1JQ5Xf2s71Xpt3YnEVorh9QtpNHjLFeTJEroYwi2vIdB21PdMo1f/TrlcQYX2023Nqc9Q0e2OVSspmLVw9QGPue/DVoHgVIK6/4u+tx95NQ4TMoEnJtWqN9imL1lQGuxSktS41mLFsEDnAEFgcjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951213; c=relaxed/simple;
	bh=7Bj8FBjsoYIcSw/47ODoLuqB7c8raM3MiRLHwk2OwnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJIAooF5r/GXNFMcM7AfhCKqziXvMJAHPSqFtewL4HKY6F+dyw5hj2xil6TnU/hoaMpG5Yco8Ch3XFIGM3qHVa4BpBT/9kizEFNrQddXyLDT5pW9shhriatcJdsl++/MJdEJhr16qAnXe4vTorwC8GB0+VMy/MmnGBoN3NMSuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482491063;
	Mon, 20 Oct 2025 02:06:40 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC3543F66E;
	Mon, 20 Oct 2025 02:06:45 -0700 (PDT)
Message-ID: <a753688e-8ab2-4db6-8462-11b52a642081@arm.com>
Date: Mon, 20 Oct 2025 10:06:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] drm/panthor: Introduce framework for
 architecture-specific features
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251014094337.1009601-1-karunika.choo@arm.com>
 <20251014094337.1009601-4-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251014094337.1009601-4-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:43, Karunika Choo wrote:
> Add a framework to support architecture-specific features. This allows
> other parts of the driver to adjust their behaviour based on the feature
> bits enabled for a given architecture.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c |  5 +++++
>  drivers/gpu/drm/panthor/panthor_hw.h | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index b6e7401327c3..34536526384d 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -186,3 +186,8 @@ int panthor_hw_init(struct panthor_device *ptdev)
>  
>  	return 0;
>  }
> +
> +bool panthor_hw_has_feature(struct panthor_device *ptdev, enum panthor_hw_feature feature)
> +{
> +	return test_bit(feature, ptdev->hw->features);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 39752de3e7ad..7a191e76aeec 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -4,14 +4,32 @@
>  #ifndef __PANTHOR_HW_H__
>  #define __PANTHOR_HW_H__
>  
> +#include <linux/types.h>
> +
>  struct panthor_device;
>  
> +/**
> + * enum panthor_hw_feature - Bit position of each HW feature
> + *
> + * Used to define GPU specific features based on the GPU architecture ID.
> + * New feature flags will be added with support for newer GPU architectures.
> + */
> +enum panthor_hw_feature {
> +	/** @PANTHOR_HW_FEATURES_END: Must be last. */
> +	PANTHOR_HW_FEATURES_END
> +};
> +
> +
>  /**
>   * struct panthor_hw - GPU specific register mapping and functions
>   */
>  struct panthor_hw {
> +	/** @features: Bitmap containing panthor_hw_feature */
> +	DECLARE_BITMAP(features, PANTHOR_HW_FEATURES_END);
>  };
>  
>  int panthor_hw_init(struct panthor_device *ptdev);
>  
> +bool panthor_hw_has_feature(struct panthor_device *ptdev, enum panthor_hw_feature feature);
> +
>  #endif /* __PANTHOR_HW_H__ */


