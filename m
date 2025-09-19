Return-Path: <linux-kernel+bounces-825100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C3B8AF50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB41B286D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52469264636;
	Fri, 19 Sep 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blqNXqNa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7D257AEC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307316; cv=none; b=bvVN1LHIF1powe98aE8vaptji4nXlsFLOuvECTkg2F3ED8U7bSNEYJ79G0oIb+SI1rUdC1cz8xrQwXiX//+jzr8iSWSVUJhd2DrGlzXRA4d5LpJHqgCDDxZJuEuLzRJaanxM0VceIW5jN9eLn/1//k1v1KP8uxlr0aEIkPWBlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307316; c=relaxed/simple;
	bh=TUDF5w3G5i2z98+PxLv36xZF6LqeyndtPpfQFG6mm3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koF9xQy4YnOOomZxK0Iy/yQfWLZaQIIka0Xh4wxAgvhjxAdFfuwZRYuRyCYbh9xsBewrGgx/J0ZdMi1J9Y8Ja+mAKYI4IeATyngEHDBYoDBuhaAGwZf5RhbburlRnVrvTreQFlC6bDujuxrRPwft2QbdyHNF8chaar8o1Px9r+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blqNXqNa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JEE0IL018046
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=i7CxFXs3E+TxXdjR6pU++0nh
	zSKDiXUs6/X+r4T9DOg=; b=blqNXqNap4RdDUrGJHaDIHahSPTcmOFjAAK+36Di
	IhcA+6lelkrQOZIVWpJSuXMeRHzdHh/A85okxRiUZtD/Puq0p0o1Yl9sFuPKUK3S
	GNpN8JmcC0KqZyKFIkCGuQkKMeGpqo+0jIGMOh4UqHFF8icYmbfvlttCkDjGuLFJ
	5o+m737uE+ltICx5CWLeNg1rcAzxN12kRS1XVv7MD0EYOE/4Su0r6i3TCEQf6XIW
	yPJ2GD8bmI49TxO1khkl/iLaIwqip/E3oZfAVS0rqEuAjU6wOFRLCI4EKfiE4irS
	AG8X9GKy5YRMaiXaJVO0WNnRG4/C0yhxFIBUmET0gFBhIg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deg3md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:41:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5ecf597acso59138681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307313; x=1758912113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7CxFXs3E+TxXdjR6pU++0nhzSKDiXUs6/X+r4T9DOg=;
        b=jYjtTYZJrX8rE4UPCCndHGs8NOqYDv7RWqtpM0wVb8PCZvqHhuACneNm+hbCZ73H0v
         L4ZhhVAD4Z39EUf9JITjBa7NUnEOkrnF8mOQslXKV45xV6xtOmhfE5rXCM0pSRz2YeQo
         vSr56HmXgYc8KJWT3gx/9kG0zdbpyy/XrdkZdTlprVJipkSnBxEe8Anm+o62ixGcdI0T
         VNbFzkPTG7kIFKu2pqeSHK43Yr6GOPKuE1fEMbJc2mpnPmW5v7aN1wih3UuTaK2fsL6U
         VblodjrC//Y95eIqG3J7d0pTI8DK1iFFsJusgHO/QGbI3g9SfVoi0evxX9sfwiIxrVWl
         6N3w==
X-Forwarded-Encrypted: i=1; AJvYcCXZNCItWr/nTOJckcy7t117CzdVqkwRHYzmyj8RXGlH2Z+0UhuTWJ9R736NR/8MIQ3d4FFNGVFnF+U8XO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Cxj6mMSjL8dRvNrTW52fAvJAAwftPBymthMUXWMva5EL3Glm
	KBB0K59cbfzv9X9x2J6aJ5pMC2w3aezjVm4xqwsE1fXuSLla0DAopp4UKbvFVRcEttVljmLCQb2
	vWHFlUfr6NGOH9QNYagyMfkTJ9OingkZMwYYt0AlfELHrxAaa+iyGYpXXaHgWQpQSbiM=
X-Gm-Gg: ASbGncu2vtTWT5aHm+UZ/2cFJWNHnmpUWdd3gf6SWeD5+58cU4u8fXIAVHUK7RTczkw
	eUIKU1DoRTDTo8i5ORkZZtkUKFIbplxBRSbHy/1C+I5OX9lUzbdqAWxeylys/kdYEk+LeQdDtRW
	V2XRb5tz04aUH26o23GxsWfYruhWYOWsr+XJ6+CfYddVVlrjd10ht52PGk6KFrk7Tijuuv+AvaS
	gBMfRPwowFXoB8840+dj+32KTdH81jjeO2r3ILWcnG+hbTsdeRwhxbaL5GHhN50839QeSRKkXXz
	BZGPHivBBebz1UbttIHLbB+ZhM/1ZLnmyJ1NlP/2ZoeMzfhk58vDS+M6GAz+ghRp5Zhxp30tHpa
	kv6tndNoO98wDeNbtARTkcRjVPn1iDSJxylMD+c/IOYIZawGw5wJT
X-Received: by 2002:a05:622a:491:b0:4b6:2336:7005 with SMTP id d75a77b69052e-4c06d6828d5mr48024651cf.19.1758307312808;
        Fri, 19 Sep 2025 11:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+jXszKO5APDEximPKgrAQZzyc5+8giT/WjH1lhXJNUczhHvAVEcXJ87AWsBXaMadhHq3byQ==
X-Received: by 2002:a05:622a:491:b0:4b6:2336:7005 with SMTP id d75a77b69052e-4c06d6828d5mr48024191cf.19.1758307312164;
        Fri, 19 Sep 2025 11:41:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a99e9024sm13738501fa.49.2025.09.19.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:41:51 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:41:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY
 config and DP mode support
Message-ID: <bfpgktxgo2hb6dpzy3i7jdr6w4de5boorx4n6qeapct2vre4sn@4z2mnppridn5>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-12-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-12-eae6681f4002@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cda3f1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XgMPAK_adSAUw0pB5X0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Z6dr_r6m8HYA73i4qvCsJksIn3j1_yYt
X-Proofpoint-ORIG-GUID: Z6dr_r6m8HYA73i4qvCsJksIn3j1_yYt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX/uKIpFi+4mef
 jf+Dv8MnZgqjcr4tlSiLyRorV1j6TllfNPyN6Tb2olLBhGsqabjnQzgcW3ZTguMhs9UbUllpNGY
 tj3Ko7v5miB4Vso8vIiIvdBvP0HQpgx8ks1ieBRYBtKHuW2NPpxe2ZZpleSWWtj58WMGlcxei3I
 tQTJkGjjlZzP0NmXCI1k5If3lPSpGpJwzDU9UU8rIFEAsRGLeRn/iJM5X+MRfh7dhxgxKCedOW7
 +JLqC9duXfJrWZ99jafmaz6hKBCOT0jdAKz9BF7KVkKn3fZxUZzAFcqvNQp3vRHelQJOfnamCaj
 VUKnwxslM/kWvfqZ18lL226LE2M75ABKHnHihvPvo72qFrj8Lu2k8Tli3Kj6vUio7ZVy7VI7e8f
 jFbKIjSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

On Fri, Sep 19, 2025 at 10:24:29PM +0800, Xiangxu Yin wrote:
> Add QCS615-specific configuration for USB/DP PHY, including DP init
> routines, voltage swing tables, and platform data. Add compatible
> "qcs615-qmp-usb3-dp-phy".
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 395 +++++++++++++++++++++++++++++++
>  1 file changed, 395 insertions(+)
> 
> +
> +	writel(0x3f, qmp->dp_tx + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
> +	writel(0x10, qmp->dp_tx + QSERDES_V2_TX_HIGHZ_DRVR_EN);
> +	writel(0x0a, qmp->dp_tx + QSERDES_V2_TX_TX_POL_INV);
> +	writel(0x3f, qmp->dp_tx2 + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
> +	writel(0x10, qmp->dp_tx2 + QSERDES_V2_TX_HIGHZ_DRVR_EN);
> +	writel(0x0a, qmp->dp_tx2 + QSERDES_V2_TX_TX_POL_INV);

Are you sure that these don't need to be adjusted based on
qmp->orientation or selected lanes count?

In fact... I don't see orientation handling for DP at all. Don't we need
it?

> +
> +	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
> +	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
> +
> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
> +			       status,
> +			       ((status & BIT(1)) > 0),
> +			       500,
> +			       10000)){
> +		dev_err(qmp->dev, "PHY_READY not ready\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

