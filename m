Return-Path: <linux-kernel+bounces-795158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E790B3ED9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A03207AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619AE3126CA;
	Mon,  1 Sep 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8vBZal7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0332F74C;
	Mon,  1 Sep 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749850; cv=none; b=nyr7XmPomrLE/nYZ/CDSJ7Aro7xahCSj8yGmNr8Za2EoZ6WdcKBcqDxi7K3vtGZI8Ihe5OGAGWtefgjJHUKk168SwAwVwczySAfJoK5O8a/rG6cT71mSLg53JBDsyvCZugmlTZQXL6WEAcOSOriV3dKiJgj2WwADbBhAGfvdTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749850; c=relaxed/simple;
	bh=zwinHe94I7iecJbYreV9AeCekiR8vSs0p/EGqzcbmSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jin5YdeN9+t4K5PRkEk1FztOZQXpqjr+QbVaMvH1IGyPtUCwVIlijmF8+r1kGM4TtI+fUcnFtay6myoA6699mo5q8dvUr+xEuvq2aV3ANILaxUrY3XD/p/yPMMcW5wgeirvYkzMkCPLz1D6DTFriDQtu7MIG2h9K3vkAJOdo8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8vBZal7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D458BC4CEF0;
	Mon,  1 Sep 2025 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756749850;
	bh=zwinHe94I7iecJbYreV9AeCekiR8vSs0p/EGqzcbmSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8vBZal7hXzzlZUAWTMkKxHucjp2VdjAU+JtfizvGhtZGZFphi7ziCNUwK4f/Xwcr
	 votHbQnovjd3W5nZyFZSa11jbxO1TWSILI7+Wg0X132JpN8beB/UG6RoGHbEJdR+ay
	 pNax/0uPNDbV9Bb0kDP+gy6It3z583Z80+XnQO0pOlDQ3dqRsFC3xhyzh0wXc/0pnh
	 RnqEqPYR5LG3JV0961Y3xmkCEkgKxvVHFxr8XwLFI+zPXkRBcycLEmb7PVmkvU9/Q1
	 CaXyG+ZbxEZY+OskNmXge1r/IZnGmZQKWdtIfJNhoz4H2MFukovLQ203QXTu5vZePs
	 mPqM4a930966g==
Date: Mon, 1 Sep 2025 19:04:04 +0100
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
Message-ID: <20250901-unseemly-blimp-a74e3c77e780@spud>
References: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>
 <20250830-cheesy-prone-ee5fae406c22@spud>
 <20250901-lasso-kabob-de32b8fcede8@spud>
 <b1734c45-42ec-46c7-9d4c-2677044aacab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AkOtiGMp+3MnnVkq"
Content-Disposition: inline
In-Reply-To: <b1734c45-42ec-46c7-9d4c-2677044aacab@gmail.com>


--AkOtiGMp+3MnnVkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 01:19:42AM +0800, Asuna wrote:
> > For example, there's a check in the riscv Kconfig menu to see if
> > stack-protector-guard=3Dtls can be used via a cc-option check. If that
> > check passes with gcc as the compiler that option will be passed to the
> > rust side of the build, where llvm might not support it.
> If I understand correctly, the `-mstack-protector-guard` option is already
> always filtered out by `bindgen_skip_c_flags` in `rust/Makefile`, regardl=
ess
> of architecture. Therefore, we don't need to do anything more, right?

That particular one might be a problem not because of
-mstack-protector-guard itself, but rather three options get added at
once:
	$(eval KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dtls		  \
				-mstack-protector-guard-reg=3Dtp		  \
				-mstack-protector-guard-offset=3D$(shell	  \
			awk '{if ($$2 =3D=3D "TSK_STACK_CANARY") print $$3;}' \
				$(objtree)/include/generated/asm-offsets.h))
and the other ones might be responsible for the error.
Similarly, something like -Wno-unterminated-string-initialization could
cause a problem if gcc supports it but not libclang.

I was doing some debugging today of another problem, and was able to
trigger both of those errors with llvm-21 and libclang-19, so they
definitely have the potential to be problems if there's a mismatch - I
just don't know how many of those issues affect a mixed build with rustc
and the gnu tools, mixing llvm and libclang versions already produces
a warning about it being a Bad IdeaTM (a warning that I think should be
an error).

> > Similarly, turning on an extension like Zacas via a cc-option check
> > could pass for gcc but not be usable when passed to the rust side,
> > causing errors.
> That makes sense. I might need to check the version of libclang for each
> extension that passes the cc-option check for GCC to ensure it supports
> them.
>=20
> > These sorts of things should be prevented via Kconfig, not show up as
> > confusing build errors.
> I'm working on a patch, and intend to output an error message in
> `arch/riscv/Makefile` then exit 1 when detecting an incompatible
> gcc+libclang mix in use.

I think you're mostly better off catching that sort of thing in Kconfig,
where possible and just make incompatible mixes invalid. What's actually
incompatible is likely going to depend heavily on what options are
enabled.

--AkOtiGMp+3MnnVkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLXgFAAKCRB4tDGHoIJi
0vCjAP9XpUu0gZJFGClhFW08NaPGYzrYfD/xehn63LD+qZ9tGAD+MdqLLUS+oZBD
s1T033qGogkbVo+ABtc/Vm35qcP+EQ4=
=IQ1t
-----END PGP SIGNATURE-----

--AkOtiGMp+3MnnVkq--

