Return-Path: <linux-kernel+bounces-767513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45356B25584
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBFB3ACE85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F42C2AA2;
	Wed, 13 Aug 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMcCfUja"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22D17B50A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120737; cv=none; b=CciybslxdSTm9Q58Su2ZzxbpoPRDsaFt5DmPnaskTMtFHDCA9rT+L2Hu8xFVdhUvr7p49yHU/NkmWA1JGwW40WN9XKeM42JrTi05PMqrKXdJwVTrwzUwgs4cjfPFImToITvH/YbRz+WO91P0du166ib/ADFRluzogyf87iEEUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120737; c=relaxed/simple;
	bh=gz575RtG23oSRtncyZleJ9U5eprqql62eLY7aALs0jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMW/opLKoqSuTOeF29cPj7wzhesS0xkdpGszk1E4t07cuD+R6H/gv7lPlAZZvGw9xoTTj1rZ9lvzpYwhZBwzIAOoJMiS+vg5v06J5EkyZrH3XJXLT/tSGTkAPTPuE2gfg9wjEMJC4rezajVT0V+umIy0Ijz7ApHlFthmTXJwuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMcCfUja; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9dc5c2f0eso156666f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755120734; x=1755725534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5cG3cbEW4nr0PnGSR/wXOBrvwNEWafTFeGX/LZex5Y=;
        b=QMcCfUjaMG1xw/wXlsMR7BmuiVQt7JGnQXYBn0KycJVQt727KjKoWz+OFEZoGjGfLH
         bfdQPMmx6lIFJ3qFLw+2dDf362+iO9mHTS6bndnbi8sQwLG2kNt5/WNMvu8vV6ak/SkP
         iDZ6uayb5eJVdN+VzSXwLsQOEBFmrbroTxUw7ouRZlhnhRwFBXP40X7lDH2tSPcVQtzJ
         JwH3BQ3NNG9/tVnf4XCID4iOF0lM4w5g/ku3WzRfVwrf2+7TEh2ZcsNfS700Nj4TFC6q
         sncgnhizEnErZHiVd29lF2NtT6tzxZ20xt1XEgAGQUDWALe0khaBzKUiCVNmu3D2NJ7K
         tujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120734; x=1755725534;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5cG3cbEW4nr0PnGSR/wXOBrvwNEWafTFeGX/LZex5Y=;
        b=qQiGYobBpMDgAoE6uQX5q30PWDTwLCTOtpLs318JTveYUAKWujzdHgMx1IwX74vBHt
         oOqSRxfZdp1XIbBZkAavdqzIfJsyb8Asjn3pjfXaC0Ku3r6ui+Ve4GHONTgSkOpo5Sqn
         pV+/IomNPpkqcsBLkE3Ym7OFU1cfyAqzmUg4vBOBeNSm068yQBEfJux1cM9x+svGzB3K
         htUtBRoeMXRn+YvAkxNUXjAIOLmSeUWTGDXEu3XmLMqwlW0Wz2ihw6nwBFQSK0eGzFQ0
         nDZlN7MefJsQPWg0XvI3ujWFVRp+vI3vqp2fCFqwItN1YmKbyXu/zB8VDU7Cjpxp+TV1
         raoA==
X-Forwarded-Encrypted: i=1; AJvYcCWQF0VAxRscpxkZKtjEP5859Lrqz1j3qV6ZC56LkVSxqt366jfcjxrco7BfnuAQcc3QganoR1buWSK2GC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQJ8pGh+16y05SQ2D7cADRrZJQHuxrGZmnL/5R62E7n/xjb4C
	vN30O4gO5rjJUWd/vdhOefrHjB1EvM9rsttk2l1PR4fAhGB3jHuFHHs7uztP9+/fDHg=
X-Gm-Gg: ASbGncsOWb08s8B86WiCjLWBJku1d6LMAlH8pXUASU/4RbpUNqLkK3gGNudBoRdfFFo
	bUOX2UQoGW7ow1ZP8g574iGiA+750Ebko3q9sw+ZnKWpaEtJw4wY5Sf5n/74/RPFa/WuO9XX0Vl
	pBeGsw4dwEijHYgNWSc6dFK3xgP8MyzMkMeqkUp093dsH24kUY1x0/dOMxqKngvzMzrHqPEizj0
	4csQXoTNgnhgSLhdY7UMhBHpFgTRnwTHuzD+CX6G+Gl+WwKJy4qj5FERuUb/pAfNhuxTzVrDoUH
	Ts1NoJOA+F7gLKdGCyoW/uTr42AkpZKCwt40RAd98a8cKZEtkihcdjuKWQk1WqbsGD1W13yPFTr
	WEtFCPNbJSzqVtWxZnOK9WE/9+pKBdf42zaQ6+sxufQvrQLd0hL/N8uB4eEsFXGHY
X-Google-Smtp-Source: AGHT+IHkYxD1EboP/TbdW74mssEAzDAmI9C1GIx0bTyGR/ssaIY4vNnPWQhRo2D5dv3Be+lyxWwcGg==
X-Received: by 2002:a05:6000:288f:b0:3b7:94c6:7c9 with SMTP id ffacd0b85a97d-3b9edf935aemr644651f8f.27.1755120733878;
        Wed, 13 Aug 2025 14:32:13 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469319sm47865251f8f.54.2025.08.13.14.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:32:12 -0700 (PDT)
Message-ID: <505218ad-d010-42a2-bf01-d2141d55001d@linaro.org>
Date: Wed, 13 Aug 2025 22:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] media: qcom: camss: Add CSIPHY support for QCS8300
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813053724.232494-1-quic_vikramsa@quicinc.com>
 <20250813053724.232494-4-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813053724.232494-4-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 06:37, Vikram Sharma wrote:
> QCS8300 uses the same CSIPHY hardware version (v1.3.0) as
> SA8775P. The only difference between the two platforms is
> the number of CSIPHY instances: SA8775P has four, while
> QCS8300 has three.
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   .../qcom/camss/camss-csiphy-3ph-1-0.c         |  2 +
>   drivers/media/platform/qcom/camss/camss.c     | 57 +++++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index a610504359d0..445f4d41e847 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -826,6 +826,7 @@ static bool csiphy_is_gen2(u32 version)
>   	case CAMSS_7280:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
> +	case CAMSS_8300:
>   	case CAMSS_845:
>   	case CAMSS_8550:
>   	case CAMSS_8775P:
> @@ -928,6 +929,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
>   		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8550);
>   		regs->offset = 0x1000;
>   		break;
> +	case CAMSS_8300:
>   	case CAMSS_8775P:
>   		regs->lane_regs = &lane_regs_sa8775p[0];
>   		regs->lane_array_size = ARRAY_SIZE(lane_regs_sa8775p);
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 6b9aba1029b5..410e188d26aa 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -2483,6 +2483,63 @@ static const struct resources_icc icc_res_sm8550[] = {
>   	},
>   };
>   
> +static const struct camss_subdev_resources csiphy_res_8300[] = {
> +	/* CSIPHY0 */
> +	{
> +		.regulators = { "vdda-phy", "vdda-pll" },
> +
> +		.clock = { "csiphy_rx", "csiphy0", "csiphy0_timer" },
> +		.clock_rate = {
> +			{ 400000000 },
> +			{ 0 },
> +			{ 400000000 },
> +		},
> +		.reg = { "csiphy0" },
> +		.interrupt = { "csiphy0" },
> +		.csiphy = {
> +			.id = 0,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845,
> +		}
> +	},
> +	/* CSIPHY1 */
> +	{
> +		.regulators = { "vdda-phy", "vdda-pll" },
> +
> +		.clock = { "csiphy_rx", "csiphy1", "csiphy1_timer" },
> +		.clock_rate = {
> +			{ 400000000 },
> +			{ 0 },
> +			{ 400000000 },
> +		},
> +		.reg = { "csiphy1" },
> +		.interrupt = { "csiphy1" },
> +		.csiphy = {
> +			.id = 1,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845,
> +		}
> +	},
> +	/* CSIPHY2 */
> +	{
> +		.regulators = { "vdda-phy", "vdda-pll" },
> +
> +		.clock = { "csiphy_rx", "csiphy2", "csiphy2_timer" },
> +		.clock_rate = {
> +			{ 400000000 },
> +			{ 0 },
> +			{ 400000000 },
> +		},
> +		.reg = { "csiphy2" },
> +		.interrupt = { "csiphy2" },
> +		.csiphy = {
> +			.id = 2,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845,
> +		}
> +	},
> +};
> +
>   static const struct camss_subdev_resources csiphy_res_8775p[] = {
>   	/* CSIPHY0 */
>   	{
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

