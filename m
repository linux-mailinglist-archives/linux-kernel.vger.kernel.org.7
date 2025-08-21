Return-Path: <linux-kernel+bounces-780433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33562B301D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D16F601163
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB792D5408;
	Thu, 21 Aug 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIJT2L0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110919EED3;
	Thu, 21 Aug 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800254; cv=none; b=atatcyAQoj9Vn3WiFlQEzOvOuO+/uDLHZLh57hZVGbHDUd8hWaPeyREAgKpvDIzeaGowp3K7oQApkGpNkdm4jyHLBhz5tKgNyL1hFX9RqpdUUNqEH/DBuRo30/1zL5H7RER70k96dbtn8hYU7div6gw3Wf8rk/EQBaivL0lpNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800254; c=relaxed/simple;
	bh=sdpk9kvumjyelyuunnszIrhJPZRwr5hdsLnxeXdH7BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj3a2TpTKuOLq4e1saoDE7z0Up2WEId4BnNu/Dey1r4yJj4RX3D30xybHaHgKx55PC/DOXnznBwuRMc6JD14RWgL5EpCJ/gYKpMoc7ESOWI+eCHDrPmYrv1qKmmOFxxZM6ZH/T/HQ4or8N/lDBrDOhGclXRUSFO23KQ2F7uZ1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIJT2L0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F39C4CEEB;
	Thu, 21 Aug 2025 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800253;
	bh=sdpk9kvumjyelyuunnszIrhJPZRwr5hdsLnxeXdH7BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIJT2L0FSMpseoLQ0+azuxnY7re9vD45CWlyFkUf5KGOjSs11ay6BXQ2J5P7NDh9r
	 ujfEASp89P0CMuf5YLOXV4DnWzF6zD52AWHvx5pXUkbrVCif3WDR6QQ3RC4OhQM7ID
	 PPocC+Nw3hnzR6liRsVPae/W0KEIQL6CqQtUBp9CcDacjXIo4CS5lwstTmtxXO4EBw
	 22PYMKalPeitWjNSgp0T+L/fTEeWS4oJcBXm2Q3TRxs4m5NyBGDNdyvKnb1UEgSoOh
	 2v9YDj8qLHNr9aolk8wQpNpy1ExwLjQBTBBeSUyxm2oLJt69sXinsoAdausPY+9tvW
	 xnP7B8M9KITew==
Date: Thu, 21 Aug 2025 19:17:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
Message-ID: <20250821-pencil-anguished-6b8467adbd38@spud>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogk02xgAdtyg13R4"
Content-Disposition: inline
In-Reply-To: <20250821100930.71404-2-hal.feng@starfivetech.com>


--ogk02xgAdtyg13R4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 06:09:28PM +0800, Hal Feng wrote:
> Add device tree bindings for the StarFive JH7110S SoC
> and the VisionFive 2 Lite board equipped with it.
>=20
> JH7110S SoC is an industrial SoC which can run at -40~85 degrees centigra=
de
> and up to 1.25GHz. Its CPU cores and peripherals are mostly similar to
> those of the JH7110 SoC.

How "mostly" is mostly? Are there memory map or capability differences?

>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Docu=
mentation/devicetree/bindings/riscv/starfive.yaml
> index 7ef85174353d..a2952490709f 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -33,6 +33,11 @@ properties:
>                - starfive,visionfive-2-v1.3b
>            - const: starfive,jh7110
> =20
> +      - items:
> +          - enum:
> +              - starfive,visionfive-2-lite
> +          - const: starfive,jh7110s
> +
>  additionalProperties: true
> =20
>  ...
> --=20
> 2.43.2
>=20

--ogk02xgAdtyg13R4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdiuQAKCRB4tDGHoIJi
0uloAQCW8zYJBmp+5pFUy5+K9wGBKt53uvd5revzwEq1efJRGgEA7Z3tBRMUIB5I
+Kok+f96PccyQMWOqm32iMRzqMSjBAE=
=VGHm
-----END PGP SIGNATURE-----

--ogk02xgAdtyg13R4--

