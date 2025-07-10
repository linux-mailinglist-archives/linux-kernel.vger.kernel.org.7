Return-Path: <linux-kernel+bounces-724996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95315AFF98D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CD83A6FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F732857FF;
	Thu, 10 Jul 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V1Ecq2ad"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C95383;
	Thu, 10 Jul 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128255; cv=none; b=o7UJ1EFrc0HkKl5lId4JVtnzRWksXWCznYC0WaWxfRNaMpZ/yF8X+fMv1dGz+5fokzv4lC2CSNA4yzlI97DE6Bq66qc20kfnrk3iWjZHX4IGbfWmYzYwQWPJx+AIpzudiftPvk3P9xyvpPdoN9ExVHQG3ti3VXoj1lmyXne3/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128255; c=relaxed/simple;
	bh=IDCLCBRvGHvWye9rDgOHSsCJGzvchumYRBq9vqI6k+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MeFSrIQMD8QYOH3YaLjYzkd/UvYnj6yJV2S+11/CmWG4s1RkxjDK8IlmDYDG7MX5upqTmGl2tBYEVSN8ycJL/2LHnvROvV6yfsuNZ6mFWagiGXBpuoix2TCUHd8n7bDlwDhZfb2fLjFLUQmQp5LW9wEER0cGq6xHhKxrx226w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V1Ecq2ad; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56A6HPNa1412531;
	Thu, 10 Jul 2025 01:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752128245;
	bh=uCA1XYApjMEEpODseSN2C0Imh7avIdauzB9lovWH7D8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=V1Ecq2adzQdiCtJ51W9p8YwStuYvbx3qyLwDUTIblofKbmio3+NITDw44ZxommKjr
	 mgFPq1+c08aB+jKJwx7+V4BFzEXWS1P4vQ7syTd/8XRuk6EdznkEd+sqqpdnlmmWYE
	 bZ9Rwuj7amw9RXKC7hCSB3RVvtMpmWzjOsx3lFyU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56A6HP3T4096293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 01:17:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 01:17:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 01:17:25 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56A6HLTl1155423;
	Thu, 10 Jul 2025 01:17:22 -0500
Message-ID: <1fcf5d59-02f0-4b99-aeb0-bf555730cefa@ti.com>
Date: Thu, 10 Jul 2025 11:47:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Add support for Variscite
 VAR-SOM-AM62P
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
 <20250709220714.85697-3-stefano.radaelli21@gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250709220714.85697-3-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

[...]

On 10/07/25 03:37, Stefano Radaelli wrote:
> +&main_pmx0 {
> +	pinctrl_mmc_pwrseq: main-emmc-pwrseq-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00c8, PIN_OUTPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */
> +		>;
> +	};
> +
> +	pinctrl_i2c2: main-i2c2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
> +			AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
> +		>;
> +	};
> +
> +	pinctrl_i2c3: main-i2c3-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */
> +			AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
> +		>;
> +	};
> +
> +	pinctrl_mcasp1: main-mcasp1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
> +			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
> +			AM62PX_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
> +			AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
> +			AM62PX_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (P24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
> +		>;
> +	};
> +
> +	pinctrl_mdio1: main-mdio1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
> +			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
> +		>;
> +	};
> +
> +	pinctrl_mmc2: main-mmc2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0120, PIN_INPUT_PULLUP, 0) /* (K24) MMC2_CMD */
> +			AM62PX_IOPAD(0x0118, PIN_INPUT_PULLDOWN, 0) /* (K21) MMC2_CLK */
> +			AM62PX_IOPAD(0x011C, PIN_INPUT_PULLUP, 0) /* () MMC2_CLKLB */

Lower case for hex digits: 0x11c

> +			AM62PX_IOPAD(0x0114, PIN_INPUT_PULLUP, 0) /* (K23) MMC2_DAT0 */
> +			AM62PX_IOPAD(0x0110, PIN_INPUT_PULLUP, 0) /* (K22) MMC2_DAT1 */
> +			AM62PX_IOPAD(0x010c, PIN_INPUT_PULLUP, 0) /* (L20) MMC2_DAT2 */
> +			AM62PX_IOPAD(0x0108, PIN_INPUT_PULLUP, 0) /* (L21) MMC2_DAT3 */
> +		>;
> +	};

-- 
Regards
Vignesh
https://ti.com/opensource


