Return-Path: <linux-kernel+bounces-811681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893AB52C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF46A17C94D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E088B2E7BC7;
	Thu, 11 Sep 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="rlpEnzLg"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039D2E7198
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581287; cv=none; b=Rr8UhY5W4UkOF3+SGsKAxbNOP+CFCVZUh9NflAo9nw50Q3gCcoHDvgUWI1zP9886tJgLo4WACYYD4LK3gUandUgADUGKUDyUN0iTW2Dck8B2z8gE5tIVdugZie6PIRCI0Xj2XaYCnfYUgUiz5RYknM0Xi0x5pNJhbo7Zqsl/TQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581287; c=relaxed/simple;
	bh=kGj/Gsr8u2gM4mxMjPtIbO3+TvAgVXR18R/TmL7kC8s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BTwJPoYT5Liui96THRaseSPf+qgnH6LitM5ZG2qkg2HSLJUNkkuR+gCpn1qqakpUsXjnwlnZik0QvYZlVSuKrlVjhEllaEBLE42yBAJWmuFe7BGFXc8aoAJVwkaZV3Q61bt/wqRJQb3IBodqFPBA7phBm9zXN2Io5EG1/5rJEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=rlpEnzLg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1757581282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOhuNvmVuf/GyxrRlHUdHw8fHEaK2f199bcbQPpCzOs=;
	b=rlpEnzLgbl0QN8y8xa2LMDj5Y2jUGB5QT6TzfpFMua7/pQ9K5ZUksTmFKmviJ2HgGhk3Sk
	GKHOOkMSjbhx6dPlbl/ysyHqnMS7AHg8C//n+ALK+Y7C6X0MiRXRZaj5ZvFC+cxfdMfOvd
	XgvJgxOE+5byOlMBDpL9JIzOZy9CFSJLkfEeOjYRGrBjjfBaQOFvxrOv1HiCtLOVdogrmh
	sGaiOUQ27WPhFHwR6FdrPWjMKi51T48Rkf6LBWRmG9x29+xtoDzT3oWzJ8QgmG5GLE7cs3
	JQSjljsnrthR3wJTYYK/IDe/I8sJEZDo3bWtHqwXxxeC4qD/bLtJlJBEhGoyhg==
Content-Type: multipart/signed;
 boundary=50ff9f84bc944755ff7976bae1dce62405cf41bd88db2cec6a292aa3edfc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 11 Sep 2025 11:01:14 +0200
Message-Id: <DCPUKAWW5N0Z.AM3JS7S8FJ7A@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Christian Hewitt" <christianshewitt@gmail.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
Cc: "Alex Bee" <knaerzche@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: enable the Mali GPU on
 RK3328 boards
References: <20250906120810.1833016-1-christianshewitt@gmail.com>
 <20250906120810.1833016-2-christianshewitt@gmail.com>
In-Reply-To: <20250906120810.1833016-2-christianshewitt@gmail.com>
X-Migadu-Flow: FLOW_OUT

--50ff9f84bc944755ff7976bae1dce62405cf41bd88db2cec6a292aa3edfc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Sep 6, 2025 at 2:08 PM CEST, Christian Hewitt wrote:
> From: Alex Bee <knaerzche@gmail.com>
>
> Add a gpu node to the rock64 board to enable the Mali GPU and
> move the existing node from roc-pc to the shared roc dtsi to
> enable it also for the roc-cc board.
>
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Now that the 'other' issue with power domains has been resolved, or at
least localized, I feel (more) comfortable giving my

Tested-by: Diederik de Haas <didi.debian@cknow.org>  # Rock64

Cheers,
  Diederik

> ---
> Changes since v2:
> - No changes
> Changes since v1:
> - No changes
>
>  arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts | 4 ----
>  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi   | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++++
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts b/arch/arm64/=
boot/dts/rockchip/rk3328-roc-pc.dts
> index 329d03172433..c0b7b98ff788 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
> @@ -44,10 +44,6 @@ &codec {
>  	mute-gpios =3D <&grf_gpio 0 GPIO_ACTIVE_LOW>;
>  };
> =20
> -&gpu {
> -	mali-supply =3D <&vdd_logic>;
> -};
> -
>  &pinctrl {
>  	ir {
>  		ir_int: ir-int {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3328-roc.dtsi
> index b5bd5e7d5748..7eef6f7f108f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> @@ -160,6 +160,10 @@ &gmac2io {
>  	status =3D "okay";
>  };
> =20
> +&gpu {
> +	mali-supply =3D <&vdd_logic>;
> +};
> +
>  &hdmi {
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/=
boot/dts/rockchip/rk3328-rock64.dts
> index 5367e5fa9232..592fd8ca21df 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -152,6 +152,10 @@ &gmac2io {
>  	status =3D "okay";
>  };
> =20
> +&gpu {
> +	mali-supply =3D <&vdd_logic>;
> +};
> +
>  &hdmi {
>  	avdd-0v9-supply =3D <&vdd_10>;
>  	avdd-1v8-supply =3D <&vcc_18>;


--50ff9f84bc944755ff7976bae1dce62405cf41bd88db2cec6a292aa3edfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaMKP4gAKCRDXblvOeH7b
btAmAP4/fD3deQwUhDfEtz/l+iUwn6XJqEv0cEIsnG13lxcECgD/YbRdmoDzM10V
t3np71DjmSrIwMLbLVp6fZJ4OKbV2Ao=
=I02j
-----END PGP SIGNATURE-----

--50ff9f84bc944755ff7976bae1dce62405cf41bd88db2cec6a292aa3edfc--

