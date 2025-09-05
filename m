Return-Path: <linux-kernel+bounces-802503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE8B452E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973E43A1A88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DDA313E10;
	Fri,  5 Sep 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HZQwQvO4"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246130507F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063619; cv=none; b=G/aP5/K3osTjnXfjDZzaJh1MNHRoVPeLlcsO3UaJ9agMAw6ovtUGB08F1LfOlE3rjVb4Cxgl/r/fdTK1+5IUHW/49zhb9ZY0/IjHQyaaKAYZGSl5rzsb9fj7VBZcMrMbLEBFQjnS1oKT6kkBHoRcsWaNCGcyUFhSBcZxYfmJBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063619; c=relaxed/simple;
	bh=m0nF1hgIpqmzkV/Wes5siML6Pi7yBWHGWMcNN12UAnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv0XaChVmCOOljTwTeUlKlZVd25nNVllyXao/PHvEFgG4F45q2l3yV5YZhz6CtZMoiG9R/6xw0Ixju37nlt6T0JU8rLl8Cvj+Mq+Uux6mQrS+EaE+U+3AnP+E5xGggyMcE8sl0wP3OCv9zz3LDQtg9bYo2nY8L7ZIRvJU+QK6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HZQwQvO4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e249a4d605so1208031f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063614; x=1757668414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR2xqRJLV5wcc1BaVz4hew+xeHnmtpMPVb/CKMgOX6U=;
        b=HZQwQvO4rWnCy2YRplBTl0l7huY1XjMpawWgcxKxS9AlFe+ej47sl59Du66tyX38DS
         PBsItGjoL9uaSL78cAUJuL572ootuQnSlsRB2ELFBj2GoujpNyoXs7sc1xnaE3luE6y+
         0x0/NKB6ywT5oAjtu+VbkqQlhIv1SVncPL3IRTzxTXbaImrNzWIkEeNRV2uRxDM3mnP+
         qk5lDQUA+asbnCi9VJYmZ2jIsrBI2CEtdtr3UVQDx2AO1M2oo+nof2f6U0mbrW488f3v
         4mkOtoUIL1GsFIkwg8j5m2GkA2RRG1PYRFB5rHxWukjUkCzEl5Jw9yQpIIM5sG0uqZcx
         L5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063614; x=1757668414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR2xqRJLV5wcc1BaVz4hew+xeHnmtpMPVb/CKMgOX6U=;
        b=Uqo7iucoNZAYjC2JhYUFzrEpyAFb5MWaLxPDtwu2t5z87zaEEJ/rP2bVnxuY1XtnfX
         QwxgRvnyl7KwHoyE6SIsF74w98dxHjtZ371h+Mau2HY+MZ3NryOwG81ZkZ7zFpSL7Squ
         XMbN2AcNw61X8ZlRWa7gGtUJ/Zy4Iac4ISF+95ls9iwZgSPc0W8kIOsMBoOwacbQRQnW
         5qNqM+nVCrr5iSD4x7YfZTHLtLGu/onufK0IWF1q5MJNcosI+3JbPMmGGlxqD/OT41Vs
         jDOnRCW3x8qa6xUrksft3364VhAYv3Bdi0KDwOlCiG07+OwFAp3JLzRJgz/7leupR7pp
         e6BA==
X-Gm-Message-State: AOJu0YwlYauA+5nyvtNjzdp6hNosscmaVEUQM8iLe9xc3bT02PiCqEyN
	q0P/vd4rh6CsrgOwG7aR3RAIC+ngECSRUkpKwBGgZBjulaZBE06oXSXsAh/hZRSZcxpdKAbx9uz
	cQZoliW8=
X-Gm-Gg: ASbGncsMRVavX86DLAhzyweHhQfvnMf24+hzphc6NG6jpKXKs1UEDMhkuw/NxJpzIc5
	ZE/vOhoLdXS2+X/pc/8Q7rtEYBnQHFuZ632+puSdxcz6WycLIRZGOkSe1+YAyN/dSgEVA4OvYfJ
	M02w2nvW7j6sG9bvwHSE2x8xiG+1WL10lwrTlydMWeLCD4EhQUsJxQR1tMjvB0CSE555fwpSGC/
	s61g5NMjIp/lkX0HzOq+iuFWhTGlY8e6hu7LTTLV7G8MiYQRSPk/MbeeQpnXS7xLOm4DVvuNVGs
	TIozRbda1ID32zrr6KlmaGT9M4P2W6p4/E5pDrQ9kvuFXlgVCQWgemOmckZOKuXZH5kgS46R8fR
	ZoPT6RToZw3aOd8cPrlvlLkeTwIvjE+2YPZrPXwZFeujm2NIjghrHMnen7A==
X-Google-Smtp-Source: AGHT+IEu8cEB81VVj3TQ5rAeg3WZ9lkLlX8//hH2/Xy1UYV2yyb47JyuAh8SbhYq2wWfAc8Y6I0tRQ==
X-Received: by 2002:a5d:5f50:0:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3d1df53be89mr16859127f8f.58.1757063614271;
        Fri, 05 Sep 2025 02:13:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm167477f8f.0.2025.09.05.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:13:33 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/3] workqueue: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:13:24 +0200
Message-ID: <20250905091325.112168-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091325.112168-1-marco.crivellari@suse.com>
References: <20250905091325.112168-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 include/linux/workqueue.h | 22 +++++++++++-----------
 kernel/workqueue.c        |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 0e14d78fb970..542529d3b41b 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -433,10 +433,10 @@ enum wq_consts {
  * short queue flush time.  Don't queue works which can run for too
  * long.
  *
- * system_highpri_wq is similar to system_wq but for work items which
+ * system_highpri_wq is similar to system_percpu_wq but for work items which
  * require WQ_HIGHPRI.
  *
- * system_long_wq is similar to system_wq but may host long running
+ * system_long_wq is similar to system_percpu_wq but may host long running
  * works.  Queue flushing might take relatively long.
  *
  * system_dfl_wq is unbound workqueue.  Workers are not bound to
@@ -444,13 +444,13 @@ enum wq_consts {
  * executed immediately as long as max_active limit is not reached and
  * resources are available.
  *
- * system_freezable_wq is equivalent to system_wq except that it's
+ * system_freezable_wq is equivalent to system_percpu_wq except that it's
  * freezable.
  *
  * *_power_efficient_wq are inclined towards saving power and converted
  * into WQ_UNBOUND variants if 'wq_power_efficient' is enabled; otherwise,
  * they are same as their non-power-efficient counterparts - e.g.
- * system_power_efficient_wq is identical to system_wq if
+ * system_power_efficient_wq is identical to system_percpu_wq if
  * 'wq_power_efficient' is disabled.  See WQ_POWER_EFFICIENT for more info.
  *
  * system_bh[_highpri]_wq are convenience interface to softirq. BH work items
@@ -704,7 +704,7 @@ static inline bool mod_delayed_work(struct workqueue_struct *wq,
  */
 static inline bool schedule_work_on(int cpu, struct work_struct *work)
 {
-	return queue_work_on(cpu, system_wq, work);
+	return queue_work_on(cpu, system_percpu_wq, work);
 }
 
 /**
@@ -723,7 +723,7 @@ static inline bool schedule_work_on(int cpu, struct work_struct *work)
  */
 static inline bool schedule_work(struct work_struct *work)
 {
-	return queue_work(system_wq, work);
+	return queue_work(system_percpu_wq, work);
 }
 
 /**
@@ -766,15 +766,15 @@ extern void __warn_flushing_systemwide_wq(void)
 #define flush_scheduled_work()						\
 ({									\
 	__warn_flushing_systemwide_wq();				\
-	__flush_workqueue(system_wq);					\
+	__flush_workqueue(system_percpu_wq);					\
 })
 
 #define flush_workqueue(wq)						\
 ({									\
 	struct workqueue_struct *_wq = (wq);				\
 									\
-	if ((__builtin_constant_p(_wq == system_wq) &&			\
-	     _wq == system_wq) ||					\
+	if ((__builtin_constant_p(_wq == system_percpu_wq) &&			\
+	     _wq == system_percpu_wq) ||					\
 	    (__builtin_constant_p(_wq == system_highpri_wq) &&		\
 	     _wq == system_highpri_wq) ||				\
 	    (__builtin_constant_p(_wq == system_long_wq) &&		\
@@ -803,7 +803,7 @@ extern void __warn_flushing_systemwide_wq(void)
 static inline bool schedule_delayed_work_on(int cpu, struct delayed_work *dwork,
 					    unsigned long delay)
 {
-	return queue_delayed_work_on(cpu, system_wq, dwork, delay);
+	return queue_delayed_work_on(cpu, system_percpu_wq, dwork, delay);
 }
 
 /**
@@ -817,7 +817,7 @@ static inline bool schedule_delayed_work_on(int cpu, struct delayed_work *dwork,
 static inline bool schedule_delayed_work(struct delayed_work *dwork,
 					 unsigned long delay)
 {
-	return queue_delayed_work(system_wq, dwork, delay);
+	return queue_delayed_work(system_percpu_wq, dwork, delay);
 }
 
 #ifndef CONFIG_SMP
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 687285701655..89839eebb359 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7660,7 +7660,7 @@ static int wq_watchdog_param_set_thresh(const char *val,
 	if (ret)
 		return ret;
 
-	if (system_wq)
+	if (system_percpu_wq)
 		wq_watchdog_set_thresh(thresh);
 	else
 		wq_watchdog_thresh = thresh;
-- 
2.51.0


