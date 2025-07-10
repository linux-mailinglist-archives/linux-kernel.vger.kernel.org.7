Return-Path: <linux-kernel+bounces-725018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE2AFF9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF042189CA61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07A286D55;
	Thu, 10 Jul 2025 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mvc5VTLj"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCD283CA2;
	Thu, 10 Jul 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128857; cv=none; b=BPkD4YeBHlfkN8ayjx8lOvDeVs44gFqHQGRt25wrQ3u5NqOS/EuoF34JziF71VAn8r3y+N16f4q3H4scLWgqMP2MVYI37XoWgArxOoZ1rzDDLVnB/suCiUV/OTp0g6JJCfVe9tLHFVOCW7QntBvqewdHxOjcuAs594EX6qbwWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128857; c=relaxed/simple;
	bh=FiO1XH7Igsv3lEbiU7daiybFpg4j6n/TBtFjCImR2cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQYK2IZ44y3/G+ae4isGgE5yh2CjdNlHVry0ccY+DRHr14i0/eFSJ1vZy7OD4R8voA2HGOTGD0xsOQXk7VuO1RoQaSabrf/fbz6bSsTc0O7+96kFJxxKw+DavoAANQjqU4KPGDB8OIA75ZxrWq92eibACvgLKuAFCxDC1PM0oOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mvc5VTLj; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56A6RSNW1413904;
	Thu, 10 Jul 2025 01:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752128848;
	bh=U9zTy+PvqtUonDDziJSsn4ErLMsgWDCGXzX94xHwxno=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mvc5VTLjSYNmVS5tZJ+3o6H6S1FziCKVYDHj6zmngh8s3QYQSVrnrcvRbtPlIF6/D
	 Swv9glXByYyR15WLfSvf27Z/M1ZKMHu8PXpc3kSyJfHdrxETd/spQg5w2g1dbtTaRX
	 BS83eiD2A32uhv7t5A2jFiWOaDCwQC7tR61Ybq6E=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56A6RSkU3233610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 01:27:28 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 01:27:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 01:27:27 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56A6RO801166939;
	Thu, 10 Jul 2025 01:27:25 -0500
Message-ID: <d6ddb952-ddbc-46a1-a94e-b5191b412036@ti.com>
Date: Thu, 10 Jul 2025 11:57:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: var-som-am62p: Add support for
 Variscite Symphony Board
To: Stefano Radaelli <stefano.radaelli21@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
 <20250709220714.85697-4-stefano.radaelli21@gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250709220714.85697-4-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 10/07/25 03:37, Stefano Radaelli wrote:

[...]

> +&main_pmx0 {
> +	pinctrl_extcon: main-extcon-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01a8, PIN_INPUT, 7) /* (F25) MCASP0_AFSX.GPIO1_12 */
> +		>;
> +	};
> +
> +	pinctrl_i2c0: main-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B25) I2C0_SCL */
> +			AM62PX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A24) I2C0_SDA */
> +		>;
> +	};
> +
> +	pinctrl_i2c1: main-i2c1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
> +			AM62PX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (B24) I2C1_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_mcan0: main-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01dc, PIN_INPUT, 0) /* (F20) MCAN0_RX */
> +			AM62PX_IOPAD(0x01d8, PIN_OUTPUT, 0) /* (B23) MCAN0_TX */
> +		>;
> +	};
> +
> +	pinctrl_mmc1: main-mmc1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x023c, PIN_INPUT, 0) /* (H20) MMC1_CMD */
> +			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK */
> +			AM62PX_IOPAD(0x0230, PIN_INPUT, 0) /* (H21) MMC1_DAT0 */
> +			AM62PX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H23) MMC1_DAT1 */
> +			AM62PX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (H22) MMC1_DAT2 */
> +			AM62PX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
> +			AM62PX_IOPAD(0x0240, PIN_INPUT, 0) /* (D23) MMC1_SDCD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pinctrl_rgmii2: main-rgmii2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0184, PIN_INPUT, 0) /* (E19) RGMII2_RD0 */
> +			AM62PX_IOPAD(0x0188, PIN_INPUT, 0) /* (E16) RGMII2_RD1 */
> +			AM62PX_IOPAD(0x018c, PIN_INPUT, 0) /* (E17) RGMII2_RD2 */
> +			AM62PX_IOPAD(0x0190, PIN_INPUT, 0) /* (C19) RGMII2_RD3 */
> +			AM62PX_IOPAD(0x0180, PIN_INPUT, 0) /* (D19) RGMII2_RXC */
> +			AM62PX_IOPAD(0x017c, PIN_INPUT, 0) /* (F19) RGMII2_RX_CTL */
> +			AM62PX_IOPAD(0x016c, PIN_INPUT, 0) /* (B19) RGMII2_TD0 */
> +			AM62PX_IOPAD(0x0170, PIN_INPUT, 0) /* (A21) RGMII2_TD1 */
> +			AM62PX_IOPAD(0x0174, PIN_INPUT, 0) /* (D17) RGMII2_TD2 */
> +			AM62PX_IOPAD(0x0178, PIN_INPUT, 0) /* (A19) RGMII2_TD3 */
> +			AM62PX_IOPAD(0x0168, PIN_INPUT_PULLDOWN, 0) /* (D16) RGMII2_TXC */
> +			AM62PX_IOPAD(0x0164, PIN_INPUT, 0) /* (A20) RGMII2_TX_CTL */
> +		>;
> +	};
> +
> +	pinctrl_spi2: main_spi2-default-pins {

			^^^ no underscores please.

> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01b0, PIN_INPUT, 1) /* (G20) MCASP0_ACLKR.SPI2_CLK */
> +			AM62PX_IOPAD(0x0194, PIN_OUTPUT, 1) /* (D25) MCASP0_AXR3.SPI2_D0 */
> +			AM62PX_IOPAD(0x0198, PIN_INPUT, 1) /* (E25) MCASP0_AXR2.SPI2_D1 */
> +			AM62PX_IOPAD(0x01ac, PIN_OUTPUT, 7) /* (G23) MCASP0_AFSR.GPIO1_13 */
> +		>;
> +	};

[...]

-- 
Regards
Vignesh
https://ti.com/opensource


