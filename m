Return-Path: <linux-kernel+bounces-865628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731EBFDA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C8A3A90EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF526E703;
	Wed, 22 Oct 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtmSF+Ob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D22D540D;
	Wed, 22 Oct 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154744; cv=none; b=qyT1Usttm43JAEArFWBAu3Su62cS8z05nfoxLBPAEHFvb+DDc7YqNRV2E+ThlUKmZNByrG7BU97GgHXZWT87Tk68HUHAvIXd+WS6QnAVVB36BH0nqDBM58A+mY+hOf1sk79a3b4JoyJFG3xe8sAI7CfL+yAg7XC/v0XldCdW9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154744; c=relaxed/simple;
	bh=5ufcd2XFtZqf7AMXlnvjyGcs49YRZ4UBHGJV3PCi3YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJv3Qw8jYyzKw+yeWcjqxVQg9I7QVRM8ZQxLfxP6bic3zdG5AdVng5EIjYYHqsXpQo451U9zmkEcuJCzO0yqENWBIeHc/INolVAuuEvuJCZCVFbUhNBfQpd7uR2XV1XEhK++nOc5K2xDTKZQYoLyTv4rHe2KgrAVgsJjd4MAssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtmSF+Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB28C4CEE7;
	Wed, 22 Oct 2025 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154742;
	bh=5ufcd2XFtZqf7AMXlnvjyGcs49YRZ4UBHGJV3PCi3YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtmSF+ObqbjyTc8tPaU3QnvRIVqcJvH0xcum7MwpWTI64LXWChY9ih7+2AOv85fUW
	 o1RwpeIPFgIOP0dF3R5an0FKCsJPZfcSQ2ypW2sm49fkS8NN2TG73ANaals0kxMEpi
	 24K3o29bA+SrcbO/JpembcPVSXpYHv4nzxUjjH3MUUuOqcVlFLpkyzTTq5u845QJsU
	 p7ChHVYsGsfAffbAOzb/9Vr2bC6cDzHX0h/X2jr/1lMOC8vEFMxHqXs1nFgRdL6VvG
	 ekfZQkV7L8Xx/v0ku6ymSz2yjzTciUDq+8bp0TIw8cBdEGeC/3mSi8Gz2UCn0YITxd
	 YMFRZM3vSmQ2A==
Date: Wed, 22 Oct 2025 18:38:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: x-powers,axp152: Document AXP318W
Message-ID: <20251022-banish-synopsis-9d6a4246cbf6@spud>
References: <20251021112013.2710903-1-andre.przywara@arm.com>
 <20251021112013.2710903-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aoExz7rlvJNu+SsF"
Content-Disposition: inline
In-Reply-To: <20251021112013.2710903-2-andre.przywara@arm.com>


--aoExz7rlvJNu+SsF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:20:10PM +0100, Andre Przywara wrote:
> The X-Powers AXP318W is a PMIC used on some newer Allwinner devices.
> Among a large number of both DCDC and LDO regulators it features the usual
> ADC/IRQ/power key parts.
> Like other recent PMICs, it lacks the DC/DC converter PWM frequency contr=
ol
> register, that rate is fixed here (1.5MHz on DCDC1, 3 MHz on the others).
>=20
> Add the new compatible string, and add that to the list of PMICs without
> the PWM frequency property.
> Also add more input supply properties, for the split DCDC and ALDO
> supplies.
> The PMIC features *two* switched outputs, hanging of DCDC1, and the
> manual calls them swout1 and swout2, so follow suit here and add those
> names to the pattern for matching the node names.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aoExz7rlvJNu+SsF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkWsQAKCRB4tDGHoIJi
0hgnAQC9rHIOh4RCOGU7WXT8nZI8Nq6Q8RIMk8ji5PyOlInHswEA5FCGgke8b1gy
9PHv971+yN1Hr0+8LcrYj3AH6vt+xAQ=
=VO+b
-----END PGP SIGNATURE-----

--aoExz7rlvJNu+SsF--

