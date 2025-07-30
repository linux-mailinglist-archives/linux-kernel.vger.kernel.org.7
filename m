Return-Path: <linux-kernel+bounces-750372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D3B15A99
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D896C16AC16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D8299922;
	Wed, 30 Jul 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqdCQlbn"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3C2980B8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864116; cv=none; b=JLfXEulbN7MQV1+CiymHyRTmoNJ6Iciqnk37T+acK+VCsRddXFSE+I4fanZw9fGc5W+/R94pXrgZeecFMMb8dG1xxsADVQ+pnnXIskVRlaj4oIFxmzM0+DK3RR9WGSEOkGGZH3gvXWe2nH6O+u0D7Suxe6si2642YjfdcALYWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864116; c=relaxed/simple;
	bh=Wk97buN0o0oO5Pg6mh3j5DzY8MUEjrw8kChllVB2Vhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEkIvc7zy+Ar9eFqpNPcs3D6eErGcf4oRC6BS1KSprMl2faMiP+LUkFFL6mnIBmoHsGL9C+a5xl3rMTBMay16cXTxDEvu3Syjc9rPqePXRzdtztgnOcAwr7ok3Od5L/6drSTWYoxqONtoGD+t8N4v/2Nvg5ztXAxHbiPhttGSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqdCQlbn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7823559a5so353252f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864112; x=1754468912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNIZRPL/aYSMg8EX0aeqcrIzm6PwgSE5iRtD2jvvxVY=;
        b=dqdCQlbnOU5Jz0HtV8WBfTd77Pt4m2XXUnyCGuCN9o/64IPvLISbTFMmGvHLX0tCTu
         dgQ0fBhX0QLs/JVZ9OdoYOn118wKlOe6a6YMBHxf2Ptl/arPr3tP+rOM1HSabLmguXkr
         /ochfkCyJBmv39DpS5hkeGYPOpDPEQZQpof4Ucn8h23DGvCsrBLIi3QWH/NyseX6X1Jm
         U8Vf7N48j7FCKlxUGQsiCF399b01F0oI/3iHUY6Gv53ZLMG12vQMFc418MQ75cMIJyAY
         ijBEKM5iClSAiWUhuNdct/ScjeN3vJME8yTL/6+LDg52yX7YuUfcTeuvTXwKcLogQX8N
         vKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864112; x=1754468912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNIZRPL/aYSMg8EX0aeqcrIzm6PwgSE5iRtD2jvvxVY=;
        b=qOHQfbWc2BI6wrYouzTJmw3eOIauGruhpD1hxowVPjiOrGtULdmD+YwzB2UlpcTFTd
         5cb+Ddd63Xz411mGJx1ouWpUNr71pSzDmZ3FIXunxLcQuM28U9Fg7FDfs/KB7SJoEMsJ
         oXlNVIBrfyXtZNiCNI4Gb8PotTet87Oer12KIMU2KEKJ2X/4KL79qZBxt9Flac7fvSiB
         MD/qHeHF02eTI0t9xZG/v8YXrCLTJV8bpViidcMps+uQO0Cg6hv0+NiWMpiuYgZNmwJV
         VCuUNJolLVEa7vDDnGFWyAkdsUW3YGMw3eN/0Gv/fYrzUr0QeEax6cG7JxqXa5sMi/QM
         Lv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsFRBK72ziVPToMx3qC/E6x9DXty9oislJiiwuQIw27Fm6fmSY4YayxUrzo8IqBu35d1LK7uULZ56MRNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFw/3dNnrZXePQOEbbO4AfmPIxl+NtfXfyPCVYV3lkk8G6rq6I
	8h2W8DMr8+AfyhGCp2BLd+nl39iqSxvNb0Qn8HyTN1AocnRO7UvXJpuTFrJ2bRv7No4=
X-Gm-Gg: ASbGncunZLtfMolueqfQXaIn0auFkB4iDToL2BQ1K+wuVQ9LBF2pARuHumuZlK8p7W+
	H2soAZG36//KOSqQkkYMcTDPLMT3HCEBgs2kBWjyUYav2sTlgUyXsylcsWCvnBsupPY8UVnj7Sn
	yUxaUTZLfhSzKGkUmSX4Km0f+StDmk5qd0DddSJP0Dn6LtHl25suNgYfVnZE6SeCJBPDG3MfvzN
	lvWghQ56XDXdWO6Yc752yh8fnUB5SHYZYWBcON7iCWXOvEc7hSKkvgdV0/Xt2ll4PFiCPza7q7x
	/wdVBCPDja4J/Gzg6ZcnDMwfAqVg7CsloF6vm03+N52dXBmgmWnK/axoMcZPiqWaGWA1cs7m3nw
	smbz9GfAt2YnXFnDefrOeifwv16VK2Grow+Yxeh+6u55pq7JM
X-Google-Smtp-Source: AGHT+IEDs+cIV8lm6otWMgxjcnmwPUp8Bekbty0CfSvSZYQYFi6eXDIk4tEC0BcMxELRgsF5ls7T1Q==
X-Received: by 2002:a05:6000:2890:b0:3b7:7cb5:a539 with SMTP id ffacd0b85a97d-3b794fed101mr2125562f8f.18.1753864112536;
        Wed, 30 Jul 2025 01:28:32 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:32 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 14/20] clocksource/drivers/vf-pit: Enable and disable module on error
Date: Wed, 30 Jul 2025 10:27:16 +0200
Message-ID: <20250730082725.183133-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Encapsulate the calls to writel to enable and disable the PIT module
and make use of them. Add the missing module disablement in case of
error.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 96377088a048..609a4d9deb64 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -13,10 +13,12 @@
 /*
  * Each pit takes 0x10 Bytes register space
  */
-#define PITMCR		0x00
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
 
+#define PITMCR(__base)	(__base)
+
+#define PITMCR_FRZ	BIT(0)
 #define PITMCR_MDIS	BIT(1)
 
 #define PITLDVAL(__base)	(__base)
@@ -52,6 +54,16 @@ static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
 	return container_of(cs, struct pit_timer, cs);
 }
 
+static inline void pit_module_enable(void __iomem *base)
+{
+	writel(0, PITMCR(base));
+}
+
+static inline void pit_module_disable(void __iomem *base)
+{
+	writel(PITMCR_MDIS, PITMCR(base));
+}
+
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN | PITTCTRL_TIE, PITTCTRL(pit->clkevt_base));
@@ -254,11 +266,11 @@ static int __init pit_timer_init(struct device_node *np)
 	clk_rate = clk_get_rate(pit_clk);
 
 	/* enable the pit module */
-	writel(~PITMCR_MDIS, timer_base + PITMCR);
+	pit_module_enable(timer_base);
 
 	ret = pit_clocksource_init(pit, name, timer_base, clk_rate);
 	if (ret)
-		goto out_disable_unprepare;
+		goto out_pit_module_disable;
 
 	ret = pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
 	if (ret)
@@ -268,7 +280,8 @@ static int __init pit_timer_init(struct device_node *np)
 
 out_pit_clocksource_unregister:
 	clocksource_unregister(&pit->cs);
-out_disable_unprepare:
+out_pit_module_disable:
+	pit_module_disable(timer_base);
 	clk_disable_unprepare(pit_clk);
 out_clk_put:
 	clk_put(pit_clk);
-- 
2.43.0


