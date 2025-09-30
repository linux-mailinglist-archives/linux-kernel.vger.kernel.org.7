Return-Path: <linux-kernel+bounces-837591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916FBACAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F441892A28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7322F747C;
	Tue, 30 Sep 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzdBuhSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BB23A995;
	Tue, 30 Sep 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231735; cv=none; b=FwKydVa1PFAeQGwKFfuZ/XDcvb5c6UtwFseUEUAiLnapchw9soinfdZSkPKfJTVBVicOwNRKVaAvhjUEGFFRDDPrmDxja+eIsWTY4uFWANh3Z5SRXuLEMagm6wMYzf169UD9LFGiZOz51yfBSlakrzVztYuXdviBERuPvEuos7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231735; c=relaxed/simple;
	bh=2uOCefQxy9aMorGL7YJd54BkvaKF2LUCUk691jwJwyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzp5KOVNRKh4h0btu9hh3DSaSBEditudiLW/JmqCc3cvhEw89yKM0Kqn11FxMTegVyCGQsviReXK8wvpEyI4TzaEVbVeSenb5E+SdJoqPNpdM/XOIWrLkeT/XUdLItaNNLoWszaqS99eGrd8UKFxvCMy8r+6zSfueExLX0SWZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzdBuhSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4F4C4CEF0;
	Tue, 30 Sep 2025 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759231735;
	bh=2uOCefQxy9aMorGL7YJd54BkvaKF2LUCUk691jwJwyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzdBuhSDQRs6RHdxJsBxtNXioCysuVWr2khDLJyNG7Qa/bDjZHSoY00AOk90fe/YA
	 fBWv/Akonk21ZIG7tQOMNPVGWmOF9RA/n/2GsX64+bzONWhhflGZqlz61TeJYq35Pb
	 IOfrgxePA5xGVz9ootiQHrWvcfjkYnlmm/OM4yrINLbAhFClu6rYTFWrAWJJURhr66
	 db6CzAl3Zyuvh6z9JrdNllWCyYFFx4+5GKrIdwD2o/ZSR5CB6lTAxBHYABGJpaJLZI
	 TA3Z1XngTCRvkDnYkHBl4WT2ylxHe47ADsROyE4LbfYDuvhWE8pwMeFwciUpnx5UKF
	 wBGJd8xk1tFzQ==
Date: Tue, 30 Sep 2025 13:28:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
Message-ID: <20250930-brawny-pastel-wildcat-4ba8d8@houat>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
 <20250925-eager-delectable-frog-fcbb5d@penduick>
 <aNVPqHldkVzbyvix@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="oaferhurvh74yiin"
Content-Disposition: inline
In-Reply-To: <aNVPqHldkVzbyvix@redhat.com>


--oaferhurvh74yiin
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
MIME-Version: 1.0

On Thu, Sep 25, 2025 at 10:20:24AM -0400, Brian Masney wrote:
> On Thu, Sep 25, 2025 at 02:14:14PM +0200, Maxime Ripard wrote:
> > On Tue, Sep 23, 2025 at 10:39:19AM -0400, Brian Masney wrote:
> > > The Common Clock Framework is expected to keep a clock=E2=80=99s rate=
 stable
> > > after setting a new rate with:
> > >=20
> > >     clk_set_rate(clk, NEW_RATE);
> > >=20
> > > Clock consumers do not know about the clock hierarchy, sibling clocks,
> > > or the type of clocks involved. However, several longstanding issues
> > > affect how rate changes propagate through the clock tree when
> > > CLK_SET_RATE_PARENT is involved, and the parent's clock rate is chang=
ed:
> > >=20
> > > - A clock in some cases can unknowingly change a sibling clock's rate.
> > >   More details about this particular case are documented at:
> > >   https://lore.kernel.org/linux-clk/20250528-clk-wip-v2-v2-2-0d2c2f22=
0442@redhat.com/
> > >=20
> > > - No negotiation is done with the sibling clocks, so an inappropriate
> > >   or less than ideal parent rate can be selected.
> > >=20
> > > A selection of some real world examples of where this shows up is at
> > > [1]. DRM needs to run at precise clock rates, and this issue shows up
> > > there, however will also show up in other subsystems that require
> > > precise clock rates, such as sound.
> > >=20
> > > An unknown subset of existing boards are unknowingly dependent on the
> > > existing behavior, so it's risky to change the way the rate negotiati=
on
> > > logic is done in the clk core.
> > >=20
> > > This series adds support for v1 and v2 rate negotiation logic to the =
clk
> > > core. When a child determines that a parent rate change needs to occur
> > > when the v2 logic is used, the parent negotiates with all nodes in th=
at
> > > part of the clk subtree and picks the first rate that's acceptable to
> > > all nodes.
> > >=20
> > > Kunit tests are introduced to illustrate the problem, and are updated
> > > later in the series to illustrate that the v2 negotiation logic works
> > > as expected, while keeping compatibility with v1.
> > >=20
> > > I marked this as a RFC since Stephen asked me in a video call to not
> > > add a new member to struct clk_core, however I don't see how to do th=
is
> > > any other way.
> > >=20
> > > - The clk core doesn=E2=80=99t, and shouldn=E2=80=99t, know about the=
 internal state the
> > >   various clk providers.
> > > - Child clks shouldn=E2=80=99t have to know the internal state of the=
 parent clks.
> > > - Currently this information is not exposed in any way to the clk cor=
e.
> >=20
> > I recall from that video call that Stephen asked:
> >=20
> > - to indeed not introduce a new op
> > - to evaluate the change from top to bottom, but to set it bottom to top
> > - to evaluate the rate by letting child clocks expose an array of the
> >   parent rates they would like, and to intersect all of them to figure
> >   out the best parent rate.
> >=20
> > It looks like you followed none of these suggestions, so explaining why
> > you couldn't implement them would be a great first step.
> >=20
> > Also, you sent an RFC, on what would you like a comment exactly?
>=20
> Stephen asked me to not introduce a new clk op, however I don't see a
> clean way to do this any other way. Personally, I think that we need a
> new clk op for this use case for the reasons I outlined on the cover
> letter.

So his suggestion was to base the whole logic on clk_ops.determine_rate.
You're saying that it would violate parent/child abstraction. Can you
explain why you think that is the case, because it's really not obvious
to me.

Additionally, and assuming that we indeed need something similar to your
suggestion, determinate_rate takes a pointer to struct clk_rate_request.
Why did you choose to create a new op instead of adding the check_rate
pointer to clk_rate_request?

> I am open for suggestions about alternative ways, and will gladly make
> modifications. This is why I marked this series as RFC. Patch 10 in
> this series is the main change of note here.
>=20
> Additionally, the presence of the new op is a convenient way to also
> signal to the clk core that these providers can use the v2 negotiation
> logic. Otherwise, we'll need to introduce a flag somewhere else if we
> want to support a v1/v2 negotiation logic across the clk tree.
>=20
> As for 2), I negotiate the rate change from the top down. The new_rate
> is propagated in the same manner as what's done today in the clk core
> when a parent rate change occurs. I let it reuse the existing rate
> change code that's currently in the clk core to minimize the change
> that was introduced.
>=20
> Regarding the clock table in 3), it could be done with what's there,
> but there's the issue of the new clk_op. I posted this to get feedback
> about that since I think we should settle on the core changes.

Again, why can't we add a pointer to that array in clk_rate_request?

Maxime

--oaferhurvh74yiin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNu+9AAKCRAnX84Zoj2+
dsprAXoCxeRN9DGpm/p1kDonhFIiCK5LgsbpU3OkGp3ZgFrNCna1JVI8jRDE3hSr
Wn6cX6kBfRUw+0sV1+kkLwnzULRBoY58WYHOQleKb3CBYWkQUu0OBJfMQzmcIB04
vsZnADuerw==
=8KBc
-----END PGP SIGNATURE-----

--oaferhurvh74yiin--

