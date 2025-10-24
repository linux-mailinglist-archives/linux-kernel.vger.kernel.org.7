Return-Path: <linux-kernel+bounces-868369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30693C050D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1F984EF100
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509E305958;
	Fri, 24 Oct 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A3KqldqN"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2B2556E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294737; cv=none; b=IfJb+fvxncD6Fw0VSTn46r8Y5+1mNKIZ9ySDnGXYcktOYSLqqVsSuEX5KXMVIrAQ47KiSvOx+ifCcR/YqRdOjZuFU8H9vbYVmdX3zSrL/WjVr4JkYnrokh2KTM9lmsGEsG/Ri7g0yATrVSeXwJujL9zppjz50rtoDjGXBNsmbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294737; c=relaxed/simple;
	bh=ykg1faROnkghwYFMVKMEds7rWrVt1TtPgNqzY/YIp68=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NjjXUR/sKhU9Zu+aCDa/TeublIevlSNJc7T48oYo+5wiNsoiFCeF0JrDKOwwn+tf11hECEbX3E9Ya4fR6G6xUUfqU4QF3N+R0b1rxfc88qaKRVTE+X1ZWLhXSZU6vyjJ+FAIjnZUibGVWPzCA1M1wHUZSAwKwuRZOEpCBgdwfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A3KqldqN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251024083211epoutp042d0b270677abd314d7faf23f45ccf68b~xYDoafOTV0164001640epoutp04d
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:32:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251024083211epoutp042d0b270677abd314d7faf23f45ccf68b~xYDoafOTV0164001640epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761294731;
	bh=ykg1faROnkghwYFMVKMEds7rWrVt1TtPgNqzY/YIp68=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=A3KqldqN+6ce9Wd+boIyd/KPYJxZu8HSqMz/Nr5q6C0Z3O+RysVa9grEWPaOzrmY0
	 V7e+PpNif+mMmOoI4SEhvxmqzh873Vec0pJJofrcOJwaYjyWJTiYCtYnWzIMlG6e5p
	 XIymb9EARtcm1BNjgPmcXdpPzVLLWHBs2ocWO1qs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251024083211epcas5p10cdd1d5da84fc89e2794c38860b0ae6b~xYDnoGYkD0624406244epcas5p1e;
	Fri, 24 Oct 2025 08:32:11 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ctGNV2xxnz6B9m8; Fri, 24 Oct
	2025 08:32:10 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251024083209epcas5p4f68b146347a720de1696bb10e86b2110~xYDmUb9Qr1552415524epcas5p4z;
	Fri, 24 Oct 2025 08:32:09 +0000 (GMT)
Received: from INBRO001840 (unknown [107.122.3.105]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251024083205epsmtip1d0cb577b9aaa7bb39661ccdbb575f386~xYDiekk8b1995619956epsmtip1O;
	Fri, 24 Oct 2025 08:32:05 +0000 (GMT)
From: "Pritam Manohar Sutar" <pritam.sutar@samsung.com>
To: "'Thinh Nguyen'" <Thinh.Nguyen@synopsys.com>
Cc: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rosa.pila@samsung.com>,
	<dev.tailor@samsung.com>, <faraz.ata@samsung.com>,
	<muhammed.ali@samsung.com>, <selvarasu.g@samsung.com>
In-Reply-To: <20251023224505.jipasxaokcfu3xyk@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: Allow usb role swich control from userspace
Date: Fri, 24 Oct 2025 14:02:03 +0530
Message-ID: <000001dc44c0$b02d2330$10876990$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI/xMG+oqQZ7NyZgvZIYESd8WrlfAEi1ocaArgW4CQB/HambAGca/C3s85SnaA=
Content-Language: en-in
X-CMS-MailID: 20251024083209epcas5p4f68b146347a720de1696bb10e86b2110
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251020112840epcas5p28d8eded5200f096e7b80f71899371f2c
References: <CGME20251020112840epcas5p28d8eded5200f096e7b80f71899371f2c@epcas5p2.samsung.com>
	<20251020113723.553843-1-pritam.sutar@samsung.com>
	<20251021220935.5njyz5lyiwrsf3rw@synopsys.com>
	<058201dc4403$334b0f20$99e12d60$@samsung.com>
	<20251023224505.jipasxaokcfu3xyk@synopsys.com>

Hi Thinh,

> -----Original Message-----
> From: Thinh Nguyen <Thinh.Nguyen=40synopsys.com>
> Sent: 24 October 2025 04:15 AM
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
> On Thu, Oct 23, 2025, Pritam Manohar Sutar wrote:
> > Hi Thinh,
> >
> > > -----Original Message-----
> > > From: Thinh Nguyen <Thinh.Nguyen=40synopsys.com>
> > > Sent: 22 October 2025 03:40 AM
> > > To: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> > > Cc: Thinh Nguyen <Thinh.Nguyen=40synopsys.com>;
> > > gregkh=40linuxfoundation.org; linux-usb=40vger.kernel.org; linux-
> > > kernel=40vger.kernel.org; rosa.pila=40samsung.com;
> > > dev.tailor=40samsung.com; faraz.ata=40samsung.com;
> > > muhammed.ali=40samsung.com; selvarasu.g=40samsung.com
> > > Subject: Re: =5BPATCH=5D usb: dwc3: Allow usb role swich control from
> > > userspace
> > >
> > > On Mon, Oct 20, 2025, Pritam Manohar Sutar wrote:
> > > > There is a possibility of user needs for USB mode switching on
> > > > boards that lack external hardware support for dynamic host/device
> > > > role detection.
> > >
> > > It's fine to enable this. But base on this change log, it sounds
> > > like there's no use case at the moment? If there is one, even if
> > > it's only for debugging purpose, please note it so. I'm hesitant to
> > > accept changes base on use case speculation only.
> > >
> >
> > Thank you for your comments.
> >
> > Yes, a use case exists, especially in automotive, where this feature
> > is needed to allow user-space applications to switch modes (host to
> > device or vice-versa) at runtime during CarPlay or Android Auto
> > operations.
> >
> > Can you please confirm updated commit message with usecase added as
> below?
> >
> > =22
> > usb: dwc3: Allow usb role swich control from userspace
> >
> > There is a possibility of user needs for USB mode switching on boards
> > that lack external hardware support for dynamic host/device role
> > detection. This is particularly relevant in automotive applications
> > where userspace applications need to switch USB roles (host to device)
> > at runtime for CarPlay/Android Auto integration.
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
> > =22
> >
>=20
> Yes, can you update the patch with this new info? Thank you.
>=20

Will update it and share v2 patch soon.=20

> Acked-by: Thinh Nguyen <Thinh.Nguyen=40synopsys.com>

Thank you.

>=20
> BR,
> Thinh

Regards,
Pritam


