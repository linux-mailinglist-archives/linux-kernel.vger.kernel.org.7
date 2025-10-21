Return-Path: <linux-kernel+bounces-862733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09464BF6037
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD1A19A134A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66862FBDF6;
	Tue, 21 Oct 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hRoJ/yl9"
Received: from mx-relay138-hz1.antispameurope.com (mx-relay138-hz1.antispameurope.com [94.100.132.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D71302CDB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.197
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045966; cv=pass; b=mpmIzZs+ihdJNBtaAOwwalIHaESURI3TU4eXUIQM+u82+YUT55qeXM4/mLdwNpZA6LhavXsEZzv6ObA+/sQIvoYzpcG2jIoeeL4HoB44iYmh4wy+tC1eTpPRPlFZp3v1Bnx4IdDuWfBYSFiubS6l+64E/xSpJ6jxE9rXOeKxJYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045966; c=relaxed/simple;
	bh=n4mhlRhzzFm3V7tkh8PEoEN4chx5mQY5EISlduNBssk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C94ziRP/FiHzO3WXmIFLCTXnrIQHPBmBV9X3HSJMQCRM4lRRJXTosePveQ/VBtMee5587PDevcN/stL419BHihm1pTqdMJpCZtCoYStXsRQZ9I7ndMPUjeDgSGaaYkwtB2kOrnmRZEnmPtm0F8M3gjDpSfNanFqprCTa1j2lxyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hRoJ/yl9; arc=pass smtp.client-ip=94.100.132.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate138-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=qPRSdSQE0bLnU693LJLxkchAwzL3R1o8wQQaHCAimXE=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761045914;
 b=LuByLqB8XY2tsdEQ1xs+u1IRMmUGwwv7LO6ToIhizQsaRdXqVp4kIYpK2RMiSepl7YGINyZQ
 O+KgNyE9FTmPxg3uIqB6emnQtSk+PyVTb0jFPbYPLFOaN0zOcfBfbPyg7bnjUOUVnz6UHeOkZJ0
 zMyiwo+TMHaINxefzgfOatjChP0/7elbRjpjIWog7zXnrAnWBp039jEUF07KOFZrZwOAfqyy8xd
 yLqOw7lNE9TBoxe219j0T1rx8pfjcMwJSlryn4/FmoHUeee2/g4QIEoje5yW4TC+efyWW4WNUWt
 Q+ThykToeQpw3v7+RgakSCzNCR4qZ40cXldCBqhw23DsA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761045914;
 b=rEZQseNOOFqDNf7FWczfwfE4s//BnoNq0K6K8R9NA6xsV+T0dY+rurFXs9OmSmKsR2XWSEYf
 McS8AU+FbbHhDA8C8HxZ+w5UVj/ZP30DVQf61JTboQIEscDdpkFKfgLq7OhSwuW/hyRrrv7AoS2
 Rll5BiuXhqC+zdEzi6c3GhhlXYValt783VDM0DWHJCGaqkLjP+n9NW6vqErACMqFwInKg6vTthH
 6YpUTUs22TCCI+ylddfWPm936pCV2nYA5bJuhIe8YchKUFcZjAwPtqAF/KDZtYg9aNSWiwvIotg
 C3xioYQFh2xdGAFx31O01edhcsVAP82dlkh1x5nobGuyQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay138-hz1.antispameurope.com;
 Tue, 21 Oct 2025 13:25:14 +0200
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 56DCEA404BD;
	Tue, 21 Oct 2025 13:24:53 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Gregor Herburger <gregor.herburger@tq-group.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject:
 Re: [PATCH v2 2/2] arm64: dts: ls1028a: Add mbls1028a and mbls1028a-ind
 devicetrees
Date: Tue, 21 Oct 2025 13:24:52 +0200
Message-ID: <13873811.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <14f52170-cc5b-4808-8fc1-28685ba349dd@lunn.ch>
References:
 <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
 <20251020133536.303471-2-alexander.stein@ew.tq-group.com>
 <14f52170-cc5b-4808-8fc1-28685ba349dd@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay138-hz1.antispameurope.com with 4crVMB1Y5zz1NGLl
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:0a6c4bbb931b6e0c1b6e99bc4c54eeb4
X-cloud-security:scantime:2.297
DKIM-Signature: a=rsa-sha256;
 bh=qPRSdSQE0bLnU693LJLxkchAwzL3R1o8wQQaHCAimXE=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761045914; v=1;
 b=hRoJ/yl9e7TfSsYErdF0tkYk6kFCc3txXOGT8dYKIB6MgUA0CWOH9GEMCh19/445QYV7s7B+
 xvrGd4DUWPEQeIUxItHmCORscltnPa6MtPyKSMteQZQYaoPILHOsyO6VMRERlDH5pgW0X0l2szl
 ITLlHgzIibTPSgVTSLDNLirSGoUw4y/3j/2t8fuRSRozXB1Z8AU7d4RsASy4Hq7aeqeCQnasFwg
 wyqC/AIRe/9JUSrnwvfe6XrJDs6WHHtX+3J1IzeR6qyikx7/9d5qFuDuBzQ22GS+imnFppSSr8J
 muzNhjXwC1rF7Ow12WE2r+afbRD9s/F0y3UbdHqevddxw==

Hi Andrew,

Am Montag, 20. Oktober 2025, 20:34:16 CEST schrieb Andrew Lunn:
> > +&enetc_mdio_pf3 {
> > +	mdio0_rgmii_phy00: ethernet-phy@0 {
> > +		compatible =3D "ethernet-phy-ieee802.3-c22";
> > +		reg =3D <0x00>;
> > +		reset-gpios =3D <&gpio_exp_1v8 1 GPIO_ACTIVE_LOW>;
> > +		reset-assert-us =3D <1>;
> > +		reset-deassert-us =3D <200>;
> > +		interrupt-parent =3D <&gpio_exp_1v8>;
> > +		interrupts =3D <0 IRQ_TYPE_EDGE_FALLING>;
>=20
> PHY interrupts are generally level not edge. So this is probably
> wrong.

Thanks for the pointer.

> > +		ti,rx-internal-delay =3D <DP83867_RGMIIDCTL_2_50_NS>;
> > +		ti,tx-internal-delay =3D <DP83867_RGMIIDCTL_2_00_NS>;
> > +		ti,led-function =3D <0x05b0>;
> > +		ti,led-ctrl =3D <0x1001>;
>=20
> I really would prefer /sys/class/leds was used. In fact, these are not
> documented, and don't even seem to be implemented in mainline. So you
> need to drop them.

Ah, sorry, this slipped in from downstream kernel. Will be removed.

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



