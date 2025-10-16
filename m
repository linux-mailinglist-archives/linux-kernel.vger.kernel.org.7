Return-Path: <linux-kernel+bounces-855475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D0BE15D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9116D3BFE81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954A1F461D;
	Thu, 16 Oct 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="XMoeKsum"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D2CA4E;
	Thu, 16 Oct 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585480; cv=none; b=tG2cw47paqM6XMVID4zmMYZz76V5zJ3Oo1sn0mAgAAtRqMcw+pnV64G2ufnLNBiXAgYN/HqyVdm5uBe1S1xlruV/u2m6PtdGci1PeRDNtXnMRQQZfUji8XUNqI7L1hS7B3iUcjo6zGLlKwIN6g+PK3Zbex2vr3qswY1BZlCAnyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585480; c=relaxed/simple;
	bh=DhquJXfwIJXPb+27jcxzHtwxsqB1wZz4m4WsYkpC20g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqJV8mttfG6WIerAsFHp9ZBhApNu+HX1mpUGmuT2OpRuG+1diOMslHaDT9fA0+uez3ExXIzE76ZcpbX0ZYsaOdXQFEh4auuepoRm+XeVrMoQE/PRbNPQDuV/VTN1pLPgp+sqTo69FJ7VMj+q5iR/x3qnGNHqkvx4PMtUlWlfmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=XMoeKsum; arc=none smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 59G1dwdV748855; Thu, 16 Oct 2025 10:39:58 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding;i=yuji2.ishikawa@toshiba.co.jp;s=key1.smx;t=
	1760578760;x=1761788360;bh=DhquJXfwIJXPb+27jcxzHtwxsqB1wZz4m4WsYkpC20g=;b=XMo
	eKsumOG8enFCBctqTXu2QRBPHmDGQmybRSaFJvokxDiu9sGjb8qy56IsLhAf3Fma37KP0iXVTOhy7
	G5BR4rfkxQgqlvhRZGG726lq03bv/eHbMBMRYop5aWU2rI7MkLj9BtvzZN35Wj9MsH7jP+v05kA0k
	TMjTPBeh5oj75eDHGmKfHFRzeNm47h60AyAwVwYOAPdqo1IpIeXyFonz4FcVc63ONvkX5pbzAr4bE
	siBKAcFEL2ggJYB7oEf4JY96QaK1ihvlsf32fpYLxxOcm5/+Y8365ADj2Om3RZmyJLDumWNIFSnXF
	QIdM/EitIuftKR5/CLlOIXxCLABYGTw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 59G1dJZl409905; Thu, 16 Oct 2025 10:39:19 +0900
X-Iguazu-Qid: 2rWhejjBIYgAXkrEwe
X-Iguazu-QSIG: v=2; s=0; t=1760578759; q=2rWhejjBIYgAXkrEwe; m=TjeFf1PYIWwR61zihda6OanuCyy7Qx1w4c7qBLq7BQY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cn9bp1qzYz4vyq; Thu, 16 Oct 2025 10:39:18 +0900 (JST)
X-SA-MID: 53068310
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Update identifiers for VIIF on Toshiba Visconti TMPV770x SoC
Date: Thu, 16 Oct 2025 10:33:27 +0900
X-TSB-HOP2: ON
Message-Id: <20251016013328.303611-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016013328.303611-1-yuji2.ishikawa@toshiba.co.jp>
References: <20251016013328.303611-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update identifiers for the clocks and the resets of Video Input Interface
in order to reflect the actual architecture of TMPV770x SoC.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
 include/dt-bindings/clock/toshiba,tmpv770x.h | 33 +++++++++++++-------
 include/dt-bindings/reset/toshiba,tmpv770x.h | 10 +++++-
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/dt-bindings/clock/toshiba,tmpv770x.h b/include/dt-bindings/clock/toshiba,tmpv770x.h
index 5fce713001..2dbd5885c0 100644
--- a/include/dt-bindings/clock/toshiba,tmpv770x.h
+++ b/include/dt-bindings/clock/toshiba,tmpv770x.h
@@ -94,10 +94,10 @@
 #define TMPV770X_CLK_DSP2_PBCLK		77
 #define TMPV770X_CLK_DSP3_PBCLK		78
 #define TMPV770X_CLK_DSVIIF0_APBCLK	79
-#define TMPV770X_CLK_VIIF0_APBCLK	80
-#define TMPV770X_CLK_VIIF0_CFGCLK	81
-#define TMPV770X_CLK_VIIF1_APBCLK	82
-#define TMPV770X_CLK_VIIF1_CFGCLK	83
+#define TMPV770X_CLK_VIIFBS0_APB	80
+#define TMPV770X_CLK_VIIFBS0_CFG	81
+#define TMPV770X_CLK_VIIFBS1_APB	82
+#define TMPV770X_CLK_VIIFBS1_CFG	83
 #define TMPV770X_CLK_VIIF2_APBCLK	84
 #define TMPV770X_CLK_VIIF2_CFGCLK	85
 #define TMPV770X_CLK_VIIF3_APBCLK	86
@@ -121,11 +121,11 @@
 #define TMPV770X_CLK_PYRAMID		104
 #define TMPV770X_CLK_HWA2_ASYNC		105
 #define TMPV770X_CLK_DSP0		106
-#define TMPV770X_CLK_VIIFBS0		107
-#define TMPV770X_CLK_VIIFBS0_L2ISP	108
-#define TMPV770X_CLK_VIIFBS0_L1ISP	109
-#define TMPV770X_CLK_VIIFBS0_PROC	110
-#define TMPV770X_CLK_VIIFBS1		111
+#define TMPV770X_CLK_VIIFBS0_PROC	107
+#define TMPV770X_CLK_VIIF0_L2ISP	108
+#define TMPV770X_CLK_VIIF0_L1ISP	109
+#define TMPV770X_CLK_VIIF0_PROC		110
+#define TMPV770X_CLK_VIIFBS1_PROC	111
 #define TMPV770X_CLK_VIIFBS2		112
 #define TMPV770X_CLK_VIIFOP_MBUS	113
 #define TMPV770X_CLK_VIIFOP0_PROC	114
@@ -141,7 +141,10 @@
 #define TMPV770X_CLK_PIREFCLK		124
 #define TMPV770X_CLK_SBUS		125
 #define TMPV770X_CLK_BUSLCK		126
-#define TMPV770X_NR_CLK			127
+#define TMPV770X_CLK_VIIF1_L2ISP	127
+#define TMPV770X_CLK_VIIF1_L1ISP	128
+#define TMPV770X_CLK_VIIF1_PROC		129
+#define TMPV770X_NR_CLK			130
 
 /* Reset */
 #define TMPV770X_RESET_PIETHER_2P5M	0
@@ -176,6 +179,14 @@
 #define TMPV770X_RESET_PIPCMIF		29
 #define TMPV770X_RESET_PICKMON		30
 #define TMPV770X_RESET_SBUSCLK		31
-#define TMPV770X_NR_RESET		32
+#define TMPV770X_RESET_VIIFBS0		32
+#define TMPV770X_RESET_VIIFBS0_APB	33
+#define TMPV770X_RESET_VIIFBS0_L2ISP	34
+#define TMPV770X_RESET_VIIFBS0_L1ISP	35
+#define TMPV770X_RESET_VIIFBS1		36
+#define TMPV770X_RESET_VIIFBS1_APB	37
+#define TMPV770X_RESET_VIIFBS1_L2ISP	38
+#define TMPV770X_RESET_VIIFBS1_L1ISP	39
+#define TMPV770X_NR_RESET		40
 
 #endif /*_DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_ */
diff --git a/include/dt-bindings/reset/toshiba,tmpv770x.h b/include/dt-bindings/reset/toshiba,tmpv770x.h
index c1007acb19..d711006d6b 100644
--- a/include/dt-bindings/reset/toshiba,tmpv770x.h
+++ b/include/dt-bindings/reset/toshiba,tmpv770x.h
@@ -36,6 +36,14 @@
 #define TMPV770X_RESET_PIPCMIF		29
 #define TMPV770X_RESET_PICKMON		30
 #define TMPV770X_RESET_SBUSCLK		31
-#define TMPV770X_NR_RESET		32
+#define TMPV770X_RESET_VIIFBS0		32
+#define TMPV770X_RESET_VIIFBS0_APB	33
+#define TMPV770X_RESET_VIIFBS0_L2ISP	34
+#define TMPV770X_RESET_VIIFBS0_L1ISP	35
+#define TMPV770X_RESET_VIIFBS1		36
+#define TMPV770X_RESET_VIIFBS1_APB	37
+#define TMPV770X_RESET_VIIFBS1_L2ISP	38
+#define TMPV770X_RESET_VIIFBS1_L1ISP	39
+#define TMPV770X_NR_RESET		40
 
 #endif /*_DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_ */
-- 
2.43.0



