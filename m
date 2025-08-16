Return-Path: <linux-kernel+bounces-772050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC8B28E42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FE0AC4B71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A62E7F3A;
	Sat, 16 Aug 2025 13:52:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A72E5D2A;
	Sat, 16 Aug 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352349; cv=none; b=bD8JlLmtYZZhVHVu9x1N3wBOWkZb649R2XsH6BVm9IfdDVVLtmYYxOXvdgkjMlCExwzN4DYR60a0q5MHfahBWRWGwNar3C2XfMqoU2zOtCFr2voIPDFa0zhR9Yy2YIvlqwKMHpLWC0hs0pHvhxyFTWJtyE6WDzxjCd5C5bSCWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352349; c=relaxed/simple;
	bh=oZ5Cc4xVoSeWb9U0ObX76KpGY9hzQGHcznmOMyGx1+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT2tisJHmhT6vVbDY6lFc09C+8NgSrPd7SGN6IgRGb91DFfPYEpdQ7OA/IT7D9sW7Ov5g01qcXjyk9EFBrVfDpq/wtqlbuRtxbzHvD8XlHy2LWJERFpf/ItIL0JvZq7mf/IK35BwBN0CeoM5/nThoYTuL2EaAhOH8eL6Ll5u2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D964F1691;
	Sat, 16 Aug 2025 06:52:18 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CF773F738;
	Sat, 16 Aug 2025 06:52:24 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:49:36 +0100
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
Subject: Re: [PATCH 5/7] arm64: dts: allwinner: a523: add USB3.0 phy node
Message-ID: <20250816144936.3f2738cc@minigeek.lan>
In-Reply-To: <20250816084700.569524-6-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
	<20250816084700.569524-6-iuncuim@gmail.com>
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

On Sat, 16 Aug 2025 16:46:58 +0800
iuncuim <iuncuim@gmail.com> wrote:

Hi,

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> After adding the phy driver, we can also add phy node. In addition to the
> clk and reset lines, the power domain PD_PCIE is declared in this node
> according to the bsp dtb. So let's mention it. 
> Currently, phy driver does not support role selection and only works in
> USB3.0 mode.

That's the current limitation of the proposed Linux driver, but should
not affect the binding or DT:

> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index e4ed4fa82..233365496 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -606,6 +606,16 @@ mdio0: mdio {
>  			};
>  		};
>  
> +		combophy: phy@4f00000 {
> +			compatible = "allwinner,sun55i-a523-usb3-pcie-phy";
> +			reg = <0x04f00000 0x100000>;
> +			clocks = <&ccu CLK_USB3>;

Will we need more clocks (or resets) when supporting PCIe later? If
yes, we should add them already now, even if they are not used by the
current driver.

> +			resets = <&ccu RST_BUS_PCIE_USB3>;
> +			#phy-cells = <0>;

I think we should use one PHY cell here, to allow users to select the
PHY path they need. A USB3.0-only driver implementation could choose to
ignore it, or require the number to be 0 only, rejecting anything else.
But this way we keep compatibility with newer DTs.

Cheers,
Andre

> +			power-domains = <&pck600 PD_PCIE>;
> +			status = "disabled";
> +		};
> +
>  		ppu: power-controller@7001400 {
>  			compatible = "allwinner,sun55i-a523-ppu";
>  			reg = <0x07001400 0x400>;


