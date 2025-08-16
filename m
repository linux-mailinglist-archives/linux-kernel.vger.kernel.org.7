Return-Path: <linux-kernel+bounces-772064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B53B28E65
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBB7BA3BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F62EB5C7;
	Sat, 16 Aug 2025 14:13:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE812EA17C;
	Sat, 16 Aug 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353593; cv=none; b=jSvY9EiJwtD8YYre/sXiQxY44ZVPIJX+ma1K3jBbgoFU5fkQsSLwop+nUc0he/yFX72bhwVrsyeuAVd3Tbnu474Xd33aoWwTi65UDgysKL2l594ZUFObTQhmymCshRZ0Cq6V+zHU5I2aUwybF63xf1PmptcJU2QqnbSc7uPQ4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353593; c=relaxed/simple;
	bh=MCwup8/VMzm2vt/sg3v0hqhdOZGr4LtLR5MBWmocvfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlkenrVEtZf+ok8GTJ4jrr/rZpRK2trkRnpYwOK3ypBEKHsaVU9UMQVaF1TalI6RU9SeqORtMZ++9NLfGexdTwZUxWEExy82VV6tcf2NP2GMQLkLu2cqxJrn81gc5enk9JraHJ+QLd5GGkB9gCWeBFdLx9UFfD9U0VYlxWfh4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1AA1595;
	Sat, 16 Aug 2025 07:13:02 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4543F738;
	Sat, 16 Aug 2025 07:13:07 -0700 (PDT)
Date: Sat, 16 Aug 2025 15:10:15 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: iuncuim <iuncuim@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/7] arm64: dts: allwinner: a523: add DWC3 USB3.0 node
Message-ID: <20250816151015.621f8da4@minigeek.lan>
In-Reply-To: <20250816084700.569524-7-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
	<20250816084700.569524-7-iuncuim@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 16:46:59 +0800
iuncuim <iuncuim@gmail.com> wrote:

Hi,

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> After adding the phy bindings, we can also add dwc3 node, which uses the
> previously added usbphy2 and part of usb3 from combophy.
> All settings declared in dwc3 node are obtained from the x96qproplus' dtb.
> BSP contains an additional glue driver for dwc3, but it seems that it is
> not needed.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index 233365496..ec170888a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -606,6 +606,27 @@ mdio0: mdio {
>  			};
>  		};
>  
> +		dwc3: usb@4d00000 {
> +			compatible = "snps,dwc3";

Wouldn't we need an A523 specific compatible string first?

> +			reg = <0x04d00000 0x100000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "host";
> +			clocks = <&ccu CLK_MBUS_USB3>, <&ccu CLK_USB3>,
> +				 <&ccu CLK_USB2>, <&ccu CLK_USB3_SUSPEND>;
> +			clock-names = "bus_clk", "ref_clk3", "ref_clk2", "suspend";

How does this work, exactly? I see "bus_clk" (deprecated, should be
"bus_early") and "suspend" in the bindings and the Linux driver, but
where do ref_clk3 and ref_clk2 come from, and more importantly who is
going to use them? IIUC, the binding hints that certain implementations
could need more clocks, but then it's their responsibility to parse and
enable them, in platform specific glue code, I think.



> +			maximum-speed = "super-speed";
> +			phy_type = "utmi";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-u1-entry-quirk;
> +			snps,dis-u2-entry-quirk;
> +			snps,dis_u3_susphy_quirk;
> +			snps,dis_u2_susphy_quirk;
> +			snps,dis_rxdet_inp3_quirk;
> +			phys = <&usbphy 2>, <&combophy>;

Related to my comment on the other DT patch, this should be
"<&combophy 0>" (with "#phy-cells = <1>;" in the PHY node, to be forward
compatible.

Cheers,
Andre


> +			phy-names = "usb2-phy", "usb3-phy";
> +			status = "disabled";
> +		};
> +
>  		combophy: phy@4f00000 {
>  			compatible = "allwinner,sun55i-a523-usb3-pcie-phy";
>  			reg = <0x04f00000 0x100000>;


