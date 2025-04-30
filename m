Return-Path: <linux-kernel+bounces-627496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955FAA517F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842BF4E72E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02954261584;
	Wed, 30 Apr 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeVxmnMY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1B27718
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030060; cv=none; b=erwyw+TJ1iecc2/W/q+nAQExDMtwnJiJEVcu78+itvxavutW6ZYlD+BP2ZCyY6hTxLwwF9dbBR/G2kAqw3pDjp6RYrGf7wx6Y4GEX023Hyrk2h6INr4z+FV3xE/gwTLJqWs2hSgSO/7Wqc4MmwwFaVgOfA2wsB64SVgU7ygqYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030060; c=relaxed/simple;
	bh=p5KZ8GqZ4wBTxn2oporad1DCpVHvTfmZOGaZPaTB5Ws=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o5ITFUgkmm6Hq6tyHrHdmglqOUE3/hdKrFJtAh0WEmGo0hop69M1KSmBo5PXvCE+AsMSLF5fPt05snRUWcOS3ZU1kHuO66iUWlG8okIA0CIu8vfV+cfznZyzw6lCC+Cg+nZ8AatwtlALcUsGc1k9NYqA6ajZxk4CSTMzgJ/cEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oeVxmnMY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso53440645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746030056; x=1746634856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UX+8iIK6EjZzj5S4mIHEUg6V9ukFCG7XcJEeMNgIFRo=;
        b=oeVxmnMYHvMd27ay9SphLIDd5Otyn7YOnvxqhjIj0WUmaaC8W+h24VbKegDRYoykbd
         comdYm2wr7XqezTrsAndNUuowRWsepCzb7QfbobuLESRrc9pAoylj7z2xr1u0SQ7jXas
         D2ytPFnn3vGnPGWBcYlXBsnE7ovirV9595qBT3DTf8ZJF58V4Yn1qixxGtUid8M6aUyw
         Js7MFwU5H7et5DnAbaxEYfX26xjBEAwYeZhOifgDdvOWC2ZIGbrBIBhdn1ChmbrmTxPi
         pqgC80N996otnEAyIy894By4Zgv7IqeN4oX0eJK6TDFTCVi4hGQL6yDg+4x60kllCt2Z
         psiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030056; x=1746634856;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UX+8iIK6EjZzj5S4mIHEUg6V9ukFCG7XcJEeMNgIFRo=;
        b=Vrm/mv1PCBaBHoMGfpt+SCvpC9JDxDfvRGMWKOeSTbbVyDOoK+Gkg1l7iOufcF+Fa5
         pXB4w0bK+9JlLHmdFEmPMM7KHR3LoD30DJegDzIDrkXkZZMcrUIak+t7PhWoVK847lkM
         cIWmnAI9ecVaBlh/BsgLxGunkj6SbGQcz8IKajA5g8LPRTZxqWzrIirEb4s4LYJTUIko
         W77ooG2Mv5zjo3gdAlot43KvXwHLDmPcknQez1hXEi961V+OXad3Kdc28Rz/HYAhgW4+
         e4wGZ7WS5mJwmBAYI4xV/hEA3G+KrtSX/hAAk8jJX25JDnWjgROYGa8ip91yAANap6fL
         6pKw==
X-Forwarded-Encrypted: i=1; AJvYcCW4SIcGW86YEa0R/LAX9qxwNat+FM3gkUM+cWKsRgcQ58kUrLvBELHKBhqgLXnmu3pK5dYa8m6tuZhRbTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykjUoBLU+QJJ2HiTCfbJV5NOHCr48EjwB5GAiwCKlqvCLcmQV8
	OhzVwfcZLecAc7qi9UbyNS/oBIqsYh99N8vLtkTz7qOEdos1qLXbLTya2U16gN0=
X-Gm-Gg: ASbGncvRa5W3rXCilxZWFRPvMnGaQcFDXPCBtW/ishFaX2DZYuOMQbfe8gDUVcJRKZA
	A8sBm+KHHvhG0ZEE811+BUf1oJiJfpfG/O1usDLZW4vVl6bfTCOrG5c36H5MENPuHMeajPK4L0V
	Sml4vHh5HHD5DGzAFRXyqTKmG497iPCpmcMCM+SsA4zBmP/zlZ9NcBQi18zt6EJMv5Zr7Nm/bRa
	G9KoEx1PKFpGnKNv90N5VLIf30SaM1cK862565ApGaDI+SiAh9goq2z9IFK6eruH2Wfavzzxm27
	giqqR1oz+r4Kx0cEMR9cqBuugm7HYp5ZwdQMzrbmBmpu/MZ6g9R7vsJcEt+RKIbCP4joTYOzcZW
	TTFoPmjnzUObHatDOUw==
X-Google-Smtp-Source: AGHT+IGkhktqnrZwCap3P+FJextq03UIPWlIJ0756FqY4BhWfk+4IbTvkopwJYoNgJb8bZYdOs7IPg==
X-Received: by 2002:a05:600c:4ecc:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-441b2696f36mr22738335e9.33.1746030055840;
        Wed, 30 Apr 2025 09:20:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b3d6:213c:5c50:7785? ([2a01:e0a:3d9:2080:b3d6:213c:5c50:7785])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2bbf3aesm29136245e9.37.2025.04.30.09.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:20:55 -0700 (PDT)
Message-ID: <68a2cb9d-4f3b-4bfa-81c3-2d5c95a837f3@linaro.org>
Date: Wed, 30 Apr 2025 18:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT v6 1/5] drm/msm/adreno: Implement SMEM-based speed bin
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20250430-topic-smem_speedbin_respin-v6-0-954ff66061cf@oss.qualcomm.com>
 <20250430-topic-smem_speedbin_respin-v6-1-954ff66061cf@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250430-topic-smem_speedbin_respin-v6-1-954ff66061cf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/04/2025 13:34, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
> abstracted through SMEM, instead of being directly available in a fuse.
> 
> Add support for SMEM-based speed binning, which includes getting
> "feature code" and "product code" from said source and parsing them
> to form something that lets us match OPPs against.
> 
> Due to the product code being ignored in the context of Adreno on
> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 14 +++++-----
>   drivers/gpu/drm/msm/adreno/adreno_device.c |  2 ++
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 42 +++++++++++++++++++++++++++---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  7 ++++-
>   4 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 242d02d48c0cd0972bb96a960872b73384fe043b..0db57e4b7596b01c091ed82510cf14cf2a8e0d03 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2328,18 +2328,20 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
>   	return UINT_MAX;
>   }
>   
> -static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
> +static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
> +				 struct device *dev,
> +				 const struct adreno_info *info)
>   {
>   	u32 supp_hw;
>   	u32 speedbin;
>   	int ret;
>   
> -	ret = adreno_read_speedbin(dev, &speedbin);
> +	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
>   	/*
> -	 * -ENOENT means that the platform doesn't support speedbin which is
> -	 * fine
> +	 * -ENOENT/EOPNOTSUPP means that the platform doesn't support speedbin
> +	 * which is fine
>   	 */
> -	if (ret == -ENOENT) {
> +	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
>   		return 0;
>   	} else if (ret) {
>   		dev_err_probe(dev, ret,
> @@ -2495,7 +2497,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   
>   	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>   
> -	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
> +	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
>   	if (ret) {
>   		a6xx_llc_slices_destroy(a6xx_gpu);
>   		kfree(a6xx_gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 236b25c094cd5d462f4b6653de7b7910985cccb6..a8376574381abff90d4a56e86f3f05735027ca9f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -6,6 +6,8 @@
>    * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
>    */
>   
> +#include <linux/soc/qcom/socinfo.h>
> +
>   #include "adreno_gpu.h"
>   
>   bool hang_debug = false;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 26db1f4b5fb90930bdbd2f17682bf47e35870936..b0ec64e9a35591507f26e16b4ef60ec874dafe12 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -21,6 +21,9 @@
>   #include "msm_gem.h"
>   #include "msm_mmu.h"
>   
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
> +
>   static u64 address_space_size = 0;
>   MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
>   module_param(address_space_size, ullong, 0600);
> @@ -1090,9 +1093,40 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
>   			   adreno_ocmem->hdl);
>   }
>   
> -int adreno_read_speedbin(struct device *dev, u32 *speedbin)
> +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +			 struct device *dev, u32 *fuse)
>   {
> -	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
> +	int ret;
> +
> +	/*
> +	 * Try reading the speedbin via a nvmem cell first
> +	 * -ENOENT means "no nvmem-cells" and essentially means "old DT" or
> +	 * "nvmem fuse is irrelevant", simply assume it's fine.
> +	 */
> +	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", fuse);
> +	if (!ret)
> +		return 0;
> +	else if (ret != -ENOENT)
> +		return dev_err_probe(dev, ret, "Couldn't read the speed bin fuse value\n");
> +
> +#ifdef CONFIG_QCOM_SMEM
> +	u32 fcode;
> +
> +	/*
> +	 * Only check the feature code - the product code only matters for
> +	 * proto SoCs unavailable outside Qualcomm labs, as far as GPU bin
> +	 * matching is concerned.
> +	 *
> +	 * Ignore EOPNOTSUPP, as not all SoCs expose this info through SMEM.
> +	 */
> +	ret = qcom_smem_get_feature_code(&fcode);
> +	if (!ret)
> +		*fuse = ADRENO_SKU_ID(fcode);
> +	else if (ret != -EOPNOTSUPP)
> +		return dev_err_probe(dev, ret, "Couldn't get feature code from SMEM\n");
> +#endif
> +
> +	return ret;
>   }
>   
>   int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> @@ -1132,9 +1166,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   			devm_pm_opp_set_clkname(dev, "core");
>   	}
>   
> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
>   		speedbin = 0xffff;
> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> +	adreno_gpu->speedbin = speedbin;
>   
>   	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>   			ADRENO_CHIPID_ARGS(config->chip_id));
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 92caba3584da0400b44a903e465814af165d40a3..3946b9e992b9a8e2fd81f3e03354f9f83717b270 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -80,6 +80,10 @@ struct adreno_reglist {
>   
>   struct adreno_speedbin {
>   	uint16_t fuse;
> +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */

This should be SM8550

> +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
> +#define ADRENO_SKU_ID(fcode)	(fcode)
> +
>   	uint16_t speedbin;
>   };
>   
> @@ -634,7 +638,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
>   			 struct adreno_smmu_fault_info *info, const char *block,
>   			 u32 scratch[4]);
>   
> -int adreno_read_speedbin(struct device *dev, u32 *speedbin);
> +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +			 struct device *dev, u32 *speedbin);
>   
>   /*
>    * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
> 


