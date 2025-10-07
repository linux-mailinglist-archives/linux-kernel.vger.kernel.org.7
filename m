Return-Path: <linux-kernel+bounces-844601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3429BC2537
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F561893ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5322129B;
	Tue,  7 Oct 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BuaE95Xy"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0402139C9;
	Tue,  7 Oct 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860458; cv=none; b=XccLapBTTOBnr3fLx5j1hPeqrav5topTqKhOPgXBwauF29wqFAm93Sw7AFJ+2c4gD48WzwqfrvlvmfTieOZ1CIorDNPoGnsXDnMQmLbhb5Id+3BBdew7N8d7XyBCadHPBW8CWk7imliq6HOMYxOA1X9JTQLh2VovY46j6rfrl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860458; c=relaxed/simple;
	bh=BNH4ZjX4Yh/vGE0Vdr5keaTwMv/WbBU6iJihl2DNpAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WitCaZyspfbEb2GCbVAvtgB5FHyBCzF/U/IgjEBA6YgMhomPUMAfAY2qzv+2ODaQbLy4XForqsQqzG1SaRbsy/vF0KSapMl6GLEWOYr9rCKFERQG96eEoZ1VQurXFzd/Ftd8BZuhtvtJF+tgk9LX050klNniMclJaV0y+8jRR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BuaE95Xy; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597I7NCX3810025;
	Tue, 7 Oct 2025 13:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759860443;
	bh=VOc/6DotKCEMW9Sbnc/xyg+5eFLjWqB7jFNv6VD59hc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BuaE95XydtLi+HxoJuzf/NGrknvu7AU+C5os5kym5Lp1LwbTG2V4f0gkeKGS0BRMo
	 YIy+Po1jr75jjVVVw53gDhkDHZd/XubDoXdDnXuJjCw9X4QfbCXK72Nvb1imsch19U
	 0tMwb4Ni6TSJW4lvtyf8Wd8XjSZJFfxYuALWP8m8=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597I7Njr058437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 13:07:23 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Oct
 2025 13:07:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 13:07:22 -0500
Received: from [10.247.24.40] (lt5cd3040qtn.dhcp.ti.com [10.247.24.40])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597I7MrK1288932;
	Tue, 7 Oct 2025 13:07:22 -0500
Message-ID: <ff900ce3-ba9e-454b-ae79-0be06618616c@ti.com>
Date: Tue, 7 Oct 2025 13:07:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62d2-evm: Enable PMIC
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>
References: <20250919032806.707926-1-p-bhagat@ti.com>
 <20250919032806.707926-3-p-bhagat@ti.com>
Content-Language: en-US
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
In-Reply-To: <20250919032806.707926-3-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/18/2025 10:28 PM, Paresh Bhagat wrote:
> Add support for TPS65224 PMIC family on wakeup I2C0 bus. This 
> device provides regulators (bucks and LDOs), along with GPIOs, 
> and monitors SOC's MCU error signal.
>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 91 ++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> index 9a74df221f2a..155abd97b799 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> @@ -214,6 +214,14 @@ AM62DX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
>  		>;
>  		bootph-all;
>  	};
> +
> +	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62DX_MCU_IOPAD(0x004c, PIN_INPUT, 0) /* (D13) WKUP_I2C0_SCL */
> +			AM62DX_MCU_IOPAD(0x0050, PIN_INPUT, 0) /* (E13) WKUP_I2C0_SDA */
> +		>;
> +		bootph-all;
> +	};
>  };
>  
>  /* WKUP UART0 is used for DM firmware logs */
> @@ -464,6 +472,89 @@ &main_i2c2 {
>  	status = "okay";
>  };
>  
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	tps65224: pmic@48 {
> +		compatible = "ti,tps65224-q1";
> +		reg = <0x48>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +		ti,primary-pmic;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		buck12-supply = <&vcc_3v3_sys>;
> +		buck3-supply = <&vcc_3v3_sys>;
> +		buck4-supply = <&vcc_3v3_sys>;
> +		ldo1-supply = <&vcc_3v3_sys>;
> +		ldo2-supply = <&vcc_3v3_sys>;
> +		ldo3-supply = <&vcc_3v3_sys>;
> +
> +		regulators {
> +			buck12: buck12 {
> +				regulator-name = "vdd_core";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				bootph-all;
> +			};
> +
> +			buck3: buck3 {
> +				regulator-name = "dvdd1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				bootph-all;
> +			};
> +
> +			buck4: buck4 {
> +				regulator-name = "vdds_ddr";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				bootph-all;
> +			};
> +
> +			ldo1: ldo1 {
> +				regulator-name = "vdda_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				bootph-all;
> +			};
> +
> +			ldo2: ldo2 {
> +				regulator-name = "dvdd3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				bootph-all;
> +			};
> +
> +			ldo3: ldo3 {
> +				regulator-name = "vddr_core";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				bootph-all;
> +			};
> +		};
> +	};
> +};
> +

The PMIC node looks correct based on tps6594.yaml + test log regulator summary.
Reviewed-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>

>  &sdhci0 {
>  	/* eMMC */
>  	non-removable;

