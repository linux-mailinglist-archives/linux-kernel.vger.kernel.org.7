Return-Path: <linux-kernel+bounces-896765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50810C512C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FCC3A274E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256B2FD1D9;
	Wed, 12 Nov 2025 08:47:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C177165F1A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937244; cv=none; b=eaoKQS/DieLRP6lebu5jYiBeZM3T9rd1WBryCZ53xLuAdrii2fzDkzZK+wylfZggX7M+HIJM3w4DDGonDUVqWGMLdA4WWwmFtM7eyXVZtcNG2+FPs8pSGM4sXF67QJlqzTJd6crvQA8e5QyJ3w1mhvt0axapIHVwcLqoCkTCiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937244; c=relaxed/simple;
	bh=4jeqUNmPOMwzZ/GkaScD0IOS4S+tWByBRy2rtt22bj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADzyPFUfpjrYY3XQx5q54JdooSaAYHGVkejWaYGXeFm/SAZXvgzAVIYtmqmS/M71vQYJ3RyLCxPrTDJDF8srnBDCeiZU8cpLZdeDpUviXngRiaZeg0hlQUWrOuwn6WBu0HjU7HSA0mg8qlg9iMMwwOG1eFNXVdgUeUhQuulD3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vJ6VZ-0002Hl-IX; Wed, 12 Nov 2025 09:47:17 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vJ6VZ-0003IF-1D;
	Wed, 12 Nov 2025 09:47:17 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vJ6VZ-00GPvd-0q;
	Wed, 12 Nov 2025 09:47:17 +0100
Date: Wed, 12 Nov 2025 09:47:17 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Add support for Skov Rev.C HDMI variant
Message-ID: <20251112084717.ea7fchu7jcz6dzsi@pengutronix.de>
References: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
 <176278493286.154609.17548604407386943510.robh@kernel.org>
 <20251110145256.pxgfw3zu7wocguqs@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110145256.pxgfw3zu7wocguqs@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-11-10, Marco Felsch wrote:
> On 25-11-10, Rob Herring (Arm) wrote:
> > 
> > On Fri, 07 Nov 2025 15:49:50 +0100, Marco Felsch wrote:
> > > Hi,
> > > 
> > > this small patchset adds the support for the Rev.C HDMI board variant.
> > > 
> > > Regards,
> > >   Marco
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > Marco Felsch (2):
> > >       dt-bindings: arm: fsl: add Skov Rev.C HDMI support
> > >       arm64: dts: imx8mp-skov: add Rev.C HDMI support
> > > 
> > >  Documentation/devicetree/bindings/arm/fsl.yaml          | 1 +
> > >  arch/arm64/boot/dts/freescale/Makefile                  | 1 +
> > >  arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts | 8 ++++++++
> > >  3 files changed, 10 insertions(+)
> > > ---
> > > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > > change-id: 20251107-v6-18-skov-revc-hdmi-1e8d4bbac26a
> > > 
> > > Best regards,
> > > --
> > > Marco Felsch <m.felsch@pengutronix.de>
> > > 
> > > 
> > > 
> > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >   pip3 install dtschema --upgrade
> > 
> > 
> > This patch series was applied (using b4) to base:
> >  Base: 3a8660878839faadb4f1a6dd72c3179c1df56787 (use --merge-base to override)
> > 
> > If this is not the correct base, please add 'base-commit' tag
> > (or use b4 which does this automatically)
> > 
> > New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de:
> > 
> > arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dtb: switch@5f (microchip,ksz9893): pinctrl-names: ['default'] is too short
> > 	from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml
> 
> This may be a valid issue, but it's rather an additional patch worth it
> since this patchset doesn't touch the imx8mp-skov-reva.dtsi include at
> all.

FTR: If I get the binding right, the regression is caused by commit
https://lore.kernel.org/all/20250918-ksz-strap-pins-v3-2-16662e881728@bootlin.com/.

Since this commit, pinctrl-names always need to have the "default" and
"reset" value, which is wrong.

Regards,
  Marco


> 
> Regards, Marco
> 
> > 
> > 
> > 
> > 
> > 
> > 
> 
> -- #gernperDu #CallMeByMyFirstName
> 
> Pengutronix e.K.                           |
> | Steuerwalder Str. 21                       |
> https://www.pengutronix.de/ | 31137 Hildesheim, Germany
> | Phone: +49-5121-206917-0    | Amtsgericht Hildesheim, HRA 2686
> | Fax:   +49-5121-206917-9    |
> 
> 

