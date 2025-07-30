Return-Path: <linux-kernel+bounces-750365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F7B15A92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC11B17A0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CE293C5F;
	Wed, 30 Jul 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQ0Vuc6E"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB008262FC5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864108; cv=none; b=tvAXpv4GAF2/JHVPK/NQHUIJw73yTTU+IY29+AEv6SIJYZfKhJhe94jdN3G9e2fBVxHk0j/v7olnH4xBAGqubypz01tD7Y6CTwNScaKDLrwNl2ri6b4fMH6A9pTWqwL+xRcHKeAwDLJThiecLaO8Ecg3NNc1N4Q4SeRvqUFWjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864108; c=relaxed/simple;
	bh=06rifj8MWfYgbrnM4LhpqBskPUPXikO5B7seRZV1jtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heX2Z9M8RRyvPMoan5QzGLcEw+GcWH0/BoO4tMsIvDmffTQDjDVCnDBhPKH4tT7FJh8p11ECICFU3i2jEtppXxI0085Xd7b86tWuf0XlrtaFiKYnvmdALtB1HtXWF2cocx4X867PcmRJl53LK09kYyO3S5KaGk0PZ2Mmmrom47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQ0Vuc6E; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7886bee77so2735630f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864105; x=1754468905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V0TxbQkV1uVYSYK2Miyy3vCujOd6QCIFmu+E5maDJc=;
        b=AQ0Vuc6E8KWVup1ThN5ZAoqD562/dgVKIaMFybVAXNVvBoFK6qQe8QgEkeFyHMgzq7
         FQShCanaqB+mQR4xmYs/x+vBneP9xSXtPQacDp3foJK0geeabdJfsQ7XNvbi42+IMTbe
         4SX5f4RxvFHIfGUn/CtuvHZh+/nDbVvrx/fiQ2JRFU3rzTD5BRcoTMaSpsWMW4Ty0oLW
         CuHVOsGMW40ZujoEERevca8x96CdHb+ZNS8mpc265Kczaa0g4o4Voxc0uj6q7XRNCDSL
         0dlDBpvHmqOwQ6mrY+8CAYceJK0xfMrbqvapWE7/+RzMssl0UmQ06ZzLIRFkffum1Sca
         3qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864105; x=1754468905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1V0TxbQkV1uVYSYK2Miyy3vCujOd6QCIFmu+E5maDJc=;
        b=vIZw1K6Zgwi6dH8qi4Z7muf94z3/nagMhtUCxA33j4irNmHpbop+Qa+0bEtNNIylgx
         3aeC87jtvvj2NE3lqX1u8gp+PUZ8fbQpU50lLYeubE7vfMGcSABzMda1DXEFV7k8gijm
         JXgwbjattOSRIACpqVOQ2cAdGYJj3gXlt9HEb+DFsrIIx9B0jsYsBA7pZYgci8R5FFpn
         NmPkfsFZ7n+mizPPkegGJ7xqdKmrqIDIlgWG8wVPy1djjy6p3fwJXCK9PSyuHWh3IRKx
         ImT18j/STc0o0eGSlwOeTNpHDR5vSpNTCF7Dn/Gh8KgaTF8nyi7XB1trk/u81GQ6c5OA
         OcGg==
X-Forwarded-Encrypted: i=1; AJvYcCWRDDoxixLCSogyAfz8M5YThehva6/pccnfsa2dVQ3PC4/FvAKikCxh+e823/dd7t9RHZ/BbzcwMXOzduQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Q3skKQh7JiaEgyIgH8pS6MCPyDdKRk/t2xoTrFErEL77McVd
	h8ePe83VrYenbpsIoqvzbx1oFLqv1vbTL0gdehs5UxKf2tyVcGudxzWDS0RBqDUFDmk=
X-Gm-Gg: ASbGnct1yhUBzYHWgPPGVwWOmCOBxMM5aup3DWH6aMYBTgApv1PEXbLE5gd5bOn2zJH
	8c9BdTDS5RcVnB4fuAAflkewIO8NWcVB4BTCl+OdB56p3nQ1ui0T0vi7BLZkNzfWIdWUJbhQlqy
	SthYPdzsm/jfZ0UbLqSRXZ1DlniH41l4sUy2AT3xoOeinl61qob2A/2+SVSpTdcQCvHSNFoUrun
	CGCJ0M2mS0RdAvWuxXyl2oVcpvgk0bMfKB7J5tuVbuCps9+l+ttOk+fr9UecTVYp/OSS9Op304Z
	vKyqwmrypgHsDiYBHzaDqotSzRlqj30ix3gKCHyY6kIRimuaI5/EKnIJsqAV6bJwVBm+XeL4GOU
	E+qYaTZy6BDnsRZCsaOvdDm2WAHE9pqqwx9qXIgbM1T/xFB6/
X-Google-Smtp-Source: AGHT+IFT6B+Q8i9GH2k9HX5AmfcEo+1tdOxxBgf2Nqv7hC8nxUPkpuMeDy7glN5SgTv02sYn7Hte9A==
X-Received: by 2002:a05:6000:2305:b0:3a4:ea9a:1656 with SMTP id ffacd0b85a97d-3b794fe4e57mr2001091f8f.10.1753864105432;
        Wed, 30 Jul 2025 01:28:25 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:24 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 07/20] clocksource/drivers/vf-pit: Allocate the struct timer at init time
Date: Wed, 30 Jul 2025 10:27:09 +0200
Message-ID: <20250730082725.183133-8-daniel.lezcano@linaro.org>
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

Instead of having a static global structure for a timer, let's
allocate it dynamically so we can create multiple instances in the
future to support multiple timers. At the same time, add the
rollbacking code in case of error.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 48 +++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index a11e6a63c79f..d408dcddb4e9 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -37,8 +37,6 @@ struct pit_timer {
 	struct clocksource cs;
 };
 
-static struct pit_timer pit_timer;
-
 static void __iomem *clksrc_base;
 
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
@@ -189,38 +187,66 @@ static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
 
 static int __init pit_timer_init(struct device_node *np)
 {
+	struct pit_timer *pit;
 	struct clk *pit_clk;
 	void __iomem *timer_base;
 	unsigned long clk_rate;
 	int irq, ret;
 
+	pit = kzalloc(sizeof(*pit), GFP_KERNEL);
+	if (!pit)
+		return -ENOMEM;
+
+	ret = -ENXIO;
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
 		pr_err("Failed to iomap\n");
-		return -ENXIO;
+		goto out_kfree;
 	}
 
+	ret = -EINVAL;
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0)
-		return -EINVAL;
+	if (irq <= 0) {
+		pr_err("Failed to irq_of_parse_and_map\n");
+		goto out_iounmap;
+	}
 
 	pit_clk = of_clk_get(np, 0);
-	if (IS_ERR(pit_clk))
-		return PTR_ERR(pit_clk);
+	if (IS_ERR(pit_clk)) {
+		ret = PTR_ERR(pit_clk);
+		goto out_iounmap;
+	}
 
 	ret = clk_prepare_enable(pit_clk);
 	if (ret)
-		return ret;
+		goto out_clk_put;
 
 	clk_rate = clk_get_rate(pit_clk);
 
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
 
-	ret = pit_clocksource_init(&pit_timer, timer_base, clk_rate);
+	ret = pit_clocksource_init(pit, timer_base, clk_rate);
 	if (ret)
-		return ret;
+		goto out_disable_unprepare;
+
+	ret = pit_clockevent_init(pit, timer_base, clk_rate, irq, 0);
+	if (ret)
+		goto out_pit_clocksource_unregister;
+
+	return 0;
 
-	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq, 0);
+out_pit_clocksource_unregister:
+	clocksource_unregister(&pit->cs);
+out_disable_unprepare:
+	clk_disable_unprepare(pit_clk);
+out_clk_put:
+	clk_put(pit_clk);
+out_iounmap:
+	iounmap(timer_base);
+out_kfree:
+	kfree(pit);
+
+	return ret;
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
-- 
2.43.0


