Return-Path: <linux-kernel+bounces-742475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF415B0F225
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C715A7B65B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641BD2E7181;
	Wed, 23 Jul 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="qLmWSqS0"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A42E5B1C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273432; cv=none; b=sOVHY2TrpKuBbfAWu/Aa/gcY8oEocCtwAz1j91tCtb/Z24r7w+Mj/1RfZS8/EXRMDzImU9Kf92AlNdHMVCmRqOXAvyKZrZVuz8ymx4E0cDcxU5sY/y0kBvolizybeBOLd7JmuEgSlc6FSbOWdtfDqma1iQ2cruDWqXONsD6At7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273432; c=relaxed/simple;
	bh=0ISYNH1EBVAZYOnYkE5HZvWKIs61e1vcooKNHgb+bfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlawjzCNaSzRApk/yvO4xl42ccJOTFd6vVPaIjRurJBqFWFh3pg185wcPFYPiuG+BjsmEbgkra6b/PyJil1nFlJ3IpZKx5tlV9y9XTbuGKLOXJp0GyESzGPryYjB4xx7rqngcI1LgAOpHl2V2wXKOmtWMOXmpRoEEWB3o6fDUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=qLmWSqS0; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753273430; bh=pMeef0fMgt0XkMUkuWS4WfbRrZLUJjrcEoP7+ycSlXU=;
 b=qLmWSqS0pQ5wxnTqpmGotO15khiKg8FdgY4PkF55Y9uYFpgSlm498fhgqQl3aDAxkAvjgyKiD
 xFybbRFgBF8+iRsVXiCDQR/EGeu4Yi6957/92JdzoSkfRYkkkpXvnRd/7xywF/eunLieV7oQwx/
 rMlGnJyQ3InURmKp45phjp0dKaX2uR/pfHE2wNZNQyYtuyR4vQh/uQJg6OZM5+gtsRtusbRm0mT
 5/+h9oHs8/f8r3dqbfj0FaXzgs9aNakHKjBiph0SIA4EentEa2jTM6/095vOXnj3v419IjBNdCM
 MT15vHJJcuMqj7/zrEONtLGyXinoZ9nMGZdvV+6djG9A==
X-Forward-Email-ID: 6880d44ecb0ee86f9731a087
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/11] dt-bindings: phy: rockchip,inno-usb2phy: Add compatible for RK3528
Date: Wed, 23 Jul 2025 12:23:01 +0000
Message-ID: <20250723122323.2344916-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723122323.2344916-1-jonas@kwiboo.se>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The embedded USB2 PHY on RK3528 is very similar to the one in RK3568,
the main difference being that it only uses two clocks instead of three.

Add compatible to support the USB2 PHY in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../bindings/phy/rockchip,inno-usb2phy.yaml   | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index b95c9e3e44fe..f50fc69fbbe4 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3328-usb2phy
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
+      - rockchip,rk3528-usb2phy
       - rockchip,rk3562-usb2phy
       - rockchip,rk3568-usb2phy
       - rockchip,rk3576-usb2phy
@@ -41,11 +42,15 @@ properties:
     maxItems: 3
 
   clock-names:
-    minItems: 1
-    items:
+    oneOf:
       - const: phyclk
-      - const: aclk
-      - const: aclk_slv
+      - items:
+          - const: phyclk
+          - const: pclk
+      - items:
+          - const: phyclk
+          - const: aclk
+          - const: aclk_slv
 
   assigned-clocks:
     description:
@@ -65,6 +70,9 @@ properties:
     description: Muxed interrupt for both ports
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 2
 
@@ -150,6 +158,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3528-usb2phy
               - rockchip,rk3568-usb2phy
               - rockchip,rv1108-usb2phy
     then:
@@ -218,6 +227,19 @@ allOf:
         clock-names:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3528-usb2phy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+
   - if:
       properties:
         compatible:
-- 
2.50.1


