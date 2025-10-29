Return-Path: <linux-kernel+bounces-876327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8EC1B2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8349F1AA5FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF3E126BF7;
	Wed, 29 Oct 2025 14:16:00 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40E18DB35;
	Wed, 29 Oct 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747359; cv=none; b=KGEuZFAt8l3289/yZcqbbqNr0+f0E1fGWgQ1NROGV3UeT4ty9MbmMU1b0k9uXk9Jo/06RsU11xlF5oZRp/2axe1P4muuMXe5mwYTkHMNWfvUsDgdJo6WmfF/UFxy21uuq8+XUTFDzPy1Ni6orQWDjukiYzk+loJj8fQfys4r3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747359; c=relaxed/simple;
	bh=4zgFNeOCPQmleSUKYm/voVb+OMXGrsLkRKFfu2VQ6gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTyv31b68rFWijRvOkDjAukAHw5AbMLZZJrT8/O92aoKUneUz3qA5E4rRAdV1hEaRneuTuivz53wsTfxRCzzV/o03htyw1ezIWiSdC9pInKPn8VZPPNStZrfJmyt0XY8zLB1V5CYAUoUEEEuDI/YPbH4Kg/FRI2XXDJ+NGsoz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27a69f6db;
	Wed, 29 Oct 2025 22:00:37 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: i@chainsx.cn
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
Date: Wed, 29 Oct 2025 22:00:26 +0800
Message-Id: <20251029140026.867458-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <77BB123A1F1E3D11+20251014021623.286121-3-i@chainsx.cn>
References: <77BB123A1F1E3D11+20251014021623.286121-3-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a304543c703a2kunm624f917d129bff
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkJJVkpIHRhIGUkaSBhOSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

Hi,

From the schematic, DT still has some things wrong:
https://dl.100ask.net/Hardware/MPU/RK3576-DshanPi-A1/DshanPi-A1-RK3576-SCH_V1.1.pdf

Do you want to resend the whole patch or I send some patches fixing them?

> +	vcc_1v2_ufs_vccq_s0: regulator-vcc-1v2-ufs-vccq-s0 {
> +	vcc_1v8_ufs_vccq2_s0: regulator-vcc-1v8-ufs-vccq2-s0 {
> +	vcc_3v3_rtc_s5: regulator-vcc-3v3-rtc-s5 {
> +	vcc_3v3_ufs_s0: regulator-vcc-ufs-s0 {

These ufs and rtc regulators do not actually exist.

> +	vcc_5v0_typec0: regulator-vcc-5v0-typec0 {
> +		regulator-name = "vcc_5v0_typec0";

The name on the schematic is vbus5v0_typec.

> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&rgmii_phy1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth1m0_miim
> +		     &eth1m0_tx_bus2
> +		     &eth1m0_rx_bus2
> +		     &eth1m0_rgmii_clk
> +		     &eth1m0_rgmii_bus
> +		     &ethm0_clk1_25m_out>;

This should be ethm1_clk0_25m_out.
It seems that the 25m clock is not used.

> +&i2c4 {
> +	status = "okay";
> +
> +	es8388: audio-codec@10 {
> +		compatible = "everest,es8388", "everest,es8328";
> +		reg = <0x10>;

i2cdetect reports that its address is 0x11

> +		clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
> +		AVDD-supply = <&vcca_3v3_s0>;
> +		DVDD-supply = <&vcc_3v3_s0>;
> +		HPVDD-supply = <&vcca_3v3_s0>;
> +		PVDD-supply = <&vcc_3v3_s0>;

These are all from VCC3P3 (VCC3V3_S0).

> +		assigned-clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
> +		assigned-clock-rates = <12288000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sai1m0_mclk>;

In fact, this is connected to sai2.
The schematic is quite misleading here:
RK3576 - SAI2_xxx - SAI1_xxx - ES8388

> +		#sound-dai-cells = <0>;
> +	};
> +};

> +&mdio0 {
> +	rgmii_phy0: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;

The phy address configured in the schematic is 0,
which is also the case in practice.

> +		clocks = <&cru REFCLKO25M_GMAC0_OUT>;

This 25m clock is not used.

> +&mdio1 {
> +	rgmii_phy1: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;

The phy address is 0.

> +		clocks = <&cru REFCLKO25M_GMAC1_OUT>;

This 25m clock is not used.

> +	headphone {
> +		hp_det: hp-det {
> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;

According to the schematic, this should be GPIO0_A2?

> +		};
> +	};

> +&sdhci {
> +	bus-width = <8>;
> +	full-pwr-cycle-in-suspend;
> +	max-frequency = <200000000>;

max-frequency is already defined in dtsi

> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <200000000>;

max-frequency is already defined in dtsi

> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_s3>;

This comes from VCC3P3 (VCC3V3_S0).

