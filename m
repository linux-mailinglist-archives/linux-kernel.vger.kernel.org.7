Return-Path: <linux-kernel+bounces-801485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC8B4459B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856C6A00DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE82FE04B;
	Thu,  4 Sep 2025 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JmULmFZW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD322FDC26
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011102; cv=none; b=s7ko/x+y5RU6kYdt8NBRVv1ZlLk6JTCefik8t1kRS+g4YlwYqnYEAMjU2kqf9BxcJkIyeFVUWrZou7vQ3VlJSnFaMgt956vnfstrWHQSjEplsq3F6AAzRv/DustRpJtnnw8dF0NVWCXXGPtdS549mutACWdW0X0D6PIJ2OhzLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011102; c=relaxed/simple;
	bh=NiRdYiiiRV4FWalVTr1Q5z0gH4g/vvAfsEWsd3OUJ5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8Xg/mpeV7Oui1BViIeaLbbvEwBV6wn/YqlzymJh6BvLSu9heJWtd94/U8XAV7aRL0vaKwZboZ2+aWIwV+5vFpwmpL/vlG8bzFXHv+ggpZRxxhqvogWN3cY8+57P4Fj+qhXFxcY75PiHBR/RxTj3RQ+Hb3sQTu05g4F8gCwB3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JmULmFZW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9Dx032214
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rssL+6G8FN5LG7LMUBKmTSBofG0KyOBvcSbrEws4HPo=; b=JmULmFZW6lZ/mKn0
	8itMKEbCHe7M2BP6t61xJmYFLLjfXs5zmAMyU2y001q6fNpmcmUoZ/0GYH/A2xFU
	PwyJYF0C7iYAGmoP7UirkGTXNa1luXd9TkR5j33MI2lJts6LypbEkCipyTuc00Dt
	xekHIPqR2m7VZgqCLW/xzOfR8bxHnQYN6lMkvlgW9hl+BsFjwqruVd0qfsMvwk25
	KTJM9++3Dq6IPMYZ78d/C3QXrKOu7mP5S7uBn+k4ejlOFsS+9yEG4yqUdIsMw3RB
	Ks/NtjjC1yFH/25mQ55X7d2tM71NP+LWM02FCBU1cPWO44M66D6sPlcXvakoF5M2
	U6IQ2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpgqqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:38:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c99bd543aso20425715ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757011098; x=1757615898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rssL+6G8FN5LG7LMUBKmTSBofG0KyOBvcSbrEws4HPo=;
        b=nhbpIxowLcyff7dXtp4fjVYrGBKtPA96UQR9/XLz+xxkpKMmqldnzmG6PGNln+MZL3
         wbbvCvnegcSFbTLlz4maMBrqwv6zHWFtW1BCuUCJCAv/k1pBmOtYcHLd6Y4cUKopzvu0
         GO5VZ8JAvaaTkZZCizI4ZXrwdtDKcghmVrzvVuZ9XtzoorW5bjG8bF9TVqOKcYmkUrCN
         au9lPk0K57d/nKZK12QzePd3YrQ3I/k30Jo46TWprQzrE+30iK7asjk52vhW+bSRcVCh
         5uUSkhjTMDuS51ETeOMY8fXbyZfoDHE7ZmkcB2CGrG55kd9Yr2oY9iapz5QdAweOFwuK
         eSmw==
X-Forwarded-Encrypted: i=1; AJvYcCWSzQn3pTyHSaEdtdoCpAcfmkSda4IOknT5ekNG/rhKdCCf9/PmM3Rb6wsWhPuPDQh4b03BikH5xKUAeYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7E60dV+F/pebuGbvlaSGzxhWzsuvsPyIRmtRguubYlW/WDgH
	vT46i205inrDErTZApR7J2zk6a2CKT1KnQi5+pBs+1r5bPggGAtaELT1lVJADGI//j354B1CtH2
	E17YdPRdsYouAUdVxLLrUVtI+NF6zeGo8lV6FHioUfVPO5QtwJAfzC0LlufhEnicWGfk=
X-Gm-Gg: ASbGncsq0LX5N8bsIeLGP+AFE3EEMSDwiN/SDW5TgOgFh5ldEImb3hlo2+H7bn+IJ05
	N9lcrPkmjsYAj8kOQ0uVUUcDpW+EfOLTQT34yioSlKaK/MQv7+IkHr/oQ3AcoHVE/2CPjEVPSHD
	q4iM+hr7n7yIfCvzrtXJA3snqR5CqpWSU5oSXWsPALinr8iFtPzoB56nHWuzAeQdUgK/YhsdS1Q
	aagjcdQe40GjFN6DU9mKEyNISEniXyM7ACVXljJmMIZbH2IIdpVQnukHsfvoN5v1uZWUxp2sMVg
	RWO2bZOm5aiYNw1RBRbqHtWExW8JlGP3KlbpXFBeG3eLH1TJ4tuuy7npw2Yg2vZEdATaapQL+0w
	Z+SrQM990+F26DSNvnMPHQg==
X-Received: by 2002:a17:902:f542:b0:24b:1741:1a43 with SMTP id d9443c01a7336-24b17411e77mr130690685ad.58.1757011097869;
        Thu, 04 Sep 2025 11:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrGZXs3Bk5vSSAzqcnUJQ1gGAx5Q/kY4Q2C+c3W9OYcx0iHZD5nnEJBxA6I/4YYx/XY+RokQ==
X-Received: by 2002:a17:902:f542:b0:24b:1741:1a43 with SMTP id d9443c01a7336-24b17411e77mr130690365ad.58.1757011097364;
        Thu, 04 Sep 2025 11:38:17 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ce9dd9373sm5748535ad.85.2025.09.04.11.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:38:16 -0700 (PDT)
Message-ID: <c2d810bc-bdba-464b-9a05-49ca2e1c773b@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 11:38:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] drm/msm/dpu: use standard functions in
 _dpu_format_populate_plane_sizes_ubwc()
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
 <20250705-dpu-formats-v1-12-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-12-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zKxfmq-7FGUq9aTMPGG-a5V2dtcSXMcl
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b9dc9b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=vPUQ5TvUw8t84cJzJAUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: zKxfmq-7FGUq9aTMPGG-a5V2dtcSXMcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX/maYTdQ80xQQ
 MA4vQ/Er4ZsVg0FS0rrtDEy0Kfj1IkhZwfwibEbMP1pu8GAPzsZ/JlwD/n3a6hO9VJF5AzRCS55
 0+VnSibYZzzNlb4F1JL+Q7IsXIjg0K+llT0SV7OKL5Lsk+2BvCNTSHiztjC3tlqCnW0WckHXNF8
 pD2/sWk6Esu4bpkGw6TUUurDqjbWTbUxUwNGL7at4H5nGbzfQRBLtiRbqe6Cz4a2xizscHqBU4a
 qz68qokvxkL83ovIeagXgMQ6KThs3D4hRXFYc01cHqWTqLhUTuy7F72KMC6EDHwSj+kisTWfWV2
 X1F6eqh/ZfdZsqIyJEDb6lmBTqTddbP+l4Bpt7yDB79OlLB23+absSjAFqEELYtEyrcKjq1goqG
 9aX4Vmtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> The _dpu_format_populate_plane_sizes_ubwc() used MSM_MEDIA_ALIGN() and
> MSM_MEDIA_ROUNDUP(), macros inherited from the previous implementation,
> msm_media_info.h. Replace them with the standard Linux macros,
> round_up() and DIV_ROUND_UP() respectively.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 62 ++++++++++++-----------------
>   1 file changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> index 67bc5a6eeb43dcf113dea9eccdb778cd52b1ad40..6a0426ed1460c5af4822844d7a7b0c51739df875 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> @@ -10,16 +10,6 @@
>   #include "dpu_kms.h"
>   #include "dpu_formats.h"
>   
> -#ifndef MSM_MEDIA_ALIGN
> -#define MSM_MEDIA_ALIGN(__sz, __align) (((__align) & ((__align) - 1)) ?\
> -	((((__sz) + (__align) - 1) / (__align)) * (__align)) :\
> -	(((__sz) + (__align) - 1) & (~((__align) - 1))))
> -#endif
> -
> -#ifndef MSM_MEDIA_ROUNDUP
> -#define MSM_MEDIA_ROUNDUP(__sz, __r) (((__sz) + ((__r) - 1)) / (__r))
> -#endif
> -
>   #define DPU_UBWC_PLANE_SIZE_ALIGNMENT	4096
>   
>   /*
> @@ -80,57 +70,57 @@ static int _dpu_format_populate_plane_sizes_ubwc(
>   		    fmt->pixel_format == DRM_FORMAT_P010) {
>   			if (MSM_FORMAT_IS_DX(fmt)) {
>   				if (fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT) {
> -					stride = MSM_MEDIA_ALIGN(fb->width, 192);
> -					stride = MSM_MEDIA_ALIGN(stride * 4 / 3, 256);
> +					stride = round_up(fb->width, 192);

Hi Dmitry,

It seems like the usage of round_up() here might be incorrect -- the 
docs say "round up to next specified power of 2".

Maybe we should use roundup() instead here?

The rest of the patch LGTM.

Thanks,

Jessica Zhang

> +					stride = round_up(stride * 4 / 3, 256);
>   					y_tile_width = 48;
>   				} else {
> -					stride = MSM_MEDIA_ALIGN(fb->width * 2, 256);
> +					stride = round_up(fb->width * 2, 256);
>   					y_tile_width = 32;
>   				}
>   
> -				sclines = MSM_MEDIA_ALIGN(fb->height, 16);
> +				sclines = round_up(fb->height, 16);
>   				y_tile_height = 4;
>   			} else {
> -				stride = MSM_MEDIA_ALIGN(fb->width, 128);
> +				stride = round_up(fb->width, 128);
>   				y_tile_width = 32;
>   
> -				sclines = MSM_MEDIA_ALIGN(fb->height, 32);
> +				sclines = round_up(fb->height, 32);
>   				y_tile_height = 8;
>   			}
>   		}
>   
>   		layout->plane_pitch[0] = stride;
> -		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
> +		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
>   			sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
>   
>   		layout->plane_pitch[1] = stride;
> -		layout->plane_size[1] = MSM_MEDIA_ALIGN(layout->plane_pitch[1] *
> +		layout->plane_size[1] = round_up(layout->plane_pitch[1] *
>   			sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
>   
>   		if (!meta)
>   			return 0;
>   
> -		y_meta_stride = MSM_MEDIA_ROUNDUP(fb->width, y_tile_width);
> -		layout->plane_pitch[2] = MSM_MEDIA_ALIGN(y_meta_stride, 64);
> +		y_meta_stride = DIV_ROUND_UP(fb->width, y_tile_width);
> +		layout->plane_pitch[2] = round_up(y_meta_stride, 64);
>   
> -		y_meta_scanlines = MSM_MEDIA_ROUNDUP(fb->height, y_tile_height);
> -		y_meta_scanlines = MSM_MEDIA_ALIGN(y_meta_scanlines, 16);
> -		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
> +		y_meta_scanlines = DIV_ROUND_UP(fb->height, y_tile_height);
> +		y_meta_scanlines = round_up(y_meta_scanlines, 16);
> +		layout->plane_size[2] = round_up(layout->plane_pitch[2] *
>   			y_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
>   
> -		uv_meta_stride = MSM_MEDIA_ROUNDUP((fb->width+1)>>1, y_tile_width / 2);
> -		layout->plane_pitch[3] = MSM_MEDIA_ALIGN(uv_meta_stride, 64);
> +		uv_meta_stride = DIV_ROUND_UP((fb->width+1)>>1, y_tile_width / 2);
> +		layout->plane_pitch[3] = round_up(uv_meta_stride, 64);
>   
> -		uv_meta_scanlines = MSM_MEDIA_ROUNDUP((fb->height+1)>>1, y_tile_height);
> -		uv_meta_scanlines = MSM_MEDIA_ALIGN(uv_meta_scanlines, 16);
> -		layout->plane_size[3] = MSM_MEDIA_ALIGN(layout->plane_pitch[3] *
> +		uv_meta_scanlines = DIV_ROUND_UP((fb->height+1)>>1, y_tile_height);
> +		uv_meta_scanlines = round_up(uv_meta_scanlines, 16);
> +		layout->plane_size[3] = round_up(layout->plane_pitch[3] *
>   			uv_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
>   	} else {
>   		unsigned int rgb_scanlines, rgb_meta_scanlines, rgb_meta_stride;
>   
> -		layout->plane_pitch[0] = MSM_MEDIA_ALIGN(fb->width * fmt->bpp, 256);
> -		rgb_scanlines = MSM_MEDIA_ALIGN(fb->height, 16);
> -		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
> +		layout->plane_pitch[0] = round_up(fb->width * fmt->bpp, 256);
> +		rgb_scanlines = round_up(fb->height, 16);
> +		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
>   			rgb_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
>   
>   		if (!meta)
> @@ -139,13 +129,13 @@ static int _dpu_format_populate_plane_sizes_ubwc(
>   		/* uAPI leaves plane[1] empty and plane[2] as meta */
>   		layout->num_planes += 1;
>   
> -		rgb_meta_stride = MSM_MEDIA_ROUNDUP(fb->width, 16);
> -		layout->plane_pitch[2] = MSM_MEDIA_ALIGN(rgb_meta_stride, 64);
> +		rgb_meta_stride = DIV_ROUND_UP(fb->width, 16);
> +		layout->plane_pitch[2] = round_up(rgb_meta_stride, 64);
>   
> -		rgb_meta_scanlines = MSM_MEDIA_ROUNDUP(fb->height, 4);
> -		rgb_meta_scanlines = MSM_MEDIA_ALIGN(rgb_meta_scanlines, 16);
> +		rgb_meta_scanlines = DIV_ROUND_UP(fb->height, 4);
> +		rgb_meta_scanlines = round_up(rgb_meta_scanlines, 16);
>   
> -		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
> +		layout->plane_size[2] = round_up(layout->plane_pitch[2] *
>   			rgb_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
>   	}
>   
> 


