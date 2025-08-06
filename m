Return-Path: <linux-kernel+bounces-757639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC8B1C496
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D6625E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6028B4F9;
	Wed,  6 Aug 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXhWhPTo"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA728A719
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478010; cv=none; b=BZL3nZTLA+tcTOmLMFpZpH1AK2gYcqBJ1UmbQH/BIlNsh+XQkDub6IHph6PBfM6O6WaoIgUUy6tTCToTiuzNxeLAZRGBKP5OiyzYcJMQ67FI8QgdZsX/uAadvXRSb6cZEJSAQ/+q80o66nQ+QSnjqNWLSzev4xX1y9PcNFMZ9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478010; c=relaxed/simple;
	bh=ztmA5grMhynCFB2kUGWvxLZcBQdunX1Q6gK/ADIuAQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP6H5+XEAYJRIH2KYFq5k4lCBFh2s8ypgmff0Q7Yqvn3yQL4NT6fiszuG7tQsL0/gfax9ALsp5J1YWmzp4eyuBEGngfxqWMWGgDzzSarnaZgBLP8t1PMV5ILNX435F6kotmHCt904hlJwysgBr3o0R/E4QQrajnjpeQx+OsXECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXhWhPTo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b780bdda21so4565756f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754478006; x=1755082806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCmVre5gjeM4nS/wqXusx4xVtaJFxkhLqF5sa87a9kc=;
        b=zXhWhPTonY0/LNpKu0zP/6GZrHtMMsNMHG2zeLcGcIRxxjfVIuRJUQHg2C2wC7+zz/
         jtBlY0fW7pYM276izuSRcz5uLs9p3adLSijYtdxJmUn+ArA4A/J/Hy4Q05Uq0fjgEQJp
         4LbtZdrXYBH+45VKWuvJV0mDSa+EX5YPG5Iyn5xZC/6lz4gaMHkPEVAAmfZR84AR51VY
         W37SJhdVfr6TbhijppYsTFmmJihvg5OOS75ZGi93HssHr8isI+ZwLajLPVplbhiL+dst
         BlsrL6iD2VrYBgUya7FCSohs63Bn3SiPmNA3s8xA1s58XXhjylGLly841ksn0NbvXyob
         MKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754478006; x=1755082806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCmVre5gjeM4nS/wqXusx4xVtaJFxkhLqF5sa87a9kc=;
        b=biFw+M6H855Su7QqCBAR/aROAVHE0NM3xOk8o51A3sQHHyAiPMzmdnFuWIIi4og22G
         DNUrCKo39grb6C6QQTAI08/9AmdU2AhXLXjHnvbHzjgP51a/p0wSZYCMHDrPv5t1Zd5O
         c7OBWP/Qkb1gJ+7q1QntHoQVDLJwgJxd0Ftd2A4s2sdB3R5lNksiLvxFaNPkg0ZBVWz4
         ksx3kchR+vFVk9AKIkW2FaLCH9Ena//2u1zDNhKra8eYzk5VcIZABYg/hacxN7ZhXhZo
         znCRJ+G3L5psah04HpDKnQFvUblsJf6HyPSWN/k1jmZIMhLTuJTQdG4V4GyIuABIW/PO
         XDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrXS7Sl01L6zB8GTOMGZsdLz8NL9Mwc9Af3lh6ReBS3bS1H0fQLLFdu3NMkgkxAxTbeMIIkTLGGueutOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzr3KC4X+l3/e5RBNSwZe8Ap8SEzl6chF3wqpdCpKPdDUK1fid
	jECuhjZgy8XAfLmtglDqWHk3Z8Q0yoiwVZNLzlr5VVg8Kg6wkK1D0LghKK+CarUdEMg=
X-Gm-Gg: ASbGncsF/fPM2bWJ8ywqmm4ljK91ve5KLGXYc4gwL+i8VF/3aaj6RweiaqbZF5dzuNN
	LDv8navHa/JK5Hndopga02OIozVIJv5goVUULh83A8vCvwzTVNrme2mM1V8pugcnleZ9vgIgDoH
	DHtWr1Gvk+8afPGqA/bisqvuu3EQuYuhv3x9TdC88Or+WnSUq6v96UFRvDh+3esu6KGBZ7XzgtR
	oaN6kduTm9P+l+JcgpJC6IR0E/bR1mdOCqVieTQlGg739VyiiXof0fwIFP3Oe4zPkylamMznl9g
	VLg688aoxmpryA+Bk2tkLLxWtYrmmmjjSLasmU/gtEgOiQhLVSD6z9GBhJm8CkeGHG6/4oLwW6z
	WEMYQcbVIlehmn81/sdpCY0DBmlQ=
X-Google-Smtp-Source: AGHT+IED1ObJfhfJTF9IANk5X4B6IPDP0k6oF3FpmB8DzDbBAJ47RdFvv8Mlx8ZmKpcul2JbAtAwiA==
X-Received: by 2002:a05:6000:2001:b0:3b7:8d70:dac5 with SMTP id ffacd0b85a97d-3b8f48de435mr1517659f8f.2.1754478006344;
        Wed, 06 Aug 2025 04:00:06 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e585430csm43379465e9.11.2025.08.06.04.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 04:00:05 -0700 (PDT)
Message-ID: <e08322f9-3bce-468f-b951-21eff63cde4d@linaro.org>
Date: Wed, 6 Aug 2025 12:00:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] coresight: tpda: fix the logic to setup the element
 size
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: tingwei.zhang@oss.qualcomm.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tao Zhang <quic_taozha@quicinc.com>, Mao Jinlong <quic_jinlmao@quicinc.com>
References: <20250806080931.14322-1-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250806080931.14322-1-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2025 9:09 am, Jie Gan wrote:
> Some TPDM devices support both CMB and DSB datasets, requiring
> the system to enable the port with both corresponding element sizes.
> 
> Currently, the logic treats tpdm_read_element_size as successful if
> the CMB element size is retrieved correctly, regardless of whether
> the DSB element size is obtained. This behavior causes issues
> when parsing data from TPDM devices that depend on both element sizes.
> 
> To address this, the function should explicitly fail if the DSB
> element size cannot be read correctly.
> 
> Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB element")
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 0633f04beb24..333b3cb23685 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>   	if (tpdm_data->dsb) {
>   		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>   				"qcom,dsb-element-bits", &drvdata->dsb_esize);
> +		if (rc)
> +			goto out;
>   	}
>   
>   	if (tpdm_data->cmb) {
> @@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>   				"qcom,cmb-element-bits", &drvdata->cmb_esize);
>   	}
>   
> +out:
>   	if (rc)
>   		dev_warn_once(&csdev->dev,
>   			"Failed to read TPDM Element size: %d\n", rc);

Reviewed-by: James Clark <james.clark@linaro.org>


