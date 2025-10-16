Return-Path: <linux-kernel+bounces-856594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9FBE48FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807AD508BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22500301000;
	Thu, 16 Oct 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5HK/C+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3023EAB4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631698; cv=none; b=GtzXTlnd8GprBgo/uE0nEe0E7wN+pUTVCcniLdaqBFSfHdr5h4ZdmEcD3Q0LWdIXqsJ2/UQ4VpY249VE+aNb9mZIbrIkKVvzujjz8RiuMKTm2Brm1hKQLtfFNBL9wbc4fxRW5uR1k9WIhv4w2i4wiwN10Ql4+Vuvk4hNf8FHJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631698; c=relaxed/simple;
	bh=d0JWx+iyOV58pPeAoCBF1yP8BaIdNbBxpHFhVupbq6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBCASRKt3E/ZJNiZqeuGwdgD3eeLFegWTT35AoRFhRbbVFu32Moj/5nzQogykqaWJAcn6epbCjQ/4/jmWG0qAv8yh1UuXhElgUlZqM0l+HqFu0PsYXmydKE4J3uQ6X8mGsepe938dMyXTA+LQrTWGmLHDFXMVyCXAQWVDLIkjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5HK/C+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0405DC4AF09
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631698;
	bh=d0JWx+iyOV58pPeAoCBF1yP8BaIdNbBxpHFhVupbq6Y=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Y5HK/C+lRDU65jYN6YXzB04XNNb9BqW/k8id1QIZ1WbCL5N0nBHFnXgKmlFisEa6p
	 7ePw8z5AgBwlbm7ZYEgEMy1cJE53KLEFNPw4AEOlqfTeGaWv5wihJ6O+bAYFJvxrHY
	 BJ7zC0JjcRTfexjF/L8D5avnf9lBpoWBks/ejIkfzoXUET2LXKTgzKmqdmmhWB52Ap
	 4OqsFYI+RxZtdr9Pqw6buzxgExZ0uv0CxAUIrYhGb8nyT7a+FzQEtODEOT1OOdVYxp
	 WBXJmjTPRbAs9N7w9S3wVE239Mjfk+Hek9Y0TgWFcsCdhouoxda1zClDjW2Umtqb0+
	 OUHzqwNxvXf9w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3717780ea70so9097131fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:21:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpJzRF0iYl4bLpS5cGpN7KcPVjArKfX25acZUKyma1BM9am3KxetBtr2OXqi5vdMmKwYrPhMiME+THXnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9kmrhdAz8X63BN6dxWsda9tPKE1jb2EQX1CfvjD0b/TTwEmj
	10O7439IfS7oG16qib9RtKoQ+NnZob4NcMfBGD1kXBh2RS+dZ7fKcURSwIPUyiOsxvoIIw/vJWO
	5BmkWKjYp+jvh3bifQcEkDkOiD2VeMVY=
X-Google-Smtp-Source: AGHT+IH/wEilwiHA+j9Hi9fJuPsPWVsSlZQF+xEbG70S6lrNqtLfKQtyWlua7kBThyMdpRujMlTbmYoWWsHtPMbtr4I=
X-Received: by 2002:a2e:bc81:0:b0:36a:878b:6e2c with SMTP id
 38308e7fff4ca-37797817491mr2876461fa.3.1760631696157; Thu, 16 Oct 2025
 09:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-rk3568-vicap-v13-0-da164b4918fe@collabora.com> <20240220-rk3568-vicap-v13-18-da164b4918fe@collabora.com>
In-Reply-To: <20240220-rk3568-vicap-v13-18-da164b4918fe@collabora.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 17 Oct 2025 00:21:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v66JJjVyiKvBdSvdLA8dt5CUnSDLRTnFK=vL7XarVPX2Og@mail.gmail.com>
X-Gm-Features: AS18NWC05gpvlu1169tb3Jp9d3u6Z0FyAGrYnnR8fVGzk_-KM2SW3BuSeb86oLg
Message-ID: <CAGb2v66JJjVyiKvBdSvdLA8dt5CUnSDLRTnFK=vL7XarVPX2Og@mail.gmail.com>
Subject: Re: [PATCH v13 18/18] arm64: dts: rockchip: add radxa camera 8m on
 rock 3a csi port
To: michael.riesch@collabora.com
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Gerald Loacker <gerald.loacker@wolfvision.net>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Markus Elfring <Markus.Elfring@web.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Kever Yang <kever.yang@rock-chips.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Collabora Kernel Team <kernel@collabora.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Alexander Shiyan <eagle.alexander923@gmail.com>, Val Packett <val@packett.cool>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:56=E2=80=AFPM Michael Riesch via B4 Relay
<devnull+michael.riesch.collabora.com@kernel.org> wrote:
>
> From: Michael Riesch <michael.riesch@collabora.com>
>
> Add a device tree overlay for the Radxa Camera 8M (featuring the
> Sony IMX219 image sensor) to be connected to the Radxa ROCK 3A CSI
> port.
>
> The image sensor is connected to the RK3568 VICAP MIPI CSI-2
> port, since as at the time of writing this there is no mainline
> support for the RK3568 ISP.
>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>

This is basically the same as what I reconstructed for my Raspberry Pi
v2 camera, minus the split out regulators.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  arch/arm64/boot/dts/rockchip/Makefile              |   5 +
>  .../dts/rockchip/rk3568-rock-3a-radxa-cam8m.dtso   | 103 +++++++++++++++=
++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index ad684e3831bc..d6b969a0dab9 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -146,6 +146,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-qnap-ts433.dt=
b
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-radxa-e25.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a-radxa-cam8m.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-display-vz.dtbo
> @@ -243,6 +244,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rockpro64-v2=
-screen.dtb
>  rk3399-rockpro64-v2-screen-dtbs :=3D rk3399-rockpro64-v2.dtb \
>         rk3399-rockpro64-screen.dtbo
>
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a-radxa-8m-cam.dtb
> +rk3568-rock-3a-radxa-8m-cam-dtbs :=3D rk3568-rock-3a.dtb \
> +       rk3568-rock-3a-radxa-cam8m.dtbo
> +
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-vz-2-uhd.dtb
>  rk3568-wolfvision-pf5-vz-2-uhd-dtbs :=3D rk3568-wolfvision-pf5.dtb \
>         rk3568-wolfvision-pf5-display-vz.dtbo \
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a-radxa-cam8m.dtso=
 b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a-radxa-cam8m.dtso
> new file mode 100644
> index 000000000000..3aa1ffdc22d8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a-radxa-cam8m.dtso
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device tree overlay for the Radxa Camera 8M attached to the CSI port =
of
> + * the Radxa ROCK 3A.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +&{/} {
> +       clk_camera: clock-camera {
> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <24000000>;
> +               clock-output-names =3D "clk_camera";
> +               #clock-cells =3D <0>;
> +       };
> +
> +       vana_camera: regulator-vana-camera {
> +               compatible =3D "regulator-fixed";
> +               regulator-min-microvolt =3D <2800000>;
> +               regulator-max-microvolt =3D <2800000>;
> +               regulator-name =3D "vana_camera";
> +               vin-supply =3D <&vcc_cam>;
> +       };
> +
> +       vddl_camera: regulator-vddl-camera {
> +               compatible =3D "regulator-fixed";
> +               regulator-min-microvolt =3D <1200000>;
> +               regulator-max-microvolt =3D <1200000>;
> +               regulator-name =3D "vddl_camera";
> +               vin-supply =3D <&vcc_cam>;
> +       };
> +
> +       vdig_camera: regulator-vdig-camera {
> +               compatible =3D "regulator-fixed";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               regulator-name =3D "vdig_camera";
> +               vin-supply =3D <&vcc_cam>;
> +       };
> +};
> +
> +&i2c5 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       status =3D "okay";
> +
> +       imx219: camera-sensor@10 {
> +               compatible =3D "sony,imx219";
> +               reg =3D <0x10>;
> +               clocks =3D <&clk_camera>;
> +               clock-names =3D "xclk";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&camera_reset>;
> +               reset-gpios =3D <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +               VANA-supply =3D <&vana_camera>;
> +               VDDL-supply =3D <&vddl_camera>;
> +               VDIG-supply =3D <&vdig_camera>;
> +
> +               port {
> +                       imx219_output: endpoint {
> +                               data-lanes =3D <1 2>;
> +                               link-frequencies =3D /bits/ 64 <456000000=
>;
> +                               remote-endpoint =3D <&csi_input>;
> +                       };
> +               };
> +       };
> +};
> +
> +&pinctrl {
> +       cam {
> +               camera_reset: camera-reset-pinctrl {
> +                       rockchip,pins =3D <4 RK_PD2 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +};
> +
> +&csi {
> +       status =3D "okay";
> +};
> +
> +&csi_dphy {
> +       status =3D "okay";
> +};
> +
> +&csi_in {
> +       csi_input: endpoint {
> +               data-lanes =3D <1 2>;
> +               link-frequencies =3D /bits/ 64 <456000000>;
> +               remote-endpoint =3D <&imx219_output>;
> +       };
> +};
> +
> +&vicap {
> +       status =3D "okay";
> +};
> +
> +&vicap_mmu {
> +       status =3D "okay";
> +};
>
> --
> 2.39.5
>
>
>

