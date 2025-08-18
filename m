Return-Path: <linux-kernel+bounces-773526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD226B2A15E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6A656241B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC52319875;
	Mon, 18 Aug 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMlllXjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB427B320;
	Mon, 18 Aug 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519132; cv=none; b=mrwKEe8TH/LzepQk9xobwIoQxJEMHcsaxcAZvC0RzLiBQ23etnvFCXuGJOKG7f3dG4QaODBbIVlyaiu0tL4zdc5QSuIK3Ab8p3bQ7qMjP6GO82B2AGtQADkRhOQT+vFsMYJlm9CDvIRDTJYkRIl9hDO5jFm9N8ud5vFr5l/uksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519132; c=relaxed/simple;
	bh=pFQiRNiAx2KA64iJllDiUG0KBdl/BAjnjqPi21Hk2yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0ojvTKEDur/OGZbdrDS21iq2lSTOYHsJz4y60joHreR01pDXCj2P49r6MTfw8z6gzIlgiMR7Rau4xI/geyJKSZ9Ydx0svQNkh0S35IaMxvAkwNaBsZcpZKy5b9Eex9KFUgsOFMOW1RNBs2RsCs7eiT8ZLoaGNKQhL4Q6ooJX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMlllXjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7F0C4CEF1;
	Mon, 18 Aug 2025 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755519131;
	bh=pFQiRNiAx2KA64iJllDiUG0KBdl/BAjnjqPi21Hk2yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMlllXjV23P9OaT8bW9Iciyq0kyfpVL6LjY+QkGkL2leuSqZhf+aFWDIMhvpiTjgD
	 Md3NAn3piFo4BLPf4fKgmeawE0lcv8dboTgalyTXeNMYMQFhBXxl9xbahankS1mwkb
	 483Ye6vpVAlCcmUDTVcipZlHpgsgQy9xpT0Lvcncy6r9ZBkkpwXt9w3Yp+DialouVe
	 DB/WJmCl/CuuPQGrMxnXywC+8M0dJymdsZ5MqgCLrTeajKTYFTEGE8vfW1XPfVPijH
	 f2TR++t2Zh+yEM3+EFKHS4MfcLAxSVNl/loLlXRoJr6AzpeBAU5KAS2IkWYparuTnY
	 K9v6O2K+e5PsA==
Date: Mon, 18 Aug 2025 13:12:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Chang <jeff_chang@richtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] regulator: rt5133: Fix IS_ERR() vs NULL bug in
 rt5133_validate_vendor_info()
Message-ID: <50e34f5e-410e-4a5c-a1de-34becd9056da@sirena.org.uk>
References: <aJ7YivhlWlE6ifw1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WdoSpSVQ4oG3PH20"
Content-Disposition: inline
In-Reply-To: <aJ7YivhlWlE6ifw1@stanley.mountain>
X-Cookie: A grammarian's life is always in tense.


--WdoSpSVQ4oG3PH20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 09:49:46AM +0300, Dan Carpenter wrote:
> The "priv->cdata" pointer isn't an error pointer, it should be a NULL
> check instead.  Otherwise it leads to a NULL pointer dereference in the
> caller, rt5133_probe().

This doesn't apply against current code, please check and resend.

--WdoSpSVQ4oG3PH20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmijGJUACgkQJNaLcl1U
h9BF9wf8CvCQTwSqdYdU48v5WRHGGLUFLpF5CBk1kLP8ebNuOwY2kGnQL3ew6V5L
YByMNX5hjBvY3FKUGeP36qMr5A5aJyVe51rFYBiVtv5mtJfMElb5qJrpI4DnPpIw
YPwAwRbmbsL3mZQVuuOL7C5iRi5DJYJ5jnoVqC7HmEdcWuH3hnSB1SM48Q+fG+3N
EwbuTDCPHiZCy4pR2zh6sFSEqimXWOzbqNpXQ4nVbPZ3BYw6hxUyRTDMHZKumtIP
IqkRUFnm3w3x4IWcyiJa09lu71w6TPq1LnPFRqXXsXZArC4DdBbeJoeVqh060fXd
RkC6be0kmtNw+Qiu5FvWXby/xJSkeg==
=6yU2
-----END PGP SIGNATURE-----

--WdoSpSVQ4oG3PH20--

