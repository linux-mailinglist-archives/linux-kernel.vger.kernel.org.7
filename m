Return-Path: <linux-kernel+bounces-810742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA47B51EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162A41C87C34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597CC27990B;
	Wed, 10 Sep 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pQRs/3ZK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC413774D;
	Wed, 10 Sep 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524613; cv=none; b=DgCfyaAaGgnUDn7X1KqJhK2RlZ2YSKXFGhWcO7lSHWHcartskgkHRVI7QgviRkvtNfm+1gbcTM52X5Wgod+zwaNN+5YWznT5zRFFUz/zdY29m0c00o0EqAcYXpf7XWM5n7iPWEQM/knydB/Sxl6hSG9Do3rQ6nckBrkkFxytiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524613; c=relaxed/simple;
	bh=LWiTpviXtSxA2uLJhCTluREzykCtzO584HqazV0nCCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u/8nBb41TIBPqM14eC3Ka5dLHElPL0KFodFy9/WcufcRYK5H6Wnh27Scz6xrLS+7kVmCLo/sdstsE5u+cdOSGknb4Gp9Ev+T5N0dftRRmdMHv3G1FwgwBshBtWnsYHvUMA0cumRgEoszHcI643z8/D0PfTUfgQf94MAzdSnWNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pQRs/3ZK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757524613; x=1789060613;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LWiTpviXtSxA2uLJhCTluREzykCtzO584HqazV0nCCw=;
  b=pQRs/3ZK3VtuzkNtam0AHwRyXm7WlH7YSh7ZPynwZJRzikOp9Y/maxC7
   hFZkIATza3v05f9UtMdTAGgkhKlXoF+mvx45nGk8ailLXZ4/6ku7O/cW0
   AxCwS48Yl4vAyLWfvRvP6Se8H4sKDAxGC1njKLPZehTCCZw8A1uWPDMae
   ir5T9Wn3+vCj9bbnqkPoDR/8kQJtZ66VrJyVgcrSYSPuy97RgeKW1DuDK
   Gp0DlMX5eGOUumWOyGvOF3kHq91ZlnLXsX2ygrpXg6aDJ0RPw2JV0CfaB
   ZNNxfpZbpRTOJD7KDxAeIB0pL+h/m7FpdQJhmaQXXGkk15KVEqaqornxt
   A==;
X-CSE-ConnectionGUID: GzHJBcSSS/ufTmRbnewvdg==
X-CSE-MsgGUID: J9J1N0KkTMGJXEg7AK49uA==
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="277704208"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2025 10:16:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 10 Sep 2025 10:16:04 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 10 Sep 2025 10:16:04 -0700
Message-ID: <fa5d44ca-d1ea-4c72-a998-b10f098b25f8@microchip.com>
Date: Wed, 10 Sep 2025 10:16:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama7d65: Add GPIO buttons and LEDs
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250909160842.392075-1-Ryan.Wanner@microchip.com>
 <20250910-retake-attic-ac1fe3429a1e@thorsis.com>
 <20250910-alkalize-overtime-930a59a7d169@thorsis.com>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <20250910-alkalize-overtime-930a59a7d169@thorsis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 9/9/25 23:25, Alexander Dahl wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello Ryan,
> 
> Am Wed, Sep 10, 2025 at 08:20:28AM +0200 schrieb Alexander Dahl:
>> Hello Ryan,
>>
>> Am Tue, Sep 09, 2025 at 09:08:38AM -0700 schrieb Ryan.Wanner@microchip.com:
>>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>
>>> Add the USER button as a GPIO input as well as add the LEDs and enable
>>> the blue LED as a heartbeat.
>>>
>>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>>> ---
>>>  .../dts/microchip/at91-sama7d65_curiosity.dts | 49 +++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
>>> index f091cc40a9f0..2fe34c59d942 100644
>>> --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
>>> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
>>> @@ -11,6 +11,7 @@
>>>  #include "sama7d65-pinfunc.h"
>>>  #include "sama7d65.dtsi"
>>>  #include <dt-bindings/mfd/atmel-flexcom.h>
>>> +#include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/pinctrl/at91.h>
>>>
>>>  / {
>>> @@ -26,6 +27,42 @@ chosen {
>>>             stdout-path = "serial0:115200n8";
>>>     };
>>>
>>> +   gpio-keys {
>>> +           compatible = "gpio-keys";
>>> +
>>> +           pinctrl-names = "default";
>>> +           pinctrl-0 = <&pinctrl_key_gpio_default>;
>>> +
>>> +           button {
>>> +                   label = "PB_USER";
>>> +                   gpios = <&pioa PIN_PC10 GPIO_ACTIVE_LOW>;
>>> +                   linux,code = <KEY_PROG1>;
>>> +                   wakeup-source;
>>> +           };
>>> +   };
>>> +
>>> +   leds {
>>> +           compatible = "gpio-leds";
>>> +           pinctrl-names = "default";
>>> +           pinctrl-0 = <&pinctrl_led_gpio_default>;
>>> +
>>> +           led-red {
>>> +                   label = "red";
>>> +                   gpios = <&pioa PIN_PB17 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
>>> +           };
>>> +
>>> +           led-green {
>>> +                   label = "green";
>>> +                   gpios = <&pioa PIN_PB15 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
>>> +           };
>>> +
>>> +           led-blue {
>>> +                   label = "blue";
>>> +                   gpios = <&pioa PIN_PA21 GPIO_ACTIVE_HIGH>;
>>> +                   linux,default-trigger = "heartbeat";
>>> +           };
>>> +   };
>>
>> The label property is deprecated.  Please use the properties "color"
>> and "function" for new boards.  See devicetree binding documentation
>> for LEDs.
> 
> From a quick glance, this seems to be an RGB-LED, so I would suggest
> to not model it as three distinct LEDs, but make use of the
> "leds-group-multicolor" feature, example:
> 
>  59         multi-led {
>  60                 compatible = "leds-group-multicolor";
>  61                 color = <LED_COLOR_ID_RGB>;
>  62                 function = LED_FUNCTION_INDICATOR;
>  63                 leds = <&led_red>, <&led_green>, <&led_blue>;
>  64         };

I see, I was not aware of this feature. This would combine all of the
LED pins into one RGB light correct, it seems from sysfs that this is
the case.

Would having the default-trigger="heartbeat" still be allowed for the
led-blue node or should that be moved into the multi-led node? From the
bindings it seems that the default trigger is still in the gpio-led nodes.

Best,
Ryan
> 
> Greets
> Alex
> 
>>
>> Thanks and greetings
>> Alex
>>
>>> +
>>>     memory@60000000 {
>>>             device_type = "memory";
>>>             reg = <0x60000000 0x40000000>;
>>> @@ -352,6 +389,18 @@ pinctrl_i2c10_default: i2c10-default {
>>>             bias-pull-up;
>>>     };
>>>
>>> +   pinctrl_key_gpio_default: key-gpio-default {
>>> +           pinmux = <PIN_PC10__GPIO>;
>>> +           bias-pull-up;
>>> +   };
>>> +
>>> +   pinctrl_led_gpio_default: led-gpio-default {
>>> +           pinmux = <PIN_PB15__GPIO>,
>>> +                    <PIN_PB17__GPIO>,
>>> +                    <PIN_PA21__GPIO>;
>>> +           bias-pull-up;
>>> +   };
>>> +
>>>     pinctrl_sdmmc1_default: sdmmc1-default {
>>>             cmd-data {
>>>                     pinmux = <PIN_PB22__SDMMC1_CMD>,
>>> --
>>> 2.43.0
>>>
>>>
>>


