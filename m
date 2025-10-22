Return-Path: <linux-kernel+bounces-865629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF7BFDA19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445B81A0805D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5002D73BB;
	Wed, 22 Oct 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNk+wK5/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65472D481C;
	Wed, 22 Oct 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154774; cv=none; b=JTqcgaiYKU+cYp5JzpkI8uHCCPb7XA3b4bxVQCI6XqjsFsH6+FNolGwHotf2zHIFdl8NE8u4LSkeRCOoeKT3DzIFvcRpJdDSif+9zpAdwyVJEC4zErOubdt561RWF4nSQGnO+qJUFQazfldNawIzbKXW38EDr7dI845d78CoIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154774; c=relaxed/simple;
	bh=24OkgosBerV7T+lgYIYHuKbrujn61EaFVukeV2kjpwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJgk5gw5Q8tm/oU8ESq+2YPnefyM1PgLw3g0fU+0U2FokicKJ8DXmvQyCgr6ZhX2pDfvsTnFhBtwJJdcTLXB/TgT4KStsa+kRpwgJp4VHLH+R+wJabN0i9NchUsjm6eVSL9qstgW3v35z1ceVf1HlPwSBR9qN+OpwN300Nb1Gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNk+wK5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5DFC4CEE7;
	Wed, 22 Oct 2025 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154774;
	bh=24OkgosBerV7T+lgYIYHuKbrujn61EaFVukeV2kjpwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNk+wK5/F5AARFiynLtMZjhIK0/T/uIjd66vNx6B9TgIlKTHJWNVpcEnYlevf/Wb0
	 WqSJW45hV8z2EC4oTCKgxUUk+PmS4cHKStL6T8i3PFZGHJukcU1qwPh9EyjnvhxGf1
	 RrFb3JPiGn/Z1+uI8JTdPNQe5vp5s4pRSVK4UaGYs4tCOsf63TBoWkru2riYNbyNU7
	 0AUfrIDEyn3nN+vdxQZPzMccFMWL7yJCWGAWN8AxUgDevs6J2P5ks3ZXBOjf4pKlbf
	 ZXxYF/9Zs98v+u2YFW+0wDtgZaz9u2OhWX1c1+9r/pbXDRNekzJHlydj04fwN06Pe8
	 nBpsBHDsEHTAw==
Date: Wed, 22 Oct 2025 18:39:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC
 phyBOARD-Segin-i.MX91 board
Message-ID: <20251022-eraser-latticed-6d0291a07589@spud>
References: <20251021093704.690410-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvtMwzI9nOsPH2Aq"
Content-Disposition: inline
In-Reply-To: <20251021093704.690410-1-primoz.fiser@norik.com>


--kvtMwzI9nOsPH2Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:37:03AM +0200, Primoz Fiser wrote:
> Add device-tree bindings for PHYTEC phyBOARD-Segin-i.MX91 board based on
> the PHYTEC phyCORE-i.MX91 SoM (System-on-Module).
>=20
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kvtMwzI9nOsPH2Aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkW0QAKCRB4tDGHoIJi
0pJqAP0RqklqLO4Tj2pIuOr/1kpPnRUHFAdHRi7L4FSO4wfjMwD+IHHxz9L47553
PrSJhvtbBG2KwrOsGRDYOkUzyGz2Tw4=
=ZqaT
-----END PGP SIGNATURE-----

--kvtMwzI9nOsPH2Aq--

