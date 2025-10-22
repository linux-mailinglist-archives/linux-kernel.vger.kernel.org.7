Return-Path: <linux-kernel+bounces-865324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C9BFCCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F44EAF92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742234845D;
	Wed, 22 Oct 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VesLKiOR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E6347FEF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146012; cv=none; b=n+sZ8WedYDlH5gdf3VR+mU3tXfQiKy3YQxvaXsKeSi4CcvoNPiFQAKlZTaGx7sVd9tkz8RB7zjDQq+seo37GebjgKME8ALFkN1pyYjZiCbQqWCrMgmH4ljZc5gnl2kKjk+ELO0uxElx8GJ+lH9pvWaTOjPZmOFLdnHGcO7/8k5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146012; c=relaxed/simple;
	bh=2ovnrrkNxN1AfFLOidZK7o+t/WuyEwDsv4AO1qXtgkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsgNf5lCGoiwLsCrW4/ZSVan3uXllrNEY1bZX9H7fljOqSf6TVfi81no2ponKDUx2brYmYjilckYvs0lYdqPsLCngHm1dRFSKgJxtO2h1nX4c7y2iW/IXd+HOMDst+EKyVKKKkI8yoPPkV89/QQwwq45rb+zHxoCYKzCNySJO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VesLKiOR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9pNE6018743
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AtOPiC6l9BljB6aQ9rnOst9XuL/E0zhfUfs2IkZsLyo=; b=VesLKiORCVMrQ7GS
	14L63ABO0Np/2mo+V3ZHRiAAcI5h6Qo2xbbMhqTOTHZzUol66uQ+RzffZYpA7/ra
	zAUo4MmZUiRwNnuF+JdbcWeXK/i+KJhUYfg6+mJjSF1o4vebYWuFAgFCg+zYlwpL
	wk1L6Dd4gyCkGlPizScFg0RYu/erxPBtU/LtV/3IrsC42Djkr0BR2FWOPIEsTGtP
	hC55ihaIUhzZmCmm0MczwdGSLUkv4BWeo+WdoXLwIp9t4siyvXmD0OfHYiSfYtsj
	0UxAzp1nJPotu4qrBl/CCwrF1PVaDwAIVE0b1ka+e3353q131VRCRS9TeT7ZFdmF
	HvQ3/g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469n3ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:13:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e886630291so3862801cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146009; x=1761750809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtOPiC6l9BljB6aQ9rnOst9XuL/E0zhfUfs2IkZsLyo=;
        b=dBp0QoYNmhWQuywA45Q/NiNk1IWkl/jEAvaNm1SSG8ezhpHo3muec1Jeq440KqlqEi
         vSDXgsggw8LOHlxYlmftlcomjP72zNdvHjdYaC1EDmHlTLBhVuFJI3A0Jb5ot4D2UFdS
         TMiHTgXHZMIn9pGcg7IjciN0yIs+IkDZv0kQkTFQeAyUXfm8FRcAb7L89spDtZThDtk6
         gUkAVQjzw7rJo72hoL+mr/dPpZQpE7Jkt9UKlFfykY5dl+jC3LkOF9/ntVD8aDRyTxcx
         odtw2Crhb9KFXfInyD//dFr6pQVBlkTSw69RMZfnabk0iyU3VwGs5Byo+2BXO7apNa09
         Xphg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Cp12Jw3FfI4BFTN4SniWy8WZS5ULS2qg26YhsLNvG6tPk3mluvlu0+N05Hv+L/BOiFlXQmkZR3AFmr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz48Em24dVzLdZtOst7JhA9pTPpSSUZwSqbjuVdNOzJufoGU+v
	3Pi87PBZFNurlD0mFelp60JhziHsGbkyEuw40MAgcprRdmp3gh6lZjRPGDpgiBxYS1Ka4j9iTC2
	L2VgQhLeMv5oJNp98HedF5gAPkkCPk1v/VnmnFD7b38sG6L+hcSmvYKLYpxA1vZsm+Gk=
X-Gm-Gg: ASbGncsCL19vVvx5QlC9fIRVXezFvBkQZowXv8nqoUtS8+RfvqQxXNzGQZEO3xEUftb
	WQYAFz2BBHLk5vBqJEWJFXTS8nR72SSqE/pQtn3aPCjscDut4n0ymqcg2Ciu5ArqkYpdBaBUsQT
	wfpkkWpsVgv98a11IPvI0YO3faoASGlfAKSa30/VTzwmZmOJR1i2e1NZY/PB4WFOIfAVNDblmdH
	/9FVBhTt/H7H814265nY2fr5FSV52wAFYG5hThNesfNDROpBz/2F+x4FyuzOND0gzn56KGDw49x
	a87CcrYcokIsaN2mtOclo/oapNuSN7LiQKDpVOkVtScBfWiLgfE0Av1g49TF9YV04tUPyZm6PAg
	0Ht6oQCfJ4+jKta0Hd05gSDeCf4ZrVz6lECrCkwS5bSMGvzM2mhmrJsEx
X-Received: by 2002:a05:622a:199a:b0:4e8:a9f6:359 with SMTP id d75a77b69052e-4ea1178251cmr61449961cf.10.1761146008757;
        Wed, 22 Oct 2025 08:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEierfzFT+Ehux93IgCTLHvl2L0VFHL4qLUlUPHsnWhN8MQCEyk8V77qdJ6+vl24wozTMkFJw==
X-Received: by 2002:a05:622a:199a:b0:4e8:a9f6:359 with SMTP id d75a77b69052e-4ea1178251cmr61449171cf.10.1761146008174;
        Wed, 22 Oct 2025 08:13:28 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm1378295966b.54.2025.10.22.08.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:13:27 -0700 (PDT)
Message-ID: <44ff81bf-8970-475c-a4f5-c03220bc8c3f@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-1-0baa44f80905@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017-qcs615-spin-2-v1-1-0baa44f80905@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5b-_Bp2nAxao6AaIqEcS3iEe67kWny_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX3igoiRAfgGdd
 V2LJJ2cEM/iS0YmeEU1f79KGub3Pnl2WsADkQGWtKXu0RCTw0pwfW6eC0G9z4EVTsaOd5Mc6eEu
 Ywn4pR2Ubdg+ccCCtwkMf3mInUugdZxBo9+luJlm41BXYZ7jAAZMuBfVYQHrP6BqAgSzjB4K7nW
 AZNm4T58Q+oXAiuedSEogYOmT5Dq4JG2WdIm6TOcYn1aYEb436nwXS6ZsAK+DeeLAR0Kbhz2jZ2
 qRf34lIYGXfH4z+z0ZgiwyppFzatwN9mok0HU3+N2UMXcySottNkgi7LhpTQDWWRtivvyjZj8Xn
 5GW/fOh2bfPNkQ/WuLjY+gLHCAdQnIaibJ/TYEe4qQ8+8nWYbMVQfgtuVbpFodW0//Wbg6R583K
 xhvyiDPfB7CAPmSc33qbEelqBPUP3A==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f8f49a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NFg73xRieO-LzbxsZPIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5b-_Bp2nAxao6AaIqEcS3iEe67kWny_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/17/25 7:08 PM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
> of A615 GPU.
> 
> A612 has a new IP called Reduced Graphics Management Unit or RGMU
> which is a small state machine which helps to toggle GX GDSC
> (connected to CX rail) to implement IFPC feature. It doesn't support
> any other features of a full fledged GMU like clock control, resource
> voting to rpmh etc. So we need linux clock driver support like other
> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
> This patch skips RGMU core initialization and act more like a
> gmu-wrapper case.
> 
> Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> @@ -350,12 +350,18 @@ static const struct a6xx_gmu_oob_bits a6xx_gmu_oob_bits[] = {
>  /* Trigger a OOB (out of band) request to the GMU */
>  int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
>  {
> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  	int ret;
>  	u32 val;
>  	int request, ack;
>  
>  	WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
>  
> +	/* Skip OOB calls since RGMU is not enabled */

"RGMU doesn't handle OOB calls"

[...]

> +int a6xx_rgmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(node);
> +	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> +	int ret;
> +
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	gmu->dev = &pdev->dev;
> +
> +	ret = of_dma_configure(gmu->dev, node, true);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(gmu->dev);
> +
> +	/* Mark legacy for manual SPTPRAC control */
> +	gmu->legacy = true;
> +
> +	/* RGMU requires clocks */
> +	ret = devm_clk_bulk_get_all(gmu->dev, &gmu->clocks);
> +	if (ret < 1)
> +		return ret;

Simply add this clock detail to a6xx_gmu_wrapper_init and use _optional

[...]

>  	/* Enable fault detection */
>  	if (adreno_is_a730(adreno_gpu) ||
> -	    adreno_is_a740_family(adreno_gpu))
> +	    adreno_is_a740_family(adreno_gpu) || adreno_is_a612(adreno_gpu))

Sorting this would be neat

[...]

> +static int a6xx_rgmu_pm_resume(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> +	unsigned long freq = gpu->fast_rate;
> +	struct dev_pm_opp *opp;
> +	int ret;
> +
> +	gpu->needs_hw_init = true;
> +
> +	trace_msm_gpu_resume(0);
> +
> +	opp = dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	dev_pm_opp_put(opp);
> +
> +	/* Set the core clock and bus bw, having VDD scaling in mind */
> +	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> +
> +	pm_runtime_resume_and_get(gmu->dev);
> +	pm_runtime_resume_and_get(gmu->gxpd);
> +
> +	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
> +	if (ret)
> +		goto err_rpm_put;
> +
> +	ret = clk_bulk_prepare_enable(gpu->nr_clocks, gpu->grp_clks);
> +	if (ret)
> +		goto err_bulk_clk;

Add this as-is to a6xx_pm_resume(), nr_clocks==0 is valid, similarly
for _suspend

Konrad

