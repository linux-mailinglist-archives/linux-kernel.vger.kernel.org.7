Return-Path: <linux-kernel+bounces-740904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8BB0DAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3829D1C253BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597F28AAE6;
	Tue, 22 Jul 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRZG5+pM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007B154457
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191115; cv=none; b=jjBC43UeWPJwzDwOyfsXggUrE161JaJN8ASNSO6GAdhRKeO0ja1o+Is/XHzRIrw58sbnOEQAn+VSo39T+ANmtHSpxJJbjqQnzlgebdhEzd6XMesH28TTd3wO6Utw3Fyjjbcz/RktKJ1XwHHsmxOMondVTcAeBf0Am47mz/34rJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191115; c=relaxed/simple;
	bh=VAsfLGbYMl2R6CWTaL7KdBFdZDn8/uNx3iewAiXRI/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImAov9DvGR6ks1MAlsXTgea/ZBZw9ieJOvK7tKi/HSSa3Zy0iIBg12/9+se8z/PREV3bIcVn+p1gk8zCcwRgfY6LGINyiJW6+dKKeMQ/CuVUfj9/FIc3m8VJuTZqyFTq2feQETmkE1Cy5ZwBZ1IzUHDHEWpnqbQ4vTXYovcBpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRZG5+pM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCsbMX021550
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/WYV/IpwzlIixikGjcsvi3zZ
	74GtvTpP8nq9H/FHkKg=; b=ZRZG5+pMMQG/exv5HIGHcksPfdI/QuZuiTPG+cMR
	J3hUMfyzApODyi3KcmexgOhbubANojyyjkN/710U2+G8jNJMfa8AW3iZ1p/Sobnn
	ew1D1iNMwdnlCDFEBJXUewe9wg0xci7RkWO2S97OacM/4q2SGF6BA5ixcDhtH0ES
	y1nctE46QRqHDTMLeHyKjkZr1NT5RwGIE3vaY0yzevjwOh3AHCf7gSCx5zSn4EVM
	eazoA+n/AoM+Zw0iMKj5ATVq02Q32o/xvtz5Y3tOcKsW3abkqpvjQqKezNlX0G6F
	DRWSwRMYr8IJV3y9OTdJdZTRv7MRVrLt54VKKuG/JLApjQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1u83mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:31:52 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4241f355a41so1126787b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753191111; x=1753795911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WYV/IpwzlIixikGjcsvi3zZ74GtvTpP8nq9H/FHkKg=;
        b=W4N7OzWxKFuHVOWZfwbjIy7Ac0jWacJJ/I3dH8D8nhIvdHQLh2cZFgk/VfTa735Q9f
         cZ2rZQG8ERZQmKlulzvxyNoDq1wX2yKgdiXDvPPQN3L4SsLDMP+5Yr3qkNj9eJDxADaq
         70PgMsXIAqPZmvu7ZVY/+urY+PX/OBePPodt1LP3SH++xFzkWLLFFguOReV+sGZPuqMO
         Lqic9P0Mx43tGrMPky79zaqdcqhqM3TtblBSu4c6HXSPCh12Yn0Rn/u362dV8BJ2uzB7
         MDTLKX+zEA+2ehfMvr+b8eqISKDTvh5n8YUSQ10UEuTtaT6iPlGkaQyseIswe62ji7Cr
         vdcw==
X-Forwarded-Encrypted: i=1; AJvYcCXmMOU0Y18D8gCrASV8z7doSmekpH2s3t6IpQhW2n51uJtm+DTTTbNvoTSX1mCOz0gi7fzPgVRqp0B9rtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyoQT01mKZPMz6ePVs7ZtsGVlt+lzBRLNGWQ+2MEnjmkWwC4GO
	enBrol+gedimdkg/GmDWaDoh5Nxui7A8m24nXhuEGstdJPH1MqFsnvl7/4mvaHYRk0ITMDwegys
	vNFP8OeF0CE9dDlS+QftUfimxEp9JAxD5iGLEg4aG2hkdSDZ5JX3XnnQO5ffV8VABhG8=
X-Gm-Gg: ASbGncsLazyRCcSmc4QWDV/SdkxPGPP5lk4H0J+lSgGlwlIQhhESMPFkDWvoZP1I3Ff
	Cn/IouLxzazBvph4z/y7FDyQNJT024JP+9fVzIIDkBYSI+QcRYtoO05hE05/E/b59iUixZSXAWN
	m10tKPs1MpXqpGJAAuR/0sh6AGMUeEWhetQYI7pzhkh5/8I5dpXXeDw8c4fLTxdLkNh2daiLwt8
	qWynxZ2kUEnoUk/e6gLojCkrIY1GO1jruUcLdj0g+lDHbIW0DL2RKAXmqoPTD56685yEVGixZpE
	Rku+7W9qYmq5zrp9gJ6xg5UWB9VnaJDMJU7TWXFGe/ujmt+yxDNkmZqTF1c5aWmNqSzcZYawvsa
	yciTDR/kJCoCQbOaMNekLm6081v5efoPktUgQMmbf7FA76TqucjoZ
X-Received: by 2002:a05:6808:2f06:b0:40b:6531:a43d with SMTP id 5614622812f47-424a564a74emr2971611b6e.2.1753191111431;
        Tue, 22 Jul 2025 06:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXXNKpQVAK8wSW1rOSvcuIJ90cBPFt5dTO9JhQF8U4J1q+bkg1PNkAQobLqYbFNvBZLVqrjQ==
X-Received: by 2002:a05:6808:2f06:b0:40b:6531:a43d with SMTP id 5614622812f47-424a564a74emr2971571b6e.2.1753191111029;
        Tue, 22 Jul 2025 06:31:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da2b3dsm1952626e87.183.2025.07.22.06.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:31:50 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:31:48 +0300
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
Subject: Re: [PATCH 04/17] drm/msm/a6xx: Poll additional DRV status
Message-ID: <shq6rnj5qrw52xvtcnu3bbvxuxjuddzajugawcojdyrm74fpp6@abeztbbmtqnr>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=687f92c8 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=c4-AqNUvOhhRGI8Ju6QA:9 a=CjuIK1q_8ugA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExMCBTYWx0ZWRfX3JYPsmnE/x7x
 efllGrg4vLPsLy+nGHPUEb9JVKO7D7yDi7HSzXGJ0p2WDVg10BWvoPubwZnRZ7Jwmo3CLvE4jE0
 IjblcHpHe7l58KGHw8rN70+hYbI3cCak2lxnz+YVN3UIaDwbDQ0KyoemPFFHn0YlLptYctXj7zS
 rU47Jj2XZb4bO2vhcvGLZFQqABF+pnDV00kzXVMEKa8pHTL5GgARvoFqUOHOb0P4zKd4/mpGKfD
 WixVAXNB/3/mn+7fBwCXwejBE+oCZLN8ewXO/SbR/jLOcQ7LxMuRHdqsqXEnjt/SsHLIxeYnBMk
 XkWIVMTP8+/C7asN/64S4ej+t8VLWNfhvIrvFL6UxdPvDjuZg1q18XH8GIUC6JS2kth9F1u9E+k
 ukv1SXQxHw/wqllyng4BRUK20pNjBckPKshJcDQlNdIPYoZgVgGnaY93+y/RzOWMoJ3yESwg
X-Proofpoint-ORIG-GUID: p5c7mhe4hdoYT6rxtqaWZupBZkNIaxo8
X-Proofpoint-GUID: p5c7mhe4hdoYT6rxtqaWZupBZkNIaxo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=973 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220110

On Sun, Jul 20, 2025 at 05:46:05PM +0530, Akhil P Oommen wrote:
> A7XX_GEN2 generation has additional TCS slots. Poll the respective
> DRV status registers before pm suspend.
> 

Fixes?

> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 790ef2f94a0b0cd40433d7edb6a89e4f04408bf5..3bebb6dd7059782ceca29f2efd2acee24d3fc930 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  		val, (val & 1), 100, 10000);
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
> +
> +	if (!adreno_is_a740_family(adreno_gpu))
> +		return;
> +
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 1000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 1000);
>  }
>  
>  /* Force the GMU off in case it isn't responsive */
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

