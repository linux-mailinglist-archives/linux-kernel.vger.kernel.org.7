Return-Path: <linux-kernel+bounces-856335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C944BBE3E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C22C4F9B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFE33EB10;
	Thu, 16 Oct 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RBpkbq8f"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AC33EB0B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624854; cv=none; b=taes0uxByvZwNBtXfWHmDUQVX9L+/F9biMrQzVJDXqGeKPqhmIX+6/7ROWoejSuZbTrRvzzzKf1bKQ1MNveFICK19PIMuZdhVuNyVftpJ8VA9FwoXA6vfRV4Y+hHutlHWt1e9KRSNqnIKc+xHPeX74BA7nLBNaXTGN6VIysYw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624854; c=relaxed/simple;
	bh=9brNoZKjdpjYUdJfvwB5+mqBOUG8E4ePDh2XwdHUqlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQOJX/s0/GfMfmNUFkS9WXtE8cI0s/IylqVUG4iwP6ZrcBZjNalxd0fBfzEvK1IKz1DUvjSqLwJoY5kh7LQLfFvgfdtF2879JrmQ8ioFMU/Oro14j1isPzRjWprfsIJQPKVX+QrsP72MhlQkBdEo0qI9Sw32QMPK8hl2ncUxp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RBpkbq8f; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=P/xa
	VA8We202vbtypRHehTWpR/UdDUzk20UbGRFmXMk=; b=RBpkbq8fGPxU7kAfOr5F
	cyrZQb7y2d47gvYXUdsZB1myxHnie6Wm3fgvqeJsZXZwvSZDSzn8eGPFrYKWYOJ1
	yi70IOO0VSZpMjt8Hjx1i0kCqi/sozBK74qLV4ZzBNKngD4/4aISkaau6oKHfd2t
	RJ8se272loks3mtvVSJgydzcyQckEFWtm2UnE/kFqGg8mNT5H5T2Hq7lRoFB8CNZ
	FsD0HzhNIysoYTXdJykVxy8Ez9YhDRzipPXJ3Hz+pRFX3GcF+BYXZevj+/lZi1z4
	/L3vXAhwzABYV44EcwCYe+U5zyueedbHuLtvDW0YN14VRmO1nzOkQDTkgIqKibtU
	5g==
Received: (qmail 3842040 invoked from network); 16 Oct 2025 16:27:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Oct 2025 16:27:20 +0200
X-UD-Smtp-Session: l3s3148p1@84MmakdBuJcujnti
Date: Thu, 16 Oct 2025 16:27:19 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if
 possible
Message-ID: <aPEAx8ZGHBcWZKJF@shikoro>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <20251015205919.12678-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xBMWQj30cWp67ujO"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>


--xBMWQj30cWp67ujO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you!

> This does mean RESET_GPIO will never be modular anymore, while it could
> still work as a module (the reset core creates the platform device,
> which can be probed later), albeit in a non-intuitive way.

Interesting topic. In fact, I think we should make RESET_GPIO bool. I
think the fallback mechanism of the core should work without any module
loading infrastructure. It should be there whenever possible.

> BTW, could we run into a circular dependency?
>=20
>     config RESET_TI_TPS380X
>             tristate "TI TPS380x Reset Driver"
>             select GPIOLIB
>=20
> I guess this should be changed from select to depends on?

I agree. This is not "select" material.

Happy hacking,

   Wolfram


--xBMWQj30cWp67ujO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjxAMcACgkQFA3kzBSg
KbZxcxAAh1/J89wM/VNQVjqE06ypoITVpO6T9RHyHxOZBQ0W+gXeecLLny+79Kdo
Fvc5Y4nnn4U7qeCnT4f8tGxGlvlvP+RXqjmgVurCJ4Q0Ns7QGy+T7KAZefiYnQ8J
KlnUc4vCq4llTM6W9NimzmhFT95rzoAgEb7JWy6bXbHD9+eSvAP7PfW1QiTVnooc
pLHlt6qmK2DVhOzFGbYxLRih/EGEIndHNrxPOfnar1zsPRlsQo2d/sdksTHBipWw
OnK7IoYPBPN7PCZ/oAv2xLl9WGhsnUSaDxa94dUhte3uQSaCbASGwkYnkpj/WWK7
W++5pGA2FpQGOZA0e9eo8O2LtxHzhuxO4mWaSimFeh6z2jaEt8jCp80f5/YfLJl5
Gd0G82bWh8i/cMpQlaQtYXX6M5sJOUniC4T2bfKyNoTmUO+ZErTJRWyvPcgMP7CN
KSxMQJjpmkYUbZjPUwS/wUYzu6Xwk/iNmWQPVGqpjnMCe5B5HcxGS7Hb3S5rO+iC
JJd64sCHbKdCzYQaiqsXRh+9Xp/ApA+4VUAi7IY+eQDH+teEXyz4enyWNPyj/Zze
QMKpjP8gOsXCwrIqLNsgVfO67TF5NymWJ1g/02LD54PggTdvB+/uf0+bu3VghvEX
L43QSgM1WJA3BhyZEbn+wYQ7zKhbsD18jLuRt8fwWCxqiPKGcoA=
=DWgd
-----END PGP SIGNATURE-----

--xBMWQj30cWp67ujO--

