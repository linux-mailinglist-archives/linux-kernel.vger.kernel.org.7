Return-Path: <linux-kernel+bounces-856451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96ADBE42F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF84207A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8A34BA5A;
	Thu, 16 Oct 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCQvoQeU"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55E346A1D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627987; cv=none; b=fNm58bF19ZL+DknKAoK77dEQvfzqULgpTsCCggW5PYYDvqEd3V6xKeB8SW7hKyflaOZ6PYleH4F76ayqvsAA1dU1Q92+jZaVezgc/71U2uZoindyaok+QDLInjLKR1+T5mzRiNQDh2aFUO1Hk0Nidpg1yoHnYzYpkz7I9VihEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627987; c=relaxed/simple;
	bh=o5HEvZCwSuySR1jmKB8nhGyW1NxQC5ADbI+U76W6bP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Y/WlUqfGf16GOr8cK3UIMJysosB20y7AAxzzSNsmtHtOYItzbttvZ9+M7iI8HtOUaZDHbr9OU2CMoal2SPNjNz8nmeBCZBfMd38zkFScVAffPh1X0urc7232MCX1oj0ew/bh8mNT8+FbyQrHruAGKFgZVbpNB8rDVTJiROgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCQvoQeU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-591c9934e0cso1021910e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627983; x=1761232783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxV71jdmV/ByebbrIUZHic+K8dLTxGDirB2bOa0abyc=;
        b=JCQvoQeUGcxacX2D/AnYo3Dzm6vlttJoJjw8Kc3UEUKY2CMHSVy93nHE4vFx7OQ78W
         EdsaJ8UBLjOeSUG9R4+J5n8RtUGUhRZsF84bpy7wjtrwyGAliorbghL/8USrWbPx8ooV
         8AsydmcdifIGzanyUk/pKVTWK1p8IXYx1DaH1vu8y8hYVn75n/je7H0HdGzYCve1j+wY
         fvKcU1Zva4eBmUkkmz52Aebo44KaU+th4GKUV2DWQJLGv98KhT0+0Nb0dGHSnaE39x7A
         zF8uF9gYq9QCDlUW0+Mpsn45AOoBF/2hafMH8TfxHY95Al7AHmYZw7ZcbLkmP3VaXmHg
         PdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627983; x=1761232783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxV71jdmV/ByebbrIUZHic+K8dLTxGDirB2bOa0abyc=;
        b=uKllfxOIrFK3Pf60vOxJkQVtSMGLdzbXVS2KxLsaOOoevY3LmEPfdnoBoIW1xu9q78
         AzLzUHuLJaUelKmEa/eQasEkXUzCQjh6ft28jqC1JsRB3oNMYPuPnIB9DHja+ZnGfe6o
         RDAa6kYZmOqiz7/DTqpG2lNI4WQ19dhonycCUov5WfnNO4QoR04pbvrnwicdzY4R5z1u
         9PUraOC1hJjaTeqy5sOS6G+ilJGGYeARldMRFxb11F4AIBtNPy/vm1oKag/qY7zm6VMA
         6O9a1kJ4s5OXevLe9Xrh0WNvcZYKTHQJ8uXIKqNO5M4weXnLb42+48I34CoATkoqq00G
         /3dg==
X-Forwarded-Encrypted: i=1; AJvYcCXAf//TQKKRW7gJG7sioiysPoWIKwjzCno3/KxEnL4eCvC6TeNG0p585qu3mEQbALbtB+FS4nVV9NZbZxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXrtkPHRDyc5i5bzJE93fX4h74/bVrhf/CuSLe+7gFwM+49+w
	2Xgsx0kRRtEeN81km6uyzZh5Px3Hms6N23SdqVmLg1h0G/Obo61G53cQl0jjmKadG9Y=
X-Gm-Gg: ASbGncuXqsrAiTn5pNmKt0nXdz05k0HE5GCRbE1/hrS01ckACuc+tDnRAOA+afYdWYb
	TuDytoV2kSjD0eWGlVqQHo6qlhM6i0F6x6UWAbKu+W2p5t468mpfedOsZRo6Uz/r4AVsFUvvVpR
	45Zs4qI04y6SXvdT8xJIFvAJ76vpL/SwCxaQ/DByztqIx2NHhkxSuvP4G4gUd8wUhsaB+D/Y5rt
	BDTG/Yoa83pZrv4zLxgAgKgq4HzysemAbc+kXyycCHNKBHSX1lZ7iI2FI570wblpv4JsQOyswo3
	xCNwHt0paFRpKKbdfpZhTr5KzVqRCwy7NQEO8ohU4kdbuIiMve3OZlyHkI64fFeCphK4NWhBAu0
	UwoaajN835MJNxjx8kNm/a4DLuECzPQVYFSPCWjamu5p9wA9UnjIn9RJcBG55y1HDvVHFu0+Eh8
	8HJ94P9kmGDjzD1iDnWynjY3tnypQIJPv0xRawkPsCNUVoc/sHNvuSeHjw5QgqHBtawASXO1M=
X-Google-Smtp-Source: AGHT+IGvjg5uCswfR+tN9GifXO55mjU6KM6v0+HQbxwAe6xg9Y/5B3QZKxZkKucPhWtwh9KJ7o0QpQ==
X-Received: by 2002:a05:6512:ba1:b0:55f:5245:d695 with SMTP id 2adb3069b0e04-591d84cf610mr190387e87.10.1760627983295;
        Thu, 16 Oct 2025 08:19:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:42 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] sched: idle: Respect the CPU system-wakeup QoS limit for s2idle
Date: Thu, 16 Oct 2025 17:19:23 +0200
Message-ID: <20251016151929.75863-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016151929.75863-1-ulf.hansson@linaro.org>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU system-wakeup QoS limit may have been requested by user-space. To
avoid breaking this constraint when entering a low-power state during
s2idle, let's start to take into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rework the code to take into account the failure/error path, when we
	don't find a s2idle specific state.

---
 drivers/cpuidle/cpuidle.c | 12 +++++++-----
 include/linux/cpuidle.h   |  6 ++++--
 kernel/sched/idle.c       | 12 +++++++-----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 56132e843c99..c7876e9e024f 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -184,20 +184,22 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
  * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
  * @drv: cpuidle driver for the given CPU.
  * @dev: cpuidle device for the given CPU.
+ * @latency_limit_ns: Idle state exit latency limit
  *
  * If there are states with the ->enter_s2idle callback, find the deepest of
  * them and enter it with frozen tick.
  */
-int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+			 u64 latency_limit_ns)
 {
 	int index;
 
 	/*
-	 * Find the deepest state with ->enter_s2idle present, which guarantees
-	 * that interrupts won't be enabled when it exits and allows the tick to
-	 * be frozen safely.
+	 * Find the deepest state with ->enter_s2idle present that meets the
+	 * specified latency limit, which guarantees that interrupts won't be
+	 * enabled when it exits and allows the tick to be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
+	index = find_deepest_state(drv, dev, latency_limit_ns, 0, true);
 	if (index > 0) {
 		enter_s2idle_proper(drv, dev, index);
 		local_irq_enable();
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a9ee4fe55dcf..4073690504a7 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -248,7 +248,8 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev,
 				      u64 latency_limit_ns);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev);
+				struct cpuidle_device *dev,
+				u64 latency_limit_ns);
 extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
@@ -256,7 +257,8 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     u64 latency_limit_ns)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
-				       struct cpuidle_device *dev)
+				       struct cpuidle_device *dev,
+				       u64 latency_limit_ns)
 {return -ENODEV; }
 static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09..c1c3d0166610 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -131,12 +131,13 @@ void __cpuidle default_idle_call(void)
 }
 
 static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
+			       struct cpuidle_device *dev,
+			       u64 max_latency_ns)
 {
 	if (current_clr_polling_and_test())
 		return -EBUSY;
 
-	return cpuidle_enter_s2idle(drv, dev);
+	return cpuidle_enter_s2idle(drv, dev, max_latency_ns);
 }
 
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
@@ -205,12 +206,13 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
+			max_latency_ns = cpu_wakeup_latency_qos_limit() *
+					 NSEC_PER_USEC;
 
-			entered_state = call_cpuidle_s2idle(drv, dev);
+			entered_state = call_cpuidle_s2idle(drv, dev,
+							    max_latency_ns);
 			if (entered_state > 0)
 				goto exit_idle;
-
-			max_latency_ns = U64_MAX;
 		} else {
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
-- 
2.43.0


