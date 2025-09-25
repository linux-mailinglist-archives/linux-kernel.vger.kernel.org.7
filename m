Return-Path: <linux-kernel+bounces-833337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E330BBA1B58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98717625F27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09527B34C;
	Thu, 25 Sep 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XK1uqDAP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4023A9B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837449; cv=none; b=IeetiSgDb5lCaYgQDOoTDobF3aNusvt8t4wZar7DoLWq3/G93WU3nO59xQpv1zEcG3lch4N7jKlwDB94e2s54y4Wm9CvfPjboIo8N6slbtLrfH5ZQ2AOynni3t/nXFVhNCmloJgIaskzGARasqZe9hOefuhrk4TirzppiXFXhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837449; c=relaxed/simple;
	bh=XRDf8tTXsDigygdSdMxdsM1FC7hg2Y/Qis9SJR8B9Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM4Hl7qmwZCUnH63apieMf1ffJmgF6Xbc/6NFZrgBwA574mVGMTq9PXowMJhIgEBowOLf0ogpTXD3wH/NX83s2T3vXSthjAZ7mlf+T7vb2HuaJcagmw2RsdWaMe8cB8YpaRn3Alt7pIEdL8WF4bmGhBhzeonzAp6urf37y7EVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XK1uqDAP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQ2BI007761
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0PwCuPQqx8Z6h5Uvt2HeerM1
	J/nGXO3zl9oVlZVDBoc=; b=XK1uqDAPXweKnTZKlUOckWMutVJlu5JD471YAHDp
	y/fSOf6S0JmkK4x28Vq0wnoZtIin7w3eltmeEw8V79yPXj0zZ7b0UMyR7J0/xPIs
	fQjpuaoc3xwBf7QH1OIbxDaVe4bz9Sb81IKVnoUsi0dLTuzD9g45JhRt8AZaloXM
	ys3kUasTUNUcFLMX2bg64XPKLt1MJjzgVbLqX5ak555SHo5h2kjRu5YzKbiNBzKn
	HOIPcrWZB10fLBBJ72iQo1I0BHrtYLsGW/rIfjHpWwxJsJ2xt6GeJkXB3tTZHqMJ
	4qEkIZXCRRNlH7ZZQ/lLUbdAUoaKEDz24C7JoM/ISZYfVw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0vrgj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:57:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dbd8484abbso17987541cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837446; x=1759442246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PwCuPQqx8Z6h5Uvt2HeerM1J/nGXO3zl9oVlZVDBoc=;
        b=owFZBxOtRFjBDy2i2CrgBxs3iyrhyQhFYnlJhIRzaiOGII35oJdI3vBpxY3xG5fqzv
         CWjxY/92QyCO4najlZuW5a2QBkMt3H+rTxwBZtSNmmK8u1EKzzJo+s32pniCCA+7+m4h
         +rbbDDbXpPkw2ZUv1yrAXNR21Gel/x+EkBedesM+GY1NstJYWOfPPGKIiKMM7pkcJHwF
         xgM01kb9sNb66tFdU3zs22FCcUw0wgP4W+VvnWEUV7jSpxVDlKSVa5F/d7OCdGXF5fJs
         t89VrFx3IjgmFpnvDoig/tAVP8lFRy1qEmbRK2pWarkw4NOoXyE94KIMBY9K+4/hpVlr
         uRRg==
X-Forwarded-Encrypted: i=1; AJvYcCWib8DXF9PAIfys7oV3B5eQxhpMcESupMJPfDiDptxLGdKG48oYDjpSFLpyDz5jhQRjV+uAhYPq524UOOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YEIjz+vtdZogxd6HB4PXFq8+SdfWI0xgAYUvClVGb7pYZKkM
	HfwD2esHglVuQkup4uNH0Mgl6oOYYRErGXVj7TcvlMEhmoEd2dBOvoPrihKUSD42wJoxLKK/Gnq
	L49tQ22SY4kp+e1cIv54C17cdno7w7+e7FelaBTNBvwPhk3dD12nr3YFTwmudPl/ozHc=
X-Gm-Gg: ASbGnctA2dLtmLQDewhAlhhSRm6Q4G7IpmOwQMaca1sf7gB7XFoZDXCnPc3ydqX2uLJ
	mQTvWVnajtzJ9EUSaui3EkRVVICKJ1ZuuLc+2F1CW40AfSfP7EqV6R9CeL8A04A1dfswErjDeQI
	lwo06NSyb0/psVliKmXzAFrmZfrhacPdfzF5xAbGRVEtgdjw7kBdggVsOnhSLKwZjCTIt/nNcPL
	UyzWSIScbmFPNaRWNcrlHzjoMR6531ONxbHC5AmkZsB9HPsKZHc85VwZhVRygMtM1UxAP1X9a94
	/RtBjLzkeOsGyikpiny7SVEk784y6v/eKp25lShW/c3W0fmn9zZMNC8lsPrHUaFjsX0U696Pbfk
	HG6bFGB2shHQHF+ZkPswnNCTHW2XCSV4ypTG3tjlI6yzLgpEP91D4
X-Received: by 2002:ac8:58cb:0:b0:4d6:222:dd8b with SMTP id d75a77b69052e-4da4d31543emr60280971cf.83.1758837446400;
        Thu, 25 Sep 2025 14:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUvHFm/VIoqIQAQiQZ6FSqSB9YMAic3boTm5yCXZXNdcpV35T3IBACEQOCvNWiglROD/o5RA==
X-Received: by 2002:ac8:58cb:0:b0:4d6:222:dd8b with SMTP id d75a77b69052e-4da4d31543emr60280581cf.83.1758837445940;
        Thu, 25 Sep 2025 14:57:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a316d6sm1156263e87.98.2025.09.25.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:57:23 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:57:20 +0300
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
Subject: Re: [PATCH v6 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY
 config and DP mode support
Message-ID: <5dtlqq7x36gb7cmiunoreoe2vftq46pusb75sbol47ceazefpf@lxrx3hhcwhju>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
 <20250925-add-displayport-support-for-qcs615-platform-v6-12-419fe5963819@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-12-419fe5963819@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 14Lp73rWBPXE4hLz8bGxU21R_i0mJjim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX6TKxKvskWUDt
 /VecirREjkw7DRPbSV38q/qviXpk8q3L74hEe3zT/GcjlwNuvF09gltsCeKK1j4OtB8+AgSnWsc
 q22L8ldOzkDb0Sz78ZCMQx3hU3vRx8IP77fGZQK55ncZrCbXVjXWIaTEVYukFNzlanlBPBZ08LZ
 e4skkauZbmwQto9kfE0EcohtEAyHjxPf4M+JM06o61CMGhYOQWV+sKFWdFw5uMMUtdnbRDJevo5
 RQTulFr7qdMnRT5SzkEe08d/RFYngCaMUu9yPGnIvLb5IhylUzixb9zY6RtxvaxZtVxw4Fk7Cib
 DcUf4Rp5dFlXFxzjVUfW5KLRWi9FNRI5NJCWQ5+MoExWDaATywEn92OSa9ASydR+cry7BPBFDPJ
 zKtG4taT3W3C+IPCvkH622tSgno64g==
X-Authority-Analysis: v=2.4 cv=OstCCi/t c=1 sm=1 tr=0 ts=68d5bac7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=cNq2fIDUiLOJNmzcDXoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 14Lp73rWBPXE4hLz8bGxU21R_i0mJjim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509250171

On Thu, Sep 25, 2025 at 03:04:58PM +0800, Xiangxu Yin wrote:
> Add QCS615-specific configuration for USB/DP PHY, including DP init
> routines, voltage swing tables, and platform data. Add compatible
> "qcs615-qmp-usb3-dp-phy".
> 
> Note: SW_PORTSELECT handling for orientation flip is not implemented
> due to QCS615 fixed-orientation design and non-standard lane mapping.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 407 +++++++++++++++++++++++++++++++
>  1 file changed, 407 insertions(+)
> +
> +static const struct qmp_phy_init_tbl qmp_v2_dp_serdes_tbl_rbr[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x2c),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x69),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xbf),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V2_TX_LANE_MODE_1, 0xc6),

Hmm, I just noticed. This register belongs to a _different_ space. As
such you can't have it in the COM table.

> +};
> +

-- 
With best wishes
Dmitry

