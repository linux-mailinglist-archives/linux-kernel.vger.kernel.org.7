Return-Path: <linux-kernel+bounces-846068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3AEBC6F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 01:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7642D402088
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 23:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F197204F8B;
	Wed,  8 Oct 2025 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiT2hoft"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770DB28D83F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759967451; cv=none; b=eeeqiu8XjdgXZzyF37f2cpp8CbU7Hko2H1x0dVfFGqBotWNanXm3J6W0TFl/i5lgZMgieJRzdnHbtds65MPsp/oMkvrlm9xfeCweLmFuuMdq9H0JXWHrnHFFVadBND6LxO8RjRXwbBfa06tnApc+Kinc4jw+mJGRnOwufk2n9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759967451; c=relaxed/simple;
	bh=PepEMbQ1yjF5c5BaPwxWL9iAuc14/s0OFz6xe0oNLLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRxhPuQQv6DGpTd6q2XF7/XMCF63lf6xnmY4VV51+3mMr6GF4aLmp263XsDd0ofrFaDGOCQU+yfD/mXreMvh2cjC2tQRJN6cl7LEBhKwIMcWAEOHiFxeCzKN+IBp1M74avhofX9zeQsnrYDrkRBPbNJWO8eE75hw9597uhCic3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiT2hoft; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so2219405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759967448; x=1760572248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+edhMv+0BzSlGdfFXwn7RqYiQQ8tm9NoUNnWq+dQx8=;
        b=eiT2hoftdsWDJpwlLiZY29yaf5Nj4ncn2jodcOcCvNdGSyQofbHk6NP8QPANN8rPVX
         HLcryKD8SyWF+xp0PUEEU/NkX7Qa6Gj/1uw9uL08Qdxy1Bgl2tcq/Ayds8GrAyUxDJmS
         Tlkws3LAL1hTP0YTcLLjilVrew+6H37br6yBj1VOtoqoym+qA1RIwa45oDgKyOosbkT2
         sSsrtn0LujDjCEZyh2NDkOL1haxzlDsAmL5+85uI0uaPHuXSUN3xKWUuvLFNWQiCtLvd
         1OuiyMydu/2cr++4M5XFXrDX/RyJQ3u/IJ4dr/H1K5+Y9qLI2q7sTRmgbYpv8J/k4SGc
         kwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759967448; x=1760572248;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+edhMv+0BzSlGdfFXwn7RqYiQQ8tm9NoUNnWq+dQx8=;
        b=DSK+mXImIJGWeWgk2erdx8DprqMFJQKJwar6hUxH9o9HJbJFMrxreCjwTHPouNqGOP
         wObwJtJkTAH+Gw2tXjskWCfG9cl/TEbLliGEuu5gglDcJNoDfgWoc1f9k5W0pQ1BgqE3
         aOim3TU330l4zhuwPmXjyx1H8WAYuG7xuxVgjoHrQKrPASXHLb9B4cX7nq7+zrrGvYNh
         FYVLxX87GgfXoszLwBLaHyG8fmIUKCVtwf7T+GhCLeRNlcweQIAqBMcB9tV0l0zHeKe0
         ZF00LdrTdUYY7ab3ZDUbhimeK+r/+zWKT06qRwqwHC6yeS7hY0h8m6SnciW/Y49MX7Eu
         Qtgw==
X-Forwarded-Encrypted: i=1; AJvYcCUX05pdAthSOueezIDxrOeqBKjsid5YmDJXQNCt7Y2/1uv3AE482IAG/HGSsrkDn1QxlFHz6CghC3xEIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNcml51iKaflNwbOw0CWvWcPN7V+gKgWC2IFalsK76kGSSvhK
	V95u3zUhPifqdbGIkXQQ3TTiDzZrG/OyaUhdL8LhD2rmXE87b9n+JnQpI9n7OaTuyNc=
X-Gm-Gg: ASbGncsJNP59yHkl/w34XJxiIG0yGa8lPWqjAxvQwBDgGIcH+tWng5udsWAJWI4Sr+i
	BUWz96xvErywoqIZQX5wwv/+XQlG/BcA29LpbofaMrB03B/1a4XK+XdhUdIRSQBr63xY5q/7AMp
	wJqj3W1yemMS16C22pSgRrZiS8Z3kR4Q29o6cSTxSjQGqCv/+jvxncUt4DC+bZAsoiaYJYyCTfA
	dU6XDMxbcnmnyxBduZQ4rXpmW552s9OxaDMEwm+lpFrSMvrHQbMOnRa/hQBSZT/Q6QyF7qhQoqi
	qplMls1lIwV+IRlEqCAljgGd7ADK64+QDUeRKppjzy1rhbOVWUapmXCjmnRUXKfBvTM+rPHgabR
	8Lm+uBj+jya0Bt/JWurcBuLOeqo3INQE2tjh1TqR/NKv+q7S8QAODPNQTNzBWyNHdcqMBAYxagN
	NdERiVlw11+7PwbEpx
X-Google-Smtp-Source: AGHT+IEpfshDCqBAHwNTTUCD0shn/QO6Rxgp954tKBhVfZ8/aMJ0AhoH55Q9PWrHm6CVn9Z286wuwA==
X-Received: by 2002:a05:600c:a41c:b0:46f:aac5:daf with SMTP id 5b1f17b1804b1-46faac50ea8mr23797905e9.35.1759967447736;
        Wed, 08 Oct 2025 16:50:47 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf7f80sm56797095e9.1.2025.10.08.16.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 16:50:46 -0700 (PDT)
Message-ID: <536e8aed-a25b-4beb-830d-9b073d02905e@linaro.org>
Date: Thu, 9 Oct 2025 00:50:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] media: iris: move common register definitions to the
 header
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <Upsv0z22Lrbf1B-YW_axrnAADZ6xN-nr46DpXCCNMZN5AHjEkowuebjDlRs7tpqRCSwQLaiKUk-_zMIdsd0YGg==@protonmail.internalid>
 <20251008-iris-sc7280-v1-7-def050ba5e1f@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251008-iris-sc7280-v1-7-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2025 05:33, Dmitry Baryshkov wrote:
> Simplify adding new platforms by moving common registers definitions
> from VPU 3.x and "common" file to the header with other register
> defines.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu3x.c      | 35 --------------
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 43 -----------------
>   .../platform/qcom/iris/iris_vpu_register_defines.h | 56 ++++++++++++++++++++++
>   3 files changed, 56 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 339776a0b4672e246848c3a6a260eb83c7da6a60..78aede9ac497abafc0545647c34a53c63c595f72 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -11,48 +11,13 @@
>   #include "iris_vpu_common.h"
>   #include "iris_vpu_register_defines.h"
> 
> -#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> -#define AON_BASE_OFFS				0x000E0000
>   #define AON_MVP_NOC_RESET			0x0001F000
> 
> -#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> -#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> -#define REQ_POWER_DOWN_PREP			BIT(0)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> -#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
> -#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
> -#define NOC_LPI_STATUS_ACTIVE		BIT(2) /* Indicates the NOC is active */
> -#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
> -#define CORE_CLK_RUN				0x0
> -/* VPU v3.5 */
> -#define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
> -
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
>   #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
>   #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
> 
>   #define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
> 
> -#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> -#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> -
>   #define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
>   #define SW_RESET				BIT(0)
>   #define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index bb98950e018fadf69ac4f41b3037f7fd6ac33c5b..2d6548e47d47967c1c110489cb8088130fb625fd 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -11,13 +11,6 @@
>   #include "iris_vpu_common.h"
>   #include "iris_vpu_register_defines.h"
> 
> -#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> -#define AON_BASE_OFFS				0x000E0000
> -
> -#define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
> -
> -#define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
> -#define CLEAR_XTENSA2HOST_INTR			BIT(0)
> 
>   #define CTRL_INIT				(CPU_CS_BASE_OFFS + 0x48)
>   #define CTRL_STATUS				(CPU_CS_BASE_OFFS + 0x4C)
> @@ -35,42 +28,6 @@
>   #define UC_REGION_ADDR				(CPU_CS_BASE_OFFS + 0x64)
>   #define UC_REGION_SIZE				(CPU_CS_BASE_OFFS + 0x68)
> 
> -#define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
> -#define HOST2XTENSA_INTR_ENABLE			BIT(0)
> -
> -#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> -#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> -#define MSK_CORE_POWER_ON			BIT(1)
> -
> -#define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
> -#define CPU_IC_SOFTINT_H2A_SHFT			0x0
> -
> -#define WRAPPER_INTR_STATUS			(WRAPPER_BASE_OFFS + 0x0C)
> -#define WRAPPER_INTR_STATUS_A2HWD_BMSK		BIT(3)
> -#define WRAPPER_INTR_STATUS_A2H_BMSK		BIT(2)
> -
> -#define WRAPPER_INTR_MASK			(WRAPPER_BASE_OFFS + 0x10)
> -#define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
> -#define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
> -
> -#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> -#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> -
> -#define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
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
> -
>   static void iris_vpu_interrupt_init(struct iris_core *core)
>   {
>   	u32 mask_val;
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> index fe8a39e5e5a3fc68dc3a706ffdba07a5558163cf..9955367a9f8179d2e364c41dcfe8ad445a0a13f4 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> @@ -9,9 +9,65 @@
>   #define VCODEC_BASE_OFFS			0x00000000
>   #define CPU_BASE_OFFS				0x000A0000
>   #define WRAPPER_BASE_OFFS			0x000B0000
> +#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> +#define AON_BASE_OFFS				0x000E0000
> +
> +#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
> 
>   #define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
> 
> +#define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
> +#define CLEAR_XTENSA2HOST_INTR			BIT(0)
> +
> +#define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
> +#define HOST2XTENSA_INTR_ENABLE			BIT(0)
> +
> +#define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
> +#define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
> +#define CPU_IC_SOFTINT_H2A_SHFT			0x0
> +
> +#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
> +#define CORE_BRIDGE_SW_RESET			BIT(0)
> +#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
> +
> +#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> +#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> +#define MSK_CORE_POWER_ON			BIT(1)
> +
> +#define WRAPPER_INTR_STATUS			(WRAPPER_BASE_OFFS + 0x0C)
> +#define WRAPPER_INTR_STATUS_A2HWD_BMSK		BIT(3)
> +#define WRAPPER_INTR_STATUS_A2H_BMSK		BIT(2)
> +
> +#define WRAPPER_INTR_MASK			(WRAPPER_BASE_OFFS + 0x10)
> +#define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
> +#define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
> +
>   #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
> +#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> +#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> +#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> +#define REQ_POWER_DOWN_PREP			BIT(0)
> +
> +#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> +#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
> +#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
> +#define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
> +
> +#define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
> +
> +#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
> +#define CORE_CLK_RUN				0x0
> +
> +#define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
> +
> +#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> +#define CTL_AXI_CLK_HALT			BIT(0)
> +#define CTL_CLK_HALT				BIT(1)
> +
> +#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
> +#define RESET_HIGH				BIT(0)
> +
> +#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> +#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> 
>   #endif
> 
> --
> 2.47.3
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

