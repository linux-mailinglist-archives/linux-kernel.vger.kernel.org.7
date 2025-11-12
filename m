Return-Path: <linux-kernel+bounces-897958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349DC53FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D7A3BA347
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2752BF001;
	Wed, 12 Nov 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQXuK2XY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8433A016;
	Wed, 12 Nov 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972888; cv=none; b=fZd/7JPYmSGN2r2yFUgwGs5kcfHMV3OsfAz2miqNtk6aDiYZXWkrkendjoh2YHt4N81ReYdk1xjhYTFARVxdfMdWUmfDu1Q3f7spwKCZvVAwDxJTpH3H0RVTT1TfsFShATbA65MXKUX3Vw+ZDdrC+SgIq4HSuhqYux/eW9rX954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972888; c=relaxed/simple;
	bh=KHFw9Fj0TSvi+G3yTQ4AOGjx13r1Cdtagbf3JpY/9Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gXAzo+mOa7iSRrA/RwLcyXRf7SwR47GWJW1feLP6GuIlCZVBuqmK8a3K3GbvibkigN3LUU4vuoAe4kfaA1p5fVJ4BSt9QL7ghkMHQKAU+3NMGRf4VOMnuE5qA6jmQF09K7q3gC/ISR38h/Dc5E31T13AORJX2r3H0JJtr5AiQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQXuK2XY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E8CC4CEF1;
	Wed, 12 Nov 2025 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972888;
	bh=KHFw9Fj0TSvi+G3yTQ4AOGjx13r1Cdtagbf3JpY/9Hg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fQXuK2XYp3xTsoEOAnwtxwVXxwKYpeIg3zWGfnk83tVJapjtggCyEes9l6kJEZpzt
	 fgCtyU5OA6D+zB5YHURrwF6BaubyZ+6LkINr/UKLNiEeS8pBh0ANpNKWl+smi4Yifb
	 nOhpcG/cOyCyY1lrzx8IroceOEBWDIsE3widuegLPRa90erf7Pn3IKQnTBc7vmc+ug
	 EkJvNBF1wZ2NctAqOsbXrV8237Ofoybgl95v+0B7lSpc5Jky7EUeqnznqH+GEX4mc0
	 rLQdsp4tQrJcowC8NmhIxrVAIPycTu0ohy02xo/kEFIsny8z0PfRXfIhqVlxksfUp/
	 ijpB8RXY9s3VQ==
Message-ID: <95aaafe2-a362-4f55-9d38-c0d2dcb21cf0@kernel.org>
Date: Wed, 12 Nov 2025 12:41:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: socfpga: add Agilex3 board
To: niravkumarlaxmidas.rabara@altera.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
 <20251112105657.1291563-3-niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251112105657.1291563-3-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/25 04:56, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Agilex3 SoCFPGA development kit is a small form factor board similar to
> Agilex5 013b board.
> Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
> of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.

Please fix up the message's formatting a bit. I don't think you need the 
additional newline.

> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
> v3 change:
>   - Add agilex5 fallback compatible string.
> 
> v2 link:
> https://lore.kernel.org/all/97fea9a15bfe2a3d52d5b75bee6bda25615422e7.1762840092.git.niravkumarlaxmidas.rabara@altera.com/
> 
> v2 changes:
>   - Use separate dtsi file for agilex3 instead of using agilex5 dtsi.
> 
> v1 link:
> https://lore.kernel.org/all/aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com/
> 
>   arch/arm64/boot/dts/intel/Makefile            |   1 +
>   .../arm64/boot/dts/intel/socfpga_agilex3.dtsi |  17 +++
>   .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 127 ++++++++++++++++++
>   3 files changed, 145 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 391d5cbe50b3..a117268267ee 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -2,6 +2,7 @@
>   dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>   				socfpga_agilex_socdk.dtb \
>   				socfpga_agilex_socdk_nand.dtb \
> +				socfpga_agilex3_socdk.dtb \
>   				socfpga_agilex5_socdk.dtb \
>   				socfpga_agilex5_socdk_013b.dtb \
>   				socfpga_agilex5_socdk_nand.dtb \
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
> new file mode 100644
> index 000000000000..4e55513d93c4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025, Altera Corporation
> + */
> +
> +/dts-v1/;
> +#include "socfpga_agilex5.dtsi"
> +
> +/ {
> +	compatible = "intel,socfpga-agilex3", "intel,socfpga-agilex5";
> +
> +/* Agilex3 has only 2 CPUs */
> +&{/cpus} {
> +	/delete-node/ cpu@2;
> +	/delete-node/ cpu@3;
> 
There's no need for another dtsi if you're referencing the Agilex5 dtsi.

> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
> new file mode 100644
> index 000000000000..76efaac82e27
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025, Altera Corporation
> + */
> +#include "socfpga_agilex3.dtsi"

Include socfpga_agilex5.dtsi here.

> +
> +/ {
> +	model = "SoCFPGA Agilex3 SoCDK";
> +	compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex3",
> +		     "intel,socfpga-agilex5";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet2 = &gmac2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};

Just add this here:

+       cpus {
+               /delete-node/ cpu@2;
+               /delete-node/ cpu@3;
+       };

> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led0 {
> +			label = "hps_led0";
> +			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led1 {
> +			label = "hps_led1";
> +			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +};
> +
> +&gmac2 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&emac2_phy0>;
> +	max-frame-size = <9000>;
> +
> +	mdio0 {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		emac2_phy0: ethernet-phy@0 {
> +			reg = <0>;
> +			rxc-skew-ps = <0>;
> +			rxdv-skew-ps = <0>;
> +			rxd0-skew-ps = <0>;
> +			rxd1-skew-ps = <0>;
> +			rxd2-skew-ps = <0>;
> +			rxd3-skew-ps = <0>;
> +			txc-skew-ps = <0>;
> +			txen-skew-ps = <60>;
> +			txd0-skew-ps = <60>;
> +			txd1-skew-ps = <60>;
> +			txd2-skew-ps = <60>;
> +			txd3-skew-ps = <60>;
> +		};
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	status = "okay";
> +};
> +
> +&osc1 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "jedec,spi-nor";

You need a specific type of the qpsi memory here.

> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		m25p,fast-read;
> +		cdns,read-delay = <2>;
> +		cdns,tshsl-ns = <50>;
> +		cdns,tsd2d-ns = <50>;
> +		cdns,tchsh-ns = <4>;
> +		cdns,tslch-ns = <4>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			qspi_boot: partition@0 {
> +				label = "u-boot";
> +				reg = <0x0 0x00600000>;
> +			};
> +
> +			root: partition@4200000 {
> +				label = "root";
> +				reg = <0x00600000 0x03a00000>;
> +			};
> +		};
> +	};
> +};
> +
> +&smmu {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};

No USB?

