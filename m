Return-Path: <linux-kernel+bounces-597922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE4A84054
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC16CA029F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853926FDA7;
	Thu, 10 Apr 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="l0VBSWcs"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CE26FA55;
	Thu, 10 Apr 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279576; cv=none; b=Bs14Mn3vfALsNoPDgct0jy6T7BS5ON0zRm91eMzf4oo497K9CKik8c4EPQpumCmyf8ksj2J5WzyuROY5lz21HPcrA7LHS1jCy/mNc3BD+/7XaMvqIGKJbvv2rgcgpyGTwJ9jsaTyZxzT5euIY0YSLUcW9wW4Wk7NV92pkIZERNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279576; c=relaxed/simple;
	bh=r4g96eIB3F0Ej2CP2UOb4gJ49MPYVlDJTKJSB1BEz78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FyiopI1kbfXEvHT28aB+4iZZHY/w4z3RCDP3GBLUIr3FdSYSd7FAoeTEK/pwnQHFjN34zgMjDzDloV0LfJFIn+151iz3G84jERcLTo8u9cQtecSOrdtYxZTfclxzZNDT+Q05o5nUHIo7FA6tEr5w2fEUpmCgbM/GltyUT32jcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=l0VBSWcs; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A62MMC009620;
	Thu, 10 Apr 2025 10:55:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=l
	4mfVcj7wulHooXN1HGbxSa2Hp490XhlWMnTdmNMVKg=; b=l0VBSWcsWNi/f788R
	cLKiEl1VfYDvX+NEETaaKqi9X/VPO4LfB9acB6LOGFEDpRgPHcC2iT8bSBjwZDQL
	3aL+JCkmowxU+JMHt/YZcBt4CumDF2E4vJh+dKlDN3ykFEfEnycJRmiE453Vk0IR
	7Cucrxmm4z42G2mSl5Y4T2rNtnN3TUBu399CSAycY+vyYSmE4ua3sib1MrxM3HFP
	1MJ0YIFg2Bm9Dhj/TNuS/N2qUIogavRKUvQDqVm/XOMRq3SrHkk9aJtGOu7rzmNy
	jvJvlQO2CPIWsI2sxZtjAspPc8eTQuB+2AKN5+vYqrN3uIeyWGTbxH8gCq8vrIo+
	EFgWQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 45ttssbgdy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Apr 2025 10:55:18 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.134) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Apr 2025 10:55:16 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 10 Apr 2025 10:55:00 +0100
Subject: [PATCH v6 01/18] dt-bindings: gpu: img: Future-proofing
 enhancements
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250410-sets-bxs-4-64-patch-v1-v6-1-eda620c5865f@imgtec.com>
References: <20250410-sets-bxs-4-64-patch-v1-v6-0-eda620c5865f@imgtec.com>
In-Reply-To: <20250410-sets-bxs-4-64-patch-v1-v6-0-eda620c5865f@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Michal
 Wilczynski" <m.wilczynski@samsung.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6083;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=r4g96eIB3F0Ej2CP2UOb4gJ49MPYVlDJTKJSB1BEz78=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaR/n9oQ4Htu1vqSyRsNDZZe1FvbnGcaODnmQLFkaK4m6
 97ZBxxTO0pZGMQ4GGTFFFl2rLBcofZHTUvixq9imDmsTCBDGLg4BWAiBccY/nubH2OS7nWO2Ou3
 kkHl3rWZFlPt1nOkqMs6nf9mGn66wZPhr5j7tnsMq/Z4Ld/2/t99MxHmW+qKGl28T0w3mz8RqDj
 /nxsA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: Bp90uCspDQJ5ks7B7UwG89ccUasIeC2s
X-Authority-Analysis: v=2.4 cv=I7hlRMgg c=1 sm=1 tr=0 ts=67f79586 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=UtEzwyU9vMAA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=KKAkSRfTAAAA:8
 a=w15EKZF3e2A1P0N44N0A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Bp90uCspDQJ5ks7B7UwG89ccUasIeC2s

The first compatible strings added for the AXE-1-16M are not sufficient to
accurately describe all the IMG Rogue GPUs. The current "img,img-axe"
string refers to the entire family of Series AXE GPUs, but this is
primarily a marketing term and does not denote a level of hardware
similarity any greater than just "Rogue".

The more specific "img,img-axe-1-16m" string refers to individual AXE-1-16M
GPU. For example, unlike the rest of the Series AXE GPUs, the AXE-1-16M
only uses a single power domain.

The situation is actually slightly worse than described in the first
paragraph, since many "series" (such as Series BXS found in the TI AM68
among others and added later in this series) contain cores with both Rogue
and Volcanic architectures.

Besides attempting to move away from vague groupings defined only
by marketing terms, we want to draw a line between properties inherent to
the IP core and choices made by the silicon vendor at integration time.
For instance, the number of power domains is a property of the IP core,
whereas the decision to use one or multiple clocks is a vendor one.

In the original compatible strings, we must use "ti,am62-gpu" to constrain
both of these properties since the number of power domains cannot be fixed
for "img,img-axe".

Work is currently underway to add support for volcanic-based Imagination
GPUs, for which bindings will be added in "img,powervr-volcanic.yaml".
As alluded to previously, the split between rogue and volcanic cores is
non-obvious at times, so add a generic top-level "img,img-rogue" compatible
string here to allow for simpler differentiation in devicetrees without
referring back to the bindings.

The currently supported GPU (AXE-1-16M) only requires a single power
domain. Subsequent patches will add support for BXS-4-64 MC1, which has
two power domains. Add infrastructure now to allow for this.

Also allow the dma-coherent property to be added to IMG Rogue GPUs, which
are DMA devices. The decision for coherency is made at integration time and
this property should be applied wherever it accurately describes the
vendor integration.

Note that the new required properties for power domains are conditional on
the new base compatible string to avoid an ABI break.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v6:
- Add Krzysztof's Rb
- Link to v5: https://lore.kernel.org/r/20250326-sets-bxs-4-64-patch-v1-v5-1-e4c46e8280a9@imgtec.com
Changes in v5:
- Remove extraneous (and error-causing) power-domains minItems constraint
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-1-d987cf4ca439@imgtec.com
Changes in v4:
- Add img,img-rogue back to ti,am62-gpu compatible strings to allow
  compatibility with older kernels
- Revert change to power-domains property and add proper constraint
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-1-143b3dbef02f@imgtec.com
Changes in v3:
- Remove unnecessary example
- Remove second power domain details, add these where they're used instead
- Avoid ABI breaks by limiting new required properties to new compatible
  strings and making all binding changes in a single patch.
- Links to v2:
  https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-1-3fd45d9fb0cf@imgtec.com
  https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-3-3fd45d9fb0cf@imgtec.com
  https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-4-3fd45d9fb0cf@imgtec.com
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 43 +++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 256e252f8087fa0d6081f771a01601d34b66fe19..e1056bf2af84c3eb43733bdc91124a66aaf51d35 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -12,10 +12,23 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - ti,am62-gpu
-      - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
+    oneOf:
+      - items:
+          - enum:
+              - ti,am62-gpu
+          - const: img,img-axe-1-16m
+          # This deprecated element must be kept around to allow old kernels to
+          # work with newer dts.
+          - const: img,img-axe
+          - const: img,img-rogue
+
+      # This legacy combination of compatible strings was introduced early on
+      # before the more specific GPU identifiers were used.
+      - items:
+          - enum:
+              - ti,am62-gpu
+          - const: img,img-axe
+        deprecated: true
 
   reg:
     maxItems: 1
@@ -37,6 +50,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  power-domain-names:
+    items:
+      - const: a
+
+  dma-coherent: true
+
 required:
   - compatible
   - reg
@@ -47,6 +66,18 @@ required:
 additionalProperties: false
 
 allOf:
+  # Constraints added alongside the new compatible strings that would otherwise
+  # create an ABI break.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,img-rogue
+    then:
+      required:
+        - power-domains
+        - power-domain-names
+
   - if:
       properties:
         compatible:
@@ -64,10 +95,12 @@ examples:
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     gpu@fd00000 {
-        compatible = "ti,am62-gpu", "img,img-axe";
+        compatible = "ti,am62-gpu", "img,img-axe-1-16m", "img,img-axe",
+                     "img,img-rogue";
         reg = <0x0fd00000 0x20000>;
         clocks = <&k3_clks 187 0>;
         clock-names = "core";
         interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+        power-domain-names = "a";
     };

-- 
2.49.0


