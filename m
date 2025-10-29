Return-Path: <linux-kernel+bounces-875642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87924C19781
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14F84354639
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A640D3002C1;
	Wed, 29 Oct 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="TDtzJGR8"
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225582E22BE;
	Wed, 29 Oct 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.167.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731331; cv=none; b=MpfBa0gk+jShdhnKL9N8bi6+Dok501mkiske1kL87kVbIVd/SIHFD5YCYdVY3lQmgoUHC4rVXMSvpsggpmwQGjB5LnRIHFkYJAiN2HoQAEfCE17AZ4XUdI5fsXdhx8M3ws7ULLxp9Ihar7qy2ZYCz9cRaxNR3v91j7xCI6BQrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731331; c=relaxed/simple;
	bh=qZdOrwnhHhmvKW1sM3Zp3iwo7hcAfqJiRVXLnAoXGP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGRWPQblbHdeuPDBZaDte0T/hzmAixNS0/QvI2VTmUfkRDATqd/QFVfLO8okTHPrD34hVpkEKfDizwkJbUAn22cnG8gJYqw6iKPRVWL8ncKOsq5UHvm5yysqJRzPnXqogX9h5TmEgoplXZMUI5dsciQX6aLSe4imJKtJKPy6x08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de; spf=pass smtp.mailfrom=KARO-electronics.de; dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b=TDtzJGR8; arc=none smtp.client-ip=85.13.167.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
	s=kas202509031142; t=1761731319;
	bh=04PcYjGelANUAIc65GQpYCVFC3ej9UoaMVRsOSXvgHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TDtzJGR86gROx3Pc4Z2qYEJ32hS8ZvtuFzlUGHL57qkvnbaQzRfu6RmoW6ogL08lb
	 AWZMvIYcbK1500vunWsfatyVMYzSWVi+D8brEp+su26RUqgYpl5RMLhKtxIwxE+6ue
	 53GjmTbvpBDVlIktDcjnXme6rfTwJNoVErVKHoEta+XjNxlv4JHe/19m1CBbSp3tDB
	 EbwpeGj7KA3yUvDdKCN5NXYhyImyMYafQbKM3zOOljzxl1SafL1kgf3Krinncnvdyp
	 lO7US+ZMjxNPW4h7YOSxJyAcq/W051Jz9QTgo4AUSOQqRPLgGuyRPjJB7SZmsr6ZNJ
	 Lib7yMYp/ccsg==
Received: from karo-electronics.de (unknown [89.1.81.74])
	by dd54918.kasserver.com (Postfix) with ESMTPSA id 55BA9772C365;
	Wed, 29 Oct 2025 10:48:39 +0100 (CET)
Date: Wed, 29 Oct 2025 10:48:38 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Maud Spierings <maudspierings@gocontroll.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
Message-ID: <20251029104838.44c5adcf@karo-electronics.de>
In-Reply-To: <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
	<20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
	<a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
	<65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
	<938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
	<20251029081138.2161a92a@karo-electronics.de>
	<4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
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

On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
> On 29/10/2025 09:11, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote: =20
> >> On 10/28/25 13:42, Maud Spierings wrote: =20
> >>> On 10/28/25 13:15, Matti Vaittinen wrote: =20
> > [...] =20
> >>>> Could/Should this be described using the:
> >>>> 'rohm,feedback-pull-up-r1-ohms' and
> >>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
> >>>> correctly, that might allow the driver to be able to use correctly
> >>>> scaled voltages.
> >>>>
> >>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
> >>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
> >>>>    =20
> >>>
> >>> Ah I didn't know those existed, should've checked the bindings in more
> >>> detail, thanks for the hint!
> >>>
> >>> I will have to investigate this carefully, since I don't have access =
to
> >>> the actual design of the COM, so I don't know exactly what is there.
> >>>     =20
> >>
> >> So I am not yet entirely sure if this works out, I used the calculation
> >> in the driver:
> >>
> >> /*
> >>    * Setups where regulator (especially the buck8) output voltage is s=
caled
> >>    * by adding external connection where some other regulator output is
> >> connected
> >>    * to feedback-pin (over suitable resistors) is getting popular amon=
gst
> >> users
> >>    * of BD71837. (This allows for example scaling down the buck8 volta=
ges
> >> to suit
> >>    * lover GPU voltages for projects where buck8 is (ab)used to supply=
 power
> >>    * for GPU. Additionally some setups do allow DVS for buck8 but as t=
his do
> >>    * produce voltage spikes the HW must be evaluated to be able to
> >> survive this
> >>    * - hence I keep the DVS disabled for non DVS bucks by default. I
> >> don't want
> >>    * to help you burn your proto board)
> >>    *
> >>    * So we allow describing this external connection from DT and scale=
 the
> >>    * voltages accordingly. This is what the connection should look lik=
e:
> >>    *
> >>    * |------------|
> >>    * |	buck 8  |-------+----->Vout
> >>    * |		|	|
> >>    * |------------|	|
> >>    *	| FB pin	|
> >>    *	|		|
> >>    *	+-------+--R2---+
> >>    *		|
> >>    *		R1
> >>    *		|
> >>    *	V FB-pull-up
> >>    *
> >>    *	Here the buck output is sifted according to formula:
> >>    *
> >>    * Vout_o =3D Vo - (Vpu - Vo)*R2/R1
> >>    * Linear_step =3D step_orig*(R1+R2)/R1
> >>    *
> >>    * where:
> >>    * Vout_o is adjusted voltage output at vsel reg value 0
> >>    * Vo is original voltage output at vsel reg value 0
> >>    * Vpu is the pull-up voltage V FB-pull-up in the picture
> >>    * R1 and R2 are resistor values.
> >>    *
> >>    * As a real world example for buck8 and a specific GPU:
> >>    * VLDO =3D 1.6V (used as FB-pull-up)
> >>    * R1 =3D 1000ohms
> >>    * R2 =3D 150ohms
> >>    * VSEL 0x0 =3D> 0.8V =E2=80=93 (VLDO =E2=80=93 0.8) * R2 / R1 =3D 0=
.68V
> >>    * Linear Step =3D 10mV * (R1 + R2) / R1 =3D 11.5mV
> >>    */
> >>
> >> Because I do not know the pull up voltage, and I am not sure if it is a
> >> pull up.
> >>
> >> So:
> >> Vout_o =3D 1.35V
> >> Vo =3D 1.1V
> >> Vpu =3D unknown
> >> R2 =3D 499 Ohm
> >> R1 =3D 2200 Ohm
> >> Gives:
> >> Vpu =3D ~0V
> >>
> >> And:
> >> Vout_o =3D 1.35V
> >> Vo =3D 1.1V
> >> Vpu =3D unknown
> >> R2 =3D 2200 Ohm
> >> R1 =3D 499 Ohm
> >> Gives:
> >> Vpu =3D ~1.04V
> >>
> >> I am not quite sure which resistor is R1 and which is R2 but having
> >> there be a pull down to 0V seems the most logical answer?
> >>
> >> I am adding Lothar from Ka-Ro to the CC maybe he can shed some light on
> >> this setup.
> >> =20
> > R2 is connected to GND, so Vpu =3D 0.
> > With:
> > 	regulator-min-microvolt =3D <1350000>;
> > 	regulator-max-microvolt =3D <1350000>;
> > 	rohm,fb-pull-up-microvolt =3D <0>;
> > 	rohm,feedback-pull-up-r1-ohms =3D <2200>;
> > 	rohm,feedback-pull-up-r2-ohms =3D <499>;
> > the correct voltage should be produced on the BUCK8 output, but a quick
> > test with these parameters led to:
> > |failed to get the current voltage: -EINVAL
> > |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register bu=
ck6 regulator
> > |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
> >=20
> > Apparently noone has ever tested this feature in real life. =20
>=20
> Thanks for trying it out Lothar. I am positive this was tested - but=20
> probably the use-case has been using a pull-up. I assume having the zero=
=20
> pull-up voltage causes the driver to calculate some bogus values. I=20
> think fixing the computation in the driver might not be that big of a=20
> task(?) The benefit of doing it would be that the correct voltages would=
=20
> be calculated by the driver.
>=20
> If real voltages aren't matching what is calculated by the driver, then=20
> the voltages requested by regulator consumers will cause wrong voltages=20
> to be applied. Debug interfaces will also show wrong voltages, and the=20
> safety limits set in the device-tree will not be really respected.
>=20
> I think this would be well worth fixing.
>=20
Before doing the real-life test I did the same calculation that's done
in the driver to be sure that it will generate the correct values:
bc 1.07.1
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 Free Sof=
tware Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.=20
fb_uv=3D0
r1=3D2200
r2=3D499
min=3D800000
step=3D10000
# default voltage without divider
min+30*step
1100000
min=3Dmin-(fb_uv-min)*r2/r1
step=3Dstep*(r1+r2)/r1
min
981454
step
12268
# default voltage with divider
min+30*step
1349494

Probably we need to use this value rather than the nominal 135000 as
the target voltage in the DTB.


Lothar Wa=C3=9Fmann

