Return-Path: <linux-kernel+bounces-826994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8722B8FD95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1387AFB0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26282EE27D;
	Mon, 22 Sep 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g00bKmK5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7421C163
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534697; cv=none; b=WS/8bIFdB0QvLUOrYz/jBL0RYXamqsJqF9CbcYoea63sStaGE2v8XZvn0UKCx3reRvMey59Za1Phg+4mfECyYvEo0WIIIrawVR33KHH1aIcicQfsIghiO2ACSTcxxZL8vXL31wiC8tFAoBpKhFGRA3R1Ps5OWlQeCydjef1jXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534697; c=relaxed/simple;
	bh=Wd7MXk7KVvMKiL8QsKVzK7/O3AGc1BJP+qNpHFBkcrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiWVC/65JIo7bfRUhfvXXs5Q12W7c5GHEXAEoBY0dI9Hqt2bcPyhPSvcqwQAmB/mukW8MxCI0bAsZCxccJe1B85dSFzM2r9ODvnoEHsfAhqCt5z7ZCzn+PnLQvpxmuACNIQdi/lagcxaddSjLz3yQ3oL4mT81tPtpJYJr/5+WVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g00bKmK5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8n3Ea018783
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yAF4yxuR/rHPPnaXohNM3mKvMvsG55hvpoK6MrwhJhU=; b=g00bKmK5X+iyT6uJ
	BwwkFrqPb/8fMndkoZlDRAdF5JCjZ2u33EG0dixZvArwSBfHbfVkWdBQ6AEOtLYP
	YneL8oWNwt8gPDS18jhrN8m/90eS5ok+EeizhllVZQlX4r64xYgDqYhJH2o+IgUb
	mgYCMrfnXa+yL7YgU2j+OqQV6HVRxugZBv+KMaUqVTIs2sbHrzIZL1xxUzOZ8dCT
	iGW05FnhuouX8q12uvMTcI2Ewxq17xNWcrLz97qkB3/PbU4yJHwwbex3gS3dnVbW
	COgxkaU3NsY7vfhs4QzzGObrctjQ3y8BlWwliEB5LGi4RiKg9rcDysPry7GuHMXB
	RD0IYQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fc6uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:51:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5e303fe1cso71096521cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534694; x=1759139494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAF4yxuR/rHPPnaXohNM3mKvMvsG55hvpoK6MrwhJhU=;
        b=F3poHfHDfH36xbYcM5Ly0PKZKrwyiGEfhYak3FHj1U3YPW5DZUJF8l4m2Y/zQ5OUAE
         rhx4L7Af33fkejPtpBYXfSWiZqTjQjm6HfM63UcaatPj919hzjwZceYUmspliPx1+1hW
         1DFq8T4Tu2nagPEgs/sK8IOcDAiULdRxExgAouFDdyRdskTBYb+VrUZAbMBvA+DAUZ57
         k4P4zSqHfdo56CLEzzIisLnSSn0kBQ6dA7fsaJex6wh+bSsGl/L47IGVhDyBjt2oVhx4
         RhoDXKM3E/TyG+fkb6QGDkUdzKk6oksdiEiRlnc/ajMKzHN8fL3suDGLqPETgTg9qrAZ
         y9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWgEIgDiNhYOyVN1fF6AwAj6ka14oH6m4tftbSgoWvwdUE+NKUCctebh+iT/AiJzThMyMxtXC+6oaWlVa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsmOeRGqvRhKH/XmvKENkgMNVMny39ODq9oW+FOpeE4bnHcRk
	2maWIkZFiHIe/jFtlZXH0qAZSHSYPhAmgXTSVqn0gebzOAeAhBbkYcaMQCaTcdYfo3koiVw2Z5o
	LTr04W7IYfYLC8IliqAJr4vj8TEEHw5WaOnuOzswrMZykPrF3cJtRX+1hCmTHW3SXgEU=
X-Gm-Gg: ASbGncvIAyWkWM8PH3lciUdWgg4B2T1VcRIYLnVODcsDZ2RxyHhPx8bZQtOuK8Qv4hS
	FkT2uog/CJH4kKHrc3EtcDZoMIlQeQtGLNTVEFgxEv7YhlFiSdSLNSKZF/Jvqp5i1krE0tfnGxI
	B044mue430JXyqqEwAMOcc/RbaOcB+2gdvcE7MNNAyQD+qFiei3ENeeTZbok50pB2Ggrzjg3zYD
	9QGanJbQSq/GnieaVN8OvwegsVMlLCRefmrCNzMOQZGMpa+v/h5pkZbrfgREQnqdD0Gdsz1Pe1T
	30TTB6gEYQ44xypmD7zWDGFiSMhJij/n8UD+IWna5mtcK3rtHdk2O2hU4pr85OXTNdITM+BV2Jw
	nQZvG1XW/w0jnEwRIufny2rm2SqR/PWM7aQCde/gHV5uyxl3I7gu+
X-Received: by 2002:ac8:574e:0:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4c06e3f854amr129598331cf.17.1758534693628;
        Mon, 22 Sep 2025 02:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEojLDIZ5dwkeP8Fy6MbtD8yJ4tYri6Xinj/1tvHaAC1AZVzLBWg33l1NfA/vlFrxCb/mR7WA==
X-Received: by 2002:ac8:574e:0:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4c06e3f854amr129598121cf.17.1758534693106;
        Mon, 22 Sep 2025 02:51:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a8fadb2dsm3183075e87.90.2025.09.22.02.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:51:32 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:51:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-samsung-common: correct
 reserved pins
Message-ID: <aar5oq4xvlbpjmitnwzti5w7gitf7wxdas4bflx6eqh3r6srt7@iccpujd6xc4m>
References: <20250921135623.273662-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250921135623.273662-1-ghatto404@gmail.com>
X-Proofpoint-ORIG-GUID: PexUnM1dLET9LFq_UCworQ00yhy0ykGn
X-Proofpoint-GUID: PexUnM1dLET9LFq_UCworQ00yhy0ykGn
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d11c27 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=jqn0LYlPQ9Sjq9uXwicA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX8f1F8uiCxX6/
 k/p8+ldRq4ryNen7DU6WoWYYgC0pdGbmfIiu1vl9VFcHhkHTT7XxdRiYXZt/A/z9KZv+7Mmc0DX
 gk9bVywAe5jTl1DGIar9M8f9fUD1KzZ5J7OfOiFprrW3yRkXqQL3YudTHWHDxv/YZqMV+GTFSOK
 lBuipZykfRpTZGinACptMHRT+dD32YzKYvamQwx9JQx8QQmojCA+RcF1m7H08wKnCojmo04etsQ
 trLALJLXzjORc6rz4tFL+CBoOlkQX8I1cFWEEHmf9uUdDg2YnNWv0xHkdC5prj2EAgxP5ez2nOM
 lWeCColLdqMgXFskb+Z5vaSL1twBI6ikYvtjGokYg3UWOHpu5vwblTy7/dqSQmy2P5BVc7AVxYr
 qxzf+kbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Sun, Sep 21, 2025 at 01:56:23PM +0000, Eric Gonçalves wrote:
> The S20 series has additional reserved pins for the fingerprint sensor,
> GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> index 96662bf9e527..1680be67e733 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> @@ -159,7 +159,8 @@ &pon_resin {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
> +	gpio-reserved-ranges = <20 4>, /* SPI (Fingerprint scanner) */
> +						   <40 4>; /* I2C (Unused) */

Typically Tab size is 8 spaces, not 4.


Also:

Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")


>  };
>  
>  &usb_1 {
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

