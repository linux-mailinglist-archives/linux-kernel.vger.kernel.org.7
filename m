Return-Path: <linux-kernel+bounces-755401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D01B1A5E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769DD62376D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A0275108;
	Mon,  4 Aug 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUn+GNYL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56897274B50
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321051; cv=none; b=LSVuRFiQEz1HbwU4RXSY7PNN4+iZz3djvkzO2IW0uhsvL6Dhp9cIolsvdEseFzEUyfziZDe7xFKbuqHhprsqOrpaNX1mzj9+8q0WobwSDRW4/7VAIl/CyFHRWfdEFx10NxpoenlGaToREqaxeCinm9mtnsZD7G2C7z7QdMcEke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321051; c=relaxed/simple;
	bh=Wk97buN0o0oO5Pg6mh3j5DzY8MUEjrw8kChllVB2Vhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aF1XIUgB28Pbr1BpNJtggpNbRDmRY0J1YZ7hQdCYEoNHniGwuGB92Oz0VddFByDh1BIk144fEj1mrF0p6xDqB6C8Pd4E3lAos4LWAVjvhwvo9LwRPcZ6wXI051jt4EZk5STMbMWw+SRY1q4DsIWz2iUZfw+7cCnZfdhRU31/c2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XUn+GNYL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b79bddd604so2970694f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321048; x=1754925848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNIZRPL/aYSMg8EX0aeqcrIzm6PwgSE5iRtD2jvvxVY=;
        b=XUn+GNYLiJScE2CvjKCkJvo0napo9ap2VES39wo3/0aE79FzQav2yBNWDuZxMqm5ej
         LPpmzlc1vMu8ry60C9nexDUzBvFg6UsHDpUltqmznctC89mU/QHxWMljGhSx0iN9qNRl
         HfMWywD4ZNnPlxx5nQUR7qKHefhpL0fxNB1BMsH6kpDkc+erm5eMhlGG5VVK+sg+m3Zk
         bIv1cg+cxclke49TDYZuuPH7FfRdUAUp6FUotTKvgQfyUkaOEINl5gpZxUKrJ2tZVedh
         wsa8GwKcaIQiGgmxAk2I2gf8xJDaQ/LapygQAfpn1D8NC5T2QzRRMviNaZypfOKgsltE
         M6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321048; x=1754925848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNIZRPL/aYSMg8EX0aeqcrIzm6PwgSE5iRtD2jvvxVY=;
        b=JyHXjPySSZIB7AaIkwSbJ5Ae/HEfYQDpTQQuaF9SFTvFsm7s9nYmdVS52XxoNWjLjt
         W45FM5Orz0G7F6dZaGDourApc+cF+bF0dPHyTvZK4W6YmQR6WpIf9/gz1O1eXMwoI4K0
         PPxOuQAt9Ksxtn2rZ/GuLbF60d6BWFpf/wIZ7aSN5UXmj0QOShsny2Q6/uNlvTn6CiaU
         5vE+yXVMJBcyicMlmkLv0KcCBJORzXtpyvegyVNIV0uRelqZwmHSHqmUAyWX0h2WiKOS
         yN+zJGxsNDS19GDjFCJrujahE5jwL1CHVVhm/Za55nqMBxFZWo8nmw5dDi/a35nqcTKp
         pJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPtbdmgwy5MsNabV6GYNXchHnNjYvtIvi+59/LH/t6AhsO7k2LQSRGqIKlK9em58DAuCI1Ii12QH6UqHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTv6Uo+SpS4m0bH/VV4vpd7Ky/gsJkCpFKenuZO+SAGWtLaA7
	d3Jya2L7mTyo9nfXCr8qjVZDkhno81m3jAnJhIDcOElFWfl5rmOrt0GyNcdqE/O0qqXtOOJsG6C
	LX/ah
X-Gm-Gg: ASbGncsmtt2FGIJCqnZG5fybiwOEodiCieRwZG5wTTFbhcdE0efdlMqiGDOkD1TZjnZ
	Kex9NChKz7xlq36hJgmbyFzf7bQcfwPFO98ilCSarNoDwRI6zRfXqTAIvZlV5fE9xbzFNQLFg1m
	AHGh3N5eqa26HClVaIRxzu3oxKXhh3Bgh0jmg7KdvINXb++0KfBk/RHcQHdKZybzYPmQ/79o0ST
	fWrLSAh0TuHU485mpOSZkIYRoPf/5zw5d+gRteT1rHSM2P7wj0yviEacP27UsqDm/0njn0YuQ/n
	ODgKwFmgbmnh4qY1MEnE3iCPvtrMl63PnReZdcUtiVe7LyTXX4JNtpJF4pzpSHr0Papodab98EE
	HK9dfAyFah65D53mFa/+gXlc7GX9OnvJV9CZ6Fr6bl0djczY5
X-Google-Smtp-Source: AGHT+IFgXBG0bwfd21xHT+0pHFBUO4DlZytD31YXGFW6NGTAxSSO3sX4k62sohLMZl5R6Qp+q00o9w==
X-Received: by 2002:adf:a30e:0:b0:3b8:dabe:bd78 with SMTP id ffacd0b85a97d-3b8dabebeb6mr4342668f8f.54.1754321047532;
        Mon, 04 Aug 2025 08:24:07 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:07 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 14/20] clocksource/drivers/vf-pit: Enable and disable module on error
Date: Mon,  4 Aug 2025 17:23:32 +0200
Message-ID: <20250804152344.1109310-15-daniel.lezcano@linaro.org>
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


