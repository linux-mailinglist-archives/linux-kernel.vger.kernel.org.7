Return-Path: <linux-kernel+bounces-831735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182CB9D6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5869174312
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33E2E7F02;
	Thu, 25 Sep 2025 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hfno4qSt"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02A2BB13;
	Thu, 25 Sep 2025 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777268; cv=none; b=DflvBQmbcPqHgwZx2aeOs1bvd4DXolh1jUvM5AHzHhKvANxSLJzjK5dAdRfsAszIn82xVojJv3kwCwBAGwk7D0DTw8E85xvG2sNYKz0S0NKq0EvGPH8CfIFSZf3BfXz3vTCUkW/93qijMtUdG73dvnrtlo0xQr1W0QgPIRU+RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777268; c=relaxed/simple;
	bh=71pvOju9UOZzBYUDKVlROr2/kT30woFR94z13ifO8ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXgiJfPxGSaLrTHE95rl/K5gBhym6hTgBzzFasbz8sDhhwjUl9YTJqRSOZCFpHdc/7Jb/diYRttjupppYOqaP+vukPI8/y774Jq7xjPxI1GIuJX/y3q6r3BMuzpDpynuxTlUHWa0iIIIxyc1uu/ev5fBWQysMXg8OYczYwo8I2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hfno4qSt; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58P5Dv4N1853992;
	Thu, 25 Sep 2025 00:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758777237;
	bh=SsbfzBM1ZDmceaejq0MfnQPjP4MhIkP/IweeHXME398=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hfno4qStnJCwTzEX5BzeyxuMQjxcEip8kqd3a8LMWmDf/ZHMr6pbDFK/1Ox+yMKoD
	 wRj0HV142jLziYmvBWn1K8hYkeWGJNMseQaqybbnssExnjlBuqqYw65781Gvu0CQ1m
	 rkD6a5JoDhoPZ6a3t7hG+upcSMY+sqgb5kKM2sEA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58P5Dux22964932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 25 Sep 2025 00:13:56 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 25
 Sep 2025 00:13:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Sep 2025 00:13:56 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58P5DVip2924111;
	Thu, 25 Sep 2025 00:13:44 -0500
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
Subject: [PATCH v1 2/2] ASoC: tas2781: Add tas5828 support
Date: Thu, 25 Sep 2025 13:13:02 +0800
Message-ID: <20250925051302.6805-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250925051302.6805-1-baojun.xu@ti.com>
References: <20250925051302.6805-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update ti,tas2781.yaml for adding tas5828.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 Documentation/devicetree/bindings/sound/ti,tas2781.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index bd00afa47d62..a2173e851e45 100644
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
2.43.0


