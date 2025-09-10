Return-Path: <linux-kernel+bounces-809463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEACB50DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CDE545AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C652730596B;
	Wed, 10 Sep 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Wxrpa7B4"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA00213E9F;
	Wed, 10 Sep 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485246; cv=none; b=Tg6p9eC6bNqQSOJecmvRMCm9VgOmSjH0rCzTkLdLQ3dZl6Tf7rrUzWrLBuT0okapqfD86v4aUt1dJTJDmFLHHYUdymWVeTMB1pPPGjShTBkQYvmslkhXJcBfmyT+XoofJCYGDXhvh/eaZFmhh9AdLe9YNbViCyoxbVeWUe5mCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485246; c=relaxed/simple;
	bh=uPHddWIsxVWs59gR/d09rB8RiyVGwuLFe0sZqG5gM50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRjBvCzB22QYyrKwph3Ijgk9rTUTkzn+2VqgS1ApaoTsZ4q0r8qEsbSB4vYqgOhjzTdwQQc5svTEEPpyfZU5cHm5sHo9aI4pCVp2+hawOkp7opIx7vb8tGgKXDJK1yRx9QrI/fJeJvBT/o13VEqNJdxAKCsRmjL13T76Dru+9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Wxrpa7B4; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC0AA148625E;
	Wed, 10 Sep 2025 08:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1757485234; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YzWEaq7fc9RZr840kPRXsnWFetoKfBv/D8xt+yJ4/m0=;
	b=Wxrpa7B4yLX38x0eHaGOBvhBP8zgjpKgAmymznTrEEINHHmzs/6cH+rr/UCWjlLw99ye0n
	PY0YQUb0CeQ1ZLEPbSU5FOgl1darrlVde4qvytBwDAp/WCuIzj/sc1NEgQL1/BDQGY+V0p
	5r2CFv3Pnxz5PrAUWJf9MPs0BkM7PoGBWoKphz891fRQVpq7BRsOMygUYtL0Nc9M9KJfSe
	xxjpewAOHzMZUPmlXJomz8UtepPTMd/iQR2T8ygsBaOzO0ZdgH0kJX/xLksxNy8u1D8rDR
	n6Oq10xvUlopELrrqh5Gdk7rEEf2lx8RteATdOWswheCNNi0nVfEgUhl5SiWWA==
Date: Wed, 10 Sep 2025 08:20:28 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: microchip: sama7d65: Add GPIO buttons and LEDs
Message-ID: <20250910-retake-attic-ac1fe3429a1e@thorsis.com>
Mail-Followup-To: Ryan.Wanner@microchip.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250909160842.392075-1-Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909160842.392075-1-Ryan.Wanner@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Ryan,

Am Tue, Sep 09, 2025 at 09:08:38AM -0700 schrieb Ryan.Wanner@microchip.com:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add the USER button as a GPIO input as well as add the LEDs and enable
> the blue LED as a heartbeat.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../dts/microchip/at91-sama7d65_curiosity.dts | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> index f091cc40a9f0..2fe34c59d942 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> @@ -11,6 +11,7 @@
>  #include "sama7d65-pinfunc.h"
>  #include "sama7d65.dtsi"
>  #include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/at91.h>
>  
>  / {
> @@ -26,6 +27,42 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +		button {
> +			label = "PB_USER";
> +			gpios = <&pioa PIN_PC10 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> +
> +		led-red {
> +			label = "red";
> +			gpios = <&pioa PIN_PB17 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
> +		};
> +
> +		led-green {
> +			label = "green";
> +			gpios = <&pioa PIN_PB15 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
> +		};
> +
> +		led-blue {
> +			label = "blue";
> +			gpios = <&pioa PIN_PA21 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};

The label property is deprecated.  Please use the properties "color"
and "function" for new boards.  See devicetree binding documentation
for LEDs.

Thanks and greetings
Alex

> +
>  	memory@60000000 {
>  		device_type = "memory";
>  		reg = <0x60000000 0x40000000>;
> @@ -352,6 +389,18 @@ pinctrl_i2c10_default: i2c10-default {
>  		bias-pull-up;
>  	};
>  
> +	pinctrl_key_gpio_default: key-gpio-default {
> +		pinmux = <PIN_PC10__GPIO>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_led_gpio_default: led-gpio-default {
> +		pinmux = <PIN_PB15__GPIO>,
> +			 <PIN_PB17__GPIO>,
> +			 <PIN_PA21__GPIO>;
> +		bias-pull-up;
> +	};
> +
>  	pinctrl_sdmmc1_default: sdmmc1-default {
>  		cmd-data {
>  			pinmux = <PIN_PB22__SDMMC1_CMD>,
> -- 
> 2.43.0
> 
> 

