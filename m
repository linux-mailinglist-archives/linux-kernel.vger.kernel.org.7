Return-Path: <linux-kernel+bounces-869014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B9C06B81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D953B57B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAE30748B;
	Fri, 24 Oct 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qkdy/p+g"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F7269B1C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316482; cv=none; b=NJ8oevpWUDyME2/V/CkIccHdsU511OVkGHwH/eqV0UWLrMi55SvYBXzYeRb4ItSgMZc9akpUkX+t+dyVj3HYug5JPxb6UshiefVM/mPxbHhvPZ13SDnbU33Ff1Q6rzaoeCqXXMdP50bZZqc1S6mAkU4Mr4yGQtthL8dYZuaY5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316482; c=relaxed/simple;
	bh=BOUy0rvH3jbf8d/DXxXFfpRisYIWyoXuZ7y0GHPEMRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ICtGp/cTiFlI+58xbKwLwyRqm252SI1+yCWdrAyGguE9y0Ny5iLyvqUTB2naNfoOKySgRrK0RUY01PtYZj8WCkrrElJ4GtIxOZtvak1x5ML9vQsmPVOHlcXdocanqcpj1CX1wm55LeVKW8zcelYquz6wXMNVveqHSpmbmY6xFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qkdy/p+g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47107a9928cso1136645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761316477; x=1761921277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+PpqXeugL7pGMhk358BvYaCrtr5g/cABDlByYsLEG8=;
        b=Qkdy/p+gj9MaYd9pmEM3SF2wDfBpsbnJchM7vnP8oplt1ND6H4Ds2w9FIG+WNn9MHg
         DSf4IswJrkb/DBbmKfQh9q7KHXDWRFIjKNkTAU6Kkmp58QkyyF21XsnvmQGSf9/GSEo6
         2CuYnzvPUVf+GaopwLQYIWhhlxhc9jI+7fi05D2XoLesKrbXQVScO+2abQTKzWu21wMj
         Q+WXufvXpmYjCiHLDVgeJ6fdx+VPOv9XGfZ35Mc51F2LmGWDwydyZB7pFQFE66+qOCx9
         +ZnUIraWVB//0E+Not4izatnnNVG+JN8MVxiGTeQytY43pwetYsfiK+Vo1rbUzxhLi4I
         psWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316477; x=1761921277;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+PpqXeugL7pGMhk358BvYaCrtr5g/cABDlByYsLEG8=;
        b=CiNJx0vjavoJhiSt94GuWMuDQQjWOh/QMTf4OqbSfQNg5Nyl0yG5KdfSUfNpbXaDkZ
         YkPJmQ8UF+z4/v2ONpGhPfFT84g3GgVKO3HlmLaKRDnZB3sw9aykZ8DDPH2VBYRzdmXa
         GpqR+n1eZtmL72ziFTXwyOXDO8PoYsu+b8FOkuIJZ1Spn0cE+4LqQe7s0pW8s7i3rvKx
         4f3zsW+H17nhNMV/pCX/8fQ8dYRLeuLsJGb/TKV2LTI46CRzCtRZ20dFYfn902dpjgxd
         MHLlUiJyvZoF4JN/HVNej/SsEq/uYeVCtu6cGbPR7PUXm1mjjCRcqusOtgH5WMgrvNCA
         eQuA==
X-Forwarded-Encrypted: i=1; AJvYcCXa5Pv+8NcGvfkwOk66L4JZBx6tamVPvrdSv62kv/ts/HmtrlPcHyvT+FsMxPt7ltPIx3TOzSbl+Zjsj8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejrlWZvbHdBvvDd18WbRBXmkjH7VrT4nCuQAVeBPeaNYtxES0
	O1pCoQscRASFo/m4OEibv9xaDjMMEkHDtnTzJMwRAHUlkY7pxYA44NhluIRcGnawCqQ=
X-Gm-Gg: ASbGncvaxmkfL0p4vAOJQbGKZoECpY3MBsbhBaA9qBAgsJLFvlyDbUrmna1ikZBNA8g
	2RcSqBG5Ko2CNhVar4vSr7bSjxIztowiLntBXb8jbLevUZizOePo8zlxvqmL/BOYBy+SjErqCeg
	HSHm6JQqoE3o+rrFNaFHD2lsxBr5xPAxvoeWNFNO7lNDJkBPEdXjb+2Oj4uCC0v54BYWKmgMhW7
	XxGW4PLzvPvNCwU5SsMg6pnSt/BeyGQSLjRP2aNWDA6uUf7Ddww6z3KRl+wszoWYEGNcg3BQd69
	eFs88ItIqhUZbNy50+t7uUS5zXEIbWz5bfbdprvVjSh+njFseAylj+RL4ou4/zeWUwTu0nAYXAJ
	vby+Tx+4c1dZz9DMqCJwypWq4T0JZkaX7Qyeelnag2BBFQYK5uBlTGz0NTQEMaKaIeIYSKvcAGN
	+lR/oiDYRQZr2pj5lOQ8+1QjHn8uTRj+c=
X-Google-Smtp-Source: AGHT+IFFTQfSJUbQ0wn4q5TWxlpKn0xxmu9BkVKhs+IavSaSdLdyRW7kc5mVPKE2XVpCiAho/KSkJQ==
X-Received: by 2002:a05:600c:4fcb:b0:471:c4c:5ef with SMTP id 5b1f17b1804b1-4749437b584mr63585875e9.4.1761316477486;
        Fri, 24 Oct 2025 07:34:37 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b33sm151500975e9.14.2025.10.24.07.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:34:36 -0700 (PDT)
Message-ID: <05d6ea2a-c1ae-422d-b178-5d2a306f3669@linaro.org>
Date: Fri, 24 Oct 2025 16:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] drm/msm/dsi/phy: Fix reading zero as PLL rates when
 unprepared
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250908094950.72877-2-krzysztof.kozlowski@linaro.org>
 <50a49d72-2b1e-471d-b0c4-d5a0b38b2a21@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <50a49d72-2b1e-471d-b0c4-d5a0b38b2a21@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2025 14:43, Neil Armstrong wrote:
> Hi,
> 
> On 9/8/25 11:49, Krzysztof Kozlowski wrote:
>> Hardware Programming Guide for DSI PHY says that PLL_SHUTDOWNB and
>> DIGTOP_PWRDN_B have to be asserted for any PLL register access.
>> Whenever dsi_pll_7nm_vco_recalc_rate() or dsi_pll_7nm_vco_set_rate()
>> were called on unprepared PLL, driver read values of zero leading to all
>> sort of further troubles, like failing to set pixel and byte clock
>> rates.
>>
>> Asserting the PLL shutdown bit is done by dsi_pll_enable_pll_bias() (and
>> corresponding dsi_pll_disable_pll_bias()) which are called through the
>> code, including from PLL .prepare() and .unprepare() callbacks.
>>
>> The .set_rate() and .recalc_rate() can be called almost anytime from
>> external users including times when PLL is or is not prepared, thus
>> driver should not interfere with the prepare status.
>>
>> Implement simple reference counting for the PLL bias, so
>> set_rate/recalc_rate will not change the status of prepared PLL.
>>
>> Issue of reading 0 in .recalc_rate() did not show up on existing
>> devices, but only after re-ordering the code for SM8750.
> 
> It happens this breaks the bonded DSI use-case, mainly because both PHYs
> uses the same PLL, and trying to enable the DSI0 PHY PLL from the DSI1
> PHY fails because the DSI0 PHY enable_count == 0.


If it is ==0, the check you removed would not be hit and enable would
work. I don't quite get the analysis.

> 
> Reverting part the the patch makes the bonded work again:
> ===================><===============================
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> index 32f06edd21a9..24811c52d34c 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -426,11 +426,8 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7nm *pll)
>   	u32 data;
> 
>   	spin_lock_irqsave(&pll->pll_enable_lock, flags);
> -	if (pll->pll_enable_cnt++) {
> -		spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
> -		WARN_ON(pll->pll_enable_cnt == INT_MAX);
> -		return;
> -	}
> +	pll->pll_enable_cnt++;
> +	WARN_ON(pll->pll_enable_cnt == INT_MAX);
> 
>   	data = readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
>   	data |= DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
> @@ -965,10 +962,8 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
>   	u32 const delay_us = 5;
>   	u32 const timeout_us = 1000;
>   	struct msm_dsi_dphy_timing *timing = &phy->timing;
> -	struct dsi_pll_7nm *pll = phy->pll_data;
>   	void __iomem *base = phy->base;
>   	bool less_than_1500_mhz;
> -	unsigned long flags;
>   	u32 vreg_ctrl_0, vreg_ctrl_1, lane_ctrl0;
>   	u32 glbl_pemph_ctrl_0;
>   	u32 glbl_str_swi_cal_sel_ctrl, glbl_hstx_str_ctrl_0;
> @@ -1090,13 +1085,10 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
>   		glbl_rescode_bot_ctrl = 0x3c;
>   	}
> 
> -	spin_lock_irqsave(&pll->pll_enable_lock, flags);

This should not be removed.

> -	pll->pll_enable_cnt = 1;

So you basically remoevd pll_enable_cnt everywhere and reverted entirely
my commit. How is this patch different than revert?

Best regards,
Krzysztof

