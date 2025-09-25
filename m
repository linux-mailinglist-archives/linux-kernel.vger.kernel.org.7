Return-Path: <linux-kernel+bounces-831614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7724EB9D20D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308B6425252
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921F1DDA24;
	Thu, 25 Sep 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcJ9qBim"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF1D27E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766760; cv=none; b=GPC5G7Ck/PzT1snw2b1FoioRMBFx3euF4QVy85MP1Vvvi0sWcLmui3njlnTwdk5qCsjH9aexjZU1BeNSQe/YlHHByV7RGZdOGhDajixl2z9WhPFDKMre492cK8xgHYH5ni7e68GWKUG1mrCjA1cQr8IUcb4gHNYADCT5MAWBMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766760; c=relaxed/simple;
	bh=V0o0RUbSBp5pz28ZYimBAnWbI9+qlIN8juPN5I30FXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl9QrAMKmsWIsSv9nkD6EF9RWnouEbb5VV+WzFcBkgRVf7ub4oH6F0M1WbxxjKCOfOOL4c0z2NfRLiShbwro4ktljbuiy1YKOk0YhUDXXezV7xx3y6ns9bpNWWAm6a9/rxa69A54vOz2n0wjHluhHTXMBnXaz8VTqWsBAv2djK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KcJ9qBim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0dRVp002118
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kXk60tSvBFJFBNcCoJMszP6h
	av8IWwZrJglPAylRH68=; b=KcJ9qBimdnC4DcQ9taZSKFlEBr65ZwgcP691v3rR
	rVBr+bJOKGlI7De2HUw/QaU80Zor7DjqZT4daVHVTDgRLtgDeguznlTSq1ssCAIX
	SKrDS7FnshiAIjqMrFr8foGlk3n3PopOtyyeBKqP+bpMH4AFd3ry/8yzEP3HqpNj
	WgF5phMsGUnfe31Y07O40j0MimurZujxMWVw5rsIp9bJjGEmZJ0hlBx9517haYC1
	6zm7Kh58VygsJgmQbqC57zfsPwe3o8uJs73z4lxF9XgJETc9fl6Xu0/0y3KdRrrh
	uSmPOVafU5cq87OBUHsAnfXB6nv0//HbjL41ij3xTRb6BQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98pe22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:19:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4bf85835856so14599161cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766757; x=1759371557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXk60tSvBFJFBNcCoJMszP6hav8IWwZrJglPAylRH68=;
        b=WJOC2Pp5HBAU1afBxjmwVpyjB3RQ/6q2PbxySgUyns/JaJJMXY/DxwexILy8FPogt9
         TNRB3aa8L91IuIiLUy7Dr4q1omjryaW8ZZHvmqNuHXOJrIRcSwPMQjCmmVZENsNMM9vQ
         Te4FCqrkim7xF+MEO6AN9RnORWYiO915SzmNLhyqlLcisxXipq2OCef8QqM/Q/5wDVXD
         aUpm9nDkUYXY/pbNQ5gfprC+x1MCoY+mzXKVTwY0pQboeGRTvzHvVoF17p9f5Y59lozv
         LxLpKt0SJ990lctojfglhTygAZaRw1mGzCXepdUrGC1h9tOpxc4IQFdvt4fIlFQRpGLb
         bUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZnDvMWuhUUbiW4jF/nEt9OfNcmBWqLUYxLkV0GlHDpGgie/w3zWVVtP+Xd4ENx+0eLgEyG44+Or1/5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5D/OoW0I/HCw1DtzzZmnJmD3kma3ZIq7qnk5A+6HwGX8kCo/
	aSuSM0RSzgmhDf6+FoLJdGv7faTIgEVMXHtnYQ6GHQ0vahJMHH4z4ma/m3j4O2FX9mf4y05Z0oc
	gWOdZFZrV8bPzWfiqM7yTAaJcxB7znDZAGDqnDt0FrVTK0vyB6tWqRGpGubi+l5w3FUg=
X-Gm-Gg: ASbGncsrWA2m3wPfSjVGHQDdq+T9CxLYj0TIQBTNyl7SZ/4Vu4+DBZZYKgkIEYftUjl
	izyhTl6GAo7iDsUfZsM2UneGkZmiFgBL/4dSr8782oMJymFi9dl2a3KwoFYi9BpzjIDEpdPtWG5
	VxUEwFyBGCYv5z1xlqRMPqm1EIXbIjnmKZ6ZYKagyVkUwnmEMdF8BC+z+Y1mXdY8i4aX35i0WSS
	THAjjxABDzueTj47jsIgHMwL1mxR5pN+oKBT7ikQwb6LtPuu7AAndgslqGjZ1FhV9FuoP2SPTM1
	fO2xA8PPD0ZI6vO3cwzZ/S2azqX8onJepbdZwUd8ujGhQMe8CQ+1BkcVyfkQR7abkQzEipvtsTt
	VYp+Szh9coXH50sMdwF1sPLN5hY5MRFaFQ1p1sArvov6mgeE1qyiZ
X-Received: by 2002:ac8:5712:0:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4dacdce3156mr13155431cf.33.1758766757175;
        Wed, 24 Sep 2025 19:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkHoyd8pfNk/u0CL0VcNtv5YsWD3I6SuFs5XOWMFIZNGOfOtmwhgR8TS+cBKd/zfDeZIjh2w==
X-Received: by 2002:ac8:5712:0:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4dacdce3156mr13155191cf.33.1758766756673;
        Wed, 24 Sep 2025 19:19:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831343111asm244566e87.19.2025.09.24.19.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:19:14 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:19:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali ADSP
Message-ID: <h4lk5psnwx3ma3um2sozhcdccwhmgmbje2lgjks2czcrzn4mre@svtnbyzvrivw>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
X-Proofpoint-GUID: F27W0FbiPfhqv7CPyDmamOcDS8P-LDNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX0Ylt6EP9lJfF
 bNp5+brqVh07vuMTnVooN3sBJaHJ2+Dyw3243cffl4/Tph+AMg9Z0BbQklPylkWda5DsMVTUuL0
 nKkyd7ZgqtDkOmbVtGCdMHHBCsTnYFEhVL9xta9V/TU2ngixbLX9yeEkJXnuks5iKwjUWPRJSkX
 pqgl5YiYgbX/2s72rRtAOeCw9ebKJf8hS3H02k3H/l+NiRW1LVBKDnD7scr3GjQUwV/kHM4wkke
 8PNgqseYR2ml8a7OVr1uv2HzJaihtfx0okk3HqyAQIGgbajEKuJkg9zJpFZtgO3/WAlwJTLXPlF
 l9N0lmeG+H+MLYw8zUNUCUiIIcZ7Y6KJitO2TfOdA6pAjR0xA1FlokakxEJUQrQBgxfXPZznJ/t
 gY55rvVf
X-Proofpoint-ORIG-GUID: F27W0FbiPfhqv7CPyDmamOcDS8P-LDNu
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4a6a6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TG0ozkzLEzouTHCdhgAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On Wed, Sep 24, 2025 at 04:37:22PM -0700, Jingyi Wang wrote:
> Document compatible for Qualcomm Kaanapali SoC ADSP PAS which looks fully
> compatible with SM8750, which can fallback to SM8550 except for one more
> interrupt ("shutdown-ack").
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> index 2dd479cf4821..be9e2a0bc060 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> @@ -28,7 +28,9 @@ properties:
>            - qcom,x1e80100-adsp-pas
>            - qcom,x1e80100-cdsp-pas
>        - items:
> -          - const: qcom,sm8750-adsp-pas
> +          - enum:
> +              - qcom,kaanapali-adsp-pas
> +              - qcom,sm8750-adsp-pas
>            - const: qcom,sm8550-adsp-pas
>        - items:
>            - const: qcom,sm8750-cdsp-pas
> @@ -95,6 +97,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,kaanapali-adsp-pas

This one and the next entry are redundant. Do you see why?

>                - qcom,sm8750-adsp-pas
>      then:
>        properties:
> @@ -185,6 +188,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,kaanapali-adsp-pas
>                - qcom,sm8550-adsp-pas
>                - qcom,sm8650-adsp-pas
>                - qcom,sm8750-adsp-pas
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

