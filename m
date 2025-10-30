Return-Path: <linux-kernel+bounces-878156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D00C1FE86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D713F1887CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB72FF677;
	Thu, 30 Oct 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="TJzJ511K"
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BC313E2B;
	Thu, 30 Oct 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.167.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825617; cv=none; b=qy4T2zfpJ58D0QCoFltOb10UAMXuHa15VgsTRMSEzFI6RpcAeLVPy9YJxr4U1b0uWdgY1xtnlDQuwBURSak573L1XWqD2FLmir85GIxoBMUjSIimNAh9vuRhOLBU7U+faUjW/Y/LS07jvK9z9a6Wt2yAHzrA13kwz8VuWljhNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825617; c=relaxed/simple;
	bh=sUglKoVc/VLXRM9p0grmAN5nbBQlsBeZ6PJ7XKIOx40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1wGT3y+Zq9rf4t22Kujy+XFpudesGmBnL8XQNUos9J87ypEGi19gXiojRNk2ouCIG3Z0vvd5EtuL3korkS/7IpaIE3BNVoY592NFsUGT+6AsC3wQHTr8doiotVsw2y6phvl40k5d5R0JjHPcCBcQxDCuVydckMtOPaOzu0lKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de; spf=pass smtp.mailfrom=KARO-electronics.de; dkim=pass (2048-bit key) header.d=karo-electronics.de header.i=@karo-electronics.de header.b=TJzJ511K; arc=none smtp.client-ip=85.13.167.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
	s=kas202509031142; t=1761825608;
	bh=KoSpIHesXav88BpAbWZAt/l5Rnoii11g5rgxnEXc2kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TJzJ511Kau45mJR/ckFCA6l46qxr2CBDpYPyYYz1OOpWhPc020ANMEuudO8sjC08G
	 sM9XS3m5lGQ3xQfyCiiGSX5oSe5TQ2vjth86959tI4HZk9+d3HvaVHAx6Hj5nAvK9v
	 dJX/coXRd4466/s0/mW4KrTYGl/jViyWqeGdJnTUuwM5krD+q8aL3fJWURaOv0Gqsm
	 gajocVQfdWpacLTtC62WNP0lKarL4Aag6vDPFaQO9gGu+/YiBBBt4aSF9qzX12cgmZ
	 1L/xK8IMiIbABbkK6L7S/Z9JVT9PjWNR00XTIghNyFX5ruaLOcvtWad1vV6GNF3wJA
	 ZvTEQs1n8pzXw==
Received: from karo-electronics.de (unknown [89.1.81.74])
	by dd54918.kasserver.com (Postfix) with ESMTPSA id E53F9772C542;
	Thu, 30 Oct 2025 13:00:07 +0100 (CET)
Date: Thu, 30 Oct 2025 13:00:06 +0100
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
Message-ID: <20251030130006.0221957a@karo-electronics.de>
In-Reply-To: <26fc62bb-3484-4812-b576-6640eef72c49@gmail.com>
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
	<26fc62bb-3484-4812-b576-6640eef72c49@gmail.com>
Organization: Ka-Ro electronics GmbH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /

Hi,

On Thu, 30 Oct 2025 13:01:52 +0200 Matti Vaittinen wrote:
> On 30/10/2025 10:54, Lothar Wa=C3=9Fmann wrote:
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
> >>>>>>>> =20
>=20
> // snip
>=20
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
> >> =20
>=20
> // snip
>=20
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
> > artificial number that is enforced by the SW behaviour? =20
>=20
> I am unsure what you mean by "artificial number that is enforced by the=20
> SW behaviour"?
>=20
The nominal voltage that is required by the consumer is 1.35 V. That's
the voltage I would expect to set as target for the regulator.
If that voltage cannot be achieved exactly, I would prefer to have the
intended voltage listed explicitly rather than listing a value that
accidentally can be achieved by the regulator but has nothing to do with
the requirements of the consumer.

> I don't know why there should be two different min values? Assuming the=20
> latter should be max - I have no problem seeing a range of allowed=20
>
My copypaste is obviously spoiled... ;)


Lothar Wa=C3=9Fmann

