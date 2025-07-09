Return-Path: <linux-kernel+bounces-724052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A300AFEE02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1470B4E5AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA762E8E09;
	Wed,  9 Jul 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E84lmFSn"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F382D3A86
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076070; cv=none; b=k8kr0SSj/RaaaC/wWSbuYqvFONHzvQdx/rbiTz0mCUFSoqtI/Kvlu9fZ+KazI7cAOkylbe/lMLtZlMGSuVEeTRg9Fg35fpklB4VwyBVmGCG1dWxwSMgup+urhGYgFh2BkiJUn35S9GAZyUqgYBa4X/2LtPL/i8g7oa3JwbBlE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076070; c=relaxed/simple;
	bh=h6tMRQRXn67KOocJPl7gL2XSOaaSQRap9WsxQwDoJLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIgelgfa0axidty26VzWKGmZVPFIDpe+KGFLDNdyWNTjTv3Q/xKmH/Li+xeH4RXt84QMzQOJqcakw2AhiHvYFmmHvQq6lKnJtf5BsfUnQl9fhbC2LYNa1hJjOyoXlbMVUdvVOpzeZ/eopJNYu1ZyOWgqY05+2yRak9zRrIeBFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E84lmFSn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso64902f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752076066; x=1752680866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M7LELCI1cPFBstNSyN002g4c3zY7P9EeDdL35tmOwI=;
        b=E84lmFSnmHBpUWKcnOp7gkz1a+J7IIz0uyU+ZaSkNK7sou1YggHzcpemdEQfGqj4eG
         ablawCUq399SHmSFlk+4gKeBgRLU8Twh6l6U7afVlnsjWuRWy9/VgYy8/DjvCX6qrgar
         9TFV8X9Mymjvv3QZEhmgRqUoy7ZTNzznAvwTu3e5jyRsQEpgcDTUganHsRmbyg5D9Zwo
         AR3okqhFm/PscynOoGOlIjPerkkECyHqpfPLk4Rc4TOlyaxhdwsCRT+0TH5v2Prq7qRy
         6slmu//kY4YS0Mfa6/qjkcaOD6WlUsQgHDfrmg/CydYbB3LE2Oy7JP4z9coJpoaFkSbN
         m6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076066; x=1752680866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M7LELCI1cPFBstNSyN002g4c3zY7P9EeDdL35tmOwI=;
        b=LTW0ERRHlVIiFBaWoOZGufR53M7o/EYc9X/lHth+FjBrYYlU/0xYHr6s/l+TbfwI1T
         tKJNIOg5FIQEjkzuH3nu1SanvIw+65vSPP1sckvA2IUfbe+BHz5s99DLp2IK6mVF38d2
         q6TE0TEwgIHkMXWdGqDO9BLwUAm7mw/In9QeKvEUCn7/hoSWoWfrHpzf8lshg7TjxJaE
         +vsiT9LIWo/29a8iBVhnnyFKASCRSqvPc1sX6lFZaMaw9cDTnhrnDgZK+Ic6K0UVkBbb
         RwZfKvTprouj9B80lEJfxiREjZ1YQGjBE5zyjWcTWJejAVH8Ajd1hBbNVArHH94A5zIz
         R0QA==
X-Forwarded-Encrypted: i=1; AJvYcCV/c3tzZaKgzpIguL5yZyX8DmHWT8jiqbFXTGPP1bBk/SbwsM+YlSFONXqisRUJp/HOJ1UPXCzEvrlJQck=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfT0cvuwQ9bjDoH61g+vtgGfPx2wi3wHxX3BQO4ReEu+qaBMx
	zrZe9LW7Rrv5A6Ebf1Dpg6UsW8FHXtNqN+gQWCkUNFoygFfW4qv+S6tyKStZVioAPvc=
X-Gm-Gg: ASbGnctqS2nbd4dAqscl1Vsi0u0pbpCWNsW/d4YlRGSwr8wlDDavTlBDe7s6JL+rqSO
	pumWbNtLVLQGFQTHq0wvcEcbDnENQhdhxQT1KI3gJDcP47MtcRHstBe1/aEZr4/5ANI9vnkKMw7
	jzj1NETFR2ndXY1jwki4n7SFhPAWZHqwWnaQRXQRX33jGfWD4P2llFNIifj1aEpCSW+rXZmv0Q0
	tL2Pr57KK4CnS8wG/IRsO0gk6Rgh/VPGlFXjyf6yL7EpIm0Af0a8T7+0eDgLcwgrKOZQvTWkU8l
	U4QcklMGMR0PUaUxoUoYhTW1Ur686c2LLMGbo6gsL2WAxHNuDW4p+1BXR0B1cqFb0euaaXlJudQ
	WFTn/jmwoIBLD
X-Google-Smtp-Source: AGHT+IFtb3wKvcyNXV4wx2vLvybT75yPG2OAwmNgwliyjrb9KJP4FNMYX9tqHYbI3ZRouro6vvXlVw==
X-Received: by 2002:a05:6000:2206:b0:3a5:42:b17b with SMTP id ffacd0b85a97d-3b5e452a289mr2446888f8f.29.1752076065919;
        Wed, 09 Jul 2025 08:47:45 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm16783647f8f.59.2025.07.09.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:47:45 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org,
	sudeep.holla@arm.com,
	ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT))
Subject: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
Date: Wed,  9 Jul 2025 17:47:28 +0200
Message-ID: <20250709154728.733920-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
not supported because the underlying generic power domain functions
used in the cpu hotplug callbacks are incompatible from a lock point
of view. This situation prevents the suspend to idle to reach the
deepest idle state for the "cluster" as identified in the
undermentioned commit.

Use the compatible ones when PREEMPT_RT is enabled and remove the
boolean disabling the hotplug callbacks with this option.

With this change the platform can reach the deepest idle state
allowing at suspend time to consume less power.

Tested-on Lenovo T14s with the following script:

echo 0 > /sys/devices/system/cpu/cpu3/online
BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
rtcwake -s 1 -m mem;
AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
if [ $BEFORE -lt $AFTER ]; then
    echo "Test successful"
else
    echo "Test failed"
fi
echo 1 > /sys/devices/system/cpu/cpu3/online

Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 4e1ba35deda9..b19bc60cc627 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
 static bool psci_cpuidle_use_syscore;
-static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
 			   u32 state)
@@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
-	if (pd_dev)
-		pm_runtime_get_sync(pd_dev);
+	if (pd_dev) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_get_sync(pd_dev);
+		else
+			dev_pm_genpd_resume(pd_dev);
+	}
 
 	return 0;
 }
@@ -135,7 +138,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
 	if (pd_dev) {
-		pm_runtime_put_sync(pd_dev);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_put_sync(pd_dev);
+		else
+			dev_pm_genpd_suspend(pd_dev);
+
 		/* Clear domain state to start fresh at next online. */
 		psci_clear_domain_state();
 	}
@@ -196,9 +203,6 @@ static void psci_idle_init_cpuhp(void)
 {
 	int err;
 
-	if (!psci_cpuidle_use_cpuhp)
-		return;
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * s2ram and s2idle.
 	 */
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
-		psci_cpuidle_use_cpuhp = true;
-	}
 
 	return 0;
 }
@@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
 
 	dt_idle_detach_cpu(data->dev);
 	psci_cpuidle_use_syscore = false;
-	psci_cpuidle_use_cpuhp = false;
 }
 
 static int psci_idle_init_cpu(struct device *dev, int cpu)
-- 
2.43.0


