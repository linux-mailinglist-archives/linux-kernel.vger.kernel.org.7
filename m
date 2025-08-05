Return-Path: <linux-kernel+bounces-756791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E0B1B947
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1689184FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5729AAF3;
	Tue,  5 Aug 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iraWJDz8"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFE296159
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414552; cv=none; b=r7vVglT/T5odfjlX3l1NF4Tm1YuSe9HHZlmnaKNG6779jRn0IKiDWjHDWG8tueX2pUU6U/YK76SZ95n/PXuDXh/cFaoVMmaAJRfJg46jq4O9ndzJUnKMVa40pJFDRWS2EGtx+xuc8IXH22sZF3Kfpv8gnZKMQe55RhCqrdcvu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414552; c=relaxed/simple;
	bh=mQ3JKXU8ijyz0ZXSikywCAsdUAmddScDsKfgbuM2hb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=PP0w+JDX6bYFBDniTu/Zrun9PzXpElAwOupkjYyKtzG8k1NxhP79t+kHQAV5rGG8OEwl6MpdqV6r7bjSfQQrnFy9PFoOpSZmCHeBYa50QLNpNt7uNKeMGjGraIo7CjR8vvO37jy6E721hSSslSynDrYtkWAG7+G932Pu2lS3zwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iraWJDz8; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250805172229epoutp01a114c68215c9b790bb2c2bb9332cc096~Y7rzCBJus2140921409epoutp01k
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:22:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250805172229epoutp01a114c68215c9b790bb2c2bb9332cc096~Y7rzCBJus2140921409epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754414549;
	bh=BNHXYcAm7wmL0lZdeOl7MIvgCH9t824lfy0oiwY4fbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iraWJDz88mAuv6TQ2+9n32c9RS4hobOBmDEQZ7tpRY0gXBocSXFpbScVNi2/f0fpV
	 Wa0aVwSUxl14QW3xrR+H1/KF8HsT6EwtGxTgm/dbs1yF2XRnLw8HKEPRf5H2d99E0v
	 ci3s1NcKukGisu80fV1tlY9AZN4ATBoLnagziUZI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250805172228epcas5p1d191955528134891861a78b8e22dc8e3~Y7ryMChg53014130141epcas5p1K;
	Tue,  5 Aug 2025 17:22:28 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bxKxH3WT3z2SSKX; Tue,  5 Aug
	2025 17:22:27 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250805114313epcas5p15b843d7fe692feb20828a789cef49dc0~Y3DlCZJbV0972209722epcas5p1D;
	Tue,  5 Aug 2025 11:43:13 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250805114310epsmtip1165bc01a75ab7919847d37fd5d53d33b~Y3DiKEXXv1447314473epsmtip1r;
	Tue,  5 Aug 2025 11:43:10 +0000 (GMT)
From: Pritam Manohar Sutar <pritam.sutar@samsung.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	andre.draszik@linaro.org, peter.griffin@linaro.org, kauschluss@disroot.org,
	ivo.ivanov.ivanov1@gmail.com, igor.belwon@mentallysanemainliners.org,
	m.szyprowski@samsung.com, s.nawrocki@samsung.com, pritam.sutar@samsung.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rosa.pila@samsung.com,
	dev.tailor@samsung.com, faraz.ata@samsung.com, muhammed.ali@samsung.com,
	selvarasu.g@samsung.com
Subject: [PATCH v5 3/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 combo hsphy
Date: Tue,  5 Aug 2025 17:22:13 +0530
Message-Id: <20250805115216.3798121-4-pritam.sutar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805115216.3798121-1-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250805114313epcas5p15b843d7fe692feb20828a789cef49dc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250805114313epcas5p15b843d7fe692feb20828a789cef49dc0
References: <20250805115216.3798121-1-pritam.sutar@samsung.com>
	<CGME20250805114313epcas5p15b843d7fe692feb20828a789cef49dc0@epcas5p1.samsung.com>

This phy only supports USB2.0 HS(480Mbps), FS(12Mbps) and
LS(1.5Mbps) data rates. It requires two clocks, named as "phy" and "ref".
The required supplies for this phy, named as vdd075_usb20(0.75v),
vdd18_usb20(1.8v), vdd33_usb20(3.3v).

Add schema for combo hsphy found on this SoC.

Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
---
 .../devicetree/bindings/phy/samsung,usb3-drd-phy.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 1932a2272ef9..4a84b5405cd2 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -34,6 +34,7 @@ properties:
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
       - samsung,exynos990-usbdrd-phy
+      - samsung,exynosautov920-usbdrd-combo-hsphy
       - samsung,exynosautov920-usbdrd-phy
 
   clocks:
@@ -226,6 +227,7 @@ allOf:
               - samsung,exynos7870-usbdrd-phy
               - samsung,exynos850-usbdrd-phy
               - samsung,exynos990-usbdrd-phy
+              - samsung,exynosautov920-usbdrd-combo-hsphy
               - samsung,exynosautov920-usbdrd-phy
     then:
       properties:
@@ -248,6 +250,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - samsung,exynosautov920-usbdrd-combo-hsphy
               - samsung,exynosautov920-usbdrd-phy
     then:
       required:
-- 
2.34.1


