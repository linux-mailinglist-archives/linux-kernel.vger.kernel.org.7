Return-Path: <linux-kernel+bounces-890691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF5C40AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406093B94B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB232D0FD;
	Fri,  7 Nov 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JprloZHT"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7372F9DAF;
	Fri,  7 Nov 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530737; cv=none; b=P7kiSA0jEJ3nMVhcOCZpWUUE/ttIOtVv1jw6L9uv6tG6LPhJoRV5djRrB8APoHHkzkvE1C4wyE5SzfUhU/7D1bDZtoXgRq9xLUaFPK6qunVK8Ko6bBZTlunivkKCamdc+CbgpztBs0MK4BvU+Q3JFo+JnLAyDL/JUqOtQjXgUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530737; c=relaxed/simple;
	bh=VfqiXVnXHsweixRlwrrt3c7A8wz6SyMBDBW8vTeLdVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li98oWPhLrEHzhQpgkqO1K9dZXZjXpFzhx41nNeA3bLJDWqY90OUd8jAeRA/9vFaTdPJIYIxfbFH3vh/aEECTrSmvFVlFxqTyhzQnN+0i7qRBbXr+VAoWVKenUcMimExrZH4N1BR9fLKoVRZBQEScgySbjE1WiDg8vTY7+jLXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JprloZHT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5A60C1FB9A;
	Fri,  7 Nov 2025 16:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762530725;
	bh=c3Vswpijn/fHcEJQO2VeGXkaT5nX/VaBE7KE0Jscnuo=; h=From:To:Subject;
	b=JprloZHT7cxN62EH9YL28KwyMi9OOie063qzgXzS36wpar25HfqyxOOX+bR3nMlLi
	 g6K7xSOrvpSaxY0kCOl1mkA+3OaI3bBxmF75qVYIKSbRMKXPZTLXHk5SnfNEgnMMhm
	 oMKpvibF5zXZqXEaRZwsyRxtveBhFHMJ1ZeRQGCNHoNm6QnRczJd1QB67uWhavVr4x
	 jr3kRrML1EuSIJ3NE1PCs6cvxQU5+W97VcivX17XzEqfsEuejwlQy3h1T16mo1Or/s
	 RK5lOTyQ4eg6lxWqljiMOSwSRD9WFy8HV0151pUYcp5gMfhLIf3fOsVi6/ScDUXKng
	 lvvLxEB8VOjUw==
Date: Fri, 7 Nov 2025 16:52:01 +0100
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
Message-ID: <20251107155201.GA119737@francesco-nb>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
 <20251104-gpmi_dts-v1-3-886865393d0f@nxp.com>
 <20251105115538.GA17091@francesco-nb>
 <aQttQb5GesjUtBw6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQttQb5GesjUtBw6@lizhi-Precision-Tower-5810>

Hello Frank,

On Wed, Nov 05, 2025 at 10:29:05AM -0500, Frank Li wrote:
> On Wed, Nov 05, 2025 at 12:55:38PM +0100, Francesco Dolcini wrote:
> > On Tue, Nov 04, 2025 at 05:27:14PM -0500, Frank Li wrote:
> > > Add child node nand@0 and move NAND related property under it to align
> > > modern nand-controller.yaml.
> > >
> > > Fix below CHECK_DTBS warnings:
> > >   arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): Unevaluated properties are not allowed ('nand-ecc-mode', 'nand-ecc-step-size', 'nand-ecc-strength', 'nand-on-flash-bbt' were unexpected)
> > >         from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
> > >
> > > Since 2019 year, commit
> > > (212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
> > > NAND related property is preferred located under nand@<n> even though only
> > > one NAND chip supported.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi           |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi              |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi      |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi           |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                 |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi               |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi  |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi               |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi            | 12 ++++++++----
> > >  arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi   | 12 ++++++++----
> > >  arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi      |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts          |  6 +++++-
> > >  arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi               |  8 ++++++--
> > >  15 files changed, 82 insertions(+), 22 deletions(-)
> > >
> >
> > Was any of these changes tested? Is the driver able to cope with the
> > binding change?
> 
> I have not board to do direct test. This format is used at imx8 platform,
> which use the same gpmi driver.
> 
> This properties are parsed at mtd common part
> drivers/mtd/nand/raw/nand_base.c
> 
> If you have one of above board to test it, it will be appericated.

I did a minimal boot test, on colibri-imx6ull, and the board was booting
fine, with Linux 6.18.0-rc4 and this patch applied.

I am wondering if there is any impact with the bootloader, this DT is
used as it is also in U-Boot, and there the NAND driver is for sure
different. Any comment on this? I was not able to test this combination.

Francesco



