Return-Path: <linux-kernel+bounces-752357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23838B17494
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DBFA8301C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE323C4E7;
	Thu, 31 Jul 2025 16:02:58 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38E2222CB;
	Thu, 31 Jul 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977778; cv=none; b=ohG4/WyxK/ANee3iGRc88ePUk/S2JT9z1xtQ+o/T3lEBMAJA9tp6m+5fOYCFW+OIbJB0HdSLztZ+pwCleaMp8wCb138jhiekVX8XrYejfq4irYdP8VsQ3k5NuOZH+UN3znIcW4yrSAGHofMSw4Df+bgsTzCm8pw9wFZFXiVrv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977778; c=relaxed/simple;
	bh=vvFSZ89Mn/XWX0tfWxb7bhlASEHgl0/ESlWaVfQ48pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMkTmh6irL6Ud23rwGgfwNgrYmKzaCVajcr3oBsxenN2tpC0GdsPqvn8KPLYcaMlVH1cxwyovB62lEO5A3QiDzzwkVPA4Ia1Jq4+sN+GcuLCH9YAJdXSYGU9AZoeZJW8yVyfi82B15II4EWy/kdqF1A+utYfQcpyet33i88oDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id E55601C2719;
	Thu, 31 Jul 2025 17:52:55 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id DD5991C2712;
	Thu, 31 Jul 2025 17:52:52 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:17 +0200
Subject: [PATCH v3 04/16] dt-bindings: display: sprd: allow attaching a DSI
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-4-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Add a DSI output port and include common DSI controller bindings in the
bindings for the Unisoc DSI controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index 71abbc2de8dbb1b674f151a87490c865b187fdd0..7da68eb026b97932515b470764fa3948104db4e8 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -46,12 +46,22 @@ properties:
         const: 0
 
       port@0:
-        type: object
-        description:
-          A port node with endpoint definitions as defined in
-          Documentation/devicetree/bindings/media/video-interfaces.txt.
-          That port should be the input endpoint, usually coming from
-          the associated DPU.
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            description: The input endpoint, usually connected to the DPU
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            description: The output endpoint, usually connected to the panel
 
     required:
       - "#address-cells"
@@ -60,6 +70,9 @@ properties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
 required:
   - compatible
   - reg
@@ -68,7 +81,7 @@ required:
   - clock-names
   - ports
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.50.0

