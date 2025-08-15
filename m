Return-Path: <linux-kernel+bounces-770188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C353B2783F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3C5587833
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16724EA8D;
	Fri, 15 Aug 2025 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MkBPYSmP"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD5202C3A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235070; cv=none; b=ph+j9E5W3BP9RBa5xzu33RYBmQ/ZJcHGMf74sVoL1NvnqXbyXftNGxMDiVXs6KWCk3LB2s0S2RcUoYxaNqVoqbibLqxAH64/u35w+FSTgeGNcmEpXzHPWEx8byz7a17qIMiKIOA/UulNC/G5yZ90NWP7DXmBBGUAjQ2ArZ5sNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235070; c=relaxed/simple;
	bh=b06tSPkNPOsymxZcIQh4cvJ5PfLzXSKhYEO4BFFGJ1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2ksmr0hQY2NLE1d3hd9kNX8y/fuMezP6c/RMK5gumjcMlZsq2RAfrnwf5Rxk80nWGcPIPJSQEwK8wdsNzgwj/gA72tWsbv8eODhdCssdaRDFH/FiM3G1EAo9WOjyiRMUHJLbtiGkqvBG8m6wdChy7O1plk3cOP1ayqX+H57RPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MkBPYSmP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e05b3eso1379192a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235068; x=1755839868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzJqrcT6Sr4Domw6gSg6TRk14H0do5SxSGJ7BY074bk=;
        b=MkBPYSmPm+vjaAtNFzPc7pasTi8HWZ+/XuqjalBCFZ7T8/hfx2Fsf3tCdwiC8wXWvt
         6QXhRsDd4Q4DBlhNfB6VlQYbGu+z1Nc571Qx8rmZdfk8QUzbvxcDE9zEuIhh9/GDhTZz
         aG79raa8e21ZjDD+X0EWPiXb6GJq+w29+47HLtN3FIYqlqCEbNcV2VCIRDfO2vJGuHoR
         gYwHCQH3m0RXlkeeP3geo4tzsjBiLiPjQgBe9dCXmhGPpf7nKthwp9k0WsfgU1Ws7Lbq
         jpK6B6zYc18WVEJ/tKJPOUv8J5hRjwzUR4V1RpI1TWuNsTuCJJdkx5et1KgCf+Oxcr7d
         vUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235068; x=1755839868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzJqrcT6Sr4Domw6gSg6TRk14H0do5SxSGJ7BY074bk=;
        b=Tmb0j1oo3FU6VV92yPuHVcW0N+PKsIPjhy9Cq0IvqdN5lKN3s47VMZsZs0HZp6IaRh
         4EvLSwg9SibQx9JppjriRqx4os39upuSGPOk3FMEc9mtL567g2/bEuSQXN0xNol3Xupp
         mDj6vQzZhMQhCBYGn/wgZUWN6IEObCOVsbVjhFF0SiXsX0HP/N5aY18JOxZ6wKRTBXS7
         Vq0iuoJ3/SJDSUaNH4g/7ZnNfC48rSMQFZWPNiUGB28IflRpUiPlL76YDO3LYkuBFgtE
         aV2kpgT2LNyBJb+fRIRCPTiSy7gFiJDCdPHpBOGI1bXdlG1uVZEEabXpFZKK1go+iWul
         P7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUMbMkZ3SNz35IKStGQg8Z42QnqePoch5BEkGVXdDmtKfxyFS3X1+wbG3e+Qmtzpwh+BFv6dG1CDCQKxxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBzapcyMmkXOsrWmRWJh5IYVR4o/4XYDJmXYEzdh2eht5mCRU
	lJ7lGSxogTkEifDXV7sVCJlLXptgxqB7XywIp2X+me0D740Lt2qYITYnxRAPmKi7M2Q=
X-Gm-Gg: ASbGncv0pawR1eDmnn/sW16Rr15qcPRmFJF1apxnehNZkJ4QQuSfa1PYRy4NuYJ3hqp
	TmcTZuzFZJ1Fp5UXubB8/Ug9QxwEwpi6/qW0h50jcU3qkxPHQXekmttoJzej3c6mShkTXdWGAPH
	3rkytj+SnphOqyeDklT8P0mYFnuPHovnmrTnyOgYAd+31gK53V3LHla1FCMIaxbcYy+yQ7RU0wo
	jD+3/fNdSJ626RNB+nkMWgVRMGn51Ox66Gc2Q9kFRDj+uAYV4DEfuI6hcX+iVaZUkNQPx8B7g1n
	OPJ4BOItQ1G7ulJLteuOZsoYIHRvmMjRoFBNFd/iJ9+evSmMCyORmCSqY38TvQZaLNKq++FQbIs
	euoFeQ7oFuIoRaew6P/QSVw==
X-Google-Smtp-Source: AGHT+IGEpJzSAAi5oYh5J4I/dYuHH3xIHOFcQzFYpHxGCez4ecdeF62QFwuHOYZn933LvQXIM7H3KA==
X-Received: by 2002:a17:90b:224f:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-323421217cbmr1522970a91.33.1755235068158;
        Thu, 14 Aug 2025 22:17:48 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:17:47 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:24 +0800
Subject: [PATCH v4 2/8] dmaengine: mmp_pdma: Add clock support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-2-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add support for retrieving and enabling an optional clock during
mmp_pdma_probe(). It is optional because in Marvell devices
such as "marvell,pdma-1.0" the clocks property is not a required
property. But in SpacemiT K1 PDMA, "spacemit,k1-pdma" as the dt
binding schema file stated, clocks is required.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: Update the commit message, no source code change.
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


