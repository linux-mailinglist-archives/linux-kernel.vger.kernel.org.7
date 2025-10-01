Return-Path: <linux-kernel+bounces-838972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90DBB08C7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1A84A6BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035E2EF665;
	Wed,  1 Oct 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8fVYTZj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B492EF653
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326251; cv=none; b=V8a64RD6XnX4XSttK911OidIFhWcPRzvY2czjvuYjomeBuOCnym5EpblcceXOVthNKpkaOGtke+WZnvTZCOkZBIqfao8RNOx4417K/UXRsS7OHTIkcv1+ZPjR8yOdX24Q5gVTZSU5fcc1YG1m4yVj0dojYC3KOHJHtipjNxnmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326251; c=relaxed/simple;
	bh=zZG41IIPpecftPSR/BMuKoOK5Drk5rCESRq1EzmErag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCmg7Jmg8H6Lvd0+BC00HSLHpDq+mkC6S2qvF8p4KU5wXIqs0RYnWXuqETvziz+FKcApg1d1vAQyYjROLOCwNmxWuLHeEgcqhjNeUFfqFPUPSu7pXgM8i95ZDcY47FMEJEUa8oZchY+DIqn4s9KT0GtoLIQ4rAHseQRJMQnkb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d8fVYTZj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e47cca387so54724895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759326247; x=1759931047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sk9/01sjLhSDKrsz2vI2OXUeP/F7c38Pwscg4TdgVDU=;
        b=d8fVYTZjCsKyvZALElY1lsLUXATVDT8AzqlDb4am5IdPnsgxUl95tP2R2i8hr2f8ry
         EL2Cu8Woz6/bBb2oyMaI8PuUiwujxLFxSV+qwIwyRPCaul9fG6HzWSJOxHnsoFIXYtes
         o6LZXUWcpJDxvwq7VTYhmHtrze+Djf20PEXQINA1p/rcQI+/NmA594cIZ0/YX5GOXlax
         ULJAisesNkNHdaNz6BDGQAxibpaYSKTGbOBoGIL+GrbGpkPrQgK4RqT3k7YgBzGCcnDH
         pCDASkbL7Xj5lnqXgV/Pq8b89j0J4mv7kyXG0euLKbTeQeqgRbIQQkW2zX8BgichHeMT
         jFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326247; x=1759931047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sk9/01sjLhSDKrsz2vI2OXUeP/F7c38Pwscg4TdgVDU=;
        b=oRIKlYqB6Twr7x7RCGNdt7I9DvM5gDLRDkvVUB7nIXtq3NFcRRdXLLkc19SOpBun5N
         OVXTD0jPRyPqWXeX5dX9rHGBe4P4+5A1vGqe5sWjrAf2QYbg8tYGgAUQa1ZjzHpqmfaO
         vHbxl5nIKtWEbLnAhlSRIc7u4LW5/FVEJiHquZM/zzSxmlNehZOYD5DUCDFSOJA47mLH
         96iQQfgS9ub4ZQBDZql5VnT583qXw99b1l0zePvnrRODBQNWCjQS3tT6O1jYkfVokXyK
         8NEpgaotuiFeNnIhGWrTbdWngyLIgyNyugNH44L3psHc0IIgqLU7uwJHVakxcoi/C6GF
         fQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCXwkm/7HnobHR/CtFoeWB4PjUV6gkCHLU8WLg6RXsRyimoo0jHsKiKfyPiTXSQ9iCeT60MUCrlTB5SWa7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBzraLA9BhPkBGsKRnynG3GpAzK0Au9PbAaf+jsf05Q1Yu0IY
	/LIVOCONJEz6LMR57G2vsdakX2fqeZmH3N1lAtdCAa2XoTFeqLSmqItm9CoAZObXPi/xUIFHm5I
	aRjWYZTQ=
X-Gm-Gg: ASbGnct69+s6PhMtFagV45T1xeygOGXawUIj/4nSK/iqiuw9g4aV5H+XdMYOxTsj5OH
	smK3oo4JSYzdOjpl8oDdDDqarExrVNO7igxK8X3ayEjsOz6CWnZvMiDarz9R8wvwzDTA85W5xOJ
	M02GZhlrHb/TiMV5uh87tMzk4D7c4Mok0Bdk7X2jMLy1gg1zJh9470iRciML5HeUCggNi7omYlh
	Qr2WgxH5b+Pi+50wM4YnSvEWaXVxz5EefF5/eHKDwraAgjjiVXwOKvHBsqBY8Jz4zv1VBTCtntB
	84nWAawd0pxUMyAJ0CqU1xdB24wP+0szpBOtCyFP+9mhY04XwCy/qsVxfBLqo7vNN6NinFV3xy0
	AeLrpQr6bHWMUtfrXxX9XpnqPzqJBl8vtROOj6xnIm6dP4URBJYhGg/CJx7zWlf8=
X-Google-Smtp-Source: AGHT+IEWE5njzkAVMh0iSC7VPEQmyUpucrPcJT/AcJg5bY23uL7H8GGcf4J5p6a5shSngpQ//r/sAg==
X-Received: by 2002:a05:600c:c162:b0:46e:49dd:525e with SMTP id 5b1f17b1804b1-46e612bc070mr25722595e9.21.1759326247407;
        Wed, 01 Oct 2025 06:44:07 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6199250bsm41317945e9.3.2025.10.01.06.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:44:06 -0700 (PDT)
Message-ID: <708a5bbd-2bad-4f94-8fd1-6bd10825ba71@linaro.org>
Date: Wed, 1 Oct 2025 14:44:06 +0100
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
 <3a731a9e-0621-42b6-b7fc-4b0fd9b7da6e@linaro.org>
 <20251001132815.GN7985@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251001132815.GN7985@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/10/2025 2:28 pm, Leo Yan wrote:
> On Wed, Oct 01, 2025 at 01:40:37PM +0100, James Clark wrote:
> 
> [...]
> 
>>>> @@ -103,6 +111,9 @@ static struct attribute *etm_config_formats_attr[] = {
>>>>    	&format_attr_configid.attr,
>>>>    	&format_attr_branch_broadcast.attr,
>>>>    	&format_attr_cc_threshold.attr,
>>>> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>>>> +	&format_attr_ts_level.attr,
>>>> +#endif
>>>
>>> By using .visible() callback for attrs, we can improve a bit code
>>> without spreading "#ifdef IS_ENABLED()" in this file. E.g.,
>>>
>>>      static umode_t format_attr_is_visible(struct kobject *kobj,
>>>                                      struct attribute *attr, int n)
>>>      {
>>>           struct device *dev = kobj_to_dev(kobj);
>>>
>>>           if (attr == &format_attr_ts_level.attr &&
>>> 	    !IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
>>>                   return 0;
>>>
>>>           return attr->mode;
>>>      }
>>>
>>> Otherwise, LGTM:
>>>
>>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>>
>>
>> Unfortunately that won't work because you'd have to always include
>> coresight-etm4x.h. This file is compiled for both arm32 and arm64 so it
>> would break the arm32 build.
>>
>> I could define the TTR_CFG_FLD_ts_level_* stuff somewhere else but then it
>> becomes messier than just doing the #ifdefs here.
> 
> ATTR_CFG_FLD_ts_level_* is only used in coresight-etm4x-core.c, it is not
> used in coresight-etm-perf.c. Thus, we don't need to include
> coresight-etm4x.h in coresight-etm-perf.c. Do I miss anything?

Yes, GEN_PMU_FORMAT_ATTR() uses them but it makes it hard to see.

> 
> A similiar case is the attr 'cc_threshold' is only used by ETMv4, it is
> exported always. It is not bad for me to always expose these attrs but
> in the are ignored in the ETMv3 driver - so we even don't need to
> bother adding .visible() callback.
> 

I disagree with always showing them. I think they should be hidden if 
they're not used, or at least return an error to avoid confusing users. 
It also wastes config bits if they're allocated but never used.

Either way, this was done because of the header mechanics which can only 
be avoided by adding more changes than just the #ifdefs. There are also 
already ETM4 #ifdefs in the file.

> Thanks,
> Leo


