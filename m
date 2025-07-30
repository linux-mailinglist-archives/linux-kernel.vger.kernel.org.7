Return-Path: <linux-kernel+bounces-750369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BEB15A96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EACC5417D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B3264FBB;
	Wed, 30 Jul 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pmi/zzt5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C962295504
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864112; cv=none; b=eGiguRbfoEb/cui1LHWZ3Uap9Y9Y+Fqou5GAX8nID6ZGKBwWgwxa8/iLe11yglaslUoZHIkINixNscpp2eOSpKuxY5yyLUVX9LfNSa+loFk4pkWACJ21YkJ9vFIjeUNOMzuvpZkvYPnfkYXEnsYk76q8rJ2s2NkuOvtKK5L5HgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864112; c=relaxed/simple;
	bh=fRVjQwZlL7pqNFytLxKtCwIXMdyJvJ6nXm7IXVR5Qpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEaSz1PiNfJLGEHLnXymJwhHu0y4VYRoGwT577ZLXQXCzEeErbWbPi63+qQGpErHQ6ur5ppLcnHHiO+y1NIusiSZaKyyipnRiKTcQaFjFGyu+HwPkMjxnmC2Q19WpVlI1Xixfjg1qAfonz12w3llyUe4kuAnA73qTqPBr1KppvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pmi/zzt5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so3903365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864109; x=1754468909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGOz47K9DNZ9k0oFNROUhK4fV3+mADVimHbCB4pz5gA=;
        b=Pmi/zzt5R8sveTYhyRbr1f0p6kWAv48Kadza0em33XqtfWO7C8hSbwzDwWpqSUQ3ay
         i9vzsSVbZ/kUyQHUC3I8XqX0+qoDpq8OSoC0vk2hk6FBPtPMw3UtIJ0XN4YfegusomcV
         oHs00qA9YU6PpGDGtDkZ3GYOAJGd3olOjM54JJCIF8tbEvnL+pjUjeDh3URG458w0yJG
         43ayo88cLSOkYmeKqQuIQ3BYP4VsE8I+cv446eKZl/mEoMdeFb3ZmUcVL9fUMBwtwbxm
         fsuaP6ykLK2PHuzjZ6SXMvg9muSi+/+0m5QpJ1uj1w8UGdWIQkyRgCwXzGRwRY7Reg1F
         gLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864109; x=1754468909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGOz47K9DNZ9k0oFNROUhK4fV3+mADVimHbCB4pz5gA=;
        b=PMQH4b+WyIK033LsbaspVaUw6I5gpccDKfXIaDbC+3cVy7daphqCNmUhb0ESmd/cJv
         GRlVVWxbaUYxk8O7RuXhr8D0OSlTFw8l5KFCqVcFaZ3N8Qmytq48X+3Xo4aVD6Iu5PJY
         Wsf4RLKNV/26N2na4xZKYmt1igOuBGmbcG3gUqzzdm7+AvdSqDpsP0PEob3z54ObrqYR
         6kv9+PVrRapJhaNewuIDusQsnIXz5WzDevUCQvVesIYE892hFLiK9+pSL5qH+J9WWSmF
         iUg9X2Jb9ClxvqUqOiLA2vFeXEC+Jo+gWlSHRPfeDnijSjgEClgiXHInuzbD7Kk1GUK+
         jbgA==
X-Forwarded-Encrypted: i=1; AJvYcCWiwi70flF0Bv2TuTjJ8j7f6LONfWuxjqt5SWlB2MXfd0PqOsvslbH1XcH7NZW6AnEcnQ4N77UiZoAywe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJyhBDhC5dUrXFzS21TVfgCAMoM+Le76eIybgaBHBraUKwrq/
	keS2+1IUsFcuGvh8nHPQwFfu89lk63zPgKyik7vxcm4RzP+dDpsavzyjxrSqjjGznX0HSBo/OW1
	/jJX/
X-Gm-Gg: ASbGncuR/2N+652ElhdVuKjVohhCDBjSYahshb8VmFqxbQ1ti8inhEuAczj7ZegvrOs
	iALxAwVzMfrVZS5hbUXYzLIMq00g24gffB89HxL+xpVbIlpeiakH7rV9SIhfVrXClbK/+qPqFfv
	Qj5e8ApJEqGdSdItY50W0GPA0lF6C6EtpazorFTfuorjkPZKEmL08MFTYrG776U3TtCwLYEiBCr
	XNz2lofeUVT09wVDOILRpoZDGEkZ34h+uFthWUbOtCoRzFwJxWjdB5BPfvM8skejqqRd3jQN6LN
	UgFXJmmcLISiItIGhilniHqGtCGSjWy1vznQ3sQw5R70brlNzYQI/leE5B5E+4p5iOrKTBvLFUY
	BAJrwSWL0z3QfYtyd9fVW8ZPicnWwzYuHt3Mwjk9Wv0Rbetp6
X-Google-Smtp-Source: AGHT+IFvZ92+pN8vxqshET9s5Vu9PkmfBBvuOQPYNIgeZ/xVDvENUDBA6gH3QEcY4gLZtithNY4Wbw==
X-Received: by 2002:a05:600c:c05a:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-4588d144a3fmr39030715e9.8.1753864109484;
        Wed, 30 Jul 2025 01:28:29 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:29 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 11/20] clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro
Date: Wed, 30 Jul 2025 10:27:13 +0200
Message-ID: <20250730082725.183133-12-daniel.lezcano@linaro.org>
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

Pass the channel and the base address to the PITLCVAL macro so it is
possible to use multiple instances of the timer with the macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 8f0e26c0512d..4f1b85ba5de3 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -17,13 +17,13 @@
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
 
-#define PITCVAL		0x04
-
 #define PITMCR_MDIS	BIT(1)
 
 #define PITLDVAL(__base)	(__base)
 #define PITTCTRL(__base)	((__base) + 0x08)
 
+#define PITCVAL_OFFSET	0x04
+#define PITCVAL(__base)	((__base) + 0x04)
 
 #define PITTCTRL_TEN			BIT(0)
 #define PITTCTRL_TIE			BIT(1)
@@ -40,7 +40,7 @@ struct pit_timer {
 	struct clocksource cs;
 };
 
-static void __iomem *clksrc_base;
+static void __iomem *sched_clock_base;
 
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 {
@@ -69,14 +69,14 @@ static inline void pit_irq_acknowledge(struct pit_timer *pit)
 
 static u64 notrace pit_read_sched_clock(void)
 {
-	return ~readl(clksrc_base + PITCVAL);
+	return ~readl(sched_clock_base);
 }
 
 static u64 pit_timer_clocksource_read(struct clocksource *cs)
 {
 	struct pit_timer *pit = cs_to_pit(cs);
 
-	return (u64)~readl(pit->clksrc_base + PITCVAL);
+	return (u64)~readl(PITCVAL(pit->clksrc_base));
 }
 
 static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base,
@@ -99,8 +99,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	writel(~0, PITLDVAL(pit->clksrc_base));
 	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
 
-	clksrc_base = pit->clksrc_base;
-
+	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);
 
 	return clocksource_register_hz(&pit->cs, rate);
-- 
2.43.0


