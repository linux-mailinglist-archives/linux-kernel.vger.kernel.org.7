Return-Path: <linux-kernel+bounces-809467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB04B50E02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9303B672B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C22D3740;
	Wed, 10 Sep 2025 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="uOdpXvC7"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D91B87E8;
	Wed, 10 Sep 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485521; cv=none; b=ipDNQG9HtFqG3BQOe9CfSBR3r1T1IgyV7ia1Y4YLEV6GwwPWPB4JdrWqLdAqCDQPXZHTe4BeNx0BeTrpIftQeVVrSoOthA6s0l1uleLctoWAS+XXz/Zo4+hXjSgG02MpkEpWe+TSL0ldoLnhommKfWjSpjSrAy2by49GawoQRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485521; c=relaxed/simple;
	bh=QnJOx01HWsmHieLN00ngWQ3oadJtIJDI67dNXlerAVM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqSgz6L5WmE7BOagDSsI7piMdR+sDomb1FMFtxtzkK6895I76Q6kU1uvr10tIxpXdL/GugEAEuMl6qkEU0aGSFvXk8dFabeK4C1McaWy7eTbbTsQ9he7zK8yCtSOzYGZSuhZcnEIjGeAqRluC2xkmhiynBLXzdedOWrxKzO6K3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=uOdpXvC7; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4E371486248;
	Wed, 10 Sep 2025 08:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1757485516;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=i2tkSNOBdYBLXot+Ags84Au0XUzpcxSTIhWXOCdWJ0E=;
	b=uOdpXvC7UsrRyFATUUsCuRvATr0NDjk+gRDkI/nvOQSVIvqekr0BndRJjhqWkc0CSSNXdk
	ikUUrjEbbKq2g3d4d9fCG6nW52KwmIruRs4N/Q40Jnqs4roLqNT1GoxH9U8T3/IaTOtYPa
	UWnPdajUd55RxyWpXkDGrhAxXmXYuX8ZTADFq2AgsQLyQ55c79spMR9bTRZfIhRSWPye1D
	HgWIyNamntDlegi4iVKtKizgsuMxN+DR6aFZABcf8Vo1OEB7Y73A9lgz9cu38z1sKtV5UJ
	J8JZ+OVg8MOPr50w6UEQfV/AZ4PeI+J+fChrEXtaLd5LywBLiGoWi16ECpsj3g==
Date: Wed, 10 Sep 2025 08:25:14 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: microchip: sama7d65: Add GPIO buttons and LEDs
Message-ID: <20250910-alkalize-overtime-930a59a7d169@thorsis.com>
Mail-Followup-To: Ryan.Wanner@microchip.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250909160842.392075-1-Ryan.Wanner@microchip.com>
 <20250910-retake-attic-ac1fe3429a1e@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-retake-attic-ac1fe3429a1e@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Ryan,

Am Wed, Sep 10, 2025 at 08:20:28AM +0200 schrieb Alexander Dahl:
> Hello Ryan,
> 
> Am Tue, Sep 09, 2025 at 09:08:38AM -0700 schrieb Ryan.Wanner@microchip.com:
> > From: Ryan Wanner <Ryan.Wanner@microchip.com>
> > 
> > Add the USER button as a GPIO input as well as add the LEDs and enable
> > the blue LED as a heartbeat.
> > 
> > Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> > ---
> >  .../dts/microchip/at91-sama7d65_curiosity.dts | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> > index f091cc40a9f0..2fe34c59d942 100644
> > --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> > +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> > @@ -11,6 +11,7 @@
> >  #include "sama7d65-pinfunc.h"
> >  #include "sama7d65.dtsi"
> >  #include <dt-bindings/mfd/atmel-flexcom.h>
> > +#include <dt-bindings/input/input.h>
> >  #include <dt-bindings/pinctrl/at91.h>
> >  
> >  / {
> > @@ -26,6 +27,42 @@ chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >  
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> > +
> > +		button {
> > +			label = "PB_USER";
> > +			gpios = <&pioa PIN_PC10 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_PROG1>;
> > +			wakeup-source;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> > +
> > +		led-red {
> > +			label = "red";
> > +			gpios = <&pioa PIN_PB17 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
> > +		};
> > +
> > +		led-green {
> > +			label = "green";
> > +			gpios = <&pioa PIN_PB15 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
> > +		};
> > +
> > +		led-blue {
> > +			label = "blue";
> > +			gpios = <&pioa PIN_PA21 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +	};
> 
> The label property is deprecated.  Please use the properties "color"
> and "function" for new boards.  See devicetree binding documentation
> for LEDs.

From a quick glance, this seems to be an RGB-LED, so I would suggest
to not model it as three distinct LEDs, but make use of the
"leds-group-multicolor" feature, example:

 59         multi-led {
 60                 compatible = "leds-group-multicolor";
 61                 color = <LED_COLOR_ID_RGB>;
 62                 function = LED_FUNCTION_INDICATOR;
 63                 leds = <&led_red>, <&led_green>, <&led_blue>;
 64         };

Greets
Alex

> 
> Thanks and greetings
> Alex
> 
> > +
> >  	memory@60000000 {
> >  		device_type = "memory";
> >  		reg = <0x60000000 0x40000000>;
> > @@ -352,6 +389,18 @@ pinctrl_i2c10_default: i2c10-default {
> >  		bias-pull-up;
> >  	};
> >  
> > +	pinctrl_key_gpio_default: key-gpio-default {
> > +		pinmux = <PIN_PC10__GPIO>;
> > +		bias-pull-up;
> > +	};
> > +
> > +	pinctrl_led_gpio_default: led-gpio-default {
> > +		pinmux = <PIN_PB15__GPIO>,
> > +			 <PIN_PB17__GPIO>,
> > +			 <PIN_PA21__GPIO>;
> > +		bias-pull-up;
> > +	};
> > +
> >  	pinctrl_sdmmc1_default: sdmmc1-default {
> >  		cmd-data {
> >  			pinmux = <PIN_PB22__SDMMC1_CMD>,
> > -- 
> > 2.43.0
> > 
> > 
> 

