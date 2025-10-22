Return-Path: <linux-kernel+bounces-865322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA0BFCCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C314660314
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A1347FC1;
	Wed, 22 Oct 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAMgLndq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2832C954
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145667; cv=none; b=up3mv2gSim9C8dejeGfIZT8JAXEadzqRlU6GdKwcodLY0iBBQCz3VoR0717LqeK21V01VOyQUk3vvqwkmy1AIVJNeU+VF0O7S9w0lyN03AVmyAOndjoLrekgHur4x1KW+fsuJ6wyBq8mTchZtFD7pue6lQd4F8chsYwQBzAmSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145667; c=relaxed/simple;
	bh=cM7UKuyA9lLWg3NK5ViLuZaeP+xsfXVhzIXOQDzVv0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5U4aGMWsnKe/WRIz7QI9I3jEvKGt3hvQ3u+nOaLo/v7ykZPWgnZDrJZRcOoeS8YmDZrBh7uMs8QnYIeZRxlUCl8pzNUBmaNEOSa3/NzAmHmwGrT8jSR017CQGQJNC9OaCrVnkjR4tA6lRcBmkcqTQ3hyHWw45Nw/EVi1CyMg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAMgLndq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAt3qh026973
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AizstXEr7j+qbEZcyP2bfp+P
	4ZNYzI2uQPOCe7cb9eE=; b=VAMgLndq5aZabdDcknWnnVTZSyxEm3BZHhfkYEdy
	8LbwqLs0IjtwkctqPa7y47YKvZo1zWhXPJW0IP6opR8rTmllLnwLMfx7UcLCvJeS
	EwQ3lRLiYfRg/yOYDCI+oUsAkmGmqdRVFZR9v57weOQvxjR9aZleUhi2aoR7JZT9
	16/zxlyDDV0nBEgIOy5P1vUBA1TZeOlJ15dHPIsVdxyKSQX+ucwRYwRHrcv+fT7G
	e/8lpDtKqTNZ5ncYm+HQY0dkitQzRI94G9DIOnDS+r7AV2ZgN8XY0gB+tbZNXRRN
	6to9VhqF823AB4K+14koNECPB4gi0jINzr0M29Bc8s198A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pnapv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:07:43 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5569a2b4244so545086e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145662; x=1761750462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AizstXEr7j+qbEZcyP2bfp+P4ZNYzI2uQPOCe7cb9eE=;
        b=hXTSimOrURmOvGunbkkIcXecK9nnJNz9CfIbzZeZuqbWcf7vMlpfoQB6NQ0ILObNaw
         aMjjl9fOmI2Y1IJoVaEjQAzAnoXymSP3rJpIv8Lk3GVD+PvzQko2SEcDctze0UfKFv1Z
         ZiThHt2YL0kJ79Y175zWwxyqSUTAm4rHf4Ok3Atl6/HaCrrtRLnxqhDlIad/2CQaxRzx
         i37enx9qUn731FdyJeiBcTQii1B/2jpyTCs+cvopBenhAnuOjrK9pul2t/nDLfTwT69M
         xqoaOgFwhbuigZ1M/31jgcGZrjOGXbqTZX63gSgmck+xgzNUyFnxQbaT6zuFOl3bkPFJ
         Dwjw==
X-Forwarded-Encrypted: i=1; AJvYcCUwAuk/yWn1XdwwN2wAYigoCOI16JCBsTK5pqcGsU2uugF1Pul8uR1Oa9HlDVbZjiuv9UIn6WXwN19uZi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBWPPlOzZ9Hpl3K3UPur3+c9rkBDQek1cNI9aGhlIdHxG2IwE
	Rq2DFpcsFZQSdpbE7AiN1h7RzuuqMRZ5TQ2jvOP4CH+6K9Uik6kMGmYW8oud/7qhT3lnz9opHLo
	T9JyX+Oiipz1CcuXXcZyVTP+561vUmWloW+L/WKvKD06OUyYQdbr+kscizs9a7nM6oP8=
X-Gm-Gg: ASbGncvT2/u3OzfLmWzHEW8O3lfkPJhoZ4U1hdbe8toBY4mlSTtEUbpie125/GW+Er5
	pro/fIkCXp1qfP9MmAAMldAvVeETbFglA9D2NpIBvSTmasgfuHy64WvSN+j6X8E8k+7cI0uFAk2
	NivihcsOa9OVdVA0M9VZxnWPKw1HUVRRV/WKg0CgHBXpDrLS9reJm6w7cZKa8tp/DbF38P+v7zM
	pp3msGy2xLCBAmaXGuPAgGvoJ1hGBnUQhfD3gNL+/oF5KFh+mMNOZtXFnk9vfxKOGxKfy62gdS2
	3nituvh98+RI84WEw8r3ly/Gem9aqpAwQqltSWDeOeWqmlGwkRNhf+OPG8UJEG3gOeRXgzFGtBr
	uU6P0mTCHu5H6kgQG84Q8N0iWeU6Gd6AjxXinHRLwbUnwlsU/dg6e04Do9r0rQtYLyQDdlYZ68w
	WfYJd4n33u3yY=
X-Received: by 2002:a05:6122:3412:b0:556:745f:6a06 with SMTP id 71dfb90a1353d-556745f6b89mr3111942e0c.10.1761145661764;
        Wed, 22 Oct 2025 08:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFXovL3a0V22gWge+cpQKP3S8k4AeqKhy/tySq4N0wYr3JuPRxNPuz/9nahs3f/axhVrCdrQ==
X-Received: by 2002:a05:6122:3412:b0:556:745f:6a06 with SMTP id 71dfb90a1353d-556745f6b89mr3111877e0c.10.1761145661262;
        Wed, 22 Oct 2025 08:07:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9586b2dsm39381791fa.46.2025.10.22.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:07:39 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:07:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: xiangxu.yin@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v5 1/3] dt-bindings: display/msm: Add SM6150 DisplayPort
 controller
Message-ID: <fh7daiy5p5taaz7ifymbivfktjqngs5oashhd3osrtzspsac2z@nswaeyh3kkhi>
References: <20251021-add-displayport-support-to-qcs615-devicetree-v5-0-92f0f3bf469f@oss.qualcomm.com>
 <20251021-add-displayport-support-to-qcs615-devicetree-v5-1-92f0f3bf469f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-add-displayport-support-to-qcs615-devicetree-v5-1-92f0f3bf469f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXwUW2J13eEpBq
 gBbFbbQi5kCPO4wib3sYzQFIRVkDGi5td+lZ1a6V14bb8ePppSEjqggQM7JHH6D5tGA1eGZtjpr
 PMIJ+OUIh+gdMdepwtl7a/hmvFJQFBdpLBkyNtGFfqEYtu+0tXHH5EOqk5+xcSnA8A10JX65dzc
 55cx3lCN60lXD6dMZq2/Jb+UYLKzShQkux+C1FPuMCcxRWdjWelpA/2u3oDWTKwPVIzAJl/vKfD
 uXEZsWJbyN+nFIUJsrRR8IrOKLc8CLjhZy50RoSPU+GXc8oaRwM+KIOVox73y6ROcQfU00Qk0E4
 J30nF26lewemyrlc1eKDdOY8jJ4XtSiLZlvo/eNGUX82L5Kl0bwJD6FZcyvAgvtD7MArA52wzEM
 nHVvRfk+ec2bJJuaRI45T5lB1PNTaA==
X-Proofpoint-GUID: wzed36r9dHs7LZc7ZGTQnQjm6Z94RXHD
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f8f33f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=I67Lji_zawwbCJgw2PAA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: wzed36r9dHs7LZc7ZGTQnQjm6Z94RXHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On Tue, Oct 21, 2025 at 11:18:07AM +0800, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> SM6150 uses the same DisplayPort controller as SM8150, which is already
> compatible with SM8350. Add the SM6150-specific compatible string and
> update the binding example accordingly.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> index 9ac24f99d3ada1c197c9654dc9babebccae972ed..89852af70de97a9025079107b838de578778c049 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> @@ -51,6 +51,16 @@ patternProperties:
>        compatible:
>          const: qcom,sm6150-dpu
>  
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,sm6150-dp
> +          - const: qcom,sm8150-dp
> +          - const: qcom,sm8350-dp
> +
>    "^dsi@[0-9a-f]+$":
>      type: object
>      additionalProperties: true
> @@ -132,13 +142,14 @@ examples:
>                  port@0 {
>                    reg = <0>;
>                    dpu_intf0_out: endpoint {
> +                    remote-endpoint = <&mdss_dp0_in>;

Why?

>                    };
>                  };
>  
>                  port@1 {
>                    reg = <1>;
>                    dpu_intf1_out: endpoint {
> -                      remote-endpoint = <&mdss_dsi0_in>;
> +                    remote-endpoint = <&mdss_dsi0_in>;

Why?

>                    };
>                  };
>              };
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

