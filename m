Return-Path: <linux-kernel+bounces-823938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF61B87C59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AECE5808F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13D26D4D7;
	Fri, 19 Sep 2025 02:57:23 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CD26D4ED;
	Fri, 19 Sep 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250643; cv=none; b=CShJV+2dnhGYm9RHLEYJKloHXE8yVC7bALjeg4ihkAj2oqraI4DnHxESiq+ztig7u2IcCyqhAshapVT5BjfDbDXPLTuAGvAEtGyVGMGtjvWh9D6AJpNTIpxfbSRVe6ujhUmTPF+eBucCS22u7HgiegbJSQeuyiD60sUa5/FP+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250643; c=relaxed/simple;
	bh=6tFUe5ClwPO1n/Mm8qoJjiUjNyDI4gX260/dZCLD9fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu0Wl7Gx8YnWimLKnTJUO4K+Dfs+AT1LpE2ZVpI3JIdsOlx9uADujMmuC95g6w/OSnWeUvKCHiy251hO2i4Y0uk/qPXtRY9V6sstjOLZgbWlQ2bID11SRSPEJGvXGHLoDtiozf8SbRwNurtjH2OYXQflfv2jK/g6AGp0UFPuaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 10:57:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 10:57:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
Date: Fri, 19 Sep 2025 10:57:11 +0800
Message-ID: <20250919025712.719246-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the compatible string for Aspeed AST2700 SoC.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/usb/usb-uhci.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
index b1f2b9bd7921..7b774d0b2742 100644
--- a/Documentation/devicetree/bindings/usb/usb-uhci.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
@@ -20,6 +20,7 @@ properties:
               - aspeed,ast2400-uhci
               - aspeed,ast2500-uhci
               - aspeed,ast2600-uhci
+              - aspeed,ast2700-uhci
           - const: generic-uhci
 
   reg:
@@ -53,6 +54,15 @@ allOf:
       required:
         - clocks
 
+ - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2700-uhci
+    then:
+      required:
+        - resets
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


