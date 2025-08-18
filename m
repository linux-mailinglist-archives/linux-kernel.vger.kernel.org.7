Return-Path: <linux-kernel+bounces-773027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00BB29A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BDC19622F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034E4279904;
	Mon, 18 Aug 2025 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glmIizsz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687D279351
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501227; cv=none; b=RKiNuuOmOC8abKkeDZ5S/mWGGJ/jqIa0MH4PfCmAWK+tJyJiSORM3dNqKCC7kMmITM9PNNFazmRqmCycbBh5jKjWUAwIR4aJmBZ2JjXamMrThLxd1iZyRZyfPy7LQRJeoRA2SOGArOqT14QRlURO0G/zQ1aOLCSLUKLdr/mu0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501227; c=relaxed/simple;
	bh=7h+Nc4eirPiFhfph7HvTBvBW2d9R1HcOAcmS9qcq/SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd6h39AHBBq5T5iD/Pc/QjHAIQJybxvLZSy4hRhbNi2f+1mRNEtwLTQq0DX3BDCQ4/de1b1vWY/2KvG3zLRYyaPX8PDJTvCqBSuvsn/Puu2VQuG3eC2j4KrlOirhnnOaY2DxspSAumwENZRGJRI6r+fTrl1fdlt82fuJwBhB3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glmIizsz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HJeF5K022565
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eO7wadraGhre+LJhTfVeJor488W/8ImtdDnMyxSeuN8=; b=glmIizszRqn3/+U+
	AQB6xcC8EP+OqOJ7w+DsAbFyuSIbb5/21T7AShl/+fevJU6Z2rOWZxz2SpccdLe5
	oqcdd4L5ua0fZZqDr7GPdOPWpph+zDF49+S/Q5OkOoGkMV/iMgfVkenf0vRapAKc
	yVuMIthwebhXF9OBg40/SrJiLng9n5MuhPrePLkKBcqkJ4hWYf444lReEOkEfWkR
	pSf1OBbqx6o6CNGgY5/g2+9MXxhGMDOzILaBIBF3Ad4mEOcdoxgo6xtxcQ3NIEFp
	wM01PcoiibPISy38rnrAxcaJUotGB/eqHBfo8679ErvBGg2efl6+HkpoeJ2OpUYR
	1OUPKQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99kkup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:13:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f59889so39008945ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755501224; x=1756106024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO7wadraGhre+LJhTfVeJor488W/8ImtdDnMyxSeuN8=;
        b=PzIvUR4IE78r6KBf0FTlipMydxK7H8UA2g1LU/KkT3FvyO5RSn33bnCa3py+/7C3Sx
         +Crxkm2cP3Y+UHUouV3pULpujvRAv0jgQX0HZY3DUDxZvRxDmkfsSNEoKJVaLc2+LXhM
         pRbpFdOQZfTFAmdPxDfaljRikQDpK3kTxqbZwqLDL6Y9Tfw8SoqB3P+kva2DHUKvG1YE
         eqYeW2qXWPlMAhBrgmma6H1GFSX5z3IJm/5vZnvk1FERPhOswvjcajmPApD6sd3OE5cF
         5EEHMSxX1BjlVOdCGhQc5TPu2Lk1xwdlMqfH/76xhNmfn4bQ8qzRMKISutYUDkKHI6Ah
         v6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVSaFRG6Kt65oKM2JamNqsct25gwPEFAhVufkQM0GvWz/wx++F8aIA2bQNjzrX1NxjqQNv6cq0Fc2VsGgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnMnY8KFuipBXAozBnAg/nphrCe0zQlU7WxGh2wAkha18pcQQ
	2p2vd2guG8SDanEH6eNV8zlYXn3T41y+0ToN3+m9+gvBUbA5tN4vjiBr7HGISUohkorLVfUzcqI
	GAlWKeTIxy3BbzpBLvRA2fAEmmOgLT9eLdPoqhTml5yXgHcdwAg/6od2lj2L5kkaf6PY=
X-Gm-Gg: ASbGncseD7bNV1J+rCgwBiJpsiM4Rid8GFWrC5Vqg47/HLdlUKyO/YMu16+m44mVccb
	uADzWzhQfFbVMNQ491OTaWhOpofoJAxGlorGH04u21t9TA5B9UlA0SJ+xcyC24YTk5dV1xHrlzy
	pPXgk7gckuBb17S5hnss0c1o417MH7YEsaGEVLZ8cnTAWQUgt/OSCg3Z0ttDy0knCFreRmZSXSm
	IB1uUVhIBv02lbhqmuPiSJu0apGZUnWq+xPywL7/9uH5bwnCrNIc4XKz8VgYFbeZ3V8RLMyTJYS
	EBV2iNPuaFtJlwuA25WC6kg7YRqZFbrqPmjBi31RQKaRrAVpAgVXX2fgQvWTfdGq
X-Received: by 2002:a17:903:2d0:b0:226:38ff:1d6a with SMTP id d9443c01a7336-2446d6e4c8fmr162951785ad.7.1755501224255;
        Mon, 18 Aug 2025 00:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKK/VsGw2K363BINLgo4z0OW/kcKqNy2Al0tPXrsMMCPgwF+XIrPg9LBdfU+0MmAtu3XKsaA==
X-Received: by 2002:a17:903:2d0:b0:226:38ff:1d6a with SMTP id d9443c01a7336-2446d6e4c8fmr162951415ad.7.1755501223816;
        Mon, 18 Aug 2025 00:13:43 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.229.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d043sm71010145ad.12.2025.08.18.00.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:13:43 -0700 (PDT)
Message-ID: <026b1a09-c8db-4a5d-af43-3be4fe24a824@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:43:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
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
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O_nrS1S7kB25V_mTlfBxH7lflJCg8t12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX9uafRPJi6BYO
 cgj9rg6OXr4QwdahcY3PGpMytW6upGG0N9oXgHzglndIzaZk4A5TMOlljP/CqGHguwO+ADrV+Q1
 fOFlESYRCIuFLSfBgcOO8Vf1w+5iU+UIkFFYqYRCXBd8+CLVsDc+8luXPn2nifBp5U3AFYNZyVy
 r0Ok7/R/y7F2AhkM/gqwi77R5ypJg3WAhdJyrla4UGnDzQMPfFEOL84iRGYwSUZyLfy5eox4Cpp
 zssdqithLDbj4iMIVKe7JJT5JxJuUbPmYqwCpqnA5ek6TCnXHVaLk4c1UG49vDiONQ7srh6Qrvv
 eUmXS9UgppspKa8Cb/uMA5TIH3iEZKrx/KhstMeyI2esYf6+2qtSqE5g+X4vl3e/Q5gE8JJ0LJj
 FMNSwWFM
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a2d2a9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9Q8gPALlkHEzzDxkdHlyxw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=1B6o04Z4kyHWbw-D5gsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: O_nrS1S7kB25V_mTlfBxH7lflJCg8t12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

On 7/25/2025 2:05 PM, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
> the Frequency and Power Domain level, but by default we leave the
> OPP core scale the interconnect ddr path.
> 
> Declare the Bus Control Modules (BCMs) and the corresponding parameters
> in the GPU info struct to allow the GMU to vote for the bandwidth.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
> Changes in v2:
> - Used proper ACV perfmode bit/freq
> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
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
> +					.perfmode = BIT(3),
> +					.perfmode_bw = 16500000,
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


