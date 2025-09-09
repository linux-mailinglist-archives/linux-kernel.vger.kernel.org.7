Return-Path: <linux-kernel+bounces-808725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52489B50404
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB15316B124
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2813570BF;
	Tue,  9 Sep 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVh6EGjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591332A3E1;
	Tue,  9 Sep 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437833; cv=none; b=nW1eMir9ig0+awMl4HwqX1OK+GkF0jKO+qOwoIWCaBbkJh70GlasTbEmzgCqid8FZben26SCHjdg2q8MU0c8arvkP0/gZyJaaIIpcwI184f0jY9zfCE2CCZ+PQwKSgsA6Qqjus/NGox7U7SIubPwNmzBIkfqg6pfs8BqHcROncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437833; c=relaxed/simple;
	bh=mUi4AOnYML2NlnW1fSURRmF5lKnm20xRWn530unMYOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szMINMpCZ1k3hgGjKcziTKVLhv4sdKM3eiaIiHeVdfcmIqlXT3yyjV+h99SZRvVpiKlOdJf2QqZDTznC5U3pRle0Gey7vlFPknv4Kbo762YCjvPIsRMgi6RMgfwHVaWzWETBRAUC5IZrvPieZeA6Wf6PRlMCQcSOGIa9RUXGvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVh6EGjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2DDC4CEF4;
	Tue,  9 Sep 2025 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437833;
	bh=mUi4AOnYML2NlnW1fSURRmF5lKnm20xRWn530unMYOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVh6EGjEochncoiM6rlrCezIS791nqYSdlBthmzNftJJHgVAv5j36/xuk2US2SSe0
	 4mHjDO5E4mU6ssWorsslRs2ojLJXvtpQkRC9v1sYI9fvWV/iLmvRh5FPUx+g3fzWRi
	 79Yf/4JIppLOjqma4u1kDTxOC3Df6dUFEj044TaKgDE9eBzec+oQlPMZtqV+44Qspk
	 WZ8hMkSV76zjLc+3sNnDHrQeKKbvvX2TsV7D0+T0+9pESMaldzP6Wl24wEAYRcp3+P
	 uXey5Yp+EQuKvJrX442x2Snu14AwvCNG84pqwMArTWAj0+n3Dk8FhqbaChOz5eh0Qm
	 eSEwRb/5IS3VQ==
Date: Tue, 9 Sep 2025 18:10:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <0b2951b2-ebee-401b-84fd-ecfabd01376a@sirena.org.uk>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <d59eae86-9b8b-4d4d-9a1c-b76ff0f42704@sirena.org.uk>
 <871905b9-995b-4b16-97a1-7be580716ce4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uJzBj8Hexa6WK6wo"
Content-Disposition: inline
In-Reply-To: <871905b9-995b-4b16-97a1-7be580716ce4@kernel.org>
X-Cookie: Ma Bell is a mean mother!


--uJzBj8Hexa6WK6wo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2025 at 06:29:49PM +0200, Danilo Krummrich wrote:
> On 9/9/25 6:17 PM, Mark Brown wrote:

> > If we do that then every single user needs to also add ifdefs for the
> > regulator API which is not exactly wonderful usability.

> OOC, I assume users do not just depend on CONFIG_REGULATOR, as it depends on the
> actual platform / board whether they require control over a regulator?

Yes, and an awful lot of the time control over the regulator is just an
optimisation and not actually required for things to work (eg, doing
DVFS or disabling the supply when the device is idle to reduce power
consumption).

--uJzBj8Hexa6WK6wo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjAX4IACgkQJNaLcl1U
h9DxbQf/UfN6CsWN2iI6iDGLYt9+hI8iY/6VSopgoge/yA64C6k2az5IF82yDO8+
vU7ReTbp+4kH0tPWoQ31Z4itAZxwjlm5NrpyxGSLS0qvhlO8vakZ8ENQpD/Pp1UG
/VPhhMx3GKCO7XEtBWJMVneV0Xjv9HyTFYnQX9v5eksb0Xgfug/eAp87kUYPvSXa
xmR+H04gMobRFMtbHidtMU8pmVPz3aGk/G9AVME62y/PwJ4rWOjrgd+x25dhJW+v
16QvDeMKWkdw6LBPj8DUwEs35B4YyrCD8jasapo+G+IMBWEePnZzSA+YBWURfkB/
8aLMD69fg0o7QLpx4PYWWlsnOpXxrg==
=jQRQ
-----END PGP SIGNATURE-----

--uJzBj8Hexa6WK6wo--

