Return-Path: <linux-kernel+bounces-833601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9155ABA2635
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529A1384C42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0D27381E;
	Fri, 26 Sep 2025 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VdDIbbI7"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CE233704;
	Fri, 26 Sep 2025 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758861305; cv=none; b=PodIDFnunRf29xWkAAXnHUkOCpXiGWzHRx6N3K6DybrzjHam4pcsHuU7dHbgMrI1gPIzSir+Oj3m0kEAndbVrQ8Adrr5mK7f5F61wp95nYJo0EK48U4nALqeB09jIh06AfD4ujlVYbAw4iS7jUI3hpmy5ywQsrbe+Nq/t4b6X7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758861305; c=relaxed/simple;
	bh=OojCanpqFtM56WtUFcyiXIwgBg7eyveVPY7CjMXQfvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGna3pz/uTW/jkL50w3ytkUKaBs8PFv0MX13brtnEMXM0G4jaHrYccYujwCoIP1x2eyWf6mhAD+1oDEcPFk9z9lcM+YsU8HsDG729ZPo5gwB4ICqwNFZIQIOH0NsCk92RxvD8XObdH0/PnfmLieHBWpkDPR8/tI3dJWSQfJx+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VdDIbbI7; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58Q4YZLP1603571;
	Thu, 25 Sep 2025 23:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758861275;
	bh=Wl3MUKw5gk3MG0eob3+aXjrng6Sl3XUJPeeQClT4Ews=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VdDIbbI7kdJKFU/qouMhxAXquq0PpjeBEXpIJjf7KlRbF0yQhwWF52Vc01jxe4gL4
	 seecnPK0zG+HAzc/ffdDmxqwAtQqgxbEE0TDkbI7v9VwXfv/RVaqNs8gU4FFeLJUtd
	 tiJrtnPWypAqgwMTonOAZh7pmx5f+Q6NlvlYj6mI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58Q4YZfC689670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 25 Sep 2025 23:34:35 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 25
 Sep 2025 23:34:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Sep 2025 23:34:34 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58Q4Y72N685509;
	Thu, 25 Sep 2025 23:34:21 -0500
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
Subject: [PATCH v2 2/2] ASoC: tas2781: Add tas5828 support
Date: Fri, 26 Sep 2025 12:33:39 +0800
Message-ID: <20250926043339.8419-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250926043339.8419-1-baojun.xu@ti.com>
References: <20250926043339.8419-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update ti,tas2781.yaml for adding TAS5828.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v2:
 - Update description for TAS5828
 - Change commit tree to .../tiwai/sound.git
---
 Documentation/devicetree/bindings/sound/ti,tas2781.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index bd00afa47..a2173e851 100644
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
@@ -37,6 +37,7 @@ description: |
     https://www.ti.com/lit/gpn/tas2781
     https://www.ti.com/lit/gpn/tas5825m
     https://www.ti.com/lit/gpn/tas5827
+    https://www.ti.com/lit/gpn/tas5828m
 
 properties:
   compatible:
@@ -70,6 +71,9 @@ properties:
 
       ti,tas5827: 47-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
       Amplifier with Class-H Algorithm
+
+      ti,tas5828: 50-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
+      Amplifier with Hybrid-Pro Algorithm
     oneOf:
       - items:
           - enum:
@@ -82,6 +86,7 @@ properties:
               - ti,tas2572
               - ti,tas5825
               - ti,tas5827
+              - ti,tas5828
           - const: ti,tas2781
       - enum:
           - ti,tas2781
@@ -183,6 +188,7 @@ allOf:
           contains:
             enum:
               - ti,tas5827
+              - ti,tas5828
     then:
       properties:
         reg:
-- 
2.25.1


