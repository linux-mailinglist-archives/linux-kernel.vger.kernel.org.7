Return-Path: <linux-kernel+bounces-787100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E8DB3716D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074E836789C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43F301001;
	Tue, 26 Aug 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQkYvvlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C302D3A7B;
	Tue, 26 Aug 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229891; cv=none; b=OYmJw3ZJ9knzjH+lOAhIDTdK4uqjiWqv07z3usiYThR301Hh2UpyrNlBeSI9D3J3vpxYS5dxGBqUiGRz6gsoEt2cQ4v3aJEBIXwSraMdrq0dywcwa3SXMyqm0a1kDow5xPXoemHg+jmYkL8Q6kCuPbHswmkOWin3v/sXK8BMYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229891; c=relaxed/simple;
	bh=YvlrQEBdz4XlAcPJrPLv9JNi6qjiuMYMujNAJxcrsBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbEmIohbre9alFgYQUthwrLBev/nbruTtD75HkqRs1tyG9WibvitEK0FZX8dlzTDubeOcvVWaUU69kKIz6rvx4dn9kpqbwquC0DNiwLa7xz7Tkc+2eLWLx/tQGpKAJmhFBrVNTLLimxnLCgGp4lQd4s8uKxDrf4vV34Wer0rM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQkYvvlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE820C4CEF1;
	Tue, 26 Aug 2025 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756229890;
	bh=YvlrQEBdz4XlAcPJrPLv9JNi6qjiuMYMujNAJxcrsBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQkYvvlRcgmd6HyYtfYTvjaacKi+h9Cyh9n0+yI7pN2i4qWYH8MJq9FShzMz8kTX8
	 dEzz5zfvefUrURXRrXKBaleV+3FhWw9qxYn6tpDd6PRXYuS0CxTOkg/CkPevYWJeS/
	 TiYcazCDcDnzC2s3WFfT9TZe9q4SSnNpwFeDBcfDXhIHGPPqrsiILErL432k4nI/bz
	 bvDVsZWJyH+J0A719o6yzlIEukmfLgt7YoHrEcTYYPFnUN3Biy1BjheXPc4cJ0PD23
	 QzeTMX0iziFyt2klr5DMQ7WSqSQopn79cguqj0ZgJ7OFjUrkzpVS8f4HOW2QzUZuU1
	 L1fU2Ts8nyD7w==
Date: Tue, 26 Aug 2025 18:38:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Karel Balej <balejk@matfyz.cz>,
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: imagis: add missing
 minItems
Message-ID: <20250826-yippee-tamper-5439f104769b@spud>
References: <20250824-imagis-minitems-v1-1-cea9db55e87f@dujemihanovic.xyz>
 <20250825-capillary-viral-b7448ca6a57e@spud>
 <5917367.DvuYhMxLoT@radijator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2sXf8PaRRQhYNndC"
Content-Disposition: inline
In-Reply-To: <5917367.DvuYhMxLoT@radijator>


--2sXf8PaRRQhYNndC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 08:57:57PM +0200, Duje Mihanovi=C4=87 wrote:
> On Monday, 25 August 2025 18:42:38 Central European Summer Time Conor Doo=
ley wrote:
> > On Sun, Aug 24, 2025 at 06:12:05PM +0200, Duje Mihanovi=C4=87 wrote:
> > > The binding currently expects exactly 5 keycodes, which matches the
> > > chip's theoretical maximum but probably not the number of touch keys =
on
> > > any phone using the IST3032C. Add a minItems value of 2 to prevent
> > > dt-validate complaints.
> >=20
> > Does this mean that there are devicetrees in the wild that use < 5
> > keycodes?
>=20
> Indeed.

oke, Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2sXf8PaRRQhYNndC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK3w/QAKCRB4tDGHoIJi
0kcbAP9OjxuJlSeoFVoRMwd0AC3i22uJuWo3oxsPWAmkIauJkAEAkf4ZKO+LV//b
vk4OrnB4R749FeonUHgJgKEVyPsZsQ4=
=OJdB
-----END PGP SIGNATURE-----

--2sXf8PaRRQhYNndC--

