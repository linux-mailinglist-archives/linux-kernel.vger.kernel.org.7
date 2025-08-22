Return-Path: <linux-kernel+bounces-781926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45890B318C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7614D64103B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DB199FAC;
	Fri, 22 Aug 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XcvgCYNC"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5581BF58;
	Fri, 22 Aug 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867457; cv=none; b=HOCQssmVdgsfqJWTLrk6ipT9K9RoegY+aOs0gQso8y5JO+m2yGjHEtkYhY9377oGsZgcrdjwyCEyzzc4ghke+f9k6p6PiruqPzDlcs1w+/4iUqw6T/oaqBki+TCFZsuujw6hqNqZ+9ny+w8RlugdzFiqmrfV3vbAUQdbHcZQHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867457; c=relaxed/simple;
	bh=CT95aoj3GcK+SLYSHbca/fGwUzXYdmxWd4vrd1wnp/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ViMEnOtnBa8hdm67/rtZJIryE43Gl8BAKgk8TU4xrhU4995/YUPekuWrFsbSeUsa+62DijwXyKf5ktRsc+eDC5h+w6NK/aFBPKpyrO53WXUtpiYcdgQnQ85j3viiobgju56QAnvIAkgihAVi/FUe+CcW38NFBPHpjo2Bi+KEJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XcvgCYNC; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MBxc3F027155;
	Fri, 22 Aug 2025 14:57:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	opW6CQ+EIqTEuYkWoukvWl2zvBo6YGtnwvOV0fo5tV8=; b=XcvgCYNC8hOKLHmF
	1YDvila7DCEL29BYb+Cndwdb4UamCtkBVMaO0olvOYEkz8Ta1dyt++QR6K0HqlJ+
	2Ujeg87Q1C3JWiTeeMdOPOZjr4p1IxE+Av05+lzUzv976+fTI/ob2H+tgxaPUe7G
	9rZN1MtW0e4JbbY7EAgG4cJjjqPFRgWfxJ53b4ooX1xbvIMutq3meYl37n7tBn36
	8tsmJuL3n5RKcWwTxlol4eP+b8PyYLS+HCtsdLiedVAH/fXDnen6pQIc3HaldI6h
	+eID3SWXnI5kbWGoSt2XR+hV7TSLIU/Bf4jbQgFW2cXVMHeB/AuMDxRPrYVq+Wxg
	wlAoiQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n70dk5vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:57:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1D46A40046;
	Fri, 22 Aug 2025 14:56:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A67571EE06;
	Fri, 22 Aug 2025 14:55:05 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:55:04 +0200
Message-ID: <46e08e79-a735-453d-9804-d5ed9fb4bb82@foss.st.com>
Date: Fri, 22 Aug 2025 14:55:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] drm/stm: ltdc: support new hardware version for
 STM32MP25 SoC
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
 <20250821-drm-misc-next-v4-7-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-7-7060500f8fd3@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Le 21/08/2025 à 13:08, Raphael Gallais-Pou a écrit :
> From: Yannick Fertre <yannick.fertre@foss.st.com>
>
> STM32MP25 SoC features a new version of the LTDC IP.  Add its compatible
> to the list of device to probe and implement its quirks.
>
> This hardware supports a pad frequency of 150MHz and a peripheral bus
> clock.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/gpu/drm/stm/drv.c  | 12 +++++++++++-
>   drivers/gpu/drm/stm/ltdc.c | 38 +++++++++++++++++++++++++++++++++++---
>   drivers/gpu/drm/stm/ltdc.h |  5 +++++
>   3 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 8ebcaf953782d806a738d5a41ff1f428b0ccff78..ab00d1a6140cc32e71e10abc82f7956328b518e3 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -236,8 +236,18 @@ static void stm_drm_platform_shutdown(struct platform_device *pdev)
>   	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
>   }
>   
> +static struct ltdc_plat_data stm_drm_plat_data = {
> +	.pad_max_freq_hz = 90000000,
> +};
> +
> +static struct ltdc_plat_data stm_drm_plat_data_mp25 = {
> +	.pad_max_freq_hz = 150000000,
> +};
> +
>   static const struct of_device_id drv_dt_ids[] = {
> -	{ .compatible = "st,stm32-ltdc"},
> +	{ .compatible = "st,stm32-ltdc", .data = &stm_drm_plat_data, },
> +	{ .compatible = "st,stm32mp251-ltdc", .data = &stm_drm_plat_data_mp25, },
> +	{ .compatible = "st,stm32mp255-ltdc", .data = &stm_drm_plat_data_mp25, },
>   	{ /* end node */ },
>   };
>   MODULE_DEVICE_TABLE(of, drv_dt_ids);
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index ba315c66a04d72758b9d3cfcd842432877f66d3a..17548dd3484a0a3e1015c58c752b80f8892a0ff7 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -14,6 +14,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/media-bus-format.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
>   #include <linux/of_graph.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/platform_device.h>
> @@ -51,6 +52,7 @@
>   #define HWVER_10300 0x010300
>   #define HWVER_20101 0x020101
>   #define HWVER_40100 0x040100
> +#define HWVER_40101 0x040101
>   
>   /*
>    * The address of some registers depends on the HW version: such registers have
> @@ -1779,6 +1781,7 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   {
>   	struct ltdc_device *ldev = ddev->dev_private;
>   	u32 bus_width_log2, lcr, gc2r;
> +	const struct ltdc_plat_data *pdata = of_device_get_match_data(ddev->dev);
>   
>   	/*
>   	 * at least 1 layer must be managed & the number of layers
> @@ -1794,6 +1797,8 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   	ldev->caps.bus_width = 8 << bus_width_log2;
>   	regmap_read(ldev->regmap, LTDC_IDR, &ldev->caps.hw_version);
>   
> +	ldev->caps.pad_max_freq_hz = pdata->pad_max_freq_hz;
> +
>   	switch (ldev->caps.hw_version) {
>   	case HWVER_10200:
>   	case HWVER_10300:
> @@ -1811,7 +1816,6 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   		 * does not work on 2nd layer.
>   		 */
>   		ldev->caps.non_alpha_only_l1 = true;
> -		ldev->caps.pad_max_freq_hz = 90000000;
>   		if (ldev->caps.hw_version == HWVER_10200)
>   			ldev->caps.pad_max_freq_hz = 65000000;
>   		ldev->caps.nb_irq = 2;
> @@ -1842,6 +1846,7 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   		ldev->caps.fifo_threshold = false;
>   		break;
>   	case HWVER_40100:
> +	case HWVER_40101:
>   		ldev->caps.layer_ofs = LAY_OFS_1;
>   		ldev->caps.layer_regs = ltdc_layer_regs_a2;
>   		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a2;
> @@ -1849,7 +1854,6 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   		ldev->caps.pix_fmt_nb = ARRAY_SIZE(ltdc_drm_fmt_a2);
>   		ldev->caps.pix_fmt_flex = true;
>   		ldev->caps.non_alpha_only_l1 = false;
> -		ldev->caps.pad_max_freq_hz = 90000000;
>   		ldev->caps.nb_irq = 2;
>   		ldev->caps.ycbcr_input = true;
>   		ldev->caps.ycbcr_output = true;
> @@ -1872,6 +1876,8 @@ void ltdc_suspend(struct drm_device *ddev)
>   
>   	DRM_DEBUG_DRIVER("\n");
>   	clk_disable_unprepare(ldev->pixel_clk);
> +	if (ldev->bus_clk)
> +		clk_disable_unprepare(ldev->bus_clk);
>   }
>   
>   int ltdc_resume(struct drm_device *ddev)
> @@ -1887,7 +1893,13 @@ int ltdc_resume(struct drm_device *ddev)
>   		return ret;
>   	}
>   
> -	return 0;
> +	if (ldev->bus_clk) {
> +		ret = clk_prepare_enable(ldev->bus_clk);
> +		if (ret)
> +			drm_err(ddev, "failed to enable bus clock (%d)\n", ret);
> +	}
> +
> +	return ret;
>   }
>   
>   int ltdc_load(struct drm_device *ddev)
> @@ -1922,6 +1934,20 @@ int ltdc_load(struct drm_device *ddev)
>   		return -ENODEV;
>   	}
>   
> +	if (of_device_is_compatible(np, "st,stm32mp251-ltdc") ||
> +	    of_device_is_compatible(np, "st,stm32mp255-ltdc")) {
> +		ldev->bus_clk = devm_clk_get(dev, "bus");
> +		if (IS_ERR(ldev->bus_clk))
> +			return dev_err_probe(dev, PTR_ERR(ldev->bus_clk),
> +					     "Unable to get bus clock\n");
> +
> +		ret = clk_prepare_enable(ldev->bus_clk);
> +		if (ret) {
> +			drm_err(ddev, "Unable to prepare bus clock\n");
> +			return ret;
> +		}
> +	}
> +
>   	/* Get endpoints if any */
>   	for (i = 0; i < nb_endpoints; i++) {
>   		ret = drm_of_find_panel_or_bridge(np, 0, i, &panel, &bridge);
> @@ -2034,6 +2060,9 @@ int ltdc_load(struct drm_device *ddev)
>   
>   	clk_disable_unprepare(ldev->pixel_clk);
>   
> +	if (ldev->bus_clk)
> +		clk_disable_unprepare(ldev->bus_clk);
> +
>   	pinctrl_pm_select_sleep_state(ddev->dev);
>   
>   	pm_runtime_enable(ddev->dev);
> @@ -2042,6 +2071,9 @@ int ltdc_load(struct drm_device *ddev)
>   err:
>   	clk_disable_unprepare(ldev->pixel_clk);
>   
> +	if (ldev->bus_clk)
> +		clk_disable_unprepare(ldev->bus_clk);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index 9d488043ffdbc652deeede71c9d57d45fb89d3c6..ddfa8ae61a7ba5dc446fae647562d0ec8e6953e1 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -40,10 +40,15 @@ struct fps_info {
>   	ktime_t last_timestamp;
>   };
>   
> +struct ltdc_plat_data {
> +	int pad_max_freq_hz;	/* max frequency supported by pad */
> +};
> +
>   struct ltdc_device {
>   	void __iomem *regs;
>   	struct regmap *regmap;
>   	struct clk *pixel_clk;	/* lcd pixel clock */
> +	struct clk *bus_clk;	/* bus clock */
>   	struct mutex err_lock;	/* protecting error_status */
>   	struct ltdc_caps caps;
>   	u32 irq_status;
>

