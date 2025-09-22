Return-Path: <linux-kernel+bounces-827059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6CEB900D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEAE422806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94F3002C1;
	Mon, 22 Sep 2025 10:34:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A212264B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537257; cv=none; b=hCOm1BqGZJzLBZb7ulPJ5zcvJSJud5QzMCqLReKMhmyIa5doe9X6vTC6dYTj6GXLIx2IA4WYb+vDMzFxg2XkRtuqxeuOqv00LulZOqcskKDyTu3PieA20j/NG+o+tDxHCfxflPtQn4yyECDo2dixyXjjXyUl/gUSnWfKdBetEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537257; c=relaxed/simple;
	bh=fxZqgCQlL8Ue4RXjT9BEhiT1hKNaYjjk5++YMgOPy1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXWB3gEz53j+mU/VXiPkuN5jsFD6UDfQVBzF/HUn86kvGBRFbhpTlA3l17OQwOi0Y19NYbQ9CD1G38EYaV9txBkUF4a9XdXARfWk3FMc1RMDuS9aotTjbTeEnV9P+Ml7MNJKItN2TQiL5EwVtJvnu1p6ZblJE6tICjdbr0dMW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 044EF497;
	Mon, 22 Sep 2025 03:34:07 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B673F66E;
	Mon, 22 Sep 2025 03:34:14 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:34:12 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] coresight: Fix possible deadlock in
 coresight_panic_cb
Message-ID: <20250922103412.GF516577@e132581.arm.com>
References: <20250919160653.507109-1-sean.anderson@linux.dev>
 <20250919160653.507109-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919160653.507109-3-sean.anderson@linux.dev>

On Fri, Sep 19, 2025 at 12:06:53PM -0400, Sean Anderson wrote:

[...]

> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 022c8384b98d..6dfb1198c16e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1046,8 +1046,11 @@ static void coresight_device_release(struct device *dev)
>  {
>  	struct coresight_device *csdev = to_coresight_device(dev);
>  
> -	fwnode_handle_put(csdev->dev.fwnode);
> +	if (panic_ops(csdev))
> +		atomic_notifier_chain_unregister(&panic_notifier_list,
> +						 &csdev->panic_notifier);
>  	free_percpu(csdev->perf_sink_id_map.cpu_map);
> +	fwnode_handle_put(csdev->dev.fwnode);

The moving fwnode_handle_put() is irrelvant to panic notifier fix,
should be moved out from this patch.

>  	kfree(csdev);
>  }
>  
> @@ -1315,6 +1318,16 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>  		coresight_remove_conns_sysfs_group(csdev);
>  }
>  
> +static int coresight_panic_notifier(struct notifier_block *nb,
> +				    unsigned long action, void *data)
> +{
> +	struct coresight_device *csdev =
> +		container_of(nb, struct coresight_device, panic_notifier);
> +

Need to check device mode:

        if (coresight_get_mode(csdev) == CS_MODE_DISABLED)
            return NOTIFY_DONE;

The rest is fine for me.

Thanks,
Leo

> +	panic_ops(csdev)->sync(csdev);
> +	return NOTIFY_DONE;
> +}
> +
>  struct coresight_device *coresight_register(struct coresight_desc *desc)
>  {
>  	int ret;
> @@ -1357,6 +1370,17 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  			goto err_out;
>  		}
>  	}
> +
> +	if (panic_ops(csdev)) {
> +		csdev->panic_notifier.notifier_call = coresight_panic_notifier;
> +		ret = atomic_notifier_chain_register(&panic_notifier_list,
> +						     &csdev->panic_notifier);
> +		if (ret) {
> +			coresight_device_release(&csdev->dev);
> +			goto err_out;
> +		}
> +	}
> +
>  	/*
>  	 * Make sure the device registration and the connection fixup
>  	 * are synchronised, so that we don't see uninitialised devices
> @@ -1563,36 +1587,6 @@ const struct bus_type coresight_bustype = {
>  	.name	= "coresight",
>  };
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
> -static int coresight_panic_cb(struct notifier_block *self,
> -			       unsigned long v, void *p)
> -{
> -	bus_for_each_dev(&coresight_bustype, NULL, NULL,
> -				 coresight_panic_sync);
> -
> -	return 0;
> -}
> -
> -static struct notifier_block coresight_notifier = {
> -	.notifier_call = coresight_panic_cb,
> -};
> -
>  static int __init coresight_init(void)
>  {
>  	int ret;
> @@ -1605,20 +1599,11 @@ static int __init coresight_init(void)
>  	if (ret)
>  		goto exit_bus_unregister;
>  
> -	/* Register function to be called for panic */
> -	ret = atomic_notifier_chain_register(&panic_notifier_list,
> -					     &coresight_notifier);
> -	if (ret)
> -		goto exit_perf;
> -
>  	/* initialise the coresight syscfg API */
>  	ret = cscfg_init();
>  	if (!ret)
>  		return 0;
>  
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					     &coresight_notifier);
> -exit_perf:
>  	etm_perf_exit();
>  exit_bus_unregister:
>  	bus_unregister(&coresight_bustype);
> @@ -1628,8 +1613,6 @@ static int __init coresight_init(void)
>  static void __exit coresight_exit(void)
>  {
>  	cscfg_exit();
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					     &coresight_notifier);
>  	etm_perf_exit();
>  	bus_unregister(&coresight_bustype);
>  }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4ac65c68bbf4..a7aaf9d3d01d 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -280,6 +280,7 @@ struct coresight_trace_id_map {
>   * @config_csdev_list:  List of system configurations added to the device.
>   * @cscfg_csdev_lock:	Protect the lists of configurations and features.
>   * @active_cscfg_ctxt:  Context information for current active system configuration.
> + * @panic_notifier: Notifier block used to clean up during a panic
>   */
>  struct coresight_device {
>  	struct coresight_platform_data *pdata;
> @@ -304,6 +305,7 @@ struct coresight_device {
>  	struct list_head config_csdev_list;
>  	raw_spinlock_t cscfg_csdev_lock;
>  	void *active_cscfg_ctxt;
> +	struct notifier_block panic_notifier;
>  };
>  
>  /*
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

