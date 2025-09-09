Return-Path: <linux-kernel+bounces-808740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272DB50431
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BDD188A9FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3F33CE92;
	Tue,  9 Sep 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTLJmaTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667B33473F;
	Tue,  9 Sep 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437890; cv=none; b=sKSl+sXIrj2L2WdBpavkkpnQXU0KJl8VM/gXIzYgtW/oSjeLgNmG+etfTMSjfpDx41zSEHKfk/6OJ3xFGwlmJ3m7Wjdynr3ShwUx2quhqtgOjeKObxSxdMrJPKPrfL8MoZMlnPpzfnnQogKVohh+qtjnCNHLr1EQYxZLG8HgJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437890; c=relaxed/simple;
	bh=S/OuN5apoJVcEoEIPRjsVFwPizw4X1TqkN7MJOdBM9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg0oHJQrqrdsOCDf/a+4Ev/rBUMvrywcyJoI2bpdSXtyWGkU98wDjw1u0o4azVVAWtPaHolGubLMwzb4sJuIJTYMTqqmedlBSx/SqbLSFgNdDDcyrdGMoxkI84Hta3PNpMtDzEv4mFM23zaEe8BdxQf+R+RMBQP3LsjbFqTxED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTLJmaTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1A9C4CEFA;
	Tue,  9 Sep 2025 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437889;
	bh=S/OuN5apoJVcEoEIPRjsVFwPizw4X1TqkN7MJOdBM9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTLJmaTFDnaEstqo775o4Q7JCvUB78BqED8d2jqmnPfqqMYmXnoDzpYMMt1rIudaP
	 Hz4XzlAiqbnqHhiGjMTc9XDKkZ53YSD7Ax1GmPRKYdqtXY0yIZ/VqdWID3FHkgrX7J
	 b56DWSGq4BZI3qc0HhcUcsrGKva8w4Jl3XdCKQTWH1mWcVXmDh9toVJRPPEojqKFck
	 hnF7WqPP5Zd6rzkB6wQWEMeljHunbcRMX5rOw7oBTC1Ga8X9XlyF+xmuXHHP1PCnPq
	 gboEl61MRMXJr2g1It28pdmWRceuY7acIq4uba+JvckEWr2AQDBntgTbBOH0J0+hRf
	 uoim/jw3zRmLg==
Date: Tue, 9 Sep 2025 18:11:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <3bed2164-8f68-42ed-9ab9-6fda05687535@sirena.org.uk>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>
 <aMBVgrVqX2w31GhV@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6d1BqhGbIWpOuVpl"
Content-Disposition: inline
In-Reply-To: <aMBVgrVqX2w31GhV@tardis-2.local>
X-Cookie: Ma Bell is a mean mother!


--6d1BqhGbIWpOuVpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2025 at 09:27:46AM -0700, Boqun Feng wrote:
> On Tue, Sep 09, 2025 at 05:58:34PM +0200, Miguel Ojeda wrote:

> > It depends on what the C API does -- if the C API is supposed to
> > "always work" (even if it is no-op or if it returns errors) even when
> > disabled (so that callers are easier), then we likely need to
> > replicate that on our side.

> While I don't disagree with the rule in general, but I do want to say
> the cost is the binary size (at least without inlining helpers), so I
> think we are allowed to apply this rule case by case, i.e. even if a C
> API is supposed to "always work" but Rust can avoid exposing the API at
> some configurations.

The C stubs are all inlined so should have zero impact on the resulting
binary (as are all equivalent stubs generally).

--6d1BqhGbIWpOuVpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjAX7sACgkQJNaLcl1U
h9Bk/Af/eK1fBQP931A0UJnh7LrIb+mbA+D3rEV01J9BqaEvB+R278vEaNrXieI1
sHSV32jEZ9hQJ7N4tiwbZW8JpHSr+xGv/35qea6yJ+vueWHQ6Vx/q2SD/Ea2GCab
kGUmF/2wL/C47JiZEc4ETKwFPXVruu0IpX9JKJG5lsjb8toGMsXo+hLArXCCY4Eu
h4qwOQh53DWRZpfkeaLzI1krasGyzFVpszJbNfjYndsz6glIhddG39/AyOotJ0nA
vY7m4xrOplnIm8w4wvWHZAgT+iVEmUrWAfvb4GJLrR4nnvVUsPlkrI8E3vJKsbXq
UvMXAVNffu7zlr6lHJ46bjxuitqKDQ==
=Fuqg
-----END PGP SIGNATURE-----

--6d1BqhGbIWpOuVpl--

