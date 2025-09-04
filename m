Return-Path: <linux-kernel+bounces-801774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08921B4499C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D723AC94C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956D2EAD16;
	Thu,  4 Sep 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJxRcTlo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70032BD01E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024580; cv=none; b=iqTZMSwp3J0THufov1Hwv0/qrq44ZeF2oMNYFQvLG17U9qq1AFt5j8e1TgLNcFbmQGqEhN3VJPC5ShzzBQfgRBQXBRtOiMHvOGc5X1ztgOfIPPM1qpd6v9RPkQYVahpEwBOm0J8eD+WTEA8IC1zZosw5l8uGPZH7W8Y0qP8QgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024580; c=relaxed/simple;
	bh=E/Pr7xUE9wTYujby8inbtu4jrPt1Vzr3VJaLaFTJiH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb6STSpAomqmpVR1893EDewCwzMHx2v4D9WetfgUGPK19FVENQnWdlSqWCsk9IY7BVnvjzsca3riSptzf/67S5yols3X6LRKa6puGDuwYYQ+G+ZKV8dXQUfEfT9Q1qOSp/QLRqIgBCHIzbnFfVI9KALD068TwoyNAN7uH4AxiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJxRcTlo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JDYrQ003803
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 22:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6BQ9Pk/W7/QRXtSw70pm2qXXKdryxxnOLt/6BC1K9c=; b=mJxRcTloftSiJWaC
	/l20kdxZrp9R0Kem2AeMIFksKtFCi0f7wb7qPg3g4AoQG0QltOxyjOvoltfH58Oi
	DTpQoCG8iVrAJwKw/C7gEPJtjnC7L9/h6ic/fA+G3Wg/98vTKHvSY894NbUbOWKm
	XfBh0xL9JPlul/ArlA3aG6eppHBUsV3cN0TQNK3BZq6HZddk1LSQVOaFggvXagD6
	ZxCvI6RQAXdsIarsL0YJSlNZHwB4ISpluYTMy22Xw0pBWvqvgmOpkU9AzNfKxE6V
	2n/NFhmm1JbnW74ahUUibdtgfZjl7yatJaQZy7ZPDH/sBCWO0Q1fji/pU/G9ijI3
	K8frtw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s947e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:22:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c724d27f8so1008796a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 15:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757024577; x=1757629377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6BQ9Pk/W7/QRXtSw70pm2qXXKdryxxnOLt/6BC1K9c=;
        b=EKaAhSd1GkmNkKYWbhLVJeeeXpI9Oyw9kfdY7r2LSAwxWm2Jvw6h3IZkwtgCmBh1Ru
         64fAERQiOFKCfHAPZylRSN3cvTcwkyQVQ6cyjbh9l1+JXI6IOxeXLquXYXLfggjxAyc+
         mal6/a3vsKAsayO8/KVMyZSqaz1xoyp2E6pL9k8V6sb2XF2xBBatk6nXmfirNeNh1LG0
         zS/qOfd0iXM1cpFmNpso34mnLBA5rW+T3Tpi/cU6MUtbhGGt7MgzpEkGm4C0iTTLZMP0
         qkBWCPDNCQi4Vryw8oVIoHidX9OFj5nAa1AwJLd6e11NTzKt011SWQXV63ZBuqfK2zwW
         E+rA==
X-Forwarded-Encrypted: i=1; AJvYcCV9f3WSyrLrtLdbjaDrHwb1TerDWKGTKvJAZGyVbUuCR3CZoUvPCsxnnJdqTKEg6Uvl0m4IUzoKaybI62c=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRFxswccFo4zulIBJ9GwY6CtcHBuIgGvGctT1kmZ0x3m7VNsA
	jO9tcZDhyWQsn6sBFzuKPLtBPZ8gIepC65gmcbWJoC4FoBXsHgsCXELj9yhcZT5fGd4F9DaN148
	l6wd/kyV9i9ioDOIku6gST2v0OlUp0qQkyHHjHzK6UyfdKZJDVlk7ZFU2gJIWyk1qHcc=
X-Gm-Gg: ASbGncsHu96wiwoOvLdL5vuXROqXTcpIukIxc5iedg9BLZWjd5OHKCPH3fh7Tj0Orvc
	hF7Dm9pcXtZKnDn2BfOCQxJn4DUomZfMx2DVYFFApPpjnDPWfKtu4T/rEvr35X7UA4yADLsmiDJ
	VIzXpAH3NdJS55hqFYRsmUzvDjmpyIprM2NB6MadTArpQTAUOgO481fCaqIgXvNZhDUdvnJFPCA
	cPZ9Aw3v56KlY2hw9UcE4aAAAyrpLHNBPFdgy46TERfCBgj0gzS3IwZ3wnuIjAMmgmBooqZaHl+
	ZtHcaWdgxN/ABFtXKz8TOiyA5UktY+3shNWybkCkgHE/OmYv20tcmPypL2NpU9TAnNXfHmtOX8w
	8r+0tmDxTfXGj0JknqBumqQ==
X-Received: by 2002:a05:6a21:33a4:b0:24e:84c9:e9b3 with SMTP id adf61e73a8af0-24e84c9eb66mr1434637637.23.1757024577019;
        Thu, 04 Sep 2025 15:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXk2IILCRiDCwe85NGpxmu9U8/4IpQp/VXSQsdCKv+Z4yDzlFW4SikH0f683nftipIhLfVHg==
X-Received: by 2002:a05:6a21:33a4:b0:24e:84c9:e9b3 with SMTP id adf61e73a8af0-24e84c9eb66mr1434621637.23.1757024576572;
        Thu, 04 Sep 2025 15:22:56 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f2c990296sm13300475a12.39.2025.09.04.15.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:22:56 -0700 (PDT)
Message-ID: <cd389c5c-b290-47e8-a374-63ad1ae886df@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 15:22:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/msm/disp: pull in common tiled YUV format
 parameters
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
 <20250705-dpu-formats-v1-7-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-7-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3gQeL5ocCl+F
 s7LZUQHJyUA98o5U+9P/e9mQ6aBFTESjVa+iMSM7Fpp2KGryAJL2YvxdWhDBBnBcrw/LZ0CCU8g
 6prZySY3bCv5b2uCguhPegl7XaQ84z+UyxiY4494x+yHKNrPoB9a7ydQ3NQQ+2xZfxhQ9vlZQzh
 8U+dm5kKSUNft/MT3XUVpTAym4nkT+DdjbO4oJKqVFB4dmxgW7Xu7twN2rqf2KSy4F0qUD5i5fK
 g1ZqHHQiNGX/dEMmA8/DBYvWeChH+wdluqXC/1bf8C5tF6gp10mED27ZZe1o2AqbTkPpQRMAFZx
 RJAnSaED7IiCqkqsEGjYyEtySqIROMLH/KiRPNUiOuQRYJico+pLdUDYoV2ck38P9sk3xw3oDxJ
 cVvuOqcp
X-Proofpoint-GUID: hJV5Pt_Zz1MrhIi1r4HJffz0CxCWczAe
X-Proofpoint-ORIG-GUID: hJV5Pt_Zz1MrhIi1r4HJffz0CxCWczAe
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68ba1142 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AtzOqZUtkYz0lm2cLFcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> Pull common params of tiled YUV formats into corresponding macro
> definitions, simplifying format table.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/disp/mdp_format.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index 900b2de252a6eb2eac3d0670f1aaa77f7520fd77..6f5af26d4e2d43414281197bf541e1ea3fe211f5 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -284,8 +284,7 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> -#define PSEUDO_YUV_FMT_TILED(fmt, a, r, g, b, e0, e1, chroma,             \
> -flg, fm, np, th)                                                          \
> +#define PSEUDO_YUV_FMT_TILED(fmt, r, g, b, e0, e1, chroma, flg, th)       \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
> @@ -294,13 +293,15 @@ flg, fm, np, th)                                                          \
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
> +	.fetch_mode = MDP_FETCH_UBWC,                                     \
> +	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
> +		 MSM_FORMAT_FLAG_DX |                                     \

Hi Dmitry,

This sets the DX flag for NV12 when it previously wasn't being set. Did 
you mean for it to be that way?

Thanks,

Jessica Zhang

> +		 MSM_FORMAT_FLAG_COMPRESSED | flg,                        \
> +	.num_planes = 4,                                                  \
>   	.tile_height = th                                                 \
>   }
>   
> @@ -623,19 +624,16 @@ static const struct msm_format mdp_formats_ubwc[] = {
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
>   
>   	PSEUDO_YUV_FMT_TILED(NV12,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C2_R_Cr,
> -		CHROMA_420, MSM_FORMAT_FLAG_YUV |
> -				MSM_FORMAT_FLAG_COMPRESSED,
> -		MDP_FETCH_UBWC, 4, MDP_TILE_HEIGHT_NV12),
> +		CHROMA_420, 0,
> +		MDP_TILE_HEIGHT_NV12),
>   
>   	PSEUDO_YUV_FMT_TILED(P010,
> -		0, BPC8, BPC8, BPC8,
> +		BPC8, BPC8, BPC8,
>   		C1_B_Cb, C2_R_Cr,
> -		CHROMA_420, MSM_FORMAT_FLAG_DX |
> -				MSM_FORMAT_FLAG_YUV |
> -				MSM_FORMAT_FLAG_COMPRESSED,
> -		MDP_FETCH_UBWC, 4, MDP_TILE_HEIGHT_UBWC),
> +		CHROMA_420, MSM_FORMAT_FLAG_DX,
> +		MDP_TILE_HEIGHT_UBWC),
>   };
>   
>   const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format,
> 


