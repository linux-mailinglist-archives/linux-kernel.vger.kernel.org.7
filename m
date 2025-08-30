Return-Path: <linux-kernel+bounces-792748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354CB3C876
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D405F3B4794
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355F22129F;
	Sat, 30 Aug 2025 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t7ep6Dr8"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3B241C8C;
	Sat, 30 Aug 2025 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756534576; cv=none; b=aofGpmD/cqQGHAfWj94KhKj+Kx3lKVYWkvR+xghObYGhOSBiwoegztnYJtpsfcePPE0fkdQcJz3GOqzh0vaI9x5HptEYtMOm9Em1V07aso9UX+78E9Lt5MK6uMJnsYGzV2qrSQqkyVbZtZaqwtvMxU9+EVJdySIggexH2DwYR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756534576; c=relaxed/simple;
	bh=qfyv3oMp3domLy8FxDk2uV8pVIu7xX53qtHqe1eXx6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgQj6XUPcPCK3KM6tELSJeBKbS/hishjVUGzROZ8Hhw8OKsWJ8T1aEnhFdDpm21e5B6bbkhm9C5hv//4Kqtma4HFtBFtmO564cj/BpUS/wh+b5cfrBd2L5KDqF5XWRKm19DSSQB6eIeUSnazFwm2Pydbl81wNmRTWCxs8XRp8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t7ep6Dr8; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57U6Fg3Y2393700;
	Sat, 30 Aug 2025 01:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756534542;
	bh=/3h3pBMnXj801ChBgkwa7CRTuzA6xKhT1CxYrz6psP0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t7ep6Dr8S6toVvLaDdT+/g/m1lFrpte9ZARxJZt7p83oqWyRXYEzAl6DXkUBm43ba
	 1zV7fwXTnZNMM+G7yXHqqZSFuVBzif620XzFKimVFSn7XpMeaf0BwWfyfXH3n8cDzC
	 cYMqSKtaoGxLLSQV56maPqCVgn3QgiD8nsNj3x90=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57U6Fgeo366883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 30 Aug 2025 01:15:42 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 30
 Aug 2025 01:15:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 30 Aug 2025 01:15:42 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57U6FLtt3461942;
	Sat, 30 Aug 2025 01:15:33 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <k-yi@ti.com>,
        <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
        <will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
        <chinkaiting@google.com>
Subject: [PATCH v4 2/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825 support
Date: Sat, 30 Aug 2025 14:14:59 +0800
Message-ID: <20250830061459.24371-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250830061459.24371-1-baojun.xu@ti.com>
References: <20250830061459.24371-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update ti,tas2781.yaml for adding tas2118, tas2x20, tas257x and tas582x.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v4:
 - Change description for adding tas257x and tas5827
 - Added descriptions for tas2570, tas2572 and tas5827
 - Remove unnecessary description for I2C register
v3:
 - Remove unnecessary minItems.
 - Remove unnecessary description for tas5825.
v2:
 - Update the mail list for maintainers of yaml file
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index 5ea1cdc593b5..0f1da803253e 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+# Copyright (C) 2022 - 2025 Texas Instruments Incorporated
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
@@ -11,30 +11,77 @@ maintainers:
   - Shenghao Ding <shenghao-ding@ti.com>
 
 description: |
+  The TAS2118/TAS2X20/TAS257x is mono, digital input Class-D audio
+  amplifier optimized for efficiently driving high peak power into
+  small loudspeakers.
+  Integrated speaker voltage and current sense provides for
+  real time monitoring of loudspeaker behavior.
   The TAS2563/TAS2781 is a mono, digital input Class-D audio
   amplifier optimized for efficiently driving high peak power into
   small loudspeakers. An integrated on-chip DSP supports Texas
   Instruments Smart Amp speaker protection algorithm. The
   integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
+  The TAS5825/TAS5827 is a stereo, digital input Class-D audio
+  amplifier optimized for efficiently driving high peak power into
+  small loudspeakers. An integrated on-chip DSP supports Texas
+  Instruments Smart Amp speaker protection algorithm. The
+  integrated speaker voltage and current sense provides for real time
+  monitoring of loudspeaker behavior.
 
   Specifications about the audio amplifier can be found at:
+    https://www.ti.com/lit/gpn/tas2120
+    https://www.ti.com/lit/gpn/tas2320
     https://www.ti.com/lit/gpn/tas2563
+    https://www.ti.com/lit/gpn/tas2572
     https://www.ti.com/lit/gpn/tas2781
+    https://www.ti.com/lit/gpn/tas5825m
+    https://www.ti.com/lit/gpn/tas5827
 
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
+
+      ti,tas2570: 5.8-W Digital Input smart amp with I/V sense and integrated
+      11-V Class-H Boost
+
+      ti,tas2572: 6.6-W Digital Input smart amp with I/V sense and integrated
+      13-V Class-H Boost
 
       ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
       Protection and Audio Processing, 16/20/24/32bit stereo I2S or
       multichannel TDM.
+
+      ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
+      to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
+
+      ti,tas5827: 47-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
+      Amplifier with Class-H Algorithm
     oneOf:
       - items:
           - enum:
+              - ti,tas2020
+              - ti,tas2118
+              - ti,tas2120
+              - ti,tas2320
               - ti,tas2563
+              - ti,tas2570
+              - ti,tas2572
+              - ti,tas5825
+              - ti,tas5827
           - const: ti,tas2781
       - enum:
           - ti,tas2781
@@ -61,6 +108,23 @@ required:
 
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
+          maxItems: 4
+          items:
+            minimum: 0x48
+            maximum: 0x4b
+
   - if:
       properties:
         compatible:
@@ -79,6 +143,21 @@ allOf:
             minimum: 0x4c
             maximum: 0x4f
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas2570
+              - ti,tas2572
+    then:
+      properties:
+        reg:
+          maxItems: 4
+          items:
+            minimum: 0x48
+            maximum: 0x4b
+
   - if:
       properties:
         compatible:
@@ -97,6 +176,21 @@ allOf:
             minimum: 0x38
             maximum: 0x3f
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5825
+              - ti,tas5827
+    then:
+      properties:
+        reg:
+          maxItems: 4
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


