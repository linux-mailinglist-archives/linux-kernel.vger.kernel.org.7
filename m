Return-Path: <linux-kernel+bounces-810711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA22B51E36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8727E1C878CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220E2741B5;
	Wed, 10 Sep 2025 16:48:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AC25CC40
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522937; cv=none; b=h/APao3bLTX7e+2TJmagScYBkTvRj52+lAcEVZEGZxVtiV+XnAmDe8UFTEMZZqOr3CsIpeMpbh0/Sc6gQPr1K1kF3gCj8hGPoum2p1nJTMEVjz/mn1FjKf7WuO2jbPhoGuTTpCWd6JdP+VNvbMEopydmHh2XjlfH29pYQGL1eiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522937; c=relaxed/simple;
	bh=N9Ajuc95f1EQihHZaLDmW+ovy1l/d2xIxriDTLOW38g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbLciFwS/tRHVYMxwwVmW6wjk/NXQ8OSQ/pz53ypYNwi3zOCmPzeP2BKGrQo6SvRgi5p2bpj9zZ+pJhthfNyi/JGzmxQoTYEgH/OJvVy5RxAvEEVG532wQxyUvLypH06e0svNYwUExjn7Bs5aGPfPoi9zdDJdeQJkeASTC7i1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6FA1BF7;
	Wed, 10 Sep 2025 09:48:46 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C52483F63F;
	Wed, 10 Sep 2025 09:48:53 -0700 (PDT)
Message-ID: <ab3023a8-ebe0-48ac-b725-9f5d34ba94fa@arm.com>
Date: Wed, 10 Sep 2025 17:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fix possible deadlock in coresight_panic_cb
Content-Language: en-GB
To: Sean Anderson <sean.anderson@linux.dev>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
 Linu Cherian <lcherian@marvell.com>, James Clark <james.clark@linaro.org>
References: <20250828181738.1529289-1-sean.anderson@linux.dev>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250828181738.1529289-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean

On 28/08/2025 19:17, Sean Anderson wrote:
> coresight_panic_cb is called with interrupts disabled during panics.
> However, bus_for_each_dev calls bus_to_subsys which takes
> bus_kset->list_lock without disabling IRQs. This will cause a deadlock
> if a panic occurs while one of the other coresight functions that uses
> bus_for_each_dev is running.
> 
> Maintain a separate list of coresight devices to access during a panic.

Thanks for the patch. I have a minor comment.

> 
> Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/hwtracing/coresight/coresight-core.c | 40 ++++++++++----------
>   include/linux/coresight.h                    |  1 +
>   2 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fa758cc21827..1f1bf0e2bf92 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1315,6 +1315,9 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>   		coresight_remove_conns_sysfs_group(csdev);
>   }
>   
> +static DEFINE_SPINLOCK(csdev_lock);
> +static LIST_HEAD(csdev_list);

May be add a comment here to mention why we maintain this list ?

> +
>   struct coresight_device *coresight_register(struct coresight_desc *desc)
>   {
>   	int ret;
> @@ -1374,11 +1377,16 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   		goto out_unlock;
>   	}
>   
> +	scoped_guard(spinlock_irq, &csdev_lock)
> +		list_add(&csdev->csdev_list, &csdev_list);
> +
>   	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>   	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>   		ret = etm_perf_add_symlink_sink(csdev);
>   
>   		if (ret) {
> +			scoped_guard(spinlock_irq, &csdev_lock)
> +				list_del(&csdev->csdev_list);
Could this be moved to coresight_device_release(), which will be called
when the device gets unregistered ? That way, you don't need it here
and in coresight_unregister()  too.

Rest looks good to me

Suzuki

>   			device_unregister(&csdev->dev);
>   			/*
>   			 * As with the above, all resources are free'd
> @@ -1427,6 +1435,8 @@ void coresight_unregister(struct coresight_device *csdev)
>   	coresight_remove_conns(csdev);
>   	coresight_clear_default_sink(csdev);
>   	coresight_release_platform_data(csdev, csdev->dev.parent, csdev->pdata);
> +	scoped_guard(spinlock_irq, &csdev_lock)
> +		list_del(&csdev->csdev_list);
>   	device_unregister(&csdev->dev);
>   }
>   EXPORT_SYMBOL_GPL(coresight_unregister);
> @@ -1563,28 +1573,20 @@ const struct bus_type coresight_bustype = {
>   	.name	= "coresight",
>   };
>   
> -static int coresight_panic_sync(struct device *dev, void *data)
> -{
> -	int mode;
> -	struct coresight_device *csdev;
> -
> -	/* Run through panic sync handlers for all enabled devices */
> -	csdev = container_of(dev, struct coresight_device, dev);
> -	mode = coresight_get_mode(csdev);
> -
> -	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
> -		if (panic_ops(csdev))
> -			panic_ops(csdev)->sync(csdev);
> -	}
> -
> -	return 0;
> -}
> -
>   static int coresight_panic_cb(struct notifier_block *self,
>   			       unsigned long v, void *p)
>   {
> -	bus_for_each_dev(&coresight_bustype, NULL, NULL,
> -				 coresight_panic_sync);
> +	struct coresight_device *csdev;
> +
> +	guard(spinlock)(&csdev_lock);
> +	list_for_each_entry(csdev, &csdev_list, csdev_list) {
> +		/* Run through panic sync handlers for all enabled devices */
> +		int mode = coresight_get_mode(csdev);
> +
> +		if ((mode == CS_MODE_SYSFS || mode == CS_MODE_PERF) &&
> +		    panic_ops(csdev))
> +			panic_ops(csdev)->sync(csdev);
> +	}
>   
>   	return 0;
>   }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4ac65c68bbf4..a5e62ebd03b5 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -302,6 +302,7 @@ struct coresight_device {
>   	/* system configuration and feature lists */
>   	struct list_head feature_csdev_list;
>   	struct list_head config_csdev_list;
> +	struct list_head csdev_list;
>   	raw_spinlock_t cscfg_csdev_lock;
>   	void *active_cscfg_ctxt;
>   };


