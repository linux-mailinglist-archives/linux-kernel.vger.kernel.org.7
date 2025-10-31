Return-Path: <linux-kernel+bounces-879517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA22C234B3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD201893A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF852BEC42;
	Fri, 31 Oct 2025 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="m4Ibix9A"
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DD25A353;
	Fri, 31 Oct 2025 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.167.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888997; cv=none; b=O1LRJXbAfG1wallZDskSbMVz9ZvFXhi2R1FfszsIuztKq6h4XPXsIjVkJLCkvHl80fV/PaMB2CqAiKiqHdecdVnq6gsAU+ZnnCiTAo37obAle9IixHj1EEGgo1xAfGQwI1Ejq2bdV700KGrmIOTiz4iT7zMtJgYRVCfpb8CoJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888997; c=relaxed/simple;
	bh=lQaW+XJrIjrepJWjHZdmt2NPtqyfVuYrZgPwV0L/FhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1N0zJl0ieEeHMpxMRy1oH1FLe913+eSvkZcLPvP/trSCgXHDvwki4Su30xjGtHdula8zbLy/RUVYEjK1IRiIJ2VM1gSfpTu9jhom3vAnwg8PC1ArsP4vNsqNp7RX39K5nvHHzDX5hcSkp+SyFMqjruVu1fX9Ag5r+opStG2vXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de; spf=pass smtp.mailfrom=KARO-electronics.de; dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b=m4Ibix9A; arc=none smtp.client-ip=85.13.167.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
	s=kas202509031142; t=1761888991;
	bh=QEOgTP2F1hs/f1FQ+VeLSXN46Rarm6UBX8onQC94+5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m4Ibix9A19d2WoDL0t2sgknFG54TrAnjI2kLOQM63KHnq4poS2cJ3U/xPZgB/lz77
	 XJYJTbGijsdnFQmQwpbB1noJveQg3ADs0KqIyi3jIFOkkaNhFjDnaLOgFDQdZX6bbZ
	 yQPy2+G7n9o2FTlhDtYCbEtnE45YPLCC4XZdO4EfCGzHRm9g28n5YPNnQ/8jxzRVCy
	 eKsfCvwCYnpu4RXGg5IAmZPlJPKDhywIjrYN/HFeJNRu1nJmZJp52sK0WFhAVUvWRC
	 M4UqGE/nSU0IHxrCJlpRVpRssdCFS7prFeJraSjJZy9VmeU404fk+oMvT3wqntq0CU
	 LLDUES2v45HNA==
Received: from karo-electronics.de (unknown [89.1.81.74])
	by dd54918.kasserver.com (Postfix) with ESMTPSA id 6E27E772C602;
	Fri, 31 Oct 2025 06:36:31 +0100 (CET)
Date: Fri, 31 Oct 2025 06:36:31 +0100
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
Message-ID: <20251031063631.0ea1ec32@karo-electronics.de>
In-Reply-To: <036a04e1-3cb7-44c3-8836-3640f640b4a4@gocontroll.com>
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
	<20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
	<a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
	<65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
	<938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
	<20251029081138.2161a92a@karo-electronics.de>
	<4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
	<20251029104838.44c5adcf@karo-electronics.de>
	<d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
	<0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
	<20251030095434.1dc06df2@karo-electronics.de>
	<036a04e1-3cb7-44c3-8836-3640f640b4a4@gocontroll.com>
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

On Thu, 30 Oct 2025 15:45:14 +0100 Maud Spierings wrote:
> Hi Lothar,
>=20
> On 10/30/25 09:54, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > On Wed, 29 Oct 2025 16:35:25 +0100 Maud Spierings wrote: =20
> >> Hi Matti,
> >>
> >> On 10/29/25 11:05, Matti Vaittinen wrote: =20
> >>> On 29/10/2025 11:48, Lothar Wa=C3=9Fmann wrote: =20
> >>>> Hi,
> >>>>
> >>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote: =20
> >>>>> On 29/10/2025 09:11, Lothar Wa=C3=9Fmann wrote: =20
> >>>>>> Hi,
> >>>>>>
> >>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote: =20
> >>>>>>> On 10/28/25 13:42, Maud Spierings wrote: =20
> >>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote: =20
> >>>>>> [...] =20
> >>>>>>>>> Could/Should this be described using the:
> >>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
> >>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
> >>>>>>>>> correctly, that might allow the driver to be able to use correc=
tly
> >>>>>>>>> scaled voltages.
> >>>>>>>>>
> >>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
> >>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108 =
=20
> >>>>>>>>
> >>>>>>>> Ah I didn't know those existed, should've checked the bindings in
> >>>>>>>> more
> >>>>>>>> detail, thanks for the hint!
> >>>>>>>>
> >>>>>>>> I will have to investigate this carefully, since I don't have
> >>>>>>>> access to
> >>>>>>>> the actual design of the COM, so I don't know exactly what is th=
ere. =20
> >>>>>>>
> >>>>>>> So I am not yet entirely sure if this works out, I used the
> >>>>>>> calculation
> >>>>>>> in the driver:
> >>>>>>>
> >>>>>>> /*
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Setups where regulator (especially the buck=
8) output voltage
> >>>>>>> is scaled
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * by adding external connection where some ot=
her regulator
> >>>>>>> output is
> >>>>>>> connected
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * to feedback-pin (over suitable resistors) i=
s getting popular
> >>>>>>> amongst
> >>>>>>> users
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * of BD71837. (This allows for example scalin=
g down the buck8
> >>>>>>> voltages
> >>>>>>> to suit
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * lover GPU voltages for projects where buck8=
 is (ab)used to
> >>>>>>> supply power
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * for GPU. Additionally some setups do allow =
DVS for buck8 but
> >>>>>>> as this do
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * produce voltage spikes the HW must be evalu=
ated to be able to
> >>>>>>> survive this
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * - hence I keep the DVS disabled for non DVS=
 bucks by default. I
> >>>>>>> don't want
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * to help you burn your proto board)
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * So we allow describing this external connec=
tion from DT and
> >>>>>>> scale the
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * voltages accordingly. This is what the conn=
ection should look
> >>>>>>> like:
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * |------------|
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * |=C2=A0=C2=A0=C2=A0 buck 8=C2=A0 |-------+-=
---->Vout
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 |
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * |------------|=C2=A0=C2=A0=C2=A0 |
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 | FB pin=C2=A0=C2=A0=C2=
=A0 |
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 +-------+--R2---+
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R1
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 V FB-pull-up
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Here the buck output is s=
ifted according to formula:
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Vout_o =3D Vo - (Vpu - Vo)*R2/R1
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Linear_step =3D step_orig*(R1+R2)/R1
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * where:
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Vout_o is adjusted voltage output at vsel r=
eg value 0
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Vo is original voltage output at vsel reg v=
alue 0
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Vpu is the pull-up voltage V FB-pull-up in =
the picture
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * R1 and R2 are resistor values.
> >>>>>>>  =C2=A0=C2=A0=C2=A0 *
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * As a real world example for buck8 and a spe=
cific GPU:
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * VLDO =3D 1.6V (used as FB-pull-up)
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * R1 =3D 1000ohms
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * R2 =3D 150ohms
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * VSEL 0x0 =3D> 0.8V =E2=80=93 (VLDO =E2=80=
=93 0.8) * R2 / R1 =3D 0.68V
> >>>>>>>  =C2=A0=C2=A0=C2=A0 * Linear Step =3D 10mV * (R1 + R2) / R1 =3D 1=
1.5mV
> >>>>>>>  =C2=A0=C2=A0=C2=A0 */
> >>>>>>>
> >>>>>>> Because I do not know the pull up voltage, and I am not sure if it
> >>>>>>> is a
> >>>>>>> pull up.
> >>>>>>>
> >>>>>>> So:
> >>>>>>> Vout_o =3D 1.35V
> >>>>>>> Vo =3D 1.1V
> >>>>>>> Vpu =3D unknown
> >>>>>>> R2 =3D 499 Ohm
> >>>>>>> R1 =3D 2200 Ohm
> >>>>>>> Gives:
> >>>>>>> Vpu =3D ~0V
> >>>>>>>
> >>>>>>> And:
> >>>>>>> Vout_o =3D 1.35V
> >>>>>>> Vo =3D 1.1V
> >>>>>>> Vpu =3D unknown
> >>>>>>> R2 =3D 2200 Ohm
> >>>>>>> R1 =3D 499 Ohm
> >>>>>>> Gives:
> >>>>>>> Vpu =3D ~1.04V
> >>>>>>>
> >>>>>>> I am not quite sure which resistor is R1 and which is R2 but havi=
ng
> >>>>>>> there be a pull down to 0V seems the most logical answer?
> >>>>>>>
> >>>>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some
> >>>>>>> light on
> >>>>>>> this setup. =20
> >>>>>> R2 is connected to GND, so Vpu =3D 0.
> >>>>>> With:
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =3D <1350000>;
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =3D <1350000>;
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0rohm,fb-pull-up-microvolt =3D <0>;
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0rohm,feedback-pull-up-r1-ohms =3D <2200>;
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0rohm,feedback-pull-up-r2-ohms =3D <499>;
> >>>>>> the correct voltage should be produced on the BUCK8 output, but a =
quick
> >>>>>> test with these parameters led to:
> >>>>>> |failed to get the current voltage: -EINVAL
> >>>>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to regist=
er
> >>>>>> buck6 regulator
> >>>>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
> >>>>>>
> >>>>>> Apparently noone has ever tested this feature in real life. =20
> >>>>>
> >>>>> Thanks for trying it out Lothar. I am positive this was tested - but
> >>>>> probably the use-case has been using a pull-up. I assume having the=
 zero
> >>>>> pull-up voltage causes the driver to calculate some bogus values. I
> >>>>> think fixing the computation in the driver might not be that big of=
 a
> >>>>> task(?) The benefit of doing it would be that the correct voltages =
would
> >>>>> be calculated by the driver.
> >>>>>
> >>>>> If real voltages aren't matching what is calculated by the driver, =
then
> >>>>> the voltages requested by regulator consumers will cause wrong volt=
ages
> >>>>> to be applied. Debug interfaces will also show wrong voltages, and =
the
> >>>>> safety limits set in the device-tree will not be really respected.
> >>>>>
> >>>>> I think this would be well worth fixing.
> >>>>>    =20
> >>>> Before doing the real-life test I did the same calculation that's do=
ne
> >>>> in the driver to be sure that it will generate the correct values:
> >>>> bc 1.07.1
> >>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017
> >>>> Free Software Foundation, Inc.
> >>>> This is free software with ABSOLUTELY NO WARRANTY.
> >>>> For details type `warranty'.
> >>>> fb_uv=3D0
> >>>> r1=3D2200
> >>>> r2=3D499
> >>>> min=3D800000
> >>>> step=3D10000
> >>>> # default voltage without divider
> >>>> min+30*step
> >>>> 1100000
> >>>> min=3Dmin-(fb_uv-min)*r2/r1
> >>>> step=3Dstep*(r1+r2)/r1
> >>>> min
> >>>> 981454
> >>>> step
> >>>> 12268
> >>>> # default voltage with divider
> >>>> min+30*step
> >>>> 1349494
> >>>>
> >>>> Probably we need to use this value rather than the nominal 135000 as
> >>>> the target voltage in the DTB. =20
> >>>
> >>> Yes. When the driver calculates the voltages which match the actual
> >>> voltages, then you should also use the actual voltages in the device-=
tree.
> >>>     =20
> >>
> >> Think I've got it:
> >>
> >> diff --git a/drivers/regulator/bd718x7-regulator.c
> >> b/drivers/regulator/bd718x7-regulator.c
> >> index 022d98f3c32a2..ea9c4058ee6a5 100644
> >> --- a/drivers/regulator/bd718x7-regulator.c
> >> +++ b/drivers/regulator/bd718x7-regulator.c
> >> @@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *de=
v,
> >> struct device_node *np,
> >>                                   step /=3D r1;
> >>
> >>                                   new[j].min =3D min;
> >> +                               new[j].min_sel =3D
> >> desc->linear_ranges[j].min_sel;
> >> +                               new[j].max_sel =3D
> >> desc->linear_ranges[j].max_sel;
> >>                                   new[j].step =3D step;
> >>
> >>                                   dev_dbg(dev, "%s: old range min %d,
> >> step %d\n",
> >>
> >>
> >> the min_sel and max_sel fields were uninitialized in the new
> >> linear_range, copying them over from the old one (they refer to the
> >> register range if I understand correctly so they should not change)
> >> initializes them.
> >>
> >> Then setting 1349494 as the actual voltage makes it fully work.
> >> Otherwise it complains:
> >> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
> >>
> >> Final debug output now:
> >> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step =
10000
> >> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
> >> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up
> >> configured
> >>
> >> I will add this fix to the next version of this patchset and include
> >> your requested change in the dts.
> >> =20
> > Does it also work with min/max settings in the DTS that are taken from
> > the designated value +/- 5% tolerance margin, so that the DTS contains
> > reasonable values determined by the HW requirements, rather than some
> > artificial number that is enforced by the SW behaviour?
> > E.g.:
> > 	regulator-min-microvolts =3D <(135000 - 6750)>;
> > 	regulator-min-microvolts =3D <(135000 + 6750)>;
> > Thus, the nominal value of the voltage is explicitly shown in the DTS
> > file. =20
>=20
> Setting that range seems to work:
>=20
I just checked the datasheet of the DRAM powered by the regulator. The volt=
age
tolerance of the 1.35V supply is -.067 V + .1 V.
I.e. the voltage settings should be:
	regulator-min-microvolts =3D <(135000 - 6700)>;
	regulator-max-microvolts =3D <(135000 + 10000)>;
to match the actual requirements of the consumer for this regulator.


Lothar Wa=C3=9Fmann

