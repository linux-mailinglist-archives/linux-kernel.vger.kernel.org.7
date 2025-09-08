Return-Path: <linux-kernel+bounces-804917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30844B481EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB85D17C525
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF861DE3DB;
	Mon,  8 Sep 2025 01:18:27 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA441CEADB;
	Mon,  8 Sep 2025 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294307; cv=none; b=SmY9HzI6LZbyfRPRMDMf3QYgDoeWqA0kV6c/rbvJMSg5Vp3su8oSqyWDWiaAwbX6TqhTT3irHqbVA/FworPQhnPV50d7REMU6CJMZtmfL+k/JasGj4czFZdVjYPThfnfOmmdJBIbtA6bJm9gQCMtgTyAduUKfjoX0TPLx+H4Gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294307; c=relaxed/simple;
	bh=hBrHhMm7CnKQJCLOB4kEXiSKKwtIB7+L2MZsLzEE4VI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8vrWAlkOs5W9a0fSPDZ5/5XeSly8/ICzO5N+0alDgv4DIOagJH4XBCtPMwuVGp9yvchT5WL9klIuUSQg9JCGYRbMyNFlMzeXexK/pl6jbkwdHVzK1j3CaEOpqmVZ1VMwNHUNVJTkPjRPxQsTaGL3kGLqS3WhuQEql753dSIokY=
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
Subject: [PATCH v4 2/4] dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
Date: Mon, 8 Sep 2025 09:18:10 +0800
Message-ID: <20250908011812.1033858-3-ryan_chen@aspeedtech.com>
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


