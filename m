Return-Path: <linux-kernel+bounces-753778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02BFB187C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F272E5646F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CC28D82F;
	Fri,  1 Aug 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwqNxYPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380471F03C5;
	Fri,  1 Aug 2025 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076694; cv=none; b=I46VBfIfx2M782EG5c7sFZhtfwSZ2g9eyU+lXfVgqB5s5RVkUZX2qGCMgwf+l1ezbOCWPa+BLX16PcKnoAtOedPQpTXg35OdYt08X1iEwSkhmMq7tQyoXDMO44J+BGCa2gNsN+MWyCxmmREVvLdnsDo7hNE1QWlsV04GgCrYEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076694; c=relaxed/simple;
	bh=TcZbBZapmGQ0Rnr4BOG6Vs70nByafs6BaT3xqjgKgEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9vto6Zoi8gWU5JHY8IgNI1d/3NfRzP/jTws2d9qhjwooGgcWWdhzBrui0E1+GktHi+DBlGkzyVlu9D1jCp99qRJF/0ZbpaO2ajeyoWpzPgPbANQqMStkXJUa1SnAxInT7V0AMxZpjAHOMbX9TqRad37P0IO2MdMXp3Lkea1IOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwqNxYPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC65CC4CEE7;
	Fri,  1 Aug 2025 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754076693;
	bh=TcZbBZapmGQ0Rnr4BOG6Vs70nByafs6BaT3xqjgKgEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwqNxYPlEHQsXABuSbTPq9ikmDFweJrimgwN1Y/Be9zFSZ6otUuhGupkJ6CIMx9Os
	 ZHYkFwVXVozwzR/MiewKAJ3vFLxQIt63C06Q2sltPkBXQherTpWHpva7w82k9gxSSu
	 ADp0ixEkbF4ck5W/DoSPTfLE8NimYG0cxI8DrTjyFbbfgIe+2+EidLNFg/GxCzo4tz
	 GYLWZdALm6Y8GNyfjoAzhcyshT1M98E2g1jZ1JFtTDKZBlKQ/OdBrkdfDZmQns52Y4
	 V92ia6J+gqweIl9EN7v5XT7pLFtmX+q0EScVJfKr/0PfbamvqbTOoQpicstA6yCrib
	 SJgzl7q890WAA==
Date: Fri, 1 Aug 2025 20:31:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: Add SiFive vendor extensions
 description
Message-ID: <20250801-lunar-stream-0fdb3f0febec@spud>
References: <20250801070112.12071-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wbkrqDwsXdSIcaGf"
Content-Disposition: inline
In-Reply-To: <20250801070112.12071-1-nick.hu@sifive.com>


--wbkrqDwsXdSIcaGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2025 at 03:01:12PM +0800, Nick Hu wrote:
> Add description for SiFive vendor extensions "xsfcflushdlone",
> "xsfpgflushdlone" and "xsfcease". This is used in the SBI
> implementation [1].
>=20
> [1] https://lore.kernel.org/opensbi/20250708074940.10904-1-nick.hu@sifive=
=2Ecom/
>=20

> Changes in v2:
> - Update the message to indicate the user of the extensions.

This should be below the --- line.
With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
although I suppose it'll be me taking this and I can fix it up on
application?

>=20
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index ede6a58ccf53..5638297759df 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -663,6 +663,24 @@ properties:
>              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
> =20
>          # SiFive
> +        - const: xsfcease
> +          description:
> +            SiFive CEASE Instruction Extensions Specification.
> +            See more details in
> +            https://www.sifive.com/document-file/freedom-u740-c000-manual
> +
> +        - const: xsfcflushdlone
> +          description:
> +            SiFive L1D Cache Flush Instruction Extensions Specification.
> +            See more details in
> +            https://www.sifive.com/document-file/freedom-u740-c000-manual
> +
> +        - const: xsfpgflushdlone
> +          description:
> +            SiFive PGFLUSH Instruction Extensions for the power manageme=
nt. The
> +            CPU will flush the L1D and enter the cease state after execu=
ting
> +            the instruction.
> +
>          - const: xsfvqmaccdod
>            description:
>              SiFive Int8 Matrix Multiplication Extensions Specification.
> --=20
> 2.17.1
>=20

--wbkrqDwsXdSIcaGf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaI0WEAAKCRB4tDGHoIJi
0uYTAPsGwJFW4yNjwYW1pBmrtz8xINlz60+L0eZqXY81BKT/owEAimug6HQAtgP4
UpmPq+OYSLSIcv7IE9Am7z3Yn50aSQ0=
=6jVn
-----END PGP SIGNATURE-----

--wbkrqDwsXdSIcaGf--

