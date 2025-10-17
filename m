Return-Path: <linux-kernel+bounces-857374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA5BE6AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C05B6E02C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9D830F94B;
	Fri, 17 Oct 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PwL2vK1Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346BB211A05
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681910; cv=none; b=GZayG7fTOJWmZLXnm+CYX+bSa9bF2o6lV1Jx/9yAOO9BK4O1Kr/GWhzSQIpDAfKpyjzd9IhtT2f5fIeKwa8srIQO3m6/3+wdkFtFqdfWTES30QF44yq8J7rk6EzrEnCbyY57cHiPsYO/gJ/sgcP2vjgJ0Xf+8tZK5eR9lq6gQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681910; c=relaxed/simple;
	bh=cLdHVMGkg/uBHFPRADqLysNuG2fWTEaI7wCxtZaTusg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgX6IYXljd6+Ilu65Soy6XnDkMcMNySjRz9/fUv+igwhsIBhB2GrpZB4haaUcRaBpMaRwJziLryUbGah+R3hRGKPF7RaQPzPUb5Zjcbl8GaMWMbhzuuPfJAWea9Ynf15QEWXM5wQl1Haj1byomS9QpZzBmd+2z0FgB60rw2djQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwL2vK1Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLP1W025235
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	12MGkH5cw9DWbLNSOakkfhLLME9RWD5IhyTaBBVeGo0=; b=PwL2vK1QeoA35wIW
	jRLVuRGG93GYmBXmFVIAAbFPnnmS1X/VOOEpNbXRGkF5hTCD/nFqPL2JVuXxSJZk
	+t1kxk5lNmVjCkPK1zOMZfPO5lQLydywMXvmXEIfS5wwJBsTdKiVEily9h27RlO1
	y7agdHYbfEpz2bowrHLa+uzuZGooefIpjnsDvzGEgM9ZWvLcYhYR1rg4GtwjaORp
	uipiXra038UwOvCmIAl7fQDwfgh4AEk1FdfY2qaqSz0C8Zy85/Sw3dEUFXlmzpcT
	RIVJWjKRi+/yN1q46wFEYfZIkCiz4SiTvpukUfj5kMBhapuRkxHju6rbShdBzmr5
	pegYuA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkk2c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:18:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso1439947a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681907; x=1761286707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12MGkH5cw9DWbLNSOakkfhLLME9RWD5IhyTaBBVeGo0=;
        b=isjY8ShIj8nnWcyIvUmeyOQrJqQqhkAGg32JX+Cg7VkVz5gekvp6aUadM5W7YkPDga
         crtulpX97er0oDlBaSf4PFto2vpmyrl5eo3VudhyCJJz3KP6Z8lwOodqVkZxo/eGW3pY
         jbVbIMZdslN5mjaqS3uXBGwMqqTIlDtOlIF5MEKPIMjI/cJCzYUdXEDKinVQGYOvbArJ
         PAzZ8hCXR9YeI3SBhu+bLTAGnAblWFupSeNH4NEndTgs5uJ+Gyu5YUiQwJ3vedTqpZrz
         xpqocp1IdHXiwxJLt4AF8Q8DOovJs5+YZEG4pHb0eOATO5cJjfTK1yTc0TApUbL+mOgH
         MysQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXsNK+YfIOVpwvSgv84X8oaN4Zfxz3otwEp2O8fzQfTYqwhkfrHpiZS/gExltVdRfVGmoCuP2eoFDAV1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQXHrmk7YML/pvPxnXLqW8bOjuMUkWoyZd44JjhMm2GNh3edE
	8eAf/OcRW810qa0oYyLy6X/jRD5bdBsepg+7P+xT85zUkyKIIJQSfeUwFQooNyk1zypUt6PhbDX
	SQJ8qfTxFegOjjiFLr6DUrwJ+y4V9AIJYTo2quzoA2sfWOIW1oXr1czQkFVGl/I0xG50=
X-Gm-Gg: ASbGncs/5dOuENH6xnGp8By85PLkfsH1fVNesziUKuObWqRNPZishOxHhT9B02huwQ0
	lOh0PkcbGk3cPgvlbPS1yr70M3824SzuWwYdrmDHaIfg8TQ5eftiES/n0i7UB4B805/BzP/fucc
	mvTuEzqKhauQvpvNSzYmVN7qa3CRrl4etk7iFsGg6xNJM+87agoW5U2dcv5JoDj3S0NTIexBQwM
	TwvPUblLGkhJDwKB4ql4yf3TFRm/9orC593F3h1cdQBBUnVVG2eBZAVAZ1GFHtjXMQJ7ig9gMyb
	Gcq4gbGIh0bIXVSHAGdjUsz+SrEJ32YxVE5WQsLPeh33vE1jil721H5rN+dCOSGvsq5KfnCo7+g
	Zpi+/h75+zF5xINhvLYbOhUrEMGlwbsE=
X-Received: by 2002:a17:902:f68c:b0:27b:defc:802d with SMTP id d9443c01a7336-290caf82b93mr32883175ad.28.1760681906726;
        Thu, 16 Oct 2025 23:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUAV5xzlaoN8tL8L8ACYEiMSXjhbKQNNw0S55lf9JlxkAXmoHYJ9teNZ3tUbBRnrasjgpqaw==
X-Received: by 2002:a17:902:f68c:b0:27b:defc:802d with SMTP id d9443c01a7336-290caf82b93mr32882915ad.28.1760681906250;
        Thu, 16 Oct 2025 23:18:26 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a9a7sm51736125ad.18.2025.10.16.23.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:18:25 -0700 (PDT)
Message-ID: <1d497f90-a64a-7a37-be22-f83d9af382c3@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 11:48:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: drop unused module aliases
To: Johan Hovold <johan@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan ODonoghue <bod@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251017060540.8624-1-johan@kernel.org>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251017060540.8624-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DhbFPaXjUC2Eb0yLUsuicEEJGigsMS1Z
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f1dfb4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QFjVjgdLP3Ufk_jjaVwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: DhbFPaXjUC2Eb0yLUsuicEEJGigsMS1Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8eeP40exHKFp
 GKfmakk58ckybZNSaWBDrcWT3pXCa422CJm0zjJpQps7flRLvUJo1wvxZ0UI/gQramoaanx6eiE
 iCMHLUhSq42HQgNWYH/80tycr/LmaKnLZQhu8149p5Ey3NTn32q0f6voXl4qKV3X6Ix+a8P+/d9
 QMMk7tk8U0xZ8IcQcRtpYGasNvOZQgXcNkPuiwIuIdWX92K1qB5Q2iWLPKmUxvb4qeJvcedeW2+
 XR/iDoyab92PlFZpGdkhbdX9cKWiaj1nDQOl4A3Q6Qz3k7fVKudrNl4zx8qYBBKss20Byl13r3T
 UxSWE4f6C3TZbhsKgsOQo8oM5k2y2Xe5Sd34jBSUvGWcXSAiSfMffHuoWDL9MXY6fP8kc+llbBc
 XY7HkMVbomOw8wuG5cl8Xhk6+CPJMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/17/2025 11:35 AM, Johan Hovold wrote:
> The driver has never supported anything but OF probing so drop the
> unused platform module aliases.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 1 -
>  drivers/media/platform/qcom/venus/vdec.c | 1 -
>  drivers/media/platform/qcom/venus/venc.c | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index abf959b8f3a6..24d2b2fd0340 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -1146,6 +1146,5 @@ static struct platform_driver qcom_venus_driver = {
>  };
>  module_platform_driver(qcom_venus_driver);
>  
> -MODULE_ALIAS("platform:qcom-venus");
>  MODULE_DESCRIPTION("Qualcomm Venus video encoder and decoder driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 2d822ad86dce..23376b87b6a4 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1879,6 +1879,5 @@ static struct platform_driver qcom_venus_dec_driver = {
>  };
>  module_platform_driver(qcom_venus_dec_driver);
>  
> -MODULE_ALIAS("platform:qcom-venus-decoder");
>  MODULE_DESCRIPTION("Qualcomm Venus video decoder driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index f1abd2bdce6b..f86ca5a3b23f 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1661,6 +1661,5 @@ static struct platform_driver qcom_venus_enc_driver = {
>  };
>  module_platform_driver(qcom_venus_enc_driver);
>  
> -MODULE_ALIAS("platform:qcom-venus-encoder");
>  MODULE_DESCRIPTION("Qualcomm Venus video encoder driver");
>  MODULE_LICENSE("GPL v2");

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

