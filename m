Return-Path: <linux-kernel+bounces-744266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7967B10A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9E717CB73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB647FC0A;
	Thu, 24 Jul 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofEmwhS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380F2D12EE;
	Thu, 24 Jul 2025 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360534; cv=none; b=J1XFthu2WbS14WSLb74Rt+/OZ2yYLrIBkprfEdGv/XBZ59zM/1PuKWV230+pmpZiRn7UUeJwoth/l7kEAMvqIqggdaRZGl9oGAmNwbNfsvv5Kh2SVXzbpyMtpzsfhB51Z2OHQea2d9tpvIXA0KNlmFv62Kr3T+IlOVmpx6xR+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360534; c=relaxed/simple;
	bh=r+ZX3Es5yVhtnwa0qN+J3zKdrHltGFF3te0S2kpbSmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNIG59shBCbaunR1+oDZD+vtOWkaPtFbKca/FuQo+4O26vjlhgL8ZgjkCNzTx/86/RM2+UO8zUODgKDYKqSbdHYUnwutQqt6G19bzZY57UKTHh+Mld/l2Dzn6fF8fqbfCof+aj4+zqqoyFAZonbzH1LDaFjJGskmxiVjtGnqeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofEmwhS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145CC4CEED;
	Thu, 24 Jul 2025 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360533;
	bh=r+ZX3Es5yVhtnwa0qN+J3zKdrHltGFF3te0S2kpbSmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofEmwhS9Ugx7wxJO1zhgyrAfVPef58C7fkmlZaC94qqXoPe8mkhudepD1Mzm4a5Wy
	 uF1Ca58XZM9+xPIoPeB6iJga3GX1Cfsd2qK1VzKcxpG1AzipUzLzx5+4LF3aIgW9E7
	 1ijfw6oms1mt8/2oae1sgGCNoMIXQphjhbgiF1N7OL2qS+yLR/4Oe1XmRtIuFL0eTI
	 6gH/yridgg3QksGtuO2BCYToU7hUmm7EVvksJ6vfgtZZChVcNAc9lPaTGoWnGnfn0L
	 fReI8aGF0PYC7Y8szvE0nP10H3+Ag7CZjKHKZnKizNs20GvtNb750LcIjc57BshCQE
	 4WWjnI5Nkin/w==
Date: Thu, 24 Jul 2025 13:35:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Varshini.Rajendran@microchip.com
Cc: claudiu.beznea@tuxon.dev, Andrei.Simion@microchip.com,
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: atmel,at91-ssc: add
 microchip,sam9x7-ssc
Message-ID: <68996241-d49d-4680-863c-38e30e403bac@sirena.org.uk>
References: <20250610065005.64070-1-varshini.rajendran@microchip.com>
 <7989c547-2346-4e1e-8327-0c085885faf9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GMCgj9FRHPHzUIgs"
Content-Disposition: inline
In-Reply-To: <7989c547-2346-4e1e-8327-0c085885faf9@microchip.com>
X-Cookie: Did I say 2?  I lied.


--GMCgj9FRHPHzUIgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 05:26:22AM +0000, Varshini.Rajendran@microchip.com =
wrote:
> Hi,
>=20
> Gentle reminder to merge this patch.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--GMCgj9FRHPHzUIgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiCKI8ACgkQJNaLcl1U
h9Bt9Qf+Jror8xXrRp6GCl/0eJcVWRMzPkxTLvGzSnt10RAB7m5ivevvZcYq5FAV
VJOozlsvMXpskkSyilo1gWpI8C/P0su943W6j7JP+vvrA6zeut9Mq6nnSuQuVq7h
DiTeCXC9lS4g4xGYms25dLpMNd/hb/I1LbCCZcoyRklbVb4QpS+XwJvP47b+h5bI
x0yXHh7nQMpeLlJdQRZejOy1CKGu6ViVtZ3ZuLV8hQu/l72jYSGJiwYeZvY9dOZL
cZXLTWBYjBFvBXWSopSdl+oB1fNhrjKyLXBX++hxIzYg8ntVtqCEtFpVDBs9ivaM
cSQcqvLcvIzGftir3L8A+J+A8nwegw==
=pK06
-----END PGP SIGNATURE-----

--GMCgj9FRHPHzUIgs--

