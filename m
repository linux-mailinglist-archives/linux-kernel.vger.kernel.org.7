Return-Path: <linux-kernel+bounces-735401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89DB08ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB503B2071
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8512F6F9B;
	Thu, 17 Jul 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqqE/4ip"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E72ED87A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761108; cv=none; b=XLfEyyxN3sofeMVLTrpXmjvxbAR63GdmRB6/12MEOmzBJm6KQ3kgvL/ugs/JjUuPd11u4/PEiTZv0V2EbOduSJHNedY8NIJf6GhjG7I6QyUl9JVODTSesMUmytjRriYv+zTcSVcP2pKDqYkBBQGCI4DGK8QHr1BjkX1L5sf/fYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761108; c=relaxed/simple;
	bh=9gvBim17Y/OQeT9BpvV3H6m0AjqhHeS0NTcnqVzFBdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pL7MQdjhxYP/t4xF6uDrfEYpkbTeHrrs4Urt4NTCSxs5Z+LnoJ/qpgJ6C3inwdPZBI+YRpYVrdLZ+5TAen+aj+qlFH0uBsHLBku+M3f4gTuNlpjVg3Jo1DH76UWUid8xh2aaIR3kCzh4aQrXCR0FUJZNEUM4KDkt0H95R4roxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqqE/4ip; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4e62619afso105377f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752761105; x=1753365905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hziN1ibaswAS/psjN8sr3ljdhSytt8bIgX4uJ7Uc8ag=;
        b=IqqE/4ipA7EzL7uUxk/Ftk3hGzhH09yGTK7oyUWKYt/bEhQZU1MA8ofGeEJc3OL9TT
         KHFtilU2oPsl6tppAQuksDmRCewoqWVCxtOBQkgdTWR14ofyvoW4HrPgxgoSRowDbaxF
         u65BIkfi3aJ/JKUsdEx1yRuo8xy7WZJMPCuDni/6TMx5fRnLTD04PEHLcIHrvGBlP5K0
         zoN+jZCygmhe0baIRwSvTungxfBF/sdqyLEIAOmIuGZY5GXAufJ0wLVuYxjckH63Kmsa
         LwK6bVW2NWvwJme2eSp01R30uFBDS1HHVp3HGnRjTW+dhGLWyTMzCsF94w1cEsCsYfQT
         kHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761105; x=1753365905;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hziN1ibaswAS/psjN8sr3ljdhSytt8bIgX4uJ7Uc8ag=;
        b=X3+ejdNm1vkomsC13oPXA/rng542FkRIRYZxFt1Bw6ox+AQKc9T13YPFkgNIJ8raeG
         rpeSyuO8XORMBiEHs+aD7GzjSLmt6Bx7B1eJwUvArmOzMOv4A3sGfKdwR1Kh3y1ZT8ni
         UmQLSHimiwA0bIg4rUGDCmKYiSVHALcRbFjRwObZbpqwyx+XIa4XUGd7WAKq2DuHwons
         C7H3kyjacEmAqDlyoFQvPSNqj9fZLNme/ZPHZriDNetYvGcGq/7Fyle+K6Ifqt5hslOi
         DyhC/Pa/m76y1TcWd3dSmi4iJqOeqW0KDYOI1c08uIzS3UI72iXc10HzlwcpG1xJjCtg
         HzcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqf0e6oYObnkUwTCXssYy4nA3xUR86xIWbQfCBjlYsPwtHlSri0hqq2cV0pwcsRSfsCj6xmvK69PGo60M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rQqryS/O+NvWTIDZ9XcCOTYxQCuAw6r5RqpeeJ50g8A9Bvos
	6NL0bpycemmIvHLUuSvtFu8Zt8EArE/AzMGR3qaYCN2IyX806b1R+wJp5eP5UyeIfvs=
X-Gm-Gg: ASbGncuuS8DckrDJ88/cjYbKmG4F9uQTV4MqQ1G/VHyt0KLQHvccm1P46f63OHHFXBI
	QCJZNT1xGYCNdMCyZ6Nidi8TL5UofAqvqY/zNFALoKJ5xfazaKy1/QNsuKEkvgapEaMWdLTkF1c
	w/xy8xJA4i1C1utpMEoRHyaab3RZH0Mz8lNxtEKY4ITuQpIlXU0ctz3m0KaL5z/r0mNwlfZfC7L
	9NyZzozclaBCGPrVOJHPtEleZyvJzsDn6xg3jCPczNrJSY8ugB+pKw/CH3CvdkJ0qt4idWtnvC4
	ZDbCrDKsGFqOrAy5Rb4EBl1NH5MOQ1kEYcVevHH2kDZqOSZEAS4097mZPpMimIfuilFrZiFHSJc
	gRgr0p4t0vwqGQ/os/rQnLhc/io2zpiT5IlMatkkJiQ==
X-Google-Smtp-Source: AGHT+IFIkZphDhTA9B+44Q5/IKe43A9aFgi9cyKEASIvFShkWzB+ZlJHgdIZmVNpNfSEhLsgS6PcJQ==
X-Received: by 2002:a05:6000:2301:b0:3a8:2f65:3751 with SMTP id ffacd0b85a97d-3b60dd4d73fmr2588922f8f.2.1752761103089;
        Thu, 17 Jul 2025 07:05:03 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1792sm21038309f8f.13.2025.07.17.07.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:05:01 -0700 (PDT)
Message-ID: <db07c25c-4064-4330-8bdb-8a619b0b2915@linaro.org>
Date: Thu, 17 Jul 2025 16:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm64: dts: nuvoton: npcm845: Add peripheral nodes
To: Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717135336.3974758-1-tmaimon77@gmail.com>
 <20250717135336.3974758-2-tmaimon77@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250717135336.3974758-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2025 15:53, Tomer Maimon wrote:
> Enable peripheral support for the Nuvoton NPCM845 SoC by adding device
> nodes for Ethernet controllers, MMC controller, SPI controllers, USB
> device controllers, random number generator, ADC, PWM-FAN controller,
> and I2C controllers. Include pinmux configurations for relevant
> peripherals to support hardware operation. Add an OP-TEE firmware node
> for secure services.
> This patch enhances functionality for NPCM845-based platforms.

Drop this sentence, redundant and not in style (see submitting patches).
> 
> Depends-on: ARM: dts: nuvoton: npcm845: Add pinctrl groups

There is no such tag.

Use changelog for this purpose or b4 dependencies.


> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 695 ++++++++++++++++++
>  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
>  2 files changed, 702 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> index 5cd877e6c20a..3564e0e30791 100644
> --- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/clock/nuvoton,npcm845-clk.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	#address-cells = <2>;
> @@ -40,6 +41,11 @@ ppi_cluster0: interrupt-partition-0 {
>  		};
>  	};
>  
> +	udc0_phy: usb-phy {
> +		#phy-cells = <0>;
> +		compatible = "usb-nop-xceiv";

Please follow DTS coding style.

> +	};
> +
>  	ahb {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -56,6 +62,259 @@ clk: rstc: reset-controller@f0801000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		gmac1: eth@f0804000 {

Please follow established naming for node names. I'll fix whatever old
stuff you took it from.


> +			device_type = "network";
> +			compatible = "snps,dwmac";

I don't think we want the generic one, even if it is allowed by bindings.

Also... You CC-ed an address, which suggests you do not work on mainline
kernel or you do not use get_maintainers.pl/b4/patman. Please rebase and
always work on mainline or start using mentioned tools, so correct
addresses will be used.


> +			reg = <0x0 0xf0804000 0x0 0x2000>;


> +			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks	= <&clk NPCM8XX_CLK_AHB>;
> +			clock-names = "stmmaceth";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rg2_pins
> +					&rg2mdio_pins>;
> +			status = "disabled";
> +		};


...

> +
> +		mc: memory-controller@f0824000 {
> +			compatible = "nuvoton,npcm845-memory-controller";
> +			reg = <0x0 0xf0824000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		udc0:usb@f0830000 {

DTS coding style...

> +			compatible = "nuvoton,npcm845-udc";
> +			reg = <0x0 0xf0830000 0x0 0x1000
> +			       0x0 0xfffeb000 0x0 0x800>;
> +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk NPCM8XX_CLK_SU>;
> +			clock-names = "clk_usb_bridge";
> +
> +			phys = <&udc0_phy>;
> +			phy_type = "utmi_wide";
> +			dr_mode = "peripheral";
> +			status = "disabled";
> +		};
> +

...


Best regards,
Krzysztof

