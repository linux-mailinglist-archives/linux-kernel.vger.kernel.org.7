Return-Path: <linux-kernel+bounces-683431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28341AD6D66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A952F3A49B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C76239E6D;
	Thu, 12 Jun 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQYFqmGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3A1F92E;
	Thu, 12 Jun 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723486; cv=none; b=ZXDRr0pAGSQLQY7lX8xe7ybQxl5IBJjucpICYIbszZ7nIu0xXUTdH7lneY/gEcjrnLUDRcmT5lYgNjxmIvXoP4XifdgzT3QONqEk7LRf5DFlMwBgy5nf9rh1jJxFuYwlZHSFl/3ZO3Ksk7BpUxVFUPsUHDHxpq1HeTWnOus7O8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723486; c=relaxed/simple;
	bh=haHjCLuyFcjjryC0APdEnmv4gb5nv2DCaiXwfEunHJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cIS0KC7YG8pbpO7Z/pK5Km2HXKo4kjuSOqZAYhIx4Rz5nszt1/1GrmtWGtbyHgfqs3lqPd5yiQTSdcsqGnn+2TFSfqULgZAy1oXRhaCm/awWwHOWn/qxDefbbJ3B2DEns4dVhnZuaiKdOOBYD8q3r2+ZLeAtrIuexcClvnz8zx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQYFqmGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B242C4CEED;
	Thu, 12 Jun 2025 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749723485;
	bh=haHjCLuyFcjjryC0APdEnmv4gb5nv2DCaiXwfEunHJM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dQYFqmGYD9dnEMLAaX7tWl8uJkb68MH4h4zEji8ux2NVi9l54qh4m/jwWVlvrh42N
	 Z0hrv/Pjkmc462Dn8jaSdyvjs0ya6fhOO2DIgU7kc15G7zvA5lNzEwP9tdnlKhDEx7
	 gy8fnMRvJOnWAHqgvOe6/9tImJ/TrlyT9Jw8Gsesp3YRyic7RCyqfFys4N5WxHtZdE
	 E/QwbElGUCd9Z3ff4kvXszezEmgX2tn52SPjBhHiPRq7sCEbsn/xEjTWFvpFli4K3j
	 hAuTNHUltzD9fd8DM5VAhmx9UJSs88tSp0nyKCB40cpP+Jy/1DzXFm5RvNFezFingB
	 XmOTOgl8MHq9A==
Message-ID: <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
Date: Thu, 12 Jun 2025 12:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
 nfraprado@collabora.com, Taniya Das <quic_tdas@quicinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Eric Biggers <ebiggers@google.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 Mo Elbadry <elbadrym@google.com>, Rom Lemarchand <romlem@google.com>,
 William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
 wthai@nvidia.com, leohu@nvidia.com, dkodihalli@nvidia.com,
 spuranik@nvidia.com
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 12:09, Ryan Chen wrote:
> This add the initial device tree support for the ASPEED AST2700 SoC.
> 
> - Add top-level compatible string "aspeed,ast2700" and set up
> address-cells/size-cells for 64-bit address space.
> - Describe a quad-core ARM Cortex-A35 CPU cluster with L2 cache,
> including cache properties and PSCI enable-method.
> - Add PMU and ARMv8 timer nodes with correct PPI interrupt wiring.
> - Model the dual-SoC architecture with two simple-bus nodes:
> soc0 (@0x10000000) and soc1 (@0x14000000).
> - Add syscon nodes for both SoCs (syscon0, syscon1) with clock/reset
> cell definitions and address mapping.
> - Add GICv3 interrupt controller node under soc0, with full register
> mapping and interrupt properties.
> - Hierarchical interrupt controller structure:
>   - intc0 under soc0, with child intc0_11 node.
>   - intc1 under soc1, with child intc1_0~intc1_5 nodes.
> - Add serial4 node under soc0, others serial node under soc1.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 380 ++++++++++++++++++++++
>  1 file changed, 380 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> 
> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> new file mode 100644
> index 000000000000..d197187bcf9f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +#include <dt-bindings/reset/aspeed,ast2700-scu.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			reg = <0x0 0x1>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			reg = <0x0 0x2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			reg = <0x0 0x3>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a35-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,cpu-registers-not-fw-configured;
> +		always-on;
> +	};
> +
> +	soc0: soc@10000000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x10000000 0x10000000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		syscon0: syscon@12c02000 {
> +			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
> +			reg = <0x0 0x12c02000 0x1000>;
> +			ranges = <0x0 0x0 0 0x12c02000 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		gic: interrupt-controller@12200000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0 0x12200000 0x10000>, /* GICD */
> +			      <0 0x12280000 0x80000>, /* GICR */
> +			      <0 0x40440000 0x1000>;  /* GICC */
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			interrupt-parent = <&gic>;
> +		};
> +
> +		serial4: serial@12c1a000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x12c1a000 0x1000>;
> +			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	soc1: soc@14000000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x14000000 0x10000000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		syscon1: syscon@14c02000 {
> +			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
> +			reg = <0x0 0x14c02000 0x1000>;
> +			ranges = <0x0 0x0 0x0 0x14c02000 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		serial12: serial@14c33b00 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x14c33b00 0x100>;
> +			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
> +			interrupts-extended =
> +				<&intc1_4 18 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&soc0 {

This is the base DTSI, there is no existing node to override. Just
define complete SoC node in one place like every other vendor.


> +	intc0: interrupt-controller@12100000 {
> +		compatible = "simple-mfd";

NAK, never tested.

Not allowed, see bindings. And test it next time.


Best regards,
Krzysztof

