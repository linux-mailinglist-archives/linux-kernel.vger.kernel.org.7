Return-Path: <linux-kernel+bounces-838767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1ABBB019B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C21927784
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E32DAFA3;
	Wed,  1 Oct 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SWCYSz5S"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581F2D061C;
	Wed,  1 Oct 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317211; cv=none; b=utI2t3P8bm5MzGgMDnL4e19/EHRlKFh7mwpDE0/C33Ca/hKRTFbk2eLveL5l8lIVQUjCy79eZ0sJt1IWAC8lm0uupCnpRRRI63z8hq1t1FbqblFY1HysXNElkxoJB/VylhwmNmmefJYpWxic9f2XbwuJ4sLfu6BhHiPT2LOLMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317211; c=relaxed/simple;
	bh=oS856Sv7qqc6NZ8kQDQSeSOMjUl4B24dYezx24uAEk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1rLZiDM2kPJLYQAllC0PxS/OKYKWhZaLQO4i2kjHIFiR4SFq222a7gjRtoiMRNysoy/NY05NZzbcfTSq7GEMjR5EdQdr4v/YleXtT6H7q9ZRBy9om2ufcnptRa+CjIa8enoxH4EF2bxT8MsbOZj3Ugc9iS1EKLMdGzTVHVwN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SWCYSz5S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759317207;
	bh=oS856Sv7qqc6NZ8kQDQSeSOMjUl4B24dYezx24uAEk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWCYSz5SCYeVRshC+2g71Vcuh91lxVHEFhHf+hQYymfTcTg9Fc5DuEKOegvtTpX0K
	 PZVDM+a2rYVMChKmpzWgK97PPJTC5kFtqM527ZDacaYw7+EyOkdFkiSPh1//euktad
	 4+is0UzGH/yjyp0dX3o+wDxxdwGDbIvY2BpfTijgy312F/3J3PEaeYPC5SZov5RJz2
	 iJVgt5czCc1TLlgb6W0Jk96GGjjx5TdNYzn5C38CFHv6wATMnLZTz4hZO8Oxq8tRq+
	 vcVmzF+ehEAsfQYDrAUF/p/c86vERx4rOfYy1uoXF3CGv+kp6+1pmFcPbCP+PFDEbx
	 0zKK5OYDk+KRw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E6A117E00AC;
	Wed,  1 Oct 2025 13:13:27 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: [PATCH v6 7/9] dt-bindings: iio: adc: mt6359: Allow reg for SPMI PMICs AuxADC
Date: Wed,  1 Oct 2025 13:13:14 +0200
Message-ID: <20251001111316.31828-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When one or multiple Auxiliary ADC IPs are embedded in a SPMI PMIC
it is reachable at a specific address.

Allow specifying the `reg` property and make it a required one for
MediaTek MT6363/6373 PMICs as those communicate over SPMI and also
disallow it for the others (as it wouldn't be applicable).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../iio/adc/mediatek,mt6359-auxadc.yaml         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index 5d4ab701f51a..e685e5ee224a 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -25,6 +25,9 @@ properties:
       - mediatek,mt6363-auxadc
       - mediatek,mt6373-auxadc
 
+  reg:
+    maxItems: 1
+
   "#io-channel-cells":
     const: 1
 
@@ -33,3 +36,17 @@ required:
   - "#io-channel-cells"
 
 additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mt6363-auxadc
+          - mediatek,mt6373-auxadc
+then:
+  required:
+    - reg
+else:
+  properties:
+    reg: false
-- 
2.51.0


