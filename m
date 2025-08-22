Return-Path: <linux-kernel+bounces-781929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E85B318C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E851C83ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD330274F;
	Fri, 22 Aug 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Nfs7u0K7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A212FD1C0;
	Fri, 22 Aug 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867582; cv=none; b=ff3AahiEMOgBuZXcxJdWkAcfyyYdkGef2FkrsmTJJjyIQZGX4DVBUoZV48pqdyVi1nkf1SCYmklqZI78bhmFVc9z4fFWUlgtgQziI0fEEG2+xwOK8KahfByRnI0HRD3zQla8ZpMEpTD7KNnU7vKoSbOkBj0VP8IZ0nswnkiAkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867582; c=relaxed/simple;
	bh=UsX7y5kEJLWRiNbRq/+lGac/4Hb+cEzPKh3/eKiDKvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HaPQcEvzjfi+3Y8ydZwtL3cOPxh4b3uLad/p++cY+yWnpA6y3UvMCiAvWDCY5WSmpO0hZZLbI7h3AgkONA5Na2aw3LDMdLzSm9Xe2Kc5YRzzC1YNOfbL6YDtXWpZ053I4iSuLN4d0se7ibEmlqzgq0bZONSDAaU0R7Nsw9+glrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Nfs7u0K7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MB4cNS006702;
	Fri, 22 Aug 2025 14:59:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	eJVEVHQF5pr9BGboWJab/5hf088ZC2OEhk357P8nepk=; b=Nfs7u0K7OlORz/Pc
	D6Sp9pLBly1bVFLlKKcXt7nNlZ5eXZOoOd/qZd4N+VnZuxcjgEGKSBv/03cE56zg
	s84BseNPmH/f+YN7NSapfJKf+23PI0iJ600LKTygRkXTD61x4zSjNS+nVdEanN4X
	8UkYHvd8+MLYSy7DR2s0f/KcAiDAUmDmoD4YLeuK6xE/njAeRga+/hPk3wUdKicd
	AYGrS4YgsgAXP51YZsHDT0rzu8Wcl0w8TW0adxRh5IV844+RUSm3e2z6rKjqHfg4
	Gfe46MB+fUE/+Psv+l70rV0hwLzDDvCaflRKi6JueVyZ40yvhK7L5Sd3om1Vs46U
	5/8iOA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48nj3v88b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:59:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 880E04002D;
	Fri, 22 Aug 2025 14:57:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 967FE5EFA17;
	Fri, 22 Aug 2025 14:56:34 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:56:33 +0200
Message-ID: <6bc77ea8-c664-45ff-886a-aefc79767253@foss.st.com>
Date: Fri, 22 Aug 2025 14:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] drm/stm: ltdc: handle lvds pixel clock
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
 <20250821-drm-misc-next-v4-8-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-8-7060500f8fd3@foss.st.com>
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
> Handle LVDS pixel clock.
>
> The LTDC operates with multiple clock domains for register access,
> requiring all clocks to be provided during read/write operations.  This
> imposes a dependency between the LVDS and LTDC to access correctly all
> LTDC registers.  And because both IPs' pixel rates must be synchronized,
> the LTDC has to handle the LVDS clock.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 22 +++++++++++++++++++++-
>   drivers/gpu/drm/stm/ltdc.h |  1 +
>   2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 17548dd3484a0a3e1015c58c752b80f8892a0ff7..f84a9a8590f0653e422798ff61804d7c3966caef 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -837,6 +837,12 @@ ltdc_crtc_mode_valid(struct drm_crtc *crtc,
>   	int target_max = target + CLK_TOLERANCE_HZ;
>   	int result;
>   
> +	if (ldev->lvds_clk) {
> +		result = clk_round_rate(ldev->lvds_clk, target);
> +		drm_dbg_driver(crtc->dev, "lvds pixclk rate target %d, available %d\n",
> +			       target, result);
> +	}
> +
>   	result = clk_round_rate(ldev->pixel_clk, target);
>   
>   	DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
> @@ -1878,6 +1884,8 @@ void ltdc_suspend(struct drm_device *ddev)
>   	clk_disable_unprepare(ldev->pixel_clk);
>   	if (ldev->bus_clk)
>   		clk_disable_unprepare(ldev->bus_clk);
> +	if (ldev->lvds_clk)
> +		clk_disable_unprepare(ldev->lvds_clk);
>   }
>   
>   int ltdc_resume(struct drm_device *ddev)
> @@ -1895,8 +1903,16 @@ int ltdc_resume(struct drm_device *ddev)
>   
>   	if (ldev->bus_clk) {
>   		ret = clk_prepare_enable(ldev->bus_clk);
> -		if (ret)
> +		if (ret) {
>   			drm_err(ddev, "failed to enable bus clock (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (ldev->lvds_clk) {
> +		ret = clk_prepare_enable(ldev->lvds_clk);
> +		if (ret)
> +			drm_err(ddev, "failed to prepare lvds clock\n");
>   	}
>   
>   	return ret;
> @@ -1981,6 +1997,10 @@ int ltdc_load(struct drm_device *ddev)
>   		}
>   	}
>   
> +	ldev->lvds_clk = devm_clk_get(dev, "lvds");
> +	if (IS_ERR(ldev->lvds_clk))
> +		ldev->lvds_clk = NULL;
> +
>   	rstc = devm_reset_control_get_exclusive(dev, NULL);
>   
>   	mutex_init(&ldev->err_lock);
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index ddfa8ae61a7ba5dc446fae647562d0ec8e6953e1..17b51a7ce28eee5de6d24ca943ca3b1f48695dfd 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -48,6 +48,7 @@ struct ltdc_device {
>   	void __iomem *regs;
>   	struct regmap *regmap;
>   	struct clk *pixel_clk;	/* lcd pixel clock */
> +	struct clk *lvds_clk;	/* lvds pixel clock */
>   	struct clk *bus_clk;	/* bus clock */
>   	struct mutex err_lock;	/* protecting error_status */
>   	struct ltdc_caps caps;
>

