Return-Path: <linux-kernel+bounces-816539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71405B57527
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD21188EADC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B32FAC12;
	Mon, 15 Sep 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I8jFRrE6"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095C2FABF6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929519; cv=none; b=La1qpnZbUKG0ZU4UwqskxKJrl54ylHu7AfQ9bqsXzsfVoIGTi7QWQh3lHqeOazpAZZ443clqr2AzVxx/J1YrSNtK1Vqm8XqE9U55cqGNcb+iXPfiNq3R6rF88FwW6NIp63mGnbACSkIBFNm3P04AjIzwkdnm2BEQ/SqsIhPLOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929519; c=relaxed/simple;
	bh=fhGiiTHcd/L/fp2vOjOAA6fKenzCFD4fLb1Bk4W9xSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Q3wo/vxeBLJZ/UXMdRSd1KjLzLIkn87qS+vj3XNLeB5+rE9dtEgrO5/g2vzj/dqVWud7Oe9HszjuyMariJcMSiZ3s/nKy/ITmAL/KlPKbU04O69wVaK7NRbHADPtmo+P0JoE1rH/OHN1diKMlJmr/kbL0sjfym+vKZFBensDNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I8jFRrE6; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250915094515epoutp0136351c5887754002f157a0406c88e7bc~la5SD_mRB2301023010epoutp01k
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:45:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250915094515epoutp0136351c5887754002f157a0406c88e7bc~la5SD_mRB2301023010epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757929515;
	bh=N5Do/Zm0purz49bPXXww2B2dKStSKo6VERcXNpISwh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8jFRrE6UuVsIQ3C5JZVDsCfA3lQuc72OwOwYQhE23MDZOaK7wGmkkuSstO7VxVD3
	 l6tsuclZS2zFOOyzf2rBAsYCr1gxbKkt4leFdyeA82HQgKV3dL+Nsfjky4rtL5zWgg
	 cXlGEq2b67JA/4NTpIV6e9mJNyZFRw3etiUnxh1w=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250915094514epcas5p492b01ee79be39beb3d8804a98e5ab9ad~la5ReLkNb3002530025epcas5p40;
	Mon, 15 Sep 2025 09:45:14 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cQKrn3R3Pz6B9m8; Mon, 15 Sep
	2025 09:45:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250915094512epcas5p223e2eb264967508527f478eb2200be83~la5PT6xta1637416374epcas5p2X;
	Mon, 15 Sep 2025 09:45:12 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250915094509epsmtip21747b6b29145802fb856806a716fc453~la5M-BCOd0834508345epsmtip2P;
	Mon, 15 Sep 2025 09:45:09 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com,
	shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, chandan.vn@samsung.com,
	dev.tailor@samsung.com, karthik.sun@samsung.com, Raghav Sharma
	<raghav.s@samsung.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: exynosautov920: add m2m clock
 definitions
Date: Mon, 15 Sep 2025 15:23:59 +0530
Message-Id: <20250915095401.3699849-2-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915095401.3699849-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250915094512epcas5p223e2eb264967508527f478eb2200be83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250915094512epcas5p223e2eb264967508527f478eb2200be83
References: <20250915095401.3699849-1-raghav.s@samsung.com>
	<CGME20250915094512epcas5p223e2eb264967508527f478eb2200be83@epcas5p2.samsung.com>

Add device tree clock binding definitions for CMU_M2M

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 .../clock/samsung,exynosautov920-clock.yaml   | 21 +++++++++++++++++++
 .../clock/samsung,exynosautov920.h            |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
index 72f59db73f76..b2dfe6ed353a 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
@@ -38,6 +38,7 @@ properties:
       - samsung,exynosautov920-cmu-hsi0
       - samsung,exynosautov920-cmu-hsi1
       - samsung,exynosautov920-cmu-hsi2
+      - samsung,exynosautov920-cmu-m2m
       - samsung,exynosautov920-cmu-misc
       - samsung,exynosautov920-cmu-peric0
       - samsung,exynosautov920-cmu-peric1
@@ -226,6 +227,26 @@ allOf:
             - const: embd
             - const: ethernet
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynosautov920-cmu-m2m
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (38.4 MHz)
+            - description: CMU_M2M NOC clock (from CMU_TOP)
+            - description: CMU_M2M JPEG clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: noc
+            - const: jpeg
+
 required:
   - compatible
   - "#clock-cells"
diff --git a/include/dt-bindings/clock/samsung,exynosautov920.h b/include/dt-bindings/clock/samsung,exynosautov920.h
index 93e6233d1358..0342a988565a 100644
--- a/include/dt-bindings/clock/samsung,exynosautov920.h
+++ b/include/dt-bindings/clock/samsung,exynosautov920.h
@@ -295,4 +295,9 @@
 #define CLK_DOUT_HSI2_ETHERNET          6
 #define CLK_DOUT_HSI2_ETHERNET_PTP      7
 
+/* CMU_M2M */
+#define CLK_MOUT_M2M_JPEG_USER          1
+#define CLK_MOUT_M2M_NOC_USER           2
+#define CLK_DOUT_M2M_NOCP               3
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOSAUTOV920_H */
-- 
2.34.1


