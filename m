Return-Path: <linux-kernel+bounces-750168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFBB15810
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3653B8846
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E911A0BF3;
	Wed, 30 Jul 2025 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d6XwjYRl"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6812B73
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849052; cv=none; b=GHU2Zt/Rzc51tvsB/63v9zWyGhKKeggZMbSfSt9HPZDhuCi0t+KycjKAvM7hnRf3u9+K803j02R8PloMQLVGIMnS9sJLOt9NEkylpe8lYetcUALlrwgNLLFRQcQQUoP2Is16waqcdsZ2F/LwRybO70OQ6e6IlCEikUj7S0nw7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849052; c=relaxed/simple;
	bh=K7KUwKilFDHEDsfh4Yx7rczHG83ExKuciAknBf8324k=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=bqW4JxlIJVUi8AXFBjrvmk+X7nT6Vmh0zFoBGaWMX1HHOysuRzNgPQmXi/vh/CPrG56SP4EOubkY2tx4shZjSrQsvXt+6oTy3vzxSQzs0qv/7KtvyEcJnSbbg8IWJXQq2DJwwhJl/QBK2CDXA1hqfKt1pOERbU5/3BfThsDiv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d6XwjYRl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250730041728epoutp02962057cc31dd1f617984ade1095caaf3~W7GrGJJ2O1014410144epoutp02H
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:17:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250730041728epoutp02962057cc31dd1f617984ade1095caaf3~W7GrGJJ2O1014410144epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753849048;
	bh=K7KUwKilFDHEDsfh4Yx7rczHG83ExKuciAknBf8324k=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=d6XwjYRlVRX8+/zPzCEltkpw1wDRuEboXY2tXEeVRe9DQnmtYS/SFe+LRTxwGytHB
	 WWbeiTLwRcFUMYATVJyg3EYVCe/UgdNTs5e0B7FlYbz28h4qfpaQUOewYVaYlzElA6
	 XpEF5eOSYtfEUl2QL74FIKfJRXUh1etYqBlAG+F4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250730041727epcas5p24ac1bc7bcb5343f2d896777c41cc5917~W7GqaiqPk2771727717epcas5p22;
	Wed, 30 Jul 2025 04:17:27 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bsJpG3b7tz3hhTK; Wed, 30 Jul
	2025 04:17:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250730041726epcas5p2ab1049be882c5eda45d384680200683f~W7GpFosuY1622716227epcas5p2n;
	Wed, 30 Jul 2025 04:17:26 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250730041724epsmtip25e8f7a35ba1e498bca2040a8730bbd42~W7Gnsd4kE0316403164epsmtip21;
	Wed, 30 Jul 2025 04:17:24 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Devang Tailor'" <dev.tailor@samsung.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<faraz.ata@samsung.com>
In-Reply-To: <20250710083434.1821671-3-dev.tailor@samsung.com>
Subject: RE: [PATCH v2 2/3] rtc: s3c: support for exynosautov9 on-chip RTC
Date: Wed, 30 Jul 2025 09:47:23 +0530
Message-ID: <36d401dc0108$db031250$910936f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQMc6yo9jRPgA4nZ2IiZrgLtyBFMygKSVtdMAw5/R1KxmzSKEA==
X-CMS-MailID: 20250730041726epcas5p2ab1049be882c5eda45d384680200683f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710082536epcas5p4f9dcd50ff474066562b2cbd40199d2d9
References: <20250710083434.1821671-1-dev.tailor@samsung.com>
	<CGME20250710082536epcas5p4f9dcd50ff474066562b2cbd40199d2d9@epcas5p4.samsung.com>
	<20250710083434.1821671-3-dev.tailor@samsung.com>



> -----Original Message-----
> From: Devang Tailor <dev.tailor=40samsung.com>
> Sent: Thursday, July 10, 2025 2:05 PM
> To: robh=40kernel.org; krzk+dt=40kernel.org; conor+dt=40kernel.org;
> alim.akhtar=40samsung.com; alexandre.belloni=40bootlin.com;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> rtc=40vger.kernel.org; faraz.ata=40samsung.com
> Cc: Devang Tailor <dev.tailor=40samsung.com>
> Subject: =5BPATCH v2 2/3=5D rtc: s3c: support for exynosautov9 on-chip RT=
C
>=20
> The on-chip RTC of this SoC is almost similar to the previous versions of=
 SoC.
> Hence re-use the existing driver with platform specific change to enable =
RTC.
>=20
> This has been tested with 'hwclock' & 'date' utilities
>=20
> Signed-off-by: Devang Tailor <dev.tailor=40samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>


