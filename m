Return-Path: <linux-kernel+bounces-801808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6CDB44A31
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7221EA4235B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4E2EE608;
	Thu,  4 Sep 2025 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sggjo2rn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8572EDD74
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027231; cv=none; b=kDcLshJnOdWve6sgOXw4UKWGfS06wb1GIuXn/+omMdUxl8BOSfcz01YecjlgOYutJrQLb6FBbqrYkshNjGvbqtueJXF4Ngrq8dkaBSsLXHsFaeoo1qFcWFC4e3uUl7cy+sfFta2FfSr+nYY2cU8DecxiOvJ9Nj5cRSYpMOt2q8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027231; c=relaxed/simple;
	bh=4CgRI9awes2q0YnxMZhM7WdQbylSBB9NFMKP36TVs1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQZ7rUJGqSs8vfIveiwQ1n4ohXtaFyh4cMv8SyZD8DGuv6hBhTLIRK0HPgJZ2CkxfmJKr6ZkHz94YAS2dVWg9w5GnpW+v9D5NTK3qc3oa49nGTJY8G74pOzOTsZBVYy6P+Fst4jweFwvtdoFiN+ocTY7BDcLU4OeKgBBI8or1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sggjo2rn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IIvLH007622
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 23:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VQxgtvqlq0HzxRDkP5I5PrVUOxES5Rbtim81FxX4br8=; b=Sggjo2rnmTJNkjGq
	S46CyRNFro+vFR8zL2uwM4EP7SArfGwrsatiZ+jzKxuktCM/uN2TgeAR6JIfzCbn
	dACUqifR102jbX+Udb6eoSWuOT0K+GCiE5ZA/jvrtvC7B//z7hWyy838KV+TzwwR
	IXW1TYw1ZlhnACSRS26O6G1vV21IUCFZ8pf+NJEA6dou/uZ5kHQzPOUJEuDFvVO4
	KtQ83P8eZ0UpEWixZPB0hhmcF13o5FSZjxIdFHG8wQeYU5w+YaoN9Or/X1ZO76rY
	2pnM5V1LvQuLh0hkQwuLZ0faqxoo8E1rrcM03dT9RwetUKNQbRTnz/mYWAAKw+M/
	5M4IMw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura9124v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:07:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24d4ab50385so951605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027227; x=1757632027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQxgtvqlq0HzxRDkP5I5PrVUOxES5Rbtim81FxX4br8=;
        b=oxxHf0xThRApVNPjxeyTCujg4p826YnHg7bKnnk5vjCn4xvi4lRzx6bpUzABmi8aAq
         DYnOIEmTJ9p9hrDPCG9kd6IL5y3iiOJ5sMQEgiZ6hd2Rbe7JrRxVdCez8uH7bduwfRfg
         W4Y3jdhXLOusBGnLMHIabOPMdplWKDYyrnxSNFzhDexC4MOboQa5u51FbG9T9gF2LteU
         9St1uuKwXoVvBHBmhBh+YgyHIEQ9X7gLfF5LnyGHaAhAyOXxY8swTgOHbkJBeajUaNII
         fodCmLyfK552atQcaYF7pyhgno/iUdK5bt0pQVO9h09ViR6e0Mkq4Qs4C1JT2x3uOMQ1
         RtbA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Sb84XWmKUO3lO9xWYKIR5D1gHIqMuXJnKTTRYxCeBcWM/CBEJmgC1czzQ2gl+wdTOvQ+7mlCbpII2C8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OdhaJzqkFJNAktjRSfRQf0/TnkS/EfadeiM/RlRb74tlEXpX
	d54OHbPf8h36P5PSq62Uuk3dZpSSzu76/FYXhUKFgI0KXrae9OCHRFCgyqV/W0QAKCvP0RU+Utx
	DE7cSQy07mjR2cVtdXxYqyV2YvfLB6rZ4dOjF9DvNZtcZFA8GXB9Y7A3466GF3x2H/88=
X-Gm-Gg: ASbGncu+73EdHmH+TXrXSEmn/th9zIhxuBx50mawPxXmi1R1zv5fCsmVUtB5vUabckd
	0IJVVq7bUiwIcwlW0F4kS9UMJkVx52dLR9Ae5Yw8FxXvkakpQnGYKFxvrm0vydLmjMeuu3IGH/E
	cUQl2E1kBy8UhuNsKuuD4G62nP4OxxKZwztwqs8dsHT+L3azd8Hp5EfIiyt8fcnJvckF8txZTE8
	6D0aB/7gje6nVvMYrHZ6XMScPfUYth2K//WFj3BJ/8vhR6nDbELYi9PGWhnGzL8Ipe25QiXwWr+
	AERbSgSaD1lFom/NxHwV/N9J6pZU9+KZxRH4OrIZI14RV8sp99rhSmx5zAM7GSFvrEAzg9K50oU
	dt9MVWZhpEJ2H5wqq4O59/Q==
X-Received: by 2002:a17:903:244f:b0:246:cf6a:f010 with SMTP id d9443c01a7336-24cedfa9098mr16776735ad.13.1757027226472;
        Thu, 04 Sep 2025 16:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3a9adXc+OPNFqInEjRcz8beQaf9/kI61UkTE5l3c0GN008HPPd0XCUECzEsnDCx8AkRCd9A==
X-Received: by 2002:a17:903:244f:b0:246:cf6a:f010 with SMTP id d9443c01a7336-24cedfa9098mr16776305ad.13.1757027225874;
        Thu, 04 Sep 2025 16:07:05 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3110sm38258035ad.120.2025.09.04.16.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:07:05 -0700 (PDT)
Message-ID: <1865e8a7-9d9d-4671-8429-bff121ab6ac4@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] drm/msm/disp: pull in common YUV format parameters
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
 <20250705-dpu-formats-v1-6-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-6-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jb7O_4JKo-03uG9YcjDFJMBW08DfhGpG
X-Proofpoint-GUID: Jb7O_4JKo-03uG9YcjDFJMBW08DfhGpG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX994noAzkbbi7
 t8vYH7aAAyhdTGqfDAFSoEehlVEss0f26FvZSTNpP5p0BFClS+ba7X2zLocw9J914HK/HAov+1l
 W3dCycDXM0H1073zO8Km+DWXzCYGFuTPLVpIQGTm0W1mlwy4t9lzHrkPKkpl72qIGes2QZ9E1+o
 1kaYToOQ+rX0PaLiYJGaoPCWYWywjGGS2ZpQqpTmmhFVFaZ3MOpdN6glGdaYDNYrr9ht8A2lA4k
 YiY8g+CjzVspiFFPx6LUeBjLm6k/VGIGcqBrEbvfiULEQCVBv7PN0uYO81IA44OME5EmznUUwqy
 rfCYqFbeQIunx+ydkGleuW5qYITm94FJKAxAM6LR6p6BlyuojXTg5VhUBQj0b8KFKa+R5YUFqsM
 PKUwdy1/
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68ba1b9b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=NxCvQ7sPRDO8UjZhUV8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> Pull common params of YUV formats into corresponding macro definitions,
> simplifying format table.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/mdp_format.c | 120 ++++++++++++++++------------------
>   1 file changed, 56 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index d577b3d53fbebced63792b5c65f50dd45211c8ea..900b2de252a6eb2eac3d0670f1aaa77f7520fd77 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -244,27 +244,27 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
>   	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
>   }
>   
> -#define INTERLEAVED_YUV_FMT(fmt, a, r, g, b, e0, e1, e2, e3,              \
> -alpha, chroma, count, bp, flg, fm, np)                                    \
> +#define INTERLEAVED_YUV_FMT(fmt, bp, r, g, b, e0, e1, e2, e3, chroma)     \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> -	.alpha_enable = alpha,                                            \
> +	.alpha_enable = false,                                            \
>   	.element = { (e0), (e1), (e2), (e3)},                             \
>   	.bpc_g_y = g,                                                     \
>   	.bpc_b_cb = b,                                                    \
>   	.bpc_r_cr = r,                                                    \
> -	.bpc_a = a,                                                       \
> +	.bpc_a = 0,                                                       \
>   	.chroma_sample = chroma,                                          \
> -	.unpack_count = count,                                            \
> +	.unpack_count = 4,                                                \
>   	.bpp = bp,                                                        \
> -	.fetch_mode = fm,                                                 \
> -	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
> -	.num_planes = np,                                                 \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
> +		 MSM_FORMAT_FLAG_YUV,                                     \
> +	.num_planes = 1,                                                  \
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> -#define PSEUDO_YUV_FMT(fmt, a, r, g, b, e0, e1, chroma, flg, fm, np)      \
> +#define PSEUDO_YUV_FMT(fmt, r, g, b, e0, e1, chroma)                      \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
> @@ -273,13 +273,14 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
>   	.bpc_g_y = g,                                                     \
>   	.bpc_b_cb = b,                                                    \
>   	.bpc_r_cr = r,                                                    \
> -	.bpc_a = a,                                                       \
> +	.bpc_a = 0,                                                       \
>   	.chroma_sample = chroma,                                          \
>   	.unpack_count = 2,                                                \
>   	.bpp = 2,                                                         \
> -	.fetch_mode = fm,                                                 \
> -	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
> -	.num_planes = np,                                                 \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
> +		 MSM_FORMAT_FLAG_YUV,                                     \
> +	.num_planes = 2,                                                  \
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> @@ -303,7 +304,7 @@ flg, fm, np, th)                                                          \
>   	.tile_height = th                                                 \
>   }
>   
> -#define PSEUDO_YUV_FMT_LOOSE(fmt, a, r, g, b, e0, e1, chroma, flg, fm, np)\
> +#define PSEUDO_YUV_FMT_LOOSE(fmt, r, g, b, e0, e1, chroma)                \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
> @@ -312,13 +313,15 @@ flg, fm, np, th)                                                          \
>   	.bpc_g_y = g,                                                     \
>   	.bpc_b_cb = b,                                                    \
>   	.bpc_r_cr = r,                                                    \
> -	.bpc_a = a,                                                       \
> +	.bpc_a = 0,                                                       \
>   	.chroma_sample = chroma,                                          \
>   	.unpack_count = 2,                                                \
>   	.bpp = 2,                                                         \
> -	.fetch_mode = fm,                                                 \
> -	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | flg,                  \
> -	.num_planes = np,                                                 \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB |                       \
> +		 MSM_FORMAT_FLAG_DX |                                     \
> +		 MSM_FORMAT_FLAG_YUV,                                     \
> +	.num_planes = 2,                                                  \
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> @@ -342,23 +345,23 @@ flg, fm, np, th)                                                          \
>   	.tile_height = th                                                 \
>   }
>   
> -#define PLANAR_YUV_FMT(fmt, a, r, g, b, e0, e1, e2, alpha, chroma, bp,    \
> -flg, fm, np)                                                      \
> +#define PLANAR_YUV_FMT(fmt, bp, r, g, b, e0, e1, e2, chroma)              \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_PLANAR,                                   \
> -	.alpha_enable = alpha,                                            \
> +	.alpha_enable = false,                                            \
>   	.element = { (e0), (e1), (e2), 0 },                               \
>   	.bpc_g_y = g,                                                     \
>   	.bpc_b_cb = b,                                                    \
>   	.bpc_r_cr = r,                                                    \
> -	.bpc_a = a,                                                       \
> +	.bpc_a = 0,                                                       \
>   	.chroma_sample = chroma,                                          \
>   	.unpack_count = 1,                                                \
>   	.bpp = bp,                                                        \
> -	.fetch_mode = fm,                                                 \
> -	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
> -	.num_planes = np,                                                 \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
> +		 MSM_FORMAT_FLAG_YUV,                                     \
> +	.num_planes = 3,                                                  \
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> @@ -511,72 +514,61 @@ static const struct msm_format mdp_formats[] = {
>   
>   	/* 2 plane YUV */
>   	PSEUDO_YUV_FMT(NV12,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C2_R_Cr,
> -		CHROMA_420, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		CHROMA_420),
>   
>   	PSEUDO_YUV_FMT(NV21,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C2_R_Cr, C1_B_Cb,
> -		CHROMA_420, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		CHROMA_420),
>   
>   	PSEUDO_YUV_FMT(NV16,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C2_R_Cr,
> -		CHROMA_H2V1, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		CHROMA_H2V1),
>   
>   	PSEUDO_YUV_FMT(NV61,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C2_R_Cr, C1_B_Cb,
> -		CHROMA_H2V1, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		CHROMA_H2V1),
>   
>   	PSEUDO_YUV_FMT_LOOSE(P010,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C2_R_Cr,
> -		CHROMA_420, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		CHROMA_420),
>   
>   	/* 1 plane YUV */
> -	INTERLEAVED_YUV_FMT(VYUY,
> -		0, BPC8, BPC8, BPC8,
> +	INTERLEAVED_YUV_FMT(VYUY, 2,
> +		BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C0_G_Y,
> -		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 1),
> +		CHROMA_H2V1),
>   
> -	INTERLEAVED_YUV_FMT(UYVY,
> -		0, BPC8, BPC8, BPC8,
> +	INTERLEAVED_YUV_FMT(UYVY, 2,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C0_G_Y,
> -		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 1),
> +		CHROMA_H2V1),
>   
> -	INTERLEAVED_YUV_FMT(YUYV,
> -		0, BPC8, BPC8, BPC8,
> +	INTERLEAVED_YUV_FMT(YUYV, 2,
> +		BPC8, BPC8, BPC8,
>   		C0_G_Y, C1_B_Cb, C0_G_Y, C2_R_Cr,
> -		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 1),
> +		CHROMA_H2V1),
>   
> -	INTERLEAVED_YUV_FMT(YVYU,
> -		0, BPC8, BPC8, BPC8,
> +	INTERLEAVED_YUV_FMT(YVYU, 2,
> +		BPC8, BPC8, BPC8,
>   		C0_G_Y, C2_R_Cr, C0_G_Y, C1_B_Cb,
> -		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 1),
> +		CHROMA_H2V1),
>   
>   	/* 3 plane YUV */
> -	PLANAR_YUV_FMT(YUV420,
> -		0, BPC8, BPC8, BPC8,
> +	PLANAR_YUV_FMT(YUV420, 1,
> +		BPC8, BPC8, BPC8,
>   		C2_R_Cr, C1_B_Cb, C0_G_Y,
> -		false, CHROMA_420, 1, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 3),
> +		CHROMA_420),
>   
> -	PLANAR_YUV_FMT(YVU420,
> -		0, BPC8, BPC8, BPC8,
> +	PLANAR_YUV_FMT(YVU420, 1,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C2_R_Cr, C0_G_Y,
> -		false, CHROMA_420, 1, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 3),
> +		CHROMA_420),
>   };
>   
>   /*
> 


