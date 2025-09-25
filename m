Return-Path: <linux-kernel+bounces-833226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE88BA176B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D8E5628E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39642773EC;
	Thu, 25 Sep 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="diMoJ62e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435A2741A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834584; cv=none; b=UP/TS+NkpyoG18uNu3TMXXH0Gm4bQeFYqxlvrb8/DT8A3IfUEAbdkT5iWNMKhBBENS2mMevHmJZl9qhGLv4m5IOB8qZ7Qvr8eT+nBCk6H3ETpufSrqC1J8YXWfGWKnl36f9HGpiyx+c8teAB5qVgIxNh4O0GKaQLk8+friGCoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834584; c=relaxed/simple;
	bh=JEodWQfFrlLT4ft6wjHp/4PxrYt2WKMNSdqCoZMAr6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hue+Xx+o+mKGcjBhKf3aNQTAtOWWF8TEU+n80PApF/KrOiepJrb2OiW3AtxT9WDy/n1FtGjbCWRfZgV1qp4DwXOP3N0lt+r4L01Ygscp3ijniJt53PvUGfEGugiXzLBIYevxTGkzVfgBBXNbMZXeG5XuykW/n7IQiu64vTQdHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=diMoJ62e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPs2e004169
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yBJOIEuQPqA/lZF82wvWq/0Q
	zUW0NQdR/jM9pAy0sYY=; b=diMoJ62eD8eRze0dsn2h5hbT7fVGPAaouML9ENNQ
	SjX/0r+ZIzHAH05lSwfXmFG4Mp5mGbROXZo7wWiYoq2OZSI3jfz+CSJKcaqDXoWm
	xoN2DOx18TuD6yHfhC68BbcW4kxQSUMf/3CiIIh6IClGXkW3k8FUnyTH5Bk7TDjm
	VxXGknJ5A75cbB7br6MmO9wtqsmr29YmTAAJ0xKYxiHdSZFX1tD3Y9oMfxeY6bkl
	bkihlyhflKW0FoQWO1AYddK16scD3Qb5lZSKlRs1sJAAtW6dXdTzZMslC+2ya4kE
	HPBZgyTLxGLtnuSNIkDCNDslqjMTM+BnAqzyTezzRv3OTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u0e2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:09:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cf47c9bab2so51398581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834581; x=1759439381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBJOIEuQPqA/lZF82wvWq/0QzUW0NQdR/jM9pAy0sYY=;
        b=N5wOJ+uOj+XNvFUeEp05Mne1XBZzjtJJE12PXSKuOfQOhJ+GY/cfJGrVN9VBfjqPoW
         CR8YyDOw20c4RkYRKtW1ZoZAoEDxqoBG4P/2Z5X3o6PfCj8umMDG87UwZNV2FLw2d2hu
         vFoOBXTizpvlOpQTXFC+6V/NrgjvW13TEi97wKVVlIrd1SCPWTzrHvyWbq32o4ycP4/J
         w6ciJmjoXpTEt77qR8J2IGrMdCIUVPMkmCWsHXlutl7rIBAOs3NL4Kl98gpN48g+fCgF
         XYAv7osJjlr4sGIJyD7sEWfrKYj7t+hxjvLLsHqNHGM8VSk/4141oAB9x5MuTUjVCjs3
         2R7w==
X-Forwarded-Encrypted: i=1; AJvYcCW3pBAIHIVxhKrZ5fGTt6odlALEuREHg055sD/vtlTWuyy1lgQ66Cp2CFwyQKhYyVov2i4dmYh6wtFlQ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnUmq4nZgRPwKQOaP8edkSh0OkoGF0NsyrD/SgPfdsA2xAzEQ
	hSI3PvzMdrD6ad+W0hdw0NDkgi/+1Di9CngBQSR3hcCS0vy3GME0ynAv+U3b67Iac4fNOFwk7Cg
	bMaVppQLqLr4aHbb5DNnXtEZh7FVe2bhXLBiPAguuAukajOql5Z/eTSvTTPUe5uszDsg=
X-Gm-Gg: ASbGncsF//Jnp+aRuyKW1xWuP8XZwd9Jyx9tG7qFpyJDjqi7vRkvJtOztXtETLqmrkC
	zp6wsmLIhIgbjN4JmrWTNT2mQF4Ig+jNY00W28P9ydBuXHw/J6Ni9LQSHVI0t1JHyQYhvswdeXo
	cy7191skfOTvHUQqQZbqqUGjD3jcyJwgR+fuNSTZv4Zajis1ut9KvhmyUww9e/wk2q+TqeP+2o2
	YiLzcXncB2zzShlmGokrvCDISTnDlvPEtfvAFRztd1U23vMlb9YCxNhJ8GN8HG9RDhU/jL9AMt1
	9AfDg1ddViwE8j6R9vxo8G6lei1/RvEHBaiPmuOQCVBuIVhqfRVliCaD2xCsVrLZDcUZAaHOIRX
	A5bCB/EzthPrTXNbvg9Nma1h9lul7qRCVHLbhWJT6W3iqu49SaYIh
X-Received: by 2002:a05:622a:2c4:b0:4ca:e5df:f25d with SMTP id d75a77b69052e-4da4782dc5bmr67985921cf.5.1758834580835;
        Thu, 25 Sep 2025 14:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqkDqc2xK8sis9Jeta/cmBmc7gYMtEpaFT6Lcvm02JjnAT0CNE9kA1AR4P6UIm8nYGX1swzQ==
X-Received: by 2002:a05:622a:2c4:b0:4ca:e5df:f25d with SMTP id d75a77b69052e-4da4782dc5bmr67985491cf.5.1758834580258;
        Thu, 25 Sep 2025 14:09:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f99d5sm1125211e87.40.2025.09.25.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:09:39 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:09:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] arm64: defconfig: Enable Glymur configs for
 boot to shell
Message-ID: <yj5krcmdoualjj4zy4qvjjxarstaphn3eduj7n7jvti2tpbzai@tjwayrloy7fs>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-2-8e1533a58d2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v2-2-8e1533a58d2d@oss.qualcomm.com>
X-Proofpoint-GUID: 4BnMvAx8ex17a4SVfDaaF7Z7T2yc7xbY
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d5af95 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HHzqYahG-ipb5aDFT_MA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXwbt2n7n11cmB
 Tf6Jsn4rAsUVc7neC4ZOsKhJsmT9SOwCWDbhhtZvPELik9LcCxi/c538KDlx9mxuPJ0A0x5VyD8
 N6IWi/ySxsWFLHkA01ygQZ+od5FvS8cMLY3csgBFIOZyleIepPFO7a2PYqimPQOkKli778ko9XV
 cyAlOstXtr+j53Y2Xma7dGh5Tkumr7bAG1Jd+S6SNRKSLzuNYA4lTSY7H+kjSpKeleTZuMpFuMx
 3+rHHDAw6aZdgNzAzSfM0HFZUKQWqRyHVDuxlONhulKFXi6HCb6wocUEePMF9Z7aEqcyRruBG1K
 lf9G7IRAKS5X4x6IZqm8Yhf3yyTacmd4O9btfif3UvTSXKzR+g31Sfve2RunohtcIRh0DZsktnx
 jYvQUzaxNU6xTEa0nV3uqpPUQfi8gA==
X-Proofpoint-ORIG-GUID: 4BnMvAx8ex17a4SVfDaaF7Z7T2yc7xbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 11:58:08AM +0530, Pankaj Patil wrote:
> The serial engine must be properly setup before kernel reaches
> "init",so UART driver and its dependencies needs to be built in.
> Enable its dependency clocks,interconnect and pinctrl as built-in
> to boot Glymur CRD board to UART console with full USB support.
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..9dfec01d347b57b4eae1621a69dc06bb8ecbdff1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -616,6 +616,7 @@ CONFIG_PINCTRL_IMX8ULP=y
>  CONFIG_PINCTRL_IMX91=y
>  CONFIG_PINCTRL_IMX93=y
>  CONFIG_PINCTRL_MSM=y
> +CONFIG_PINCTRL_GLYMUR=y
>  CONFIG_PINCTRL_IPQ5018=y
>  CONFIG_PINCTRL_IPQ5332=y
>  CONFIG_PINCTRL_IPQ5424=y
> @@ -1363,6 +1364,9 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
>  CONFIG_COMMON_CLK_MT8192_VDECSYS=y
>  CONFIG_COMMON_CLK_MT8192_VENCSYS=y
>  CONFIG_COMMON_CLK_QCOM=y
> +CONFIG_CLK_GLYMUR_DISPCC=y

No improvements here.

> +CONFIG_CLK_GLYMUR_GCC=y
> +CONFIG_CLK_GLYMUR_TCSRCC=y
>  CONFIG_CLK_X1E80100_CAMCC=m
>  CONFIG_CLK_X1E80100_DISPCC=m
>  CONFIG_CLK_X1E80100_GCC=y
> @@ -1641,6 +1645,7 @@ CONFIG_PHY_QCOM_QMP=m
>  CONFIG_PHY_QCOM_QUSB2=m
>  CONFIG_PHY_QCOM_EUSB2_REPEATER=m
>  CONFIG_PHY_QCOM_M31_USB=m
> +CONFIG_PHY_QCOM_M31_EUSB=m

Neither here.

I'm sad to say, but:

Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



>  CONFIG_PHY_QCOM_USB_HS=m
>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
>  CONFIG_PHY_QCOM_USB_HS_28NM=m
> @@ -1718,6 +1723,7 @@ CONFIG_INTERCONNECT_IMX8MN=m
>  CONFIG_INTERCONNECT_IMX8MQ=m
>  CONFIG_INTERCONNECT_IMX8MP=y
>  CONFIG_INTERCONNECT_QCOM=y
> +CONFIG_INTERCONNECT_QCOM_GLYMUR=y
>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_MSM8996=y
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

