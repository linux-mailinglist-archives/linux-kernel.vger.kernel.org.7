Return-Path: <linux-kernel+bounces-771163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE2B283B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45508189885A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2063093AC;
	Fri, 15 Aug 2025 16:18:08 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F51E0DFE;
	Fri, 15 Aug 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274688; cv=none; b=mUkcZs0iwjNzo+z/l8qt7RJxF3Z5/1ugLH7z39mUIRiAS0+FhzerjFCVbJVfDau2AgayEthwetKUr47sO5Y/kinJdBUKaT3egz3QOQPb96Fzd+AyyKe2hrbeiabRVJC3oj9cZE7Ei0T7Dz6kFyAEe4gZ80xjV2xHDfKBtQRGDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274688; c=relaxed/simple;
	bh=HCfVRSceZAPnThZauVgJtYw6qy8MCTUsTQwuABkZKxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCVr9wgEiaAMQFWpv8jonLAGcyBbXy6y1FSxib+VJci/bbGXEmmeifB6PwE0hewh+TMEa95ZFqc3d2DAQOETLZRYOakavXpGBnirK/rmtmkbqimNfDSWrGJMFmmn5nDeW2mOFFqLzadt4vlo+7ipYBdrl0bDMEDs56WLhb9KIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (8)
X-Spam-Flag: NO
X-Spam-Score: -0.637
X-Spam-Level: 
Received: from mateusz.grinndev.ovh (79.163.192.75.ipv4.supernova.orange.pl [79.163.192.75])
	by server220076.nazwa.pl (Postfix) with ESMTP id 6C3701BCF24;
	Fri, 15 Aug 2025 18:10:31 +0200 (CEST)
From: Mateusz Koza <mateusz.koza@grinn-global.com>
To: angelogioacchino.delregno@collabora.com,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com,
	b.bilas@grinn-global.com,
	Mateusz Koza <mateusz.koza@grinn-global.com>
Subject: [PATCH 2/4] dt-bindings: arm: mediatek: Add grinn,genio-700-sbc as a valid platform
Date: Fri, 15 Aug 2025 18:08:35 +0200
Message-ID: <20250815160837.371592-3-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815160837.371592-1-mateusz.koza@grinn-global.com>
References: <20250815160837.371592-1-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.48
X-NA-AI-Is-Spam: no

Add device tree bindings support for the Grinn GenioSBC-700, a
single-board computer based on the MediaTek Genio 700 SoC.

The new compatible string "grinn,genio-700-sbc" identifies this baord in
the device tree bindings, enabling future board-specific adjustments if
required.

More details about the hardware:
- https://grinn-global.com/products/grinn-geniosom-700
- https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc

Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a7e0a72f6e4c..ad7fb85e3559 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -431,6 +431,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8390-evk
+              - grinn,genio-700-sbc
           - const: mediatek,mt8390
           - const: mediatek,mt8188
       - items:
-- 
2.43.0


