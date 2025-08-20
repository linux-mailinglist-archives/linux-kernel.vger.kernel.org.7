Return-Path: <linux-kernel+bounces-777642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D975B2DC22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655325C66E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA632E8889;
	Wed, 20 Aug 2025 12:11:02 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A48283144;
	Wed, 20 Aug 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691861; cv=none; b=MzbX8VI151/Bzk40wE3pixYAvbcQXFwc7Zy07dBfMKpgmXMG/kbGly0hjKz+bcFo85Ad0oj0MG6DZmnnO9bVmHcWorQg8YEPm0ILlq6YcN42F41kvmVjUpsBOnenRBX3nS0L7R+djpVXgzAukVpZF8jIQdUH1wl1vSYgKYcAZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691861; c=relaxed/simple;
	bh=jXW+66wEVlet3JZ3VSTb+m0k/1E3nZ8APb+V3lX1oZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIo/Qi7qurSf6/S0ti6+clyyDgP/qQS3a6TyxG/sK4MdJiVg9XuEHvo8swuQ1O9aPkMlJ7FjTkjCftLH4Uh2JvJljTBYeuuO6RG8rdyId0gvrWuHJ+R7Kyr4BdehOtyUDcrLLJt3lhKRCJY87joLSQ8qJf6rbAOyj3odXyRiR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (16)
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id 9C91F1BDD64;
	Wed, 20 Aug 2025 14:10:56 +0200 (CEST)
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
	mateusz.koza@grinn-global.com,
	andrew@lunn.ch,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add grinn,genio-700-sbc
Date: Wed, 20 Aug 2025 14:09:03 +0200
Message-ID: <20250820120905.993189-3-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820120905.993189-1-mateusz.koza@grinn-global.com>
References: <20250820120905.993189-1-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.50
X-NA-AI-Is-Spam: no

Add device tree bindings support for the Grinn GenioSBC-700, a
single-board computer based on the MediaTek Genio 700 SoC.

More details about the hardware:
- https://grinn-global.com/products/grinn-geniosom-700
- https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc

Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a7e0a72f6e4c..122af0bad141 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -430,6 +430,7 @@ properties:
           - const: mediatek,mt8188
       - items:
           - enum:
+              - grinn,genio-700-sbc
               - mediatek,mt8390-evk
           - const: mediatek,mt8390
           - const: mediatek,mt8188
-- 
2.43.0


