Return-Path: <linux-kernel+bounces-740927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C84B0DB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70805564178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076B433A8;
	Tue, 22 Jul 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9Xcietf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4A22FDFF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192147; cv=none; b=UiMTV7T8g8xHXztnhWX+8Vs4OLWlZb5tBCbyAx6AikdxiFAPJepG3X4ocT7a3DDnz1zVM10QI4OprAyUCX4FCLf2EvEq2AL4LXLgET8zwBrB1SFVvEYheK4hlXU7CVV4c/rkdXbf3dr97zA2ntzHbZGP1vFpqjdENZHBaeXFDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192147; c=relaxed/simple;
	bh=UBg8GfTzqwH391IljKQIgfrriRWvrmW8MOWbPhSgdac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+4l0zY2AQpGhGCaXq8TEIXYjP54x8xrl8vY5fRpNEcoDm/WAicnvvwM9yftofnBKZyJEypiBGM2SjQAQXzQ0fYBybOPRFuoazAUYQmuBqiJMWKu24QAuoWL6wMyOqKFrnnPuYIJsrDB44T6Fb6Xav9pIbKG4Rh47y/ft07GSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9Xcietf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MBt7qO015833
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/ahKHSJjWMR0JbnnzzPNZ/NL
	nOfa1sJ/Sol3h9sN5wM=; b=a9Xcietf16qBoxAuyJPAfrjcHNDQDra2LGSMqgef
	bGQqhe9k+vrs9KdM6Yz9Rlx5LRe62h9iR+WTXcEyGlwQE3L19/FF8v3Zd28/oKFX
	X20sDuBg34LYSnTmcE3qrZeHOcqZzgnU7LAtM03g4+FAT6214FIleIlSBjg5/t81
	vpPpE++N8NPg3opoxyxqoHvYlxejg0osrFFze3b81XSFqomtO+Ab9mkpfYpmoAmF
	nFiNd9EBZwnh3adnWTN8QuaHxbuXYXbOOEMaTHMVzb5rE5o64TWaa9I1XpvdWYui
	PjQ5neNSOD8rVAdvHjTnfCz67jkT5E/yWuaMhpw5iRri+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451he2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:49:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e32df3ace0so448844385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192144; x=1753796944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ahKHSJjWMR0JbnnzzPNZ/NLnOfa1sJ/Sol3h9sN5wM=;
        b=nyoCZ+r/thrhJT73ui8OCYSbqR9oDeZDgmQEjF4FSnBVV8c2/euA5nzODsyM0bK1zI
         MNFiuQMfTOyyqPwBqfOmb9FJ3SEnOdydSLejWeezVXYmteSl81Qxx9BQiVHBPJnlMUQ3
         4UgA9mk366+aY6dugCmJi/BwPnq4oD354R7fx+R/7mazNC1Ef7ecsbG6zPP6wHFlBfjb
         zgBAFmdOl/ODfB/sxnhGPA5YiGfYZKlU7MJpsLMyYOIbbBb84Qja/Dyhb3eL1HY6VxAl
         a4nYOCcIwbIttmGKeVt5Q2igSNsEZ3hNtyJj/LyIU7Na0G5xEClHJjZqKiGGiRugmax6
         f7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVcmv3Abzc2LcCDn0wonVIY5fddI2InjMhiDT1BfNFwMz8SdpMStdrg8ZSuJxxS8nZb5FCgE/+ZUoCNCH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyooPnwAZb++dLL3yc6lW9i8vezIfTSkWiNqPZhnzpjgr1+NAz4
	avXBJ0LLe6aPJ3gl0zHG1LUlzUj0+j2Gf6STyRBisLibL+myxVbDWHxhBG0z5ZYTiKCpW80VnwE
	I6K6fa1vTD1/oec++CIMtwNKZmmhMxCr65Yb0t9bBxV0+nyeYmL63M9lv+D1gNuxiQ5A=
X-Gm-Gg: ASbGncs93dkJemS9outN2ye5Qu8oQoOx0BARire8ItoHJ/XDA3aZNHfz3eRqQnynQeA
	wVHu/hCFqREl3YluIo7xznNAfca3lhg1fIsahm26nZp1WHkw1Virt4qoaLklM8EcSuMjPquTnNK
	ekL63QWgSzdCvSVkMoa4464yCwbhA4ywMafYWm+Tb54QwWhbARmqmeXDTb0IMjUIgU7nTHnvFh9
	fOT4Oryy460lr4cyC+jKvsxqLGKDNwH1R87BmitsFzfGIXSNXOhJESmp54tyAoLAkf5Q3tgShHm
	zaXfm9Ohx8BErgUdUJUmMZn802lE6+3jkzDnTMs9XnHmAycgX7trXdntUk0WNOLGcqFP0Cvq6mc
	ORDtOueCn9lr1flvhijzSk+BBhGPWOFpUbhnd6skB5OSOOO2ftI8q
X-Received: by 2002:a05:620a:178d:b0:7d3:8f51:e80c with SMTP id af79cd13be357-7e343571240mr3158196785a.22.1753192143423;
        Tue, 22 Jul 2025 06:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmmaQ1krTHbmcZorYzIOGhW5X5c+FKz8RqQxyMYTrcBqK8TnKqrJzlUyB3wkUh2DI0SekV8Q==
X-Received: by 2002:a05:620a:178d:b0:7d3:8f51:e80c with SMTP id af79cd13be357-7e343571240mr3158192785a.22.1753192142813;
        Tue, 22 Jul 2025 06:49:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d91134sm1959164e87.145.2025.07.22.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:49:02 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:49:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] drm/msm: Add support for IFPC
Message-ID: <k653qq6a4xkvwadeum5kbr7cheje773vobehpzq33ec44vyxjj@vi3ekv4jwext>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687f96d0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=i_i2Vd3NPHTucyE0f70A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VlMGbzhxJQ8hC-0y-uvuTQtdohIXKLGx
X-Proofpoint-GUID: VlMGbzhxJQ8hC-0y-uvuTQtdohIXKLGx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExMyBTYWx0ZWRfX5FVpg12Dm3c+
 oEoRViBtbzgHfx3MRqrd2Fc8PsGCFjfV1DghIABjwwdYEHETc6kZyorRmx12YKJEizupaLyuL5C
 B5qPXeKTt++ppeImrKSaoMTsvSOLTGKT0vbB6pMFL9e/HWEwCYQsOgrbdU0tvcl7kpK83Nc/Z2r
 NxCaDvsjm4xzw0eNdYjWwDZeutDJtFdsNVWl9GZB5g9b/juaUZZn8qZ4xXWzzQHysAkogr+GF0x
 OKwEb0Ml4beQVZuZ2ygQd3QAIsEdlxh3XI4HMUHUPRCl2ObmCQ86mW9C7pE0qI5n5loU1EH9sTC
 BEfBqZF2iMnXMNupLiqDyZu6BcJDP/MEK3MNE5l5MLadig2rerVT2prTYCzQaP12BIbVQvZvkq7
 O/ofXRPWsQeUE5iism4UOwmEUqUKbkNF+lWoBuGnTYCyGuQHTBA0Xs7Y8TNpDqCTdmOTjUya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220113

On Sun, Jul 20, 2025 at 05:46:12PM +0530, Akhil P Oommen wrote:
> Add a new quirk to denote IFPC (Inter-Frame Power Collapse) support
> for a gpu. Based on this flag send the feature ctrl hfi message to
> GMU to enable IFPC support.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |  5 +++--
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c   | 33 +++++++++++++++++++++++++++------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  3 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 4d6c70735e0892ed87d6a68d64f24bda844e5e16..3bbcc78179c1cf1bfa21ff097e9350eb2f554011 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1961,8 +1961,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	if (ret)
>  		return ret;
>  
> -	/* Fow now, don't do anything fancy until we get our feet under us */
> -	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
> +	/* Set GMU idle level */
> +	gmu->idle_level = (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC) ?
> +		GMU_IDLE_STATE_IFPC : GMU_IDLE_STATE_ACTIVE;
>  
>  	pm_runtime_enable(gmu->dev);
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 8e69b1e8465711837151725c8f70e7b4b16a368e..20ade6b0558b016b581078f5cf7377e7e7c57f8e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -21,6 +21,7 @@ static const char * const a6xx_hfi_msg_id[] = {
>  	HFI_MSG_ID(HFI_H2F_MSG_PERF_TABLE),
>  	HFI_MSG_ID(HFI_H2F_MSG_TEST),
>  	HFI_MSG_ID(HFI_H2F_MSG_START),
> +	HFI_MSG_ID(HFI_H2F_FEATURE_CTRL),
>  	HFI_MSG_ID(HFI_H2F_MSG_CORE_FW_START),
>  	HFI_MSG_ID(HFI_H2F_MSG_GX_BW_PERF_VOTE),
>  	HFI_MSG_ID(HFI_H2F_MSG_PREPARE_SLUMBER),
> @@ -765,23 +766,39 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>  		NULL, 0);
>  }
>  
> +static int a6xx_hfi_feature_ctrl_msg(struct a6xx_gmu *gmu, u32 feature, u32 enable, u32 data)
> +{
> +	struct a6xx_hfi_msg_feature_ctrl msg = {
> +		.feature = feature,
> +		.enable = enable,
> +		.data = data,
> +	};
> +
> +	return a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg, sizeof(msg), NULL, 0);
> +}
> +
> +#define HFI_FEATURE_IFPC 9

Can we please have an enum or at least a set of defines rather than
havign them scattered through the code?

> +
> +static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
> +{
> +	if (gmu->idle_level != GMU_IDLE_STATE_IFPC)
> +		return 0;
> +
> +	return a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFPC, 1, 0x1680);

magic number?

> +}
> +
>  #define HFI_FEATURE_ACD 12
>  
>  static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>  {
>  	struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
> -	struct a6xx_hfi_msg_feature_ctrl msg = {
> -		.feature = HFI_FEATURE_ACD,
> -		.enable = 1,
> -		.data = 0,
> -	};
>  	int ret;
>  
>  	if (!acd_table->enable_by_level)
>  		return 0;
>  
>  	/* Enable ACD feature at GMU */
> -	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg, sizeof(msg), NULL, 0);
> +	ret = a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_ACD, 1, 0);
>  	if (ret) {
>  		DRM_DEV_ERROR(gmu->dev, "Unable to enable ACD (%d)\n", ret);
>  		return ret;
> @@ -898,6 +915,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
>  	if (ret)
>  		return ret;
>  
> +	ret = a6xx_hfi_enable_ifpc(gmu);
> +	if (ret)
> +		return ret;
> +
>  	ret = a6xx_hfi_send_core_fw_start(gmu);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index bc063594a359ee6b796381c5fd2c30e2aa12a26d..1135beafac464f3162a3a61938a7de0c7920455a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -58,6 +58,7 @@ enum adreno_family {
>  #define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
>  #define ADRENO_QUIRK_PREEMPTION			BIT(5)
>  #define ADRENO_QUIRK_4GB_VA			BIT(6)
> +#define ADRENO_QUIRK_IFPC			BIT(7)
>  
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

