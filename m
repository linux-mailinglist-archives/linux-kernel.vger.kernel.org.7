Return-Path: <linux-kernel+bounces-755394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A086FB1A5D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE62117FDC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB4921ABD0;
	Mon,  4 Aug 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVpfkqXp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAF26A1C9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321043; cv=none; b=LOT79ITiZwz6Fh/4L7Mw/HGc4BhQO6a/lVNyuciHQLr5Y4LPVFPonXmx5Qd1xYVpbNbtlIIUOH0Rj0s2prtywH4e7BzhX502OsyLwwDpNMrca219i1h6PUyHVF4JDPlmMy1q9NiUSgvlabNYgwHc78IyBUVA5NeCMgCxYZQIP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321043; c=relaxed/simple;
	bh=06rifj8MWfYgbrnM4LhpqBskPUPXikO5B7seRZV1jtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ9U9iAKDO3GTQ9g0fzutN+Y/M/9K3xYbPRN9TC8tvmW+rZZxJD78h1I2oTtl4ZytlgASEETh43U4zyx92DecCY5oGM8yTpexrHt0ceEswo7J93gdXGU5XtAjYWT8c2TW1WYpjQHxtnCO94BrI4oUhLwZeQ5UVy01UuDCK/Wznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVpfkqXp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b783ea5014so2005070f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321039; x=1754925839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V0TxbQkV1uVYSYK2Miyy3vCujOd6QCIFmu+E5maDJc=;
        b=AVpfkqXp956Sp4rOSfHil/FSV6Ii/KEiTCx/kSUHyYDcMQIlr1qJtYtzESeNUM5pC6
         NkudxnTi9/C44NytEMpfLnRYns1ooOSZ3FUCEIxQZXPvWeueeoy+XzY7u73viAFlwigs
         GtwRNlQmNGeBzd+tfoJLvI5DkGk7oQAJt8TCDWUQN5ByIY0Kv7wxLVJxzX7j+dCNVAEY
         svsGe/rMqpLs27QNXrXsRDwcy5WgIsHqFrG+sHcISkIfBoQSE/SXghVLp7+QKFUH5Xun
         iFIf3wDfmei02HKZvsuYmQz5dPDViOECEZ1O5cJNQwJPBna20Lr2DIOiXMNlvfTTz2TN
         NdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321039; x=1754925839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1V0TxbQkV1uVYSYK2Miyy3vCujOd6QCIFmu+E5maDJc=;
        b=iMFmPIz7oHrmssOEWsd/Zvp0R78WnlBkVMhOBqvRoRq9+j6sUIRdjpsMG6peorqTWH
         ycKnmVQJJ/u5ce+ZrN6qP3/sRXaHtGDPpQiiz210Oi7GmUH/9p2Vz6WPKM5n6GeVuv9E
         GCc1Q/B8i6+uk1h9exR6el5w4aXMzE1XSLz5KoBXWUgesZWTyXX7Z6svz3bT3dEVMHtg
         fGyZe6gDLpB4wYv0fRctFplkfVq4QL+3RfWhit/tny3aXGwbp5TO6gX8/Pjy5Zn71q4D
         L8FUrvkBF9ibXBZihV6keccNDMQQp5FuBZ77SMY8ANnScHOovF/ztbV8DOETPlCeNxR8
         al/w==
X-Forwarded-Encrypted: i=1; AJvYcCWlufhy/U2jwZMWOQTReTuh6h3d+X8Hwygd0hcdWlg3gGr1armIpGAUEHRiFYug8rXKhKgBBHk7amGuvIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/vusMLJwI5qfcjMRRWvo+oUycUoE3ZwBRBTL+VOMMICpa/tz
	ImaQTOkTm6KHHQSpz+IdIckB2LTzDXiUgBCyH59Tdq7F1wh/QSwdGIVidjKjlSxvoUAbNrTQyme
	K9h47
X-Gm-Gg: ASbGnctw16+pZFF6PLvyR4P+33mpKO22z9W4sXn6GLhigLIL5x9d8V0Iec2lVtiu/EK
	PFJhAsMGd2O8mNvlrswdJ43XZ3DAuXtp4N1+P5EZbiXHYlP8SLD4G7WiTmikItMZL50VtQjHWuW
	TH/wRIoXuu/V2L2RcLHp5QibJAsbIvjgT2cu6pj9gG4zZR0N57x7JKLPJ3Xi+2P45f3408y1HNv
	4Zlum8ORTimtNZHgb7thF3xvbkkJ7GfnoOdlq2TMHUdaSDxYAdcYDP+V0S/2fF1xttMqQj7rHRV
	Kv0ucmhWf/H7dkEPGD5X3pSCUJf2iFyfInfgEQc7gWNmxwP23lM+ldjP/tzp+ydzdTYIndCutEV
	k3gdIdXZGLHnS1gBGkHeQTAVOmfQmuIjha0q0qUNAKCl49Nf1
X-Google-Smtp-Source: AGHT+IHAJ1jjB0asHcbTf5oUf9fJYyZmwjRKmnudmwERLFJo7oUSpblye2tkSQq2HhtZNT9c6y8CWg==
X-Received: by 2002:a5d:64ce:0:b0:3b8:d115:e6c7 with SMTP id ffacd0b85a97d-3b8d94aaac5mr7135812f8f.33.1754321039532;
        Mon, 04 Aug 2025 08:23:59 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:59 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 07/20] clocksource/drivers/vf-pit: Allocate the struct timer at init time
Date: Mon,  4 Aug 2025 17:23:25 +0200
Message-ID: <20250804152344.1109310-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
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


