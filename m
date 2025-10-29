Return-Path: <linux-kernel+bounces-875541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C0EC19543
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20C60564BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A531E0E6;
	Wed, 29 Oct 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="QCRL6f0y"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EA2BEC20;
	Wed, 29 Oct 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727873; cv=none; b=LIVKPczi259bZKejTjnBzOBldoqwtDxY2l62gTrFg6GJdQkP5RLKj5XwSKXeL3koVaphQE5wkK6ZSu6NWhDBHR2sV6cUH+xdMXGM8qVAkBBG0pJ+1zchz9pj3wo1pOv/E+V4Y8UHYHVJraIYPAsr71TgLNp6tqN+acGX9ZlT6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727873; c=relaxed/simple;
	bh=RR32p+M9C599dIleJAbw+9d5tlMsoBTx0doNI9BbweY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3DYlmA+pLkQ5BphPDy2JFzCuaTvJrE8IHP7dBff+HE5Lh9eoioBHiljmzBuOCQPH5twgg2sV8bqwm2OKaP0Fyg02scTf37QAEBOfowYguzmEM1KY/73IaSY+w/46A1IIM2F1R3ZOu6FpTqSUFvlkpIUF/s8xy0nz0M7Ci9ppOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=QCRL6f0y; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 59T6JiIY2014904; Wed, 29 Oct 2025 15:19:44 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding;i=yuji2.ishikawa@toshiba.co.jp;s=key1.smx;t=
	1761718755;x=1762928355;bh=RR32p+M9C599dIleJAbw+9d5tlMsoBTx0doNI9BbweY=;b=QCR
	L6f0yHuItdZpDFLJ0ibR3IBdcPDooG9Uj+kGR0DiPvh1pTDp4nmlY//34a+I7E6uptLKhG3jNcDjg
	7IWkyUxNkWSKUHuZ66OYF2Rn6CPRybyzwiVOu0/fgIfIWBJLBc3+VEecvy4pRKB6nCRtrEQrCQs3J
	89xjxnswcrgMv4N6y5EOwu3x+Le6dDX88jFv617KMbjIP7AI3vJPts+vblOPwNVJ/wvCSWPQsjRoF
	DUTZ2ga0TChUo48g1VMGd6SgftYButAP1q2p33E3KIriJy7ou7NgxAdZATNNjMk0oRcxRfQY+8mDP
	MekKAXzjQ4fzeK8wo7P/E4WzFX25Ctg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 59T6JEwI3507518; Wed, 29 Oct 2025 15:19:14 +0900
X-Iguazu-Qid: 2yAbrg0HuZq9EQydsG
X-Iguazu-QSIG: v=2; s=0; t=1761718754; q=2yAbrg0HuZq9EQydsG; m=AgqxK7maNBCk8YpXbPqC12la+75KSurRAdfqNdqMxkA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxHBm6SXDzyPQ; Wed, 29 Oct 2025 15:19:12 +0900 (JST)
X-SA-MID: 53851523
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Subject: [PATCH v2 1/2] dt-bindings: clock: Add identifiers for VIIF on Toshiba Visconti TMPV770x SoC
Date: Wed, 29 Oct 2025 15:13:43 +0900
X-TSB-HOP2: ON
Message-Id: <20251029061344.451222-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029061344.451222-1-yuji2.ishikawa@toshiba.co.jp>
References: <20251029061344.451222-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock and reset identifiers for the Video Input Interface.
These identifiers support two instances: VIIF0 and VIIF1.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- Do not modify existing identifiers to avoid breaking ABI.
  Keep existing identfiers for VIIF0.
  Introduce new idenfifiers for VIIF1, following the same naming conventions.
---
 include/dt-bindings/clock/toshiba,tmpv770x.h | 15 +++++++++++++--
 include/dt-bindings/reset/toshiba,tmpv770x.h | 10 +++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/toshiba,tmpv770x.h b/include/dt-bindings/clock/toshiba,tmpv770x.h
index 5fce71300..ff4ef1be5 100644
--- a/include/dt-bindings/clock/toshiba,tmpv770x.h
+++ b/include/dt-bindings/clock/toshiba,tmpv770x.h
@@ -141,7 +141,10 @@
 #define TMPV770X_CLK_PIREFCLK		124
 #define TMPV770X_CLK_SBUS		125
 #define TMPV770X_CLK_BUSLCK		126
-#define TMPV770X_NR_CLK			127
+#define TMPV770X_CLK_VIIFBS1_L2ISP	127
+#define TMPV770X_CLK_VIIFBS1_L1ISP	128
+#define TMPV770X_CLK_VIIFBS1_PROC	129
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
index c1007acb1..d711006d6 100644
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
2.34.1



