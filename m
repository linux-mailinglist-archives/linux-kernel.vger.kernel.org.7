Return-Path: <linux-kernel+bounces-804317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7BB471E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155A93A5B92
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D15921CA0E;
	Sat,  6 Sep 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkjD6QR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533C1DA4E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171998; cv=none; b=dCnxHM9jANh2ETXs9Pp+rv0QkHum64Ux+8tNs+WcgzccSY+62s8Fg4VR7V699fffQ1ThkwlSKQjxaD7HCZCeVZ4xymLfVEVJxVHz8L9Oo9Y9PMzyRcc1tlJ3uuQMwi+Jy0yALWgpZniq4cZD83tSXAMHOY/GzdRFbYKEWnKu9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171998; c=relaxed/simple;
	bh=3iOPrN74xVEBO/vjQdWGykSlHCyKwX8oXZwsfk42NFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXPJRNnmIsIZMwiMXq5jDA8FLBm79rAgdybih56XCJZ3mzNjhvzDTsMNLUVj70YBfugLyPRXzU+W8YzdFtipkfiKJ/xkLQIpd2pvf6tsedrP5OK6uwNeNWThnLEKMNYFiz2n7Nbx3G1g0M+7Z78mYKh7id9FV1zZQkR9qmxveO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkjD6QR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21756C4CEF9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757171998;
	bh=3iOPrN74xVEBO/vjQdWGykSlHCyKwX8oXZwsfk42NFQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=gkjD6QR7YJzsrUwSIaXUj90MJ3QfIW6WOmF4eIkOrWl2CMY8fuurur0OkhQdg3Xq4
	 NHZre41UYop/d7lmQ8LonzvT/5iKf5fkE9+cERJKBja0qmIkB9wapmg/obtZVIznxr
	 qYyUxzcaKmIQYGHC/ZZfsbfHgWZ9xDhV5o6VZ2XNJ45JhxsBofwuL7hedTJs3MsZPA
	 HfTcUuyBuL4e0tYt3ylMhCe2pbYg7pv42JRRjYbekEY1pNBGAn5YR56xUq2lONN80c
	 59eMwWlnfFsVXDMP8bwdtCW4Z5BhlzCDGRDwzaEID5NhQxnMHsHPXgfhvMjHrF59HA
	 DpvC8FPzdWWzw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33808d9e10bso25933621fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:19:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnrVpUauhHgfLPow0iuxlsMoByjyayjd5Fq93F+XWATgZkT9uJ0EfL8UMUoun8PonqqMYiQ+67kvdvXDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQh3tZXTXvyqCyb9Vv4wq2+mpq4BOHSTMZnjSoVhtypkE6+Jjo
	i/h6Yn9/tpDpTP6jYzQ63UBGv/Zae1VIfIXwVZv2ZwnLXlqTY134rw/5PfXa4XGU9JDo0lGpodR
	eZXQsXfQGHf4yP3JfsFlY8YDUbLCVYVc=
X-Google-Smtp-Source: AGHT+IHpDYVkVnfYFDnax1QMKGYderiLaGjKlKTAyHREe9npSmqRYhhRbtxlMlcuC4mrm2GRTCrRggKSNMNWOBmjBaQ=
X-Received: by 2002:a05:651c:20cc:20b0:32b:a9a4:cd58 with SMTP id
 38308e7fff4ca-33baef74c92mr4112521fa.15.1757171996500; Sat, 06 Sep 2025
 08:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906041333.642483-1-wens@kernel.org> <20250906041333.642483-11-wens@kernel.org>
 <DU0P190MB244586AE96B47F85AFE7A702BC02A@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DU0P190MB244586AE96B47F85AFE7A702BC02A@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 6 Sep 2025 23:19:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v64w0Hr+hrDoNjSOx=m8hZ37-jM=jDseygmxiRQmtNszEg@mail.gmail.com>
X-Gm-Features: Ac12FXz53VnrcQofrnLM0LEbOU6QTn8gTf2cydyfh9lYODHUFGAWC0ZWxvt-xSQ
Message-ID: <CAGb2v64w0Hr+hrDoNjSOx=m8hZ37-jM=jDseygmxiRQmtNszEg@mail.gmail.com>
Subject: Re: arm64: allwinner: a523: Enable MCU PRCM and NPU
To: Muhammed Subair <msubair@hotmail.com>
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dropping network and DT folks and mailing lists. Please report issues on
the relevant thread.

On Sat, Sep 6, 2025 at 3:30=E2=80=AFPM Muhammed Subair <msubair@hotmail.com=
> wrote:
>
> Hello
>
> I have a board with A527 chip , and NPU is detected in  legacy while the =
new patches shows below message
>
> upstream 6.17-rc4
> # dmesg | grep [   21.988215] etnaviv-gpu 7122000.npu: probe with driver =
etnaviv-gpu failed with error -110
>  7122000
> [   21.988173] etnaviv-gpu 7122000.npu: deferred probe timeout, ignoring =
dependency
> [   21.988215] etnaviv-gpu 7122000.npu: probe with driver etnaviv-gpu fai=
led with error -110

This shows that the driver is waiting for some resource to appear and timed
out. Do you have all needed device drivers enabled? I think you need to hav=
e
the power domain drivers and the MCU clk driver enabled.

ChenYu


> legacy 5.15
>
> [   13.887892] npu[106][106] vipcore, platform device compatible=3Dallwin=
ner,npu
> [   13.890322] npu[106][106] vipcore, platform driver device=3D0xffffff80=
c1a11c10
> [   13.890394] npu[106][106] vipcore irq number is 116.
> [   13.890471] vipcore 7122000.npu: supply npu not found, using dummy reg=
ulator
> [   13.892589] npu[106][106] NPU Use VF3, use freq 696
> [   13.892754] npu[106][106] Get NPU Regulator Control FAIL!
> [   13.892766] npu[106][106] Want set npu vol(1000000) now vol(-22)
> [   13.938664] npu[106][106] core_0, request irqline=3D116, name=3Dvipcor=
e_0
> [   13.938889] npu[106][106] vipcore, allocate page for video memory, siz=
e: 0x2000000bytes
> [   13.938900] npu[106][106] vipcore, video memory heap size is more than=
 4Mbyte,only can allocate 4M byte from page
> [   13.938948] npu[106][106] vipcore, cpu_physical=3D0x10cc00000, vip_phy=
sical=3D0x10cc00000, vip_memsize=3D0x400000
> [   13.940230] npu[106][106] VIPLite driver version 1.13.0.0-AW-2023-01-0=
9
> [   25.090905] sunxi:sunxi_pd_test-0.pd-npu-test:[WARN]: runtime_suspend =
disable clock
>
> -----Original Message-----
> From: Chen-Yu Tsai <wens@kernel.org>
> Sent: Saturday, 6 September 2025 8:14 AM
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft=
.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>=
; Paolo Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof=
 Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Chen-Y=
u Tsai <wens@csie.org>; Jernej Skrabec <jernej@kernel.org>; Samuel Holland =
<samuel@sholland.org>
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@=
lists.infradead.org; linux-sunxi@lists.linux.dev; linux-kernel@vger.kernel.=
org; Andre Przywara <andre.przywara@arm.com>; Jernej Skrabec <jernej.skrabe=
c@gmail.com>
> Subject: [PATCH net-next v3 10/10] arm64: dts: allwinner: t527: orangepi-=
4a: Enable Ethernet port
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> On the Orangepi 4A board, the second Ethernet controller, aka the GMAC200=
, is connected to an external Motorcomm YT8531 PHY. The PHY uses an externa=
l 25MHz crystal, has the SoC's PI15 pin connected to its reset pin, and the=
 PI16 pin for its interrupt pin.
>
> Enable it.
>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> ---
>  .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/=
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> index 38cd8c7e92da..7afd6e57fe86 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -15,6 +15,7 @@ / {
>         compatible =3D "xunlong,orangepi-4a", "allwinner,sun55i-t527";
>
>         aliases {
> +               ethernet0 =3D &gmac1;
>                 serial0 =3D &uart0;
>         };
>
> @@ -95,11 +96,33 @@ &ehci1 {
>         status =3D "okay";
>  };
>
> +&gmac1 {
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&ext_rgmii_phy>;
> +       phy-supply =3D <&reg_cldo4>;
> +
> +       tx-internal-delay-ps =3D <0>;
> +       rx-internal-delay-ps =3D <300>;
> +
> +       status =3D "okay";
> +};
> +
>  &gpu {
>         mali-supply =3D <&reg_dcdc2>;
>         status =3D "okay";
>  };
>
> +&mdio1 {
> +       ext_rgmii_phy: ethernet-phy@1 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <1>;
> +               interrupts-extended =3D <&pio 8 16 IRQ_TYPE_LEVEL_LOW>; /=
* PI16 */
> +               reset-gpios =3D <&pio 8 15 GPIO_ACTIVE_LOW>; /* PI15 */
> +               reset-assert-us =3D <10000>;
> +               reset-deassert-us =3D <150000>;
> +       };
> +};
> +
>  &mmc0 {
>         vmmc-supply =3D <&reg_cldo3>;
>         cd-gpios =3D <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 =
*/
> --
> 2.39.5
>
>

