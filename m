Return-Path: <linux-kernel+bounces-729745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD852B03B08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F58F7A46FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6D2417F8;
	Mon, 14 Jul 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="n09VUg/k"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C52417D1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486029; cv=none; b=vCaDQTAAp93f9kDxBUr99tcQgoNbW0Hz6vulvsO/0CN3BrVvNob4KJOhHWmUf+GpxtfLSD1jtX1eWWclj3MfGhK9qK+OubYv7XkyLSc8CDx7NtxGcqvgz0KeG827dFLDzi6XeJJ0+4gVwhre0v9m6RM0RScRzp2YOvpMFffwiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486029; c=relaxed/simple;
	bh=fAjYUeW+4LAGffwsSutY6W1lwq2EBQZzUiZY6gVtC8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IScva2ewcqVdTvDm8g5xlruKoZLGPXDQMfuQ8Ak9U2y6bkr6wdV7su/FEMnu+UaV2iLfzYOIGoM3M9W6pqhhyhK9w6VYG/Y0c9D/ZXOoe4m74eDdec1sn6ENTpVgR91q+5AWy+5NXa2XBHItMLYNSz8clg7r7rePC8BfwWb4gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=n09VUg/k; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a528243636so2147212f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752486025; x=1753090825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq1yIQl81CDUUjvpmEnXhN2Lz/OlMt3l5QjMkKHWpvM=;
        b=n09VUg/kRiQ7MmyDt3GYMsn/4SkcV0vJmf2K0T6FnaO649i/AZxKRIjUVaSdlrLMVK
         xnSTDndkafym6RVKu//BkE321/Um78hVIpgEfMlwowKOQ/SaL7kzxCr+4LQQMjCyBkTp
         +IBRstzRGpW/ZQOJ5utCjtnzpEF9Ag7A4CnFOEQcuOQ2jIbE01/p1CTjG3uqGbYL+NK0
         1e2ZAzMshrY4hoSMum3MeTdjxi7Fd4vTQCBxICqOTuLWcFU++UwJIHYr7y8y5gxlqjRP
         q5lkqTIlYiVkbcu2V2N/fDNsZi4uL2/Xi1pjztkYQ+TEslNS+BWbYywOeALhBaz4LB/k
         Qaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486025; x=1753090825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq1yIQl81CDUUjvpmEnXhN2Lz/OlMt3l5QjMkKHWpvM=;
        b=VhTudEM2bkxEWuEpKuNfKxlL/AUsmZRPBfpA8nrJwch8JRo/8kPXSM/HVq5FudDfTx
         FYwIZWCjcs2suanX/j2suc7ALXuWsd+lxmnKQnJJssIoigyAjnUoDMEWox4YNqY91Mpz
         ZI77tN4jFeKV88rShf92RXGvaTcebUNol+gnBC4tyCDu/5JLXRCQnn4gxvGc+cqUsCk1
         zAvTwUKyYCvcnjQUpfCRHt1OmPzDP2+6HoQQn0cLqaLuBgwTfCwPZopCwBSAkGqlSFP4
         RVF+Xt+kHIkbJ9JWWyk1EnvJDmZsoc4xFeHnCmNYKxdg7M0B6dLreYh360A67VYcp0L3
         U6zA==
X-Forwarded-Encrypted: i=1; AJvYcCWSefAL4qwyRRZYEE/lZq11B82SdSCoVMEobBnyBRIctZodn3at9xnBlNfWU+RANCEelbtWGIGUVU4eRUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60lqkBN/Lw0cEPP5haqfvzLLSqhVywCwezFLBfHOmX11hhl4i
	lrB0YaSdO2Jb/L7Kt6SvMN61xWCAMpwTPjQak/ikxNj+Ky4+1w4XNGOarokP3XsorXg=
X-Gm-Gg: ASbGncvq15/zRiUhlroO7PXA7Kj1jqJelHepWgeyMMEFZ+rzkl9jR+rddXh/hReA0rL
	tpTllTiDtz7kLy/1siuqL7AkjoNDOjHI/WVtOiUTFoKdo7cW49wAGMELv/H1zZpw4hWibaM3mkS
	tFFalgGNiP9Q15A4RqaS3g7Q8FnefuOU2udIB8dfTsftcYYx6Yrw3lOmJ1+cl2O0iUKd/ji4v7K
	k815D+T+1Q27nmitOhudZ3ntUdCvQm5hg7gmZAL2P1Xj7mfACp59ZAzlhwJ12g4Wk/m79eukOgQ
	Ottk6pHKCQtxnwhLM8VcJ9Ao7EabYLXiBP1/aPXlkn52JBdRNczqb2CH/4272oGgJBWKsvHxUw=
	=
X-Google-Smtp-Source: AGHT+IF6lJB/75RKuYglHguDkP/WuOKNpgun14Va/8fXDBRY/jjqffgn9QMUWocm8IuxU0KZ4gL2CA==
X-Received: by 2002:adf:cd8f:0:b0:3a4:f55a:4ae2 with SMTP id ffacd0b85a97d-3b5f18d9986mr7801135f8f.50.1752486025115;
        Mon, 14 Jul 2025 02:40:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:0:1:2::3035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b25a948sm24989035e9.35.2025.07.14.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:40:24 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 14 Jul 2025 17:39:29 +0800
Subject: [PATCH v3 2/8] dmaengine: mmp_pdma: Add optional clock support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-working_dma_0701_v2-v3-2-8b0f5cd71595@riscstar.com>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
In-Reply-To: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Add support for retrieving and enabling an optional clock during
mmp_pdma_probe().

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: No change.
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index a95d31103d3063a1d11177a1a37b89ac2fd213e9..4a6dbf55823722d26cc69379d22aaa88fbe19313 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
+#include <linux/clk.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
 
@@ -1019,6 +1020,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
+	struct clk *clk;
 	int i, ret, irq = 0;
 	int dma_channels = 0, irq_num = 0;
 	const enum dma_slave_buswidth widths =
@@ -1037,6 +1039,10 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(pdev->base))
 		return PTR_ERR(pdev->base);
 
+	clk = devm_clk_get_optional_enabled(pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",

-- 
2.43.0


