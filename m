Return-Path: <linux-kernel+bounces-829488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5069B972F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F6D2A759A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACA2FFDCA;
	Tue, 23 Sep 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wGEjUWqr"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A732FE07D;
	Tue, 23 Sep 2025 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651899; cv=none; b=s8lBAacQfZps1rZdDIJpoN4MbDw4PJ+7at8TCd7tf0XPMV+OGVXbolWvyqUg4ASBFB1/tGgOgCn+MRGtHC49feX0VOo9uhd4zh0scrrA+VuwgmaNzBHEOfh1zO4I+8JUuI1Hzs1xQjkg66uHRNFMsceDWJOOTAKr7efIicCMthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651899; c=relaxed/simple;
	bh=5B61jvbeT8Yx+UdSilRu/10F9vP6o9WlW3ZoQvw/so8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibLgpdgiWw1/2P6OVUYxX/EaVJJvREVcCLMY/LQpLGb3Z1LHIqHdLVE6NKqo6JRuIEb69HUTU5ZXV7TUxIVhe9w7xeE9aD9B7kMLrgGUXnQ096H+/2/3r633EKAifLKtBpoCrXNDDj7pNmFmxU7NYFtcVgSYUrekVXnS+FyfMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wGEjUWqr; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NIOpxd1060695;
	Tue, 23 Sep 2025 13:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758651891;
	bh=X16rRHoKfCSbZItoPOGe7fywVo5/NmcvRhAc0KeeKr0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wGEjUWqr1pxipcBjxsnWQqeZ+3iV/gDNX6s7XOguV2y0RqkeW7sw5cxB75RhOMNBg
	 WpMpS0Vdm5t4+wNmgRhxvsXVlnyz239eNg+xxgGSm8Db9IB2S2Sa7KOkivMKp4jjEA
	 qrbM+VfGtIjdowBCfPCNNmkp1KG5vyvZu9CJv4RU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NIOolm2974661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 13:24:50 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 13:24:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 13:24:50 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NIOodF463807;
	Tue, 23 Sep 2025 13:24:50 -0500
Date: Tue, 23 Sep 2025 13:24:50 -0500
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>,
        Kevin
 Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
Message-ID: <20250923182450.5rqwz2pkn2gjt2vh@uda0506412>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
 <20250812-topic-am62-dt-partialio-v6-15-v2-7-25352364a0ac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-7-25352364a0ac@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:15-20250812, Markus Schneider-Pargmann wrote:
> The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
> powered during Partial-IO and IO+DDR and are capable of waking up the
> system in these states. Specify the states in which these units can do a
> wakeup on this board.
> 

nit: s/"IO+DD"/"I/O Only + DDR"

> Note that the UARTs are not capable of wakeup in Partial-IO because of
> of a UART mux on the board not being powered during Partial-IO.
> 
> Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
> Partial-IO. Add these as wakeup pinctrl entries for both devices.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> - Merge devicetree nodes in k3-am62p5-sk.dts
> ---
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 71 +++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 899da7896563b43021de14eda1b0058a5c6d36da..a2dffb5e243f543c90081eeacdc0758b38bd0eb9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -762,12 +762,52 @@ AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
>  		>;
>  		bootph-all;
>  	};
> +
> +	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
> +		>;
> +	};
> +
> +	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
> +		>;
> +	};
> +
> +	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
> +		>;
> +	};
> +
> +	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x040, PIN_INPUT | WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
> +		>;
> +	};
>  };
> 

AM62PX_MCU_IOPAD should be used for consistency.

Best,
Kendall Willis

>  &wkup_uart0 {
>  	/* WKUP UART0 is used by DM firmware */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	wakeup-source = <&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
>  	status = "reserved";
>  	bootph-all;
>  };
> @@ -808,3 +848,34 @@ &epwm1 {
>  	pinctrl-0 = <&main_epwm1_pins_default>;
>  	status = "okay";
>  };
> +
> +&mcu_mcan0 {
> +	pinctrl-names = "default", "wakeup";
> +	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
> +	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
> +	wakeup-source = <&system_partial_io>,
> +			<&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +	status = "okay";
> +};
> +
> +&mcu_mcan1 {
> +	pinctrl-names = "default", "wakeup";
> +	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
> +	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
> +	wakeup-source = <&system_partial_io>,
> +			<&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +	status = "okay";
> +};
> +
> +&mcu_uart0 {
> +	wakeup-source = <&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +};
> 
> -- 
> 2.50.1
> 

