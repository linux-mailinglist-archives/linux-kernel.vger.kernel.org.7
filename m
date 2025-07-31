Return-Path: <linux-kernel+bounces-751964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBFB16FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FFB3B89B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F872BE7D0;
	Thu, 31 Jul 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUKakwI1"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFEF2BE03C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959351; cv=none; b=RLnfTNe/0l75108HjBt9P0bwFEIUDoEe6YgAPwr22IRzoXWpvqsExy5S6v1U9xFMm1pIYyplr0a8qhXWrGMqmemZMTteBatvgUl/nKlGMXaScr0dODA++u+Vl5rR23moEYwcY0rnDx913XQNgM1yAkSb2KM4RPP6jT3UnZrQQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959351; c=relaxed/simple;
	bh=1h1hYV15b/9OrZx9rgbJfHxJeDSJJGbmTMQBxgv3xnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY0zpttKK05C4Pi5KZHGrd9XaGRyA3Xgog1fQmyoGkBjuK0B8ue1klGHQBdOOGgcWv382yTTRGW+2CzNi2AtqZnR8i+zj1FsJ6wfeRKnLxIg9vDGbbPkKg6L+fb2e9O0209XRwmC7zaqP48DMooWpJvv+RD86YIf18otaKOdnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUKakwI1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7892609a5so502344f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959348; x=1754564148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuQIWstDhNu35nB45LKa/AekW382Kc6x1gcIP9pJGZE=;
        b=OUKakwI1sFhtQBIELJo0nU4Hk0Yf2WJnXrLnKKDuHRfYbz4zBjfOz0Jb9M24EcPwmv
         QPd8XNRZLYRdr8ySaxQ8xjb3ZJuTmRTH10H0duJzFniDZ7ck4fsRE3vjmMVd3cExVxEf
         tqZisa7cUxrtVXHkqShRMRxMClKJGfz89g2++X+EpAEjCyejmxAWCOCyZMWc/vRoxZM3
         SmPQUuFx++BTg9mGOu17j8i75ZIKq9FIguX8JQOkPM66emur1nE5TJeWruhQLBMEBNCu
         NocF/QsqXxdfiZeeYobh0PoVVz/RX8JuJWzSxqOqLG65nHAAbUm+NIfY8jjdo2QDHm+G
         YobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959348; x=1754564148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuQIWstDhNu35nB45LKa/AekW382Kc6x1gcIP9pJGZE=;
        b=F/EXAIwS7Miwt5nP0PeCN7RuPa30Y5Nt/lGKmoO6JlxQK8I91XJI4gxX/ok/b+ZJJY
         1uqR0Gn3mriOkLnPL04PQ9WiaMDDfkfv0r7LTfWyNl3svPGoPRcMXKo1bTkSo/+jXNg6
         SWG2BMf9XwCn6zQN6eEEMKCrtMzoILkGcqC9z5mm5m0kavaFzDYIu5GUO2BeT4a/hjp6
         7VzWBZlsexTmxFH6fk8GB89Y6gc6/p5nsF0qHoTiGbxjZV/xvCsKuy+4+khJg2T50CAz
         zrHyfwXGJLGEo27DpeEA1Kxcb8NeIsj7xsd3ZprhWZ+/1G81m+gtZW07tdB2CoaBdCMN
         59+g==
X-Gm-Message-State: AOJu0Yw18jWy9X3+pWwtUBYlbwJsHsSrr3tC3TXcBbWVxNJgGUfQT6dU
	WzE2/SYhiKXWAlzuQtftipqIIFcODNhnLaBbPdEfUuU/vyFl+t3Rl9bV
X-Gm-Gg: ASbGncsTQs3FfQ5jPLj9viNrucv9FgStzaubHhx6doleptqUi1/Z870D9vLybBhvXtz
	O6R32/CI+A/U5/PeSv022Tq7WYTVJwOiBY33cwDbva0/ogcyfhs+TKXP5lBnVTdaX91s/nKfV8P
	OQFXPSy3iJV6c+Bf8gjIJ1+aR8dpuyqFEL59lTZSCMmtXffV6nzNcYhhLsHp+itWtcpecXEh1dh
	PF1wf/b/r2qzhFi4t/ltdjI+yArVfkUq7Mb5P8XShGMWIq6JBwtdS45Giwn1jl2iJDwJPERv54i
	P/XKRlHq4J3MiKGZ41TzYIw9bsQ+zv/bkMKo4QmvSGfvF/RVikiszKt1XAnhQkWpIh0oLMSNCyJ
	ljnQOVttRGOl+qW/HslAhkk03JQQ0hg==
X-Google-Smtp-Source: AGHT+IGhoH+yhFWiOeEr25sQ0DFAA5hiD1OLZM9f1MXEwhtU5DDI6Ah6hI2Qk76ptoPCOmdznbwIZQ==
X-Received: by 2002:a05:6000:240b:b0:3b7:b3f2:f8c3 with SMTP id ffacd0b85a97d-3b7b3f2fd1fmr1227787f8f.57.1753959348495;
        Thu, 31 Jul 2025 03:55:48 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:48 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v2 05/25] sched/rt: Move some functions from rt.c to sched.h
Date: Thu, 31 Jul 2025 12:55:23 +0200
Message-ID: <20250731105543.40832-6-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Make the following functions be non-static and move them in sched.h, so that
they can be used also in other source files:
- rt_task_of()
- rq_of_rt_rq()
- rt_rq_of_se()
- rq_of_rt_se()

There are no functional changes. This is needed by future patches.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c    | 52 --------------------------------------------
 kernel/sched/sched.h | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 945e3d705cc..3ea92b08a0e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -168,34 +168,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 
 #define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
 
-static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
-{
-	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
-
-	return container_of(rt_se, struct task_struct, rt);
-}
-
-static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
-{
-	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-	return rt_rq->rq;
-}
-
-static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
-{
-	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
-	return rt_se->rt_rq;
-}
-
-static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
-{
-	struct rt_rq *rt_rq = rt_se->rt_rq;
-
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-	return rt_rq->rq;
-}
-
 void unregister_rt_sched_group(struct task_group *tg)
 {
 	if (!rt_group_sched_enabled())
@@ -296,30 +268,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 #define rt_entity_is_task(rt_se) (1)
 
-static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
-{
-	return container_of(rt_se, struct task_struct, rt);
-}
-
-static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
-{
-	return container_of(rt_rq, struct rq, rt);
-}
-
-static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
-{
-	struct task_struct *p = rt_task_of(rt_se);
-
-	return task_rq(p);
-}
-
-static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
-{
-	struct rq *rq = rq_of_rt_se(rt_se);
-
-	return &rq->rt;
-}
-
 void unregister_rt_sched_group(struct task_group *tg) { }
 
 void free_rt_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a8073d0824d..a1e6d2852ca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3042,6 +3042,57 @@ extern void set_rq_offline(struct rq *rq);
 
 extern bool sched_smp_initialized;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ON_ONCE(rt_se->my_q);
+#endif
+	return container_of(rt_se, struct task_struct, rt);
+}
+
+static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
+{
+	return rt_rq->rq;
+}
+
+static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
+{
+	return rt_se->rt_rq;
+}
+
+static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
+{
+	struct rt_rq *rt_rq = rt_se->rt_rq;
+
+	return rt_rq->rq;
+}
+#else
+static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
+{
+	return container_of(rt_se, struct task_struct, rt);
+}
+
+static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
+{
+	return container_of(rt_rq, struct rq, rt);
+}
+
+static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
+{
+	struct task_struct *p = rt_task_of(rt_se);
+
+	return task_rq(p);
+}
+
+static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
+{
+	struct rq *rq = rq_of_rt_se(rt_se);
+
+	return &rq->rt;
+}
+#endif
+
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
 		    double_rq_lock(_T->lock, _T->lock2),
 		    double_rq_unlock(_T->lock, _T->lock2))
-- 
2.50.1


