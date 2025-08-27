Return-Path: <linux-kernel+bounces-788003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EFB37EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C3036334B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0A343D96;
	Wed, 27 Aug 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS/yE1n+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D3343D62
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286489; cv=none; b=QPiuOAf16v+i0ubBuFhEHiIlDDn4PH82AhrKAeDrMRNCKuyf/tThxy2E9B5wnJORw75VSevUauRRdcHDsyc2TbtEqVKAKy82teQy3Te+b+dtjSf1iy4OpomtO44kGAiaPIyrNuScl6jJ4+4XzKL7blnTdOr5VxpjLIkehvqGhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286489; c=relaxed/simple;
	bh=UYHRh0nnf5/4PfZfTpjBoaA1YeifpOFb2r0eI6/SlwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUUvtXMETE0HC+U5phopHJt9fka8mRZQxfGlN4KjZGhvqnVGqlhdwpF5DajELGOxiK90c/+LSjLqXcFeCPdVjj1orK9CmPywXM6K5M7TijdhV5NGjTpaKM864zW6gn9fQ233DodfUwThsC9Gx+wc7Hgcbw1V4hXgOQlDoTogawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HS/yE1n+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c79f0a5c5fso2851386f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286486; x=1756891286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mker59khNl9LO6XVA193w6BS5zlp+w383B89UYOvyb4=;
        b=HS/yE1n+5NTaDm4mGxRBgJVsxsxzwDfQ15YEo/KJpQQekCMObkiT2JYX0vUhxePwF6
         Y1VeuV2OB7D90tOtN81Q1Q81HfBlmoY/mIYVRnkFTWWsu4yc3RAHE8yBq7B/ugSXFB+N
         lXznf0exYygNhTcLd8UMVO1SetzxZv9YKsRSNwRkwrCFnnGvtBD183f5DN8eMNeKKDiz
         yKb01C5d6mJdqT7V+lh+8gLqV3evMzhuAYp1WTlN6d24Qp9MvTcRX4jzX0ItvBAxm3Ke
         t/CW/CbKyqImbpeQegxvMDTyJ8cSKq7Or/MJQVL/Tdn+UF2J3F5fXqN3PzY5QWCBJrZY
         uXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286486; x=1756891286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mker59khNl9LO6XVA193w6BS5zlp+w383B89UYOvyb4=;
        b=fRJyeBkYHTv+h4pK4Z8MC+6AQsgAKHChgrvGpNLKKx6d68j9DtL5bYhhir4wrgkwbo
         uHjn0SftYwGVnFgvWU4JZSmUT+e0H5cnFWc3Wi2fFOPqkGusPd1vT1mSAm3MCb1R0TnC
         b59gQwOfSbtZT6fySHWtNjjCN9RRZUtX1EirmhWN22fSESMEs3O35K00XeHzm373sNht
         S6TmBfW61r/zue60qynoQtL40zbUisAVyLhyZaF2flJzOpn6DYOlseF2A/5Ua1b/GWc6
         GHzjrcpSKbREyA/AGjf3PrCt+n1hnx2dIRhdvMEp5pb9ygZo2KPUFbvo+GUGxWm1GCMW
         p1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUT21biu0yTmRvP6AYQEL6zZPsSYkXwKDmzArvzOM/o9eAxiu/+vmJligV0SCltAHmWOS1vo/zPAofmvk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFxC295TkQKdPKkQCsgzfEx3gvZ/mArifPVQNY1YYYkHkYk8V
	eD7KXGFUrHymHBHmsjWYLn+mvPR1i+jDoC4lvAImLMMj4lx4if2dE5hUrJ8Ahgp2Es0=
X-Gm-Gg: ASbGncvY7PsyPfNEq+2HBAfhaCLa3XIcISjDwjl09w/Fzc9AyWA4c+L+oldNhf5sjAI
	HdyEME/4ylh2mMHl1UWHVt3r8VlOChR704fulqw66KhDBfTDtGH/9wp4Rv3Xmlhpslxp7oW3xBY
	/5Y5RtQA55QSdwINd5jzv2zFO9dhdfTuGIn6KYDqAXFWpi/MlXi0EBVzOUa/rsO9fCnHhaiyKyE
	1LUwGcYGg1idro2zQ02k/hcZPq18hWu0KDb+5Ybz6PQTwH/IcJ3rw00d7tRgVejo6YELrxqhbFj
	YsBLiKW0AmKR/xaXdxXtyS1oc4VK2lvwy6oO68mkHA31oevIkklLU++UsUbfy9SH1sEzIQo4UXh
	s/ZTsUDdSg/HDEg+MEd26++HjGGU=
X-Google-Smtp-Source: AGHT+IFvRqEa1ogDaSXzE5145n6AsbEdzn4jkuxQuGsQWp+ChfJK8nOqGUjd3LT9Dxkf37baNqI9Dw==
X-Received: by 2002:a05:6000:26c8:b0:3c7:6348:4089 with SMTP id ffacd0b85a97d-3c7634846admr10821566f8f.11.1756286486239;
        Wed, 27 Aug 2025 02:21:26 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc7b699d5dsm2665466f8f.48.2025.08.27.02.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:21:25 -0700 (PDT)
Message-ID: <4ca657cf-1c8e-4d51-aba9-c894c32a23b3@linaro.org>
Date: Wed, 27 Aug 2025 10:21:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] coresight: tpda: add logic to configure TPDA_SYNCR
 register
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
 <20250827042042.6786-3-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250827042042.6786-3-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2025 5:20 am, Jie Gan wrote:
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
>   drivers/hwtracing/coresight/coresight-tpda.c | 7 +++++++
>   drivers/hwtracing/coresight/coresight-tpda.h | 6 ++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 647ab49a98d7..430f76c559f2 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -187,6 +187,13 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   	 */
>   	if (drvdata->trig_flag_ts)
>   		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
> +
> +	/* Program the counter value for TPDA_SYNCR */
> +	val = readl_relaxed(drvdata->base + TPDA_SYNCR);
> +	/* Clear the mode */
> +	val &= ~TPDA_SYNCR_MODE_CTRL;
> +	val |= FIELD_PREP(TPDA_SYNCR_COUNTER_MASK, TPDA_SYNCR_MAX_COUNTER_VAL);

Just use the mask directly if you want to set all the bits. This makes 
it seem like the MAX_COUNTER_VAL is something different.

val |= TPDA_SYNCR_COUNTER_MASK

> +	writel_relaxed(val, drvdata->base + TPDA_SYNCR);
>   }
>   
>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index 0be625fb52fd..8e1b66115ad1 100644
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
> @@ -27,6 +28,11 @@
>   #define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
>   /* Aggregator port DSB data set element size bit */
>   #define TPDA_Pn_CR_DSBSIZE		BIT(8)
> +/* TPDA_SYNCR mode control bit */
> +#define TPDA_SYNCR_MODE_CTRL		BIT(12)
> +/* TPDA_SYNCR counter mask */
> +#define TPDA_SYNCR_COUNTER_MASK		GENMASK(11, 0)
> +#define TPDA_SYNCR_MAX_COUNTER_VAL	(0xFFF)

No need to define a numeric value that's the same as the mask. It also 
opens the possibility of making a mistake.

>   
>   #define TPDA_MAX_INPORTS	32
>   


