Return-Path: <linux-kernel+bounces-754701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9005B19B24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1463AA5AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7522F74D;
	Mon,  4 Aug 2025 05:40:00 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C752264BA;
	Mon,  4 Aug 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754286000; cv=none; b=OJa6+buUGUlnLs+lYa3IlLxfGe7huLn/ox/UGxzj93+Yh7P/HuOg1ddWCdM3KLsgbsWG2Scg9bfRsG/vn8xC3vXuQ4D4KIAAEFENpWGrWI10sTZkGVwwxxv8I/E9O6Xyll3kVodUhRfG0dG8NihvZS761QRxXtjUJupuG10nQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754286000; c=relaxed/simple;
	bh=wUPCjqgDlpPNOOCtRlio82KP4wQD5krsTlLftPOxm0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cks24SY03xyq4JymQ1+PkaqkYsYR4UZoQqKxeF4fbND+L91MWWnrw0ixLDuU1OmATuGaMpIUMeMegcgxN1QR39YgiHTIy4RlZo3ywjwwgDjFIHU3EbScbKN3yM60AeFBKTlrKh4988cQRjRb1q1F6uJHw895YUMmvzLERp4UEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 13:34:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 4 Aug 2025 13:34:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: aspeed: add AST2700 SCU IC compatibles
Date: Mon, 4 Aug 2025 13:34:44 +0800
Message-ID: <20250804053445.1482749-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

- Add "aspeed,ast2700-scu-ic0,1,2,3" to the compatible
 list in aspeed,ast2500-scu-ic.yaml.
- Document support for AST27XX SCU interrupt controllers.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../interrupt-controller/aspeed,ast2500-scu-ic.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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
-- 
2.34.1


