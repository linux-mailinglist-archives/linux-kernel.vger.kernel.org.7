Return-Path: <linux-kernel+bounces-738532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EE6B0B9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CF67A4FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCC172BB9;
	Mon, 21 Jul 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="csbDTtQ2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2011566A;
	Mon, 21 Jul 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753060444; cv=none; b=uCm4LUabxvfyAyuO2o2e5BQfLIFEGTCDXlW7ppRG8d4tMJuLFiLkQT3QgsUHiKsvtEO1Iqaq2kTFQelxfzNFhqo/ZFOC6x+qQ/eQQ69e1tpFhP6JQp10Jt/F34koc3dLHp2zs3Q2ViSkNP8my4xDw8rzomIvFRGtb62XaI4R6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753060444; c=relaxed/simple;
	bh=Ava61Vivu7w/mcZfCfpTOpBif8IfUW5XaEI9F1IJOB4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1aTjzJKwsvZjhHqg0T3SpWZjEsP6XT/L+GOSrDJG4Uw8eY0OHQVSJxh1A8/dSPi/n5IXKA39h9EA+DXAS9Fxk6GDaz6O0uLo5dCq6Cjl4xljG3rVhELARBuBBbLABNxmK2FswnIcwyz945cue5ceSaaUvwJSi+vOjdQfL2HWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=csbDTtQ2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753060440;
	bh=Ava61Vivu7w/mcZfCfpTOpBif8IfUW5XaEI9F1IJOB4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=csbDTtQ2jgTPppbMqU8+YPTQ1SgrQ9HL3Lbe0Dhffbn3xftWGJ66X4mI6t9ZdKgxH
	 cesOBugB8X1kPhlHniy8n4njJnYdtELyIWEeQaQ+QB1ySQDFedAFu3RxUDdlyTGNpl
	 hrtKLAp8anZzDl+T1H0zq2KMxEeUR6QLf+pINuDPOMjvmO65nTvCjUtanpyOz4hQDz
	 ytAHYh/NAVuso/BsJMy85oZEmMco4h/VE2q4I+CnyeED8mVpVwoZkJbZKdD7pLQRJp
	 y0sxTBLcUaTo2zMB8xDHqBJdqG9FPUQ1PVRFEg5Qp/azDvSBCCgDJQ7SKBOQvh+YFk
	 S/n6bWfYWu6Yw==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E86056443C;
	Mon, 21 Jul 2025 09:13:59 +0800 (AWST)
Message-ID: <f61d9b4f25e18c37e88c56e3222a387b9ece6c0d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 6/9] ARM: dts: aspeed: Move flash layout out of
 Facebook netbmc-common.dtsi
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Tao Ren
 <taoren@meta.com>
Date: Mon, 21 Jul 2025 10:43:59 +0930
In-Reply-To: <20250706042404.138128-7-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
	 <20250706042404.138128-7-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-05 at 21:23 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Move BMC flash layout from ast2600-facebook-netbmc-common.dtsi to each
> BMC platform so it's easier to apply different layout settings.
>=20
> The fuji data0 partition was already extended to 64MB in Meta
> environment. Elbert flash layout is not changed.
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
> Changes in v2:
> =C2=A0 - None (the patch is introduced in v2).
>=20
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts=C2=A0=C2=A0=
=C2=A0=C2=A0 | 6 ++++++
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++++
> =C2=A0.../arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi | 2 --
> =C2=A03 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/ar=
ch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
> index 74f3c67e0eff..673cabbec92e 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
> @@ -50,6 +50,12 @@ spi_gpio: spi {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0};
> =C2=A0
> +&fmc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@0 {
> +#include "facebook-bmc-flash-layout-128.dtsi"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +};
> +
> =C2=A0&lpc_ctrl {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> =C2=A0};
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch=
/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
> index 840d19d6b1d4..71f58ad1ff06 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
> @@ -223,6 +223,12 @@ eeprom@2 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0};
> =C2=A0
> +&fmc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@0 {
> +#include "facebook-bmc-flash-layout-128-data64.dtsi"

Please don't bury the change of flash layout in a patch that only
claims to push the layout choice down to the platform dts.

Also see my reply on patch 5/9 regarding maintenance for the Wedge400
flash layout.

Andrew

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +};
> +
> =C2=A0&i2c0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0multi-master;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-frequency =3D <100000=
0>;
> diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi=
 b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> index 208cf6567ed4..4f819bf8c909 100644
> --- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> +++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> @@ -54,8 +54,6 @@ flash@0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0m25p,fast-read;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0label =3D "spi0.0";
> -
> -#include "facebook-bmc-flash-layout-128.dtsi"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@1 {


