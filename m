Return-Path: <linux-kernel+bounces-723244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E1AFE4CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46C25662D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1258288524;
	Wed,  9 Jul 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="crM7sDQ1"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2B28469C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055240; cv=none; b=SJm/iP0tu1wsidjdGCWEaQlF9H0WiW+EeSkO94Nqm5G/51ltTLBNl/whfjNURYpfeZmtPfN1MEq20sv0YQQgQlOjVII3x9iJDXOBqVyd9xIVN4jcd6wGMcDjN89X0eALw2K2NauX1QrZlmZI2KpBXFBRCsnfL4p9Gg0UrwoZIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055240; c=relaxed/simple;
	bh=3cMxryECHbFyInj86wbRy79c+zpxeGN9+i2nNUGxS78=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NwSwZCroHCYDaFZEDZ06a2KMiBx2yyuLf7GBAz45rlljcvIpGErNQW/kKE3jkmdR4pRuQ4GrwIRtCa37qLkA4Tng/jAaRKSEqe2cbk4RAZVY6pII1vheUsU5iYTUc6FvYhObNnPOdKVhmut2jHUEh7j5864Tdk/c01DDP6R72qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=crM7sDQ1; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250709100035epoutp03a4a2187519c7c186cc5e42903b91a911~QjPRJVjxj0724807248epoutp03R
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250709100035epoutp03a4a2187519c7c186cc5e42903b91a911~QjPRJVjxj0724807248epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752055235;
	bh=8YjDIVkSzZ1qBfDNEzt6aiWfmZ06SFpmvJBdwg8GbFU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=crM7sDQ1Uz9NtR7Lf5itnb9Kxo52UH9FjSGOjp2JkszPtedhMD5yYtuYLOW3diez/
	 JPkFeY49RxYNNxrnIaqgsbyUhQeN8lHbywF+MaOZmR+G2WbWzqcQ5AR4mnJDBjOoQ2
	 uzRfhHRw+oNiDyxGt4ThAj8UYDSsUzBnjC+ZaEg0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250709100035epcas5p11cefc566289685aa4dadd35429e93d22~QjPQiuHEG1114111141epcas5p1k;
	Wed,  9 Jul 2025 10:00:35 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bcYPr5Dhtz6B9mD; Wed,  9 Jul
	2025 10:00:32 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250709085159epcas5p15cd74d4ab9d7944eef406ce118768a84~QiTXJ9MsA0055000550epcas5p1N;
	Wed,  9 Jul 2025 08:51:59 +0000 (GMT)
Received: from INBRO001840 (unknown [107.122.3.105]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250709085156epsmtip13f8f84df1a677aaa0f8edc8247250f7a~QiTUNkrE12100421004epsmtip1O;
	Wed,  9 Jul 2025 08:51:55 +0000 (GMT)
From: "Pritam Manohar Sutar" <pritam.sutar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<andre.draszik@linaro.org>, <peter.griffin@linaro.org>,
	<neil.armstrong@linaro.org>, <kauschluss@disroot.org>,
	<ivo.ivanov.ivanov1@gmail.com>, <m.szyprowski@samsung.com>,
	<s.nawrocki@samsung.com>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<rosa.pila@samsung.com>, <dev.tailor@samsung.com>, <faraz.ata@samsung.com>,
	<muhammed.ali@samsung.com>, <selvarasu.g@samsung.com>
In-Reply-To: <20250706-grouse-of-pastoral-bloom-7d79b0@krzk-bin>
Subject: RE: [PATCH v4 3/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 combo HS phy
Date: Wed, 9 Jul 2025 14:21:54 +0530
Message-ID: <07d401dbf0ae$bb0256b0$31070410$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJAgQZ9LFXBZrDskwNBYris6jFv1AJNRgOcAqL7pisBlv/N8LMsH/TA
Content-Language: en-in
X-CMS-MailID: 20250709085159epcas5p15cd74d4ab9d7944eef406ce118768a84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250701120002epcas5p2c4d728d599a819057bcc40b724881276
References: <20250701120706.2219355-1-pritam.sutar@samsung.com>
	<CGME20250701120002epcas5p2c4d728d599a819057bcc40b724881276@epcas5p2.samsung.com>
	<20250701120706.2219355-4-pritam.sutar@samsung.com>
	<20250706-grouse-of-pastoral-bloom-7d79b0@krzk-bin>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 06 July 2025 03:12 PM
> To: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> Cc: vkoul=40kernel.org; kishon=40kernel.org; robh=40kernel.org;
> krzk+dt=40kernel.org; conor+dt=40kernel.org; alim.akhtar=40samsung.com;
> andre.draszik=40linaro.org; peter.griffin=40linaro.org; neil.armstrong=40=
linaro.org;
> kauschluss=40disroot.org; ivo.ivanov.ivanov1=40gmail.com;
> m.szyprowski=40samsung.com; s.nawrocki=40samsung.com; linux-
> phy=40lists.infradead.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-s=
amsung-
> soc=40vger.kernel.org; rosa.pila=40samsung.com; dev.tailor=40samsung.com;
> faraz.ata=40samsung.com; muhammed.ali=40samsung.com;
> selvarasu.g=40samsung.com
> Subject: Re: =5BPATCH v4 3/6=5D dt-bindings: phy: samsung,usb3-drd-phy: a=
dd
> ExynosAutov920 combo HS phy
>=20
> On Tue, Jul 01, 2025 at 05:37:03PM +0530, Pritam Manohar Sutar wrote:
> > This phy supports USB3.1 SSP+(10Gbps) protocol and is backwards
>=20
> What is =22this=22? You add here HS PHY, so HS is 3.1?
>=20

=22this=22 means =22combo phy=22. Combo phy is combination of 2 types of th=
e phys.=20
1. one supports only USB3.1 SSP+ and denoted as =22samsung,exynosautov920-u=
sb31drd-combo-ssphy=22 as in patch no 5 (combo SS phy)
2. another supports only USB2.0 HS and termed as =22samsung,exynosautov920-=
usbdrd-combo-hsphy=22 as in this patch (combo HS phy)

> If this is the same phy, why are you adding another compatible?

As explained earlier (even in cover letter), there are 3 types of the phys =
in this SoC.
1. one is simmilar with exynos850 and termed as =22samsung,exynosautov920-u=
sbdrd-phy=22 as mentioned in patch no.1
2. two phys are in combo phys as explained above (patch no 3 =5Bcombo HS ph=
y=5D and 5=5Bcombo SS phy=5D)
		=09
NOTE: hs phy in combo phy in =22NOT=22 same as phy (patch no. 1 which is si=
milar with exynos850).=20
		=09
These three phys (usbdrd-phy, combo-hsphy, combo-ssphy) are totally deferen=
t =22NOT=22 same, hence added 3 three compatible for three phys.

>=20
> Best regards,
> Krzysztof



