Return-Path: <linux-kernel+bounces-793106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2DB3CEA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37E1561B88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA972D838E;
	Sat, 30 Aug 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiVOjf9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D218DB26;
	Sat, 30 Aug 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756577874; cv=none; b=WQc8U+IfL+CWgcpd3JsvS76oJvBcHi0s/oX58dOadlI9CKC5WCkazzWOQcZrAWYfZy6IJhbvoTy/OVzAKX4cWTUBkZI9hZUrpl/B0DY4BBx0tAnkP4R5PmfjO/KqkBDCD/Wc3fmCXTW7ASFH+dtykZNjyzcm9NJzpV8iwDBZoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756577874; c=relaxed/simple;
	bh=AaXzJegL0LXpBu/wgNxuQEKB9cIewaGfi4OXtiQRdAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvqXsQJYVFhhZNlloO62vIQFm9ZUQ2oJGdnYbqEXUBK7wacrCOx44LBvdxhKA5N+/eFHSLCjZ9LoecYRoqwY4pnHz3A5xMaZsWSwBYblqI6VRe2Bft4ATZs+2SLNGGEJuhop8AnOmo/iQ6NgMAC8wXFzMNVUlaNU5uo01ttjavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiVOjf9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7416C4CEEB;
	Sat, 30 Aug 2025 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756577874;
	bh=AaXzJegL0LXpBu/wgNxuQEKB9cIewaGfi4OXtiQRdAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiVOjf9jOkGjHJZOn6cWeFjeGb4NmxamBHRvpC+vQZMjcf9cpohVByIZNvS2Iax/p
	 FbXBosHi++OUrfdP5FDrXXKVrDh242WhB6R30jG+fg5V17Y29t6p0f7Tn85q0sEjye
	 ziFFoxGWRvld4gBDfAXJzsCbIGS6fEy005WhyX8wFzgzN69F1sWoP48paqhYHoLVNY
	 517v4PlIRFMhqdtvKJ76t7BmMay8AWn0FxcpIBBJnq0Sx1s7giQgyfgS5SXg2xWYNE
	 HHwcIjTZ8W0AU4uXXb/b2XUgVTIPkf+UX6pcjtuGVfGEemTFhBc6Hx97/qJozukK+g
	 yV8HsWhpcC3rQ==
Date: Sat, 30 Aug 2025 19:17:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Asuna Yang <spriteovo@gmail.com>
Cc: Jason Montleon <jmontleo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: RISC-V: Re-enable GCC+Rust builds
Message-ID: <20250830-cheesy-prone-ee5fae406c22@spud>
References: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLgD4sybnROtocgd"
Content-Disposition: inline
In-Reply-To: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>


--PLgD4sybnROtocgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 01:00:56PM +0800, Asuna Yang wrote:
> I noticed that GCC+Rust builds for RISC-V were disabled about a year ago,=
 as
> discussed in
> https://lore.kernel.org/all/20240917000848.720765-1-jmontleo@redhat.com/
>=20
> I'm a bit lost here. What are the main obstacles to re-enabling GCC builds
> now?
>=20
> Conor said:
> > Okay. Short term then is deny gcc + rust, longer term is allow it with =
the
> same caveats as the aforementioned mixed stuff.
> "the same caveats" means detecting what specifically?

There's "code" in the riscv Kconfig/Makefile that makes sure that the
assembler has the same understanding of what extensions are enabled as
the compiler. This is done by detecting which version of the tools are
in use, and adjusting march etc as a result. See
TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI for an example. When I wrote the
comment you're citing, there was no "off the shelf" way to figure out
the version of libclang in use to ensure that it has the same
understanding of -march as the version of gcc being used on the c side
does. For clang build, it's not a concern since it's almost certainly
the exact same as the compiler building the c side.

> We have a RISC-V PWM driver being written in Rust. Currently, GCC being
> disabled for building the kernel with Rust for RISC-V is the primary bloc=
ker
> for including these drivers in RISC-V distros. Therefore, I'd like to push
> forward and contribute to the re-enabling of GCC builds. Is there a more
> detailed direction on what I can do here?

Add the version of libclang as a Kconfig symbol, so that the kernel's
build system can ensure that both sides are built using the same
configuration. Off the top of my head, using a pre-17 libclang with a
new gcc would require having zicsr in -march for the c side and it
removed for rust. It's been a while (1 year+) since I fiddled with this
though, so my recollection there could well be inaccurate.

Cheers,
Conor.

--PLgD4sybnROtocgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLNASAAKCRB4tDGHoIJi
0vXYAQDgtR0RaOgK/BuuCweWdpp1h5+8Uf3iwmbxuqXRT+YFsgEAu3diokJiUzBm
ruXnlci8jwoUePp9tM9YndTyCztULQk=
=UFnw
-----END PGP SIGNATURE-----

--PLgD4sybnROtocgd--

