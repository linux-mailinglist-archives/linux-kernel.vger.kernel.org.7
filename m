Return-Path: <linux-kernel+bounces-798160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1355B41A26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4E57A1CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B72F0C70;
	Wed,  3 Sep 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0GFhtF6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD292F0C6A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892071; cv=none; b=RKIiSCGPkwFYAj1eHL54kYRW6i4x8dlnHG+76JZtinMG2MBvCvma1zN75+H3H5Oa5DkqsprWcpqZVc4I+AwZTDp/42NXP8YZHmU4lBH1EVUys2nvGLBNIGuM6LUoX0TdkS4t4laUFEF1Gg7AHIPnzSYZNoWiE3dzXSwf3qC/hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892071; c=relaxed/simple;
	bh=k99mFqKcbrXmSfgyxDpumBLWWztr6/dlbEmY47pyhfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WlrPYzqLQOPUZ9nE9lvS4mjku4eOxmaf9+kgZIcJpzwEww/CU8oxhoW+LYj385zi9cFWofXbwy8O/0FMsbHXSHaE33Pk3ePxYJorU1cPTD0hYPjLyJkxyBUp56x4u2qRuULk+1OWYgLwfByG4g+/z10osuyMSV1yamUkmjgCTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0GFhtF6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832WSvC021331
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yyPRprpshXznCs5FcBlCnF9Hsm/bulJY/Z/Gs/qTIaA=; b=D0GFhtF6O96nXgl0
	We9gI44TYrAuD0QNhqjRLS3X2/qW+3ILkHHjPl3sRk30HALepHXgR/oNiNahXobN
	1/WVyZbxYcHPuf5DXNLR9Jyg1IEkVsfFr6NBSfBUTnY0AaEEc7UYSDxgWeTK85mR
	yuRmOgVeXVoNQZqIB42PtV/GM28H8VtqdlbJTkncL0ZVeyfqXFtSZisFAI+rv1uh
	Cm/MkW62AccUO7nAqvMN9Wqm/qw+oVwPbqUfFNEUjJD7X/kAyvkVseIl0Crgl6tL
	Rl0s0rzjWhUNptJumC6GA9jqLnE1pFZ5Bd/lxMZx/JRc/svj6DCvVsumH4otwzc0
	IL2oDg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s34ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:34:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2967fd196so19043121cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892068; x=1757496868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyPRprpshXznCs5FcBlCnF9Hsm/bulJY/Z/Gs/qTIaA=;
        b=TTdYama1CMY4q7uPuEk0h4QwgZJLVil2hZ7jqwn8tCF+S5uoQKNLgpcnCukhZGmptq
         FKqx/56s5TkWj/lp/WkWxu7ISmXnfUYY5nJywonVoRbYvc6mc41MQJYJK80h/lhZc4h4
         m97nXbQZvU4J+sHFbkew/uxnfBt+zPBlL+LI9k+I+heu0Z2yLDFyVDCoO9pCrntrM1Ge
         EDw4/JMUUHoroLlk8hiP9M6lbWm5l41cESEkfwaDMoXMVgZjiBZoTznxbQRyZaW/zRoP
         Q3evBerhxf29WWQ84dtep2tECb4GhGbbDXGcQYhhyY4wbARaAgcvcpAwnJnzurOcHQQE
         4Vdg==
X-Forwarded-Encrypted: i=1; AJvYcCWEZpW4HD85JCk5GURrhOmkfhIhCwlPOW3Zc8gtXKNL6U17/TsdPEAOKMSvwtTyB6an0N7RnFmcZqOgbEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrblApYHbqJQ9DS7Xi1iWRBGXqQjkILb/4J6n4WkLRfpMFoFe
	NAMAihN0jNXWgOkrZuhXD+wuIfu+k4L6DeMvV5iFoe/rBOpUbm2Kc0Efyph4IYQlmexLMVlta5G
	y+4wq4774THVTLbGkEtwc6OKRDS31WG/pJNg7R7whZUdNG/xjrw0Gk321NhaOxoOTDsA=
X-Gm-Gg: ASbGncsavqTNAtxC6SwqBvphkm1Y5lAqUnut5R4DdV5SLIIc1/L4zUUdhGtIrHR3LNs
	+o9KamxyOQNfT1yeWVCkdS00ICItgJ85whmsYGJOe9/dVT/DL/tMRzG9DbS04DZ7B+VT3VvWhuB
	KKhc2p06KDy18x1QOXNd6q6OYm9ebc5RCzQ39Na4PtBm/2pDa0uMPTmg4kWMPwq8Duw38DrQwF7
	/9LpjXi7S53IDMRbyoeUGOyp42a+gOAa9WTat0WO47QGHvHq6txGgTEMBhDPAnAPzkdiG3/zr29
	HRchUhihHv9LrIef0yy18MMI4/uhLFW7axyyPbwz4MpW/rJe/NDL4Y81pTFp3rjRuo/D73NYQp+
	yUTJ94V8xCbudgHX+mojANQ==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr144441221cf.7.1756892068015;
        Wed, 03 Sep 2025 02:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFDTBcppto8XLOKJk5x/oor9svNZrww9ip34CnGvwDiPoUfu5cpSAuZRsl2sn0sMXTVgM2Iw==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr144440971cf.7.1756892067585;
        Wed, 03 Sep 2025 02:34:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0ed6ffebsm1200591966b.32.2025.09.03.02.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:34:27 -0700 (PDT)
Message-ID: <666b4115-3e81-42c8-8519-f6d7b16c66df@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 11:34:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: qcom: audioreach: Add support for VI Sense
 module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
 <20250821141625.131990-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250821141625.131990-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXzDFfy+NEQFvl
 k8ZBlgZ/QUx1+5MQ2613h/klitkCjwhplb6hy3jJQYRhapeATrqIhWyUzP6upmwQgmIKaF/p1vH
 l/eORDlYwadakBGErSnFilM0uZWgM2tJ/+3L+rmOVL68leAG9k2sVeM1H//O4+v1ZqhjH5BnPnK
 4pr2VzsSsqHn63M8U+ZFDXQqrnIpnszZ5eo9gY5joS+nSQmyq9cX7X+lCDDUKw8A6bkBL5fquWQ
 ekzMaf5ZkWm6OqjVksF98e5ct5WrlYBp7t1bXX4paupP1BBBwmyDtcthf7T3p27ybwTgU1tUG6h
 EITLHYkyKkH28XtH5WRAlD2fIMXpSXsDR51x27jmsDYBv5mg0rdctHe8hsNKsy17mb9BYwY2GNo
 00Std6Cl
X-Proofpoint-GUID: SUCrY_dvrPXgrQyKLVUlEkH_K7a1IQvp
X-Proofpoint-ORIG-GUID: SUCrY_dvrPXgrQyKLVUlEkH_K7a1IQvp
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b80ba5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=rH1WamYxNCqinqo8aXAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/21/25 4:16 PM, Krzysztof Kozlowski wrote:
> VI Sense module in ADSP is responsible for feedback loop for measuring
> current and voltage of amplifiers, necessary for proper calibration of
> Speaker Protection algorightms.  Implement parsing
> MODULE_ID_SPEAKER_PROTECTION_VI from Audioreach topology and sending it
> as command to the ADSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[...]

> +	uint32_t num_channels = mcfg->num_channels;

u32

[...]

> +		/*
> +		 * Map speakers into Vsense and then Isense of each channel.
> +		 * E.g. for PCM_CHANNEL_FL and PCM_CHANNEL_FR to:
> +		 * [ 1, 2, 3, 4]

"[1"

Konrad

