Return-Path: <linux-kernel+bounces-863835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B893EBF93A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE45D4EB0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3E62C15BB;
	Tue, 21 Oct 2025 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dh9y2uXe"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67326E16C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089277; cv=none; b=i/HdmVNBji8E/g3C/Y4u22gWQTldErGmcR2Fm3FQKHnMkSZN7RpFFZSVihhJo1J9o1jTDZlJ8OrF79YffA5ihQI1ihL+iceiVFwn/V/4aZuzKdr/LVa3ppG9s/Fl5OpMZWnw3aa8uBZyaUZfb05+A9TKUCoD0RgPipgQfn22Ic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089277; c=relaxed/simple;
	bh=CgkG4pMugjcs9pB9Iu6a/9GYwozm4r+tEeuBEz/VDnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X81XtXc1Fp6zhzUjT93ZJQiP4d1Ws0WzI5malPt/BaEmJ4O21yZPu5stlcGCRE6VHBU9+3Sugr9yIhRhYAW2rTdQA5KMddUcRAVLy1qNpcATM4MHx8VqPCoU4rt3o2jEcYtwtOVQ8Hjjn9ES4XZ2wEIU/7V8AaiC05eZHI1PUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dh9y2uXe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711810948aso42946805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761089274; x=1761694074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11T5RT0EtzcFdLIDswfSiZBzbAPS/UzKcdJ15Rc+GQs=;
        b=Dh9y2uXeBPwpwQj12LsDPdjmweiY5rS3A1GzmdF7zNz3YQwMcFtfLH7OOM3n6P/gYA
         fTZ9q0I83ApP0PV/UgCLh52HXgpJeNM6OkRb/hmzc71CFAxuO9Al1M2iw3WNGXIdfpud
         PhE31jIqV1norA1xjKBWrS5J1tiKnI1+ZiJu2mg8/lEEobeBdHBA8TQqf8iX6qYFK9AT
         r3na/Jbj6SsvBzkeHDHxYE+1u2iCPay6xaMMeJlli5X5dcqP+Cx0wZMKZVCwxzsyMFtV
         iORE3Bnzxdfu3LPAvuN5Q9RQaeKSegQgxSVNp3hxmsmyN/IeeHO+krYp0KwZifwq+FjC
         GsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089274; x=1761694074;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11T5RT0EtzcFdLIDswfSiZBzbAPS/UzKcdJ15Rc+GQs=;
        b=othCfC0k4aqt8cQb0BEAZBBi+pTwEUrgKPo4JghfVoH+tdCIhGo8TcMAvj+PD66Pz3
         gg86SK1Fc0OTWvL8NQJJxXfTlHcf6SF/zWhNpFy6dhsMqcZNO6B72gQ+TZ7PcGjaH9U9
         f88lZN6ncOlE0qRcLzDhvcCnhOPe33wLnaQNPF5qqMJabkfwIpZZ9sODV4DS1Gtme9iM
         gH1bfmFiFjuXGSA6Nfw+j3IA4e65O+QFsuplzWi9Y43SJpF58BK5uc5fRBNPynDa+DzJ
         2gMbRZ5SiSr4xeViBFilDmcJKiJ0iVvNCWyatj1nteIDhyv7L1CPecpGeDFD0zavqJV6
         lUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPplt8uxbb6IyM07ndtRBJjedLX90MTlnZvNd7z2owHUCqNoSvIq0so7g7r3Il+ztkr2zrAYzy2zbXcwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZk2WEcYiAvsG7kFpBmYp/CiTPX4t32di3W3lOIOnja/EzX0zP
	OUU5vFIrHbLZSoVFDS0kpt87mrQVc6QxlRuc9NNkMasurKn5VvOa4rlGyYjHjIxFJqniWT/ukaM
	DaQvj
X-Gm-Gg: ASbGncvH9jL0kcDmAYr9gVmJtxxeFs8ABibVQJikNk0iTKAT6fkgeBO1dwym8W+Iscl
	/36gGTLf1OwMrahdBuiXCX8lzJBoV/dczco68fBPTcCTpaEEbeYST88329Zd0Xm+R/B8xhtmN5C
	bjqXO6doq+lYYqEbQSV1OIhMIPvCvmG9N4ofP9dj0Tv4e3mH4Ni44hpzENeqzO+smWFa9adAlu6
	6W7hdfDpcuSzB5a7EJXDb/iVHPY6xvvbam+aE/vS/qq9Kenqf/+5QBbW5wUKb2YhVWKoJbvhM2y
	ouHSFQ1RetZAy6jqg9jGgSNhOx4LlfDXn3a/DL1KHgRn10Cxy64QJi6kDbDQVFbxxkig4xAPBg5
	4tWOpQThGNhBksKbrnDe4lTcjjKPBCR8rJ17qeofTiNq1i7GAYcsxc93m75JWRQ4MtwCsqk0HQh
	poiAmOX2HAUECCGiQ2verwvgMTeqvYvfz+tPr2yErGSps/9efOj94SDg==
X-Google-Smtp-Source: AGHT+IH16gLXInKodyasLPwx+eTKM8EGe2d51842fK5IcPp9qAw4hLP2RVVMEPuqgvcvN/9IrDhZWg==
X-Received: by 2002:a05:600c:3149:b0:470:bcc4:b0a0 with SMTP id 5b1f17b1804b1-47117925919mr158367725e9.34.1761089273855;
        Tue, 21 Oct 2025 16:27:53 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c429e745sm15891335e9.9.2025.10.21.16.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 16:27:53 -0700 (PDT)
Message-ID: <941070d8-1abe-42d6-b639-80ff369469bf@linaro.org>
Date: Wed, 22 Oct 2025 00:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] media: iris: Move vpu register defines to common
 header file
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <YqjRCScxXDEPpVVaScQe2L-oTMtqW8BHl8RV49CNHptbE0idZxbYu1ZPJVzDfFtAd4o5U2Rba4x2evk_oA-k2A==@protonmail.internalid>
 <20251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2025 15:16, Vikash Garodia wrote:
> Some of vpu4 register defines are common with vpu3x. Move those into the
> common register defines header. This is done to reuse the defines for
> vpu4 in subsequent patch which enables the power sequence for vpu4.
> 
> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
>   .../platform/qcom/iris/iris_vpu_register_defines.h | 32 +++++++++++++++++++
>   3 files changed, 32 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 339776a0b4672e246848c3a6a260eb83c7da6a60..0ac6373c33b7ced75ac94ac86a1a8fc303f28b5d 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -11,48 +11,12 @@
>   #include "iris_vpu_common.h"
>   #include "iris_vpu_register_defines.h"
> 
> -#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> -#define AON_BASE_OFFS				0x000E0000
> -#define AON_MVP_NOC_RESET			0x0001F000
> -
> -#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> -#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> -#define REQ_POWER_DOWN_PREP			BIT(0)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> -#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
> -#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
> -#define NOC_LPI_STATUS_ACTIVE		BIT(2) /* Indicates the NOC is active */
> -#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
>   #define CORE_CLK_RUN				0x0
>   /* VPU v3.5 */
>   #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
> 
> -#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> -#define CTL_AXI_CLK_HALT			BIT(0)
> -#define CTL_CLK_HALT				BIT(1)
> -
> -#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
> -#define RESET_HIGH				BIT(0)
> -
> -#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
> -#define CORE_BRIDGE_SW_RESET			BIT(0)
> -#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
> -
> -#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> -#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> -#define MSK_CORE_POWER_ON			BIT(1)
> -
> -#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
>   #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
> 
> -#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
> -
> -#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> -#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> -
>   #define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
>   #define SW_RESET				BIT(0)
>   #define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index bbd999a41236dca5cf5700e452a6fed69f4fc922..a7b1fb8173e02d22e6f2af4ea170738c6408f65b 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -11,9 +11,6 @@
>   #include "iris_vpu_common.h"
>   #include "iris_vpu_register_defines.h"
> 
> -#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> -#define AON_BASE_OFFS				0x000E0000
> -
>   #define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
> 
>   #define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
> @@ -38,10 +35,6 @@
>   #define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
>   #define HOST2XTENSA_INTR_ENABLE			BIT(0)
> 
> -#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> -#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> -#define MSK_CORE_POWER_ON			BIT(1)
> -
>   #define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
>   #define CPU_IC_SOFTINT_H2A_SHFT			0x0
> 
> @@ -53,23 +46,7 @@
>   #define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
>   #define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
> 
> -#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> -#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> -
>   #define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
> -#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> -#define CTL_AXI_CLK_HALT			BIT(0)
> -#define CTL_CLK_HALT				BIT(1)
> -
> -#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
> -#define RESET_HIGH				BIT(0)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> -#define REQ_POWER_DOWN_PREP			BIT(0)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> 
>   static void iris_vpu_interrupt_init(struct iris_core *core)
>   {
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> index fe8a39e5e5a3fc68dc3a706ffdba07a5558163cf..bfe7ecceda894f6464970f9db2578c92dcb6c1ad 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> @@ -9,9 +9,41 @@
>   #define VCODEC_BASE_OFFS			0x00000000
>   #define CPU_BASE_OFFS				0x000A0000
>   #define WRAPPER_BASE_OFFS			0x000B0000
> +#define AON_BASE_OFFS				0x000E0000
> +#define AON_MVP_NOC_RESET			0x0001F000
> +#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> +
> +#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> +#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> +#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
> +#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
> 
>   #define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
> +#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
> +#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> +
> +#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
> 
> +#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> +#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
> +
> +#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> +#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> +#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> +#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
>   #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
> +#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
> +
> +#define CORE_BRIDGE_SW_RESET			BIT(0)
> +#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
> +#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> +#define MSK_CORE_POWER_ON			BIT(1)
> +#define CTL_AXI_CLK_HALT			BIT(0)
> +#define CTL_CLK_HALT				BIT(1)
> +#define REQ_POWER_DOWN_PREP			BIT(0)
> +#define RESET_HIGH				BIT(0)
> +#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
> +#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
> +#define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
> 
>   #endif
> 
> --
> 2.34.1
> 
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

