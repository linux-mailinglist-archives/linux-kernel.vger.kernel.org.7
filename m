Return-Path: <linux-kernel+bounces-855759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4BBE235E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2368484672
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF572307AE1;
	Thu, 16 Oct 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HQmM4ypr"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EB1E0E08
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604287; cv=none; b=mBonoyuLdgOhxT1crneRGZdXgIP5X6FULIEbPjjgnzhJUHpljY+p3lHY276OpiYB3ugPyUsm3QG6AxehnZrGRfvo6yoAYO86ywJJ6OqCu1+81OYviWy/w21/xaZl3ERfKlIxCKbgnLA60ojZGivzguffJIAXid2lNMN6kWnbRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604287; c=relaxed/simple;
	bh=vRX2tojo3/tm9805sxEoYBXfaRPegPiWe9oFIjqdDOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb93Xk7mJPuOZm+2KMNK+mZIfTz9wrBOEBqkepXaBKRposXbq1CW32MrGoWu8CJXXelH4WaWN+NGANGIYFMzhSy7t9+jBgSMfRSImRxbdo9tK1ITPiX7sEGN/ldUkoJ5QKpRgNLMbraE+6iUcyXDhI4Cx4TJEeuFht2Do6tcMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HQmM4ypr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 06738C03598;
	Thu, 16 Oct 2025 08:44:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24AAB6062C;
	Thu, 16 Oct 2025 08:44:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56753102F22F1;
	Thu, 16 Oct 2025 10:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760604281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N1rZiVWM7zYa7/iOhEFyo6sQl/kIYT8q4flK3hRKByc=;
	b=HQmM4yprZlilGcaiSB4/XWd0S51BJtvXC4417lCtZL2fcCLWXoIicfoDQFC7COdyPP0d8U
	sGUm6edEWmgUf3OBpeISB1P1kDAcotG5N0Jnq++reD2L0FyKrqycTTjt7b6aq6DJZRCcC4
	MYkWwgL8NAqOE61PQINi3sOG5Jx56yvzF2AXr0go6QOjuzk3OANIeriItOuNTML1TK13Za
	48NEqBqW1wlUbAloKzagYwDULgmqA4Urj/6Uv7VdtM+yoH7C0DSsGkKrZJsfOhog3uYzRV
	Kolrc5ZfmqkyT8TOXZll5Fe9p88LnOa+7QdJNsG69DX1P3mVF/jiMY1id8+JJw==
Date: Thu, 16 Oct 2025 10:44:34 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ethtool: tsconfig: Re-configure
 hwtstamp upon provider change
Message-ID: <20251016104338.6677e807@kmaincent-XPS-13-7390>
In-Reply-To: <731e8fa7-465b-4470-9036-c59fea602c07@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-4-maxime.chevallier@bootlin.com>
	<20251015144526.23e55ee0@kmaincent-XPS-13-7390>
	<731e8fa7-465b-4470-9036-c59fea602c07@bootlin.com>
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

On Thu, 16 Oct 2025 10:01:53 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi K=C3=B6ry,
>=20
> On 15/10/2025 14:45, Kory Maincent wrote:
> > On Wed, 15 Oct 2025 12:27:23 +0200
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> >  =20
> >> When a hwprov timestamping source is changed, but without updating the
> >> timestamping parameters, we may want to reconfigure the timestamping
> >> source to enable the new provider.
> >>
> >> This is especially important if the same HW unit implements 2 provider=
s,
> >> a precise and an approx one. In this case, we need to make sure we call
> >> the hwtstamp_set operation for the newly selected provider. =20
> >=20
> > This is a design choice.
> > Do we want to preserve the hwtstamp config if only the hwtstamp source =
is
> > changed from ethtool?
> > If we want to configure the new source to the old source config we will=
 also
> > need to remove this condition:
> > https://elixir.bootlin.com/linux/v6.17.1/source/net/ethtool/tsconfig.c#=
L339
> > =20
>=20
> What I get from the ethtool output is that the ts config is per-source.
> Re-applying the old config to the new source may not work if the new one
> doesn't have the same capabilities.
>=20
> >=20
> > I do not really have a strong opinion on this, let's discuss which beha=
vior
> > we prefer. =20
>=20
> Well if we want to support different timestamp providers provided by the =
same
> HW block (same MAC or even same PHY), then we need a way to notify the
> provider when the timestamp provider gets selected and unselected.
>=20
> Otherwise there's no way for the provider to know it has been re-enabled,
> unless we perform a config change at the same time.

Oh right, indeed, we need a call to ndo_hwtstamp_set to tell the provider to
change the qualifier configured. I missed that.
This could even be a fix but as it is used nowhere it won't fix anything.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

