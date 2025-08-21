Return-Path: <linux-kernel+bounces-779088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F4B2EEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F68F3B9213
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7322E88B3;
	Thu, 21 Aug 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ekm6KjpF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C582D7806
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759548; cv=none; b=ayHbNnqueVFH882j8ZA5K2gDJE8KnBkC3PtjV6vYOxe/KlJezjFI6pM1JAI4MaAkxKbWEoYlzu1A0Ny0btXPaMhInBh3jbygLNptnpPD1866naHVdtm6iVc9moQPWdKG2LkpzVDgjoD5Oa5Kl6jQa/BTHQxTUBeeIhNRrqztRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759548; c=relaxed/simple;
	bh=noJnXR5fz5uvdCvAkcNEa1jNmbr6rkH0YiAY8IYmjQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIsElCQak3yn2Shwo03STF1uK3XDqmxKghV4bNmnXK894zi0NjxvgvfvtV9k5ewosEpZiHup9h3QMcKKlw+IwOBe3hfVXRd0ujWvu646cLKHBJ4kFrEJxeQwuNpT4OMHt1alYkIAaVwjKft+po73Xcb1Cv2mYITVfHH/kVRPALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ekm6KjpF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb731ca55so7449166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755759545; x=1756364345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLhC4lsKdeJ9/A2G31nCU/i9ls1OYFW3dx0kccZaDUU=;
        b=Ekm6KjpFgjpZp5ky1Uf9Gw/T0tc6GgFCJlD5Emk8e4yW1s00Wh7x77c3cjJW1jt8cn
         6D5JaHVsUR8WE+2lU8MXZB3lUaxwWzmuvobMWaYgbs02z8T3rh4pphpaRGoM3GqcFRi3
         6JFXFqWoDlDrUubz/z6R24z+hJhNMg8j8eU5YE3sBmUU5VY0ZLJImxjIBJdu/HJYFlg/
         b6aiVSp1eHa6qXwtwmM7uSSVPIAutzwsRTlumw4ZQp2Hv2J7alMQdBwyFjQm2LqfZDBa
         s0sL8RnZ39pvazWmT/Kqrs6sC3tD5VUymh1cT/9sOMz06C24gaPWx+qRx1eGCRfonRaz
         PK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759545; x=1756364345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLhC4lsKdeJ9/A2G31nCU/i9ls1OYFW3dx0kccZaDUU=;
        b=J0/uU1OQ9HfDecEMl7YUhpLgn3Z90cU1bTBOwz7n2nuOoQQMwPab5libZ523zaZZ+Q
         hUvXt6uvDA1hX1MzN2i5Okh/w+EXOP4MMzDOR39QNwDk1RCXnxq4so//bGoqcKdgU7Ka
         5MarNTXi+Mzzbj2FPkW3UCymGjvSR2IJNOVgRLJtyuO8hvlySbl2e2g4EVR56pojnmU1
         k/4mNwTXlsZqbZAhZ2k+GU7pFZ1Ex6v2bBlbD5vrNPqP3oi0v5gP7mtPT++TxrGh1L1i
         IrHaKmLLw8pNuUl4k0EYEtjkNivnoz9z+I1CnZrU6DEehjHwWfE3p17bJ6AOSHHSO2Us
         jYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYaQeO7JbtcFLsk8GEkLURVDXgPsJ1PBUqOC4LrhuHZudq32r08U/eSP+DFndnrvqqSsjYnPaFyzhpPJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNE/1/GBLKkQy3x+8p4XFYP9oe7ZB+JM2R2Cb8ihLiF8j/pY2U
	5birKdIZZplzxNDGFi4AIGUrlnt5vIbk+nokQ/FftMvWiB+U85FdSM9jtiIEHPNLkPIY9imMpEh
	5HpGY
X-Gm-Gg: ASbGnct13GUCvqtsAq2EiaRbhgYzvgtPmeWykmBFTMbUzHF8ODROunVQDuqSBB00PmP
	YMx63BzJWB47EkO6vk3yeyaX6v4ojujy1jUbuphtaCfQ/fkTIpmpPdFyHU9jThEjbIRARIIiffm
	+BUeLbkxDn+dED+39mWsqmsj1a6Dy4WcVglY7QkecKUfdASZJGqLgczGC66UmNk6L3ofOLzfsUn
	stYkbWa/HCwDd66YRouKc2tyIoO67g5+Y0FYHakqvB5BI5QnjFAPf2yZ/sJQlcbOGhAcMRrG7Rs
	nByUyXfa/hh0vpH+DEDwyxMOWsbh9LmdVmftNpyePPgYVRqtRskdfadI5eF56vzOxlGlCMHIzG+
	CQp1Tkc8mOKXSrBBOddULdk437Sf9QS1+Ww==
X-Google-Smtp-Source: AGHT+IEuVTZYnamN/Xowwi1nRdH6LMjKeL4XdJAvBXyBCXh3wYl1BQwHweSgtnWHDmWjFNyCCYNcGw==
X-Received: by 2002:a17:907:2d90:b0:ae3:5d47:634 with SMTP id a640c23a62f3a-afe07e9d221mr56729866b.9.1755759545251;
        Wed, 20 Aug 2025 23:59:05 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf0ba2a42sm296119266b.49.2025.08.20.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 23:59:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] media: dt-bindings: mediatek: Constrain iommus
Date: Thu, 21 Aug 2025 08:59:01 +0200
Message-ID: <20250821065900.17430-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=noJnXR5fz5uvdCvAkcNEa1jNmbr6rkH0YiAY8IYmjQg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopsO0jo7CwTeUi/nTEXn6Hl/cd661HvDUBl1G1
 CoaNqlc6G2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbDtAAKCRDBN2bmhouD
 13pQD/9vTqb+ZSb40TqgV9s9GSHbKX+jREpUaz1Lbl/H9x1SCzuYcFTdKLgx0SBdIv/3/DnkpJq
 vo4NhdsbhEwABDRNfTFkidTninZ4+sOOW9IBkJcd81ceHIlMX/+8FhLS+PaWcfQMGzjmOWO2LeM
 hl1knU+od7Z5A6vy6xOrsQ+UIqs3NPsxc7KkHDjxYdc5HynoLR5dP02syrmBRRvX7A19iy+9RnS
 ZeW4b4suXJhVRt6Bp+OT3EGGuQxXuJ/lmlt5AX+5b/lYeUkw1+WQSRJDDEpl/7zgoQODT35oveh
 kmYdjWLaxjh6T99vUluCdHMm20oVUoiF1ESlZ+juv+2wkQ83KrC7H6V4mh24OywQu+omV6FXXgS
 UkP1ZpMX318tChOvSCx+Flh5W66b+1NAfDyq4eFJzqJsgd8BUj4HP7AXPZtEYZWUB+TlxW58LVY
 AUqfnNxQKwMp4in3IYO2O0a7/ybRfGUOBxTzYITO4PWbHZq3ofmPG1GG8qayMt9OFJbDjBP/gUb
 IxShcYENueZ0YrKLb82fSGXqRGhcfnFNr8AB8APcAIjlUg40iWE9ySR+DnZagKj74puDbphzG0Q
 iUyzR25u2kDVdGOnM5FcwTuUYBApUdObGTvJlNtxmoBzWfuZ6LQyU4DO3bPoiltiVSoKKt3AQlG vlGi4hhxJqNiBxQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Lists should have fixed constraints, because binding must be specific in
respect to hardware.  Add missing constraints to number of iommus in
Mediatek media devices and remove completely redundant and obvious
description.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Ack
2. Mention dropping description
---
 .../bindings/display/mediatek/mediatek,ovl-2l.yaml           | 5 ++---
 .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml   | 5 ++---
 .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml  | 4 +---
 .../devicetree/bindings/display/mediatek/mediatek,wdma.yaml  | 4 +---
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
index bacdfe7d08a6..ac0d924a451b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
@@ -45,9 +45,8 @@ properties:
       - description: OVL-2L Clock
 
   iommus:
-    description:
-      This property should point to the respective IOMMU block with master port as argument,
-      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+    minItems: 1
+    maxItems: 2
 
   mediatek,gce-client-reg:
     description: The register of client driver can be configured by gce with
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 4f110635afb6..c0fd0a91c4d8 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -65,9 +65,8 @@ properties:
       - description: OVL Clock
 
   iommus:
-    description:
-      This property should point to the respective IOMMU block with master port as argument,
-      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+    minItems: 1
+    maxItems: 2
 
   mediatek,gce-client-reg:
     description: The register of client driver can be configured by gce with
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index 878f676b581f..7e5234def39a 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -64,9 +64,7 @@ properties:
       - description: RDMA Clock
 
   iommus:
-    description:
-      This property should point to the respective IOMMU block with master port as argument,
-      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+    maxItems: 1
 
   mediatek,rdma-fifo-size:
     description:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
index a3a2b71a4523..276868c0fde7 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
@@ -43,9 +43,7 @@ properties:
       - description: WDMA Clock
 
   iommus:
-    description:
-      This property should point to the respective IOMMU block with master port as argument,
-      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+    maxItems: 1
 
   mediatek,gce-client-reg:
     description: The register of client driver can be configured by gce with
-- 
2.48.1


