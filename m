Return-Path: <linux-kernel+bounces-807981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62CDB4AB89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7307B9F63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D3321F24;
	Tue,  9 Sep 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbPRU7G8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BA31C587
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416796; cv=none; b=Sy3Ak0OoRvDk620wg7xSUgkwYYRsEbEwo7uUEDBA3hQLXu44Z5BcZOJRwtUdisS+3JuSWkBHhL2XX0Ac14OX9c2tn2Mm7f3w45Jvm86du3BLVHs0Ik9GKl/Iw4vhAf+TMK6i1t+f6AId6YiQyHnBJvvGTe0ppEx+/KSo/EM06Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416796; c=relaxed/simple;
	bh=4M1YgHT3LV6yyXXTA5Eblvj1pupiIOclR+QrmGk+Z64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gATQHvY/wLSV50YgdOzGnSkVPtUQ1gJqTPBrjbsZ42XGU3/cb20nfl03jwbU5P+KL9bq7U2WplZYbMOo9vKgkbvbocRtCyHoAQg2DcnDn8jN1A+nGeLFgp4KaZZa2AXmPVeqpzq60VR5Yf2NX6q/6MjVtM8tCNK2GxhaAmpC8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbPRU7G8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LSsU031513
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=q14H0KT1COSDYSRp0kk+HYET
	w3KiV71BJr5ELJZUOaU=; b=YbPRU7G8kgcfMyBcs0cpK74fK0Wq27pJqrjPwAFL
	jHn8H3TOyLZPmrsuPh+3o+j6OQcNODjqRxN6lqnXslf3vMLS0gRmxJMDQ0A/B0M0
	5D8Qx/tfKtQVCL40gEz2RxqKcxpIQITm45dw0WePWTwMWUoaMuTMLFFKJ9RT6fj2
	uHFAcrxteguq7WRx40QQgskdEK4rHplvrEWUDuXbeokAa8saflNdZJdr0xCAadav
	79Eng+5gPuqcGBfNAd8LOcNK4W8QkGlYKws9B5lB3TPwBSlAnC0XDIKVejEHdGxR
	QfQZMSbnk2Rd9ePNWJt3wve73zn7fKLCIaswm2NjV+xy8g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws841n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:19:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70fa9206690so110383556d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416792; x=1758021592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q14H0KT1COSDYSRp0kk+HYETw3KiV71BJr5ELJZUOaU=;
        b=WM8MckHKi7n8vqAwKNvD6xNkvY0Se1kjWDK8Y91omU4EpuyHwspZqzFw72SZCIUQtp
         86XXYK3VaiXAg+fJCCxm+dSqPjIoO/AIdYuRDom8tDkPz6ZgQJKp7wU6GopJzHtKu+5L
         9yfif1+SX+af/0//K/Oexa2eYCH1CXEBrjzM9vg53eUy2aYRMuNLg+NI5xKsUYCOwL84
         xM+JV19byKXKtuXp2RFQBWGefG/TJrPu6pnmJKDMrg8bsXXLTP1NA1bsHWL0WLnqyZhi
         fRZ1ctcbD16aHBQoEGCVB/fCmezXeIxMxHP2qekqGYjOpCbrNNUC3lGJOZPv1CUR+jA7
         o90g==
X-Forwarded-Encrypted: i=1; AJvYcCV4pRAPPacSzwEpYpzTJQqC4eskXCeda6gx8rwPCO4Beyi3L5tTeggvl0Bt8p3tNPqmq1O8YACbhh8be2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jwvv3rGUIk/uGFHv/v7flPNnx7gyzyjLWVX9bJevUNwISf+6
	GqElkUvoNc2CWe31kkFwXigW9dQgXaQub0h9LVsWcv/ibIRa9Fbix3eYkPut+3+dM/itlWgNv9u
	hQLRBLRWwhEy05dgr9lDLPtpDLDt6AXhLWkJSbXTgMkRXXC/Pfj8Ks+Y/QxFtsETpM6I=
X-Gm-Gg: ASbGncvATWX5QtUldkz6koEJtaa0Kky6cZjp2j0J6CEnO/WxdvNwaQ1+Hub4J9L047x
	bpI181ZvYbV6T3OwUCtiDMo7jpqUwAF5v9N7IuWhkhBZ6M0uBHz2ACst9ehOHDjCmNlYNoiq8mt
	zW8CszvNGdJd2/DjkgT45Xt0x5p/9FqzfBW4ntt+pPDDXSyM+dMpMcKZfQeyhxNXKm2LOoN57D9
	Y0cP8+T/AYYQgr8n5C1knR3T8ejdrP9KV8SCOQ2AIFa4zkpfgAvB7zpZ7/8yikr6TR2VdfZkFS6
	sOSr8x6LcI+4xSYQ2eO/RsWGqnwT9M2Ej9m6i509/9ZorjsYlrGiSRRoDd68TthndcWm7KXC0vs
	NlEZaQDp4cUmQcU+HhYu4M4mYzgbcB2wt5iNIhSS49jlFkP5ZeocK
X-Received: by 2002:a05:6214:224b:b0:715:538a:2fee with SMTP id 6a1803df08f44-72bc3373bb1mr136679776d6.20.1757416792221;
        Tue, 09 Sep 2025 04:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz8PDFRuBVWB09FnFcdYcVbjIUOegYWwGsl9hFOnuToizyvXk+fLn95vq1GBCcAt1nIqfWag==
X-Received: by 2002:a05:6214:224b:b0:715:538a:2fee with SMTP id 6a1803df08f44-72bc3373bb1mr136679576d6.20.1757416791580;
        Tue, 09 Sep 2025 04:19:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cce9f3csm458968e87.52.2025.09.09.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:19:50 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:19:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] phy: qcom-qmp: qserdes-com: Add v8 DP-specific
 qserdes register offsets
Message-ID: <3xw54kzk36u7zrfhgva4p577nzle3ctzi3lyhcxapczv2bhceo@23zcaylkqoff>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-2-02553381e47d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-phy-qcom-edp-add-glymur-support-v2-2-02553381e47d@linaro.org>
X-Proofpoint-ORIG-GUID: 4NqAGVYdxXOmwMZkZHqf27tE9qx8q0QS
X-Proofpoint-GUID: 4NqAGVYdxXOmwMZkZHqf27tE9qx8q0QS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX6mu4KhADqP6m
 IGzuFSkDjEYj9JSPflvxzEKz5MHqiB456U94U8E0q9gx0JQQK/4UoXD43wA+JPlTQeKQ/7UV0eH
 sMuxSJmaR7rhgHi2hAdWuij42hI04y3+IE/aQHcV+S7XhAMPsyTJtDJ7fz5s40s+Gyvm0JrEecw
 GIvB36hltZ/yG2PhpqgnnQWsHsPWDdC9W90pkwn3e6UIQPUkV9BmMkOsYqqKNMeq9IPt2PoX/7u
 MVjALdpqdsTZntCJqr6bg/Z93v28rztQCtXQDy2qJ34skD5s2t4DXIeWjSmQQTZaa4cyQ7OP1yu
 xbzPIjxDgrljgrWrWkrpwWbN1tc5MABYXwSzhFGz20i14JzwS3WaVOB/LcSU3VPjSQr3hsLuvTO
 HOdbYIrR
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c00d59 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=Et_T-Xu_rDMQo3vlGccA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Tue, Sep 09, 2025 at 01:07:27PM +0300, Abel Vesa wrote:
> Starting with Glymur, the PCIe and DP PHYs qserdes register offsets differ
> for the same version number. So in order to be able to differentiate
> between them, add these ones with DP prefix.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2bef1eecdc56a75e954ebdbcd168ab7306be1302
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Linaro Ltd.
> + */
> +
> +#ifndef QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
> +#define QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
> +
> +/* Only for DP QMP V8 PHY - QSERDES COM registers */
> +#define DP_QSERDES_V8_COM_HSCLK_SEL_1			0x03c
> +#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
> +#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
> +#define DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0		0x060
> +#define DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0		0x064
> +#define DP_QSERDES_V8_COM_CP_CTRL_MODE0			0x070
> +#define DP_QSERDES_V8_COM_PLL_RCTRL_MODE0		0x074
> +#define DP_QSERDES_V8_COM_PLL_CCTRL_MODE0		0x078
> +#define DP_QSERDES_V8_COM_CORECLK_DIV_MODE0		0x07c
> +#define DP_QSERDES_V8_COM_LOCK_CMP1_MODE0		0x080
> +#define DP_QSERDES_V8_COM_LOCK_CMP2_MODE0		0x084
> +#define DP_QSERDES_V8_COM_DEC_START_MODE0		0x088
> +#define DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
> +#define DP_QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
> +#define DP_QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
> +#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
> +#define DP_QSERDES_V8_COM_VCO_TUNE1_MODE0		0x0a8
> +#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
> +#define DP_QSERDES_V8_COM_VCO_TUNE2_MODE0		0x0ac
> +#define DP_QSERDES_V8_COM_BG_TIMER			0x0bc
> +#define DP_QSERDES_V8_COM_SSC_EN_CENTER			0x0c0
> +#define DP_QSERDES_V8_COM_SSC_ADJ_PER1			0x0c4
> +#define DP_QSERDES_V8_COM_SSC_PER1			0x0cc
> +#define DP_QSERDES_V8_COM_SSC_PER2			0x0d0
> +#define DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
> +#define DP_QSERDES_V8_COM_CLK_ENABLE1			0x0e0
> +#define DP_QSERDES_V8_COM_SYS_CLK_CTRL			0x0e4
> +#define DP_QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
> +#define DP_QSERDES_V8_COM_PLL_IVCO			0x0f4
> +#define DP_QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
> +#define DP_QSERDES_V8_COM_RESETSM_CNTRL			0x118
> +#define DP_QSERDES_V8_COM_LOCK_CMP_EN			0x120
> +#define DP_QSERDES_V8_COM_VCO_TUNE_CTRL			0x13c
> +#define DP_QSERDES_V8_COM_VCO_TUNE_MAP			0x140
> +#define DP_QSERDES_V8_COM_CLK_SELECT			0x164
> +#define DP_QSERDES_V8_COM_CORE_CLK_EN			0x170
> +#define DP_QSERDES_V8_COM_CMN_CONFIG_1			0x174

The registers are the same at least up to this point. Would it make
sense to keep common part in the same header and define only those bits
that actually differ between DP and PCIe parts? (Is it really about PCIe
or is it eDP vs everything else?)

> +#define DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL		0x180
> +#define DP_QSERDES_V8_COM_CLK_FWD_CONFIG_1		0x2f4
> +#define DP_QSERDES_V8_COM_CMN_STATUS			0x314
> +#define DP_QSERDES_V8_COM_C_READY_STATUS		0x33c
> +
> +#endif
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

