Return-Path: <linux-kernel+bounces-782187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC30B31C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE37FB41313
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C391312828;
	Fri, 22 Aug 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qQv5DmjA"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3146309DA4;
	Fri, 22 Aug 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873521; cv=none; b=dQLD1BQBj6M7zT7P4vQ9dYvYiZOgXy73TKBUBKq0J39urmoWhB8ih0Ec5YElNpo5stu2lkEW3dzgbX8EEIyypeuZhZMY9W3al3yPLoKAXFSJWSWorIUkyAgqK/wcBYo1HZwbP1634Gy31yrsMjqu78sX62Awd4zj9cRhnG2O+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873521; c=relaxed/simple;
	bh=nmhXVd1DYktVVEsH4WqGhsibFXNm+0rnlU8on70XjoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iom0G4BT6fUc4G9e4erJa+Cr1So4fwvDy5zP6riu+YwVAJvQWjyxAjXWYtStVGfw8DR98Gak3eP2FqA0W4FrUw/uXdc6RrG6Qf5DACiMylPW3Z+LEdPdQEKJcMyFWyE0772Ov/va3/ESclCc6LTTn8bmlbi8SttGlYc7fCC70zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qQv5DmjA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MEXa4U015372;
	Fri, 22 Aug 2025 16:38:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	63KYvJNL4tqb9W50rpUtT3l2hlYXYEYhSRYlan6wZT8=; b=qQv5DmjAUqAibjCL
	GOkys2hAZhKjsw5d1NH+1IcCH+++Cuu7g4A4+gp3DAeZfn2sm4je6sN5nYxAkhnC
	gmfdX7iYQb2TKjnhuARixBh6JnQzrvNg62EvbarBWevzWMEd1xsmMr4R0ih26UVK
	62uO330NYmdYWeAHjpwaEdfy9jDHHe3GBKgWLlxvzuiLP/983pheGJFiA3t4J7Z/
	zMxHFtwbsJZEk110nLiDtZ0MxJgwXKHBE4szqwUoXFXMhm5TdHVcAKe0osaUE9gL
	qZYlUzMI0dJhKk+Mw1fxCnmOFU3Hxduh7qYW1fD9ENcQaiA3C3W5DTC2bXgGSr2E
	PliL1A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48nj3v8jg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 16:38:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8D84540047;
	Fri, 22 Aug 2025 16:36:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D04F6726F12;
	Fri, 22 Aug 2025 16:35:52 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 16:35:52 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 22 Aug 2025 16:34:15 +0200
Subject: [PATCH v5 06/13] dt-bindings: arm: stm32: add required
 #clock-cells property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250822-drm-misc-next-v5-6-9c825e28f733@foss.st.com>
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

On STM32MP25 SoC, the syscfg peripheral provides a clock to the display
subsystem through a multiplexer.  Since it only provides a single clock,
the cell value is 0.

Doing so allows the clock consumers to reach the peripheral and gate the
clock accordingly.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index ed97652c84922813e94b1818c07fe8714891c089..95d2319afe235fa86974d80f89c9deeae2275232 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -36,20 +36,31 @@ properties:
   clocks:
     maxItems: 1
 
+  "#clock-cells":
+    const: 0
+
 required:
   - compatible
   - reg
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - st,stm32mp157-syscfg
-          - st,stm32f4-gcan
-then:
-  required:
-    - clocks
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp157-syscfg
+              - st,stm32f4-gcan
+    then:
+      required:
+        - clocks
+  - if:
+      properties:
+        compatible:
+          const: st,stm32mp25-syscfg
+    then:
+      required:
+        - "#clock-cells"
 
 additionalProperties: false
 

-- 
2.25.1


