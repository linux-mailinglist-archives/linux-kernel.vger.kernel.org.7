Return-Path: <linux-kernel+bounces-841427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38ABB7479
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1184E4856A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E224285C84;
	Fri,  3 Oct 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiBgaHat"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C128507C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503798; cv=none; b=uDAOQmxEooyC7w8Aq3/EcIV49UIYTh+DWkvpJB+BZ9wxxa4pvjGEUPmhn42q9s5tP46i/Csf+Aj5zWa1xXr3YJFtJKQwFWqWLsjMEMfNCwkzoQY1dyljUxMnYRGGro4BNZgYTS5Y2uwsb84MaCT3pnzIa/014INW2naEfKmf/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503798; c=relaxed/simple;
	bh=AXCrGXN9rK3o1GNT7tRiGh1jrV37gWDegzLLQuvmcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odR7v84crekQ1FfASXsMztVGchZ0nHuddrgTw0dEr7PdudL/ZOk0gI0TihuVxrDoOYpZ2fYpV81N08dNpDPj6GA1Cjzof87W54dVm9bhjz8/ONgXbiSTEdRixaTmQZah1yy8Ur+BB8SVkNlaq/H/Gij1Bpg1zbuYb4oWa9SOOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiBgaHat; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57ea78e0618so2648154e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503795; x=1760108595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox+4Or53Zo/RT8nK1iXRO8MRcxCOezKN0PgiKGiKSzk=;
        b=UiBgaHatkjU8Ht6zlSG7EWWaPsmAw2mhL3Q27DDasP96smW84UUwAaxX7UMNBLiRMq
         +MVLzAlAwgad+46eRCsCOKrcJ/r2UDfTr3S7V2mEOP579Y+PxeufrrUWPZNXNtwc0TjP
         Kd01AHb7O8/q0YBuvVzsNknZ9EMaiZLa8Tvgcj0I7rMS0B2lpAkxz7fbVh4MMvK9hzC+
         8HiRaLKnWoAUNDHg6D5rkjAbY585FYJvUxSrYwnyNcDT52SzqBCT+jDJU9PlW7tS5oLG
         yp3ddkZnRbOQ0LrI2EHyXJ2o/2EgTzAHFuhhT3KiqxRKf1ke2Tli+YWdNWwE2Zhkp5HO
         j5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503795; x=1760108595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox+4Or53Zo/RT8nK1iXRO8MRcxCOezKN0PgiKGiKSzk=;
        b=buBMtLc6cD+Ff1mSWLdxrMWODAp9CNvD3yDGlh2TgaFX+0GOx+vqJewCfWsoK1n4vE
         7MfiuSeuMXjRnMiVmYLmszpgeHHs3BPYUrafEL8P0hYX2SskEvyfRwATwhaBcWxO51zG
         ZU0pRcrgvJq/7f6qNS8EGRa6wnEIBzzGxe4nEVHUlcE7GNwqKUbzjt4w8roS/4KSY7Aq
         xM0U0KKYomiNTFtC3FLtpe6CmtPH43K83uBq7imfuCjiVVUDOF/QHKTNMJh0B4KaMvX0
         ygujiKMDS7kdiVacukudb3JWiPKLXEv6Hv/DOyiDuIH9zMOsXTUPoODQVn4+Y9yt0X5U
         fkrA==
X-Forwarded-Encrypted: i=1; AJvYcCUOduEAw38EBhIOtX43bmEoPk1PFQixcXaUKIE+7m8rIDumtAh5pP2R3//T9MX2fW4p1MAq9u07oDr0kFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPytp8AZO/fL9BRc3t/h09eYvVvyGwe8beWpszlq3GReD9Z+L6
	vCRcEhZn+33UlbERXte10MuPH1W/9xoyMVQNob2irR1orjUUiBQm2PMGptTYf7K9oeE=
X-Gm-Gg: ASbGnctrI4dWhLK0eaATVrLGyUNM4c7cKpVxg61Koh2nkl4V+kbh/peTVpc/9qQfxxy
	6ewNfzh9u2y3OYytMj4WwG7IukslJ4Ynun8GdtTdwhIN6zgMOvljgi6Dih8GvhvsH4hqN5/1lpO
	2ByOZbJADSoTy9n3qkuw9lnJCIdqF7mAGrOri/tcZT7M+NwyVBwuh0kRSu76A5TrJ3iMfleT31h
	y42GzgKEN+sVvCjNochbB4FCd6OQHaaGTbRamgzaGg1CXDyC533yZGD4DACXath8K5vFIcjbFaz
	2d3OSlE+hdMQq5ysBph/7HwEeb20urIiopeoB/iEnuksRO3iWM9J3xlnutE+zNL9WfAr7e/LIHJ
	KWAio1Zl2UHN+6GT3Tq66I2B6xTGgGHL0h7uJfnmLd75JYIdQ/VaIDB5LWr6DiJZ7tUELa3fmTv
	K0LxfE9NX8I22tqOJ3ee9m7DCDhOKK3Jlopcc=
X-Google-Smtp-Source: AGHT+IH13UMFUj7Zpgvxqzpadk8FthG6NhdcXG10MwTPwlzbyaOGt0KOWk+7mn3p72gNfh5AfAblSw==
X-Received: by 2002:a05:6512:3e10:b0:57a:de0d:d9ce with SMTP id 2adb3069b0e04-58cbb90df9cmr1031413e87.44.1759503792699;
        Fri, 03 Oct 2025 08:03:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:12 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] pmdomain: Extend the genpd governor for CPUs to account for IPIs
Date: Fri,  3 Oct 2025 17:02:45 +0200
Message-ID: <20251003150251.520624-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003150251.520624-1-ulf.hansson@linaro.org>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the genpd governor for CPUs, tries to select the most optimal
idlestate for a group of CPUs managed in a PM domain, it fails far too
often.

On a Dragonboard 410c, which is an arm64 based platform with 4 CPUs
in one cluster that is using PSCI OS-initiated mode, we can observe that we
often fail when trying to enter the selected idlestate. This is certainly a
suboptimal behaviour that leads to many unnecessary requests being sent to
the PSCI FW.

A simple dd operation that reads from the eMMC, to generate some IRQs and
I/O handling helps us to understand the problem, while also monitoring the
rejected counters in debugfs for the corresponding idlestates of the genpd
in question.

 Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             1451           437        91         149        0
S1             65194          558        149        172        0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.562698 seconds, 140.3MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2694           1073       265        892        1
S1             74567          829        561        790        0

 The dd completed in ~3.6 seconds and rejects increased with 586.

 Teo governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             4976           2096       392        1721       2
S1             160661         1893       1309       1904       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.543225 seconds, 141.1MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5192           2194       433        1830       2
S1             167677         2891       3184       4729       0

 The dd completed in ~3.6 seconds and rejects increased with 1916.

The main reason to the above problem is pending IPIs for one of the CPUs
that is affected by the idlestate that the genpd governor selected. This
leads to that the PSCI FW refuses to enter it. To improve the behaviour,
let's start to take into account pending IPIs for CPUs in the genpd
governor, hence we fallback to use the shallower per CPU idlestate.

 Re-testing with this change shows a significant improved behaviour.

 - Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             1994           551        10         24         0
S1             115602         801        4          56         0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.622631 seconds, 138.0MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2462           766        14         202        0
S1             119559         1031       9          253        0

 The dd completed in ~3.6 seconds and rejects increased with 9.

 - Teo governor
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             3212           990        16         245        0
S1             202442         2459       13         1184       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.284563 seconds, 152.2MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             3387           1046       16         265        0
S1             206074         2826       19         1524       0

 The dd completed in ~3.3 seconds and rejects increased with 6.

Note that, the rejected counters in genpd are also being accumulated in the
rejected counters that are managed by cpuidle, yet on a per CPU idlestates
basis. Comparing these counters before/after this change, through cpuidle's
sysfs interface shows the similar improvements.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..7e81dc383269 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -404,15 +404,21 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
 		    genpd->states[i].power_off_latency_ns)) &&
 		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
-		    genpd->states[i].power_off_latency_ns))) {
-			genpd->state_idx = i;
-			genpd->gd->last_enter = now;
-			genpd->gd->reflect_residency = true;
-			return true;
-		}
+		    genpd->states[i].power_off_latency_ns)))
+			break;
+
 	} while (--i >= 0);
 
-	return false;
+	if (i < 0)
+		return false;
+
+	if (cpus_has_pending_ipi(genpd->cpus))
+		return false;
+
+	genpd->state_idx = i;
+	genpd->gd->last_enter = now;
+	genpd->gd->reflect_residency = true;
+	return true;
 }
 
 struct dev_power_governor pm_domain_cpu_gov = {
-- 
2.43.0


