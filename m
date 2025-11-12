Return-Path: <linux-kernel+bounces-896900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6FAC51836
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E49E3ACA07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091EB280025;
	Wed, 12 Nov 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GQr9aP7O"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638862F998D;
	Wed, 12 Nov 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940867; cv=none; b=bGeCZypuQ8Y9N9mbjGYvGi+Nd6ZvHw08fafdNDNpsdjhZIllfX+q0Aj/Gq3RyNbZpeWY5yH2B0reWYiDwpiY16/ss9VBrlUgmimsV7nBP6XWkO5uZ0MGoJpSeVSXwiaGibWFEHAHaF59FK8m6esY4bCXjMxImiiz7Z5a+ix3u90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940867; c=relaxed/simple;
	bh=uQlw9n9vkNkHMlNxgHtHye18JiC1YKtz5ZIUPvK5eWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMhEtj44p0IzmkGnckCMOhT1ugTk+6SCJ3N33S041s0GXq/9LwkQea7PfwkYqAE621/rgjil8f3V1d75GuggMGJcQymCobokuDUKUsvruACw2+edBN3YdAa1EMn1dR1O8ky/P2PSapltKGbuMuPZQs6pZOSEqrJZzYhp4NmDg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GQr9aP7O; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 64C831F928;
	Wed, 12 Nov 2025 10:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762940862;
	bh=3SYq7/Ls6CuDLQxN3kb3YD34nt8HriJZ18tYljiOVG0=; h=From:To:Subject;
	b=GQr9aP7OU/Icb3c2EW7UG5FUGaeEeJDpVyVK/yTK8xPtVNzsm8ZfrO4M1hRFKIzAT
	 hd+6FSD0JKBfSJsSZykP2Q6MTlsGvunfDDio/ZKsoZf5B7cZfGZy3ttOtKxOsboYHM
	 sMqAmEMz2KOzP8/lwP3r3nopCCBi+CqWKj2b54TlFiawFCboQd/AgDWiY6RYRsvx9d
	 ILlNnLI75q2gv8Rbg6IsjYaLftjw+cagpSLmyTJl7mPz1LXinEwTW+8P5DjZf62RFm
	 JNXxLl1xrzRXEF0FMm2hP0yStcly3emOSlHhA95pyjIHBC+U8PJ/5UGW3o6q1MN8sM
	 4qdbEHAQJe4rA==
Date: Wed, 12 Nov 2025 10:47:37 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Vitor Soares <vitor.soares@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add Toradex SMARC iMX95
Message-ID: <20251112094737.GA5126@francesco-nb>
References: <20251111151618.70132-1-francesco@dolcini.it>
 <20251111151618.70132-3-francesco@dolcini.it>
 <aRNeMJWsCTRO3j6X@lizhi-Precision-Tower-5810>
 <aRN562k3NXCMghEl@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRN562k3NXCMghEl@gaggiata.pivistrello.it>

On Tue, Nov 11, 2025 at 07:01:15PM +0100, Francesco Dolcini wrote:
> Hello Frank,
> 
> On Tue, Nov 11, 2025 at 11:02:56AM -0500, Frank Li wrote:
> > On Tue, Nov 11, 2025 at 04:16:14PM +0100, Francesco Dolcini wrote:
> > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > >
> > > Add DT support for Toradex SMARC iMX95 SoM and Development carrier
> > > board.
> > >
> > > The module consists of an NXP i.MX95 family SoC, up to 16GB of LPDDR5
> > > RAM and up to 128GB of storage, a USB 3.0 Host Hub and 2.0 OTG, two
> > > Gigabit Ethernet PHYs, a 10 Gigabit Ethernet interface, an I2C EEPROM
> > > and Temperature Sensor, an RX8130 RTC, a Quad/Dual lane CSI interface,
> > > and some optional addons: TPM 2.0, DSI, LVDS, DisplayPort (through a
> > > DSI-DP bridge), and Wi-Fi/BT module.
> > >
> > > Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
> > > Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
> > > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > > Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > Co-developed-by: Vitor Soares <vitor.soares@toradex.com>
> > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > > v2:
> > >  - move enable-active-high after gpio
> > >  - add newline between properties and child node in som_dsi2dp_bridge
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |    1 +
> > >  .../dts/freescale/imx95-toradex-smarc-dev.dts |  277 ++++
> > >  .../dts/freescale/imx95-toradex-smarc.dtsi    | 1155 +++++++++++++++++
> > >  3 files changed, 1433 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > index 75676b908299..28f8eaf18471 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -390,6 +390,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx943-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
> > > +dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596sa-mb-smarc-2.dtb
> > >
> > ...
> > > +
> > > +/* SMARC PCIE_A / M2 Key B */
> > > +&pcie0 {
> > > +	status = "okay";
> > 
> > Nit: if there are next version, please consider add supports-clkreq.
> 
> What do you expect exactly?
> Maybe what you are looking for is in imx95-toradex-smarc.dtsi?

Found it, you are referring to https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L155

We would not be able to test it, the required changes in the PCIe driver
are not merged yet, so I would prefer to skip it for this series for the
moment.

Francesco


