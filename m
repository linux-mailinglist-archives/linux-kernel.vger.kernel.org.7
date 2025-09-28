Return-Path: <linux-kernel+bounces-835348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1626CBA6D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D081897460
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9942D73AD;
	Sun, 28 Sep 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VXADkv9U"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA932C0291;
	Sun, 28 Sep 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051359; cv=none; b=dlYmfUGC8GMysja2fldMHRYKSsf5XJLkJZEAXA6IS1KdnCXQlsynXI9MTp2taJ5+auCzJhN56Rdw+MtbgQdH6S7jjNe+faiPIa4DfErq4uU7XNDHWWBavHHNRuD2gXxkMjKfL+bdkGQ4a+PHgRqtOTix/inX6bFAuLyLhk/0ASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051359; c=relaxed/simple;
	bh=FsyO78cAY5OS5syYfgWEipoqTParnh2cJZmBAR/FHRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn56ceoEP769uo8gNgczv8aXQ/8GMo4pBEPiE1EoeUpUND6x6/nRFEhQyc7tXbvguFRMXBjyU4E2L/uaEWXC0WgY61oNNtX6T5XkntTiIlijjl+uaglqfDVP6I2lqc0nYU7+Wis7A0MYxBkHDC9/IAfIrR5TI7HrDLB8CFEyEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VXADkv9U; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58S9G1qo1973472;
	Sun, 28 Sep 2025 04:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759050961;
	bh=JplANSYRs8nPJ0xMslPsyEKqcg2yXcny2W08nU6w77I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VXADkv9UEwF9OPdy5w+DtL4Rjf51KhYGAWLtr2j+GdnC7ApkvVdCtCbfcXDQydq+V
	 Zg+mssTlts8nS/yRtpr+opdfedSfxO9k9FzXHPveqNG0TeWpSh1f86avyLbHKpHj9u
	 0+GULlcBoCNlsYUzWvo9dyKR9DF3Ftn9g8rLwPYg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58S9G1LH1483231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 28 Sep 2025 04:16:01 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 28
 Sep 2025 04:16:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:16:00 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58S9FbHs3697526;
	Sun, 28 Sep 2025 04:15:50 -0500
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
Subject: [PATCH v3 2/2] ASoC: tas2781: Update ti,tas2781.yaml for adding tas5815 and tas5828
Date: Sun, 28 Sep 2025 17:15:14 +0800
Message-ID: <20250928091514.12349-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250928091514.12349-1-baojun.xu@ti.com>
References: <20250928091514.12349-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update ti,tas2781.yaml for adding TAS5815/TAS5828.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v3:
 - Rewrite the patch title
 - Add TAS5815 support in yaml file
v2:
 - Update description for TAS5828
 - Change commit tree to .../tiwai/sound.git
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index bd00afa47..192d8c560 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -24,7 +24,7 @@ description: |
   Instruments Smart Amp speaker protection algorithm. The
   integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
-  The TAS5825/TAS5827 is a stereo, digital input Class-D audio
+  The TAS5825/TAS5827/TAS5828 is a stereo, digital input Class-D audio
   amplifier optimized for efficiently driving high peak power into
   small loudspeakers. An integrated on-chip DSP supports Texas
   Instruments Smart Amp speaker protection algorithm.
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
@@ -65,11 +67,17 @@ properties:
       Protection and Audio Processing, 16/20/24/32bit stereo I2S or
       multichannel TDM.
 
+      ti,tas5815: 30-W, Digital Input, Stereo, Closed-loop Class-D Audio
+      Amplifier with 96 kHz Enhanced Processing
+
       ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
       to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
 
       ti,tas5827: 47-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
       Amplifier with Class-H Algorithm
+
+      ti,tas5828: 50-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
+      Amplifier with Hybrid-Pro Algorithm
     oneOf:
       - items:
           - enum:
@@ -80,8 +88,10 @@ properties:
               - ti,tas2563
               - ti,tas2570
               - ti,tas2572
+              - ti,tas5815
               - ti,tas5825
               - ti,tas5827
+              - ti,tas5828
           - const: ti,tas2781
       - enum:
           - ti,tas2781
@@ -177,12 +187,27 @@ allOf:
             minimum: 0x38
             maximum: 0x3f
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
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


