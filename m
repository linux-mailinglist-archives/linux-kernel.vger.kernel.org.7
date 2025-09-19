Return-Path: <linux-kernel+bounces-824573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A589B8991C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0095A34EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F26224220;
	Fri, 19 Sep 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/e3udmL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2A14A60C;
	Fri, 19 Sep 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286978; cv=none; b=Y5Oo6ehA5qBAwlJEbDKJ2z7Gs36a4Rjy9TYgjGbX5Mz2pogMU2pFZjk/NdH7W6HKD+o7pufSKle7d+xhnmhIGYJJpUuKCxMMvJq7LACUdJ0TdLWgNyeMbhohZ0GPhZhgt8qyYgTFeK6ovYg5MLVWW64MB5qiXtBcO1gvtq5A214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286978; c=relaxed/simple;
	bh=ibYmE2c5M3NgxmUOwRdDFk5cC2rztRoRsEoywjcKAMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFn/I/OfBnKgyIIu9Cf9/Yej4WZ01ky92lpHGSYKw0kbSPb4SoApVBfa2UEPB+kuvLyCOXc5VE12IrUMejsq8R+V2pQVTCSSDpr7JQoCQ6p+zzYA++N4U63bMhmRePHluPtf85H60V58ooOnLqt93cbGAveJmIH+a7VgC5qezHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/e3udmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEEDC4CEF0;
	Fri, 19 Sep 2025 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758286977;
	bh=ibYmE2c5M3NgxmUOwRdDFk5cC2rztRoRsEoywjcKAMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/e3udmLj860i+05ckqO8nQvBT79iD52i+tZNxoFDRrsFNkGLSi5Gv33SC+M1pXe3
	 cq3Cl8UFAFviE4KDMbF2gjWY0arWyXk4Jww1eJNKGK8bHQ7yTT9eDtajeG3tz9saqL
	 JjZtgMZExYZ2AqWRaVMAcOkK8Fr1IdO2dPuZOIVizFvHC5jX2hp8sXG4FmWhyZXvGQ
	 qr4g4gKjynLjoMZpjo/sLfoCDO7HC4T/BZXYkK12BsHVE+E6js2QC+4cR56F4zxcDR
	 yikESUKUNJfhY/qJLQDCzuvniHkRuUC5f80UZjuyo7NYVjiyqkbopMkI4GAUM+EVmq
	 k3csGPdgauMLA==
Date: Fri, 19 Sep 2025 14:02:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [RFC PATCH 4/5] mfd: axp20x: Support tri-phase setup
Message-ID: <024aab2f-6ede-4fc8-ac13-195a8038c365@sirena.org.uk>
References: <20250919000020.16969-1-andre.przywara@arm.com>
 <20250919000020.16969-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QEwzfm6fqE7756VS"
Content-Disposition: inline
In-Reply-To: <20250919000020.16969-5-andre.przywara@arm.com>
X-Cookie: Don't read everything you believe.


--QEwzfm6fqE7756VS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2025 at 01:00:19AM +0100, Andre Przywara wrote:
> Of the PMICs that support multi-phased regulators, all but one just
> support a dual-phase setup, with exactly two regulators tied together.
> This allows for a simple data model, since just two is somewhat of a
> special case.

Oh, and:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--QEwzfm6fqE7756VS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjNVHoACgkQJNaLcl1U
h9BKiAf/Wfi4z0/1wQlJeEAkzU+AA3Az2DHqSd/9A2+/XEzSHToQ06Xl1pyTQuwW
2CQ0DXfwYG0hTC8JpVdj/bibLHQxj2pgHTJPDeg4nNzwEiP1xj+imFfpOTYI0Hhe
oWcJ+tKBBqQbMaOXESqZF9Qt2J3wpB5F7XivX03+jCPL8/nQxGkZB3SiwiHrxrjy
vsRWdMjKDpNvvNHRYnzfFCX6gY8rtajCLjzoEpAUVzX/b0HIzw2OnXr5E44qsjSa
uiyIibxcGqPjhLqmDuFs7g5BzBNEuKVDFcTsSwd2kVBDA39CO7SxbEkiXCVpcKRG
A5cJCrY0PNQfgc50w9aOgorckZemmw==
=ugUS
-----END PGP SIGNATURE-----

--QEwzfm6fqE7756VS--

