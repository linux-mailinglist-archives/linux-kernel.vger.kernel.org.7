Return-Path: <linux-kernel+bounces-823272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE89B8603E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E18A467181
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FE31C59D;
	Thu, 18 Sep 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UU28H28T"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53873161A5;
	Thu, 18 Sep 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212540; cv=none; b=jkinRYeciVDqCrCRcnrkdkSQgLBNSbSETCGHWFyKXDVE5H2+K025pLCUm+x5qjI+N7Ng7Z01tQehGc5yRmR8ygRNIW/tA2odFrMz4inGTZ+ZVkZpKGa3KmBqq3G7e3lxBQy+k68R66g5y+5eujgCqrQ9Jn1dc4ITuFakRfAi6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212540; c=relaxed/simple;
	bh=FtsfJN4xPfRjRMw1YqW5hwk2ajn8XRMpiI9Uwq+ok/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR/WMhUch9555H4uenDpjIrmN5fmggRETEoXErBRPYvHAupfgHl/+zDBPgoBnOeuiOM8F7qBvPK9t51rZl2wk/Z3BM2+iPKzdkrBhoHr7DK9BKPPD7p6Ff5w8wGfBK/X5xzkNMKSK0fna4CdH7FvgGEmZXmT2UZC14p6bW347kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UU28H28T; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc;
	bh=6tkeGma96gdssMGmQ/bwCDw+4IJuG2DJOLS8GBEx04Y=; b=UU28H28T+IdwxcIHhq6+rQWoDs
	IXX+mglDASqKZjCoFLpOY2a/8JmSWvc1dslZiwKZUDPkXpE4p4J5bZpgJNNe2SxAak00fpBKzgq6r
	ym5g09YcoUdpoB9aDbFHKILO3eTm62DeZWAiKyh2EJqGoLoMM+rabCh1d/4GcyVgVGATw3PsGgam4
	bXwy4vLPJ3LmnkmDiEQYbiubibtaKvyfJ31thciTeNr5wnYCYltUXNwMl6X+vh/yMKf34hSolXW8F
	yPY+pCGtFXzEa8B7aOUG35Ntfw1hh8l1Ny4WStmmxg++V0chMIYn2y1VSUoVAUwNxk5QfDogLjK2W
	wXIBePTQ==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzHOf-0001zZ-MR; Thu, 18 Sep 2025 18:22:13 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ed Wildgoose <lists@wildgooses.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ed Wildgoose <lists@wildgooses.com>
Subject:
 Re: [PATCH 2/2] rockchip: dts: Enable UART DMA by adding default dma-names
 property
Date: Thu, 18 Sep 2025 18:22:12 +0200
Message-ID: <3477683.usfYGdeWWP@diego>
In-Reply-To: <20250918093246.15623-3-lists@wildgooses.com>
References:
 <20250917114932.25994-1-lists@wildgooses.com>
 <20250918093246.15623-1-lists@wildgooses.com>
 <20250918093246.15623-3-lists@wildgooses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 18. September 2025, 11:32:46 Mitteleurop=C3=A4ische Sommerze=
it schrieb Ed Wildgoose:
> Kernel appears to need a dma-names set for DMA to actually enable. Set a
> default dma-names property for all UARTs defined in the board
> definition: rk3566-radxa-zero-3.dtsi
>=20
> This is tested on a Radxa Zero 3W (which has 5x UARTs) and removes the
> warnings and enables DMA on this platform

the kernel does not _need_ the dmas and the uart will work just fine
without.

And as was pointed out in the previous version, the uarts have possible
stability issues, when connected to specific peripherals

So I'd prefer to not enable uart dmas "just for fun".

Heiko


> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> index e644bfc9c..fc26a4a52 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> @@ -488,21 +488,29 @@ &tsadc {
>  	status =3D "okay";
>  };
> =20
> +&uart1 {
> +	dma-names =3D "tx", "rx";
> +};
> +
>  &uart2 {
> +	dma-names =3D "tx", "rx";
>  	status =3D "okay";
>  };
> =20
>  &uart4{
> +	dma-names =3D "tx", "rx";
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&uart4m1_xfer>;
>  };
> =20
>  &uart5 {
> +	dma-names =3D "tx", "rx";
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&uart5m1_xfer>;
>  };
> =20
>  &uart9 {
> +	dma-names =3D "tx", "rx";
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&uart9m1_xfer>;
>  };
>=20





