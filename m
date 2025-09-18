Return-Path: <linux-kernel+bounces-823364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725CBB8635B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27499165C07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F305C2741CB;
	Thu, 18 Sep 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eO6eaCxD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE114B06C;
	Thu, 18 Sep 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216680; cv=none; b=kI99klyZJhIkIiyZ8bLjNkAJx4yJe2XC7cjVkfkOvvc+ECfVHNtI8vRqOeL3dHYknTQWR5NyDFvITEu0/UZn7eCu78DIr9tMXK8z5FxP548RhRfBWFEyd8MUHaLrt6qLMtF5eemM7ysylVpy9SElt+F426YByZ1NzyTAdAsvcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216680; c=relaxed/simple;
	bh=MJyrprIjQP976NNdfWnB194ny7T1wyJGkK9xEmH6yY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TibBK1nAVYLLNwzUcnEUhJxxI+EL27L0p84esa2UnbueAgeryimOSBrht+yv/MyAyPeLmq27qM0tQjHjW3hqlMxDo74ryYIApzNaV3bsG9CRRXwxYl+sM9nhn5x+Ox2b2Rp3W/CT4lQ2qayQrgp2RF5co2fmIbaPCdz9MW8cyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eO6eaCxD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=yReL3BW5cNgeOoU+ct6Z0+QfxkhYi0zLxLWspzmRmBU=; b=eO6eaCxDj6t7fnCop9QAYLYJgH
	59X7aMuS9JsaTAGxG7jM2PogXRFDOxYTBU0EHDKvoxfG31wmQDx/aTI2pKuqulDdPEgJthfghaKeb
	oDk9ZUzmBfJYRnAZ2iuE9+OyJnJHuYDS+SpstpkdeDwvln/C++hD6c3udYOu9/aWsagBPM0eotUl/
	sTVL4naZ5rlJdwaRQEixAQe5kFO9OuK/NLeKJIlOaDAxs3XV6HpgalP3DAoHVuLQpVEAxG/howhYn
	QH8jxLp+Etb+s3/d8+ccO+yTWQ1aXZrxGFmwFBznxC8TWo4wQPQBmTbsIuYMomj7Dxirrmpn9tOCY
	HYolQ8hg==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzITJ-0002Pr-Qb; Thu, 18 Sep 2025 19:31:05 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject:
 Re: [PATCH v3 1/3] arm64: dts: rockchip: disable display subsystem for Radxa
 E52C
Date: Thu, 18 Sep 2025 19:31:05 +0200
Message-ID: <10594621.0AQdONaE2F@diego>
In-Reply-To: <20250901100027.164594-2-amadeus@jmu.edu.cn>
References:
 <20250901100027.164594-1-amadeus@jmu.edu.cn>
 <20250901100027.164594-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 1. September 2025, 12:00:25 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Chukun Pan:
> The Radxa E52C SBC do not have HDMI output, so disable
> the display subsystem to avoid the following error log:
>=20
> *ERROR* No available vop found for display-subsystem.
>=20
> Fixes: 9be4171219b6 ("arm64: dts: rockchip: Add Radxa E52C")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

I'm torn on the approach vs. just removing the error line in the driver.

Returning -ENODEV from rockchip_drm_platform_of_probe() is correct,
but the error log could just be a debug one instead.

Because running a system without active vops is obviously fine.


Heiko

> ---
>  arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/ar=
m64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> index 48ddc43e2ab5..1883bd183396 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> @@ -207,6 +207,10 @@ &cpu_l3 {
>  	cpu-supply =3D <&vdd_cpu_lit_s0>;
>  };
> =20
> +&display_subsystem {
> +	status =3D "disabled";
> +};
> +
>  &i2c0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&i2c0m2_xfer>;
>=20





