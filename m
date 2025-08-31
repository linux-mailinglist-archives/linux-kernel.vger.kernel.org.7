Return-Path: <linux-kernel+bounces-793317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C4B3D1D0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B167A593E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D93E23ABA9;
	Sun, 31 Aug 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ni1a+nfF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882DC1990D9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634707; cv=none; b=bm9mV5tmrQw2KgX6ywB2oFthuoEbDBAWHyG5ZApDXpL4Xi8H+HF928Rdg4J/ccHatIIar/NNBOCCO6xcoyiv3HlMZnkC1iFi9Nr5AqYG5kjgXksPntAng4P2Dq3nCLQz7y/DZQ7Ha/dp6Tcp8pltizde2YGsc/7ygs7Bvni7t3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634707; c=relaxed/simple;
	bh=qgZOJ23E7GKrRrkmvhIvbpHwFEbyncXhUWLXTsvOz7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAHNk328EtL3kQwYFVSAkeTB7pmYGdpKiXD0LVOy7Dcxp3xB/PFPNw51rboNhD0Uu+b38jW8enFxAYK4Ih+mvuLY0Vs5vhEHGZbnHbh3oftbCHF6BYkUXFcR4nu3l96ddRROr9d0l8calh8Edpiv67lOvQmVm6s8JyXWVamOeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ni1a+nfF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V7U21T015923
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WtmVK7p/SotPayBLtQrG1bWg
	qezjRJbwZ0ptisq/x4g=; b=ni1a+nfFBepFZIUGTSVLat6LgmRUrjZdFjbzB7fL
	TCcZLbzXWz/J8sSwjtc4VqCUG2/yHcV9oYX5Xz6gZ21Ouw1BXyzfWMMpbtHhlaZz
	mojI06occsqeRs5L2TQDU/xlDDbuCZcZcS5YLFu0V6TGvNFmM6UooS291/2pi51X
	f2Xiak/bHNEV8OPO8bYUl4AiYB+zNmxj76aBWhkiduz38qvQWysgeBco/Sff0aFE
	J8pg0ylTrC9DccUS3nDzZPWSGzk72/CBropCQdd0jzhS2TRrVUMGR7b4mocRgHbJ
	dfPrfcPnn8IdH57tBMQAbAs/RRDD3IOb6IBVcsdliTMsgA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp22qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:05:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2ecb8e64bso43499341cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756634704; x=1757239504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtmVK7p/SotPayBLtQrG1bWgqezjRJbwZ0ptisq/x4g=;
        b=wBqIxxuO36yRuJuOpSJ2CzuG07dfXBXw4nVGHI10XsHWQfMFN48frdjs1+3gThB+Hu
         2dLUqB6FpAi227JWYKaSgWTJwzEP9jOByIAqkNfYOJZ4KuoNmFxoh+fu6A0PMoBOXj0X
         laTQ0ji9gl/NAFW5DbXEaIPKyEDrZ/DatPwtJjrxbb8zSz3SAT1bto1Ihwcu5tbILnVk
         JuiDgG/tF2ntK5zzIQB/Er7w5IDYboyFIqTyK9SEKFRUDZceeen3UC7ZSIyMyT7fANqT
         kPQBw6JvAbO2rh9uO3kVqv+AMAWDkMLMksEyXGagMzq3fpsLbwoqxRHExoJVpeHNV74C
         8tyw==
X-Forwarded-Encrypted: i=1; AJvYcCVWL3hnOp0HQ45vYN59UZym5mVTCFTr7B64p34H0gsS77FTAZH5zoG4RnSpAuXPAnaXn/SycAF1wWekKGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5PYQOaJ4KdD04WAtOu5vhd85AdfkyJ2C57CGll6j/z2PKhUE
	7pLr599+zXO8XXWNbIh3QHS0WkIVMxnYaObTt7y2u+nCV7ASvIwZ1fb0d0iGKx0gAwGIwwT+73m
	vV4ZzVPrtcokUDvrPRpYsunuGG8oLzToMv9RwYwn+xIE147FDH5xzZRHKJoxCtyW8LPf6ndL1BB
	JEsAdi
X-Gm-Gg: ASbGnct9JfsRhzv1v9IVAes9JtnNcBDRA1VgesV066LgnLa/SFjoyLZBm1XlAOXCdqC
	X7NsrcHR8O9DFpt1FmgVBEuGHKvMVa50PxDw4weRr2hXkU6XcQ2mWiz9m1WcJhV822POuHurSCf
	KNoBCzrSqLUsmsQoIZI48MIe9Ajw77Y4P000jMf47PE/t8PHaGretwI6m13WDJCA8/v4pgddVR4
	xcsyYMWzZ2+1Lr3+kySZRw2JIQgE9dQ+r4ctr3dAnJmEuTpLoXyDy2C3vFfDIn77W0cPCkIvNXd
	3oyhMMY9LPPuGvtzQ0KK6ptxDopFq3+m4Y7kv228J8MLgPQLzrVgPiZU4iGTkezC+XEJ+o0RhV+
	xKaDDu6camUyN7ekFdjwmwi48Ozt8ZOLbEHgw8Q91Sv5MEc8L8RU1
X-Received: by 2002:a05:622a:259a:b0:4b2:ed82:29d5 with SMTP id d75a77b69052e-4b31d8526bcmr50235291cf.33.1756634704038;
        Sun, 31 Aug 2025 03:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb2lKo0iJNscirT3bEFWvA/JJp5w1yC0Ywe+zyzyU6LqWGRFeZc7bNUVhMX/eTELojDizGSg==
X-Received: by 2002:a05:622a:259a:b0:4b2:ed82:29d5 with SMTP id d75a77b69052e-4b31d8526bcmr50234921cf.33.1756634703397;
        Sun, 31 Aug 2025 03:05:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6770d9a8sm2101064e87.40.2025.08.31.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:05:02 -0700 (PDT)
Date: Sun, 31 Aug 2025 13:05:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: add mfd/max77705 definitions
Message-ID: <4atqwegfaq5ivrd6oypsfev3xpgfjhqw3hooxh4mit3fl23rtq@a5vbqtts46vv>
References: <20250831-starqltechn-correct_max77705_nodes-v1-0-5f2af9d13dad@gmail.com>
 <20250831-starqltechn-correct_max77705_nodes-v1-1-5f2af9d13dad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831-starqltechn-correct_max77705_nodes-v1-1-5f2af9d13dad@gmail.com>
X-Proofpoint-GUID: YzvetcZinnmUnbeTBZKqnTG_KOI6WJy2
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b41e51 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=pNwjqshDI-g99FjbY1cA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: YzvetcZinnmUnbeTBZKqnTG_KOI6WJy2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX7rVMDwTgpFXf
 mzBItxqML9Xm7Jpvn1cH1fo/FoKwtRYge2wE3GJR7+V3J2U4mQ/4+kn1kpdMHzLMjdbOimiSj5Y
 +m+R/NgeAYSgKEaNmjvCI2kYzqJwoBFf0bso8GiJDAK9UJIgFU/qLmF3EklM3FoKYBca2c7AxU0
 pnkvtMUW7l5SlQ1jUWG/N5iECR6W32+Vg4Q0HPHx9YjtFPZo9XOTothCuFw6e2g09uhJpIOFjwF
 tVZUUN9mVWdrNqDAwqeCmd36dVKcCDaBTvyfPBjD1tVC0ExJgXj4l1TpL4Q3ozJIWGUPNWTwc71
 NAOUjjKqaQu0BQVa27iY9uY+kkEDm4+4aF0uuh8vbNj9B1GsVgwhPiTjEPva182DHiYBSTgoJyh
 jzersPNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-31_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Sun, Aug 31, 2025 at 01:21:21AM +0300, Dzmitry Sankouski wrote:
> Add a dt-bindings include file for max77705 devicetree definition, define
> available irq numbers.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  MAINTAINERS                        |  1 +
>  include/dt-bindings/mfd/max77705.h | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 020d7aa13188..82f500cf3c02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15166,6 +15166,7 @@ F:	drivers/clk/clk-max77686.c
>  F:	drivers/extcon/extcon-max14577.c
>  F:	drivers/extcon/extcon-max77693.c
>  F:	drivers/rtc/rtc-max77686.c
> +F:	include/dt-bindings/mfd/max77705.h
>  F:	include/linux/mfd/max14577*.h
>  F:	include/linux/mfd/max77686*.h
>  F:	include/linux/mfd/max77693*.h
> diff --git a/include/dt-bindings/mfd/max77705.h b/include/dt-bindings/mfd/max77705.h
> new file mode 100644
> index 000000000000..34fcf1642e2d
> --- /dev/null
> +++ b/include/dt-bindings/mfd/max77705.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * DTS binding definitions used for the MAX77705 PMIC.
> + *
> + * Copyright (C) 2025 Dzmitry Sankouski <dsankouski@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_MFD_MAX77705_H
> +#define _DT_BINDINGS_MFD_MAX77705_H
> +
> +#define MAX77705_IRQ_CHG	0
> +#define MAX77705_IRQ_TOP	1
> +#define MAX77705_IRQ_FG		2
> +#define MAX77705_IRQ_USBC	3

There is usually no need to define IRQs as bindings.

> +
> +#endif
> 
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

