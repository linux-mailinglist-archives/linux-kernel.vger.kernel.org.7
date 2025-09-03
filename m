Return-Path: <linux-kernel+bounces-799090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6795DB426D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D4417BCE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918782DCF6A;
	Wed,  3 Sep 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3YTi+Qd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF12D2389
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916679; cv=none; b=h/FN+jJi4ojd1EVvV9bYOhJTWAhg1e1nyAqDsakYmm7L8fM7Dmr2FJD9Oq6fGv1p8CQOOFFFX0ZOHe3yBowvnxf8nYzTF2gvoZVellFMKE+W3eWuUted7aMPn34rVP/NmGKbFXUe1zYs157HAPEw13H527m1fSfayujfwd947U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916679; c=relaxed/simple;
	bh=Ji6cweSO6xnY7aSnNkwD48Te0jCW/jiJDFPpmjSSMKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws2mHmGm4jKusLceg003Gj3ZxdzS+SGHsInIvIqYBEgGsOSGDi4oAZMxDdw/JPp0TMYTG4Aop+bjUK3qZkpEMGBuhKvDXlFVU/DArKg3J5Kt3arL5tTy/4tJhJ410VHf38y77CO9BnypE90+XVq4C2V9SOnf21F9p3gQadbczWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3YTi+Qd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqt2004992
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oaSQ7ufpcQxDCN6LeJ8N1WOp
	u8FF+bQ6qW1sUI4ZhrA=; b=U3YTi+QdWuUX6xrpJChhPKGVdgWdgIARcjbvblBT
	qamK+ggMtYl37hsI1tJlXSl+d/va9TdSDSwHgmlQekYpl7xOR8mtk4h8kwhytOGH
	2HPBW9/SNcImjWYG4xy6poWMIHDJQoxgYJOFtj9G/ccK4PnKbFj+OvkMnFNSNpis
	R4stUfQAcu5ruXK4iBWIYFYCwNhXgzNx3Ylq0Q+ICS4xNnyqExlYmQQtGd+LL5al
	dLErmDRJVMrAVV3AFOscM29IKIUjGpotMxpHN9NERa7bOJpBxPUa9eL/VxG8NX8n
	hetVFDcGFhN3lI7zFbjTt2cgDiGYyXRrcLhAlgMr3efk8A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s4gae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:24:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7224cb09e84so272806d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916676; x=1757521476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaSQ7ufpcQxDCN6LeJ8N1WOpu8FF+bQ6qW1sUI4ZhrA=;
        b=Ojb2/euYNqVNzF7uFZ0I2Bnnhq6Sm6EinYvPmFjhBLkPbKwGLQRlP+Pw1uRSiGJiG8
         x/w/kKZ8ThMvnPpxAJFnjOpFTg0Zvn07XA9qDNo4lRDg5LIqBOX6ypioE+u83+xHciZX
         BR3+wYY0FuHhhKgiiKxzq0PQRK9skwVLKQ6mCzLHrFihf0UsQeLbSCvvSmK7B/bKoi80
         52Fiu5ca2vzsPMTFIZfUqt2luWHAUw1yBf+4PhVQ0fHIX6q8tV03IKtD1CAXO/ShG+LP
         bztgRwzxJN5QBf7njZb0tIOqF/elJ0lbZmbfGFctSHLqRbnP84baBMgg6iseY9OBHqWH
         ltvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/lCNBHifLWldOzBrd2Xdzjqsd2pccOH0viHHwFcxlM7gAs9OSTEPxgEI+mSigHzm72Zjro/av9CTJz8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAG3yJ1EWBH0bXJsevAXGCKw2Bul85RGU/wnNQIu3IQh2nkKZ
	QyUm/4DZlpZM4I8RKDlrAzWVCMl+sn19FpS1not6lWRe7LAG29CBOPcBmq5foQ0s6nFa94ppNs4
	mhUh1SyU1FA5+tdbMGBpOE09Tc5xKAH67ryekNAuiNGr5McN7RbqPcMEywOUXCEz/nmg=
X-Gm-Gg: ASbGnctZqNiQzq4z2YdAbORkgoOBVKLSb9EElzBCfEFMfD/rpxvxlSfrEOT1ZnX1DRq
	0/z2eyyltD6pzB4BEMygFCZv4upLtoiAqOpJFcPDwhTe0vlx++qMLUfqir/PAOs6Sz8sMXyhXFl
	G/9/JgvzDEUXcWkW79GSE0uSDVsbROdLfe2GmZEtDvqSMYOacMA231Aj4RFE8joeA1hiktDEGeu
	yxe9nglZd/+iL+KuNYsHYewkAiriuJ4dWQXqdLa7kqlHoyyD2eKBYd29aE55GA5HR7N9WDo31tT
	E6FveCq/30Ogcdb+vQZyiTKc5lTPlZogZfouFA8K14gR+80eXpkRdeBNCsdNOCY09kFY3eULWb5
	DI7SAohFO8FGm8HwmDuULG1JYXJ7mvdYhQgHAgTICSU97w/TzFtxD
X-Received: by 2002:a05:6214:5184:b0:722:2301:2fb with SMTP id 6a1803df08f44-7222301132amr60988716d6.11.1756916675773;
        Wed, 03 Sep 2025 09:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqWc24oF91JK1xSjy48sxY9KXX6E+0IZbkKERnqkOK9N88EtXTxpEWAmWnHEeRkqQNVqpfIg==
X-Received: by 2002:a05:6214:5184:b0:722:2301:2fb with SMTP id 6a1803df08f44-7222301132amr60988016d6.11.1756916675062;
        Wed, 03 Sep 2025 09:24:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad2c222sm600452e87.130.2025.09.03.09.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:24:34 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:24:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
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
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 9/9] arm64: dts: qcom: Add MST pixel streams for
 displayport
Message-ID: <bbqtiazy2wvz2oj2h4dadslu2qaveaqcwtgyqs6wuyzye4zmtf@fj2ysdoyf2nm>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
 <20250903-dp_mst_bindings-v8-9-7526f0311eaa@oss.qualcomm.com>
 <964a58d4-ddb6-4c98-9283-1769c0f11204@oss.qualcomm.com>
 <rfhqfbx4q3kl35ktzaexjjshzosv4a2tkjthtvo24aoisrdvj7@i63a55qx4mnn>
 <f34c72ee-971b-47e8-8d49-6355b2660925@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34c72ee-971b-47e8-8d49-6355b2660925@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXyOsLViVvGAEO
 YIwUYyMoB5LOOD5QaSGy1GDH1fWRAG1az5AsKTDmpMywXxBfEWx8lRth4zwG9kFkCOHNpihs2Ss
 fEGNzcj1hPyjQwIyCrRwhjQX3+a9UwUtYPd6dA6UJyWGOjFrLqDZrh6HPQBrmFz2guCQp1nEFIw
 IYeZnezxtxgw0Ag0p4Zzv4YZOZVyH7hXWjbahPr/pGVldZu0npdNNE4RHhC2R2pXsHuvFkVIcQ+
 xVDmW638KES/5J0ibEWwqTPLGO8no8BcRuhm/yhlvNnx2esJn3B4Chj8eR5fY7147TRiTz82lCW
 dooCR9+984FVA2kN8aoSQTMt/zOa9g1r9MedYlA3cJ2LMyo91OzcKT2/AcsZmBTUlY13PPToqbz
 il8gnIng
X-Proofpoint-GUID: ghpumOdccB0cK7tgAFhzamJ-hAxT2Q8U
X-Proofpoint-ORIG-GUID: ghpumOdccB0cK7tgAFhzamJ-hAxT2Q8U
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b86bc5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wpHHmcXYIatjU_FVFasA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Wed, Sep 03, 2025 at 05:33:41PM +0200, Konrad Dybcio wrote:
> On 9/3/25 3:58 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 03:41:45PM +0200, Konrad Dybcio wrote:
> >> On 9/3/25 1:58 PM, Dmitry Baryshkov wrote:
> >>> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> >>>
> >>> Update Qualcomm DT files in order to declare extra stream pixel clocks
> >>> and extra register resources used on these platforms to support
> >>> DisplayPort MST.
> >>>
> >>> The driver will continue to work with the old DTS files as even after
> >>> adding MST support the driver will have to support old DTS files which
> >>> didn't have MST clocks.
> >>>
> >>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> >>> index 70c87c79e1325f4ab4c81f34e99c0b52be4b3810..e6a7248040095077d6f98d632f4e8a1868432445 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> >>> @@ -3241,16 +3241,20 @@ mdss_dp0: displayport-controller@ae90000 {
> >>>  					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
> >>>  					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
> >>>  					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> >>> -					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
> >>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
> >>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
> >>>  				clock-names = "core_iface",
> >>>  					      "core_aux",
> >>>  					      "ctrl_link",
> >>>  					      "ctrl_link_iface",
> >>> -					      "stream_pixel";
> >>> +					      "stream_pixel",
> >>> +					      "stream_1_pixel";
> >>>  
> >>>  				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
> >>> -						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
> >>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
> >>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
> >>>  				assigned-clock-parents = <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> >>> +							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> >>>  							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> >>>  
> >>>  				phys = <&usb_prim_qmpphy QMP_USB43DP_DP_PHY>;
> >>> @@ -3319,16 +3323,20 @@ mdss_dp1: displayport-controller@ae98000 {
> >>>  					 <&dispcc DISP_CC_MDSS_DP_AUX1_CLK>,
> >>>  					 <&dispcc DISP_CC_MDSS_DP_LINK1_CLK>,
> >>>  					 <&dispcc DISP_CC_MDSS_DP_LINK1_INTF_CLK>,
> >>> -					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>;
> >>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>,
> >>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
> >>>  				clock-names = "core_iface",
> >>>  					      "core_aux",
> >>>  					      "ctrl_link",
> >>>  					      "ctrl_link_iface",
> >>> -					      "stream_pixel";
> >>> +					      "stream_pixel",
> >>> +					      "stream_1_pixel";
> >>>  
> >>>  				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK1_CLK_SRC>,
> >>> -						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>;
> >>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>,
> >>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
> >>>  				assigned-clock-parents = <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> >>> +							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> >>>  							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> >>
> >> Something's not right here
> > 
> > No, it's correct as far as I understand. On this platform INTF3 / PIXEL1
> > is shared between INTF0 / PIXEL and INTF4 / PIXEL2. So it is
> > counterintuitive, but seems to be correct.
> 
> Eh, I unfortunately found confirmation for what you said. Hopefully this
> doesn't cause too much extra pain on the driver side

It will, at a certain point. IIUC, during the first submission we are
going to handle only the INTF0+INTF3 for those platforms.

-- 
With best wishes
Dmitry

