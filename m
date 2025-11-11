Return-Path: <linux-kernel+bounces-895780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28647C4EE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 914844EA710
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3BB36C5A4;
	Tue, 11 Nov 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZp4HGLR"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D936B073
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876597; cv=none; b=bEsoc8ZSpbppL0BszlfXjT1nDOYbZnnjN1V0T1bNTeMTNwvmiELX3TsFy2+Q8Jcosu2bpyH3O1fWFyhXy0j15csTADexJ0bJ5HIHw0gIUhQCmiq1cqJ1sdKcppZ8GlQlXy7fAk/wUhh4wUR3ujGycrasFLpiWztpm7PMny2jTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876597; c=relaxed/simple;
	bh=I8gVSNxw2aOO4ZdP0s2HcOB6Vs9l7ZVMP8y4tYKEw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiipPjkv28FRxNJC7cIgLjbopOAUBtuCfObTb37ACjRqP4Zw1irxMxEAmOpaSNPaD5ARXPpZPOsB2wcEKBc+cvNAFQ8/+dSaohl0rb7gBkTaG15yTbSA1N62FLHqYAXVRydXekfS1UmP2INP9Mi6vyImKkJs/prdPN3WeRtXMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZp4HGLR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b38693c4dso1427861f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876593; x=1763481393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l76VTWaL5JNJWQVkhMGxzjJJc96x+kz2NkszPplq7c0=;
        b=ZZp4HGLR8arYZ/gfY2EfteuDWGLseuOpxdr5xLQS+LZODQkb5OhycKOE7yuk6Ooxg9
         gVuYiQ1sHdNa+aDZDTJmytTPQAntLpSm573mF0B/jPUblne9Z2uECHQdces8FK0Zy9e9
         pUVAQFZ7ENkd6WCcOqDVNpuTrmHIVNoKqtVY0av9x/Z5+xOWxnT1ZF1ZY/ltux+OQuVc
         lj4uyqxCIJhG/hFOHEy/QyU3RTy7kH6wiSqbiDh4DTzeHo1MG5le69BgfW56FzkpIdtN
         nOs34CPd9YWydBKDYvaoj0+c8eDibFrowhNibKZ/+mtwaaemNjLhkd+KEj/QyA2diVuJ
         7rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876593; x=1763481393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l76VTWaL5JNJWQVkhMGxzjJJc96x+kz2NkszPplq7c0=;
        b=AWv8wB2QSUXoXKL6YlNssHVJzmRZu07f9JISUJjnaWIgiLdA0vGi6ikeicn8AlAny5
         ICnl2DsvizBj+zLfWP7JVvYV0FskZBeThoOqhgf5IEUKAdyJbh8s8POTgEcPBuNWA4Qu
         9sST802nXdXeQvhkk6cbI0pcvf1J4z002daC55pCooE6yl3k2Wf/cXtyYUd871mXgafD
         T6SyTGJqat1r9pfeqd42b3skgTbuKaogOFSB1tFPEC8CFSSN8tHRWfQn8jlz005t3kdL
         FPdse7jsVRYeFYKPbyKSqbfSD4AM2QTozZr/Rs4JCshjfxMO4sCuoIm1EkC2MW9YgkTe
         2irw==
X-Forwarded-Encrypted: i=1; AJvYcCVJGkoWrubsBhkTGTIGWyoSUa0jy1cX82EtqE3/Va2Vm9CQJ9fiMbZ+oyJuFhBIZP6NpYq1Lu97IBUtdes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQRDp3Jl8GFN4/yVyJ1V1CnpwnlVIhCPE9vPlOMvxXrSrmd3u
	mn4VltUz2C/mkuEjhuwXGB3QfPxtKP6sGWQv0ICJXcoytHdRW9qFxH48
X-Gm-Gg: ASbGncsiYZR/9mFDX17BchtbWyaDCjm9BplzF/GXb+stZ1LvOVoCj4pggZgVAdLJcR2
	2jEbCycz1B8kKVOTr52sImAJbnXC6+xXtxqap+/G+h3YYq9JW7jBU7lm5ySZhro7/eKVf9QBzFv
	OyDjoixYvMPZWwXJSHvAUBaQbreYSPxkuIsutk/dcQcBO4dJngasgEJGliGYOLD15XZ87kG1R66
	3y7Bmi8hpBKIHQaecTOwqnjhNPaZRRvr+zn/Gzm25mK+A683W64u/Lc7D1S6O5u/oNwtBevFdKX
	exj2G26i7pPWKaW2QZPdwiCtv+h5l/9mdJki82bIGiKRQDImixaW765pVZYfJFQ4nsqgZZL1PMA
	N2hMrlLmLkgxQ7QCGpT5bd4PB3mt3i5uvJQ7exIGSL/h3MyD9CbUQbR0L4/5AMD/0Oe2c+WJU95
	8OlZnpb41JOO5lmDlmuOjM5VFwgsY5og==
X-Google-Smtp-Source: AGHT+IGrlsOxD3VvyhNqHTYmqSwZXcEDRU2mam9V5xs1eNPMUgYcK58098Bm6bZZtgLeXYdOtcLo1Q==
X-Received: by 2002:a5d:5d0f:0:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b2dc6b007mr11397434f8f.58.1762876593479;
        Tue, 11 Nov 2025 07:56:33 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm28676766f8f.19.2025.11.11.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:56:33 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 3/5] clk: en7523: reword and clean clk_probe variables
Date: Tue, 11 Nov 2025 16:56:19 +0100
Message-ID: <20251111155623.9024-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111155623.9024-1-ansuelsmth@gmail.com>
References: <20251111155623.9024-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework and clean en7523_clk_probe variables to make them consistent with
the rest of the source. Also apply some minor cleanup for pdev
variables.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index b040f0f0d727..d98990a157d3 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -700,25 +700,27 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 
 static int en7523_clk_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	const struct en_clk_soc_data *soc_data;
 	struct clk_hw_onecell_data *clk_data;
-	int r;
+	struct device *dev = &pdev->dev;
+	int err;
 
-	soc_data = device_get_match_data(&pdev->dev);
+	soc_data = device_get_match_data(dev);
 
-	clk_data = devm_kzalloc(&pdev->dev,
-				struct_size(clk_data, hws, soc_data->num_clocks),
+	clk_data = devm_kzalloc(dev,
+				struct_size(clk_data, hws,
+					    soc_data->num_clocks),
 				GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
 	clk_data->num = soc_data->num_clocks;
-	r = soc_data->hw_init(pdev, soc_data, clk_data);
-	if (r)
-		return r;
+	err = soc_data->hw_init(pdev, soc_data, clk_data);
+	if (err)
+		return err;
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				      clk_data);
 }
 
 static const struct en_clk_soc_data en7523_data = {
-- 
2.51.0


