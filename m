Return-Path: <linux-kernel+bounces-775930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19491B2C683
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE6188D69D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341681F3FC8;
	Tue, 19 Aug 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VIOSbwQD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D8AD5A;
	Tue, 19 Aug 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612082; cv=none; b=tgtPkofF9Btz2tK4lFNOA1rfAfcS3qw5IFo4I3EisHM++y6uDKbTWx+aJuO3Mk5rhdMkydMLnZ5Yg3em/u/wi3QeHYidA4ezDOMcpX2vUdVriSmAtgFrmU9aIWzZmmG5crO3FU/xkIxG373xKjyZ0KezomOG4UG0uYIc7yKbBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612082; c=relaxed/simple;
	bh=a2gMG2z4n/QilfiYn1/Anv7UTDKG8xPbDa/nrlRE1lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=DFMaeR+f63W7yJzlouKmjDGR+zdMGddAJ6cXfl5se4m5csfCcVX823j/VeGxisYtwZxkMPjhxZVpd7iJbg3BqZlAqW5mNIm4nuk1lxR/jc7e/PnyUeOFCF/phsQSj+xf0qXuE/Ljod9t+XYkxne2RP1NDleEa+NpjZCEnC206hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VIOSbwQD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755612081; x=1787148081;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=a2gMG2z4n/QilfiYn1/Anv7UTDKG8xPbDa/nrlRE1lY=;
  b=VIOSbwQDBhr72LFiZYAHa4FQXbmxd4PndlTdKLITGbsJDP63MjLQnDea
   EiU5Hc88PE2L74HNM8VU5lxX23mr/iS2vz2R95vQfIs+nBIR/q4Y1muVB
   NrbIzclPKauaZkWSieuD00IqFXX+eESEHEuVKWOD+qI6euiLDi05LFtC1
   otvmjssLM7gJdSG1sb6XagQiBp6I059ObYLk10Tv+klLf16Yw4WsffCbv
   2YdHtxjEk9gu7qJ9O8rzcQNWJy3TcqQcaLRDc8mJLh5TDp3SudAmUfMt1
   zcJUt2tg7dKXhpbKZUDdz/I/vMkWIdTghu4ZTyOMS1tR13XkSI83dODhY
   w==;
X-CSE-ConnectionGUID: yimjwyM6Qne79SKApcb1tQ==
X-CSE-MsgGUID: qKPcykCuTreaKzASC2aKHA==
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="45371639"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2025 07:01:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 19 Aug 2025 07:00:59 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 19 Aug 2025 07:00:57 -0700
Message-ID: <4a284c63-062c-4d2f-a2ff-c0fc7e5504c0@microchip.com>
Date: Tue, 19 Aug 2025 16:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: Minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250819131736.86862-2-krzysztof.kozlowski@linaro.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
CC: Ryan Wanner <Ryan.Wanner@microchip.com>, Mihai Sain
	<Mihai.Sain@microchip.com>
Organization: microchip
In-Reply-To: <20250819131736.86862-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 at 15:17, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.

Thanks Krzysztof, and sorry about that.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts | 2 +-
>   arch/arm/boot/dts/microchip/sama7d65.dtsi               | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> index 7eaf6ca233ec..c14c52936ecc 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> @@ -346,7 +346,7 @@ pinctrl_gmac0_txck_default: gmac0-txck-default {
>                  bias-pull-up;
>          };
> 
> -       pinctrl_i2c10_default: i2c10-default{
> +       pinctrl_i2c10_default: i2c10-default {
>                  pinmux = <PIN_PB19__FLEXCOM10_IO1>,
>                           <PIN_PB20__FLEXCOM10_IO0>;
>                  bias-pull-up;
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index c191acc2c89f..84bac1d29421 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -91,7 +91,7 @@ secumod: security-module@e0004000 {
>                  };
> 
>                  sfrbu: sfr@e0008000 {
> -                       compatible ="microchip,sama7d65-sfrbu", "atmel,sama5d2-sfrbu", "syscon";
> +                       compatible = "microchip,sama7d65-sfrbu", "atmel,sama5d2-sfrbu", "syscon";
>                          reg = <0xe0008000 0x20>;
>                  };
> 
> --
> 2.48.1
> 


