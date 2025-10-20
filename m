Return-Path: <linux-kernel+bounces-861415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC6BF2AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B264F5B48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D1E32ED3E;
	Mon, 20 Oct 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl5LTmHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2FC8FE;
	Mon, 20 Oct 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980692; cv=none; b=ExFXWEv85bGihZDor/VFoeUjKKJdVn+lipO1zuYDgWMId4R6oB2JhImsFmNMKhjfrKWtYL9tW88eRmzBUsdkGxJEmlfSS4z3oO3lQbYBzLRJheQSfQZsLTHvyil0gLqyH/ub+5diY4gsehLHnHHvOsd14rN4fXT433KUFwANodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980692; c=relaxed/simple;
	bh=XiFkPjpbRb4EvxWHzM2pnBZEEJZd3/pqX3IeZ6qKzeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lriG+nrcq2lRnWNLUKBANgl6as0cWpt880d9UiWtD6V2WMccDkVLk9hGRr2xbmy2lXNvQrso3kCWm84sIx6t7Uj41x3kkJ4bz3BzUoupZbaC+cvXNx//09zybGLLG5AS1CdyitR7CNtpsijlxfd3KQ2rjBbjXb8cw1GXkfdhJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl5LTmHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8D5C4CEFE;
	Mon, 20 Oct 2025 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980692;
	bh=XiFkPjpbRb4EvxWHzM2pnBZEEJZd3/pqX3IeZ6qKzeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gl5LTmHInpyxPFKLcyUsCYaiT0yTRN+G+x1IBw6hObRVmPn3hR8ZI3mddOUsa0MJ/
	 EfkhMjLRk5dPlCKaI0mJY/QoaOEk3/c2zrzBr9KjPzJPZjuF/FdI7BZNGlDoFVhgvq
	 2xQ3RNEUwc9Pc8MduggMdUO+Nc/eNn0zPPq9NLDAJmlyqdJKIkrSaE1R94vVCmWc/1
	 iP/xoUTk1geJluzVdSqbzIPIiNKFv+XqmdPTj3HJ1Qc2NAUgj3k4mMuHaIvTWAIxpu
	 GnV1nSGyD9I8cvJvmuKmESSfhFBw8hjlNYBB2Yuk6AR1PL6JSp5Q4lAY2y/d+lVKiy
	 0TPW3GLwSPQxw==
Date: Mon, 20 Oct 2025 18:18:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/15] dt-bindings: mtd: sunxi: Add H616 compatible
Message-ID: <20251020-caring-aftermath-32ed83db9a7a@spud>
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
 <20251020101311.256819-15-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ugH87F6woIwS5I8f"
Content-Disposition: inline
In-Reply-To: <20251020101311.256819-15-richard.genoud@bootlin.com>


--ugH87F6woIwS5I8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ugH87F6woIwS5I8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZuzgAKCRB4tDGHoIJi
0mWmAQCXkfmlRLPpkpogtOPLDai3zd1cQMUD4dehkb1qSH2wTwD/TyAWdD6k93SK
AeF6ryJefcHUqunzW+LtLTOwecmIFQQ=
=YaUV
-----END PGP SIGNATURE-----

--ugH87F6woIwS5I8f--

