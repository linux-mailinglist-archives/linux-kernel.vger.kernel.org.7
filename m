Return-Path: <linux-kernel+bounces-846755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B96BC8F04
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20510350D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460732D73B9;
	Thu,  9 Oct 2025 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxxhAz99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552E1EA7CE;
	Thu,  9 Oct 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011397; cv=none; b=BDc8TcC++j+ch5ZkG9w4a1dYQcJiqvD3mNyQiyT24+vcgmTyNmyeb82mJt4A99zTrCCMfTWnRyoUnIuiHKE6kmj9yFtHzw/ObuNHqNuksqmQWwMmCxW3Jf7JQVGRdjzh2SPm8Wlj+7CSW7E/J0H8N96vNfZk+phnFlar9bAOwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011397; c=relaxed/simple;
	bh=CdsaUPoqlbF9PCKAuHft+0rfSUAHjboVmGpvzfRTZS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7dAyG4BP70O37kWmRH9owwWevuF7tGQHIX+0M8IRxGof3ErDgw3J5pLIPDFgQfRoXh7TCJRidts+jvAiBxwrzNUAUrRU/aBtSw1cjdt3cy3B1xDGUPP+eKaE8j+msQBGNVd4xT0RlbePVZUSxdzCaq3nDcapkP3cbx8n0yZ4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxxhAz99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED502C4CEE7;
	Thu,  9 Oct 2025 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760011395;
	bh=CdsaUPoqlbF9PCKAuHft+0rfSUAHjboVmGpvzfRTZS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxxhAz99MDwMzsawBLSKlI5HZ6NuVf1gj1lpJSD6+FiEKr/0khNPWbBKte/LZW2eW
	 Wmu27hAfd3YvVQvCLmBi4Y4y1A+M5XSi5me4FURW5XukF71D8+UZkFZIwm5QUnnjMi
	 9xk4bXgXW4ges7sghgICNyEjG/5P1WZKt9h7gBSuaBINQfadJhf/9Jk1tGT6EEmi+r
	 KXpaMlOZLiOiNkIe+RzMS50n7JQM9Qh4Qw4Ee3dx3IZst8blIA7b+qqzlgOsORRcrK
	 XDX2sPWfD9KY8R+IDuzRdVs0wMddJdV2pnF7iGAUydRQ3n/ZgyVH7+F1wGFautT0gt
	 oblY90iRiwGig==
Date: Thu, 9 Oct 2025 13:03:11 +0100
From: Lee Jones <lee@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v3 3/4] led: sony-cronos-cpld: Add RGB LED driver for
 Sony Cronos  CPLD
Message-ID: <20251009120311.GE8757@google.com>
References: <853154551.1748566.1758824300948.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <853154551.1748566.1758824300948.JavaMail.zimbra@raptorengineeringinc.com>

On Thu, 25 Sep 2025, Timothy Pearson wrote:

> The Sony Cronos Platform Controller CPLD is a multi-purpose platform controller
> with an integrated multi-channel RGB LED controller.  The LED controller is a
> pseudo-RGB device with only two states for each of the RGB subcomponents of
> each LED, but is exposed as a full RGB device for ease of integration with
> userspace software.  Internal thresholding is used to convert the color values
> to the required on/off RGB subcomponent controls.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  drivers/leds/Kconfig            |  19 ++
>  drivers/leds/Makefile           |   1 +
>  drivers/leds/leds-sony-cronos.c | 402 ++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/leds/leds-sony-cronos.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6e3dce7e35a4..9df51d94f185 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -1013,6 +1013,25 @@ config LEDS_IP30
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-ip30.
>  
> +config LEDS_SONY_CRONOS
> +	tristate "LED support for Sony Cronos CPLD"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on LEDS_CLASS && I2C
> +	depends on LEDS_CLASS_MULTICOLOR
> +	depends on MFD_SONY_CRONOS_CPLD
> +
> +	help
> +	  Say Y here to include support for LEDs for the
> +	  Sony Cronos control CPLD.
> +
> +	  All known Cronos systems use the ASpeed AST2600 SoC,
> +	  therefore the configuration option is gated on
> +	  ARCH_ASPEED selection.  If this changes, add the new
> +	  SoCs to the selection list.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-sony-cronos.
> +
>  config LEDS_ACER_A500
>  	tristate "Power button LED support for Acer Iconia Tab A500"
>  	depends on LEDS_CLASS && MFD_ACER_A500_EC
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 9a0333ec1a86..6dbcf747cab6 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
>  obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
>  obj-$(CONFIG_LEDS_QNAP_MCU)		+= leds-qnap-mcu.o
>  obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
> +obj-$(CONFIG_LEDS_SONY_CRONOS)		+= leds-sony-cronos.o
>  obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
>  obj-$(CONFIG_LEDS_ST1202)		+= leds-st1202.o
>  obj-$(CONFIG_LEDS_SUN50I_A100)		+= leds-sun50i-a100.o
> diff --git a/drivers/leds/leds-sony-cronos.c b/drivers/leds/leds-sony-cronos.c
> new file mode 100644
> index 000000000000..2544187cea36
> --- /dev/null
> +++ b/drivers/leds/leds-sony-cronos.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LED driver for Sony Cronos CPLDs
> + * Copyright (C) 2012 Dialog Semiconductor Ltd.
> + * Copyright (C) 2023 Sony Interactive Entertainment
> + * Copyright (C) 2025 Raptor Engineering, LLC
> + *

Drop the empty line.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/sony/cronos/core.h>
> +#include <linux/mfd/sony/cronos/registers.h>

Alphabetical.

> +/* Masks and Bit shifts */

This is obvious from the nomenclature.

> +#define CRONOS_LEDS_STATUS_FLASHING_MASK 0x40

Tab out the values please.

> +#define CRONOS_LEDS_STATUS_FLASHING_SHIFT 6
> +#define CRONOS_LEDS_STATUS_COLOR_MASK 0x07
> +#define CRONOS_LEDS_STATUS_COLOR_SHIFT 0
> +
> +#define CRONOS_LEDS_LINK_FLASHING_MASK 0x80
> +#define CRONOS_LEDS_LINK_FLASHING_SHIFT 7
> +#define CRONOS_LEDS_LINK_COLOR_MASK 0x38
> +#define CRONOS_LEDS_LINK_COLOR_SHIFT 3
> +
> +#define CRONOS_LEDS_CCM1_POWER_COLOR_MASK 0x03
> +#define CRONOS_LEDS_CCM1_POWER_COLOR_SHIFT 0
> +#define CRONOS_LEDS_CCM2_POWER_COLOR_MASK 0x0C
> +#define CRONOS_LEDS_CCM2_POWER_COLOR_SHIFT 2
> +#define CRONOS_LEDS_CCM3_POWER_COLOR_MASK 0x30
> +#define CRONOS_LEDS_CCM3_POWER_COLOR_SHIFT 4
> +#define CRONOS_LEDS_CCM4_POWER_COLOR_MASK 0xC0
> +#define CRONOS_LEDS_CCM4_POWER_COLOR_SHIFT 6
> +
> +/* LED Color mapping - Links and status LEDs */
> +#define LED_COLOR_OFF 0x00
> +#define LED_COLOR_RED 0x04
> +#define LED_COLOR_GREEN 0x02
> +#define LED_COLOR_BLUE 0x01

In order?

> +
> +/* LED Color mapping - Power state LEDs */
> +#define LED_COLOR_POWER_OFF 0x00
> +#define LED_COLOR_POWER_RED 0x02
> +#define LED_COLOR_POWER_GREEN 0x01
> +
> +/* Number of LEDs per type */
> +#define LED_COUNT_STATUS 6
> +#define LED_COUNT_LINK 5
> +#define LED_COUNT_POWER 4
> +#define LED_COUNT_ALL (LED_COUNT_STATUS + LED_COUNT_LINK + LED_COUNT_POWER)
> +
> +enum sony_cronos_led_id {
> +	LED_ID_CCM1_STATUS = 0x00,
> +	LED_ID_CCM2_STATUS,
> +	LED_ID_CCM3_STATUS,
> +	LED_ID_CCM4_STATUS,
> +	LED_ID_SWITCH_STATUS,
> +	LED_ID_SMC_STATUS,
> +
> +	LED_ID_CCM1_LINK, /* 6 - 10 */
> +	LED_ID_CCM2_LINK,
> +	LED_ID_CCM3_LINK,
> +	LED_ID_CCM4_LINK,
> +	LED_ID_SWITCH_LINK,
> +
> +	LED_ID_CCM1_POWER, /* 11 - 14 */
> +	LED_ID_CCM2_POWER,
> +	LED_ID_CCM3_POWER,
> +	LED_ID_CCM4_POWER,
> +
> +	LED_ID_COUNT, /* Number of LEDs */

This comment is superfluous (as are the numbers above IMHO).

> +};
> +
> +enum sony_cronos_led_type {
> +	LED_TYPE_STATUS,
> +	LED_TYPE_LINK,
> +	LED_TYPE_POWER,
> +};
> +
> +/**
> + * struct sony_cronos_led - per-LED part of driver private data structure
> + * @mc_cdev:		multi-color LED class device
> + * @subled_info:	per-channel information
> + * @led_register:	led register in the MFD regmap
> + * @led_type:		sie_cronos_led_type
> + * @led_id:		sie_cronos_led_id
> + */
> +struct sony_cronos_led {
> +	struct led_classdev_mc mc_cdev;
> +	struct mc_subled subled_info[LED_COUNT_ALL];
> +	u8 led_register;
> +	enum sony_cronos_led_type led_type;
> +	enum sony_cronos_led_id led_id;
> +};
> +
> +#define to_cronos_led(l) container_of(l, struct sony_cronos_led, mc_cdev)
> +
> +/**
> + * struct sony_cronos_leds - driver private data structure
> + * @hw:				handle to hw device
> + * @leds:			flexible array of per-LED data
> + */
> +struct sony_cronos_leds {
> +	struct sony_cronos_cpld *hw;
> +	struct sony_cronos_led leds[];
> +};
> +
> +static int cronos_led_color_store(struct sony_cronos_cpld *chip,
> +				  struct sony_cronos_led *led)

Use 100-chars throughout.

> +{
> +	u8 byte;
> +	u8 color_mask;
> +	u8 color_shift;
> +	u8 color_key_red;
> +	u8 color_key_green;
> +	u8 color_key_blue;
> +	int ret;
> +
> +	if (led->led_type == LED_TYPE_STATUS) {
> +		color_mask = CRONOS_LEDS_STATUS_COLOR_MASK;
> +		color_shift = CRONOS_LEDS_STATUS_COLOR_SHIFT;
> +	} else if (led->led_type == LED_TYPE_LINK) {
> +		color_mask = CRONOS_LEDS_LINK_COLOR_MASK;
> +		color_shift = CRONOS_LEDS_LINK_COLOR_SHIFT;
> +	} else if (led->led_id == LED_ID_CCM1_POWER) {
> +		color_mask = CRONOS_LEDS_CCM1_POWER_COLOR_MASK;
> +		color_shift = CRONOS_LEDS_CCM1_POWER_COLOR_SHIFT;
> +	} else if (led->led_id == LED_ID_CCM2_POWER) {
> +		color_mask = CRONOS_LEDS_CCM2_POWER_COLOR_MASK;
> +		color_shift = CRONOS_LEDS_CCM2_POWER_COLOR_SHIFT;
> +	} else if (led->led_id == LED_ID_CCM3_POWER) {
> +		color_mask = CRONOS_LEDS_CCM3_POWER_COLOR_MASK;
> +		color_shift = CRONOS_LEDS_CCM3_POWER_COLOR_SHIFT;
> +	} else if (led->led_id == LED_ID_CCM4_POWER) {
> +		color_mask = CRONOS_LEDS_CCM4_POWER_COLOR_MASK;
> +		color_shift = CRONOS_LEDS_CCM4_POWER_COLOR_SHIFT;
> +	} else
> +		return ret;
> +
> +	switch (led->led_type) {
> +	case LED_TYPE_POWER:
> +		color_key_red = LED_COLOR_POWER_RED;
> +		color_key_green = LED_COLOR_POWER_GREEN;
> +		/* Blue channel does not exist for CCM power LEDs */
> +		color_key_blue = LED_COLOR_POWER_OFF;
> +		break;
> +	default:
> +		color_key_red = LED_COLOR_RED;
> +		color_key_green = LED_COLOR_GREEN;
> +		color_key_blue = LED_COLOR_BLUE;
> +	}
> +
> +	/* Assemble CPLD color command code */
> +	byte = 0;

LED_COLOR_POWER_OFF

> +	if (led->subled_info[0].brightness > 128)
> +		byte |= color_key_red;
> +	if (led->subled_info[1].brightness > 128)
> +		byte |= color_key_green;
> +	if (led->subled_info[2].brightness > 128)
> +		byte |= color_key_blue;
> +
> +	ret = regmap_update_bits(chip->regmap, led->led_register, color_mask,
> +				 byte << color_shift);
> +	if (ret) {
> +		dev_err(chip->dev,
> +			"Failed to write value 0x%02x to address 0x%02x", byte,

Can we make this less generic.

"Failed to set color value 0x%02x to LED register 0x%02x"

> +			led->led_register);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t cronos_led_set_brightness(struct led_classdev *cdev,
> +					 enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct sony_cronos_leds *leds = dev_get_drvdata(cdev->dev->parent);
> +	struct sony_cronos_led *led = to_cronos_led(mc_cdev);
> +
> +	led_mc_calc_color_components(mc_cdev,
> +				     brightness ?: cdev->max_brightness);
> +
> +	return cronos_led_color_store(leds->hw, led);
> +}
> +
> +static int sony_cronos_led_register(struct device *dev,
> +				    struct sony_cronos_leds *leds,
> +				    struct sony_cronos_led *led,
> +				    struct device_node *np)
> +{
> +	struct led_init_data init_data = {};
> +	struct led_classdev *cdev;
> +	int led_index;
> +	int ret, color;
> +
> +	ret = of_property_read_u32(np, "reg", &led_index);
> +	if (ret || led_index >= LED_COUNT_ALL) {
> +		dev_warn(

dev_err()

> +			dev,
> +			"Node %pOF: must contain 'reg' property with values between 0 and %i\n",

"'reg' property is out of range (0-%i)\n"

> +			np, LED_COUNT_ALL - 1);
> +		return 0;

-EINVAL

> +	}
> +
> +	switch (led_index) {
> +	case 0:
> +		led->led_register = CRONOS_LEDS_CCM1_STATUS_REG;
> +		led->led_type = LED_TYPE_STATUS;
> +		led->led_id = LED_ID_CCM1_STATUS;

Since all of these plus color_{shift,mask} are static data, I would set
them all up as such.  We don't need to be doing any of this checking at
runtime.

> +		break;
> +	case 1:
> +		led->led_register = CRONOS_LEDS_CCM2_STATUS_REG;
> +		led->led_type = LED_TYPE_STATUS;
> +		led->led_id = LED_ID_CCM2_STATUS;
> +		break;
> +	case 2:
> +		led->led_register = CRONOS_LEDS_CCM3_STATUS_REG;
> +		led->led_type = LED_TYPE_STATUS;
> +		led->led_id = LED_ID_CCM3_STATUS;
> +		break;
> +	case 3:
> +		led->led_register = CRONOS_LEDS_CCM4_STATUS_REG;
> +		led->led_type = LED_TYPE_STATUS;
> +		led->led_id = LED_ID_CCM4_STATUS;
> +		break;
> +	case 4:
> +		led->led_register = CRONOS_LEDS_SWITCH_STATUS_REG;
> +		led->led_type = LED_TYPE_STATUS;
> +		led->led_id = LED_ID_SWITCH_STATUS;
> +		break;
> +	case 5:
> +		led->led_register = CRONOS_LEDS_SMC_STATUS_REG;
> +		led->led_type = LED_TYPE_STATUS;
> +		led->led_id = LED_ID_SMC_STATUS;
> +		break;
> +	case 6:
> +		led->led_register = CRONOS_LEDS_CCM1_STATUS_REG;
> +		led->led_type = LED_TYPE_LINK;
> +		led->led_id = LED_ID_CCM1_LINK;
> +		break;
> +	case 7:
> +		led->led_register = CRONOS_LEDS_CCM2_STATUS_REG;
> +		led->led_type = LED_TYPE_LINK;
> +		led->led_id = LED_ID_CCM1_LINK;
> +		break;
> +	case 8:
> +		led->led_register = CRONOS_LEDS_CCM3_STATUS_REG;
> +		led->led_type = LED_TYPE_LINK;
> +		led->led_id = LED_ID_CCM2_LINK;
> +		break;
> +	case 9:
> +		led->led_register = CRONOS_LEDS_CCM4_STATUS_REG;
> +		led->led_type = LED_TYPE_LINK;
> +		led->led_id = LED_ID_CCM3_LINK;
> +		break;
> +	case 10:
> +		led->led_register = CRONOS_LEDS_SWITCH_STATUS_REG;
> +		led->led_type = LED_TYPE_LINK;
> +		led->led_id = LED_ID_CCM4_LINK;
> +		break;
> +	case 11:
> +		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
> +		led->led_type = LED_TYPE_POWER;
> +		led->led_id = LED_ID_CCM1_POWER;
> +		break;
> +	case 12:
> +		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
> +		led->led_type = LED_TYPE_POWER;
> +		led->led_id = LED_ID_CCM2_POWER;
> +		break;
> +	case 13:
> +		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
> +		led->led_type = LED_TYPE_POWER;
> +		led->led_id = LED_ID_CCM3_POWER;
> +		break;
> +	case 14:
> +		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
> +		led->led_type = LED_TYPE_POWER;
> +		led->led_id = LED_ID_CCM4_POWER;
> +		break;
> +	default:
> +		return 0;

This should fail.

> +	}
> +
> +	ret = of_property_read_u32(np, "color", &color);
> +	if (ret || color != LED_COLOR_ID_RGB) {
> +		dev_warn(
> +			dev,
> +			"Node %pOF: must contain 'color' property with value LED_COLOR_ID_RGB\n",

If it's the only supported value, why does it even exist?

> +			np);
> +		return 0;

This should fail.

> +	}
> +
> +	led->subled_info[0].color_index = LED_COLOR_ID_RED;
> +	led->subled_info[1].color_index = LED_COLOR_ID_GREEN;
> +	led->subled_info[2].color_index = LED_COLOR_ID_BLUE;
> +
> +	/* Initial color is white */
> +	for (int i = 0; i < LED_COUNT_ALL; ++i) {

Why are we pre-incrementing?

> +		led->subled_info[i].intensity = 255;
> +		led->subled_info[i].brightness = 255;
> +		led->subled_info[i].channel = i;
> +	}
> +
> +	led->mc_cdev.subled_info = led->subled_info;
> +	led->mc_cdev.num_colors = LED_COUNT_ALL;
> +
> +	init_data.fwnode = &np->fwnode;
> +
> +	cdev = &led->mc_cdev.led_cdev;
> +	cdev->max_brightness = 255;
> +	cdev->brightness_set_blocking = cronos_led_set_brightness;
> +
> +	/* Set initial color and cache it */

What do you mean by cahche it?

> +	ret = cronos_led_color_store(leds->hw, led);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot set LED %pOF initial color\n", np);

Why are we using Device Tree names?

> +	ret = devm_led_classdev_multicolor_register_ext(dev, &led->mc_cdev,
> +							&init_data);
> +	if (ret < 0)

Just if (ret) should do.

> +		return dev_err_probe(dev, ret, "Cannot register LED %pOF\n",
> +				     np);
> +
> +	/* Set global brightness for all LEDs */
> +	ret = regmap_write(leds->hw->regmap, CRONOS_CPLD_BRIGHTNESS_RED_REG,
> +			   0x00);
> +	ret = regmap_write(leds->hw->regmap, CRONOS_CPLD_BRIGHTNESS_GREEN_REG,
> +			   0x00);
> +	ret = regmap_write(leds->hw->regmap, CRONOS_CPLD_BRIGHTNESS_BLUE_REG,
> +			   0x00);
> +
> +	return 1;

return 0;

> +}
> +
> +static int sony_cronos_leds_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct sony_cronos_cpld *chip;
> +	struct sony_cronos_leds *leds;
> +	struct sony_cronos_led *led;
> +	int ret, count;
> +
> +	chip = dev_get_drvdata(dev->parent);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	count = of_get_available_child_count(np);
> +	if (count == 0)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "LEDs are not defined in device tree!\n");
> +	if (count > LED_COUNT_ALL)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Too many LEDs defined in device tree!\n");
> +
> +	leds = devm_kzalloc(dev, struct_size(leds, leds, count), GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	leds->hw = chip;
> +
> +	led = &leds->leds[0];
> +	for_each_available_child_of_node_scoped(np, child) {
> +		ret = sony_cronos_led_register(dev, leds, led, child);
> +		if (ret < 0)

if (ret)

> +			return ret;
> +
> +		led += ret;

led++;

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sony_cronos_led_of_id_table[] = {
> +	{
> +		.compatible = "sie,cronos-led",
> +	},

These three lines should be on just one.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sony_cronos_led_of_id_table);
> +
> +static struct platform_driver sony_cronos_led_driver = {
> +	.driver = {
> +		.name = "sie-cronos-led",
> +		.of_match_table = sony_cronos_led_of_id_table,
> +	},
> +	.probe		= sony_cronos_leds_probe,

No need to table this out - what is it even aligned with?

> +};
> +

Remove this line.

> +module_platform_driver(sony_cronos_led_driver);
> +
> +MODULE_DESCRIPTION("LED driver for SIE Cronos CPLDs");
> +MODULE_AUTHOR("Timothy Pearson <tpearson@raptorengineering.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:sony-cronos-leds");
> -- 
> 2.39.5

-- 
Lee Jones [李琼斯]

