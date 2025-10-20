Return-Path: <linux-kernel+bounces-860894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1FBF139E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121B718A5596
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120A3128BC;
	Mon, 20 Oct 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zjTdNbwz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F530F529;
	Mon, 20 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963486; cv=none; b=ErY+SKM69qwQ5wiunf3LPpcnfJfwEOdxUOF/6d/OJa6tiBS8Dby7dBQuabLkDNu85Nj6gcBJZ9983HUgH2sDFvci0PIRCks0XzMsTh10LZ5b4u62/ApGKPvKJKfVmcB3OvznN9KHTLVnXINvWZENuQH4V7TiEkeN7T//ejNUZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963486; c=relaxed/simple;
	bh=hLvEPzpEX38BPgXOYVeWukoNBfiE74v/p7+sf0ef6Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0v7T4V+Mz2tekKKy7UWnUuGlf5VAnLzS6NaSE8WQcixdAOP/TZ8IIgmJeUvfL3IOrKRmlf0jO/95rbXlyIga6VxnLZHVLNM2Bs/xuGrLHZTzSsy33h9vovZWYk2XlGQ4bNWLo0TOQfGNcNYOkzl/ir1LOo4ffM74CqLCtrQ2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zjTdNbwz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MhYxWhLFynEPuXGXf6NvRZnWZ6WgJyN1EoBH8Cps2Ag=; b=zjTdNbwzRfJ02QMBrrUYQyahQC
	e9N3vAi5TdIP52ZJc9LOJrjBvU+FQY7C7UqYSd4R0ulVAW1xYAUKXit/t/Rr4/7MZxilfLTNNJgac
	TlFiOtt/tM3BpXEYQzfEO+lrPttm2Zk9zvunVObYN9FvqgCaOWoNYUx/SS2DDJ5g/lH8VblaMS2fZ
	7ZT+SpN4ORtxBml2817HjzBDIFLE6qL/CmK8DJm0yEeTns6Dk/df/NPZeiwBHJhNsNxzx4kD0nkHi
	5hMv45MUTUZN0U8f5/YH/rZ6GrqqID3rYMB42Sqypt8jJYpXqM01Qg8aZU+kjq2Zupd4ICtFzxcNp
	WqFKgMJw==;
Received: from [141.76.253.240] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAp2f-0000zJ-3h; Mon, 20 Oct 2025 14:31:13 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add DSI LCD display on rk3576-evb1
Date: Mon, 20 Oct 2025 14:31:12 +0200
Message-ID: <12339028.CDJkKcVGEf@phil>
In-Reply-To: <748fd61a-31fb-436f-b028-b47807a4860c@gmail.com>
References:
 <20250925-rk3576-evb1-dsi-v1-1-c76fc3740abc@gmail.com>
 <5143458.iZASKD2KPV@phil> <748fd61a-31fb-436f-b028-b47807a4860c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 20. Oktober 2025, 10:50:58 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Alexey Charkov:
>=20
> On Mon, Oct 20, 2025 at 12:31=E2=80=AFPM Heiko Stuebner <heiko@sntech.de>=
 wrote:
> >
> > Am Montag, 20. Oktober 2025, 10:19:51 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Alexey Charkov:
> > > On Thu, Sep 25, 2025 at 12:38=E2=80=AFAM Alexey Charkov <alchark@gmai=
l.com> wrote:
> > > >
> > > > Add support for the Rockchip W552793DBA-V10 LCD+touchscreen assembl=
y which
> > > > comes physically attached to Rockchip RK3576 EVB1 boards.
> > > >
> > > > The display part is driven by the on-chip MIPI DSI controller, and =
the
> > > > touchscreen is connected over I2C.
> > > >
> > > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > > ---
> > > > Note that backlight support is left out for now, as it depends on P=
WM
> > > > support [0] which has not yet been merged.
> > > >
> > > > A workaround is simply `gpioset -c 0 13=3D1` to set the respective =
GPIO
> > > > pin high and thus to light up the display unconditionally.
> > > >
> > > > [0] https://lore.kernel.org/lkml/20250602-rk3576-pwm-v2-0-a6434b0ce=
60c@collabora.com/
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 89 ++++++++++++=
++++++++++++
> > > >  1 file changed, 89 insertions(+)
> > >
> > > Hi Heiko,
> > >
> > > Any thoughts about this one? Can we perhaps get it merged for -next?
> >
> > Does the gpio-backlight work on that device?
> > That would make the gpioset hack unnecessary.
>=20
> I've got a local patch using pwm-gpio and pwm-backlight as a stop-gap=20
> solution, but I don't think it's worth merging upstream, because the=20
> backlight is supposed to be driven by the hardware PWM on the same pin=20
> (not bit-banging the GPIO line). After all, Nicolas has been working on=20
> adding a proper hardware PWM driver for RK3576.
>=20
> The display itself works without PWM support, and so does the touchscreen.

Right now, I don't think we have an actual timeline if/when Nicolas will
be able to work on the pwm again. So my idea was if we want to
integrate the baclight as you described below, to have an actual usable
display and then when the new pwm has landed switch over to that one?


Heiko


> My temp patch goes like this:
>=20
> ---
>   arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts=20
> b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
> index f20cd6f2c079..5c27fff03569 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
> @@ -58,6 +58,14 @@ button-vol-up {
>   		};
>   	};
>=20
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		brightness-levels =3D <20 220>;
> +		default-brightness-level =3D <100>;
> +		num-interpolated-steps =3D <200>;
> +		pwms =3D <&lcd_bl_pwm 0 25000 0>;
> +	};
> +
>   	hdmi-con {
>   		compatible =3D "hdmi-connector";
>   		type =3D "a";
> @@ -78,6 +86,12 @@ work_led: led-0 {
>   		};
>   	};
>=20
> +	lcd_bl_pwm: pwm {
> +		#pwm-cells =3D <3>;
> +		compatible =3D "pwm-gpio";
> +		gpios =3D <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> +	};
> +
>   	vbus5v0_typec: regulator-vbus5v0-typec {
>   		compatible =3D "regulator-fixed";
>   		regulator-name =3D "vbus5v0_typec";
> @@ -277,6 +291,7 @@ panel@0 {
>   		compatible =3D "wanchanglong,w552793baa", "raydium,rm67200";
>   		reg =3D <0>;
>=20
> +		backlight =3D <&backlight>;
>   		iovcc-supply =3D <&vcc3v3_lcd_n>;
>   		reset-gpios =3D <&gpio3 RK_PB5 GPIO_ACTIVE_LOW>;
>   		vdd-supply =3D <&vcc3v3_lcd_n>;
>=20





