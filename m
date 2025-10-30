Return-Path: <linux-kernel+bounces-879175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30171C2272D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5CB189DABB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C61314D24;
	Thu, 30 Oct 2025 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nB5i1vu0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0sIZxz9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172034D38B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860562; cv=none; b=bKZxbbtU+mL24T1XCtRJ4PNMPf+miJzsPO0NTt9rxXzBrGkNRu6c7h32VppcfpM4aqpWgfGJ5od89VrG6+HpACTp1hK67BWu2L87X0bkyzB2Dc3nwy/8gq/zqCf1Pwe8rUgiwzLJ3wT0gd7At5zOx2nRruDSCg64eR1GXFvGSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860562; c=relaxed/simple;
	bh=1VkUuFXgKh18q/VVXbawt/jZlRqLYdXeO4NSmx4UsGg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n8fvRFf6dFNjKfSiP08iTmA1gU7sUpiukTzRYYMmXIxAPKiQcWiQ7etzQiLolbK9q7ucs5/Qawr+KJY93ftdFO2RBo1LUYwux4WEGW3o92nbaSN5aHDgsXWgmg4cuYR/2ZyvMI5NT+4674s6HUKOOJEltVF5OCC09On4h6yxq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nB5i1vu0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P0sIZxz9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UKVGaf3281609
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tzlUFB86mAlTUURMeKWMWkUk71VirJXlKOjLKibgrMs=; b=nB5i1vu0NdPS2wPx
	eoVqkrmQogyhWYaOs20hxamRBiclaCE1rJP/ANv1/v66gfysCp87g8B0X6yAfDVG
	tBBv5x0wietJnBXQMZaMn+xUcUikSp7wzsR09UlMBuxFz7ND/5jjoxg8Ji1d/jeT
	f1Ibr1HMacj/mYR0bk+n+P1NWw0B9BteWOemHdm4KlMW5Q5M44k8dNVDXt1V22GI
	r3y0rOO2pK2Xb0sJsM+NII+umkQUahqhzai6A3uf06FGHWZAmDtd0rjjERqwrHIF
	bIpb3G5Bsy+ppJpefCSyQAhCKnYZ9nRwuiX2UaEG2P7WGW9N1d3H1MsaDyTm2JP2
	VIc9JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a468khu8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:42:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89eb8ee2a79so738962985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761860558; x=1762465358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tzlUFB86mAlTUURMeKWMWkUk71VirJXlKOjLKibgrMs=;
        b=P0sIZxz954EG8qc0KWM1V7GvM1LS/Q6TS3urJ1pwbS8MSu9IpJyd4EZPNQyxWjiIxS
         InYMgbGqX2SqNpUMI3c/CwXs8jUBf9GJRnFvFd9cYwaJXJDYaHWGZo21s3EfeT9lsmY1
         WDDjxz/qYJmYqRnqYPZFO85Et2t9K0WPkpwp99DAHtgy2EYw/WacPAbOhBRaiH0Q8mCu
         PJbfBpbjRGkhuvFu5VG1J/k6ihSHUvsnxrP4OixUcgnhGWp9mcoTXZOf3cAAfvhSYGbP
         weBkK+3z1ln7TEXqyGgBDNQe1SQ0Ff/FrBbYg/u75pH3qnfYoGhJbo7jGCHv+d0+QVzq
         NJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860558; x=1762465358;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzlUFB86mAlTUURMeKWMWkUk71VirJXlKOjLKibgrMs=;
        b=wGpOfyiecWBT5zgk1I2BrJ4yugWlrQe2SkFexkwWfGviLw6Ji6Ys4OuO85eIhe/ZED
         lUyyZ/DuPCWq7kTDneb7bcmWXqGCYwerDxCWnL0uS4KVHt3PbljOon3uKcMfTw5p6GiF
         Jq0uNDh6gm25tUy+mSo4bjOHsbqg/ndyaBXyx59piNsZsqqykUHMG6sI2dIRLU8SGyRz
         prgfq1Utmupqil68ZE1BCNH8mxWnTNGcUM3t3kREljpR/yk/H+XAAE4Zz4MzNBai/TVc
         Y/7igqiE3R1RFVdOLIZlDIyXZ2e0FH7G2sbVX9paajuKwlCy35wdrtG3e36GoqHacjpu
         BvZw==
X-Forwarded-Encrypted: i=1; AJvYcCXWGaKgw6194FZLIQDO2t8C0i4gxBn2rXzKMSccse4M4oSf3ln/hIQZMmA6PbypILiDdwDKgYB3I4WFDI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzOpJD8yme1Pmk7ejBM04xXFC2ixhQqCPj58XfdnoVl7U4g/D
	dN4plhKVbNGqiE1kJyHCA22uBbcNDfWLOUSdCw1SNc/Z66BYsvvFYnK5YtnBx7gH5jpPF+7sKZC
	iPq7ibIvBoCtnwmvXWEj4jMaZO+0owRXQx10LoF5WT/cYFpD5FSxksJLG8Ko+2ecgrVBk+Q7ccy
	s=
X-Gm-Gg: ASbGncst8XRAMzCSszUu9C9DhH9alxHJSFpKWJP94xTUwKP6uJzD/IWyzumCnW01ouO
	ETNgjoX3Vh52t4bdGTIME0ewhpubFylTTSUZkJbP+AbM+gVuDXdUDppUM+GqGXlvqbTWrwvnNeo
	zu1RQbK88vEhKrPaSXvw19Y1WF35HXUMxeMkaaailQLgBsq7YYLQMEU3fInCcw120MZm0DWuOLc
	aQrsjtR167WnwZUcDtrMpxpUw5P0GIhYgynwryOYRVYtrffMXscobGllHB9PSBbuQHAPOXZdGLq
	OGwEnALsNA/teig5rTTFc80LrWZeuAGsgWRH2nLEJp1iuUnUdYj5wO9utpX15aOWjsfmOOk8Y/Y
	wEKs6GrHbooR1YDYETIY0fQw=
X-Received: by 2002:a05:6a00:8d1:b0:7a2:7bdd:cbf4 with SMTP id d2e1a72fcca58-7a77a9ca32dmr956528b3a.27.1761859787090;
        Thu, 30 Oct 2025 14:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7gJS7A8SHkbq5oKF6sDj7A6I6fhFxuB0Lxorh9exZXB3/O9HNGHkmZRZA8yyMj7usEqcVoQ==
X-Received: by 2002:a05:6a00:8d1:b0:7a2:7bdd:cbf4 with SMTP id d2e1a72fcca58-7a77a9ca32dmr956495b3a.27.1761859786477;
        Thu, 30 Oct 2025 14:29:46 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.233.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012d13sm19972568b3a.9.2025.10.30.14.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:29:46 -0700 (PDT)
Message-ID: <c8058713-b126-461b-8ae6-19c4574a8105@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 02:59:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: Re: [PATCH RFC RFT] drm/msm: adreno: attach the GMU device to a
 driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4MyBTYWx0ZWRfX/m+oy7iaKiUu
 bSBWmW/psAvr6/QTdsWTXAUiBtLvBJaxFn6ui9kTRRXU6Vz0g2ph1CgzrOpxF4N7qXHjhnplVsA
 f/92b97EwWsR9mvYwwJ7OG3d9bXDhlGJ433RJggIthuIf8TQZy7q/7rAClrwbkTjsyEnW5x1F2R
 yjEAgqDljqaWItCj58hLfiUFQ9ygh2gHSRILj0R3bcNqRfSKALsDJlao4tpXAXaYY6wMIMsYeW0
 7qOw9Qru4gcny0vm8Bu0WydIVjjK323C9/TyxsXm9nQXU0gPNU2txZjnyLPsanj6fDh4Xtbn3U8
 4mZ/lZZRYDq9jGofdQOd4xNfcpjNyqklbjzC3XeixIoSFI34eQd8DZThe+XyCyCw/x5L5Zyqs/9
 jufQWRG1vaqqcsbCh6X/VwonRgxFbg==
X-Proofpoint-ORIG-GUID: -NRwmgWpdrDTOnw9-34De8-DUS7LjSRK
X-Authority-Analysis: v=2.4 cv=LoWfC3dc c=1 sm=1 tr=0 ts=6903dbce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=rTtKBu4o5onlnI9juXDqsQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=ZJ4cUMe89lpGfuoIxrAA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -NRwmgWpdrDTOnw9-34De8-DUS7LjSRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300183

On 10/22/2025 6:14 PM, Neil Armstrong wrote:
> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
> the GCC and GPUCC sync_state would stay pending, leaving the resources in
> full performance:
> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
> 
> In order to fix this state and allow the GMU to be properly
> probed, let's add a proper driver for the GMU and add it to
> the MSM driver components.
> 
> Only the proper GMU has been tested since I don't have
> access to hardware with a GMU wrapper.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 354 ++++++++++++++---------------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |   6 -
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   3 -
>  drivers/gpu/drm/msm/adreno/adreno_device.c |   4 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   4 +
>  drivers/gpu/drm/msm/msm_drv.c              |  16 +-
>  6 files changed, 192 insertions(+), 195 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index fc62fef2fed8..6e7c3e627509 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1859,11 +1859,14 @@ void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
>  	pm_runtime_put(&gpu->pdev->dev);
>  }
>  
> -void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
> +static void a6xx_gmu_unbind(struct device *dev, struct device *master, void *data)
>  {

I feel we should keep gmu and gmu_wrapper implementations separate. It
is already overloaded. How about adding a separate gmu_wrapper_bind_ops
and keep it in the match data?

> -	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct msm_drm_private *priv = dev_get_drvdata(master);
> +	struct msm_gpu *gpu = priv->gpu;

<< snip >>

>  static inline uint32_t get_wptr(struct msm_ringbuffer *ring)
>  {
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 7e977fec4100..0618da7e8b40 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -998,18 +998,30 @@ static const struct of_device_id msm_gpu_match[] = {
>  	{ },
>  };
>  
> +static const struct of_device_id msm_gmu_match[] = {
> +	{ .compatible = "qcom,adreno-gmu" },
> +	{ .compatible = "qcom,adreno-gmu-wrapper" },
> +	{ },
> +};
> +
>  static int add_gpu_components(struct device *dev,
>  			      struct component_match **matchptr)
>  {
> -	struct device_node *np;
> +	struct device_node *np, *gmu;
>  
>  	np = of_find_matching_node(NULL, msm_gpu_match);
>  	if (!np)
>  		return 0;
>  
> -	if (of_device_is_available(np) && adreno_has_gpu(np))
> +	if (of_device_is_available(np) && adreno_has_gpu(np)) {
>  		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
>  
> +		gmu = of_find_matching_node(NULL, msm_gmu_match);

Instead of this, we can probably use the gmu phandle from "qcom,gmu"
property? That is quicker and also doesn't assume that there is only a
single GPU.

> +		if (of_device_is_available(gmu))
> +			drm_of_component_match_add(dev, matchptr, component_compare_of, gmu);
> +		of_node_put(gmu);
I think you missed the recently added headless support. Please check
separate_gpu_kms modparam and msm_gpu_probe().

-Akhil

> +	}
> +
>  	of_node_put(np);
>  
>  	return 0;
> 
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251022-topic-adreno-attach-gmu-to-driver-e47025fd7ebb
> 
> Best regards,

