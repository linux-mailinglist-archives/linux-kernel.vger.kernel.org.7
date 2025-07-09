Return-Path: <linux-kernel+bounces-724580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B2AFF487
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CA25C170B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5B246790;
	Wed,  9 Jul 2025 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b="ttOEq6q0"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920C245008;
	Wed,  9 Jul 2025 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099462; cv=none; b=jiLTuvpTnWSGZhow/fB4X01w5BujsRgF0Pp9LDZ8fZtKxq2DdQBGwpwusmwCrsJ9Xt76bYXmoMsMbb/PuTgCqLWtB6yYHZCLMCHNjkBqZ7xa6lkiag7ltBrolDG8TMXLUvzUgi6ykEnvXGncfaTN2rQMRBmrf9hN4BlOJArQwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099462; c=relaxed/simple;
	bh=i+X/LERh4rj/4tfNwclQ3Dnd+gRKxCSewwoMSwU8kWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2fTQksOZ66WRKjF9prSqtLXJm6+prQZ/ncwFet6hjzo5ezcNoC/wWvUXZ9f5WxF0aQ9y+0TxsT39NdMc10lQbc8a3a6Sfa/ng+QlSSBvL6NyCrJTPXXfKIKvUjjkstQSJ1oQuXrSPfWdUx1Lv3uHsWAUhyw2F7WmidCXQFRDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com; spf=pass smtp.mailfrom=lab126.com; dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b=ttOEq6q0; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1752099461; x=1783635461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6qq6tD8G2gJnKmNebl13VtAMiIeIIKd0RBrZrx89A3w=;
  b=ttOEq6q0FjfmyMuq0Rz+52v+lRa5mL7DI7NFyojkHtR22h6jGyXMe2x8
   Wt5zCC/yArp5pxWCpQGgiPgwo6tWwubHg+Tay6n6UA5CJZv7D+N42sELJ
   icqWIzPxhtdEgaD2puZmQq1IWev++sdz3BHaArLKZgYCRtwd9/D8+R3g1
   XVzUy79GLxiTYU/LP7zzWWog4SPHvT/a8ykAT7vplr9a+yOUbhGSorRf7
   LEmJPE6QhPwX4Sf70IWT0Cq/QPG4NBWG9gPdlED1RiXc3UWE/3JsNfU17
   tgf5PkYZpDumL3AJ6f18H6KWuFKDEuiFViFjmsyAfh8eu9SP3+gyM0fUT
   g==;
X-IronPort-AV: E=Sophos;i="6.16,299,1744070400"; 
   d="scan'208";a="316202464"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:17:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:31037]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.16:2525] with esmtp (Farcaster)
 id d62a3060-98c9-4334-b974-36061ea67137; Wed, 9 Jul 2025 22:17:38 +0000 (UTC)
X-Farcaster-Flow-ID: d62a3060-98c9-4334-b974-36061ea67137
Received: from EX19D007UWB001.ant.amazon.com (10.13.138.75) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Jul 2025 22:17:38 +0000
Received: from u1cb251c9c70150.ant.amazon.com (10.68.99.17) by
 EX19D007UWB001.ant.amazon.com (10.13.138.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Jul 2025 22:17:37 +0000
From: Karthik Poduval <kpoduval@lab126.com>
To: <jyxiong@amazon.com>, <miguel.lopes@synopsys.com>, <anishkmr@amazon.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: Karthik Poduval <kpoduval@lab126.com>
Subject: [PATCH 2/2] phy: dw-dphy-rx: Add dt bindings for Synopsys MIPI D-PHY RX
Date: Wed, 9 Jul 2025 15:17:24 -0700
Message-ID: <20250709221724.1276428-2-kpoduval@lab126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709221724.1276428-1-kpoduval@lab126.com>
References: <20250709221724.1276428-1-kpoduval@lab126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D007UWB001.ant.amazon.com (10.13.138.75)

Add DT Bindings for Synopsys D-PHY RX, presently tested on version 1.2

Signed-off-by: Karthik Poduval <kpoduval@lab126.com>
---
 .../bindings/phy/snps,dw-dphy-rx.yaml         | 44 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
new file mode 100644
index 000000000000..e986b2872e1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/snps,mipi-dphy-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys Designware MIPI D-PHY RX
+
+maintainers:
+  - Karthik Poduval <kpoduval@lab126.com>
+  - Jason Xiong <jyxiong@amazon.com>
+  - Miguel Lopes <miguel.lopes@synopsys.com
+
+description: |
+  These are the bindings for Synopsys Designware MIPI DPHY RX phy driver.
+  Currently only supported phy version is v1.2.
+
+properties:
+  compatible:
+    const: snps,dw-dphy-1p2
+
+  '#phy-cells':
+    const: 0
+
+  reg:
+    - minItems: 2
+    - maxItems: 2
+
+required:
+  - compatible
+  - '#phy-cells'
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dw_dphy_rx: dw-dphy@900000040 {
+        compatible = "snps,dw-dphy-1p2";
+        #phy-cells = <0>;
+        reg = <0x0 0x90000040 0x0 0x20>, <0x0 0x90001000 0x0 0x8>;
+        status = "disabled";
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index b5a472a544cf..5fd5a92431bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24217,6 +24217,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
 F:	drivers/dma/dw-axi-dmac/

+SYNOPSYS DESIGNWARE MIPI D-PHY RX DRIVER
+M:	Karthik Poduval <kpoduval@lab126.com>
+M:	Jason Xiong <jyxiong@amazon.com>
+M:	Miguel Lopes <miguel.lopes@synopsys.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
+
 SYNOPSYS DESIGNWARE DMAC DRIVER
 M:	Viresh Kumar <vireshk@kernel.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
--
2.43.0


