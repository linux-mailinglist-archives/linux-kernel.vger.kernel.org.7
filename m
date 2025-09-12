Return-Path: <linux-kernel+bounces-814574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E7B555C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0315C44B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BFE329F31;
	Fri, 12 Sep 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge59Wiow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70424BCF5;
	Fri, 12 Sep 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699954; cv=none; b=M9JUaIchhSnDvBfojxj7kZkH5la0CsRnnT/5eew7wLIy5um7YPuL+Haf3An2fMKRDcFOFhb0QYuCHwkFMONgQeC4tn5jckIprxZr3CntoZDGobkOehMXX8qh+MasNwj6Gt6Lz3nMuyMM/atHm2PDsqKSFpgIG5o/iIqvlNH51vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699954; c=relaxed/simple;
	bh=NAZECHrYbl8mxswXcbpWQ0UVEYqlvkhivcyRhkS4tyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brmQuz0VrpoH/tFauPd0TBhpYlY+NNXCIcqTvN1eqzh5xQu4XTps6zdlP9SQb++SNaKJGMm1Wg4NzNJTj5LrRdrfJWIpS/+s4cznwRlZZ0lzqMakIFx4v350e+JHo7K38TfmeRX+UrVT78SSNU7yesPOe3qilfFQNMlSX7zDVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge59Wiow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951C1C4CEF1;
	Fri, 12 Sep 2025 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757699953;
	bh=NAZECHrYbl8mxswXcbpWQ0UVEYqlvkhivcyRhkS4tyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge59Wiowz9H3gLLSBo+dahVii80E4/vECJFWZRQtbtJuN3j362S/DYM+Ud0xxogdZ
	 ioX3k4fSM4b4azMmh0t5h3FGFQqSfZoa4lN5bokDbvlL0c0ZBU1fLzG+iQ30SasfjF
	 SFvYpABBc/aam/TRXxq9hTzO9kDkHnFSDWf5Ydq9mU8yJLsmIUo0XxwOjouN8p6XYh
	 3dfjmZhHG1iECE2MxRKFaHwu1n86HehG1gQ3GRSYoZEW+ZMrHclf04H7w9F67fX97P
	 lNJNZYd2A5ugopVoAcoT2QzVg/XQOU+xa7Y0TG8U8sPnxJAwc28nQIUHjsLYBTYIVO
	 7VILswe79csvw==
Date: Fri, 12 Sep 2025 18:59:08 +0100
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
Subject: Re: [PATCH 3/3] riscv: dts: thead: add zfh for th1520
Message-ID: <20250912-verdict-croon-81ac20e5b621@spud>
References: <20250911184528.1512543-1-rabenda.cn@gmail.com>
 <20250911184528.1512543-4-rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5pIc3q2NffjnH9i"
Content-Disposition: inline
In-Reply-To: <20250911184528.1512543-4-rabenda.cn@gmail.com>


--b5pIc3q2NffjnH9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 02:45:28AM +0800, Han Gao wrote:
> th1520 support Zfh ISA extension [1].
>=20
> Link: https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1737721=
869472/%E7%8E%84%E9%93%81C910%E4%B8%8EC920R1S6%E7%94%A8%E6%88%B7%E6%89%8B%E=
5%86%8C%28xrvm%29_20250124.pdf [1]

Could you please cite the section that this is detailed in?

>=20
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index 7f07688aa964..2075bb969c2f 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -26,7 +26,7 @@ c910_0: cpu@0 {
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
>  					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>  					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <0>;
> @@ -53,7 +53,7 @@ c910_1: cpu@1 {
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
>  					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>  					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <1>;
> @@ -80,7 +80,7 @@ c910_2: cpu@2 {
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
>  					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>  					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <2>;
> @@ -107,7 +107,7 @@ c910_3: cpu@3 {
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
>  					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>  					       "xtheadvector";
>  			thead,vlenb =3D <16>;
>  			reg =3D <3>;
> --=20
> 2.47.3
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--b5pIc3q2NffjnH9i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMRfbAAKCRB4tDGHoIJi
0gr1AQDn94lY15gXhvjAqX086W8aphAAVGa73ZrLqmyznyWS9QD/a6zFwVSlSV+C
TDWMts0ppc63CwGlT0Ixd1N2hyU89AI=
=Vc25
-----END PGP SIGNATURE-----

--b5pIc3q2NffjnH9i--

