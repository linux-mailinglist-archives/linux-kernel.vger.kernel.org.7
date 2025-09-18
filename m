Return-Path: <linux-kernel+bounces-801805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C600B44A26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C51CC05BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076C2EE26E;
	Thu,  4 Sep 2025 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYqMwgio"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F525742C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027176; cv=none; b=RHpN7qEEi8988SEdvKmqaKtkYFVh90qQObBRNTVkExpGoe+pnR9Uvx6g6LKi2soSDc24Jvwk2mM35qU78Z/hKvqJQSq28ZsdRiRXhD9UpylXVGcqVKpC9YDPy3RS0o9WdwW+1U//XyCH9+CfojGv09u7dBStQWth0J++0pU0Xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027176; c=relaxed/simple;
	bh=lWPuFAByrtxQ2WSWx7LlpVspruPjfhqk54g4S3fDvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQamErohahT1Zw7/wknajnrnrpNS++kqNDw+5onKJK6b5ftMatWe/1YIkRHaqCXJU8Shrh8F5JZjr5y1i0tWuBQgpteRgjUhCPe8Yzg1qsix3A4BCVQ2BbWWGcuYwzH6mZp6oKHrGM0JFmetJam6g7Jwghd9RWhghRnbODFzksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EYqMwgio; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584ISc8T012208
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 23:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2BBqhUruX490OCtbVD9cWmg1K80ZzKKNurd2FslWoTo=; b=EYqMwgio38pAPk2q
	hPjE816685J0Aia1yPn4/2c0EtWPBOKhXi9oEP9dNrZlUaL6+WAX3UTxVqh3uRK8
	2K9OnUkVdUo4I4LSGRW8d7yeI8whByjPwnJ1ys01dwJiIX0i2x2vMsBJT+7xWlif
	ciOtZDeeZ3bI0uWaYiZ+6wzTU5r1GHC9eYUGkCk+8EZQyRTP0jEoXLdZ84Hn09PO
	tcCWG9/wigFRL1suR4xyFt7gP3lZ7azJxwFpFjgYL15yIzk6VfZeORQ8j8KZgh9Y
	RywsafUdpPsV3qLNhfRHiTBEuQJT01kvwyPp8LD0RCp0Q3Fuzp3NC51g0OrRZ6rF
	svffMw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj5jew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:06:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77250c660d3so1680314b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027173; x=1757631973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BBqhUruX490OCtbVD9cWmg1K80ZzKKNurd2FslWoTo=;
        b=JX4hojO28pj0uUoEJdSOIlSkk+0hApNShe6GfZ+87xMY3Mv5JPrdlSWQpnOSvYJzzE
         skfaws+niludRM5b3v2WSqa18MCXRlLznKbsjW321LR3J9FsLDAEBshalPerPmxrmDEJ
         VmXZ133vehRvAo1fvXyTk0sM/Dsy94myFjbC9bfI7Qe44o8LXOTaCZkiqN6yd0bJ/Txk
         N0LGtOmYY2u+Z8zYCYYO78KFGjsTHuZPXi31evCWyZcOkDrkNf4pbNm4+MbD1DSqX32B
         zvPc/wgcdfiPZEmEG+HSpix+9vjlDJZCp/fZaq/9ETGxEg8dPb9mb9Gj37UedAbWvIur
         5Hng==
X-Forwarded-Encrypted: i=1; AJvYcCXGNnsPCb7NBzSc6CDHEtekScqgf91pFhBjN+/g8aEkUMgI4/+OUyJ93DGEWbRcf2PGt1WWXLQ0YRPBSEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTR/YtGel4+IuG6BEVjyjHVjcXclA8+nTBUhSJ+S3VmRsNljSn
	XpCUndpWD4QqAFMe6fOQqO0EeLrY0+N0SdXq8xVgp9XvzI5DygntEzuFNK3IKmKwLTVFYHcCbtU
	ugawTlGXoyCRnjv9ioHcE93J4XpbnkXdfk6cOUSEXoihXBpCgjHc3tBOMjVjQp1bNLaI=
X-Gm-Gg: ASbGnctDfsfQoXUJtId03RAfrimyM6pJcj1m7NLSyx9vwgroAplMUl1hi4LU1W6xR6f
	lO3gapcPvQe1byCzb230KTqY6lNt1G11lILL659CDKX2wNYOkz7TUjOu4354pZZREWn+WMqSYZb
	tlkR+XOOamMfOVTW4We2Fjz7gSQwXBwIYVO++VL7tA/tS320KBVupB3XrXiThBOSC00FTp5APGp
	+mJk/6OESnRqgz/kb8KMMYDCKRWss8ZxNtU+EhjFbnjNh3SP0MLa4HjZMV8lRE3rvh/V+1zqZT8
	PE9AcCjIzZByvyhKj/vgr1DrLzkcvTtKQFA/xODnZkgyGSKiiwu0eOfl7SxDZsJZkU822zgpu9u
	CaoN/JpaOlJsfNSw35vBPiA==
X-Received: by 2002:a05:6a00:1495:b0:772:3010:82da with SMTP id d2e1a72fcca58-7723e309edcmr21931529b3a.19.1757027173309;
        Thu, 04 Sep 2025 16:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqyuEkRevLhX9mmgJs8Y19O8ZIwAo2K9TlXRGtyI3jWl6oukPdrHQZOctJyIPFTdY0p6AcPg==
X-Received: by 2002:a05:6a00:1495:b0:772:3010:82da with SMTP id d2e1a72fcca58-7723e309edcmr21931500b3a.19.1757027172803;
        Thu, 04 Sep 2025 16:06:12 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77241f08a73sm16290542b3a.29.2025.09.04.16.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:06:12 -0700 (PDT)
Message-ID: <3cb48245-526c-4907-99e6-e79a31cca88c@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:06:12 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXwoOMBqUowY2N
 1njcMPET6e1WnW1Jwtam7/vAWHOLr6iFMlryjpk5Ht4LzmzLMkufrIbg7Z2es5npeEKWeMSdrJS
 l4rh3PVWNEuVC8rxSquXPuZOPFZoQNDloEYpqn5FR/oNHG0GukkxInH5ngBPGpa+EVkgb4P/hje
 JZB249I1EpxxaEGfCg+ZKTUe/XI7TBdPMeO9ekELWBjm3A+0io2LIBgPblAxrkEgvIS2PIv5b4f
 X/nD4/bMFky92RIMt03kWyA/+QEo4uYHp+m4aQYxD3+i72bzrjOz92VZytzapLBcmaNtx7NbEwV
 YO0fr73neFR72dfSXo0lNCBr8b5ewnXqteq9cgFEMtvtmxXobUUtmOgCLrtk5vrsDD9vckuRHqY
 7VLhTmKP
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68ba1b66 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=D8afDwXF6kNTcx-T2tEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 4kEIvcRwsPQ185OBXZAVugUoWhbqdXxP
X-Proofpoint-ORIG-GUID: 4kEIvcRwsPQ185OBXZAVugUoWhbqdXxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117



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


