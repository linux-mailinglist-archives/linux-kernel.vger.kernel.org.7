Return-Path: <linux-kernel+bounces-820914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78288B7FD82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7019B653DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3193195EE;
	Wed, 17 Sep 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvCsbNmu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A8316192
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117354; cv=none; b=KWAALSKWJjAtVaFdADYk7rP+7q9v0xDp+VTjzHIKdkYlcymFrJRKnLMnkoTp7sL5JCcaK9Vp3UNjS4CFWmhr6NccBosqdNHddhgKYMyoDzoWZY8QBTrq+lqK72cLd40+lxL4dwvFjCNuAuN+SFX4XzCkweiyr/5XmqS4qiiE01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117354; c=relaxed/simple;
	bh=Tj5IRr8dZhfPx4G5+Ksw7UHLStIl5ZsYWyj89gWM/q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJBuMitHDHmECROaOkSZxqyJsXwSYfEyRkibUDl/asHjbONEP97ACGDgTX7WTjZmswAAe6xVL7BNcpqhVzW5O47DJVMz5YXl2GzBG+oIqmp/JMgyngfD6GTkg4rVN2VLJNpOtdoSbJUiePBJjRLCEb+v36oAErMm2Dm8w5nfwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvCsbNmu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBL8Lu027124
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyOu/IgQxlzd+MJPmzHUqm4oYw2lGlbtcll2m2ciyrw=; b=hvCsbNmuAqrlPNhp
	lxhiZy4pc8xbrPoaUom1SOhBfTxOvZUFOkKWvDALNbAcqpiaGll96NKSU4NoMCLc
	viTPxCQayKYUoFseZnF1skSW4PCI/xEM6hrAT037boRGRky4JCYCAFA4rlArjOYN
	hzc4BaSGSidu6LoAhKJqBRjky5syu4GTYk9C9tVyTbFAGj4ebfN1HqykG5WsZJVo
	xtJ/N9Yx2toiumTpa+0ZMNTUzy3yuIBCLKy54ktvb8c1mazJT1Y6N5gU7+m3ZcBK
	jc9gmo5DpYFtwcgJ25qd8jzkM/w1oPhz8oTVnMEoZY0fpmKdVC3PZFS9vFKYAYLS
	znx6Pg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1j8f8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:55:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b79aa110d7so7786081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117351; x=1758722151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyOu/IgQxlzd+MJPmzHUqm4oYw2lGlbtcll2m2ciyrw=;
        b=pGH3A5SXsix9EZ+uriqvvmxB8cqsgHAwRL3rwmM9W/egTSpP3ItFvXRR/aw9kVm4jQ
         SwcTuBnXkLYI4tToNkd4w7l6v7RFoHHS41TfKUxaOp0KuxZEY2ThSvv7lMowaJiy4SsO
         nJWGuzeHEvJqSPzZhO1iHs9R765W/AKEbs8Njb2C8dX/+gXGPY7tjmhf8We4pC1w4+aw
         BLcXmJwSMQOSrB3/TOWGDvZhXyUNjjNvHaaNIHHicvH8hDb6/WXpCPPXJ/dnBooSqq1J
         8UG4HbyJvvZZ1GdbKfu40S2GEIpsYpXvTroUwPfMPwRd8+CtuGhreiSdwxLM3FkhsX7T
         byxA==
X-Forwarded-Encrypted: i=1; AJvYcCWCoRnTISpJd6Y4+IhmUfLrqDd87ufjjofk4Zl592YbH1INji0IqZKpQWBV3AbzbnSOzRA1aNFlVv6hJTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUT7McETJTuXU1nkultXfgCCjQfHNrw67FWPW6xoy9UUkh7OOQ
	UE/IugqmO/VR9OrYSUbEYSsSsgGItDfibWYkc6IlMVGxSiqCzPiwIdkUDS8t6VuWEhjw/fAGTrc
	ClBq46vnf0myx1ut3JzWbEox7e57Z4ilvskWBeLYpV3OdgEaP3QNWN+RJHD2ciy5M5iQ=
X-Gm-Gg: ASbGncu/lvIfDEtvpaQyNQInuQTO9uhwYQywAnd3DM7ogS6GDjM9Elus3Y/roLkfre7
	XcVi4dVlpvHTk/VvX5WqnTy1vnBHzFMqTXDjMu33ef9p5fjc2uVdfeMic1EcCxSnRDqpmPOWSqo
	ntY9G62aSX2/Cok170P4ySQB4cBHSnDZVlOcwiVe8sUbYNEDfeGiGWNZja+VpHmpXclphVy1uVO
	vUfUp9WStkyMGaBkQKC2bpr+xNyQzpdXDBDL9MRn1nZbsQAuxPw56Vgq8KitG4DNyau0gpvNJeX
	gQ7AIXRDlvdEg+7WuHC9NOIPZflH9f9Y0ml19BXU5I8vurhyP9HnuotNPBVZ37lEtvNDc0Tl8S2
	tZJZZ4xiUALnq86fcGMPzSQ==
X-Received: by 2002:a05:622a:60b:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4ba6a201929mr16253321cf.8.1758117350869;
        Wed, 17 Sep 2025 06:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuAkJKWASjeOGY3tbVDkX/9cmGlK5vVb9DF+pq6ckhMvxJU8lzoAoODEO2pS4jjECiv164QA==
X-Received: by 2002:a05:622a:60b:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4ba6a201929mr16252971cf.8.1758117350275;
        Wed, 17 Sep 2025 06:55:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347a2dsm1365863966b.98.2025.09.17.06.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:55:49 -0700 (PDT)
Message-ID: <acb4f8a2-ff08-4a90-a7ad-7b25a7f4b6b0@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:55:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] arm64: dts: qcom: sdm845-lg-common: Add
 bootloader-compatible board and MSM IDs
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-11-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-11-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: heAV9PvrJGkL5ClpxwNo2stCdCJRwPkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX4utp1LxPIcNb
 n0teEWl/dLRuZhmH1csAf5XtuDo7OxKh7T7GdLAi26Y0XR8mojfWmlrHOc+iWkkkrQZup9aeyB4
 9m9mTIiamK4l9lqGH//c4Rt54F86Xj123PSMYuDFLUiylISrUzpAkos7gjaYxL/myAYTooyIVVg
 1hM7vhERStNCFH8bHNsHsrjADGQt/LJh3t20/yVS5PXCZ4KSfd/RpX0B8Yzvzt93Gpcul/EvWDa
 t8bqIXZhJeTZisrLyErH+ktcxtZtBWR+kfZddDnNXRZX2lTnptPZFHInjD63femC9taHsCE4HGt
 LH3vqgJgyJnuwcyrQ6d2Cr1MDRsPylpkexRbZmpx3pTzVkDOohBtz0qLbVt+nI1/ntwtDnGvkKA
 FtaWa0+T
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cabde7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=ChqMgnJmBaQzFjhIqwQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: heAV9PvrJGkL5ClpxwNo2stCdCJRwPkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On 9/17/25 3:09 AM, Paul Sajna wrote:
> The original bootloader (fastboot) requires board and MSM IDs in order
> to boot the kernel, so these have been added. When re-using the same
> files to chainload U-Boot, these compatibles are also needed to ensure
> proper booting.
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 1baec758c7d881026bf6001a0a305687d7a14b40..a513cd931b3a984443183ee4e8df7b0e45732630 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2022, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <dt-bindings/arm/qcom,ids.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> @@ -29,6 +30,7 @@
>  
>  / {
>  	chassis-type = "handset";
> +	qcom,msm-id = <QCOM_ID_SDM845 0x20001>;
>  
>  	aliases {
>  		serial0 = &uart9;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index 8c1692f86e6ceea7b718361965e78f95d39373bb..beb1372dc6c17f5f06c2044412ee1c8165858cd1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -12,6 +12,7 @@
>  / {
>  	model = "LG G7 ThinQ";
>  	compatible = "lg,judyln", "qcom,sdm845";
> +	qcom,board-id = <0x020C0008 0>;

This is almost QCOM_BOARD_ID(MTP, 12, 0), except for the odd BIT(25)
which the dt-binding promises should be left unused..

+Stephan maybe you know more?

Konrad

