Return-Path: <linux-kernel+bounces-767581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511DB25648
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FC93B0CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B52F290D;
	Wed, 13 Aug 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkGkQIJs"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D82F39C1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122893; cv=none; b=Fq1slksYZZlz8A7Khqb7B0dGwmqwk3I8epXhKmhlQ/MRS7cVbffiK8oPAn5y/DJl3HTwMaYJI+JGRdlv3g8BW4pf4KYSpaN7TcWroyQJGNtytNDYLTd59+PJmQUNo2h8MLkN6SUgpR7/YWfEHUPsuqHsVPVvANp5ee55dk24Rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122893; c=relaxed/simple;
	bh=cOzIQCDUe0+XfgNsEEQjPQSKEdXLsnLnzVTF/W0TXu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwJc6POO4d+GHPddaLJ8qjhNtY48Rx2jwXSt2jB0lqE2Rlszat/O+GjvKwQ7IxOl8uA+kEQ6VE0teitjjLZ1KHl6A/hPpmJU4SN5blndqyMoSoh+9SaKpgIbYAhrYMCZgJ7MYgCc05PCskA+b102S8+cg5sMCNJuTRvYRLDug7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkGkQIJs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so1667025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755122890; x=1755727690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGvnQRJXrX042hXZ7hl3cbdusCF8NvFI3WtV50e38aE=;
        b=vkGkQIJsWqSPiZZC6YLLjsbxXjlOyAsYyT1ZQ7cVABKoyDzXDJATUU26BFiP/IFdlG
         n/ltDr/oNkdsdLx1OpcXUyFHTSVjiK2Bpgv6fYUMDCV2ATxCu6OULjgxjlr7/6wIdNCN
         nc43n8WuYPTHQfNHEkxXtTVKkDYNzgJWNs6DWBOOZX8JKnDMRdUK58wYHG4U6Jcet+zX
         24Y2fyhjXvw0v3Lp6YDHvj/9TxjdkcQugSeGmFLYUibP4ikbGw34LAxko/cPLaWc3I/7
         TpqYpDnvg3b5ABUGKjkABLOnVe3PLXmrRtKegPKzuENd3pQqinXvyelIl6yeutvEmjDd
         fTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122890; x=1755727690;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGvnQRJXrX042hXZ7hl3cbdusCF8NvFI3WtV50e38aE=;
        b=MEdFkNaKMtUxU3lKGH/m9efgWC1Qda/4vCttnTZOjj7QKOFoYI80q/+FwWaAkgYUNY
         ryLYfbuxKo9zfAzeZ6/d7/J8kTSeEywDL7YS1ZXwKqiZVi/UDgLfYdg0gmbcgMEbR92N
         g0pFX1Uw5yNfddDjB6yEi3d4X6ANlRfakgn/ga3HAIdVhxNXc2dFwUqDtkQRaK7CiF1l
         /YSJQuzfJOaEa74OSZY/BjFapTwbFaj50LrECmfIc8XtmVo199XSST8ZTWxWi19qVc5T
         /PklfUGNAAfd+KhCDNH3OWuuAm3BPzEt4UPeKTYAuSp/jZrzqsAvply5Kv+gtPjrbSuW
         Tisw==
X-Forwarded-Encrypted: i=1; AJvYcCUV3MIueET/pXxWb4iuaINcIA4xbbGTDqSC7kReGiebSKXtJ+7Yaq/DoXXFU4qhq3B0jRM0Q1kUq1dxnFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyN0PI2dCBzn5i/QmLOegOlWDbSiEefHJU1C/m2XNCp3lm0HgE
	0lvpLiviF13a5uvmSbuQ3tAQ1G5VhbDS6PBND9LFuJ5pKSq0/1dXyhyewaq4jTdTxG8=
X-Gm-Gg: ASbGnctPeUHACVThLQLlqzFC8+bA5ssn7EbPYBmTAlTfIx1utinwwJt/ril41YZrZGI
	5nGHUZ47ymuaB8WgYOfkA7mr+J3B5DO1yG+R/J3VSWvZmvvOEuqzf4Ry7KqyHraaun4ssq0x3f3
	vBPZom7XJE58+mn8vwtiYHpKx+1gDarLtlDXsC2u2HVdP1ptr1SbClnCQ+cBobEZ+Th9NturgyI
	Vq6Y1gjOQlLGliWdOWRiIKwWfMu0i0o0dIapazoHiaem86Ow735oDgl9Ze6LF67wh+y1Nv41SzZ
	2MF72u3MoGLxMgEfJL92N3+giHLhzMajUBF8nXaQ1FiadZ8v1HcRgIZ7viiuVyTFIkk4z8FCTJd
	5i13UB0tOPlAHHsnExiiaCUgvqXvXaLipyWUPpO8MZE8i3ptpn659myRgHIac9DTV
X-Google-Smtp-Source: AGHT+IGAYNm27ZVowf7WspE+IzHrbkyB12Y7kx7nFsTZoij4WqyQxBHxHb7jlAy5R2YCjfPtWok4gg==
X-Received: by 2002:a05:600c:3b93:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45a1b605070mr2758535e9.2.1755122889639;
        Wed, 13 Aug 2025 15:08:09 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm50861002f8f.40.2025.08.13.15.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:08:09 -0700 (PDT)
Message-ID: <5dafef36-72bc-4958-9348-57d9ff4a10d1@linaro.org>
Date: Wed, 13 Aug 2025 23:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: Use of_reserved_mem_region_to_resource() for
 "memory-region"
To: "Rob Herring (Arm)" <robh@kernel.org>, Ming Qian <ming.qian@nxp.com>,
 Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Ming Qian <ming.qian@oss.nxp.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250813214949.897858-1-robh@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813214949.897858-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 22:49, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>   - Rebase on v6.17-rc1
> ---
>   drivers/media/platform/amphion/vpu_core.c     | 40 +++++--------------
>   .../media/platform/qcom/iris/iris_firmware.c  | 18 +++------
>   drivers/media/platform/qcom/venus/firmware.c  | 19 +++------
>   3 files changed, 21 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
> index da00f5fc0e5d..168f0514851e 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -10,7 +10,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> @@ -542,47 +542,30 @@ const struct vpu_core_resources *vpu_get_resource(struct vpu_inst *inst)
>   
>   static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
>   {
> -	struct device_node *node;
>   	struct resource res;
>   	int ret;
>   
> -	if (of_count_phandle_with_args(np, "memory-region", NULL) < 2) {
> -		dev_err(core->dev, "need 2 memory-region for boot and rpc\n");
> -		return -ENODEV;
> +	ret = of_reserved_mem_region_to_resource(np, 0, &res);
> +	if (ret) {
> +		dev_err(core->dev, "Cannot get boot-region\n");
> +		return ret;
>   	}
>   
> -	node = of_parse_phandle(np, "memory-region", 0);
> -	if (!node) {
> -		dev_err(core->dev, "boot-region of_parse_phandle error\n");
> -		return -ENODEV;
> -	}
> -	if (of_address_to_resource(node, 0, &res)) {
> -		dev_err(core->dev, "boot-region of_address_to_resource error\n");
> -		of_node_put(node);
> -		return -EINVAL;
> -	}
>   	core->fw.phys = res.start;
>   	core->fw.length = resource_size(&res);
>   
> -	of_node_put(node);
> -
> -	node = of_parse_phandle(np, "memory-region", 1);
> -	if (!node) {
> -		dev_err(core->dev, "rpc-region of_parse_phandle error\n");
> -		return -ENODEV;
> -	}
> -	if (of_address_to_resource(node, 0, &res)) {
> -		dev_err(core->dev, "rpc-region of_address_to_resource error\n");
> -		of_node_put(node);
> -		return -EINVAL;
> +	ret = of_reserved_mem_region_to_resource(np, 1, &res);
> +	if (ret) {
> +		dev_err(core->dev, "Cannot get rpc-region\n");
> +		return ret;
>   	}
> +
>   	core->rpc.phys = res.start;
>   	core->rpc.length = resource_size(&res);
>   
>   	if (core->rpc.length < core->res->rpc_size + core->res->fwlog_size) {
>   		dev_err(core->dev, "the rpc-region <%pad, 0x%x> is not enough\n",
>   			&core->rpc.phys, core->rpc.length);
> -		of_node_put(node);
>   		return -EINVAL;
>   	}
>   
> @@ -594,7 +577,6 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
>   	if (ret != VPU_CORE_MEMORY_UNCACHED) {
>   		dev_err(core->dev, "rpc region<%pad, 0x%x> isn't uncached\n",
>   			&core->rpc.phys, core->rpc.length);
> -		of_node_put(node);
>   		return -EINVAL;
>   	}
>   
> @@ -606,8 +588,6 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
>   	core->act.length = core->rpc.length - core->res->rpc_size - core->log.length;
>   	core->rpc.length = core->res->rpc_size;
>   
> -	of_node_put(node);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index f1b5cd56db32..40448429ba97 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -19,8 +19,7 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>   	u32 pas_id = core->iris_platform_data->pas_id;
>   	const struct firmware *firmware = NULL;
>   	struct device *dev = core->dev;
> -	struct reserved_mem *rmem;
> -	struct device_node *node;
> +	struct resource res;
>   	phys_addr_t mem_phys;
>   	size_t res_size;
>   	ssize_t fw_size;
> @@ -30,17 +29,12 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>   	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
>   		return -EINVAL;
>   
> -	node = of_parse_phandle(dev->of_node, "memory-region", 0);
> -	if (!node)
> -		return -EINVAL;
> -
> -	rmem = of_reserved_mem_lookup(node);
> -	of_node_put(node);
> -	if (!rmem)
> -		return -EINVAL;
> +	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> +	if (ret)
> +		return ret;
>   
> -	mem_phys = rmem->base;
> -	res_size = rmem->size;
> +	mem_phys = res.start;
> +	res_size = resource_size(&res);
>   
>   	ret = request_firmware(&firmware, fw_name, dev);
>   	if (ret)
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 66a18830e66d..37c0fd52333e 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -9,7 +9,6 @@
>   #include <linux/iommu.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
> -#include <linux/of_address.h>
>   #include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_device.h>
> @@ -83,8 +82,7 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>   			 phys_addr_t *mem_phys, size_t *mem_size)
>   {
>   	const struct firmware *mdt;
> -	struct reserved_mem *rmem;
> -	struct device_node *node;
> +	struct resource res;
>   	struct device *dev;
>   	ssize_t fw_size;
>   	void *mem_va;
> @@ -94,15 +92,8 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>   	*mem_size = 0;
>   
>   	dev = core->dev;
> -	node = of_parse_phandle(dev->of_node, "memory-region", 0);
> -	if (!node) {
> -		dev_err(dev, "no memory-region specified\n");
> -		return -EINVAL;
> -	}
> -
> -	rmem = of_reserved_mem_lookup(node);
> -	of_node_put(node);
> -	if (!rmem) {
> +	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> +	if (ret) {
>   		dev_err(dev, "failed to lookup reserved memory-region\n");
>   		return -EINVAL;
>   	}
> @@ -117,8 +108,8 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>   		goto err_release_fw;
>   	}
>   
> -	*mem_phys = rmem->base;
> -	*mem_size = rmem->size;
> +	*mem_phys = res.start;
> +	*mem_size = resource_size(&res);
>   
>   	if (*mem_size < fw_size || fw_size > VENUS_FW_MEM_SIZE) {
>   		ret = -EINVAL;
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

