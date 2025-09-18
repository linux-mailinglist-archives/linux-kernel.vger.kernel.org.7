Return-Path: <linux-kernel+bounces-751172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D06B16605
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008CB5656D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313F2DECC2;
	Wed, 30 Jul 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p9IMoYYt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD32E0935
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898692; cv=none; b=UckxygtlVdMidiXQlcfokqEc66A29Kfpelw5A7OgP1sB3tUosIR8Zz+G5ZzzOm9hu8pgXhPPShrbtHG5bEJzXqrWHqp9rlH1QNUvkEA3lmQKy9GOSkyHvyVBlM6qggPRECl5LWMBfmHVln3O8BlLqWk8URauQeW7TBkoyEP+p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898692; c=relaxed/simple;
	bh=n3D8qHnnfuAiAoc6PZ9oryWver6UAcBaxmcMguTYLIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsPCRkkInMOKlNOGpgSI0/ERLY2N1FtdAxkk1zqeFEa7VSSi3XajaIQ+Qw7eT23r7BUUscUjGvm2Lwc07N/Iun4TbaYMzfJHHjjbCKoOvvTjXaPY2NwpBtIQtaZg6XTfiVG6VHkOCLUUNellBNRzpCq+aYY4KIiCYHqH5RqgTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p9IMoYYt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb7bq030216
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I/8jBayyhvVLDAZPoDLRfHEl
	UvAYchL2u6ScDXnQkcQ=; b=p9IMoYYtbltFngmzBsxUuR//FzXgU6tAT0ENf7n9
	RMdxhSr+BHgJ6wfkZjLrkqZ41ENbDxo6AFcwcAXHb/18bDTKHsm2Mz5po1ry2zRN
	yItzjGckbaVR20805iPqgwoaFQDa+SbQn8Ms+ja3u1GxrIBRERUr9gMcQnh/I2te
	LIWAaYDGhBPZx+ee1U965UNkOrwbpxskiwVzi2E3ViDdM6vCLeB4WywwwB/OrgK2
	YjdgId6OzlrxwhosEdxmy/bxHzHr1jeyBOou7kkMCSi2OOJnOZx32uEhyj2TKoHh
	ehcnv7bnTpITx83ryUudM5Zw10g96LKDGS/OZUClemzYSw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwes7ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:04:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e623a209e0so18584985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753898689; x=1754503489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/8jBayyhvVLDAZPoDLRfHElUvAYchL2u6ScDXnQkcQ=;
        b=efVZdlixI11CkKwTwYaItVhKTDwfivCoMYNylbahDxyZF7ioZ58bTv34EwjHacTpos
         cAae4D8c2eqBzdin10BJKHIWExsFHGiANqCPYHaag8ENlcfCxaqECT6UiUXWqONqGLdb
         3XDWJ/0hT20bfiyMbPfXV1LQZLUjG1V3/XtML9Z+XY/sKCe8Y/OnWdJMFLi+POcO6nkV
         GqiqubsK7nyur8KsLp3QOB5xcPoTQFqQ87EnFEqET4cTBEhr7IHhKzU21x/OFRLDqPiw
         r67SKS+DeAEt1S9BDv70C1rHCtU1J0eCUqAQVPz5YIN3+/9Q7+2NSxiKK1QSGjSIMNoe
         rY9A==
X-Forwarded-Encrypted: i=1; AJvYcCX2e2QjekGleUebdwZN6hFOir4eriNX7mzin3ozQGofrIaDMnU5LPhU7oGMA01LRdGfBZcIXPkqiU+0Coc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzECAGzahsXic+pqXh2QjPzUeSi4m18ht+d3jRFQHfKaYm9BdyL
	ZhukxoJgO2KOwvhkUWcUxfCuTNssYhWXNpUb6XBHJrjIPPU/2sNXniPv5iAJFaKfn+xjRpDgNAG
	/V5SWM4upZT1X0yNmDLR4xR1cQ1xvvqI+yFNsNEJWonTYcNKrK8lOsf7oyGQp3bIg+dA=
X-Gm-Gg: ASbGnct3cUJwnYMvOlytzKtL2dMgupT5AVJrYyUlCZOi0ob92c+pfWa7ehPCD6XRfiA
	8rS2y5Ml7uGBR21NnoDwJvNB1yRCWIzERJNHSvZkeY43/yhfRCw4e62TIbUgH5NRKT3AyccHzyG
	yEEc+tZCDcmI+vQfJqCG2fLD7/jbczVd5UC3ofN+WI1jo8sfpC34E1nXS94revsNtfhII+kSbkT
	cHjZ99bvltcGAhlOfK2XLp5eHKs7scFwQK5duy3BQtEKIv8sJ2xfpJfDMHBxhJEI0zDqNKOmSFA
	26/7t4dBJZftlow5vVBQZGAOvJg8ihkKFtaE2nVT49QuuHCK69eibgGWPIiLYAAKpUP4WNi4vch
	IxEJvt94iOyRVIxQpm83xv+KEUiolYsltjx1lv6Og70RSj5yV7NY8
X-Received: by 2002:a05:620a:3954:b0:7e3:3288:8ec3 with SMTP id af79cd13be357-7e66f356727mr495183685a.32.1753898688689;
        Wed, 30 Jul 2025 11:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkOwzT89t02FAAwhQoy8CKlO1y04DetSnNnh59BpmdEzw5MvIIAzdTos7aUbXT9mMSFhlv6A==
X-Received: by 2002:a05:620a:3954:b0:7e3:3288:8ec3 with SMTP id af79cd13be357-7e66f356727mr495176085a.32.1753898688034;
        Wed, 30 Jul 2025 11:04:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d9bbsm2237982e87.9.2025.07.30.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:04:47 -0700 (PDT)
Date: Wed, 30 Jul 2025 21:04:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
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
Subject: Re: [PATCH v5 2/5] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Message-ID: <yhgdibfxtv3w7t7strxd2ywy7gustrff5tbjtlpeh34m2bkhkm@xosfinmgbkui>
References: <20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com>
 <20250730-mdssdt_qcs8300-v5-2-bc8ea35bbed6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-mdssdt_qcs8300-v5-2-bc8ea35bbed6@quicinc.com>
X-Proofpoint-ORIG-GUID: g_MUess-o1uWGArqfOBoo23kh1hVGDkN
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a5ec1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=WvbujaHHVq_kfgFs6tQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: g_MUess-o1uWGArqfOBoo23kh1hVGDkN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzMSBTYWx0ZWRfXwwUsdz+iu0Ai
 MlFPb97bB8LZezAzbqQW34dgnesb8pL5gbBV0qWybVgoJJU1eOKs3ZqG2NPSTgpYsPyFZnMbhYs
 A2WMW7Bi1ih5BcHs1pm7mr9Edl19XJUQ2iLSXkBrf1UMJlZe3NCvoviLgBj65TXB72MdN4e0QIp
 wJ7i2plGSXPBtC8XFiHftgxwIPAcqLFrIZlG1bc8fXaPkbpWQZG/xdO5ezCHMXAtljJtFzUo0wi
 d3UwA2+9YYnY6Rk2m8xt56nlquNOzwTm4Uub1nUThNwXcUhuymX12QUOR6PM+216D2meScIg2bu
 alLN+Dn8lqYfrghE+fC1EHvFy3VLr+UxuW4s1fOUUoR6M+I2UASkmLtEccBXr++54eToM/W/eWD
 gcrkWc/YjAC99GAtry9x9dhf54zLOj+KWZteTpw+btclvIebAMQUzG2cdzKN/G/hvDhB3VOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300131

On Wed, Jul 30, 2025 at 05:42:27PM +0800, Yongxing Mou wrote:
> Add compatible string for the DisplayPort controller found on the
> Qualcomm QCS8300 SoC, which uses the same DPU as the SA8775P. While
> DP0 supports 4 MST streams, DP1 has been removed at the silicon level,
> so SA8775P/SM8650 cannot be used as fallback compatibles.

"It uses the same DPU as SA8775P, but we can not use SA8775P's DP
compatible". There is some logic issue there. Please rewrite to speak
only about DP.

Moreover, removing of DP1 should not affect DP0 being compatible or
incompatible with other platforms.

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 2893f097df826a5f941fbb754fb4a96a1e410a70..f5930f29c91ec95e9182c7b8ee83c0549c6657cc 100644
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
> @@ -186,6 +187,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcs8300-dp
>                - qcom,sa8775p-dp
>                - qcom,sc7280-dp
>                - qcom,sc8180x-dp
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

