Return-Path: <linux-kernel+bounces-866458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B75BFFCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68D7A4F5E47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DF82EB85B;
	Thu, 23 Oct 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E/ncisCb"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114412EAD10;
	Thu, 23 Oct 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207065; cv=none; b=V11ALrQhrZFFgewFWi5/Reo6wqBOOrW+ghRE4ByGu7dWIh1Xv+5l1REAV0SuuGD1fMlwbUt0iaf36gwT8QugVtydud6cbFzCp01YJZpe1+7CIa9AEpUrRSGGYdR8NxO00D2Q9cCS3rQK/H50J1x5kH9VaE5GA1buONLn+pmyruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207065; c=relaxed/simple;
	bh=IOzK0+6vzTLzNAB4j/CCNSfdjshRGV+NGA7tvCQjke4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kz7vP/6K+Y/R8rbfp+WAs/f6MYTXoh40PhL/mcVWH7f8YQkamlhUvgWpUQ/aCbGvQP1uqB8+jmx4mus+FqOm74soEr3r4Jc85/M8XuvT5ly8vZ4j1cQAuEiU/UeyhbWsZ/oJ49rSdX024SBtkMf3pWdUgwFaOrrY/QbK8CcxkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E/ncisCb; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59N8Am9X483021;
	Thu, 23 Oct 2025 03:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761207048;
	bh=mvitnbkjcLAPoCX0wHi6huodXxXSf+n5ic/epN0KCNA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E/ncisCbT+ddeWJ5/EgdoFSv4WoQmsskRT5yFbVikwmLxKdAHccYOY/o98GEtNicz
	 Vy2rxVeOPKQL2jEMm0RJ/F+1v1nFjGUwA/2SDoRqfIYl9J27uMxqB3XxjgZdKXcVfH
	 8/sVEp0xtQXwBNM/COesSQUlu6h8oeQJCLGSvFzo=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59N8AmKN2247619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 03:10:48 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 03:10:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 03:10:48 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59N8AiYh2549946;
	Thu, 23 Oct 2025 03:10:45 -0500
Message-ID: <3c131320-7be9-4223-b3c2-11beb435abd5@ti.com>
Date: Thu, 23 Oct 2025 13:39:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-tqma64xxl: add boot phase tags
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
References: <20251006095036.16367-1-matthias.schiffer@ew.tq-group.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20251006095036.16367-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Matthias,

On 06/10/25 15:20, Matthias Schiffer wrote:
> Similar to other AM64x-based boards, add boot phase tags to make the
> Device Trees usable for firmware/bootloaders without modification.
> 
> Supported boot devices are eMMC/SD card, SPI-NOR and USB (both mass
> storage and DFU). The I2C EEPROM is included to allow the firmware to
> select the correct RAM configuration for different TQMa64xxL variants.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts     | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> index 8f64d6272b1ba..81e9e047281fd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> @@ -167,6 +167,7 @@ reg_pwm_fan: regulator-pwm-fan {
>  	};
>  
>  	reg_sd: regulator-sd {
> +		bootph-all;

Here and elsewhere:

Per [1] boot-phase tags would need to go just after all the std/common
properties and just before vendor properties

[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&main_mmc1_reg_pins>;
> @@ -245,6 +246,7 @@ icssg1_phy0c: ethernet-phy@c {
>  
>  
>  &main_gpio0 {
> +	bootph-all;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_gpio0_digital_pins>,
>  		    <&main_gpio0_hog_pins>;
> @@ -263,6 +265,7 @@ &main_gpio0 {
>  };

 [...]
-- 
Regards
Vignesh
https://ti.com/opensource


