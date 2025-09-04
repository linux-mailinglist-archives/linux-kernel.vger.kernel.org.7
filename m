Return-Path: <linux-kernel+bounces-801804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F4CB44A22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D5954E1DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922E2EE272;
	Thu,  4 Sep 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ozpw9On3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDE2E3B07
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027128; cv=none; b=ccLuKuA02SaZNp/2kcbu3YIgka44UW5E953JhVgBn5ef93n3HblBM7Fv5ft1bY+9B0qJBt277Ut3YrRZQg+vSI7r4WMZknumfbtAHGv8pGYR8N+nfePcRhtI83vji/cV7w650esYgu5BiZ09n4dhgxcHd0irNdWDu9JGOwCETfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027128; c=relaxed/simple;
	bh=lWPuFAByrtxQ2WSWx7LlpVspruPjfhqk54g4S3fDvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piLBAWtmlY+YuvRxI/YZl6QEHKdci1yt6pv2ibA67sHGK8CyXH67lHdbQcVYUoJ3qMnaUp96TSMfa5V4Q1mMwLu683dF+eEx+umZJrHoX5SgpFqxvC4fi+vJ49FHP9Pj+mkOf+7Vx+33I9gxqpYFRKLjm/NchslBv5yj/hQn3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ozpw9On3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GFvcx028221
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 23:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2BBqhUruX490OCtbVD9cWmg1K80ZzKKNurd2FslWoTo=; b=Ozpw9On3SMYkJxSP
	3ecE21clFXn46f9Q8xD79TVG4bqjY3apFcYWL/kSDdcoKkYZVZhkgLLwHotuUkSH
	RVGrYFv/dn2/cqVSPYYM7HYrySa/Fhm1YuYxDHKS/GDQGnl3kYxsodAME4//asXJ
	NGLPHt3Lol+LsPUvJOVsdUA/Wxu7JzTlJ+zb8jKB3FEuzDwGnPHC8Dd7rrGTC0Fw
	ReyWItNrFRhgXTBqzRap8b45vBEFJ4z91Q7DkNOa/3GSLy5EAhrID4qX+qt3dJw6
	0/rOlVnSdU5eew4bwVOo6h8qFOfZOBY366gkAa7E4HQDDBViZwqC3VCCdYfJaY9f
	AID4xw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0es9bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:05:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so2773027b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027124; x=1757631924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BBqhUruX490OCtbVD9cWmg1K80ZzKKNurd2FslWoTo=;
        b=D0CYV93kAaM/bGJokdlRtVl9ZqUb6hDlWY+61n9y97UbV63JSYoguBekzwQp+w5Qu+
         B7JBTB6HuPqOZ6S5Y7vfLkzZxZAOlzxOJIJalCMTOmX53IgZvpcH4JnuhKmQ42B7NO3M
         luAOuw3vtttzNTfXsaNAKKavEoPq7PECnZd8QKSWWoKUVWl6p1pyV2nJi7giTviQRebd
         HXpnmn63SHmebKbAESy2qwf94ZLXWFRKti+m0J9BHWodJx4UNAnPEDzPdyZKSDk9YkzS
         EyM0X6k3cVoiIQkhNXeQsHbIf054nYe0IXJ8zBcDPKTBxJEGw9fSXaxQ2tiSX+jdydiv
         FTOg==
X-Forwarded-Encrypted: i=1; AJvYcCXzwwb695fo2I9iA8YvW+nnkJvbM4k41RojWoEIZosZ9BkqDML5642GSCfVt2zro6S5ikEg01znfiJ20Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlemkcmwLEvOt9FxLV9HzjTNkYd8PmC39INth2qMapHWz5opq
	729Rukr99gNZ2rDRk91HCkuJJWeUZJziRtxBqsnc4wCKKJn+LJPrw4dE7ipsUGxMP8mIpU5c3ZE
	BeyaddT0GDDoORqUzDS+gXB9anskTH2AUDJNdkF14imxPVT8WSSaEEwqg8gtg2Vo8ESk=
X-Gm-Gg: ASbGncu4c4/Cg641yt4GG0CWOXsuvnIUbu+EDIdSsrhuDsLzEEG2DVMG/Q709OxufLb
	GxxIKAkBbbn0K3RYUaFfS/HwclM0pEyLWAYfRDRPzY3U7UN/AHokrqRt+AJ/0BMGpVTr8PEmfbt
	40RlYU934I6YILwd+GPFqvijIiy8Ffx74gVo6OtDSZ8YMSXsRX7O98nlDGCeIYONQmL/Li9kdam
	N0NEDw16K9Tn3zx/aMtBvULKTCGrPb/gN+BaqT4APhvCE1N2NbxG8GDnKVF3BWBpUXids+lrO62
	3RyZScSi96cG2YizM9cabzE9V/n2nrQUBxioqviJh2RVk1n0JY2lBjIxZoj6FTpOtrla7aim6S0
	wzdTmm8SXzwFvfVASExhoCw==
X-Received: by 2002:a05:6a00:1d92:b0:772:4937:d43e with SMTP id d2e1a72fcca58-7724937d85emr26174588b3a.32.1757027124284;
        Thu, 04 Sep 2025 16:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAsPYtFu6jW8n09u4WGEQzJcpHeOJw5wUGGzhcGysaJndyxg4QWO59eyJ3jU3jAg/KJlXtFQ==
X-Received: by 2002:a05:6a00:1d92:b0:772:4937:d43e with SMTP id d2e1a72fcca58-7724937d85emr26174563b3a.32.1757027123782;
        Thu, 04 Sep 2025 16:05:23 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7741f5b3c1csm98269b3a.60.2025.09.04.16.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:05:23 -0700 (PDT)
Message-ID: <e15b8695-08dd-49b2-a0e4-f1957026bf8f@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:05:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/msm/disp: simplify RGB{,A,X} formats
 definitions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250705-dpu-formats-v1-0-40f0bb31b8c8@oss.qualcomm.com>
 <20250705-dpu-formats-v1-4-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-4-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Lq_g6b75LFfYFUyLDu_njE-OmWg-NvzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX/sfT+ddXjU+r
 2tZ9c18RTuzzX0n4giMPp6Kmux1tgr93GOrm/ihzvm0mUJhTF7BHDF0x5LZLDcbFWr4yamI8YyM
 70L/KmcLIGiKe7P/Mkq5p9l9lzWoxaFi8bvZRuqBdMywUMVAx+PDhNvVbi4X/bouRVfHGzvr/yp
 rBO3MOVsoFEYU+hgf6J7JVfdetsl6xAwhN200vzSCKMbwRQFNuNKUza20pAWT4nercgWRIm4tAy
 ToblfCUC0ev7HIicki+vbYlCrU/afSIcuLicwcjhvu6ak+BMu1zhG3UeON9V2lfeATMkhEhA2oL
 uNfOMiaEiTv3jmiIbWApeyAr6rPlpb1tpPhGXoTNwI/v6W5ZWOMJbVneBSqmvfqSONHpWUCWgOC
 Sxk4ZFh3
X-Proofpoint-ORIG-GUID: Lq_g6b75LFfYFUyLDu_njE-OmWg-NvzU
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68ba1b35 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=D8afDwXF6kNTcx-T2tEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> Define several additional macros, capturing RGB format classes, in order
> to simplify defining particular RGB* format.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/mdp_format.c | 275 +++++++++++++++++++---------------
>   1 file changed, 158 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index 09a5bffd838b8a4fd3c22622e82dcf9fb99b5117..28cef986f2d662484afd47440a79393c48256ff5 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -66,22 +66,99 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
>   #define MDP_TILE_HEIGHT_UBWC	4
>   #define MDP_TILE_HEIGHT_NV12	8
>   
> -#define INTERLEAVED_RGB_FMT(fmt, a, r, g, b, e0, e1, e2, e3, uc, alpha,   \
> -bp, flg)                                                                  \
> +#define INTERLEAVED_RGB_FMT(fmt, bp, r, g, b, e0, e1, e2)                 \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> -	.alpha_enable = alpha,                                            \
> +	.alpha_enable = false,                                            \
> +	.element = { (e0), (e1), (e2), 0 },                               \
> +	.bpc_g_y = g,                                                     \
> +	.bpc_b_cb = b,                                                    \
> +	.bpc_r_cr = r,                                                    \
> +	.bpc_a = 0,                                                       \
> +	.chroma_sample = CHROMA_FULL,                                     \
> +	.unpack_count = 3,                                                \
> +	.bpp = bp,                                                        \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT,                            \
> +	.num_planes = 1,                                                  \
> +	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
> +}
> +
> +#define INTERLEAVED_RGBA_FMT(fmt, bp, a, r, g, b, e0, e1, e2, e3)         \
> +{                                                                         \
> +	.pixel_format = DRM_FORMAT_ ## fmt,                               \
> +	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> +	.alpha_enable = true,                                             \
>   	.element = { (e0), (e1), (e2), (e3) },                            \
>   	.bpc_g_y = g,                                                     \
>   	.bpc_b_cb = b,                                                    \
>   	.bpc_r_cr = r,                                                    \
>   	.bpc_a = a,                                                       \
>   	.chroma_sample = CHROMA_FULL,                                     \
> -	.unpack_count = uc,                                               \
> +	.unpack_count = 4,                                                \
>   	.bpp = bp,                                                        \
>   	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> -	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT,                            \
> +	.num_planes = 1,                                                  \
> +	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
> +}
> +
> +#define INTERLEAVED_RGBX_FMT(fmt, bp, a, r, g, b, e0, e1, e2, e3)         \
> +{                                                                         \
> +	.pixel_format = DRM_FORMAT_ ## fmt,                               \
> +	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> +	.alpha_enable = false,                                            \
> +	.element = { (e0), (e1), (e2), (e3) },                            \
> +	.bpc_g_y = g,                                                     \
> +	.bpc_b_cb = b,                                                    \
> +	.bpc_r_cr = r,                                                    \
> +	.bpc_a = a,                                                       \
> +	.chroma_sample = CHROMA_FULL,                                     \
> +	.unpack_count = 4,                                                \
> +	.bpp = bp,                                                        \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT,                            \
> +	.num_planes = 1,                                                  \
> +	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
> +}
> +
> +#define INTERLEAVED_RGBA_DX_FMT(fmt, bp, a, r, g, b, e0, e1, e2, e3)      \
> +{                                                                         \
> +	.pixel_format = DRM_FORMAT_ ## fmt,                               \
> +	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> +	.alpha_enable = true,                                             \
> +	.element = { (e0), (e1), (e2), (e3) },                            \
> +	.bpc_g_y = g,                                                     \
> +	.bpc_b_cb = b,                                                    \
> +	.bpc_r_cr = r,                                                    \
> +	.bpc_a = a,                                                       \
> +	.chroma_sample = CHROMA_FULL,                                     \
> +	.unpack_count = 4,                                                \
> +	.bpp = bp,                                                        \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
> +		 MSM_FORMAT_FLAG_DX,                                      \
> +	.num_planes = 1,                                                  \
> +	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
> +}
> +
> +#define INTERLEAVED_RGBX_DX_FMT(fmt, bp, a, r, g, b, e0, e1, e2, e3)      \
> +{                                                                         \
> +	.pixel_format = DRM_FORMAT_ ## fmt,                               \
> +	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> +	.alpha_enable = false,                                            \
> +	.element = { (e0), (e1), (e2), (e3) },                            \
> +	.bpc_g_y = g,                                                     \
> +	.bpc_b_cb = b,                                                    \
> +	.bpc_r_cr = r,                                                    \
> +	.bpc_a = a,                                                       \
> +	.chroma_sample = CHROMA_FULL,                                     \
> +	.unpack_count = 4,                                                \
> +	.bpp = bp,                                                        \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
> +		 MSM_FORMAT_FLAG_DX,                                      \
>   	.num_planes = 1,                                                  \
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
> @@ -225,185 +302,149 @@ flg, fm, np)                                                      \
>   }
>   
>   static const struct msm_format mdp_formats[] = {
> -	INTERLEAVED_RGB_FMT(ARGB8888,
> +	INTERLEAVED_RGBA_FMT(ARGB8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 4, 0),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(ABGR8888,
> +	INTERLEAVED_RGBA_FMT(ABGR8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 4, 0),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(XBGR8888,
> +	INTERLEAVED_RGBX_FMT(XBGR8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 4, 0),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBA8888,
> +	INTERLEAVED_RGBA_FMT(RGBA8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 4, 0),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGRA8888,
> +	INTERLEAVED_RGBA_FMT(BGRA8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 4, 0),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(BGRX8888,
> +	INTERLEAVED_RGBX_FMT(BGRX8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 4, 0),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(XRGB8888,
> +	INTERLEAVED_RGBX_FMT(XRGB8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 4, 0),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBX8888,
> +	INTERLEAVED_RGBX_FMT(RGBX8888, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 4, 0),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(RGB888,
> -		0, BPC8, BPC8, BPC8,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
> -		false, 3, 0),
> +	INTERLEAVED_RGB_FMT(RGB888, 3,
> +		BPC8, BPC8, BPC8,
> +		C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGR888,
> -		0, BPC8, BPC8, BPC8,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
> -		false, 3, 0),
> +	INTERLEAVED_RGB_FMT(BGR888, 3,
> +		BPC8, BPC8, BPC8,
> +		C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(RGB565,
> -		0, BPC5, BPC6, BPC5,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
> -		false, 2, 0),
> +	INTERLEAVED_RGB_FMT(RGB565, 2,
> +		BPC5, BPC6, BPC5,
> +		C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGR565,
> -		0, BPC5, BPC6, BPC5,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
> -		false, 2, 0),
> +	INTERLEAVED_RGB_FMT(BGR565, 2,
> +		BPC5, BPC6, BPC5,
> +		C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(ARGB1555,
> +	INTERLEAVED_RGBA_FMT(ARGB1555, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 2, 0),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(ABGR1555,
> +	INTERLEAVED_RGBA_FMT(ABGR1555, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 2, 0),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBA5551,
> +	INTERLEAVED_RGBA_FMT(RGBA5551, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 2, 0),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGRA5551,
> +	INTERLEAVED_RGBA_FMT(BGRA5551, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 2, 0),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(XRGB1555,
> +	INTERLEAVED_RGBX_FMT(XRGB1555, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 2, 0),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(XBGR1555,
> +	INTERLEAVED_RGBX_FMT(XBGR1555, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 2, 0),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBX5551,
> +	INTERLEAVED_RGBX_FMT(RGBX5551, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 2, 0),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGRX5551,
> +	INTERLEAVED_RGBX_FMT(BGRX5551, 2,
>   		BPC1A, BPC5, BPC5, BPC5,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 2, 0),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(ARGB4444,
> +	INTERLEAVED_RGBA_FMT(ARGB4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 2, 0),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(ABGR4444,
> +	INTERLEAVED_RGBA_FMT(ABGR4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 2, 0),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBA4444,
> +	INTERLEAVED_RGBA_FMT(RGBA4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 2, 0),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGRA4444,
> +	INTERLEAVED_RGBA_FMT(BGRA4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 2, 0),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(XRGB4444,
> +	INTERLEAVED_RGBX_FMT(XRGB4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 2, 0),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(XBGR4444,
> +	INTERLEAVED_RGBX_FMT(XBGR4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 2, 0),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBX4444,
> +	INTERLEAVED_RGBX_FMT(RGBX4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 2, 0),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(BGRX4444,
> +	INTERLEAVED_RGBX_FMT(BGRX4444, 2,
>   		BPC4A, BPC4, BPC4, BPC4,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 2, 0),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(BGRA1010102,
> +	INTERLEAVED_RGBA_DX_FMT(BGRA1010102, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(RGBA1010102,
> +	INTERLEAVED_RGBA_DX_FMT(RGBA1010102, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
> -	INTERLEAVED_RGB_FMT(ABGR2101010,
> +	INTERLEAVED_RGBA_DX_FMT(ABGR2101010, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(ARGB2101010,
> +	INTERLEAVED_RGBA_DX_FMT(ARGB2101010, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(XRGB2101010,
> +	INTERLEAVED_RGBX_DX_FMT(XRGB2101010, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX),
> +		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(BGRX1010102,
> +	INTERLEAVED_RGBX_DX_FMT(BGRX1010102, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX),
> +		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb),
>   
> -	INTERLEAVED_RGB_FMT(XBGR2101010,
> +	INTERLEAVED_RGBX_DX_FMT(XBGR2101010, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX),
> +		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
> -	INTERLEAVED_RGB_FMT(RGBX1010102,
> +	INTERLEAVED_RGBX_DX_FMT(RGBX1010102, 4,
>   		BPC8A, BPC8, BPC8, BPC8,
> -		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX),
> +		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr),
>   
>   	/* --- RGB formats above / YUV formats below this line --- */
>   
> 


