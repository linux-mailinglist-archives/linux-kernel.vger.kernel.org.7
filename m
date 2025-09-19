Return-Path: <linux-kernel+bounces-823936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3115B87C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782A51C232F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8B26B0AE;
	Fri, 19 Sep 2025 02:57:20 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C4260563;
	Fri, 19 Sep 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250639; cv=none; b=DC25ZXUdVCJmnnmaDJR5hp1gbHRtymbRrzHqEsSaOgemustzvtcn9GXYEQY2846cvl4q23CqoxOnYdk7QsMqtboJWqYk8+Lvw8enDTVV6dCvDXo4RvGRIGwZEGYggDGcyN44gWH+/TcSdaudRMtwRS8nF8Qh9A5C58vQG6QeJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250639; c=relaxed/simple;
	bh=qCMpKNEwmFFQntyUxe04ONnLaz0OBcgXO5q4kCOIInU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFWSgG5TR3B7t9doZ61myIUpaS32UEYxzHNPQAfG5g/MVHrL4d6R6zT7Mf9y7n8Oy3TO98QgVOeFeRx/jBRywOZxN1cwyDeg/S1ZUpR4rOpiVnOLa7VLtB5Sd2FQ1SU4X2RCKf0XujnGMI5WeAnIgso3oWZk18T6D3L4MpoD9lI=
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
Subject: [PATCH v3 1/4] dt-bindings: usb: uhci: Add reset property
Date: Fri, 19 Sep 2025 10:57:09 +0800
Message-ID: <20250919025712.719246-2-ryan_chen@aspeedtech.com>
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

The UHCI controller on Aspeed SoCs (including AST2700) requires
its reset line to be deasserted before the controller can be used.
Add an optional "resets" property to the UHCI device tree bindings
to describe the phandle to the reset controller.

This property is optional for platforms which do not require
explicit reset handling.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/usb/usb-uhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
index d8336f72dc1f..b1f2b9bd7921 100644
--- a/Documentation/devicetree/bindings/usb/usb-uhci.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
@@ -28,6 +28,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   '#ports':
     $ref: /schemas/types.yaml#/definitions/uint32
 
-- 
2.34.1


