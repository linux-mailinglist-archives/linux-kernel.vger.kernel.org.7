Return-Path: <linux-kernel+bounces-803220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C3B45C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F260B7A607F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C994230D1E;
	Fri,  5 Sep 2025 15:14:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B131B82F;
	Fri,  5 Sep 2025 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085297; cv=none; b=aZ2LyPvVvWjiTIArhdXcw4XTdMvyzi/AUf9h/0zGP/1qoxky491amqbP96/gVMWY7EbM0K/Kmg1ACslg9rxyc/yrHaIPiCzzKO7uNSULWudC3j7YcOQwRM1UmrRUqMXyAbhlyuHvboXfPscGi4fUssAE4AFEmNEeyAHE1zLaTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085297; c=relaxed/simple;
	bh=yvl98XdvVXAPMoXoBQoYovxNuw2Ef7feGrImIzv1zmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lc8BYOz/RsHv/4oEiQ9G8V6weDvk1+KVTSziHMt2oQb1iAofcfbsPmPhH2ImGXV0oZAri+1KP4yzZF6JnpSMb/FaU3JlVEVQ8RZkBr488npTCbd3aMOzW+nlqtFbv68YSeeGLjB8shbgLRSbGZ+twQVxZudHVqI0lh13HWLLMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F004A152B;
	Fri,  5 Sep 2025 08:14:46 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E9C3F6A8;
	Fri,  5 Sep 2025 08:14:53 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:14:51 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: allwinner: a523: Add NPU device node
Message-ID: <20250905161451.0d9615f6@donnerap>
In-Reply-To: <20250830170901.1996227-9-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
	<20250830170901.1996227-9-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 01:09:01 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Allwinner T527 SoC has an NPU built in. Based on identifiers found
> in the BSP, it is a Vivante IP block. After enabling it, the etnaviv
> driver reports it as a GC9000 revision 9003.
> 
> The standard bindings are used as everything matches directly. There is
> no option for DVFS at the moment. That might require some more work,
> perhaps on the efuse side to map speed bins.
> 
> It is unclear whether the NPU block is fused out at the hardware level
> or the BSP limits use of the NPU through software, as the author only
> has boards with the T527.

I happen to only have boards without the NPU, one A523, two A527s, one
T527, but the SKU without the NPU, and a H728.
So I can confirm that the clock gates and resets exist, but the whole NPU
MMIO frame behaves as read-as-zero/write ignore. At least it doesn't
crash, and the Linux driver just skips this NPU as it cannot identify it
(with all the ID registers being 0).

So I think it's fine to have this node in all the DTBs. We *could* have
something in U-Boot that probes for this RAZ/WI behaviour and slaps a
status = "disabled"; on it. In which case it might be beneficial to have a
status node in already. But I'd rather avoid the churn and reliance on
firmware, instead try to auto detect as much as possible.

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Matches the binding and the manual:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index b6e82d53af54..1ab5b87ec78e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -850,6 +850,18 @@ mcu_ccu: clock-controller@7102000 {
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> +
> +		npu: npu@7122000 {
> +			compatible = "vivante,gc";
> +			reg = <0x07122000 0x1000>;
> +			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&mcu_ccu CLK_BUS_MCU_NPU_ACLK>,
> +				 <&ccu CLK_NPU>,
> +				 <&mcu_ccu CLK_BUS_MCU_NPU_HCLK>;
> +			clock-names = "bus", "core", "reg";
> +			resets = <&mcu_ccu RST_BUS_MCU_NPU>;
> +			power-domains = <&ppu PD_NPU>;
> +		};
>  	};
>  
>  	thermal-zones {


