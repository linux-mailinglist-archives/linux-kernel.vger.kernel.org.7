Return-Path: <linux-kernel+bounces-815099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1AB55FB0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02C71CC0F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88B2E973F;
	Sat, 13 Sep 2025 09:03:05 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8D29AB12
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754185; cv=none; b=C6/H5fhLVaF7w2cm3JskL+Z5Fn3JRapAQJXKHyRrWpMIp5BEBuFYmoEcj8E1Vn606N2uhuKXKXnGs+VbCoLcAGKFWFQoeIyQLAm8brPeJZs/hthporAcfdAt2eD5w6SnxfYJOWuich0XpNKecQ/XMnQdIpLhICN7D2sOHGpqx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754185; c=relaxed/simple;
	bh=FtkU5WbYNwooptUFdXcibNW6kvMRzKs6zenXx6kEbT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOm0ggq+uI/g1KA6LsP3Yff/MP1ieyQDrIMcw54UlvfOKFdNsHml/NF0IGZRCZuutYr18cxDOjSPY9wN14xgJv8V14VRJWTCAnAlOiGpayo5f17DdliqeRTy5MKvdLcZemaGZ9BsJPNflPBBAt2iRfJVn97TN33JCylgJnqHnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-571a58b385aso1229484e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757754179; x=1758358979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9yf8Ktp4HQCNlkhLraLZ3muqM4SOy6F+jw9y0V/VXs=;
        b=J0YPf3lD2UZB84UIQp8gp3hJeF/mvqRU9unlUQDm+dxRes/i4eLjhaUr7QzaWHyttt
         VLqPoTtDJzV3b2jBzk9g45pxBnclFKzyY6zINQzGxV2Lct4rFGCp3404AWjbV0uudsNM
         IEI2SVAFVapIKg/hapopxTMDxU9D3CoDKrkJw0OPjZnOCdkF4BLX/HZXTfB+WU5M5TJv
         qXmfdcrtJZxHxBl+oWe7VF1zpvKIBNp+HMvOpwCtyQ6pfAZem+rMtARm95S3KhNDuw/T
         JGSs1ieuFcBLq+G5I88Mlj5UV7CKjEnWruHNEfYdWBM+Fq9g6aPPiDsldUR/Nr0udvX+
         uQGA==
X-Forwarded-Encrypted: i=1; AJvYcCWp6AqaGxK+3w2ySnz7tZKKhL9IgvuZBQo9UYpXTUtYpH2otunl1SeFPlIrgXEtjUpxnLSqkBNt137Au9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tix7EB7XuGBv8lRb5SSCVGpdPNi9eg3aJe5aE3+vTFrzI6Rh
	s7dytXfT1mawb5LkRo+cJ0h8w5n48oojYII/TDS3XTp6ZU8BejiC+58sBsTfP7dX
X-Gm-Gg: ASbGncsl5CaYAKdvnBPXfp4OUknavPUc3aKJiiPBsqdZqDkmnQ/4eIgja1nQdOTsyWs
	rnLhNgr4kkmREOVrVHXbsTqu5rSRU3p3g989en1GSr1Vvj8RIzfIIh5dnhnDbn70VILnm9xwDyO
	aqFpvcv9FzTHp8c30zprNyeGdI3Puw1/1EMJSLP1YlO5pplqoMJArxfourEXhewNBuJ1SdeEDT1
	FeoWzlMLHA7kR+L75pBZQvm+ZCJaLzfnyaBX7BGnD1Wbl4EAVGTZeVjitRiShBVqcgQSV1e6rmn
	tP4xf+oY0uGKyhdpOb+mqI8lSZ3WMJqOoXdtIQ7RsMoeonca2Orv/H142GC5ouCK4pTCoZI+Yc/
	X8FjE4cWtvQ9IqgmN7R1jzGRQFF1SWBzBCWjlihUzS2ODDvzJGR6yBYw=
X-Google-Smtp-Source: AGHT+IH9Pg72CcLf5MUGbRaC1vSoE8hF9f6MnE4zqZggUQm9ZpjXK+zMO07ca2QZIk21yB6tZ7YeYw==
X-Received: by 2002:a05:6512:3b0e:b0:572:97e:9297 with SMTP id 2adb3069b0e04-572097e949cmr351299e87.1.1757754178708;
        Sat, 13 Sep 2025 02:02:58 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6d0e20csm645508e87.38.2025.09.13.02.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 02:02:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336b908cbaaso23767101fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:02:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBYcz11i9vtjSBAmDtMZdzH0z1GI3hkWt8cg4ysYOLdCTq6eqtk3/Tyd/te76w1TRCpSNPgXA82LQ6HD0=@vger.kernel.org
X-Received: by 2002:a05:651c:31da:b0:338:11e1:c7d9 with SMTP id
 38308e7fff4ca-351415650afmr16006951fa.43.1757754176539; Sat, 13 Sep 2025
 02:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831162536.2380589-1-lukas.schmid@netcube.li> <20250831162536.2380589-4-lukas.schmid@netcube.li>
In-Reply-To: <20250831162536.2380589-4-lukas.schmid@netcube.li>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 13 Sep 2025 17:02:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v66iD1BBwOeECrckmf_d-xQmmMzFhkj-SjO5ja7i1f0YDw@mail.gmail.com>
X-Gm-Features: Ac12FXxX2oqvFnH_76fKkzLJQXu3WsG74ENxnFjJOqn4Ha6355qDBEr_yZ7zdgg
Message-ID: <CAGb2v66iD1BBwOeECrckmf_d-xQmmMzFhkj-SjO5ja7i1f0YDw@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] ARM: dts: sunxi: add support for NetCube Systems
 Nagami SoM
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 1, 2025 at 12:26=E2=80=AFAM Lukas Schmid <lukas.schmid@netcube.=
li> wrote:
>
> NetCube Systems Nagami SoM is a module based around the Allwinner T113s
> SoC. It includes the following features and interfaces:
>
> - 128MB DDR3 included in SoC
> - 10/100 Mbps Ethernet using LAN8720A phy
> - One USB-OTG interface
> - One USB-Host interface
> - One I2S interface with in and output support
> - Two CAN interfaces
> - ESP32 over SDIO
> - One SPI interface
> - I2C EEPROM for MAC address
> - One QWIIC I2C Interface with dedicated interrupt pin shared with EEPROM
> - One external I2C interface
> - SD interface for external SD-Card
>
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 250 ++++++++++++++++++
>  1 file changed, 250 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagam=
i.dtsi
>
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi =
b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
> new file mode 100644
> index 0000000000000..4d3627f6d58d2
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025 Lukas Schmid <lukas.schmid@netcube.li>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-t113s.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       model =3D "NetCube Systems Nagami SoM";
> +       compatible =3D "netcube,nagami", "allwinner,sun8i-t113s";
> +
> +       aliases {
> +               serial1 =3D &uart1; // ESP32 Bootloader UART
> +               serial3 =3D &uart3; // Console UART on Card Edge
> +               ethernet0 =3D &emac;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial3:115200n8";
> +       };
> +
> +       /* module wide 3.3V supply directly from the card edge */
> +       reg_vcc3v3: regulator-3v3 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc-3v3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       /* SY8008 DC/DC regulator on the board, also supplying VDD-SYS */
> +       reg_vcc_core: regulator-core {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc-core";
> +               regulator-min-microvolt =3D <880000>;
> +               regulator-max-microvolt =3D <880000>;
> +               vin-supply =3D <&reg_vcc3v3>;
> +       };
> +
> +       /* USB0 MUX to switch connect to Card-Edge only after BootROM */
> +       usb0_sec_mux: mux-controller{
> +               compatible =3D "gpio-mux";
> +               #mux-control-cells =3D <0>;
> +               mux-gpios =3D <&pio 3 9 GPIO_ACTIVE_HIGH>; /* PD9 */
> +               idle-state =3D <1>; /* USB connected to Card-Edge by defa=
ult */
> +       };
> +
> +       /* Reset of ESP32 */
> +       wifi_pwrseq: wifi-pwrseq {
> +               compatible =3D "mmc-pwrseq-simple";
> +               reset-gpios =3D <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
> +               post-power-on-delay-ms =3D <1500>;
> +               power-off-delay-us =3D <200>;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply =3D <&reg_vcc_core>;
> +};
> +
> +&cpu1 {
> +       cpu-supply =3D <&reg_vcc_core>;
> +};
> +
> +&dcxo {
> +       clock-frequency =3D <24000000>;
> +};
> +
> +&emac {
> +       nvmem-cells =3D <&eth0_macaddress>;
> +       nvmem-cell-names =3D "mac-address";
> +       phy-handle =3D <&lan8720a>;
> +       phy-mode =3D "rmii";
> +       pinctrl-0 =3D <&rmii_pe_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +/* Default I2C Interface on Card-Edge */
> +&i2c2 {
> +       pinctrl-0 =3D <&i2c2_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "disabled";
> +};
> +
> +/* Exposed as the QWIIC connector and used by the internal EEPROM */
> +&i2c3 {
> +       pinctrl-0 =3D <&i2c3_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +
> +       eeprom0: eeprom@50 {
> +               compatible =3D "atmel,24c02";             /* actually it'=
s a 24AA02E48 */
> +               reg =3D <0x50>;
> +               pagesize =3D <16>;
> +               read-only;
> +               vcc-supply =3D <&reg_vcc3v3>;
> +
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +
> +               eth0_macaddress: macaddress@fa {
> +                       reg =3D <0xfa 0x06>;
> +               };
> +       };
> +};
> +
> +/* Default I2S Interface on Card-Edge */
> +&i2s1 {
> +       pinctrl-0 =3D <&i2s1_pins>, <&i2s1_din_pins>, <&i2s1_dout_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "disabled";
> +};
> +
> +/* Phy is on SoM. MDI signals pre-magentics are on the card edge */

                                 ^ pre-magnetics?

Will fix up when applying if nothing else in the series is wrong.

ChenYu

> +&mdio {
> +       lan8720a: ethernet-phy@0 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <0>;
> +       };
> +};
> +
> +/* Default SD Interface on Card-Edge */
> +&mmc0 {
> +       pinctrl-0 =3D <&mmc0_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "disabled";
> +};
> +
> +/* Connected to the on-board ESP32 */
> +&mmc1 {
> +       pinctrl-0 =3D <&mmc1_pins>;
> +       pinctrl-names =3D "default";
> +       vmmc-supply =3D <&reg_vcc3v3>;
> +       bus-width =3D <4>;
> +       non-removable;
> +       mmc-pwrseq =3D <&wifi_pwrseq>;
> +       status =3D "okay";
> +};
> +
> +/* Connected to the on-board eMMC */
> +&mmc2 {
> +       pinctrl-0 =3D <&mmc2_pins>;
> +       pinctrl-names =3D "default";
> +       vmmc-supply =3D <&reg_vcc3v3>;
> +       vqmmc-supply =3D <&reg_vcc3v3>;
> +       bus-width =3D <4>;
> +       non-removable;
> +       status =3D "okay";
> +};
> +
> +&pio {
> +       vcc-pb-supply =3D <&reg_vcc3v3>;
> +       vcc-pc-supply =3D <&reg_vcc3v3>;
> +       vcc-pd-supply =3D <&reg_vcc3v3>;
> +       vcc-pe-supply =3D <&reg_vcc3v3>;
> +       vcc-pf-supply =3D <&reg_vcc3v3>;
> +       vcc-pg-supply =3D <&reg_vcc3v3>;
> +
> +       gpio-line-names =3D "", "", "", "", // PA
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "CAN0_TX", "CAN0_RX", /=
/ PB
> +                                         "CAN1_TX", "CAN1_RX", "UART3_TX=
", "UART3_RX",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "eMMC_CLK", "eMMC_CMD",=
 // PC
> +                                         "eMMC_D2", "eMMC_D1", "eMMC_D0"=
, "eMMC_D3",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "", // PD
> +                                         "", "", "", "",
> +                                         "", "USB_SEC_EN", "SPI1_CS", "S=
PI1_CLK",
> +                                         "SPI1_MOSI", "SPI1_MISO", "SPI1=
_HOLD", "SPI1_WP",
> +                                         "PD16", "", "", "",
> +                                         "I2C2_SCL", "I2C2_SDA", "PD22",=
 "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "ETH_CRSDV", "ETH_RXD0", "ETH_R=
XD1", "ETH_TXCK", // PE
> +                                         "ETH_TXD0", "ETH_TXD1", "ETH_TX=
EN", "",
> +                                         "ETH_MDC", "ETH_MDIO", "QWIIC_n=
INT", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "SD_D1", "SD_D0", "SD_CLK", "SD=
_CLK", // PF
> +                                         "SD_D3", "SD_D2", "PF6", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "ESP_CLK", "ESP_CMD", "ESP_D0",=
 "ESP_D1", // PG
> +                                         "ESP_D2", "ESP_D3", "UART1_TXD"=
, "UART1_RXD",
> +                                         "ESP_nBOOT", "ESP_nRST", "I2C3_=
SCL", "I2C3_SDA",
> +                                         "I2S1_WS", "I2S1_CLK", "I2S1_DI=
N0", "I2S1_DOUT0",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "",
> +                                         "", "", "", "";
> +};
> +
> +/* Remove the unused CK pin from the pinctl as it is unconnected */
> +&rmii_pe_pins {
> +       pins =3D "PE0", "PE1", "PE2", "PE3", "PE4",
> +                  "PE5", "PE6", "PE8", "PE9";
> +};
> +
> +/* Default SPI Interface on Card-Edge */
> +&spi1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       pinctrl-0 =3D <&spi1_pins>, <&spi1_hold_pin>, <&spi1_wp_pin>;
> +       pinctrl-names =3D "default";
> +       cs-gpios =3D <0>;
> +       status =3D "disabled";
> +};
> +
> +/* Connected to the Bootloader/Console of the ESP32 */
> +&uart1 {
> +       pinctrl-0 =3D <&uart1_pg6_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +/* Console/Debug UART on Card-Edge */
> +&uart3 {
> +       pinctrl-0 =3D <&uart3_pb_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> --
> 2.39.5
>
>

