Return-Path: <linux-kernel+bounces-807450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92511B4A477
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6989189D34A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2549D2459FF;
	Tue,  9 Sep 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zFwTKofk"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8118A93F;
	Tue,  9 Sep 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405034; cv=none; b=TyZdITOgISzMm5JqqdxconKflRA5EjlzRiPrxHHdxsDTGaK58OUHBHqsHtCywtZ7+OTM0g9VWXLBDCj2rElx7rLSlQo4XdRcnAAvie44XR9sE4LIdQz9nVY467VS/Z27bBWkDhkQIzK7c/kYME0PSJ9BRnDHfZILDss/xSkDmyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405034; c=relaxed/simple;
	bh=wLK02Ed1K38JrKw2XwBDErtXlAHtu/vAoVKzu2+CvA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1huWAHFShi5WK2HO/P1m3QOmbu6sIo1Neli66K19X072hvKrqS2U/TLQ7blH0UGRkBPpXHvLgtxhGHEe+1O6MSM+qZM0SS53zA9x8qsDqpPNdo/KP4Ip2FVHRg+xdlsRhmpe/tIn5Ct+ZfjL16DdVnE6vPon9Oh9O7PLiQVTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zFwTKofk; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58983ix03980614;
	Tue, 9 Sep 2025 03:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757405024;
	bh=uPRgODPKeN9jsNYNPx6NODG41yHKoxurGr/Q/w1nGsY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zFwTKofkglkFvdO30wmB4GyoF8+0ibao7FcEdC9SsofYFToPRspxkkmtBl2YLBP39
	 q9NvmryXA9DBhbU1IhsniCAXXu2B5gB8mhsfC8iX5yTZBidiNkEAgwLlG/xgAbpN76
	 gg0RX8IUCySHHuydrt2XsUrh/2ZYC6fe5LX+OSE0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58983is53627735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 03:03:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 03:03:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 03:03:43 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.150])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58980nwd2009791;
	Tue, 9 Sep 2025 03:00:55 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <vigneshr@ti.com>, <wbg@kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/2] dt-bindings: counter: Add new ti,omap-dmtimer-cap compatible
Date: Tue, 9 Sep 2025 13:30:41 +0530
Message-ID: <20250909080042.36127-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909080042.36127-1-g-praveen@ti.com>
References: <20250909080042.36127-1-g-praveen@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This commit adds a YAML binding for OMAP DM timer used in
capture operating mode.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 .../bindings/counter/ti,omap-dmtimer-cap.yaml | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml

diff --git a/Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml b/Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml
new file mode 100644
index 000000000000..8de9cf58aee5
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/ti,omap-dmtimer-cap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI dual mode timer Capture Module
+
+maintainers:
+  - Gokul Praveen <g-praveen@ti.com>
+
+description:
+  TI dual mode timer instances have an IO pin for Capture capability.
+
+properties:
+  compatible:
+    const: ti,omap-dmtimer-cap
+
+  ti,timers:
+    description: Timer instance phandle for the Capture
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - ti,timers
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    main_cap10: dmtimer-main-cap-10 {
+      compatible = "ti,omap-dmtimer-cap";
+      ti,timers = <&main_timer10>;
+    };
-- 
2.34.1


