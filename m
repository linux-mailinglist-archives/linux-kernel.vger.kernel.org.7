Return-Path: <linux-kernel+bounces-748205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F9B13DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57E617E0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6F2701DF;
	Mon, 28 Jul 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="B1p6GydT"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8126B093;
	Mon, 28 Jul 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715261; cv=none; b=QX3Hp+mQ3HYGJG38ggIrdJ335K76xxZw61Zh+Uq9ANQKPVMRTUBTTAV577bm/iu+QligrBFU9koSQbC+TjB1Ccv5baOF0KsMBtiFt9iOb448HzqGVitp3dK0bwrA9F+fUDRtS7SlT7wYiUZcV4H7ltWMxVXx5p15GoIt+TKDuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715261; c=relaxed/simple;
	bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2fcNmmDgtXSn2lRu0V62wImy1ZT7qdN6T/RS+iW4pwoaNEhOZHZ6bICQ4TirK0go49h/ZrfGQ9COHYAnIv2hV2lmOnjt1Jy4LfmNFyU+4S4H92gj1lpmtzgT37FdFH7H4ioRlBUn7fbJhEzbkvku3fUmfUxYNaiA24mBTI9mAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=B1p6GydT; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753715258;
	bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B1p6GydTvvV9IUlpvSF7BW+R/jZiJLDJk1X1ho3uJX91QeIXLtHkm2SOWG/BbP152
	 QVSm2nEzgp0cygItof5QokKepy/Jr/fbhGeGaSH4AN96S0GLoQ7ZU7qUAsQSm7y1+z
	 uc8x0xjOjv+mdqGXlm1WeSvR9A+Wk1md4bPfrrQdaj1zxtgi7RhGNQ/fAYw0s71GMU
	 KHH5RQ1G6UnMrLqVFr37jTzAKendrQdZkPrJoChDMTIhugh0THUQJKQkuC0l/lNQR8
	 7vRz6JQjMFxBdumHfY8Roak1PvqFA2mbOwyq9LzfHaDt7yxGzOhhZGI2AKAe/jRSZd
	 izplVda2lQRZQ==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:31ee:da95:eea2:34e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 89C9C27E83B;
	Mon, 28 Jul 2025 15:07:38 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Date: Mon, 28 Jul 2025 11:07:37 -0400
Subject: [PATCH v5 2/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-linkstarpatch_v5-v5-2-b4ebfeaca652@tahomasoft.com>
References: <20250728-linkstarpatch_v5-v5-0-b4ebfeaca652@tahomasoft.com>
In-Reply-To: <20250728-linkstarpatch_v5-v5-0-b4ebfeaca652@tahomasoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753715257; l=1156;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
 b=jS97AuXubreofn2GtbncJNoEvjWPnHULAnjzCIRTJUVzrXRw9PovBHcnUMte3OHu7lrCE5xGy
 fiSEuxE9MBCANt9dIS6FOxBWnR2t3mw7teMzKH/HlgtZaD33TY7IVlY
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


