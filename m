Return-Path: <linux-kernel+bounces-787976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B319EB37E53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958B57A49D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9AE34166B;
	Wed, 27 Aug 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLUfNDYG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96A2F0673
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285580; cv=none; b=qum2bjpBgfFMcuLcRjPXwub5vmD9+A42Xb2scxIwXQwwvri/E20998SAL1CAyfOZ06+LNd6GsNnf9yncOrUL3SU1Dj40tn8Kn218EThXLsdG5YKFznALkcbHY7X2IDv2q1KHm13ms2m/UVksstzWbgnNItdiinwMlt+OMcWY1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285580; c=relaxed/simple;
	bh=WKRUk+IXvuBct3+0Jo+6dMV1t8ega/wFwo0opMB68PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxSCgsI7A3RhY5V13Amrw/yngOB2MCotOYm0sFQCqpfzQv0vDUi1MD3/GsfbJ08hrvrGiiAE0tCtOTNtsrzDksBv8aB6p45TrFyDNgMUhK7poHR2fHx7aHIa2jF+2mSOTXOO9BMGmafISaw1mscMKzMCgL6DUihJiZIy8SBxJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLUfNDYG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b4d892175so33074745e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756285576; x=1756890376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYe7x0kn1tSmo2SrgkQnTv/0D7u1Q2Db+szIg3dqsbA=;
        b=PLUfNDYGY+4ZufkwdA3gi6zJHudNy4zZxkMTUF1Faw8B0kyh1bQNVXS2ehntdPKkp6
         GJj5mXu3s8PCtE65GQy3VHZQaHQgPW9bePwRSZQyILF6eyEJrkgyRHUvZ0jJG2vA6ysn
         Cnc0UOo9i1NqUu3J7yyhsrjEDbzDKiv0HUK1ZeMYmjbAj2Yvi+W2ehTydlMX4DRzXhU2
         WbxivcXszhZQczP8te5T3sfYOkzCDHAg6Ma1uwWyqeBrw9upSelgTYFVY5IJ0NFNRmKG
         3YwUTE/weFCUrL6DbnTUnemL0gG1kcyF07VAHHf+7EXIVWGR7Ot6NErILMMLNppVSBfk
         zNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756285576; x=1756890376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYe7x0kn1tSmo2SrgkQnTv/0D7u1Q2Db+szIg3dqsbA=;
        b=KoX/C0GqrL4fIPV3rl+IlZxceOQ1lM2+hB0sDq7hGkgYrkkTI0oA7uhEnQvvs8GFqN
         L70EPj19+NP7Nt+PxDl9UIshtcVy2mwYM+ospj3bFKnXnZEsvCuv+f/lE+2DqJbMbYQh
         VgkFujFj+KBu8PwP/kaHB2Tkum2uD7TYB/x9E0c+1pNrXigMYElegxKgFia7i0MUa6n+
         rVj+GPN42tpeDaZgdBWn+nOZ/8WgXXl8+TFARZaa4XApNJdAfbNUoFFf6IcaC4XwOy5m
         T3Xs9DoixQujR3zaPYvJ7jnNFZmd0nnb5QjS9l7Vyw1Q8OAIlPOPjtyE1RzTlrL7EyAz
         z6GA==
X-Forwarded-Encrypted: i=1; AJvYcCXm++AdHub53Vp2+2LtZzHap0HfiOmLIWAvZr+iWjUt5tLFoo6nVO8L2vFN+G/L9nPucNViR3O8EwlLIyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz705NpEy/XlfXdVXH+Nrs0htRfG8jkx+YBYwCD99nPw8roCpFd
	chkhPnHNf668rAO+BMELZ/lShOySPj7kudVNavgProoADHkcdYOHA7UBNOeLb5xrlQk=
X-Gm-Gg: ASbGncv4zG4cAiOoTONNyAvPmB01oL5CkdioyGfDLAplWXEPsxkWRp8tthOmr5oHyQc
	oPu6vjGWhGy+EJkGVottf2YrUSPxIxSCNmltwleqaHHeDHdYxQto+1qERsudFNEdBYkHYV5swgC
	6PHj8gSbrt8VIMVIcgzqOhPHVdWeTZjqkuy7vTjge6TieOHl6+5xsOtJ2bOoQ5NAsOVbOR7z3dS
	AkBh1F+3aDkbF7+JcNLjhYl/h7sQp/49ShqjvIKaIaLpolAntgwSAZk1laD9EQOQExp3WnIgvl9
	fWCW2D+gufa4YL/ggcj6Et7sUIQ9xwdqgirG6Vq4iaoMpG3QTqyalLtQptTFDQNZisr+l0IVyBV
	3Gobdh1asA5Dy4GYGWp2Ym1jfaIQ=
X-Google-Smtp-Source: AGHT+IFofqVkCw866gGpjEjqIIBWlxxrvKIjyyYVRgAv7SZZNZ6pQU8mFL+ekFwhuNKCFcgDAFANOQ==
X-Received: by 2002:a05:600c:630c:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45b517cfe7dmr144985015e9.20.1756285576068;
        Wed, 27 Aug 2025 02:06:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f31b02asm21662625e9.21.2025.08.27.02.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:06:15 -0700 (PDT)
Message-ID: <5acf3562-e69a-49b0-8cb6-9e57c5ad4368@linaro.org>
Date: Wed, 27 Aug 2025 10:06:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] coresight: tpda: add sysfs nodes for tpda
 cross-trigger configuration
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
 <20250827042042.6786-2-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250827042042.6786-2-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2025 5:20 am, Jie Gan wrote:
> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
> 
> Introduce sysfs nodes to configure cross-trigger parameters for TPDA.
> These registers define the characteristics of cross-trigger packets,
> including generation frequency and flag values.
> 
> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpda  |  43 ++++
>   drivers/hwtracing/coresight/coresight-tpda.c  | 227 ++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  27 ++-
>   3 files changed, 296 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> new file mode 100644
> index 000000000000..fb651aebeb31
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> @@ -0,0 +1,43 @@
> +What:		/sys/bus/coresight/devices/<tpda-name>/trig_async_enable
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Enable/disable cross trigger synchronization sequence interface.
> +
> +What:		/sys/bus/coresight/devices/<tpda-name>/trig_flag_ts_enable
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Enable/disable cross trigger FLAG packet request interface.
> +
> +What:		/sys/bus/coresight/devices/<tpda-name>/trig_freq_enable
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Enable/disable cross trigger FREQ packet request interface.
> +
> +What:		/sys/bus/coresight/devices/<tpda-name>/freq_ts_enable
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Enable/disable the timestamp for all FREQ packets.
> +
> +What:		/sys/bus/coresight/devices/<tpda-name>/global_flush_req
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Set global (all ports) flush request bit. The bit remains set until a
> +		global flush request sequence completes.
> +
> +What:		/sys/bus/coresight/devices/<tpda-name>/cmbchan_mode
> +Date:		August 2025
> +KernelVersion:	6.17
> +Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
> +Description:
> +		(RW) Configure the CMB/MCMB channel mode for all enabled ports.
> +		Value 0 means raw channel mapping mode. Value 1 means channel pair marking mode.
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 4e93fa5bace4..647ab49a98d7 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -156,9 +156,37 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   	u32 val;
>   
>   	val = readl_relaxed(drvdata->base + TPDA_CR);
> +	val &= ~TPDA_CR_MID;
>   	val &= ~TPDA_CR_ATID;
>   	val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
> +	if (drvdata->trig_async)
> +		val |= TPDA_CR_SRIE;
> +	else
> +		val &= ~TPDA_CR_SRIE;
> +	if (drvdata->trig_flag_ts)
> +		val |= TPDA_CR_FLRIE;
> +	else
> +		val &= ~TPDA_CR_FLRIE;
> +	if (drvdata->trig_freq)
> +		val |= TPDA_CR_FRIE;
> +	else
> +		val &= ~TPDA_CR_FRIE;
> +	if (drvdata->freq_ts)
> +		val |= TPDA_CR_FREQTS;
> +	else
> +		val &= ~TPDA_CR_FREQTS;
> +	if (drvdata->cmbchan_mode)
> +		val |= TPDA_CR_CMBCHANMODE;
> +	else
> +		val &= ~TPDA_CR_CMBCHANMODE;
>   	writel_relaxed(val, drvdata->base + TPDA_CR);
> +
> +	/*
> +	 * If FLRIE bit is set, set the master and channel
> +	 * id as zero
> +	 */
> +	if (drvdata->trig_flag_ts)
> +		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
>   }
>   
>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
> @@ -274,6 +302,203 @@ static const struct coresight_ops tpda_cs_ops = {
>   	.link_ops	= &tpda_link_ops,
>   };
>   
> +static ssize_t trig_async_enable_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_async);
> +}
> +
> +static ssize_t trig_async_enable_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t size)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	drvdata->trig_async = !!val;
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(trig_async_enable);
> +
> +static ssize_t trig_flag_ts_enable_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_flag_ts);
> +}
> +
> +static ssize_t trig_flag_ts_enable_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t size)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	drvdata->trig_flag_ts = !!val;
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(trig_flag_ts_enable);
> +
> +static ssize_t trig_freq_enable_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_freq);
> +}
> +
> +static ssize_t trig_freq_enable_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	drvdata->trig_freq = !!val;
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(trig_freq_enable);
> +
> +static ssize_t freq_ts_enable_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->freq_ts);
> +}
> +
> +static ssize_t freq_ts_enable_store(struct device *dev,
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
> +	guard(spinlock)(&drvdata->spinlock);
> +	drvdata->freq_ts = !!val;
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(freq_ts_enable);
> +
> +static ssize_t global_flush_req_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!drvdata->csdev->refcnt)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	CS_UNLOCK(drvdata->base);
> +	val = readl_relaxed(drvdata->base + TPDA_CR);
> +	CS_LOCK(drvdata->base);
> +
> +	return sysfs_emit(buf, "%lx\n", val);

I know in practice it's probably only either 0 or 1, but this should 
either be decimal or have the 0x prefix otherwise it looks like a mistake.

> +}
> +
> +static ssize_t global_flush_req_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
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
> +	guard(spinlock)(&drvdata->spinlock);
> +	CS_UNLOCK(drvdata->base);
> +	val = readl_relaxed(drvdata->base + TPDA_CR);
> +	val |= BIT(0);

If you only set bit 0 do you only want to show bit 0 in 
global_flush_req_show() above? The sysfs files should be divided up by 
function rather than dumping the whole register, otherwise tools need 
their own copy of the fields to interperet them.



