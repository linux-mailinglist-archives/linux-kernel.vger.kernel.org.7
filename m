Return-Path: <linux-kernel+bounces-750371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A382B15A95
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BF47AEECC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867792989BA;
	Wed, 30 Jul 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZWnq+nm"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0529614F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864114; cv=none; b=I86cBgaSMTnVeInvhoDL9q8Vj6be5Ju6FzieNkr52Bwg4iHb1kQIKVdG7H+PPbLcYIRFwE6Yy8X503bVAmw4zRvFzUaEbKXYcuhtIBOR1hVzp1A8/+IECmUjSdEAWc5CzBeHrZnqEGX5X/93eR8LwkDs3ODMEPHWd9aZpmVminA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864114; c=relaxed/simple;
	bh=p81EulUS9kF/MLITjT7DPvMr6vmlQKnAjjWftNap1A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGKGIA0LJg6x61Yy/aJkXwM7rXh3Okv11S0WrzDMcXBgtgw3lnicxnaiqbpiU8XgCfsqhpCTsYTY7nQ6ZMkm5gHThJ2d1b8li7uMZObqzuOJfNPG1GfsjaLe/doALV1wBcaIadB58HCxZZavsvHmvA78TIjyrqZWpXQeno4DYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZWnq+nm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45617887276so36937465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864111; x=1754468911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ryA9faGluqwB9+UiJW8cuMQhTuvfpb1HZM4cTkE7E8=;
        b=wZWnq+nmiybj7qXnRbWie31+tyx/V0+HsEoeJu+llzCPh9uRxrxYTOJVV4inwBThxF
         /7wJdJspp4HEaGcyz6Efyzcfn2hx/OaIOMuQca9SRfW3BEgkBtvWbpLMjmNyJoDWm705
         PmF3ju+WTHqXFzDVB9e0WhrZnmPyNA72thV+EHO9klW7cBCI1Bl/mrjp0OYtFcG0vcW3
         6lvvDjw/lgj1YMJY9wKKt9POSoUXws0W0+J3UfI1w+HDr8G3ArUb14sDWi3X+t0DQ2qN
         MNIKFPVSu6XdVpjrR2Q6bn6TY++RKe33ByoeELcZr9JfrB0PPBI2nT7YuzhttpH2Kb2t
         ER1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864111; x=1754468911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ryA9faGluqwB9+UiJW8cuMQhTuvfpb1HZM4cTkE7E8=;
        b=vgTEBlwQKJkzzZfewi8vAUF5+fzZHwgADtsIGTsJfeaz03oiTXu/efkiK/30++NO8Q
         vhZGyh6y9PW4SsTbfAoMpKvBxsBrM8Tf/6Lh1TgelnpqXd6GQ7Bw3xC3IkKxUTOy17Ad
         AJlZAQr/L/Kv0au09ygRu6qig8M/kQbW4jIX/loSBAy4gwZnkvl3IKrNgoPIf9W0lrqA
         6RpkEtIkg+hwi68E+a5hZ40lOi6aANlXeowsHn4r29BRdt8Tic+i5nRMnCnh/G2TKF0r
         Vsem3yHS/zh9KOT3J2+xrwITeTHFx48w5q8PzqloscDXck3A+xUL+yiFUCrD4Hv0AIJq
         7WUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgY49kpUNNH5pfkVxai0Nn15ZElQAgHs4nP/ICfUCOJb+b2jIV9T0qrtiIGPHX+6DpgOH+DdwTVAlufZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFR4MSfxivX7QDuiAdAcK+15MHGgnZwra8ii8N3nSwdCP/8qY
	/7JgEkpUzB7RpHT6Z7k4yGOpUwq+freqsOLy/b6fRMIrtf5dcRBot3i5eonb8/yhuW0=
X-Gm-Gg: ASbGnctHZtgjQMlCX0KxTPaUqQ4Ha8RDQAIB1QUROXQ9rSl7ilrRZpS5rpUnMtJ7e5v
	MWh47KO4+6oJ0pMvvKkv5GAq9xtVDbxJ64j7GlZDwL1H//3tkCCH5ijGaDg0oM+tBitp5DwTlnl
	aISYt8OHz3GDnaOUbAgFpjjey5M5AAl5khNkZQnTln4DL/RcL/VJnkwXJZMyNDJGPrYzNAkpcXy
	mdSCRE7GAvw1hdh2eAWzuPGfgyKBafqm4z/YTP2Kok7kLzO4UouESyyPPzN1OEif1d6xf8o+H+t
	Jd1DX2crLTgKrkBG/vxVlO09FKuMcsgjOAeQ5kfFbrUuwkBv+05Q9TBLpIKsJq82U/V8TsmkHZV
	m41xwW5399/iQwX6NBxkumad+LCt2Q9GagcfI1Wm0Hs1UJ56Y
X-Google-Smtp-Source: AGHT+IEixMp6FD7BcGSeydMLJHt2w82yBv9g2S4XN+mp89/5i5299FHYC4l6YnQGbyMCqpqrudZlbw==
X-Received: by 2002:a05:600c:1d1e:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45892bc7b07mr18441125e9.20.1753864111540;
        Wed, 30 Jul 2025 01:28:31 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:31 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 13/20] clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable
Date: Wed, 30 Jul 2025 10:27:15 +0200
Message-ID: <20250730082725.183133-14-daniel.lezcano@linaro.org>
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

For the sake of lisibility, let's encapsulate the writel calls to
enable and disable the timer into a function with a self-explainatory
name.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 2a255b45561d..96377088a048 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -62,6 +62,16 @@ static inline void pit_timer_disable(struct pit_timer *pit)
 	writel(0, PITTCTRL(pit->clkevt_base));
 }
 
+static inline void pit_clocksource_enable(struct pit_timer *pit)
+{
+	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
+}
+
+static inline void pit_clocksource_disable(struct pit_timer *pit)
+{
+	pit_timer_disable(pit);
+}
+
 static inline void pit_irq_acknowledge(struct pit_timer *pit)
 {
 	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
@@ -95,9 +105,9 @@ static int __init pit_clocksource_init(struct pit_timer *pit, const char *name,
 	pit->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	/* set the max load value and start the clock source counter */
-	pit_timer_disable(pit);
+	pit_clocksource_disable(pit);
 	writel(~0, PITLDVAL(pit->clksrc_base));
-	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
+	pit_clocksource_enable(pit);
 
 	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);
-- 
2.43.0


