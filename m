Return-Path: <linux-kernel+bounces-800652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148CB43A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02BFA015EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223602FCBE5;
	Thu,  4 Sep 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcUFedeG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1254654;
	Thu,  4 Sep 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985305; cv=none; b=JpNIxs34SFr0J3F4nL1DaMoD4Ky3QhFEkpC9+0NdRri7GB8YQYFysoKypYHpEx0f9uFC+3lpf625+l3wylPoLwUypO4Hy+aZIXpxMJznxa/TIImwiCQSiCC7Qooghb9P8uu0wuuGcFgw2PiELmYZqxY2XIdzdyRkoTK3F0CajwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985305; c=relaxed/simple;
	bh=tIBxjsccm8kHR8G43oxDZfY3p0spp/YY+1CMvOCugxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/G1C/ouiJBe0TW3DDyaFRN27V0dNg8IgwgGSkrgZYq8H7nB/WBCGUiR4n0sPDY46HqNQiGIrN4oWlzdOUwqFetLUxZOFL/XQMfIk/+lf8nCJne9M6pBAIg6HrLLHKenEHlSNHsPgXhRWWAUzb//aWiF1nkvDATI+++t4eUHf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcUFedeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D0FC4CEF0;
	Thu,  4 Sep 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985304;
	bh=tIBxjsccm8kHR8G43oxDZfY3p0spp/YY+1CMvOCugxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcUFedeGgYbOan+Gw1UzKa7IwKeF8ZNKF/wQhqY5w1osyqXlYOKvT97RRZoamD3qz
	 xjJmcCeSKLXAQXLZS1p1HPmqNA6eqWzAfSUZQUXc+odCBBkOzqErAlx2n1h4OQVGox
	 BlY2foolbjZJs4mjSkD/UBJ/9r/eQ6+RXbMyIRa7+pL/PV/LhhpunnYylMAOOaumEK
	 WfUY+xkMMKwBKUQy4P7vs370ATiHsBSfwE9cNExcpwnxPnpqFxmYJDjU++3Z7IkA+i
	 3XNFaaPPPxYXZjhty73Q1QcR8l2jGPA81YsNppPOHLpjE0Ln6CIPi7dvh0g3WAeVPK
	 WJlNm9xf7/KqA==
Date: Thu, 4 Sep 2025 12:28:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Asuna <spriteovo@gmail.com>
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
Message-ID: <20250904-little-fester-546dac576c72@spud>
References: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>
 <20250830-cheesy-prone-ee5fae406c22@spud>
 <20250901-lasso-kabob-de32b8fcede8@spud>
 <b1734c45-42ec-46c7-9d4c-2677044aacab@gmail.com>
 <20250901-unseemly-blimp-a74e3c77e780@spud>
 <e48699fb-287d-42a9-ba6c-5edad86965f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SyMjmTdRNomxZcq3"
Content-Disposition: inline
In-Reply-To: <e48699fb-287d-42a9-ba6c-5edad86965f4@gmail.com>


--SyMjmTdRNomxZcq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 08:59:29AM +0800, Asuna wrote:
> > That particular one might be a problem not because of -mstack-protector=
-guard itself, but rather three options get added at once:
> > 	$(eval KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dtls		  \
> > 				-mstack-protector-guard-reg=3Dtp		  \
> > 				-mstack-protector-guard-offset=3D$(shell	  \
> > 			awk '{if ($$2 =3D=3D "TSK_STACK_CANARY") print $$3;}' \
> > 				$(objtree)/include/generated/asm-offsets.h))
> > and the other ones might be responsible for the error.
>=20
>=20
> I still don't understand the problem here. `bindgen_skip_c_flags` in
> `rust/Makefile` contains a pattern `-mstack-protector-guard%`, the % at t=
he
> end enables it to match all those 3 options at the same time, and
> `filter-out` function removes them before passing to Rust bindgen's
> libclang. Am I missing something here?

If they don't ever appear with gcc + llvm builds, that's fine.

> > Similarly, something like -Wno-unterminated-string-initialization could=
 cause a problem if gcc supports it but not libclang.
>=20
>=20
> Yes. However, this option is only about warnings, not architecture related
> and does not affect the generated results, so simply adding it into
> `bindgen_skip_c_flags` patterns should be enough, I think.
>=20
> > I think you're mostly better off catching that sort of thing in Kconfig=
, where possible and just make incompatible mixes invalid. What's actually =
incompatible is likely going to depend heavily on what options are enabled.
>=20
> Sounds better, I'll go down that path.

--SyMjmTdRNomxZcq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLl30gAKCRB4tDGHoIJi
0kP/AP9CtL+bSxb0+e1UR7kmpRdoVFQ8gp0n5r5uvuNmnl4EAAEAhso8p2VU8aLB
Z1AplovqHG+RP/1oJ11HofF9jAa44wA=
=5wPA
-----END PGP SIGNATURE-----

--SyMjmTdRNomxZcq3--

