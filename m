Return-Path: <linux-kernel+bounces-825526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BEFB8C094
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EA41B25DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6A235355;
	Sat, 20 Sep 2025 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tuUEa5IA"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2D225402;
	Sat, 20 Sep 2025 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349320; cv=none; b=hnx0Js/I+a6XJ30/0cotznMZ6yxBHKpt0yirB6ODFtKrfYeMZN1nHtO0eiVN82bYjzNbHJUCp34DcBjG1wPS451vjvwadujyeztIxOcx/Mae2M143bkl2ByDDUaZ0ybaBsQqI8dWrsUM3qQiOrclxSrjd/2Z3rQmEAXTTGCn0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349320; c=relaxed/simple;
	bh=9RcGvOkOXT/d8Hxm2c0v67xGchk2M+hVVdjqG6EcoD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ArsE637vHduTawxfX7OfWLQokYQ8m6hUaMUW0HVoj+m813KBBzlB9Gr/Vl3kEAgVjFT1I1jMIkFlEaF2fdISbduU2ILH5yhA1uscqiPspbrfAXFbnGf0c5UYz8EIt81c9kuWS/PnfE5+5TiCqVHqstwjB23NaSPr+ZqGViKTTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tuUEa5IA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58K6LHfa859875;
	Sat, 20 Sep 2025 01:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758349278;
	bh=3kbgb0IN9bjPFXfBctaJeLpVfYUyl6fZMxymQW5eud0=;
	h=From:To:CC:Subject:Date;
	b=tuUEa5IAjC0RzYPmNHcSFcSxfdp3vODt0NnoIO30i/JP+HL/ir8b+408SAeRRVKaH
	 vn8+0mItiko8qvucvpeQenZ+lsNZlf5e2iYwYdEwVm0QMai00mh79SekwMUwhk2XaQ
	 l/6Y1n47DE2wp1+3Ov5IlDOm9yqKmG0P9IGCGDxM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58K6LHBW3448206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 01:21:17 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 01:21:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 01:21:17 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58K6L98x3734016;
	Sat, 20 Sep 2025 01:21:10 -0500
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
Subject: [PATCH v1] ASoC: tas2781: Correct the wrong description and register address on tas2781
Date: Sat, 20 Sep 2025 14:20:44 +0800
Message-ID: <20250920062044.1904-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Correct the wrong description for TAS257X. Combined TAS5825 with TAS2563,
as they use the same register address and number.
Correct the register address and number for TAS5827.

Fixes: 7095d688de38 ("ASoC: tas2781: Add tas2118, tas2x20, tas5825 support")
Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index 011211112be4..bd00afa47d62 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -11,11 +11,13 @@ maintainers:
   - Shenghao Ding <shenghao-ding@ti.com>
 
 description: |
-  The TAS2118/TAS2X20/TAS257x is mono, digital input Class-D audio
+  The TAS2118/TAS2X20 is mono, digital input Class-D audio
   amplifier optimized for efficiently driving high peak power into
   small loudspeakers.
-  Integrated speaker voltage and current sense provides for
-  real time monitoring of loudspeaker behavior.
+  The TAS257x is mono, digital input Class-D audio amplifier optimized
+  for efficiently driving high peak power into small loudspeakers.
+  Integrated speaker voltage and current sense provides for real time
+  monitoring of loudspeaker behavior.
   The TAS2563/TAS2781 is a mono, digital input Class-D audio
   amplifier optimized for efficiently driving high peak power into
   small loudspeakers. An integrated on-chip DSP supports Texas
@@ -25,9 +27,7 @@ description: |
   The TAS5825/TAS5827 is a stereo, digital input Class-D audio
   amplifier optimized for efficiently driving high peak power into
   small loudspeakers. An integrated on-chip DSP supports Texas
-  Instruments Smart Amp speaker protection algorithm. The
-  integrated speaker voltage and current sense provides for real time
-  monitoring of loudspeaker behavior.
+  Instruments Smart Amp speaker protection algorithm.
 
   Specifications about the audio amplifier can be found at:
     https://www.ti.com/lit/gpn/tas2120
@@ -131,6 +131,7 @@ allOf:
           contains:
             enum:
               - ti,tas2563
+              - ti,tas5825
     then:
       properties:
         reg:
@@ -181,15 +182,14 @@ allOf:
         compatible:
           contains:
             enum:
-              - ti,tas5825
               - ti,tas5827
     then:
       properties:
         reg:
-          maxItems: 4
+          maxItems: 6
           items:
-            minimum: 0x4c
-            maximum: 0x4f
+            minimum: 0x60
+            maximum: 0x65
 
 additionalProperties: false
 
-- 
2.43.0


