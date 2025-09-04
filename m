Return-Path: <linux-kernel+bounces-801803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD1B44A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E51882F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D032EE262;
	Thu,  4 Sep 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndKRIeWU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FC2EB5DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027081; cv=none; b=AmGfa4sFnoe4WtVhP+ZkmFBY/gpGUl5RpT3Qk8gGScO75uPBco3rOHLhSU/57bjSP/0Q+5aZSQ9vET8CnFqz+Q2cIMl8ebUUAKHbpvZHi8U98i94aXpJ6PElt5isrT+pfkmsnrPT6YiogGSvwEIuYkDtV2Xoh49Vv/esJOqZDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027081; c=relaxed/simple;
	bh=CaZoi7xlGTITN03Rjj7zYchtrmw8+uuybVBMH6eekaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi95kqEZmHQfDNNTm7r59aZA8OqMWRI0m6wIf+Yr7YivLvTN78oU5ckqRMMbPNvCaozeRcVjw9tRQT6jZGSTSJ32a/20NoXGNfJsFe+8LRj+8Hy0G75vSblq+ZYzHL3jHOS/tzG3ePk+bVvpcY3HhoA07xdmMmkoclR4lIux4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ndKRIeWU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584HeMmp013631
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 23:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JTGAHvO3dzWq+EoS5uNJA1yAwMH+0tq3Qa7fTg/qeOs=; b=ndKRIeWUxsKm4r9B
	fkR9Vy4opdUjNOAoEUZCVRmZlDZuAKklzixJtOmrH8fKyqYbXmyPWsPHQTY4SUu8
	MT+ksulpUrWVX40qXOYEKmL8Uw65PveiomSAnElpPjGbMaIfpwYpkEQpNB/6usos
	Z5G7xCR+qq/3q4LOhnUrSWMzF2GX8243GvuRAQaRe+UTYI/JohHQaXBWOw92Fazw
	YyeTL8VcvQnIPFKZoNSd8lAw3mJ3sS475UXikkpgQGiiExFkGvH99JKsOCwrdDMF
	ktZxVHPlcAl96ALRYvdQ78+GwROlQzZlxiCbmFg6dM376m/I/KTwlsk7IMzEqw8T
	u0UWyw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyd2ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:04:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-772642f9fa3so2479350b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027078; x=1757631878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTGAHvO3dzWq+EoS5uNJA1yAwMH+0tq3Qa7fTg/qeOs=;
        b=SLJy8tmyBkBqc56PrJub/KxCBgGlMfJ+uY/z0mewGwiFyLImX2L5Pk03Ae2pFm135l
         Au3p3o0KYMOMZE5AmrAbHLS/VgpOYjjj7FKMzjlBIWhv69mY8uqB6lu5Kkj5Y40unyxn
         OsLnuRN6lXRWzDFHGiGlsHvXYcireufxnpPfa7RPFi/WDVrzzKx7OM4HXxi1dEaYvXuj
         mXdgFlwemNDmYv/Wzz8748fohO0t9FTEYdYYnXVHZ4TvEh1lUE/bHvhW9N1dZFFeRjsH
         QM8WYsPzHtfGPsNSRIreyUd5f3bPm8DA548X+e/GlZQ7ANdk744+7eoYMnK8kqoyb9d4
         foyA==
X-Forwarded-Encrypted: i=1; AJvYcCUpozIJ8M7QtacyOLO8eS86dY5i/KqkLqniIn7Dn8v/bH3uwk7swKEDhDud9AnXgUHjo6cedA2g/Z//DYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkWhwxn5FeAX3SFqdQ3dtrSSBRkE7VaINq5VFHCNVwHi0ItuG
	JhfZiBQhMQY/c1PgHm2TC22TsiiHUvrgtLc2XAOqkfXDA7ApNjEhJ0wnD+dwwtxTpXFW3RXjkmr
	CaWyVtb9MRCsnrliufvBYO6d92mrmexsnDCk1KEjHW3Gw8H+rIlblmRVAHoMG5ueTvoI=
X-Gm-Gg: ASbGnctwKWGBAS9Cse3ACVIw/5+DTIFJ8GO+wKygjGquDH+olfTUDGasUWa2Rj4nbGP
	r2+kNeWuzqbN4CzjIzISmOdnMQnGLUQrxoLHqayNzXN380QWiyEpV3D5q1lvFvSfgnt+Aciw09n
	T/lB+/J/2WCMm1D+5m9pjgSqA2ZPmg7z+B2AosbIMtYfsayMMisk2wV5bJIPFo3+enqDVg4hFHV
	HOZ0rVRSmKhHQlcyeKUKH+5ACCij0qmQqwyPSVSUEMWNyIcU69dN8U9xZoO5J+CaOEboIkxLa9V
	X4aCEo4eOUaWQpp3jzHUxIl8jb0oWIWiC7oveKT2yNJX/P02sIEN2Z5EmZu8TOggheO15zlgF2x
	XMiE/zfIh/J9zjDbNGnz2dw==
X-Received: by 2002:a05:6a20:2585:b0:24e:3021:dbca with SMTP id adf61e73a8af0-24e7cc21f79mr1728274637.4.1757027077752;
        Thu, 04 Sep 2025 16:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+iA5dJCDJ6EKl6d9KKQ/arjY5Bfhgn5AoMxnI2wmHjrjJTPiDNbZX78JO/uNCpw5DqrwAAA==
X-Received: by 2002:a05:6a20:2585:b0:24e:3021:dbca with SMTP id adf61e73a8af0-24e7cc21f79mr1728238637.4.1757027077247;
        Thu, 04 Sep 2025 16:04:37 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4edf7ed519sm14309145a12.28.2025.09.04.16.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:04:36 -0700 (PDT)
Message-ID: <7ac0c9f2-754c-4ba3-bde1-fbde9f3aab33@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:04:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] drm/msm/disp: drop PSEUDO_YUV_FMT_LOOSE_TILED
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
 <20250705-dpu-formats-v1-8-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-8-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68ba1b07 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=djW4e6U6kngvZURYzKAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: gMe5BnafchzwXil06pl2bG1WyxE2GYsc
X-Proofpoint-ORIG-GUID: gMe5BnafchzwXil06pl2bG1WyxE2GYsc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX+N+mnW2gH/Oa
 lv8GWPPDH9EozIlMyOOTbVsy1wuNpBFT9ZZpfC5nfVgdVVhFRlJzs924UZQ8qckV/qHUDaFWA8l
 lhsRZzra8FMIHwukhyerP+4Zw0bUkxdVO0WIJfDURsgeqWIsjkE+G52phbzQxBr/5r78dfxnYV7
 vU+xkZ47RpXLrEMkYenvY/B6sU3xU+o8qcRJhretTXQs8LqyPNAAGz4HpWut00ARd8ml7FVrT8k
 tJJqJw999ckyKIB2DvuYb4SXPzP7M8+eSghSbRtIOfonQhzk9f5QNURVh8jpXcYsWYNH03lzzIu
 phqdFKp4MMoS+2nwK726U/6NfbZSXTioR7QDSDECLSbc+kJcSMr8tR4KQpKd9w6DbIV/Cdb6wZ+
 VAQk/cIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> Drop PSEUDO_YUV_FMT_LOOSE_TILED(), the macro is unused.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/mdp_format.c | 20 --------------------
>   1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index 6f5af26d4e2d43414281197bf541e1ea3fe211f5..f949810567d83c5924f9dd127261e7d523921724 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -326,26 +326,6 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
>   	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
>   }
>   
> -#define PSEUDO_YUV_FMT_LOOSE_TILED(fmt, a, r, g, b, e0, e1, chroma,       \
> -flg, fm, np, th)                                                          \
> -{                                                                         \
> -	.pixel_format = DRM_FORMAT_ ## fmt,                               \
> -	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
> -	.alpha_enable = 0,                                                \
> -	.element = { (e0), (e1), 0, 0 },                                  \
> -	.bpc_g_y = g,                                                     \
> -	.bpc_b_cb = b,                                                    \
> -	.bpc_r_cr = r,                                                    \
> -	.bpc_a = a,                                                       \
> -	.chroma_sample = chroma,                                          \
> -	.unpack_count = 2,                                                \
> -	.bpp = 2,                                                         \
> -	.fetch_mode = fm,                                                 \
> -	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | flg,                  \
> -	.num_planes = np,                                                 \
> -	.tile_height = th                                                 \
> -}
> -
>   #define PLANAR_YUV_FMT(fmt, bp, r, g, b, e0, e1, e2, chroma)              \
>   {                                                                         \
>   	.pixel_format = DRM_FORMAT_ ## fmt,                               \
> 


