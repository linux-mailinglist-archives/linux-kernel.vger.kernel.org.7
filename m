Return-Path: <linux-kernel+bounces-854759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D5BDF4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C059E19C6EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C992FB97F;
	Wed, 15 Oct 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkQ2Yp96"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D32FA0DF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541551; cv=none; b=sMvie6yW+qdzZ/UquotyY3jyQpAW3pdTsrOjCSf0oQ5B7+jG7WiN8aieg/Qz4jXIE6oUruJHABp0fKdRaFQKSNSBBd1RaEBbnplhu7ZWDLz+Wlu35fMJJSek664Rib4aGqt8uZdVeQnOPgLRLca7Gq1lZQxqb56UPZxFIIGzsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541551; c=relaxed/simple;
	bh=9xwOjhbT+GpY03m9KlJEQtMVGXICweoyvs7lxP+VuAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0mwW38lTpyGL11eyKL+qLwZug0UCWo6CTYI0qVIeXf89gTDKS/JK5vqYrGtf4mpg8W+AFntCEpwTwLm/FrKDksZGePOpoJRXJ1OScEztN0WbMu4dqLlbg64ywvuykDfneOSLEMV3+NCyQIqDvlIXTBfseR1dFKRqAS80y8FiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkQ2Yp96; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso5558101f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760541546; x=1761146346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozzqX27qI/om600ZTPA46M3BTEK2ZsX0XsaZoTyCATk=;
        b=IkQ2Yp96LXaC4/lC2YVySGP6YgR5if2S5hs5v05LVOUHmcFMvyREroNroBOLdHFuIU
         rn3N+8UQRL7oUnk390VRHiAO5Wmj2RqzV63Ot4QHCFgiAFJARoG5sbMdE4ccoQ7rKVpe
         9LYJdMfowPxJGiD90p2L1pKOmQRelH7Z7sduAQW8am8olp/9tdm4b/gTl/6JFyc+4NBu
         WLQMlmgueLQnoOQ/gKtuKMf+pC0ce27IZdpS1KQlvq6T38rk+BPTD7TR8qYBW/ku/w91
         HREyAlRvl15Rsni4uCH+LTros2Xkw1sM+HtP0q5obJEmj3drO1d2SO67dMSN+tmtT6vR
         aknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541546; x=1761146346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozzqX27qI/om600ZTPA46M3BTEK2ZsX0XsaZoTyCATk=;
        b=KlxHuKjf056Qrnw1H/La9q5ueW2hB/XeGhOa6wEu98xj0knW0Hyus5gDvjHQ7F3NDk
         S7frnZpXLz6FHmzs95ZPzozBoQB7Jpp2L55iXctm2pXkBhzi01YFnU29pH5I3XPiEieG
         mRABnfY4sj7Hh2GoKiuzMKZKybOaR062VtdRaJRwxeub+GGq9XgWH2Xd4QGVUDwwDrTR
         UHi5+LWrp+NraxZK4Czos3xKQ1ycptbkPqKRb0FlqyE1Tb7bpO3jNnIaIIiJiiku2oun
         d5lHMgGIexQ/pEQZg9dExpggfAzM00MeE2rCpK9lalor5NbPZCMBzV8JrQSvpC4Vg+hi
         fVbw==
X-Forwarded-Encrypted: i=1; AJvYcCViHgtgLZOaktzTG1TttCRaaV1+RZHybAAZgwKcXtzM/cHfMxLlVPFu6qvNTAoWCKFC3Jc4aQnHlKn19mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIe8w4nNc1dg6Ugxe5s9VAEw7kCGjICzXZNJUG5EkOIprRTo2P
	7BCAgY8RlJmoWWnzEuMUtQZxssbtjNiq71irXOBOkM6NafXGSwS5QoVQgzjpdFCuwy4=
X-Gm-Gg: ASbGnctSQ5MDoAnjd2aSJQEkYSzNnwafL2bJKqe8TY0m7Ws0OQbJU2pMFaej+BlC1pn
	ux32ocLBPAJR6eGNmDuk5TnNO+6oIyMJxYMkav7YTFnVgwLZMVBctS1xENbQ5O5eG0qVFQAyTVy
	NrT9F6HUNpODMgEHXBVOMCGpXY4++gEVwnxqEivmXSBfba2OMitJ+FSqZs37wwWxCj/zDYxmV04
	GbAuQW0NfKt1Ejv902GokV9nh32FHm1jcdxtq32g+YwE15tP8Pq3Nc/fQKWF+D7MxVKndsg5Zxd
	h1eQgvou9KH1NCiSwHJxcMkw6PlRERTuvwl+JKpJg+SZQnr2mAsuJ9WxFXRwKEPe5zzqpXKR8rz
	q0MUALT2D8noXTv9qbAukdN9g6ZLhGUTQUR1sIgwEztoxHlzqVbc=
X-Google-Smtp-Source: AGHT+IF3N4RF7wjNKV78n5ehk7O1cj857Eb665p5lv3nX2KcjaMyC/Xbc7kHngxEcnnvUHEwHV5Jog==
X-Received: by 2002:a05:6000:3105:b0:3f9:1571:fdea with SMTP id ffacd0b85a97d-4266e8dd683mr21126849f8f.44.1760541545655;
        Wed, 15 Oct 2025 08:19:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm29524067f8f.40.2025.10.15.08.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 08:19:05 -0700 (PDT)
Message-ID: <bfce6b68-783f-4aa1-b9db-d905230be609@linaro.org>
Date: Wed, 15 Oct 2025 16:19:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] coresight: Add format attribute for setting the
 timestamp interval
To: Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
 <20251002-james-cs-syncfreq-v3-4-fe5df2bf91d1@linaro.org>
 <CAJ9a7Vj1NnikoJyabXnad+=3SDULKCyqoZiNb_S66SkG+HD+dw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7Vj1NnikoJyabXnad+=3SDULKCyqoZiNb_S66SkG+HD+dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/10/2025 4:50 pm, Mike Leach wrote:
> Hi James
> 
> On Thu, 2 Oct 2025 at 11:10, James Clark <james.clark@linaro.org> wrote:
>>
>> Timestamps are currently emitted at the maximum rate possible, which is
>> much too frequent for most use cases. Add an attribute to be able to set
>> the interval. Granular control is not required, so save space in the
>> config by interpreting it as 2 ^ ts_interval. And then 4 bits (0 - 15) is
>> enough to set the interval to be larger than the existing SYNC timestamp
>> interval.
>>
>> No sysfs file is needed for this attribute because counter generated
>> timestamps are only configured for Perf mode.
>>
>> Only show this attribute for ETM4x because timestamps aren't configured
>> in the same way for ETM3x. The attribute is only ever read in
>> coresight-etm4x-core.c.
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c   | 16 +++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-etm-perf.h   |  7 +++++++
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 21 ++++++++++++---------
>>   3 files changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index f677c08233ba..0c1b990fc56e 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/init.h>
>>   #include <linux/perf_event.h>
>> +#include <linux/perf/arm_pmu.h>
>>   #include <linux/percpu-defs.h>
>>   #include <linux/slab.h>
>>   #include <linux/stringhash.h>
>> @@ -69,7 +70,8 @@ PMU_FORMAT_ATTR(sinkid,               "config2:0-31");
>>   /* config ID - set if a system configuration is selected */
>>   PMU_FORMAT_ATTR(configid,      "config2:32-63");
>>   PMU_FORMAT_ATTR(cc_threshold,  "config3:0-11");
>> -
>> +/* Interval = (2 ^ ts_level) */
>> +GEN_PMU_FORMAT_ATTR(ts_level);
>>
>>   /*
>>    * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
>> @@ -103,11 +105,23 @@ static struct attribute *etm_config_formats_attr[] = {
>>          &format_attr_configid.attr,
>>          &format_attr_branch_broadcast.attr,
>>          &format_attr_cc_threshold.attr,
>> +       &format_attr_ts_level.attr,
>>          NULL,
>>   };
>>
>> +static umode_t etm_format_attr_is_visible(struct kobject *kobj,
>> +                                         struct attribute *attr, int unused)
>> +{
>> +       if (attr == &format_attr_ts_level.attr &&
>> +           !IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
>> +               return 0;
>> +
>> +       return attr->mode;
>> +}
>> +
>>   static const struct attribute_group etm_pmu_format_group = {
>>          .name   = "format",
>> +       .is_visible = etm_format_attr_is_visible,
>>          .attrs  = etm_config_formats_attr,
>>   };
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
>> index 5febbcdb8696..d2664ffb33e5 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
>> @@ -7,6 +7,7 @@
>>   #ifndef _CORESIGHT_ETM_PERF_H
>>   #define _CORESIGHT_ETM_PERF_H
>>
>> +#include <linux/bits.h>
>>   #include <linux/percpu-defs.h>
>>   #include "coresight-priv.h"
>>
>> @@ -20,6 +21,12 @@ struct cscfg_config_desc;
>>    */
>>   #define ETM_ADDR_CMP_MAX       8
>>
>> +#define ATTR_CFG_FLD_ts_level_CFG      config3
>> +#define ATTR_CFG_FLD_ts_level_LO       12
>> +#define ATTR_CFG_FLD_ts_level_HI       15
>> +#define ATTR_CFG_FLD_ts_level_MASK     GENMASK(ATTR_CFG_FLD_ts_level_HI, \
>> +                                               ATTR_CFG_FLD_ts_level_LO)
>> +
>>   /**
>>    * struct etm_filter - single instruction range or start/stop configuration.
>>    * @start_addr:        The address to start tracing on.
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 920d092ef862..034844f52bb2 100644
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
>> @@ -616,7 +617,7 @@ static void etm4_enable_hw_smp_call(void *info)
>>    *  +--------------+
>>    *         |
>>    *  +------v-------+
>> - *  | Counter x    |   (reload to 1 on underflow)
>> + *  | Counter x    |   (reload to 2 ^ ts_level on underflow)
>>    *  +--------------+
>>    *         |
>>    *  +------v--------------+
>> @@ -627,11 +628,17 @@ static void etm4_enable_hw_smp_call(void *info)
>>    *  | Timestamp Generator  |  (timestamp on resource y)
>>    *  +----------------------+
>>    */
>> -static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>> +static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>> +                                      struct perf_event_attr *attr)
>>   {
>>          int ctridx;
>>          int rselector;
>>          struct etmv4_config *config = &drvdata->config;
>> +       u8 ts_level = ATTR_CFG_GET_FLD(attr, ts_level);
>> +
>> +       /* Disable when ts_level == MAX */
>> +       if (ts_level == FIELD_GET(ATTR_CFG_FLD_ts_level_MASK, UINT_MAX))
>> +               return 0;
>>
> 
> Returning 0 from this function _enables_ the timestamps
> 

Returning 0 just means that etm4_parse_event_config() doesn't exit with 
an error. For ts_level == MAX we want to disable timestamps generated by 
the counter, but we still want the minimum periodic timestamps.

To disable all timestamps you'd need to have attr->config & 
BIT(ETM_OPT_TS) == false. This is set by the "timestamp" format flag 
which I tried to explain that in the docs change.

I could also change the comment to say "/* Disable counter generated 
timestamps with ts_level == MAX */"

It's unfortunate that there are now two format options for timestamps. 
Maybe instead of adding a second option we can change "timestamp" from a 
1 bit field to 4 bits, with the following meanings:

  0:     No counter timestamps or SYNC timestamps
  1-14:  Counter timestamps = 2 ^ x. Plus SYNC timestamps
  15:    Only SYNC timestamps

Now we basically have the same meanings except you also have to set the 
timestamp bit. Seems a bit pointless.

Previous versions of Perf were hard coding the timestamp format bit 
rather than reading it out of 
"/sys/bus/event_source/devices/cs_etm/format/timestamp" though:

-       /* All good, let the kernel know */
-       evsel->core.attr.config |= (1 << ETM_OPT_TS);

For that reason we'd have to leave that one where it is for backwards 
compatibility. If it's set it would be equivalent to the new wider 
timestamp field == 1.

I don't know if there's any precedent for changing the bitfield that 
backs a format field, but presumably that's the point of publishing them 
in files rather than a header.

>>          /* No point in trying if we don't have at least one counter */
>>          if (!drvdata->nr_cntr)
>> @@ -667,12 +674,8 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>>                  return -ENOSPC;
>>          }
>>
>> -       /*
>> -        * Initialise original and reload counter value to the smallest
>> -        * possible value in order to get as much precision as we can.
>> -        */
>> -       config->cntr_val[ctridx] = 1;
>> -       config->cntrldvr[ctridx] = 1;
>> +       /* Initialise original and reload counter value. */
>> +       config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << ts_level;
>>
>>          /*
>>           * Trace Counter Control Register TRCCNTCTLRn
>> @@ -762,7 +765,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>                   * order to correlate instructions executed on different CPUs
>>                   * (CPU-wide trace scenarios).
>>                   */
>> -               ret = etm4_config_timestamp_event(drvdata);
>> +               ret = etm4_config_timestamp_event(drvdata, attr);
>>
>>                  /*
>>                   * No need to go further if timestamp intervals can't
>>
>> --
>> 2.34.1
>>
> 
> Regards
> 
> 
> Mike
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK


