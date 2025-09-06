Return-Path: <linux-kernel+bounces-803972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93AB4681E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4DB7B94F9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561811D5AC6;
	Sat,  6 Sep 2025 01:49:02 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA01C4A13;
	Sat,  6 Sep 2025 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123342; cv=none; b=jC1H47QjZ2SxjMMqTopizRqG0MD8uByEqnTGx92cxq91/hkdtnUy1bZKv9fYQNrzWT5Ijm/XCLM2bv7qLCCreDQwfZfw6Sna+elQigyBmQGsXjFyhxtpKmdCI/dNBstO/cZDbzO0nlpO5pouXWo0ZemO5z2LPz7PLW5y4VIhx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123342; c=relaxed/simple;
	bh=hBrHhMm7CnKQJCLOB4kEXiSKKwtIB7+L2MZsLzEE4VI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeW2fwTG19RGRRB37zuC7PBWkfVFWCQ76vekpuA3w/Zqzh0Z8Y2SYIA+9X/KzcmfgezFqB4lgzFyZM6Xq6q0Bbn467WMUMPgay0nR5QHDzWipyAjmRqKgCpdgndGS7vPKZfvZp16BTU5pdZGLPkMPNefXHSR4KbjMNdzlkXNjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 6 Sep
 2025 09:48:46 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 6 Sep 2025 09:48:46 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/4] dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
Date: Sat, 6 Sep 2025 09:48:44 +0800
Message-ID: <20250906014846.861368-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906014846.861368-1-ryan_chen@aspeedtech.com>
References: <20250906014846.861368-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add SCU interrupt controller compatible strings for the AST2700 SoC:
scu-ic0 to 3. This extends the MFD binding to support AST2700-based
platforms.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10d95ce..67be6d095fe4 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -75,6 +75,10 @@ patternProperties:
             - aspeed,ast2500-scu-ic
             - aspeed,ast2600-scu-ic0
             - aspeed,ast2600-scu-ic1
+            - aspeed,ast2700-scu-ic0
+            - aspeed,ast2700-scu-ic1
+            - aspeed,ast2700-scu-ic2
+            - aspeed,ast2700-scu-ic3
 
   '^silicon-id@[0-9a-f]+$':
     description: Unique hardware silicon identifiers within the SoC
-- 
2.34.1


