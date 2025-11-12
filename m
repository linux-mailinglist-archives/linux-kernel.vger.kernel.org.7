Return-Path: <linux-kernel+bounces-897510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42CC53236
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E27621531
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93534253B;
	Wed, 12 Nov 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmgGa4JJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7+cjIY8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED2340A6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959771; cv=none; b=hHMG5gjY7q3dd41e6yP9Z70Hn1nKRpmBtP1zNRCaof2aYXts83ir0uSkfSs9dGM/Rhb0D5nL5oqOQI3LZbzd+IRQKT0x09BevSs6AxFLS2Xs2mycIIR2LUs1pnh4zfSwjCf7C0oENOPuTdQzEFWbd49YfYf7Fxxe56xhlihpzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959771; c=relaxed/simple;
	bh=iD4qsnKznEoOb28KGZ84ux57r68RZ32XkXTT4u90lM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVYKkN/DmdoPo59GXJJ0X1UZamCUl1+y0EvAmv7oVhzHxY9FVqw9tfv2XisFtgaDrObf3xEZzPogyebTsNZI++B8r0wsEX+oo2ln5oVYGWPSNbsfUDC4Y0X6+ihMblKA7mwc4CcyhoaiIduZJXbR9DWCCOAEZMLa6YbYJDyeb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmgGa4JJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7+cjIY8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACE3K4N1271016
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9rRTmxPmVpuHkJ2g/EvFY5Hn
	zt6+vzvauOfhyJ8/hJU=; b=DmgGa4JJWIGDnZ46LPY3gqsLs2QAAzxbY9dixRM6
	KhiJp0ND027Y62a8UoqPWaFEjGM5Me4ptwDlvoZI0WHTREXDhNzCfkBQcE0zw3nP
	17e1UufPzbepL4EpBB/ysTOnH6npHhcSJAVTyfdI8ghlDOY/L2jYUnbjR43YFZtX
	LJEIDYSzUduSqYlbB5wAL9zaPuMi4xCTUXuZ1ZyS2uFY5lNBa19XwjDLmH5BGiEp
	R7PJgLKMdkXzqmzmHv/NioNw/Wz/P9QKSGPQ3JFd27LQ86F425zYsXRoR05zE0yb
	RQfMJgSjydrBBiBWtEhdgxdAVB/hiThMnbcyaL+P28cdzQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acunm066w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:02:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e1cf9aedso25133025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762959768; x=1763564568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rRTmxPmVpuHkJ2g/EvFY5Hnzt6+vzvauOfhyJ8/hJU=;
        b=F7+cjIY8dIaSjF51QmhmedgISsF/g325q/A60CThAmwlpi4+KAfUn4SXsfi6IaNddY
         2gqxo53lKk5HbG7ECGPJUYYBQ8X3LZF2kmZhmY+6HNe5hTBBQByj+cx2fVGxZtYzVY20
         BH1b1XXqdOiWd1ZB3QZSYOAM+4/a/hpZ5++KEaR6e9OdxzmKqHKs8UMO0Bi1T+63oflp
         BRE6llS7V87fR6ozeQfJkJu/KFeYMU2Baq2jqGj7HKmZw1oXWofz8IWxbyJk7RoUujG8
         FU6hq+qhB5q+hfjt3xhZNbfarVDB3jitqc7V3ErbsZSi9Me2aYiN3eGXMPiQnnb7hNRt
         0OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959768; x=1763564568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rRTmxPmVpuHkJ2g/EvFY5Hnzt6+vzvauOfhyJ8/hJU=;
        b=R8hHAO+6uKt/gnuin5CpW1yKaAxQ1xzIeCGs6AkBk6H75EEOi0x77mQME/nCgifS+2
         wI2N7qVFFtpWvc5A/08Je7LREXsreRKZsOqGLl2YJ1zcUmhkjCgGHV3wNfjDrY8sEIJd
         ZOaKnhx/PGxsPQQzw5GTn0EYTPdcKLADbP/W5gytMqbOOW1fyP944nXDgccFxHi2UZBq
         5PWfemq7nafe6J5gt9dEEGcKKcJ8E7okULfQLG5KpU5S8OAPeAyWDEtgRpeqlWihBCSb
         nWwkZKX7WfNlqjM3AC4aGYgyBumMHW/RUUpghdj0oR64cA3KLoiFjp5kwwsTgAxyhL9d
         N/XA==
X-Forwarded-Encrypted: i=1; AJvYcCUUdNK3vEbsZSaq5AUSGDwJy6RcGAViq0GFk4GAdxh+nICvow82HQxipofcx/dwWDqIr1ZXRPtOYV16X+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRapKLW7U/l1eJ3IaEMI+6oS9vqPL+oMs10MQM95qbmQOSMMC0
	DZ/UN3T7pITzfxrOzwBV2eWmLKxKULj05/nFrDsn9DiaS8mSUuexh9me52+M31UMDSTmGd5mEuS
	xMC/nTf23dWhxPFz775PDLMx7C042/cECQ2fQzBuFMA3Xt8gQcR83ybv+MwRRofNO7XQ=
X-Gm-Gg: ASbGncsfOX2CDQUHEqiyD/XyY7c5VTGLGBtZfOd8aN6x4Bz5OjsI7NyKX8fRa+Pg20m
	RlcyqoeDZ9VHn4240bhRsxxPhS7Q5A8dplqCevQOaNZ77XrY8Zy6Uo6+T412MH13jIhtRPGAso7
	oPJLrMmAs2LNgxHn1IBqV7LSf2Wm1dcaDTfTffo84pIWgxdOH560uJKTrvbWpWrq9qOD8j635Mg
	LSJulKORV89Wn6SvunBODhtW2sDKnPe5vQGm9bd+oOMhg9dZWaz/Gvaqi54RGLwWDJsVWpl26tW
	nAP8Xsbo5+GHPBIxIx54bFfhl5PUTU6ABiGivLMOSoLJ+oT5OnK3XOfB6z/lHUlGWI/ZscxToGD
	GYKEIbe8/UzCqzfksdbgfZmf0aM9iTuqjdvbcoHaddMP8O8jXV2WthsFoirWQxIwZlzMUzVv/fS
	VfBB2uitUIz9Lf
X-Received: by 2002:a17:902:fc8f:b0:297:f2d6:17b2 with SMTP id d9443c01a7336-2984edc8fe0mr41002945ad.40.1762959767899;
        Wed, 12 Nov 2025 07:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG52Cu/IxlVXdEs1d7W8EbJc1ChZaCVEpT5U7zLUcnX+dRF/CdNr77aqvhMxDvsYHGz3fMfJA==
X-Received: by 2002:a17:902:fc8f:b0:297:f2d6:17b2 with SMTP id d9443c01a7336-2984edc8fe0mr41001495ad.40.1762959766459;
        Wed, 12 Nov 2025 07:02:46 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594518375f1sm5692754e87.76.2025.11.12.07.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:02:44 -0800 (PST)
Date: Wed, 12 Nov 2025 17:02:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>
Subject: Re: [PATCH 2/2] arm64: configs: Update defconfig for DSI-LVDS bridge
 support
Message-ID: <jgjhjgjchajp5lyn5wgnykqbrhecakywwumy3lsyqybsijuiqx@ridtnd3irslb>
References: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-0-6eab844ec3ac@oss.qualcomm.com>
 <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-2-6eab844ec3ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-2-6eab844ec3ac@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMiBTYWx0ZWRfX4UiMjn/cRPGT
 /J7KRGePupBL+Q+Ax9FoiBLD6W/eYdBpr9OzbBe5hypxUbRbUndo6bEfYiDQ4/YqI16NXhZ2Vjb
 xdikQmjfYF5TK/7PVxdc2eH773o0Fo2LP46614D+8Epszn3OGelReI1GVFInPIinjopGBFFr0aM
 ci1ltbN7rI1vo5/qlOu/SpC0hlXgGntBV4mTEQ/y7mu0qanLavPK8lwHGNShgFg1OALI8VXYIfY
 rWAxB6SEv5v1eYF2kpmy5RQLwRM2jyiexrw69TbP2mPvZikPyK1cUa5d4EzpgKMZGbonpR83LV3
 ObT9g443pMXfB/UHykmqXjOnNc14UExnV6wO594BEdPhKm1PntG7b55nP/ukm2lx/ovhDk0vxUg
 v7Hcato+9L9e6BR7YGs5knlMwB3S+A==
X-Authority-Analysis: v=2.4 cv=aLv9aL9m c=1 sm=1 tr=0 ts=6914a198 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4RWRdER6p9Cvvg2m5vIA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: zwDaEZW45quzYdAYO8DtWz6YVWZbLy7N
X-Proofpoint-GUID: zwDaEZW45quzYdAYO8DtWz6YVWZbLy7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120122

On Wed, Nov 12, 2025 at 08:18:12PM +0530, Gopi Botlagunta wrote:
> Enable LT9211c bridge driver.

Why?

> 
> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 00d15233a72b..1d35af618159 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -959,6 +959,7 @@ CONFIG_DRM_DISPLAY_CONNECTOR=m
>  CONFIG_DRM_FSL_LDB=m
>  CONFIG_DRM_ITE_IT6263=m
>  CONFIG_DRM_LONTIUM_LT8912B=m
> +CONFIG_DRM_LONTIUM_LT9211C=m
>  CONFIG_DRM_LONTIUM_LT9611=m
>  CONFIG_DRM_LONTIUM_LT9611UXC=m
>  CONFIG_DRM_ITE_IT66121=m
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

