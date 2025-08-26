Return-Path: <linux-kernel+bounces-786347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9529B358B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24F53A5977
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05102307488;
	Tue, 26 Aug 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoXLE4LR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95E2F9996
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200012; cv=none; b=SuQCEpHbddLWhLwEo67kP5MVTa++3/q6o6YPOF6k4ECc/ySQauEHXXXU8NBigcMWZj8NhO6msor8dLqby8LZlzKz/OS5jtUliWJwHj01IbWNwX2fvN02rpWJEQ6FOLr/u2QI1b7Wfj65qxsYIoqIZTrHnMjWiQe2VKsQbvmrLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200012; c=relaxed/simple;
	bh=ZO1IgAuwBt52NoHD+ilRGM6Mth1RH65xMpJ/BN9e9qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkyfUSINJKFGOsbolepUx4rnUThQpAcPleIJoX2dfsMn7Snht/PQv4C5M/9ivkRad9mGfly/NHUosvEdzD3mlrusAfWyUXGl7zs1xsmlkJLT5sNs88MYQL6oa+bcQUzeBLl07F3UPk27x4BaqTF4rGIYTG1/FLk4HRVyZqkFrj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FoXLE4LR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so33309845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756200008; x=1756804808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaOTCniziyeazJJYkYE2FSNDiQRbUyarefsu1PbqX/E=;
        b=FoXLE4LRMJXihDnfdpc3QiHZQYE5qwyxGlTC1lwkW8NcQ/Pctb80Vy01Ba8ZPYVM3q
         0i7LN1f+MxPpzuxcoR/eDdUqS19205GImLB9Mnv34KXBvvcV0Xr2dNFo/a0GgR1zr1Ve
         mzaeettoJFaSSIEF7u9ZernabZ1qCX5FwFiYu12idMXSwioa58CpwwR1ri0CArds2bK0
         Dgdxq3c/XOyCtXBHM01OkWSKCdC31l7n0T9H4AWTYreE9STeoSbVuLIKdxR46qBw4pzT
         OZnvkwfa17YJLFPdVQ7i3boEs8qddTaaorwn5FQDGTy7GJAxvSCbxgMDTKpgwITrbHgU
         Q7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200008; x=1756804808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaOTCniziyeazJJYkYE2FSNDiQRbUyarefsu1PbqX/E=;
        b=TsDthBjgyQbRDHbhWeAQoXGihdsF2xZuNmqPabwDNvlnc+Igfw/AUGsDFcsNsooTnm
         dV+sG3f1VGY7U+tF8sbEXCSErqkd+bBQmCfOfrnT1XbWP9X6D8bQIQAHU8RrYw9H1gGa
         2qB5JEGSaQoRXt4wbbrWETyvEEB5et8q99MIubeycyqDAg6HRQekZAhebltT8m46ltis
         1whlNPkdmzeg5yNaE+r+c/bIK3TqtT/vPnpWalpBrhg6SWYEWGlhNZzmuTdaT7elM1av
         etJMxwvd9Z3WqA41Ab4CQ0CVjg9YXOb58+0+8YhUk1xSzWcgtvD44jt3rKMGlvZTkOfb
         M3ag==
X-Forwarded-Encrypted: i=1; AJvYcCWVwQVCtIFrQvrC3gpeNhE9Pk99lAcIWZwg4cXi+M+b5k4lXFgbJfRLo6Si+7BzBdHVzl3DdjiQqHLYKhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9c3qyP8AKu77kZKwoOdFEAhaO1qX1KDVq2du8dmqdpE46B9xn
	DGNKZUyJAf43JarShRSXNFUKtFeoEjxnKl6ilGxZm8a4/QbBYOYi47vl+4RIykrEGoBHm+kCSjj
	7lYRp
X-Gm-Gg: ASbGncugOiadtd1KBs3sUN6vLYbKBMqXCSx6g9pejDKN7xK0mKxoc/M3VSIgOARvltq
	06horU7FtZq4IBx6UU/gFcFIWxeDT7N3SmCC1KFrqtR7VpDsw7f6WSlw5ui1BQ/VZySaIaPk4UR
	pzE0thwSv2GoeULl2SrwIMBis8/Qwrg2sJwLOFUWWUuEj12aDkdKiexBYXoBE/aG3y5GfsB4yw7
	KnSxNGF259PA13j8pDKl0ny8CyGac9a7nyRlQicsJqRIHS2OqFTJMnRzm1KZ+lhYrAtZldSksTT
	zB9XnvazHC0lbHbu6x38sqFNvMoXh1ToSRhJeoEVKOkJMwKj/ewf0mj/oOwC8hu5gW0b1WuQRi2
	JP70FW2HtVS1YX1FNMsgTC0QA5E92V0ZCmOsl7A==
X-Google-Smtp-Source: AGHT+IG3O4nYqPPZOTd55R1CACz78Gxy+VGwYkBeN2scTg38UYjMhu5WNHrdDEH4ezcSuJRTDw+VSw==
X-Received: by 2002:a05:6000:2c04:b0:3c9:469d:c092 with SMTP id ffacd0b85a97d-3c9469dc2b7mr5298437f8f.16.1756200008054;
        Tue, 26 Aug 2025 02:20:08 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211b19sm15708101f8f.39.2025.08.26.02.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:20:07 -0700 (PDT)
Message-ID: <66cfff9c-e0ec-4171-b62d-80d6139c42f3@linaro.org>
Date: Tue, 26 Aug 2025 10:20:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] coresight: tpda: add function to configure
 TPDA_SYNCR register
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-3-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250826070150.5603-3-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/08/2025 8:01 am, Jie Gan wrote:
> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
> 
> The TPDA_SYNCR register defines the frequency at which TPDA generates
> ASYNC packets, enabling userspace tools to accurately parse each valid
> packet.
> 
> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 15 +++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h |  1 +
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index cc254d53b8ec..9e623732d1e7 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -189,6 +189,18 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
>   }
>   
> +static void tpda_enable_post_port(struct tpda_drvdata *drvdata)
> +{
> +	uint32_t val;

Minor nit: this is inconsistent with u32 used elsewhere in this file.

> +
> +	val = readl_relaxed(drvdata->base + TPDA_SYNCR);
> +	/* Clear the mode */
> +	val = val & ~TPDA_MODE_CTRL;

&=

> +	/* Program the counter value */
> +	val = val | 0xFFF;

|=

Defining a field would be a bit nicer here. Like:

val |= FIELD_PREP(TPDA_SYNCR_COUNTER, UINT32_MAX);

Assuming you wanted to set all bits, and 0xFFF isn't some specific value.

> +	writel_relaxed(val, drvdata->base + TPDA_SYNCR);
> +}
> +
>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   {
>   	u32 val;
> @@ -227,6 +239,9 @@ static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>   		tpda_enable_pre_port(drvdata);
>   
>   	ret = tpda_enable_port(drvdata, port);
> +	if (!drvdata->csdev->refcnt)
> +		tpda_enable_post_port(drvdata);

Any reason this can't be done on tpda_enable_pre_port()? It has the same 
logic where it's only done once for the first port.

If it can't be done there you should add a comment saying why it must be 
done after enabling the first port.

> +
>   	CS_LOCK(drvdata->base);
>   
>   	return ret;
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index b651372d4c88..00d146960d81 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -9,6 +9,7 @@
>   #define TPDA_CR			(0x000)
>   #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
>   #define TPDA_FPID_CR		(0x084)
> +#define TPDA_SYNCR		(0x08C)
>   
>   /* Cross trigger FREQ packets timestamp bit */
>   #define TPDA_CR_FREQTS		BIT(2)


