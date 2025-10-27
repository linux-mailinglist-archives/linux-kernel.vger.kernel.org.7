Return-Path: <linux-kernel+bounces-871650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8873C0DF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916AC1885794
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34562698AF;
	Mon, 27 Oct 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbu+IAIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A423D289
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570941; cv=none; b=QaL+oD6fUoB+Hs9JMpf/nep3asGJIfZy1PjNhpxjyUcuWuF7lHO5pDxztgeQcGy80d6980MxVvP4+jU1HauH8qIF+aKwcRNyVCBoLTGyMZ5Eq4jxoekdC9012q52sjnUMGUZnUaxLiEa6hjOIjCbiDADlRmCY79JONpt27TCjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570941; c=relaxed/simple;
	bh=JehhPsyuoWTvAI6THbCuvpLfpjH680l0Q08hKRJS9XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV7HX4SDZuFVJw+C8jTPBYQcOIi6cm0QIMU2T3n4IiG/aYoM7JZgoP8rQ18EKl/2SdGq22olXvN1+MGtQdrYHzTGEkG7LGrpHH/68f0skt84oVhAU2+zkYHRNlTfC3qQg7w2eyPb8WSbznOjPcT1uuF8Y72hbtrXVYhS08mZfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbu+IAIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A34C4CEF1;
	Mon, 27 Oct 2025 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570940;
	bh=JehhPsyuoWTvAI6THbCuvpLfpjH680l0Q08hKRJS9XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kbu+IAINSf4JSNmGB9xytPjn0ALrULG1OW0ZTNcAF+k/EI4yslDR865V1Lvwr0bfU
	 bP8TSjk8mqcEUJ1r5ucSP6rdmU0mAFDZ9pfg5LXN1JQ+AI7uicUu4tYyu65lWdncYE
	 4cBtN4mNpoJrQsdTLKgzec0iDAOwHguCqirKVmbYF8jq6ZZi9tQ9obMyp8IzHUuAIK
	 4xX2ygArLgUrtuxmQ2Q9Jq5lLgMzOHSzeQ+URCisZWAZZGcAkJMnJvX6krYZOXIAcd
	 +D+DbLkcvtaA1PUUTewoVo+d11Wepzn2tqQbcwLxIVLQlueeYCbWVl+Rzd2YnNqEQo
	 V7KisPCX8YGrA==
Date: Mon, 27 Oct 2025 13:15:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Eggers <ceggers@arri.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: regmap: Modeling a shared page selection register
Message-ID: <7560d98c-84f3-4405-aa1e-0da79eb47866@sirena.org.uk>
References: <2241758.yiUUSuA9gR@n9w6sw14>
 <aP8xPOG68qL2IQ-A@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0Ud3mAPxmrQuzaL"
Content-Disposition: inline
In-Reply-To: <aP8xPOG68qL2IQ-A@smile.fi.intel.com>
X-Cookie: How do I get HOME?


--i0Ud3mAPxmrQuzaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2025 at 10:45:48AM +0200, Andy Shevchenko wrote:

> Right, the logic behind paging implementation in regmap is a bit tricky
> (and has some known non-critical bugs, FWIW). There is no documentation
> and it appears that most of the drivers using it, do it wrongly.

Which bugs are you referring to here?

--i0Ud3mAPxmrQuzaL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj/cHcACgkQJNaLcl1U
h9AQJgf/bM5/9A7sjTKZV4jEiT53GfCwgNhNZu0g6Zpf6pV5DyDybojTrYKNfKDB
7/rckxIujCaGvw6us8nmlxy96TFmdJeTmvQIGnUMPwUMYfZhbTCXUpBHVfiiZCEn
siuliXzolXVQ1TLyUkDUxzXVrYPE1uyHLT/gTIioX9ssfLcfKSx5KWL0b0aZvfAX
p09ij/FFRzdIzip9wFnQMb7QHm6WTh+5EgijsUNJYQYfqBhGtPitzhKCMmLpkz2g
z1Nipkeyxeg7B2tYvThIZBPTTwttZR8qkU6N3DDRLh1Vx69sc4c06eAut7nOe6pw
hu0PUJHVwAm+rVNUiRChSK6peXIfpg==
=psRT
-----END PGP SIGNATURE-----

--i0Ud3mAPxmrQuzaL--

