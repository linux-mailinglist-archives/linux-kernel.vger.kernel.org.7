Return-Path: <linux-kernel+bounces-819121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C711B59B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41457B6747
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C534320C;
	Tue, 16 Sep 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JL73Uz32"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486B22DFBA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035508; cv=none; b=D5ALWaYkKiLoX6cl1P0F2zopfrGKOvGXf3IqLIyR428GogvMu5iDFmr71U+3Ghyb+A9Meo+WBXqsg90QF6b51sMhV5THwG+7VYYXf/BvFaIdqtfbc7lOV73xyYRAZvvo2OFeND7w+NuMNSQ8n7ZGNuG3j62FBhU97NZZGVWPp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035508; c=relaxed/simple;
	bh=t7UUwd4xgMft90yTMEDkSkQCO8HRauBhf0Zx0laARP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c82f9SdHIFMuw9s1OpDXOEp8ABGQWXDP1MV/VyoR9lmN5lP7WcEqy0DX3W/G5PtNVplrdsRlgKJVesJZBsM8owqf7FnTGwHx2q2qfZ4AU3wmJrLGTwdOPDI5shplb03yw5HGCpSkNbIKCIJMiER16YRKTkGsZkemheIqUsYG3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JL73Uz32; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9xrXd001513
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TNby5qq49hfo4o9k//m3Xyh7
	0OtDv47+M1YG9MtLCxg=; b=JL73Uz322hjo7db1y8VK6MOqpZS/kNSXyhblTxji
	X/8ett4qqsRTgS904srclOUiORO9cUQ6fCNQAdqVvbcsd/FpA1QncRkBfd94o/9A
	ayIVhYJNJflxOOTiId6jWan/mBB5kLQNYuopyYXUUqOWrhXA8sAyxX78F0XvlXJG
	pHHv0lRCGDuOZLzhNvBwVoJrRRHia2ITx3ocbJdXEAH7TxVOXS2Ot2X3WxnxRsKs
	w1eOZm7vGwK6MbzBwazgwh3l3yTmEKfroCsKUCamZGZk1e5bGDicRtqDY167Q7ag
	Hs+kbQDaAo6941gLLkSbxgZDV1ZTBANlxA4/IP/V80SL4Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqq0a1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-544b12e328fso1589869e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035503; x=1758640303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNby5qq49hfo4o9k//m3Xyh70OtDv47+M1YG9MtLCxg=;
        b=ue16sXu+ABpFA10A5Qcooa7SNU1VBMDaP8kGNtG9ilqanSTmOxUmiNkAUOycaxQACJ
         c31evygVNh0/JAvkPFYIAjpCqdAZpkhm2Fan+oPoAO5nft0PkSYVSufQT0P3MFSK255l
         jAiDymifxECDhsWuNYdhSCVL1RRV7rBt3NKtxMxNDPPsEG7DobcyAM3e0UMxXXzSE4Qb
         t+Ln0PyazHINRiaN11+7nmAqU8UjP3/nSooJPY/cK2l9Y8fC37RmMGUaSG07IYfWaVWN
         Cf1ILH1bC5lSoAjLBbAFnEv/hMw+gV6yMJr6izjnhjP9/FhkWXY9xftwKyNztoCfF070
         DY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4byJrfSBlGUtpHu+A0bui6o7fJj3pttE93xycD+Oe10hq5+iR7xmxSG6IAeGZ6ZYpxZ37ZpDakLoXmWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeLUwZJqNPMLBRDJrix4N8E4/4yW9DQcewtg3AwvLgvaicqS4
	DwfHc8+q+4jpp/qWA3+lBBNXZ8wfBP8AWLcBqJSauR9VPiQnHe0BGM0lnyLu6AI+dOFkv8KK7U2
	j9Tc0RnM379JLXX//gTf2TsWZRkPpfYro4ZAft4XfWnsZnt850CksXytzw8OgT25IKVA=
X-Gm-Gg: ASbGncufpCF/qJYb4zFNfyiGTNAQVhoVwFBFWUTxL/T3dy34WFB59+wxvwZHyj5b4Ms
	XRDRh7KUtC2IwriV0UkF6e4Og6z1LcSEoKf3LoNAwkLH79NyuqwpWgZej4RbR2/ur44knYtbDlM
	FIj59BC+gH7zD4AUPfk3Hr5W6CjFlFA9pJwUrCS8mpZQuc+0c5F5sJUDYYAHSt2kXtcOzRIIIAy
	2YkZQRRi9u87mNJBeo6lJqr7Dy9NWWmh2oxVmejjP+WqZU1smtVfcsftcNxa8NFhguALYjqsjDr
	A4T+fl6bWvjUIBWWHbcKN0J+NLQ3PEexJPkMr5mTzgdn8EesCCT0L1KMgbfmnhjhmAaUIanAy4r
	FprBnE/TPyGLfRYuQSnaKEUystVIHTVX2GJDAMmUOC/adACvhogri
X-Received: by 2002:a05:6122:3bcd:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a16b2c285mr4799742e0c.1.1758035503239;
        Tue, 16 Sep 2025 08:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjpODeFy3ymdDzfM3pALWwp0engqNOO0v2fjb8KygHwUWmCU8dovGzcM73w2iuBtRoo/d/ZQ==
X-Received: by 2002:a05:6122:3bcd:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a16b2c285mr4799705e0c.1.1758035502721;
        Tue, 16 Sep 2025 08:11:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35828d19a04sm15474721fa.9.2025.09.16.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:11:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:11:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v6 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <pwnt6obqsyq3o2qzqk5fcydzlhwv7ycmywvdeo5pwhvt6kbw35@ce36yjyo3hp4>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
X-Proofpoint-GUID: hPz3p6iDoUdsCQkj83azdPYEBeFYdWjP
X-Proofpoint-ORIG-GUID: hPz3p6iDoUdsCQkj83azdPYEBeFYdWjP
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c97e31 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lcEb1VsSqg0gz2oZhFQA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX0TCGL1GJz9MW
 qevbCUMpHwOnMiokwG4qPGbnAcFM0BUY2CrN5e7LLprWm28R7ED8eWt/xsJ/u5+udnXa6JKDWRG
 qxzVfOgw617kM2/QUaNm1t6Nz317KJvdHuRpEH891WGZe7sKuaNy7ig0xXe03u95QFAmHsTE7s7
 2whXuT7bE0xBfkmyKZXGbuEBWNvRtQc1KeY4oo292+DjMLKTBFrM7460S/YGG0op7vC92bMXfUt
 SU6T5o2TXJNfelCUBIbdRHdPM9pCie9r0d45hY+Zfn41tq1W//0G+wmLjWtf0IkB1JvNbV7mk9v
 O7ZHGQQLYF6HOq7T2IvgZ3/z3C0W0HbZIHavm9fTxDsntt/5YHwfI8iy12TQj0r51FL+iO9bWg3
 H+zjQLZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Tue, Sep 16, 2025 at 08:29:24PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.
> qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.

Don't rush sending the next iteration until the discussions have been
sorted out.

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

-- 
With best wishes
Dmitry

