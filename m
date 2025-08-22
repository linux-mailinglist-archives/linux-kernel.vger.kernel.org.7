Return-Path: <linux-kernel+bounces-782235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65BB31D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD43CAA6206
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E1320CD8;
	Fri, 22 Aug 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jp+mSv00"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AE320CDB;
	Fri, 22 Aug 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874638; cv=none; b=cbm6alVFeGtEe/PGcJLdN6R/PzmMyvSmIAA/O4k9KOlfJMy+xuQA4yDM4KnYRhjfAoyMjyewD3xYVhABD4ruC+hltDgU5FTeCetZUb75AtUhI8nwhrcXhnTMUStJazafAaRn228JTa1pqODFcwVkHHrIeWVPe9gOBM8GsCUm6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874638; c=relaxed/simple;
	bh=NX2EmAHptM0cpfbEil35UWdEA2+irxa/S467sbBJ+F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XJMIrgkix0YGAK+83efpb+PlmwChA2/4OEvp2IhKBe/7A73zn1Z/KlJSCFdw0uSkYbOdu3Fb1+Wav24+bE0S/OBLa2Fi+6qz+Byst4P7ZpZxmq8HJecWldpWSzlCEtR1xpTYc+LsJ2E4MmbDHoC7oyayDiOANij1LugUhXlfpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jp+mSv00; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755874636; x=1787410636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NX2EmAHptM0cpfbEil35UWdEA2+irxa/S467sbBJ+F8=;
  b=jp+mSv00uScIjwRrxZzRHWzXN5X/G1A4/9OWf8XyVnUNuXRjwcsBZduh
   wEFMG70PBz/NUeLjVbW1PY0FQMQcqtJi/azic2/oyoKvAB8HTMzsju7Xo
   GOqUCxiRN3BI7tHoei2h8nhKJ3RQMLDp+C2L6WdX26KJuzzHFpJer3HqB
   EwW4N4CVkPgGAen6284F9Yf5QTBBvipoaomnWMGQbldJNUK63IjeUuHJO
   SRKkRf4uPDMEkFQtermPIJu3bspyBOkTXZ7G+15jNsIY/X3MDvYXd7QsQ
   T3L/YjHLf+t7mcn8rytCsCttc4O9z8U0I/upoWyiXO3E5ErNhImXvSPag
   g==;
X-CSE-ConnectionGUID: G8MtUZCmTuS7MMvct1brrg==
X-CSE-MsgGUID: 9da9UzP/RpGB51ZixKeqdw==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="44987207"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2025 07:57:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 22 Aug 2025 07:56:38 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 22 Aug 2025 07:56:36 -0700
Message-ID: <b7089f9a-92d9-4652-b571-b749637c609f@microchip.com>
Date: Fri, 22 Aug 2025 16:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode
To: <Ryan.Wanner@microchip.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, Aubin Constans <Aubin.Constans@microchip.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250819170528.126010-1-Ryan.Wanner@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250819170528.126010-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 at 19:05, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> The SDMMC in this IP currently only supports legacy mode

... but we're working on it ;-)

> due to a hardware quirk, setting the flags to reflect the limitation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

That's fair enough for the time being:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
   Nicolas

> ---
>   arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> index 7eaf6ca233ec..d086437f5e6f 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> @@ -387,6 +387,8 @@ &rtt {
>   
>   &sdmmc1 {
>   	bus-width = <4>;
> +	no-1-8-v;
> +	sdhci-caps-mask = <0x0 0x00200000>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_sdmmc1_default>;
>   	status = "okay";


