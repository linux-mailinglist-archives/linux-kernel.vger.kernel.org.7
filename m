Return-Path: <linux-kernel+bounces-787996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1CB37E92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D90C18994F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F94343D80;
	Wed, 27 Aug 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6NvnX7f"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E2343D63
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286251; cv=none; b=ZIyfsdZXWfM4NHjhAgvt7tzhb2cgOD/7JdCoz5RvFo4PrJjAo9552U2iP5byCyB+5d9UPCwdUWj46E60i2QbOxYqJSVgFjVYwQZqNUcWDfRBRrqxMORhFFh0hFYl6Q+yXh5QGEGmY3N3cpMBcMS2diUY0OHYwCnu2+SiMtDO6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286251; c=relaxed/simple;
	bh=3TDravvIGkQGSnUlWMkvFFKCrY6S76fdgudXC4G2nrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC2F/dV2T34FMOrYXTGu5T7M/+mptVsVDSg9Ten5nBwnCVfBCIl+H/dho4BwjzxdJBXmXiW7NOgM4iNLhysMGY8gFl3ZrtT7uPjz5oBN0f4cD0k8k2Ml4N+WnES9/XbQ/4Yc8NmAqdU32fB7NlIygncRqfeI+c2bMeZAOT2kMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D6NvnX7f; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso3337930f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286248; x=1756891048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LoLKtox6RZvVwzEkSmrYfJeFK5b2yBrCHAYLgeBH+8=;
        b=D6NvnX7fRQcHg5dTKHK2eBBYiYnvIwWmkH6IRDnSoQi28OjhGiECZ8i7XnbT/O1CTt
         dfiyeBR3YpeSkVh3HqCzWqGSifzuq4qHHyBNAsscjFrx+Y6YQC+zOuFRRjv01eAKmZ83
         XwCwYE9BzN6DT30httDOPPb43SV0IC+YN/luAMdsfkn7h4NDVehP3ecbFffQaz/jm4hY
         LQRhSfa7xBakf49+XdGygRc4gwWoOCLJy5xHNFpUp84rhxpJxCJRew7AS/80C4NNiJZ6
         a53uFYn5v5gqbDRq49C3ZsU5Bf6xi/cxTbp692PGVkrV5VN8ut3qQBIUuLCar7usx0HK
         YmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286248; x=1756891048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LoLKtox6RZvVwzEkSmrYfJeFK5b2yBrCHAYLgeBH+8=;
        b=M3Q/xPp3IyXbxcvVxaoOYxTZM4SwpIbRzpAo+3D7ZFwkXHkZp3oUKCmlSptly1PM2j
         tX+ecsLhNfIMhGx13NO/01vJi8kP58Qg6EJ/m4U0BXHsB6VC7tccQhx7BgFLcNZ5QqoC
         nriWZa2380UtiL43NhFjRF5GFvCyCWOiPaXqgpQnx6rEszOgqUhmYjMNto0RhR/28AhN
         DEL8OBLcesaAIBEwXQsvnzbn28zKhgkCJwnGUe85pETPqUxtypRzjw3NJ91H7CC4vgw0
         ztyxJJJ45Sw8gee1FMcRFq2sw+zg5qolX4a3MCA10xc9tOQk24el95GsfGquYkEtMkCb
         +Oiw==
X-Forwarded-Encrypted: i=1; AJvYcCVh8eow+UlA/4DuhLB4GFenbofrcz87GyDLjl+Y5zZ/+3y6xDOddspDgUHf8K00pHmrq5p5DgcJhwo08Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhesffnL4OmtsID2uD3ZgjRQDMISfhBVUcFpzfyggrllIWJk/B
	vVaQ5wHCKLXw8HNZyKUkHrcQ9pMFo05K8Mpq7XqAT3QZHMczmohNz8ULwhMitw9saw0=
X-Gm-Gg: ASbGnct04PI4wEXWt6wWaQOxUAD6BjXm+JSmlOPP2bCyL++72AfU0VE7m7lTw8Y+HXg
	HEIrqu3DMn6j6QO/Ad5q+Ax6Lf6Jh99QVzbnL2r3HPiYQL9iZAp3W2H7JqRwUdvaC34I9glPSc9
	TX6+IyYcRGr8R6c4aWATioSVWwetYOGrX20+AxrKFNQqrlMlSB6kwUJk6/OMx77zskxqNGDcDRt
	rlB6HsXkrRL8ew1C8toe3jMPwk5xMmm2GdMPdOxw4s6CBUfwvogvIjcv0OgkhSVgWXTDRCQccfA
	NCNauiuWry/I5p7Hy9NiqZvWe7aRBPNUJV/yYN3fnbUjZGDrqUdCVWWxjzWqO/9t45E4dKNiTmT
	gah4WsiTY8IXaAuUVXJbMxq1wt2/xFix0X+tCEQj77p9MByjD
X-Google-Smtp-Source: AGHT+IEn2+Mqlva4eTiz/U9+4k0MFWsfnMZ4oB+8ctPeoze1Xi/Byz7VnuLxX/51r0/UZh1J91oxOg==
X-Received: by 2002:a05:6000:200f:b0:3c9:5df6:de3f with SMTP id ffacd0b85a97d-3c95df6e14fmr8753713f8f.24.1756286247700;
        Wed, 27 Aug 2025 02:17:27 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc18f762b1sm3948817f8f.65.2025.08.27.02.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:17:27 -0700 (PDT)
Message-ID: <b1f79a26-97e1-40f4-b076-51d5c2abe736@linaro.org>
Date: Wed, 27 Aug 2025 10:17:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] coresight: tpda: add sysfs node to flush specific
 port
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
 <20250827042042.6786-4-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250827042042.6786-4-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2025 5:20 am, Jie Gan wrote:
> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
> 
> Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
> for port i, forcing the data to synchronize and be transmitted to the
> sink device.
> 
> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpda  |  7 ++++
>   drivers/hwtracing/coresight/coresight-tpda.c  | 42 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  2 +
>   3 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> index fb651aebeb31..2cf2dcfc13c8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> @@ -41,3 +41,10 @@ Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qu
>   Description:
>   		(RW) Configure the CMB/MCMB channel mode for all enabled ports.
>   		Value 0 means raw channel mapping mode. Value 1 means channel pair marking mode.
> +
> +What:		/sys/bus/coresight/devices/<tpda-name>/port_flush_req
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Configure the bit i to requests a flush operation of port i on the TPDA.
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 430f76c559f2..8b1fe128881d 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -487,6 +487,47 @@ static ssize_t cmbchan_mode_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(cmbchan_mode);
>   
> +static ssize_t port_flush_req_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!drvdata->csdev->refcnt)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	CS_UNLOCK(drvdata->base);
> +	val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
> +	CS_LOCK(drvdata->base);
> +	return sysfs_emit(buf, "%lx\n", val);

Still missing the 0x prefix

> +}
> +
> +static ssize_t port_flush_req_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf,
> +				    size_t size)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	if (!drvdata->csdev->refcnt || !val)
> +		return -EINVAL;
> +
> +	val |= FIELD_PREP(TPDA_MAX_INPORTS_MASK, val);

Using FIELD_PREP() now that it's the full width of the register makes 
less sense. Especially when there is no corresponding FIELD_FIT() check, 
  which is fine because everything always fits. But if you didn't know 
the mask was the full width you'd wonder if the check is missing.

I would just write val directly to TPDA_FLUSH_CR so it's simpler.

It should also have been val = FIELD_PREP(...)

> +	guard(spinlock)(&drvdata->spinlock);
> +	CS_UNLOCK(drvdata->base);
> +	writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
> +	CS_LOCK(drvdata->base);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(port_flush_req);
> +
>   static struct attribute *tpda_attrs[] = {
>   	&dev_attr_trig_async_enable.attr,
>   	&dev_attr_trig_flag_ts_enable.attr,
> @@ -494,6 +535,7 @@ static struct attribute *tpda_attrs[] = {
>   	&dev_attr_freq_ts_enable.attr,
>   	&dev_attr_global_flush_req.attr,
>   	&dev_attr_cmbchan_mode.attr,
> +	&dev_attr_port_flush_req.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index 8e1b66115ad1..56d3ad293e46 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -10,6 +10,7 @@
>   #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
>   #define TPDA_FPID_CR		(0x084)
>   #define TPDA_SYNCR		(0x08C)
> +#define TPDA_FLUSH_CR		(0x090)
>   
>   /* Cross trigger FREQ packets timestamp bit */
>   #define TPDA_CR_FREQTS		BIT(2)
> @@ -35,6 +36,7 @@
>   #define TPDA_SYNCR_MAX_COUNTER_VAL	(0xFFF)
>   
>   #define TPDA_MAX_INPORTS	32
> +#define TPDA_MAX_INPORTS_MASK	GENMASK(31, 0)
>   
>   /* Bits 6 ~ 12 is for atid value */
>   #define TPDA_CR_ATID		GENMASK(12, 6)


