Return-Path: <linux-kernel+bounces-835824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE24BA8299
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B101622DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033E635;
	Mon, 29 Sep 2025 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DT1H1tqN"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766022B8B5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128367; cv=none; b=iv7SJ59peZIPB23vyRKjNML8jsODyT9ZZl/V8c9vUeWnBV8haQUVH7AJGe2GYAOYqqqpwEwybnMAzGWm5X7imC1/2hEJ2FTU6pXEtpsKitwSEVmajPyXTAdno8LtQBj5CTOeb8H5Tx44wazV2lEwyNCaViohzUU5SfjPMKkZO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128367; c=relaxed/simple;
	bh=tEcpI5UHajZzcOgKwh0ZSahyLNRamKTjcsRj6A5OzRs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=KPRHP2hFJhUc/Uc+509q7mfcRjp9kvNmRjZTHrKKhSlwLWX0GPa0SB8bMUFAfT/IdK9o7jkSaOhWmWVfliWWJk4gs8r6Rn1Tznbr8SrgNsV9uHRrhxWGQeZhtQG1rr1tzweasQEiLVwyDpVMMq2IHwtdNs3JsyJXOU3hLmUTf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DT1H1tqN; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250929064603epoutp0106c0ee0cc91117ddb131f44a787470a3~pre0QuegP1818518185epoutp01R
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250929064603epoutp0106c0ee0cc91117ddb131f44a787470a3~pre0QuegP1818518185epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759128363;
	bh=tEcpI5UHajZzcOgKwh0ZSahyLNRamKTjcsRj6A5OzRs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=DT1H1tqNqhbjc9LyomxUMXC/CTMq/GHzDlmjSDD1B4PrE8yIw/d9D9XkFL4ZYe7SO
	 d/GX2BCZGovXORXJnqwgxEkD77cTtZNhSjaltD2dATvxoxqm9qVBWgOs0gjn3v/Zfo
	 BiU3U8VOFmKa8v+unIuPcSaLJrxQARLqhb0hX5HY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250929064602epcas5p45e71a950ed75ff05f651d9e8ea81577c~prezjA47S0430204302epcas5p4w;
	Mon, 29 Sep 2025 06:46:02 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cZsCY1ggDz2SSKq; Mon, 29 Sep
	2025 06:46:01 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250929064600epcas5p2aad3d7244d83c6751ea7b1dbd0b63dc9~prex_ExEA3230632306epcas5p2G;
	Mon, 29 Sep 2025 06:46:00 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250929064554epsmtip2d133b1f85860186fda42b9aae1351b20~presS4JLU0831808318epsmtip29;
	Mon, 29 Sep 2025 06:45:54 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Pritam Manohar Sutar'" <pritam.sutar@samsung.com>, <vkoul@kernel.org>,
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
In-Reply-To: <20250903073827.3015662-2-pritam.sutar@samsung.com>
Subject: RE: [PATCH v8 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 HS phy compatible
Date: Mon, 29 Sep 2025 12:15:52 +0530
Message-ID: <001301dc310c$b7a78550$26f68ff0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRMOVGdWg5oRjNsRBgEjzIeIB8IgGabj6EAmTXuDe0H7zKkA==
Content-Language: en-us
X-CMS-MailID: 20250929064600epcas5p2aad3d7244d83c6751ea7b1dbd0b63dc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e
References: <20250903073827.3015662-1-pritam.sutar@samsung.com>
	<CGME20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e@epcas5p4.samsung.com>
	<20250903073827.3015662-2-pritam.sutar@samsung.com>

Hi Pritam

> -----Original Message-----
> From: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> Sent: Wednesday, September 3, 2025 1:08 PM
> To: vkoul=40kernel.org; kishon=40kernel.org; robh=40kernel.org;
> krzk+dt=40kernel.org; conor+dt=40kernel.org; alim.akhtar=40samsung.com;
> andre.draszik=40linaro.org; peter.griffin=40linaro.org; kauschluss=40disr=
oot.org;
> ivo.ivanov.ivanov1=40gmail.com; igor.belwon=40mentallysanemainliners.org;
> m.szyprowski=40samsung.com; s.nawrocki=40samsung.com;
> pritam.sutar=40samsung.com
> Cc: linux-phy=40lists.infradead.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-
> samsung-soc=40vger.kernel.org; rosa.pila=40samsung.com;
> dev.tailor=40samsung.com; faraz.ata=40samsung.com;
> muhammed.ali=40samsung.com; selvarasu.g=40samsung.com
> Subject: =5BPATCH v8 1/6=5D dt-bindings: phy: samsung,usb3-drd-phy: add
> ExynosAutov920 HS phy compatible
>=20
> Document support for the USB20 phy found on the ExynosAutov920 SoC.
> The
> USB20 phy is functionally identical to that on the Exynos850 SoC, so no d=
river
> changes are needed to support this phy. However, add a dedicated
> compatible string for USB20 phy found in this SoC.
>=20
> Signed-off-by: Pritam Manohar Sutar <pritam.sutar=40samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>


