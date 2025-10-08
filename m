Return-Path: <linux-kernel+bounces-845042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C908BBC35A6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8620B4E9D96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF912BFC60;
	Wed,  8 Oct 2025 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oeLrQ1Dr"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBA28C871;
	Wed,  8 Oct 2025 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759899363; cv=none; b=NbXyogxHwIblKuM4tS4Js78bNHrlPph57UNljt/dzNeea7bSWqJ6KGymbXFk0T6HZDjjCv/HqmyKGJ/vkQCjGhio4yJ6qNHn24f4mTJDdlNgKMbsUCrVJdb/kpyLi3GjkCn02+405TE8LHa9qCh3KNjFvcHc9C6AbHlQHFLFHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759899363; c=relaxed/simple;
	bh=V0GNeOk6Yb9a+PXldWhn3TuKk2jS4hh+yoe0F9aSbBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbD+/qFxibPiT7h+ybyDFwBZyxZ+9SaqWPMnXFauxdKmehLIdPy8/mEzb0u//OKNmFZw+fXZhg6yU8zMKsCFBen1uw4M5PjfMUdjw3j6+LeLJmBm5Aj0Fk+ZPJTbmRZXeWoRdig0vnlOOxVB5hCULuo2iXocDb6iV+IkESUEH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oeLrQ1Dr; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5984thZm3968494;
	Tue, 7 Oct 2025 23:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759899343;
	bh=DdhlJmgv1OEzc891uVU86WV12G76t8SGWQ8hyvFzM18=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oeLrQ1DrEl1hkbAsJpu8uYWmnjuywpAkcNk4lVlpjayE9qqgQPyjla3atcYeu/5vV
	 9Xr7TYsx1UNsIMvn3PfLlW2oy9RxrNO+9Zg4UgWyB76gTeXifjsWkuGZbrZr8HH3Db
	 ff3Eq26UUzKSllS0Il33MiyPnb22NSzVvKyf7Tzo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5984tg1E1201214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 7 Oct 2025 23:55:42 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 23:55:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 23:55:42 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5984tQt82223240;
	Tue, 7 Oct 2025 23:55:35 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <k-yi@ti.com>,
        <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
        <will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
        <chinkaiting@google.com>
Subject: [PATCH v5 2/2] ASoC: dt-bindings: ti,tas2781: Add TAS58XX
Date: Wed, 8 Oct 2025 12:54:59 +0800
Message-ID: <20251008045500.44477-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20251008045500.44477-1-baojun.xu@ti.com>
References: <20251008045500.44477-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

TAS5802, TAS5815, and TAS5828 are in same family with TAS5825, TAS5827.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v5:
 - Change the patch title and the description
v4:
 - Change the patch title
 - Add TAS5802 support in yaml file
 - Change description for missed TAS5815
 - Change format to keep all lines within 80 bytes in length
v3:
 - Rewrite the patch title
 - Add TAS5815 support in yaml file
v2:
 - Update description for TAS5828
 - Change commit tree to .../tiwai/sound.git
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index bd00afa47d62..7f84f506013c 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -24,10 +24,10 @@ description: |
   Instruments Smart Amp speaker protection algorithm. The
   integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
-  The TAS5825/TAS5827 is a stereo, digital input Class-D audio
-  amplifier optimized for efficiently driving high peak power into
-  small loudspeakers. An integrated on-chip DSP supports Texas
-  Instruments Smart Amp speaker protection algorithm.
+  The TAS5802/TAS5815/TAS5825/TAS5827/TAS5828 is a stereo, digital input
+  Class-D audio amplifier optimized for efficiently driving high peak
+  power into small loudspeakers. An integrated on-chip DSP supports
+  Texas Instruments Smart Amp speaker protection algorithm.
 
   Specifications about the audio amplifier can be found at:
     https://www.ti.com/lit/gpn/tas2120
@@ -35,8 +35,10 @@ description: |
     https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2572
     https://www.ti.com/lit/gpn/tas2781
+    https://www.ti.com/lit/gpn/tas5815
     https://www.ti.com/lit/gpn/tas5825m
     https://www.ti.com/lit/gpn/tas5827
+    https://www.ti.com/lit/gpn/tas5828m
 
 properties:
   compatible:
@@ -65,11 +67,21 @@ properties:
       Protection and Audio Processing, 16/20/24/32bit stereo I2S or
       multichannel TDM.
 
+      ti,tas5802: 22-W, Inductor-Less, Digital Input, Closed-Loop Class-D
+      Audio Amplifier with 96-Khz Extended Processing and Low Idle Power
+      Dissipation.
+
+      ti,tas5815: 30-W, Digital Input, Stereo, Closed-loop Class-D Audio
+      Amplifier with 96 kHz Enhanced Processing
+
       ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
       to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
 
-      ti,tas5827: 47-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
-      Amplifier with Class-H Algorithm
+      ti,tas5827: 47-W Stereo, Digital Input, High Efficiency Closed-Loop
+      Class-D Amplifier with Class-H Algorithm
+
+      ti,tas5828: 50-W Stereo, Digital Input, High Efficiency Closed-Loop
+      Class-D Amplifier with Hybrid-Pro Algorithm
     oneOf:
       - items:
           - enum:
@@ -80,8 +92,11 @@ properties:
               - ti,tas2563
               - ti,tas2570
               - ti,tas2572
+              - ti,tas5802
+              - ti,tas5815
               - ti,tas5825
               - ti,tas5827
+              - ti,tas5828
           - const: ti,tas2781
       - enum:
           - ti,tas2781
@@ -177,12 +192,28 @@ allOf:
             minimum: 0x38
             maximum: 0x3f
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5802
+              - ti,tas5815
+    then:
+      properties:
+        reg:
+          maxItems: 4
+          items:
+            minimum: 0x54
+            maximum: 0x57
+
   - if:
       properties:
         compatible:
           contains:
             enum:
               - ti,tas5827
+              - ti,tas5828
     then:
       properties:
         reg:
-- 
2.25.1


