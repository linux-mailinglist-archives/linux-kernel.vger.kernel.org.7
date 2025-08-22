Return-Path: <linux-kernel+bounces-782181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4EFB31C67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C62A1D4211D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABEF3093DD;
	Fri, 22 Aug 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rYljASOn"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320393054F4;
	Fri, 22 Aug 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873502; cv=none; b=bsca1QCw4Z98idf/9LWLpyGFhxBT/Jf81hRbUI7Fb7wHQwxvzX+0OsddI3i2CmM8rj0ZRyel/Qqtq+yGDIjP0Q8ifj3m+EVhX2ZFncqBbtA2LkOTawcwe0UBA+Fpot7ImPtdTii3tBpaVTGgvCfKC2o2Yp6GbNWRS49zbYdp+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873502; c=relaxed/simple;
	bh=MXPe2LGtvWgtIXzuXImiBeNnO3kSJn60L1tgMiATbS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gSggbmAHk7YciotgzQIxJJLQa1tUcXMJzUihmqXO/qwaHjrIcEqYuv5cVDAwABz8QQL8Lm8A7bFroiGrgPT9owPUtU4cOzxc+9lapWMws2q5A8OQURfZsn8vhsx5hG8XLW5TbIwjMFJON5Pcn/NuQ6ZhIppjpxHiWNaaGgv/qD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rYljASOn; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MEUQMT026394;
	Fri, 22 Aug 2025 16:38:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0/DWalJdpRTzR41GI/7nr5IgJdjyXkVRYmOi2yrQ+OU=; b=rYljASOn2oBk5+sC
	T4oMYk1DxLu7f/HUgIgi1M1Z5TlJvH3MDSkM7JmI0Y+p/5rB/jPVrG0cU/YEoFkh
	gN9dy45R1g4IAMlmpRwnAPY9qp/cCZUoU1UAf41dQI2R7sW7xkQ+lapYyTjoLECZ
	i4NNVr6RIiKLr/EdxpO65Wj5YsERo0E2XE51bdEI/nXyFXaY4rTyvpYztLLVuUYE
	gq4MkYVhcbVyg8miTYiXMlE9pN5FczI6Zij6nN72B//ptRjESsGbsa9QYCAvRaZq
	L2RSeJsPSP7kQwuZLeZZIUOBK7KJQPMKi9HqkYQpRKAzo/v/5ZaRwZG/FRp91f9U
	ax9Jfg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48np7n7hna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 16:38:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AC204002D;
	Fri, 22 Aug 2025 16:36:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2C26726C8B;
	Fri, 22 Aug 2025 16:35:49 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 16:35:49 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 22 Aug 2025 16:34:10 +0200
Subject: [PATCH v5 01/13] dt-bindings: display: st: add two new compatibles
 to LTDC device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250822-drm-misc-next-v5-1-9c825e28f733@foss.st.com>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
In-Reply-To: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

The new STMicroelectronics SoC features a display controller similar to
the one used in previous SoCs.  Because there is additional registers,
and different mandatory clocks it is incompatible with existing IPs.  On
STM32MP251, the device only needs two clocks while on STM32MP255 it
needs four.

Add the new names to the list of compatible string and handle each
quirks accordingly.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 .../devicetree/bindings/display/st,stm32-ltdc.yaml | 52 +++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index d6ea4d62a2cfae26353c9f20a326a4329fed3a2f..1233345a16307532ea08d3686d194b486f897ea9 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -12,7 +12,10 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32-ltdc
+    enum:
+      - st,stm32-ltdc
+      - st,stm32mp251-ltdc
+      - st,stm32mp255-ltdc
 
   reg:
     maxItems: 1
@@ -24,11 +27,16 @@ properties:
     minItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   clock-names:
     items:
       - const: lcd
+      - const: bus
+      - const: ref
+      - const: lvds
+    minItems: 1
 
   resets:
     maxItems: 1
@@ -51,6 +59,46 @@ required:
   - resets
   - port
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32-ltdc
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp251-ltdc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp255-ltdc
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          minItems: 4
+
 additionalProperties: false
 
 examples:

-- 
2.25.1


