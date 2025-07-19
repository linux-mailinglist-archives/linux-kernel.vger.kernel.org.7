Return-Path: <linux-kernel+bounces-737728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E526DB0AFDA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F58B565825
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854742868AD;
	Sat, 19 Jul 2025 12:20:41 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479E285CB4;
	Sat, 19 Jul 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927641; cv=none; b=i5odBM5AhoFMvc1iearG/7hQlWqFI0zvBM3n4YVgcepokXd1KInfwFaZJNL96rkTv3Us60WYXdJStsb8FTnSjMR5ZQt74Z9KLIKNc12zOzM59l+Db2Oh/R0bd/9f6/5THzHdb67Yndetg6JMYbB7JTRW0lksPibThhg2EL90Nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927641; c=relaxed/simple;
	bh=1M3u83jrpW6a7CtuwC4lCQ3tVKRNAt9Pdwr3OkRHSDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSDwdMbb6NhyZM0sORrjsbsCuc4EeOdp2olfHWm2RDNN8HLFCC6iJalKQ5IMiY2XDxj02GiStv+PzcAhTQ7FdaWJloFaH5hNIBRVtrDiYfAPoV5Rj0L7vvvJgkXAXY2HA+wKAvGehrmZ5mlia7l0XWWGcYCaPqdo3t4eJSu00tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 3EF061C025F;
	Sat, 19 Jul 2025 14:11:29 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id 977391C0628;
	Sat, 19 Jul 2025 14:11:28 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:38 +0200
Subject: [PATCH 02/12] dt-bindings: display: sprd: allow attaching a DSI
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-2-e4344a05eb3d@abscue.de>
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

Add a DSI output port and include common DSI controller bindings in the
bindings for the Unisoc DSI controller.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index 8438d2da0a4277db03e30b13cb270684c0c360cb..d9a77f7228e145b955b57746967e08e56f5a0c89 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -45,12 +45,22 @@ properties:
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
@@ -59,6 +69,9 @@ properties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
 required:
   - compatible
   - reg
@@ -67,7 +80,7 @@ required:
   - clock-names
   - ports
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.50.0

