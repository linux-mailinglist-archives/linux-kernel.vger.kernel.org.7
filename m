Return-Path: <linux-kernel+bounces-895986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC5C4F6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E8E3AEA80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA8377E9F;
	Tue, 11 Nov 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB2mwsKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C8265CA6;
	Tue, 11 Nov 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885609; cv=none; b=C25V+Qbig6aSAP2aUuj03WzFb2xvBUQ9+puhUmwd8a8XkfUDQPtM7IzbKp8aL9teqQD7DhsQwLcDgeq+aZIqwV/OSjFFsrlW1Q3G9+G9xmtGdUW7josG59fRgpM8COuQ9kTZAIhNv4XnbYOPhyPO3UX0cYFqCqPSglDZxgHG3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885609; c=relaxed/simple;
	bh=4blQyKrzAkck3w71C86EM4tTASTGHoqXfv8ZZdP8GD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo9ElGvzRvXiKble2hNV8S0/odNOEuuQu0MYkBPJs5EVitUHv8Hqpj9pQ8qjZ9akZ+4GuDFo88k/xtZhyEh5zztLBEkTXlml456Qbkg8XSt2AaI7i8GKdX5XBv35dsCCw4NPbiHW+efzUgD6bBrye2G+YivMTwCs2d1HNhE7oWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB2mwsKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9E1C19425;
	Tue, 11 Nov 2025 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762885608;
	bh=4blQyKrzAkck3w71C86EM4tTASTGHoqXfv8ZZdP8GD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EB2mwsKZOt26mhFmlqmAt9TTcx7m6KIb/2WmEWg5hTkTbVNjMZ68QCkYgdgAbKGaI
	 SCUt+TbxjpFPqboSNBYoirqVLfH+IZOo4cEr62NOv0oTgrlMfn6xbWsJhnuvXeFLP6
	 pv3/NlemTf6Woija8Glpv8xiia4HhybsEihrAeVOvKHggrgJ+l4moLeNc1dorNyypH
	 CkTe4MkpfDXHl0UtVXcbUKBelzOp38ocz7DiPMTLpo941vemDQAxR+uKJbJhGIIosV
	 YOmKRqVAh6U6SN5/qfjjLKdrNAWwd2wAIx2uwkS3DyVZxwmgiANwyOOftdkrNT4bdx
	 ujiA35zkLOvug==
Date: Tue, 11 Nov 2025 18:26:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Andy Yan <andyshrk@163.com>, Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC 02/13] dt-bindings: clock: jh7110: Make power-domain
 optional
Message-ID: <20251111-brim-circling-0d5a364519a8@spud>
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
 <CGME20251108010454eucas1p103697b195125d853bd9f4d40662b681e@eucas1p1.samsung.com>
 <20251108-jh7110-clean-send-v1-2-06bf43bb76b1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EoykeO/vcnmrhIyh"
Content-Disposition: inline
In-Reply-To: <20251108-jh7110-clean-send-v1-2-06bf43bb76b1@samsung.com>


--EoykeO/vcnmrhIyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 02:04:36AM +0100, Michal Wilczynski wrote:
> The voutcrg (Video Output Clock Generator) hardware resides within
> the PD_VOUT power domain. In the new display subsystem model,
> this power domain is managed by the top-level 'vout-subsystem'
> parent driver.
>=20
> Because the parent driver now handles power management, the voutcrg
> node in the device tree no longer needs a 'power-domains' property.
> This patch updates the voutcrg binding to reflect this by removing
> 'power-domains' from the list of required properties.

I don't like how driver-centred your commit message is, but I think you
can just explain this by saying that the appropriate place for this
power domain is in the node that uses it, not some other supplier to the
vout subsystem.

>=20
> This fixes a dtbs_check warning that would be triggered by the
> updated device tree.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml | 1=
 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-vout=
crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.=
yaml
> index af77bd8c86b12e667b79ffbaeae5f8a82e6d3f37..deff69037e5072002e06aa5a8=
99f4488b7264f47 100644
> --- a/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
> @@ -61,7 +61,6 @@ required:
>    - resets
>    - '#clock-cells'
>    - '#reset-cells'
> -  - power-domains
> =20
>  additionalProperties: false
> =20
>=20
> --=20
> 2.34.1
>=20

--EoykeO/vcnmrhIyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN/3wAKCRB4tDGHoIJi
0jcGAQCm8zdZi4Rj0XsEx0Qzj/K0aGmz4WEQWzpBc5W/wiIwsQEAx+y3uu9T8sp/
Aamgu97ttBdRylrGg+l4YxZE4C+V2wY=
=l4qk
-----END PGP SIGNATURE-----

--EoykeO/vcnmrhIyh--

