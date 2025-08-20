Return-Path: <linux-kernel+bounces-776856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E35B2D231
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67946188191D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A865526F2AD;
	Wed, 20 Aug 2025 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LxCrpMFl"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7C26F295;
	Wed, 20 Aug 2025 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658767; cv=none; b=kWi/xenRt54eRpbexOTg5z7+q2flH4GF8AAaUxECbvTteXNDIIDBmw/dBFStD9VdDntsYCsOOZB+839mc6pxtuuLG5gYQ7sBN0LgBxGW0WTyuGYlCS01tqcj+nZPtS+0hwiWUvLCWWAeZCJMpr0uI1JCKCx7bsPpgBmtcKLaBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658767; c=relaxed/simple;
	bh=lqQnDZ3r28IKLgBuza0AFNv8cKyvpuTP+0NE2//RlQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6pqJRCfuWnaYw4HbgHIQF9vFTy3NwpzPCf9Xt+Uy7DoJgWFzMf4F5ITIwbGxEvboR1E1la1DrEge8vVtz9xr/dNwiQpxBjbAKhNvJi3YVD6iDad34bBgN4Q7J9pXknw+RbsOV8O+eOEkC/SjZ48z+/HZuKQR5/HJBvilPhvI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LxCrpMFl; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K2x4273096797;
	Tue, 19 Aug 2025 21:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755658744;
	bh=4TEQ1Mdr01d1Jv8q7fpV3KX1BmxQ1Dk9ydlh/AW6kdg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LxCrpMFld9XLrxSXLwmpJt17qW5FXfCz+MsQFLugYCAcLgMawaBQZDO6JPB5AzBdS
	 R7DlnsvZLRYds+UfMGLFJebwCpohEzIGlP4+EF/qJEsbFRnzwf+yQwoNcDvCzzyCmO
	 IF+HyoCew0+pLCVU04cSx9SuSTcYrK4t229HKMoo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K2x3mq1738431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 21:59:04 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 21:59:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 21:59:03 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K2wqs44008196;
	Tue, 19 Aug 2025 21:58:58 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-y@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
        <will-wang@ti.com>
Subject: [PATCH v1 2/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825 support
Date: Wed, 20 Aug 2025 10:58:24 +0800
Message-ID: <20250820025824.24473-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250820025824.24473-1-baojun.xu@ti.com>
References: <20250820025824.24473-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update ti,tas2781.yaml for added tas2118, tas2x20, tas5825.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 73 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index 5ea1cdc593b5..fb57b63a00a2 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+# Copyright (C) 2022 - 2025 Texas Instruments Incorporated
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
@@ -11,30 +11,62 @@ maintainers:
   - Shenghao Ding <shenghao-ding@ti.com>
 
 description: |
+  The TAS2118/TAS2X20 is mono, digital input Class-D audio amplifier
+  optimized for efficiently driving high peak power into small loudspeakers.
+  Integrated speaker voltage and current sense provides for
+  real time monitoring of loudspeaker behavior.
   The TAS2563/TAS2781 is a mono, digital input Class-D audio
   amplifier optimized for efficiently driving high peak power into
   small loudspeakers. An integrated on-chip DSP supports Texas
   Instruments Smart Amp speaker protection algorithm. The
   integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
+  The TAS5825 is a stereo, digital input Class-D audio
+  amplifier optimized for efficiently driving high peak power into
+  small loudspeakers. An integrated on-chip DSP supports Texas
+  Instruments Smart Amp speaker protection algorithm. The
+  integrated speaker voltage and current sense provides for real time
+  monitoring of loudspeaker behavior.
 
   Specifications about the audio amplifier can be found at:
+    https://www.ti.com/lit/gpn/tas2120
+    https://www.ti.com/lit/gpn/tas2320
     https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2781
+    https://www.ti.com/lit/gpn/tas5825m
 
 properties:
   compatible:
     description: |
+      ti,tas2020: 3.2-W Mono Digital Input Class-D Speaker Amp with 5.5V PVDD
+      Support.
+
+      ti,tas2118: 5-W Mono Digital Input Class-D Speaker Amp with Integrated
+      8.4-V Class-H Boost.
+
+      ti,tas2120: 8.2-W Mono Digital Input Class-D Speaker Amp with
+      Integrated 14.75V Class-H Boost.
+
+      ti,tas2320: 15-W Mono Digital Input Class-D Speaker Amp with 15V Support.
+
       ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
       DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
 
       ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
       Protection and Audio Processing, 16/20/24/32bit stereo I2S or
       multichannel TDM.
+
+      ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
+      to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
     oneOf:
       - items:
           - enum:
+              - ti,tas2020
+              - ti,tas2118
+              - ti,tas2120
+              - ti,tas2320
               - ti,tas2563
+              - ti,tas5825
           - const: ti,tas2781
       - enum:
           - ti,tas2781
@@ -61,6 +93,27 @@ required:
 
 allOf:
   - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas2020
+              - ti,tas2118
+              - ti,tas2120
+              - ti,tas2320
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple-AMP case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x48
+            maximum: 0x4b
+
   - if:
       properties:
         compatible:
@@ -97,6 +150,24 @@ allOf:
             minimum: 0x38
             maximum: 0x3f
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5825
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple-AMP case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


