Return-Path: <linux-kernel+bounces-842681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA57ABBD486
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE62B4E860D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F525A2BB;
	Mon,  6 Oct 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F4D8FWIX"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC01339A4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737372; cv=none; b=GqXxyDFPvXtOEs4JGjA3/pAO5+eFVk96gVYgsUHalbhcmwtz4bV3eGLdI7yXtaVfOqG9Q9CahOe3lJA0YCL9zrH6MFCjYiTubQM1BIX3jbZdYk0M0lFr8w/VOO2JgfmP5gTjpjaUeCF7LF8tJ0Fa6q7wdg/nfKRbRbd+4eLfGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737372; c=relaxed/simple;
	bh=FtIZ4ntxfc9NNJw+ZLAatKDq+b4NcVohslCudhSyBV0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lLxdn0FI0pTrqgd2Au2nbc+ndysfMjldb8S84M46rKW9GWx/qeQzmCtjIftQN1Qv0HTZY7ekZY46ClOXLsf0Imud/FsAp2+aeQNTzK+Ru5spoth/G9MXD6D/AfO6kFKsFbT9Zyo/vpecQKk+tOinCcBlyqM5XQjmU2n139F1IVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F4D8FWIX; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251006075605epoutp04ce7295324b40b7735378eabee74a27f6~r189te9CB2584625846epoutp04S
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:56:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251006075605epoutp04ce7295324b40b7735378eabee74a27f6~r189te9CB2584625846epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759737365;
	bh=y3jKOu9b+P0Ih93AICIcneY/oMkTMn7T+Krlp2E8KKA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=F4D8FWIXj/ijjKU7Fj+GximToN7e4DiY0q0oKVkmyNh3sFfuzgBLg+3Fwv+21A/8g
	 l3QSx0pmM3KxioyAccJ3TErPRfOO98ZbHkYNsdQP+2SSnkZNlnjjfqFwc9jMx9W2b/
	 JWACmnEZu08FxzRSomen6pSfhzB+UlIKrNMSy6as=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251006075604epcas5p2340605e3e9393140844ab163feb26c00~r189NvSTp1431114311epcas5p24;
	Mon,  6 Oct 2025 07:56:04 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cgBR75fF4z3hhT3; Mon,  6 Oct
	2025 07:56:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251006075603epcas5p1b56873cad2f305bcdee52ea7c550529f~r187tLzhK0791807918epcas5p1R;
	Mon,  6 Oct 2025 07:56:03 +0000 (GMT)
Received: from INBRO001840 (unknown [107.122.3.105]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251006075600epsmtip20e24c5f8001f5c1fad71053ea9c0d0e8~r1842CSE20799907999epsmtip2K;
	Mon,  6 Oct 2025 07:55:59 +0000 (GMT)
From: "Pritam Manohar Sutar" <pritam.sutar@samsung.com>
To: "'Alim Akhtar'" <alim.akhtar@samsung.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <andre.draszik@linaro.org>,
	<peter.griffin@linaro.org>, <kauschluss@disroot.org>,
	<ivo.ivanov.ivanov1@gmail.com>, <igor.belwon@mentallysanemainliners.org>,
	<m.szyprowski@samsung.com>, <s.nawrocki@samsung.com>
Cc: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <rosa.pila@samsung.com>,
	<dev.tailor@samsung.com>, <faraz.ata@samsung.com>,
	<muhammed.ali@samsung.com>, <selvarasu.g@samsung.com>
In-Reply-To: <001301dc310c$b7a78550$26f68ff0$@samsung.com>
Subject: RE: [PATCH v8 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 HS phy compatible
Date: Mon, 6 Oct 2025 13:25:58 +0530
Message-ID: <000001dc3696$a97bcf10$fc736d30$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRMOVGdWg5oRjNsRBgEjzIeIB8IgGabj6EAmTXuDcDLshEdrQRTsmg
Content-Language: en-in
X-CMS-MailID: 20251006075603epcas5p1b56873cad2f305bcdee52ea7c550529f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e
References: <20250903073827.3015662-1-pritam.sutar@samsung.com>
	<CGME20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e@epcas5p4.samsung.com>
	<20250903073827.3015662-2-pritam.sutar@samsung.com>
	<001301dc310c$b7a78550$26f68ff0$@samsung.com>


=20
> -----Original Message-----
> From: Alim Akhtar <alim.akhtar=40samsung.com>
> Sent: 29 September 2025 12:16 PM
> To: 'Pritam Manohar Sutar' <pritam.sutar=40samsung.com>; vkoul=40kernel.o=
rg;
> kishon=40kernel.org; robh=40kernel.org; krzk+dt=40kernel.org;
> conor+dt=40kernel.org; andre.draszik=40linaro.org; peter.griffin=40linaro=
.org;
> kauschluss=40disroot.org; ivo.ivanov.ivanov1=40gmail.com;
> igor.belwon=40mentallysanemainliners.org; m.szyprowski=40samsung.com;
> s.nawrocki=40samsung.com
> Cc: linux-phy=40lists.infradead.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-s=
amsung-
> soc=40vger.kernel.org; rosa.pila=40samsung.com; dev.tailor=40samsung.com;
> faraz.ata=40samsung.com; muhammed.ali=40samsung.com;
> selvarasu.g=40samsung.com
> Subject: RE: =5BPATCH v8 1/6=5D dt-bindings: phy: samsung,usb3-drd-phy: a=
dd
> ExynosAutov920 HS phy compatible
>=20
> Hi Pritam
>=20
> > -----Original Message-----
> > From: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> > Sent: Wednesday, September 3, 2025 1:08 PM
> > To: vkoul=40kernel.org; kishon=40kernel.org; robh=40kernel.org;
> > krzk+dt=40kernel.org; conor+dt=40kernel.org; alim.akhtar=40samsung.com;
> > andre.draszik=40linaro.org; peter.griffin=40linaro.org;
> > kauschluss=40disroot.org; ivo.ivanov.ivanov1=40gmail.com;
> > igor.belwon=40mentallysanemainliners.org;
> > m.szyprowski=40samsung.com; s.nawrocki=40samsung.com;
> > pritam.sutar=40samsung.com
> > Cc: linux-phy=40lists.infradead.org; devicetree=40vger.kernel.org; linu=
x-
> > kernel=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux=
-
> > samsung-soc=40vger.kernel.org; rosa.pila=40samsung.com;
> > dev.tailor=40samsung.com; faraz.ata=40samsung.com;
> > muhammed.ali=40samsung.com; selvarasu.g=40samsung.com
> > Subject: =5BPATCH v8 1/6=5D dt-bindings: phy: samsung,usb3-drd-phy: add
> > ExynosAutov920 HS phy compatible
> >
> > Document support for the USB20 phy found on the ExynosAutov920 SoC.
> > The
> > USB20 phy is functionally identical to that on the Exynos850 SoC, so
> > no driver changes are needed to support this phy. However, add a
> > dedicated compatible string for USB20 phy found in this SoC.
> >
> > Signed-off-by: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> > ---
> Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

Hi Alim,
Thank you for RB tag.

Hi Vinod,=20
Addressed comments on phy drivers those were given in patch-set v5.=20
Can you please check and let me know if any other comments?=20

Hi Krzysztof,=20
Please let me know if you want me send v9 by retaining  your RB on=20
patch1 and patch3? Also do let me know if any other concerns need=20
to be addressed?

Regards,
Pritam


