Return-Path: <linux-kernel+bounces-833523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCABA2380
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6A34C59EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE69264623;
	Fri, 26 Sep 2025 02:33:21 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64552609D6;
	Fri, 26 Sep 2025 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854001; cv=none; b=XF5pMX6cPKVcid/CR1iwrJffmbPjxGqv70Y7iOAR5BQBr9EzECZtDoBkVDyMrp70AwXV0I/Ifa2J03W0c6yKrrUBUKQMstbZrD/aJA8URmzoSvHlr7trR2nTNG2j/9vWAM4z8qP9yyVaoInTfQBgXi3mm9VGUbQV2DBeG0PDWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854001; c=relaxed/simple;
	bh=9P1DgRTyTwlbkoms5dO/oxOMMmGjxNTqJcoBHpOIcAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo6xf5Z09JZAqFYXXWZRAV4b+od2r7GKojBmpLY51j7aw8qHLN45pEFxcaXGE+5xVpnf61DWIOR93TDGc0GnF7v1NRAM7RI423Np10THM1muG9oZ2Ee+Xo5sAWRq0vI15teSb2GvcJ64gnuUsnbiqU1F30wIDj64oxQgY2vmL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 10:33:08 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 10:33:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: ehci: Add Aspeed AST2700 compatible
Date: Fri, 26 Sep 2025 10:33:07 +0800
Message-ID: <20250926023308.2890607-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926023308.2890607-1-ryan_chen@aspeedtech.com>
References: <20250926023308.2890607-1-ryan_chen@aspeedtech.com>
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
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 508d958e698c..4e84bead0232 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -46,6 +46,7 @@ properties:
               - aspeed,ast2400-ehci
               - aspeed,ast2500-ehci
               - aspeed,ast2600-ehci
+              - aspeed,ast2700-ehci
               - brcm,bcm3384-ehci
               - brcm,bcm63268-ehci
               - brcm,bcm6328-ehci
-- 
2.34.1


