Return-Path: <linux-kernel+bounces-802524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1797B45322
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3273BDAC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB6283C9D;
	Fri,  5 Sep 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzn44bLQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B12284662
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064368; cv=none; b=L7axxK33rtGcew+sk5kd7BIjL3qZJ0u5w5V8w6NvvuQqroZEzqwkDMqZuxU1mnsWwDSuUMb2mmuokINWg3Xcfq/1KtdtfWWnBVwi5s/+8lc6j9b6NgcxNrIb15VVail08V65YUaODRYPPyCVHQLHs/lK0rcgLklpH2NG13AtS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064368; c=relaxed/simple;
	bh=MEed7gqF7d7fWHQmdGpJUnqCT33bvVFLPAKdB2LPFeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyhmAGmQ/UMCvB0d1AyyIhDZPSDVdPn5SUHyd2PEfl5UcTOeyOEQnQd+CuBXveW2Re5Gw9e7Gpq7fI7NqBXgeW6RYkTBtOWee3Z4hjtMbFJ95B1rgXDm33pdeRlIhsdBDabJEPVxblYKhr6ZWoBoS6UGr9pZlgn1j/bQPaXcNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gzn44bLQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d1bf79d75aso1060422f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757064365; x=1757669165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1b4J3UsQ3netqUZNC1BP1Y1aZDxDf+RWzn/Hk/C+pw=;
        b=gzn44bLQ32e7vf/erJdOQL/HLt+H0ABMbNBR0cQCSoh2+fCHO7dLmR18g63WBd4/Kv
         Cd3NOlBrGTir3N84gGgjgivjqYmQIB9JUs+PzVYQfqABxlMIhl829WPgosviGZ1tnrwG
         X8u8P+f7fsmjDqcB6Bs2MxyftD/9GrOTGk1LH2ZHcr8m8pmnhpIeEK6ORlWEP+G4nJ25
         T2N2reD+fpEDXJhZiV+b9zj8IBo24bpwAvCh/X2iMCMJltDr2XQtOAAk4LzSLbKpNDkc
         8Xjx2dE7FQDp6OKwALpdsG509oXgl1cWVzHzENuhCcyfZ8BHHSyh58E6KTrBV/jSNOGP
         ABeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064365; x=1757669165;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1b4J3UsQ3netqUZNC1BP1Y1aZDxDf+RWzn/Hk/C+pw=;
        b=i8Nzb+/jycYqW9MYS6Pg2z/r4VVbdRtdGG+4RyVLFu93lR9Ogzlhbtd5Bj0nfGmNVY
         zubqZfyPjEjwkzeso/8Ig88ohlPvYQrxO8Wxzpx6Riah6a3Xo7+38zuLg/xxtjiTC98i
         4miYqHvi/MXjZy4a8OqxtAsr84UUDzFzYAhbunYo17QSblU0V+cTytPGrIGQhN53DpRt
         hwB6tpp3OBYumywM9uH4rmIAdIj7E/uMRLJIuXVYSEfLvL3C+07f8ADFB/A6l2d3ZZUJ
         CUBof+skkd/CvepVXY75WqdcOUMsTex1MJKIc2HJOXeY8rfZ99Vs652p6ncUMM3x9/kJ
         FA7g==
X-Forwarded-Encrypted: i=1; AJvYcCWVD7DwuZ2e5O4g6QRraopKhWBOAH+QuBxZr7QWVU9XtVS7CsEI1h+igsE4C6mUklb6cMVQ7SE4AjWMOfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qOBkrAHMJ5ks+A5psyfDiNFajsneI3l4e81u3pw3cG8PE4Om
	kta0tojnIacsN7L64Sc4BkI+j3qiUB91MQgxPlQMKueaUqn8qOzYMZWHB+iymO9hhcI=
X-Gm-Gg: ASbGncsQFbmy3GuUoDRFk5FAzb6pvbPVoxscgVUYrwlWIZKMEl6wlqMIA2v1ObDoN9u
	vUfBK+HnC44iJMn71xO+HcaJ4/i98OGUatfj9c2YAVMoaVlqGC/QzgFzdG/7aqm8aw/9RU/xIYw
	imwjL9CK9h4cSlVog+bK2r8SUgZ1/ByQWyH/wx87IWLalCW5yqXDBCA25Vo3+qHqqBoPau3x646
	0I43sN1QH+p6m6ZZ5NCYkWBDwvG27NEWrkwXQfFdIgUgp6SuWZcwuvG9u2ozjI6QEMVDi7L7SC7
	UYrj2Q7OdN7hyVUXHf619afT4229XLGhDilepMv+42teaael/qrezYB8bssh7LaQQdnOSwt64wY
	vWG+Lgj2CjklQK2Y3jv7jaoynhS33IeCRT5GSxOX9wU1qfCZU1D2XLvgulAU6/rhN74R5TVizdQ
	HzkUc08kigu//MFnXkd73hCgqDnxqjUw==
X-Google-Smtp-Source: AGHT+IHf2bP4rvj7gdEbkjOaPluyqyvNYQTBLFp/W2bKEoetxcByY2bWU0nZ7KXQEoy+tTKeNkxMLQ==
X-Received: by 2002:a05:6000:22c4:b0:3ce:7673:bb30 with SMTP id ffacd0b85a97d-3e3048266c8mr2128415f8f.14.1757064364653;
        Fri, 05 Sep 2025 02:26:04 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm167696195e9.2.2025.09.05.02.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 02:26:03 -0700 (PDT)
Message-ID: <df705089-0554-4044-87c8-d2bd16da3ee8@linaro.org>
Date: Fri, 5 Sep 2025 10:26:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: x1e80100-t14s: add EC
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250905-thinkpad-t14s-ec-v2-0-7da5d70aa423@collabora.com>
 <20250905-thinkpad-t14s-ec-v2-3-7da5d70aa423@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250905-thinkpad-t14s-ec-v2-3-7da5d70aa423@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 02:09, Sebastian Reichel wrote:
> Describe ThinkPad Embedded Controller in the T14s device tree,
> which adds LED and special key support.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index ac1dddf27da30e6a9f7e1d1ecbd5192bf2d0671e..f70489aba870289edbcf84ec22fdb004e010868b 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -887,6 +887,24 @@ eusb6_repeater: redriver@4f {
>   	};
>   };
>   
> +&i2c6 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	embedded-controller@28 {
> +		compatible = "lenovo,thinkpad-t14s-ec";
> +		reg = <0x28>;
> +
> +		interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-0 = <&ec_int_n_default>;
> +		pinctrl-names = "default";
> +
> +		wakeup-source;
> +	};
> +};
> +
>   &i2c7 {
>   	clock-frequency = <400000>;
>   
> @@ -1267,6 +1285,12 @@ &tlmm {
>   			       <72 2>, /* Secure EC I2C connection (?) */
>   			       <238 1>; /* UFS Reset */
>   
> +	ec_int_n_default: ec-int-n-state {
> +		pins = "gpio66";
> +		function = "gpio";
> +		bias-disable;
> +	};
> +
>   	eusb3_reset_n: eusb3-reset-n-state {
>   		pins = "gpio6";
>   		function = "gpio";
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

