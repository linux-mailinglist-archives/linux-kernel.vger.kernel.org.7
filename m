Return-Path: <linux-kernel+bounces-684190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E121AD776E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79333B3400
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2C299A94;
	Thu, 12 Jun 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY5L++jN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB311B0416;
	Thu, 12 Jun 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743872; cv=none; b=p/A5j+hSUxhPPiKemqLewzjAZYXmyRV7fXhh0aIKomDHBbxZWFC5MY2iQjFjV/j2inRSUsqokfNPqergrUFih+3aCNaLObYEn+rSBCe9rVU1fywX/qXr3kmB5ztGbzU+BfkByGMNyUOk0/dwYd0zR7lWLsICtuD6Um23OnW3F/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743872; c=relaxed/simple;
	bh=quVk5JjWgkRkZ11iWAF6diO/aBB5OEX8KIhW0ikR74U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6O9Ugf6G1kGFK92vjmAwsj+5nA/pHc7BZRsbV9p4VPwefe3bCyCFbhxQdVY1T+xAvsCjv0m6NyW7v4OzdusSNV33Bb2kpXFtD/J/Bcj64AlgYYAvKkgOL4efk3D2/dtfwgMEGWziwZWuH8mPjLu8Hwif6csm+9/ezBqB3eROhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY5L++jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9176C4CEEB;
	Thu, 12 Jun 2025 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749743872;
	bh=quVk5JjWgkRkZ11iWAF6diO/aBB5OEX8KIhW0ikR74U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lY5L++jNiGKZFHLvrIdSVlmT8ec/OoFT2VgLRb4kvmfn6z3ivgarmCRmHT225XG0H
	 +WVNP4PFdTkTu6uiu/RKlji7vceibTVZR4tHmMBybJxkWIgZkmGv4AZ8C2YcjfClB+
	 Qg2omQZxTJVZ7HSnojxqcxm7Oe+nNO8+B3ba95bX5CYNShBMjs9d+bn4120LG96AN5
	 ITpOGd+nY2CXLukS1ny3jbVxkRurvctoubsdfwmbURzjFAgsphG2HhDGPi5g3XgXdP
	 pkVDtXOXA2azY0TnyzjAMtxLkCgb37T/edvRcV7jc1G4JJ36pXKpHBWjQBnRk7Uqeh
	 BNcxyensoO5KA==
Date: Thu, 12 Jun 2025 16:57:46 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, qii.wang@mediatek.com,
	andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 3/3] dt-bindings: i2c: i2c-mt65xx: Add MediaTek
 MT8196/6991 compatibles
Message-ID: <20250612-create-bucktooth-0dea6929bed1@spud>
References: <20250611110800.458164-1-angelogioacchino.delregno@collabora.com>
 <20250611110800.458164-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6t7S44HeCwXqkkfW"
Content-Disposition: inline
In-Reply-To: <20250611110800.458164-4-angelogioacchino.delregno@collabora.com>


--6t7S44HeCwXqkkfW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 01:08:00PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for the MediaTek MT8196 Chromebook SoC and for its
> close relative, the MediaTek Dimensity 9400 MT6991 SoC.
>=20
> Those chips' multiple I2C controller instances are compatible with
> the ones found in the MT8188 SoC.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--6t7S44HeCwXqkkfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEr4+gAKCRB4tDGHoIJi
0pOIAP9dL66U4toAAvm8pG50O/bEelGajn9QL/aWOT4gmCa1GgD/Wd7HHHH9Coio
pcRVjnIjZI3dQVcXsuqT+DvShe7jhwU=
=MOtr
-----END PGP SIGNATURE-----

--6t7S44HeCwXqkkfW--

