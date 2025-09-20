Return-Path: <linux-kernel+bounces-825588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00AEB8C46D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF1B164517
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC02BCF6C;
	Sat, 20 Sep 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI7iaOMq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF529AAF3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360387; cv=none; b=M+kiCdLInMZnXHgydonbmZoySygyJjNMMk3ZFffiQDtxnVAZ6lOH8+iANl3rHvuDZ6GIkDz3esyNee5li9QTQxI2rs1TDe6PwFpogiT2ICIhyC/TL+UzZfdkEGaYvNC2WSRszQis8ZmFCm2QFtWNFBXpe+WOf2wOyFcG2AiOBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360387; c=relaxed/simple;
	bh=3BbqoSmJ0NDplQL4bxeVCOWydY8wpQLkEvYPPE0msBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cULRHYap4KfLP92DLXSSEuqkONvq7pU8TubcvHBrrXk48jfAOmlkwTnLi/JlbdMARzT6XLIobnmP1fZO2J8TzlYBH4uGis1Zsrdvv2TDPT6k98SZ0TrDy6Ahj4T4bz9BrnnbI/UuNA0f416XoE3UOTtzxA42Q5YEr+G4XX+LhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI7iaOMq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so26084505e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758360384; x=1758965184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xEwCQ2kLx4wO4jHEqwEMPS8Qvt2FpFOtZT1uSLzl+Q=;
        b=KI7iaOMqe+xxTX6AyO+chI2Bxg2X8bt8spl//ofkjdJlQhAXKc9kWh+u9hO+haSDln
         ct2PM/s6DYbh+1eAFrZELJ0oc8DH/vv1vN0/ZJb8WOib6YRmCn1db+2ze0V6BWvoqpch
         2VLv46/blZO4vlWx3FOiT65e/1BjbWJtFo8me+Z+FgiDK6P2KfRI0+JF/wDT5nzlpGRy
         qsG5BVIUna5h2u8O069dX2Jkh6zftqk3+nocfdF+PG9pOYpDhOs7qJeX7KNYwe2Qrhoc
         5R0ifLRgXMLyrGhRK2zR2s1vfQ8SydZ4TQZBULpmV1fRKhNdQ5wssA/MjyaBTSvTstzP
         7+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758360384; x=1758965184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xEwCQ2kLx4wO4jHEqwEMPS8Qvt2FpFOtZT1uSLzl+Q=;
        b=kBZm9LDpiozqhhnf9g0flglxep0WuJ1+BpgbKxPo0577x/l1N+iaK6G4QpkL5rGgLX
         YLzPahQuzv7QyZu73OfRUcDgeeRuIT5tVij614R5FC8akOc2DEf2g1FlBR2lHW+qdTI8
         ZBZLA4eeeWeyeRRJrblWJgSApr/S864ah3nFBfqU8/A1JnNQ9Ml707h8FPho5sAH1ES5
         DzHed3HS0Fi87D4wiLVZ2TtpYz6yTp4MrAFHlGwsTG+ddky76oxZh6Pjfyn883DMFTsi
         5qiTZpkzE8kDG/IY0VwAsMsQ4FcKkapIBSquN/Uk27GS1oX6yWyYHH2fNmfLLuZ0hWi6
         6cEw==
X-Forwarded-Encrypted: i=1; AJvYcCVSzENshzG1jKh5dCRTfqrQtxgqv3xmIGBYSAmPokZMsDyTfhDhyfbnUP35iXgvOs6A56t/uz3sHeCNPNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQ5o0hk0NaBRBPWsU8zojE2O12QC1RKCZq2SQSoDC6OfAilvg
	9fNPjRvv/kHKKOBM9/oC2RwGC8THP7URq+55pkLyZ+9m4gBB0NulAp/0
X-Gm-Gg: ASbGnctsGPt7LtXfzm8Rt9eAXVgsef3WwQ1rW0DKH9OmATMiw7dn/+xLvuASQR8aeF1
	y0nBXuEKcQtRNAWrQW8OPLXZF88VAyso66WWrSoHYa8OtT1dwLRuzNjnZ1OirmhJx/rilLBr2kS
	HIy2Rzs/QCXQeG8aJmRryXUlX2zeoPqSUbYIKEMR8ZefhJtAIKq2xsyx5ZkzSUMnhkOrWzeUUsg
	fERPUoRvO1Mf28ShPx7fnwItzGx5hdXsBLyYVOJJUKvA7pZ0K9EMBz1EIdPZ7H5v28iKuBr7kv+
	TbFvzR64EEgi4pe+whkTzas/ceDYXZidsf0qjhTG2MuNlc1eHn3coZPUnM9cA2uN4EVeBrE8I+s
	xZUka7FXh5/RRy7SYu3j9ldz1VQoE3Fs/EmE6AKgWnlPiqNEahDtGgprDrdTzReXSfgpBN3M=
X-Google-Smtp-Source: AGHT+IFxlAXSV4W5++7XWnPzZ12JWvBKJO7xkpt1cyOakCo8rv+0InqQQYz6OthfTBtMJczwkWlkVQ==
X-Received: by 2002:a05:600c:43c5:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-464f7027ee6mr62778095e9.4.1758360383862;
        Sat, 20 Sep 2025 02:26:23 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm73648535e9.0.2025.09.20.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:26:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for Airoha AN7583
Date: Sat, 20 Sep 2025 11:25:34 +0200
Message-ID: <20250920092612.21464-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
binding.

This differ from the Airoha EN7581 SoC by the fact that only one Gen3
PCIe controller is present on the SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 0278845701ce..3f556d1327a6 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -59,6 +59,7 @@ properties:
       - const: mediatek,mt8192-pcie
       - const: mediatek,mt8196-pcie
       - const: airoha,en7581-pcie
+      - const: airoha,an7583-pcie-gen3
 
   reg:
     maxItems: 1
@@ -298,6 +299,26 @@ allOf:
             - const: phy-lane1
             - const: phy-lane2
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie-gen3
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          items:
+            - const: sys-ck
+
+        resets:
+          minItems: 1
+
+        reset-names:
+          items:
+            - const: phy-lane0
+
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0


