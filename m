Return-Path: <linux-kernel+bounces-787118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73181B371A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93F47B35E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51B265CB2;
	Tue, 26 Aug 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqzxHFB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA61A704B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230379; cv=none; b=YKmD0T26SdSzBEe2ZaZcKXEFO34rx3pj+8hwSDx2dGGC6eQ9pTeI0BR2p9C5V09Xwz8FfmhGENdpSXTlP5Rk5lWhJCJyXHr7fiTBebCNyFXewysokOn91+MliHgzXR8B6lJvMNR1CQ8VRINyQFUNLzJTWxNqnSS/KZjdPR+d7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230379; c=relaxed/simple;
	bh=ITt90kpmmeDMeUFwRnkeVdhCWAM4V8MY6rHrGixc0WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJfW/iJNYdeG6IhlxG/h3e3gcm+Vujenqf+Xeq6e0viqHU14ImSuPSrs00xH/jIFzTFYQuoSRFGD9FQ5v3W9nPqGH9NWVSrjyPHh/kNdNWu10NSrTTniCyOj/HP1qeMC024pP2Y5jzVZCp30gOl6Y2aAJpc12h8QGQdwrSqpoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqzxHFB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A800C4CEF1;
	Tue, 26 Aug 2025 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230376;
	bh=ITt90kpmmeDMeUFwRnkeVdhCWAM4V8MY6rHrGixc0WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqzxHFB5RosrS8ENluWDmbu8kBd1gzFDLzLCu7GM6Phd2mXFdacNhxNSISmmkoF7Z
	 g3CWqwpvqTU3+OYu6CIFmV5xcgt1f7Huf6wU3F9sOnMMRfO0DB+lMdlvUILbSli0hL
	 xbaR7/Cn/hGfenf33Fy9nJV1Q9g96hSUikd8GX70dmAVP6TlTj3ub4W29LmNYe8TY6
	 gzKUQdvolulosCT/+ZetsmKLqwPmdi3v+xxPHiQT7/T4JLORwGkjVYZxe6DVt4ACoZ
	 xVclhu+N1VSDmWVOEiQarhnpx0mRmDzLwzgODYuTP9kiKStyuODMSjFhZN/GRr/KqF
	 eqgSQ3BBS7ltg==
Date: Tue, 26 Aug 2025 18:46:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] riscv: Add Zalasr ISA exntesion support
Message-ID: <20250826-dullness-seventy-c93e7c8479d0@spud>
References: <20250826145740.92276-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecRtX6R0aqjkVC7D"
Content-Disposition: inline
In-Reply-To: <20250826145740.92276-1-luxu.kernel@bytedance.com>


--ecRtX6R0aqjkVC7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:57:36PM +0800, Xu Lu wrote:
> This patch adds support for the Zalasr ISA extension, which supplies the
> real load acquire/store release instructions.
>=20
> The specification can be found here:
> https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc

Why is this an RFC?
Is the RFC tag related to how you have not CCed all relevant mailing
lists and maintainers?

Cheers,
Conor.

>=20
> Xu Lu (4):
>   riscv: add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: Instroduce Zalasr instructions
>   riscv: Use Zalasr for smp_load_acquire/smp_store_release
>=20
>  .../devicetree/bindings/riscv/extensions.yaml |  5 ++
>  arch/riscv/include/asm/barrier.h              | 79 ++++++++++++++++---
>  arch/riscv/include/asm/hwcap.h                |  1 +
>  arch/riscv/include/asm/insn-def.h             | 79 +++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c                |  1 +
>  5 files changed, 154 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--ecRtX6R0aqjkVC7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK3y5AAKCRB4tDGHoIJi
0vCDAP4y+UC6BToxZJGgQ7KuD1FhxqpyWwUg0+wokTRKOXBkXwEAurnvoIBSfisz
w+JIFLhc1tPLgjoOm25xDqppolc7mwc=
=Owt8
-----END PGP SIGNATURE-----

--ecRtX6R0aqjkVC7D--

