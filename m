Return-Path: <linux-kernel+bounces-772042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64060B28E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51586587943
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFEB2E266D;
	Sat, 16 Aug 2025 13:34:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACB026281;
	Sat, 16 Aug 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351250; cv=none; b=ZxYd0IxZDD04l4yNwAW/EreuYo8FIuBc27PskK7baE2ethkXnWLsEDQRwjS6phkJ6dRr5e1Bsf5LJVHGqOXcQI2+NSZkVMUJWFDUiedAAI/G475EdksjjsE8cuTMnlmwlkFsFTCen0u/+izVVqbzzUaJWM0Truwjwbs+CT3zeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351250; c=relaxed/simple;
	bh=sQQoLhpMijiAs0tCXeUL1nZEAmraz+fwhbqr5RfrM9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=darLSJSOU24t8fUV4kBG3mUHLlN0i2zOVU+LrXIU2aGoEbGtrdAiQCPmn19dOWtCirlYZjN3UY8kBKAhPvWExLEQHM59r1rCjHqIF9bVnypWlgAgYS4qHitGrRBR4QguwIJMuwfohCsarXc+h/e2dfgmXhMiwSOc/9TO76RbXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940551691;
	Sat, 16 Aug 2025 06:33:59 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 874CD3F5A1;
	Sat, 16 Aug 2025 06:34:05 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:31:17 +0100
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
Subject: Re: [PATCH 3/7] phy: sun4i-usb: a523: add support for the USB2 PHY
Message-ID: <20250816143117.4b86ecc6@minigeek.lan>
In-Reply-To: <20250816084700.569524-4-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
	<20250816084700.569524-4-iuncuim@gmail.com>
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

On Sat, 16 Aug 2025 16:46:56 +0800
iuncuim <iuncuim@gmail.com> wrote:

Hi Mikhail,

many thanks for posting these patches, that's a nice surprise to see
this moving forward!

I think there are some issues with this series, but we can surely iron
those out.

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Previously, USB PHY was compatible with D1 and did not require
> separatedata options. But now we need to add a third PHY, which makes it
> incompatible. The third PHY is used together with USB3/PCIe combophy with
> DWC3 controller.

It is really used together? I think on IRC we lately established that
the USB2.0 and USB3.0 parts are somewhat independent, and I think the
Radxa board wires PHY1 to the D-/D+ pins of the USB3.0 socket, instead
of PHY2.

Regardless: this change would be a compatibility break: When a new
kernel with this change sees an old DT, it would bail out, because it
doesn't find the resources for the third PHY in the DT.

What I'd suggest instead is to drop the hardcoded assumption about the
number of PHYs, and instead just enumerate all "pmu<x>" cells in
reg-names. That would work with both old and new DTs, and then we can
also keep the fallback compatible name in the DT, to allow new DTs on
older kernels (for instance a U-Boot provided DT on a stable kernel).

As an added benefit, it would make future enablement easier, as we are
more likely to find a matching compatible string, even when the number
of PHYs differ.

Cheers,
Andre

> In the BSP code, the third PHY requires a separate glue
> driver, but it seems that it is not needed.





> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 8873aed3a..bb79339f2 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -1025,6 +1025,15 @@ static const struct sun4i_usb_phy_cfg sun50i_h616_cfg = {
>  	.siddq_in_base = true,
>  };
>  
> +static const struct sun4i_usb_phy_cfg sun55i_a523_cfg = {
> +	.num_phys = 3,
> +	.phyctl_offset = REG_PHYCTL_A33,
> +	.dedicated_clocks = true,
> +	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
> +	.phy0_dual_route = true,
> +	.siddq_in_base = true,
> +};
> +
>  static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
>  	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
> @@ -1041,6 +1050,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	  .data = &sun50i_a64_cfg},
>  	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
>  	{ .compatible = "allwinner,sun50i-h616-usb-phy", .data = &sun50i_h616_cfg },
> +	{ .compatible = "allwinner,sun55i-a523-usb-phy", .data = &sun55i_a523_cfg },
>  	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",
>  	  .data = &suniv_f1c100s_cfg },
>  	{ },


