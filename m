Return-Path: <linux-kernel+bounces-856450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917DBE42E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B88EB358F62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097BB34BA4B;
	Thu, 16 Oct 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moP1n3Ng"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312034AB09
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627987; cv=none; b=RrsMmB6e5tK15SEJ34w6hmNxuEQz1wSghaDwKIITu5f3+WgtqOmnilr48gU2LK1bUz5AJDRPLAXXbhTTs546KNihxTzL1vkv+5lg9WAPF482usY4aj2ITBAyH7JyLBu1fO3o14kRlWWCqosB5fyUH/zIwhQvENlHflpKA9IjKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627987; c=relaxed/simple;
	bh=QfTmQDOc1pDn+Jv1CASWybdMSC/xCqrK8wzzxyN33ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh7qZO+qa86Pivj7zC6wtrznftmfOp2hE6ih4X0WddeyHU0jdCbF5DKXBndTErjzhwwxgrlMlNmg6UzGJ1We48+ZvVP6zaMATT21fYec/R6C6rQuFlF3VGAOboZv4AMV+frkC1l8S42S35NL4pnIpPAVR1FCQ8bmUccF6EvisWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moP1n3Ng; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57ea78e0618so1092812e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627983; x=1761232783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCBJWiwmmJTUNM0j8C8szqE8iwROCYTEd9fYpRnBY7g=;
        b=moP1n3NgvqW+gWYkeznwT6xVCkt86tIJPFIO7c0N+rGw3IjlRErMIq9p3v372Glu9j
         ik73Cs5pxQAUu75iRLa3axtXQF4GpKDG6m1/dZ/7x0yQ2g45/vca5jDmoug4kTt5mGGr
         zbf+YauGjUB37Roatp8t7Km9xUHIcFyvt23gKRLoRqILzqnYCK/NoHMa/GqBFqxMCoEe
         Os1OlyUHlVP1XjEgBv8+RQW+8efnjv6gYjtkWyyWTKRKjF4qVA+IMU4h9cbca2KEx/yY
         xHnrhGIXUNodQtlSJdWwCNBzHbA0UudrwgwfiQUvD/2kuZKDIuB/eWI4AF9VumpMoqtY
         kWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627983; x=1761232783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCBJWiwmmJTUNM0j8C8szqE8iwROCYTEd9fYpRnBY7g=;
        b=Ls5lsiA3fEVCG1wbWY+QJ7kWAmp5hygmrr3d3xfDL8LeQK5N/o1XZ2dIU9wAH38323
         2oxY/WteIuCmcdApTPzPdg4yoi+n4WdD0Kza6vmj8X0jgFvvmg2CWRufGkh8sr6tbq2A
         kdpX3/GWSGxX1QEGyvGay7RmZi7MXsBrBZYNQigcBaoN32LyxqqKo99gflLiEewVmpvM
         r7WkVtdRlM6FB6APD4WUGllGojBjUNtLkpUSPKfbq7ywfwd67Xi1RbE0HzDbY7cGUwij
         3LT+Ob8W6VDgmfQX1rid01RD2oZrUmLRtOp2xt3+CZjTLoHiDF6u1papiVu7XpMXONIR
         ztmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2qA7BBshWpQCpQUYUJuphg+Wq08FMpq6clNb7nxPXPf/QNp4ZsYiD/9Maz5FwQGDuv0WkL0BP2LtnRMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gLzMq4mrsibvjafEFztqIJJWEW3Q0aGi3s44DvUH6id1rnno
	dQxhCJltU8vZCz9mC+MDYYPHh/Zbz9vjKR9SHuI22cV2duJ615H3UUf+hBOOj6yeIVA=
X-Gm-Gg: ASbGncvXbtrOnRjbCFB2XZAbIK7H56f7/U9uRg2wgArHf5hxkkqBdu1OPxBCt0Mrkkm
	Kre3yYGDuDl4UiD57uOZzYpYxc2mC8wNtYkcqpFWRHoxdJB8miRNMG3Dghpen3USqbci9clppn4
	8kpz6ZJtkOYDtmT8aBMcXkwBt9M/kqo8Jp9XgmoF2c96rbP8xFmyrPDTf7eO4eSTC1ZlUy9wgHl
	FA2jdh5tAdcA+EVL4Jj7NLUuQVUAW5d/iX4/l5KFmmxdrErcKC9XkR/vAu3jWdnT47fJii4j1dM
	ydZmnbk6P2pscF0Ue2p6oW0QchUDpB9yBAX5MS4qpXk9hfihS2et8Cjr9XeadIoJC/lwAWIGg5p
	FhuDSytGl4fnzWZbVHz84Tdw4CutcTLLfkGoks20Tch4hJo6e3ad3VFojdn0YsgT72Y4+tci+kd
	qQRzJ5omSoKrtI09iBCunCfTcUo1ur5h+4qfIrVbmVKFIIk2b1EEqNNq2cB6xy
X-Google-Smtp-Source: AGHT+IF5oCdaBh84LKLSVZ51c8p7Jct0vsWdmbZ3Nwl6dlWGi8PUK/GV6A2horTszFBvye+XnNBgqg==
X-Received: by 2002:a05:6512:b89:b0:578:ed03:7b5f with SMTP id 2adb3069b0e04-591d8589d9dmr133097e87.26.1760627981949;
        Thu, 16 Oct 2025 08:19:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:41 -0700 (PDT)
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
Subject: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit during s2idle
Date: Thu, 16 Oct 2025 17:19:22 +0200
Message-ID: <20251016151929.75863-3-ulf.hansson@linaro.org>
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
s2idle through genpd, let's extend the corresponding genpd governor for
CPUs. More precisely, during s2idle let the genpd governor select a
suitable low-power state, by taking into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Limite the change to the genpd governor for CPUs.

---
 drivers/pmdomain/core.c     | 10 ++++++++--
 drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce3..4fd546ef0448 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 			return;
 	}
 
-	/* Choose the deepest state when suspending */
-	genpd->state_idx = genpd->state_count - 1;
+	if (genpd->gov && genpd->gov->system_power_down_ok) {
+		if (!genpd->gov->system_power_down_ok(&genpd->domain))
+			return;
+	} else {
+		/* Default to the deepest state. */
+		genpd->state_idx = genpd->state_count - 1;
+	}
+
 	if (_genpd_power_off(genpd, false)) {
 		genpd->states[genpd->state_idx].rejected++;
 		return;
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..bd1b9d66d4a5 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	return false;
 }
 
+static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
+{
+	s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int state_idx = genpd->state_count - 1;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
+		genpd->state_idx = state_idx;
+		return true;
+	}
+
+	/* Find the deepest state for the latency constraint. */
+	while (state_idx >= 0) {
+		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +
+				 genpd->states[state_idx].power_on_latency_ns;
+
+		if (latency_ns <= constraint_ns) {
+			genpd->state_idx = state_idx;
+			return true;
+		}
+		state_idx--;
+	}
+
+	return false;
+}
+
 struct dev_power_governor pm_domain_cpu_gov = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = cpu_power_down_ok,
+	.system_power_down_ok = cpu_system_power_down_ok,
 };
 #endif
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f67a2cb7d781..93ba0143ca47 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -153,6 +153,7 @@ enum genpd_sync_state {
 };
 
 struct dev_power_governor {
+	bool (*system_power_down_ok)(struct dev_pm_domain *domain);
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
 	bool (*suspend_ok)(struct device *dev);
 };
-- 
2.43.0


