Return-Path: <linux-kernel+bounces-737726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53386B0AFD3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9656563B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09805286428;
	Sat, 19 Jul 2025 12:20:41 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2F220F48;
	Sat, 19 Jul 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927640; cv=none; b=sD/2+Qi9AQ39Qj2jHxCB+9lUwOrkSgg4nVfCe+OiiAHIVsbLlwevGOQAsvkMxnHZS/9g/Rp0GbSA7ZBF99SR1QWoChDvtZttvRjFX/Z3hgZSU387EARs+rLxCXc1gyVuDaSHuWi2EgBqn8lG5i5RszTynP+hdYt4WvFhQlkSEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927640; c=relaxed/simple;
	bh=Iq06pj5BoKotABug4YVe1ritLyVyzvXK5w1C7uMNt8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyWUKdN1cPLCxEueOnO2P02s5eGEfRdgT4v3A8OKibjxNWOFZM3IDZkLe1+ynVtfL/HUV7OWV/sq40AehkPneSXC+bNxAlqgS2G83xEfBHwEfPumkBj8xLWfGVuQLNsvbIdJmadvfKilqC8zxgbk/LQ6yfRuqAR82yA9hlMkhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 88C661C00FF;
	Sat, 19 Jul 2025 14:11:28 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id E84721C025F;
	Sat, 19 Jul 2025 14:11:27 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:37 +0200
Subject: [PATCH 01/12] dt-bindings: display: sprd: adapt for UMS9230
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
In-Reply-To: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Add the compatible strings for the display controller found in the
UMS9230 SoC and bindings for a gate clock. Add IOMMU-related bindings
to the display-subsystem node.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../bindings/display/sprd/sprd,display-subsystem.yaml  | 11 +++++++++++
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml        | 18 +++++++++++++-----
 .../bindings/display/sprd/sprd,sharkl3-dsi-host.yaml   | 11 ++++++++---
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
index b3d5e1b96fae2f24ff2afb26c9c3ce0212856be4..d02f79c602f515533f60a993539ed7cd82ce22ec 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
@@ -43,6 +43,17 @@ properties:
   compatible:
     const: sprd,display-subsystem
 
+  iommus:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+    description:
+      A phandle to the framebuffer region configured by the bootloader. This
+      can be used together with an iommu-addresses property on the reserved
+      memory region to create an initial passthrough mapping for the boot
+      splash framebuffer.
+
   ports:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
index 4ebea60b8c5ba5f177854e3a8d89e93e7304e18b..6fedb6e508b247eb71da17ced589b8ed09085592 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -16,7 +16,12 @@ description: |
 
 properties:
   compatible:
-    const: sprd,sharkl3-dpu
+    oneOf:
+      - items:
+          - enum:
+              - sprd,ums9230-dpu
+          - const: sprd,sharkl3-dpu
+      - const: sprd,sharkl3-dpu
 
   reg:
     maxItems: 1
@@ -25,12 +30,15 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    minItems: 1
 
   clock-names:
-    items:
-      - const: clk_src_128m
-      - const: clk_src_384m
+    oneOf:
+      - items:
+        - const: clk_src_128m
+        - const: clk_src_384m
+      - items:
+        - const: enable
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index bc5594d18643010b91376c92a8f235a522d7dc3d..8438d2da0a4277db03e30b13cb270684c0c360cb 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: sprd,sharkl3-dsi-host
+    enum:
+      - sprd,sharkl3-dsi-host
+      - sprd,ums9230-dsi-host
 
   reg:
     maxItems: 1
@@ -23,8 +25,11 @@ properties:
     minItems: 1
 
   clock-names:
-    items:
-      - const: clk_src_96m
+    oneOf:
+      - items:
+          - const: clk_src_96m
+      - items:
+          - const: enable
 
   power-domains:
     maxItems: 1

-- 
2.50.0

