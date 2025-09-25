Return-Path: <linux-kernel+bounces-833213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071DBA16D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1CC170E70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1A32127A;
	Thu, 25 Sep 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p8XAmUVu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F1321458
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833388; cv=none; b=Hk1/MMZm9Mse6mXmzLNxPV3r4VuA4wGR0p+TnQG6Qk+1HtL2Q0vpcQJtrhl4aKSrB8jx6LTuQffjWTeig/2GVtpYz9dTbP0XPpPCpo+A1YJOhz/bkfgEyvFOcRwnDTe6Q/kDcJfC4m5MsIh4iEsqtUScCpKJB733OAqXnRuk5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833388; c=relaxed/simple;
	bh=wUrCJVTUXbCa1FqV1Gj7nemggyLFCW000qa8hd7/D1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLbKlJjOhIYalVH5mA/oZEtfJyqKvHNZWtfWP0uLmg6cmDkmVAjzfsPL29mrOQ/rPx4Z6I6fowmCDtvl6R9uPVBmxiYJrb2UCgLbU1rlPRf2Std8cai6Gh4lPyz9I8iycM+AVdd93AGiQ3mmbKvceCXe79KXmSvEf7C/SHcAc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p8XAmUVu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPo5G021675
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nrSVRD2iDoQamABgWm7Qd5k0
	3hb/avowVNTKiN91OWk=; b=p8XAmUVuqnL0/hZciQV9ofK3iiFYJCMH38cZWBZ6
	vlugsOXOChfLrzmYeunV2wRbbuqqc84f94o56ujMhV+888AvbkHvIzOGmcn7tmPk
	QQWBikCVN/zlm4jaHN4JDppL0xCVFbSV02kQji1i/3tJRGWPEL49l9yIlBPEoI2g
	5EzKOQJre/wQFYkvxVsbgS0otr3xFFYBvord1B+9UpyYBzUYtfjLJAaqVl/A7V6D
	7BJOIpLBz2yAfcLjVTJL9xOdp5J5R42g2HzYLG3/1nhFPdrumc5MPsOtBSh0iQ34
	YvgX3z5HUbClSl4zDtcT4RPNrJm1wXsFX8AdX38fmYWkmg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qrbmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:49:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b60d5eca3aso44164211cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833384; x=1759438184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrSVRD2iDoQamABgWm7Qd5k03hb/avowVNTKiN91OWk=;
        b=rSREJHbaE7zVOWM5zTDrbrOm6L7Ds0SrogmwRF/0xlI8n3/LuLNVJthYX61HXUy5hv
         ZLNCjGPxJMVmBYVjuHk2M5fVsjFFrLXzafcuO0eIf5zoj0OjBcXrMV/HTFbAZ2JypF/e
         PWkRM7VNXSy9M4C8PLAuHpeKVtRArc7Bc7FbYWVigpg2HrbBhv5nMscu/1AOKw2p2BEN
         K9SwVFE0xWu+aUoUthcqgPFKN+qVQImBqfCC3jMHv/rrfYMiNnSprH9oyol85jya4Ne+
         3hqEIy4mvLJ+gVXLtFZ+z3HvI3BNBJ7SfsifspUhJj7t96SGiQfws4EBIDxLhidp4hYo
         jy3g==
X-Forwarded-Encrypted: i=1; AJvYcCUmXXkl61Lqtphil47WndeLQVcKCTkMwsBYXsQaP4Qn+B/fqOsAiP8g5mqgIcs4lmblrJcG58rcKrgNRp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwhdxMu6tPWrQiZ09mUQkDUjpdBhQs4U0b2pmBIlp2ZJRoFRT
	JXKftXnpl37VRm07OUSyiVEegFph3fC7mpoOx5Unozv65CNNLyL4ZpT7nKFSOrNibfvWkUrJBkI
	4Wu1vx37EsGzsMTFto9mZGmSp2m2DKBcooGxHpgJo1KQm8Bk6oPQ9LjqsRU/y42WhnZw=
X-Gm-Gg: ASbGncv4giAIEs7QrimJ8tRP0d1ODkBD2we1GOjGiBHHVS1NJpTK6+tkTkNgJ8GICBS
	krniUVimsb/2pqnlBAzy8wsErmtMq5MH18cap/XUBZp+YVLLT/keOUGTpzuzTcBPEnfipb14qk6
	miOO3lOhI1+psOkHZmQL/Z1a2j6OzRqRJM64EBHhUCm+G5SZaQJrH7OaUkHNUMmIydXKbEdUpBG
	aoVn9HkwmxPoHo9JX8+4HMINVPt+eKpZVs/9MgqPYXNURyh4GnsKdTZbtojknJi66rdKjYhe2iO
	b6mNpySl6wfThcqHtsz8t10Rxxjwq7FJ9uWWb0SDqk/qO/T5MWs7rY8xuOHPRLoVtDsCMqxPouu
	gcnFRgtf3u1s4/ET/s2Cgixcm77JRP8yomd+MB3BCwXXZtUCnpu+b
X-Received: by 2002:a05:622a:1811:b0:4dc:cfa6:f3aa with SMTP id d75a77b69052e-4dccfa6f683mr17331751cf.13.1758833384151;
        Thu, 25 Sep 2025 13:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHglSc8bYkisIptWG+WWib0zptRuS07TFi6Ykk8adPD9FgVo68/X4JgsQrmDg0Zmsk//FYBjQ==
X-Received: by 2002:a05:622a:1811:b0:4dc:cfa6:f3aa with SMTP id d75a77b69052e-4dccfa6f683mr17331301cf.13.1758833383633;
        Thu, 25 Sep 2025 13:49:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656243sm1109173e87.91.2025.09.25.13.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:49:42 -0700 (PDT)
Date: Thu, 25 Sep 2025 23:49:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/3] arch: arm64: dts: qcom: sdm845-starqltechn: fix
 max77705 interrupts
Message-ID: <ri43zx3dwmizxxeqju3gq7tdrvjhs7eb2ay2b3p5vmcyldm6lg@bo3o6zntlkyd>
References: <20250925-starqltechn-correct_max77705_nodes-v4-0-93b706bdda58@gmail.com>
 <20250925-starqltechn-correct_max77705_nodes-v4-2-93b706bdda58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-starqltechn-correct_max77705_nodes-v4-2-93b706bdda58@gmail.com>
X-Proofpoint-GUID: CEW806m1ACa5BfNEmAh2jA-FxKb8VjvS
X-Proofpoint-ORIG-GUID: CEW806m1ACa5BfNEmAh2jA-FxKb8VjvS
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d5aae9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wtXp1jUp6BH7xgA5KDEA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX8ILW3vk79lAX
 gONs+Jh88Jlf9nRXU6C0FahzFz/mEGKKqg6R02MoqdgF4qH/wu3Bfoav4E2v1fme1BncbPS6xPv
 ObTMETW5/8GDes63fhZHvj5Bx4yX07IivC2OirBxSxqKFku6W7U9ICqNXnR7W6OZLvcIQvz3pYd
 hr9VIfLE+ehDVy164CWHL9tqje9d2Bx5wsxWE73ZgE6arILwVz5CTvVjxV+5sC8i7VBeD5QUcwn
 xMgxk1qKfWNia+NEj+czsYDuklWOD8QO6a/wMchQkvH6Mw0w2e8M9O3C+k7vsk9tqIB4PHIhaVe
 EEfdrW1UbsTQAwZVIKrYPA++ZWQjkQSQ/tM5+YxuWRSQbBCBnQ+Vj8t1C0io2kJu6CHq1x6N9eF
 QfIeQ4MH8O3tr7j5psOZEH6rbu0ang==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 10:38:38PM +0300, Dzmitry Sankouski wrote:
> Since max77705 has a register, which indicates interrupt source, it acts
> as an interrupt controller.
> 
> Direct MAX77705's subdevices to use the IC's internal interrupt
> controller, instead of listening to every interrupt fired by the
> chip towards the host device.
> 
> Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes for v2:
> - fix commit message to be more clear
> 
> Changes for v2:
> - fix commit msg header prefix to 'arm64: dts: qcom: sdm845-starqltechn:'
> - remove binding header for interrupt numbers
> - make interrupt-cells 1, because irq trigger type is not used
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 45c7aa0f602d..41c93c801703 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -599,13 +599,15 @@ &uart9 {
>  &i2c14 {
>  	status = "okay";
>  
> -	pmic@66 {
> +	max77705: pmic@66 {
>  		compatible = "maxim,max77705";
>  		reg = <0x66>;
>  		interrupt-parent = <&pm8998_gpios>;
>  		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
>  		pinctrl-0 = <&pmic_int_default>;
>  		pinctrl-names = "default";
> +		#interrupt-cells = <1>;

Nit: if the series get resent please group interrupt-related properties
together.

Anyway,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



>  
>  		leds {
>  			compatible = "maxim,max77705-rgb";
> @@ -644,8 +646,8 @@ max77705_charger: charger@69 {
>  		reg = <0x69>;
>  		compatible = "maxim,max77705-charger";
>  		monitored-battery = <&battery>;
> -		interrupt-parent = <&pm8998_gpios>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&max77705>;
> +		interrupts = <0>;
>  	};
>  
>  	fuel-gauge@36 {
> @@ -653,8 +655,8 @@ fuel-gauge@36 {
>  		compatible = "maxim,max77705-battery";
>  		power-supplies = <&max77705_charger>;
>  		maxim,rsns-microohm = <5000>;
> -		interrupt-parent = <&pm8998_gpios>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&max77705>;
> +		interrupts = <2>;
>  	};
>  };
>  
> 
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

