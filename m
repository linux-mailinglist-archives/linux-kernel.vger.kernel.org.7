Return-Path: <linux-kernel+bounces-731759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36335B05919
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474F14E40AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C032DC325;
	Tue, 15 Jul 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIUi0Ytc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611E252906;
	Tue, 15 Jul 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580061; cv=none; b=Eyh0LXcb6t1SIlAx9RzCqtALgHxChrKRHM/BsaBENOGd8eAfPR7037dv6+yjnOeWK0d14u3Dar0MlsiVozWfCRlc/JJoo4mgu6FxLpHkdT1YTzlgfc54yyYh9wOVDF+ozI9+cFnUG4vy8qXFBtu6fTJW4X+0duEuhHSIvdR0RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580061; c=relaxed/simple;
	bh=A4j7G1vC0T8/33ktGJXnWr5nfBS1gbpvgbnn1MDL8Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV6HwMC0ZTJYUmt8STl/EGnX6K0OflTEEsQvlWPmJsdiPerCzHZi4Bwunz9ipMQRScJP++cAiLFduImPzxUgwN6wWNXbIxdY/sD8RTzpVePU+V7NLMcO4cVBUme+o7LOgOPJ0hu6ASceECJSiGSm0ZiMALK+X8X3p26MI83Ct5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIUi0Ytc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E418EC4CEE3;
	Tue, 15 Jul 2025 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752580061;
	bh=A4j7G1vC0T8/33ktGJXnWr5nfBS1gbpvgbnn1MDL8Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIUi0YtcSwAFb1E9tiev/sD+ZEIF1refmS1KTCmXo7+LSWhR+To3EGy8HO/D0iLMA
	 9wbQ/i3cQcHFi5/N8BGhuT9NmjWUXogymvLBj52JhhDwr+vPd7mio9vcoqvDOmnFxR
	 E0JywS+bjA5iqm0YMcWWOdNCUWbVDswIa5vVgbsGdmWNro99T817XXEl8ybGvXfsMU
	 tJfjIEICMA7pbypXmuWEXcukWijbt1rGD05lp5AOsL5ytbCm79GFJlNjfvKcS57F18
	 j/QrmEogwCB/1cuPTdkghLxj7KA28MgFMohZm9sthg+bJwTduTmDTr15P/37QC+f2Z
	 dYYtcyDkZ5KQA==
Date: Tue, 15 Jul 2025 12:47:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Benjamin Copeland <ben.copeland@linaro.org>
Subject: Re: selftests: arm64: mte: check_prctl.c:72:17: error: use of
 undeclared identifier 'AT_HWCAP3'
Message-ID: <45be60ff-385d-43ab-9b08-1c13477a4a01@sirena.org.uk>
References: <CA+G9fYusqGejrepNPCR-7ZZDPeQQfZgf2z=_aUz_03QHm7Ccaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uQSmwzk/K9D/NaCi"
Content-Disposition: inline
In-Reply-To: <CA+G9fYusqGejrepNPCR-7ZZDPeQQfZgf2z=_aUz_03QHm7Ccaw@mail.gmail.com>
X-Cookie: Your own mileage may vary.


--uQSmwzk/K9D/NaCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2025 at 04:53:04PM +0530, Naresh Kamboju wrote:
> The selftests arm64 mte build failed on the Linux next-20250703 onwards
> with clang-20 toolchain. still seen on today's tag next-20250714.

I have a bodge for this which I see I didn't get round to sending out
last week while I was at an internal conference.

--uQSmwzk/K9D/NaCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh2P9QACgkQJNaLcl1U
h9CtpQf+J0uScZs5pqd4ZVDV42gg4cfx+vl09VSsEQLZrkYXlQJbJm/Oz/olZhaM
UaCJGFoGsMnNGEvkUf6VOxr4f4QjtXOPEoGv467A8Vl67x84ViSLAcbYlhcwPkNn
/Gn4s/bHNaM3vWnCEqkhxU3AiGKNiUJa5FbRdaVmnQavlvyThLsC0TvyEmjhQ/Pa
F/D6nmmxbmW53sZYcYk1vdq7sQ1fWd3TrOrHqJV8FHFUWtoJs5cD9lDgTFp2ulOq
1a6Tlz1UcR9giue5r+ewT6O/gFeqTrHYZWnsc5sYPWFA2xgezMYaIqZUgYsMhZXJ
fqANbbA3gU8uwhYXKiMJW7Bu1kNUfQ==
=7/J9
-----END PGP SIGNATURE-----

--uQSmwzk/K9D/NaCi--

