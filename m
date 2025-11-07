Return-Path: <linux-kernel+bounces-890868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206AC413EC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C103C4E21A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861D338F39;
	Fri,  7 Nov 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEg7c6eK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB327145F;
	Fri,  7 Nov 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539276; cv=none; b=uD6/UEjNx6e88/gxcE90idXG1aChzzMGXD9FUG66NVEWngdNraCgO9ItwQ8s06CqwprsyACzho4/z7+3Fmvj30pMpqARTlPWPPFqU6WnRnR5g9mQ3JZdh2W3OoTMBwRoJoo5RmllIkgnhfMVw3+s3GAro07gGhcyBORgk+zWov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539276; c=relaxed/simple;
	bh=eM5ZneuspMh6fY9/LR7skAboL0fd0yKYb5cCgw95hAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF/d1tdc4RyGZ16Ru0jBpOyQwMQMqQWQPXSz/O+L9LmTS1bIi1WYuzRp/mx7r9kRTYTf9UND4BxcxniwTTVHLvTlmoS0qoh8Rd7ADguyROlPLbdHrN7IP1wLDfkqmfXlXo9RnVx4YrccwLBYJtjxGbXKFtjiEehRPTNths4STbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEg7c6eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE79C4CEF8;
	Fri,  7 Nov 2025 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539275;
	bh=eM5ZneuspMh6fY9/LR7skAboL0fd0yKYb5cCgw95hAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEg7c6eKO3PokMvzhrEFP+XY4vIY2iKjkO80GM96kGs1U0+YMRWG3tSCi4XBPuX6T
	 eUub83RPNHQBs4JkaQO2jysWe+i3nrm7BtZ+d9NMVvBrTRmDZGSl4FwkoRXNmbLISN
	 G8Wpm2uFNFNkH8+4WOBPkKctxLPPzD4toZ2qxmfF3K2vkYntfzj8NmnFpWiiE90EAV
	 hzaZeIDuc5zDGjnd9M5dMDnEdh0YEdbg7MddjZJ0L6CUemqf5Elgr9CNMCuIXywGQO
	 Ty3EPWdUWY4yVenQh9DGpmI6NOn4/uuCUVLC4yqAlOEszIddU9fL191pPGfeGFzIan
	 kFA6ZatjmFjYQ==
Date: Fri, 7 Nov 2025 18:14:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: soc: Add bindings for Airoha SCU
 Serdes lines
Message-ID: <20251107-crisping-doable-365d6b7d60a6@spud>
References: <20251107160251.2307088-1-ansuelsmth@gmail.com>
 <20251107160251.2307088-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B39WCCiVv17+HjH0"
Content-Disposition: inline
In-Reply-To: <20251107160251.2307088-2-ansuelsmth@gmail.com>


--B39WCCiVv17+HjH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 05:02:43PM +0100, Christian Marangi wrote:
> The Airoha AN7581 SoC can configure the SCU serdes lines for multiple
> purpose. For example the Serdes for the USB1 port can be both
> used for USB 3.0 operation or for Ethernet. Or the USB2 serdes can both
> used for USB 3.0 operation or for PCIe.
>=20
> The PCIe Serdes can be both used for PCIe operation or for Ethernet.
>=20
> Add bindings to permit correct reference of the different ports in DT,
> mostly to differentiate the different supported modes internally to the
> drivers.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/soc/airoha,scu-ssr.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h
>=20
> diff --git a/include/dt-bindings/soc/airoha,scu-ssr.h b/include/dt-bindin=
gs/soc/airoha,scu-ssr.h
> new file mode 100644
> index 000000000000..a14cef465dad
> --- /dev/null
> +++ b/include/dt-bindings/soc/airoha,scu-ssr.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __DT_BINDINGS_AIROHA_SCU_SSR_H
> +#define __DT_BINDINGS_AIROHA_SCU_SSR_H
> +
> +#define AIROHA_SCU_SERDES_PCIE1		0
> +#define AIROHA_SCU_SERDES_PCIE2		1
> +#define AIROHA_SCU_SERDES_USB1		0
> +#define AIROHA_SCU_SERDES_USB2		1

I'm going to assume that 01 01 is correct here.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--B39WCCiVv17+HjH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ43BwAKCRB4tDGHoIJi
0pVWAP9yALGNfDaXdkKA0VA1cacvoNV1NxfUwR0SjRIKBvFBMQD/VKW6hr/1aS99
fczYQ2vBgCBT3a/Ft3Xpx4X/XlQ8kAU=
=mERD
-----END PGP SIGNATURE-----

--B39WCCiVv17+HjH0--

