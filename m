Return-Path: <linux-kernel+bounces-829483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4CB972CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44607A2D73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E32FD7CE;
	Tue, 23 Sep 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tYBN+0ok"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757A2FB093;
	Tue, 23 Sep 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651372; cv=none; b=GZnGqLWouqrJ7H1fEJ6d/4uMTCf/Ehm2BZvxVkl6Bq1GtbsxIoRNYSiHs7GoLQ3YETR8YzI1/mRAr4lDHro1m4wLoxWo2zCft75uNcoF49OsyWDc2RP8Mg5rosGY9m/p9KIW/bJ1ObCJDI/V7L+wMyfSHbSkkWBGU7dBfAFTcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651372; c=relaxed/simple;
	bh=Pd/vr6gfJecTCg6idYwsj65Vxje1Ql8fzzq9QB1O7qI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4ZvTLkNkOf4jxQMuvtB8rarSKPmLqpx12Fq/WUIY0W8rNy+Y6LBfr5L92spGkEFuyOCp3GF3Izn6pIk+D2j5Bi7Lbdjy4Wl5X89tx/68FZUiZxfaCyU3xuoYLJqymqjptd0kqWkOZdZXvzsokc7yc4ZfP2JFKGYayr2YPbXjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tYBN+0ok; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NIG2XL1044493;
	Tue, 23 Sep 2025 13:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758651362;
	bh=J4ZBqPejUM9ozxyVcs4lYmfMpZfbwlqrhxv4JVL0Njk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tYBN+0okJSmVpe5/9hx5R3aFFgRxDX0dMTEb81J/kcSxNHun5kYuDIQ5ywQpWqY5n
	 1UOEdbmDUEP/biQRMN5aOpu3Z3SqNN/4bp8/wf+xas6qXaPPx2muXacWww80MHTuy8
	 evHzHQRPHXC5A5u9SDvrZw9J8E0KFAyP2nFP3j4Q=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NIG2Uc1847586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 13:16:02 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 13:16:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 13:16:02 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NIG2Is455516;
	Tue, 23 Sep 2025 13:16:02 -0500
Date: Tue, 23 Sep 2025 13:16:02 -0500
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
Subject: Re: [PATCH v2 5/7] arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source
 system-states
Message-ID: <20250923181602.owmee6oisylw6svj@uda0506412>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
 <20250812-topic-am62-dt-partialio-v6-15-v2-5-25352364a0ac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-5-25352364a0ac@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Markus,

On 11:15-20250812, Markus Schneider-Pargmann wrote:
> The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
> powered during Partial-IO and IO+DDR and are capable of waking up the
> system in these states. Specify the states in which these units can do a
> wakeup on this board.
> 
> Note that the UARTs are not capable of wakeup in Partial-IO because of
> of a UART mux on the board not being powered during Partial-IO. As
> IO+DDR is not supported on am62, the UARTs are not added in this patch.

nit: s/"am62"/"AM62x"
nit: s/"IO+DDR"/"I/O Only + DDR"

Logic looks good, but as said previously it needs to be rebased due to
WKUP_EN macro.

Best,
Kendall Willis

> 
> Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
> Partial-IO. Add these as wakeup pinctrl entries for both devices.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 ++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> index 4609f366006e4cdf0c162f72634ce90623f60a90..0314f857ea05acc4ffc62bccb5184e58d19a6103 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> @@ -268,3 +268,63 @@ &main_gpio1 {
>  &gpmc0 {
>  	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
>  };
> +
> +&mcu_mcan0 {
> +	pinctrl-names = "default", "wakeup";
> +	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
> +	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
> +	wakeup-source = <&system_partial_io>,
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
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +	status = "okay";
> +};
> +
> +&mcu_pmx0 {
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
> +};
> 
> -- 
> 2.50.1
> 

