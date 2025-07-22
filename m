Return-Path: <linux-kernel+bounces-741038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B651CB0DF53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11DCAC303E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F52EBDC3;
	Tue, 22 Jul 2025 14:41:55 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926F2EBBA7;
	Tue, 22 Jul 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195315; cv=none; b=Hl9y2BDT1968lwkebeGCLltu7skiQTRWN7B/IkW7U5a/8nW3zOaXr325+Hw0SKKA/v0LJ3m+d+Hc9VIZIWds5lFJX7IX6ih2J4Xy4YWnQjy2mZ1lQTcAYc0SLVyjgE6sGe1zwA1mxApkWGOXD+4rxTeOeqmSoF01ddhCWHx9ymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195315; c=relaxed/simple;
	bh=GQtjtwhiAHhxsilOFnb33SyQQ7Dk0+tF+I/+ltt/DYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DO41n6uGjSmd1/0Zf0y2U5nEXDyAXLr8OFUG80p6OV7PIEPbqn/fkr+WJiBPfOEg16i3sgoas0qEoNlX9iVKRT9LQ/mf1PE/ZYERANrF8e9FY+i2U2py/FbP+FFgP+1BFAcZ9+7Anwf0WegGDRbrzt01u+fyTwvoNpABsuo+uao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 967EE1C06A3;
	Tue, 22 Jul 2025 16:41:37 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id BCD851C0628;
	Tue, 22 Jul 2025 16:41:36 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:04 +0200
Subject: [PATCH v2 02/15] dt-bindings: display: sprd: add memory-region
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-2-054276ec213d@abscue.de>
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

Explain that the DPU node supports a memory-region property that can be
used to describe an initial framebuffer set up by the bootloader,
usually in order to create a passthrough mapping for this framebuffer
when the IOMMU is used.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
index 7f34652080b22e7b7072a709fd390a72375110ef..fa9ad2600f150e1023606898322a1a7b4675bab3 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -48,6 +48,14 @@ properties:
   iommus:
     maxItems: 1
 
+  memory-region:
+    maxItems: 1
+    description:
+      A phandle to the framebuffer region configured by the bootloader. This
+      can be used together with an iommu-addresses property on the reserved
+      memory region to create an initial passthrough mapping for the boot
+      splash framebuffer.
+
   port:
     type: object
     description:

-- 
2.50.0

