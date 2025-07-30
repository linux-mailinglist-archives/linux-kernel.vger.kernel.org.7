Return-Path: <linux-kernel+bounces-750364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFCB15A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E973B5A2B80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F50293B73;
	Wed, 30 Jul 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2OEXQ2+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4B291C3B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864108; cv=none; b=hXWVWVDKFOhgfvRHs+a93LIcEVzg3uu/qCojtgXMOCJ/u8EKHuOkSVI1S7bkp49x//XTzG7Jyo+48NeASX+X5wXZnttFg56LBtOUW+L0efSRTnVOXmGQuDMyGLyCB+IVWPLpyj7tMxiWJtSyl345K37PbHKmwTWwxmsQXtZeSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864108; c=relaxed/simple;
	bh=AX6yILrFa1zP7h7FqhjoMp5tbPuYWJFvn6a3J1bZV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0nyTBBe19277d0GBOA8ge+Gc+wVrWXLtMbTH1HzDjRexwOB2iNq19wgh9cH3DrGyXcuqm4cAWxuZF1gwX3VMwK7szzMQ3389T1mkI+qVOrVXc74aYRq9v/0HnSwfsFicoU0Cv9HuNrvvWaAdKsQ4Fhs748LHgmo1LW0KL+djdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2OEXQ2+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4589180b266so4677075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864104; x=1754468904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0wimr9Kz7VoEl2fdp9icMi7AEIiaxz3Fb8BOi3TtHk=;
        b=g2OEXQ2+m7vzL6vF6cG2s2kPdwo4lMlF8wwSCwIaLNHl/FRAqRAwu/hw31UkgEV+3q
         p2mpxj5RVJrfhsbOgBXmDH0S2WvJ61AI6Q7M8605zJmgoCaFa6SS6JoekSzoVJaSUxs/
         ITR4ww3rl9w1wFPqpVDz3m13lsy0lqeiMAGalM8ca26psFAxt/iLmImwPuVHzMl0JlWx
         2cgGraKI5IuPWTR67txL3cOIl/a6YCr2LK/8lpvy4YXZTIEvwRSZQA/V5WWHhp9DCHNz
         kAumIzkvM0fc5aLNcsW2YwK1VUNpyrX4a4zpfNQLvEhXFWhU9SrKHkaJxtnWu3dBjdUs
         MW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864104; x=1754468904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0wimr9Kz7VoEl2fdp9icMi7AEIiaxz3Fb8BOi3TtHk=;
        b=H0EG1YpD/mA/uqUQnwbARjbgOWZ1gDirFikgsg71dsBO9FkBkEaCatHxDfxOHvSZXO
         8MKBu8dkHYFdpWJ/HVYN8ymdnvzUPUtCu+sVjXFqqxwFJQm3uxO0ekae/cckO5+54TEu
         RWWZSbO1oxXZ2k6z/T+N1pPLd7VbSsNRh9MvKmToAPOu4kVFf2QdL3Ohqf99f9rD9Ed0
         1pirjcKidnLDpUufRGKVujNDtavgqcfS1D5TC3M62ec86YTszGolYSQ290qpAhi2KQ4/
         3meJRMWj5V4MkFPhj3QdkXbsk/ueQ25gY/43B36h9Put5PD+rHJKlayOCMxUQCFprnU6
         ofAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMPzjrlVraRECkSJkzh1qNs7ihCKSPOjf66s5aTDv/yXaF8wwxjCyOmZj5gHrEdURCLn+dBSb1Ku2RKkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgTmaKFdKfOkbxGPwjD9qJSo/JZk8P9HCj5yUMMYP2q/05TVl
	4gtxiaMxohHJmw2jg8lqNsMyETnFA0cwOIbrWaUyUNLdjatji2NQ+1HAk/TWldql0xg=
X-Gm-Gg: ASbGncue/j4a8Nhlv3+6Fc+dazWSE1xwjqMlWRpSdgak5PZJkiCf6e0fN0j1n7K7GYp
	RzlcC9jU2m+D49E9TDPwXgrQBHmvuU4JUsNBno+re1J0HYHZtYwpHIXjDeHX0wEphLdqE0xW7tm
	t3/sDWSzu//Dktu9vLODolu8jVjYBAKn4D0Ot7DsEiRcdOPSFWnBWAoFh87LW4d7VORDg7HGtFJ
	fkh0dBekAH0F/ZsK9voCHU9yL4v5XJ6N6UF/l+3zrMGJPkChEpz+OOyNYHteRpM+VKzBi44jxMT
	Devc5Uu7fXsTur23eSsLzfQi0xCAuuW7RqUuugJr84oyi5qc+vqn+k7d7y+B+i6kK8alWY1AL8F
	aUk4xSty7T/xtYRhzOgSxbSXKPe5LDw78jnzARe42iTdl3SIw
X-Google-Smtp-Source: AGHT+IGqNUleiFojuDk73yGY5Tc9V4qyXgkhNgzRfDBRC+rRh3q91/af/iS7TuomQWHJVrAAFc0I0w==
X-Received: by 2002:a05:600c:810c:b0:453:6424:48a2 with SMTP id 5b1f17b1804b1-45892b9e335mr26898495e9.10.1753864104465;
        Wed, 30 Jul 2025 01:28:24 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:24 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 06/20] clocksource/drivers/vf-pit: Encapsulate the initialization of the cycles_per_jiffy
Date: Wed, 30 Jul 2025 10:27:08 +0200
Message-ID: <20250730082725.183133-7-daniel.lezcano@linaro.org>
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

Move the cycles_per_jiffy initialization to the same place where the
other pit timer fields are initialized.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 9f3b72be987a..a11e6a63c79f 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -155,6 +155,7 @@ static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clkevt_base = base + PIT_CH(3);
+	pit->cycle_per_jiffy = rate / (HZ);
 
 	writel(0, pit->clkevt_base + PITTCTRL);
 
@@ -212,7 +213,6 @@ static int __init pit_timer_init(struct device_node *np)
 		return ret;
 
 	clk_rate = clk_get_rate(pit_clk);
-	pit_timer.cycle_per_jiffy = clk_rate / (HZ);
 
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
-- 
2.43.0


