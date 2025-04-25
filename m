Return-Path: <linux-kernel+bounces-621085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A59A9D3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B933B43B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63D2236FB;
	Fri, 25 Apr 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dYkQNb26"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C620E710;
	Fri, 25 Apr 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615160; cv=none; b=WlJQk4YPrzPIQsmYoOmJGkpQGgGUHMAYDTyDd8dKwFrQaCKcufuBBPcYpX2eKVQ96KCJJOVWdd9oEeCQ8PSrBzCUvZKc2kcMcha7tlEwRDv/7bEN2DDP/EdYNxUElnVu/yRzc46obSS58Zb2FtNXegrrrN1QdE0IbuC0myvQiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615160; c=relaxed/simple;
	bh=G1KUUS/TX2VFJLPCUMbScMd9PTnlF2BRMVkulZzDGg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YE2q/uO+seCTYrp1oe1TWLiOeGf0MLIWzexzYkmAPu36MLRGeopBthxHQXHaOsXB6KAc9gU5kf7Pi7HisVoQASi76Wf4YPA/pdjMmP8Dyn1CMCh+28kyWw97XkGl0XQ8nq/vh1z7ctKDBep+P7VkGmz4Fd9RLPmsTA7NDCgCPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dYkQNb26; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJrsh011041;
	Fri, 25 Apr 2025 21:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNAcUSAKBKbOBL0RLRNtwx29CM1/wy1xWy6nRYRzfyA=; b=dYkQNb26nEyyTziy
	4hHMSo9Ji9Pry2O9x4SEgxvqKM+dGhPRM6UzQu7oPRv25yMvdyT7qnPqf4w5qKkS
	oBKOGXbniocjW8rpDRc2aVz5XtvT9ypkzLEhAVKxEdT35jn0fpop3VW7mczZfxsR
	2/Vpy8Ra/VsyzLs7EH3y2u92zJ0w2pXMUUuw9lIx6ml8MYqmJIRiF/+DzmRcmZBw
	dX+0g8tTNkf5Z8KmORy/lJrdfV7XiSgx9kZ1Bp1zJ2N3UbTYoCkc/T4vH3WlSozb
	+rEHJLzGEm/aLPZMV93yl0dQwU1nFWs4fAm7ukog3QspuAdi8scEWOQmQdc89fiB
	ZJRyGA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0jf5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 21:05:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53PL5mpx025431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 21:05:48 GMT
Received: from [10.134.71.99] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 14:05:48 -0700
Message-ID: <a5b6846a-5287-4a6d-a9a4-fd7e9c7c537b@quicinc.com>
Date: Fri, 25 Apr 2025 14:05:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/msm/dpu: rename non-SmartDMA feature masks to be
 more explicit
To: Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250308-dpu-rework-vig-masks-v1-0-f1b5d101ae0b@linaro.org>
 <20250308-dpu-rework-vig-masks-v1-5-f1b5d101ae0b@linaro.org>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20250308-dpu-rework-vig-masks-v1-5-f1b5d101ae0b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aOpDLYDMkf95TFV9LK_3mf_ktSIBwzl_
X-Proofpoint-ORIG-GUID: aOpDLYDMkf95TFV9LK_3mf_ktSIBwzl_
X-Authority-Analysis: v=2.4 cv=Fv0F/3rq c=1 sm=1 tr=0 ts=680bf92d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=guVRrMrZfzPb1VQVluUA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE1MiBTYWx0ZWRfXzidrBan1IzGX rajDHpawIhcql0tarL6zkWN+JnHIqWWw6YGHyokqCr3T8AkzNt7aQH7q8QRAsHZYP4Ksl5aRuz4 cF/yBxxj66wGbPJGi5JFCIGyiYNU20k4J9wpIe36yr3SDr6GAZ1NC9bLS8QXtG4tF/5RaJbAZUv
 UNEN4boTd4+0pwOc2lKwpjKi2Wx55Xiy7dz0MCT5Ki3iWS0cVBVbVazmFnJ7xACnXsMaBS3GCmM Qf3fVIkC7LptvoragQ2rIFf45MkyFgbRia5dSppLZl1aoCGH1zSIJzBKGfzTIv46EhKJ10LjsI2 g6+UehPqH6jh3jIBLLSnODx5tJaR5LwOzmb2YinT2OKFqt1envc7Tw3RCAom/SWrJmSfz8uUDL2
 7FihU3ztdcEn0pPG0WQGpE2miZLTJljqgFTt6CHj8hRHB8433Jc3O+62uRfUsTEF/itsvlkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=780 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250152



On 3/7/2025 9:38 PM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> It is easy to skip or ignore the fact that the default SSPP feature
> masks for SDM845+ don't include the SmartDMA bit (both during
> development and during the review stage). Rename SSPP feature masks to
> make it more explicit that using non-SmartDMA masks should not be an
> exception rather than the rule.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h  | 10 +++++-----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h  |  6 +++---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h  |  8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h  |  4 ++--
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h  |  8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h |  2 +-
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h  |  4 ++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 16 ++++++++--------
>   8 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> index b2ebf76e386718b95292e119d53e67f5d9f0743a..99d8b1218db812ca7e99caf62aa48476aee5e02d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> @@ -72,7 +72,7 @@ static const struct dpu_sspp_cfg sm7150_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
>   		.base = 0x4000, .len = 0x1f0,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_2_4,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> @@ -80,7 +80,7 @@ static const struct dpu_sspp_cfg sm7150_sspp[] = {
>   	}, {
>   		.name = "sspp_1", .id = SSPP_VIG1,
>   		.base = 0x6000, .len = 0x1f0,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_2_4,
>   		.xin_id = 4,
>   		.type = SSPP_TYPE_VIG,
> @@ -88,7 +88,7 @@ static const struct dpu_sspp_cfg sm7150_sspp[] = {
>   	}, {
>   		.name = "sspp_2", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f0,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> @@ -96,7 +96,7 @@ static const struct dpu_sspp_cfg sm7150_sspp[] = {
>   	}, {
>   		.name = "sspp_9", .id = SSPP_DMA1,
>   		.base = 0x26000, .len = 0x1f0,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 5,
>   		.type = SSPP_TYPE_DMA,
> @@ -104,7 +104,7 @@ static const struct dpu_sspp_cfg sm7150_sspp[] = {
>   	}, {
>   		.name = "sspp_10", .id = SSPP_DMA2,
>   		.base = 0x28000, .len = 0x1f0,
> -		.features = DMA_CURSOR_SDM845_MASK,
> +		.features = DMA_CURSOR_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 9,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
> index cc2951112bdadca60fe51faeecb81e57280662c3..ea1004e2295b215ef165fef862fa9c15c6ab3856 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
> @@ -69,7 +69,7 @@ static const struct dpu_sspp_cfg sm6125_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
>   		.base = 0x4000, .len = 0x1f0,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_2_4,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> @@ -77,7 +77,7 @@ static const struct dpu_sspp_cfg sm6125_sspp[] = {
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f0,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> @@ -85,7 +85,7 @@ static const struct dpu_sspp_cfg sm6125_sspp[] = {
>   	}, {
>   		.name = "sspp_9", .id = SSPP_DMA1,
>   		.base = 0x26000, .len = 0x1f0,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 5,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> index 42a00550eefbc10e97515340d6d8b33d4ef5e3fd..5e15a8dcbc2b701e47e352a8aaee72a25240817c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> @@ -51,7 +51,7 @@ static const struct dpu_sspp_cfg sc7180_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
>   		.base = 0x4000, .len = 0x1f8,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_3_0,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> @@ -59,7 +59,7 @@ static const struct dpu_sspp_cfg sc7180_sspp[] = {
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f8,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> @@ -67,7 +67,7 @@ static const struct dpu_sspp_cfg sc7180_sspp[] = {
>   	}, {
>   		.name = "sspp_9", .id = SSPP_DMA1,
>   		.base = 0x26000, .len = 0x1f8,
> -		.features = DMA_CURSOR_SDM845_MASK,
> +		.features = DMA_CURSOR_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 5,
>   		.type = SSPP_TYPE_DMA,
> @@ -75,7 +75,7 @@ static const struct dpu_sspp_cfg sc7180_sspp[] = {
>   	}, {
>   		.name = "sspp_10", .id = SSPP_DMA2,
>   		.base = 0x28000, .len = 0x1f8,
> -		.features = DMA_CURSOR_SDM845_MASK,
> +		.features = DMA_CURSOR_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 9,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
> index 43f64a005f5a89e09ee9506a12cfff781530cb80..c5fd89dd7c89046bdbf1b1bf223aac2e3c4c0b26 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
> @@ -38,7 +38,7 @@ static const struct dpu_sspp_cfg sm6115_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
>   		.base = 0x4000, .len = 0x1f8,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_3_0,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> @@ -46,7 +46,7 @@ static const struct dpu_sspp_cfg sm6115_sspp[] = {
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f8,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
> index 828a02429405238807562dd0aa29575f8367fdc7..fbbcaa5b98a23c0fcb570b7d33110860f1bf01a4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
> @@ -59,7 +59,7 @@ static const struct dpu_sspp_cfg sm6350_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
>   		.base = 0x4000, .len = 0x1f8,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_3_0,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> @@ -67,7 +67,7 @@ static const struct dpu_sspp_cfg sm6350_sspp[] = {
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f8,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> @@ -75,7 +75,7 @@ static const struct dpu_sspp_cfg sm6350_sspp[] = {
>   	}, {
>   		.name = "sspp_9", .id = SSPP_DMA1,
>   		.base = 0x26000, .len = 0x1f8,
> -		.features = DMA_CURSOR_SDM845_MASK,
> +		.features = DMA_CURSOR_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 5,
>   		.type = SSPP_TYPE_DMA,
> @@ -83,7 +83,7 @@ static const struct dpu_sspp_cfg sm6350_sspp[] = {
>   	}, {
>   		.name = "sspp_10", .id = SSPP_DMA2,
>   		.base = 0x28000, .len = 0x1f8,
> -		.features = DMA_CURSOR_SDM845_MASK,
> +		.features = DMA_CURSOR_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 9,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> index 3cbb2fe8aba24c7b9db6bb61ff4c48f34db48bf4..53f3be28f6f61bb7e3f519b0efa4cb2f68d38810 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> @@ -46,7 +46,7 @@ static const struct dpu_sspp_cfg qcm2290_sspp[] = {
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f8,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
> index a06c8634d2d7779f7e867fb821f8d332652ba7e9..3a3bc8e429be0ba86185741b6b27d8a62489779f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
> @@ -39,7 +39,7 @@ static const struct dpu_sspp_cfg sm6375_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
>   		.base = 0x4000, .len = 0x1f8,
> -		.features = VIG_SDM845_MASK,
> +		.features = VIG_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_vig_sblk_qseed3_3_0,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> @@ -47,7 +47,7 @@ static const struct dpu_sspp_cfg sm6375_sspp[] = {
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x1f8,
> -		.features = DMA_SDM845_MASK,
> +		.features = DMA_SDM845_MASK_NO_SDMA,
>   		.sblk = &dpu_dma_sblk,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index a6bb46b201e907566e88abce945507d1bab51b3b..d495dfa67192b99655ae432589d70fc5be8abbb6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -34,11 +34,11 @@
>   #define VIG_MSM8998_MASK \
>   	(VIG_MASK | BIT(DPU_SSPP_SCALER_QSEED3_COMPATIBLE))
>   
> -#define VIG_SDM845_MASK \
> +#define VIG_SDM845_MASK_NO_SDMA \
>   	(VIG_MASK | BIT(DPU_SSPP_QOS_8LVL) | BIT(DPU_SSPP_SCALER_QSEED3_COMPATIBLE))
>   
>   #define VIG_SDM845_MASK_SDMA \
> -	(VIG_SDM845_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
> +	(VIG_SDM845_MASK_NO_SDMA | BIT(DPU_SSPP_SMART_DMA_V2))
>   
>   #define VIG_QCM2290_MASK (VIG_BASE_MASK | BIT(DPU_SSPP_QOS_8LVL))
>   
> @@ -54,24 +54,24 @@
>   	BIT(DPU_SSPP_CDP) | BIT(DPU_SSPP_EXCL_RECT))
>   
>   #define VIG_SC7280_MASK \
> -	(VIG_SDM845_MASK | BIT(DPU_SSPP_INLINE_ROTATION))
> +	(VIG_SDM845_MASK_NO_SDMA | BIT(DPU_SSPP_INLINE_ROTATION))
>   
>   #define VIG_SC7280_MASK_SDMA \
>   	(VIG_SC7280_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
>   
> -#define DMA_SDM845_MASK \
> +#define DMA_SDM845_MASK_NO_SDMA \
>   	(BIT(DPU_SSPP_QOS) | BIT(DPU_SSPP_QOS_8LVL) |\
>   	BIT(DPU_SSPP_TS_PREFILL) | BIT(DPU_SSPP_TS_PREFILL_REC1) |\
>   	BIT(DPU_SSPP_CDP) | BIT(DPU_SSPP_EXCL_RECT))
>   
> -#define DMA_CURSOR_SDM845_MASK \
> -	(DMA_SDM845_MASK | BIT(DPU_SSPP_CURSOR))
> +#define DMA_CURSOR_SDM845_MASK_NO_SDMA \
> +	(DMA_SDM845_MASK_NO_SDMA | BIT(DPU_SSPP_CURSOR))
>   
>   #define DMA_SDM845_MASK_SDMA \
> -	(DMA_SDM845_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
> +	(DMA_SDM845_MASK_NO_SDMA | BIT(DPU_SSPP_SMART_DMA_V2))
>   
>   #define DMA_CURSOR_SDM845_MASK_SDMA \
> -	(DMA_CURSOR_SDM845_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
> +	(DMA_CURSOR_SDM845_MASK_NO_SDMA | BIT(DPU_SSPP_SMART_DMA_V2))
>   
>   #define DMA_CURSOR_MSM8996_MASK \
>   	(DMA_MSM8996_MASK | BIT(DPU_SSPP_CURSOR))
> 


