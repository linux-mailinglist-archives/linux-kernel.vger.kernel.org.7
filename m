Return-Path: <linux-kernel+bounces-835827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D4BA82B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629597A8892
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D62BEC55;
	Mon, 29 Sep 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aBg3H/6V"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89C22B8B5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128431; cv=none; b=mvyC+7JU5GqaeacoKYmWoxQQYwzKpAKfZcAkbQrBtgVCX9r4YVASS1jRYVZXGi7xZHf9C5GWNOoDVu6Q14/LCabOc9+D9LpUgGJVV34cjNH1E5XRDa4JlkA/E0bI8rzSsVUgeUP01JzQeisLIpL9Oqv2r5B5hQ0o8ailaEDEVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128431; c=relaxed/simple;
	bh=y5tPGdO0zkiGxYnKhMmtxjekDbOB0ovCzbPkwlNmCbs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=nqrf7NCdnnIJoNVvwQV692qbA2ThHOx2bHvsjtSbf1N7VM9vPFi9XgRV+W4Te2P60thMLSTkOj0YhiubbVGGNEWlgzPP5kPK7hcsSgBBAApRhT3N3RJ6p2IcEzxI5mEujmAj3B5OE1pNT4PNW/kupSiW18PYKA7jQbR2N5pY2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aBg3H/6V; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250929064707epoutp010013c1f7d302dc7067c73aa5a5e7a88f~prfwQNkL31983619836epoutp01C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:47:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250929064707epoutp010013c1f7d302dc7067c73aa5a5e7a88f~prfwQNkL31983619836epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759128427;
	bh=rlD+Oa758snTIeLWIc2UCK6i1q2QhpKw3wxOF2sifOI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=aBg3H/6VmTNiLUkV2VTTS3hxnFVduv5g/xJsDfljmOWJGC1Ap2KvsQL8cvl6RkPFo
	 bEmrkzXV7YkIU8iERRiGCsr7wM6wzeMzBTmoMqgLHUomM41CoPWwILzpwjSXCuF915
	 qmM659j/KaH6KbhEmnXKIx7UiCS3T73wNZVTyl7M=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250929064706epcas5p25fbef3d266435f18a5a7d550bd7fb1d9~prfvr9wQe3152631526epcas5p2C;
	Mon, 29 Sep 2025 06:47:06 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cZsDn5g4tz3hhTC; Mon, 29 Sep
	2025 06:47:05 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250929064705epcas5p28b43638ca8368376aaa55a652e2c097b~prfuB7tJr3152631526epcas5p29;
	Mon, 29 Sep 2025 06:47:05 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250929064700epsmtip1803678f881cc80bb889cc76568fbd6c2~prfp-PR7e1213412134epsmtip1f;
	Mon, 29 Sep 2025 06:47:00 +0000 (GMT)
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
In-Reply-To: <20250903073827.3015662-4-pritam.sutar@samsung.com>
Subject: RE: [PATCH v8 3/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 combo hsphy
Date: Mon, 29 Sep 2025 12:16:57 +0530
Message-ID: <001501dc310c$de18fb60$9a4af220$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRMOVGdWg5oRjNsRBgEjzIeIB8IgI+elV9AgkpZOa0HXqrMA==
Content-Language: en-us
X-CMS-MailID: 20250929064705epcas5p28b43638ca8368376aaa55a652e2c097b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903072942epcas5p2154a85b45152af50e2714248c38c5adc
References: <20250903073827.3015662-1-pritam.sutar@samsung.com>
	<CGME20250903072942epcas5p2154a85b45152af50e2714248c38c5adc@epcas5p2.samsung.com>
	<20250903073827.3015662-4-pritam.sutar@samsung.com>

Hi Pritam

> -----Original Message-----
> From: Pritam Manohar Sutar <pritam.sutar@samsung.com>
> Sent: Wednesday, September 3, 2025 1:08 PM
> To: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; alim.akhtar@samsung.com;
> andre.draszik@linaro.org; peter.griffin@linaro.org; kauschluss@disroot.org;
> ivo.ivanov.ivanov1@gmail.com; igor.belwon@mentallysanemainliners.org;
> m.szyprowski@samsung.com; s.nawrocki@samsung.com;
> pritam.sutar@samsung.com
> Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; rosa.pila@samsung.com;
> dev.tailor@samsung.com; faraz.ata@samsung.com;
> muhammed.ali@samsung.com; selvarasu.g@samsung.com
> Subject: [PATCH v8 3/6] dt-bindings: phy: samsung,usb3-drd-phy: add
> ExynosAutov920 combo hsphy
> 
> The USBDRD31 5nm controller consists of Synopsys USB2.0 femptophy and
> USBSS combophy. Add-on USB20 femptophy is required to support USB20
> data rates along with USBSS phy. Document support for the USB2.0
> femptophy found on combophy of the this SoC.
> 
> Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


