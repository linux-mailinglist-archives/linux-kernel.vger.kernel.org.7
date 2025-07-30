Return-Path: <linux-kernel+bounces-750363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A90B15A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AF154666C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928F292B58;
	Wed, 30 Jul 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+y1gRzt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073A2874E2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864107; cv=none; b=EWzCvkODkanrbJQvbJEnYE0iAIVlP+a9qR1gnUc7OJPqJ/4Xv/ABN3Na1fXDtAIqBWO9x6X0oNSSsrrLzst2egCa9T50l1UkMVXCNB3NFaKC+A1jUcq1DmfdbL4PHD00O76gWf630heTlPUPY+R4oc9R7rBrwCx4bPC4uGspBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864107; c=relaxed/simple;
	bh=RqZFdNtgTbZf0m6I4ZXD8TU1jqwKhepTi0HwZSZTuJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc5D0oiclk+aDIjTkLcmtA61lurWpHNT0TlLslxP3Kw5ZHyxN9k5+H8c5Os9zqcCb3PRYwZxuWcxy5+T6qpx1WWjUWFEUJPevVW1tdNhbUNf/rgbIsaS85xVBXJEAUe6HXL1ZCNxmlz985+ghle4KzW07hwBrcuznkqre6aF/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a+y1gRzt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso2986955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864103; x=1754468903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbDzZtNaADWutB54k3WAXEO5erD5I8WcIHEbONLpqUM=;
        b=a+y1gRztWsjhvhEIl5cHYBQDEEb95LCC5+LdK24rAw81WGR4cdHodMg2N9WgJO7uay
         fUhyF8woYfadQrditiYeLIy9/xwErTu/my+veomM1LmBCWukO1kQ0AYO1exXQfL30Noe
         N1ZsZLPKTwfLHVWlsTCSE7zM4X7hHq2e0Sw95vOoXiMlyLL8zxImuK20IkLstXj543Wz
         eBGje08FSyiDT89q6NXxNwmMyOqs/U7Aqhr3KPmT6XRIocJ+8xycYDZ93/iJKyvgL8Ur
         UJDw5b/vG3sMJNwz0sv6uj8S0ZQm6pNbrYvw8vDCkdrhV9ZujKCKv/kdNGTIzfl+EI6Y
         w6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864103; x=1754468903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbDzZtNaADWutB54k3WAXEO5erD5I8WcIHEbONLpqUM=;
        b=RgFA2noGj/yz54+8GhRHn2/XjFccNpy+Hy6eWhDiEddSTDH0uCWL1yo9m3X9PFdNmk
         vgWWiu9qQLuzDc5iEzUuAg/hPjlJ2OsqpRcopYugcUAhPi1DtkOVVZQmPnlUwpC4wxgq
         kLedpNKQVaLtMAbZ9a++TQqdEL6aq7fdWKdY/7U0+LbdbqziByfuXPhSg7mVA3TI+1UC
         mm5nceYZJ16HJYK5yaBqvIr4evreFYLh/zupmM+bLAdY8eT7xFaFU4hPMVTG08J8kPz2
         uCbluPzcMSUZcEc/qPWKLCQjU4wN1iAAi0lhMh0j4MX0jDBNiEMiJC1UoZsuUE2tHsuz
         Y+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI6mRxXQXdCAI9LDFTSs2FpnrKw4u4t5XYFRE9nWocBRplbi0t312gx5IMWogc9TquWOZZo3LLiqZbu88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZfmQ2IEW/R/bZ/XKeNRcEWtuHNmlK6S+AmkJqqx1Dd8plm2n
	SVDSEK0W9fAnTJOKPOHC5xb2BURjsXIdDd7a6TMN1i//UrltQrc83KKJJnx0ybBONyU=
X-Gm-Gg: ASbGncvuPeSBSGsxUbhWlbifeZG6wVj3rPIIcRNe+M+T/5yEZjv4AD6J3dl0oRRpnZp
	vdKjcuWDseaG7LPnwb3G+h/e8dQJl5DbTY3nKWxLTlzm89EtaJnmuPp9cLWQfJKI1eei5BY0rgH
	OfwUa1QgDp3+xacXvrY9W76tVIeBCALsQNPRL4kNfI9Ydm7zPnGcajPshPWZngLZAwxtP2kMrTr
	APxw73JZdaG+CNo7Q2Ci2Me+C0rpVCm/Ts+NXS5uJnnBrPK3fJMue55BdIbARXQl8w5C5YD/h9A
	B9xZLCQjb9QwcpqWMmpHWvpwNPv27rZoqFDPps6mCi3+j2KJxwnH8IyZ27cdx/yPAPB43e18QFt
	L0gA3WYzZfVSHFzeuAUqtk/A2vNMtvFwahLktSfyA77LGlmvY
X-Google-Smtp-Source: AGHT+IEbov1VksddRew67I4SCyBF8DwL8VtFb54YMw2CUQG0meyoE46AbzaTpEAcbTfvHpB0fCnxwA==
X-Received: by 2002:a05:600c:1d82:b0:450:30e4:bdf6 with SMTP id 5b1f17b1804b1-45892bc4a11mr21848305e9.19.1753864103492;
        Wed, 30 Jul 2025 01:28:23 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:23 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 05/20] clocksource/drivers/vf-pit: Pass the cpu number as parameter
Date: Wed, 30 Jul 2025 10:27:07 +0200
Message-ID: <20250730082725.183133-6-daniel.lezcano@linaro.org>
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


