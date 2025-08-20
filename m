Return-Path: <linux-kernel+bounces-777545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8CEB2DAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A957D583887
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5235335B;
	Wed, 20 Aug 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jb4FCtHg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E712153EA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688603; cv=none; b=WPh9XmANqCM3hxcpfTPPbV9twk+IKKsgsryYrYBRaLDMgXuIV73W2KpozMGb+rQkX0LpIaV4a1xzqkuQURt7x3Qx1OavllEPZdawxPjNr4wyxkK9rpIpuarvC+EwFZy+AE+5qJJpdHrRq5R/U7LjDfC+z8n+88iogN03umOxf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688603; c=relaxed/simple;
	bh=AdxCjkjoAfQ7JR8WecnlpWNVRNTlYxyAj7JILqSb/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1gvJD7t54o0y0FonnG6CVDUEC2WPZNx35NFY3gXj0RA5IsQ/07XzBZKGhWk9O7BaMg92NA4pQoE4g9sFRmO9hRLM5Aglq9uaLPHUolb52c4yCqRoWNG+ZSvyvAArRcQ4Iym//+ji6zIkBFcRKeD9IFSUUfQgczkcxJ7X4CGsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jb4FCtHg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KASlCh028174
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Z7Up3r+c9engU8+UCwkklUb
	n4iM1d7MoVv1XcE+/Bw=; b=Jb4FCtHgVzCuUKJ7WmuwSjJ+BngX6Y0KWaespDfZ
	/gUwh0yFRpcSznLyLx16ksxhAwNyF3cywKbX/XJTWQ9kpbrwYHpPU83ulp35TuvE
	RxJEzDzKBAKHKzI72rO/dBtvWfp2Q+nQjUt4DHnkK2iFeMVexC2w8sp9jC6nbpBT
	mRroLv2koSmJulBWEqR0FVSElttV8E+mLnJ/u6waK3bxBN8SkVc4SHASDNUUuE4r
	UdgzWo3uN5P0BMguUqiuPXJdIXmltNnxPxoF+zKGS2gAu1jfK3ytp/pyNu9qzZ3n
	LdIkCbrbaZDQcp56ERlYjMtRJvVX26D7aUfjwNZkzK3awQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52asf31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:16:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88de16c0so142761586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688601; x=1756293401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z7Up3r+c9engU8+UCwkklUbn4iM1d7MoVv1XcE+/Bw=;
        b=iuxAJEtl4DaJweA9Z+7mpv80xtp/PRkBfpQc1+IqpZxCL/ImzT1zjq88ciIXx7pnsN
         7tWZx95FmnvYlNAq8VV0SGsh3xO9OqqBGYjkNjKVZjzjqo4GkhXlyCawXZz1+iCzHexY
         Hhply8U6zEqfWzbsGgttAtFr4KD+Zj6kkV41sNsHUtih6NMja8SHygxZh+cNbAEIKCn5
         eRiR6vf+FLxSKRk1R+Wst3sfPN384M0SP/Vov0QH6Rf27Ia5yF76HqJyCOBXfqWp0ZIA
         gvG03JcGukuusnc1yemhT9RFuTtOwE2NcdPHAPr3QH+ZtpVtpsxS/9FMis6FHXlQxJuE
         qrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWAe9rEAR1B8fB/HU2MLheNOVdQkRsOIH0XHcIVkyAOLuFSAuVnJTroY8L0PfUs1TjaXhSHSfqM/qGWC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX26/EsVsdRN2LkTOyzNmhyR+mC5dVJDJW0ZRFnLPEULIyhkcQ
	DXWGlVy3R8vm+4g7aPAjy/6RCvc3GsVlNiXMN/9Dk4WPRyW+pPUOYjSc1dhegW+7fC4XGfXqWsx
	3syYoRZs8C8hqzcQJq6EyA5K4ogJOmTXf2ExqGxyppy2zZarsHmVIFWRWb3aBNhk9aco=
X-Gm-Gg: ASbGnctCP4HUCox2vVgUVGk+18IGHO5vlcUNKXjXybWKwaHugc9Ai2NuXeWtQJvSVeG
	KgonsK2/9s3zvau3p14qAlfA8zssQWh/dqt4Hwafo+4+N5Fhtv5poPdatqHBTKWAMcFY0+6XvpK
	NwYyVYtk1O6l+14i8s1UVHDbPiTaC0mObX46VhupBPvkaet5pr8koK9VvZSIOhCgd+SYQuKXLSR
	kDBgkHSXKXIqHOtXpwAr8eZOzFuZxRO2PU9rJ2bWyrZYvphGYoWfMt2YmcCGpgl9CqOyKAXE9q5
	8AvHVwW827y4s4/MsVlOh2sb0ZQ00sfyBst6Xk8LLCI0diwxArl6TJjr5PbIVPo1JYj+rYPY8Un
	LGM3O40eo9juTk0lVHew2D1hYQ0ynR7BgpfRCFR+Iwak2CIrM1HKd
X-Received: by 2002:a05:6214:d6a:b0:707:71d9:d6da with SMTP id 6a1803df08f44-70d76f5be8emr25705206d6.10.1755688600553;
        Wed, 20 Aug 2025 04:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXo2tEhaFHWFMNzMyu5ebXhvONp13hFPzXhg1vzwJcxoRGG2jluk+k9PtM8oxn7Ws7nmt9rw==
X-Received: by 2002:a05:6214:d6a:b0:707:71d9:d6da with SMTP id 6a1803df08f44-70d76f5be8emr25704406d6.10.1755688599895;
        Wed, 20 Aug 2025 04:16:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3515edsm2625261e87.20.2025.08.20.04.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:16:39 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:16:37 +0300
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
Subject: Re: [PATCH v3 08/14] phy: qcom: qmp-usbc: Add DP PHY configuration
 support for QCS615
Message-ID: <su3zkeepxaislh6q5ftqxp6uxsyg7usxmc5hkafw7yn2mgtqeu@wua72odmy7zp>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-8-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-8-a43bd25ec39c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4s8jnPHTFb5R
 hy99WxrQrp1ki/1Yn4ev3Rrdp4PejJjqkkrYindg22CvDVbfRh5YwV/nw5x5gKZ6myj06ci2iZj
 oE0Qkl7lDiwB+HCAZKFO7Zw8gC+UFUxjQXDbzuuPnk4YhyQc8sRSvWLWsHdS5FV88UlcEcuLI+3
 wqgXZHM1a6N+kxij5MwguURf1p7YAP8OrAQVkS8hxXGKRxYqdVEjc3qzSmxsaIYa8E05+9ufeta
 9xR7Gsi7I7Hq3laI/WJDVDNNaCz9J1lqdq2+6mnPDC03CFgsH+PaFYUPacuYm6m53AW34lJ5r/g
 qEdlSGCvDAwmvalNAgRV16PuJmsRJinEuyxb81H20T0A2CwKjvIdjAOs0xnLKGFVxX+Y4PEj4Ev
 U5gADFqBeu7J15bf7TAzAotBjeQdYA==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a5ae99 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=2oAyx2JpwU0Ji29QuscA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: CFRzWZASYQot_XdigqTTkPGOJr8raMo8
X-Proofpoint-GUID: CFRzWZASYQot_XdigqTTkPGOJr8raMo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:50PM +0800, Xiangxu Yin wrote:
> Introduce DisplayPort PHY configuration routines for QCS615, including
> aux channel setup, lane control, voltage swing tuning, clock
> programming and calibration. These callbacks are registered via
> qmp_phy_cfg to enable DP mode on USB/DP switchable Type-C PHYs.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h |   1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c   | 251 +++++++++++++++++++++++++++++
>  2 files changed, 252 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
> index 0ebd405bcaf0cac8215550bfc9b226f30cc43a59..59885616405f878885d0837838a0bac1899fb69f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
> @@ -25,6 +25,7 @@
>  #define QSERDES_DP_PHY_AUX_CFG7				0x03c
>  #define QSERDES_DP_PHY_AUX_CFG8				0x040
>  #define QSERDES_DP_PHY_AUX_CFG9				0x044
> +#define QSERDES_DP_PHY_VCO_DIV				0x068

This register changes between PHY versions, so you can not declare it here.

Otherwise LGTM.

>  
>  /* QSERDES COM_BIAS_EN_CLKBUFLR_EN bits */
>  # define QSERDES_V3_COM_BIAS_EN				0x0001

-- 
With best wishes
Dmitry

