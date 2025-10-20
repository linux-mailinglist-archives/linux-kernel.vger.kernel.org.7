Return-Path: <linux-kernel+bounces-860055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F952BEF365
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A639E4E8564
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51F29D291;
	Mon, 20 Oct 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XRWn0q27"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7ED366;
	Mon, 20 Oct 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760932896; cv=none; b=P1+Wdr54XvTStkCjJcbOxVyKes8Q2eTikv4fP7JeJNapxfDyLsW9PJI8+TCGrbQDoJaZIDCZ7zpH9sBUkVXtRW2g+6iuO26nJ7OddV92PHn+TjO9dGdOjwOYAdYlnAJO9XNMQHlMLyPMi2hXfRhVi2/1BnVoR5mVf8nx0QfcqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760932896; c=relaxed/simple;
	bh=imY4wlUArt3zLLLNczi5EHtLMcrPw/snbyRfRoWCPwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I3UdjOT4vCdCeORlx+NVYvqaWS06Pd/U3ws6ewPed4ZJMliTU9JwpM1pj+gryujqnF31kF13igypRtOK1O8sEO93qoSLsxgB651SEDcYJrnKLcBA2wR2DPwn5BLXkgJ6tODVtS+cPhmsr0vKFveYEYcNhfCW3qHNEl4nj+LsSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XRWn0q27; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59K418ig2901560;
	Sun, 19 Oct 2025 23:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760932868;
	bh=TQfkxUrxX8ddnORdSu/cqX5CuTyJmbVu5Xn50AklgRg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XRWn0q27aGRVc9IRIdxUKar3bRHknsMltqHWcJ1QXkUK4vGpcK1etfjEFjpHdtmrB
	 E30pO6hn64cYDy8+YIuJ9PwCJVEJJ3AwvFNpa1ct+r2UfwNepapqXbfGCzkasRx4eh
	 uSBt9OZOSjrkrFp0emXDpNml+alWV9mdWzTdyvVU=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59K418Ng149657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 19 Oct 2025 23:01:08 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Oct
 2025 23:01:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 19 Oct 2025 23:01:07 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59K413xm1299387;
	Sun, 19 Oct 2025 23:01:04 -0500
Message-ID: <1bd8be6a-a6b0-43d3-ad55-a5bbeb3325a4@ti.com>
Date: Mon, 20 Oct 2025 09:31:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Fix I2C pinmux pull
 configuration
To: Aniket Limaye <a-limaye@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gehariprasath@ti.com>,
        <u-kumar1@ti.com>
References: <20251019103938.276062-1-a-limaye@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251019103938.276062-1-a-limaye@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 10/19/2025 4:09 PM, Aniket Limaye wrote:
> The I2C pins for some of the instances on J784S4/J742S2/AM69 are
> configured as PIN_INPUT_PULLUP while these pins are open-drain type and
> do not support internal pull-ups [0][1][2]. The pullup configuration
> bits in the corresponding padconfig registers are reserved and any
> writes to them have no effect and readback checks on those bits fail.
>
> Update the pinmux settings to use PIN_INPUT instead of PIN_INPUT_PULLUP
> to reflect the correct hardware behaviour.

Subject says, its Fix then Please use Fixes Tag

with that

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> [0]: https://www.ti.com/lit/gpn/tda4ah-q1 (J784S4 Datasheet: Table 5-1. Pin Attributes)
> [1]: https://www.ti.com/lit/gpn/tda4ape-q1 (J742S2 Datasheet: Table 5-1. Pin Attributes)
> [2]: https://www.ti.com/lit/gpn/am69a (AM69 Datasheet: Table 5-1. Pin Attributes)
>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts                   | 8 ++++----
>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 5896e57b5b9e..0e2d12cb051d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -236,8 +236,8 @@ J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
>   
>   	main_i2c0_pins_default: main-i2c0-default-pins {
>   		pinctrl-single,pins = <
> -			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
> -			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
> +			J784S4_IOPAD(0x0e0, PIN_INPUT, 0) /* (AN36) I2C0_SCL */
> +			J784S4_IOPAD(0x0e4, PIN_INPUT, 0) /* (AP37) I2C0_SDA */
>   		>;
>   	};
>   
> @@ -416,8 +416,8 @@ J784S4_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (J37) WKUP_GPIO0_12.MCU_UART0_TXD */
>   
>   	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
>   		pinctrl-single,pins = <
> -			J784S4_WKUP_IOPAD(0x0a0, PIN_INPUT_PULLUP, 0) /* (M35) MCU_I2C0_SCL */
> -			J784S4_WKUP_IOPAD(0x0a4, PIN_INPUT_PULLUP, 0) /* (G34) MCU_I2C0_SDA */
> +			J784S4_WKUP_IOPAD(0x0a0, PIN_INPUT, 0) /* (M35) MCU_I2C0_SCL */
> +			J784S4_WKUP_IOPAD(0x0a4, PIN_INPUT, 0) /* (G34) MCU_I2C0_SDA */
>   		>;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> index 419c1a70e028..2834f0a8bbee 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> @@ -270,8 +270,8 @@ J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
>   
>   	main_i2c0_pins_default: main-i2c0-default-pins {
>   		pinctrl-single,pins = <
> -			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
> -			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
> +			J784S4_IOPAD(0x0e0, PIN_INPUT, 0) /* (AN36) I2C0_SCL */
> +			J784S4_IOPAD(0x0e4, PIN_INPUT, 0) /* (AP37) I2C0_SDA */
>   		>;
>   	};
>   

