Return-Path: <linux-kernel+bounces-791366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FDBB3B5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7F346785F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC4298CC4;
	Fri, 29 Aug 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I2yuhlbI"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63089257826
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456006; cv=none; b=fdPUpse/qi3aBQtYgt4+0GGmocxLjSk97Y81HDaNjRQ7dFZA1jxMgvaNROGfqb61DqbM5H7awlR1hY3xPks4scOzn5py2hRqOBCGTieCOqlRbfTotmtkCfG/j8IHYG45VA1ZTGjEZhLpq8PTdjd0uJfyrF81Q53lRxPmatcI4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456006; c=relaxed/simple;
	bh=7qLeM+kxTRxbJYzKciRd095XlXC2ywCb1PAwpEcIAIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUsX3dh8sh76glAUrhuP9rjN6zqMUXhPzIAOUHvxzRN2SlcSAm8wsy2KE4CfC4ounUauAMJWWZI/vV665580xjGOF5am5QbRmBBmL1soYd7PEJoaiDPGPh9MRCcw+2ujJdO7zpCh/f8kGIhUEuw52D+wkH4ozGXMAxLiesKW2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I2yuhlbI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A9264E40C28;
	Fri, 29 Aug 2025 08:26:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69D60606B9;
	Fri, 29 Aug 2025 08:26:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 489E41C22DB07;
	Fri, 29 Aug 2025 10:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756456001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qcdtZuoiQD8z2g6YK6ro+/M/nM5t+ResA19W1UFPmC8=;
	b=I2yuhlbIdJhY58deLkKVTIrANBMDvHgpen9qkOwAhguqx+0xdP+m1pVape31vNO9o/z6Pb
	VdltX5Yq1heXXt48FY3x0+7sZk2U3DE8lnkCC1ozU7wCQdJMmmmoDIqCTtZa+YYmWa8XV0
	2Y2W8LqSPEVTzGtt6y+6qfcyHvJaitOnDUVjOPcl53DkQx4SEQyts0Xsilep02Xgoa/F/t
	o6L9IHaAPQq8+P1d3S0v2JZcILzSym/cIwIeXk4uJjJi6123/h5Evz1av0sqPoBUp/LpnC
	ReNyS1zRgqddoPcBfRl+pGXySzTpoyEJDrE+Nyk7cpEucM1drsZOUOrWSH3VdA==
Date: Fri, 29 Aug 2025 10:26:24 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: pse-pd: pd692x0: Separate
 configuration parsing from hardware setup
Message-ID: <20250829102624.1d959943@kmaincent-XPS-13-7390>
In-Reply-To: <20250828151218.1c187938@kernel.org>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
	<20250825151001.38af758c@kernel.org>
	<20250828104612.6b47301b@kmaincent-XPS-13-7390>
	<20250828151218.1c187938@kernel.org>
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
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 28 Aug 2025 15:12:18 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 28 Aug 2025 10:46:12 +0200 Kory Maincent wrote:
> > > On Fri, 22 Aug 2025 17:37:01 +0200 Kory Maincent wrote:   =20
>  [...] =20
> > >=20
> > > Leaking manager..   =20
> >=20
> > I don't think so, as manager is declared like the following it should n=
ot.
> > struct pd692x0_manager *manager __free(kfree) =3D NULL; =20
>=20
> Please consult documentation on the user of __free() within networking.

Oh, I didn't know about this net policy.
I didn't follow the maintainer-netdev doc changes. Maybe I should.
Ok, I will add a patch to the series to remove the __free macro.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

