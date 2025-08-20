Return-Path: <linux-kernel+bounces-777606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4DB2DB93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B88177249
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9432E339C;
	Wed, 20 Aug 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fj0EFRd6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FF2E2EED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690453; cv=none; b=Ima++85KpluK52EcP9yNW0Mfy6G/gQk320lFxzDgg02eBaKOS3Ke367cImVy1CpHSeof9/tZV5vyqmSJtNN7jlxnczcW7c48SxGIcrROFpKnSgTKH2v7aohFQFSssj+GIMvYfTXycLPRCTXFEzRC58ETocV7tk2A7WZlQpWMuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690453; c=relaxed/simple;
	bh=rqP7bdnWmvdLNH+wGeeBYQkO7IqJVLQXu/rfwzWsYlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrMjNJjnCzqZwmxnkaY33DoxspcYH23KYkQIJxw2M8idm1uvM0N8CBXsxuc7kdy4XkuhHSADa3M8p9C35CRQe6Ck0ZtDhgU3Rm6HBZSe5uJ6GRZiKKAPyLB7hOSkB3zOpmSNkeL98B1st93FZx9xZJqV2ho+f7QkaLn304SyagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fj0EFRd6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KACkpN031033
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dFc4IH/0HHEYW2zGgPx9oUd1
	ai5FCg3dSwI1TYF3zRA=; b=fj0EFRd64mA+29oBybgkCVSDClAeX2cpVe/JJ+lY
	ybKS2lKptFDXF+W36AaL8Z/4b8ujhEqHlvJFA+8BwmoEUvFU6ugNCOOBqE4Gk9tZ
	LaV+nX6UBN6e56o3l2QkykgRXIUeFRM+qQhrLlWnUaSmM06ehbpCitK700fj4/Ob
	bkNueSH5OJ4ulXd/qK7JQqPRjPc2dFhKavJAUf65g2r5wIt4zCHyT2xFQ4MzrRMI
	0B/r0m64I02uycCk0vw0p8rTbIFURSFW50OGz/IJSamZkA43D+SsQ/6OJyr4a222
	Jgt0i10jklvZUdAPxPJxpbRoB+b0h88g5COwO949pR8ksw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dhhpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:47:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88daeb18so140306906d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690448; x=1756295248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFc4IH/0HHEYW2zGgPx9oUd1ai5FCg3dSwI1TYF3zRA=;
        b=lS0uITf+R76HfdZfzLx1GJZHbqByhJT4QbfQh48LK66E3O0X7qSvx/qB49/JHRGtqS
         r0yH3Qq1BRUnYCzNVGktJjtFrcaI41ydyN1a7AzGDTK3ct3/K5AmGx1Rs5TX6kHfXDTJ
         xYgYvtW2Ra5EhLxAXVO7XKMEWAXSkicTVIuGUTcKZM1Dt27r5PDPBJa63uRHZSxht4xJ
         BwfntkJtpwzUPiBEOzSQX+Vc0prJn9ooqGQqtwrT0WcmflfH8OzgNpxugw91G3qSN/lQ
         HOMV/Fb9PWX8tr/1OP9V7wLSaKqsy8fWMdMvFSkdNiB/DRNCVpFY52SadpY5COOGDgl2
         DMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIhufgDfxYtzy7lrSoldA7Zc5jFimP1cDy8V4z6EBCpB+sLVjv+8UksulzgPXqCbDeH56oj0nxI1lyFNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQBKptvJF5PH2nTCbOJHvwByOjVZms+5NI6JfEhQ3MPFlC5d7
	EXZYByji6vbFTUHcI0IE4IoeXh1N8jyum/V8AIBierqeiq4g1K3DhIpZ0l9Um4EVBgUV//uXdpe
	KivXNB5MwqOVXdEsf296CIoi3X+2Pkr2jTKn0UAfh60k/1V+Yd/BTWvddK3QWmF32ZWM=
X-Gm-Gg: ASbGnctw2O+QaHtThTRhai9Y30JrZPhP/IAdTVtghI51eUNJEw2pW2lyCMRiPLwWdx0
	W9/yiEzHyGl6uIJdBTJ5tom2BbXiE9CpTwowGnZNvh9xwgzt/xxbkELCJF9nfqzROF7vnOHMH0k
	qWvy6zF6uBOCxE7hD0o7eDgKSZzqRJFpZBvJx2Fdm3xEVSQRTuC1pCrpQVaVFRyokjC3zroL7OH
	Aw52u6f+8kAa8hsSeXIn5KVKAn1eN7rYimwmJ2s+oB2W4JhHOWBZD3Y7PQGMggV6saoqBOhw5Nc
	b6L4zSyODXnR2CwrrpX3bZP0+mZuO3gix8laCOzvlEZmUUIi8+T4JvzxfkX/ZkqAA15ajJ63ovB
	v0CcArA4A2TrmsmqYbuiGr3bMChH19cXxIk9aWhGkKYimkjGRcdE6
X-Received: by 2002:a05:6214:e69:b0:70a:3792:71b3 with SMTP id 6a1803df08f44-70d76f870a8mr26796656d6.8.1755690448150;
        Wed, 20 Aug 2025 04:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/gakNMa/QxtXVM6Q3T3hNzkLDxmdNOzWdZVhhKTGdYxa2vtoe8JOEwhpP+CZNBh6RpUnOkg==
X-Received: by 2002:a05:6214:e69:b0:70a:3792:71b3 with SMTP id 6a1803df08f44-70d76f870a8mr26796116d6.8.1755690447455;
        Wed, 20 Aug 2025 04:47:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3519d8sm2573833e87.11.2025.08.20.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:47:26 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:47:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 05/14] phy: qcom: qmp-usbc: Add DP-related fields for
 USB/DP switchable PHY
Message-ID: <7b6utbnibia767bp55vhvg6ghdavb66ubdpabyguohuwtmz3mp@unvm36jttota>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-5-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-5-a43bd25ec39c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX75ukhgiSD0vZ
 C62y5L6SvmhsNjyZr2bCl5R0THHlw9MIPREWWKWIbMUkX3fU2oSTmqlzhlSYaV7BFKq5QM/ugYH
 N2lTWIgSZBkPZseXlSCOFL85Arh8bdDosiYKTD5yr4FjAyi6pWACa96NwBDujqw4fDgDZ6hL0hd
 Qx7grRXgrL43Kvikrc4lAfkN030lBNMeX+OfUH2RDQ2dqX7ZWWhyBqJCUPOI7a4h2dcYx/6ZD/h
 eclsh/CToqTEsmjGWYEpvi98tuTEFiyPS6zfqY9VSysJDHM8lUcqcCDRnQChbHvtyzFc4t1mvfk
 AKGskAhLdQioqWqtWtGKP9KTSRPgrtlih1OOYb1+any1UEU6xFF+5GO8bt0vM4ONoflpB0w1F57
 Xl+wLMUyb+uZgY+4BQV9T0rWg0g40A==
X-Proofpoint-ORIG-GUID: IwO7CLQEjpKinCcEgFx-g2VW9W0UTEHB
X-Proofpoint-GUID: IwO7CLQEjpKinCcEgFx-g2VW9W0UTEHB
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a5b5d1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tpX6aX9aePfZnGUoeJ0A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:47PM +0800, Xiangxu Yin wrote:
> Extend qmp_usbc_offsets and qmp_phy_cfg with DP-specific fields,
> including register offsets, init tables, and callback hooks. Also
> update qmp_usbc struct to track DP-related resources and state.
> This enables support for USB/DP switchable Type-C PHYs that operate
> in either mode.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 73 ++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 18 deletions(-)
> 
>  
> +	struct regmap *tcsr_map;
> +	u32 vls_clamp_reg;
> +	u32 dp_phy_mode_reg;
> +
>  	struct mutex phy_mutex;
>  
> +	struct phy *usb_phy;

Should be a part of the previous patch.

>  	enum phy_mode mode;
>  	unsigned int usb_init_count;
>  
> -	struct phy *phy;

Similarly.

> -
> -	struct clk_fixed_rate pipe_clk_fixed;
> +	struct phy *dp_phy;
> +	unsigned int dp_aux_cfg;
> +	struct phy_configure_opts_dp dp_opts;
> +	unsigned int dp_init_count;
>  
>  	struct typec_switch_dev *sw;
>  	enum typec_orientation orientation;
> @@ -874,11 +911,11 @@ static int qmp_usbc_typec_switch_set(struct typec_switch_dev *sw,
>  	qmp->orientation = orientation;
>  
>  	if (qmp->usb_init_count) {
> -		qmp_usbc_usb_power_off(qmp->phy);
> -		qmp_usbc_com_exit(qmp->phy);
> +		qmp_usbc_usb_power_off(qmp->usb_phy);
> +		qmp_usbc_com_exit(qmp->usb_phy);
>  
> -		qmp_usbc_com_init(qmp->phy);
> -		qmp_usbc_usb_power_on(qmp->phy);
> +		qmp_usbc_com_init(qmp->usb_phy);
> +		qmp_usbc_usb_power_on(qmp->usb_phy);

and these.

>  	}
>  
>  	mutex_unlock(&qmp->phy_mutex);
> @@ -1106,14 +1143,14 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> -	qmp->phy = devm_phy_create(dev, np, &qmp_usbc_usb_phy_ops);
> -	if (IS_ERR(qmp->phy)) {
> -		ret = PTR_ERR(qmp->phy);
> +	qmp->usb_phy = devm_phy_create(dev, np, &qmp_usbc_usb_phy_ops);
> +	if (IS_ERR(qmp->usb_phy)) {
> +		ret = PTR_ERR(qmp->usb_phy);
>  		dev_err(dev, "failed to create PHY: %d\n", ret);
>  		goto err_node_put;
>  	}
>  
> -	phy_set_drvdata(qmp->phy, qmp);
> +	phy_set_drvdata(qmp->usb_phy, qmp);
>  
>  	of_node_put(np);
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

