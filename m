Return-Path: <linux-kernel+bounces-895251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5FC4D5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1B31883853
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C294E354701;
	Tue, 11 Nov 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BdKzcTHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6+E4qYg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3A351FB6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859443; cv=none; b=gO/NeZQnItGjI2yG98ddO7TDheOVeX+SPq/ys+J1/amiZnqK4g1pLk5AjTQaXoU2l71wA0yUJF/xk+J8oWgf9+3SBrkYBuvbsfoACjs0r0kBPu06Jeb3VbU35fx2FmGEVILYroqQV5KRZGtb5SnyAsQlxj+JStljGUCjMfxHDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859443; c=relaxed/simple;
	bh=o9XDCEPOsW0pCvBrF5pRJYiZzRgCBxL2IDMOwMA7mHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfJezBSNIk5dkbM3LmT2wkRgWoYlLNnNvA0JDVixZixnMoN0PtG4f/Er7P0BUCLI+Ia5wC2MRPNcVqyax9TfmrpwPtmdAdzE6Z0+23CJ8OjB3+tZZ7FhhHz44Xx1iL41CNWzCBsLk/DktQLkde8RfXsxOWjgTeDZPtiZ+1Bl600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BdKzcTHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6+E4qYg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABA5Oew1001865
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=By6tizRWgXa7/zGKbE684xmY
	l8CoT4gArMCpph0OYeE=; b=BdKzcTHJQ57SWzBhomVLb/45DTgzZz8yKOGuUyu8
	/rMOb0/F3pygSOYfTuPGmIr+EHzAmiaY6nsAMMoE9JY1AvGIabd+0nWGaewjypeD
	I3ri0d8V/syTVucwAR7D6cObgppu0y+0V4XeCjrDz+GIqVCmMHyIlHRJSBMY7IYS
	Z71WDn1j/ioIdjfa/0i2RCuJy17dJSNWwdYTuCmoyTkdGuOyh2JAWRYDaUuJTlmZ
	2hOgFSdMy4Cc/1f/zGue0jU9KeFxz/ATxfTrTELdvC6BerhQP7emh7nE3nv/5d5P
	ZBnnHOXokRgZrzIa56RlbhaGwRC8u58mY9ITau9U/FNg7Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhthddb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:10:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb31eed49so55916141cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762859440; x=1763464240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=By6tizRWgXa7/zGKbE684xmYl8CoT4gArMCpph0OYeE=;
        b=U6+E4qYg74GUaMvaJrhuDvT8hb+5RAxKBPZ9DpCbPH2Bxt99nR4kzwtwjNQUc1fCFP
         mF9qHxOvxR5moOS/Q5K5jZ6Ya6VkenYJmlhiDkj2qArRwAQhTpFULfy42DHcUwHg4cCz
         g0L3LHlKZThPfSRRMkEtnUMstj3Nn+BKIldPbpoK0BjQw+zHwNpaq01YISxDCfV+MBi4
         B28qvAeMBGyInfzsRWXp9Fqwf+ut26ygoZ6kYLveVe2284IPAOQg2AJR13OQb4L+jzIt
         93qz3W8J3XIr9dXyLnqbNnf05dYzmLA59+oggReNmD75ev1iPbH9LSwh8nOx+m+jUg01
         mF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859440; x=1763464240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By6tizRWgXa7/zGKbE684xmYl8CoT4gArMCpph0OYeE=;
        b=bYbczlCnwnnLt945Frr18Vd7k/kxYArT7+FCskHfplQO5wWxRoNYyJy8eKRLPYJ/Oa
         pWhHiWAapJ68HF+QfNu/8tEQKRRSjQxZQLUrxV17V58fyHIDAMvEw/CCfcUv98lbs9wH
         kmX2A82PpPGK1rbJ8dTUSrLcwsbM8/Shs0VbYG30sh2O8G7F/uAk7ScpcclCRq+twds+
         ml5qybvooZhKa02N2Uwfk+LGgYBL6768QGwskvaHyXq/SEVzsv3UqhdezVjW0OWzMxrn
         HIHAtv1e6R4DnH3qdBx7EyUuKMxeVsALpqLDvrlKVR7p7DoQS5j8PlwiWnQDzn6V8/NY
         mXEg==
X-Forwarded-Encrypted: i=1; AJvYcCVFy4l2vS5F0T+cTByzxFCmopFDK3tbUj1p/Tba6/p2tEfh8eRsPsJ4fMc2A6zIibyKunRLl/bAjxAALWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7a7RcTSft14aLvA4fS3W6sMTCYS3932C+42/Kw+voFKIW2Rp
	6mOpTN23cNHXx0DSETT7JW8xxOiJzNF9FycNe5VnLCodYm1fDXDkVXZXacCiqMxX7k1HVwx/RMO
	BjH8qPacJVB9LnjKWtP9JAqWjHlSAGeeGFQIH3VplgAvSh67cMIhAmPLsUDBxl6LUf7U=
X-Gm-Gg: ASbGnctcEptpD/iMD0x5XItcMhcm97hnO0ilaNAOr+IvUqPxFdNMlJweSEhJZJziABW
	ye3W9H1lXKfg5y2EtvAPPvNwJsg1NiIu6RvixuZ64fInty5gMHacQPIoTqwmklXB6f7NVmrWbph
	LWbkNyEdnoXF2fdgXnNCIlwJ+xWQpzL9xMtc1CymYIV+/JWAr8Hevfv08jB+ylTYI7jgrmlEr/t
	0Al+XPIKYCmYr9rgdP0XEEOJ3M/EJC+cr9++17dQBDyWltMlWIlfrTOaVtEuECgtWkzp+sSKgad
	h/nGy2vaVn8+a32aNKV5NNKR/MwOYEQyiMpb8gY7nWBjgPCuP/SOAgaKnb6erT5b4W2AZ3vmF7A
	oEYGX+JQFgsKFXw2QTEqS9qmlz8U9YHL9/vksQD1rag0lDSvKFRjZv2ejTlLXNF6u7zI2dCQ9Hj
	A7CYaDv3vR99k9
X-Received: by 2002:a05:622a:1308:b0:4ec:b599:2879 with SMTP id d75a77b69052e-4eda4fce42emr152358211cf.66.1762859440397;
        Tue, 11 Nov 2025 03:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkaAdyv8nvHiLN6T8nwWW70ZQV7BCDE0W7pF5rUcAFBRWXIKZmLtMzx7CpioSO3o0iF9vwVQ==
X-Received: by 2002:a05:622a:1308:b0:4ec:b599:2879 with SMTP id d75a77b69052e-4eda4fce42emr152357541cf.66.1762859439352;
        Tue, 11 Nov 2025 03:10:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a3a1c38sm4879269e87.85.2025.11.11.03.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:10:38 -0800 (PST)
Date: Tue, 11 Nov 2025 13:10:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sudarshan Shetty <tessolveupstream@gmail.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: Add support to validate direct
 DSI
Message-ID: <uhhe4cyv5c4nlwphbgwl22hhl225gfikqdvzxmltnr2kk4nhmi@7mexlu4oesi3>
References: <20251111104245.3420041-1-tessolveupstream@gmail.com>
 <20251111104245.3420041-2-tessolveupstream@gmail.com>
 <563a0de4-09d6-49f8-90a9-38b72e5c03ce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563a0de4-09d6-49f8-90a9-38b72e5c03ce@kernel.org>
X-Proofpoint-GUID: MHbpaxrlriBMJlsrZWwN3pCqAROSfikS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NyBTYWx0ZWRfX62uKkN9TRlQ+
 lcjh8qhWrOuSPrg2N1FKMRATfWL+Tkum8+pyKizj+e8R+HT8x88nW/CMXONrGbPOH7mVdGDOSVT
 iqLYHrDoCzKj9q7Ylia+8NjA3EDufyKijNIMD6uQ9O+RIyMEXzeB5ukbWOtr0Yw0cg1WNDAXPnm
 TQleWhulauk0SzVViuAwX9KzVjLGF85Tm1iReek79EBqfbHglDKKk+BYmnMg2+EMH5WxY6lnVFo
 sKaElNBOAgqhcsZixnxoHuBiLySh/7iJ7WASNRy0FV+qtoJrXmGaESClFgzIUJ4oYYtK5KlApuE
 6Ed8wi410pjXbyL8QAxqauEm82UR9coiTwfLbzcAZy7NHKqTH8Y6+gTy4jeuxATHqmYXwjvWBuO
 R0+pm+pEFtdeiI2PHCPmPG4dgTud6g==
X-Proofpoint-ORIG-GUID: MHbpaxrlriBMJlsrZWwN3pCqAROSfikS
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=691319b1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=DnFvYW0WoMT7wKI67mAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110087

On Tue, Nov 11, 2025 at 11:49:41AM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2025 11:42, Sudarshan Shetty wrote:
> > Adds device tree support for the Waveshare 10.1-inch
> > MIPI-DSI panel on the QCS615 talos evk platform.
> 
> Why is this a board? Panel is a hat or sort of addon, so overlay, not a
> board.

Don't waste your time. The developer completely ignored review on the
internal mailing list. I don't see a reason to believe that your review
won't get ignored.

> 
> > 
> > Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile          |  1 +
> >  arch/arm64/boot/dts/qcom/talos-evk-dsi.dts | 43 ++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-dsi.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 282d744acd73..d5a3dd98137d 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -306,6 +306,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-dsi.dtb
> >  x1e001de-devkit-el2-dtbs	:= x1e001de-devkit.dtb x1-el2.dtbo
> >  dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb x1e001de-devkit-el2.dtb
> >  x1e78100-lenovo-thinkpad-t14s-el2-dtbs	:= x1e78100-lenovo-thinkpad-t14s.dtb x1-el2.dtbo
> > diff --git a/arch/arm64/boot/dts/qcom/talos-evk-dsi.dts b/arch/arm64/boot/dts/qcom/talos-evk-dsi.dts
> > new file mode 100644
> > index 000000000000..8a6dc8b6bf8f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/talos-evk-dsi.dts
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +/dts-v1/;
> > +
> > +#include "talos-evk-cb.dtsi"
> > +
> > +&i2c1 {
> > +	clock-frequency = <400000>;
> > +
> > +	status = "okay";
> > +
> > +	display_mcu: display-mcu@45 {
> > +		compatible = "waveshare,touchscreen-panel-regulator";
> 
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.
> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

