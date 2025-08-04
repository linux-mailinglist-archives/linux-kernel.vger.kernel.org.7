Return-Path: <linux-kernel+bounces-755392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D80B1A5D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A3718A0A51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B826F44D;
	Mon,  4 Aug 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZwQznGT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870D25F99B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321041; cv=none; b=gpGt+TPcGJCx339sauPhVrWEm6eff3vdHXQPOjtyrzw09PI+RS8niKwD3u5mqvOQ4xIRcXERkLl7I+2wKabopqrAJyew1GXSxufcofUzsthF28rPhNsG6XF/txSt0FAxSl3NvOU4TeZMHUoK6OPXBF96DUV/ePFIZwafseue3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321041; c=relaxed/simple;
	bh=AX6yILrFa1zP7h7FqhjoMp5tbPuYWJFvn6a3J1bZV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBAi9yxgHkDruEVqam5Svx3y3hSlD46EqxKbI7HwxfLXGztLROl7nsn0+/phKuIgFNU4O30WS5H6EI8gEgVL11cZfdH0MRrM2XiK0Y+bC8MuEEY+10eT93gnedCzCNuYNME7b1+nSVCsolccpDFhAYrZ0rX55pnkEzYXexn/kFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZwQznGT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so7211405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321038; x=1754925838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0wimr9Kz7VoEl2fdp9icMi7AEIiaxz3Fb8BOi3TtHk=;
        b=xZwQznGT99a8PNu1fZtGTUpQS2kRcOLcw2FUDgqGcIR/Lu1CFVKtISYeZ0oiDRghN3
         sCzbuu8TTcToz+p14LX0AYgxDnMBYLgR2hrXjDUpAe5aZfQAyHHbuL5Y2ClTKo/Th41C
         238iopPFb4xquG4apxKdpHh0NXn4SJj7ohp+Qs3D1Nw93UL5ISoOOylsKzDMZcqUigj4
         IQYInQ3AdeE9TJJpw9O4VgUDoyBvVb8ACewSPksLtuBqHg2iEWEH00y9VrSVPLze6lYL
         f8AChpdyUSrA1dc6/XCvaEhme7gv0qp19Hn+UbuX7ocqREYt/wJOsrtyE9s2rzy84M45
         7p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321038; x=1754925838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0wimr9Kz7VoEl2fdp9icMi7AEIiaxz3Fb8BOi3TtHk=;
        b=uHRQ6tdoQVTn4icssjFVChymwPfMbz85FgmGQ3Fzw6XjeHf53ytRX76D57wsBQV+Hy
         aUPUlpwx5L9tzvpVBY50zuUeKRpzZI2eLyAoW3jddlctbFwA6We6Rz+OSiqH2MW/b6Fg
         be3SXO73X3F3QX/lGP9Eb0gROSzw/35deMfAq3MzbGAcpRDObLfbS+H8G1I+Oes7fC9w
         MYVifvIjyybH8jlNEBKjdmQr0dt22GG21IYrmQfc+kBxcB/4/F+FRUwPyzmWjS2CT/2q
         jA0Jpiu1r68NJR9JklCjFBg29wBHw3jL3N3sqW5k8eXZCCldXWTktDvVMqidkl/HYtct
         /J5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUky5vrmkWP2v7l3GMxTBQ/AtjV7s5if472C8aElS7qDGS5t1sPO7rgqNRspi2ixHkYGGnT2F9rC4RcWxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafYZKDCpqqjfjerrEPsbccGiQDDPvS80mtRMH0j1bRsvbYMaq
	c6IwHfY2ORq/HfqrvgLRLWbriiu5AjwILBgXQf2kdcuiTFAj+TtEZLdjzEtYcFPVC0o=
X-Gm-Gg: ASbGncsWPG6LJejjpWh0fQswJjOVXx9SWFR4rJJr0BlEZan4mxlSerI+vsvyvn5o1Mx
	8YHwLl9hUJ1Y+VFUYVKQzZo689v5S1U1T0bCczLaKLIPn5nB7JeMefOKJ1Ln65YiMl0hW/eIJ9/
	IHIdVb/yLOqBMxPNUy1JLvceQUXG34DmyOm/hbitrkbnErBR6YmjgXwIAMRVZILe8tGpLMZ6Ant
	nExtZ3GI38hDHw2MSIhhOGGQIXc9Nt+kpJHM+X5vA3rIQc5CeX4hfXSJMk1g8ARF2Jna+eywa2x
	sbbmhHkMR1eDYy0TKHp5BtcViZ+dr4uDqMLLgB4juSQYxdI9UH9u5vc0K1cN8vldMCFZusT2cu8
	umOhuSogTlf9BvtrlpQPnC7cMbrJDPP5IZ5JwU2YpT5ttAasw
X-Google-Smtp-Source: AGHT+IGS1haFR8n57b5EnZAX8GWR/rUVuyC6gUQsf2MFP6K41PzESE4GTc6lJEPdQu1HeiB96aMNsw==
X-Received: by 2002:a05:600c:1e87:b0:458:b01c:9d with SMTP id 5b1f17b1804b1-458b69dec92mr70916555e9.11.1754321038480;
        Mon, 04 Aug 2025 08:23:58 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:57 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 06/20] clocksource/drivers/vf-pit: Encapsulate the initialization of the cycles_per_jiffy
Date: Mon,  4 Aug 2025 17:23:24 +0200
Message-ID: <20250804152344.1109310-7-daniel.lezcano@linaro.org>
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


