Return-Path: <linux-kernel+bounces-804918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC56B481F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1935E7AF8FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18001E47CC;
	Mon,  8 Sep 2025 01:18:29 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE021DDC2A;
	Mon,  8 Sep 2025 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294309; cv=none; b=kDmuve0Jkh8de5DlSU4c75HneOGTwQllHIZNPG0vNMxDxhUd031HqRZxZsxvTyZz2p60IiekdQGm2qfaiRjVLumOCDY8FC3nKiyzg37oyuvXImSsjeYYvn0tYCamJbY1Z+VWg8CBv9FKgGMpoaVX8yd3mpLFweQcbxGwnzmt5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294309; c=relaxed/simple;
	bh=3ZeABG7RXzgMupXNgC3IgUTXs2QEJW0g6ibXeuKOE2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9R09srds/5zniyi+8WMeMEJM6kfNYjFXsKjkexC5kcrNFWjMZLMtEagtMk6zIHO+QbrvL0BeiGJ37S6R9XoMnDuIOMWawPCX56OxEWxgUQoIU1wVlgWgC6XPKoMGB/g8hb0hkmzOYZiJGKVCxSIExdGjg6Tyef1RYprO2N9Xo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 09:18:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 09:18:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 3/4] dt-bindings: interrupt-controller: aspeed: Add AST2700 SCU IC compatibles
Date: Mon, 8 Sep 2025 09:18:11 +0800
Message-ID: <20250908011812.1033858-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908011812.1033858-1-ryan_chen@aspeedtech.com>
References: <20250908011812.1033858-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible strings for the four SCU interrupt controller instances
on the AST2700 SoC (scu-ic0 to 3), following the multi-instance model used
on AST2600.

Also define interrupt indices in the binding header.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../aspeed,ast2500-scu-ic.yaml                     |  6 +++++-
 .../interrupt-controller/aspeed-scu-ic.h           | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
index d5287a2bf866..d998a9d69b91 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-ic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
+title: Aspeed AST25XX, AST26XX, AST27XX SCU Interrupt Controller
 
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
@@ -16,6 +16,10 @@ properties:
       - aspeed,ast2500-scu-ic
       - aspeed,ast2600-scu-ic0
       - aspeed,ast2600-scu-ic1
+      - aspeed,ast2700-scu-ic0
+      - aspeed,ast2700-scu-ic1
+      - aspeed,ast2700-scu-ic2
+      - aspeed,ast2700-scu-ic3
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
index f315d5a7f5ee..7dd04424afcc 100644
--- a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -20,4 +20,18 @@
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
 
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_HI_TO_LO	2
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_HI_TO_LO	0
+
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_HI_TO_LO	0
+
 #endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
-- 
2.34.1


