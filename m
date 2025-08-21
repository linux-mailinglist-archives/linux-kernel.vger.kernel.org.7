Return-Path: <linux-kernel+bounces-780016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34651B2FCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48511D01A15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833525B1EA;
	Thu, 21 Aug 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="CoJke/Tf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220F24DCF6;
	Thu, 21 Aug 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785956; cv=pass; b=u2/GltPHtXmb6ZUKijjhzk7mReUKAdIDoFbsJerDrTt9b0Pm6OpTNr5o5jiw1oAVeBeio/f5EojERI/Qb62PVo9LFkwPCZh1gyAOudQfijhcVdKyHaIrAWvj+K4Oc8cjTmOXEyfJej1haqSTKo/N5Gp1bOu7vqD+W0Mn+iRIVQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785956; c=relaxed/simple;
	bh=79KOZzoMWXYKX1JSrWiAtldTsC6RMZZo5XxiEg1mdsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IigIbWO9B7lVZ+ctAMRCEM+5BPv6cJ2vawIl3LtYtZunSgAXrnsK/AYqpFdVVi12XBWvJRRvPRFp2JFzGw0Su4KtfPe3UxH40BfCDQpaEHm1oOiZmuYUNw6oK0l2YbgivXtkKTMz3KQej23AmGhIDb9NV4e9TbCypVW/8LB5NJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=CoJke/Tf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755785931; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TITSWMGflXBYwia8q7EzZMAcvHC0xFg4RPhvCCkChyK8z483MvQFXjW8jyBvFLcqLqGJahkwtP8l0BFmv95BI1TLP0qwGPn140VQMk5oHLjvDvmLnAX1PlhzOUTlalUvvOfGYQI9Li4aWp+heiwh7dZ+1A4/v+va8TVh7jVCocM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755785931; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y6X4AGpWLKNADRRQKUdpfbMSeoRMobXM+6PeVQBuBwY=; 
	b=e8q5Yzeo9yZYOW7j30p3P5H6FOL5f5/btW3ynnplmvhUuloITkZgolesj5bVeOj/hz179YUGkqiga2wBLBZosB7x+WsgSfTSZidGFIgnW4P7MJYJUNeOldXlkDr4ytpa+Uv9iiMlxQUT1j1KH0d01P5xlpBreBPgDZp81ge31yA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755785931;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=y6X4AGpWLKNADRRQKUdpfbMSeoRMobXM+6PeVQBuBwY=;
	b=CoJke/TfpE6zb1cNaRhfljflsbXb3+tEfZIDvL3oFFFqlvdbkEG8e7KEcL/G4XQw
	z0wiHdrkPlVMD9zLZFnTIHG92p9NkQDo/exmmvFCzNZidnkvhKZxKuos7xQ+5Ooc0/k
	/lHOOmFRNDzrm4l506ijFmcjJgP0Vq4L6MPZZ9Ug=
Received: by mx.zohomail.com with SMTPS id 175578592813233.35386089127883;
	Thu, 21 Aug 2025 07:18:48 -0700 (PDT)
Message-ID: <ac1347ee9dffc3d7a0bea1263ef56eb06f0c1a1d.camel@collabora.com>
Subject: Re: [PATCH v3 1/4] arm64: dts: mediatek: mt8390-genio-700-evk: Add
 Grinn GenioSBC-700
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Mateusz Koza <mateusz.koza@grinn-global.com>, 
	angelogioacchino.delregno@collabora.com, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com, andrew@lunn.ch
Date: Thu, 21 Aug 2025 16:18:43 +0200
In-Reply-To: <20250820120905.993189-2-mateusz.koza@grinn-global.com>
References: <20250820120905.993189-1-mateusz.koza@grinn-global.com>
	 <20250820120905.993189-2-mateusz.koza@grinn-global.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Mateusz,

On Wed, 2025-08-20 at 14:09 +0200, Mateusz Koza wrote:
> Add support for Grinn GenioSBC-700. The Grinn GenioSBC-700 is a
> single-board computer based on the MediaTek Genio 700 SoC. Its device
> tree is split into separate SoM (.dtsi) and SBC (.dtsi) files, which
> are
> combined in the SoC-specific .dts file.
>=20
> More details about the hardware:
> - https://grinn-global.com/products/grinn-geniosom-700
> - https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc
>=20
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
> ---
> =C2=A0arch/arm64/boot/dts/mediatek/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../mediatek/mt8390-grinn-genio-700-sbc.dts=C2=A0=C2=A0 |=C2=A0 19 =
+
> =C2=A0.../dts/mediatek/mt8390-grinn-genio-sbc.dtsi=C2=A0 | 674
> ++++++++++++++++++
> =C2=A0.../dts/mediatek/mt8390-grinn-genio-som.dtsi=C2=A0 | 209 ++++++
> =C2=A04 files changed, 903 insertions(+)
> =C2=A0create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-
> 700-sbc.dts
> =C2=A0create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-
> sbc.dtsi
> =C2=A0create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-
> som.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
> b/arch/arm64/boot/dts/mediatek/Makefile
> index 1dcea8b9aed9..7383d75d8041 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -104,6 +104,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8365-evk-
> hdmi.dtbo
> =C2=A0dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8370-genio-510-evk.dtb
> =C2=A0dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-genio-1200-evk.dtb
> =C2=A0dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8390-genio-700-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8390-grinn-genio-700-sbc.dtb
> =C2=A0dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-kontron-3-5-sbc-i1200.dtb
> =C2=A0dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-radxa-nio-12l.dtb
> =C2=A0dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-radxa-nio-12l-8-hd-panel.dt=
bo
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-
> sbc.dts b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
> new file mode 100644
> index 000000000000..a37507a5a5d0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 Grinn sp. z o.o.
> + * Author: Mateusz Koza <mateusz.koza@grinn-global.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8188.dtsi"
> +#include "mt8390-grinn-genio-som.dtsi"
> +#include "mt8390-grinn-genio-sbc.dtsi"
> +
> +/ {
> +	model =3D "Grinn GenioSBC-700";
> +	compatible =3D "grinn,genio-700-sbc", "mediatek,mt8390",
> "mediatek,mt8188";
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0 0x40000000 1 0x00000000>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
> new file mode 100644
> index 000000000000..22765b9a6d20
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
> @@ -0,0 +1,674 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 Grinn sp. z o.o.
> + * Author: Mateusz Koza <mateusz.koza@grinn-global.com>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	chassis-type =3D "embedded";
> +	aliases {
> +		ethernet0 =3D &eth;
> +		i2c0 =3D &i2c0;
> +		i2c2 =3D &i2c2;
> +		i2c3 =3D &i2c3;
> +		i2c5 =3D &i2c5;
> +		i2c6 =3D &i2c6;
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:921600n8";
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible =3D "linaro,optee-tz";
> +			method =3D "smc";
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/*
> +		 * 12 MiB reserved for OP-TEE (BL32)
> +		 * +-----------------------+ 0x43e0_0000
> +		 * |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHMEM 2MiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> +		 * +-----------------------+ 0x43c0_0000
> +		 * |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | TA_RAM=C2=A0 8MiB |
> +		 * + TZDRAM +--------------+ 0x4340_0000
> +		 * |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | TEE_RAM 2MiB |
> +		 * +-----------------------+ 0x4320_0000
> +		 */
> +		optee_reserved: optee@43200000 {
> +			no-map;
> +			reg =3D <0 0x43200000 0 0x00c00000>;
> +		};
> +
> +		scp_mem: memory@50000000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +
> +		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: memory@54600000 {
> +			no-map;
> +			reg =3D <0 0x54600000 0x0 0x200000>;
> +		};
> +
> +		apu_mem: memory@55000000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x55000000 0 0x1400000>; /* 20 MB
> */
> +		};
> +
> +		vpu_mem: memory@57000000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x57000000 0 0x1400000>; /* 20 MB
> */
> +		};
> +
> +		adsp_mem: memory@60000000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x60000000 0 0xf00000>;
> +			no-map;
> +		};
> +
> +		afe_dma_mem: memory@60f00000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x60f00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		adsp_dma_mem: memory@61000000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x61000000 0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	connector {
> +		compatible =3D "hdmi-connector";
> +		label =3D "hdmi";
> +		type =3D "a";
> +		ddc-i2c-bus =3D <&hdmi_ddc>;
> +		hdmi-pwr-supply =3D <&hdmi_phy>;
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi0_out>;
> +			};
> +		};
This node and several others below refer or override nodes related to
DPI, HDMI controller and PHY (hdmi0, dpi1, hdmi_ddc, hdmi_phy...), but
their support for MT8188 SoC and its variants (MT8370, MT8390...) is
not yet present in upstream mt8188.dtsi.=C2=A0
So, if this patch is applied on a branch based on recent linux-next or
RC tags, this new device tree won't build.=C2=A0
So, please remove them for now and check it builds and is also passing
the dtbs check.

Best regards,
Louis-Alexis
> +	};
> +
> +	reg_sbc_vsys: regulator-vsys {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vsys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_fixed_5v: regulator-0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed_5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply =3D <&reg_sbc_vsys>;
> +	};
> +
> +	reg_fixed_4v2: regulator-1 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed_4v2";
> +		regulator-min-microvolt =3D <4200000>;
> +		regulator-max-microvolt =3D <4200000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply =3D <&reg_sbc_vsys>;
> +	};
> +
> +	reg_fixed_3v3: regulator-2 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed_3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply =3D <&reg_sbc_vsys>;
> +	};
> +};
> +
> +&pio {
> +	gpio-line-names =3D
> +	/*=C2=A0 0 -=C2=A0 4=C2=A0=C2=A0 */ "RPI_GPIO0", "RPI_GPIO1", "", "",
> "RPI_GPIO4",
> +	/*=C2=A0 5 -=C2=A0 9=C2=A0=C2=A0 */ "", "RPI_GPIO6", "", "", "RPI_GPIO9=
",
> +	/* 10 - 14=C2=A0=C2=A0 */ "RPI_GPIO10", "RPI_GPIO11", "", "", "",
> +	/* 15 - 19=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 20 - 24=C2=A0=C2=A0 */ "", "RPI_GPIO21", "", "RPI_GPIO23", "",
> +	/* 25 - 29=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 30 - 34=C2=A0=C2=A0 */ "RPI_GPIO30", "", "", "", "",
> +	/* 35 - 39=C2=A0=C2=A0 */ "RPI_GPIO35", "RPI_GPIO36", "", "", "",
> +	/* 40 - 44=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 45 - 49=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 50 - 54=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 55 - 59=C2=A0=C2=A0 */ "RPI_GPIO55", "RPI_GPIO56", "", "",
> "RPI_GPIO59",
> +	/* 60 - 64=C2=A0=C2=A0 */ "RPI_GPIO60", "", "", "", "",
> +	/* 65 - 69=C2=A0=C2=A0 */ "", "", "", "", "RPI_GPIO69",
> +	/* 70 - 74=C2=A0=C2=A0 */ "", "", "RPI_GPIO72", "RPI_GPIO73",
> "RPI_GPIO74",
> +	/* 75 - 79=C2=A0=C2=A0 */ "", "", "", "", "RPI_GPIO79",
> +	/* 80 - 84=C2=A0=C2=A0 */ "RPI_GPIO80", "RPI_GPIO81", "RPI_GPIO82",
> "", "",
> +	/* 85 - 89=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 90 - 94=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/* 95 - 99=C2=A0=C2=A0 */ "", "", "", "", "",
> +	/*100 - 104=C2=A0 */ "", "", "", "", "",
> +	/*105 - 109=C2=A0 */ "", "", "", "", "",
> +	/*110 - 114=C2=A0 */ "", "", "", "", "",
> +	/*115 - 119=C2=A0 */ "", "", "", "", "",
> +	/*120 - 124=C2=A0 */ "", "RPI_GPIO121", "RPI_GPIO122",
> "RPI_GPIO123", "RPI_GPIO124";
> +
> +	i2c0_pins: i2c0-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO56__FUNC_B1_SDA0>,
> +				 <PINMUX_GPIO55__FUNC_B1_SCL0>;
> +			bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +			drive-strength-microamp =3D <1000>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO60__FUNC_B1_SDA2>,
> +				 <PINMUX_GPIO59__FUNC_B1_SCL2>;
> +			bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +			drive-strength-microamp =3D <1000>;
> +		};
> +	};
> +
> +	i2c3_pins: i2c3-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO62__FUNC_B1_SDA3>,
> +				 <PINMUX_GPIO61__FUNC_B1_SCL3>;
> +			bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +			drive-strength-microamp =3D <1000>;
> +		};
> +	};
> +
> +	i2c5_pins: i2c5-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO66__FUNC_B1_SDA5>,
> +				 <PINMUX_GPIO65__FUNC_B1_SCL5>;
> +			bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +			drive-strength-microamp =3D <1000>;
> +		};
> +	};
> +
> +	i2c6_pins: i2c6-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO68__FUNC_B1_SDA6>,
> +				 <PINMUX_GPIO67__FUNC_B1_SCL6>;
> +			bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +			drive-strength-microamp =3D <1000>;
> +		};
> +	};
> +
> +	uart0_pins: uart0-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO31__FUNC_O_UTXD0>,
> +				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO86__FUNC_O_UTXD1>,
> +				 <PINMUX_GPIO87__FUNC_I1_URXD1>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO35__FUNC_O_UTXD2>,
> +				 <PINMUX_GPIO36__FUNC_I1_URXD2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie_pins_default: pcie-default {
> +		mux {
> +			pinmux =3D <PINMUX_GPIO47__FUNC_I1_WAKEN>,
> +				 <PINMUX_GPIO48__FUNC_O_PERSTN>,
> +				 <PINMUX_GPIO49__FUNC_B1_CLKREQN>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	eth_default_pins: eth-default-pins {
> +		pins-cc {
> +			pinmux =3D <PINMUX_GPIO139__FUNC_B0_GBE_TXC>,
> +				 <PINMUX_GPIO140__FUNC_I0_GBE_RXC>,
> +				 <PINMUX_GPIO141__FUNC_I0_GBE_RXDV>,
> +				 <PINMUX_GPIO142__FUNC_O_GBE_TXEN>;
> +			drive-strength =3D <8>;
> +		};
> +
> +		pins-mdio {
> +			pinmux =3D <PINMUX_GPIO143__FUNC_O_GBE_MDC>,
> +				 <PINMUX_GPIO144__FUNC_B1_GBE_MDIO>;
> +			drive-strength =3D <8>;
> +			input-enable;
> +		};
> +
> +		pins-power {
> +			pinmux =3D <PINMUX_GPIO145__FUNC_B_GPIO145>,
> +				 <PINMUX_GPIO146__FUNC_B_GPIO146>;
> +			output-high;
> +		};
> +
> +		pins-rxd {
> +			pinmux =3D <PINMUX_GPIO135__FUNC_I0_GBE_RXD3>,
> +				 <PINMUX_GPIO136__FUNC_I0_GBE_RXD2>,
> +				 <PINMUX_GPIO137__FUNC_I0_GBE_RXD1>,
> +				 <PINMUX_GPIO138__FUNC_I0_GBE_RXD0>;
> +			drive-strength =3D <8>;
> +		};
> +
> +		pins-txd {
> +			pinmux =3D <PINMUX_GPIO131__FUNC_O_GBE_TXD3>,
> +				 <PINMUX_GPIO132__FUNC_O_GBE_TXD2>,
> +				 <PINMUX_GPIO133__FUNC_O_GBE_TXD1>,
> +				 <PINMUX_GPIO134__FUNC_O_GBE_TXD0>;
> +			drive-strength =3D <8>;
> +		};
> +	};
> +
> +	eth_sleep_pins: eth-sleep-pins {
> +		pins-cc {
> +			pinmux =3D <PINMUX_GPIO139__FUNC_B_GPIO139>,
> +				 <PINMUX_GPIO140__FUNC_B_GPIO140>,
> +				 <PINMUX_GPIO141__FUNC_B_GPIO141>,
> +				 <PINMUX_GPIO142__FUNC_B_GPIO142>;
> +		};
> +
> +		pins-mdio {
> +			pinmux =3D <PINMUX_GPIO143__FUNC_B_GPIO143>,
> +				 <PINMUX_GPIO144__FUNC_B_GPIO144>;
> +			input-disable;
> +			bias-disable;
> +		};
> +
> +		pins-rxd {
> +			pinmux =3D <PINMUX_GPIO135__FUNC_B_GPIO135>,
> +				 <PINMUX_GPIO136__FUNC_B_GPIO136>,
> +				 <PINMUX_GPIO137__FUNC_B_GPIO137>,
> +				 <PINMUX_GPIO138__FUNC_B_GPIO138>;
> +		};
> +
> +		pins-txd {
> +			pinmux =3D <PINMUX_GPIO131__FUNC_B_GPIO131>,
> +				 <PINMUX_GPIO132__FUNC_B_GPIO132>,
> +				 <PINMUX_GPIO133__FUNC_B_GPIO133>,
> +				 <PINMUX_GPIO134__FUNC_B_GPIO134>;
> +		};
> +	};
> +
> +	spi2_pins: spi2-pins {
> +		pins-spi {
> +			pinmux =3D <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
> +				<PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
> +				<PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
> +				<PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
> +			bias-disable;
> +		};
> +	};
> +
> +	hdmi_vreg_pins: hdmi-vreg-pins {
> +		pins-pwr {
> +			pinmux =3D
> <PINMUX_GPIO50__FUNC_O_HDMITX20_PWR5V>;
> +			bias-disable;
> +		};
> +	};
> +
> +	hdmi_pins: hdmi-pins {
> +		pins-hotplug {
> +			pinmux =3D
> <PINMUX_GPIO51__FUNC_I0_HDMITX20_HTPLG>;
> +			bias-pull-down;
> +		};
> +
> +		pins-cec {
> +			pinmux =3D
> <PINMUX_GPIO52__FUNC_B1_HDMITX20_CEC>;
> +			bias-disable;
> +		};
> +
> +		pins-ddc {
> +			pinmux =3D
> <PINMUX_GPIO53__FUNC_B1_HDMITX20_SCL>,
> +			=09
> <PINMUX_GPIO54__FUNC_B1_HDMITX20_SDA>;
> +			drive-strength =3D <10>;
> +		};
> +	};
> +
> +	audio_default_pins: audio-default-pins {
> +		pins-cmd-dat {
> +			pinmux =3D <PINMUX_GPIO121__FUNC_B0_PCM_CLK>,
> +				 <PINMUX_GPIO122__FUNC_B0_PCM_SYNC>,
> +				 <PINMUX_GPIO123__FUNC_O_PCM_DO>,
> +				 <PINMUX_GPIO124__FUNC_I0_PCM_DI>;
> +		};
> +	};
> +};
> +
> +&eth {
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ethernet_phy0>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us =3D <0 11000 200000>;
> +	mediatek,tx-delay-ps =3D <30>;
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&eth_default_pins>;
> +	pinctrl-1 =3D <&eth_sleep_pins>;
> +	mediatek,mac-wol;
> +	snps,reset-gpio =3D <&pio 147 GPIO_ACTIVE_LOW>;
> +	status =3D "okay";
> +};
> +
> +&eth_mdio {
> +	ethernet_phy0: ethernet-phy@3 {
> +		reg =3D <3>;
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		eee-broken-1000t;
> +		interrupts-extended =3D <&pio 148 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins>;
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c2_pins>;
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c3_pins>;
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c5_pins>;
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c6_pins>;
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 =3D <&uart0_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 =3D <&uart1_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 =3D <&uart2_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&pcie {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie_pins_default>;
> +	status =3D "okay";
> +};
> +
> +&pciephy {
> +	status =3D "okay";
> +};
> +
> +&spi2 {
> +	pinctrl-0 =3D <&spi2_pins>;
> +	pinctrl-names =3D "default";
> +	mediatek,pad-select =3D <0>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	status =3D "okay";
> +};
> +
> +&vdosys1 {
> +	port {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		vdosys1_ep_ext: endpoint@1 {
> +			reg =3D <1>;
> +			remote-endpoint =3D <&ethdr0_in>;
> +		};
> +	};
> +};
> +
> +&ethdr0 {
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +
> +			ethdr0_in: endpoint@1 {
> +				reg =3D <1>;
> +				remote-endpoint =3D <&vdosys1_ep_ext>;
> +			};
> +		};
> +
> +		port@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +
> +			ethdr0_out: endpoint@1 {
> +				reg =3D <1>;
> +				remote-endpoint =3D <&merge5_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&merge5 {
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +
> +			merge5_in: endpoint@1 {
> +				reg =3D <1>;
> +				remote-endpoint =3D <&ethdr0_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +
> +			merge5_out: endpoint@1 {
> +				reg =3D <1>;
> +				remote-endpoint =3D <&dpi1_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&dpi1 {
> +	status =3D "okay";
> +};
> +
> +&dpi1_in {
> +	remote-endpoint =3D <&merge5_out>;
> +};
> +
> +&dpi1_out {
> +	remote-endpoint =3D <&hdmi0_in>;
> +};
> +
> +&hdmi {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&hdmi_pins>;
> +	status =3D "okay";
> +};
> +
> +&hdmi0_in {
> +	remote-endpoint =3D <&dpi1_out>;
> +};
> +
> +&hdmi0_out {
> +	remote-endpoint =3D <&hdmi_connector_in>;
> +};
> +
> +&hdmi_phy {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&hdmi_vreg_pins>;
> +	status =3D "okay";
> +};
> +
> +&u3phy0 {
> +	status =3D "okay";
> +};
> +
> +&u3phy1 {
> +	status =3D "okay";
> +};
> +
> +&u3phy2 {
> +	status =3D "okay";
> +};
> +
> +&xhci1 {
> +	status =3D "okay";
> +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	hub_2_0: hub@1 {
> +		compatible =3D "usb451,8027";
> +		reg =3D <1>;
> +		peer-hub =3D <&hub_3_0>;
> +		reset-gpios =3D <&pio 7 GPIO_ACTIVE_HIGH>;
> +		vdd-supply =3D <&reg_fixed_3v3>;
> +	};
> +
> +	hub_3_0: hub@2 {
> +		compatible =3D "usb451,8025";
> +		reg =3D <2>;
> +		peer-hub =3D <&hub_2_0>;
> +		reset-gpios =3D <&pio 7 GPIO_ACTIVE_HIGH>;
> +		vdd-supply =3D <&reg_fixed_3v3>;
> +	};
> +};
> +
> +&xhci2 {
> +	status =3D "okay";
> +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	hub@1 {
> +		compatible =3D "microchip,usb2513bi";
> +		reg =3D <1>;
> +		vdd-supply =3D <&reg_fixed_3v3>;
> +	};
> +};
> +
> +&ssusb0 {
> +	status =3D "okay";
> +	dr_mode =3D "peripheral";
> +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +};
> +
> +&ssusb1 {
> +	status =3D "okay";
> +	dr_mode =3D "host";
> +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +	maximum-speed =3D "super-speed";
> +};
> +
> +&ssusb2 {
> +	status =3D "okay";
> +	dr_mode =3D "host";
> +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +	maximum-speed =3D "high-speed";
> +};
> +
> +&scp_c0 {
> +	firmware-name =3D "mediatek/mt8188/scp.img";
> +	memory-region =3D <&scp_mem>;
> +	status =3D "okay";
> +};
> +
> +&gpu {
> +	mali-supply =3D <&mt6359_vproc2_buck_reg>;
> +	status =3D "okay";
> +};
> +
> +&adsp {
> +	memory-region =3D <&adsp_dma_mem>, <&adsp_mem>;
> +	status =3D "okay";
> +};
> +
> +&afe {
> +	memory-region =3D <&afe_dma_mem>;
> +	status =3D "okay";
> +};
> +
> +&sound {
> +	compatible =3D "mediatek,mt8390-mt6359-evk", "mediatek,mt8188-
> mt6359-evb";
> +	model =3D "mt8390-evk";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&audio_default_pins>;
> +	audio-routing =3D
> +		"Headphone", "Headphone L",
> +		"Headphone", "Headphone R",
> +		"AP DMIC", "AUDGLB",
> +		"AP DMIC", "MIC_BIAS_0",
> +		"AP DMIC", "MIC_BIAS_2",
> +		"DMIC_INPUT", "AP DMIC";
> +
> +	mediatek,adsp =3D <&adsp>;
> +	status =3D "okay";
> +
> +	dai-link-0 {
> +		link-name =3D "ETDM3_OUT_BE";
> +
> +		codec {
> +			sound-dai =3D <&hdmi 0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
> new file mode 100644
> index 000000000000..d88481beff9d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 Grinn sp. z o.o.
> + * Author: Mateusz Koza <mateusz.koza@grinn-global.com>
> + */
> +
> +#include "mt6359.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	aliases {
> +		i2c1 =3D &i2c1;
> +		mmc0 =3D &mmc0;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c1_pins>;
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +};
> +
> +&mfg0 {
> +	domain-supply =3D <&mt6359_vproc2_buck_reg>;
> +};
> +
> +&mfg1 {
> +	domain-supply =3D <&mt6359_vsram_others_ldo_reg>;
> +};
> +
> +&mmc0 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default", "state_uhs";
> +	pinctrl-0 =3D <&mmc0_default_pins>;
> +	pinctrl-1 =3D <&mmc0_uhs_pins>;
> +	bus-width =3D <8>;
> +	max-frequency =3D <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	supports-cqe;
> +	cap-mmc-hw-reset;
> +	no-sdio;
> +	no-sd;
> +	hs400-ds-delay =3D <0x1481b>;
> +	vmmc-supply =3D <&mt6359_vemc_1_ldo_reg>;
> +	vqmmc-supply =3D <&mt6359_vufs_ldo_reg>;
> +	non-removable;
> +};
> +
> +&mt6359_vbbck_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcn18_ldo_reg {
> +	regulator-name =3D "vcn18_pmu";
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcn33_2_bt_ldo_reg {
> +	regulator-name =3D "vcn33_2_pmu";
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcore_buck_reg {
> +	regulator-name =3D "dvdd_proc_l";
> +	regulator-always-on;
> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +	regulator-name =3D "dvdd_core";
> +	regulator-always-on;
> +};
> +
> +&mt6359_vpa_buck_reg {
> +	regulator-name =3D "vpa_pmu";
> +	regulator-max-microvolt =3D <3100000>;
> +};
> +
> +&mt6359_vproc2_buck_reg {
> +	/* The name "vgpu" is required by mtk-regulator-coupler */
> +	regulator-name =3D "vgpu";
> +	regulator-min-microvolt =3D <550000>;
> +	regulator-max-microvolt =3D <800000>;
> +	regulator-coupled-with =3D <&mt6359_vsram_others_ldo_reg>;
> +	regulator-coupled-max-spread =3D <6250>;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +	regulator-name =3D "dvdd_adsp";
> +	regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +	regulator-name =3D "va12_abb2_pmu";
> +	regulator-always-on;
> +};
> +
> +&mt6359_vsim1_ldo_reg {
> +	regulator-name =3D "vsim1_pmu";
> +	regulator-enable-ramp-delay =3D <480>;
> +};
> +
> +&mt6359_vsram_others_ldo_reg {
> +	/* The name "vsram_gpu" is required by mtk-regulator-coupler
> */
> +	regulator-name =3D "vsram_gpu";
> +	regulator-min-microvolt =3D <750000>;
> +	regulator-max-microvolt =3D <800000>;
> +	regulator-coupled-with =3D <&mt6359_vproc2_buck_reg>;
> +	regulator-coupled-max-spread =3D <6250>;
> +};
> +
> +&mt6359_vufs_ldo_reg {
> +	regulator-name =3D "vufs18_pmu";
> +	regulator-always-on;
> +};
> +
> +&pio {
> +
> +	i2c1_pins: i2c1-pins {
> +		pins {
> +			pinmux =3D <PINMUX_GPIO58__FUNC_B1_SDA1>,
> +				 <PINMUX_GPIO57__FUNC_B1_SCL1>;
> +			bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +			drive-strength-microamp =3D <1000>;
> +		};
> +	};
> +
> +	mmc0_default_pins: mmc0-default-pins {
> +		pins-clk {
> +			pinmux =3D
> <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
> +			drive-strength =3D <6>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux =3D
> <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
> +			=09
> <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
> +			=09
> <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
> +			=09
> <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
> +			=09
> <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
> +			=09
> <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
> +			=09
> <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
> +			=09
> <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
> +			=09
> <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength =3D <6>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-rst {
> +			pinmux =3D
> <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
> +			drive-strength =3D <6>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	mmc0_uhs_pins: mmc0-uhs-pins {
> +		pins-clk {
> +			pinmux =3D
> <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
> +			drive-strength =3D <8>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux =3D
> <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
> +			=09
> <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
> +			=09
> <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
> +			=09
> <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
> +			=09
> <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
> +			=09
> <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
> +			=09
> <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
> +			=09
> <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
> +			=09
> <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength =3D <8>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-ds {
> +			pinmux =3D
> <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
> +			drive-strength =3D <8>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux =3D
> <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
> +			drive-strength =3D <8>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +};
> +
> +&pmic {
> +	interrupt-parent =3D <&pio>;
> +	interrupts =3D <222 IRQ_TYPE_LEVEL_HIGH>;
> +
> +	mt6359keys: keys {
> +		compatible =3D "mediatek,mt6359-keys";
> +		mediatek,long-press-mode =3D <1>;
> +		power-off-time-sec =3D <0>;
> +
> +		power-key {
> +			linux,keycodes =3D <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
> +};

