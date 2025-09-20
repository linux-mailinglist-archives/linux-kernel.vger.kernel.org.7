Return-Path: <linux-kernel+bounces-825920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FDB8D1C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E027A3930
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE6285419;
	Sat, 20 Sep 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2f5208K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB225FA0E;
	Sat, 20 Sep 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758406744; cv=none; b=jRDhGLMTVyqeRksYoug1fG83OqV35k0HMEXKzuVMewptMhFuNwR7jy+LvBySUKbvkbVe3l2fVSW4/pGymRERD0lQ8MCUUnmexCXjapoJ1FUT5QB2LGXW1WJZvxKewaf/brpnef8YwnTATsoM7nWDxe7DHIFIKtcNmAVZba/nw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758406744; c=relaxed/simple;
	bh=PYEiTDY2LygoEjRa/YiGz+dOFnGCROKWezbUQTxc5PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YycpECHjv9UdxIb3duJQoTjUW6k7Rv4KZduNgfBq9p2xCjHdgITRgmqjlD6y8hXXEwSjq0wTlBPuR5DDB6WuTPjSknRjfzrVyQx0AiymiVrJ4OIeS+DYV93/iEHupGo5nzhqSZU/O3ahD2OBMhHaLp1gl5Wo4rnpadiDB7T6goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2f5208K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12846C4CEEB;
	Sat, 20 Sep 2025 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758406743;
	bh=PYEiTDY2LygoEjRa/YiGz+dOFnGCROKWezbUQTxc5PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2f5208K/ZH542Kfy41JJak/vQG40hn37Cd3qB99tgCWHiwmvND4sMlGYCtBcEwSS
	 IADU1HA4dM7TtVZNwvZS0LzGNn/AogPuGojYL+1rtVYO9fNoXzpaHvAnT3S+gqjEF7
	 8BWJMO97jGB/b/sjuwck5dS2a9L5Ax3tu0Lj4THMLHQji5oBH6olIEnO/L9iKjEyTw
	 ZAMvBjcwFbl1psBQDwuVEzLo0ztcpbGSBG6tFXPnFiAVX5m2I8BwylVgG0GmTHiTG7
	 G93x/dugBzSJRbcYbC5TbgNiMn82HZQ8TVGVyBM5CHRNGpaMPC/NcE/Y5In5FPy5jf
	 yguz0YQNNv+fg==
Date: Sat, 20 Sep 2025 23:18:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
 <20250920114311.291450-2-andreas@kemnade.info>
 <79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
 <20250920233307.0c425863@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajcYnS13mjOHFFvE"
Content-Disposition: inline
In-Reply-To: <20250920233307.0c425863@kemnade.info>
X-Cookie: BARBARA STANWYCK makes me nervous!!


--ajcYnS13mjOHFFvE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 11:33:07PM +0200, Andreas Kemnade wrote:

> Just for learning, yes, it is an abuse of the _optional for non-optional
> things, so a dirty hack which should not go in, therefore RFC. But what
> happens more than having the hwmon device endlessly deferred at worst?

There's also the fact that this API is so frequently abused for bad and
broken reasons that I regularly audit users and try to fix them, I'd
rather not see any new users that don't have a really strong reason to
use it.

> The wanted regulator is the one defined in sy7636a-regulator.c. So it
> is all an issue internal to the sy7636a.

> Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
> I see several other solutions:
> a) call device_is_bound() on every other children of dev->parent, if not
> bound defer.
> b) do not care about the regulator api at all, just check whether
>    the corresponding bit is set before reading temperature, return
>    -ENODATA if not, some mutex is probably needed.
> c) do not care about the regulator api at all, just set the
>    corresponding bit (together with some mutex locking and counting).

I assume this is using the regulator API because someone might use an
external regulator in a system design for some reason (better quality,
power efficiency or a shared reference between multiple devices I
guess?), or because the supply might also be used by external devices?

> d) copy the of_node pointer from the parent, add a regulator phandle prop=
erty
>    to the node pointing to the regulator in the node itself.
>    That sounds like your idea but is against the current dt binding for
>    this device and afaik it is uncommon to have mfd-internal things wired
>    up this way
>=20
> e) something clean, simple I miss

The idea is that the relationship between the devices should be
registered before the devices, that's how the regulator knows to defer.
We used to have an API for doing this for board files which might fit
here, but it got removed since nobody wants board files any more.  If
you're allocating the devices dynamically that's annoying to implement
though...

--ajcYnS13mjOHFFvE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjPKFIACgkQJNaLcl1U
h9BGQwf+OvNNj/wSlGObv8QCJrJ3kxiM1MiiJ08UTjK+cfC7BpPHljGpWPAzrYGW
SEMvcGn+Sfxkcdd7E6JJGiWTfjcFTT5uR18pUCn0IVyWLkymHZeY5MaKxH8Sl4Su
jAnGrpOsi+HP+6JIMUnDhjUOWzDlbuSSQJiuj8OzCK4oFagNo9eu0DLa3b2qKFA+
NxSSLo1GbLgYwtPKB5uo2D5Cf0/XiiI6aTc8F+iHIqSB+KhZluk4ATKh6AxYceOj
C1fTKBujeSXOE3/3B4RIA/2JCl/8oLbB4z666C/Cgeyd2VzRcrdVWbzsoa9nslRq
Hyls0rO9mJjmfxBPUWehHuWw7+wlGQ==
=Vg24
-----END PGP SIGNATURE-----

--ajcYnS13mjOHFFvE--

