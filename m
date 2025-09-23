Return-Path: <linux-kernel+bounces-828600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50379B94F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0948F3A5F38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C507F31B11A;
	Tue, 23 Sep 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UATZU/Ep"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692142E92BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615792; cv=none; b=qxrvmyMC8VY6zAkGYRXrg+eezuB2gfQx6hO8LWXH6Cg1ooXQMO3cRa6q6TTzG/+eVyPlhQwa3Cps1WLEfpzEAkIvqDT1CODMhZFh3X+eUpAi34LmWuu/RDgw2Zs7kiN7upOCvtIWuMy/QzBVU818uZuHG44E/CPjrjxS9fUgkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615792; c=relaxed/simple;
	bh=hZL8cMemp35OvsvtLi/PbzQZ983k0IxZK/KFVRezPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRun5AgxzvI2InMRUrXZhOFDAYbB2ksK8zKEAgMlwz8sJxK6hgUXxLtot7VfdhQca9nq05BCqPd1aRFOmcqke9oKNg47xpI0E4j0eddgh4jMqAkAk6ZnTuINmPigtV8GVJ4m4E1f4d51D+v3C9o+a5TlmQ/NlUlrEuRTSprraMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UATZU/Ep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HP1i003116
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lHIoF9YFlreh6iJ8DpMNf8z2
	sMgb4aI7tWDoMnOWm5U=; b=UATZU/EpeZ1vemuj47fpIcgU1Xz+7dQoj49/0Yff
	K+e1VhS8Vyiw0VcCzfOBFYxjlE31+AIkYEAuL15/vh99u9NhznHxefweDKMsC0lB
	mjqUg0l7t/3FNzk05EdCxHD2dA59sV2N3Q/MZ77LMMGtr6AItWHMPJqj/soTWtMS
	kckFZs9rjlcXMzFgUVIcM9wXJEJMisodD/1aqnvnjYduhEuSapKlEbJmN/KtM8uH
	ozbSeFfjFAA8xyaDPVL44BfuaDhtJVE82cARAhzilQfePQUiCLkyQ87bSaTIyW+x
	jguOPuo/QLtBaAB2R9DqN5meit2XqhCJBZhiJQYJ7Ngk1A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0ysnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:23:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e4e07aa39so86601416d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615788; x=1759220588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHIoF9YFlreh6iJ8DpMNf8z2sMgb4aI7tWDoMnOWm5U=;
        b=R+wVBFFyytABrmENeNsI2m2ts37XzMb7psx6xzgGlSITZV3BCPc9suI6DnIR3N16kw
         jxucOX3yaXeZ3QSxMlkwMdsleipRihp1RrEX+3xsfY/SfPh/C4uvIx6kU4+JnWNCAhA4
         XqljTqs9iXbjjxNFF26IVlH8tpCqhOnQAZFHILiUTkJH8OxiYEc3u4tBjUfNqpQ0bMLT
         aOb/V3xU11MJRu2Ha4j/urpe1h+CelpVzp2k7oTLDzFWNO3RM2z6kznxg3v8a1Qkehlj
         5Q8qOE8A6v3lPf/b8NBc4SvWG3ek/JuhQsZQUeNHGwebJEB6zSDxvejNYioOhdWpaPMn
         kTfA==
X-Forwarded-Encrypted: i=1; AJvYcCU2mX3BSPUk0tT9Geagibv97r5P9DGJlcLbI2qIQ5aPJ8jqp3kh+9B+V9JMJEOiUGP82CxVABglsFxE1IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zpfrGt66EezxAshfkjduo7Ss1z3/40qukI/JB2JEZBAu6sKc
	Xi30CYjRu0TlDpEQfv8K/5w3UeYoFg0ZFwLFbkVtznX8fWQx7fzxgRTAvNLsOV0ootxiYpHXOyz
	BR7Q39AXhE1y0agb7aH7vqNh1y/kJiLvetfh3aCqU6m08XTv4GyP7VC+tsNY1BbL8JDo=
X-Gm-Gg: ASbGncsVZgB2ZmCyFsl3RGQtwsXYoKJkjcnvpoGoVFCy/5gSFSLigO+Nv7REOTtXuZN
	uR3H2Dph8KUrGQsImv916l9oiiZ1QcyIsLLwZ4lhR9f8Z2kcBGUzv2iXjyb5zsv3j4tobQwPGpd
	YV7Wcxh606vaojYX/SLZudDnKzWYDBquqq1ivTPd5yBbKVtnYgYiO/92CZHijXSc2/3ElT8o3J0
	v4mCeWHFAbzsoIE9J0HbHCuoJ5ZksfdnJInIDdv4G7IXVlRDp9WXEW7oW0VLTuslN874GiKl74a
	t9Hk+yy9PnrMIoKz3uwHFKK/FsNLKMW5EezcapbBgCalnK+JdM63TbCxgzXyum9NcKNb4mEkrh5
	IN1k/UcJU8/Fb6QHWe18LAj/naZTKHJHh6poURzak7ZhljFwWPxwb
X-Received: by 2002:a05:6214:2a88:b0:786:8f81:42f with SMTP id 6a1803df08f44-7e71133eaabmr18299886d6.39.1758615788362;
        Tue, 23 Sep 2025 01:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTqf6gCEvg93UnurQ8vVB2x/PoLj6l4bFsWeAr6cog3AY0TdhZBUmDyx4Na73stVCrlcsG3A==
X-Received: by 2002:a05:6214:2a88:b0:786:8f81:42f with SMTP id 6a1803df08f44-7e71133eaabmr18299596d6.39.1758615787733;
        Tue, 23 Sep 2025 01:23:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b3528c49dsm2473961e87.134.2025.09.23.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:23:07 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:23:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()
Message-ID: <a5o4iivd7ph4h7hb5mhfwgijob3celkn5l5dci635a7owzga6t@pjmf37gcmai6>
References: <20250923065212.26660-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923065212.26660-1-make24@iscas.ac.cn>
X-Proofpoint-GUID: ZXWLmekHuYaoB-MfoSYPORa1nLsJIRK3
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d258ed cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TWLRxeszWchEVqlQ-2MA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX2+qE/+ET7M/D
 prH9nRFSVQoHZIIx6xcMBPqHC3ra3oNTJDRN/MXOiiaMaODI/ibxA8OMJXkncIxeSGB0Oqapu+T
 VroQPoUf6tOH4OW5FcabYcHRd2cD0BKVmr0FdgdAWTmlqhVwZOKS9XuW8ytSBp6Wbvrv5w1DGh/
 r4NNOhaYM9FE3yJjRlbB24lWFhPJMrqbB6j7a+jyWep7QCtUhGCEVaYflfU0ySNFAICodFAVgQ3
 Rr5+zA3/XUjzOojLq0cU/zyu/nTjgPF2640HVjDaEnMtLWjGYCgFs005YiozELYby5m0ohv8tKV
 XQg1y6ubAnhomG9DU0VZtNqPf1Cy4y49k/J7rl6TmbZptuVyPKFfUcfxZ+6gVqJVJKxECXun7MM
 7e4SZOts
X-Proofpoint-ORIG-GUID: ZXWLmekHuYaoB-MfoSYPORa1nLsJIRK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Tue, Sep 23, 2025 at 02:52:12PM +0800, Ma Ke wrote:
> wcd934x_codec_parse_data() contains a device reference count leak in
> of_slim_get_device() where device_find_child() increases the reference
> count of the device but this reference is not properly decreased in
> the success path. Add put_device() in wcd934x_codec_parse_data() and
> add devm_add_action_or_reset() in the probe function, which ensures
> that the reference count of the device is correctly managed.
> 
> Memory leak in regmap_init_slimbus() as the allocated regmap is not
> released when the device is removed. Using devm_regmap_init_slimbus()
> instead of regmap_init_slimbus() to ensure automatic regmap cleanup on
> device removal.
> 
> Calling path: of_slim_get_device() -> of_find_slim_device() ->
> device_find_child(). As comment of device_find_child() says, 'NOTE:
> you will need to drop the reference with put_device() after use.'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v4:
> - removed the redundant NULL check as put_device() can handle the NULL dev;
> Changes in v3:
> - added a wrapper function due to the warning report from kernel test robot;
> Changes in v2:
> - modified the handling in the success path and fixed the memory leak for regmap as suggestions.
> ---
>  sound/soc/codecs/wcd934x.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

