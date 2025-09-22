Return-Path: <linux-kernel+bounces-827312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11CB91689
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280803A575A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16BB30C378;
	Mon, 22 Sep 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KMoAUbhK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609D309EED;
	Mon, 22 Sep 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547943; cv=none; b=N3oOj7VEYnkqxdOL4HZTuIsXliwyLsF5iJg0TphTvKUFoKBMqa+eeqaJ6prNIzHYxqrxusfYuFLMuiAfBkXPQxUKZJJYuml24HQyQIWkE4kM4QSSgYYJyCKMfVcMY1VD5KOlu5+YGzfEa+CG7KgX7p/WUbcgRIMB7lQ29uoQsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547943; c=relaxed/simple;
	bh=TDh5kMQItLeCtCYOhniYG9SE9N6xkw1ryWAXikH5CKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KXtE6BtcCnUZRdG/UX3yzXOOWiHj/Sd9YFHisXN3zrp7KnIlRweXgVoW/L8fnsKIOOulW69JpvntwHo8s3YqCXwpxkxXmwp38mmuNlQfBZy0Zc+4zI+tonK6QtbzhD56QCF8GfhkrlBuw/LKQCU++Mcq1HeJ5KYXbZbTmNyPxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KMoAUbhK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758547941; x=1790083941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TDh5kMQItLeCtCYOhniYG9SE9N6xkw1ryWAXikH5CKc=;
  b=KMoAUbhKtuwcl9RY98Uh/zQ31AqP+56p7hnS0f06iDFV5NpMhmGaNgoi
   EaLaIEgUW87d4dKsGyeYI1+P1lrOD7Mdrqm+9xDBc0kmtxXhQlyBa5Yd7
   oqjY5oU0BpVeYQiuZ/ZYU7QXToEa1/kQ/76VJX36Rdfb0rte9gqPBK9Xj
   XLuME0bZnaHfvpNNxqo7wZdmjFSuWbYPdE5CWFO9uhJYaRXkmvQ6czTif
   JAs3GKlJrxcFyG6icA0hrVjHfA70S/B5reTov+R4dOtcVl3OE4Dy3A8nd
   9lHaGRABkGsEpkFRXQgzywvjjTAGaeMob774jKKfztr5etXLn6LsfVFDH
   A==;
X-CSE-ConnectionGUID: TCpADp6USuqlHeFWAhCzYw==
X-CSE-MsgGUID: g6s7rN8HROqtzWL3QVKHcQ==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="46235453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 06:32:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 06:31:47 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 22 Sep 2025 06:31:45 -0700
Message-ID: <bc2278a2-387f-4e66-b275-8429bcb45db1@microchip.com>
Date: Mon, 22 Sep 2025 15:31:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x7: Add qspi controller
To: Dharma Balasubiramani <dharma.b@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250915-sam9x7-qspi-dtsi-v1-1-1cc9adba7573@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250915-sam9x7-qspi-dtsi-v1-1-1cc9adba7573@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 at 11:13, Dharma Balasubiramani wrote:
> Add support for QSPI controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
And queued in at91-dt branch.

> ---
> Driver and Doc support
> https://lore.kernel.org/lkml/20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com/

Thanks for the reference to the (accepted) binding and driver changes!

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/microchip/sam9x7.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
> index 66c07e642c3e..46dacbbd201d 100644
> --- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
> @@ -271,6 +271,27 @@ AT91_XDMAC_DT_PERID(38))>,
>   			status = "disabled";
>   		};
>   
> +		qspi: spi@f0014000 {
> +			compatible = "microchip,sam9x7-ospi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0xf0014000 0x100>, <0x60000000 0x20000000>;
> +			reg-names = "qspi_base", "qspi_mmap";
> +			interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
> +			dmas = <&dma0
> +				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +				AT91_XDMAC_DT_PERID(26))>,
> +				<&dma0
> +				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +				AT91_XDMAC_DT_PERID(27))>;
> +			dma-names = "tx", "rx";
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_GCK 35>;
> +			clock-names = "pclk", "gclk";
> +			assigned-clocks = <&pmc PMC_TYPE_GCK 35>;
> +			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_PLLADIV2>;
> +			status = "disabled";
> +		};
> +
>   		i2s: i2s@f001c000 {
>   			compatible = "microchip,sam9x7-i2smcc", "microchip,sam9x60-i2smcc";
>   			reg = <0xf001c000 0x100>;
> 
> ---
> base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
> change-id: 20250915-sam9x7-qspi-dtsi-a4844266b17d
> 
> Best regards,


