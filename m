Return-Path: <linux-kernel+bounces-744506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5707B10DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B7B7B8A05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9182DE710;
	Thu, 24 Jul 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKqqmxhd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E1292906
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367758; cv=none; b=T4Ghu8D7xJOPmkAT/UdCtPBrHf6TH7XtrpFpLN0PpuEhGlK0f7AHQ6fKjoq+NsdVI2/BFjC/Lw3tiMLGbuLbRzDlSa5Ei82VmdGmfjAOMPV9vnS0Csjou9FscW1ws9pHe7ZpW92JqTxABpulDR4JxLuB4zzhgZM6NMgKTI89tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367758; c=relaxed/simple;
	bh=dfJiQYzRwSlcnWAUOhPPgJKtd/pmTmlGFzYmp6BeV/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pt2hRnmIehDkXMmPTLL4rCGqSkUrwiWDO2XcTH7mbG35pRrhsdACvoC1hy76Vsxnpv+6Sx4pjjKhf/GCpn6+gYOr09OkjzK3ks/ZdWDBZrPx2FgYLCoOtPL7WCjYymfKUT+adel2P0tJLv6LgnfzMvdP43rxY/NQzKQuarH4jV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nKqqmxhd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9ZtV6018150
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJP5OrXYtaNIwr5c3QE7nQS8J5flRoXRt0htwVVshBo=; b=nKqqmxhdhfF6hIJl
	JlHtcuALY42H9cVgkN6/8wF1vLCv07fNq1T9kyur2pJBO1u+51WxEHVhzwD5Sy6s
	aeN7gXGM1t+h+ZEy4BoiLJMyWWdP3XEfUiUZrZXTBImWC7M62ZigRDh7bVq/fCkT
	CZlk/h8ggAd3NXqsY8kxC7Ceg/Ab7ZNtqzKXOTnNt4dn3NVSEFbSP/DO41BZnvEy
	2TET/tNm7pCgwYn1hqYYyNO8RXYoVpOMPJylEsQhrkUe2Wb5Z+zxL3urkZ8VSQfL
	HOhq3Gtegu4wXHwZ+hFdmEUaOQWh6LjCJfrJIlXL0Tf1ThQ9Qm6oG6z+BePA4bXh
	7Yphqg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6u6ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:35:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso1208096b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367753; x=1753972553;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJP5OrXYtaNIwr5c3QE7nQS8J5flRoXRt0htwVVshBo=;
        b=SRsqjGlVNyMSRDbSJoN6Ngf9dN9L+ooEkzYNtQsnuvawBDbvyMF5PZ7JINidQF/K7g
         EWVeCdcVtX+D3V0LHdQaXfqTyKq1h+ZBDV9ubK5GCP8CgFpgLaUAh72IzG+WwXYmau1w
         TU0Xp+2ZcyW21qPPm7frKw56OifMgE5Tt89liZiLFPLM0TgEoM4db1lDvSgFcF/HLKvd
         kSlVv+uL+ZoxM9gTXJPnVbWT/RfAc+GMPCjygsQE3SzCDzEJuBqhA7+umMjG7Idhnxbb
         udYGhR60yRc2K84AUARLYOy7BZMRTZb8IaqECataVl9Djmwpc42x+EsEaOJHMBtMcNo1
         I1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXqJsNWv+IOAjS22lmo32K+LnmTch+ptsyzEw6UcaUdguo+tQVJh9p4xIZhnxk2MSYNWRjQAT29zspUFJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhilWGkrEWHAMKYulOKgHSsMDl2KhKthkNC6sm9sFaInavMhmd
	nTJrxcovadg4KnwqHMeXW8X3wNv0WqVXoKlUhenXSg51mO0qB/SzQUmfHZggGpUWuVLDl07vUJU
	/zaRLE5BJsqDsbWBjShyKTQ8gdrnX6mqRshN2yOWg/GjIP0sqko72xS1R/UBCH+5x2nQ=
X-Gm-Gg: ASbGncvAvn79VK2Va7vkp1OvFlC9AFtGqK6XbUz2xKcLKMGfw2CtERy8Yv7vzzrF826
	LhGVbDSUN4SFpYxmaijMW+7hOhm/wgJ9nHjS2eLCsuKpUtyI2DiC+k+3R8JiJGVLRl92FdyYZoC
	GV9Tmffdm2MaLy3U/TYRxfLlm9UDTVI6lrZHlSuPeV/j5lJkRr+f5Ds4RtlHyxeFxawakRWuO+k
	R/NAG4EzjryhsL9Zpaxh+qgUWLX5Fc8fAn+PnWWdJx8/AutA1qq6HW4WYS+RLK7+vK9I7lPiGDv
	QEMXhdgI9ZFrmJJ/jIg1mHlLAJ69scRjiEvC7IYzOik7mC05fAgYT5dOEk/qiA==
X-Received: by 2002:a05:6a00:8b8c:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-761f0aae747mr2193515b3a.9.1753367753117;
        Thu, 24 Jul 2025 07:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErsxD0US8xYnn5Y59yyRl45GxrphsiOAnuwC/zARlLpy5inA5mS3Yzry3LPCBjaE+Q2UR4zA==
X-Received: by 2002:a05:6a00:8b8c:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-761f0aae747mr2193469b3a.9.1753367752353;
        Thu, 24 Jul 2025 07:35:52 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ab41dfe0sm1775131b3a.0.2025.07.24.07.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:35:52 -0700 (PDT)
Message-ID: <ac476949-d0e7-4058-ad76-c3cc45691092@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 20:05:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=688244ca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=1B6o04Z4kyHWbw-D5gsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mVSMip9M0QnuIfv8XSfpjUm-kDBwTIF_
X-Proofpoint-GUID: mVSMip9M0QnuIfv8XSfpjUm-kDBwTIF_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfXzdWIuRvZx2cV
 7FFyxqE0flhhbvVjv/QqexCGC+qrDh6VFxmeP+gPb3rmLZN3o2ztzYMMUfjpuk0JbBxIWytW0uN
 1FNnUV9tkalKarpIsh1oN8obLvQivtmUQM8282Ed/93JVwYRWZ9e3Mb62iIHJWio9QNKp2pw7cT
 UyrQfUC/nDHqfr7N+BwSrAgDGVeq+ySkWcaVKu+09uH5JfKMKaDpkxqJx/7VYULM+KNnaz20rPh
 Repo/Ux/qabLKI+OjP7jD/nxpm2cNTI1+Fa6X7eSsa8UVnTiIkKARXhEjnn3aMkZ74jeOV72QD+
 WzdlIsDz3V/jmb9sINt4DeGxTU2dDokJIMd5ANie+yOThdhDhMT2t47Rv3P03TJTZ91Gfhg63QE
 IPz53cKDs07DeCEtUzCr9ThOBDHGFDiDwFvq6wXy2BcGOvMPrZybwZUgy06h2xAS0gbVUgVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240111

On 7/21/2025 6:05 PM, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
> the Frequency and Power Domain level, but by default we leave the
> OPP core scale the interconnect ddr path.
> 
> Declare the Bus Control Modules (BCMs) and the corresponding parameters
> in the GPU info struct to allow the GMU to vote for the bandwidth.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..b313505e665ba50e46f2c2b7c34925b929a94c31 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.gmu_chipid = 0x7050001,
>  			.gmu_cgc_mode = 0x00020202,
> +			.bcms = (const struct a6xx_bcm[]) {
> +				{ .name = "SH0", .buswidth = 16 },
> +				{ .name = "MC0", .buswidth = 4 },
> +				{
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(2),
> +					.perfmode_bw = 10687500,

This configurations should be similar to X1-45.

-Akhil

> +				},
> +				{ /* sentinel */ },
> +			},
>  		},
>  		.preempt_record_size = 4192 * SZ_1K,
>  		.speedbins = ADRENO_SPEEDBINS(
> 
> ---
> base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
> change-id: 20250721-topic-x1e80100-gpu-bwvote-9fc4690fe5e3
> 
> Best regards,


