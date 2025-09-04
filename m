Return-Path: <linux-kernel+bounces-800213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC7B43498
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0D054331D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A322BE7BA;
	Thu,  4 Sep 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gkk95YVG"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6127B335
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972279; cv=none; b=AHw5APNQwUsA0yFs1BCU+0LhePZ7U5l7MSbMCwSgvS3Q9YoJkO6D2zQa0q+7SPtQ2+R3QpTE1SI2E/yiazHFtNWBbjZE2KeoTzRt8YU80+cDNG8KRwlmw7tdc1uD33xxSIuybK0dpLDOLsWq9F6lIgEQaAxDhE/WYPlRQBVDhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972279; c=relaxed/simple;
	bh=oX7UEOaFp5Z+f1WS5I2kIi2WzTYPeW2Lz1GRHyCpros=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=saJ1q9VtgcgaNgbMWEMGqcbhUfdkFvYWbe8edJOIdvOCmuJOFtOUhujzH2hG195fcxNedzsp7nYRBwzzwidbaGa8DsZ7MFe2qfz1iWlp/atbBYpkSD6d5EgZpF8VSqGIzbOTYccOv56xMIPHj2tONmMeIf302g+C5tvq1X1QZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Gkk95YVG; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250904075114epoutp0413b10596b0826cbd467d5b58bd184368~iBPmQU6Jv0894308943epoutp04L
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:51:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250904075114epoutp0413b10596b0826cbd467d5b58bd184368~iBPmQU6Jv0894308943epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756972274;
	bh=BR2gZ2ua1hawq9ETTub8etbCtTRBasyb9bOMsgkE+5E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Gkk95YVGgKoh1+rYqdqaEg/PXdvf4qvbychJ0Od0sDf5pmCQyxJPCIe9Bm0iwK2es
	 x/k2atHBSI/kz9oH2OdLuPxvFDZHUJdEVJ3Be8QFSzTWII5RQvBGI59YIx8XO3bFtl
	 SoxvOqW+3GNP7UHyrZg/eGePJjDP8tRzDHu4zEtI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250904075113epcas5p394340cc759dc824bd310f5b5d72f2cdf~iBPliafs32306923069epcas5p3P;
	Thu,  4 Sep 2025 07:51:13 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cHWrJ5Zw5z2SSKh; Thu,  4 Sep
	2025 07:51:12 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250904075112epcas5p49650dcfae9c59e1241751ea53f73fbcc~iBPj-8a8Q2959129591epcas5p47;
	Thu,  4 Sep 2025 07:51:12 +0000 (GMT)
Received: from INBRO001840 (unknown [107.122.3.105]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250904075109epsmtip2fcfead067a25af3c3ad223ce40bbf198~iBPhGx2ni3175031750epsmtip2A;
	Thu,  4 Sep 2025 07:51:08 +0000 (GMT)
From: "Pritam Manohar Sutar" <pritam.sutar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<andre.draszik@linaro.org>, <peter.griffin@linaro.org>,
	<kauschluss@disroot.org>, <ivo.ivanov.ivanov1@gmail.com>,
	<igor.belwon@mentallysanemainliners.org>, <m.szyprowski@samsung.com>,
	<s.nawrocki@samsung.com>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<rosa.pila@samsung.com>, <dev.tailor@samsung.com>, <faraz.ata@samsung.com>,
	<muhammed.ali@samsung.com>, <selvarasu.g@samsung.com>
In-Reply-To: <20250904-interesting-lovely-ringtail-38bbef@kuoka>
Subject: RE: [PATCH v8 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 HS phy compatible
Date: Thu, 4 Sep 2025 13:21:07 +0530
Message-ID: <000001dc1d70$aebf7d80$0c3e7880$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRMOVGdWg5oRjNsRBgEjzIeIB8IgGabj6EAmTXuDcB8lF0oLPo6zcQ
Content-Language: en-in
X-CMS-MailID: 20250904075112epcas5p49650dcfae9c59e1241751ea53f73fbcc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e
References: <20250903073827.3015662-1-pritam.sutar@samsung.com>
	<CGME20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e@epcas5p4.samsung.com>
	<20250903073827.3015662-2-pritam.sutar@samsung.com>
	<20250904-interesting-lovely-ringtail-38bbef@kuoka>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 04 September 2025 12:18 PM
> To: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> Cc: vkoul=40kernel.org; kishon=40kernel.org; robh=40kernel.org;
> krzk+dt=40kernel.org; conor+dt=40kernel.org; alim.akhtar=40samsung.com;
> andre.draszik=40linaro.org; peter.griffin=40linaro.org; kauschluss=40disr=
oot.org;
> ivo.ivanov.ivanov1=40gmail.com; igor.belwon=40mentallysanemainliners.org;
> m.szyprowski=40samsung.com; s.nawrocki=40samsung.com; linux-
> phy=40lists.infradead.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-s=
amsung-
> soc=40vger.kernel.org; rosa.pila=40samsung.com; dev.tailor=40samsung.com;
> faraz.ata=40samsung.com; muhammed.ali=40samsung.com;
> selvarasu.g=40samsung.com
> Subject: Re: =5BPATCH v8 1/6=5D dt-bindings: phy: samsung,usb3-drd-phy: a=
dd
> ExynosAutov920 HS phy compatible
>=20
> On Wed, Sep 03, 2025 at 01:08:22PM +0530, Pritam Manohar Sutar wrote:
> > Document support for the USB20 phy found on the ExynosAutov920 SoC.
> > The
> > USB20 phy is functionally identical to that on the Exynos850 SoC, so
> > no driver changes are needed to support this phy. However, add a
> > dedicated compatible string for USB20 phy found in this SoC.
> >
> > Signed-off-by: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
>=20
> You just dropped all tags without explaining why.

Regretted inconvenience.=20

There were significant changes in supplies' names in driver and schemas=20
(patch-set v8). This led to make changes in patch no 5.  And review for=20
these changes is needed.  Hence, removed RB tag in this patch-set.=20

There was a ask for the same https://lore.kernel.org/linux-phy/000401dc18cd=
=24ec02a1b0=24c407e510=24=40samsung.com/=23:=7E:text=3DLet%20me%20know%2C%2=
0because%20of%20above%20changes%2C%20should%20be%20removing%20your%20%0A%27=
reviewed%2Dby%27%20tag%20from%20patch%201%20and%203.

This had to be captured in changelog along with other details. Will remembe=
r to add details=20
in future, if any tags are removed.=20

However,  do I need to send v9 with the details?=20

>=20
> <form letter>
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions =
of
> patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is =22r=
eceived=22,
> when provided in a message replied to you on the mailing list. Tools like=
 b4 can
> help here. However, there's no need to repost patches *only* to add the t=
ags.
> The upstream maintainer will do that for tags received on the version the=
y apply.
>=20
> Please read:
> https://protect2.fireeye.com/v1/url?k=3D6abe7ac7-0bc392bf-6abff188-
> 74fe485fffb1-49c70cea06738e63&q=3D1&e=3Dfc43c80a-8c7b-41b0-aa24-
> 8cb76d954fe5&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.12-
> rc3%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-
> patches.rst%23L577
>=20
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>=20
> Best regards,
> Krzysztof

Thank you.

Regards,
Pritam



