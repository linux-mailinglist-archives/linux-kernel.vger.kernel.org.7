Return-Path: <linux-kernel+bounces-777478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4821BB2D9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4626D188E3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B82E0B45;
	Wed, 20 Aug 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m04ZDh9m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605ED2253AE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685110; cv=none; b=gxzRvP050HJ5UJ//MmSPUKdE/+5N1W1MQ+8xpUPY3kyIfW95EztU6IPC4jhLDCPm5LuCS+NT9e8j9tpoZ1K3Av/GGtide/qSCjxytKPOSANReSR57qM1c8TCe1uYoTouNoGrodwdRNp2D1nYLAqVhj0p1mLYX70s368JE8wXqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685110; c=relaxed/simple;
	bh=RD/YhGR6n6Cqcm80/va7EGUN4MC358kbGLBV1nwlbKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaMcakW6liHxBPJNbXUkk1pJmi09VG6d6GH2Jd83cm3n+q8L1xXphDYXD9CKGcSEHWAGLLGfTKkw2RbOceWSJzAjtYu2CfacH7yx1fpDtui+kfotQR+c1ZjopK0yLu0Ipg2MxCJ/5kFr7QzRL6Zk55my36FglgaqqOuxo/n5vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m04ZDh9m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KABa9M031245
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RMmIf6OvZrK65C2lJ9Pmjnze
	nmAYNUQwMUXR7Q7PPco=; b=m04ZDh9m3eZZiWHDtRw+bhpEsiBl3XlWz+Yc9AOI
	gHgXA+fqa8B1WbSIincNp6cSJOpfOMfWNNeETEgTS9HKHuZRTzUmxmb/OzkyMP9k
	opd6Qz2SGN1A2t9iHN8DKTqa/T6mXIK/P6/mxC03PJ+R5fnmGQjP6fFgFenI1Gtj
	8IkAuR9N4dHdQX4tyyNg0SlWajKunB4eLhw609Cbvw50G0NqHdLEAmNQoluZ7aV7
	D6xVni2lWpctfrfXLiFV7woLvwdcFJRye/COQZjEuZhqtd7fFffcpMqxqLNt/0v1
	oZAzzT7VTEQLP7wPHJ9g5aWfB/0yyYq5TGfP3zqV9otVHQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dhakn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:18:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c7ad98so235004881cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755685106; x=1756289906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMmIf6OvZrK65C2lJ9PmjnzenmAYNUQwMUXR7Q7PPco=;
        b=AgK9dgpNN4uUXb8n9VRG5nrRIIkovn20zKe9Rh0ooAYHmK2bo2A2S4m3V322bjik4/
         xJB7Aon5GVsJkzWBuY6GNcnNLTXWcnOzu7toIg1e9FuimlhA/KjTfCQfWexZKVKvl7u7
         WltOrwGndu4MQqLaRCOwPTbj56IlDkrMVdySIvprSbcYslmqqIZz9paEKyw4MIHGR95k
         WvMMYHQ3GlFdVW3Zv29rur4KRlxrdiLN4TP+46NyTHtIqnbcg/h9PJELxcPQ4lCZf7qP
         jkRHVzqKN/BUj6fU9+9/Vq9CpyTO9P+LB5ktzKt6G+g9aSB0fK2FheV+1qipLWilTwZc
         kJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYh+Y2ZlruFcVsSaQl6QcfiwZHRqs3F8/a2Ts697TwINYM21BAjdAwZL72kM7fXwaiyej8NjMC27xM+UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGs1fHjPPfyeuhJr+UAG67oQ4RfwfBl4QTSIgNcWnKM4twHE4D
	1GbPHEQkLrWFXM7aIwzXMiAIKj3YRbDDEdXTL2vnYP51nYQy2cBjE0BrRSIxIuhzjdPO5cJuXn6
	JPc1LfR+xXtQMrhmCdoDsq/WNYPXcG6rL9i9fztduo2zK1baS3fiy3eqEVACawAJf3pI=
X-Gm-Gg: ASbGncuThGxSEji3gSGfDbsV1Y5cANIAZl+7cy3w1EQP+qn4AnRDnxrxgWO3U0Bdv76
	dkW1sAvp8p+ZlL4iANkcYJjtAQH7cmQ1p1x/8l2H9+9Fy0oU0XwoGs+kOm09sXAGC48OBN0PLnH
	04DyNDWEVJr4rX+m8qrlFfB1f4cjckU+jeaaZJ1zg9U63RGQlSJgBrrhTx+ma0q5hGj4fLsiMPn
	RvT4RxStikHMT/4+kagMF+Y1AIXTYFd/1aSVhMEvz8aiXNwm4HXs5v+QUTY5Q7/GMvs0X4kygr0
	qZuux5IsWlHTqhuq6AaNsbFKTHM83iPbh6oScAFNVxXizZtjTXKwdIRtW99QAbIrREAlDaZyZ8d
	Ex6rvO9t02DVCcZ9NdcsrX1haRMce+SYj+/hE/QcBsBlfQNkHDOBt
X-Received: by 2002:ac8:7c52:0:b0:4b0:677f:db03 with SMTP id d75a77b69052e-4b291a450cbmr19243041cf.15.1755685106421;
        Wed, 20 Aug 2025 03:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2AOZHGENtzCbjXG8zdnjHcyu3nc3kzJVHOmLOa0gbBzdcDRDqks1SlZYpXJ4L372H7WS/sw==
X-Received: by 2002:ac8:7c52:0:b0:4b0:677f:db03 with SMTP id d75a77b69052e-4b291a450cbmr19242671cf.15.1755685105881;
        Wed, 20 Aug 2025 03:18:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55e02c31498sm623244e87.12.2025.08.20.03.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 03:18:25 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:18:23 +0300
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
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
Message-ID: <75ra2ofecqu6tid6kr4hnyuztpl6jjaq2ksyquafyajhq2sa4d@4tkggrdqky7y>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/5gM0jEE5ofN
 lGuZTIsSu1lNJHDZlLhzCwCmaQzFCKGXZWPbmoNrno5RqzpVjY+jrxq7Bldd+crHn3at6MQUSYh
 gMwjXHMAPQc9zMQM+h9spaQn0Izs6Vt5kn9FL42fNpTkjsU/Zk6vrjTLBM5a6PdSQ0MQ/c19qQR
 9UyqlfQiyyqINGPW7493lcqkPmWC4BqwvEt+2nTkVsoDoXXwSgWoFqjtJPhzgNbXdLMFa4myQcS
 oq3Fv2QdEVT8HVfIaOHFRKw3iNO9WpZjAFpNv0FkS3VmRCtx7dlMCDN20QWd27+d5qmDgidxHKJ
 QI9tgiGxN3BuRFl8tUC5zFwLLcmp5vYwJfuCL8/SeJ7aNS1pGLWFK6vrVTOhPQOAz/QdWbusrY6
 WwiQWZU0oaV31UbWxxb+dyCcmdGWpA==
X-Proofpoint-ORIG-GUID: 22TRJijZUZhQVo2_7O3_LZiEJuOWwwSj
X-Proofpoint-GUID: 22TRJijZUZhQVo2_7O3_LZiEJuOWwwSj
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a5a0f3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6LesCdOPl9v1yPo426oA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
> Add DisplayPort controller for Qualcomm SM6150 SoC.
> While SM6150 currently shares the same configuration as SC7180,
> its hardware capabilities differ. Explicitly listing it ensures clarity
> and avoids potential issues if SC7180 support evolves in the future.

I assume, it has no MST support. Am I right?

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,sc8280xp-dp
>            - qcom,sc8280xp-edp
>            - qcom,sdm845-dp
> +          - qcom,sm6150-dp
>            - qcom,sm8350-dp
>            - qcom,sm8650-dp
>        - items:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

