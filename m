Return-Path: <linux-kernel+bounces-775773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C393B2C4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F65A242DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45BF341AA1;
	Tue, 19 Aug 2025 13:03:58 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877233EAEB;
	Tue, 19 Aug 2025 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608638; cv=none; b=gC9a7qA1ajEx9Bn6tdqpAWawUK/7ZPTSadrEDem7U5BRGv4nTlWoENaAqFUdrhtIec727rdZbPmqRu3Y0u+B82/Emv6o+TkbVOlYV1NHOcxY1MUNerlx2eqNX1saJE5kpehdsGtXog1AvSBxhtqEHoKuvKPHIUOGU5i8iL9oDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608638; c=relaxed/simple;
	bh=OfqnL2+E1D75n5YAXWAM1nn/0jO+tAmxvyYUv+oxEoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW2RryMQGDdGM+hDvlnRkx1U/A3QV66SiuUwoC2lY7W0QrdwtibDPyc49azyVFGdQTOzQleA2nYZO7NA/auVSZYJOQTiCkWdo2nrkLhzBEV90OQfp275BXp/rBH8bQIMdDqWyYLV4bNcqjF7lGQX+KGEPTIo4y7gUFEVM4J62kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (9)
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id 8CC291BE3D3;
	Tue, 19 Aug 2025 15:03:53 +0200 (CEST)
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
Subject: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add grinn,genio-700-sbc
Date: Tue, 19 Aug 2025 15:02:29 +0200
Message-ID: <20250819130231.181571-3-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
References: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
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

More details about the hardware:
- https://grinn-global.com/products/grinn-geniosom-700
- https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc

Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
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


