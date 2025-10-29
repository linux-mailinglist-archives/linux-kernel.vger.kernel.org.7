Return-Path: <linux-kernel+bounces-875319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5BC18AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6113A4601FE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF63126A2;
	Wed, 29 Oct 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="bznq++z1"
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276330F944;
	Wed, 29 Oct 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.167.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722468; cv=none; b=qdUYWPRGeiuqjS8DDIi6XIGzexACuO6tMVbAg7yb2kRYhdQhjTqP2zpk7Ifp+XcaeUnDHCupBa8r/CNfx2Zdi3CZpPru4RhbRwiyHT59XqntJ72RnJwLZKfEYk4INgzwyA7Fa6fStjzRpYRYOqfGgXZIhadd04k8DWRAIEOD9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722468; c=relaxed/simple;
	bh=Ep9YwSgs0Aw5mqUfs23xGd+sVMID51I+Lkb//qQB47w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ4lv2mKtc8QbPZJB9Ph53mJTIUlT7yrkfS5fT0GyRahgsBz+3RUV3CdXP5SAR2rPOcVub9CZGq52WTAQhYYMUZsRdKCrnCmh9uZvqoCSO2wfBnzMtF1oS+ZuaA9W4jte8Arh/A9BkWSfkRvM6WFH34MLRbgUTgsT+3S6/DB/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de; spf=pass smtp.mailfrom=KARO-electronics.de; dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b=bznq++z1; arc=none smtp.client-ip=85.13.167.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
	s=kas202509031142; t=1761721899;
	bh=p4QsNcOQhnUQw6VKEs7EI/wgC6PCFii9ExA5HZIUu54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bznq++z1b8rF88YPcJ6xYK7ARpc5BTe4nHGirZoOAmRxuOpP6qsWpbhDl+YJIo4Sa
	 1xp7tRIrE6inZOQEh7tLtORenFq22DazEDbm72wtHcPpMHPdGOW0RR2As/KtzRm6hm
	 h+ggStXDiMT8tKoPcI+oWGccGbYV8+Kd4sX6W98RnzhBdJk07WsloMsyICnrKkcmMi
	 EvlCHhmUsG9z1w9HNONCrZ2sOgjqR8SEyv4PQCn9bxIGKZcGgNH4cnOgTPi3ntgGil
	 SNXjBfuIY1n+xEoCYcstKwVb4ZhjLy9ZQZUnzWrMnYAkzTPejA2GAuwMacrThsSEL7
	 XVV8ou4/lOLgQ==
Received: from karo-electronics.de (unknown [89.1.81.74])
	by dd54918.kasserver.com (Postfix) with ESMTPSA id 4A289772C311;
	Wed, 29 Oct 2025 08:11:39 +0100 (CET)
Date: Wed, 29 Oct 2025 08:11:38 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
Message-ID: <20251029081138.2161a92a@karo-electronics.de>
In-Reply-To: <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
	<20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
	<a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
	<65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
	<938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
Organization: Ka-Ro electronics GmbH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: +

Hi,

On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
> On 10/28/25 13:42, Maud Spierings wrote:
> > On 10/28/25 13:15, Matti Vaittinen wrote: =20
[...]
> >> Could/Should this be described using the:
> >> 'rohm,feedback-pull-up-r1-ohms' and
> >> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment=20
> >> correctly, that might allow the driver to be able to use correctly=20
> >> scaled voltages.
> >>
> >> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/=20
> >> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
> >> =20
> >=20
> > Ah I didn't know those existed, should've checked the bindings in more=
=20
> > detail, thanks for the hint!
> >=20
> > I will have to investigate this carefully, since I don't have access to=
=20
> > the actual design of the COM, so I don't know exactly what is there.
> >  =20
>=20
> So I am not yet entirely sure if this works out, I used the calculation=20
> in the driver:
>=20
> /*
>   * Setups where regulator (especially the buck8) output voltage is scaled
>   * by adding external connection where some other regulator output is=20
> connected
>   * to feedback-pin (over suitable resistors) is getting popular amongst=
=20
> users
>   * of BD71837. (This allows for example scaling down the buck8 voltages=
=20
> to suit
>   * lover GPU voltages for projects where buck8 is (ab)used to supply pow=
er
>   * for GPU. Additionally some setups do allow DVS for buck8 but as this =
do
>   * produce voltage spikes the HW must be evaluated to be able to=20
> survive this
>   * - hence I keep the DVS disabled for non DVS bucks by default. I=20
> don't want
>   * to help you burn your proto board)
>   *
>   * So we allow describing this external connection from DT and scale the
>   * voltages accordingly. This is what the connection should look like:
>   *
>   * |------------|
>   * |	buck 8  |-------+----->Vout
>   * |		|	|
>   * |------------|	|
>   *	| FB pin	|
>   *	|		|
>   *	+-------+--R2---+
>   *		|
>   *		R1
>   *		|
>   *	V FB-pull-up
>   *
>   *	Here the buck output is sifted according to formula:
>   *
>   * Vout_o =3D Vo - (Vpu - Vo)*R2/R1
>   * Linear_step =3D step_orig*(R1+R2)/R1
>   *
>   * where:
>   * Vout_o is adjusted voltage output at vsel reg value 0
>   * Vo is original voltage output at vsel reg value 0
>   * Vpu is the pull-up voltage V FB-pull-up in the picture
>   * R1 and R2 are resistor values.
>   *
>   * As a real world example for buck8 and a specific GPU:
>   * VLDO =3D 1.6V (used as FB-pull-up)
>   * R1 =3D 1000ohms
>   * R2 =3D 150ohms
>   * VSEL 0x0 =3D> 0.8V =E2=80=93 (VLDO =E2=80=93 0.8) * R2 / R1 =3D 0.68V
>   * Linear Step =3D 10mV * (R1 + R2) / R1 =3D 11.5mV
>   */
>=20
> Because I do not know the pull up voltage, and I am not sure if it is a=20
> pull up.
>=20
> So:
> Vout_o =3D 1.35V
> Vo =3D 1.1V
> Vpu =3D unknown
> R2 =3D 499 Ohm
> R1 =3D 2200 Ohm
> Gives:
> Vpu =3D ~0V
>=20
> And:
> Vout_o =3D 1.35V
> Vo =3D 1.1V
> Vpu =3D unknown
> R2 =3D 2200 Ohm
> R1 =3D 499 Ohm
> Gives:
> Vpu =3D ~1.04V
>=20
> I am not quite sure which resistor is R1 and which is R2 but having=20
> there be a pull down to 0V seems the most logical answer?
>=20
> I am adding Lothar from Ka-Ro to the CC maybe he can shed some light on=20
> this setup.
>
R2 is connected to GND, so Vpu =3D 0.
With:
	regulator-min-microvolt =3D <1350000>;
	regulator-max-microvolt =3D <1350000>;
	rohm,fb-pull-up-microvolt =3D <0>;
	rohm,feedback-pull-up-r1-ohms =3D <2200>;
	rohm,feedback-pull-up-r2-ohms =3D <499>;
the correct voltage should be produced on the BUCK8 output, but a quick
test with these parameters led to:
|failed to get the current voltage: -EINVAL
|bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register buck6 =
regulator
|bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22

Apparently noone has ever tested this feature in real life.


Lothar Wa=C3=9Fmann

