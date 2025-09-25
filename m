Return-Path: <linux-kernel+bounces-832459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B9EB9F605
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740D9165708
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB520B81B;
	Thu, 25 Sep 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ftnoyTJN"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD01EFF9B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804988; cv=none; b=LsENTuZNwG8dch7Ay7EX7PHChYbSJkAOpC3dzplA7aBM1eMaR2uGPcWChoHM4KBP5aLtOx4frkUI7wGPF0Kp2gXtkxXwQ+iZFXgv74okJCFAyBr7633KZlVx7U/Ee5Ew1cVR31VR5vC8L5AW10IxRSaDR76NyPOpDuTLDN4D1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804988; c=relaxed/simple;
	bh=tqCczwitiJZp8F4Vzz6Z79TJ9m0TRwjeobfrVc/L3F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=VE31oVYU6Usbvu5MtYcw2WoQl+C44lpDp4m6WS6mQvjG2A6U+YnJAFMQAhV6pdQxF3lqmlrnZVhF5tg7eBYA9wkN+3ZnN5np5CLCm4Apr4oP1t1j/9ImeWosDiahBihD5qnuXlN/Gj1Vf95AQG8cQmVSCQy5RWx9RDNAvjDSDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ftnoyTJN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250925125618epoutp03c098e5f25f57d742deb12a8893acae6d~oh88wzPWI1224712247epoutp03V
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:56:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250925125618epoutp03c098e5f25f57d742deb12a8893acae6d~oh88wzPWI1224712247epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758804978;
	bh=sbBTIKlUsm+fUMo3p93EQYKgatFHNs8/LrncSrVknJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftnoyTJNDnuE3wMklZVGTR3uyvAsjzVEtYe7tttcG0/aF75gofmPA9Ez6+DPo+Glm
	 O1bwAks9mZkWFIuPctC3pKWszKdfzG+gXYNu+GUdToYdk+8ec74GStvSU+Jz3kpoD6
	 Q98te0MBO39beQNyGE1d5nkWUOQPP+gNqQeluhRE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250925125617epcas5p258f1d5eb1ab6ceb3591d600ccf2cb517~oh88IYSCa1889718897epcas5p27;
	Thu, 25 Sep 2025 12:56:17 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cXYcc5b6Bz3hhT7; Thu, 25 Sep
	2025 12:56:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250925125616epcas5p37346312c6a788a5398212f671d8a369d~oh86sofha0855708557epcas5p3x;
	Thu, 25 Sep 2025 12:56:16 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250925125612epsmtip26569cab259c9303bb01922db01796ca7~oh83iUIpg1532515325epsmtip2S;
	Thu, 25 Sep 2025 12:56:12 +0000 (GMT)
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
Subject: [PATCH 1/3] dt-bindings: clock: exynosautov920: add mfc clock
 definitions
Date: Thu, 25 Sep 2025 18:34:55 +0530
Message-Id: <20250925130457.3476803-2-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925130457.3476803-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250925125616epcas5p37346312c6a788a5398212f671d8a369d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250925125616epcas5p37346312c6a788a5398212f671d8a369d
References: <20250925130457.3476803-1-raghav.s@samsung.com>
	<CGME20250925125616epcas5p37346312c6a788a5398212f671d8a369d@epcas5p3.samsung.com>

Add device tree clock binding definitions for CMU_MFC

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 .../clock/samsung,exynosautov920-clock.yaml   | 21 +++++++++++++++++++
 .../clock/samsung,exynosautov920.h            |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
index b2dfe6ed353a..5bf905f88a1a 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
@@ -39,6 +39,7 @@ properties:
       - samsung,exynosautov920-cmu-hsi1
       - samsung,exynosautov920-cmu-hsi2
       - samsung,exynosautov920-cmu-m2m
+      - samsung,exynosautov920-cmu-mfc
       - samsung,exynosautov920-cmu-misc
       - samsung,exynosautov920-cmu-peric0
       - samsung,exynosautov920-cmu-peric1
@@ -247,6 +248,26 @@ allOf:
             - const: noc
             - const: jpeg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynosautov920-cmu-mfc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (38.4 MHz)
+            - description: CMU_MFC MFC clock (from CMU_TOP)
+            - description: CMU_MFC WFD clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: mfc
+            - const: wfd
+
 required:
   - compatible
   - "#clock-cells"
diff --git a/include/dt-bindings/clock/samsung,exynosautov920.h b/include/dt-bindings/clock/samsung,exynosautov920.h
index 0342a988565a..970d05167fc6 100644
--- a/include/dt-bindings/clock/samsung,exynosautov920.h
+++ b/include/dt-bindings/clock/samsung,exynosautov920.h
@@ -300,4 +300,9 @@
 #define CLK_MOUT_M2M_NOC_USER           2
 #define CLK_DOUT_M2M_NOCP               3
 
+/* CMU_MFC */
+#define CLK_MOUT_MFC_MFC_USER           1
+#define CLK_MOUT_MFC_WFD_USER           2
+#define CLK_DOUT_MFC_NOCP               3
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOSAUTOV920_H */
-- 
2.34.1


