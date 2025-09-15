Return-Path: <linux-kernel+bounces-817577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC59B58403
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D992A0DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C529DB99;
	Mon, 15 Sep 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGFtRFFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C62857F2;
	Mon, 15 Sep 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958733; cv=none; b=mW+JQ6W8P/fTk2oyXClOiibtv2RI5lxNL2PeuV5v1Qmm0r1v1iEUOJKIuKBC6ACQTOCv7lluoAHwNQzvYmMF+k1P3pFRzFj0rstDIXCfMYbfu89XY1X9db9N1PY7WKVmvqnyyVeaUpc9jsVlX3+VSMJUls00vW22CGO8Mb9hb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958733; c=relaxed/simple;
	bh=GY/cjv6c1PVfRCGBIc8RNi9uaVExam9Ygo6g40J/0Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV7IYPThW1SZOU9IXCYe7RlVIXo5HyJsrjzeXAOAr8D5dYZxNqJDrXSbYHuMbq0AY+8uGY+nqHO3oqfpEV/uqh1xqBIZL/mVyRUO5i7UUaWJgaYtcaJG6j0J1ILEdTswYIQL1SnDpf9RQaObmCPgs+N6Wv1c8reTbIzfZp5XQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGFtRFFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA69C4CEF1;
	Mon, 15 Sep 2025 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958732;
	bh=GY/cjv6c1PVfRCGBIc8RNi9uaVExam9Ygo6g40J/0Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGFtRFFITkNXVYjH2I0j0HVurK6zMABxDqrusB4ZhGmIrIBBSiC7+pObxmH02Bw8Y
	 q0Lto6u6JbAcg1/EpFRiTRjBTcZVdSwKg0jSRccDFwCsO9pEmltKFLMBjjxYDQGXyu
	 s+mPUJ1zetFlnA8pYHAJXkSQPsVwvbAEx+vtrHnF23c6JFzKZIkT7034/paCDvnxdZ
	 wUuhzMfthGKQiHfhqH67kV7RfSLmysKwzZ0NxyfiTlhotlrjtJFSp+eygXZuzpqj4B
	 sUojLoE+ktgDve7eBVgbso+8i/s2KqJTVs2LDjXFXAWBsaltOUukxxj93XtIKjw9AP
	 ZJxHWerU4X8Sg==
Date: Mon, 15 Sep 2025 10:52:10 -0700
From: Drew Fustini <fustini@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>,
	Joel Stanley <jms@tenstorrent.com>, Joel Stanley <joel@jms.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH 6/7] riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe
 cards
Message-ID: <aMhSSka3gyIcND/L@x1>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-6-ddb0d6860fe5@tenstorrent.com>
 <20250915-mouth-banner-ddfb2e48bdb3@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="epd8RCdqG9ORGx07"
Content-Disposition: inline
In-Reply-To: <20250915-mouth-banner-ddfb2e48bdb3@spud>


--epd8RCdqG9ORGx07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 05:47:08PM +0100, Conor Dooley wrote:
> On Sat, Sep 13, 2025 at 02:31:05PM -0700, Drew Fustini wrote:
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b2b08023643a2cebd4f9245=
79024290bb355c9b3
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/dts-v1/;
> > +
> > +#include "blackhole-a0.dtsi"
> > +
> > +/ {
> > +	model =3D "Tenstorrent Blackhole A0 SoC PCIe card";
> > +	compatible =3D "tenstorrent,blackhole-a0-card", "tenstorrent,blackhol=
e-a0";
> > +
> > +	memory@0 {
> > +		device_type =3D "memory";
> > +		reg =3D <0x4000 0x30000000 0x1 0x00000000>;
>=20
> This isn't at address zero as the node address claims.

Thanks, I'll fix the unit address.

>=20
> > +	};
> > +};
> > diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi b/arch/r=
iscv/boot/dts/tenstorrent/blackhole-a0.dtsi
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..517b6442ff0fe61659069e2=
9318ad3f01bc504e2
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +// Copyright 2025 Tenstorrent AI ULC
> > +/dts-v1/;
> > +
> > +/ {
> > +	compatible =3D "tenstorrent,blackhole-a0";
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	cpus {
> > +		#address-cells =3D <0x1>;
> > +		#size-cells =3D <0x0>;
> > +		timebase-frequency =3D <50000000>;
> > +
> > +		cpu@0 {
> > +			compatible =3D "sifive,x280", "sifive,rocket0", "riscv";
> > +			device_type =3D "cpu";
> > +			reg =3D <0>;
> > +			mmu-type =3D "riscv,sv57";
>=20
> > +			riscv,isa =3D "rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_sscofpmf";
>=20
> What's the benefit of retaining this property?

Nothing depends on the legacy isa property so I'll drop it.

>=20
> > +			riscv,isa-base =3D "rv64i";
> > +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicsr",
> > +					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
> > +			riscv,cboz-block-size =3D <0x40>;
>=20
> cboz block size, but no zicboz in your extensions list?

My mistake, the core does not have CBO so I'll drop this property.

Thanks,
Drew

--epd8RCdqG9ORGx07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaMhSRAAKCRDb7CzD2Six
DGbvAQCjny2kDWZcvX8nIkeo10FVBexoproAQqTYdLJgrg8BpwD+LWnC/ty998Pw
OV40oqnmYdANreDohNTKKi+bgOiNIgw=
=bqJY
-----END PGP SIGNATURE-----

--epd8RCdqG9ORGx07--

