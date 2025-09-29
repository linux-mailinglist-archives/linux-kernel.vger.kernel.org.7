Return-Path: <linux-kernel+bounces-836119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD84BA8CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB69116F6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13812F0C4D;
	Mon, 29 Sep 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="SOxFflLE"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7F2F0699
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139872; cv=none; b=NNe/Qg7ga5+6Q0oj8YXxVkbvTp1DvvQn9NUolAtAFVcNpSVojnJCAMjQtGK/Sl72h01QywmcYufikjJDPMXIEL80E4Hm2KxNjPoCnFUe/muDs8z6Fabc70hwn5VDSbGSUfaZPEAxNWMw1OKqvWME0xwvStO4wPPQ/CEAxw7mE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139872; c=relaxed/simple;
	bh=oTb9hZpn/9UD6fw2dmFatqWIzfPbm0gUUGcMf1kAo/g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Et1RgLxKXlTidoeFZPwimYCNxtfWTBlu3oQpCG7HeWRasoEbSMvERv2nie9U9z+EwmJcSfFz5Qh+UM5piyxWJmH3ZlEavaqnNsJChnuoskpsoqrXB+A1IXU5zKRYFin7cc2LOHOizyy+wmVIkiNyRtjQvg48pKLVIdpe5BeqiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=SOxFflLE; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1759139856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/FsUHZpUwtMtFiC6QiXyV09jlQR1OM6fWOKHvw5+8w=;
	b=SOxFflLEf6Rjwp29LFayU4mIroCapYlknZs8TqHsmxnrfbpo+GDA33o/QoqwHB4ux2EFBT
	IWU+totZ3Rtgvbj0qDHteY1N/vVjeBH8ERUnec9/pkdyrQvnyca1TYrqH1NZ0IXvA3YYsY
	lBnkBe2PhX+VEb+zQHGcaHiIob424plaOfQ4SRdy8TChu7bm1pgO3oLHAfSGLZs/2ixgZ7
	yP+IVPvlQpGSapgxMYd8p+WW7T5Oj0Q9jRl9/JbTlRA92mkkp9LCtkHPHNhYxvHlEW4lvM
	QzkSHqcJvYWHkHYUdMmKFt+vahEfVCHopzUgWrDU4Ay5vAbe+XxT9j9vczU1PA==
Content-Type: multipart/signed;
 boundary=cb0678fa4e25dcc650e6f47f2c81c7a9ab6e010a75fd318cadeb60384faa;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 29 Sep 2025 11:57:26 +0200
Message-Id: <DD5714TDL1NA.26WS3YF7EMZ5I@cknow.org>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Ondrej Jirman" <megi@xff.cz>, "Martijn Braam" <martijn@brixit.nl>,
 =?utf-8?q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>
Subject: Re: [PATCH v4 1/4] arm64: dts: rk3399-pinephone-pro: Add
 light/proximity sensor support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: <guptarud@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Heiko Stuebner" <heiko@sntech.de>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com> <20250929-ppp_light_accel_mag_vol-down-v4-1-6598f22d3451@gmail.com>
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-1-6598f22d3451@gmail.com>
X-Migadu-Flow: FLOW_OUT

--cb0678fa4e25dcc650e6f47f2c81c7a9ab6e010a75fd318cadeb60384faa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Sep 29, 2025 at 9:35 AM CEST, Rudraksha Gupta via B4 Relay wrote:
> From: Ondrej Jirman <megi@xff.cz>
>
> Pinephone Pro uses STK3311 according to the schematics.
> ...
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
> Signed-off-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 15 +++++++++++++=
++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch=
/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 6f97e57f36f5599f4027a0f3db98bcbc69cef5e5..71d32c4bae0d0336ac0c91204=
3618fc9b94919ef 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -520,6 +520,15 @@ touchscreen@14 {
>  		touchscreen-size-x =3D <720>;
>  		touchscreen-size-y =3D <1440>;
>  	};
> +
> +	light-sensor@48 {
> +		compatible =3D "sensortek,stk3311";
> +		reg =3D <0x48>;
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&stk3311_int>;
> +	};
>  };
> =20
>  &i2c4 {
> @@ -689,6 +698,12 @@ vcc1v8_codec_en: vcc1v8-codec-en {
>  		};
>  	};
> =20
> +	stk3311 {
> +		stk3311_int: stk3311-int {
> +			rockchip,pins =3D <4 RK_PD3 RK_FUNC_GPIO &pcfg_input_pull_up>;

On page 11 and 17 of PPP schematic V1.0-20211127 I see LIGHT_INT_L as
identifier so it's best to use that identifier here, thus
``light_int_l: light-int-l {``
and update the pinctrl-0 reference accordingly.

Cheers,
  Diederik

> +		};
> +	};
> +
>  	wireless-bluetooth {
>  		bt_wake_pin: bt-wake-pin {
>  			rockchip,pins =3D <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;


--cb0678fa4e25dcc650e6f47f2c81c7a9ab6e010a75fd318cadeb60384faa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNpYCAAKCRDXblvOeH7b
bvsuAPsEC/G3fJAw/u6yVlNjqrrlLRyZ1BAsI/p7LKdixd2uOgEAkW/WYh9W3sk7
dKjhmsr7Dc8j5Hx0B0dGqOs3NS6jzgY=
=zCuL
-----END PGP SIGNATURE-----

--cb0678fa4e25dcc650e6f47f2c81c7a9ab6e010a75fd318cadeb60384faa--

