Return-Path: <linux-kernel+bounces-861667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE0BF34D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2621883A47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C557D07D;
	Mon, 20 Oct 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYC4en2d"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EA3314D9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990320; cv=none; b=J8OT1DVFpuVblF4kq0W/P4P734Tq4utEEevRtDKiB5p4OAdCo9cUI4f2upN2Q2J0j01WpXOpsuKnah9ZrvqMdK0iDt9JdxydUcGP2YVWREAMsv90CTKlAsDyJKlc9yuad4hNcWKTPgBq0PBQS/Z7qRO/nbcXSoagEh1hcMq86zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990320; c=relaxed/simple;
	bh=XCwZUqmeuiWU9rzvvTjeRrWJQNzR4cssdIIcfiHwpwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJHOv1eLzWGU/6En1pEASRZFeBQTgJK5CMO1yOELsYQc4lLKnbvEnpC65oAbDw5uHiaznZAE0L+phNZgdX70fdikpA0dZkKsBvNhNYQCyk99lJRZhzKruv3rDUCngO4jb6GK/ghskLVtwjbyzHC31fpVqsIw3mdDWUBKHXoJGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OYC4en2d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso4469733f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760990316; x=1761595116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uTinkD5B7JVzNdslTmORFgXTh2TMp+mH7Qm01R70EU=;
        b=OYC4en2dfXk3ze30N75A/w+tJC+/soiB5y7w7PaXlTgoBxQIHJd5DMBmWHPvKF8gqS
         P585TkV0rmqX78kyhavNRvMnsEJjnDstQKcsctSraHtOaqA/HjzoDLd418EcmsdY8Zjb
         ifkqURUVPW7/5OJOnEalXhskSmiZN5lt0Bc7STh5qXgs3GQ+jmHDeNlsQNN3v9Qz1bsz
         /rqXzCPwaYwGXFYRx97i8xN/CV1P/onX3SkbR9SQpXQYHBIPNFfXlaupQQ4G7M9CmRpO
         0m60FbGQnoOwe4BsStVpVtnM7grhmAsfJoFtudHbKYVMinvahDbUvMqNUsTiY3EnBDzS
         E6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990316; x=1761595116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uTinkD5B7JVzNdslTmORFgXTh2TMp+mH7Qm01R70EU=;
        b=eW33Ad/wfH1TIiZjCRdpIlgxLgl5g5TYOj1vPRiIvQi83n55rHa2SQruBUOHfS5GJA
         IDIuxxDwkOpKtE8PhyaifsNQYGnDecWf3C9YhWCx6wPa36+bkTiTKygyFC6UOKnWHqeJ
         2fzqug/vX+0LeeNstJ4B5oOycX/ODDsZaBLm+I9uIt+CMjo8kks7bReFw4+0IyIrG5bx
         e+/MrqwKu6mP7cua0OkJm6sSxUw+r74K9CQ4mf4+cdt3tZO8uCzsWbj/RVuGu9p7XyzB
         S4oqsyg5K4bVHUUgmZQeAV+lZmSVmyE3KSZ4Que/Nt6Z71Bj6EwUxTg6joZHScs4iKAt
         YpCw==
X-Gm-Message-State: AOJu0YxI4HQW1G/QyMOwuKSzAzG69b9z35CCe45/5wy1H9qZzn4FDtIs
	BbAPDSD6YVmQsN600mUnh4pL86+mHpSWd/RKTisyw3LmsDobwdK04spMouPPLtxbRAE=
X-Gm-Gg: ASbGncsEKhJhxqdM177b28IE2tFKYpP7HnxSczwB8CDBqEpLCQ4xhrPq2rHrXch0gLj
	CktuSX4C0mrMUvxqwUpXG5DR0NNM2aNj9o5ayQ5EkBNiSyIW6djov951dQhsrHPBypK88bahbSw
	8vYz3G3tP7sSv6R4dUC0+Lcu9gvIfFKWhQtdPBAhm8tQ1bf4Dlt11sMjZSRnl2qDNBXnW8RPXL9
	o52cRNJm2f2kc1Vd8x25QrH+Tkh0RP2yuISIGufKo2LA4bsa77B5+jOwoYGGhwpI5xEgJ275I3z
	WlJ5pIE/Eqbba1W+b3UEyhV7HPEhwvsKAneBoo9tI0+jBr5fGYs5nh8Posl+oSkCP8zZPryMcCm
	2FstgWxKbej7XzB43wJMECc3YBy3ls79kgSE9nQIutoeWCp+v+Kz2Y9ULRsnxHXMbn6nLUj/QTN
	NJxdIperCebw6D5qj9kna1Ps9Qd7puve3fUDdwSyORA5kmTsfdRtl/yg==
X-Google-Smtp-Source: AGHT+IHRepbyzVss0eYQtswrWO7IT6VNUaNhd8KrgYXyrpmN/FQ0ZkZPVw//zKELs8RT7Eu0xlFMJQ==
X-Received: by 2002:a5d:5f82:0:b0:425:86c8:c4ff with SMTP id ffacd0b85a97d-42704d90011mr10997285f8f.22.1760990315993;
        Mon, 20 Oct 2025 12:58:35 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a78csm16686345f8f.26.2025.10.20.12.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:58:34 -0700 (PDT)
Message-ID: <028a884c-1d53-46c7-8e9e-a076fd87510f@linaro.org>
Date: Mon, 20 Oct 2025 20:58:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] media: qcom: camss: tpg: Add TPG support for
 LeMans and Monaco
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20251017-camss_tpg-v5-0-cafe3ad42163@oss.qualcomm.com>
 <20251017-camss_tpg-v5-3-cafe3ad42163@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017-camss_tpg-v5-3-cafe3ad42163@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2025 06:06, Wenmeng Liu wrote:
> Add support for TPG found on LeMans and Monaco.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/camss/Makefile         |   1 +
>   .../media/platform/qcom/camss/camss-csid-gen3.c    |  17 ++
>   drivers/media/platform/qcom/camss/camss-tpg-gen1.c | 220 +++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.c          |  67 +++++++
>   4 files changed, 305 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
> index 0eda4b18ad0e93f5e63135fabd5a02ae67bcd5ad..28bc3d9ba16dfa34a8fd35973beed0c3f2b67e00 100644
> --- a/drivers/media/platform/qcom/camss/Makefile
> +++ b/drivers/media/platform/qcom/camss/Makefile
> @@ -27,5 +27,6 @@ qcom-camss-objs += \
>   		camss-video.o \
>   		camss-format.o \
>   		camss-tpg.o \
> +		camss-tpg-gen1.o \
>   
>   obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> index 664245cf6eb0cac662b02f8b920cd1c72db0aeb2..8e0b0cbaa0010f4b4a156877ac2fe805e5c4422e 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> @@ -66,6 +66,8 @@
>   #define		CSI2_RX_CFG0_VC_MODE		3
>   #define		CSI2_RX_CFG0_DL0_INPUT_SEL	4
>   #define		CSI2_RX_CFG0_PHY_NUM_SEL	20
> +#define		CSI2_RX_CFG0_TPG_NUM_EN		27
> +#define		CSI2_RX_CFG0_TPG_NUM_SEL	28
>   
>   #define CSID_CSI2_RX_CFG1		0x204
>   #define		CSI2_RX_CFG1_ECC_CORRECTION_EN	BIT(0)
> @@ -109,11 +111,26 @@ static void __csid_configure_rx(struct csid_device *csid,
>   				struct csid_phy_config *phy, int vc)
>   {
>   	int val;
> +	struct camss *camss;
> +	struct tpg_device *tpg;
>   
> +	camss = csid->camss;
>   	val = (phy->lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
>   	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
>   	val |= (phy->csiphy_id + CSI2_RX_CFG0_PHY_SEL_BASE_IDX) << CSI2_RX_CFG0_PHY_NUM_SEL;
>   
> +	if (camss->tpg) {
> +		tpg = &camss->tpg[phy->csiphy_id];
> +
> +		if (tpg->testgen.mode > 0) {
> +			val |= (phy->csiphy_id + 1) << CSI2_RX_CFG0_TPG_NUM_SEL;
> +			val |= 1 << CSI2_RX_CFG0_TPG_NUM_EN;
> +		} else {
> +			val |= 0 << CSI2_RX_CFG0_TPG_NUM_SEL;
> +			val |= 0 << CSI2_RX_CFG0_TPG_NUM_EN;

Zero shifted by any amount is still zero.

Do you mean to negate these bits val &= ~ (CSI2_RX_CFG0_TPG_NUM_SEL |
                                            CSI2_RX_CFG0_TPG_NUM_EN );

Anyway I see the pattern we have, perhaps am guilty of its perpetuation, 
also am requesting its termination.

Please do something more sensible with these bits.
> +		}
> +	}
> +
>   	writel(val, csid->base + CSID_CSI2_RX_CFG0);
>   
>   	val = CSI2_RX_CFG1_ECC_CORRECTION_EN;
> diff --git a/drivers/media/platform/qcom/camss/camss-tpg-gen1.c b/drivers/media/platform/qcom/camss/camss-tpg-gen1.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ba463c16a8436cb40c61d1b483c6343c010b9744
> --- /dev/null
> +++ b/drivers/media/platform/qcom/camss/camss-tpg-gen1.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * Qualcomm MSM Camera Subsystem - TPG (Test Patter Generator) Module
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/completion.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +
> +#include "camss-tpg.h"
> +#include "camss.h"
> +
> +#define TPG_HW_VERSION		0x0
> +# define HW_VERSION_STEPPING		GENMASK(15, 0)
> +# define HW_VERSION_REVISION		GENMASK(27, 16)
> +# define HW_VERSION_GENERATION		GENMASK(31, 28)
> +
> +#define TPG_HW_STATUS		0x4
> +
> +#define TPG_VC_n_GAIN_CFG(n)		(0x60 + (n) * 0x60)
> +
> +#define TPG_CTRL		0x64
> +# define TPG_CTRL_TEST_EN		BIT(0)
> +# define TPG_CTRL_PHY_SEL		BIT(3)
> +# define TPG_CTRL_NUM_ACTIVE_LANES	GENMASK(5, 4)
> +# define TPG_CTRL_VC_DT_PATTERN_ID	GENMASK(8, 6)
> +# define TPG_CTRL_OVERLAP_SHDR_EN	BIT(10)
> +# define TPG_CTRL_NUM_ACTIVE_VC		GENMASK(31, 30)
> +#  define NUM_ACTIVE_VC_0_ENABLED		0
> +#  define NUM_ACTIVE_VC_0_1_ENABLED		1
> +#  define NUM_ACTIVE_VC_0_1_2_ENABLED		2
> +#  define NUM_ACTIVE_VC_0_1_3_ENABLED		3
> +
> +#define TPG_VC_n_CFG0(n)	(0x68 + (n) * 0x60)
> +# define TPG_VC_n_CFG0_VC_NUM			GENMASK(4, 0)
> +# define TPG_VC_n_CFG0_NUM_ACTIVE_DT		GENMASK(9, 8)
> +#  define NUM_ACTIVE_SLOTS_0_ENABLED			0
> +#  define NUM_ACTIVE_SLOTS_0_1_ENABLED			1
> +#  define NUM_ACTIVE_SLOTS_0_1_2_ENABLED		2
> +#  define NUM_ACTIVE_SLOTS_0_1_3_ENABLED		3
> +# define TPG_VC_n_CFG0_NUM_BATCH		GENMASK(15, 12)
> +# define TPG_VC_n_CFG0_NUM_FRAMES		GENMASK(31, 16)
> +
> +#define TPG_VC_n_LSFR_SEED(n)	(0x6C + (n) * 0x60)
> +
> +#define TPG_VC_n_HBI_CFG(n)	(0x70 + (n) * 0x60)
> +
> +#define TPG_VC_n_VBI_CFG(n)	(0x74 + (n) * 0x60)
> +
> +#define TPG_VC_n_COLOR_BARS_CFG(n)		(0x78 + (n) * 0x60)
> +# define TPG_VC_n_COLOR_BARS_CFG_PIX_PATTERN		GENMASK(2, 0)
> +# define TPG_VC_n_COLOR_BARS_CFG_QCFA_EN		BIT(3)
> +# define TPG_VC_n_COLOR_BARS_CFG_SPLIT_EN		BIT(4)
> +# define TPG_VC_n_COLOR_BARS_CFG_NOISE_EN		BIT(5)
> +# define TPG_VC_n_COLOR_BARS_CFG_ROTATE_PERIOD		GENMASK(13, 8)
> +# define TPG_VC_n_COLOR_BARS_CFG_XCFA_EN		BIT(16)
> +# define TPG_VC_n_COLOR_BARS_CFG_SIZE_X			GENMASK(26, 24)
> +# define TPG_VC_n_COLOR_BARS_CFG_SIZE_Y			GENMASK(30, 28)
> +
> +#define TPG_VC_m_DT_n_CFG_0(m, n)		(0x7C + (m) * 0x60 + (n) * 0xC)
> +# define TPG_VC_m_DT_n_CFG_0_FRAME_HEIGHT	GENMASK(15, 0)
> +# define TPG_VC_m_DT_n_CFG_0_FRAME_WIDTH	GENMASK(31, 16)
> +
> +#define TPG_VC_m_DT_n_CFG_1(m, n)		(0x80 + (m) * 0x60 + (n) * 0xC)
> +# define TPG_VC_m_DT_n_CFG_1_DATA_TYPE		GENMASK(5, 0)
> +# define TPG_VC_m_DT_n_CFG_1_ECC_XOR_MASK	GENMASK(13, 8)
> +# define TPG_VC_m_DT_n_CFG_1_CRC_XOR_MASK	GENMASK(31, 16)
> +
> +#define TPG_VC_m_DT_n_CFG_2(m, n)		(0x84 + (m) * 0x60 + (n) * 0xC)
> +# define TPG_VC_m_DT_n_CFG_2_PAYLOAD_MODE		GENMASK(3, 0)
> +# define TPG_VC_m_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD	GENMASK(27, 4)
> +# define TPG_VC_m_DT_n_CFG_2_ENCODE_FORMAT		GENMASK(31, 28)
> +
> +#define TPG_VC_n_COLOR_BAR_CFA_COLOR0(n)	(0xB0 + (n) * 0x60)
> +#define TPG_VC_n_COLOR_BAR_CFA_COLOR1(n)	(0xB4 + (n) * 0x60)
> +#define TPG_VC_n_COLOR_BAR_CFA_COLOR2(n)	(0xB8 + (n) * 0x60)
> +#define TPG_VC_n_COLOR_BAR_CFA_COLOR3(n)	(0xBC + (n) * 0x60)
> +
> +/* Line offset between VC(n) and VC(n-1), n form 1 to 3 */
> +#define TPG_VC_n_SHDR_CFG	(0x84 + (n) * 0x60)
> +
> +#define TPG_CLEAR		0x1F4
> +
> +#define TPG_USER_SPECIFIED_PAYLOAD_DEFAULT	0xBE
> +#define TPG_HBI_CFG_DEFAULT			0x4701
> +#define TPG_VBI_CFG_DEFAULT			0x438

Offsets are fine to define but magic value numbers are not welcome. You 
only have to define five bits and four bits respectively i.e. the bits 
you use but, for preference you should define all of the fields.

> +#define TPG_LFSR_SEED_DEFAULT			0x12345678
> +#define TPG_COLOR_BARS_CFG_STANDARD \
> +	FIELD_PREP(TPG_VC_n_COLOR_BARS_CFG_ROTATE_PERIOD, 0xA)
> +
> +static int tpg_stream_on(struct tpg_device *tpg)
> +{
> +	struct tpg_testgen_config *tg = &tpg->testgen;
> +	struct v4l2_mbus_framefmt *input_format;
> +	const struct tpg_format_info *format;
> +	u8 lane_cnt = tpg->res->lane_cnt;
> +	u8 dt_cnt = 0;
> +	u8 i;
> +	u32 val;
> +
> +	/* Loop through all enabled VCs and configure stream for each */
> +	for (i = 0; i < tpg->res->vc_cnt; i++) {
> +		input_format = &tpg->fmt[MSM_TPG_PAD_SRC + i];
> +		format = tpg_get_fmt_entry(tpg,
> +					   tpg->res->formats->formats,
> +					   tpg->res->formats->nformats,
> +					   input_format->code);
> +
> +		val = FIELD_PREP(TPG_VC_m_DT_n_CFG_0_FRAME_HEIGHT, input_format->height & 0xffff) |
> +		      FIELD_PREP(TPG_VC_m_DT_n_CFG_0_FRAME_WIDTH, input_format->width & 0xffff);
> +		writel(val, tpg->base + TPG_VC_m_DT_n_CFG_0(i, dt_cnt));
> +
> +		val = FIELD_PREP(TPG_VC_m_DT_n_CFG_1_DATA_TYPE, format->data_type);
> +		writel(val, tpg->base + TPG_VC_m_DT_n_CFG_1(i, dt_cnt));
> +
> +		val = FIELD_PREP(TPG_VC_m_DT_n_CFG_2_PAYLOAD_MODE, tg->mode - 1) |
> +		      FIELD_PREP(TPG_VC_m_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD,
> +				 TPG_USER_SPECIFIED_PAYLOAD_DEFAULT) |
> +		      FIELD_PREP(TPG_VC_m_DT_n_CFG_2_ENCODE_FORMAT, format->encode_format);
> +		writel(val, tpg->base + TPG_VC_m_DT_n_CFG_2(i, dt_cnt));
> +
> +		writel(TPG_COLOR_BARS_CFG_STANDARD, tpg->base + TPG_VC_n_COLOR_BARS_CFG(i));
> +
> +		writel(TPG_HBI_CFG_DEFAULT, tpg->base + TPG_VC_n_HBI_CFG(i));
> +		writel(TPG_VBI_CFG_DEFAULT, tpg->base + TPG_VC_n_VBI_CFG(i));
> +
> +		writel(TPG_LFSR_SEED_DEFAULT, tpg->base + TPG_VC_n_LSFR_SEED(i));
> +
> +		/* configure one DT, infinite frames */
> +		val = FIELD_PREP(TPG_VC_n_CFG0_VC_NUM, i) |
> +		      FIELD_PREP(TPG_VC_n_CFG0_NUM_FRAMES, 0);
> +		writel(val, tpg->base + TPG_VC_n_CFG0(i));
> +	}
> +
> +	val = FIELD_PREP(TPG_CTRL_TEST_EN, 1) |
> +		  FIELD_PREP(TPG_CTRL_PHY_SEL, 0) |
> +		  FIELD_PREP(TPG_CTRL_NUM_ACTIVE_LANES, lane_cnt - 1) |
> +		  FIELD_PREP(TPG_CTRL_VC_DT_PATTERN_ID, 0) |
> +		  FIELD_PREP(TPG_CTRL_NUM_ACTIVE_VC, tpg->res->vc_cnt - 1);
> +	writel(val, tpg->base + TPG_CTRL);
> +
> +	return 0;
> +}
> +
> +static void tpg_stream_off(struct tpg_device *tpg)
> +{
> +	writel(0, tpg->base + TPG_CTRL);
> +	writel(1, tpg->base + TPG_CLEAR);
> +}
> +
> +static void tpg_configure_stream(struct tpg_device *tpg, u8 enable)
> +{
> +	if (enable)
> +		tpg_stream_on(tpg);
> +	else
> +		tpg_stream_off(tpg);
> +}
> +
> +static int tpg_configure_testgen_pattern(struct tpg_device *tpg, s32 val)
> +{
> +	if (val > 0 && val <= TPG_PAYLOAD_MODE_COLOR_BARS)
> +		tpg->testgen.mode = val;
> +
> +	return 0;
> +}
> +
> +/*
> + * tpg_hw_version - tpg hardware version query
> + * @tpg: tpg device
> + *
> + * Return HW version or error
> + */
> +static u32 tpg_hw_version(struct tpg_device *tpg)
> +{
> +	u32 hw_version;
> +	u32 hw_gen;
> +	u32 hw_rev;
> +	u32 hw_step;
> +
> +	hw_version = readl(tpg->base + TPG_HW_VERSION);
> +	hw_gen = FIELD_GET(HW_VERSION_GENERATION, hw_version);
> +	hw_rev = FIELD_GET(HW_VERSION_REVISION, hw_version);
> +	hw_step = FIELD_GET(HW_VERSION_STEPPING, hw_version);
> +	dev_dbg_once(tpg->camss->dev, "tpg HW Version = %u.%u.%u\n",
> +		     hw_gen, hw_rev, hw_step);
> +
> +	return hw_version;
> +}
> +
> +/*
> + * tpg_reset - Trigger reset on tpg module and wait to complete
> + * @tpg: tpg device
> + *
> + * Return 0 on success or a negative error code otherwise
> + */
> +static int tpg_reset(struct tpg_device *tpg)
> +{
> +	writel(0, tpg->base + TPG_CTRL);
> +	writel(1, tpg->base + TPG_CLEAR);
> +
> +	return 0;
> +}
> +
> +static void tpg_subdev_init(struct tpg_device *tpg)
> +{
> +	tpg->testgen.modes = testgen_payload_modes;
> +	tpg->testgen.nmodes = TPG_PAYLOAD_MODE_NUM_SUPPORTED_GEN1;
> +}
> +
> +const struct tpg_hw_ops tpg_ops_gen1 = {
> +	.configure_stream = tpg_configure_stream,
> +	.configure_testgen_pattern = tpg_configure_testgen_pattern,
> +	.hw_version = tpg_hw_version,
> +	.reset = tpg_reset,
> +	.subdev_init = tpg_subdev_init,
> +};
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 2ede19e1347ae32f2f6919905b535352bcd134be..446d3fb94f35412178b72c803274a5159c57c852 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -2745,6 +2745,62 @@ static const struct camss_subdev_resources csiphy_res_8775p[] = {
>   	},
>   };
>   
> +static const struct camss_subdev_resources tpg_res_8775p[] = {
> +	/* TPG0 */
> +	{
> +		.regulators = {  },
> +		.clock = { "csiphy_rx", "camnoc_axi" },
> +		.clock_rate = {
> +			{ 400000000 },
> +			{ 400000000 },
> +		},
> +		.reg = { "tpg0" },
> +		.interrupt = { "tpg0" },
> +		.tpg = {
> +			.lane_cnt = 4,
> +			.vc_cnt = 1,
> +			.formats = &tpg_formats_gen1,
> +			.hw_ops = &tpg_ops_gen1
> +		}
> +	},
> +
> +	/* TPG1 */
> +	{
> +		.regulators = {  },
> +		.clock = { "csiphy_rx", "camnoc_axi" },
> +		.clock_rate = {
> +			{ 400000000 },
> +			{ 400000000 },
> +		},
> +		.reg = { "tpg1" },
> +		.interrupt = { "tpg1" },
> +		.tpg = {
> +			.lane_cnt = 4,
> +			.vc_cnt = 1,
> +			.formats = &tpg_formats_gen1,
> +			.hw_ops = &tpg_ops_gen1
> +		}
> +	},
> +
> +	/* TPG2 */
> +	{
> +		.regulators = {  },
> +		.clock = { "csiphy_rx", "camnoc_axi" },
> +		.clock_rate = {
> +			{ 400000000 },
> +			{ 400000000 },
> +		},
> +		.reg = { "tpg2" },
> +		.interrupt = { "tpg2" },
> +		.tpg = {
> +			.lane_cnt = 4,
> +			.vc_cnt = 1,
> +			.formats = &tpg_formats_gen1,
> +			.hw_ops = &tpg_ops_gen1
> +		}
> +	},
> +};
> +
>   static const struct camss_subdev_resources csid_res_8775p[] = {
>   	/* CSID0 */
>   	{
> @@ -4217,6 +4273,13 @@ static int camss_probe(struct platform_device *pdev)
>   	if (!camss->csiphy)
>   		return -ENOMEM;
>   
> +	if (camss->res->tpg_num > 0) {
> +		camss->tpg = devm_kcalloc(dev, camss->res->tpg_num,
> +					  sizeof(*camss->tpg), GFP_KERNEL);
> +		if (!camss->tpg)
> +			return -ENOMEM;
> +	}
> +
>   	camss->csid = devm_kcalloc(dev, camss->res->csid_num, sizeof(*camss->csid),
>   				   GFP_KERNEL);
>   	if (!camss->csid)
> @@ -4394,11 +4457,13 @@ static const struct camss_resources qcs8300_resources = {
>   	.version = CAMSS_8300,
>   	.pd_name = "top",
>   	.csiphy_res = csiphy_res_8300,
> +	.tpg_res = tpg_res_8775p,
>   	.csid_res = csid_res_8775p,
>   	.csid_wrapper_res = &csid_wrapper_res_sm8550,
>   	.vfe_res = vfe_res_8775p,
>   	.icc_res = icc_res_qcs8300,
>   	.csiphy_num = ARRAY_SIZE(csiphy_res_8300),
> +	.tpg_num = ARRAY_SIZE(tpg_res_8775p),
>   	.csid_num = ARRAY_SIZE(csid_res_8775p),
>   	.vfe_num = ARRAY_SIZE(vfe_res_8775p),
>   	.icc_path_num = ARRAY_SIZE(icc_res_qcs8300),
> @@ -4408,11 +4473,13 @@ static const struct camss_resources sa8775p_resources = {
>   	.version = CAMSS_8775P,
>   	.pd_name = "top",
>   	.csiphy_res = csiphy_res_8775p,
> +	.tpg_res = tpg_res_8775p,
>   	.csid_res = csid_res_8775p,
>   	.csid_wrapper_res = &csid_wrapper_res_sm8550,
>   	.vfe_res = vfe_res_8775p,
>   	.icc_res = icc_res_sa8775p,
>   	.csiphy_num = ARRAY_SIZE(csiphy_res_8775p),
> +	.tpg_num = ARRAY_SIZE(tpg_res_8775p),
>   	.csid_num = ARRAY_SIZE(csid_res_8775p),
>   	.vfe_num = ARRAY_SIZE(vfe_res_8775p),
>   	.icc_path_num = ARRAY_SIZE(icc_res_sa8775p),
> 


