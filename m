Return-Path: <linux-kernel+bounces-845386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F37BC4AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7354F12A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66B2F7AA0;
	Wed,  8 Oct 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w0jchSIj"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AE1F92E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924800; cv=none; b=KBztKiArHp+NraEIbKLFjQNiCNDHm4PZ7kluVjSeGAkgsj6/c2Hh+LrjuE4DV0mhNohOZqhmJLowa3eMMmqolCPmL5MNzOtFDMzXuBr0ffz1ME4lVbv7lFG45OaT4gX1PL67E3M1iHhkk617Ge7gkum/0EtYCR2oF9sNY2ca1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924800; c=relaxed/simple;
	bh=x4hcMVSqO+4VaWdGmJJjWEk8llEnHRDsj2WVzWfuEdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqtmIUebFqcawkWpyUZwVnT/VBpjDBhn4seuCTZXuVdLP8+bax6vCEYxJnoHJPWb1ZyE6VCif1i9kUeGd82u1EjPmsZZHRfrTGMSAGNbYuq0DRBRAGOmAZpbQCtnDvC6XyAZ6RNI2qqDj4C3pQRU/hfoQaESRdLWB+Y0P41eAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=w0jchSIj; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7E73EC02C1;
	Wed, 08 Oct 2025 14:57:55 +0300 (MSK)
Received: from dev-vm2-nested.ru-central1.internal (unknown [2a02:6b8:c0e:501:0:fca5:0:123])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Rvk7ub0FsW20-bml5UPFK;
	Wed, 08 Oct 2025 14:57:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1759924675;
	bh=esLBptsdquH53haBk2OP87zikWv0XVIlRgzWrdsNBU0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=w0jchSIjFNUrBzEojP36+EgWI8pIlo7K0wGBV6ornetiCMN2t/EgI021zY0UG1bjQ
	 GKwKScbOpiuGlCMF3QquVsoRP6QUyNt3APxhvZTwwClxbhOFI9mJh+cV74FZYz68F9
	 CT3pTg2K+Xm7YNG9fT+rRh2Tw4rlouijQD2Mrtco=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
To: hannes@cmpxchg.org,
	surenb@google.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	Kirill Martynov <stdcalllevi@yandex-team.ru>
Subject: [PATCH] sched/psi: add "abs" pressure type for memory resource
Date: Wed,  8 Oct 2025 11:56:58 +0000
Message-ID: <20251008115658.719006-1-stdcalllevi@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current PSI memory pressure metrics ("some" and "full") are normalized
against the number of non-idle tasks in the system. This means that
reported stall ratios and trigger behavior depend on overall system load.
When the system is mostly idle, even small stalls can appear as high
pressure, while under heavy load the same stalls may look negligible.

In some use cases this normalization is not helpful. Userspace components
that react early to memory pressure, for example by adjusting memory
reserves or throttling background activity, need a signal that reflects
the actual stall time regardless of task count.

This change introduces a new pressure type for memory called
"abs" (absolute). Unlike "some" and "full", the "abs" calculation
in collect_percpu_times() skips non-idle weighting when computing deltas,
providing a load-independent measure of memory stalls.

The new metric allows detection of early memory pressure, which can be
useful for proactive memory management.

Signed-off-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
---
 include/linux/psi_types.h |  1 +
 kernel/sched/psi.c        | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index dd10c22299ab..65acd58f6766 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -61,6 +61,7 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+	PSI_MEM_ABS,
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	PSI_IRQ_FULL,
 #endif
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..4da28df19bf5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -252,6 +252,7 @@ static u32 test_states(unsigned int *tasks, u32 state_mask)
 
 	if (tasks[NR_MEMSTALL]) {
 		state_mask |= BIT(PSI_MEM_SOME);
+		state_mask |= BIT(PSI_MEM_ABS);
 		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
 			state_mask |= BIT(PSI_MEM_FULL);
 	}
@@ -389,8 +390,12 @@ static void collect_percpu_times(struct psi_group *group,
 		nonidle = nsecs_to_jiffies(times[PSI_NONIDLE]);
 		nonidle_total += nonidle;
 
-		for (s = 0; s < PSI_NONIDLE; s++)
-			deltas[s] += (u64)times[s] * nonidle;
+		for (s = 0; s < PSI_NONIDLE; s++) {
+			if (s == PSI_MEM_ABS)
+				deltas[s] += (u64)times[s];
+			else
+				deltas[s] += (u64)times[s] * nonidle;
+		}
 	}
 
 	/*
@@ -406,9 +411,13 @@ static void collect_percpu_times(struct psi_group *group,
 	 */
 
 	/* total= */
-	for (s = 0; s < NR_PSI_STATES - 1; s++)
-		group->total[aggregator][s] +=
+	for (s = 0; s < NR_PSI_STATES - 1; s++) {
+		if (s == PSI_MEM_ABS)
+			group->total[aggregator][s] += deltas[s];
+		else
+			group->total[aggregator][s] +=
 				div_u64(deltas[s], max(nonidle_total, 1UL));
+	}
 
 	if (pchanged_states)
 		*pchanged_states = changed_states;
@@ -780,6 +789,10 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 			groupc->times[PSI_MEM_FULL] += delta;
 	}
 
+	if (groupc->state_mask & (1 << PSI_MEM_ABS)) {
+		groupc->times[PSI_MEM_ABS] += delta;
+	}
+
 	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
 		groupc->times[PSI_CPU_SOME] += delta;
 		if (groupc->state_mask & (1 << PSI_CPU_FULL))
@@ -1289,6 +1302,19 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 			   total);
 	}
 
+	if (res == PSI_MEM) {
+		unsigned long *avg = group->avg[PSI_MEM_ABS];
+		u64 total = 0;
+
+		total = div_u64(group->total[PSI_AVGS][PSI_MEM_ABS],
+				NSEC_PER_USEC);
+		seq_printf(m, "abs avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
+			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
+			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
+			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
+			   total);
+	}
+
 	return 0;
 }
 
@@ -1315,6 +1341,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 		state = PSI_IO_SOME + res * 2;
 	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
 		state = PSI_IO_FULL + res * 2;
+	else if (res == PSI_MEM && sscanf(buf, "all %u %u", &threshold_us, &window_us) == 2)
+		state = PSI_MEM_ABS;
 	else
 		return ERR_PTR(-EINVAL);
 
-- 
2.43.0


