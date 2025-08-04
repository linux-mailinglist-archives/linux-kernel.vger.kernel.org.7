Return-Path: <linux-kernel+bounces-755398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433BB1A5DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A830762344D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD2274B28;
	Mon,  4 Aug 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKLhpi4c"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E327464F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321047; cv=none; b=oLQq1maceUlglsgHjLAnvJ2IxtHfp9iB3z2tOGtcS242Ed9qLQ0s6+zl/AoIEBv6UH82mHF+v7jm7JqT8RjLF34/0dwlzFPtO7E/2VXDDGd5TC0A/C1e7fnFpWo5uZH63/HVa9X0Rt9HtrLAECPGpfE3/O96UG4ZuqR3KadfKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321047; c=relaxed/simple;
	bh=UkocLxl6KmGpyXqw/UjroA7pk7iJGcfWJQV5wB1Pnl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stLbGeyLfvyF1tZvmDmknpGAwS/GvbpEhtMf0EUWG2P79cU15uqpI2JDzmTcDpOXXmQ6oLC70vvwQTDY219qZdLYMNLZKwYliJGQr5vrIw+HAgJ/IlNjqre0sJX7Eb8e4/DTj5AizrZlAvofnDfj3K0j8NJW+4BVxuGv/vV5vFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKLhpi4c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso14647545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321044; x=1754925844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QRyMK0c0loCDg4KVJ63CMEBDC8n7yMy+IKreloteQQ=;
        b=wKLhpi4cpkXexwfMAnV9PFtrxLIpDk0re+9oI/DO8zmqYqrFdFewkxu6QQNBf1X/Es
         g++Ctinog+dL+kkUdE69NR3OZduxQBEHwKYS5+37EQ+aYBjP+232gw+maWyOUPdAHige
         P38sCuuU5q2UjMnYZVAzXlubKGEFzoSfxE58FYa/9vV3stcwg/VGERyv4kNWy9OXMLPl
         udg5VV5RdCmf+v5EzrqXLRIyo8fYZrhxZYZ+I35taauot7HiEcIeiLsIPF8RA6V39/F+
         BkKFwoG3kqwhYhz1kxCWK/0gRJ+cGx5dkdnFypu28U5A5KNLB/C25h4w/AKveCfXuc2Q
         uKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321044; x=1754925844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QRyMK0c0loCDg4KVJ63CMEBDC8n7yMy+IKreloteQQ=;
        b=I8UZr515vCr/9F0ujtPGqj10UAMnGek/DY/15G78gWGtua2gRT11KdNKnm8GNQ+5Ya
         O2UD+kL0hnsd6coCvl4RxXPFecx57Wx8nkRbsTzZG2AFTnXd2+y71ZKmy5v7Tstm9/Z7
         51IbjXQSPql1GPZaFqASipau/BKNKMFyjhdTL5szYrlR7Thzyb5cI465TthXA97Tf8Ic
         P5a2cynNZeNPJ+18SobRzJc3yfcjYEt69ivdMiwfArwK53ak+0+IAmy6onTxlAN2IZYJ
         k9dkhEkzZf5HvcMnjCmUfWgXZE7m/YeUCM1n0oBwl9h3PUxtmYUzSq2SHX0k6Dz5ApU4
         84Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUe32a5hmAI/GxJW4s4TzS+ZU9melYYBjh6MPw5+JQCK32PiqsSZe6NWjz3k9nnuItVEz/b0HoWu1IxU6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynu3xnFTXvyBTGzqXgWfa8GbKnh6rKEzuKUr25MOIH6bgPMNdc
	qRPbacBlv54olprIK1GN37RB0ChHlZjTx2xtEeMiTl0SpGw2Wi3h5aVc76lnoFrDnOs=
X-Gm-Gg: ASbGncvvf/gw/nasp6i1HfS675AAAcFGchaT31gXsnWo3CVTnwnX1yhtJVBlpMjZ0X/
	gD2tw75Hw+2MsEKuqiiyqDMsLHSKY8UNCOMTfqVoZd27luMSRCZjuXUPXJ38FBK0x2o+L8kLBDs
	ysx0dRfB4urgK1Ymhg0pw+WXnQtUOCPLEViupsskzCPxgJHjoXXDjPhybpo86Qp4xrAxYVxcBhZ
	5vzgqn/IStIV0D0gCWn8GhhakPaNz5gHm51mRT0kGuSXr8feE+9dTrnT5DYsJQiYabuX5On9TRK
	yg1RGeJFoElHs9ZK2/hLzvTSgfw7epghRNXAKdd6FCUxS4V7i5dJs/N1Cv4w1NTzv6FT3fvzUmv
	rfLVQnuonWImg4W0xblBc1S6++dH/SOLSLNRh0t1kzP66hDUL
X-Google-Smtp-Source: AGHT+IHEfwloso642iQTiWgkMpJd2rbRGk0HwSfiR+10tktyKvaA1EvfyyNvbNeUpfgRsBGbnO++XQ==
X-Received: by 2002:a05:6000:2409:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b8d94740c9mr6917450f8f.17.1754321044178;
        Mon, 04 Aug 2025 08:24:04 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:03 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 11/20] clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro
Date: Mon,  4 Aug 2025 17:23:29 +0200
Message-ID: <20250804152344.1109310-12-daniel.lezcano@linaro.org>
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

Pass the channel and the base address to the PITLCVAL macro so it is
possible to use multiple instances of the timer with the macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index c81c68b826a0..4f1b85ba5de3 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -17,13 +17,14 @@
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
 
-#define PITCVAL		0x04
-
 #define PITMCR_MDIS	BIT(1)
 
 #define PITLDVAL(__base)	(__base)
 #define PITTCTRL(__base)	((__base) + 0x08)
 
+#define PITCVAL_OFFSET	0x04
+#define PITCVAL(__base)	((__base) + 0x04)
+
 #define PITTCTRL_TEN			BIT(0)
 #define PITTCTRL_TIE			BIT(1)
 
@@ -39,7 +40,7 @@ struct pit_timer {
 	struct clocksource cs;
 };
 
-static void __iomem *clksrc_base;
+static void __iomem *sched_clock_base;
 
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 {
@@ -68,14 +69,14 @@ static inline void pit_irq_acknowledge(struct pit_timer *pit)
 
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
@@ -98,8 +99,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	writel(~0, PITLDVAL(pit->clksrc_base));
 	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
 
-	clksrc_base = pit->clksrc_base;
-
+	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);
 
 	return clocksource_register_hz(&pit->cs, rate);
-- 
2.43.0


