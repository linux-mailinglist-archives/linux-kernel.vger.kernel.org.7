Return-Path: <linux-kernel+bounces-722564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB6AFDC4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB99B7AE420
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3011BC2A;
	Wed,  9 Jul 2025 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vXa31Csq"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B735962
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020655; cv=none; b=OvfL3p3dZ/ymXUffBzeJfqeQzCDS8Kq4zJNgQuZwVWaO+KTiOjTwTYZ+7+hYgnS8GnijEdwIjkJnFakQYJTwNLbHVx4gebzChzzK5B1VWZc8sH/XNl0D3lxKwomsRZd3Zi/7wx6RGF1BvdtzxMa0YgACdfsxgyPpnv0+Loz+sQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020655; c=relaxed/simple;
	bh=MXXPtOORne6fRmHo+JAQjtJq9xauIVQ17AV2K3ja3C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=IAgYqTe7mnSd7cb82yLM7FgO1VpZMTz/ubOIY8gnZxYDJiUalBwkHgEyTpaI/uOCaQ6OPog9Y7ekBkScSe4BIon2QJ41kx7ETWIMjOK7X3xATcKHuadD1Tc1RqtqIi71669Pgyqph7iwm0mK8lYoXk7RHhQTia6WGyKgC6aOcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vXa31Csq; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250709002410epoutp039881616b995912df6b969861124dc17c~QbX-Vl8dW1945919459epoutp03N
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250709002410epoutp039881616b995912df6b969861124dc17c~QbX-Vl8dW1945919459epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752020650;
	bh=JmtiAJIx4OJnYhoun1Y6mRhQPBpKeZEivxGm5Al8d1c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vXa31CsqaCNCfH042OntLj6d6RXXTHVeJfehiL4mjGpBIY6TrOKhUOdeUeOF8orss
	 F4SDuXdTD7JOJ0NZHj30LuoNWvl8RWiPQEpqRD+HP1SYGziAtPYMT97HheycQMjx6h
	 nI/uFdUgctefm+yfZPYsLV1sBG//+A8cFF9gxAag=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250709002410epcas2p187128c3c29a82d5752edd758cfc3b21a~QbX_3tXqI0630606306epcas2p1Z;
	Wed,  9 Jul 2025 00:24:10 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.102]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bcJcn2fSDz6B9mB; Wed,  9 Jul
	2025 00:24:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250709002408epcas2p25248bf1a397fc308d91ffef3889c41d5~QbX9emyK01430814308epcas2p2I;
	Wed,  9 Jul 2025 00:24:08 +0000 (GMT)
Received: from AProject.dsn.sec.samsung.com (unknown [10.229.9.52]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250709002408epsmtip1e2456747b63928e1cc20f961d1d7e29b~QbX9b90_b3159031590epsmtip1A;
	Wed,  9 Jul 2025 00:24:08 +0000 (GMT)
From: ew kim <ew.kim@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ew kim <ew.kim@samsung.com>
Subject: [PATCH] arm64: dts: exynos: add abox generic for ExynosAutov920
Date: Wed,  9 Jul 2025 09:12:10 +0900
Message-Id: <20250709001210.379418-1-ew.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250709002408epcas2p25248bf1a397fc308d91ffef3889c41d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250709002408epcas2p25248bf1a397fc308d91ffef3889c41d5
References: <CGME20250709002408epcas2p25248bf1a397fc308d91ffef3889c41d5@epcas2p2.samsung.com>

Add a node for Abox generic. This driver, exynosautov920, connects to
the SoC and allows you to configure a sound card.

Signed-off-by: ew kim <ew.kim@samsung.com>
---
 .../boot/dts/exynos/exynosautov920-audio.dtsi | 20 +++++++++++++++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  1 +
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-audio.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-audio.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920-audio.dtsi
new file mode 100644
index 000000000000..4a1341ccdc2e
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-audio.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *        http://www.samsung.com/
+ *
+ * EXYNOS - Audio Device Tree source
+ */
+
+/ {
+	abox_generic: abox_generic@generic {
+		compatible = "samsung,abox_generic";
+		samsung,num-of-pcm_playback = <32>;
+		samsung,num-of-pcm_capture = <32>;
+		samsung,num-of-i2s-dummy-backend = <5>;
+		status = "disabled";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 2cb8041c8a9f..6893fd36485e 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -1129,3 +1129,4 @@ timer {
 };
 
 #include "exynosautov920-pinctrl.dtsi"
+#include "exynosautov920-audio.dtsi"
-- 
2.25.1


