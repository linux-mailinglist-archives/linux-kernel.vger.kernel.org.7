Return-Path: <linux-kernel+bounces-886414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCF0C35876
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81FDF4F7041
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F43126AC;
	Wed,  5 Nov 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="E7zAGcEW"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679F23504B;
	Wed,  5 Nov 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343626; cv=none; b=SmOXdN0QIgXoZFBwJJUUbzWWD/PwbGSaoL/by9O1FT3uYs/TLEMfNOibiBFMwHmvF+KfIwiPssLZ5BCa8b1BMTRDfHZ9xHgpj7JOoC5Hcca2lyMdxPrnzZPub2VoUNPnwT11MwMHY6q2JDIxN85vWaY58tJuQPOlQqs0MW1Cu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343626; c=relaxed/simple;
	bh=qQgL/ThO0VmZIZOSjPL+UEkcrCyIYN7AESC1qhFf5Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYb+8pWaZq9LRf1ElJUz5itpXannUMAnpFHlw92RawXIuk7g/GbU5uAPYL0CAgsk/eJIDsqQkWxEwsQffCkC7x78jY5CFDx1GYNJ7yXL0eNHXOWlGn4Z7zec3ZcWFxf//xTAqw/FcoStjtsQjHtn47clvgnjxxZM4gU2Q7+5MlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=E7zAGcEW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8ACB81F842;
	Wed,  5 Nov 2025 12:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762343620;
	bh=vnqvGc+4oxvsAo4vpsfB5qJ9LgPGlvqTeEXhNVA3Qic=; h=From:To:Subject;
	b=E7zAGcEWWCWYZk10rtdcs0QgeKlZ2aO22Kii8vds9mlhOFV0kKDM/NCGRDplPWG/p
	 Kfylurev+v1DjGgkKD7OvHMnIaZgsTE3IoBBjXfEOwHmhAxDWikX2T861e3O73Hlyy
	 4jxs4+ZhdFZjUEhYpTzVIHZKHBN+pBugSksiVxxWhVp3Pe2uXCu8/UmfrdikRrbAYL
	 Ajn0vNcipQyRmrM2xCMP/6R8PZWrU8+pOGpaD9570/y6KN/XHiJeMDkEaGAhl9zeqG
	 nCjQJF+PEjFWlcQ/ci5jmRhlDEQZ2AmcV0iZVt016d9cZov1vBcfkhG/wAX+1x0SJk
	 PvR//ri0412PA==
Date: Wed, 5 Nov 2025 12:53:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add Aquila AM69 Support
Message-ID: <20251105115335.GA14157@francesco-nb>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
 <20251104145240.61219-2-francesco@dolcini.it>
 <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>

Hello Andrew,
thanks for the review

On Tue, Nov 04, 2025 at 11:41:54AM -0600, Andrew Davis wrote:
> On 11/4/25 8:52 AM, Francesco Dolcini wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > Add support for the Toradex Aquila AM69 and its Development Carrier
> > Board.
> > 
> > The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
> > family and is designed for high-end embedded computing, featuring up to
> > 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (3x
> > Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
> > interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, and
> > a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
> > Temperature Sensor, and optional TPM 2.0 module.
> > 
> > Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> > Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >   arch/arm64/boot/dts/ti/Makefile               |    1 +
> >   arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts |  576 ++++++
> >   arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi    | 1840 +++++++++++++++++
> >   3 files changed, 2417 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> >   create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> > index 361248dcfff4..6ce652fe98fa 100644
> > --- a/arch/arm64/boot/dts/ti/Makefile
> > +++ b/arch/arm64/boot/dts/ti/Makefile
> > @@ -153,6 +153,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
> >   dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
> >   # Boards with J784s4 SoC
> > +dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev.dtb
> >   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> >   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-pcie0-ep.dtbo
> >   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> > diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> > new file mode 100644
> > index 000000000000..c7ce804eac70
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> > @@ -0,0 +1,576 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (C) 2025 Toradex
> > + *
> > + * https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> > + * https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include "k3-am69-aquila.dtsi"
> > +
> 
> [...]
> 
> > +/* Aquila SPI_2 */
> > +&main_spi0 {
> > +	status = "okay";
> > +};
> > +
> > +/* Aquila SPI_1 */
> > +&main_spi2 {
> > +	status = "okay";
> 
> Why enable this with nothing connected to it?

It's a development carrier board, the SPI pins go to a pins header,
accessible to the user, where anything can be hooked up for
prototyping/testing.

One use case would be to just bind this in userspace to spidev for some
prototyping/testing. 


> [...]
> 
> > +/* Aquila SPI_1 */
> > +&main_spi2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_main_spi2>, <&pinctrl_main_spi2_cs0>;
> > +	status = "disabled";
> 
> This is already disabled by default in the SoC dtsi file.

Yes, known. Is this an issue? 

This node must be disabled, no matter what is present in any included
dtsi file, it's a deliberate decision.

This dtsi file describes a SoM, the used pins/functions are defined on
the pinout, but this node cannot be enabled unless the SoM is mated with
a carrier board that is exposing it.

Francesco


