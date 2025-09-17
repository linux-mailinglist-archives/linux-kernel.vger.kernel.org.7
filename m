Return-Path: <linux-kernel+bounces-821417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB468B81346
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D674E358E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFD2FFDE2;
	Wed, 17 Sep 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGSJoUG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20422FFDC9;
	Wed, 17 Sep 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130671; cv=none; b=T/duoK0gbwwX7bN16lpkIPa8syuKNpaWR6MqI2Z+ZuoQT6z0gxLJXWRT4aqnNZKH9XXJZQq13wdX1or2NVR3lUIHIV373VOZCbnhQb7dqvSQ70PJdw0VCh2Yv6ZSNzVuz6QV20i/y7mJHkV8eEOEsJSauKm7J9XNRB0eAfwyovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130671; c=relaxed/simple;
	bh=Nc9e3rKn7AvDqrZmBkvvQLRNLGsv2pQ9yUUju53NSAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2syQWC6f4P0LQ3c6KjbJIWm/I8T7+iz+4UcNl/MLYFcFG0F7EFwQccr7pFsICh8fPJVqWivvkCWjfRzS41POqTA5lKXGcNEZKHjyejmVhUkyv/h30WHvb4jYSOJVz0YUydF4EzBNqCIoA6NvtIfuJrJpUB6U2vy1v8n/TKeLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGSJoUG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CD8C4CEE7;
	Wed, 17 Sep 2025 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130671;
	bh=Nc9e3rKn7AvDqrZmBkvvQLRNLGsv2pQ9yUUju53NSAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGSJoUG67pPu+iD0wkjpAQvrDPZG4bI5Xje2GuQujgFKzdTbbKazQvszs+6HPVRVa
	 RE985o8fqc5pcL6alcYf3CgjnjVYFVaYP2iW82kbJG0tJOLv70rc8KhLWqVmAhMaWI
	 ILME6F9GZYsZKmsNrgFp0/mzz6SEKE+5xymxpuAC8KlmVhCucd0ctW7shntHPFsBf2
	 M2sY5/ZvwDINaLts3FOK4MSMCM/+kVfjIJ7ryLGAH3MVueKXi25MtSjrZ4QkJ0cyMc
	 eKmhlK7MZL9neb1K+3/F8ZLhVDSpqhOw9gW1BjJE19Ss9/HDv7TP9t9qVz4yOjDc/8
	 lJzWi0NJxMOPg==
Date: Wed, 17 Sep 2025 18:37:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
Subject: Re: [PATCH 2/2] reset: sparx5: add LAN969x support
Message-ID: <20250917-backfield-saint-98ade84229e5@spud>
References: <20250917111323.60781-1-robert.marko@sartura.hr>
 <20250917111323.60781-2-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6SpiiCjI9ETMiFu"
Content-Disposition: inline
In-Reply-To: <20250917111323.60781-2-robert.marko@sartura.hr>


--w6SpiiCjI9ETMiFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 01:12:36PM +0200, Robert Marko wrote:
> LAN969x uses the same reset configuration as LAN966x so lets add support
> for it as well.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/reset/Kconfig                  | 2 +-
>  drivers/reset/reset-microchip-sparx5.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 78b7078478d4..35cb84d1de4e 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -170,7 +170,7 @@ config RESET_LPC18XX
> =20
>  config RESET_MCHP_SPARX5
>  	tristate "Microchip Sparx5 reset driver"
> -	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
> +	depends on ARCH_SPARX5 || ARCH_LAN969X ||SOC_LAN966 || MCHP_LAN966X_PCI=
 || COMPILE_TEST
                                                 ^ missing space here.

>  	default y if SPARX5_SWITCH
>  	select MFD_SYSCON
>  	help
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset=
-microchip-sparx5.c
> index 6d3e75b33260..28ad8f1298a0 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -198,6 +198,9 @@ static const struct of_device_id mchp_sparx5_reset_of=
_match[] =3D {
>  	}, {
>  		.compatible =3D "microchip,lan966x-switch-reset",
>  		.data =3D &reset_props_lan966x,
> +	}, {
> +		.compatible =3D "microchip,lan969x-switch-reset",
> +		.data =3D &reset_props_lan966x,

These are identically handled, a fallback compatible will suffice.

>  	},
>  	{ }
>  };
> --=20
> 2.51.0
>=20

--w6SpiiCjI9ETMiFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMrx6gAKCRB4tDGHoIJi
0ovNAQDum1mVIVbOnS+KAAkLu8Ws5eOGjVkudY5FCdxlugHYZAEArSKFvw4nI/zF
Lha1SH2g+lAJrPIvFrwvGSP9W8o+dgk=
=sLGi
-----END PGP SIGNATURE-----

--w6SpiiCjI9ETMiFu--

