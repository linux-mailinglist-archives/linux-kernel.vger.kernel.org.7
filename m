Return-Path: <linux-kernel+bounces-860702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B4BF0BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D44F2234
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE552F690A;
	Mon, 20 Oct 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0PMpr0g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53552EC55D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958378; cv=none; b=WwQu3uG+apmE7GR3zRMOGrti0xZEOxxDFVO4/OyLleYrfBIpDxGk5gmhDbzCiQOFawlkt2sqEQsxSpbpz2VqJ8rg1+Bw/eBnnebsYgkPa0qFMZItn3FMExc4Y3WfykJlFKuzHQbaTh4pI7UbFeLEr3wMe0rYBgT1hueXWSDFPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958378; c=relaxed/simple;
	bh=XD47O9TRxnWUCcBap4YFeLUUHeVW6Hw0uiOjDC7QDf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgHtAN9TibEJUO+Uj8BJVpGSZlW06ZG4nPfKpdG6PG788nc8O6Mqzm4T7sWi/H1oYi3+7A/7++tyLq2pfmlxO24Y1yHbkbdaA+l9YhmTV3OB4wK45+LkZJnF8osNymt40Z386ZrboLTanZtsEp8ce1nZYPlYg2F/C1hTPiX3+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0PMpr0g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JKK1dP014493
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0BwZA/OA1ZRMqrTJrXUO28pcOEUZxmfCKbigqTbLybU=; b=E0PMpr0gLIIeh0CZ
	B4q4Qm8CUYNqdxQVLzNi+7F+Fmd0XaBLkUWsJdMTgq7oR3n7WcIYV49I/s3eJzPS
	M6ytRZ/5Gb48pV0qbcHFwxzN6bQ7iWi+iPkD877hoKMW4VUsx/TEHSUb8/yaDRrN
	PV3aeVtkQwfUEAj8P7qQsbj6h2O+TYWsl3UqkOJMzLJ212m8IqsQh344wDUFyLaF
	xS4TDquX4potZ59p7KhUY76j72ylI9uywRZ7Yg33dfBdMQTJyu4vwEo9sMc9snwp
	bkYMu3E93J4tlZpZAam+dnMhhomTC8rxPpS/Fx6ul3GSUeyhd+eX0Jd9YA793/kV
	TaAS1g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27hvkwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:06:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88ef355f7a3so1898166185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958375; x=1761563175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BwZA/OA1ZRMqrTJrXUO28pcOEUZxmfCKbigqTbLybU=;
        b=fPCz9F6o+L4XaQCFZ1jGbgS+a4nkJJjd3sSUMwSvHJLuHZ9kRM7FO3OXfPC6s56pbZ
         xzgwynpM/1bafW3Ce5thz6WqZx3dDzf2phze+Im3a7lWUU09M/C+WNgCo6Bf4Vio8JR1
         ON6HZ8B3pkZtXlpFpDTaW4nxE02Z5kcCfS7eaGmw5kojXSWE+wSTezHfxgWf5bbdLYa1
         NaZzeUpoIKdz34+yLmY7PgfKtqHmZHnHvaEDR8cSyzYu+HN5seaC0gmW6AQJaTJ0WDNr
         awamdt6iplG2T2dXP/Y9nyDuUcN5HgZk0BGyDDDhSHzgm2u1tj9oaZPiskVjLty4AR0t
         WxVg==
X-Forwarded-Encrypted: i=1; AJvYcCX/vmqgxJ5JrwD1uAVJDRyG6geOKUMmj41bVBOvA+/SJMeRhT+MGnahln86Fp58tuviHJdKHk0h9wcic+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BHBR9+2vSdXd3QswNK43/mDpjVVoIMKbwBNg9MC/ObVxAl/o
	Plc3nxXevRvUGamfmiSiHxWTaaOWAtfFeqbZv3MMmLLtPQoYXuEudw7ukjeJH7VuKjFWppZSxGo
	z0LDjshww4iNT/TotwZCuQNAwJA5s433YKgv8VhiIab5IEhKk76wXCKuZwSzRVTyxmzI=
X-Gm-Gg: ASbGncs0lnB5ehCJ56aomD5BTI6qUPjywXb3fCDn2H4GhbeQy3JY3joazU7LTQSJTKl
	XJmCWfITJFSDvvm9Gm1vBY/IyLsFLqT9ouQy15r88ee7AHHvOFmB2BRNYxplB1/4jFQfpNtgzFl
	yVBi9s9dheaZoGCQ32FMFeDUNZ7reW2DcjTokYlN1S/UAUPYXCDWjJgXlq4hxmPm5CuecIDWH/8
	jcM14Ihys351v5QOnG1XFHCPcoEh/mhK+TZeCXZ3+lGrop9XViX5jbzXD8OqAvUQ6MwrO49Ga7+
	LL6PQ04mGGuECuM0WOV9GqOXG8zs4GhTwvQhnpFktH69C1bJaAh9xn6are23/GxHrcIhLZwX+bG
	BX3zH7LHKOmiESZdtlXpMYZerp3BaYe/FBU2mVkSyLFp0cORuz0+OfdDlhCwwc3pOlB/S4Szzs/
	hYDpglCEF6RdE=
X-Received: by 2002:ac8:7e94:0:b0:4e7:20d3:ca6a with SMTP id d75a77b69052e-4e89d1fe501mr164424021cf.1.1760958374536;
        Mon, 20 Oct 2025 04:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqN48xKzVO8tsbOssT4BHqejlmeJeQVsIvc+vCF7ac+0u79yDBwEFK00zcEyTRO+XdmrgoVw==
X-Received: by 2002:ac8:7e94:0:b0:4e7:20d3:ca6a with SMTP id d75a77b69052e-4e89d1fe501mr164423621cf.1.1760958373998;
        Mon, 20 Oct 2025 04:06:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deec0b68sm2422752e87.42.2025.10.20.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:06:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:06:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: Move address and
 size cells upwards
Message-ID: <i6uiemrttnnjfcc35xw3ux27g2wih5u4kvn3ore5a76ust6l4n@x7sfe34penlm>
References: <20251020-shift6mq-dt-v1-1-8714087118b8@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020-shift6mq-dt-v1-1-8714087118b8@sigxcpu.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX/DYZOWBEKWhB
 sFV1RoXbJxQfB4O2oaTUNZOU5yybGMXjNQFf4HCxP3QQnJqx8TGJ0c5XP31AWa+Wx4AmmlViEnu
 fshYax9wt9+6uaPQ0Tm+KThKP8cV5+vwOpOGAr3QjWkBiaVG6s+SEoeMRcBkNOKeR8qCaVsDuKX
 YhpVP7EwaCwXpbBmaccCaCt/78D0yARSJXQU3Lk7w9BqcvsJ7vIs9uMYHe4TPeQbBYya4jovg0Y
 VoUhcyytuKC64aplQC+W/o5FtIDJ7/tgjX9tm3NbLi36oJdTKlXZ5NU2rnMCs6ZDcQ5Ty2yoWxg
 +38oXDnDeOdHwszNziJh0s3Peee4AO4zq2yl+DusOvEijtInjrjB2RYhsaIExgpoAuP05Oorhpd
 0NVDg24Lv2SmQ48yTPeu8MZ12LMlzA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f617a7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ze386MxoAAAA:8
 a=_PUjjehnJBWPTTrYcrMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=iBZjaW-pnkserzjvUTHh:22
X-Proofpoint-GUID: MVAijfgBrZpqz8YgxEwiESsCp-NU1iCL
X-Proofpoint-ORIG-GUID: MVAijfgBrZpqz8YgxEwiESsCp-NU1iCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Mon, Oct 20, 2025 at 09:55:13AM +0200, Guido Günther wrote:
> They're used in the parent to describe the panel's reg property.
> 
> Fixes the
> 
> linux/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb: panel@0 (visionox,rm69299-shift): '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> warning.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 89260fce6513..44e7b5015d26 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -472,6 +472,9 @@ &mdss_dsi0 {
>  	status = "okay";
>  	vdda-supply = <&vdda_mipi_dsi0_1p2>;
>  
> +	#address-cells = <1>;
> +	#size-cells = <0>;

They are already a part of the device node.

> +
>  	panel@0 {
>  		compatible = "visionox,rm69299-shift";
>  		status = "okay";
> @@ -479,9 +482,6 @@ panel@0 {
>  		vdda-supply = <&vreg_l14a_1p88>;
>  		vdd3p3-supply = <&vreg_l28a_3p0>;
>  
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
>  
>  		pinctrl-names = "default", "sleep";
> 
> ---
> base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
> change-id: 20251019-shift6mq-dt-e4b9e7dc7169
> 
> Best regards,
> -- 
> Guido Günther <agx@sigxcpu.org>
> 

-- 
With best wishes
Dmitry

