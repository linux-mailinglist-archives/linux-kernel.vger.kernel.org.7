Return-Path: <linux-kernel+bounces-798344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D7B41CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D88B681CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3232F5318;
	Wed,  3 Sep 2025 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNC7lZEl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D12F4A14
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897605; cv=none; b=OdefeXBSHBOH9FbLZVllhRQFllnwKOupukxA3SPo7hIj07ATdwDdNejs3IN4s0DpzHwjg/z6hsxOrMeCuZF5F3h7BczayPLDy/HR1qEQuxdHuaJYR0mbvv2OC8s8Wz4JqJ1WbHwliHVLJl/LMaDbqGfQjpkj2i414t45qKJmYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897605; c=relaxed/simple;
	bh=kJsm/X4Ar1trGdOmwZdjzg4ChxjhqnivRo6fgK39i5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl5JyDftkoo15vcAiwpAXNU2w7Kcb5B7Kvi8XEmg0FQtF9o2lgbjzbUMUqAc36D7a6JiDXmBg1FCnKzV7pcDts+POi14wrrtQAf4E1nGjlcDYumlcuI0mjbeyp+Cs7DR0RpM5IeDqjgj3Cclz7G5P6WED1wo/VTeAHmOSubEV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kNC7lZEl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583ACqoC019600
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3po8LD/tlDhYLuSoiG6xgfO9Aa0+IGS8ggHVHTqjVRs=; b=kNC7lZElTHx+SieB
	1RXKKthOAUXZYQfJQXj8fQYDnwehpb4OqCksUcVQKs/kool2Ip0usulzq81QOFv0
	yKI1JmhBtdMvXEE8uL1BkKAawdZmDwifCca2CtipwDBt1wchU5Yn/dABfanrI6+r
	431XPvaZmOCnHfTwUGug6v970wfWWhZ/Z45e2dxO0dMJPXvvf77teG7bBW4slcMB
	KMAbX/hg7/LVLts7mYVAy1v7FiPeypQVs1zSePqwy3K0ZxIk8rL2yshLavRgXByX
	VQCApdhjhTk3Nh54E7l5tqSh5HDmbQdlCSIf4F6FUegQYCtAiD/0Ae69KWwk445W
	hfS5/w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03et4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:06:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b331150323so9640921cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756897602; x=1757502402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3po8LD/tlDhYLuSoiG6xgfO9Aa0+IGS8ggHVHTqjVRs=;
        b=nd8zSrdryRT46odjCy1qFWklfwHIfc1QsPlbsy4dByzPmNDiUMSlmjquBRjeng2DZC
         BRf8zYssm0Bo75d1AZDWDTglUxjZ7LZFRLFU5gO2xKu4TKf10yIvrYaxgu0uTCvbFa2o
         VaKn+j8oRAxWehlHfAtccYFZIh5SzoGcierxHeEwWfVl4AUbG7ADH4ecofKqLXDy2M4p
         bNy4k+Bv4Zyc9MnSVsCtHi7NVHZ1Huwk5mPgKDsw/NEO+1bZpXKQA/Nr6h2UCSqx/POA
         RML3gfD/OU5DOLxAi12hpZvExhsux3PiC4d7N1ERNLqpYdUhe5sRdm5R7vjUsqS7+GZ4
         vBHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSMLAsjm6xBj3H6H3EQjK0ohTrvnuJgFyO7B9PeUc6J/cr4FQzvfgX7nO1ggy+EyNvHJW5m8fxX/AwrbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTodYxKAeoN4Cnm4aCdRdL6+tveE57p+V/VJRVL+MhyD3ESeH9
	rkdUl6WXXhbZw6WHxQe140pcgh3TnY9DFSef3wlwP/RFFRHOwzWKJs1NsIG49fUy6Rgf4PPmvaH
	urV8wPsaEJMG9tfj4ngC9RM10qnFSwNJgJ8hKqup1xGtCWUvLtbCdl72zGx9V139/53s=
X-Gm-Gg: ASbGnctj3q23mVqEbYOBR03q/GHZmtqH49whZ0lnjo+I5sDyV2RmI+rjLUPpzer5oqr
	TGRxnhBWnX3zPUPhpopCY+N2vZAE1sFxG7nQhbVdVw/DfmpOfUBq8unG8BZ75XcCTDbgYgEW+JP
	+sFR481+jnENmYtBagghCyBOFgD8TO1oEzFDaceVsDUksl4gqJE840o8X8ycHrvOMrbYte2hL74
	2O5jztLgLdYWcPtyKO0f9KDLJfO/s1Mg1+drI9cezb239KjW//DCxNxfzhZqmCnyXmIwqd8XCZ8
	o+SJG3CAFH+TBElqno+3p9QI0kncNVg45RVFKtEvB2irYZkSvDfOGj4OiRIlWydR4VNuNyC9g3O
	jefD9p6IBKUaeDfl5nWzUQw==
X-Received: by 2002:a05:622a:46c7:b0:4b4:9070:f27e with SMTP id d75a77b69052e-4b49070f397mr8044321cf.0.1756897601574;
        Wed, 03 Sep 2025 04:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnvWanngRWYl/vDrIJba220OS1NpihDvhNZFTX9RixZk2pRzoKnklmLD8akR5jvqrGDafwkw==
X-Received: by 2002:a05:622a:46c7:b0:4b4:9070:f27e with SMTP id d75a77b69052e-4b49070f397mr8044021cf.0.1756897601000;
        Wed, 03 Sep 2025 04:06:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046d420e02sm97552966b.39.2025.09.03.04.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:06:40 -0700 (PDT)
Message-ID: <4a28c9ea-fe71-44de-ada9-eda3111eff9e@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 13:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] coresight: tpdm: add static tpdm support
To: Jie Gan <jie.gan@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
 <20250822103008.1029-3-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822103008.1029-3-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ExTIWy_pLJRZOkBvj9l0FmqT16Lh0sYV
X-Proofpoint-ORIG-GUID: ExTIWy_pLJRZOkBvj9l0FmqT16Lh0sYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX5xIBi4aCvJ1p
 mE07eaquT/vpd+WVMS1NgRRuTJFwPpemkpcSqWN8TwlUlySv4yWnX3+GD/FmXdtEHcnZPAYVlGL
 ayygFSuCoTjX2k7FbASpqrgYqrrJLXnVQhtudJnbxkFcStY4KBe94g1t9qndLD72PXP7/ECLtQU
 89BDVeptkgothVTjkiWUSGBv5twz/lO1nxR5q4AMkBkueduyWNDgceBCG0KHn2XGXaVyLOk+Tg0
 NOYlUMUUZWXhxsLeGbXgeyz7o8Z53bzCk430Ua6u5/tiL7Gccy+WZPPo2nvUjF1xNKG/jcvsgJL
 Lg3COjlZj7oyASfVG8eIls6C3j4w2YOLJRyrUBbBREmm8IKLzImbt7CIUyBMBdSCK2SwETPrPsZ
 z67O1aI5
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b82142 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4Vys72YcJYr5vsCECUwA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 8/22/25 12:30 PM, Jie Gan wrote:
> The static TPDM function as a dummy source, however, it is essential
> to enable the port connected to the TPDA and configure the element size.
> Without this, the TPDA cannot correctly receive trace data from the
> static TPDM. Since the static TPDM does not require MMIO mapping to
> access its registers, a clock controller is not mandatory for its
> operation.
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpda.c |   9 ++
>  drivers/hwtracing/coresight/coresight-tpdm.c | 148 ++++++++++++++-----
>  drivers/hwtracing/coresight/coresight-tpdm.h |   8 +
>  3 files changed, 131 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 333b3cb23685..4e93fa5bace4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -68,6 +68,15 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>  	int rc = -EINVAL;
>  	struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev->dev.parent);
>  
> +	if (coresight_is_static_tpdm(csdev)) {
> +		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
> +					      "qcom,dsb-element-bits", &drvdata->dsb_esize);
> +		rc &= fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
> +					       "qcom,cmb-element-bits", &drvdata->cmb_esize);

This allows either pass/pass or fail/pass combinations to succeed
- is this intended?

Konrad

