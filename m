Return-Path: <linux-kernel+bounces-845962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B9BC694D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD444204A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E028C866;
	Wed,  8 Oct 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTI3vxgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B729BDB8;
	Wed,  8 Oct 2025 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955161; cv=none; b=ML5HaZJF68y7PC7bo4cLnPN5bppIR9QdiXDEo/OqojA4/jxkp0gmE+SKiwksZs50uAosZ7F/DDfxFybAOj9qBA7tKQBd6TBVwPRNZuVJa+/bWH6oKWOfpDq97MPcXVjTnzancnByuZjHYqVD+rfKYJbxVM2GOGYKL/6XSCSr6tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955161; c=relaxed/simple;
	bh=hv6w4mCWqZuIZyjeysqAvjnujkHopNnTLyjqzt74EfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFy8yYmZeOf7eVlmEcrX2AeQQiq6HB2o73BiWs3wWe+7RDCVNAfOmVomVgX1gQxInNONRr8dCZ3e3N4eyyqEVhVyKG4UkjzY9DYDd28Di+XLebyaicT3Xr8MrOQbXDHjL64fgAthOM2Nxi1b1Y9x/gEOeU30f0lxnyo3fe+YWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTI3vxgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2591C4CEE7;
	Wed,  8 Oct 2025 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759955161;
	bh=hv6w4mCWqZuIZyjeysqAvjnujkHopNnTLyjqzt74EfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTI3vxgFjse5VJnUOkLRQwbHFIQ7Cf7X6NbWYGWGblTuqwiMbtkbDLkSZxMegvr0Z
	 GCvbNjjbC+fAzr4Zr+9cgHn+O3I9/tsdrrtpzus79rCAAWHOISTRJJN7WDhZmSCsf5
	 u+o1sP9pRnFs1JHHHsvz8IyB/+nO/MFC9Lkv5sD9LAv9Ryzz2woP6+0GvHp1Mgik4J
	 A1BQCJeXMbh/0egtX2CMqRj+nLQKtX5i6YKiNnIZFS7TEnppWQZozMUFaZzc7kYpqc
	 sqNsS+1p9ANbJhQUzlnLPqpoteCUMENYREVR2pprQJWUhBZUjmidgG7Z5IWbI+qNuw
	 /p5DY58xrkQwA==
Date: Wed, 8 Oct 2025 21:25:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Sune Brian <briansune@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <200b17e5-9655-49c7-a4af-7adaf2838168@sirena.org.uk>
References: <20251008162719.1829-1-briansune@gmail.com>
 <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
 <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5eZqz2o//Vq7JSf"
Content-Disposition: inline
In-Reply-To: <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--u5eZqz2o//Vq7JSf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 09:18:18PM +0100, Charles Keepax wrote:

> There are generally two reasons to run a faster than needed BCLK:

> 1) Because you can't generate the actual BCLK.
> 2) Because you are TDMing multiple devices onto the bus. ie.
>    something else is using those extra bits.

Another one I've seen is that you're using the BCLK as the MCLK for
another part (a few devices even require this), you might want to run
BCLK at 256fs or whatever for the MCLK even though it's not needed for
when used as BCLK.

--u5eZqz2o//Vq7JSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjmyNQACgkQJNaLcl1U
h9DRUgf/bzTK4q8vux7wR1uO+b3429++RKS7nto/tomVM6MiJssgpvuz+OiDzNdD
+tEfD/WG03m3JO2+48l/ZU1N7pvXHEcByJj+g+7i3iDttr2Vz1jH5smPVVpyQvc/
GKLiE0i96zZK4LxQgCOoBz/Oc/FhFuWlqYcmkZZW8U+1euQDH9wIShP3xJfFnTQf
BTJeXG4Kea16vto3ZH0jPKdsmENiLWHHfCBqcWEKkRqENPycdnZ7ukXQhwjUS/y4
US0P+cpEmiEXy9pK2uV4Q1G4aUNs0OyaoHPZGjgMnGotD6FezPXp6Fs+bm7dsokh
SLVoPU7SavOTMcSlRf8WzadbO0MdXA==
=7Ho+
-----END PGP SIGNATURE-----

--u5eZqz2o//Vq7JSf--

