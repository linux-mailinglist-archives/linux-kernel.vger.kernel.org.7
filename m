Return-Path: <linux-kernel+bounces-797873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3CB41687
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F52189BF2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A612DAFD8;
	Wed,  3 Sep 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I0Dze26X"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C72DECDF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884589; cv=none; b=aD2/3vxvsXA1l36XDjuoVZLTwouZANzLQtxWWXAFL8Rg7x8M3KbM4S1eswMeSE+3t1sQzWw2C3EehMd5HXNB/9bzDBDO5ENSR5MaZOZVwKBTcjNDEMS101daJPxQioGxCKB1cZM449b/bYiymEjf4QyWYXUOp/kVRDMTff4nG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884589; c=relaxed/simple;
	bh=AccgHMjhdT5b8PhDHeBEe8SY7qfzk70Mw1MG6hqDEo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sSSg31C4C1h9ruEsBixcmVoAnEab8RBjAfycLGRfq1zOuBUwSR15qJ4XzXDeeXb763jRJbZaHj53ghX1u2iZe3/5kY3LvViaMEujqjh1KlmfA896a+x/q+Up8dtiUiNn4TI/GUP9QAoEn5IorhNEyKokqh+M1YooBI9jRt5Yr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I0Dze26X; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250903072945epoutp04f939cce35f7cf1013a5018814cb2e1d6~htTjGZZqi3174331743epoutp04Z
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:29:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250903072945epoutp04f939cce35f7cf1013a5018814cb2e1d6~htTjGZZqi3174331743epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756884585;
	bh=U8biUgrbmhqoy6ImwYHNZ85z7bDPbo86mIUx8VSMBxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0Dze26XPryFpTCs+1wxaIKAifxm8NmL2jCygMKbFw/KQy7Jb0aOAMn+tUCc5tZV4
	 jV0o3ykGLexR+OA1rCpjMM8+ztOFPT16O0+jHX9PiCNYBwEx3Qz3aPTf+1Zu2Q0irj
	 f/smhA90zhg36xVn7nivtMqUC1KpQCYi9pgCz/ZI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250903072944epcas5p31eb60c88907761fda0defbcfa85ee83e~htTiY2_Cu2293822938epcas5p31;
	Wed,  3 Sep 2025 07:29:44 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGvPz2T8Yz3hhTD; Wed,  3 Sep
	2025 07:29:43 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250903072942epcas5p2154a85b45152af50e2714248c38c5adc~htTg3bZdO1236712367epcas5p2g;
	Wed,  3 Sep 2025 07:29:42 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250903072939epsmtip2455dc285a7eb49093c51aabf1e508bac~htTeA3VNU2549225492epsmtip2G;
	Wed,  3 Sep 2025 07:29:39 +0000 (GMT)
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
Subject: [PATCH v8 3/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 combo hsphy
Date: Wed,  3 Sep 2025 13:08:24 +0530
Message-Id: <20250903073827.3015662-4-pritam.sutar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903073827.3015662-1-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903072942epcas5p2154a85b45152af50e2714248c38c5adc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903072942epcas5p2154a85b45152af50e2714248c38c5adc
References: <20250903073827.3015662-1-pritam.sutar@samsung.com>
	<CGME20250903072942epcas5p2154a85b45152af50e2714248c38c5adc@epcas5p2.samsung.com>

The USBDRD31 5nm controller consists of Synopsys USB2.0 femptophy and
USBSS combophy. Add-on USB20 femptophy is required to support USB20 data
rates along with USBSS phy. Document support for the USB2.0 femptophy
found on combophy of the this SoC.

Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
---
 .../devicetree/bindings/phy/samsung,usb3-drd-phy.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 8d8114eb5660..4a8bcf63cd91 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -34,6 +34,7 @@ properties:
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
       - samsung,exynos990-usbdrd-phy
+      - samsung,exynosautov920-usbdrd-combo-hsphy
       - samsung,exynosautov920-usbdrd-phy
 
   clocks:
@@ -229,6 +230,7 @@ allOf:
               - samsung,exynos7870-usbdrd-phy
               - samsung,exynos850-usbdrd-phy
               - samsung,exynos990-usbdrd-phy
+              - samsung,exynosautov920-usbdrd-combo-hsphy
               - samsung,exynosautov920-usbdrd-phy
     then:
       properties:
@@ -252,6 +254,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - samsung,exynosautov920-usbdrd-combo-hsphy
               - samsung,exynosautov920-usbdrd-phy
     then:
       required:
-- 
2.34.1


