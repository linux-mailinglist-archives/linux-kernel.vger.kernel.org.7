Return-Path: <linux-kernel+bounces-750374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0EB15A98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486CA18C1406
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8359299951;
	Wed, 30 Jul 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZvMaKco"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06A29899A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864117; cv=none; b=SIxHeVyCD0DhtOKxV8epg1EDPSG1BH5t+jPsKIaBumD4aBIwJ2BFMgo2u+fuYWZzhOKJRc07iu5kjEObMJ5DVAx8eATuUm8kihEklxNJb4ROLDqAuAYzpXbFO9HiHTkaACtY0jT1oGEGNkCUSEK5UuaAQiuSv+mIQIJ+AsJqvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864117; c=relaxed/simple;
	bh=ZQF+EVPqcx9QLRXKTr1LjG0h/R3IyHQPuhVCVCcAuO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwVuor6OKbgXpiubdM76kZHcr8MfZT7AmMb5hSHpjaR21sE/oSdtP/ZsTXAECtq8rx16czh+VxvZH4pJiye5/9lrUGBaGXyBCLwvNgmzS3it7faP7bBodp0/z2APUUy0ple36s5REwWgmCmIH8t1K7p6rvix/XIHqN5virsE1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZvMaKco; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4589968e001so1891115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864114; x=1754468914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbVaJyUO7GiEiEqdQljEO7vQiGP467HVmO08HdyjiFo=;
        b=nZvMaKcoZJKcg3usf7sQI6AIKKN90NXEqtgBsUnjPru/RDXtpW9fIcjJcRblt2nMj1
         lVfgCwmTw21BR0qmGynHcln9rXFPHbjntb9/o9HFtVuf2MhV2j5wbbASSvFphuqlX+Yo
         ucjUI5bQx0iymxcfqaKsrW1cJkEJPE5nyp1gnMuxAvIC+kD3WCurncxpXRbn3xR5VHxY
         T3Lo+I0YghQwXxtEzFFPNYg+DowO3C4IZhGFZrTI1fOy1RmSVg8lKc4hqpcrJSgowghD
         4yov9CtaY0jzZo8KZkC7OOXWDRRvUsecMy52sOkKeR9K6FdKzNJFi7x09m73urI7B7cM
         2XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864114; x=1754468914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbVaJyUO7GiEiEqdQljEO7vQiGP467HVmO08HdyjiFo=;
        b=s2E9mLiogOvOQTtnL2Dk7WFPkbuwqgFEq45s2i5D2DkrKU1YwM5WJWvEwSJDLrz/PH
         PDFaDPbrUyIh/v99Kb/ChhFtcXQCQB8uPalDk+sO4eCR4L3pppA73aYkcqyaPvLuvDHM
         FGW/yUMn2qGKlCZO5LzzmgwE/nMvGL/a+msnQq6CitrNAfhVITjXKzYItjaGoGJC/AOd
         6YiV5njIUNvHuPn+AlCkJNQwH6BwVdte8eOV3A5yMk7Fbsfay74A7MXGEpIrADA9kaxG
         tMijqm/kBYnI5lY43G7qNUiHYxyRGfCrkxENufvKm/nOLf1ZmL0TBcwbrKS7OP0w/s3/
         61tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeifi5d7Hy1KE3CJfMdupXsrHl6SfE3Agmbd85YVaBA11uLGmSEFMenMYbWxAc++T21vXAP56Fjp464Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8rcGzwcf7FEVcIq+02S7MvhlmUxl5lYWo1UcVJpXj0vYQVZH
	EysBm39psdXCXhUOA/pz/1QRnpINEsdqITIFs0tI5vDCynNkD/IC/wbRScPJnKDp0w4QGi/g+j+
	SCHXE
X-Gm-Gg: ASbGncs3wgLOSiEdV+lSCn0jBY+m8i3zE8sR5uYK13MpjtXB5/uro4q+z6np7pK0Hqr
	e5ww+bm/ppt8gGttp9ADsYNL2qqnKLKMd/leGofUcoaXtGNilZ+nWVGVF/7jqGuHwmZe9asRa1V
	WopY3yabvL2cAWNq6ZVcroCjiDXinEn1u6z1Z84SumrWfYKmWyjqbEViW53AtOjw31o03RhwYBx
	/PHldAyJBPxJr3pHiMJBzGP3rLcyUlOhvtaObr1eG3GnTOD4nOgfnN+3AMIB0jPwONTf/q9z8hv
	YqExH4XMdVDw5hDewCind9kL7x+jqiqJHYuNNYLhxCUkBTeYxbDkA2rZ5PBzXZcGzvdH0td5XyU
	LCD9kXrTfVF4MV326g+6bD8ispSxaX1ZCZhuoF8woKVNCZ7Jx
X-Google-Smtp-Source: AGHT+IEVniZU3jqkUgmltQvE+gMNSsQ8Ep0hgGc3DiX8m5W30n3WYVVfCSszPecQuf4SnNvy8npFfA==
X-Received: by 2002:a5d:588c:0:b0:3b7:92ec:68ec with SMTP id ffacd0b85a97d-3b794fecddamr1933893f8f.14.1753864113696;
        Wed, 30 Jul 2025 01:28:33 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:33 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 15/20] clocksource/drivers/vf-pit: Encapsulate set counter function
Date: Wed, 30 Jul 2025 10:27:17 +0200
Message-ID: <20250730082725.183133-16-daniel.lezcano@linaro.org>
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

Encapsulate the writel() calls to set the counter into a
self-explainatory function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 609a4d9deb64..5551b61483f8 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -74,6 +74,11 @@ static inline void pit_timer_disable(struct pit_timer *pit)
 	writel(0, PITTCTRL(pit->clkevt_base));
 }
 
+static inline void pit_timer_set_counter(void __iomem *base, unsigned int cnt)
+{
+	writel(cnt, PITLDVAL(base));
+}
+
 static inline void pit_clocksource_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
@@ -118,7 +123,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, const char *name,
 
 	/* set the max load value and start the clock source counter */
 	pit_clocksource_disable(pit);
-	writel(~0, PITLDVAL(pit->clksrc_base));
+	pit_timer_set_counter(pit->clksrc_base, ~0);
 	pit_clocksource_enable(pit);
 
 	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
@@ -139,7 +144,7 @@ static int pit_set_next_event(unsigned long delta, struct clock_event_device *ce
 	 * hardware requirement.
 	 */
 	pit_timer_disable(pit);
-	writel(delta - 1, PITLDVAL(pit->clkevt_base));
+	pit_timer_set_counter(pit->clkevt_base, delta - 1);
 	pit_timer_enable(pit);
 
 	return 0;
-- 
2.43.0


