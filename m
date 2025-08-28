Return-Path: <linux-kernel+bounces-789562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE48BB39763
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351D07AB983
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B32E3AFE;
	Thu, 28 Aug 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bTpvSap6"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FD1C01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370810; cv=none; b=QYF6kpz2xGeMyY7xF/JDv+OcizM6isqxqepgjiWaE/eYfgo+4qDJP3AORRJIIMg4ohIrFU7ZensgbtzEvi4js/92HzajR/kskg0NWVYfDUls7gpK+dgM6z9BBhZJk8k9evnLT0pstkVLNliuA67CVndIss4Or4/m+Ln5TBNt+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370810; c=relaxed/simple;
	bh=de2J3MJTaqYoEKquhyWV2Kxi2khjcmqfXABnAiwZOQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJv1gIV1nahfFNgAGpQvD3j+4n54iYYxQsSo4e55Oe30UjSLf4bcSFHY3N5VL2Aae38hUKSH3pVWWYjTLJlhncBuzQUw9y+IkdRlNDp0OVII8o49iBqH8pO4vm7x+L4C9l2v0xE4cAJNOrww6UVNRy4DGacbXM2ANTciZgo6yL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bTpvSap6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8A815C8F455;
	Thu, 28 Aug 2025 08:46:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C49D160303;
	Thu, 28 Aug 2025 08:46:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 494A61C228428;
	Thu, 28 Aug 2025 10:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756370798; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fcQ9JtxCmzdFu9rK24Fv5CgRvuqX3Rs7LR5peXvP4UY=;
	b=bTpvSap6WG8UAFepu/5oFZ8X+VsjtKBuj5bDxTx2AyqMNuF0HqLVu93q2tlXWAbFxHA5M8
	4FYeC5Alhs+RIusSLHDmKfLcG4jMhNkJPf/R+Aw1Dcl+b0ghdbIQtF1mlpd4Bxy/YzdM1Q
	t0DYbZJlMzSCrTtcz4SH6PY9nTZVjW/O0vWb2mNJ0cqz7Nj74zrj54sT5rd3QtVBcL/FDF
	TrYTOeYuwG03plHjGPTZC18loxqrEYA2ZFK0nRl0ynDnopidcq524HhdbXEvTlt5wb/fb1
	/4ujEeXVNX88OcWqb/rteCsHOhZu0aKjFwU9qBYzPPRKC6uBQTW/XwTogJQVNw==
Date: Thu, 28 Aug 2025 10:46:12 +0200
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
Message-ID: <20250828104612.6b47301b@kmaincent-XPS-13-7390>
In-Reply-To: <20250825151001.38af758c@kernel.org>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
	<20250825151001.38af758c@kernel.org>
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

Le Mon, 25 Aug 2025 15:10:01 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Fri, 22 Aug 2025 17:37:01 +0200 Kory Maincent wrote:
> >  	manager =3D kcalloc(PD692X0_MAX_MANAGERS, sizeof(*manager),
> > GFP_KERNEL); if (!manager)
> >  		return -ENOMEM;
> > =20
> > +	port_matrix =3D devm_kcalloc(&priv->client->dev, PD692X0_MAX_PIS,
> > +				   sizeof(*port_matrix), GFP_KERNEL);
> > +	if (!port_matrix)
> > +		return -ENOMEM; =20
>=20
> Leaking manager..

I don't think so, as manager is declared like the following it should not.
struct pd692x0_manager *manager __free(kfree) =3D NULL;

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

