Return-Path: <linux-kernel+bounces-749498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7CB14F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E881739DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8E11EA7FF;
	Tue, 29 Jul 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="YL70pwJO"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888C1E5B7C;
	Tue, 29 Jul 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798392; cv=none; b=d1yPZnUqZnEMnTiCDnNYQOTulVtUG4+g42smMjIRNRthA1lVZpk8RJA+5DtCmI5TSt1RhRLg8wU5PELvA9546RdT2vWLZ0IKa8QQ71Bz6Np2G35Q/W8FQ1bQTMhBnp3rime0RpyvLJHGfxEMG55UPaBS/l845GPVrYxQ14jQg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798392; c=relaxed/simple;
	bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDVxLhcuhE+eXVSwpokIAYqgOmbx8Bvrev+x6gUX6nWEn+qfp93nJukqerCpjc6Y0G2O5+NV58ER1T91VDhoOyGFXsbQ2tVv3V/d4AkKzQlVjXsC0m5mWDobjab/y8N0M8jfAC6hwJfCQABb/FPn2THKJzEexPGw2JEeWIFZqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=YL70pwJO; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753798389;
	bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YL70pwJOsDCpSxk4op9E+eT1wSKldmoqDqqiCA/0mDb1GYnPXiz5iPkyWkb/R5sj9
	 Wk+0A21JR1onGEK/O2+yK9BIuT4Iq27XNEwfy51x7oOgK1zq7DlJE7eoKrBcBCDzhy
	 inzb3L9xzO55O+89AzGrmWqDM2rYshsgcT9ko1lz9dV9nEMdiDU7XzTCSWLrUGl/yY
	 6YXaTth+JsQ0mG3b5+eeNOX66ii025d5aHH365H5epjVBqvnE3rclYzQk5p7mK+Yzi
	 LycgTER4BY0ovX5DMpxErDmYIlSaoEBME71UN+K8WA6Fy2yBz4HyMWEZyrtzwNM59P
	 aIToghxOd8MjQ==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:f717:c76f:99e7:4a24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 42A5B27E5BC;
	Tue, 29 Jul 2025 14:13:09 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Date: Tue, 29 Jul 2025 10:13:08 -0400
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: add LinkStar-H68k-1432v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-linkstar-6-16-rc1-v6-v1-1-8bd4a63f343a@tahomasoft.com>
References: <20250729-linkstar-6-16-rc1-v6-v1-0-8bd4a63f343a@tahomasoft.com>
In-Reply-To: <20250729-linkstar-6-16-rc1-v6-v1-0-8bd4a63f343a@tahomasoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753798388; l=1156;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
 b=tARn3W6lt3nbuLKB2vfw2BkcTiD8JeYj6twPTbrtRWbzkS8PJs/YEKxAans8QvmfVPhQUdDwQ
 nIx3iISXULeAldGH4gfFhPpwd1Vu0X8VC08kfb91/fPq3wlPEQF2Sit
X-Developer-Key: i=xunil@tahomasoft.com; a=ed25519;
 pk=FTZVGUexvkWb4j8v0wbtm7CtJLijIAaa5x0XV72WWC0=

Add device tree bindings.

This device:
  - Is a single board travel router made by Seeed, using an rk3568;
  - Has four ethernet ports;
  - Has four USB ports;
  - Has WiFi (MediaTek MT7921e);
  - Has a real-time clock (rk809)

Signed-off-by: Erik Beck <xunil@tahomasoft.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5772d905f390e53b44f9093d32b869a7e0655db6..7f3904b69293f31fdd4f6080fab5ce054c1abee2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1109,6 +1109,11 @@ properties:
           - const: rockchip,rk3588-toybrick-x0
           - const: rockchip,rk3588
 
+      - description: Seeed LinkStar H68K-1432v1 RK3568
+        items:
+          - const: seeed,rk3568-linkstar-h68k-1432v1
+          - const: rockchip,rk3568
+
       - description: Sinovoip RK3308 Banana Pi P2 Pro
         items:
           - const: sinovoip,rk3308-bpi-p2pro

-- 
2.43.0


