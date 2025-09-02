Return-Path: <linux-kernel+bounces-796731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B7B40665
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269234E38BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615343054F8;
	Tue,  2 Sep 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idsb4DJV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3EB32F745
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822543; cv=none; b=iVkw2VGgSRYpawSU1lzvrPzhdB7RGoFhtqsm/zuZV3JAP3Jn/JGro68AnEFejF8MmDyJQcHwPLZWSgTJ2wKoEk53KMoFeklL5//FMOtB2UWIsRqs2CK7eKED6bMq4EFJzb49J685T2OvsRMGCG9uNP5wgwW4FTU+W+GFgPN/CP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822543; c=relaxed/simple;
	bh=akGpi+QtTCgfYTofF4Pk4tpeZByYbVJ+RjDKLpVnM6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvcDAXjlp2MmindyxUVkUQD8SDDRq4CIAX0jgBQgxyeb6xSc4iS1EnkM1GIzeJZPLhkKMMeKk1gywzLHZ/Ip92sZsfvTjJZva35PUbLw5BErsbqGRYzfXs9ixUc3Xv/t7/w/kn2k8VS4DUPrHqa5BLvMgbJVxCYMv3IJji5XYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idsb4DJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B5joY012377
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mlie5F52Ht3HYOWTj4ogGL6rzgMYQ/jMzQdCkcJA/LM=; b=idsb4DJVLCwHX/wd
	dLBEgRWQ5XfjnjoPCs7vnuCRGJDdRCLaAbT5T9svXWbSJnjAlyb3/SWGWuOXj3nU
	Qf062q356QCUP7EggKRkCFJpFN80p5bOLKePqvMQ+knYwQUYRK4AOeYvjlNkcp0B
	Mc0bbXRe13v93zHGHvugMaUGyLlbRd+iWqVdOTLObCSNW4oStfcXJFow81/iP6hy
	oTt7Qq42AOjVxo4tLmcNly88otHG5A1q5+jjW/t6ic29337YqqsxkJ8cJ8NkDG21
	ReeAlq5PVBOhG5ubWXO+i1jNO66SVUvqRx9IF/hi/OGahlLGwyFigblyPUyCj8B9
	XN0p8A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2ffyga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:15:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-52ad145c42aso384255137.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822539; x=1757427339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlie5F52Ht3HYOWTj4ogGL6rzgMYQ/jMzQdCkcJA/LM=;
        b=JWBVPGWHUgs/qrKdsCXQmy0076KhnzB3xtxRniBssMRia9XTFmjNtDhoDwMuESU8qb
         5II0P8cAQ4UeMJ20UrBMMak11d6kB/xLmhQhcapw0UuHLZQgCw5BmhdyX0LbmpOmvvZg
         TjPLcV1yQU7Ilr3yfaat4L/Vggot3aU9CSfu1d/2/UH7D5db4EwWclrXTwG8EJ0M7JuG
         Sg/R/qcFm6Jjsq13awiYZFkTbXmqP/VGJn9rF8pPGNb4BVrGw189dh/jKkPFX6dVSX+y
         x17eN0CDzdQbM+hHMzBzdLNUqOdPOvRQLpldT8WJTfKizw3CSx3/gDpdog5Zv115QHl3
         4w+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLbnfApbg5rZQfb3wGf9QVoYDaqqRAEJNeuA3vXL5XafaZEXC0MsmNHsf8o76emN09hCa62+TikwEQ4xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKxT2Q7evWl1S+2Olfo1UqCg/kJXHdJdq3nFuixLimVKyXk2S
	lLWkICkPaj0RlprQmq/JdOg7ssbQSdrsMlkcT7ghB0xOPVwuM3r7iMOUtQpu9lFFaXs0R1lE7lF
	VxsJbWu2mGtGnYVoZ26LTnEIsIGh8aY+sLeOVzaDFqnU5x8uFzYsi8kHBJ6FJ53TLCB4=
X-Gm-Gg: ASbGnctBwn9mPiQ14/6a1wZXXQFx71OzCidgvs0ko9DEzVsAqCG41c/kMnOMfvRZSb3
	kMas8mASiIf48ZQbkWCYNzdVG931nKca6BLzYWDrVTq4sLmp+fRU6aX4PRo5gZxTF/45tVrSOyA
	gOfbxXbCw9YY023NFD0cEJbjWKrWYVH8y77IciNT0naJfr7e3mT6nk446MEX0ZVMfni9oVk2kcG
	heGXP164IWvO0wkztOsUeVahFB+b4/JvLISzG+lcbyzpFMeRjWI1VPbHqN2UcB5ZWgfZ5I40kOZ
	4fDRbj6OzmgF1m/n9rxr1EKINya+afxmK9HrfEfDukaKdrtxYFjXOLnqMddI8pPgb9lGQT6rDZV
	v/P2yTzKv5/wzBuGjTOFRk5vdG8wJZRhB8pERyF8SmIfdtYgaGKGu
X-Received: by 2002:a05:6102:4613:b0:530:f657:c5d with SMTP id ada2fe7eead31-530f666561bmr570538137.20.1756822537106;
        Tue, 02 Sep 2025 07:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNjsqepLP76zUIqTQQBX9Us4UoXPo5VPCLW3VzTnrFgAj+u/0dS6AteoLKyMgNUBFdMU3pqQ==
X-Received: by 2002:a05:6102:4613:b0:530:f657:c5d with SMTP id ada2fe7eead31-530f666561bmr570468137.20.1756822536291;
        Tue, 02 Sep 2025 07:15:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827b1df6sm730194e87.143.2025.09.02.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:15:35 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:15:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org,
        Dang Huynh <danct12@riseup.net>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: Add initial support for MSM8937
Message-ID: <gkkxxd45xclwjs6cp2loj4male7wobeacbshvjasolr4accz64@vux2ou4wa2wa>
References: <20250831-msm8937-v8-0-b7dcd63caaac@mainlining.org>
 <20250831-msm8937-v8-5-b7dcd63caaac@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250831-msm8937-v8-5-b7dcd63caaac@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX/55P/QwgitgG
 m73yyharsTbFvBZzfkk+5CE8/5ZFgGlHIMjvv9X2sn9cKpd7jsHTgrpnsGtU/4h3N5bYqWBjDeT
 WmSCxw8LYrlscvzsUhsdZHYpLL/PorZunooAfZ8zApnxmflvmL4am2xcpamZHBBa4MxFN4zwIHR
 EvxtvmLQeU4SHlOT9o+dKQgzuoqakd9I3BkgvNqHS2Vm7Zy8f4SmzF1heX3YhpBvzY4rcPvmiEt
 lzcozFvkX2jMF2eQa5eAxhDI2Qmhdg++RGd7dSk6KQJlePQjRlhnQZIu1Oa4YFuraqEMa3cB44j
 KhgSJ8E7+tuuhuTes6qaV5ZQyTAgIjliQ6wVaNDANZohHDigUx1Ym9uaMTsMOrZayPF5NPyPjNx
 lt8cMEhp
X-Proofpoint-ORIG-GUID: 7Jgb3Ut9i0gSsFidAx8DQfUotBSYE8Ei
X-Proofpoint-GUID: 7Jgb3Ut9i0gSsFidAx8DQfUotBSYE8Ei
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b6fc0c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=bBqXziUQAAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=9HHfay7fNgEZ8udxRwkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=BjKv_IHbNJvPKzgot4uq:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On Sun, Aug 31, 2025 at 02:29:28PM +0200, Barnabás Czémán wrote:
> From: Dang Huynh <danct12@riseup.net>
> 
> Add initial support for MSM8937 SoC.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8937.dtsi | 2134 +++++++++++++++++++++++++++++++++
>  1 file changed, 2134 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

