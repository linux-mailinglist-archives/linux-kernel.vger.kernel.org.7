Return-Path: <linux-kernel+bounces-685070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68CAD83BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E73B929A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5D275111;
	Fri, 13 Jun 2025 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WUIE57wz"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C37275108
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798616; cv=none; b=h2Gxliuwr2+qwRVHU6zvu39Nvjvd85UXBEWYK52ztSX0lSPqghL5SYtwcX8WZRPhcr4TmpREfN2mrp9lRB9f+SF95OayJN/LPVJGTzb+KIpE1A/hzVJsYcA+9dxfsCXYlDPAfEI5wHBlrYa3daYsaXVtFS+zfbtDI5S6yuJuNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798616; c=relaxed/simple;
	bh=GTs5A9x4hDtLjVMDn3YvdSCTGpgbn6+4AsoDhD4ysr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dGIOV4kfEOKV/CKRkGF86Ckg4RkMwvPbrCrSaD0oocFAij9CKEIN5iOkQ+UADtVpxny9yTfW0CHbxVnDMD4YkzLCgWdsikG7ZrGuOPPyGqTlvQPVc/PbL090sO/8l4tV0T0Bkea+IglU/ODSDJQph78KGpsMiQRWNXjPX+suAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WUIE57wz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250613071012epoutp046fdc5faf2770f7bdf0066738c66ceed3~IiJFTJqrV2480024800epoutp04C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 07:10:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250613071012epoutp046fdc5faf2770f7bdf0066738c66ceed3~IiJFTJqrV2480024800epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749798613;
	bh=WT3+OA7xbIRPQyDTFFQo2fANnLJO9FZ0B+dE0jn8FdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUIE57wzXWKxzFgAt2mjP7gmNqAo6TuST0jCABuzrh3USoWblZkMzEoq9v4KeoA52
	 AoEctd5miXx18I9YXdv7LzVz9v9/URpXnOq3oTxoNpmx5JVHEMKxaEFVrLtLfz84UD
	 btwAhJ2Q8d8eRqizm+iZFro1owBjWGkox73IqysU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250613071012epcas5p3afb22a58b1c9df45f359239ee34da87e~IiJEiwpSi0170401704epcas5p3f;
	Fri, 13 Jun 2025 07:10:12 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.178]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bJVsF75j8z2SSKj; Fri, 13 Jun
	2025 07:10:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250613055050epcas5p3f995a6696ccf4f7eeb0b5d76382f71f7~IhDxlUrs13253332533epcas5p3P;
	Fri, 13 Jun 2025 05:50:50 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250613055047epsmtip1f04e1592f84c83b804209cfdc697af15~IhDu36OMJ0400204002epsmtip1M;
	Fri, 13 Jun 2025 05:50:47 +0000 (GMT)
From: Pritam Manohar Sutar <pritam.sutar@samsung.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	andre.draszik@linaro.org, peter.griffin@linaro.org, kauschluss@disroot.org,
	ivo.ivanov.ivanov1@gmail.com, m.szyprowski@samsung.com,
	s.nawrocki@samsung.com, pritam.sutar@samsung.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rosa.pila@samsung.com,
	dev.tailor@samsung.com, faraz.ata@samsung.com, muhammed.ali@samsung.com,
	selvarasu.g@samsung.com
Subject: [PATCH v3 4/9] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 combo HS phy
Date: Fri, 13 Jun 2025 11:26:08 +0530
Message-Id: <20250613055613.866909-5-pritam.sutar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613055613.866909-1-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250613055050epcas5p3f995a6696ccf4f7eeb0b5d76382f71f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250613055050epcas5p3f995a6696ccf4f7eeb0b5d76382f71f7
References: <20250613055613.866909-1-pritam.sutar@samsung.com>
	<CGME20250613055050epcas5p3f995a6696ccf4f7eeb0b5d76382f71f7@epcas5p3.samsung.com>

Add a dedicated compatible string for USB combo HS phy found in this
SoC. The devicetree node requires two clocks, named "phy" and "ref".

This phy supports USB3.1 SSP+(10Gbps) protocol and is backwards
compatible to the USB3.0 SS(5Gbps). 'Add-on USB2.0' phy is added
to support USB2.0 HS(480Mbps), FS(12Mbps) and LS(1.5Mbps) data rates.
These two phys are combined to form a combo phy.

Add schema only for 'Add-on USB2.0' HS phy.

Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
---
 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 71db17d93c6a..26660799e3ca 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -33,6 +33,7 @@ properties:
       - samsung,exynos7-usbdrd-phy
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
+      - samsung,exynosautov920-usbdrd-hsphy
       - samsung,exynosautov920-usbdrd-phy
 
   clocks:
@@ -218,6 +219,7 @@ allOf:
               - samsung,exynos5420-usbdrd-phy
               - samsung,exynos7870-usbdrd-phy
               - samsung,exynos850-usbdrd-phy
+              - samsung,exynosautov920-usbdrd-hsphy
               - samsung,exynosautov920-usbdrd-phy
     then:
       properties:
-- 
2.34.1


