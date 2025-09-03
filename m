Return-Path: <linux-kernel+bounces-798770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39F6B422C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38957AE7BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437730E85E;
	Wed,  3 Sep 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JiQUHPMI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48930EF77
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907917; cv=none; b=p47rA9J3Mtom14EG7VLECAzZgBBaC127jDkb0Vk9pEhELKvWHxha94z2+8SqPC87kwNx8NgEmM0BGv/4a4hR0qgzkRvfK1WLo/XnEHOxsupgxMWN0YsULzVT0QkeorYOS/RH0/+sQbP1/92Rgi+x8QP8kDnemRmSAhq37Q0t0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907917; c=relaxed/simple;
	bh=nDdnURVmNpmOogd7Nfp0LN9f3gyF+XZZc9oYnxiLqbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhDHavFcKwd2u5pCKx4C7qAQ5pVm4+S4k9dMXpO/QN9kgwQtO0BZQZEB4xPvfm3EhPfSrBYbAl7HCVSl+oboMI6KFJ6hVgUnk4aemVNeMkvLAWqvfgW5oekxQmW/OJiwEO5y1Fsk1mdzT85eScMTjKzeI9upFa1QFMKDDYyM1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JiQUHPMI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF2u9002021
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 13:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MVkE7pic+AjgsrJue6GbGhHU
	Q9x1JH8BDEQU2GuSGtw=; b=JiQUHPMIZ1amb3LmdAGVRwan/onxU07FjGXjPdtW
	cNxHn+V3hA+FkdtJyEdKoHaK8NdL+727EcxpzkHqp+f8dUD9LvDNDwD2FWbMogVR
	LTN+lIQhVDYNKM+SbXQgb43Iu8PuIErNavhOMQVs45uRyxJszpZNS4sS/Z+OgzP0
	P3boBMO5sU0t5ZfyM4v8EdQZZw2nfw/+guwGFJkSCFiFrrRcO6B+u+ONgsZUd3Vz
	eIKYv4Nkty0xMA3gyISMno2+JEvimM/mdLFGYYOuwT/jq0SV4c0Mc5KmW52BPfuG
	MPWKou82NFEY4RYM+lIEccMp7FPHbWreVjzleEodtYPRsQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33skk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:58:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b30cb3c705so61222001cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907914; x=1757512714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVkE7pic+AjgsrJue6GbGhHUQ9x1JH8BDEQU2GuSGtw=;
        b=KPBTTGFISSZcYBdCY5xITW39eRm8O95V8ylcqOqpXgsqoRTtwA6xOZjNqTG6/QfZVN
         Khj/bLGKDx96snmr7nGvlb5sE7gbu2WvVg4DUDrk2o8KwDQZyVl3uZsr3KQ6oC8XcPKB
         wG0Z0ODk6VtMjmh/N+jzyV5zjs4uxfXAMyJUo69DKDMQ7u7kcZvNXRTiJwONOLSOqCvN
         eWV1g/KqzhvjeyIvuqkbZOCLtiQA6bJ4vW/Ver4qBn8EqrvtnftfvpN6i6LXHu+jRtUo
         gzfqYfDPe4WvKdKa/qSNGUSu0zd6XoTI+saurEW9ePrCq6201mrtd+4a4OScftMgooOu
         Dj6g==
X-Forwarded-Encrypted: i=1; AJvYcCXL9e3isTGj0EpKS48kZQ5KHgfwXth2arE0W2Nwxcizga6KwlckuWuyYGFNa2wMbQbqwj0BM/7CNrNAvm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZ3semAutlVN6kzk8BVl5xEcmvAvVEJIRTbCtCpBCxpB7g4CX
	k4kMV2gvG69TsFvoqRYEcFT+V7fPvdZT5eBI7WKTz091zTPLTubgsEqrGXOUMN0M/YD67LWgxwd
	srzfVpo6JO6ydopr6VH86M3kls5PWxuzr/CdwQRmzB7ZnJct34WxFfvMjs9tCJgTL6YY=
X-Gm-Gg: ASbGncvDL2yuM23A4x9LPpKifsRL6QLx4Yup30y0T/ugoRsBmSby6dg8FMfCzQHsD8J
	hiJvYpFjWlO/99u9gjRNnuZKQRkcYdoQJAPrcrzqmFjOR+XR77q6EGAVt2gYTqcQKIufHQ7hTVA
	n7vBnieNnPi5wFpTic76ZjcgEtx/s6f9b0zG/p8jYPDy2J3nZHLj0qnAE27I0QRBhJDmLymRcNH
	NXQb6aiEgGxOMrYabmK4V63UO3wvRWMPmMGosdMjbImUJ9defAwqNKQ/hzwX6opZrNIQHu6frtb
	I8AytO+ZtylaxFzeYOuLOBkLB+2mYJaolLg8gN8zg8VJxPgjwOFMUZjmGp7HSKVMZAl6b7iMaxC
	2DPX8ArP+Vg5gIJILtAN3fEK0bTcdHrKk7/mPP8Z0XCKAPgGyRU28
X-Received: by 2002:a05:622a:1306:b0:4b3:81b:c5b0 with SMTP id d75a77b69052e-4b31d547993mr175558941cf.0.1756907913678;
        Wed, 03 Sep 2025 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhtC2LX93cq9JwucMfrRhPpM+u3XQlKXseCZc/zm0UTkPE9L8QBLFctB4NBw13tUK4hQVEEA==
X-Received: by 2002:a05:622a:1306:b0:4b3:81b:c5b0 with SMTP id d75a77b69052e-4b31d547993mr175558381cf.0.1756907913057;
        Wed, 03 Sep 2025 06:58:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4cd7bsm546787e87.144.2025.09.03.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:58:32 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:58:30 +0300
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
Message-ID: <rfhqfbx4q3kl35ktzaexjjshzosv4a2tkjthtvo24aoisrdvj7@i63a55qx4mnn>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
 <20250903-dp_mst_bindings-v8-9-7526f0311eaa@oss.qualcomm.com>
 <964a58d4-ddb6-4c98-9283-1769c0f11204@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964a58d4-ddb6-4c98-9283-1769c0f11204@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX17EhycJvAnPW
 9/a7HWVyPDNRyl4bk6SHo13CRSJHjdFnE4dMqkojMqbrRSaAxxH0MCPcMgrGvtfElV2XJnjPz0Y
 V72w3k+0ct1Q/wbKWPnx48J6Ex0PEu/X7SMLwvm67GUESkZTq3Qk4uH+ziJuZ1LHoW/tJgr++70
 tceeCPHIkBUkM6LQW9umrJ664q7I7LEsuFr9L9VEB5Ds6x50qrPHhadIbMJdfT4KbkhYMKZTE3v
 C4s9YmQVORNiPTw1TA7dOLb7+M0TiRBJRXn8hymajC977HnagQyPYibhPjjqr9ot8BIVu+aOiuD
 drxqibylqF1uEcbQN84cZzsgdhZtmrlNE/xPUuS8e0Bb7R+RgPAnIko8I2TCOgtK+sKx7GQR/7F
 IU5pbNv6
X-Proofpoint-ORIG-GUID: iPvTdckWBco9LRaxIqRIcN71YXl_ZO7y
X-Proofpoint-GUID: iPvTdckWBco9LRaxIqRIcN71YXl_ZO7y
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b8498b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3kmh57S2fnx10ZXIFTUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Wed, Sep 03, 2025 at 03:41:45PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:58 PM, Dmitry Baryshkov wrote:
> > From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > 
> > Update Qualcomm DT files in order to declare extra stream pixel clocks
> > and extra register resources used on these platforms to support
> > DisplayPort MST.
> > 
> > The driver will continue to work with the old DTS files as even after
> > adding MST support the driver will have to support old DTS files which
> > didn't have MST clocks.
> > 
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> > index 70c87c79e1325f4ab4c81f34e99c0b52be4b3810..e6a7248040095077d6f98d632f4e8a1868432445 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> > @@ -3241,16 +3241,20 @@ mdss_dp0: displayport-controller@ae90000 {
> >  					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
> >  					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
> >  					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> > -					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
> > +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
> >  				clock-names = "core_iface",
> >  					      "core_aux",
> >  					      "ctrl_link",
> >  					      "ctrl_link_iface",
> > -					      "stream_pixel";
> > +					      "stream_pixel",
> > +					      "stream_1_pixel";
> >  
> >  				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
> > -						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
> > +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
> > +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
> >  				assigned-clock-parents = <&usb_prim_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> > +							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> >  							 <&usb_prim_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> >  
> >  				phys = <&usb_prim_qmpphy QMP_USB43DP_DP_PHY>;
> > @@ -3319,16 +3323,20 @@ mdss_dp1: displayport-controller@ae98000 {
> >  					 <&dispcc DISP_CC_MDSS_DP_AUX1_CLK>,
> >  					 <&dispcc DISP_CC_MDSS_DP_LINK1_CLK>,
> >  					 <&dispcc DISP_CC_MDSS_DP_LINK1_INTF_CLK>,
> > -					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>;
> > +					 <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
> >  				clock-names = "core_iface",
> >  					      "core_aux",
> >  					      "ctrl_link",
> >  					      "ctrl_link_iface",
> > -					      "stream_pixel";
> > +					      "stream_pixel",
> > +					      "stream_1_pixel";
> >  
> >  				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK1_CLK_SRC>,
> > -						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>;
> > +						  <&dispcc DISP_CC_MDSS_DP_PIXEL2_CLK_SRC>,
> > +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
> >  				assigned-clock-parents = <&usb_sec_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> > +							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> >  							 <&usb_sec_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> 
> Something's not right here

No, it's correct as far as I understand. On this platform INTF3 / PIXEL1
is shared between INTF0 / PIXEL and INTF4 / PIXEL2. So it is
counterintuitive, but seems to be correct.

-- 
With best wishes
Dmitry

