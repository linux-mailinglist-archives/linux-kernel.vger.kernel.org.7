Return-Path: <linux-kernel+bounces-885198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2CC323EA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02199189785D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC733DEFE;
	Tue,  4 Nov 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCgvNONq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870833DEEE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275922; cv=none; b=ZsUaPvlGo9EcewCljfvj8LvY79xpL4BoovvteHnqecFjyHtHpWcv4/ZZ5DqU8OxlPSx/K2TrUwJNS4sSwRmW/pwXllke1V/+gEkOTe8/LlW2Atfcfe63nPJxlisf0ZR8m1gQsDBzHLCqXDD9msKRKcrQCT5KJdZbNUiH2fEOszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275922; c=relaxed/simple;
	bh=xwxNr9aVkBoYs5zNtejrYK0/J2uDnxnG41xmYHfWElI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtwT9HVDRpKprvF+OPLtWZKiz2Udjpu8wTD1UwpmxoBq7fl9NTT2kIeAXR0Lt18Ouwp9TxlwcXD77Imn2nI7HtrIkLrysjsznF1+Zm47Hhj9RzhZh45Vdg11DpU9gdMMnbSiexmn4XMnCWS41Rja7oHKw/VV+brnQprwAyjUW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCgvNONq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81501C4CEF8;
	Tue,  4 Nov 2025 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762275921;
	bh=xwxNr9aVkBoYs5zNtejrYK0/J2uDnxnG41xmYHfWElI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCgvNONqQBlMqJCXPR2tox3Dn7SZiS0Swnzivx8B8aU3AXjx+Hu/fTs/VWza6nGJc
	 XGNew/PsQade68NV9DGevafb5cS+TXkSYr4l/vACqI3d0Kb2pXsApT8NciUIOVpg3y
	 vT3Jh76ILUt4MRssCTdBv1f6SmcXlqUc7h08ca4BuUsR46o9kdhoJCXqnIMGWyd5gE
	 XDd+I4twJirxzThkhM2h9xy3OAyixBocP+z97eiS42UfdWOG6HUFOs9mzreJxBI4aD
	 EGdOzBbrWPuQ1FaLlBe9PMebmyoo98EroJC00peZFJ5p/67VCm5OY+sZA65/Bn/nUA
	 v0g9ySzwt3hcw==
Date: Tue, 4 Nov 2025 17:05:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQoyT4Com8t6zE5U@finisterre.sirena.org.uk>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
 <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
 <aQov22j_S8LRzIdm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1IP2M0C+d5IJHuO7"
Content-Disposition: inline
In-Reply-To: <aQov22j_S8LRzIdm@smile.fi.intel.com>
X-Cookie: If in doubt, mumble.


--1IP2M0C+d5IJHuO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2025 at 06:54:51PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 04:30:54PM +0000, Mark Brown wrote:

> > That is the full list of commits in the for-6.19 that do not already
> > appear in mainline.

> Yes, because this merge brings also rc3-rc4 bump:

Yes, it does.

--1IP2M0C+d5IJHuO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKMk4ACgkQJNaLcl1U
h9BGOQf7BCzKutMvEWo+SNC8O/r2PhgDePaNaefzP5H2IMVd+u5GwPEiV8TDuMk8
3Cm+tCvXN8Hb3nd5O8hv/z3aYlNUBLwbNMt5cjgCpijRs86OU/UvyNZxNQghQM5/
IOsVXcg4SzNjfjG7+/95Ywc9phekXUFkRzYlkTfIFSy3F6x60Ad4JPYd551+OxA1
ok5zkg/zzFMc9R7aIbe3Zt2xcnMZb01D65OESt9rKVNExrjIljGMYnq3xTYMLTB8
0PMIlAALI0uA7Oi/qkFx4a92xksL0sIQNuYUKHzQzgDtT/ezvAsqwXI9EVWjP3xC
epJXuPIEN2CKmTQ4bY+AiJ25g39Bog==
=V2Ez
-----END PGP SIGNATURE-----

--1IP2M0C+d5IJHuO7--

