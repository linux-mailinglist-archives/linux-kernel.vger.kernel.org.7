Return-Path: <linux-kernel+bounces-806172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE472B492DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D151897B62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FADF30CD87;
	Mon,  8 Sep 2025 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0WGRrFx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97D2F0C78
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344699; cv=none; b=dpC3IlNGcikBT5+CA+jozK/895mPnBmrlNGqgzoGtr+70/mDb0kLEYdzR6Tuto4nBx7hTzLwP46H97LeBLFcB4F47IBIw81buNbNH4ZJrP7SYC2z5kaLTTWH8/6EdzaC1NLGp2gMdt+azi4jlf3KhtkQ5CtqbSZfseU0dVPR9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344699; c=relaxed/simple;
	bh=44eWbUv2FAvl42HDZ2rGgCbInZ15HVOOcv/9qcwsNRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RacTtc2QhfhK8dcubSovn4pZJdTLlv0y0D3fE/LVqDiRnYd1039Xitg2ptNPpD3uunIAc76gLHry2QTaeDfRyn9AvFgIZAAo+jhvEldOD9fWDIdjZ1DrIhlywbvYrG5f6IPoA89GMHYiW77dza0OwlJw0V8aeak9Oh+us6GHTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0WGRrFx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Asfvp012371
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/9G8YIX33m2SGtXUdjDCf/RB5vwDmC7O7BN/b342XFs=; b=O0WGRrFxyvZuZZ2T
	RfklNROy07xaXL3a+3GKtYslpD6widCTQ/LzeF4k4bsWd3umfIBWcIqPFKgSJgKE
	ZEIPm67WccjAAaK56vDSiNn2EIQ6XtMeZgpKM0pqTPhNFo3QT38B2LwU28kMNhJ+
	AZSpCkqDoCPmJsbjYX+wvIkltw8hkUJEDBbw4udQo7iFrH5UIoEkyQPuFAvfg6qc
	FOfcLIN7uOS9DvG+ChT4Azfo9ugB0PJqMmlnD2qlhwrUjWtigV+8zzkVnKdj/9iX
	4NA0IZHycYnFvPbgmMtyHD8AAnXZiYhEjW1ZKQZrE0EaR4cJ9MUs/OXYFWZ3+BV1
	fs+OYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdstt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:18:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b604c02383so8494811cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344696; x=1757949496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9G8YIX33m2SGtXUdjDCf/RB5vwDmC7O7BN/b342XFs=;
        b=dTaS4scYbthQuQ3CMRC4/3rVEPmCvAV0/MQK3MZo+naBb0tNqjeNIGSNl5qKqHA4m5
         k4PzGIc8yd0p+1cNGTFfYcEZ/JIX6zoZdjdGZnxcQ53+IIjy6PGP2R8m3P2N5GYUbI34
         n4iOHV8LN+ICDANM8wNekki8S/8mUc5iAkIb4Ozz2tP1SQHG2ffOOtZous8eHwQ0c6Ho
         ngRXEkIGsU8RI49PfA648kxAcprlZDSP2q5vLQM2RJXGQMfKX8s+Ek00kCMAKFfpEkv9
         GWcoOEEHbleqTtyrMv8eeIa8WV58gqYYls+PWI+vTCCLQ3s6Q5ChirFXewtG4dkaN7Z6
         dK6A==
X-Forwarded-Encrypted: i=1; AJvYcCUikipq2ott0lnchUgLqh0T6JXMcMwSvKlafQEgyDFZPE/H7G5oN6kCMkP5ING3fX6Li5nmoLHdsppiO5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4moYxnj+hNgaSUarJrcRhniS+bpjF83DT67vdIS0wjmmIf54Q
	LMe+QpEiAWw5ZA285+HSgtElCqwvAyj2qVvlmINMzhQKan8DAqIzJWLEznEPowdYNVopVdKdOI2
	rVGLUxPAqdibYdsRsVqNpoBqzPc6BTQYJNqG5Bk9q9pUrih01hchDiYPxbV0NpByTCL4=
X-Gm-Gg: ASbGncvuZ7ffh314oJU94/LcH0pmZCvA+PsgCIvlE35PugT70dU9Ivyg6OCTPRa9v2B
	VeqOnIIOrbgfCkR0M5rJsNrfNKWiywbq2ZIvzlui5CWWcZRsQE7lFvL20CDcGX3Vz2SQjOroI4E
	tMVCs+sDyT2aMTXXKboGlBhqo9J+VFW0n1afF1IbCHRvnvICVW7dZFcNMtb9VTYkZN1w3kxfQCU
	MzJkOK5cbydeDACqMvvImuKKSD5pfux3TuUOuzF2+DIpKDb5fqk0lK5DmnWrxBDypu5u9fnopMp
	YxepJx+sU3lIF8yPD4DmjpvgdJhZbDlh0Vr9mAjkMZxwIAJhbQ6r22hLviUZ4R3rcdw+NrFjSpj
	iVdEsz4XWahyHC4Sf5n/QfA==
X-Received: by 2002:a05:622a:f:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b5f84608a1mr53838011cf.11.1757344695756;
        Mon, 08 Sep 2025 08:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv3mcsIkkBXMP29rwffS5CTfl5UUIWU9i9fBerRPfpgMIylwxkbElL5PVh9knG1HqQmUlAXg==
X-Received: by 2002:a05:622a:f:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b5f84608a1mr53837521cf.11.1757344695047;
        Mon, 08 Sep 2025 08:18:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b043fd772bcsm1761417666b.14.2025.09.08.08.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:18:14 -0700 (PDT)
Message-ID: <77cfd9d7-c3f1-4e0b-8cf4-8567611c3a9d@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:18:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] drm/msm/a6xx: Poll additional DRV status
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
 <20250908-ifpc-support-v2-3-631b1080bf91@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-3-631b1080bf91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WGiYNLBvIh471ABlC0l6tR1_thalU5ZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfXxtqzfPrC4dWx
 fNpmnb8SLexp0w90RnHJJaBuxg9kgmCkXNDVOwISDUP5OBqqX3GExKK5jAJEPpl+XqoiGeSL0Yo
 AHQM1rDU7rYOWMTqznitA/xZ3uSTOt7sjC5MZN57gD438nVt6RTfjQ3gNFAIRvGoFHVBqH2lYQE
 xKIkPTr0chShZ/kz89MNLS93zEC9Ngvd225HGpbn/ZyKN3kZKg+K1FfuKZZPN+sFj24zO3xby7h
 M3hE8//3l0aek6gUB8+Q7EfSNLktlJy/+gIsUMo1n8vVKAe/2Ok3ZoBmAE4T+duvplP/kP9sSOh
 kowWSLoDLG6C/AhmkdMGTfyu34UZ6QXcCxGcW3zfMVrj8CCVxAUtyjYHWZYdCZJEVq1f/OjWIHj
 52VhKGB9
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bef3b9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DmgBUSfskXSfToJwqCEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: WGiYNLBvIh471ABlC0l6tR1_thalU5ZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

On 9/8/25 10:26 AM, Akhil P Oommen wrote:
> A7XX_GEN2 generation has additional TCS slots. Poll the respective
> DRV status registers before pm suspend.
> 
> Fixes: 1f8c29e80066 ("drm/msm/a6xx: Add A740 support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index bb30b11175737e04d4bfd6bfa5470d6365c520fa..06870f6596a7cb045deecaff3c95fba32ee84d52 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  		val, (val & 1), 100, 10000);
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
> +
> +	if (!adreno_is_a740_family(adreno_gpu))
> +		return;
> +
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 1000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 1000);

https://lore.kernel.org/linux-arm-msm/002eb889-87cb-4b8c-98fb-6826c6977868@oss.qualcomm.com/

Konrad

