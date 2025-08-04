Return-Path: <linux-kernel+bounces-755400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A2FB1A5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1246A18A1C04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61771274FE5;
	Mon,  4 Aug 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3NBGhPo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300662749F9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321049; cv=none; b=TmO2CeY5SyV6wGCsCNusEP/R5s7ovUPU16KZe8z5JIWpfdRLiqObPClxnFy6JfFhqCDR79L4EMMFuQPqF1YKyiX/JNuO4jS2H8CWhGwz4n1Vlf7/zrLE95Z7nuuUoGahVOsCaw132qdd7AetGeB5gt4AyS2s/F5+CDqdgGmrWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321049; c=relaxed/simple;
	bh=p81EulUS9kF/MLITjT7DPvMr6vmlQKnAjjWftNap1A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acy32YnmgAf/XZzB/731oRNQSeH5pxIyxId15z3uvSgAdqs4cxQYCojca5SkBHuCsV4Msw9rn9DzlJspsNuIVwXDxHntlSz2GIyKOkEKKmqjkWosNSfuC0ucFXww7pYks95C0c8iQvG7YgIw0EyPu6//ghI96ieC4UdRYADigtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3NBGhPo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459d7726ee6so8578635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321046; x=1754925846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ryA9faGluqwB9+UiJW8cuMQhTuvfpb1HZM4cTkE7E8=;
        b=R3NBGhPoO8MDihGQ/EyL1XyRPQUy7WIaNxUzD3/LdtjjNLPQJacVPJxm2CCT0tQW22
         Rwdig019rezyy5/DNkE55b7BxllybH5mcGF7ZsoGm88KVfhVF9+fyft4HaLEWysuMmi7
         7olGOZUzxrQpBdyZwIhCVz/Ox2i0yKc/FJLhMouKkGj2DMeL5rWUI79SYqRIxz5coUlS
         KiJwzGlBRxREE3SucSjOExBTrD1pdmUWxZUmCmn5hJjs8xuJlRz3hmorCbiLAodZp15n
         f9gTxC845QPd80lBbzrYZL6d8X8yisjJjLbhnhSLQQ2L4C5pNuD47CUT9FO1V6l5oV54
         Ur5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321046; x=1754925846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ryA9faGluqwB9+UiJW8cuMQhTuvfpb1HZM4cTkE7E8=;
        b=ZVKNEzROJdHA1nPzyERrf4gvclME37kXn1TuKi+aqvM4z24HOQp+9TkEskGTwhij8t
         Nb+HgyB9xRfbOkIeJICZf5kq+VFtsvmVodDBsKNmDKvwfD23TzdZdqMdovMn7keA38Jx
         B+LCZpCl4r0FY1WGnaSrTDBuocx0u5zhBxp7mBMTZxbwuMG1pJyVa/2Fr24tcZkJwi7M
         XCg3gncXteLIli3WFIjZ3fsH4tp0X932v+PCTQrsjfucBSoYaSb4HqMJgrfZi8C/K+DJ
         XQx0z1fHZ1G6FcBICX3AvUkT4+U4+LplGRW2v7FhPSsD9v+H2oqi9IMarl5ASIvMVeVn
         JE1A==
X-Forwarded-Encrypted: i=1; AJvYcCUo7w9H1rCcQ1WW39JZss9sGSsF3ykZeNQcs6biBmYJcexepSO1AiVUs3m02hyhhCXeeIjIrlx/onSfrQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqSTsUAoAlXuftt8J/QWvlRafF5M8cI+d3ONkDaBu5X6XDGy3
	dDmwWSGDBkXqwVmQ35iRo5rxO9UCj8IzbtueyoNvTF8MPzYTZmVZ06+569L38J58odk=
X-Gm-Gg: ASbGncsRiQF3e3GPwDqfYTqouCxBaWM3JgxQdbwEeX/5Uel6Ma4t2ulEeG6lkRYMdAj
	wokMBU0xgj9ctZYxomP4WQjvMlImcdZXMv0+oYOTfyk9tD+eM6o+03lyaIK6vcLyPVUBM3eQl71
	7/6XsehPilpOTlvb8yxHgZmHC0pfFTvFT91j3HaP9YYhkAll18cQSmcCT+le5uebfLFCD/2hPky
	p1iHxVqxD1nZ5Nj+FjInSZ7vvQFv3fcUmdE37phccf3pdI3g5/S2+gCLufTmu52TKd1Hr1t3AtT
	9d0ovwDqvr6mDez8S8kd0jQA0NrLJmb4wz8zT5JMTAVdcOCQtCG9gqzlLS0/RjkgoiZizLHdmQ9
	WxrlCB5hDWwtDalQcOYnJKy8xjdWaI4ja0wd6GwPkfGcHC+5u1cSGowykccE=
X-Google-Smtp-Source: AGHT+IFxG1Eo7rfaHiizXIP1eu697RM/vr50az4fqJh/5bcsgHVfbKdR3IFWapwDi1gk5j4t6+xBtQ==
X-Received: by 2002:a05:6000:4305:b0:3b7:940e:6529 with SMTP id ffacd0b85a97d-3b8d9465fa5mr6199348f8f.10.1754321046486;
        Mon, 04 Aug 2025 08:24:06 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:05 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 13/20] clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable
Date: Mon,  4 Aug 2025 17:23:31 +0200
Message-ID: <20250804152344.1109310-14-daniel.lezcano@linaro.org>
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


