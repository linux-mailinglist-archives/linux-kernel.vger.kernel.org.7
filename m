Return-Path: <linux-kernel+bounces-748505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B47B14204
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF5B189DD38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A149276047;
	Mon, 28 Jul 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxRRx4bW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52669275B1B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727398; cv=none; b=hxApWPCFC88AW+UMcgQtqRlzdK44D4iS+VdIhyezwnQvj9d5MWSwN8O4lTd5utSfS3uLe35rIFro5w6aD1E1VA/XzvXhRD86pCP/chln5xicSpKLb/Q5Zw8OLYtNB7TT32Wu+MH3OD02LvBtdylAPH+Zj9nro0YPh3ycVhrdCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727398; c=relaxed/simple;
	bh=m39t4hBEDIOE4JkV53k7vdPJAG4/pTKjuu7PU6u/wj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcxdX+cGii0m3YbJmpHGTLQdOo7vDo+Cy15IOnNwpLSAGTD2kcU0iA2dwU4Oz1A/NlSlLdk2kjvzNxTc5V+SNf8o1LLhjwB1JK7Y26Fx1k/QhfrSigj+y8ejbZLmM4geie0kMG7kSI7SsVK3+xRDTOBAtMplxKzcRdL6AGg7AU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxRRx4bW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMSq012151
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oT3tXcSx8+6IFxvzSzWBOGBoJkG+N20NCBDeHWmRh9g=; b=RxRRx4bW+XfnjtNx
	cXxPfHvYE3kKcnxdM9/MlmG8oFS37+PQ89XZIIdeXMmN9m4UyeGOIbVxbWEfKlvS
	zXbdCe+sxd7uvON5kJ5bGT5M1SfXV6Nh4gzvfEBbKHpLJwV2XUIHDEXCTdCLaTSf
	fdQU5TEs2rlvD0xvSabZilWSFqE5tszYf7KDUH92dHYXOiFYSFylsv26+GVCvruN
	oLRKd4vdPayCzglgYIxJAfQwt4ECUsESUbzoaOoEprCJjLSFPKfcxOx5cBl/kFyp
	LodkABTEXVQz+ErtotXVSkrcRoUxOYsoMI6/Op+BMlhuE7BcbMVIhZ59POVc5JPe
	jH82uw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk5g3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:29:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23638e1605dso36057265ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753727395; x=1754332195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT3tXcSx8+6IFxvzSzWBOGBoJkG+N20NCBDeHWmRh9g=;
        b=nRN6qONyhPSxcDgXtmM+OUVFs3TpENQF/sprHTpsBH3P2SeAu5WwD79vWXsgxREGhA
         WfibyyNMwkO7zloMJetGO9hYYnPXd9K4uK9zPMJv6R6zMg/MmIjt+7iYm4giZPxb/iis
         dwAmErQgT9LrwqNUVUUxIW/EXWtruneUPHHWBuF1AlS9uBVm+suOKag3W7u56vPyvljV
         Se5Ymjid7nVnEg6E35zitni0HrGGwlUtS8W/6GmpEiUult+WlVH8uD6b0i6Qmtej5gM0
         p9zdYY9WsqPoxw6O8CYLuW85uAN6w5hoT4bBV59Om/MUFybxoVQaEXVo/Buf7kJpXInq
         e8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWLhhDv464JMfnVYiOon347qyeZTU/dTJStVRiF2a3lbslqzjRH+xZMqLXufydB11IburhxcI2OFy/GnYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhzqWkeJK7u+MJrWigKHfeGds9eZqnxt4b6hrKmpgTX5xqDGs
	Arl+wPdcq7qaJLT1O35EQO74WLmKybpScUl5CQw34GaVF0Zxq2bgV7oz8FO0d/uWE9m6SAWf4vQ
	E+ykwavzrkD7VgtT8uEahUPjNAcytowZRBMXJinfbd0UzypaGKoaNz0O4bmxI1Q9NIXI=
X-Gm-Gg: ASbGnctwIqM1nSS2br6v52c4s1jItCuupQGTa4q+Lx5eh5OiOWzavV1bDCMk4LA9bng
	L4WCCHYB/lXJ/rKbh1elcMPpsOlA0ThysMJngZCbP+d5hW8t0YrNakJwX0HXwrhMjIeydH98J/P
	piIx5g9JXq3iOeka0mfZyqjE4sblY1Y8P2W1Y2HREyzPgFL6tl9sF892Mi9a1CGE1p6X8VazoOR
	Ix1CovnG9kJtwPLfbyfPmmY0c1IWW3534z8qG115zCXHlzM5VmJMEspHmg4Q2MbxlrmyeB9Nv0n
	TWq8w2CJWom6uscodySeNccfxqjmeyQMm8gCdEdK+URX5OPLpyq8O+4Vt7E6sOS9/ORqNo8vGP0
	L1QSy0RCgMkuZocZw95lexQ==
X-Received: by 2002:a17:902:f30b:b0:23f:f983:5ca1 with SMTP id d9443c01a7336-23ff9835e51mr72280345ad.12.1753727395409;
        Mon, 28 Jul 2025 11:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAAEQKwWNVIHaeiLUK+6MPkWiAUDHenXFMWUMIoSJAH/g0px54Std4EA5mF2F39xEpbfaLQQ==
X-Received: by 2002:a17:902:f30b:b0:23f:f983:5ca1 with SMTP id d9443c01a7336-23ff9835e51mr72280055ad.12.1753727394829;
        Mon, 28 Jul 2025 11:29:54 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc5a9d219sm55658715ad.98.2025.07.28.11.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:29:52 -0700 (PDT)
Message-ID: <8399dc75-6363-4ae1-98cc-59b5b62dc8b5@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 11:29:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display/msm: dp-controller: allow eDP for
 X1E8 and SA8775P
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov
 <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250719091445.3126775-1-dmitry.baryshkov@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250719091445.3126775-1-dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=6887c1a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wmqSsp3ovfGiw9AtJwoA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: rY7FcCgw6rJCT6ayUuACtQuJ4gVR9o4-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEzNSBTYWx0ZWRfX+b368Q+7/kAh
 IsdB4wPPp24gqBRG94TVKRmOWiIPP3BGRjTjae5nVmzu5mVFcZCoMNmImrN+qBo6CXtLla0NYi4
 UcDVFzoF7bm8iwtHp++/Ptbf7d12Czrcm2rcXriJa+2XEcBThKaXydphjS7r72417pxnwH8OQU2
 zwBMmEX9gA7svkgmxL7JjAX1A6LHeKQn+OpC0WF4BcGN3aZBvs3kK468XUBJ4kYWNSFHiFKpTDl
 LIr+0DL+ytt6LV5O1SVtWQPwdh70S0nDfhpmE++J0hXZbyCvAaj69ij5yNwWF4l7BhSkmc2cHhP
 BAXOoljOez89vQ0W43P42sKWEFMSoBYpwxOg40Nbgty/pCEACMrz0/1H8gFn95qrNycXnPaS9Nf
 8EuZsy6orPLZHI0xo6+q2XkKcfccaQ/ha4fLXjA2dw5bYAcqKGz5+1FwI9hwoZgYqUAaiZn0
X-Proofpoint-ORIG-GUID: rY7FcCgw6rJCT6ayUuACtQuJ4gVR9o4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280135



On 7/19/2025 2:14 AM, Dmitry Baryshkov wrote:
> 
> On Qualcomm SA8775P and X1E80100 the DP controller might be driving
> either a DisplayPort or a eDP sink (depending on the PHY that is tied to
> the controller). Reflect that in the schema.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> 
> Jessica, your X1E8 patch also triggers warnings for several X1E8-based
> laptops. Please include this patch into the series (either separately
> or, better, by squashing into your first patch).

Hey Dmitry,

Thanks for providing this patch -- I'll squash this with patch 1 and add 
your signed-off-by w/note.

Thanks,

Jessica Zhang

> 
> ---
>   .../bindings/display/msm/dp-controller.yaml   | 26 ++++++++++++++-----
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 4676aa8db2f4..55e37ec74591 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -176,12 +176,26 @@ allOf:
>         properties:
>           "#sound-dai-cells": false
>       else:
> -      properties:
> -        aux-bus: false
> -        reg:
> -          minItems: 5
> -      required:
> -        - "#sound-dai-cells"
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - qcom,sa8775p-dp
> +                - qcom,x1e80100-dp
> +      then:
> +        oneOf:
> +          - required:
> +              - aux-bus
> +          - required:
> +              - "#sound-dai-cells"
> +      else:
> +        properties:
> +          aux-bus: false
> +          reg:
> +            minItems: 5
> +        required:
> +          - "#sound-dai-cells"
>   
>   additionalProperties: false
>   


