Return-Path: <linux-kernel+bounces-889465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAFC3DB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDAA3A1A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592C34A785;
	Thu,  6 Nov 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yIjWpIx5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC372F746F;
	Thu,  6 Nov 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469512; cv=none; b=pdGcWP710wYzUrXEikHcxYJzOgp48ZpZItdVrl5hMlpP5zACyH9j9MidmcZM7TKVqkgpRg7eBz+7yFzEkyBBrXHsQGdbzpzhCD+gguOpySeCMTFgYAT+AbbN0cnMsNFpwBImBaCiC1esEMnzS5PnPUUizpT2XyEXc5JMCx2TRcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469512; c=relaxed/simple;
	bh=T5RnXfkphYkI1OmEJLaNXb5cQNY5bpX8r8geheayJp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2dmf7KqXJnUHq8JtGDWTjtF+YQMJHv2ohKiZEBO7j5liRK8cGRei96Y9/oinEo3dqPBg3fC6pP9GswAwU/piNS5+hFl3p56rrfJT92KDKlfQBMTnikyBfRZuhkw7yxZEcAXfnqjgypVWQUmT2Zk4Mf1VW4CpepbUwOcNF6PWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yIjWpIx5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Dvf/XQpzulji1wBhBHLC8XVhm9Xe3eYDeZQP7tzMob0=; b=yIjWpIx5joxDlkCEEOayYDdvkF
	E4y4iX+xlBS0cYIF0dlv2X8MnTLPR2GT7/iGLLPbDiHL/ftjrbiNsce/KIu/r0bIzisALENVXwMNX
	9Jq0M125bUHdah5OUvBLrV7HdTKu+oHCVuGcqlMNHGXXJCgHTOW5BfTA/OJfY1aANka9B2uu8v+yL
	u3IiKF2KGD3SKucquTQRMVFZo830WdFRVQbu6aywuKLRXZKNIveDqB0l3UScL04mxSqoqs/FlxiDO
	xs3G+PM9CsF+iFlk7eoKcXGbZCwn3ZuahwpDvR273xXHVqppQT5wNtojuAdl9Tgh1USDVzsdjmcDB
	TX20EwoQ==;
Received: from i53875bac.versanet.de ([83.135.91.172] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vH8pR-0001my-97; Thu, 06 Nov 2025 23:51:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Coia Prant <coiaprant@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coia Prant <coiaprant@gmail.com>
Subject:
 Re: [PATCH v5 3/3] arm64: dts: rockchip: Add devicetree for the 9Tripod X3568
 v4
Date: Thu, 06 Nov 2025 23:51:40 +0100
Message-ID: <7930630.EvYhyI6sBW@phil>
In-Reply-To: <20251103171702.1518730-4-coiaprant@gmail.com>
References:
 <20251103171702.1518730-1-coiaprant@gmail.com>
 <20251103171702.1518730-4-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Montag, 3. November 2025, 18:17:02 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Coia Prant:
> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
> It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV=
4 core board
> and the X3568bv4 I/O board.
>=20
> The differences between the core boards
> - PCB size, layout
> - CPU (RKK3568B2/RK3568J)
> - Memory type (DDR4/LPDDR4/LPDDR4X) and size
> - eMMC size
> - DSI/EDP resistor values
> Although the components vary, they maintain full compatibility.
>=20
> The X3568 board has multiple hardware revisions, and we currently support=
 v4 (I/O board).

[...]

> Signed-off-by: Coia Prant <coiaprant@gmail.com>

I've dropped the camera overlay for the time being, when applying the
board, because there were a number of smallish issues with it.

So please submit it separately again. Also, how can you use the camera
yet, when the whole vicap work is still pending?

Details below

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  11 +
>  .../rk3568-9tripod-x3568-v4-camera-demo.dtso  |  84 ++
>  .../rk3568-9tripod-x3568-v4-video-demo.dtso   | 154 +++
>  .../dts/rockchip/rk3568-9tripod-x3568-v4.dts  | 887 ++++++++++++++++++
>  4 files changed, 1136 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-=
camera-demo.dtso
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-=
video-demo.dtso
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4.=
dts
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index ad684e383..959a806a2 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -130,6 +130,9 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-lubancat-1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-nanopi-r3s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-bigtreetech-cb2-manta.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-bigtreetech-pi2.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-9tripod-x3568-v4.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-9tripod-x3568-v4-camera-demo.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-9tripod-x3568-v4-video-demo.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-fastrhino-r66s.dtb
> @@ -252,6 +255,14 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-armsom-sige5=
=2Dv1.2-wifibt.dtb
>  rk3576-armsom-sige5-v1.2-wifibt-dtbs :=3D rk3576-armsom-sige5.dtb \
>  	rk3576-armsom-sige5-v1.2-wifibt.dtbo
> =20
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-9tripod-x3568-v4-camera-demo.dtb
> +rk3568-9tripod-x3568-v4-camera-demo-dtbs :=3D rk3568-9tripod-x3568-v4.dt=
b \
> +	rk3568-9tripod-x3568-v4-camera-demo.dtbo
> +
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-9tripod-x3568-v4-video-demo.dtb
> +rk3568-9tripod-x3568-v4-video-demo-dtbs :=3D rk3568-9tripod-x3568-v4.dtb=
 \
> +	rk3568-9tripod-x3568-v4-video-demo.dtbo
> +

when adding overlays, please sort them correctly,
rk3568-9tripod* should be above rk3568-wolfvision*


>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-wifi.dtb
>  rk3588-edgeble-neu6a-wifi-dtbs :=3D rk3588-edgeble-neu6a-io.dtb \
>  	rk3588-edgeble-neu6a-wifi.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-=
demo.dtso b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-dem=
o.dtso
> new file mode 100644
> index 000000000..2b428ca71
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dt=
so
> @@ -0,0 +1,84 @@

[...]

> +&csi_dphy {
> +	status =3D "okay";
> +
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {

=2E./arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dtso:=
41.8-56.4: Warning (graph_child_address): /fragment@2/__overlay__/ports: gr=
aph node has single child node 'port@0', #address-cells/#size-cells are not=
 necessary


> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			mipi_in_ucam: endpoint@2 {
> +				reg =3D <2>;
> +				remote-endpoint =3D <&ucam_out>;
> +				data-lanes =3D <1 2 3 4>;
> +			};
> +		};
> +	};

/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/arch/arm64/b=
oot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dtb: phy@fe870000 (roc=
kchip,rk3568-csi-dphy): 'ports' does not match any of the regexes: '^pinctr=
l-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/phy/rockchip-inno-cs=
i-dphy.yaml#

not sure what is up with that.

> +};
> +
> +&i2c4 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	status =3D "okay";
> +
> +	camera@37 {
> +		compatible =3D "ovti,ov5695";
> +		reg =3D <0x37>;
> +		clocks =3D <&cru CLK_CIF_OUT>;
> +		clock-names =3D "xvclk";
> +		avdd-supply =3D <&vcc_cam>;
> +		dvdd-supply =3D <&vcc_cam>;
> +		dovdd-supply =3D <&vcc_cam>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&cif_clk>;
> +		reset-gpios =3D <&gpio3 RK_PB6 GPIO_ACTIVE_LOW>;
> +		pwdn-gpios =3D <&gpio4 RK_PB4 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			ucam_out: endpoint {
> +				remote-endpoint =3D <&mipi_in_ucam>;
> +				data-lanes =3D <1 2 3 4>;
> +			};
> +		};

/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/arch/arm64/b=
oot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dtb: camera@37 (ovti,o=
v5695): port:endpoint:data-lanes: [1, 2, 3, 4] is too long
        from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov569=
3.yaml#
/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/arch/arm64/b=
oot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dtb: camera@37 (ovti,o=
v5695): Unevaluated properties are not allowed ('port', 'pwdn-gpios' were u=
nexpected)
        from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov569=
3.yaml#


> +	};
> +};



Heiko



