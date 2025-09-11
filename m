Return-Path: <linux-kernel+bounces-811663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45EB52C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91415A03CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAA2E5B1F;
	Thu, 11 Sep 2025 08:52:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397602E6CA3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580746; cv=none; b=oeuhMhAxx9Xt8JpG2wJK5PgxILizSz8IH0MbXu8Fdv8y1cQ9S41Blay1m2ToiAjlb0C823ETqzFO/xdytRgVrFuiiPnpmEq4kON69+SUXKPR7ySHF3NZDp53ZH6R1JnV1Zc51qEEUgSyO2d2mVLm+ruLQL3umhx3zAVdGrjinqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580746; c=relaxed/simple;
	bh=Q5aRZd2NXqv3GfkdsvFG13cdyXAsnSCoPLvx56egbhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aiI+RFJm1U8XRV2WW8JCTXEAuSJRK0xCibjrHHuhkauxk2H0CfqAnztDQYAFXPBC3/5pOUq356WCkD5laN0L2hV3hQUZgYEWfJADARjdLveMVXDqTGVOPjCGUeHH5WIjkfeyFFDAyaZoGx3AqoSURTsWqC3cizGAnSeKDBrBqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20BAB153B;
	Thu, 11 Sep 2025 01:52:15 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DBAD3F694;
	Thu, 11 Sep 2025 01:52:22 -0700 (PDT)
Message-ID: <64186261-3e65-45b5-a68c-8ec236a75f2f@arm.com>
Date: Thu, 11 Sep 2025 09:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] coresight: Explicitly use the parent device
 handler
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mao Jinlong <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250512154108.23920-1-leo.yan@arm.com>
 <20250512154108.23920-4-leo.yan@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250512154108.23920-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2025 16:41, Leo Yan wrote:
> A CoreSight device is present on the CoreSight bus, and its device node
> in the DT binding is assigned as the parent device.  Comments are added
> to document this relationship.
> 
> The code is refined to explicitly use the parent device handle, making
> it more readable and clearly indicating which device handle is being
> used.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 3eacdcf638df..4f51ce152ac7 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1313,9 +1313,13 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	csdev->access = desc->access;
>   	csdev->orphan = true;
>   
> +	/*
> +	 * 'csdev->dev' is a device present on the CoreSight bus. The device
> +	 * node in the device tree is assigned as the parent device.
> +	 */
> +	csdev->dev.parent = desc->dev;
>   	csdev->dev.type = &coresight_dev_type[desc->type];
>   	csdev->dev.groups = desc->groups;
> -	csdev->dev.parent = desc->dev;
>   	csdev->dev.release = coresight_device_release;
>   	csdev->dev.bus = &coresight_bustype;
>   
> @@ -1334,7 +1338,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	 * Hold the reference to our parent device. This will be
>   	 * dropped only in coresight_device_release().
>   	 */
> -	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
> +	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(csdev->dev.parent));
>   	dev_set_name(&csdev->dev, "%s", desc->name);
>   
>   	/*
> @@ -1393,7 +1397,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   
>   err_out:
>   	/* Cleanup the connection information */
> -	coresight_release_platform_data(NULL, desc->dev, desc->pdata);
> +	coresight_release_platform_data(NULL, csdev->dev.parent, desc->pdata);

This may be problematic, as the csdev could be NULL ?

Suzuki

>   	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(coresight_register);


