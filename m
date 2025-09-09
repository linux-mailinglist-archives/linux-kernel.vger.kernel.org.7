Return-Path: <linux-kernel+bounces-809039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D205AB507C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A255C4630B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B3257ACF;
	Tue,  9 Sep 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIUlMKge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7C2571B0;
	Tue,  9 Sep 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452233; cv=none; b=G8ZN8ODMW+/z0m07j5HsiSWLWHQ8U0SLnWi6ngexczR/TjW4r3cDWVnfELvFzvUn9pJca7vuUZwkyqNRYRmCukiT7CfGwJOEe/NW111DcZ++a+rP37Y/JO0SrYI6LBwt4wnRzhX7Yepn5vwHc5u5Vl4YI/gba2F7m7La5ndCKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452233; c=relaxed/simple;
	bh=ZhYj3i702NIlNoxxmFEysWbkdVutr8kgHzHlOYCMjQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb3OCWPGwZ4u2Yxvtb3k3o+uRXD8OKWRdbtOyvxa83PB/FDa7Mj1q5D+a29yrNVBGCTkQl9o7x7IFg/kmmYiV+l+FOXOLm6hVUMV1r632XDhU0MEEun8jQgS6pZryKnRwPA3zJOJk045aXdaNuBxCiqjZPB1uMptSZMhx+mgk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIUlMKge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BC9C4CEF4;
	Tue,  9 Sep 2025 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452232;
	bh=ZhYj3i702NIlNoxxmFEysWbkdVutr8kgHzHlOYCMjQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIUlMKge+proD5snVcjhwQsdRc2vxEItZdcU5MtasdgEZZUDYAloJXg0MeYQwbuCc
	 0bGBfv7UqSdmKACiw+moUId4bG4+5o0DYQoYI1DEbcmc3L29PQ7niMYO/90bZ5kmDD
	 ylDd0UQcVNeVmP0SPpkVeRdy1mcOHxw9cZcJbeoiZ+kcjIHb6S0/U35n2qLxkG6J3U
	 wwOSqRv4CXxzmGoJ2jV1w0sztgLZJnAUdQJgnCW1lt/nZR1CmpYdwIOdL//uJj0+Da
	 dY5W0koqfz3qwlCxObSqUu31zQ7j9god2YjvJf8jStYE8+pEJvHcT5NZTvF1aCwre7
	 41cXfQ+D8GX9A==
Date: Tue, 9 Sep 2025 22:10:27 +0100
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
Message-ID: <1d6f3782-3876-44c4-bed8-08d68ae6cdad@sirena.org.uk>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>
 <aMBVgrVqX2w31GhV@tardis-2.local>
 <3bed2164-8f68-42ed-9ab9-6fda05687535@sirena.org.uk>
 <aMBgyxREYOM1GZFI@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Sy4rBf6Er4A36G8"
Content-Disposition: inline
In-Reply-To: <aMBgyxREYOM1GZFI@tardis-2.local>
X-Cookie: Ma Bell is a mean mother!


--1Sy4rBf6Er4A36G8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2025 at 10:15:55AM -0700, Boqun Feng wrote:
> On Tue, Sep 09, 2025 at 06:11:24PM +0100, Mark Brown wrote:

> > The C stubs are all inlined so should have zero impact on the resulting
> > binary (as are all equivalent stubs generally).

> Yeah, but for a rust_helper, right now a function and an exported symbol
> will be generated so that Rust can do FFI. That's the size impact I'm
> talking about. And for regulator, we only have helpers if
> CONFIG_REGULATOR=n.

That seems like it should be solvable on the Rust side in a similar
manner to how it's solved on the C side?

--1Sy4rBf6Er4A36G8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjAl8IACgkQJNaLcl1U
h9BdFgf9GqdB/97QUn2n7x0euLao90e+gqk92p8ozED8BM2a4I0/xqpOWWRJ7vJb
rNwplg4Piaq4sSse4L0AaQU7b5uSLYki4a3o5vnfqUG++emFpKIfcTb+nw9HwUH1
SiayjZfFkE3FDDz/jHFpWSqc/IuUOWrqZjA3P6+0Qd5Z+quRVOlAHJfrx6tM49sq
1xJsdssOzBq1bYIBcYfA/mtG3ito2B0TNlsPjDaU/CPRWyTuU5VHFWRPpKnYSecu
Aq6fcCBmGbB6TBHFb4lm2YDhAq24XrpYONGNEYp+WZ3DnSnRtdfqxvggLYct/BDv
FezLOBv+ArNUAE7YBRrGRiOvDuqt8g==
=fqz/
-----END PGP SIGNATURE-----

--1Sy4rBf6Er4A36G8--

