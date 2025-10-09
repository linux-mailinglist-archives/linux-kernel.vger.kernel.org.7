Return-Path: <linux-kernel+bounces-847103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B5BC9DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6247353D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E521C17D;
	Thu,  9 Oct 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlA5U5e4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DB217F2E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025054; cv=none; b=rdUTUePpAtSa003W/7cZOzxku6mQbSHvH9ZMyLvBPG+tu9zQ7DQAR291wF6+reXIhlocb+nft8J7mgwY1cdZ50PjKv/UfbqZ7FwEs+ieC5obVV94HyjwKBUXCPes6SVu174Vk4rXWbFUOlD3g06YWNLSq3LIUFiYR7fhtPi5+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025054; c=relaxed/simple;
	bh=wlGgFOdB0rfvdlg38nJ8y5HxdldjF1cCag1Bv/kU8OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJK8Odxs8kHQW88zl0eoNZBnlj54u5ougOoEh/93EediRrC9QDCl8Y2vHYVNl2n+alq4yU8HNePsQZaOE1pUAQr9+qcYXGzFJBVdFoeDjvCndaIiB4+hxRNN7K43dbcV04hdrBZAk7/EGz/Kq6p8KBHWzqtXaJFZq0fAyFz9heA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlA5U5e4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-796f9a8a088so839489b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760025052; x=1760629852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JPE0e2708pzpCr6xr7Gt0qmLVgRP/T1aZDZzZ8dnpI=;
        b=dlA5U5e4bbw6fg1/wW3Y39gtIQmBopz4obF0LNR2RZ2XsmtPbinCP5u5AUmDjo9r1p
         /nf55zTH26I8/nnfnXuKWp2GnTO+/FaqIfn+Ka4+MQzCFHcCvPeZSCuza148oUMENZxm
         mLVWwHiS1Y4RhpH9gm2Kd0sOwCJtmZ07+5VPe/SKeqxWsgxCEXrlf4bmruQulO8lgRpk
         FN060u/EZdQaEF8aFFoePHvbZWofPJPokfiFOqd7wpiej+KeXsSe6GUi2tEE3nV8xhHu
         CeTpOVHDsX3jjORRcG93djHwLnDgbCIUPsu9r1HQF6uQoaXakqF7HAv9ZDIFvi0u3IHa
         /Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025052; x=1760629852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JPE0e2708pzpCr6xr7Gt0qmLVgRP/T1aZDZzZ8dnpI=;
        b=ILnp9eFOthbH3xYjXDyE58Oy3yxhDm8k/cGeuxI6t0fVp/3xrCKg8c+ZJxThL2OFZi
         RwQ2gkSBAbzoXbH77zldtymC1qyF3Vk0cDaoj8gWxrQqDfc3d2SQx3Sf5PVMvEzb+2hl
         ac5eRF/7gFcZStVWqQGdQ3HfeWn23vvmbcoAj+TrlLSaPUANb60QA5eBNsl/MnTXkH9v
         KsLxbCMmMZXAf0u+dU9DAEb/dpBrnh3R53XRhlnXPkMc18Dg0wbZXSoCuLKcRGskxkFU
         pQ2XnKfYvnHPFBa64tYIhRBMEam8+/PY+RZRjvapgvrx7WfNq6gTzhNf/+JQ9jBRhoOs
         wdcA==
X-Forwarded-Encrypted: i=1; AJvYcCUR9DPUWcjGYT3dlpfxUKyM4T3ba3kQ/fIkycfGn0wiNSTWCdiDzz7XWI4tSEl7d1hDpxzZ3idYq0gwue4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQ7rBbtXu2OVOak/2xAZzx6vDQhQ7eaYXj+Utwcd9XnAC68Nx
	2xG5ApiJBuif9BjN3Rx8ci4yfMuXw+QN73H4nIhACZT/s3zLsLyoDRehUP/TjigL9kFHNltv438
	lAMsay0SVmF1KryTbCWazOKpqyKG6HeE++R1vVS1XHw==
X-Gm-Gg: ASbGnct9/QyeprKnisIdD/QJ2mO01z/Vs1j6WtGCfaWe0MHFTrUF//lUJNJhDyJQ2KG
	qtNFLaUBPREhbFkaz4bcV5p9MFzeLv8glTSvlN8/6lG6vIv6pI17rtYp2UtcZPICG408fQnyUN4
	EN4jk3QiLFH13ZjEXr8rZletuqn18CIuzaPA7c/TrSS+dtmYlaPdS4hKMhPNGk6G2YYIBS1mVMk
	P5NHE9TKr9MKN+a4D2NSK9vSZ/mhilAVUJplw980IJd0tU=
X-Google-Smtp-Source: AGHT+IHq2aF8fMGi+ONKT8XSLI0BKZXB2/+I0Sfw04mXALcG67VwBeW8aAPyxSwLKOBRdoTxch3nDK7mD9208RiV66U=
X-Received: by 2002:a05:6a00:1895:b0:781:1f28:eae9 with SMTP id
 d2e1a72fcca58-79384f48925mr9316911b3a.3.1760025051506; Thu, 09 Oct 2025
 08:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org> <20251002-james-cs-syncfreq-v3-4-fe5df2bf91d1@linaro.org>
In-Reply-To: <20251002-james-cs-syncfreq-v3-4-fe5df2bf91d1@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 9 Oct 2025 16:50:39 +0100
X-Gm-Features: AS18NWAFM9oP5HaX_9emGZH_eQM76b5_YsTX7-DatASksMSnptAg6shCNo_ZgDw
Message-ID: <CAJ9a7Vj1NnikoJyabXnad+=3SDULKCyqoZiNb_S66SkG+HD+dw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] coresight: Add format attribute for setting the
 timestamp interval
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James

On Thu, 2 Oct 2025 at 11:10, James Clark <james.clark@linaro.org> wrote:
>
> Timestamps are currently emitted at the maximum rate possible, which is
> much too frequent for most use cases. Add an attribute to be able to set
> the interval. Granular control is not required, so save space in the
> config by interpreting it as 2 ^ ts_interval. And then 4 bits (0 - 15) is
> enough to set the interval to be larger than the existing SYNC timestamp
> interval.
>
> No sysfs file is needed for this attribute because counter generated
> timestamps are only configured for Perf mode.
>
> Only show this attribute for ETM4x because timestamps aren't configured
> in the same way for ETM3x. The attribute is only ever read in
> coresight-etm4x-core.c.
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c   | 16 +++++++++++++++-
>  drivers/hwtracing/coresight/coresight-etm-perf.h   |  7 +++++++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 21 ++++++++++++---------
>  3 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f677c08233ba..0c1b990fc56e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -13,6 +13,7 @@
>  #include <linux/mm.h>
>  #include <linux/init.h>
>  #include <linux/perf_event.h>
> +#include <linux/perf/arm_pmu.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/slab.h>
>  #include <linux/stringhash.h>
> @@ -69,7 +70,8 @@ PMU_FORMAT_ATTR(sinkid,               "config2:0-31");
>  /* config ID - set if a system configuration is selected */
>  PMU_FORMAT_ATTR(configid,      "config2:32-63");
>  PMU_FORMAT_ATTR(cc_threshold,  "config3:0-11");
> -
> +/* Interval = (2 ^ ts_level) */
> +GEN_PMU_FORMAT_ATTR(ts_level);
>
>  /*
>   * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
> @@ -103,11 +105,23 @@ static struct attribute *etm_config_formats_attr[] = {
>         &format_attr_configid.attr,
>         &format_attr_branch_broadcast.attr,
>         &format_attr_cc_threshold.attr,
> +       &format_attr_ts_level.attr,
>         NULL,
>  };
>
> +static umode_t etm_format_attr_is_visible(struct kobject *kobj,
> +                                         struct attribute *attr, int unused)
> +{
> +       if (attr == &format_attr_ts_level.attr &&
> +           !IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
>  static const struct attribute_group etm_pmu_format_group = {
>         .name   = "format",
> +       .is_visible = etm_format_attr_is_visible,
>         .attrs  = etm_config_formats_attr,
>  };
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 5febbcdb8696..d2664ffb33e5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -7,6 +7,7 @@
>  #ifndef _CORESIGHT_ETM_PERF_H
>  #define _CORESIGHT_ETM_PERF_H
>
> +#include <linux/bits.h>
>  #include <linux/percpu-defs.h>
>  #include "coresight-priv.h"
>
> @@ -20,6 +21,12 @@ struct cscfg_config_desc;
>   */
>  #define ETM_ADDR_CMP_MAX       8
>
> +#define ATTR_CFG_FLD_ts_level_CFG      config3
> +#define ATTR_CFG_FLD_ts_level_LO       12
> +#define ATTR_CFG_FLD_ts_level_HI       15
> +#define ATTR_CFG_FLD_ts_level_MASK     GENMASK(ATTR_CFG_FLD_ts_level_HI, \
> +                                               ATTR_CFG_FLD_ts_level_LO)
> +
>  /**
>   * struct etm_filter - single instruction range or start/stop configuration.
>   * @start_addr:        The address to start tracing on.
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 920d092ef862..034844f52bb2 100644
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
> @@ -616,7 +617,7 @@ static void etm4_enable_hw_smp_call(void *info)
>   *  +--------------+
>   *         |
>   *  +------v-------+
> - *  | Counter x    |   (reload to 1 on underflow)
> + *  | Counter x    |   (reload to 2 ^ ts_level on underflow)
>   *  +--------------+
>   *         |
>   *  +------v--------------+
> @@ -627,11 +628,17 @@ static void etm4_enable_hw_smp_call(void *info)
>   *  | Timestamp Generator  |  (timestamp on resource y)
>   *  +----------------------+
>   */
> -static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
> +static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
> +                                      struct perf_event_attr *attr)
>  {
>         int ctridx;
>         int rselector;
>         struct etmv4_config *config = &drvdata->config;
> +       u8 ts_level = ATTR_CFG_GET_FLD(attr, ts_level);
> +
> +       /* Disable when ts_level == MAX */
> +       if (ts_level == FIELD_GET(ATTR_CFG_FLD_ts_level_MASK, UINT_MAX))
> +               return 0;
>

Returning 0 from this function _enables_ the timestamps

>         /* No point in trying if we don't have at least one counter */
>         if (!drvdata->nr_cntr)
> @@ -667,12 +674,8 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>                 return -ENOSPC;
>         }
>
> -       /*
> -        * Initialise original and reload counter value to the smallest
> -        * possible value in order to get as much precision as we can.
> -        */
> -       config->cntr_val[ctridx] = 1;
> -       config->cntrldvr[ctridx] = 1;
> +       /* Initialise original and reload counter value. */
> +       config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << ts_level;
>
>         /*
>          * Trace Counter Control Register TRCCNTCTLRn
> @@ -762,7 +765,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>                  * order to correlate instructions executed on different CPUs
>                  * (CPU-wide trace scenarios).
>                  */
> -               ret = etm4_config_timestamp_event(drvdata);
> +               ret = etm4_config_timestamp_event(drvdata, attr);
>
>                 /*
>                  * No need to go further if timestamp intervals can't
>
> --
> 2.34.1
>

Regards


Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

