Return-Path: <linux-kernel+bounces-689751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A1ADC5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFEF1897525
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E4293C65;
	Tue, 17 Jun 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M+miiqce"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4129293F;
	Tue, 17 Jun 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151849; cv=none; b=pM+vPl3YXQWv62dlyWvnHB9/PhLb7wh/2eWXh8nRA4iZMkR59CSA32y7peqAbHZvaQqEq3+0Fvfz+ooWbtiqoxUtMxXiHthmO0lnP9cS1CXC36d5xlFBoPaveMoqy+9tUkwqEUFD1wTWUIWfOtkF6WIXGVHYe6dXDA+bV2cP+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151849; c=relaxed/simple;
	bh=FQXnGsd73/f9J/zGAeV7+41vhLkWwiNvzwjJMjI9qp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctQM0B8rWa+YsN5YmVSY2Jbl/bOWFAVjcfKnhAI0/rxHjysGiPWK3I5e6ox5RV7WkjlwmVUUjSfbcddRNWBdDMy6kNJWmPkMIiEPCIM8+O2TyLh96HKesBnFy+kET2As6IXO5nNNa4ZVp+5JwbsaWhOKCOHpSqSfI84KlUm7pRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M+miiqce; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02B4C4313C;
	Tue, 17 Jun 2025 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750151839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nF2jWLz+oe0XbgRDYBKL06Kbon9IlX0EAq9ZZET5T9g=;
	b=M+miiqcetYz4nbhA02gPLJDUGu0rrWhzDQVMPzlL5qCT8O6DE6nrgeX0aakOvZ1GrPdYJD
	GGwkE7D1CvgU+Zt5GqCA5rcIPFp7Z0aUkI43SQ6TkA8PK50gQxaP9pzvirei1cctzeiOzU
	G4kU/4Wl/fAG4pByrxSm/TZEzEkV+yDXiK8zcYqcIJSNeuVRCJMog4lDFAU1Zca5L6J5HY
	5Q8PiJQ3dhFliry8qE3VD7ai7ljW0dKLghzeI0i/xUAj8BDOHEpIdiFhgaCqOkkah/Of1v
	5s4mkWGVjA2EtDjUzogCNh31Y4oOamYMJzoMm5V8thlzZ8OQGZvXsNnIlAhGAg==
Date: Tue, 17 Jun 2025 11:17:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250617111716.1ac59742@kmaincent-XPS-13-7390>
In-Reply-To: <20250616095658.323847a9@kernel.org>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-7-c5edc16b9ee2@bootlin.com>
	<20250614123311.49c6bcbf@kernel.org>
	<20250616151437.221a4aef@kmaincent-XPS-13-7390>
	<20250616095658.323847a9@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkeelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh

Le Mon, 16 Jun 2025 09:56:58 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Mon, 16 Jun 2025 15:14:37 +0200 Kory Maincent wrote:
> > > On Tue, 10 Jun 2025 10:11:41 +0200 Kory Maincent wrote:   =20
>  [...] =20
> > >=20
> > > the only caller of this function seems to negate the return value:
> > >=20
> > > drivers/net/pse-pd/pse_core.c:369:              if
> > > (!pse_pi_is_admin_enable_not_applied(pcdev, i))
> > >=20
> > > let's avoid the double negation ?   =20
> >=20
> > I thought it was better for comprehension.
> > If we inverse the behavior we would have a function name like that:
> > pse_pi_is_admin_disable_not_detected_or_applied()
> >=20
> > Do you have a better proposition? =20
>=20
> Would pse_pi_is_admin_enable_pending() work?

Indeed that could work! Thanks!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

