Return-Path: <linux-kernel+bounces-866655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B7C005BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011E73A9360
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3630ACE8;
	Thu, 23 Oct 2025 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TKrZI5a4"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E803090D9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213357; cv=none; b=Nzr6zu2C/BET4oSUR5Z88l5nQazcdvAowIUMYXcg0WaJVaqAJB7EJfsTJCcmbZQMKomAbuDP25+Y4iPITe9//yPhsdNnxuLerKW1O3pNkStiPYOVs1ZNaQ94sJuUsLa3fLSnii5QPTrbLCCvkrnQbbxRJnm4gOdQqrQsfYq9/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213357; c=relaxed/simple;
	bh=A5mqEPqDlvV+Wx0OuMdmbU9yQ2t83o1bW/oHdl3IY8I=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=qb/5xa7hneqohjGSQiM+yMVdM9HnU/SAvmvltDreppX2rwFdcyuVIY71UEc7rjDY8YYuMCMLASVSrx76KujV6IrIPQW3Af5DiokBIMqdYLr3e9jM6+KYr0N2/xf5Zr970G+G65qU7fZLLy4Li0r7fifqAvWmsxhRo01iZLTS0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TKrZI5a4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251023095547epoutp04d4d5b4f8e208fb1b3109589f8110c720~xFjU59yup1706417064epoutp04K
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:55:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251023095547epoutp04d4d5b4f8e208fb1b3109589f8110c720~xFjU59yup1706417064epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761213347;
	bh=pOaryYPQDNntR+/VBahJztJZMAwGcpiRxDPskux/r7s=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TKrZI5a45huUb/ywvSr3QwMioTL/vVoSWGDv7t8BIhg5j0dK5CSp8GCzfxYHV6DdB
	 QBfOs8dkrVdppU5k1CqiDWaqBy5GWvXfIr39bMYIbwlFQDPesPq8q1PgKxQfRbObuf
	 2Ne6rVr2A+HBlXq+xg2g24cjRC5KTg7wszCfzjEs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251023095546epcas5p4dd05d7effe70e2ec3f076a32c42356a5~xFjUfIM780796707967epcas5p4W;
	Thu, 23 Oct 2025 09:55:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cshHP7442z2SSKX; Thu, 23 Oct
	2025 09:55:45 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251023095545epcas5p303ce95f681afc37c7edbc14ced47052b~xFjTKUykc1026510265epcas5p3z;
	Thu, 23 Oct 2025 09:55:45 +0000 (GMT)
Received: from INBRO001840 (unknown [107.122.3.105]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251023095543epsmtip18add8f62658a6e3400ca348439585988~xFjRjpwMD1373013730epsmtip1B;
	Thu, 23 Oct 2025 09:55:43 +0000 (GMT)
From: "Pritam Manohar Sutar" <pritam.sutar@samsung.com>
To: "'Thinh Nguyen'" <Thinh.Nguyen@synopsys.com>
Cc: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rosa.pila@samsung.com>,
	<dev.tailor@samsung.com>, <faraz.ata@samsung.com>,
	<muhammed.ali@samsung.com>, <selvarasu.g@samsung.com>
In-Reply-To: <20251021220935.5njyz5lyiwrsf3rw@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: Allow usb role swich control from userspace
Date: Thu, 23 Oct 2025 15:25:41 +0530
Message-ID: <058201dc4403$334b0f20$99e12d60$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI/xMG+oqQZ7NyZgvZIYESd8WrlfAEi1ocaArgW4CSz6aOWwA==
Content-Language: en-in
X-CMS-MailID: 20251023095545epcas5p303ce95f681afc37c7edbc14ced47052b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251020112840epcas5p28d8eded5200f096e7b80f71899371f2c
References: <CGME20251020112840epcas5p28d8eded5200f096e7b80f71899371f2c@epcas5p2.samsung.com>
	<20251020113723.553843-1-pritam.sutar@samsung.com>
	<20251021220935.5njyz5lyiwrsf3rw@synopsys.com>

Hi Thinh,

> -----Original Message-----
> From: Thinh Nguyen <Thinh.Nguyen=40synopsys.com>
> Sent: 22 October 2025 03:40 AM
> To: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> Cc: Thinh Nguyen <Thinh.Nguyen=40synopsys.com>;
> gregkh=40linuxfoundation.org; linux-usb=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; rosa.pila=40samsung.com; dev.tailor=40samsung.c=
om;
> faraz.ata=40samsung.com; muhammed.ali=40samsung.com;
> selvarasu.g=40samsung.com
> Subject: Re: =5BPATCH=5D usb: dwc3: Allow usb role swich control from use=
rspace
>=20
> On Mon, Oct 20, 2025, Pritam Manohar Sutar wrote:
> > There is a possibility of user needs for USB mode switching on boards
> > that lack external hardware support for dynamic host/device role
> > detection.
>=20
> It's fine to enable this. But base on this change log, it sounds like the=
re's no use
> case at the moment? If there is one, even if it's only for debugging purp=
ose,
> please note it so. I'm hesitant to accept changes base on use case specul=
ation
> only.
>=20

Thank you for your comments.=20

Yes, a use case exists, especially in automotive, where this feature
is needed to allow user-space applications to switch modes=20
(host to device or vice-versa) at runtime during CarPlay or Android
Auto operations.

Can you please confirm updated commit message with usecase added as below?=
=20

=22
usb: dwc3: Allow usb role swich control from userspace

There is a possibility of user needs for USB mode switching on boards
that lack external hardware support for dynamic host/device role
detection. This is particularly relevant in automotive applications=20
where userspace applications need to switch USB roles (host to device)
at runtime for CarPlay/Android Auto integration.

Add an =60allow_userspace_control=60 flag to handle such cases. When
enabled, it exposes a sysfs attribute that allows userspace to switch
the USB role manually between host and device. This provides flexibility
for platforms that cannot rely on hardware-based mode detection.

The role switch can be done as below
echo host > /sys/class/usb_role/<ADDR>.usb-role-switch/role
echo device > /sys/class/usb_role/<ADDR>.usb-role-switch/role
=22

> Thanks,
> Thinh
>=20
> >
> > Add an =60allow_userspace_control=60 flag to handle such cases. When
> > enabled, it exposes a sysfs attribute that allows userspace to switch
> > the USB role manually between host and device. This provides
> > flexibility for platforms that cannot rely on hardware-based mode detec=
tion.
> >
> > The role switch can be done as below
> > echo host > /sys/class/usb_role/<ADDR>.usb-role-switch/role
> > echo device > /sys/class/usb_role/<ADDR>.usb-role-switch/role
> >
> > Signed-off-by: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> > ---
> >  drivers/usb/dwc3/drd.c =7C 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c index
> > 4c91240eb429..589bbeb27454 100644
> > --- a/drivers/usb/dwc3/drd.c
> > +++ b/drivers/usb/dwc3/drd.c
> > =40=40 -515,6 +515,7 =40=40 static int dwc3_setup_role_switch(struct dw=
c3 *dwc)
> >  	dwc3_role_switch.set =3D dwc3_usb_role_switch_set;
> >  	dwc3_role_switch.get =3D dwc3_usb_role_switch_get;
> >  	dwc3_role_switch.driver_data =3D dwc;
> > +	dwc3_role_switch.allow_userspace_control =3D true;
> >  	dwc->role_sw =3D usb_role_switch_register(dwc->dev,
> &dwc3_role_switch);
> >  	if (IS_ERR(dwc->role_sw))
> >  		return PTR_ERR(dwc->role_sw);
> > --
> > 2.34.1
> >

Thank you,

Regards,
Pritam


