Return-Path: <linux-kernel+bounces-894796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC3C4C1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5671B4F4791
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4755332EAC;
	Tue, 11 Nov 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TG9lRsm8"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418D1DFE12;
	Tue, 11 Nov 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845729; cv=none; b=aUNzde9defnd59Yf5v4fETIEzauqtuKvAaCRhsDR1U6ts0X99J+PFOvurLKMJAYSNvZYiIF3eG6oE/np31hv6bKW3mLFRk0Nsp2vhqkcIAqLEi8wk/h2wsWxoy43bQ/1wXwChVSHzgupL8bd3BdxnUqx9VHwNnyv61kt/BzNB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845729; c=relaxed/simple;
	bh=XghJ1V4sTqmYevrjDI2OVSAWGMd6oZg2CyQdXuighvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sax6PbWLF4KAhYbEnzNACFMaFTfTACvDnqPR+Geyg86wOZlKZwnBqk2/rv9U7J0tvrG0APT4dzlMvKzvtX4RNxNgWyObJan8CFT68dyap5Ap7Tu0mgF1j8cEcbUQ+51IoMkTog+pdpGvzcRI/TljabEA0EAZI5BeqF8xi8kk5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TG9lRsm8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id D4EB91F8F8;
	Tue, 11 Nov 2025 08:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762845722;
	bh=1wobJU44FbdXVx/EG8UhsBKErOOVsOY4d7OoppyD2Ck=; h=From:To:Subject;
	b=TG9lRsm8pjrZqpoqUUVuiGyTRhqidSf//xB2/+myPNdtsedGGCFUQnOf6MkUJ5Ld1
	 QoV+sZT//uxynxEgVpBQcRqc7HTwR06BZ+uXuUtfiBgbjn+h7/EPIQ7GCujyKqv0S8
	 7RL8r3FPG9y1xllJre/Z010UGeKL4fzptRm8avlFDsGx7wVbkif4TP5EJhlMpTZ5Co
	 5It5ydVvmtjpjALWUgE2RZ2+gIrcZ/UfOXz3lMn3fYaStjk4ms8s6QIPLMZDGjS488
	 mIK7DCq+Bmqs0J7321dm8/a72EjkrUv04gXMmqjmrBOXl7WolvYJhmXCI6c6zDLSxI
	 AcNqW3bW8QREg==
Date: Tue, 11 Nov 2025 08:21:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: imx: move nand related property under
 nand@0
Message-ID: <20251111072158.GA8423@francesco-nb>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
 <20251104-gpmi_dts-v1-3-886865393d0f@nxp.com>
 <20251105115538.GA17091@francesco-nb>
 <aQttQb5GesjUtBw6@lizhi-Precision-Tower-5810>
 <20251107155201.GA119737@francesco-nb>
 <aRIPAagk2tzqnoSB@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIPAagk2tzqnoSB@lizhi-Precision-Tower-5810>

On Mon, Nov 10, 2025 at 11:12:49AM -0500, Frank Li wrote:
> On Fri, Nov 07, 2025 at 04:52:01PM +0100, Francesco Dolcini wrote:
> > Hello Frank,
> >
> > On Wed, Nov 05, 2025 at 10:29:05AM -0500, Frank Li wrote:
> > > On Wed, Nov 05, 2025 at 12:55:38PM +0100, Francesco Dolcini wrote:
> > > > On Tue, Nov 04, 2025 at 05:27:14PM -0500, Frank Li wrote:
> > > > > Add child node nand@0 and move NAND related property under it to align
> > > > > modern nand-controller.yaml.
> > > > >
> > > > > Fix below CHECK_DTBS warnings:
> > > > >   arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): Unevaluated properties are not allowed ('nand-ecc-mode', 'nand-ecc-step-size', 'nand-ecc-strength', 'nand-on-flash-bbt' were unexpected)
> > > > >         from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
> > > > >
> > > > > Since 2019 year, commit
> > > > > (212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
> > > > > NAND related property is preferred located under nand@<n> even though only
> > > > > one NAND chip supported.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi           |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi              |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi      |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi           |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                 |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi               |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi  |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi               |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi            | 12 ++++++++----
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi   | 12 ++++++++----
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi      |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts          |  6 +++++-
> > > > >  arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi               |  8 ++++++--
> > > > >  15 files changed, 82 insertions(+), 22 deletions(-)
> > > > >
> > > >
> > > > Was any of these changes tested? Is the driver able to cope with the
> > > > binding change?
> > >
> > > I have not board to do direct test. This format is used at imx8 platform,
> > > which use the same gpmi driver.
> > >
> > > This properties are parsed at mtd common part
> > > drivers/mtd/nand/raw/nand_base.c
> > >
> > > If you have one of above board to test it, it will be appericated.
> >
> > I did a minimal boot test, on colibri-imx6ull, and the board was booting
> > fine, with Linux 6.18.0-rc4 and this patch applied.
> >
> > I am wondering if there is any impact with the bootloader, this DT is
> > used as it is also in U-Boot, and there the NAND driver is for sure
> > different. Any comment on this? I was not able to test this combination.
> 
> Uboot should have theirself tree, which copy dts and not direct use it.
> I worry uboot parser kernel's dtb to do some hot fix for specific boards.
> But most likely not related these proptetry, maybe just add partitions.

U-Boot just sync the device tree from Linux, copying those, for some
boards (depending on the usage of the so called OF_UPSTREAM).

You cannot think at this change affecting only Linux.

Francesco


