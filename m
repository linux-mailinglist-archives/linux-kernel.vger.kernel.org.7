Return-Path: <linux-kernel+bounces-700831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3274AE6D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD68D1BC28B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C992E2F19;
	Tue, 24 Jun 2025 17:15:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35D22B8A9
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785329; cv=none; b=CdSsHD8cZk1Zq3nY0+gZfkuxulyP2n/NXM9nCtmOvmcEjGvVazFvyguqR1plYMlfw1GGMQkmf0CkoxRZ/rWs/zNwPvROeC7CE6op0zk4hJQkQmykqCgNHu1AYPrNOBzF8pRWuKwoodKpXelbCfZOW3hxVehkNh8HwzykmeiKJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785329; c=relaxed/simple;
	bh=J++vCXdEMdLhhQCO5UEyk2FcYNCV+7ZfNWoyOrnq74c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGHVI94cf66EyikZBDM0VOg/IZ6qz9QisgtFB1D8FLmONJYBB8GD35/8L7gMLpdJIjVAYE4UuPxbIThwKKWK65xKo91+7EeyQJc1bWQng8Z0V0ktwZdlff9W2Lx43uLljBR3NuJuk9CZok47UmuCC/o6/fIDotcSQNEvULk5TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77C5113E;
	Tue, 24 Jun 2025 10:15:07 -0700 (PDT)
Received: from [10.57.29.113] (unknown [10.57.29.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9A6C3F58B;
	Tue, 24 Jun 2025 10:15:23 -0700 (PDT)
Message-ID: <bc1b7891-d2d4-4104-b52d-dfa956e0a6a3@arm.com>
Date: Tue, 24 Jun 2025 18:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iommu: omap: Drop redundant check if
 ti,syscon-mmuconfig exists
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
 <20250624-syscon-phandle-args-iommu-v3-1-1a36487d69b8@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250624-syscon-phandle-args-iommu-v3-1-1a36487d69b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-24 1:22 pm, Krzysztof Kozlowski wrote:
> The syscon_regmap_lookup_by_phandle() will fail if property does not
> exist, so doing of_property_read_bool() earlier is redundant.  Drop that
> check and move error message to syscon_regmap_lookup_by_phandle() error
> case while converting it to dev_err_probe().

Sure, may as well.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/iommu/omap-iommu.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 3c62337f43c67720a15b67e8b610da7886f6f39c..4448c0a512137c79195112eea25d762266c77bc3 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1123,23 +1123,15 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>   					      struct omap_iommu *obj)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> -	int ret;
>   
>   	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
>   		return 0;
>   
> -	if (!of_property_read_bool(np, "ti,syscon-mmuconfig")) {
> -		dev_err(&pdev->dev, "ti,syscon-mmuconfig property is missing\n");
> -		return -EINVAL;
> -	}
> -
>   	obj->syscfg =
>   		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
> -	if (IS_ERR(obj->syscfg)) {
> -		/* can fail with -EPROBE_DEFER */
> -		ret = PTR_ERR(obj->syscfg);
> -		return ret;
> -	}
> +	if (IS_ERR(obj->syscfg))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(obj->syscfg),
> +				     "ti,syscon-mmuconfig property is missing\n");
>   
>   	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
>   				       &obj->id)) {
> 


