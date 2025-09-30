Return-Path: <linux-kernel+bounces-837850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E86BADA07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F421943AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1D3074AB;
	Tue, 30 Sep 2025 15:14:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612B246BB0;
	Tue, 30 Sep 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245259; cv=none; b=qZtxGrBgJl+DcBG4HMqnzB7Y/riD5zTrO4pU4eHCda+D2lEgptQ4k9iv4UTaFKixgqMBmbIejH+fPWvT0eC1NYigu+nE2BNdKLUReo/na9yd/PuQYVBbQGF+9XyF826fs+1FoBUVae3KI1rHBgQdqseCLjoAbHM9NAzS6Tph0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245259; c=relaxed/simple;
	bh=Bs0GJUcinrEJPT+rMoGNbl4mEgc3r5S7YTQeXs8ki0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drwQFJ6yUE6HOgdB4tq9gQR4x0BU6Cwaf+u4WfhKEukO1slhf11C8SoSO/AzOkfV8Euc56qalj4X44NR13md3blA7PBdxhNWEnY9F1exVZpTjlDQ3kMEyoSKLk3pC7XpQ9VQh6r/iKkWP8wKJLTAJkDIOS+TwoPhlR7NWpg4/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BAFA1424;
	Tue, 30 Sep 2025 08:14:08 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D65A3F59E;
	Tue, 30 Sep 2025 08:14:15 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:14:14 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <20250930151414.GK7985@e132581.arm.com>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
 <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>

On Thu, Aug 14, 2025 at 11:49:56AM +0100, James Clark wrote:

[...]

> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -25,6 +25,11 @@
>  #include "coresight-syscfg.h"
>  #include "coresight-trace-id.h"
>  
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +#include <linux/perf/arm_pmu.h>
> +#include "coresight-etm4x.h"
> +#endif
> +
>  static struct pmu etm_pmu;
>  static bool etm_perf_up;
>  
> @@ -69,7 +74,10 @@ PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
>  /* config ID - set if a system configuration is selected */
>  PMU_FORMAT_ATTR(configid,	"config2:32-63");
>  PMU_FORMAT_ATTR(cc_threshold,	"config3:0-11");
> -
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +/* Interval = (2 ^ ts_level) */
> +GEN_PMU_FORMAT_ATTR(ts_level);
> +#endif
>  
>  /*
>   * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
> @@ -103,6 +111,9 @@ static struct attribute *etm_config_formats_attr[] = {
>  	&format_attr_configid.attr,
>  	&format_attr_branch_broadcast.attr,
>  	&format_attr_cc_threshold.attr,
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +	&format_attr_ts_level.attr,
> +#endif

By using .visible() callback for attrs, we can improve a bit code
without spreading "#ifdef IS_ENABLED()" in this file. E.g.,

   static umode_t format_attr_is_visible(struct kobject *kobj,
                                   struct attribute *attr, int n)
   {
        struct device *dev = kobj_to_dev(kobj);

        if (attr == &format_attr_ts_level.attr &&
	    !IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
                return 0;

        return attr->mode;
   }

Otherwise, LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 1a2d02bdcb88..42277c201d4f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -28,6 +28,7 @@
>  #include <linux/amba/bus.h>
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
> +#include <linux/perf/arm_pmu.h>
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -615,7 +616,7 @@ static void etm4_enable_hw_smp_call(void *info)
>   *  +--------------+
>   *         |
>   *  +------v-------+
> - *  | Counter x    |   (reload to 1 on underflow)
> + *  | Counter x    |   (reload to 2 ^ ts_level on underflow)
>   *  +--------------+
>   *         |
>   *  +------v--------------+
> @@ -626,11 +627,17 @@ static void etm4_enable_hw_smp_call(void *info)
>   *  | Timestamp Generator  |  (timestamp on resource y)
>   *  +----------------------+
>   */
> -static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
> +static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
> +				       struct perf_event_attr *attr)
>  {
>  	int ctridx;
>  	int rselector;
>  	struct etmv4_config *config = &drvdata->config;
> +	u8 ts_level = ATTR_CFG_GET_FLD(attr, ts_level);
> +
> +	/* Disable when ts_level == MAX */
> +	if (ts_level == FIELD_GET(ATTR_CFG_FLD_ts_level_MASK, UINT_MAX))
> +		return 0;
>  
>  	/* No point in trying if we don't have at least one counter */
>  	if (!drvdata->nr_cntr)
> @@ -666,12 +673,8 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>  		return -ENOSPC;
>  	}
>  
> -	/*
> -	 * Initialise original and reload counter value to the smallest
> -	 * possible value in order to get as much precision as we can.
> -	 */
> -	config->cntr_val[ctridx] = 1;
> -	config->cntrldvr[ctridx] = 1;
> +	/* Initialise original and reload counter value. */
> +	config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << ts_level;
>  
>  	/*
>  	 * Trace Counter Control Register TRCCNTCTLRn
> @@ -761,7 +764,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  		 * order to correlate instructions executed on different CPUs
>  		 * (CPU-wide trace scenarios).
>  		 */
> -		ret = etm4_config_timestamp_event(drvdata);
> +		ret = etm4_config_timestamp_event(drvdata, attr);
>  
>  		/*
>  		 * No need to go further if timestamp intervals can't
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index aaa6633b2d67..54558de158fa 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -598,6 +598,12 @@
>  #define ETM_CNTR_MAX_VAL		0xFFFF
>  #define ETM_TRACEID_MASK		0x3f
>  
> +#define ATTR_CFG_FLD_ts_level_CFG	config3
> +#define ATTR_CFG_FLD_ts_level_LO	12
> +#define ATTR_CFG_FLD_ts_level_HI	15
> +#define ATTR_CFG_FLD_ts_level_MASK	GENMASK(ATTR_CFG_FLD_ts_level_HI, \
> +						ATTR_CFG_FLD_ts_level_LO)
> +
>  /* ETMv4 programming modes */
>  #define ETM_MODE_EXCLUDE		BIT(0)
>  #define ETM_MODE_LOAD			BIT(1)
> 
> -- 
> 2.34.1
> 

