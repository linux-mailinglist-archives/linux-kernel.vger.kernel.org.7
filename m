Return-Path: <linux-kernel+bounces-779536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD1B2F550
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2CF189BCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC652FD1B8;
	Thu, 21 Aug 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CivwUtCh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3452FABF3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772106; cv=none; b=OVlYtuSZkjjiwHzD/u1KmH8aHCJudL4EwgkR78PPzhGjUmOazsIctqGvZdz/x9ipt/hiDjuZQcuI6mgXUymvBcT/dlY/N1SbG+pHsbF/AoPjpDE1XexJOsbf9Zn0NuCDNIZaCZoLp4aZUZgjhJaCeZ3i86ZQ8XgbVcGKmZmU4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772106; c=relaxed/simple;
	bh=tfZPMqZtElzvCkRSGhlgoViognsyA3Qe60Shjgy56KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOr1wQ8PjsAh4y6DuZCSKQaU0+XYoUmvayFtaSuUHHibhP+Mrd5Ibo+pIveiFtJo8DSLOQEkWvy9hwO+u1uan0uNE3NGIOOLtU+8IokTNN4EKWxsAPS6RlvPD1JyCakfCR0v7T6tLmBUW7XW0MJA6jcwBBTkbrvYYgMDx+rZ4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CivwUtCh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bCs5031439
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bo/sYYeMVH8ubDzUgHDxT88A
	ZENWIvmqdh74NivXn0w=; b=CivwUtChF8i1DNVsez1ALO1+qJB3ve2S7jUeT5r0
	LmxxdTJx0OVqCVRcTyLKGsbXHvHx6R9XKyQSmuQ28t5VE+9cvH9k5FaBInfMjnX0
	JjIqEP5+hxHNuYO66Vh+J3/M7t2XWQVpobj7hYSEoPV5z8PS7/352vy5bEOJckEr
	j0Z41snS1EXDZREWJ4+PF5WR73VUhgppFNzy7yR90sS6M+wancgB6Z5trIm9FjT/
	FjYX0qLcKjBMgVO2gVZStG8Ub/DbnXz4MhGXYFm7nOLgnVGPqaUKqIqE2zV/Zqlz
	fMtLIqeVo/HOMKQlH/lIya/tBWp37D+snFXNoibYywITOw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52avy9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:28:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88dbf013so19649966d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772103; x=1756376903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo/sYYeMVH8ubDzUgHDxT88AZENWIvmqdh74NivXn0w=;
        b=U3S0JXxVBhp1qodfCeQfQLeLsT9ssHkAOQYvPhMEdCFqeUEophnFyvtDorBjfgOli2
         uL+SDMEs7MjrZSB/p4ggfwUMbWqIYUInsUhSPFdBlngg09q7Vdc31XdHvMMvyInm/wtU
         ge0C7iz0DpSKUw0Q6gyJiQ8dDGYeKpnCNoajZXKij5MJleItM744nWxbES6RJp7m8yLd
         4ruw7Jv9/onHN/tO6hSNLLmeeL2+iKhZYAmd6sZvJIVZjxwLZgx08jEID/nReri2xM6L
         43J8eM3UK5eBYPi77XzIAE96IrvK6Ru2kSv0DSN6rJkiLDVNg3kOLCTqVWATqvy0BLnA
         cuPg==
X-Forwarded-Encrypted: i=1; AJvYcCU0mgHa6cXSnnVQHX0ibbol6brBdaS2LfSFawGxoVY7YxtGnK24AF0yfPDrixgo69FAfzD2K41IA8y0Xu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+bzuDcuzYCVGPDp/5nClpMWzqGmqjv5ePWKeTCEdept77JYq
	6ZT0qS9HeEGPT2440GJobsc9qCdcE4voC9k6j1dCDGR33yKYWZx1TaBin1Or2v2Pqamvf47pdDJ
	UMC9JHiwRWgWkHsv4WxaLg7vBURVeJJEGuoaxBCvEPRdABFk22CbgCwQrD9FID5tb+iI=
X-Gm-Gg: ASbGncsajkOId5z3YqrSbyH1MWd1N0WzHT1c1mEyAz2X6zNNnRScOcSXrT8v1NSP35T
	Bv4gZnPw3/ba4woBsT0nT2KOeeTkr23jvSQIY6w7Qk3wn3d/yTJ63lSV3Z+vg68KBYKwLDSXDdS
	BHKRPfgs5EJyeenyxespOcc6TKBZRJi9+x1HKkgu2klEwjPfi1UMBCN3xi+LIQyjT0LLrKwA8Ih
	F/YAq0Ibx/hhJhItxTB4a7085iibqyNvOC3xHhCUOnCKJOjB2TH2ElBJ7YNfKOOUlCPh0AalSJR
	kCcpIyCJ39OVz7Q5CzMEModEKRwMlWVB2xYbRlChmXjvJ92euh38KfMkrkrD0MsSztTUpZ3rHOE
	B/A182S6N9uWew/kcUG4KcFeWDgpPNPpanv24PpgUtDGKjEt6cBlv
X-Received: by 2002:a05:6214:21c2:b0:709:31f8:fd96 with SMTP id 6a1803df08f44-70d88e96a7dmr16543906d6.20.1755772103364;
        Thu, 21 Aug 2025 03:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwYF+lZ1f8liHpI39C8YmGl+9DTxpGYR/3aTWLPUKxMN0WxZXjU48KYaq6jDvJjEnbHvlfEw==
X-Received: by 2002:a05:6214:21c2:b0:709:31f8:fd96 with SMTP id 6a1803df08f44-70d88e96a7dmr16543666d6.20.1755772102918;
        Thu, 21 Aug 2025 03:28:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc9c7sm3038380e87.71.2025.08.21.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:28:22 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:28:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Message-ID: <3ws6xfmmrnjybn4umbbnzjdksqberzuxslz6uxpabtsz2yzyss@jwblshilyx4p>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
 <20250821-qcs8300_mdss-v8-2-e9be853938f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-qcs8300_mdss-v8-2-e9be853938f9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+8Iux+zIdME2
 dADjZecjtIO6oyz94ft0irbpM0kLNjIn6A6Q56dzcm3YNS7+yIV2xtscaEhP9/9VHdlytbn/joN
 3eQz53RUVo1peaz3qEFbOLbEhdNKziExrTxrCI8i6mH8zEg+NTlSBV5w+x+CAPklRef6iULeH5g
 zCNp5IJePbDhqIOJBvqrTZvnsjB6sF8zwgaNTszDR+2ok2U8XVMLkLJOv87GavpGqqMlw0mtwRI
 ItC1lkDQppyTYuWUUsQ0o7eFlvXuizJxeFhyKqBC8j7rOp965+HBWXwYUrRlAyhybPYI4k+eTob
 p9JXWVOaNclub3aus7Ixahbn4KnpsVpnF1V4cxO+XWbl7vsoQmLSBsQ4yp80vS2kGo+XtUpRYks
 kwgYAnaUZv0qLQR5RntElGmkddpn/Q==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a6f4c8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=WnZbLXWYNgm-BG77tk8A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: Suhs0ZJxUn6ywTwAQKoXuTiwt-Qn2SHm
X-Proofpoint-GUID: Suhs0ZJxUn6ywTwAQKoXuTiwt-Qn2SHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 11:35:57AM +0800, Yongxing Mou wrote:
> Add compatible string for the DisplayPort controller found on the
> Qualcomm QCS8300 SoC.
> 
> The Qualcomm QCS8300 platform comes with one DisplayPort controller
> with same base offset as SM8650. It requires new compatible string
> because QCS8300 controller supports 4 MST streams. And 4 MST streams
> support will be enabled as part of MST feature support. Currently, using
> SM8650 data structure to enable SST on QCS8300 in the driver.

Bindings describe the hardware. There is no point in discussing the
driver here.

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,qcs8300-dp
>            - qcom,sa8775p-dp
>            - qcom,sc7180-dp
>            - qcom,sc7280-dp
> @@ -179,6 +180,7 @@ allOf:
>            compatible:
>              contains:
>                enum:
> +                - qcom,qcs8300-dp
>                  - qcom,sa8775p-dp
>                  - qcom,x1e80100-dp
>        then:
> @@ -217,8 +219,9 @@ allOf:
>            compatible:
>              contains:
>                enum:
> -                # some of SA8775P DP controllers support 4 streams MST,
> +                # SA8775P DP0 and QCS8300 DP controllers support 4 streams MST,
>                  # others just 2 streams MST

QCS8300 has only one DP. As such, it doesn't belong to this clause.

> +                - qcom,qcs8300-dp
>                  - qcom,sa8775p-dp
>        then:
>          properties:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

