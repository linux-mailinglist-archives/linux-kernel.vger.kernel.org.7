Return-Path: <linux-kernel+bounces-816269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70534B571B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1EF3ACD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661402D9493;
	Mon, 15 Sep 2025 07:39:43 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56462D7388;
	Mon, 15 Sep 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921983; cv=none; b=I+RABGEjq8gZFmr/M9uEhERVANqxhUJzmly627hnjU7lyh65Np7HmZU7XGYw93lhYlLOd/XuMgI6YhJJQ3Uhy0ei16Gd8Q1IYr/lAvMhyjqkULQy6axKeq4UpU7lfj1lj/jEjragARZJnx44NHmeinQ+T3VIKpEmOxJFHg0d83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921983; c=relaxed/simple;
	bh=qSuz+bKGDq7k+juHcdsrwoGO+rS155RqVm52v5DFmnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyLCumzl3jhttXiU1loaQnW98N4HNqFq7D4x6HTUhMrQ9iWeTJ9ErJJldA50CN02vYk9N1xkI+99oHJCCxJw9Za7U3EJH/BQR3DgqzocqUQEKesAKQUEfjKOZpJ1LQQyrVClNNp21MCnMG/8PYVwVdktgjyzJIqlYig9R8wtuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 15 Sep
 2025 15:39:26 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 15 Sep 2025 15:39:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: usb: uhci: Add reset property
Date: Mon, 15 Sep 2025 15:39:23 +0800
Message-ID: <20250915073926.3057368-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
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


