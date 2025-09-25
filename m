Return-Path: <linux-kernel+bounces-832375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7153B9F2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1731C21622
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DEB31327A;
	Thu, 25 Sep 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPWPM/x4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03E2FD1CF;
	Thu, 25 Sep 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802460; cv=none; b=rhC85yyffovJjskU+ViWq/qRHto3Vrb1Ew/TsjanRV2du5TzdPYCN3xpWpbCJkcTOZZd9HoQC0HC7I7mP2v2S95jF0gk+90n7xN700gRQ71VoABqf+eRKbiA9Tn3dkdcUm2uD3CDqcZy5uDyPaWAfGeUYcZXJlosMrk3MRwUeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802460; c=relaxed/simple;
	bh=QDf0rT/5rkTYt+81E1gFF4g1LilRq7xkqlp201SJkeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQJyNNdckrWMrzrSZvN/rXUSK6vYEcsriB25Qt6qP4Dmh0z+KyKvEDbmr46GRQGHDcUJiECqOSORUzNqsaIEjgu+Wd+EmUIuZ/CkVggqoHjEzFibxLsF1Zpf40BBNWfzisX24ESAQe4nvMEOyftNJuB8b8Y/1ay1VPDxT/k9aoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPWPM/x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EACC4CEF5;
	Thu, 25 Sep 2025 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758802459;
	bh=QDf0rT/5rkTYt+81E1gFF4g1LilRq7xkqlp201SJkeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPWPM/x4qGxQwosiba1yJD36yXG5QgFaiemGwEXVJ4UCVroWESRi7Q40vMEErOnzs
	 OvBTUYxUj9hJRXWCAtE+nb82RZufL6G0VI8GdMoEnigmdyT9t3aR0cAxfQAAR4kTL+
	 /NCQm02pWiAv00XDMKMj3krNM8SCLda7PFNlazGw026U4PcNeWj/De/eqwPHhDArvK
	 w+D0hX5clUds8GfZqKJHaqxGjsCwa2vI9amsp4AsWAtIRpAFqnFfdazBwNMhhRI9cZ
	 npO7rrKYtoiLfTyl/H3uJ2kxGRHn7W+u8ts+9M5WkKkyCr32xY8Frn+OsQ0hrv2LLZ
	 Ofx7rRI/RzJXA==
Date: Thu, 25 Sep 2025 14:14:14 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
Message-ID: <20250925-eager-delectable-frog-fcbb5d@penduick>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3jd57vz4q2z2wvel"
Content-Disposition: inline
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>


--3jd57vz4q2z2wvel
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
MIME-Version: 1.0

Hi Brian,

On Tue, Sep 23, 2025 at 10:39:19AM -0400, Brian Masney wrote:
> The Common Clock Framework is expected to keep a clock=E2=80=99s rate sta=
ble
> after setting a new rate with:
>=20
>     clk_set_rate(clk, NEW_RATE);
>=20
> Clock consumers do not know about the clock hierarchy, sibling clocks,
> or the type of clocks involved. However, several longstanding issues
> affect how rate changes propagate through the clock tree when
> CLK_SET_RATE_PARENT is involved, and the parent's clock rate is changed:
>=20
> - A clock in some cases can unknowingly change a sibling clock's rate.
>   More details about this particular case are documented at:
>   https://lore.kernel.org/linux-clk/20250528-clk-wip-v2-v2-2-0d2c2f220442=
@redhat.com/
>=20
> - No negotiation is done with the sibling clocks, so an inappropriate
>   or less than ideal parent rate can be selected.
>=20
> A selection of some real world examples of where this shows up is at
> [1]. DRM needs to run at precise clock rates, and this issue shows up
> there, however will also show up in other subsystems that require
> precise clock rates, such as sound.
>=20
> An unknown subset of existing boards are unknowingly dependent on the
> existing behavior, so it's risky to change the way the rate negotiation
> logic is done in the clk core.
>=20
> This series adds support for v1 and v2 rate negotiation logic to the clk
> core. When a child determines that a parent rate change needs to occur
> when the v2 logic is used, the parent negotiates with all nodes in that
> part of the clk subtree and picks the first rate that's acceptable to
> all nodes.
>=20
> Kunit tests are introduced to illustrate the problem, and are updated
> later in the series to illustrate that the v2 negotiation logic works
> as expected, while keeping compatibility with v1.
>=20
> I marked this as a RFC since Stephen asked me in a video call to not
> add a new member to struct clk_core, however I don't see how to do this
> any other way.
>=20
> - The clk core doesn=E2=80=99t, and shouldn=E2=80=99t, know about the int=
ernal state the
>   various clk providers.
> - Child clks shouldn=E2=80=99t have to know the internal state of the par=
ent clks.
> - Currently this information is not exposed in any way to the clk core.

I recall from that video call that Stephen asked:

- to indeed not introduce a new op
- to evaluate the change from top to bottom, but to set it bottom to top
- to evaluate the rate by letting child clocks expose an array of the
  parent rates they would like, and to intersect all of them to figure
  out the best parent rate.

It looks like you followed none of these suggestions, so explaining why
you couldn't implement them would be a great first step.

Also, you sent an RFC, on what would you like a comment exactly?

Maxime

--3jd57vz4q2z2wvel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNUyFQAKCRAnX84Zoj2+
dkcaAX4/Q3zt7IIjGTfZyOazQ/ZGQq+cJ489oNxyuw4Tcc5rurZAvjdur7WpulpK
CpKjbnQBgL08dy9V333Ea8vBKToRnPW6XPAqHcjFUTBYdqOa2N9tyRkPyLaOypYi
rl9HLzkzwA==
=dSuQ
-----END PGP SIGNATURE-----

--3jd57vz4q2z2wvel--

