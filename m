Return-Path: <linux-kernel+bounces-838893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1440BB05E7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCED7AB424
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF12EB860;
	Wed,  1 Oct 2025 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPrJ0TGv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6313C695
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322443; cv=none; b=nY0mJkPOr33u2Q679MPljou6Cvbxmf2pTn6rXywQ416YWykhmB68TLD6s25ZPmGmsiZ5GjmuR4iFdhhnNLSf9ixn0Q6bz4tYFyfjipBnPWvua+8mUk5nY5VQJLf8rG9F1EOsLS4lsyW+KcdZL0Vw+ismSZ0GP0YLRqXCUInRwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322443; c=relaxed/simple;
	bh=AuhqTdEHZu0N4P65fsFnt/ODGFUaC+ldpMWEMpyzdsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXstYWMxgs+7wDlIc+FcH3oHasBvB6EhIRhxjmhH6TJs9LkTxXCjzVZW0cIu8zOGjXP9SBQh1xcDizivFzM1RBWJOV6JU2gi6aZz7czidmqIgUTnxmveU/jSYih03qGqLD+zxFk/lr86J+ap32eDvkj8VURjpWgJFnpoImMKh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPrJ0TGv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e5980471eso14668845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759322439; x=1759927239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYTXqVRUgKBecqzeWFJPcnJVjiQJBfMxkjWzOS+Rt7E=;
        b=bPrJ0TGvV/0HrNMVdJn7brtWo1Yoo0/o8Kx2t3CNBU7HhXXhrF5i3VwBa3wRSqOu5p
         f9yJ+1XHzvftm4J5jlUNiCOVOxnsl7gxTySQUY0cPm8Mj8U1Pyum65OSrRDQSgn+pnyi
         F8TLOiqZj1uzeXbQUms0a40g+bQKMvk99S40UMYjj3H80XuCohgueo5dH7uKylv+orDE
         2Fx8ulL960wlowAsQ6ySJN9g2Xi2MFfO4erM/M6VpQV5zcNBN1opasZ9CEmH9Mos1b/h
         ZB1RZWhFvtV4XxyJJ0xZ0rVrEp5GuOLm7YQC7f1iZb4w/jfOtvF/9/dmyiF666aECJb2
         QOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759322439; x=1759927239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYTXqVRUgKBecqzeWFJPcnJVjiQJBfMxkjWzOS+Rt7E=;
        b=S2vCWmE6WV05MKUfq494EFFrUFRFXgDX+RgYGvoAXt+hgb3asyBJjbQBfPxD3yDDHj
         UNT550HXpF36GlROsZuKFH/6WzOmtuvPKyUweJ5jXg5EryIu1LltnpOZ7mKashYT1MC/
         XbVP9QXUWBeviuRowVoQchagnQF7lbGIWvrsIhnxtkGrey1Pid1QAEyZcol3vEEiqMPC
         0keU/jeBiI3zrMiLO6o8IEDlwRNW+J/3jEz8+2+N63A54IG6SHdCXOAV4KFKlFaiBh8a
         4lQgRSFixvIrNMPYc4CbOcg5RTigAH1YGobUBm7U864YU/e1caWSYbIoMZK4I85FRSrM
         Omwg==
X-Forwarded-Encrypted: i=1; AJvYcCV/KL5wgxRu/CxLuu5uyZSsMI5UWqh7jAZPtbWK6i+WCecV7PAjSvhpeeLsmMfOHoHlFyIMc5pD6bR9AK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEOPGvNaEnGGMRVFFR1vtagDWDGEhsKqYFE7k0wEP4ZTF5/02
	CJhOD7ZTqxI8q+EefUZDVngzY8O0niBipmkvc5gxXr3kk+tVXxMSs9OMuqTOtMGbxDw=
X-Gm-Gg: ASbGncsYvUSxd3EZi/OvtN+ldGaHEKCZBJa14p3cej1HvB/LRmgc/x2Z+3l7O5vJvNm
	YBdUvo7GvPCuDR7AnbaQ3HCfOUb6w4jCEEQXJEr9tTKKyA28xHkqkwdidkGYjYotz3N0uQuDBZr
	Zx6iBZvrkbbfH3Gitpfp3EgB7T0Bt6Gexp7qbhCPI9KYyucW6IiKP4SQewnF6B/UMqub6Bx/aCG
	UxQ17rkGnVv7ABklRwQ9zrErX8PHFstzxhM/Z0rgdDihrx4TwszW58A+J/a6wPSUsN3P+XGfKg3
	o+fKAf+bluOniJVdHuQUq6sHRkzyLiOmEkUUBjMEv+C5eAyzCYvpXvGL27P5q6CnC1JHxfm0Klv
	P4lmWOjCU3tuhLb427MenIOQPYyeeryoj3QFvt+JclMrQeKRP9hAT
X-Google-Smtp-Source: AGHT+IGo2u62hTBre5IhKlA68oJLY9wdX6JZmyVYIDOL0eOH23ZnAYoa4shn9eEhSc/1I5hVi4MaZA==
X-Received: by 2002:a05:600c:870b:b0:46e:3e63:9a8e with SMTP id 5b1f17b1804b1-46e612856c2mr29292665e9.26.1759322439276;
        Wed, 01 Oct 2025 05:40:39 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6199202csm38083815e9.4.2025.10.01.05.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 05:40:38 -0700 (PDT)
Message-ID: <3a731a9e-0621-42b6-b7fc-4b0fd9b7da6e@linaro.org>
Date: Wed, 1 Oct 2025 13:40:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] coresight: Add format attribute for setting the
 timestamp interval
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
 <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>
 <20250930151414.GK7985@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250930151414.GK7985@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/09/2025 4:14 pm, Leo Yan wrote:
> On Thu, Aug 14, 2025 at 11:49:56AM +0100, James Clark wrote:
> 
> [...]
> 
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -25,6 +25,11 @@
>>   #include "coresight-syscfg.h"
>>   #include "coresight-trace-id.h"
>>   
>> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>> +#include <linux/perf/arm_pmu.h>
>> +#include "coresight-etm4x.h"
>> +#endif
>> +
>>   static struct pmu etm_pmu;
>>   static bool etm_perf_up;
>>   
>> @@ -69,7 +74,10 @@ PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
>>   /* config ID - set if a system configuration is selected */
>>   PMU_FORMAT_ATTR(configid,	"config2:32-63");
>>   PMU_FORMAT_ATTR(cc_threshold,	"config3:0-11");
>> -
>> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>> +/* Interval = (2 ^ ts_level) */
>> +GEN_PMU_FORMAT_ATTR(ts_level);
>> +#endif
>>   
>>   /*
>>    * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
>> @@ -103,6 +111,9 @@ static struct attribute *etm_config_formats_attr[] = {
>>   	&format_attr_configid.attr,
>>   	&format_attr_branch_broadcast.attr,
>>   	&format_attr_cc_threshold.attr,
>> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>> +	&format_attr_ts_level.attr,
>> +#endif
> 
> By using .visible() callback for attrs, we can improve a bit code
> without spreading "#ifdef IS_ENABLED()" in this file. E.g.,
> 
>     static umode_t format_attr_is_visible(struct kobject *kobj,
>                                     struct attribute *attr, int n)
>     {
>          struct device *dev = kobj_to_dev(kobj);
> 
>          if (attr == &format_attr_ts_level.attr &&
> 	    !IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
>                  return 0;
> 
>          return attr->mode;
>     }
> 
> Otherwise, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 

Unfortunately that won't work because you'd have to always include 
coresight-etm4x.h. This file is compiled for both arm32 and arm64 so it 
would break the arm32 build.

I could define the TTR_CFG_FLD_ts_level_* stuff somewhere else but then 
it becomes messier than just doing the #ifdefs here.

>>   	NULL,
>>   };
>>   
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 1a2d02bdcb88..42277c201d4f 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/amba/bus.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/perf/arm_pmu.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>> @@ -615,7 +616,7 @@ static void etm4_enable_hw_smp_call(void *info)
>>    *  +--------------+
>>    *         |
>>    *  +------v-------+
>> - *  | Counter x    |   (reload to 1 on underflow)
>> + *  | Counter x    |   (reload to 2 ^ ts_level on underflow)
>>    *  +--------------+
>>    *         |
>>    *  +------v--------------+
>> @@ -626,11 +627,17 @@ static void etm4_enable_hw_smp_call(void *info)
>>    *  | Timestamp Generator  |  (timestamp on resource y)
>>    *  +----------------------+
>>    */
>> -static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>> +static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>> +				       struct perf_event_attr *attr)
>>   {
>>   	int ctridx;
>>   	int rselector;
>>   	struct etmv4_config *config = &drvdata->config;
>> +	u8 ts_level = ATTR_CFG_GET_FLD(attr, ts_level);
>> +
>> +	/* Disable when ts_level == MAX */
>> +	if (ts_level == FIELD_GET(ATTR_CFG_FLD_ts_level_MASK, UINT_MAX))
>> +		return 0;
>>   
>>   	/* No point in trying if we don't have at least one counter */
>>   	if (!drvdata->nr_cntr)
>> @@ -666,12 +673,8 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>>   		return -ENOSPC;
>>   	}
>>   
>> -	/*
>> -	 * Initialise original and reload counter value to the smallest
>> -	 * possible value in order to get as much precision as we can.
>> -	 */
>> -	config->cntr_val[ctridx] = 1;
>> -	config->cntrldvr[ctridx] = 1;
>> +	/* Initialise original and reload counter value. */
>> +	config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << ts_level;
>>   
>>   	/*
>>   	 * Trace Counter Control Register TRCCNTCTLRn
>> @@ -761,7 +764,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>   		 * order to correlate instructions executed on different CPUs
>>   		 * (CPU-wide trace scenarios).
>>   		 */
>> -		ret = etm4_config_timestamp_event(drvdata);
>> +		ret = etm4_config_timestamp_event(drvdata, attr);
>>   
>>   		/*
>>   		 * No need to go further if timestamp intervals can't
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index aaa6633b2d67..54558de158fa 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -598,6 +598,12 @@
>>   #define ETM_CNTR_MAX_VAL		0xFFFF
>>   #define ETM_TRACEID_MASK		0x3f
>>   
>> +#define ATTR_CFG_FLD_ts_level_CFG	config3
>> +#define ATTR_CFG_FLD_ts_level_LO	12
>> +#define ATTR_CFG_FLD_ts_level_HI	15
>> +#define ATTR_CFG_FLD_ts_level_MASK	GENMASK(ATTR_CFG_FLD_ts_level_HI, \
>> +						ATTR_CFG_FLD_ts_level_LO)
>> +
>>   /* ETMv4 programming modes */
>>   #define ETM_MODE_EXCLUDE		BIT(0)
>>   #define ETM_MODE_LOAD			BIT(1)
>>
>> -- 
>> 2.34.1
>>


