Return-Path: <linux-kernel+bounces-813524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDD9B546B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CC81888CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D81283FF0;
	Fri, 12 Sep 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TBVpNSul"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8927E1AC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668595; cv=none; b=jEJQalrw5E3wgkLTMpHSGP7utetQxcVqL1HdHyJG63GK3FNEQuwR3HAPzj4XIZXCWV/lw+cC4uQyRK3xRVmnIrp/RJBO3ZRAvuhuFGecpukgVeJUBrDf88+Wk5XgcvBc2/kpFW5ibsI3uJ1izkGtfQJJI+RmrOe/wXsu4ib/0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668595; c=relaxed/simple;
	bh=7xjaN++yI6KEPxU35tjofli5LkxLgcT962mH3BRyDXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndxk/9crnOY4HyURO7X7EGNYFfxNJy1dUvFbJW49FeJ81xjkoH9vv4Tf9NGp0sLXrV0oG4AwJCVVZPjht/xT9dkd4McQZrU0VrJNURoDjeHchqU7r4mvzbLOVo4+UQCPMHkMVVo8DgJZL4352C03OD2qZBCmgqqD8bbhCvqUD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TBVpNSul; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A0CE91A0DD4;
	Fri, 12 Sep 2025 09:16:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 755A260638;
	Fri, 12 Sep 2025 09:16:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 525F1102F29DD;
	Fri, 12 Sep 2025 11:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757668591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L+6jrk72fwMKzwzZOHzEZKdBpoCdacRGXLcgPacqMIc=;
	b=TBVpNSulOChQdlcmYi2dQcLYtqA+Q+FarGn42UjJOXftDgtEDTZPRWGyii2m/rP80+EzVK
	ATqwx/Nwpw5P1madWnjfWjsm0qZvOT5BnZyVlCxDCWXXl/fz0dPv5gVwfrNMDrqod0aPmK
	9KR7P3qkezmyJz6bf5REKk+cMr3LtOSYZOXb1FBOefrCPEO93qpOfeZlpLoPuqeIPrX1Pz
	rU00wb7SQmT0fo+dbZTyEVqDNQulVyBBdMmJN+X13xg3xvkyQFDoqFSlx6cGOMhgANp3e+
	dw+BVWGo2jVFdBbO8xOztibiJk0bSMJlA1k8GunUczgq8ul8Z9C7PZiKvzfFLg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 12 Sep 2025 11:09:13 +0200
Subject: [PATCH net-next v2 2/3] dt-bindings: net: dsa: microchip: Add
 strap description to set SPI mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-ksz-strap-pins-v2-2-6d97270c6926@bootlin.com>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
In-Reply-To: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

At reset, KSZ8463 uses a strap-based configuration to set SPI as
interface bus. If the required pull-ups/pull-downs are missing (by
mistake or by design to save power) the pins may float and the
configuration can go wrong preventing any communication with the switch.

Add a 'reset' pinmux state
Add a KSZ8463 specific strap description that can be used by the driver
to drive the strap pins during reset. Two GPIOs are used. Users must
describe either both of them or none of them.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index db8175b4ced6d136ba97c371b68ba993637e444a..099c6b373704427755c3d8cad4b1cd930219f2f2 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -34,6 +34,13 @@ properties:
       - microchip,ksz8567
       - microchip,lan9646
 
+  pinctrl-names:
+    items:
+      - const: default
+      - const: reset
+        description:
+          Used during reset for strap configuration.
+
   reset-gpios:
     description:
       Should be a gpio specifier for a reset line.
@@ -139,6 +146,23 @@ allOf:
                     should be provided externally.
               dependencies:
                 microchip,rmii-clk-internal: [ethernet]
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,ksz8463
+    then:
+      properties:
+        strap-rxd0-gpios:
+          description:
+            RXD0 pin, used to select SPI as bus interface.
+        strap-rxd1-gpios:
+          description:
+            RXD1 pin, used to select SPI as bus interface.
+
+dependencies:
+  strap-rxd0-gpios: [ strap-rxd1-gpios ]
+  strap-rxd1-gpios: [ strap-rxd0-gpios ]
 
 unevaluatedProperties: false
 

-- 
2.51.0


