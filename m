Return-Path: <linux-kernel+bounces-864915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE958BFBD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC5618C2F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA543285C8B;
	Wed, 22 Oct 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GNhgCWOc"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623734164C;
	Wed, 22 Oct 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136167; cv=none; b=nXdrg/KXaRulqDRj8OAu5wNf038RXvf+PoVUcmtMJQtaPm8oCLJ384XPPf/eTFE+DSJ8fZORyxGJdp1BQg1nfjwapMFaT3hRyyv6bKW0qTNFzJ0OOwV0+pgTHtKQDrr7oqAmDRWPo0G1XT0O/qZ9mRpZSJa61GlVLtmjNISHiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136167; c=relaxed/simple;
	bh=UVBJpMa/QbguqBmGeofNe7qPcpk9/LnPPPKdBOMtg/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aHGRRsRi8O5W/pVDtSAoVU7cJBCzcu/K64dn9fbXHd24elOmqCU74tqc/XRP5KrU/aHKtREnNNjYtSf7zmqUsdh/URbsp8f9ODZjrfXvt678RWR86ZH4d/jGBnRvGP0PhZ+L3Krg2P/nfzgIkA88yQt/M1O0VweojFmbJetpl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GNhgCWOc; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MCTJ2D266088;
	Wed, 22 Oct 2025 07:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761136159;
	bh=ItdHM5JRzxCl5+hQXpEUXe7rdUyHEdLjMyQbQhS+/iA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GNhgCWOcU6ITTv0j1TQjhhAM3eeKnLS5g5j/zPpgC8zCg9ecH6KUEmJcl5sBOM/9E
	 V8O/NbbfljkLwejO1PtdQJU7d3ONxM+a8IL7wClh/F9sWsyfzMdVdYBHdoiGDuEbQ3
	 pYOMPzvjaU1imta8FvjhLdARvNLY08e51oSCOBVM=
Received: from DLEE214.ent.ti.com (dlee214.ent.ti.com [157.170.170.117])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MCTJbO1918962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 07:29:19 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 07:29:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 07:29:19 -0500
Received: from [172.24.234.127] (psdkl-workstation0.dhcp.ti.com [172.24.234.127])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MCTFq51177876;
	Wed, 22 Oct 2025 07:29:16 -0500
Message-ID: <2aeb5e65-b15e-4d34-a2f5-15393dd6972c@ti.com>
Date: Wed, 22 Oct 2025 17:59:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4: Fix I2C pinmux pull
 configuration
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <gehariprasath@ti.com>
References: <20251022121222.220113-1-a-limaye@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20251022121222.220113-1-a-limaye@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 22/10/25 17:41, Aniket Limaye wrote:
> The I2C pins for some of the instances on J784S4/J742S2/AM69 are
> configured as PIN_INPUT_PULLUP while these pins are open-drain type and
> do not support internal pull-ups [0][1][2]. The pullup configuration
> bits in the corresponding padconfig registers are reserved and any
> writes to them have no effect and readback checks on those bits fail.
> 
> Update the pinmux settings to use PIN_INPUT instead of PIN_INPUT_PULLUP
> to reflect the correct hardware behaviour.
> 
> [0]: https://www.ti.com/lit/gpn/tda4ah-q1 (J784S4 Datasheet: Table 5-1. Pin Attributes)
> [1]: https://www.ti.com/lit/gpn/tda4ape-q1 (J742S2 Datasheet: Table 5-1. Pin Attributes)
> [2]: https://www.ti.com/lit/gpn/am69a (AM69 Datasheet: Table 5-1. Pin Attributes)
> 
> Fixes: e20a06aca5c9 ("arm64: dts: ti: Add support for J784S4 EVM board")
> Fixes: 635fb18ba008 ("arch: arm64: dts: Add support for AM69 Starter Kit")
> Fixes: 0ec1a48d99dd ("arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header")
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>

Forgot to collect Udit's Reviewed-by
Resent a v3 at: 
https://lore.kernel.org/lkml/20251022122638.234367-1-a-limaye@ti.com/

> ---
> v2:
> - Added Fixes tags
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


