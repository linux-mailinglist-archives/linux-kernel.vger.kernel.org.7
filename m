Return-Path: <linux-kernel+bounces-738531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93FB0B9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B567AA2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B97172BB9;
	Mon, 21 Jul 2025 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Pqbl3gkg"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A0FC0A;
	Mon, 21 Jul 2025 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753060332; cv=none; b=MKhizYXyEaleidN15H4arv0sjfor1dj3DbOAjP2rZf+MBz3E0FvJGtn9yKtJPSRWIMlQMk+RTWVvuidaIsWYyPZvj7AWTgspXcfljLQWWmLEjwiqPOWYfvE3W+1lRMxLwG5tn7swX1OrDwrLfr2NAzhVeSPpGi3FjdfBe7O5q+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753060332; c=relaxed/simple;
	bh=oOcvYWfw0l3RKHi2FRHUu9eHl1KmJbPDtCcJR/Sh3lA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rg7YyME4zYmDE+1mEdcOoBMaJfx5FPYeXwkGwp8/trqnM8dFjvQgd6sDoSWAJNkGVGSCusWY6rVVSXDC9VXDR9LO7FIhpnqtVkx3lGw9XE1d15GtHEQ2ANo8Ezu+UrvRx1NRmfs1gkoLouDkGRagqRFo3pdz2jSLrm5Lk55KnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Pqbl3gkg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753060326;
	bh=s//7MjuX07y4aMFmJCpTEwCT9TCj/TYkQ55O0eQjT4I=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Pqbl3gkgwV28WX8LMF7FFKluhrO2t0iskwad6rrW6ZNv0dkVaSarK2ey92y9gEMOX
	 LGvjl/Zy4czwCdITA9MMQ+6srHX+KsESqY1ZXNfQwzQSvcojwuUhGk8pU7Bw2LI5iI
	 Q6YGhuceFsEqgcshG/gHVKukz3OGhTPgNE1AULMrQwsHSFB1B9JBGN8zjtm+C+DH+O
	 OSnOr0fyXffZpA9nrC8Nyg07E5EzysIyFJp0LkHWr216oO2+72EUjDABLyiIXo4IvM
	 wQZznT4B56QHjxwOIp+OeAOI04nLwIE62l3BKzZYkOg5wWJYHUqLsPKNmViXqy0C9f
	 IXHrXVKuscvpA==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3FD3D6443C;
	Mon, 21 Jul 2025 09:12:04 +0800 (AWST)
Message-ID: <0b9b6c712bff18a25da218c507d18b9a8f18c7e8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 5/9] ARM: dts: aspeed: wedge400: Extend data0
 partition to 64MB
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Tao Ren
 <taoren@meta.com>
Date: Mon, 21 Jul 2025 10:42:03 +0930
In-Reply-To: <20250706042404.138128-6-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
	 <20250706042404.138128-6-rentao.bupt@gmail.com>
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
> Extend wedge400 BMC flash's data0 partition to 64MB for larger
> persistent storage.
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
> Changes in v2:
> =C2=A0 - None (the patch is introduced in v2).
>=20
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> index 3e4d30f0884d..cf6c768cbad5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> @@ -92,7 +92,7 @@ tpm@0 {
> =C2=A0 * Both firmware flashes are 128MB on Wedge400 BMC.
> =C2=A0 */
> =C2=A0&fmc_flash0 {
> -#include "facebook-bmc-flash-layout-128.dtsi"
> +#include "facebook-bmc-flash-layout-128-data64.dtsi"

My preference here is that we maintain two separate DTS for Wedge400:

- aspeed-bmc-facebook-wedge400.dts
- aspeed-bmc-facebook-wedge400-data64.dts

We do so such that we implement aspeed-bmc-facebook-wedge400.dts like:

   > cat aspeed-bmc-facebook-wedge400.dts
   #include "aspeed-bmc-facebook-wedge400-data64.dts"
  =20
   &fmc_flash0 {
   /delete-node/partitions;
   #include "facebook-bmc-flash-layout-128.dtsi"
   };

aspeed-bmc-facebook-wedge400-data64.dts includes facebook-bmc-flash-
layout-128-data64.dtsi as usual.

From there we can consider aspeed-bmc-facebook-wedge400.dts to be
deprecated and can remove it in a future release. At least with this
arrangement any revert of the (future) patch removing aspeed-bmc-
facebook-wedge400.dts has no other impact. Further, both layouts will
be supported in at least one release, making it possible to update the
kernel without requiring a simultaneous update to the flash layout.

Andrew

