Return-Path: <linux-kernel+bounces-811812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABA9B52E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4993717BDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7BE30FC03;
	Thu, 11 Sep 2025 10:20:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7223BD02
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586039; cv=none; b=cTXjst+MVbErp1SZEGo2cuhUka62YO0h4SxpkugaQb5lDaMDubprzkziLf6lmTwDXhKwzDoArRV+Uvl5xIET243kYkGZN47NYHX0w6QJF7fmrXjrdnieUA85gm/+WPXe2Wf5tE4BFwwQT+VOrkwm38L4zETmwYfcjAzchNdSR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586039; c=relaxed/simple;
	bh=ebX40o+ez7WkgUVS+G8PI2JeMdxjcxEIou1tu3IrVL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PJF8BZ3/4e6YCKB8w/u5emPux5udgXjxAAdOusxRd25fqwjkeOrcKOcNA7PyE+gu9ZFRtKG/JmaeIJdqLotEK8vijfBeMnwLrzt/R+WWX85e5LSpcRgabDxYInz9CZTAIOxG0khUBX68lhwGyTM0qXHSxE9MP1D9XQejrOY7n3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D346153B;
	Thu, 11 Sep 2025 03:20:28 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE733F66E;
	Thu, 11 Sep 2025 03:20:35 -0700 (PDT)
Message-ID: <c85a2ba3-ce5a-4e93-a80c-9094f4cd43cd@arm.com>
Date: Thu, 11 Sep 2025 11:20:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] coresight: Refine error handling for device
 registration
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mao Jinlong <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250512154108.23920-1-leo.yan@arm.com>
 <20250512154108.23920-6-leo.yan@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250512154108.23920-6-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2025 16:41, Leo Yan wrote:
> When error happens in a device registration, the coresight_unregister()
> function is invoked for cleanup.  coresight_unregister() includes the
> complete flow for unregisteration a CoreSight device, it causes
> redundant operations for some errors.
> 
> This commit changes to invoke more specific functions for cleanup
> resources for each error.  This can allow the cleanup flow in better
> granularity.
> 
> As a result, the local "registered" variable is not used anymore, remove
> it.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 26 ++++++++------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 4fc82206b326..1eb4f6f0fe40 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1297,7 +1297,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   {
>   	int ret;
>   	struct coresight_device *csdev;
> -	bool registered = false;
>   
>   	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
>   	if (!csdev) {
> @@ -1362,27 +1361,23 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>   		ret = etm_perf_add_symlink_sink(csdev);
>   
> -		if (ret) {
> -			device_unregister(&csdev->dev);
> +		if (ret)
>   			/*
>   			 * As with the above, all resources are free'd
>   			 * explicitly via coresight_device_release() triggered
>   			 * from put_device(), which is in turn called from
>   			 * function device_unregister().
>   			 */
> -			goto out_unlock;
> -		}
> +			goto out_unregister_device;
>   	}
> -	/* Device is now registered */
> -	registered = true;
>   
>   	ret = coresight_create_conns_sysfs_group(csdev);
>   	if (ret)
> -		goto out_unlock;
> +		goto out_del_symlink_sink;
>   
>   	ret = coresight_fixup_orphan_conns(csdev);
>   	if (ret)
> -		goto out_unlock;
> +		goto out_remove_conns;
>   
>   	mutex_unlock(&coresight_mutex);
>   
> @@ -1390,15 +1385,14 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   		cti_assoc_ops->add(csdev);
>   	return csdev;
>   
> +out_remove_conns:
> +	coresight_remove_conns_sysfs_group(csdev);
> +out_del_symlink_sink:
> +	etm_perf_del_symlink_sink(csdev);
> +out_unregister_device:
> +	device_unregister(&csdev->dev);

Is there any reason why we can't use the coresigh_unregister() ? I see
the mutex_lock() needs to be released before calling it. But otherwise
all of the above could be done from there ?

Also, again, after device_unregister(), we are not allowed to touch
csdev. Another reason why the release_platform_data below is a problem.

Suzuki

		
>   out_unlock:
>   	mutex_unlock(&coresight_mutex);
> -
> -	/* Unregister the device if needed */
> -	if (registered) {
> -		coresight_unregister(csdev);
> -		return ERR_PTR(ret);
> -	}
> -
>   err_out:
>   	/* Cleanup the connection information */
>   	coresight_release_platform_data(NULL, csdev->dev.parent, desc->pdata);


