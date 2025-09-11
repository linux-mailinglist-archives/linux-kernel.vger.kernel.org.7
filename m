Return-Path: <linux-kernel+bounces-812659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68DB53B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0D1AA0CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE6369335;
	Thu, 11 Sep 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INoe1vRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61393629AA;
	Thu, 11 Sep 2025 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614036; cv=none; b=uNpDbXgGiyhok9o64oJAbgk0/ZShD8zUhv1cBd91s8jLVQAZu4K9SU3PVO8E4d6VHPAbw97SzRa/h0UZ3hWTOFjpW2EsijJOpCIat59bFu/MO1UlugEkuFxiu034hIDVanPBedKMb0LgwxhF2LGM+7n+aKyzqK3fj9l/G7oa3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614036; c=relaxed/simple;
	bh=KpmAWMFxiOXu0TDDYDSlxIlbky8ODpeK2vXhN2ICIQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yjj24xHVOQmccaA4Hu2uxOnplObJPLZAnqmYVIhIL+wmzsTMinTVpEdh99qAG9peHtQSgygPw05Q5BAGkf/NtdTxNKtLkpP+9ZhvCceHn9lYIliiBGuW6VsDiSNuSNjH3Leup2SJjO4aDbzkcQU1OxTdwbvNLfmiMcTC4k4GlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INoe1vRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B3CC4CEF9;
	Thu, 11 Sep 2025 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757614035;
	bh=KpmAWMFxiOXu0TDDYDSlxIlbky8ODpeK2vXhN2ICIQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INoe1vRnK5LM4Wp7u1tuOus/4QP7QQGPulXi98gRJy9dJrY7QndKrpX9oFtdF3cYs
	 MlydeLOMWEjbnjmtejdp22i8iCvRSLg8IlMmSPaZ7dABNJy5ACkCpDbL42DyKLz1jM
	 gW9wkS09ibGCB6+752U+KXbGnBRYusk2Z6tO9aMhPsB7BB1wEsJVuWYhtCpYSFyoks
	 3DbO018CcwtJJ/VnC7+0M5H4IXGs5UfxUaB0w/OqqEfoUQeJfgvq+W9ug75T2DcoeO
	 czRFrmkOUo1WhCzYBGKR6RQH4k+Cen+ofyBGohViVHrQxAM31/Su8SbuFhYRkbsbMA
	 4Ox2AKhBAFyVQ==
Date: Thu, 11 Sep 2025 19:07:10 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v3 0/5] riscv: dts: starfive: Add Milk-V Mars CM (Lite)
 SoM
Message-ID: <20250911-smoked-aviation-b514261e547e@spud>
References: <20250905144011.928332-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QvKMfygXrttvtNJv"
Content-Disposition: inline
In-Reply-To: <20250905144011.928332-1-e@freeshell.de>


--QvKMfygXrttvtNJv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil, This look okay to take?

On Fri, Sep 05, 2025 at 07:39:38AM -0700, E Shattow wrote:
> Milk-V Mars CM and Mars CM Lite System-on-Module both are based on the
> StarFive JH7110 SoC and compatible with the Raspberry Pi CM4IO Classic IO
> Board carrier. Mars CM Lite is Mars CM without the eMMC storage component
> on mmc0 and the mmc0 interface configured instead for SD Card use. The
> optional WiFi+BT chipset is connected via SDIO on the mmc1 interface that
> would otherwise be connected to an SD Card slot on the StarFive
> VisionFive2 reference design.
>=20
> Add the related devicetree files for both Milk-V Mars CM and Milk-V Mars
> CM Lite describing the currently supported features, namely PMIC, UART,
> I2C, GPIO, eMMC or SD Card, WiFi+BT, QSPI Flash, and Ethernet.
>=20
> Caveat with vendor AP6256 firmware files present the firmware loading is
> successful but subsequently fails IRQ wake initialization. Common GPIO
> conflicts for "WiFi" optioned boards having this module:
>=20
> pwmdac_pins:
>  - AP6256: WL_REG_ON>>WIFI_REG_ON_H_GPIO33
>  - AP6256: WL_HOST_WAKE>>WIFI_WAKE_HOST_H_GPIO34
>=20
> i2c2_pins:
>  - AP6256: UART_CTS_N<<UART1_RTSn_GPIO2
>  - AP6256: UART_RTS_N>>UART1_CTSn_GPIO3
>=20
> i2c6_pins:
>  - AP6256: UART_RXD<<UART_TX_GPIO16
>  - AP6256: UART_TXD>>UART_RX_GPIO17
>=20
> Tested successfully for basic mmc0 storage, USB, and network functionalit=
y on:
> - Milk-V Mars CM 8GB
> - Milk-V Mars CM Lite 4GB
> - Milk-V Mars CM Lite WiFi 8GB
>=20
> Changes since v2:
> - PATCH 3/5 delete newline at end of file
> - PATCH 5/5 delete newline at end of file
>=20
> Link to v2:
> https://lore.kernel.org/lkml/20250831225959.531393-1-e@freeshell.de/
>=20
> E Shattow (5):
>   riscv: dts: starfive: add common board dtsi for Milk-V Mars CM
>     variants
>   dt-bindings: riscv: starfive: add milkv,marscm-emmc
>   riscv: dts: starfive: add Milk-V Mars CM system-on-module
>   dt-bindings: riscv: starfive: add milkv,marscm-lite
>   riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
>=20
>  .../devicetree/bindings/riscv/starfive.yaml   |   2 +
>  arch/riscv/boot/dts/starfive/Makefile         |   2 +
>  .../dts/starfive/jh7110-milkv-marscm-emmc.dts |  12 ++
>  .../dts/starfive/jh7110-milkv-marscm-lite.dts |  25 +++
>  .../dts/starfive/jh7110-milkv-marscm.dtsi     | 159 ++++++++++++++++++
>  5 files changed, 200 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc=
=2Edts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite=
=2Edts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
>=20
>=20
> base-commit: 8181cc2f3f21657392da912eb20ee17514c87828
> --=20
> 2.50.0
>=20

--QvKMfygXrttvtNJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMMPzgAKCRB4tDGHoIJi
0ltQAQDslWMe1fZ4Ww+Wl/yFLRedP+OoXPGPYVU5av62ToVj7wEAs25kRtwxXFFV
17/h/NQnlcQRfNI3GHeBydWBbnX6ugA=
=+/UZ
-----END PGP SIGNATURE-----

--QvKMfygXrttvtNJv--

