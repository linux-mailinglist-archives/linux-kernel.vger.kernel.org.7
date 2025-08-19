Return-Path: <linux-kernel+bounces-776240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18428B2CA76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A71A1C2612B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A4301499;
	Tue, 19 Aug 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJmwzm8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79FE3009ED;
	Tue, 19 Aug 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624160; cv=none; b=uRjThf4yO5k1n7fUWq371sXTTlQdyEiBh5YCLQQuTX2Rs4yDfAs9O17YieIw8ZRB9em06aCvIzTDC9QktoD1vZZj8QDeEJoD3YzymRerb5+DFFZlnQAWsyBrff22l1FBIVr14SelctEA/Rp5AlucP3eRH4bO0849YlG+xfYZjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624160; c=relaxed/simple;
	bh=Hqw9eNwEyOyjAddQiU40tZUpBUM4UVro4mYONtNAhdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c83aHYS+qL+rzU4b3r0gegFa7LXl9XMkjUTRBPgTsm76H9J2BO2jwoWcrlk55vpkvm/3KmvOgU9U1P0MZKJl/P8Xpk++fjZB2HiQHlb2Ltwlg3ewyzhZMASZ311x3utcoZVhhcS2baNUpFjsQ9qrnDTC+ks9ZJBEiA2OmEwkn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJmwzm8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194B5C4CEF1;
	Tue, 19 Aug 2025 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755624160;
	bh=Hqw9eNwEyOyjAddQiU40tZUpBUM4UVro4mYONtNAhdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJmwzm8JVvkGwG9V+/odTUt0NyAxYoUrIXbQNniA3nwUn548XT34GYo23hN0RP86F
	 ltQXVE/9Sl8T0Z7GnwDxTiMTdLU5NhX4dIzgiuGAQLZs2uG115vn9li+4xgY1ORdtd
	 cAqo83b1PiMbpr/N6IjhyFE/CLL+6ZeDXjzWuP2LOvNDlPwCHEBWxVirr8w1MuyZ/i
	 DQjF5/36k6DShHkW7JLCLcq22uz/M+8OX05N896ZsfrO5ZzQ11AW2W+2MGl4EyZeO5
	 MhZqRpPQo3A3jPTCOvmVflCws3MFnYPDtWQx5uYNWsOX+TvEcJrjrs7RukCneYbyzI
	 I0jR45Bz9LJRQ==
Date: Tue, 19 Aug 2025 18:22:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI TMDS181
 and SN65DP159 bindings
Message-ID: <20250819-impeach-prognosis-247bec1a809b@spud>
References: <20250812145256.135645-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3b7d4319-e208-470d-9ada-585343a64822@emailsignatures365.codetwo.com>
 <20250812145256.135645-2-mike.looijmans@topic.nl>
 <20250812-designing-tyke-db85527b373d@spud>
 <f4ec7690-322e-493a-b346-7b9560ac0616@topic.nl>
 <9fba4917-a24f-4fee-8f1a-7509a0bc542e@kernel.org>
 <2d694c9c-704e-4353-8b57-de83eb5a7f96@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="66JlIddYdkNBaUXn"
Content-Disposition: inline
In-Reply-To: <2d694c9c-704e-4353-8b57-de83eb5a7f96@topic.nl>


--66JlIddYdkNBaUXn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:26:15AM +0200, Mike Looijmans wrote:
> On 19-08-2025 09:51, Krzysztof Kozlowski wrote:
> > On 19/08/2025 09:46, Mike Looijmans wrote:
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - ti,tmds181
> > > > > +      - ti,sn65dp159
> > > > The driver contains:
> > > > +	{ .compatible =3D "ti,tmds181", },
> > > > +	{ .compatible =3D "ti,sn65dp159", },
> > > > +	{}
> > > > so why is a fallback compatible not suitable here?
> > > I don't understand the question. The two are slightly different chips,
> > Your driver says they are compatible. No one said the same, but compati=
ble.
> >=20
> > > so it makes sense to describe that in the DT.
> > Compatible devices should use fallback. There is plenty of examples (90%
> > of all binding files?) including example-schema describing this.
>=20
> Please help me out here, I'm happy to oblige, but I don't understand what
> you're asking.
>=20
> To the best of my knowledge "fallback" compatible is when you write
> something like this in the device-tree:
> =A0=A0 compatible =3D "st,m25p80", "jedec,spi-nor";
> Which means that we can use the "jedec,spi-nor" driver if there's no
> specific match for "st,m25p80", correct?
>=20
> I don't understand how that relates to your request, this is the first ti=
me
> I ever got this particular feedback. Looking at say the ti,sn65dsi83 driv=
er,
> it does the same thing (supports the ti,sn65dsi83 and ti,sn65dsi84).
>=20
> Please explain or point me somewhere where I can find this?

Devices that are supersets of, or functionally identical to, others should
use fallback compatibles. The driver treats these devices as functionally
identical to one another when it comes to match data (as there is none)
so you need to either use a fallback compatible or explain in your
commit message why one is not suitable here.

--66JlIddYdkNBaUXn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKSy2gAKCRB4tDGHoIJi
0jMkAP9NUxCGEjZ63zCEHXPLBh1Zxa6yjFr146a0y81NFbwSjAD/YzkXycwf8ncA
kcfhNlkqACOs8kQMNQf0M5TaGq44NAc=
=o59W
-----END PGP SIGNATURE-----

--66JlIddYdkNBaUXn--

