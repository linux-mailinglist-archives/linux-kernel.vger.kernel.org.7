Return-Path: <linux-kernel+bounces-866581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382EC0024F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C7C3A7D37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9A32F9995;
	Thu, 23 Oct 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhXEyOTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE52F6587;
	Thu, 23 Oct 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210728; cv=none; b=GJXx0cj5dXYPzaVU+nlsfWoplr657Z+otH5yEy8uLbKRqNo0PtYXmDRPpWJLj3SfjYOtUSWpZZuyqE8Cd83FcNrqAemWb8XQoMwNAuYOXtEdSHKviQZDs9DEfIKO0pCU+UXF4Tlo57NnzDmj5N69DFShCT25p76YQpBAyUN3PR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210728; c=relaxed/simple;
	bh=4fQns59QMA3pai7ttXXV7GO218fuxTEHJzSTkeLaOGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCZlEU2mDAGqkfiiHjB0JAXosfHXXxSP3SElq70ncXWR0MYR/veMVaXegJvqUwmTLrtoCVj8+fbsdpJG8Uuwg8ZdIamsE5Uu7i4TLzyDIrVYfaiXJnhCWBP9h9DvGsx8DuZDE9wkq6ayGM/nCk+tAUxyaZPL2CImVdhIT6SvuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhXEyOTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E09BC4CEE7;
	Thu, 23 Oct 2025 09:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761210725;
	bh=4fQns59QMA3pai7ttXXV7GO218fuxTEHJzSTkeLaOGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhXEyOTw+Nv0PVa1o3YFTeWUCdbHCgKh6zEBhmXkZKML+wiA+jidi6IpfvNu5N68g
	 TxHEYYUSNZnLmD2cj/nBirivk2DaLWkO6RSBh1vjJaRJdjvmqkQiCKPSqxuE4qt67j
	 Dapwxx1Xw3bePtz51R441Du2xHZMmOQ04QpMi9vrKJBA5m8BIbpwVFMGuCFM9AuI+4
	 rNedVDfDAWPLSXJS+V9rNuWuOHts8wsFtRVV43Ql08Quhg2X5YbkP/P4IIr0fOnyHo
	 ZGKbK6BQCiUulrW7bu+t8qttLuzzaX6ILOOTHJCy9oprUUo1ITCdrW71x9knp8XIn4
	 tW2MxbddPK5hA==
Date: Thu, 23 Oct 2025 10:12:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/9] soc: microchip: add mfd drivers for two syscon
 regions on PolarFire SoC
Message-ID: <20251023-lard-browbeat-daade890b4df@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-patient-matrimony-6162c8f92e2e@spud>
 <41dbea85-8aa1-4034-8106-e28c37e398b8@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KI7GN8NHbpEH6S+z"
Content-Disposition: inline
In-Reply-To: <41dbea85-8aa1-4034-8106-e28c37e398b8@tuxon.dev>


--KI7GN8NHbpEH6S+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 07:04:33AM +0300, Claudiu Beznea wrote:
> On 10/13/25 20:45, Conor Dooley wrote:

> > +}
> > +
> > +static const struct of_device_id mpfs_control_scb_of_match[] =3D {
> > +	{.compatible =3D "microchip,mpfs-control-scb", },
>=20
> This looks un-documented.

It is actually documented, this stuff all took so long to get done that
parts got applied piecemeal along the way, including any of the MFD
bits.

I'll fix these things up separately, cos I already applied the first two
patches here and just squash it in.

--KI7GN8NHbpEH6S+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPnxYAAKCRB4tDGHoIJi
0rJYAQCgpkpqZSL7x7t82+VYX7l3XaRLUIGDEYkTvHJp0wOEVAD/RFe9FOMiRRhm
r3FYvXwt1EoKcNCFEZiNkhB9BkaO5Ag=
=Eqsv
-----END PGP SIGNATURE-----

--KI7GN8NHbpEH6S+z--

