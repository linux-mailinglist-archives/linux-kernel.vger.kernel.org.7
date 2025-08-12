Return-Path: <linux-kernel+bounces-765391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B76B231EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5509C581CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CC2D46B3;
	Tue, 12 Aug 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN3GYcG5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80D2F5E;
	Tue, 12 Aug 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021947; cv=none; b=ILKdj9lCXzXyZ4clAt7BS+0PEDObKm/ACvEfUxRQvQTQtvAwPaKjISzHBOpapC1nEc/Aa9Lmaavt86tWgGdmhv8AE8dRwT/+kUGDxU/vR4/AtG2Q+Vvh1TTCCezcEzWW/WKjpPSNmDlB9n2JVnOptgvFptJvVBYGkt5Riwbgy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021947; c=relaxed/simple;
	bh=e3EDHnAFkz3QLkH+KgtO1Kl2ullAWwjFOAAK/h5xPg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKaYj9NJRO/4fegBxF6xIPylH8gPUSGcx7kCyT2TE75xSiFNLe5qmHnO8OmeHwKcmmkLnM4urt3eFzQ1GLhwbPbKda1/b+CNY7O8/bH71xKiWI2o3xdfhHptUvGf+JffeGKXbObJSVMa4S/9SCkTcyMoZur5fqa+671OTJ4/SDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN3GYcG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC6AC4CEF7;
	Tue, 12 Aug 2025 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755021947;
	bh=e3EDHnAFkz3QLkH+KgtO1Kl2ullAWwjFOAAK/h5xPg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN3GYcG5xbqMEl3xbOxlWXUfZBRNMAsF4EOO8Wl0vAPU5N9K8r974nrhqoupCuUnP
	 Q0c3R9HtlQk0VkthCCTjdraVvC7T6Zs3TqpWbOQbBm9ZlX2s5CjRsieCb+qTon3Cpy
	 WWJZCg8EvQfUdBEB1ruT9SgSdNONTGKytytzIWKTJhc15T6iMhQxziSpe3aiAa9n4P
	 4na2p5qoUbZCReUFAiMN7TplxzYslKnpwwXpjWKzqBuGJfQovIsZin1rmq5M6eNc3v
	 GqJsKTsB3/aWdaQUdvQPl41eOVnSvEOKXtokqjjj2DwCJsuUtfmJUpnN8nMhfLPxDM
	 w6UFHiURvluzA==
Date: Tue, 12 Aug 2025 19:05:43 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/4] riscv: dts: starfive: Add Milk-V Mars CM (Lite)
 SoM
Message-ID: <20250812-endearing-spiral-4c0713898043@spud>
References: <20250724094912.253723-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xCkINtjzkvJccMuz"
Content-Disposition: inline
In-Reply-To: <20250724094912.253723-1-e@freeshell.de>


--xCkINtjzkvJccMuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil,

Could you take a look at this please?

Cheers,
Conor.

On Thu, Jul 24, 2025 at 02:48:43AM -0700, E Shattow wrote:
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
> E Shattow (4):
>   dt-bindings: riscv: starfive: add milkv,marscm-emmc
>   riscv: dts: starfive: add Milk-V Mars CM system-on-module
>   dt-bindings: riscv: starfive: add milkv,marscm-lite
>   riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
>=20
>  .../devicetree/bindings/riscv/starfive.yaml   |   2 +
>  arch/riscv/boot/dts/starfive/Makefile         |   2 +
>  .../dts/starfive/jh7110-milkv-marscm-emmc.dts | 163 ++++++++++++++++
>  .../dts/starfive/jh7110-milkv-marscm-lite.dts | 176 ++++++++++++++++++
>  4 files changed, 343 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc=
=2Edts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite=
=2Edts
>=20
>=20
> base-commit: 28fa0dcb571ab8f3be4d919f0e20e01d4e44bcb1
> --=20
> 2.50.0
>=20
>=20

--xCkINtjzkvJccMuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJuCdgAKCRB4tDGHoIJi
0iEIAP9iINxEHNz2vUO3m9MHWmMibxNgbu5H96ZP510+7QAtBQEArtm65fL7XQ7+
2MV1EPWNefABocjC97GUCOTzB1t4gAk=
=J96J
-----END PGP SIGNATURE-----

--xCkINtjzkvJccMuz--

