Return-Path: <linux-kernel+bounces-829285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C4B96B20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C11C2E360E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CA2741B6;
	Tue, 23 Sep 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bAP6j7RV"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C072257842
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643257; cv=none; b=dQN3dc8ERg3ctMnCATKoeVhkwA36dm3FlwxwsQS/YJ+tvd2nc3WnueYHBwKMwMuFfbelcIMXdM5NybgYek2MgG9nw5D4CxIz4UYGN6Sj8nKZGjr7v51xp7gCwqsfPaZtYIkBt+TCkDTCNfpUAhYIJOVwkj5oM3D1j7ui1hFSVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643257; c=relaxed/simple;
	bh=3zZCd4F5TNJy+F1irODC06X4kSaGRUOro4Xbmp9NzTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCHrNFDAfTm5k/G9r++0+5DRLeG8UNjNk4u7/GFrDDhSsjxFeS+D9OF1MG0UjS0kYZS0ux6KEhokfI+bIWSwe9/SrS+pYExF7b+5SQGHGwXnHT0mGbQ7Ygp9G1Moee2XwGndrydK8Ha6DVgu3TmkLZJvr78aBtObP301F7+z8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bAP6j7RV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E619A1A0E8B;
	Tue, 23 Sep 2025 16:00:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5DFD60690;
	Tue, 23 Sep 2025 16:00:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF68C102F196F;
	Tue, 23 Sep 2025 18:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758643252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AM4ZgSHOUeHDIPf7yX4LJ/KF76YVa1eQBXVvqrWoGMs=;
	b=bAP6j7RVC7xP6hzBXnf3rxPuXBp46dGUH2uHL3e/jldDU8SdqLN0nXgGTwCLh+dpDD8eGF
	/WJM5KEBCQwIuncMzceWhHN79L0oqCfH4P0tXjBOrfoPuGwksas8RTjpKmRQnRTd0kg6YX
	TJlqZ8N4zWzgIi593BzSQicv+izp6rwc3bNoPfPUo1Ds5JmgltsmenwgkfAkDguJUtE2uq
	DwbbqJ8IFSQ140b77Y3lrvCE6flHzWmVnCNAK/C2uIMZ1gXpHSs/5Wizv6xerf0ADY7/zh
	9gBisAgFIgILVtq0IK2rQ0vRHLuhZ2HEpDgL0iRreQWA/eAljfLfssmoIQPTVQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Sep 2025 18:00:23 +0200
Subject: [PATCH net v6 1/5] dt-bindings: net: cdns,macb: allow tsu_clk
 without tx_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-macb-fixes-v6-1-772d655cdeb6@bootlin.com>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
In-Reply-To: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Allow providing tsu_clk without a tx_clk as both are optional.

This is about relaxing unneeded constraints. It so happened that in the
past HW that needed a tsu_clk always needed a tx_clk.

Fixes: 4e5b6de1f46d ("dt-bindings: net: cdns,macb: Convert to json-schema")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 559d0f733e7e7ac2909b87ab759be51d59be51c2..6e20d67e7628cd9dcef6e430b2a49eeedd0991a7 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -85,7 +85,7 @@ properties:
     items:
       - enum: [ ether_clk, hclk, pclk ]
       - enum: [ hclk, pclk ]
-      - const: tx_clk
+      - enum: [ tx_clk, tsu_clk ]
       - enum: [ rx_clk, tsu_clk ]
       - const: tsu_clk
 

-- 
2.51.0


