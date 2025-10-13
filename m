Return-Path: <linux-kernel+bounces-850985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446B8BD55C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C524030BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55B257828;
	Mon, 13 Oct 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iTUvBUFv"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24D2AD32
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371196; cv=none; b=p9LrcGw6cuwGR243YsV7p+3jFFywP2En/a7mL2nYFgE64K6mQnkRESmqdTHMCannIEDA+a4mVFJE6eyWUCq5Xu/UM6enlDz4bww86loVpPIXuWRRiAlIsZy4WWjUnowcHehn5cI2hK5pY24kF676y6yjL9PzUILriv4mcQvHaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371196; c=relaxed/simple;
	bh=jESTcv3YFhUmlOUv44t8wTXwwkxRnt3JglffHaglMWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHlztCVBT3YyGrne0BxQL47TMZNXs4i771W6OJZKBDzJc2fqZnMQYXHXyFgoGZVhyKg5eMnQRX1t92+eWckPVI7zh/MhvAcPj6WDpi0ooGXWCXa5QnMwJeLkqY7VXmJiKkPorz+mwaddsV+2EJhvNoXI/X7z9R5wgHFiS32R3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iTUvBUFv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8E361C093B0;
	Mon, 13 Oct 2025 15:59:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 663A66067B;
	Mon, 13 Oct 2025 15:59:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F18D3102F2273;
	Mon, 13 Oct 2025 17:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760371189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=F9tnRL1o3FmzbH3rPOyKULKn/hk3zU9MNzUIZBbOh80=;
	b=iTUvBUFvI/itbMlmJ0x0WrNzyi3QeiZvBxNdzyILfJ7IH3MWnWJYdtUDDzRm/s1Oe50Qsx
	S50pmM6ZNqZ/t4QvTvRlAE5J968iQN3WpJ8KeQ7Sei/efTMN/EXd4tY9drQHat9TNT63LT
	kJ1dQGrfmrjAuJJ+vZAX9+tkap3RpYHzUGZ/ia9xXCZch8QszvcJrPkyu1TE15dECyKWgF
	igGuZWbbLVAo95qPbdNjUPGGTBhxylCrwmu3DL+6HkZFc/5pR+xyxrgq+U6odYq+7yaR3t
	xJR/eJjTd9DVWPwo4sMzBwBIaRuZeK2fWtLndnSXGUsnJyQl9MZi6mBjU7SVBQ==
Message-ID: <7293f682-7ba7-420c-9997-eec0d5cb09e1@bootlin.com>
Date: Mon, 13 Oct 2025 17:59:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: allwinner: h616: add NAND controller
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251013152645.1119308-1-richard.genoud@bootlin.com>
 <20251013152645.1119308-16-richard.genoud@bootlin.com>
 <2800174.mvXUDI8C0e@jernej-laptop>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <2800174.mvXUDI8C0e@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 13/10/2025 à 17:43, Jernej Škrabec a écrit :
> Dne ponedeljek, 13. oktober 2025 ob 17:26:45 Srednjeevropski poletni čas je Richard Genoud napisal(a):
>> The H616 has a NAND controller quite similar to the A10/A23 ones, but
>> with some register differences, more clocks (for ECC and MBUS), more ECC
>> strengths, so this requires a new compatible string.
>>
>> Add the NAND controller node and pins in the device tree.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> index ceedae9e399b..bb53c6c63836 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> @@ -304,6 +304,42 @@ mmc2_pins: mmc2-pins {
>>   				bias-pull-up;
>>   			};
>>   
>> +			/omit-if-no-ref/
>> +			nand_pins: nand-pins {
>> +				pins = "PC0", "PC1", "PC2", "PC5", "PC8", "PC9",
>> +				       "PC10", "PC11", "PC12", "PC13", "PC14",
>> +				       "PC15", "PC16";
>> +				function = "nand0";
>> +			};
>> +
>> +			/omit-if-no-ref/
>> +			nand_cs0_pin: nand-cs0-pin {
>> +				pins = "PC4";
>> +				function = "nand0";
>> +				bias-pull-up;
>> +			};
>> +
>> +			/omit-if-no-ref/
>> +			nand_cs1_pin: nand-cs1-pin {
>> +				pins = "PC3";
>> +				function = "nand0";
>> +				bias-pull-up;
>> +			};
>> +
>> +			/omit-if-no-ref/
>> +			nand_rb0_pin: nand-rb0-pin {
>> +				pins = "PC6";
>> +				function = "nand0";
>> +				bias-pull-up;
>> +			};
>> +
>> +			/omit-if-no-ref/
>> +			nand_rb1_pin: nand-rb1-pin {
>> +				pins = "PC7";
>> +				function = "nand0";
>> +				bias-pull-up;
>> +			};
>> +
>>   			/omit-if-no-ref/
>>   			spi0_pins: spi0-pins {
>>   				pins = "PC0", "PC2", "PC4";
>> @@ -377,6 +413,21 @@ iommu: iommu@30f0000 {
>>   			#iommu-cells = <1>;
>>   		};
>>   
>> +		nfc: nand-controller@4011000 {
>> +			compatible = "allwinner,sun50i-h616-nand-controller";
>> +			reg = <0x04011000 0x1000>;
>> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND0>,
>> +				<&ccu CLK_NAND1>, <&ccu CLK_MBUS_NAND>;
>> +			clock-names = "ahb", "mod", "ecc", "mbus";
>> +			resets = <&ccu RST_BUS_NAND>;
>> +			reset-names = "ahb";
>> +			dmas = <&dma 10>;
>> +			dma-names = "rxtx";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
> 
> Sorry, forgot to mention. This should be marked as disabled, as most of
> the boards don't have NAND connected.
arg! of course, I forgot that.

Thanks!

> 
> Best regards,
> Jernej
> 
>> +
>>   		mmc0: mmc@4020000 {
>>   			compatible = "allwinner,sun50i-h616-mmc",
>>   				     "allwinner,sun50i-a100-mmc";
>>
> 
> 
> 
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

