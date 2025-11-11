Return-Path: <linux-kernel+bounces-895956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C481FC4F5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E29718823BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554B3A5E69;
	Tue, 11 Nov 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aI8bGIWA"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA6377EB2;
	Tue, 11 Nov 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884079; cv=none; b=gsVmyyVossGoGd9yerfYdk2tqJyyVKHp54c1nXfPN6ekL7XV7WgOheq3KnaSKgzy1KPiK7NkTewg8OnjzULrd8xTLamyemsiPsEfvGJp1VXpPpEF79oU9qtpRVxYHTWo6tp9jTRSD1EvxxAvScf8Ca0K4bQtfQF6oAOykFfxfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884079; c=relaxed/simple;
	bh=V1ag2OD93r959ox7dcTyir2tmmX5qPQGA8yHiqRXedI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfE0wWw6yC5rQD3uYRjzMYI0TYgPL2B/7BEcfld2RaSqh7bwi8ZlcskeJmCa/BBs9qdqMKeaGeRJP05Mf6b6tw5UOeo1BmMOErNWgLWvsAVjUtdpgJYNPwxXSa30VRain+qxmKrtEqTEA93/5jw4QEAj+sM4zTkipKFyp0IUDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aI8bGIWA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EAB1B1FBD9;
	Tue, 11 Nov 2025 19:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762884076;
	bh=GeOtfZ/2jEXI4JZJbkmlwASajVLEWsFaSswuR8dEivA=;
	h=Received:From:To:Subject;
	b=aI8bGIWAI2vpUM0Q1gPxC2D2j9khL0+ZtZzVyH/TwXYIPPPmZbyTTLZfONdwF9m16
	 k12Sml81K6lHHHhQTB0FRpKbInzV7b56G/tXHR6RXMoq8/b0bp6bi0T4aR+jSoMq5/
	 zf2WPxwIJCmqbSD8cIg9hUcldH0gZTEX0KGb+Z8zUfuweGEZuoq/UyDtaH1bEUolv9
	 qzgS7Kgla9vdvLDhzbhwFsyZW7TUxq09EpZ5iHFDf4FaNxV5DV/R6RBz+yzNr7BM8Q
	 dbndxxKuojLcQ0kkU2Udhl3n4cnXZ4ZttnHDho3njVX/eahgVLYioaId67rQgsEfMx
	 s816fstyTSeww==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 92C177F982; Tue, 11 Nov 2025 19:01:15 +0100 (CET)
Date: Tue, 11 Nov 2025 19:01:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <aRN562k3NXCMghEl@gaggiata.pivistrello.it>
References: <20251111151618.70132-1-francesco@dolcini.it>
 <20251111151618.70132-3-francesco@dolcini.it>
 <aRNeMJWsCTRO3j6X@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRNeMJWsCTRO3j6X@lizhi-Precision-Tower-5810>

Hello Frank,

On Tue, Nov 11, 2025 at 11:02:56AM -0500, Frank Li wrote:
> On Tue, Nov 11, 2025 at 04:16:14PM +0100, Francesco Dolcini wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > Add DT support for Toradex SMARC iMX95 SoM and Development carrier
> > board.
> >
> > The module consists of an NXP i.MX95 family SoC, up to 16GB of LPDDR5
> > RAM and up to 128GB of storage, a USB 3.0 Host Hub and 2.0 OTG, two
> > Gigabit Ethernet PHYs, a 10 Gigabit Ethernet interface, an I2C EEPROM
> > and Temperature Sensor, an RX8130 RTC, a Quad/Dual lane CSI interface,
> > and some optional addons: TPM 2.0, DSI, LVDS, DisplayPort (through a
> > DSI-DP bridge), and Wi-Fi/BT module.
> >
> > Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
> > Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Co-developed-by: Vitor Soares <vitor.soares@toradex.com>
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2:
> >  - move enable-active-high after gpio
> >  - add newline between properties and child node in som_dsi2dp_bridge
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |    1 +
> >  .../dts/freescale/imx95-toradex-smarc-dev.dts |  277 ++++
> >  .../dts/freescale/imx95-toradex-smarc.dtsi    | 1155 +++++++++++++++++
> >  3 files changed, 1433 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 75676b908299..28f8eaf18471 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -390,6 +390,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx943-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596sa-mb-smarc-2.dtb
> >
> ...
> > +
> > +/* SMARC PCIE_A / M2 Key B */
> > +&pcie0 {
> > +	status = "okay";
> 
> Nit: if there are next version, please consider add supports-clkreq.

What do you expect exactly?
Maybe what you are looking for is in imx95-toradex-smarc.dtsi?

Francesco

