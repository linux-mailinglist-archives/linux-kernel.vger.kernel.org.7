Return-Path: <linux-kernel+bounces-854255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD251BDDED4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F684FC44B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106CC31B124;
	Wed, 15 Oct 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcBQCcQy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3C31B822;
	Wed, 15 Oct 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523086; cv=none; b=hGH2R2O//CFuirSFmWudW5/w+QRDJ/pdhcxxFFym7qNVPQiUbn4tBLUKOo9bUf2iUOLe7n8DSXNswiLd5ea9s9bUfs7Vpcozv5q7UCtx7biMIAXFm0FYwxzxPs+6VvXNMth3x0bmsDQ97GBEoAtxHKuDBxgpOxICLPhpXYjomuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523086; c=relaxed/simple;
	bh=Yy5htcdfTD+mS/WBgONrZayAHPRAHtkzj2kjwQZm468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owwILOWoBCxV9+3HX68CCbdOD1TpHmr0debg7pLabZihsSz31G2weGmZoIjWYQDMxCDPkiRsi4+dQa3bcQlyqLVLkSvfRHz5rgC+AujCzc8Qh5yhBD+rIYeDgDq93OQ9A7i5FG83z907VyXwz5gQuHLbJweeCkY2jCor0pVx2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcBQCcQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F16C4CEF8;
	Wed, 15 Oct 2025 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760523086;
	bh=Yy5htcdfTD+mS/WBgONrZayAHPRAHtkzj2kjwQZm468=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcBQCcQyOygYEGPam2TdEVUkXAB+tcdkbWgbhg8FLvmPiPM+nKKgNfkzch3locAA4
	 xKTIaJr7s0dg4/g6RNBnRiJ6S60DgzRAXWef0QcMcEvKhocXPlN8blArNEIHH7SpiJ
	 44WWcQdMFem/YWDou7U/7OzvdI5ZWZiWaNwB70tDacDZCEXDncXlfCGMtwQfeNyHt8
	 HbgUmok35thjBJXU80nu4YrdzTHZal1FXBOlJgue2CrvagmLL2mOhOavDOJkx6z3vv
	 94jJE1RL0/cxwe/Mi+IznaQdqOhgPiZu1wCkYkh/MaMXnlN0SJCh0U2Bv+t94RaKxV
	 KKuZmqzvrgCuQ==
Date: Wed, 15 Oct 2025 11:11:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 2/8] ASoC: cs530x: Tidy up driver before adding more
 features
Message-ID: <c23cb79a-4883-46db-a1b0-44c4347e85bb@sirena.org.uk>
References: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
 <20251015092619.52952-3-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mTKDM2rWrdexI8bu"
Content-Disposition: inline
In-Reply-To: <20251015092619.52952-3-vitalyr@opensource.cirrus.com>
X-Cookie: Long life is in store for you.


--mTKDM2rWrdexI8bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:26:05AM +0100, Vitaly Rodionov wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> The copyright headers, #include sorting, whitespace, remove unused
> structure members, constants and constant naming (Update CLK_CFG_1
> definitions to follow similar naming convention to other frequencies)

As covered in submitting-patches.rst please don't mix unrelated changes
into a single commit, this makes it much harder to review the patch.
Each element in your list should be a separate change.

--mTKDM2rWrdexI8bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjvc0gACgkQJNaLcl1U
h9CK5gf+P9LN2OTKEgS5zLT5m7IXGjTnMh5LKrOIUhZ4euYq7xqXBWIa4Gmmz+RV
UDQqbn77whZU4VBmAMM1qpJ/jnBcVkWxmPhSy0QKZjfyPyZPjfeGGo+Itlatz+uC
nazyHr1R8V1Pup7S1yZnzz3XEDeCk8NQOLIO4ON4l+a6wH4wJZsMOcJ1uC1hFzXb
vKoB+4cwuwVzCrF3qf13E9GII7ZtexiHlMLcZIf95IqQMlCpnUCB/7a8hFIXlGYe
L+BPmwFzcI9sbYJQrZ3uxLTxW5mCD5ivS/ojRlGaZC5Dtq23pinlGDgExF48oMia
BlkD8DbVm/3Ds5Tkprs/FlJaOyZFfQ==
=HsZJ
-----END PGP SIGNATURE-----

--mTKDM2rWrdexI8bu--

