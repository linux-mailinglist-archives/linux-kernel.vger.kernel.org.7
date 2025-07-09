Return-Path: <linux-kernel+bounces-724095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89371AFEE81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE37B12E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390162EA475;
	Wed,  9 Jul 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a94vT2rt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCA21D3FD;
	Wed,  9 Jul 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076844; cv=none; b=e8mIks+Zaf2TibQcy5YRdZyLW9SlvJ7QQJrRhfpExrigeXXoiut7+toQ/M0JsTmGesCwgvB7tmoQWU9UTejn5KFp3/jdyp7xRAD6gGLBtZbsR4BwZg6OW8dYMWc9JNay4L+B99YRc/zW96yz0aq4R5RqZ4uOOmq0rNoIhcvKBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076844; c=relaxed/simple;
	bh=GoEXxmA+Dj27zsd8ziX2WQulAna4dGReDWUKd8Vxl20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ+WaA/KMvFgThebwLqDn5KwZoO6mjF3Zc5SrUMW7GISPFtmdECvt+QKPni+pwrksv9z2tx+tYBM1IK3FV4k1z5zSD0sXqlLo1xUbmJhS/E//LEfu4X2bAmcRXm7OmVxopj/+VEDvq+zyOMY0S4zwzeRESJQeiZXHtTRRHts3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a94vT2rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28468C4CEEF;
	Wed,  9 Jul 2025 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076844;
	bh=GoEXxmA+Dj27zsd8ziX2WQulAna4dGReDWUKd8Vxl20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a94vT2rt84gZSUYEQYOq4PJimJ4WvBRG5cgCgI/HHXMOGvq1LoklWN1v+bSjK3YwO
	 WD4vI4heZOeZKeiyAx655rLGJcSfYKonvEKJcSYu61avIOunM6F0gW9CIvz+R1WOuQ
	 JM2+2CYd30LwBuL6wg+zqLBDfs4fMLTvHgnd40DvbwYRsPB2bghUEAtEypKrFvITRo
	 JuxuxHeCQRavqF1LtK2SscXcJBmYA/YzA+E84z/6CZPlyOom5qZXUlZnA7lWykK9Vi
	 Ufnbyx2q/AUC9R1Zn5D58cffCuu8PmxvvX4vqwdhq9ZwNBCcSC4cAqyAhwwSDlLaXM
	 5xBMVXP+6nb2g==
Date: Wed, 9 Jul 2025 17:00:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] dt-bindings: riscv: Add SiFive vendor extensions
 description
Message-ID: <20250709-startup-coasting-aa58a99c5585@spud>
References: <20250708065242.26371-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H5XYBjydcd73WNlI"
Content-Disposition: inline
In-Reply-To: <20250708065242.26371-1-nick.hu@sifive.com>


--H5XYBjydcd73WNlI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025 at 02:52:42PM +0800, Nick Hu wrote:
> Add description for SiFive vendor extensions "xsfcflushdlone",
> "xsfpgflushdlone" and "xsfcease".
>=20
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

You have this, but no user or anything along with it. What's actually
making use of this? If it's just for the SBI impl or w/e then say that.

> ---
>  .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 72c1b063fdfe..10c37c61243d 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -626,6 +626,24 @@ properties:
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
>          - const: xsfqmaccdod
>            description:
>              SiFive Int8 Matrix Multiplication Extensions Specification.
> --=20
> 2.17.1
>=20

--H5XYBjydcd73WNlI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaG6SJwAKCRB4tDGHoIJi
0ks9AQC/Q6brAPmhJnR++6Ix8DAoDmvW23xMTc8wvhh0d6IbsAEAxM/WqT0TXydO
bNW64h83RlVLS5t5xy7nvJakYc2suww=
=hXLq
-----END PGP SIGNATURE-----

--H5XYBjydcd73WNlI--

