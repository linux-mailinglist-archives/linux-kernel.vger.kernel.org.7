Return-Path: <linux-kernel+bounces-741036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1EAB0DF40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640141AA5C53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A02EB5CF;
	Tue, 22 Jul 2025 14:41:53 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9E2EAB72;
	Tue, 22 Jul 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195312; cv=none; b=Lj4vR9r5q4fgYDjWG6Jr/YIvI4b08tuacc8XFXw27Nn5pl2QOzG9lgYIZrc93YHF3RLVetRBA5VFLwgnbp/UjLMVNsavQj23j0Lezsf4zCDZdvH56ONqRn0uJaqjXxQV44mRZJwG8phxDjIK8CQAI0rfhgdq1psPSD4WlTCYqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195312; c=relaxed/simple;
	bh=+uDn6Yj2tcWpraUp4cLZYLTfXtcnW2kUMb7gnuzL2Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFqrb/DdCLs/aKPfKUuPy67P9/p75c+pfVuXpm0k2XhFfenicxQ5tIrKMXzNAfbEPz5JOinJzah1Y6z9q02B9CT4a8plodx18wGJ6iI1ttCSDG3DNvjC4rbmOQuWib5jKZ5LoWzJA96q4z/iImxbWyFaTr8GwNJ9w3K8QrFcKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 77F6D1C00FF;
	Tue, 22 Jul 2025 16:41:41 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id 679421C0680;
	Tue, 22 Jul 2025 16:41:37 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:05 +0200
Subject: [PATCH v2 03/15] dt-bindings: display: sprd: allow attaching a DSI
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-3-054276ec213d@abscue.de>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
In-Reply-To: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
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

