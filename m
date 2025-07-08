Return-Path: <linux-kernel+bounces-722043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD9AFD3BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A9C3A93A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00B2E5B29;
	Tue,  8 Jul 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGGbi5My"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D12E5439
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993800; cv=none; b=kC5OzVoKHhOI8ZenihZVim8MevnB69PE1uz9jq9N6KWbkIV6yTGBX/S2qW68W9WXGKN/E0NUxtdqLiImnr0RHT6qET4i9I5OGO7GRz4mqp0MKrSCmOblEfoKvtcESfWOhzkNhmhQJ5mChL4HdAl0pG5UdY3g4XbJhnIHdycJw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993800; c=relaxed/simple;
	bh=ydZRP6+llQn1XG0Wed/Oa5HzhIcOTAV7GgM8Xhyvv10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtgupIR5aFe12aeqDZ1/AYzNB1GngNzMryWorrWB5ywM2dQ5qWAMbYW4JDxTfL9tpPyfbTLkkk08yPzcx5n24V63sMVFydqGFhhAuXSWL4O2s+67ngwewAfFnCuzcJ/UJsT1UkYlc66tudrkauIcIsRxo4FSMkZ1nT6n21ePBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KGGbi5My; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453066fad06so33051975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993797; x=1752598597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkQp02knqPCKiukiiHCeRaV1SL9ZYAgdUSB+fSbfNIY=;
        b=KGGbi5My0ceUWYViUlK6m8kbO4tUbQxojY22lnE5EQYrrGy2fCuoD/TpaV67jfL2m+
         AjsSWbKgLNmbOikil2AKmZleYqpWep+C9eEhGpk7bHFW2AEm333ucqEmh6Joiwxuu+L6
         33EqcSfk6juOY3Mvv79TXzbPZj6CVVJL2lK8fi0xe+2iHjUbEt3xam6UqEhUj7uHAxtn
         PrsYy04v4F6rDHC+uuq3NchGU1LFPAEL//jkQlnjRw/2UxB6EUzLByHc2szqFZr8HvB6
         X2TvSh0iAno1Hn6+ro63hwZeMhk1cl+ypyLhb6RoYoSpd+Olpqb9rbMjVzN3sPXnVUXL
         L8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993797; x=1752598597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkQp02knqPCKiukiiHCeRaV1SL9ZYAgdUSB+fSbfNIY=;
        b=fufziMA/5NEmliiDMBhcAyOJ1JSRvat0iH+uvban+HSDRleOnVCHxEvwvNLVH8kOaj
         bAO5sKaRfxe/wsnkVFdWgzlLuEFRo0DoF1dtuUZ9t1Q3JhLqlrDfnh7bq1fsmZwQ0E/f
         eaVB3F/abYth3GcJDLmr63TyuL3XQ8OpY2y1e6UyBlF1p6LbLpoxt3YcW+5qzJTFWx4X
         tD8+tIyo50v0uyD4pigcr25T29nHi41PCSOSp+znZ7xV+T6akwrOHztdndOmTxiCug3h
         RjgW8lt3r+JUep13L+E6cbg/9Wn6Hbt00B1Tv/Bw+23fuKr+L0HGgeBX63mz/rdd2arW
         Zagg==
X-Forwarded-Encrypted: i=1; AJvYcCV3cug+hQcVPMTki8+HoeRkAt/jqaOt5yvKgDRvL/gKNl3/WDoNeFsB1dNxtY+1evlpN7dLwnfQyelhph8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpdfqpjMw7QO1eFzrGhMCFYacNB/lUv4txEpAK9AWG23SM0S6
	1wCY2/QP3ObMh5o5JNUvK3RTBzrlVsQgLlot4jOyNkZ7jEcFzLMldnYZuwn7WXL6aN0=
X-Gm-Gg: ASbGncukhr6qeaabDJgQh64eiIM4MZIumYRgkRQpkK5WwA7Xma4iQ77E85IRJE5fUID
	ePaWe0F9KgqxP5xR8AVjVQspJG/uCXUWC8/DqnX0yfEjqWhYxBaMv53EfHNlHsOie7WR401CDns
	9YJYMS6YS8khO2NHsiypLIpt+OJ/AP1jSSt2ScEM9ynkZNt65M4rcEMJvNKlxRxnsv8Kock2Q+g
	Rf2ZbyFU9Qoft89LABggnCNB7iERacK92Wge7YKXAEExt1RlhClr65ch2Zg5GetIz4zbS0pL+IC
	EyLbPncMuSCWAiLvqcYRQquiJ70MH0WK7LeUpTsdg1xZOWv0AQxiHz2E7Wcjl8XhSbnptWg=
X-Google-Smtp-Source: AGHT+IElq5a9wfG2FKaD6LJBmCIfVXPss7CPTB2Oy9YVsJNsJezn70nwkPSvkFe5k+j5shzq9IiDZA==
X-Received: by 2002:a05:600c:1c1b:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-454d3882436mr2357545e9.5.1751993796936;
        Tue, 08 Jul 2025 09:56:36 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:34 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	dhaval@gianis.ca,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/6] sched/fair: Fix NO_RUN_TO_PARITY case
Date: Tue,  8 Jul 2025 18:56:26 +0200
Message-ID: <20250708165630.1948751-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708165630.1948751-1-vincent.guittot@linaro.org>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EEVDF expects the scheduler to allocate a time quantum to the selected
entity and then pick a new entity for next quantum.
Although this notion of time quantum is not strictly doable in our case,
we can ensure a minimum runtime for each task most of the time and pick a
new entity after a minimum time has elapsed.
Reuse the slice protection of run to parity to ensure such runtime
quantum.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h | 10 +++++++++-
 kernel/sched/fair.c   | 30 +++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eec6b225e9d1..75579f2fb009 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -583,7 +583,15 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
-	s64				vlag;
+	union {
+		/*
+		 * When !@on_rq this field is vlag.
+		 * When cfs_rq->curr == se (which implies @on_rq)
+		 * this field is vprot. See protect_slice().
+		 */
+		s64                     vlag;
+		u64                     vprot;
+	};
 	u64				slice;
 
 	u64				nr_migrations;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43712403ec98..97cf99bb71d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -882,23 +882,34 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 }
 
 /*
- * HACK, stash a copy of deadline at the point of pick in vlag,
- * which isn't used until dequeue.
+ * Set the vruntime up to which an entity can run before looking
+ * for another entity to pick.
+ * In case of run to parity, we protect the entity up to its deadline.
+ * When run to parity is disabled, we give a minimum quantum to the running
+ * entity to ensure progress.
  */
 static inline void set_protect_slice(struct sched_entity *se)
 {
-	se->vlag = se->deadline;
+	u64 quantum = se->slice;
+
+	if (!sched_feat(RUN_TO_PARITY))
+		quantum = min(quantum, normalized_sysctl_sched_base_slice);
+
+	if (quantum != se->slice)
+		se->vprot = min_vruntime(se->deadline, se->vruntime + calc_delta_fair(quantum, se));
+	else
+		se->vprot = se->deadline;
 }
 
 static inline bool protect_slice(struct sched_entity *se)
 {
-	return se->vlag == se->deadline;
+	return ((s64)(se->vprot - se->vruntime) > 0);
 }
 
 static inline void cancel_protect_slice(struct sched_entity *se)
 {
 	if (protect_slice(se))
-		se->vlag = se->deadline + 1;
+		se->vprot = se->vruntime;
 }
 
 /*
@@ -937,7 +948,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
-	if (sched_feat(RUN_TO_PARITY) && curr && protect_slice(curr))
+	if (curr && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -1156,11 +1167,8 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	cgroup_account_cputime(p, delta_exec);
 }
 
-static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+static inline bool resched_next_quantum(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	if (!sched_feat(PREEMPT_SHORT))
-		return false;
-
 	if (protect_slice(curr))
 		return false;
 
@@ -1248,7 +1256,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (cfs_rq->nr_queued == 1)
 		return;
 
-	if (resched || did_preempt_short(cfs_rq, curr)) {
+	if (resched || resched_next_quantum(cfs_rq, curr)) {
 		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}
-- 
2.43.0


