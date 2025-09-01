Return-Path: <linux-kernel+bounces-795196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD5B3EE10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5976D1B20B06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19753282E1;
	Mon,  1 Sep 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdVGEJFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB223AB9C;
	Mon,  1 Sep 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752333; cv=none; b=m43OE34SXHJvQlCP0ut2GRYvMKS4PVK6CriHOJrJZHN9xU+0pGnhksTVoNx1d7k4oYSvyccRi7QOcSllG67XH2dEkUmDo0kx2uWC/WHYgegmjliovCwaJ6Ev/cZQTKB4nbmH6BsSAWaJMU7GIi+HgeqAyiqKDaN4vt9duDPyg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752333; c=relaxed/simple;
	bh=aPmQCEe63OVI0FqcE40rL2+NSrMCZGArnjtoKkfzx2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9W5w7rKSaT3aViIXkQjvleEUYaTJmg9Wlb7HevUcf4zn+R5UQKqAV5z3g/EqF5bnvj2z4dAkR2xte4SPQV+cg9EmES1OZX2eQeYet8RvV9kNE8PeNJvp9eLkU5sYOCcg+K2JaA5QqLrWm+L2hi/GQfwj+XEobweq0886dvS3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdVGEJFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E2C4CEF1;
	Mon,  1 Sep 2025 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752332;
	bh=aPmQCEe63OVI0FqcE40rL2+NSrMCZGArnjtoKkfzx2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdVGEJFD+d3O+xmCqCoUzPLubuH5UEqzH5CIvo0ifs5XZDkzmuvBzucVgRJkecImt
	 DKfFUse75F59WOzEMItsY+HauMdd4ee+djSMgH9VP5f5YyogEVYEfsENVdhLgZoArL
	 LwHNdFmc9BNXnCeWm6RugdKc9tVSGWnGnJppkfqLWGMWyB588vfOTRPGrzGu3/OpPs
	 pRKnFG16tm5VPr4ZE25CN7qljKTdh8uXI1MG2qZmRhtKWr/OUIxDfKUUMz8Va8oyC1
	 n4HmIuEBaNjGK3e8TqFt05SWw3CSwDeNzunkcMH9dbFg9R910ylugx+Wn+KHW4R7zA
	 ti3/y1Fnpo1mA==
Date: Mon, 1 Sep 2025 19:45:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add TQMa91xx SOM series
Message-ID: <20250901-savanna-auction-ce7f91b6941d@spud>
References: <20250901100432.139163-1-alexander.stein@ew.tq-group.com>
 <20250901100432.139163-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hf0FunI82vNiudya"
Content-Disposition: inline
In-Reply-To: <20250901100432.139163-2-alexander.stein@ew.tq-group.com>


--Hf0FunI82vNiudya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 12:04:29PM +0200, Alexander Stein wrote:
> TQMa91xx series is using NXP i.MX91 CPU on an LGA or socketable type boar=
d.
> MBa91xxCA is a starterkit base board for TQMa91xx on an adapter board.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Hf0FunI82vNiudya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLXpxwAKCRB4tDGHoIJi
0nXnAQCQyJOXHSGjB3+/E9eRpLhKIe6oXuKgPwWiZj9JQ9CfPgD9G5r5ZJ4fnwwL
tWoZWdg8Tf3wpg9vMMQQgIFhSRHFTg8=
=JjSq
-----END PGP SIGNATURE-----

--Hf0FunI82vNiudya--

