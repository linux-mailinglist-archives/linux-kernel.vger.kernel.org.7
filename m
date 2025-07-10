Return-Path: <linux-kernel+bounces-724789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E8AFF6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F15D584453
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D127FD4F;
	Thu, 10 Jul 2025 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b="FKceDRGl"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172B23B613;
	Thu, 10 Jul 2025 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115361; cv=none; b=Bm+8GjUNQdot3MsJq9EVjhCEnq2DUh/TW1TkFUii//0DHi6Nl4FTbo7KPF2v6qmC1FqmJDNlGiKDuAYWveqXclkj/jqG9Oq8CybA3AwZyvW78GlpPOu0gbB2p2LhiosBnBMiz4mq8fO07r7H35DL0Qqe0RTiVWg/YZVMEElg7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115361; c=relaxed/simple;
	bh=zZaO+4SQnHx+PoeMs3Zyocz37jNG8iIhg4MRgGt8mdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYQIac5G+pvoZd6z3s5nLHr1UpqsiIn3ExqrWUfMcqSgmJaQ8bEP2C2irOwluEH/SvLJJjO36v2tpRSsv1YGrMlMKJNTAqe2WUkXW70nionrNn64Q9YxtiZxBvTHFl4l7WaCQAzBl6kuwpAfQ5iD6YgcZReHDp0GWDmKsJSQPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com; spf=pass smtp.mailfrom=lab126.com; dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b=FKceDRGl; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1752115360; x=1783651360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvnLYL+/IlFsK+/EON8jc4rYEkq8pObThhK3WBClhVE=;
  b=FKceDRGlXCFqKuxZiPbnTj40SUA48ebg+J2xneeIgrgt8HVBBJpdnSQX
   ewmG7Q1s4YZuaUXrYh9XqdjWg7vMl9bblNKfXIklGFmEe/byGwk3XZd/U
   Kpk8gbwC0tEdO6gsnswV3N1au4SAuE0RBx5KLQNo4OzU8wjnD4c/o1ELP
   9hSRdAEt3e9OAPeqlp3RpyNcD98BCN96QZcdR3NNkzP3Kkn8vNd4AlZVB
   3KMoAol1KyQjJyyDupKyvfghBpypqXoCjnRiv0jNvjvZr/lpROxThTdY0
   0RvQnmkc+UtLX1HOveSCVGDH3BKMrjPaLu/wFcu3+/Bi/QXmKDYVgxVW2
   w==;
X-IronPort-AV: E=Sophos;i="6.16,299,1744070400"; 
   d="scan'208";a="537353771"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:42:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:64364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.175:2525] with esmtp (Farcaster)
 id 6c1c351b-940d-4415-acd4-f9b066c490a3; Thu, 10 Jul 2025 02:42:38 +0000 (UTC)
X-Farcaster-Flow-ID: 6c1c351b-940d-4415-acd4-f9b066c490a3
Received: from EX19D007UWB001.ant.amazon.com (10.13.138.75) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 02:42:38 +0000
Received: from u1cb251c9c70150.ant.amazon.com (10.68.99.17) by
 EX19D007UWB001.ant.amazon.com (10.13.138.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 02:42:38 +0000
From: Karthik Poduval <kpoduval@lab126.com>
To: <jyxiong@amazon.com>, <miguel.lopes@synopsys.com>, <anishkmr@amazon.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: Karthik Poduval <kpoduval@lab126.com>
Subject: [PATCH v2 2/2] phy: dw-dphy-rx: Add dt bindings for Synopsys MIPI D-PHY RX
Date: Wed, 9 Jul 2025 19:42:21 -0700
Message-ID: <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752106239.git.kpoduval@lab126.com>
References: <cover.1752106239.git.kpoduval@lab126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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
index 000000000000..c3c657b1e77d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/snps,dw-dphy-rx.yaml#
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
+    minItems: 2
+    maxItems: 2
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


