Return-Path: <linux-kernel+bounces-739121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4046B0C215
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFD17CA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB1291C2A;
	Mon, 21 Jul 2025 11:02:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF9291C0C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095738; cv=none; b=tsDz4JCeeDzY2oJ4OJZAC7/0bEX5ggdKl8VOSQulzVFbuq7T1u4Us4oZLqQFhbsjHV6n9mrejwSOWV2/7wlTtoG0tqODyRBtfPDLVzeyrRl/GSy+sp1dKnGQJBI3f8M9M3d9EVeosOTdcBdsfe/I9gfPK1Q/6RpsxAJQVEHhggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095738; c=relaxed/simple;
	bh=qKZvHgUpkiu4F1ESzD0V0+p+GSfrdPViVD4CQaHR5Qw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DcXh0ukcf7MrC+8tqcZAt28SYxBpOdQOknetZOVf5IS/paooj+dHUGwnDLeZ7RSguH/n2SRHxUN/S6aYiCKrU6Ge36O7s7be1gmAyUXoYCVqF5xPG4+zp7X4QauYKGc26bzMZm7zauobGRV4uXtMvMAgOzWqH4xAei47sigTqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1udoH0-0006cV-Q3; Mon, 21 Jul 2025 13:01:34 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1udoGw-009Xfi-2H;
	Mon, 21 Jul 2025 13:01:30 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1udoGw-000EXA-1x;
	Mon, 21 Jul 2025 13:01:30 +0200
Message-ID: <d178cfb17e726597e2b4d4c49de5040646b9e55e.camel@pengutronix.de>
Subject: Re: [PATCH v6 2/2] usb: dwc3: add generic driver to support
 flattened
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Alex Elder <elder@ieee.org>, Ze Huang <huang.ze@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 13:01:30 +0200
In-Reply-To: <d2e9a521-568e-433d-a59b-9b98138ace2b@ieee.org>
References: <20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev>
	 <20250712-dwc3_generic-v6-2-cc87737cc936@linux.dev>
	 <d2e9a521-568e-433d-a59b-9b98138ace2b@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2025-07-15 at 15:50 -0500, Alex Elder wrote:
> On 7/12/25 2:49 AM, Ze Huang wrote:
[...]
> > +static int dwc3_generic_probe(struct platform_device *pdev)
> > +{
> > +	struct dwc3_probe_data probe_data =3D {};
> > +	struct device *dev =3D &pdev->dev;
> > +	struct dwc3_generic *dwc3;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	dwc3 =3D devm_kzalloc(dev, sizeof(*dwc3), GFP_KERNEL);
> > +	if (!dwc3)
> > +		return -ENOMEM;
> > +
> > +	dwc3->dev =3D dev;
> > +
> > +	platform_set_drvdata(pdev, dwc3);
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "missing memory resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	dwc3->resets =3D devm_reset_control_array_get_optional_exclusive(dev)=
;
> > +	if (IS_ERR(dwc3->resets))
> > +		return dev_err_probe(dev, PTR_ERR(dwc3->resets), "failed to get rese=
ts\n");
> > +
>=20
> It isn't enforced on exclusive resets, but I'm pretty sure
> resets are assumed to be asserted initially.

The reset controller API doesn't guarantee this. Whether reset controls
are initially asserted depends on the specific SoC/reset controller and
also on what the bootloader did before.

For example, there are self-deasserting reset controls that start out
deasserted and can only ever be asserted for a short pulse [1]. Even
the shared reset API only assumes that the reset line may have been
asserted at some point before the first assert() [2].

[1] https://docs.kernel.org/driver-api/reset.html#triggering
[2] https://docs.kernel.org/driver-api/reset.html#assertion-and-deassertion

Whether an explicit reset_control_assert() in the probe function is
needed depends on which assumptions the driver can make on its own (on
all platforms it is used on).
For example, for some devices it may be enough to assume that the
device has been reset at some point between power-on and probe.


regards
Philipp


