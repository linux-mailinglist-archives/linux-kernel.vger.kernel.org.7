Return-Path: <linux-kernel+bounces-814572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA01B555BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0D77C32D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD62A32A80A;
	Fri, 12 Sep 2025 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvj/gePE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EF329F31;
	Fri, 12 Sep 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699845; cv=none; b=Or2h86OOk/4m1KFsNwg0Os14Pt/yRv5WKbTxChxCV0h0quPBlpskBbm521j0VB1cXTmbntL9RvSZRE5D2jrkA5Yh6jyn3uQ7LHsX6SD9lUgCtwHSiVsqCw9crvoOmPWZme4JEOOjk3qY1XfqdkQJ9o4AfHdibIiF62b/QDkKF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699845; c=relaxed/simple;
	bh=KPNrAy13TtrhHaKH+3BYicgz+OHEulIoe7vBIpR0wXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmSpNtTjgrY34fVvQ1Ozd3ALony7AlesmeTw5etIn/ClddCdYpxVlxDSFaKvKuBm8Iotq+/mRX4VFa0sE3jz6lOCDfE8vyaJ5jeY3Kqcd3S5LAQznIWt3lmrm3ipgvP47T6bNdz31FKCBCteZ0McK2pAF9qvQbgXSwbrHH3t5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvj/gePE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D36AC4CEF1;
	Fri, 12 Sep 2025 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757699844;
	bh=KPNrAy13TtrhHaKH+3BYicgz+OHEulIoe7vBIpR0wXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvj/gePELH1Mire0C2L0UVcM9BdbqCs1qcb4DQkquNBdn46i5uoO8iJqr7N6PclWw
	 D+OZqTZ2cwvoylHY/NLWq2Djtem7HLrAcO5xshI8slUOUd5TSwEZNTpAutOWh6i0RR
	 MMBz7w4XQkH2gIZuhvIQZPIM7Y+ByzDNqbxe3+VQ3OqgfZNjTjrwtkvaJQaW0wAPPE
	 crjVFDER+/JXhOe5fQHNh0JdoijthKgYiVUGGyOQL3MyxX3dZjiPYASm+D2sWE0j+m
	 DriIFN5FgLhZyPALuwi0oS/vCIAaI7Vkvw7TrN0XavPhwK4GRzqB9HmlHWjgnPun5r
	 JbNU9uu63eGSw==
Date: Fri, 12 Sep 2025 18:57:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>
Cc: devicetree@vger.kernel.org, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 2/3] riscv: dts: thead: add ziccrse for th1520
Message-ID: <20250912-gander-fox-d20c2e431816@spud>
References: <20250911184528.1512543-1-rabenda.cn@gmail.com>
 <20250911184528.1512543-3-rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ckPI/e1OOmzor027"
Content-Disposition: inline
In-Reply-To: <20250911184528.1512543-3-rabenda.cn@gmail.com>


--ckPI/e1OOmzor027
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 02:45:27AM +0800, Han Gao wrote:
> th1520 support Ziccrse ISA extension [1].
>=20
> Link: https://lore.kernel.org/all/20241103145153.105097-12-alexghiti@rivo=
sinc.com/ [1]

I don't see what this link has to do with th1520 supporting the
extension. The kernel supporting it has nothing to do with whether it
should be in the dts or not. A useful link would substantiate your
claim.

> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

You only need to sign this off once.

Cheers,
Conor.

> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index 59d1927764a6..7f07688aa964 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -24,8 +24,10 @@ c910_0: cpu@0 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm", "xtheadvector";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <0>;
>  			i-cache-block-size =3D <64>;
> @@ -49,8 +51,10 @@ c910_1: cpu@1 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm", "xtheadvector";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <1>;
>  			i-cache-block-size =3D <64>;
> @@ -74,8 +78,10 @@ c910_2: cpu@2 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm", "xtheadvector";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <2>;
>  			i-cache-block-size =3D <64>;
> @@ -99,8 +105,10 @@ c910_3: cpu@3 {
>  			device_type =3D "cpu";
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm", "xtheadvector";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <3>;
>  			i-cache-block-size =3D <64>;
> --=20
> 2.47.3
>=20

--ckPI/e1OOmzor027
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMRe/wAKCRB4tDGHoIJi
0gr6AQC0Z3lIIyuKe12SKlVpEupoqew2hhyVZcMRuRiWOky/wQEA/ZDm+1HCT2Mo
FCAHgHH2tK0RawGHqwpkhre5TmmsQwc=
=V2ZA
-----END PGP SIGNATURE-----

--ckPI/e1OOmzor027--

