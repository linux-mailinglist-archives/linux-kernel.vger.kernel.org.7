Return-Path: <linux-kernel+bounces-830147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E155B98E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1121617F8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707F28640B;
	Wed, 24 Sep 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XaqbDzoo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163023D2A3;
	Wed, 24 Sep 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702886; cv=none; b=eOfJqwqV2SIkisuKxa4Cd8Ez7EJtwvUjqO/lsTKxUsMZ4yEsTnxLf/t4TcURskJtiJ3Xjguy8mrI/FQXfmQtV2JVAKX3pvDGZc49i04iOZw3LjDnTQyuEwqehdM7UbQ+1E/PvsOoFU9bsdUgIvItcFoio4px8sf78gyouVSif6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702886; c=relaxed/simple;
	bh=VdHX48lqCFSosZvX9FtA92m9ELKCKlcdOBW2HmyJPaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eij1ztVfoB8w0EUedf154DYaCp0tCZRS/AA5Y4cPALHcBC125IbR7/ffW3rJcdlyM7r0XiIKmtas/5SxjcrnDOVKqO5o6LtqCusXjy8/f9Q6rhPW6kqar/ZuRGMDKN+9FRb1IygIugtGSwlfP925LilNsNIUiH/uuJJeCVe6wBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XaqbDzoo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758702881;
	bh=VdHX48lqCFSosZvX9FtA92m9ELKCKlcdOBW2HmyJPaM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XaqbDzooaatmy2NMad8g4HR8NWNtVigysbLC4clikTQdowbAu9cRmDqGPupLTTSfi
	 GznKPmokpz9GxBlxhuCJqpvH54YSXTtRflvHWKBj9CAO4PpSHyMGnOYYILmGRk2Ss5
	 FN2Rk6neTZfcu6lRLA2cl7Qr+p7HEjA8N7lZb43epZNKl7/VYjLhD1T1ELbfbrapbo
	 x9hxv/Pwt/xBu7dCBxZf2mXRilnLztWB3D1A1sgJ2D6YZD0J183k1U2kQ7QZXtGY0A
	 mvAO/amAv5R5IacKxafjJSmZj3+IQIvG4zfVfzvg+YeeJokTO6L4091wvneKSziXz+
	 plk67zSybeHJQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6E54A17E0C21;
	Wed, 24 Sep 2025 10:34:41 +0200 (CEST)
Message-ID: <79b738be-d51c-4414-801d-3430c18f0b72@collabora.com>
Date: Wed, 24 Sep 2025 10:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Airoha AN7583 SoC and AN7583
 Evaluation Board
To: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250923185340.21526-1-ansuelsmth@gmail.com>
 <20250923185340.21526-2-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923185340.21526-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 20:53, Christian Marangi ha scritto:
> Introduce Airoha AN7583 SoC initial DTSI and AN7583 Evaluation Board
> DTS and add the required entry in the Makefile.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Fix DTB BOT warning (fix crypto compatible and OPP node name)
> 
>   arch/arm64/boot/dts/airoha/Makefile       |   1 +
>   arch/arm64/boot/dts/airoha/an7583-evb.dts |  22 ++
>   arch/arm64/boot/dts/airoha/an7583.dtsi    | 282 ++++++++++++++++++++++
>   3 files changed, 305 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/airoha/an7583-evb.dts
>   create mode 100644 arch/arm64/boot/dts/airoha/an7583.dtsi
> 
> diff --git a/arch/arm64/boot/dts/airoha/Makefile b/arch/arm64/boot/dts/airoha/Makefile
> index ebea112ce1d7..7a604ae249b5 100644
> --- a/arch/arm64/boot/dts/airoha/Makefile
> +++ b/arch/arm64/boot/dts/airoha/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   dtb-$(CONFIG_ARCH_AIROHA) += en7581-evb.dtb
> +dtb-$(CONFIG_ARCH_AIROHA) += an7583-evb.dtb
> diff --git a/arch/arm64/boot/dts/airoha/an7583-evb.dts b/arch/arm64/boot/dts/airoha/an7583-evb.dts
> new file mode 100644
> index 000000000000..a7f83436825e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/airoha/an7583-evb.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/dts-v1/;
> +
> +#include "an7583.dtsi"
> +
> +/ {
> +	model = "Airoha EN7583 Evaluation Board";

There's a typo - you wrote EN instead of AN.

> +	compatible = "airoha,an7583-evb", "airoha,an7583";
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x2 0x00000000>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/airoha/an7583.dtsi b/arch/arm64/boot/dts/airoha/an7583.dtsi
> new file mode 100644
> index 000000000000..a6a5df60d0e1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/airoha/an7583.dtsi
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			enable-method = "psci";
> +			clocks = <&cpufreq>;
> +			clock-names = "cpu";
> +			power-domains = <&cpufreq>;
> +			power-domain-names = "perf";
> +			next-level-cache = <&l2>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			enable-method = "psci";
> +			clocks = <&cpufreq>;
> +			clock-names = "cpu";
> +			power-domains = <&cpufreq>;
> +			power-domain-names = "perf";
> +			next-level-cache = <&l2>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-level = <2>;
> +			cache-unified;
> +		};
> +	};
> +
> +	cpufreq: cpufreq {
> +		compatible = "airoha,en7581-cpufreq";
> +
> +		operating-points-v2 = <&smcc_opp_table>;
> +
> +		#power-domain-cells = <0>;
> +		#clock-cells = <0>;
> +	};
> +
> +	cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			required-opps = <&smcc_opp0>;
> +		};
> +
> +		opp-550000000 {
> +			opp-hz = /bits/ 64 <550000000>;
> +			required-opps = <&smcc_opp1>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			required-opps = <&smcc_opp2>;
> +		};
> +
> +		opp-650000000 {
> +			opp-hz = /bits/ 64 <650000000>;
> +			required-opps = <&smcc_opp3>;
> +		};
> +
> +		opp-7000000000 {
> +			opp-hz = /bits/ 64 <700000000>;
> +			required-opps = <&smcc_opp4>;
> +		};
> +
> +		opp-7500000000 {
> +			opp-hz = /bits/ 64 <750000000>;
> +			required-opps = <&smcc_opp5>;
> +		};
> +
> +		opp-8000000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			required-opps = <&smcc_opp6>;
> +		};
> +
> +		opp-8500000000 {
> +			opp-hz = /bits/ 64 <850000000>;
> +			required-opps = <&smcc_opp7>;
> +		};
> +
> +		opp-9000000000 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			required-opps = <&smcc_opp8>;
> +		};
> +
> +		opp-9500000000 {
> +			opp-hz = /bits/ 64 <950000000>;
> +			required-opps = <&smcc_opp9>;
> +		};
> +
> +		opp-10000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			required-opps = <&smcc_opp10>;
> +		};
> +
> +		opp-10500000000 {
> +			opp-hz = /bits/ 64 <1050000000>;
> +			required-opps = <&smcc_opp11>;
> +		};
> +
> +		opp-11000000000 {
> +			opp-hz = /bits/ 64 <1100000000>;
> +			required-opps = <&smcc_opp12>;
> +		};
> +
> +		opp-11500000000 {
> +			opp-hz = /bits/ 64 <1150000000>;
> +			required-opps = <&smcc_opp13>;
> +		};
> +
> +		opp-12000000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			required-opps = <&smcc_opp14>;
> +		};
> +	};
> +
> +	smcc_opp_table: opp-table-smcc {
> +		compatible = "operating-points-v2";
> +
> +		smcc_opp0: opp-0 {
> +			opp-level = <0>;
> +		};
> +
> +		smcc_opp1: opp-1 {
> +			opp-level = <1>;
> +		};
> +
> +		smcc_opp2: opp-2 {
> +			opp-level = <2>;
> +		};
> +
> +		smcc_opp3: opp-3 {
> +			opp-level = <3>;
> +		};
> +
> +		smcc_opp4: opp-4 {
> +			opp-level = <4>;
> +		};
> +
> +		smcc_opp5: opp-5 {
> +			opp-level = <5>;
> +		};
> +
> +		smcc_opp6: opp-6 {
> +			opp-level = <6>;
> +		};
> +
> +		smcc_opp7: opp-7 {
> +			opp-level = <7>;
> +		};
> +
> +		smcc_opp8: opp-8 {
> +			opp-level = <8>;
> +		};
> +
> +		smcc_opp9: opp-9 {
> +			opp-level = <9>;
> +		};
> +
> +		smcc_opp10: opp-10 {
> +			opp-level = <10>;
> +		};
> +
> +		smcc_opp11: opp-11 {
> +			opp-level = <11>;
> +		};
> +
> +		smcc_opp12: opp-12 {
> +			opp-level = <12>;
> +		};
> +
> +		smcc_opp13: opp-13 {
> +			opp-level = <13>;
> +		};
> +
> +		smcc_opp14: opp-14 {
> +			opp-level = <14>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	sys_hclk: clk-oscillator-100mhz {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sys_hclk";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@9000000 {
> +			compatible = "arm,gic-v3";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x0 0x09000000 0x0 0x20000>,
> +			      <0x0 0x09080000 0x0 0x80000>,
> +			      <0x0 0x09400000 0x0 0x2000>,
> +			      <0x0 0x09500000 0x0 0x2000>,
> +			      <0x0 0x09600000 0x0 0x20000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +
> +		crypto@1e004000 {
> +			compatible = "airoha,en7581-eip93", "inside-secure,safexcel-eip93ies";

First of all: sorry for not catching this in the first review.

This is wrong - the compatible string must contain the SoC compatible, but this is
AN7583, not EN7581.

Either of

compatible = "airoha,an7583-eip93", "inside-secure,safexcel-eip93ies";

or

compatible = "airoha,an7583-eip93", "airoha,en7581-eip93",
	     "inside-secure,safexcel-eip93ies";

is acceptable. Of course, you have to add that to the bindings.

> +			reg = <0x0 0x1fb70000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		uart1: serial@1fbf0000 {
> +			compatible = "ns16550";
> +			reg = <0x0 0x1fbf0000 0x0 0x30>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <1843200>;
> +		};
> +
> +		watchdog@1fbf0100 {
> +			compatible = "airoha,en7581-wdt";

compatible = "airoha,an7583-wdt", "airoha,en7581-wdt";

(and add to the bindings)

Everything else looks ok.

Cheers,
Angelo



