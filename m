Return-Path: <linux-kernel+bounces-852577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A256ABD95C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30139546FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80352FDC53;
	Tue, 14 Oct 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRx3vTWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B4307ACC;
	Tue, 14 Oct 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445317; cv=none; b=Kx1HoCnpFfWxejvwCF5oHIGtc/6LcNir7y9d/OSfHCFR5A8ThVpDHuYsSoizyjG4AHlcpyxOFQAYA9fLVfPm/VAV0ElbjT2mycBWdSsFfmQHdOneaJdHbDRhd4ItTTL7X+XKg5GOJ6ofPgw0wsL2rM/hX4EhmdYxkuSoY8YdvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445317; c=relaxed/simple;
	bh=OglqYXM5gyVnfpoYuVb+zV5hz/W1Vl9+ARMyr+0WbGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiEUYp4SG2Bma8R9iJz1sQIUihsuuEZwWJJ5OVNrP3zHM0upFkEH+z3BEL8G81aOgklzsA1hxftbRXu9jZJDHhByTDkO9exRXwmWyHvw6kZSLpVnDvU1ODPLdyiNdRUklZGsS3/WjF1XRpKVYpuo6b9ezKOG04obSpm7l7MZPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRx3vTWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4438C113D0;
	Tue, 14 Oct 2025 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760445316;
	bh=OglqYXM5gyVnfpoYuVb+zV5hz/W1Vl9+ARMyr+0WbGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRx3vTWNBxv6d5kpQ7a+9oj+0o7lHIZ2qIzdRfQ4B2vbByNg7J2Xi4OJZclAzcVx/
	 J2IAggSjs7wYlXqSaBYxSeXHuoggrkJ2HG9zsOPnMCDszeLhfMObE2hVGHfLKe61NT
	 CIjZ6/syIKWmkLcpNm9nzmEfA/dQLuG4tCxL7a51qDcfatjBY04jtHBEB5LYUNzjFx
	 X0VPhvtIYqTduRfMP/SEIdwcGumSF9YR0Js1EqDprBGu73IXGirDu2ibMC7/BqxmGA
	 T7nx8YAxgFor4ii99Cm9S2/sxeOKgJeyR6ZnKTgfuibcBoTPmsRDX3DHvLDVVtnSzv
	 Kp38JB9W+LMdA==
Date: Tue, 14 Oct 2025 13:35:11 +0100
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v8 4/9] regulator: Add support for MediaTek MT6363 SPMI
 PMIC Regulators
Message-ID: <bcf1004d-802a-4b48-9aab-0a4e39274037@sirena.org.uk>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-5-angelogioacchino.delregno@collabora.com>
 <5635636.31r3eYUQgx@workhorse>
 <ac809179-7192-4218-8b13-86b9252652f4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wn5Uvbbd3mnsI5Zl"
Content-Disposition: inline
In-Reply-To: <ac809179-7192-4218-8b13-86b9252652f4@collabora.com>
X-Cookie: Go 'way!  You're bothering me!


--Wn5Uvbbd3mnsI5Zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2025 at 01:35:37PM +0200, AngeloGioacchino Del Regno wrote:
> Il 09/10/25 16:41, Nicolas Frattaroli ha scritto:

> > Just initialise ret to 0 at the start of the function scope when
> > you declare it. You've already missed an uninitialised use once,
> > and playing these branch games is just asking for more trouble
> > in the future. There's no micro-optimisation you're doing here,
> > clang produces the same assembly for both zero initialised and
> > the else branch version you're doing here.

> It's not about micro-optimization. Double initialization is a bad coding practice.

Yes, if you just set the value at the start of the function then the
compiler won't be able to tell if you messed up the logic somewhere
later.  Sure, the warning is gone but that also includes cases where the
compiler is telling you about an actual problem.

--Wn5Uvbbd3mnsI5Zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjuQ34ACgkQJNaLcl1U
h9C5jwf/XU13FSuJxf8T6RtyRPNXGOvljyrxJ6DklBvAU42vkhAKd19/Gv8HQSYJ
vBoncLDbmzjUzf0Eo8ciSWrShl2MjmlDmg72ZTQpebIO+DszBkL6A2Ikreff9HcL
0OhH91cshDMWzgd2R00tC8PDORmTljNrqWted4qwYIbUrbOpZK7kfmgtXa/f06md
fX+/uU6SJ2ojk0apfoLg/avXygk0WgcSyelVofWOrXOQFqv7WDjHDjRBnBqavlK6
O0lOjIoOYcuNylri623mMDDsAWlxDQjST8SYW2vzxW51oVgi4ctPxzgnnmBwi4vq
LegSnOySQBMW+QhVHbhCEQt3pYf86g==
=YAVv
-----END PGP SIGNATURE-----

--Wn5Uvbbd3mnsI5Zl--

