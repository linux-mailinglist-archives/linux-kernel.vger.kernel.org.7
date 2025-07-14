Return-Path: <linux-kernel+bounces-730562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E84B04653
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A01F17FDD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF137265286;
	Mon, 14 Jul 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoXNOI4g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259313FD4;
	Mon, 14 Jul 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513567; cv=none; b=hlAC9vGIODAgQUZFVPt9/8Ujtb6APXrxiNjSny6ckTP/tEoVnUJeT/2W5CK56JvMd+xunZIHWH+BMdh3NkIKcOrPNlewr9aJCw8ZtuFy3s3UXUdO9YRZ/aTDHCt/FWqRpCM2vJ4z0t5IyazRJYoUJEnou7jLbewmwFxFvav24nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513567; c=relaxed/simple;
	bh=QrinDk3fm9ZGE2hDlL+yMYcY72belN6TYJ1wnVRnZb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=encrHxl7ykgn5eYj0IW5uQbb1nW0u0Sxgfj2WyT7eHYi64+iVC7AYBOg2kA6jAWbwgNPjVgs/wPk+yrFoave6Cy1LHZJh0GyZbF9wdoBEIlvGPSBjRfBrrAClkyQ3aTghiJQv4I8FbfpU9lFSvStbxjeczHFwjIetvevhOOufhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoXNOI4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5209FC4CEF5;
	Mon, 14 Jul 2025 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752513566;
	bh=QrinDk3fm9ZGE2hDlL+yMYcY72belN6TYJ1wnVRnZb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoXNOI4grEQtxq0VjHSQHuUNduNRQ98r2X9bmTKz7sen1mCDZTGjugnOctYizAEXH
	 uYMMpz1cQYxSPUUReZn8d/rmQT0wxM+sHhsz84Qhdqb/GnvQfPUaPGKTG621+JG0Xk
	 Vg089q0aUYKEmuirCzPqg3o62RhwMSlVCF2mCLEZmFY/MIVL1i2DKJyRKgoOo3nMet
	 O12/fvEE05mQgLU3l5obVk1Q0aU2AgOq0NJD1EoyedgYo7kfcikBDYTIpMjVQYXkU0
	 jhB7kVOeJC6E0yPRomLKqKSu7oyHTI5+D2daTKrls7XQoOUO74+bFWxmg+YvAoutpC
	 KwBQ93eDIiekg==
Date: Mon, 14 Jul 2025 18:19:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] docs: dt: submitting-patches: Avoid 'YAML' in the
 subject and add an example
Message-ID: <20250714-backed-savanna-68256f827e6e@spud>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-1-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PiXkgQa4DTRoReie"
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-1-672c898054ae@linaro.org>


--PiXkgQa4DTRoReie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 02:46:36PM +0200, Krzysztof Kozlowski wrote:
> Patches adding new device bindings should avoid 'YAML' keyword in the
> subject, because all bindings are supposed to be in DT schema format,
> which uses YAML.  The DT schema is welcomed only in case of patches
> doing conversion.  Effectively people get confused that subject should
> not contain anything else than device name after the prefix, so add two
> recommended examples.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Changes in v2:
> 1. Rephrase - use YAML instead of schema, add another example for
>    conversion.
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 12 ++++++++++=
--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/D=
ocumentation/devicetree/bindings/submitting-patches.rst
> index f3e23e69a6389e7e5d8db66af5060978ecff8a9d..46d0b036c97eb531dec95ef52=
261988d3bfa3aad 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -21,8 +21,16 @@ I. For patch submitters
>         "<binding dir>: dt-bindings: ..."
> =20
>       The 80 characters of the subject are precious. It is recommended to=
 not
> -     use "Documentation" or "doc" because that is implied. All bindings =
are
> -     docs. Repeating "binding" again should also be avoided.
> +     use "Documentation", "doc" or "YAML" because that is implied. All
                                                                     ^
> +     bindings are docs and all new bindings are supposed to be in Device=
tree
> +     schema format.  Repeating "binding" again should also be avoided, s=
o for
                      ^^
I like the change, but I would like to note that you've got inconsistent
double space v single space after a full stop. The document seems to
mostly be confused about that and uses both. No clue which of the two it
should be, just wanted to mention it :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


> +     a new device it is often enough for example::
> +
> +       "dt-bindings: iio: adc: Add ROHM BD79100G"
> +
> +     Conversion of other formats to DT schema::
> +
> +       "dt-bindings: iio: adc: adi,ad7476: Convert to DT schema"
> =20
>    2) DT binding files are written in DT schema format using json-schema
>       vocabulary and YAML file format. The DT binding files must pass val=
idation
>=20
> --=20
> 2.43.0
>=20

--PiXkgQa4DTRoReie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHU8GgAKCRB4tDGHoIJi
0pIwAQCSCc9PwL29jXaD/+XSZKKa3UoCv1sjalIgiHBMkn2ekAD8DHxkc9iDOOM6
DMr2UXA1VSIS7XodJWZ8kc6J/degoAc=
=zP+R
-----END PGP SIGNATURE-----

--PiXkgQa4DTRoReie--

