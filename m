Return-Path: <linux-kernel+bounces-817579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B02B58408
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C63A876C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4B2D660C;
	Mon, 15 Sep 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaAH4njo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E95C96;
	Mon, 15 Sep 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958766; cv=none; b=vF2vQXFIO2HY/QI7mrt/Y1BCBa5vDEmClpbfGx1hjXhrdmJTogDwpXVe13hhNQWhbAKh06vRdFV5HxNGk73recWCvpeJwZkVmH3RYMA/ObRYMcEX3NoQk8uGkaGUO0TYOYMkBebi8KZZLtgSrRZNn0uPCTDRFs3+fCr9dHZI9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958766; c=relaxed/simple;
	bh=2F0ZJ89HUHqGVIETYaRZWiY+IljshdZlHdUkoTWThoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+SG4eON2eFm0bvk0UcTrme8DGagQ6hj+g/JBKQFUcKT8YvupNjehE2wHI/YKie4IRT8aLa2yEpAxUV5cyJbePfEHz49qQsjxTB4oBmmvaKr4iUIXd4Wc5T/IwfzHaD5rKfc95khXjmGRz8ToDpzxm5LwOfxAavbDOMh47f586I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaAH4njo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87912C4CEF1;
	Mon, 15 Sep 2025 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958765;
	bh=2F0ZJ89HUHqGVIETYaRZWiY+IljshdZlHdUkoTWThoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaAH4njo5Z15ZoDOzLXqATnsPXTYVyKeV+kHqEs3nzF9Xwm5zjLgfDF5Yva7lUvgW
	 VxJ2dInE37IXlXQ0LSqKIroCEqKOyxhSTs7bGTeKx5eK0MHpNEvtHUHjKAfrJFIKrZ
	 bA4Z6dKNa9O3Y02bTC45W9BzLwdfm3hwL0J8qowBVBSZV+HWrgSkggx+v3FVrB45aN
	 rvs+W/+1YWD7O8PslW0k3sq4MrLGKWek1MUz96UvyELqlWvXF1U8PCBuWbCmCXmHFR
	 3PjAuukKMKsDD5nmu12VeHqFjXotno0q9qr115wmSG2Op2V2ryE9djjcwamkwysnet
	 ilQQ1JM82desg==
Date: Mon, 15 Sep 2025 10:52:44 -0700
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
Subject: Re: [PATCH 7/7] riscv: Kconfig.socs: Add ARCH_TENSTORRENT for
 Tenstorrent SoCs
Message-ID: <aMhSbIvjwz2J4KCx@x1>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-7-ddb0d6860fe5@tenstorrent.com>
 <20250915-overeater-escalator-9ed8a77d809d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8o+hXkmY9sgaWHy"
Content-Disposition: inline
In-Reply-To: <20250915-overeater-escalator-9ed8a77d809d@spud>


--a8o+hXkmY9sgaWHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 05:48:06PM +0100, Conor Dooley wrote:
> On Sat, Sep 13, 2025 at 02:31:06PM -0700, Drew Fustini wrote:
> > From: Drew Fustini <dfustini@tenstorrent.com>
> >=20
> > Add Kconfig option ARCH_TENSTORRENT to enable support for SoCs like the
> > Blackhole A0.
> >=20
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
> >  arch/riscv/Kconfig.socs | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 61ceae0aa27a6fa3a91da6a46becfd96da99fd09..ff733a998612d429e7b1e00=
276eb86290d8331a3 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -57,6 +57,14 @@ config ARCH_SUNXI
> >  	  This enables support for Allwinner sun20i platform hardware,
> >  	  including boards based on the D1 and D1s SoCs.
> > =20
> > +config ARCH_TENSTORRENT
> > +	bool "Tenstorrent SoCs"
> > +	help
> > +	  This enables support for Tenstorrent SoC platforms.
> > +	  Current support is for Blackhole P100 and P150 PCIe cards.
> > +	  The Blackhole A0 SoC contains four RISC-V CPU tiles each
> > +	  consisting of 4x SiFive X280 cores.
>=20
> Can you add this to defconfig too, so that it gets build by default in
> that configuration?

Sure, will do.

Thanks,
Drew

--a8o+hXkmY9sgaWHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaMhSawAKCRDb7CzD2Six
DGUXAQC+RY4uE7ZpwUFudLLQ/jXUQovWxEkEMCutkX0fGy9P9wD+IGwUXbjpeIN2
xH1EPpshHbgaoEiOti2tWAPGn8aczQc=
=jFZn
-----END PGP SIGNATURE-----

--a8o+hXkmY9sgaWHy--

