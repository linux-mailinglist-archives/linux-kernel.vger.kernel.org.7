Return-Path: <linux-kernel+bounces-832331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9731B9EF73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B044E1EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189B2FB975;
	Thu, 25 Sep 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwLyz8Il"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143312FB977;
	Thu, 25 Sep 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800602; cv=none; b=mYkVdSHVEdoluc7THmyOAyR+jQMcU03bbQfM7mr42OT238x8AM1QXbGAvl6vQOnGdQ7HzogmHgSlNHMXGayXuk91WGqhjUaectnK8WyGTzugEpc7Wat3y09LiYETnGG/mfdJDzmoMv36rYabNjRubyuOwq2dvU0dYO4mPfYa0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800602; c=relaxed/simple;
	bh=a5xPdx3jXMIi7dIC3fqaFYnfIes+xJu61vL48T1pH/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHKKKOFTv+3m+4H1HiNpC7/fYAMlTuK77Gmichs/wgX8pXNlkWQNI01ClNGBAzv7yso6EwE9H1oc6Uxkw4s7ALX6IRp1Rh43m+SeEbp1IdppoEBv36aW2V4yuJajaeMon091EhABxfPDYA0JQMS53g6WHtokprUm46CH6F2rfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwLyz8Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE7C4CEF0;
	Thu, 25 Sep 2025 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758800601;
	bh=a5xPdx3jXMIi7dIC3fqaFYnfIes+xJu61vL48T1pH/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwLyz8IlT5sZGXEfJ/5PvIGhwv/edRsDGhxjaHVApRZYgaus6H+zHMQu05x5KWImR
	 0fkYan4uSt5mgDwUeMS+KjzAaT3zrI4h/PHpa+ymSo78E0yTLStROaDkN5yje9aWnz
	 PjmTYha7XF8hy8lXZcZDTWYVMSfrrAM5jOxAp/fag9bvV7GLdHr7IGMrKnKqnDO5SU
	 igACWAO0G57a07/JC55DmJcPNv6rS3Z9/wOTQ6wrSBO5naJgml7Y/cklDOtd2qx7f4
	 iJmb4bK44skn+5uduXQRbXvUydi+xCWm8e0uPGZBz6N5xNjyRhVYhHdOnPhRL7ADFs
	 fPRk3RcBf8Xaw==
Date: Thu, 25 Sep 2025 13:43:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Randolph Sapp <rs@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andrew Davis <afd@ti.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
Message-ID: <20250925-elephant-of-absolute-prowess-a97fcd@penduick>
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org>
 <7hv7lhp0e8.fsf@baylibre.com>
 <DD1IXJDTBQ72.2XIEIIN0YA713@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xje5644bvvj2aacm"
Content-Disposition: inline
In-Reply-To: <DD1IXJDTBQ72.2XIEIIN0YA713@ti.com>


--xje5644bvvj2aacm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
MIME-Version: 1.0

On Wed, Sep 24, 2025 at 09:26:17PM -0500, Randolph Sapp wrote:
> On Wed Sep 17, 2025 at 10:24 AM CDT, Kevin Hilman wrote:
> > Michael Walle <mwalle@kernel.org> writes:
> >
> >> The TISCI firmware will return 0 if the clock or consumer is not
> >> enabled although there is a stored value in the firmware. IOW a call to
> >> set rate will work but at get rate will always return 0 if the clock is
> >> disabled.
> >> The clk framework will try to cache the clock rate when it's requested
> >> by a consumer. If the clock or consumer is not enabled at that point,
> >> the cached value is 0, which is wrong.
> >
> > Hmm, it also seems wrong to me that the clock framework would cache a
> > clock rate when it's disabled.  On platforms with clocks that may have
> > shared management (eg. TISCI or other platforms using SCMI) it's
> > entirely possible that when Linux has disabled a clock, some other
> > entity may have changed it.
> >
> > Could another solution here be to have the clk framework only cache when
> > clocks are enabled?
>=20
> So I looked into that. There are still about 34 clock operations that are
> functionally uncached, but it does seem more logical than treating everyt=
hing as
> uncached.
>=20
> Side note, why would someone even want to read the rate of an unprepared =
clock?
> I dumped some debug info for all the clocks tripping this new uncached pa=
th.
> Seems weird that it's even happening this often. Even weirder that it's
> apparently happening 3 times to cpu0's core clock on the board I'm curren=
tly
> testing.

The short, unsatisfying, answer is that the API explicitly allowed it so fa=
r.

It's also somewhat natural when you have a functional rate to set it up
before enabling it and the logic driven by it so that you would avoid a
rate change, or something like a cycle where you would enable, shut
down, reparent, enable the clock again.

In such a case, we would either need the cache, or to read the rate, to
know if we have to change the clock rate in the first place.

Maxime

--xje5644bvvj2aacm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNUq1QAKCRAnX84Zoj2+
dlS+AYDYcgVjmnkP3YmpKQblVoojlCq6+KQGaNg5XQixrO1I2MsBBcvKjFbkL9Fx
/JpQrIYBgJTaiR/ihBAVpD80IqL5X6pNQAla0FGkzvuPA23E+shl4FQ7aGaa1SQf
KklmoGMEWw==
=HGWr
-----END PGP SIGNATURE-----

--xje5644bvvj2aacm--

