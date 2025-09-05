Return-Path: <linux-kernel+bounces-802479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804FDB452B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAE7A63D18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C8301484;
	Fri,  5 Sep 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cX6F4rT3"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347202E719C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063382; cv=none; b=SYK50sg/0Wfi089cQFj4CHKoOvTgbgNhc4lKsM26sD4J/1ni+38RevDI6pV4F3Jt04qUda6FVgjY5FPFDXoCy1rRhMWN0bXeTnaWjVl7L8Cussjeadyz0XNK8rpwWWpyu3tqalGfurh+BNjrPIRx0nE3zKNru+f9IVBvm/d+HAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063382; c=relaxed/simple;
	bh=DioF6zeAQdwPmhHZnfpqDcSXd6PHWCc+GcYhh7ohPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WimAxQoo327FEW4dkXjoD5XeCOG9pFj4lRA0HVvZNP52zs7hgQx5XgJ7ZiHTzG7vJYVZvuyjw1nlelkwDppBrgHQoTCEeoNtF4AXVFq+V+2TAsoluiCDDW3XLwudzGBKC6Mkzyx3rLqkns3gtmYY0iyTUNorGiFfbmgxo8aIWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cX6F4rT3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1713127f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063378; x=1757668178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rghuaeHkigCik2a0HTKE1WtAe9TkwuDUsdmdBe6cdDs=;
        b=cX6F4rT347vr/MnVZ2RdJaKfMgal8DhhjtOVF8aw8gzo1j1vfTz1qjBn7b9tEqFKH9
         TKqnAfFfoPkEq0lN97M6Stsderu3nCR4LkzRabP5nbXnsPbaWFyYfZX9jzpwAbB45R4C
         EjzhA0w2Oeb35VVIFUsJmsx33yRpV9PsIKhcg0Wlbtc8g8au111Vj3NuVeJ4WGIIJ/WH
         kg4gePtJ7EKpAXAqL8Ce2XFkitZteMipeiplyeyr9ZWUzwJ5I/ZGxuuoQmPfJEcYIKxf
         Iywoj4ZfFdsYJHmywOgRN/GG5WKCOKy/3SpPH26/AOY/D2EMiGrhxyfntY4Si+r6qbIY
         iQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063378; x=1757668178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rghuaeHkigCik2a0HTKE1WtAe9TkwuDUsdmdBe6cdDs=;
        b=uP5oqh9wyjSyeTAky9ug1Y2v9IVCjOeXzDjru/OSuSlSYm+m/0yyqQYIVf32VpDPmn
         lkFJ51DUaZhYJwf3nnKTCs3z2MBMt1DgB5JhlDyYNELljCUWbBa+C7hb1cLE8MeTDq00
         71eg4K0i7SEL4f1LAs06qYc48dBg69/dFMKhgoXoDHWAHLdvoNKP8t6kHm7DrgAIUCn5
         gSIk+dWcrg/+IZUPMOoIJ84YGSV0cDr+CVPLxiqDKutjlyXfCBF0HcODpGyi6tc24Zav
         Em104F4PIocIVWPJdlrkd9jwuAed7o4XDEIi60C+XNotUSe4OBnPjVz01pE7siFysVwQ
         0Zjw==
X-Gm-Message-State: AOJu0YwEMbODkXghT3Laxbz2Iq17XFoqzvcl5I5KZ6fLeEmgXeNU0eqz
	Lw1A7TIzuxycQ+CwlQhCl1v64ZGV66METkG2eMsJ03zFOa13ruOK8sKTucKQKFiBekzP7NEBxuX
	7o7ywG4I=
X-Gm-Gg: ASbGnctE423W4N1C2vbm6AtAQ01FWRUzfyGTOryFqUi9i0Q7QA1mKFhfF0ZO7LAU6tg
	lzPNvU3kRJ0m9bqAkjWz0wzw+lPtfJH3BcJ41ec0drqwCnJ5S7fTMWGCIZguLZFD8piSuBiytni
	48qHj3oW4vkok2qYWqv2dPPo/Jf4m7upRjEjmxPNeqU9ZnVBqNprEG34Zll7mtZ49MZhd/rWmGl
	M4OofK8sTWOErF8AEf57dP5B/B57tB3HPSh/75+XsosD+szYoYMXQG8fUlYp0blr1QPHIQlCnXG
	opgybzO7q3srP3EtBO8XWQqiqFD59aw9KcXPwPcPYQUVxn10+mczRt4AtyTRKzpYgrJFFlW23Gv
	H/S/0tsUUoFgLD1gRJKi5ys7Ft5u9fqqEydlrVx3OJd0iZQYc1x7/BI5yNw==
X-Google-Smtp-Source: AGHT+IGnRV7EMZO9Qg2G26bOKXMfWgx4gddN0/Wr3Cy40juFlbvo0DwRVw7Voo3/zMKa4pX+dItYsQ==
X-Received: by 2002:a05:6000:1aca:b0:3e0:cea3:f61a with SMTP id ffacd0b85a97d-3e0cea3f852mr4596850f8f.56.1757063378280;
        Fri, 05 Sep 2025 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm120245205e9.0.2025.09.05.02.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:38 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/1] sched: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:09:28 +0200
Message-ID: <20250905090928.108703-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090928.108703-1-marco.crivellari@suse.com>
References: <20250905090928.108703-1-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/sched/core.c | 4 ++--
 kernel/sched/ext.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c81cf642dba0..baa096e543f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5772,7 +5772,7 @@ static void sched_tick_remote(struct work_struct *work)
 	os = atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNING);
 	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
 	if (os == TICK_SCHED_REMOTE_RUNNING)
-		queue_delayed_work(system_unbound_wq, dwork, HZ);
+		queue_delayed_work(system_dfl_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
@@ -5791,7 +5791,7 @@ static void sched_tick_start(int cpu)
 	if (os == TICK_SCHED_REMOTE_OFFLINE) {
 		twork->cpu = cpu;
 		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+		queue_delayed_work(system_dfl_wq, &twork->work, HZ);
 	}
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66bcd40a28ca..b1b79143e391 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3514,7 +3514,7 @@ static void scx_watchdog_workfn(struct work_struct *work)
 
 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+	queue_delayed_work(system_dfl_wq, to_delayed_work(work),
 			   scx_watchdog_timeout / 2);
 }
 
@@ -5403,7 +5403,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	WRITE_ONCE(scx_watchdog_timeout, timeout);
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
-	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
+	queue_delayed_work(system_dfl_wq, &scx_watchdog_work,
 			   scx_watchdog_timeout / 2);
 
 	/*
-- 
2.51.0


