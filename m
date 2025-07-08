Return-Path: <linux-kernel+bounces-721866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0595AFCEEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BFB1BC1C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183C2E0412;
	Tue,  8 Jul 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="RgAEQUMN"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156A157A72;
	Tue,  8 Jul 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987986; cv=none; b=ns7XkqgGdpWhuCB1j71FSFwJUYXHCoy2Tl28x4xcgUawp33L/JRthlSOGqB6a0MYzmnIiBTS3vE542IzY4cMmYUNt9uIBWZUhjUhsNy6sGjHR2Mxq77VzIrrQFaFaTMwS/wbFXFQAwG66u8KLSoAN6bUs9ass/GP2g0H3+waWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987986; c=relaxed/simple;
	bh=6SFUv/CMLT4iB6N9qVtIARxMKewYnK+aJ8Uhy5VaxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPkkW4GpWrsHps4VPybP3CSeFFvsomA3v3KttMq+Y8HUacxuhh/rwkXuaQiXcFOsUcX48a4E+Pkw0pJMtdO1U92tuWcAcK7EjEkZkOE6mF6s0PIc3nvhfx1W16JxRdURK+JkULksvxr3bGS45CS/lKD+Jr4kkalnHnFAZjRWhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=RgAEQUMN; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
	bh=f+AdjSpLYE0shtXAMJo1oGPvn8m5n7Wk9nMZZIV11e8=;
	b=RgAEQUMNdPw7KMvhVYIPCsFqW062MaR+phV4UfYbXms9+KdXuV1btLi0q3k9FmAaknANDHQomYmZsL1FHgk/R/1W1mQ6U7gZXQNF0HiH4xQTg4uA4KgE5/7ivZ0f8ML+ALe+U8UTuaI6jo3oRqG5khaOz76FR1hqGaB/vj51PNM=
Received: from lukas-hpz440workstation.localnet (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
	; Tue, 8 Jul 2025 17:19:33 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject:
 Re: [PATCH v3 3/5] ARM: dts: sunxi: add support for NetCube Systems Nagami
 SoM
Date: Tue, 08 Jul 2025 17:19:31 +0200
Message-ID: <3700020.R56niFO833@lukas-hpz440workstation>
In-Reply-To: <20250708002205.70ec9097@minigeek.lan>
References:
 <20250707184420.275991-1-lukas.schmid@netcube.li>
 <20250707184420.275991-4-lukas.schmid@netcube.li>
 <20250708002205.70ec9097@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3829144.MHq7AAxBmi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3829144.MHq7AAxBmi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>
Date: Tue, 08 Jul 2025 17:19:31 +0200
Message-ID: <3700020.R56niFO833@lukas-hpz440workstation>
In-Reply-To: <20250708002205.70ec9097@minigeek.lan>
MIME-Version: 1.0

On Dienstag, 8. Juli 2025 01:22:05 CEST Andre Przywara wrote:
> On Mon,  7 Jul 2025 20:44:15 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
> 
Hi Andre,

> Hi Lukas,
> 
> please try to refrain from sending subsequent patches too quickly, that
> might just put off and confuse reviewers. To acknowledge a change
> request, it is probably sufficient to just reply to the mail with a
> confirmation.

Sorry about that. I'm still trying to get the hang of this whole "submitting 
patches" thing. What is a good time/reason to send the next revision/version 
of a patchset?

> 
> > NetCube Systems Nagami SoM is a module based around the Allwinner T113s
> > SoC. It includes the following features and interfaces:
> > 
> > - 128MB DDR3 included in SoC
> > - 10/100 Mbps Ethernet using LAN8720A phy
> > - One USB-OTG interface
> > - One USB-Host interface
> > - One I2S interface with in and output support
> > - Two CAN interfaces
> > - ESP32 over SDIO
> > - One SPI interface
> > - I2C EEPROM for MAC address
> > - One QWIIC I2C Interface with dedicated interrupt pin shared with EEPROM
> > - One external I2C interface
> > - SD interface for external SD-Card
> > 
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > ---
> > 
> >  .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 233 ++++++++++++++++++
> >  1 file changed, 233 insertions(+)
> >  create mode 100644
> >  arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi> 
> > diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
> > b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi new file
> > mode 100644
> > index 000000000..0db867b47
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2025 Lukas Schmid <lukas.schmid@netcube.li>
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun8i-t113s.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	model = "NetCube Systems Nagami SoM";
> > +	compatible = "netcube,nagami", "allwinner,sun8i-t113s";
> > +
> > +	aliases {
> > +		serial1 = &uart1; // ESP32 Bootloader UART
> > +		serial3 = &uart3; // Console UART on Card Edge
> > +		ethernet0 = &emac;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial3:115200n8";
> > +	};
> > +
> > +	/* module wide 3.3V supply directly from the card edge */
> > +	reg_vcc3v3: regulator-3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc-3v3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	/* SY8008 DC/DC regulator on the board, also supplying VDD-SYS */
> > +	reg_vcc_core: regulator-core {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc-core";
> > +		regulator-min-microvolt = <880000>;
> > +		regulator-max-microvolt = <880000>;
> > +		vin-supply = <&reg_vcc3v3>;
> > +	};
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&reg_vcc_core>;
> > +};
> > +
> > +&cpu1 {
> > +	cpu-supply = <&reg_vcc_core>;
> > +};
> > +
> > +&dcxo {
> > +	clock-frequency = <24000000>;
> > +};
> > +
> > +&emac {
> > +	nvmem-cells = <&eth0_macaddress>;
> > +	nvmem-cell-names = "mac-address";
> > +	phy-handle = <&lan8720a>;
> > +	phy-mode = "rmii";
> > +	pinctrl-0 = <&rmii_pe_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> > +/* Exposed as I2C on the card edge */
> > +&i2c2 {
> > +	pinctrl-0 = <&i2c2_pins>;
> > +	pinctrl-names = "default";
> 
> I wonder if this belongs here. In general we don't describe
> pins/devices that are on generic connectors (like pin headers), because
> the connection is determined by the user, not by the board.
> In this case PD20 and PD21 could be used as generic GPIOs or as PWMs.
> IIUC, even for the basic carrier those pins end up on headers, so even
> there I wouldn't describe it. On the keypad carrier it's of course a
> different story, since the MCP23008 is apparently soldered there.

I get that part. However the module's description (as of yet unreleased) 
specifies those pins for this exact function as they are meant to be available 
on our modules using the same connector but other CPU/SoC. The Module's state 
that this is the default option but other function's can be reconfigured or 
they can be used as IO. 

If it's an issue I can remove those here, but I would still add them into the 
basic carrier as, even though they are only pin header, they are marked with 
the dedicated function of said pin. For example the headers there are 
specifically for "SPI", "I2S", "I2C" and the SD-Card slot.

> 
> > +};
> > +
> > +/* Exposed as the QWIIC connector and used by the internal EEPROM */
> > +&i2c3 {
> > +	pinctrl-0 = <&i2c3_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	eeprom0: eeprom@50 {
> > +		compatible = "atmel,24c02";		/* 
actually it's a 24AA02E48 */
> > +		reg = <0x50>;
> > +		pagesize = <16>;
> > +		read-only;
> > +		vcc-supply = <&reg_vcc3v3>;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +
> > +		eth0_macaddress: macaddress@fa {
> > +			reg = <0xfa 0x06>;
> > +		};
> > +	};
> > +};
> > +
> > +/* Exposed as I2S on the card edge */
> > +&i2s1 {
> > +	pinctrl-0 = <&i2s1_pins>, <&i2s1_din_pins>, <&i2s1_dout_pins>;
> > +	pinctrl-names = "default";
> 
> Same story here, what prevents a user from using those edge pins as
> GPIO or PWM?
> 
> > +};
> > +
> > +/* Phy is on SoM. MDI signals pre-magentics are on the card edge */
> > +&mdio {
> > +	lan8720a: ethernet-phy@0 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <0>;
> > +	};
> > +};
> > +
> > +/* Exposed as SD on the card edge */
> > +&mmc0 {
> > +	pinctrl-0 = <&mmc0_pins>;
> > +	pinctrl-names = "default";
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	broken-cd;
> > +	disable-wp;
> > +	bus-width = <4>;
> > +};
> 
> I think this node doesn't belong into the SoM .dtsi, as many details
> are not set here, but on the carrier board: card detect, write protect,
> Vmmc supply, and even bus width (could be 1 as well). So please move
> this node to where the SD card connector sits. You might want to keep
> the pinctrl nodes in here.

Totally agree here, I will move this definition to the basic carrier, as it's 
currently the only one with the SD-Interface connected. However my question 
from above about the default function still applies here.
> 
> > +
> > +/* Connected to the on-board ESP32 */
> > +&mmc1 {
> > +	pinctrl-0 = <&mmc1_pins>;
> > +	pinctrl-names = "default";
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +/* Connected to the on-board eMMC */
> > +&mmc2 {
> > +	pinctrl-0 = <&mmc2_pins>;
> > +	pinctrl-names = "default";
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	vqmmc-supply = <&reg_vcc3v3>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&pio {
> > +	vcc-pb-supply = <&reg_vcc3v3>;
> > +	vcc-pc-supply = <&reg_vcc3v3>;
> > +	vcc-pd-supply = <&reg_vcc3v3>;
> > +	vcc-pe-supply = <&reg_vcc3v3>;
> > +	vcc-pf-supply = <&reg_vcc3v3>;
> > +	vcc-pg-supply = <&reg_vcc3v3>;
> > +
> > +	gpio-line-names = "", "", "", "", // PA
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "CAN0_TX", 
"CAN0_RX", // PB
> > +					  "CAN1_TX", 
"CAN1_RX", "UART3_TX", "UART3_RX",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "eMMC_CLK", 
"eMMC_CMD", // PC
> > +					  "eMMC_D2", 
"eMMC_D1", "eMMC_D0", "eMMC_D3",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "", // 
PD
> > +					  "", "", "", "",
> > +					  "", "", "SPI1_CS", 
"SPI1_CLK",
> > +					  "SPI1_MOSI", 
"SPI1_MISO", "SPI1_HOLD", "SPI1_WP",
> > +					  "PD16", "", "", "",
> > +					  "I2C2_SCL", 
"I2C2_SDA", "PD22", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "ETH_CRSDV", 
"ETH_RXD0", "ETH_RXD1", "ETH_TXCK", // PE
> > +					  "ETH_TXD0", 
"ETH_TXD1", "ETH_TXEN", "",
> > +					  "ETH_MDC", 
"ETH_MDIO", "QWIIC_nINT", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "SD_D1", "SD_D0", 
"SD_CLK", "SD_CLK", // PF
> > +					  "SD_D3", "SD_D2", 
"PF6", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "ESP_CLK", 
"ESP_CMD", "ESP_D0", "ESP_D1", // PG
> > +					  "ESP_D2", "ESP_D3", 
"UART1_TXD", "UART1_RXD",
> > +					  "ESP_nBOOT", 
"ESP_nRST", "I2C3_SCL", "I2C3_SDA",
> > +					  "I2S1_WS", 
"I2S1_CLK", "I2S1_DIN0", "I2S1_DOUT0",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "",
> > +					  "", "", "", "";
> > +};
> > +
> > +/* Remove the unused CK pin from the pinctl as it is unconnected */
> > +&rmii_pe_pins {
> > +	pins = "PE0", "PE1", "PE2", "PE3", "PE4",
> > +		   "PE5", "PE6", "PE8", "PE9";
> > +};
> > +
> > +/* Exposed as SPI on the card-edge */
> > +&spi1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	pinctrl-0 = <&spi1_pins>;
> > +	pinctrl-names = "default";
> > +	cs-gpios = <0>;
> > +};
> 
> I wonder if this belongs here as well, since it's again just generic
> edge pins.

Same here too
> 
> Cheers,
> Andre
> 
> > +
> > +/* Connected to the Bootloader/Console of the ESP32 */
> > +&uart1 {
> > +	pinctrl-0 = <&uart1_pg6_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> > +/* Exposed as the Console/Debug UART on the card-edge */
> > +&uart3 {
> > +	pinctrl-0 = <&uart3_pb_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};


--nextPart3829144.MHq7AAxBmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEPv6dcBmn59ssZMkSJnN+drMVRtgFAmhtNwMACgkQJnN+drMV
Rtg3VQf9En80GmrC7Ph0W7mn6Jn1BLaNfAO917+LAH71HdBz+iT66X/JOziYZtcD
PtHAyAVYdGgyrsC63wI3kzo0kikZc12Y7DRhwDm1RYvvEwE/EoT+4AzXHTsC5jbs
FvAmGV8a8As7iQQXn714pq7SsoYR98bGCK2NenbKzYrnOvgjVWiAX+xn0s4ysNzQ
ktnRDDJnQRHeguZvXlE+1IuqaMmEJk32PHo+Uuq/ZJ6u3y4gUTEbGxGYC0YzI/um
4LeKJEWDGQwz4T1PhKqhYt08Gomutx40lsHfDGZ6vvBpmOTjNYHy081kFrKZl5GP
LHiARQT12DxweW0YZsNfadfEElTV6g==
=LcEn
-----END PGP SIGNATURE-----

--nextPart3829144.MHq7AAxBmi--





