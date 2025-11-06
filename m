Return-Path: <linux-kernel+bounces-888225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CEC3A3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B8C4FEFBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF6271A9A;
	Thu,  6 Nov 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ZkArOHjM"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AD2475D0;
	Thu,  6 Nov 2025 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424396; cv=none; b=Hw87Ca5tSWwjhwLVJWAdT5zTn4Pi4jA/NdI7QNwlJlwF/FSg6R7taH1A1bj+xUqrK4154JEDE70fta9iubDIZNjUx+P+s26kkQnGU+rdXWXeGBgXy2yK2MDN3H1TGdSUFl97TaRRiGVQ1scWJcFm4kfECzK3Feaeq0JGArycS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424396; c=relaxed/simple;
	bh=4tAO4pY3aEo60ZELiNAwBE8CwxTrtWbwK+RQ0XAHSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1OZkNgwXG6230p4PYOasUYZ4tOrpTpRQ+qL5m9IPKGq+In0xzfJrc9bm0wQqS3ChiII7khzcBTR1ajced1XtjVUQJnCC83EY/ca6oS0FgpNJ4yClwB98AbOzhPoV+tY1Nti3OasI11e/ScHlXq7U8GAHF9cVfFaORvNJAFQ22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ZkArOHjM; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DA6D520617;
	Thu,  6 Nov 2025 11:19:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762424389;
	bh=od7Lqh0ho4ogjz8Pbh+DhQWDrwuddtwph5S6ttSJvJ4=; h=From:To:Subject;
	b=ZkArOHjMhaYcnQJgMbqRGeRC00woC2pZDnIV3vcYm7+tlJN+NWZd4DI/sqSH3yjOa
	 IlkD8B6Vec/SvXyhRl1sDLXyaJ9ZuTEqrssr3I+fFBAFc90sqcMPUZDUY6/PjKpHPA
	 XcpE5/ydDd/5TZSfcR9TS7MgtncIM9OFV/xWW4jZsvpSmdKP9Vqc37rPzTf86tVP93
	 J06ADqq9TCzKT/dlm1amRaAe3cRKUPt+ZzjPHGpADD+IR5YVPOizzUXOqo04pwnxwP
	 jYKdp38WoT+o/iEu8jmNXhBZ6t/Wi0I+UeR+FYrG/7li0FFLlIMJlkXx/jNIjnD81w
	 KfM16Lu2ze3+g==
Date: Thu, 6 Nov 2025 11:19:45 +0100
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
Message-ID: <20251106101932.GA5975@francesco-nb>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
 <20251104145240.61219-2-francesco@dolcini.it>
 <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>
 <20251105115335.GA14157@francesco-nb>
 <7024f4b3-00a0-4618-8bf9-53e305fcc982@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7024f4b3-00a0-4618-8bf9-53e305fcc982@ti.com>

Hello Andrew,

On Wed, Nov 05, 2025 at 02:01:35PM -0600, Andrew Davis wrote:
> On 11/5/25 5:53 AM, Francesco Dolcini wrote:
> > On Tue, Nov 04, 2025 at 11:41:54AM -0600, Andrew Davis wrote:
> > > On 11/4/25 8:52 AM, Francesco Dolcini wrote:
> > > > From: Parth Pancholi <parth.pancholi@toradex.com>
> > > > 
> > > > Add support for the Toradex Aquila AM69 and its Development Carrier
> > > > Board.
> > > > 
> > > > The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
> > > > family and is designed for high-end embedded computing, featuring up to
> > > > 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (3x
> > > > Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
> > > > interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, and
> > > > a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
> > > > Temperature Sensor, and optional TPM 2.0 module.
> > > > 
> > > > Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> > > > Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> > > > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > > > Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > > Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > > Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >    arch/arm64/boot/dts/ti/Makefile               |    1 +
> > > >    arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts |  576 ++++++
> > > >    arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi    | 1840 +++++++++++++++++
> > > >    3 files changed, 2417 insertions(+)
> > > >    create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> > > >    create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> > > > index 361248dcfff4..6ce652fe98fa 100644
> > > > --- a/arch/arm64/boot/dts/ti/Makefile
> > > > +++ b/arch/arm64/boot/dts/ti/Makefile
> > > > @@ -153,6 +153,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
> > > >    dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
> > > >    # Boards with J784s4 SoC
> > > > +dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev.dtb
> > > >    dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> > > >    dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-pcie0-ep.dtbo
> > > >    dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> > > > new file mode 100644
> > > > index 000000000000..c7ce804eac70
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> > > > @@ -0,0 +1,576 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > > > +/*
> > > > + * Copyright (C) 2025 Toradex
> > > > + *
> > > > + * https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> > > > + * https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include <dt-bindings/pwm/pwm.h>
> > > > +#include "k3-am69-aquila.dtsi"
> > > > +
> > > 
> > > [...]
> > > 
> > > > +/* Aquila SPI_2 */
> > > > +&main_spi0 {
> > > > +	status = "okay";
> > > > +};
> > > > +
> > > > +/* Aquila SPI_1 */
> > > > +&main_spi2 {
> > > > +	status = "okay";
> > > 
> > > Why enable this with nothing connected to it?
> > 
> > It's a development carrier board, the SPI pins go to a pins header,
> > accessible to the user, where anything can be hooked up for
> > prototyping/testing.
> > 
> 
> Sure, and when a device is attached to that pin header it will need
> described in DT with a node for that attached device and in that
> node/overlay is where you enable the nodes you make use of.
> 
> > One use case would be to just bind this in userspace to spidev for some
> > prototyping/testing.
> > 
> 
> But you are not adding a spidev node here, you are attaching nothing
> but enabling the node anyway.

The idea would be that you can bind the spidev driver from userspace,
without having to change anything in the DT. For this to be possible the
SPI node must be enabled.

My understanding is that this should be possible, and it's the suggested
way to debug/prototype anything with spidev. If my understanding is not
correct, I agree with you and there is no point in enabling this node.


> > > [...]
> > > 
> > > > +/* Aquila SPI_1 */
> > > > +&main_spi2 {
> > > > +	pinctrl-names = "default";
> > > > +	pinctrl-0 = <&pinctrl_main_spi2>, <&pinctrl_main_spi2_cs0>;
> > > > +	status = "disabled";
> > > 
> > > This is already disabled by default in the SoC dtsi file.
> > 
> > Yes, known. Is this an issue?
> > 
> > This node must be disabled, no matter what is present in any included
> > dtsi file, it's a deliberate decision.
> > 
> > This dtsi file describes a SoM, the used pins/functions are defined on
> > the pinout, but this node cannot be enabled unless the SoM is mated with
> > a carrier board that is exposing it.
> 
> Same as my point above, you shouldn't enable nodes that are not used
> or have anything attached. The SoM only has some edge connectors so
> it should not be enabled at the SoM level, that we seem to agree, but
> the carrier board doesn't connect those lines to anything either. They
> just run to a pin header with nothing attached, how is that header
> any different than the pins on the edge of the SoM?

You are commenting something unrelated here, or I am not understanding
you.

You commented that the status = "disabled" is redundant. We both agree
that this node needs to be disabled in the SoM dtsi, and it is already
like that.

I would prefer to keep the redundant "disabled", because I see value on
not having to rely on what is done on any included dtsi, where the
original node is defined. I see this as a common pattern in multiple
dts/dtsi file and is what I would prefer to have (and I do not see any
kind of maintenance  overhead on having it nor this being in conflict
with dts-coding-style.rst).

Vignesh, Nishanth, what is your expectation on this redundant
`status = "disabled"` property?
	
Francesco



> Anyway, the right spot to enable would be when you bind a device to
> the SPI, which it seems you do in overlays[0], so that would be were
> you set status = "okay" and all the pinmux info for that SPI device
> and carrier board combination.
> 
> [0] https://developer.toradex.com/torizon/os-customization/use-cases/device-tree-overlays-on-torizon/#spidev

