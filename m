Return-Path: <linux-kernel+bounces-821419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E00B81355
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E5F46618E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE22FF649;
	Wed, 17 Sep 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvqfBWTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E612FF154;
	Wed, 17 Sep 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130697; cv=none; b=Hh5DGNUQGt8X40fhZBAoMaWj1SO6i15zdxsiFDZIVVfW4wtG8FxFmNm8G/C0x5zMF8RiIp2hYT//VqHd63v3PhUl4SwWQU9U5MNbj62HvNN2Vv+BQq/4z+6dc0sa6ck+3Axjg/EA+UXCNtpRu2m0FmrEKhtr0Ftvt/p5Y9s1Kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130697; c=relaxed/simple;
	bh=98MNGnnkrUwGuRnrY4NUPpQAkwT8q3WuQcOsJRda4aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLLUVCl2aGn6YMHMe/GqBowyc8SkQpXDULU4sSHIoo/bHkIltMbOXfxz8pahTJ0lZcIO9mqAhxHYn0B/5FKc1Fic3WQQnBRUd0hjxIvJSG5UaEx3DH+7W3WBYZMsX0Hmw/PGTepZey3Qy/7rEosJVRDUizwtOWPnl056fTPDjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvqfBWTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66919C4CEE7;
	Wed, 17 Sep 2025 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130697;
	bh=98MNGnnkrUwGuRnrY4NUPpQAkwT8q3WuQcOsJRda4aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvqfBWTPGLdZeVCIgXIle3ePtwYbq6UowyG2ynmEUXEKrd5Y1YiEHfUTAfvPQLy4Y
	 7S+Ocx49woz1T+7Herl71V/2KKRbjtYLgXu43Q1cNAa68rPIqAv6OwCEJGw1YSZ5g/
	 dlKBnjYcTl0wpl+cC9iGfUIQdAWRpmJM08zC1/xEAEz7IDE2WLOP5JjgHdCZ4NZk7L
	 24oR2MF9Uk1zEoUAvnOh1D9tWfsTi5EYoylUP66UXteeXE3zEFmbMk1pnfzI6VbNmD
	 u3pekvuK9xzT+hG7lgIe83Z/7lUruCdBBxFZY4lnF7lc97BgQDULDEuDXJvYFXI+vs
	 yyoV/pybI17Pw==
Date: Wed, 17 Sep 2025 18:38:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
Subject: Re: [PATCH 1/2] dt-bindings: reset: microchip: Add LAN969x support
Message-ID: <20250917-paparazzi-hermit-3a4aa686add3@spud>
References: <20250917111323.60781-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZZrNlcphxvFNijN6"
Content-Disposition: inline
In-Reply-To: <20250917111323.60781-1-robert.marko@sartura.hr>


--ZZrNlcphxvFNijN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 01:12:35PM +0200, Robert Marko wrote:
> LAN969x also uses the Microchip reset driver, so document its compatible.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/reset/microchip,rst.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b=
/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> index f2da0693b05a..4d4dd47f830e 100644
> --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> @@ -23,6 +23,7 @@ properties:
>      enum:
>        - microchip,sparx5-switch-reset
>        - microchip,lan966x-switch-reset
> +      - microchip,lan969x-switch-reset

Driver patch makes a fallback compatible seem usable.

> =20
>    reg:
>      items:
> --=20
> 2.51.0
>=20

--ZZrNlcphxvFNijN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMryBAAKCRB4tDGHoIJi
0lF5APoCO2fpGBZ4T11tcyR1V+3vQvsaWXwe74qYjRS39jBoWwD/RTYl78Os46zO
LOgCifCO7gUxjX+ibE/q2+B/LW3dLgE=
=9R5e
-----END PGP SIGNATURE-----

--ZZrNlcphxvFNijN6--

