Return-Path: <linux-kernel+bounces-837836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E7BAD5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E029F323D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B5305045;
	Tue, 30 Sep 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul+KVGHx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939561AB6F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244229; cv=none; b=IBuXNaT3ZN8ZGVrW3z96DMUgABVt9NAptUEDj7QoQ0apcBayXds6n5yPB1VjJXckA9rdpmuvp973EUHNhTdgtuUNnvwx8i9gjvquXFFmv2RmzqSF+yWTAvBoB4j34kHlkKteGR4XlKzHePDMLWd+pcpD80iD1FkOGKcAF7GgSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244229; c=relaxed/simple;
	bh=Cj7LWlzSdotdCX1r5dKPprmBxv8vvn8ZC0rt9RqpRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXPm6m+vj+iTlshVZXY6/D3mhGsN3BC1vu3UGJsalGP2wjm0wpmZErK/H5hWjE5+gaE81+lIgC+zuJ3p+9r5qIYQhuwNtIMeqgPCP2LaZFmqzMZVws/0dEo8GiIo3dhHoO6HXW2Yfkd8R02RZxVDsqqB0KDjg0VVT6WJQLbxFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul+KVGHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0DFC4CEF0;
	Tue, 30 Sep 2025 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759244229;
	bh=Cj7LWlzSdotdCX1r5dKPprmBxv8vvn8ZC0rt9RqpRb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ul+KVGHxPA1bZn2Yv1ctLRQ0/UA1eP8mteaGPsY1GAQRTfrKx3yG3cjxVSlOB7fBR
	 296gunuKMvoL1ztmTjtQN6+rRuqMroHXtrWPUx9pK7hehR/NkoHiN/t8Pm0g6toSJn
	 enjvgrJ+CcWnLLGCM8no5ZdM51zUrIs544utKE81rqZI0SudJ4kTD19KP4glOX8Ica
	 5wx6iMuE8Y8K5ZuEh7Q6BYz1Rbkd1JJhPgivFc33luEW8aMti/2PUuQmzDAfJ87tbk
	 nj41ON0+TwIEjfQsE2WLd1C6/lrS63mFI4Kh+c/C4QhnbZo5yUxFoT5VFC7mdohtVa
	 501IkTtB6h05w==
Date: Tue, 30 Sep 2025 15:57:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] regulator: forward undervoltage events downstream
Message-ID: <aNvvwcXW_zNdAVp5@finisterre.sirena.org.uk>
References: <20250930120857.2228296-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tF1zCDdEP252RsiI"
Content-Disposition: inline
In-Reply-To: <20250930120857.2228296-1-o.rempel@pengutronix.de>
X-Cookie: If in doubt, mumble.


--tF1zCDdEP252RsiI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 02:08:55PM +0200, Oleksij Rempel wrote:
> This short series lets critical supply events propagate to consumers.
> It introduces an opt-in helper in the core to forward
> REGULATOR_EVENT_UNDER_VOLTAGE from a regulator's supply to the
> consumer's notifier chain, and opts the fixed regulator in at probe.
>=20
> Only under-voltage is forwarded to avoid surprises. Behavior is
> unchanged unless a driver calls the helper. No DT/UAPI/ABI changes.

On the one hand I appreciate the caution.  On the other hand I'm
struggling to articulate the circumstances in which one would not wish
to forward events to downstream regulators.  Perhaps the option should
be opt out instead?

--tF1zCDdEP252RsiI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjb77oACgkQJNaLcl1U
h9Dqagf+J+Cjs7xlPbIB5aVw0Xjf0LsEQsyYTJrAqIL6QefF6GKpURLQkMzTsm6Q
oYkfLGJ+r6qCdlidYoOwfEoAfE+JCA4RoZfIyQL8o+SKpL5BNDhYTKKakY8gFRli
VSgLRxaG1Nn7LAK/2j1M5zQPqfPEgHn2WtnXhxdFMfyYnmf0NTAxkZOAYrhXs7DP
T9RQPkInEsoLq47q30U29Ta6A+uG9ELfxJwQTPWGmYxXi9HLKWN3S6eN9mqOyQSM
7qND0KVpAwn2OEiaHQOEOCt9rDYQlxyeHPSIMOTxGZ57qQV7+o1KU+vRe0tlM2ZV
y3IGjPNpNf+HOfxdRzsCLFGLMdm/xg==
=ncYU
-----END PGP SIGNATURE-----

--tF1zCDdEP252RsiI--

