Return-Path: <linux-kernel+bounces-859790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE5BEE99E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15A5A4E8A21
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B72EC542;
	Sun, 19 Oct 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YSQqmBdB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A54354ACB;
	Sun, 19 Oct 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889989; cv=none; b=BodusD2CuKkKqMXCcTMQDquKdtcvGpoJi3S3DPvuZ6rt4pvzjzpJnyTa4UBvZi3SdJkj3/qfa0mHvtV9MFMaI9hBDSmg5V+EvXv2myVuHVhw4oavHWVkSGIury0H62UpRiya8jQSOUN8qdJU5DX1sw6gCks+/ok6oy990pvKDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889989; c=relaxed/simple;
	bh=u3kZSbKNkPCt3OL2ozQGD9V/5zpA5+QbIEqPM9ZOqb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKuSZ9+Wszv0V6IgctfMxG3axgUF0sGa+y6P15aDU2tTo73HvONfatrzazW++qkr0x2k2cRVFXzwB3DTJivaKp9eqqHBMas0T40CDvP3x93woeSmVRUAWVDsyyoYH9RmVDIGHprcRX+iQSFXHWO36tMAiFvPA535Zjo01RGCNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YSQqmBdB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AHfKA9U4Qc/kfoVyXIAwIin/0PHtcEBFmI2qkbJlwas=; b=YSQqmBdBp6Cnqio5Q494KslAOs
	4IwGfKAEq3Yx1gDBSm40vA7TITFzwpl7tzPQiEk9pf91Qljfll83vZg7bFt7U76ye5LcZPZcQihYm
	rMD+Tm67OaIlxTr+A/J08+ujbQhWSUCniipMMiuOza4Uk5++DBGDynN1uY8xCwi9U84b8/6uex+U2
	j1wvM7P2YQ7FdQ2dRqlRQoRuMiBSYlHJdZeaT9guLiLTmGrhTfKaKQg3CDVXMApOXZdpL2H7g9MrW
	EJZfKmepspjCiTWqBBKcPOA0c8/SBZ5P2LDmeCerFlB05cvK3DpuzBCfgIg5pJvMP4BB0Z6X46ldl
	sRFA5eAA==;
Received: from i53875a28.versanet.de ([83.135.90.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAVv4-0001nY-Qi; Sun, 19 Oct 2025 18:06:06 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 David Petry <petry103@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Petry <petry103@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable second HDMI output on CM3588
Date: Sun, 19 Oct 2025 18:06:05 +0200
Message-ID: <6801712.G0QQBjFxQf@diego>
In-Reply-To: <20251019142053.11047-1-petry103@gmail.com>
References: <20251019142053.11047-1-petry103@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi David,

Am Sonntag, 19. Oktober 2025, 16:20:53 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb David Petry:
> Enable the second HDMI output port found on FriendlyElec CM3588 and CM3588

the decription sounds like you're referencing two boards, but the change
itself only touches one. Is there a 2nd patch missing or does the wording
above need improvement?

Thanks
Heiko

>=20
> Signed-off-by: David Petry <petry103@gmail.com>
> ---
>  .../rk3588-friendlyelec-cm3588-nas.dts        | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.=
dts b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
> index 5fbbeb6f5a935..10a7d3691a26f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
> @@ -101,6 +101,17 @@ hdmi0_con_in: endpoint {
>  		};
>  	};
> =20
> +	hdmi1-con {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi1_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi1_out_con>;
> +			};
> +		};
> +	};
> +
>  	ir-receiver {
>  		compatible =3D "gpio-ir-receiver";
>  		gpios =3D <&gpio0 RK_PD4 GPIO_ACTIVE_LOW>;
> @@ -335,6 +346,22 @@ hdmi0_out_con: endpoint {
>  	};
>  };
> =20
> +&hdmi1 {
> +	status =3D "okay";
> +};
> +
> +&hdmi1_in {
> +	hdmi1_in_vp1: endpoint {
> +		remote-endpoint =3D <&vp1_out_hdmi1>;
> +	};
> +};
> +
> +&hdmi1_out {
> +	hdmi1_out_con: endpoint {
> +		remote-endpoint =3D <&hdmi1_con_in>;
> +	};
> +};
> +
>  &hdmi_receiver_cma {
>  	status =3D "okay";
>  };
> @@ -350,6 +377,10 @@ &hdptxphy0 {
>  	status =3D "okay";
>  };
> =20
> +&hdptxphy1 {
> +	status =3D "okay";
> +};
> +
>  /* Connected to MIPI-DSI0 */
>  &i2c5 {
>  	pinctrl-names =3D "default";
> @@ -840,3 +871,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>  		remote-endpoint =3D <&hdmi0_in_vp0>;
>  	};
>  };
> +
> +&vp1 {
> +	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
> +		reg =3D <ROCKCHIP_VOP2_EP_HDMI1>;
> +		remote-endpoint =3D <&hdmi1_in_vp1>;
> +	};
> +};
>=20





