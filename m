Return-Path: <linux-kernel+bounces-801822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC428B44A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC775A5674
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7B2F5463;
	Thu,  4 Sep 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9h/gTcS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE828152B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027981; cv=none; b=faMM2/0cx7PPZM2P3OhR1GKOmdYM88ZCSbQUw/Z6PFbi3AZDsgFrGqKdamoMFRZV+rFUskEaqr5DKcFpJ89Qvx8hfipbTt89PPpggex2X1E+wPjTu5amH6QqeOCFfxxO4yJKTvGwv+V2RHTgB0KGf3UjMp+iPQT/IKylbGgpBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027981; c=relaxed/simple;
	bh=lVhVvdSqQdDcgAl6HjJQ2cKMxYAw/vMcMBw5ZAY0S9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gridiyQc9EC2uZwYQFYtMzP7t6O/Sb3+5flzjmr3WiKlgKfZLTEkhhuJHGU/4RPAdJvpJhD5nnXZf2nPk0ycWkKXbI5Egpeie7vU/9PAnG69MKNgtH7vbMVEVn0fwgL+Xt+nNNFQbE/Owl/SspzU3d0cfN3ZltFQYJWf5kOoCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9h/gTcS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JDYuS003803
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 23:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GjXzmroxVc7W3pRobSL6XDJ/1WKmFcemVZ9/sKNXNgc=; b=A9h/gTcSU2NuNCH2
	f1Tc56bfvcRiCZecECQ/zqj7hAH6fNGp4QD2icBNHfp2+t3ZzVJyPwMRiUiG6XEE
	J+iOCoKfSgMMCe+pYlBPcUBEpmH5VNiOzm6S+TjicLprMP3MLh/in+18l0uY/pwW
	OkjB9Tme+J0hlriHHZdl8tCvpQU/x8jJvperowKG/+hOHWz7AVYkvqG7djqo/Ofc
	lCxanKnv2gJI4JobWYoQqw3v8+xgd3nJdDCxbrxLJxE+3ZH5XM2bQ3IMEE8QChwX
	hFng7MS0y5whtaDVEmzhgfdvjCpSn/6hC+Zpvr4WwESeJXzphEibAqhSX/OeHy1G
	8Cm3MA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s97jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:19:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4e1675ba95so1268070a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027979; x=1757632779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjXzmroxVc7W3pRobSL6XDJ/1WKmFcemVZ9/sKNXNgc=;
        b=sGF+GiDYH6tf7MtzodXKLAqfqquGlE0YOE81UGNKzpEENrr+bmdAr+odeULZJCEjgT
         WhgvQvNAvm80Nf71otgZVM0VrKgTJXEeDoUAlkJsoa5bWp6JBGO/oHrW8MZStciWV9ZF
         t4vAXCCIUfoGLprHQUQZkDh/APpoXaJIkGpi17xcupdH//B9CSeK4O/j28e9H7ieDPBD
         qEsDsXHfUgKeE2XOsFAcz6qXhtTE7oJMBLAw7vcCKswD90mXLAAg3XbhXw0WGKFfwxjC
         sFGVx/JWIT44i708zjBAuiKWQYLRZkgedEvOuwdkUTFeXfqV5xKsWmzrakif09nPN/is
         8Pwg==
X-Forwarded-Encrypted: i=1; AJvYcCWU2lL3vVR47mecKvCUnCLHiGBR7nGwtuVcsYIyWSzA8S72/f9AMF27IKa0qpVjjYy3XwusNJVq7acE1DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptFfQYYj8/KE6OJXs1FuORuCykCdj+gDp+e9hr9T3JMuVyeO7
	KZEuOGm7CsjjDLUUID4oYuE/LotzPEE9IBZ1Jq1n3eK5+lAt5S9Ibdr2ZMf6hh5/9HT0Ak8MGnz
	u1OnPxnRnka6dpw7EPur5gMlSkRCslF5i5abK2zileOy/38NGcHJd9epFnzzniOBcDMA=
X-Gm-Gg: ASbGncuF23VS8iMoTYSUnBR/3pO4R9DUuZiqWI7wuitQY4NlNTNAtTz82yvVAIC0V+o
	QVOka9ymn6jvlZnNnfNpoS+9umi0yEE+at0PxU5GRY5nrBlH6eZZluhSitLIB+0/Xsm0RP2J4VL
	FVZo99aHi8K3u0jcsCCR2KC3SWPm2DblBVCMx/2N+huCgeblLE+/ql2NSvspXL+QP95bQdDzPlH
	gILLU49EQD6Ro59iSjuSJK80FF3x8l84lGZC1P3U16Wvkk+J3od3JYtYRWxdR4hFrr055Z0uKI/
	BhD1WNHXcx++UbU/mUYKyWgtIs8DO+a++0iR6SPf5VjgdQfpPUiQsIZypTShM2RrTwWjhVBhkMF
	LZS7z4UMDxyALnhCGxQWNpA==
X-Received: by 2002:a05:6a20:a122:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-24e7d6d06a1mr1953605637.3.1757027978783;
        Thu, 04 Sep 2025 16:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrHCCGVk/XlfrJjM6BYUjkw3Vbu+2UMzqA2nRl5Xh8C+tfH4Qk8it3kQKN3uatJyzD/U8qDA==
X-Received: by 2002:a05:6a20:a122:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-24e7d6d06a1mr1953575637.3.1757027978303;
        Thu, 04 Sep 2025 16:19:38 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b8ba6e145sm3378630a91.22.2025.09.04.16.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:19:37 -0700 (PDT)
Message-ID: <29ae5bb3-092a-48fb-9d47-f23c92ac4616@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:19:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] drm/msm/dpu: drop redundant num_planes assignment
 in _dpu_format_populate_plane_sizes*()
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
 <20250705-dpu-formats-v1-10-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-10-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX4LOUdkzZ264d
 /CAQpmhPJqd0AaJ3u7zTwmd8EyNJe3Zy62t1cKSiuREEovMyVGbcino/ovH9ixE1MaLaYbgSHUR
 ocsAXsfgZL339JDTyhSHueffmgEzSLcntTIjnxJdB+E0i83pSCQkW5CRaIaGJEDR/Vw61mewHrV
 HrYX4FEMph1VhPgUNUlamgXoE5g97mFimOeiuVJfNv+PpWKx5CCO5S1LQsSB5b6hYKUKQ5OwEfQ
 89wNa/XLsySAbp32w9391zrpAAPci4lSzPWx/ZpJowdGl01m/qwYLuQRlYoojxTT9QeNbszC7AI
 JR62R32t2c+XP9NF+4FZ9lDcnPhxXx3P4ZiMJok6FU2r+Vx3yuXrRMFyEshmMJdAZrAQPcqEFp7
 pHy+ffGW
X-Proofpoint-GUID: MUYd-0ifppJ9LNdcVSwYKy8QCuFhy7Wp
X-Proofpoint-ORIG-GUID: MUYd-0ifppJ9LNdcVSwYKy8QCuFhy7Wp
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68ba1e8b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MRz67vdl03j5fkBFI1YA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> Drop redundant layout->num_planes assignments, using the value assigned
> from the formats table. RGB UBWC formats need special handling: they use
> two planes (per the format table), but the uAPI defines plane[1] as
> empty.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> index 195a6b7c4075eef40e7a5d0fee208168421cee35..e1fb7fd3b0b97a38880bc80aec26003d65a3a310 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> @@ -110,7 +110,6 @@ static int _dpu_format_populate_plane_sizes_ubwc(
>   		uint32_t y_meta_scanlines = 0;
>   		uint32_t uv_meta_scanlines = 0;
>   
> -		layout->num_planes = 2;
>   		layout->plane_pitch[0] = VENUS_Y_STRIDE(color, fb->width);
>   		y_sclines = VENUS_Y_SCANLINES(color, fb->height);
>   		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
> @@ -124,7 +123,6 @@ static int _dpu_format_populate_plane_sizes_ubwc(
>   		if (!meta)
>   			return 0;
>   
> -		layout->num_planes += 2;
>   		layout->plane_pitch[2] = VENUS_Y_META_STRIDE(color, fb->width);
>   		y_meta_scanlines = VENUS_Y_META_SCANLINES(color, fb->height);
>   		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
> @@ -138,8 +136,6 @@ static int _dpu_format_populate_plane_sizes_ubwc(
>   	} else {
>   		uint32_t rgb_scanlines, rgb_meta_scanlines;
>   
> -		layout->num_planes = 1;
> -
>   		layout->plane_pitch[0] = VENUS_RGB_STRIDE(color, fb->width);
>   		rgb_scanlines = VENUS_RGB_SCANLINES(color, fb->height);
>   		layout->plane_size[0] = MSM_MEDIA_ALIGN(layout->plane_pitch[0] *
> @@ -148,7 +144,9 @@ static int _dpu_format_populate_plane_sizes_ubwc(
>   		if (!meta)
>   			return 0;
>   
> -		layout->num_planes += 2;
> +		/* uAPI leaves plane[1] empty and plane[2] as meta */
> +		layout->num_planes += 1;
> +
>   		layout->plane_pitch[2] = VENUS_RGB_META_STRIDE(color, fb->width);
>   		rgb_meta_scanlines = VENUS_RGB_META_SCANLINES(color, fb->height);
>   		layout->plane_size[2] = MSM_MEDIA_ALIGN(layout->plane_pitch[2] *
> @@ -167,7 +165,6 @@ static int _dpu_format_populate_plane_sizes_linear(
>   
>   	/* Due to memset above, only need to set planes of interest */
>   	if (fmt->fetch_type == MDP_PLANE_INTERLEAVED) {
> -		layout->num_planes = 1;
>   		layout->plane_size[0] = fb->width * fb->height * fmt->bpp;
>   		layout->plane_pitch[0] = fb->width * fmt->bpp;
>   	} else {
> @@ -194,12 +191,10 @@ static int _dpu_format_populate_plane_sizes_linear(
>   				(fb->height / v_subsample);
>   
>   		if (fmt->fetch_type == MDP_PLANE_PSEUDO_PLANAR) {
> -			layout->num_planes = 2;
>   			layout->plane_size[1] *= 2;
>   			layout->plane_pitch[1] *= 2;
>   		} else {
>   			/* planar */
> -			layout->num_planes = 3;
>   			layout->plane_size[2] = layout->plane_size[1];
>   			layout->plane_pitch[2] = layout->plane_pitch[1];
>   		}
> 


