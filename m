Return-Path: <linux-kernel+bounces-849134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07CCBCF468
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9652B189E262
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB3265CB2;
	Sat, 11 Oct 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWbg/PO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478A1A4E70
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182120; cv=none; b=uymB2K+WwkQuYH7NrMjwF2DImQVZvBEl3zUAfo6q+z+1t4xfWRAmMXwzuPTmfV5ntCq2q58dAuF79Q2d4J/0iIjgqo2Es14NZaWpU83N2UZWdo5QeGeJ8lluBegRk6FPNC0NxlQhHfFC2dH1N5e2z5S6VXBRLTcHthwMwSqj5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182120; c=relaxed/simple;
	bh=fFZME1Zq/TXDxklk7L6f3c4lY/X0+FFz/z5+NJU4maM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn4ZYBSSwODKwIj/45WifYb6j+3vCVMRmG2PKlsD7G0A0lOOBPPhbLqW86XxdpB6g4QnoOld9TaNbyJzOKiq/Cyd0zXGYADwWrmscMWzr6mpTXKAKt7kIK+ndmgdydyucm15pfsjra41flQfQrF3SSxSb0gJZ0W5Uq+tbDg9SrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWbg/PO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DAFC4CEF4;
	Sat, 11 Oct 2025 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760182120;
	bh=fFZME1Zq/TXDxklk7L6f3c4lY/X0+FFz/z5+NJU4maM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWbg/PO6DKqYeIhDmuS9m2hcwXXkiKPyE8jwsI3vfAVuJDsE7Jx5Effz0U7JHvEJ3
	 ckmJ9Ib7hyS/MX/clqQfP0zzVkOqYhAnjOOWUFFGCAOWkolsDFjGZbkoYptNSKaXZK
	 sJ5ZAWl53+Cl5VOw4bhFlR9mqOuNj2v5ZLavQt1wr3qn1IN17dBtaaX1aFttVa+xul
	 KrvnC2DG7uum+2d6s+iD7uuZNkCH5JG3Se+VgPvN9nJL/2UI993wRLLtNczDz5/GEf
	 Zxf/LQ6BNpHI8WFbLFJJs1UL/edi6UCHmSJR+JNQ6oFInPASAG+AUoacQsVvrqYTy8
	 mp8vTsFzu6NQg==
Date: Sat, 11 Oct 2025 12:28:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Paul Walmsley <pjw@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	Vivian Wang <uwu@dram.page>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] riscv: Use __riscv_has_extension_{likely,unlikely}
Message-ID: <20251011-buffing-never-4911edc10600@spud>
References: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hJqoiJHTRSDkGTYh"
Content-Disposition: inline
In-Reply-To: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>


--hJqoiJHTRSDkGTYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 07:35:42AM +0800, Vivian Wang wrote:
> There are about a dozen uses of asm goto in arch/riscv just to select
> between two code paths with the alternative mechanism. Convert them to
> the existing helpers __riscv_has_extension_{likely,unlikely}.
>=20
> In each case, I have preserved the existing code's choice of asm goto
> pattern while picking between "likely" and "unlikely", namely:
>=20
>   ALTERNATIVE("j %l[no]", "nop", ...)   -> "likely"
>   ALTERNATIVE("nop", "j %l[yes]", ...)  -> "unlikely"
>=20
> Since the helpers are just implementations of these patterns, the
> performance should be the same as before.

Can you explain why you're opting for the __ variant, instead of the one
without __? They should do the same thing in your cases, and resolve to
the alternative, since the non-alternative function call will be
unreachable and the assert is compiletime. There's currently no users of
the __ prefixed versions outside of other extension detection helpers, and
I think it should probably be kept that way if possible.

>=20
> These patches are also available at:
>=20
> https://github.com/dramforever/linux/tree/riscv/altn-helper/v2
>=20
> ---
> Changes in v3:
> - Rebased on riscv for-next
>   - Resolve conflict, use ALT_RISCV_PAUSE() in moved lines
> - Link to v2: https://lore.kernel.org/r/20250821-riscv-altn-helper-wip-v2=
-0-9586fa702f78@iscas.ac.cn
>=20
> Changes in v2:
> - Cc'd authors who initially introduced the asm goto blocks
> - Use existing __riscv_has_extension_{likely,unlikely} instead
> - Remove bogus comment for Zbb being likely (checksum)
> - Restructured patch to minimize diff (bitops, hweight, cmpxchg)
> - Link to v1: https://lore.kernel.org/r/20250820-riscv-altn-helper-wip-v1=
-0-c3c626c1f7e6@iscas.ac.cn
>=20
> ---
> Vivian Wang (5):
>       riscv: pgtable: Use __riscv_has_extension_unlikely
>       riscv: checksum: Use __riscv_has_extension_likely
>       riscv: hweight: Use __riscv_has_extension_likely
>       riscv: bitops: Use __riscv_has_extension_likely
>       riscv: cmpxchg: Use __riscv_has_extension_likely
>=20
>  arch/riscv/include/asm/arch_hweight.h | 24 ++++++----------
>  arch/riscv/include/asm/bitops.h       | 32 ++++++---------------
>  arch/riscv/include/asm/checksum.h     | 13 +++------
>  arch/riscv/include/asm/cmpxchg.h      | 12 +++-----
>  arch/riscv/include/asm/pgtable.h      | 15 +++++-----
>  arch/riscv/lib/csum.c                 | 53 ++++++++---------------------=
------
>  arch/riscv/mm/pgtable.c               | 22 +++++++--------
>  7 files changed, 53 insertions(+), 118 deletions(-)
> ---
> base-commit: cd5a0afbdf8033dc83786315d63f8b325bdba2fd
> change-id: 20250820-riscv-altn-helper-wip-00af3a552c37
>=20
> Best regards,
> --=20
> Vivian "dramforever" Wang
>=20

--hJqoiJHTRSDkGTYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOo/XgAKCRB4tDGHoIJi
0jvdAQCIqf7X54DcteMBhDN+nrmCddguGzCLjFJhHeX2dEqxsgD9FcS8maAfQ5mV
37ddsRUOuxb+6L24yupPTTl++SiuvQ8=
=7YcE
-----END PGP SIGNATURE-----

--hJqoiJHTRSDkGTYh--

