Return-Path: <linux-kernel+bounces-806186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72FB49320
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6542007E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DD30E0C7;
	Mon,  8 Sep 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPbNWXMh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CE30DEA5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345084; cv=none; b=PuTF2dRUIocANm9Uml60y2OfKSGPDC/xA+qqxKr6gK5ogf03Tt2pRb3QIYs2b+W4xrx03EkafDFU0+KfryyHuNRiP92MAOprOomDoBL846I4lLeWys1CBkNxrKjOvBF3uIWDYDa+5UVXiiewEdOw/gSVbCdPG2nbYL0oyTFjeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345084; c=relaxed/simple;
	bh=BVmhf05AnvENSu4Q2O9muu1fjrqbpmJnlrdvdpeVF4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tyv1LSPb8CTzmTyI/xyleKJkELqtujBHU/OiMWxVHeEOpKFJiYEmQ7eE7DugOfF5IG3jHhkDz4lctP4f+VANO32CoNdlMVPCsVbw69c/VNTsnZN3RgDVyKm6c/ALjZe/rOvqCIIsAjtDQ3A0gPZOMVYe8SnsK87/H+aDKrghuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPbNWXMh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588939Ru006566
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9XBnFXGBmeYr88ojm2wcO7hWjCnRSWfP1E0HSc5a+g=; b=mPbNWXMhJIB1bhi+
	SKij4Hcmz4JORbUy7bwGxi3KJY/+t4JGgD6HzXlAAEHPTTssApfucuAqDPJwi2II
	N1rDHu8CzFGOQqHKI6eF4dbDNiQT25jWJEIEwKqWU0TirDKbYSWANZs/2T2BCvI0
	Kg9uRJgYeyk7i13NetjTPIAatSDzc22wyNHmZImgB7Df/YvYbohcidA44G5As0KV
	m91nklRxVxSdeWzUPK0cZYAa+kOMqufPNUqhctvDtrhYnLYc4ZHCro/s7IiSFZ5y
	Vs500sioapGS9OTfo5KdQbqtaa5tBH3KZRx8mnqmKHuipfw9ZdpkZ4Pv8UrerKC8
	IHPvFg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8w3dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:24:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-71f2e7244c7so5406416d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345081; x=1757949881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9XBnFXGBmeYr88ojm2wcO7hWjCnRSWfP1E0HSc5a+g=;
        b=JTm5oOFgKfrwURuCaWJPUr6DjjqqM9VgG8PAbY2aFrkZq5mKpj9k4u0RfyYFnrmBAc
         G49mUHY6lyEQvbK8vs5QOKKK4HvMQnncFSwgxF7RhEIucOcBv+8niIXmpCsUOfwAWK3H
         XpEWnUAucLMIcrWfket2yse/oEiwp9g6yojuNH+P4bhjDf8TEphuMrpTs3mMSU3Pz8u5
         mDt5Ot5uUDTCnTTVUjj7fWaV4uft0RI70fgbJUXdKCZtTnBKhOIIYkjNh8wsqOmRTc3Z
         UkL5ntFmxr29H45X82e+PXWZCE6TafIoAOh+8KuFi7qMHEFOwhPxLaxiBss5Z6R5u3wa
         i0yg==
X-Forwarded-Encrypted: i=1; AJvYcCV5JihMojCGYZVA7GdwJT3phnReE1WqlMVWEOpCKxwtOP3mPgPmNS084EsheaJyhePdg3RIdFJQ9v3JEvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqp/jntJ3TaBgwiT+pv4g2G7JfaB6v6oI3k+xyruHbo32n/+Je
	vYtvexwDIFI4JmqwmQ6Jf54tTFG/1P7PUaKZ545wn7pFNBM5THJ/xw/dBRky82HDUUufqkmGH91
	z3BZPEjVOiKdyr3LUyhVhHVuJLjWU41aX7pWVGAe0mvHbGFxS5MTnglGzJlMEmAtzl1Q=
X-Gm-Gg: ASbGncunhEpl8MQT8VlwG5cLdghp9PiQ9R9sqJRqkw9MOzHb8PjF3D4MU0IxBG7JZ7t
	zMXDsoXgwNERq4iQ8IcgV7teH8lE3oC2E4ge5PVcoYG8aztLOGe8S85o/MXA0PPsThVQB77Tl1k
	K3tJ7/Ny08JnOc3+LhmkO/SftamviCnjeCOI0ScUkseqRHE9yxQPF8aCxt/bXrvQPmH51jjtBu6
	7wczb1tQsRHDFv6LR70Ib8J7w9SUrrRBHdhU2xXaSDttG/0C2HZRbosOV+lSJV1LJYQnJpgfgEG
	+XtZD/EW1RZa+ktOOYodI5lZpZImhIc7cV+YYHxUhde1xjUu8g12LlEZd4j5EE42dpB+I5/IV32
	O00gzbJuUt42TW/6dDatAzQ==
X-Received: by 2002:ad4:5c62:0:b0:72a:df4a:e3 with SMTP id 6a1803df08f44-73946f70409mr55645156d6.8.1757345080626;
        Mon, 08 Sep 2025 08:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/dM+YUVzCoKCgc+8cdXvnS5qCmMcy7DhBINwLAE11WFETAeMMaRl0ZDxjjD0D4fmvZpBH8A==
X-Received: by 2002:ad4:5c62:0:b0:72a:df4a:e3 with SMTP id 6a1803df08f44-73946f70409mr55644876d6.8.1757345080079;
        Mon, 08 Sep 2025 08:24:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62778a094a0sm3537550a12.31.2025.09.08.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:24:39 -0700 (PDT)
Message-ID: <8cf65d78-2790-4467-a9b3-372af53c1374@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:24:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] drm/msm/a6xx: Enable IFPC on Adreno X1-85
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
 <20250908-ifpc-support-v2-15-631b1080bf91@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-15-631b1080bf91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bef539 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=l1a4ANfPRBzC3aqxuR8A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: zDO1OcMTmE2WcJMJVzJEGQzp5llYck5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX3I3QDaq77aoM
 riVtzbpGSUDmvK5B7z0Clt9Uxglipy7HnXtMaCBq7O1i1F+HFn7+hxJ7+VntRVPx9qFtNcqUysu
 F+tDZEWRSYN0Iob/LW4QTT5yq9UPjH7MEiFrtYJv9QniXuS8E16W+GunK2E0k6dc38kesc7BdqC
 AEoIpVwr5fZzNwRRA+0QzTi3wB2bNajwfwwQ5xpHw6VuJjEl7lxDeM8nDLgOjT8Aq+eJN7nm5PB
 omyiBLYNsvXMruM+edfrqsb9exvQuvi1r8AQfk6nja92h/BeKFHAVZiC/W0CW5awotYnsKCU+AG
 j2/CSmUf/Fui1tAZKcoAc3Fjdvz3kQs9wr5xLf+HJ5+gVNeDDdWpw43CgiEwtUK7ujuyELVHf/R
 VI+ubBi4
X-Proofpoint-ORIG-GUID: zDO1OcMTmE2WcJMJVzJEGQzp5llYck5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/8/25 10:27 AM, Akhil P Oommen wrote:
> Add the IFPC restore register list and enable IFPC support on Adreno
> X1-85 gpu.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> @@ -1432,12 +1495,14 @@ static const struct adreno_info a7xx_gpus[] = {
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>  			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +			  ADRENO_QUIRK_PREEMPTION |
> +			  ADRENO_QUIRK_IFPC,
>  		.init = a6xx_gpu_init,
>  		.a6xx = &(const struct a6xx_info) {
>  			.hwcg = a740_hwcg,
>  			.protect = &a730_protect,
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
> +			.ifpc_reglist = &a750_ifpc_reglist,
>  			.gmu_chipid = 0x7050001,
>  			.gmu_cgc_mode = 0x00020202,
>  		},
> @@ -1466,6 +1531,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  		.a6xx = &(const struct a6xx_info) {
>  			.protect = &a730_protect,
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
> +			.ifpc_reglist = &a750_ifpc_reglist,

The latter one should be part of the last patch

Konrad

