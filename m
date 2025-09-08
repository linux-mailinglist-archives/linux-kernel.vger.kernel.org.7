Return-Path: <linux-kernel+bounces-805282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75997B48667
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E72D3BB55F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E61D63EF;
	Mon,  8 Sep 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="r8mQNiWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKVsXk+d"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7702E974A;
	Mon,  8 Sep 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318845; cv=none; b=qE6mwlcri1cGPUqeOJF21+/c8aQXmz7qNGXfu0PYvJAL8zOBK2GdjOuuf+pUkeaWKuMLaKbDm1cKOCDA+Nl+/fLd6KacByxhrIiBkjGW2y2m8w8s2Y+NfetlvRMHs2Ehicv3oWRp88uSceOOPEE1EchJwDywNbSItNpEvGFO21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318845; c=relaxed/simple;
	bh=HgCDeb6SE75bgZQO2Lzj+r0EYFcC3ywitIbaD2fyMXw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z0hj6FPKkIEcj2AhewvJonuZ4UGjzwOMvC+CZd14JL/uQYf93fBEtD0nDJ6kviyIkLrrUDQUbZ+9JkN0ESwBhcMw+McbLy/ZQaZ7F31ik+GklKQPt4qUsP2UJLdZqWZRQh0BduYQsnMg7yOYwM22XUb393Klao2p8MjSLAMsPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=r8mQNiWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKVsXk+d; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 381231D000F9;
	Mon,  8 Sep 2025 04:07:21 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 04:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1757318841; x=1757405241; bh=8/KiIeOfWlwkq2YgY2/wAs61qLE1m4TR
	L6dAU7ZZx34=; b=r8mQNiWbO3w82AkN+xjB7tULa0XYQETxf/Qinw8qpGRTMTSP
	aP/PwDu5aEn13Vm5QJsTZEL2BUZqQs6+2W7u68XmObKMwqHTbrOn2er6nOjQKtKQ
	I5wx4d4SqMnXGBdpYFUPnb8dAzbmgTvQcEbn6/EE/4UfI0bsOj5dtO+U0anZ3lDw
	yToAtj1JoYgShdNKjZ6hNquCNOLRCS55hd/mgJHaP5EWhfT3M6a0K66JACCToQve
	beED4muhk/wxpkXFpVxw7aPjvzeIdWCGvg3gy3Va3s1DhXwIIIV45Cqd4Ex3pHe0
	S8aT/KFgDgUdWiPK6uci9X5q03i1sdT6n4Jlxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757318841; x=
	1757405241; bh=8/KiIeOfWlwkq2YgY2/wAs61qLE1m4TRL6dAU7ZZx34=; b=I
	KVsXk+dt/ufVeuoh0t1y8HfdnPSS7SCpAMWue+EqOFP5LthB28su8PK6JtXNjo1K
	RXhJIkOzvm1rKmuoEqXgISo01meyKdJR9DJ7JVXczu3p+DP5H6o+lxWFul16jlfw
	rh5duRAD9hxqLNxhq9prN1pqNRmid//uyhDKCDrGuzRFJHvQ0Ya8eIK8RY8b2CWK
	u9P+qzJRBxm+my7E/0Sa9XPlfKrZhtWnS46NJksJrmIjEQVldhjNF1Gr/9cQ0R0l
	Qu31SL0+VN3IwjBF1vJjaa0ZcL/eUH6VdCXDTZwdAaW7BUWU51m7KMrF7sVS8IoF
	Cuut32IOpYnSSkwdkz/DQ==
X-ME-Sender: <xms:uI6-aLHqJBZw58D0QFEmOJW3CVCjquRrxkGwwQPlszJcj9m5aKoxMQ>
    <xme:uI6-aIUPtbkEKExUHpUif0NVixo-RZsUKP4X-1t_z-23guuH0MhL28XtSfMqCICqR
    zjN-tyRpBxjtWTqxjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomheptehlihhsthgr
    ihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeehjeffgeellefgfffhteehvedvhfekfeefleeuvdehudeitdduveeggfeigfeg
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtg
    homhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprghkvghmnhgruggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnih
    gvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uI6-aKNzRcQv-eRS2ujwJGTvK4Epx8qKA1pRkjuG2DLA9Cl2U6wZfQ>
    <xmx:uI6-aA25ZQZUWLM6IjKKJcXUhPCQtqan1FMiGbDG-C0Lge2XsmhhYQ>
    <xmx:uI6-aArYQK-qESDCDtkLKK2Je3-LMSENVH4iR-v8Cmx4eMyUCXfKww>
    <xmx:uI6-aCeAPsoZ0poy7mH6DhQIBa5oELDWaLCECAQSuQq6S3NLIyWdqg>
    <xmx:uY6-aHfPBcb6BsgOV72jBy8FlBd9xqDRh8CR7txj0P1BdZJvH5r8VS8d>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A449B2400098; Mon,  8 Sep 2025 04:07:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aus85q1JlVYk
Date: Mon, 08 Sep 2025 18:07:20 +1000
From: Alistair <alistair@alistair23.me>
To: "Andreas Kemnade" <akemnade@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Message-Id: <d4589e3c-ebda-471d-8ddd-6c5dd45b918e@app.fastmail.com>
In-Reply-To: <20250906-sy7636-rsrc-v1-4-e2886a9763a7@kernel.org>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
 <20250906-sy7636-rsrc-v1-4-e2886a9763a7@kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: imx: e70k02: add sy7636
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 6 Sep 2025, at 7:09 PM, Andreas Kemnade wrote:
> Add the EPD PMIC for the e70k02 based devices as a step towards full EPD
> support.
> 
> Signed-off-by: Andreas Kemnade <akemnade@kernel.org>

Acked-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> arch/arm/boot/dts/nxp/imx/e70k02.dtsi              | 25 +++++++++++++++++++++-
> .../arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts | 24 +++++++++++++++++++++
> .../arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts | 24 +++++++++++++++++++++
> 3 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/e70k02.dtsi b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
> index dcc3c9d488a88..5f6b7545a0c0c 100644
> --- a/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
> @@ -69,6 +69,14 @@ memory@80000000 {
> reg = <0x80000000 0x20000000>;
> };
>  
> + epd_pmic_supply: regulator-epd-pmic-in {
> + compatible = "regulator-fixed";
> + regulator-name = "epd_pmic_supply";
> + gpio = <&gpio2 14 GPIO_ACTIVE_HIGH>;
> + startup-delay-us = <20000>;
> + enable-active-high;
> + };
> +
> reg_wifi: regulator-wifi {
> compatible = "regulator-fixed";
> regulator-name = "SD3_SPWR";
> @@ -133,7 +141,22 @@ touchscreen@24 {
> vdd-supply = <&ldo5_reg>;
> };
>  
> - /* TODO: SY7636 PMIC for E Ink at 0x62 */
> + sy7636: pmic@62 {
> + compatible = "silergy,sy7636a";
> + reg = <0x62>;
> + en-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
> + vcom-en-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> + epd-pwr-good-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
> + vin-supply = <&epd_pmic_supply>;
> +
> + #thermal-sensor-cells = <0>;
> +
> + regulators {
> + reg_epdpmic: vcom {
> + regulator-name = "vcom";
> + };
> + };
> + };
>  
> };
>  
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
> index a2534c422a522..f8709a9524093 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
> @@ -26,6 +26,11 @@ / {
> compatible = "kobo,tolino-vision5", "fsl,imx6sl";
> };
>  
> +&epd_pmic_supply {
> + pinctrl-names = "default";
> + pinctrl-0 = <&pinctrl_epd_pmic_supply>;
> +};
> +
> &gpio_keys {
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_gpio_keys>;
> @@ -59,6 +64,12 @@ MX6SL_PAD_FEC_RXD1__GPIO4_IO18          0x10059 /* TP_RST */
> >;
> };
>  
> + pinctrl_epd_pmic_supply: epd-pmic-supplygrp {
> + fsl,pins = <
> + MX6SL_PAD_EPDC_PWRWAKEUP__GPIO2_IO14    0x40010059
> + >;
> + };
> +
> pinctrl_gpio_keys: gpio-keysgrp {
> fsl,pins = <
> MX6SL_PAD_FEC_CRS_DV__GPIO4_IO25 0x17059 /* PWR_SW */
> @@ -159,6 +170,14 @@ MX6SL_PAD_KEY_COL2__GPIO3_IO28 0x1b8b1 /* ricoh619 bat_low_int */
> >;
> };
>  
> + pinctrl_sy7636_gpio: sy7636-gpiogrp {
> + fsl,pins = <
> + MX6SL_PAD_EPDC_VCOM0__GPIO2_IO03        0x40010059 /* VCOM_CTRL */
> + MX6SL_PAD_EPDC_PWRCTRL1__GPIO2_IO08     0x40010059 /* EN */
> + MX6SL_PAD_EPDC_PWRSTAT__GPIO2_IO13      0x17059 /* PWR_GOOD */
> + >;
> + };
> +
> pinctrl_uart1: uart1grp {
> fsl,pins = <
> MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> @@ -329,6 +348,11 @@ &ricoh619 {
> pinctrl-0 = <&pinctrl_ricoh_gpio>;
> };
>  
> +&sy7636 {
> + pinctrl-names = "default";
> + pinctrl-0 = <&pinctrl_sy7636_gpio>;
> +};
> +
> &uart1 {
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_uart1>;
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
> index 660620d226f71..19bbe60331b36 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
> @@ -36,6 +36,11 @@ &cpu0 {
> soc-supply = <&dcdc1_reg>;
> };
>  
> +&epd_pmic_supply {
> + pinctrl-names = "default";
> + pinctrl-0 = <&pinctrl_epd_pmic_supply>;
> +};
> +
> &gpio_keys {
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_gpio_keys>;
> @@ -69,6 +74,12 @@ MX6SLL_PAD_GPIO4_IO18__GPIO4_IO18 0x10059 /* TP_RST */
> >;
> };
>  
> + pinctrl_epd_pmic_supply: epd-pmic-supplygrp {
> + fsl,pins = <
> + MX6SLL_PAD_EPDC_PWR_WAKE__GPIO2_IO14    0x40010059
> + >;
> + };
> +
> pinctrl_gpio_keys: gpio-keysgrp {
> fsl,pins = <
> MX6SLL_PAD_GPIO4_IO25__GPIO4_IO25 0x17059 /* PWR_SW */
> @@ -169,6 +180,14 @@ MX6SLL_PAD_KEY_COL2__GPIO3_IO28 0x1b8b1 /* ricoh619 bat_low_int */
> >;
> };
>  
> + pinctrl_sy7636_gpio: sy7636-gpiogrp {
> + fsl,pins = <
> + MX6SLL_PAD_EPDC_VCOM0__GPIO2_IO03       0x40010059 /* VCOM_CTRL */
> + MX6SLL_PAD_EPDC_PWR_CTRL1__GPIO2_IO08   0x40010059 /* EN */
> + MX6SLL_PAD_EPDC_PWR_STAT__GPIO2_IO13    0x17059 /* PWR_GOOD */
> + >;
> + };
> +
> pinctrl_uart1: uart1grp {
> fsl,pins = <
> MX6SLL_PAD_UART1_TXD__UART1_DCE_TX 0x1b0b1
> @@ -319,6 +338,11 @@ &ricoh619 {
> pinctrl-0 = <&pinctrl_ricoh_gpio>;
> };
>  
> +&sy7636 {
> + pinctrl-names = "default";
> + pinctrl-0 = <&pinctrl_sy7636_gpio>;
> +};
> +
> &uart1 {
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_uart1>;
> 
> -- 
> 2.39.5
> 
> 

