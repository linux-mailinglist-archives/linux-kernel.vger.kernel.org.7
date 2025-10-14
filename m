Return-Path: <linux-kernel+bounces-852971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BDBDA570
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C1023538A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85723C50A;
	Tue, 14 Oct 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vln4QgwU"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816C2FFDF4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455546; cv=none; b=MUFqBypjkz+2lWB14FlK2zlfOeFE0ZiFExDsgbyjPZ/JRXIJuelZcF24WpyVQS73z4dR6xSCZqtuEVDZJeojDVAosA5rOGWsLwKPxaQzUomq6pFChLXK0JpAiUq3il504pz/BXIoyTVc1lDV+vB5Na1K51XvzWgZNgTUrlIUkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455546; c=relaxed/simple;
	bh=+BmgP1cwOI6VJAkhu18VNjfPGCwfgpuV7lA+QJYNabk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mh/qp45z+4O82ifIN1Jq5huuLyuw8dMFcN7795iF43+cOCNeHbs2zJHEwnjD72o0PGeGNsHYjZ+w6I7t/jSc0PQMX5GYe7MvOa7FYKTD6aaOj3qS+jpGiWaL6++UGthasZN8FP9WByIZQOTds6LypZ2b4wwu3Lhe+fJZpw5zLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vln4QgwU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DBD594E410B4;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEFA2606EC;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86829102F22A4;
	Tue, 14 Oct 2025 17:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BDLjVHEfWE+OX2EBzF2dDXKhMxIya0aonkUpZfjwFpc=;
	b=vln4QgwUJ3MGIz+BpttXJ1iUA6zRlssetcE0sHykllYoICGqYZ76acIeYhnJcNaM9NSh2X
	vjrIrErW91LO3QJZTJMLHvVh8dJGksfpL+qAOrl5JyIdBZCZyXD+rj9q4nXK+7pPlZvMFL
	Uu8ZBVZ5tTG3wn+emjJxzyZV4u7HrZwDl6QxjFNO9NH2UkHy1nTDAzL+tMaE547TFNfrbr
	YRYtGQuiILsE6AKhGB69QvAvFBzRcTEbi3rGBKKC4E0y0+OE5IohNM6Yj0R7z0CIvT5b20
	1uHXmtFntMUQgrqokSotoYOFA+UNTsJ7QvksKCCd+7NiIY/MkxQyB39FexykBg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:02 +0200
Subject: [PATCH net-next 01/15] dt-bindings: net: cdns,macb: sort
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-1-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Compatibles inside this enum are sorted-ish. Make it sorted.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 1029786a855c569f32171cd3484b0043622e9fc4..02f14a0b72f9c5c489c2e9a605d7f020c124fe31 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -47,18 +47,18 @@ properties:
           - const: cdns,macb          # Generic
 
       - enum:
-          - atmel,sama5d29-gem        # GEM XL IP (10/100) on Atmel sama5d29 SoCs
           - atmel,sama5d2-gem         # GEM IP (10/100) on Atmel sama5d2 SoCs
+          - atmel,sama5d29-gem        # GEM XL IP (10/100) on Atmel sama5d29 SoCs
           - atmel,sama5d3-gem         # Gigabit IP on Atmel sama5d3 SoCs
           - atmel,sama5d4-gem         # GEM IP (10/100) on Atmel sama5d4 SoCs
+          - cdns,emac                 # Generic
+          - cdns,gem                  # Generic
+          - cdns,macb                 # Generic
           - cdns,np4-macb             # NP4 SoC devices
           - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
           - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
           - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
-          - cdns,emac                 # Generic
-          - cdns,gem                  # Generic
-          - cdns,macb                 # Generic
 
       - items:
           - enum:

-- 
2.51.0


