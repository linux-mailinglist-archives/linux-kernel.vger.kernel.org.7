Return-Path: <linux-kernel+bounces-819435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73125B5A097
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2767585899
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7632C0F84;
	Tue, 16 Sep 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/dzIpvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386414E2E2;
	Tue, 16 Sep 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047767; cv=none; b=ltE7FYe739sGOpO1A0dA3n4zaK7oO9IkaG/gmENHc2G/PHRXSxrd6p+PsQeWA3AnjJE+d6VtpFjNbBx7J61+4CXjjW9XtR1ca/MbtTS1eDmJ0+1wnYPFvxeIqk85OHwjT0QuIOzotWIHD1UkAt7EosandlTnOfJXaL3pWJ8V5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047767; c=relaxed/simple;
	bh=mHVkIV4tL9Rda/ZarYcZ290uoCuLvSzpJ80gAfOXuEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7sES2GnIqLaqPLA/6MfACddmVpjfr4NkdlyytRCWdT0PB8wrS1oNTj4oEeSAqQ1TE0gRF8WhLLqQw/ywpoLVnh708r/MeeUsPyTqevuLgCotaTgfQlKow65hdqKTu656arMDilYkp/Pao0Wn56QV0Cmv9G5ulDqTdt/X36sknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/dzIpvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D081AC4CEF0;
	Tue, 16 Sep 2025 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047767;
	bh=mHVkIV4tL9Rda/ZarYcZ290uoCuLvSzpJ80gAfOXuEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/dzIpvoyd6EvdfR20kPcrLEC6vsoQbOs/RrSP5qvaQXZbwUeTRbXW1sjo20E7HqO
	 UXS+/57GbnY8vvB07UPvR7ONlWhF3UX1zQmjs3hPfMY+s/8xAUzRR7yp48i3ubcoOO
	 LQAaUzLDYRVxo6v+mKRy4gzt7pafTO1QP5Ks5q8fOc9LQp6DIfdEdcs61N4B6pvp9X
	 KiCguWfbcwuVwTGY4q1sNqwRhyLUeCKt/FAUpoe1nt/j9+ET0J3nAyUq135Wh+YvR0
	 YhounW9R5QJvEGlP8wqRLH4+Ub4DbqUAznnceT52Y6BpEJ5SfYg9vh4oCu7lgkeNVD
	 yXAYP7BYncyoA==
Date: Tue, 16 Sep 2025 19:36:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: Add Ssqosid extension
 description
Message-ID: <20250916-landfall-easeful-782b60eb7d69@spud>
References: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
 <20250915-ssqosid-v6-17-rc5-v2-1-2d4b0254dfd6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FU1bsTvOEaaQEW9g"
Content-Disposition: inline
In-Reply-To: <20250915-ssqosid-v6-17-rc5-v2-1-2d4b0254dfd6@kernel.org>


--FU1bsTvOEaaQEW9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:13:41PM -0700, Drew Fustini wrote:
> Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
> extension v1.0.
>=20
> Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index ede6a58ccf5347d92785dc085a011052c1aade14..38e3d8d38cce55022ea70eb52=
423b1163e3cb097 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -165,6 +165,12 @@ properties:
>              ratified at commit d70011dde6c2 ("Update to ratified state")
>              of riscv-j-extension.
> =20
> +        - const: ssqosid
> +          description: |
> +            The ratified Supervisor-mode Quality of Service ID (Ssqosid)
> +            extension v1.0 which adds the Supervisor Resource Management
> +            Configuration (srmcfg) CSR.

Please cite when it was added, as is done for other extensions.

> +
>          - const: sstc
>            description: |
>              The standard Sstc supervisor-level extension for time compar=
e as
>=20
> --=20
> 2.34.1
>=20

--FU1bsTvOEaaQEW9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMmuEQAKCRB4tDGHoIJi
0ko0AP4y/Tm22kiiCODnBOJhdTw0+XbdBqYIFr7KJlQpw/Kk/wD/WygUmJ+J8TFO
g9bt9U9BwC0FQdrnHRefqDL3JtQtQQ4=
=UDCY
-----END PGP SIGNATURE-----

--FU1bsTvOEaaQEW9g--

