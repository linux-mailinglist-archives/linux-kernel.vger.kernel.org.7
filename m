Return-Path: <linux-kernel+bounces-839905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4C8BB2B23
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C563B9136
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED72D2490;
	Thu,  2 Oct 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dydpOR+K"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D72C026D;
	Thu,  2 Oct 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390234; cv=none; b=r7FRjYXUX7QUrZpqdhaXTYe89cvG62ihRAxrG/r+0CHqKzT3gVfYgsEMoklwPh5VIuPdOq9Bxf59p7CRFo8kqLy5Nuy2JbjBlJOATt0NNZNx+ju03AAx4EQtYlIDTClli0UtB8gN5brDKLYN5ZnArKh/DMGvkTMLO2hlNt+Xp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390234; c=relaxed/simple;
	bh=jDUQ/UaqP3nn6L4P+8Y0miY/+y99XoN5WWGCGdWBQtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUNwu+ycVs+qaHZFfFFCI5zJhvZSdSx+uwP2haOt+p0cyxlh/xqLMFIMIvf7drGtofOmAFBMaH8J0syd/1MwAbhEJ+65Co3D5hvrAzDEtUyh+hvpeqATpNH/FrDCsvRpMZnZ8JgqU2RqpdYz1946kytS6q72UIdpEYbASsLwIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dydpOR+K; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5927U9CG2838778;
	Thu, 2 Oct 2025 02:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759390209;
	bh=71sqONH4BXGPz4VfkWdc8RIfaxiFUOFoWFT9vpabLbY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dydpOR+K4/xM4y9182ZTavGpXMCnfraWH5z2dtM2aQ93llm5QEpWxu9p/bfXg3fk9
	 zRJ8V5eRzRKeZh/j9j9B8hbJKp3/Ffga+rDI+JDGa5bwwlUGgcC9P/64KEOHS1kPfL
	 miyg4r5PQFWKEFzHTn+HMxpXFwr9fMQ8ih5rZ2qE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5927U9LE3442626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 2 Oct 2025 02:30:09 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 2
 Oct 2025 02:30:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 02:30:08 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5927TkgQ1776146;
	Thu, 2 Oct 2025 02:29:58 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <k-yi@ti.com>, <henry.lo@ti.com>,
        <robinchen@ti.com>, <jesse-ji@ti.com>, <will-wang@ti.com>,
        <jim.shil@goertek.com>, <toastcheng@google.com>,
        <chinkaiting@google.com>
Subject: [PATCH v4 2/2] ASoC: tas2781: Update ti,tas2781.yaml for adding tas58xx
Date: Thu, 2 Oct 2025 15:29:25 +0800
Message-ID: <20251002072925.26242-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20251002072925.26242-1-baojun.xu@ti.com>
References: <20251002072925.26242-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update ti,tas2781.yaml for adding TAS5802/TAS5815/TAS5828.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
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
index bd00afa47..7f84f5060 100644
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


