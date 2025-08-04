Return-Path: <linux-kernel+bounces-755393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A49B1A5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D359D17FCD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65950271A94;
	Mon,  4 Aug 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHTobpeg"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2BF267AF6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321042; cv=none; b=GS4m91FxVZJqAuRhRmrp8ECVjjxBtn9c9GSjtRJsIO6HzoAwptScx6B9MtLQ85ztalU/dOaIE5uIyy3bhIY1HX4iOqwABxtDznCdRwdWwN+SN+iXv7InVRw1HbZPLtF1TqiZemJkzDebwVaCN5BZ3Bi4PTJSAcA2N7WA1i/wRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321042; c=relaxed/simple;
	bh=RqZFdNtgTbZf0m6I4ZXD8TU1jqwKhepTi0HwZSZTuJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJiiVitOL9ausA02tILDf5c+r0m9+5SEyZV1CpfwaSoruWegAysUMfEPPff7bTsuPI0pIdr8DSoaXEnHD6FjD3yp94N/qKAhy0/zi7hS57unazxObsuqzL8XibU/jAkOYwbIrQiWVb9S/6juJILRDZ7195KD7cbHIc1MUw6TDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHTobpeg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7825e2775so3764351f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321037; x=1754925837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbDzZtNaADWutB54k3WAXEO5erD5I8WcIHEbONLpqUM=;
        b=nHTobpegZT//04r+MGWtsG06r8fHt1jf9TvIo7B4LwVo17kMgf3bhaqJ6xPSAOIgAv
         6jp+qxc2sRO655fRwzqnAcICaRf/TBbASG+qgaY9Z8HkjxbHXNRIsJqpViSNmpKvoZZU
         Z2qSedjAl5oM0skJ9wrxpPReZheuzJRfZMgK4cYn3dr74ogLJjlKFXzBuyNexK8j85Ml
         SORWE4xBVF5qfG1wAdp9gKKv0Ek3OAZ5Wxq3nFkrTgwfQhzULvMKU4ok2mxs1yFJvUpx
         vMomGYSRlo68KDlRyeB4mYNIYAkpSO0s45llVAYgvq43qOsWu1Y4Rs3Y4S1VSmGOpUjU
         S6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321037; x=1754925837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbDzZtNaADWutB54k3WAXEO5erD5I8WcIHEbONLpqUM=;
        b=ONPegicvVtF66mEBVPyI1jKrjQqnNT5zXDKkdddu5YbL5P3eGcVH673hlf4bT/YRBQ
         4u7Cr0l6yUeCC4GvAXJTa6k0GDJDa2Z5/PaCOPNvuJf+nLthwdA4BZINUkopOKpbOStP
         RdYIVCGScuVXgSE3ISd8EZFHhd9GMFlm2UjVwnFhITCL9gN2HlOqln3uCF75IZGyUnRL
         yMHPnSOx13eMTLpvnVdwdKOgfY29jjZdtU4SWwQA3PX7vtzeTAQvLa4UWg2T1j3wiv6N
         WEK+yw6zY7rYDRU5IqyozYL02Pj3AhJ7pqAb6yZ+Y2e+8OjEwGf3h4zMONMWidqbspFP
         62kw==
X-Forwarded-Encrypted: i=1; AJvYcCUkvWlotpC9u+PPGHKY1OhNhhAnf3RzSJbJkavTQhs4n1vm3BEWyDqv6vf45XWOrJEWpnJeS09ycgOFm2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvHE/23oQOLK3lq8Ibo6ehCzW1IzlCG9HKvJYTf90YdLjM2g4
	656FqIc2SaDggrBS/DCitKfuErYd8OHT330EepUjVD5aZVOl3ucQ6qTxhu1PFTIMKU8=
X-Gm-Gg: ASbGncuU4WIwpzglYm7FoLx7DUCDCdVZguYxViGphQnEJ77jl0KFufV4lKBsgO10+oj
	jXR+wuIa3tf2r3G28Zhj1BRutU4JJIaCSCiNPg6Em+Wc52tSLeZfBXxQOfAaUc4fN5F5Ot5uJ80
	UcsIBnxHet5l8oHzuHam9o/g3RWneUwI7wvPIb+X1n/8OeJs7Fs+y/UccZba7CZS10pPu8ereeS
	E8ZuNuac8Zz/IZ023mkF8HbwFHDlx/+lIw3viUm57KLSSedOEGZdNtCGqdeLDl3qwxgrvefgin7
	fc2liwDQO9I1W46gCZOlvtWZGzwPa+7HJKEVZWpFha58nFbBmKCZptgZ3mWfnV7DtnSL7I29744
	6aj9Jlyo866UpV4w46P1nwGMx/9JPbmsFUr6PxqXV/v+As5Up
X-Google-Smtp-Source: AGHT+IHJXK0mSLjyEkfuTl4XdI4DSkbbxXrgTfTNPzXUrXNgQ+P2f64aslfA/kt/ALMiaYbCoLuUJw==
X-Received: by 2002:a05:6000:1a88:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3b8d94ceb8emr7515523f8f.54.1754321037256;
        Mon, 04 Aug 2025 08:23:57 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:56 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 05/20] clocksource/drivers/vf-pit: Pass the cpu number as parameter
Date: Mon,  4 Aug 2025 17:23:23 +0200
Message-ID: <20250804152344.1109310-6-daniel.lezcano@linaro.org>
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

In order to initialize the timer with a cpumask tied to a cpu, let's
pass it as a parameter instead of hardwiring it in the init function.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 6a5f940ad0bc..9f3b72be987a 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -147,7 +147,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 }
 
 static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
-				      unsigned long rate, int irq)
+				      unsigned long rate, int irq, unsigned int cpu)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -163,7 +163,7 @@ static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   "VF pit timer", &pit->ced));
 
-	pit->ced.cpumask = cpumask_of(0);
+	pit->ced.cpumask = cpumask_of(cpu);
 	pit->ced.irq = irq;
 
 	pit->ced.name = "VF pit timer";
@@ -221,6 +221,6 @@ static int __init pit_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
-	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq);
+	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq, 0);
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
-- 
2.43.0


