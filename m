Return-Path: <linux-kernel+bounces-772045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925CB28E35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9721CC573F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAC2E9740;
	Sat, 16 Aug 2025 13:41:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5B28F935;
	Sat, 16 Aug 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351670; cv=none; b=TOjMDhikmpA9e6OQHC7ExZ6OyaHTPe6CTaUTUOtcG572LH9jKFA35v4o19x/iLQF3p6DGfZXy8hphAsT3SoW7IIMF4gIueUIVzLJCqpVQy+KswdVY84LpXOb2Z+M8mEnCzCUffckT5/gXwEe25HQ0yIJ/F5JJWCH+LISx4qmufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351670; c=relaxed/simple;
	bh=yFJOuOfrq4mcsgQ29r2oL+raFCXvkdkV/rGPNMzmrkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVFfT2DMwpAkp0ilncQhPpnQgzC2PGdsf6L6IwW56Y7EtriCqGstVbPXTyKtA0sg73D25BKaampZCUPRBDeKSNVWLrRaS1kLkwJ7ATX+SZoMvDzfypRNnz9OM6J7Mx2LkAiWVyWF8DTNq939Mm4Cn0e1H4xGn4b4zlycV9yfTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF0CC1691;
	Sat, 16 Aug 2025 06:40:59 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31C473F5A1;
	Sat, 16 Aug 2025 06:41:05 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:38:13 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: iuncuim <iuncuim@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/7] arm64: dts: allwinner: a523: add third usb2 phy
Message-ID: <20250816143813.77551ff2@minigeek.lan>
In-Reply-To: <c7468189-deee-449f-b7d0-fa1830ca88fc@kernel.org>
References: <20250816084700.569524-1-iuncuim@gmail.com>
	<20250816084700.569524-3-iuncuim@gmail.com>
	<c7468189-deee-449f-b7d0-fa1830ca88fc@kernel.org>
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

On Sat, 16 Aug 2025 11:31:12 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 16/08/2025 10:46, iuncuim wrote:
> > From: Mikhail Kalashnikov <iuncuim@gmail.com>
> > 
> > It seems that there are actually three usb2 phys in the processor, which
> > makes it incompatible with D1.
> > The third phy is used together with USB3/PCIe combophy with DWC3
> > controller. In the BSP code, the third PHY requires a separate glue
> > driver, but it seems that it is not needed.
> > According to the BSP code, the third phy does not have a reset line; the
> > only reset is declared in the DWC3 node, but none of this is documented.
> > Since sun4i-usb-phy driver requires a reset, I added RST_BUS_3 here.
> > 
> > Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> > ---
> >  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 21 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > index 6b6f2296b..e4ed4fa82 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > @@ -503,22 +503,27 @@ usb_otg: usb@4100000 {
> >  		};
> >  
> >  		usbphy: phy@4100400 {
> > -			compatible = "allwinner,sun55i-a523-usb-phy",
> > -				     "allwinner,sun20i-d1-usb-phy";
> > +			compatible = "allwinner,sun55i-a523-usb-phy";  
> 
> 
> That's potential break of all users. Also, having third phy (so
> additional piece) is not making things incompatible.

Yes, we would want to keep the fallback, to allow newer DTs working on
older kernel. As the Linux driver is implemented right now, it's not
fully compatible, since it ties the number of PHYs to the compatible
string - but that's a Linux implementation choice, not something really
related to the binding. And as I replied on the driver patch, that
breaks anyway, and I think we can change it there to preserve
compatibility, and make everyone happy: newer DTs on older kernels,
older DTs on newer kernels, and all working within the kernel's
capability.

Oh, and it looks like there are whitespace issues in the patch ...

Cheers,
Andre

