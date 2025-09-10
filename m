Return-Path: <linux-kernel+bounces-810922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BFB5218B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D467ABE72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC82ED871;
	Wed, 10 Sep 2025 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="S/DgMXTG"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5420329F0E;
	Wed, 10 Sep 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534545; cv=none; b=IZgiaHVWb/9mV5ghAIMxuGMdq3+qONW2x1fec9FRd6/iJg7sdPlaja34JgMF8bF5oBUuS5Qf4jiIgcCva5+QAImFGW8tF6zdUdEScerpyMtVbWLqkqDeUzpsS73PjTnkKJ9P9JzDuSf4iX9S9uRRyCkV9OBzShyDiMPqGzw91HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534545; c=relaxed/simple;
	bh=a+dv0UV8rJBpw5xyo6IBTrbeTMXkPWVPM8ER8nxUixY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzJGmStJ1X9YzmwYPHWXHvtw6IULmj+hGa5NcnKq68vAbSXqgT93mg+TCUhWWkSfvyIOQ4xF3CH3kiZZ88Z2xR3Jz/V3cR5+d0+dWCyhquT1I0zfPH+KsgtMmaUYChS52Q50TY4K6CsvEIHPy1GKqTPzj3kRiTxYfCVu+Z/7Ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=S/DgMXTG; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6gz3FXQu3DOFyH5Z/Yxt5ftIBimKEIJZnXppi88qYoQ=; b=S/DgMXTG9T1+Ocjo962KJ96UaF
	anWelgQmGO/UfRZPPlKdjlmpkrnpewf2mmdKcL4ZnXofMfK6ODsm6s7oh7b4M5k4RMXWCfp/XPBXH
	3MwMaQj1B/0RTfum51nzotVj5vc+982luD2HDTLjF8cIQzn1Vj0w4MDeXodebLl1aTafz+DLIzGER
	+DKZKKCIylemE0bvBATwKOZY0uaIobx1bhiUVmBdE3x0j9iXHdnloksfYoIR0No9Yrb2L8fUiMY1y
	ozK9zlaRZpU9/STU323PodgcPRhe0nOxqdYY9iyRN+/snTgZFbX4fH306Fg//Ji/s/RUcgW/GpgS1
	gZ3CSndA==;
Date: Wed, 10 Sep 2025 21:18:04 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Frank Li <Frank.li@nxp.com>
Cc: Andreas Kemnade <akemnade@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins
 and supply
Message-ID: <20250910211804.5d88f12b@akair>
In-Reply-To: <aMGdH7Ab+9t/v3CB@lizhi-Precision-Tower-5810>
References: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
	<20250909-sy7636-rsrc-v2-1-cfd9f44fd259@kernel.org>
	<aMGdH7Ab+9t/v3CB@lizhi-Precision-Tower-5810>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 10 Sep 2025 11:45:35 -0400
schrieb Frank Li <Frank.li@nxp.com>:

> On Tue, Sep 09, 2025 at 10:33:02PM +0200, Andreas Kemnade wrote:
> > To be able to fully describe how the SY7636A is connected to the system,
> > add properties for the EN and VCOM_EN pins. To squeeze out every bit
> > of unused current, in many devices it is possible to power off the
> > complete chip. Add an input regulator to allow that.
> >
> > Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
> > ---
> >  .../devicetree/bindings/mfd/silergy,sy7636a.yaml         | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > index ee0be32ac0204..054b97dd0c5c7 100644
> > --- a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > @@ -32,6 +32,22 @@ properties:
> >        Specifying the power good GPIOs.
> >      maxItems: 1
> >
> > +  enable-gpios:
> > +    description:
> > +      If EN pin is not hardwired, specify it here to have it set up.  
> 
> Need descript function of enabel-gpios, you can ref data sheet sy7636a.
> 
> "enable-gpios" is good self documented by property name, needn't
> description at all.
> 
What you are saying is contradictory. I would prefer to have a mapping
crystal clear visible between properties and pins. That is why I want
that description. I remember I have got the datasheet from the company
site with registration without acknowledging any terms. But I do not
find that site.

> > +    maxItems: 1
> > +
> > +  vcom-en-gpios:
> > +    description:
> > +      If VCOM_EN pin is not hardwired, specify it here to have it set up.
> > +    maxItems: 1
> > +
> > +  vin-supply:
> > +    description:
> > +      Supply for the chip. Some vendor kernels and devicetrees declare this
> > +      as a GPIO named "pwrall" which does not exist in the datasheet,
> > +      disabling it makes the chip disappear on the bus.
> > +  
> 
> The same here, descript function. such as power supply for whole chip.

I think it is useful what I am writing here. DT maintainers are
apparently fine with it, since it has earned a Reviewed-By.

Regards,
Andreas

