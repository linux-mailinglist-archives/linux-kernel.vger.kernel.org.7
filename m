Return-Path: <linux-kernel+bounces-815944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C549B56D47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0823BC802
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDD199949;
	Mon, 15 Sep 2025 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOcuaZRQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D618BC3D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895867; cv=none; b=oFVeCXJBNZB91QaROpg+zPSarjKscvC6q7lv2ppm+zriZWECGL61fIvtkUjfrJtCHJlMeHJBrPlkpC5C3tNHGG9KtiWmhrphjU8yl68aDaFFXxP+7MmyDh9saAshvPwVqx1XVodkIY3WATf1ZAYvgX1gYbgSwhn/CbsbPvyKbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895867; c=relaxed/simple;
	bh=0epiH+ZUeSEq8mP5kNV4sAk3iUKmeY22ZVuiXrAkj2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scoAEEYouVN+HQIxcE1RiYC8xWC7y2IqESiRjgZiT6s6frCJCnDmMYKlpoC9kbGqfIQnxI3ECRSkW5t/Y/u8wTzu7bxKxGs9D741azK+ZFQGAINMF3VSrMf2je6XE+TEoN/XU3Ma/G+87XSZWXAYMZfR4nXUou45eas8XTrdJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOcuaZRQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMq1le011468
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IG+hMnPtyAGIv4I4PIBvRlIW
	ppKBCjAv+yzEIrR7LpU=; b=BOcuaZRQbvACb1eDyTqX7+TOiNJB6GaRmsXyMCo7
	VFge5X4g4USsAayS7xq1d9fR9k/3TPwZKqwaeJ8hojKc7mGc9qnDAlsLHaq7PsjX
	gtjwxpBRlJX/wPJdZaKMm5c7w+F+gxr/hAGf7wG1IPI5X8nUxNE6h6lJNh3+AbKr
	QZLJTuxeRlWMmR47Z+E7scLK/60vGBMRk3uT8g5RbLu8JJ2cpf7XFQn4JsYBgcw+
	trPe3YipB1i4rIrSaVtAbiM4Xycr9CqdZZwN55w/rshaidhY3iITeWpdVmoDbu0Z
	Z5ndkC2G/jOyE8ODP8lBphgZOmkUMnbW2NLUo86xn3mEUg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv32bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:24:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5fb1f057fso52868671cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757895864; x=1758500664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG+hMnPtyAGIv4I4PIBvRlIWppKBCjAv+yzEIrR7LpU=;
        b=gjCArXZ8l65CT7K8Qa3U9OjrKLXEcoBsNI2/CdDT5SGOJe02wfKyoY1Q9qLOsKcS7V
         4gXOX0Oh1bH/X8Y7emzA2/vRKIaUJy1x4OULDPr1PjB2OrLTCXTfK/9TdqrrcD5RRYNV
         QEb+PSs1Ad0zcfngkVL1Tbmx+jDv7VmxQo7hvLJE2tu1/EGDyxUXouwVuR/9nPEf46Gy
         YZXdh98VjpFo3EZx6y2HtpPBArtFiIPnR4WBpYrG7T9mBhD3IWbtRw/9uV+4Ia1DxdMc
         vIIVGdMyU2omb/KhcF2VlgPyDuaz1/hSvanGJOFgRvAW1ybfmq9gWIbkhFMYKD5ChybJ
         KSww==
X-Forwarded-Encrypted: i=1; AJvYcCWrt+1rL2eYQ0J/ji/WqxB+KUBZ6Z27PlA7a9g8IIwL7tKgs/gSZVjuk9cLmnseNbReZYMCWnHU5mq0tAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+N9SL+d/43w7QUONDgkZKaW9kcY0vPWKO1xGLrdb/ybGE4w+u
	aN7uEyKI8TqdM+Zc2V76NHPPwNg2F8Ctp6rLVSM9Ozi6xRxTQsX0bWavjIMWDl7emO6N3QcAGYR
	GLv7XCcuvnGe20LDyuNRvKIWd67WZUEBKxunQ1xvszy3tD7nnOlOJMD++zfVKRxXqG8k=
X-Gm-Gg: ASbGncvRVr7BuOqSLIV3GmRCFOZa1pXkrFfiY5Iotxn5lx24KlDzOSW6U64ps+eZKjm
	YdjsJnBazKSbZW/NTrBsjXrOaPHweqvhnstDiT6k8ghumonT5kk2H9zmQ96XuTIF0t0zhWFmKlA
	ruwJkk8tNS54aBPrEyoLugpu5SFzgY33IvEOI8xvnzaUH7SEKgAVg3U/zZtEiLswuIqR8hQlSqi
	9H4udPoqVmb4s/EO2QudDY4quSF6YeOWd53NWEf+soE/Vc45d/PcagFxPbnFx0q2SIeihSBSj5v
	9rK2shGwQZo8CCrZJtNBYpjEsNkKcpw0sb3yfFTWwZ3aXgHknkGTDgKeX64+w5lx4rqhynYv1hW
	OSjuwqcUNkJImbUHB65QU60ezBZ1TrzxmS9EaCmvy9mzZigM0BIZJ
X-Received: by 2002:a05:622a:17cc:b0:4b5:781c:8831 with SMTP id d75a77b69052e-4b77d0d3eacmr164532211cf.71.1757895864147;
        Sun, 14 Sep 2025 17:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNufp6n5tz6J7IlL87sSDiBq4UKUZByx3l9TL3yWz4Gw+csNkqBiMMNU7vjpQBYjLOd+YYYg==
X-Received: by 2002:a05:622a:17cc:b0:4b5:781c:8831 with SMTP id d75a77b69052e-4b77d0d3eacmr164532021cf.71.1757895863612;
        Sun, 14 Sep 2025 17:24:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571ed15f835sm1871151e87.120.2025.09.14.17.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:24:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:24:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 03/11] arm64: dts: qcom: sdm845-lg-common: Add leds
Message-ID: <k7igqiimspo5a3wogk2yev7ugqrucnfvxkrga6idfiwnuugtdv@nfy6fgk72kfq>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-3-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-3-23b4b7790dce@postmarketos.org>
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c75cb9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=Gbw9aFdXAAAA:8 a=jDiey5z7ze4iCIxy3qgA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: jCi840qUZHKAIoaPgdiOcTUiefaF7JVH
X-Proofpoint-GUID: jCi840qUZHKAIoaPgdiOcTUiefaF7JVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfX8Ik92P6XisJc
 TldLxHHLiKo/KufTLuVpBB7wZhwLNSSikhCJXTT9CMzFtHOWmbD6aX3ac5M82mY3kzR9Vos1lE3
 lZbmi597nmXJhc3FLjwsSolb4xZ1TWHSaHCQK0tgU+kuf0k6YeBJdW0awrmxBvRPl59SA2Sn85N
 GCjmmn2onO16A0j5B9aZBGQdCV3drDthzvkNC1vHOmgV4b2y8UN8rEwzfNIKlg1Gcnldrz/KE3l
 CHyK1a/bzbKv2nYGZy5ef0G0PNV+/u5AkY/tOXqC4tnb/7LTEa7Gj7UNEKArIvuGmQG32VuUWxl
 6BaXAAF6aa12AwBrx4vkGFch8Mlg3EDifeGRV+qOFSgVfW+mqPiJtat5pvs+S3AXHKkrS3gst1t
 M9J/aT5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017

On Sat, Sep 13, 2025 at 04:56:36PM -0700, Paul Sajna wrote:
> Add the multicolor status led in the phone's notch
> 
> Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 1acc418b943443f3ba4f8a8a1cfe2c575da11876..d6129ce03f537f0c8c78c2ae5f39be6146cab7dc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> @@ -603,6 +604,31 @@ vol_up_pin_a: vol-up-active-state {
>  	};
>  };
>  
> +&pmi8998_lpg {
> +	status = "okay";

This should be described as a multi-led. See msm8998-sony-xperia-yoshino
for an example.

> +
> +	led@0 {
> +		label = "blue";
> +		reg = <3>;
> +		color = <LED_COLOR_ID_BLUE>;
> +		default-state = "off";
> +	};
> +
> +	led@1 {
> +		label = "green";
> +		reg = <4>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		default-state = "off";
> +	};
> +
> +	led@2 {
> +		label = "red";
> +		reg = <5>;
> +		color = <LED_COLOR_ID_RED>;
> +		default-state = "off";
> +	};
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

