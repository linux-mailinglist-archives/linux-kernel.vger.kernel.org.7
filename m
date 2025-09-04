Return-Path: <linux-kernel+bounces-801675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758AEB448A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDA5584182
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663D2C08C2;
	Thu,  4 Sep 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdqixAeo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536C2BDC2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021723; cv=none; b=iqGb3Pwb9YorUPMWvkMYlF+R296rXZM0uH5mf8IFnFX+7l/6G1lGCr0PxNgl800tahvTzCgmJEZdyF50pigKmOYKSOPtu7Pdm4KtTDov1AXoxjzmYFODqV1500OrkGEqzA4b7HNQqYIfZs90FGwSyhrR/YzYE97jyvUgd8nKqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021723; c=relaxed/simple;
	bh=p5azPGRp8fKE0V5AF13q31U7ZbgOwVv7U572k0NlXhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFIWoxsc84+lLmg9/NLi11bpgXbqUrDAVpj9rw56cbSsDhvwuDslQkrq44tOP8BC3TrNK+jXPEjgeOROQM2WoLm3IdUnvQzm73/DH7NE2HVEUcay8g/EP1MJuJP3zY2bZMfcLYXwC1MRM3YuGjrlD59rCl9AQFGretIeKApREhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mdqixAeo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IdQrC003771
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 21:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1XSGHjK5H5x+hvh6MnHParrtMNDsdad7xw0PkjMbZ+g=; b=mdqixAeoCJkWbooj
	iV81lDSVcjKJFNLnue60LYvsuNufsVhkyrkaHuZjCQ6xdYNP0O0KXjdv9VSrg0/Y
	2U46AT+05RG7V4DeTZRgeoss2aKXORmiJ4Apy79wl7F1DhF1jUfQLRjU5aiN8+EY
	8iOhu7ngq99teEifZeWsPCbYCe/Ow7tt710HQu6FDbfMfV6htbPCgfNXasAwRtYZ
	OEa4srooUnaggtqJ+z6gYfZHNtB7slNFqhoA2PL2fVx5SYXD6fniBIyhfbIesPX+
	SYYWl3K4zlwSwj0RUJWjJzlu6Q8biP0dNmLR2tUn4FF1+45ELwPLftvheg1mu9Od
	/9Nlsg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s910x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:35:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so2319221a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021715; x=1757626515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XSGHjK5H5x+hvh6MnHParrtMNDsdad7xw0PkjMbZ+g=;
        b=qEoEz8MGHey5JcTZji+W5O6DpL8l98QopDfmlJBMoEU9fDIGbOPHfz0It3i+zp5qP3
         1Dx0rKaQCOtHHCK6AyTPLM0mYJ0fcetH1BYLf93/OpxRWpGn8VFzOWP2P8+r0LIFwxhC
         Gdr7+0MlFzJ2KMEOF/IqfiC7gxXWm2ok2DnVEez/d4kx6zE3pqHrittKsvaYvVwKpsAP
         Uzyey6MJOeNvcDXuzcIEqWdjJhy8WiCn0VTMNx6CeBLEHnCxHt/ReQcD8KA50/eqOAPO
         mGL4COT3S0WG8w9y77k0DG2++/70mIg+SQLvesA+GqC47WOFaMdM9DxEIFncllLcHDoH
         uWnw==
X-Forwarded-Encrypted: i=1; AJvYcCVIdGUZwT1KDMAf7m9UhiLtKQiCtlhq/cladOsH8yeMV70ZqrmdqvZYvheXQQ5qhd2vKXpgRFPmOpyvoIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6kCMUjN4N5Ued0hbZdyiQWRyP9oee3WincnaADiQlkpEEL+Z
	n0pnLW8MwYNzkIVYTa82qasai2DPOGX1uZmZOf42JwrGPS9AUz92aa6xWJFaX4XEqZkIE/otQFI
	QHeG7kFyFG7ccXVZC4wYBx4gQOLnaPzCTyD1qoU8qpxHz63TTVelbjpEFHOvT/qJ8FQg=
X-Gm-Gg: ASbGncvnvj97o7NEl53myiGzCVWirkvMhRiH24jStdmFDKdrJyCBus4G/kaE1Ftuz4y
	R3JIR/NtD1V8xQMm04OEC91H8KLi0AhcvmytSWm42qQvC2a5r7CwHySifuetxvgFetFIkWKfKfN
	ufLUf199shgDa3IiCdHE7eQKDVdyV9r2xaKFee/CB9LoiMl7tuXs5Wi75DKN2+6DLhRUnQjCVWN
	rbJtFlkbKdS1QMnjJJAbTRAXrGzBqIwo2onwrz95GlVnY357t/OzD9YDGAmzjilZeto6anxcphL
	kCvwdpSZVUmACPe2Szr8JxfNTy6Fqnu/yRa+Tx5RuoJ5JwThKP9IMfCxvzsAYs2pOr5WsevySRB
	3AhiTuXm2+petKGNyECooVw==
X-Received: by 2002:a17:903:2383:b0:246:570:2d9a with SMTP id d9443c01a7336-24944b1fc6emr283192345ad.59.1757021714802;
        Thu, 04 Sep 2025 14:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp3igpntYcHLO4XqweUiLyIuxXfhO1KED/bu92vbMqGflTJz2eGcJkzb2pbmcEUuUIo7WMCQ==
X-Received: by 2002:a17:903:2383:b0:246:570:2d9a with SMTP id d9443c01a7336-24944b1fc6emr283191985ad.59.1757021714309;
        Thu, 04 Sep 2025 14:35:14 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd76e157sm22652365ad.107.2025.09.04.14.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 14:35:13 -0700 (PDT)
Message-ID: <c80e6933-8985-4da4-8498-66cedaa87b1f@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 14:35:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] drm/msm/disp: set num_planes and fetch_mode in
 INTERLEAVED_RGB_FMT
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
 <20250705-dpu-formats-v1-2-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-2-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXw5rwMDF4QqqU
 7MPzQU66WoiEbmiwshc3GU+CDYb2Pef+8K9b0eE75fjh4rk16ICQG29IrCTFqa1gYnxZujuBuBk
 1TIVAqBGW+LPLibiRcX0MfrhnIPKvfDaUnpVTf3jW9zHmYCvq1b0He5ljnQBMNYeyZP69j5534R
 LJ9bxKrQ3108fQ8jv6agRcRoAXjy49k0zAscTOxSsq5xTszE5vqXRDcnj3l9Xu7L0V5kosGU+Ms
 zue9IuGCmDlMcBKDShC6V4W8Rsob78a5f6NjpkH8FH51swgexDAk852qZH5Jg+eJRjzhY7dUpoZ
 cim6mrLI+EFHr3EWTV+vIOyoypWe/4fbLpoakyt65CPSA7wDqpnPGyMq1m2Dg1Tbl8qugMw857u
 8vBfiaLg
X-Proofpoint-GUID: Q-2UNoADcMs-poPaVngf1RLtEhDgKoIf
X-Proofpoint-ORIG-GUID: Q-2UNoADcMs-poPaVngf1RLtEhDgKoIf
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68ba0619 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2YQhiLfsl84BKudLmi8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> All interleaved RGB formats use only 1 plane and MDP_FETCH_LINEAR.
> Specify num_planes and fetch_mode directly in the macro and remove
> unused parameters.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/mdp_format.c | 114 ++++++++++++----------------------
>   1 file changed, 39 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index eebedb1a2636e76996cf82847b7d391cb67b0941..26be35572fd2ee7456401aa525cc36025bc52ee4 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -67,7 +67,7 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
>   #define MDP_TILE_HEIGHT_NV12	8
>   
>   #define INTERLEAVED_RGB_FMT(fmt, a, r, g, b, e0, e1, e2, e3, uc, alpha,   \
> -bp, flg, fm, np)                                                          \
> +bp, flg)                                                                  \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
>   	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
> @@ -80,9 +80,9 @@ bp, flg, fm, np)                                                          \
>   	.chroma_sample = CHROMA_FULL,                                     \
>   	.unpack_count = uc,                                               \
>   	.bpp = bp,                                                        \
> -	.fetch_mode = fm,                                                 \
> +	.fetch_mode = MDP_FETCH_LINEAR,                                   \
>   	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
> -	.num_planes = np,                                                 \
> +	.num_planes = 1,                                                  \
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> @@ -228,218 +228,182 @@ static const struct msm_format mdp_formats[] = {
>   	INTERLEAVED_RGB_FMT(ARGB8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(ABGR8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(XBGR8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGBA8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRA8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRX8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(XRGB8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGBX8888,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 4, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGB888,
>   		0, BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
> -		false, 3, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 3, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGR888,
>   		0, BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
> -		false, 3, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 3, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGB565,
>   		0, BPC5, BPC6, BPC5,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGR565,
>   		0, BPC5, BPC6, BPC5,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(ARGB1555,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(ABGR1555,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGBA5551,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRA5551,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(XRGB1555,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(XBGR1555,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGBX5551,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRX5551,
>   		BPC1A, BPC5, BPC5, BPC5,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(ARGB4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(ABGR4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGBA4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRA4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(XRGB4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(XBGR4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(RGBX4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRX4444,
>   		BPC4A, BPC4, BPC4, BPC4,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 2, 0,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 2, 0),
>   
>   	INTERLEAVED_RGB_FMT(BGRA1010102,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(RGBA1010102,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(ABGR2101010,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(ARGB2101010,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		true, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		true, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(XRGB2101010,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(BGRX1010102,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(XBGR2101010,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, MSM_FORMAT_FLAG_DX),
>   
>   	INTERLEAVED_RGB_FMT(RGBX1010102,
>   		BPC8A, BPC8, BPC8, BPC8,
>   		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
> -		false, 4, MSM_FORMAT_FLAG_DX,
> -		MDP_FETCH_LINEAR, 1),
> +		false, 4, MSM_FORMAT_FLAG_DX),
>   
>   	/* --- RGB formats above / YUV formats below this line --- */
>   
> 


