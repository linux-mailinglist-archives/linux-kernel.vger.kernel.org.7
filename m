Return-Path: <linux-kernel+bounces-750597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAEB15E79
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB42173228
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD4236435;
	Wed, 30 Jul 2025 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE91/pre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF418C928;
	Wed, 30 Jul 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872524; cv=none; b=nKC5GEqHKspuMZqbOvBIuIm2Ks6s5PPk0YSo5bfX7iwU1sL+G8yYDgU2SfGdfNeuWeSIXG1CP/uKZyFvgZ5+yptNzgxqOCy+DbyvczW/eQx9VN4U0iDQep0FqE5ug2D+sv6ZgBfC0Kr7mswoljNX/lXoskUPkNoySiUzjeKzYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872524; c=relaxed/simple;
	bh=FwwIBzVLKrN7X/OD68/2tT4gL5lrrwNTMy8C5g55L3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjexVePHNylB3BPA35ucwnUQL+H5riCqVm+gdWcn/BBSqcqGOQc/+w1eCYZJhnKMQxSdHuisTf0qteUk6zlKgRZPgb0db39YpFcGKmQZr0Z0HDY81SEnux2zI7b5dJNeOym4TDAZn2wr1eIrCnoynLNGtXz5Yxm7F/QFwN1q4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE91/pre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8B5C4CEE7;
	Wed, 30 Jul 2025 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753872522;
	bh=FwwIBzVLKrN7X/OD68/2tT4gL5lrrwNTMy8C5g55L3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE91/pre5fubNfPuOxM9GkqL55jdYcn9ZxeEKmZPi6GgLwM6f05z/9pN6zsbRb061
	 DdDfjHg4NIdXCM6/S4NE2rFsIF9/JiT8eCiz08VGeLYqmaUlI3cEs1UtaV6/Vucb1c
	 CfbabyZwdbuQ6np8tKynHndPVslHQZ7uhey6VwmDiRTxy7Fia3MR/gUe4izFmwmfNJ
	 ws+Vtoqssbi/Ewvn7Yb7S15IeSK3IThc/6TPCOx1/sozntix4nLnKp3QVGac+c+7tJ
	 g/dQXRna+k40Qyv5wYvoigqSEMy/VE02oACruWf54+gRR45twTkTza1bB7Gu9xdDe9
	 bzlclDqbZaQDw==
Date: Wed, 30 Jul 2025 11:48:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	13916275206@139.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: tas2781: Normalize the volume kcontrol name
Message-ID: <05fa81c8-2125-4275-8501-8d7790f0b68b@sirena.org.uk>
References: <20250730053236.57643-1-baojun.xu@ti.com>
 <e36cd0bf-fe0f-4edc-841c-83f688a5e75f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twMYDlwnHUKAd+cL"
Content-Disposition: inline
In-Reply-To: <e36cd0bf-fe0f-4edc-841c-83f688a5e75f@sirena.org.uk>
X-Cookie: Linux is obsolete


--twMYDlwnHUKAd+cL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:17:49AM +0100, Mark Brown wrote:
> On Wed, Jul 30, 2025 at 01:32:36PM +0800, Baojun Xu wrote:
> > As more devices become supported, add "tas2781" as a suffix before the
> > TLV name, correct the DVC step, and normalize the volume kcontrol name.
>=20
> I'll apply this but this really should be several different commits, the
> variable renaming and the user visible renaming should at least be
> separate commits.

Sorry, actually no - there's also HDA changes mixed in here which should
be a separate commit as well.  Please split this up into separate
changes.

--twMYDlwnHUKAd+cL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiJ+IUACgkQJNaLcl1U
h9Axrgf/ekHxn5G90nadHECYU5gsVUPd+Cfy+Zzzizk0ZeeHZGcDLuw7x914Q+Ek
fF3Bp2mOffP4YtPhgqLaVaQ7IkOxxDWyhvEW3b/KxuE88UnNPwVYXoIBZrn1lfOE
ujy5wBl3hngasqGVSlqyF6iD3ur74ykzqsYz5jzifeyI16DAKi5+TNFHsjSjbCbl
muo4HtGjQk/1ftmArb3gbJVvacYr3lC38Bd/pSxZCyOtUL+jVWxJgxQEhKPuyV8c
YRPBvl6/8BBXspyHxZtA8sLJ45DIGJIneCKfzosbi9TUk7F0HX7/t9IWXzLnHG+4
5W4u3KNhltBSBbhucAi61/8qfHmaiQ==
=Mab2
-----END PGP SIGNATURE-----

--twMYDlwnHUKAd+cL--

