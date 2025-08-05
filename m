Return-Path: <linux-kernel+bounces-756052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B371B1AF31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465CD177E33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985B230BD2;
	Tue,  5 Aug 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="no8kx89s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="glCnyA+f"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD122F767;
	Tue,  5 Aug 2025 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377837; cv=none; b=Z/dvl4dVYTJkIWat3uoKvhJzB8nNGe8Y+dKWN+deKcwBFx6BOI/ziykr0lXMEN3/lKThups2O/sQXa/U2qbYLAd+sg8enSrjH9PwnRbnh0/XZWgpaLC6edGnqflY8xajdv3BdCvZxPrZ6WVtO9dbYNH/qh6ddE2BOLUSENs2ZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377837; c=relaxed/simple;
	bh=zSNJZOZFX9hckn6mXpstET/OnFkhJk3WprzXlL1fO90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfC91QNjalsVhlNf3SAZbLTTj5eVjHVzzfAzvbKhkHoLHi6v2/Ai+HPv39Ygxt042LxdkLkN7RLssX0APaqhXQUBvonMpAvpDGESImIBfRowVGULO7JO/dMkBeRzsq+bdWs1cIxKOWGTUEqLgglAySNf12m5XU456TzBrvTcxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=no8kx89s; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=glCnyA+f reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754377834; x=1785913834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EeUMDc2WntfI8A+x14TyU5FunBo17nAG01EM1yXferM=;
  b=no8kx89s5PZc+b4B/nUvwtfJd1Kmdx7gyIqnya1Z2cqlFAL0drVGYhUb
   jaMl4glCh8BdzuYpV9Keej0JSzH15k/YuwS3eI/fyjoFQGi+xxYGAAPlo
   hD/vGIsDx95FuSixJvBZxE83zKL2Sh1BT2yJTa3uNxE82MHDdGBYv2nLO
   clZn6/2Z+Fpf0QYKNmMPBFqwYpQchmGuGHdXmn9L22PZWQ/ixzvfNrPPk
   RmIxQgcbKYtqYVbYwKmsWZILaedH6Lvx1LTwtI30czE4nwWjQuuNChzZa
   FUmmCExwDr9gW4X9TkZafDR6FPWmm9j4FfkAZ8q7hGkwOQR0csFH9dNEH
   Q==;
X-CSE-ConnectionGUID: 8OggMXCVRb67Yq9VaFkfPg==
X-CSE-MsgGUID: 8IVFNqAAS7ej/ExTuYvMvg==
X-IronPort-AV: E=Sophos;i="6.17,265,1747692000"; 
   d="scan'208";a="45583489"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Aug 2025 09:10:30 +0200
X-CheckPoint: {6891AE67-1-D4215818-E44699D1}
X-MAIL-CPID: 2D3DFB7860E93CFACCD9674F0CED3F89_0
X-Control-Analysis: str=0001.0A00210F.6891ADD9.008C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BCE91726E2;
	Tue,  5 Aug 2025 09:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754377826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeUMDc2WntfI8A+x14TyU5FunBo17nAG01EM1yXferM=;
	b=glCnyA+fmdYQNcL4hjR8TMji7ODikkmnhi0R1O5XQKeNugloKyyvHZQ83XwJsYjuB6+8Ae
	1udmhwtm9IlRZMmkW5O1u4TvP2X52nDpukEcApOm7q1jggNxlhFiQhYMnuxkCUJjAVr7Vn
	tfIQBcOQ7fdpjlqABQzQMMWOql2v0VjnXLsJ2ofukHDzU+/Pw5YpmRrN/NdoFKg1UVpgJB
	yKrDxvf9s14PS8vHOXhKatmVvMjbNox2QiHoGEdtuIblD/2y4CEOtq7+KQPObM2JexudQy
	Ov1xWntFqW8YSfXdMs5lUCO5+PAVsG9gunueaE/fPDP386+Ov+rHz04r9B8CsQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
 cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 l.stach@pengutronix.de, shengjiu.wang@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject:
 Re: [PATCH v3 6/6] arm64: dts: imx8mp: Add hdmi parallel audio interface node
Date: Tue, 05 Aug 2025 09:10:25 +0200
Message-ID: <1932645.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250804104722.601440-7-shengjiu.wang@nxp.com>
References:
 <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <20250804104722.601440-7-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Montag, 4. August 2025, 12:47:22 CEST schrieb Shengjiu Wang:
> The HDMI TX Parallel Audio Interface (HTX_PAI) is a bridge between the
> Audio Subsystem to the HDMI TX Controller.
>=20
> Shrink register map size of hdmi_pvi to avoid overlapped hdmi_pai device.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  4 +++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 28 +++++++++++++++++++-

Please separate commits for SoC and board files. Thanks

Best regards,
Alexander

>  2 files changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> index c0cc5611048e..cc9351a5bd65 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -442,6 +442,10 @@ &flexcan2 {
>  	status =3D "disabled";/* can2 pin conflict with pdm */
>  };
> =20
> +&hdmi_pai {
> +	status =3D "okay";
> +};
> +
>  &hdmi_pvi {
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 841d155685ee..00d8474bd1b1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -2066,7 +2066,7 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
> =20
>  			hdmi_pvi: display-bridge@32fc4000 {
>  				compatible =3D "fsl,imx8mp-hdmi-pvi";
> -				reg =3D <0x32fc4000 0x1000>;
> +				reg =3D <0x32fc4000 0x800>;
>  				interrupt-parent =3D <&irqsteer_hdmi>;
>  				interrupts =3D <12>;
>  				power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
> @@ -2092,6 +2092,24 @@ pvi_to_hdmi_tx: endpoint {
>  				};
>  			};
> =20
> +			hdmi_pai: audio-bridge@32fc4800 {
> +				compatible =3D "fsl,imx8mp-hdmi-pai";
> +				reg =3D <0x32fc4800 0x800>;
> +				interrupt-parent =3D <&irqsteer_hdmi>;
> +				interrupts =3D <14>;
> +				clocks =3D <&clk IMX8MP_CLK_HDMI_APB>;
> +				clock-names =3D "apb";
> +				power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PAI>;
> +				status =3D "disabled";
> +
> +				port {
> +
> +					pai_to_hdmi_tx: endpoint {
> +						remote-endpoint =3D <&hdmi_tx_from_pai>;
> +					};
> +				};
> +			};
> +
>  			lcdif3: display-controller@32fc6000 {
>  				compatible =3D "fsl,imx8mp-lcdif";
>  				reg =3D <0x32fc6000 0x1000>;
> @@ -2143,6 +2161,14 @@ port@1 {
>  						reg =3D <1>;
>  						/* Point endpoint to the HDMI connector */
>  					};
> +
> +					port@2 {
> +						reg =3D <2>;
> +
> +						hdmi_tx_from_pai: endpoint {
> +							remote-endpoint =3D <&pai_to_hdmi_tx>;
> +						};
> +					};
>  				};
>  			};
> =20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



