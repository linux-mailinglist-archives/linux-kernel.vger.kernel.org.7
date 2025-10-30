Return-Path: <linux-kernel+bounces-877582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDFC1E7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7A188EF79
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F5246333;
	Thu, 30 Oct 2025 06:02:08 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D53148DB;
	Thu, 30 Oct 2025 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804127; cv=none; b=iZTN5RmHMi5QEJI8mujLL5pSTfyqj8MjQL8sLxm6P8m0YGg0ngYqLzGVz2PDqx4Opjxn1gq/T/A/ELx/wy5ecwZPY8Fvcij9Wx8V4alHeQw2N2JGu0B24nfAfC6vYsguOUTUS4f9EOiGMgY23+Gsepbs4kyt+SQQgjT0cLLpxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804127; c=relaxed/simple;
	bh=qPIsxmkLKEGcwd+vT7xjUk/aYe0vjQsnPgFlfMj9/MM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/Jmorn/XWzx49Kr8kEP6mfiNouEikG7xHJp7fVWsMyUK/gb1aTKW1S1ioq0s8y1mmm/wUK6NDQZPiP2biNNlvwW0AUPamVxE8emuxI+8uI6yM9GaGp+wc5q4hXchCOqla09ZAQxn+4ru63AfICNk8JPilMEbhSAQoF7zNxX9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 30 Oct
 2025 14:01:55 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 30 Oct 2025 14:01:55 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v6 1/1] dt-bindings: interrupt-controller: aspeed,ast2700: correct #interrupt-cells and interrupts count
Date: Thu, 30 Oct 2025 14:01:55 +0800
Message-ID: <20251030060155.2342604-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
References: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the AST2700 interrupt controller binding to match the actual
hardware and the irq-aspeed-intc driver behavior.

- Interrupts:
  First-level INTC banks request multiple interrupt lines to the root
  GIC, with a maximum of 10 per bank. Second-level INTC banks request
  only one interrupt line to their parent INTC-IC. Therefore, set the
  interrupts property to allow a minimum of 1 and a maximum of 10
  entries.

- #interrupt-cells:
  Set '#interrupt-cells' to <1> since the irq-aspeed-intc.c driver does
  not support specifying a trigger type; only the interrupt index is used.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../interrupt-controller/aspeed,ast2700-intc.yaml   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..999df5b905c5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -25,13 +25,14 @@ properties:
   interrupt-controller: true
 
   '#interrupt-cells':
-    const: 2
+    const: 1
     description:
       The first cell is the IRQ number, the second cell is the trigger
       type as defined in interrupt.txt in this directory.
 
   interrupts:
-    maxItems: 6
+    minItems: 1
+    maxItems: 10
     description: |
       Depend to which INTC0 or INTC1 used.
       INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
@@ -74,13 +75,17 @@ examples:
         interrupt-controller@12101b00 {
             compatible = "aspeed,ast2700-intc-ic";
             reg = <0 0x12101b00 0 0x10>;
-            #interrupt-cells = <2>;
+            #interrupt-cells = <1>;
             interrupt-controller;
             interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
-- 
2.34.1


