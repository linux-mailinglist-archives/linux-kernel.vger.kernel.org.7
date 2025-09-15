Return-Path: <linux-kernel+bounces-817463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94279B58285
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9DC2A2DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324E264A9E;
	Mon, 15 Sep 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9XFcap1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF90269CF0;
	Mon, 15 Sep 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954894; cv=none; b=TdX6s0FKhQ/+QiTKznmFjD/RclGDEEXUJcSVg1ipz+mYHTCuNY5rrx5O82kJL+mQrEivyI8dsKCA1cohfy86Q83xyVUkc1P7ByH0Z3LZfJO2Df8cbpaJ5iWFkGU/ekLXKo7icLh1e/yqPSe0YFPD7yDf0N3E8jHCOgLgF/580oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954894; c=relaxed/simple;
	bh=WQA8yZXJ9fX2DhH1V6vZEYWM0tWKWwWe9hNuujBFV00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou9zN2sLtZhfMp42L3esMRmvmGzNfMSBPxm1Udu3vw1fj89Ym1mppVlnNu3BRzDoCe4ZX9YBFKDoHJBfjAf1G8Lb6EKXgBUykIhGRzaks7q3hrelBUxk8WRl11pC9+tQK+IwTw8GMwjY4AMrNbNUtUUEPGQu9xNCYfUIugV1WTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9XFcap1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C3C4CEF1;
	Mon, 15 Sep 2025 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954892;
	bh=WQA8yZXJ9fX2DhH1V6vZEYWM0tWKWwWe9hNuujBFV00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9XFcap1I2mhRx2afrhKhwgXGsLL9QcZAZI7rOuicb4bHC8CxFEguFgM1pnq0DBog
	 9PQ4H/4ke6cimoXAWQktcOl4mbrTVjKXfHQ9Wa/EmjaQTk7YCXGZ4DfELKCygU7tKd
	 TprEcrcCgAb2XTnMNuNTTE3xQBW0z3MyAiRqhxod2t6+05ON2orc3kj4yyoIOobt5F
	 sDoDTufGBkEM8ijYcwlZ1zq4UrgKtkAJwMHhpTtlv89I3OqIvGLKyaMmd+WitWvjoH
	 fNHuzzRFRDh8BATAQWtFUNTCFzBWmckIxAqRoGAbF06JoO3pVix6RsqVmI4LxPq9Wg
	 K5KCYzWXHJJcw==
Date: Mon, 15 Sep 2025 17:48:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
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
Message-ID: <20250915-overeater-escalator-9ed8a77d809d@spud>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-7-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHMJMGHJfC+NtBBa"
Content-Disposition: inline
In-Reply-To: <20250913-tt-bh-dts-v1-7-ddb0d6860fe5@tenstorrent.com>


--cHMJMGHJfC+NtBBa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 02:31:06PM -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
>=20
> Add Kconfig option ARCH_TENSTORRENT to enable support for SoCs like the
> Blackhole A0.
>=20
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  arch/riscv/Kconfig.socs | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 61ceae0aa27a6fa3a91da6a46becfd96da99fd09..ff733a998612d429e7b1e0027=
6eb86290d8331a3 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -57,6 +57,14 @@ config ARCH_SUNXI
>  	  This enables support for Allwinner sun20i platform hardware,
>  	  including boards based on the D1 and D1s SoCs.
> =20
> +config ARCH_TENSTORRENT
> +	bool "Tenstorrent SoCs"
> +	help
> +	  This enables support for Tenstorrent SoC platforms.
> +	  Current support is for Blackhole P100 and P150 PCIe cards.
> +	  The Blackhole A0 SoC contains four RISC-V CPU tiles each
> +	  consisting of 4x SiFive X280 cores.

Can you add this to defconfig too, so that it gets build by default in
that configuration?

> +
>  config ARCH_THEAD
>  	bool "T-HEAD RISC-V SoCs"
>  	depends on MMU && !XIP_KERNEL
>=20
> --=20
> 2.34.1
>=20

--cHMJMGHJfC+NtBBa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhDRgAKCRB4tDGHoIJi
0jQrAP9Vn6YoN51FdwADMapdbRnnjWP3M9R8PvkSA2d0UeID9wD/Wk2sTq4sKW2f
ptcxToCfzx9hY/tmsSUCi0aw0dNKkAk=
=ii9g
-----END PGP SIGNATURE-----

--cHMJMGHJfC+NtBBa--

