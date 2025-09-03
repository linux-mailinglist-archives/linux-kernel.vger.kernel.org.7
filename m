Return-Path: <linux-kernel+bounces-798732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918BAB4222F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B7E189B3EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61930148D;
	Wed,  3 Sep 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JLYIyPT4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A72DF155
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906913; cv=none; b=TJ96BuIsT466GiLwUd+EB259WfOv2MIpj5J+85MolJuVTsGPKfjncm6A6UWWn+yLru09QDdGaS4QNCSx1odXM0+6+O4DnQ3BdtT5cdJPv9sXbR4c2NY3Vp7DO/PsGyMYMTuixuE7BHhCPJZMM7/LDUN9qiST7xMzgUMA0+Xmw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906913; c=relaxed/simple;
	bh=NFp8TcPhS5de2EGnbzYmg4peWf8FnC+LhNlv906c6JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO36jrrxQvBNI0epFSadOP1q4FrfmL7wiKq///5e3xsYwVc52JbxY+r7PokZwhR+eJDvvdsedgAP3xCIyxCMn9N6dt6UbTTP7qB9bEwttymDCSy4tHP3PEp9XMBZsia/gZKBICx6Xw9a6HawtqFaTHEU4US80F2iOGuRHOw//fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JLYIyPT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF2dV011020
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 13:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1fYfnbja81zbttAC6psme4l73O+c9YkR4VUUb+N1Yzo=; b=JLYIyPT4p0HbU8Sr
	qiWeTOx9Ai4HHR440PdYhdI7ki4MiUXrPY+cf1jdKRlSnNsKT/3lkadOP2krWbSp
	Ne0xpBANyzwKwuvz4ZBDh/6c6BIPBNFIwxT7oK1F3U6u4pBSnc5dQFTYivMKbqI7
	BidKi0qcx7XDFvNH149Sax2Oral+KBDLt8HBBQvozW98X3H1yx+ChZMw9Xctr41o
	QvRqKlGrEF0Dlb9Z652RcoLqa0Bl+0H6V9ZCdn7L5ia9I88M/fF9y1O8OMsaUKgU
	uBttRTbEvWoHQ5cxZHsCoApc/6FmC6O7ZYiF7NZ1S65+jSxwdhwQ8CzGAik5erWK
	+XVPqg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjkstc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:41:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2967fd196so19723321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906910; x=1757511710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fYfnbja81zbttAC6psme4l73O+c9YkR4VUUb+N1Yzo=;
        b=wQ+KuSYmym1oDBvXcuX8w7W9d7ErbHazHEdR7enrrjx7NZ4pv3jtq77iMFFgLepQzf
         LfCKFlNF1aCY8ktfoh5vIUiem/PTTmikKUncRm84u79ULKbe7cnnU5rZfbTVCud+cfHa
         9KREx4FGdwUFY+i02F65OKv3ACPjMfsqa2KPs2W4Vh0hq0aPP3F6zToGp6j5cmQYiNmu
         3z1frtEeEZN6gMLgAk2K5qspHW4CWy3LqPcJU9rNtKpboSzEoqk5C8rcPRSd/0h4yvs3
         nRMKEte8PmuutsE2yauIQizuCMNCYCP4xSKN+W0oZNfqHistpyh6FcEXrjk4w9rbhYHI
         IgWg==
X-Forwarded-Encrypted: i=1; AJvYcCXD/1gD1iuS8ac10JhCigNsr1uGaTDRPWlLgKdStmnRH+Hbw1vmX3J9NwmUCCYyMkO5DlT6aX4+lYHDTC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwsBIDcPuA8FrfLFweVYWpyCMIGLadBLPWi0x91dqtBCEAPWj
	+xiRckDGmZn1cQJh+QcEaCeU8NSg/Hs8iflDoYV0fvlK/auC1JTWI/CddsCei2VMzNVCEkik7M9
	XzUBcjGJJAsI6br/dKjMaF3dvpzqqHuAWIvK4fzOZHjwsGR6TXvmIEQ9x9n2GJKfUtN4=
X-Gm-Gg: ASbGnctkW3K6cucb77Tqb9NsUyuDFnTqKb+qonFBLfDRP5bd/q7u/MoEty3OpiVNUhZ
	bC0pu4S9+WMpli7NPfB1s46uwTPa/OgEgh9/7FYvcK86NLMnxTjS/ZRzeuBp9oL+SUe5BB+sf7F
	yxgY+Us7+WlwiSxs6vydu1EYMTRFNFxs7ptCoQvmxkzkwtum0wu7b1xOQnG012gjqHM6PMbqIi1
	LXTq9RalxSYjNHSza8TVNsFhk+WYpkkhbbY2HFK1VRNC7kW8XXvkWAVUI6FUdeqcWAMrG7w7X3B
	PEbcMC1wa8NtysPKV3tMCPXsTo6lfmMgRrxfNaRmGdqxFHq57+GMrFPSJv5iVVQkQ85I9HSDuZh
	4mxB4RW0brrB6dOF90RN6zA==
X-Received: by 2002:ac8:5d12:0:b0:4b2:d0eb:1e7 with SMTP id d75a77b69052e-4b313f90e37mr141154871cf.11.1756906910350;
        Wed, 03 Sep 2025 06:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJPdTWyFNZv0wrE6s7lYHY+t1NrlyBkHlYgUSBucbQO6LODUUme+aa57ScVuOXFRfZKPEXFg==
X-Received: by 2002:ac8:5d12:0:b0:4b2:d0eb:1e7 with SMTP id d75a77b69052e-4b313f90e37mr141154451cf.11.1756906909528;
        Wed, 03 Sep 2025 06:41:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04110b94cbsm968406466b.93.2025.09.03.06.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:41:48 -0700 (PDT)
Message-ID: <964a58d4-ddb6-4c98-9283-1769c0f11204@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] arm64: dts: qcom: Add MST pixel streams for
 displayport
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
 <20250903-dp_mst_bindings-v8-9-7526f0311eaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-dp_mst_bindings-v8-9-7526f0311eaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b8459f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OhcfVZcqRUJJiLbfGB8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: HMCPvJOeW9BFXN7ujj9oRu7C1ai7snFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX3eUBM/pjzDXZ
 jkx/dbVpa9tTN3SSUzYjZuWGTyceREgORtxUbwg9sbAba7CDbot38uLA2cRVcF850TS20kizCsX
 03CP1K4QncALqssBhbzoibuvQTVbE1h7Yg+HD4C127jS+1ob0YYo5pUksfrayUf5P/FYraLdaAJ
 i66bEcDzA6N66ZQ2riK5xg2gnfWw21cljAEBMFjN6PxatRckgtsmyjR5MD/iWmaWfaDlhAR1KIE
 P9zkS7wfDxf8MJASv4/fPP/45efON8/Q1O8WMbaghnaU7qLbHOaMqYzI08BXHJcXhUyHPz6ECM0
 yT8BXfgH3Q+Mn+/827uNrJBDzfSHHW3qB2Nk9KMAzqLcCXuMzBVMMflOXIS5VKdo+vWRaRCCZ5v
 yBJKjlEw
X-Proofpoint-ORIG-GUID: HMCPvJOeW9BFXN7ujj9oRu7C1ai7snFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/3/25 1:58 PM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> Update Qualcomm DT files in order to declare extra stream pixel clocks
> and extra register resources used on these platforms to support
> DisplayPort MST.
> 
> The driver will continue to work with the old DTS files as even after
> adding MST support the driver will have to support old DTS files which
> didn't have MST clocks.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index 70c87c79e1325f4ab4c81f34e99c0b52be4b3810..e6a7248040095077d6f98d632f4e8a1868432445 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -3241,16 +3241,20 @@ mdss_dp0: displayport-controller@ae90000 {
>  					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
>  					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
>  					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> -					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
>  				clock-names = "core_iface",
>  					      "core_aux",
>  					      "ctrl_link",
>  					      "ctrl_link_iface",
> -					      "stream_pixel";
> +					      "stream_pixel",
> +					      "stream_1_pixel";
>  
>  				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
> -						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
>  				assigned-clock-parents = <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
>  							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
>  
>  				phys = <&usb_prim_qmpphy QMP_USB43DP_DP_PHY>;
> @@ -3319,16 +3323,20 @@ mdss_dp1: displayport-controller@ae98000 {
>  					 <&dispcc DISP_CC_MDSS_DP_AUX1_CLK>,
>  					 <&dispcc DISP_CC_MDSS_DP_LINK1_CLK>,
>  					 <&dispcc DISP_CC_MDSS_DP_LINK1_INTF_CLK>,
> -					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>;
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
>  				clock-names = "core_iface",
>  					      "core_aux",
>  					      "ctrl_link",
>  					      "ctrl_link_iface",
> -					      "stream_pixel";
> +					      "stream_pixel",
> +					      "stream_1_pixel";
>  
>  				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK1_CLK_SRC>,
> -						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>;
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
>  				assigned-clock-parents = <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
>  							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;

Something's not right here

Konrad

