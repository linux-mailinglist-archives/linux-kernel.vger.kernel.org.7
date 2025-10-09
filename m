Return-Path: <linux-kernel+bounces-846432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C06BC7FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF33A411C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62A2737F3;
	Thu,  9 Oct 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeZlwAs6"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8E23ABA1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997904; cv=none; b=NFqX7k57ew+WWYWd72DYVhNkeVMOnFvpUmGPkAr3pD8fwtz1vd32r34B+wSiciq3agq2IYsqZidSlBeqa55XGHGcN5RUUM7EyaEK286VSNRoBrGCc7u79o31TDpwuy2WaHJn5ngs4ANhxLa6oxFaffQH3LzbXSwVi6YXeN1QoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997904; c=relaxed/simple;
	bh=L9dIeNbCahSakeFwMSeRcRByn6sqhkANg7n19U/U8W8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5QQt+bANiHUrXj577/dx8Heam4WB3UnjmgUT4ar/Tue/XlXmerr7EvvOBcJuT+yWUmkbWoKpER2nXJguwAmETcH97rEXBMee4LVaxpvZj/3tps4vcsJrDqgPlyk/y0kZ3AIz3Bgz9CljksDs+X4fmqRvmAhzVw7zMmKKYZ8fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeZlwAs6; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b57bffc0248so596607a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759997902; x=1760602702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6LEjjKyYJkXzaHDnzaE7FNjcxkXg3cO2ohxm9+muGI=;
        b=TeZlwAs6NVGnJ2o+AXqjGCofdz0T7Mfl4+jMopyReGbUr+/wzPwn9FH/pkBSWo8Ebx
         8pLrOir4VNlcSWuIPVBQ87DN/CkE5pfkLxpf8Y8Qi9Zyz/gHuTvVosyOthzdqbSQ8CYi
         Ev6XTr+QyPsfu6jMvDX8o52tUBRe7bgm4V8OvPYmnUkG2EcrjCSCUCs/thgtUVwf1wlf
         0p5rsjuVBfkYIiBKbQ2VJsKTo2oLxoYsf4MXsdcGOVKET4MDp9Urj2v7dx86t4t1Gcu/
         HUlzcJ9HACHKSah8Kls6T7uG2f6toNUzm3XuPqP4mfwDA5jg3hQR/Zb+52X+utPgZS86
         HVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759997902; x=1760602702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6LEjjKyYJkXzaHDnzaE7FNjcxkXg3cO2ohxm9+muGI=;
        b=WuYr5sHflDLZrTbPbTw+y3rV0ZwKcR6j4oPunrTAAbIj0Yzp0ogYr89842cmQDeIEq
         WFIw0fH3rbbQlbrK7VegoNSYpVxNDHegppELLFrkwwrerP/awVE9//cpd1Iv26JMWic2
         rRmgWwfGri6XdnqBb58fX7zKez5RiaVoWutVEAlCin6BTwAjjsOnmdhRE3ilY19rFsnz
         PTqNzT7esI8eSbGSDB0jSANoVdBGbswuzThaywxe550y59Jl0hxn0y9khS08Fs1xcr28
         Nv9nvQmMzwF9LL6QTuav99fkOJF5EuXGiU0Tg8Tgzuv9OjupcXBQc2kWpSxxLvnoTzDn
         GsZA==
X-Forwarded-Encrypted: i=1; AJvYcCXuKWvvaT5ydEO/C3vf+E0eX9MU0R9gLoMoz9caDHkAvyEoUlj+/Qhj/hjgo9GxPAOCOtd6dbAE4wxLx4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohV1W0BxkTYZb6adnm+DgItAqQRyEaskDUd2i+IsjWe353h74
	7KzlV2+8f1byqBVq419A/7DZIZzQzbSzRAPOrOnXahXQsKw1NgV10pjZ
X-Gm-Gg: ASbGncuNpSuzo+kQw7Y6BDRGKb6yabErlot/xYIIfELf/8kNjle7kYS+vQGiL4VqXOC
	kTLOEIkJuS/omZhjPCTXhpRCMKC+d/58VAYxbKtkKT/XIoPjkkP5s6D/Rpc9c4yaEPxwLLhkFOW
	eGoyg/11fjwJMZ0RzDYjhrQ0/fXjHKiurIZc/9mWvRe6e08UPiFNJBpBvV0nT0bdPho+SON4KRH
	UJbfZrf9RZszLjcD7LHqLV2IfjA72lgk4DK5GzDuBrfbGO6d3dV0lPpHAUwnINjwFbexpZpnPMi
	rXQ2i0tIkiTYDrVYVBg+APZPKsJI/58cUXVcSa295h901kD6ub6vcRu5OjVgR370HiMawBpwS/K
	itPSzmkPbPdWu0lkc1jXtYx3e66/qfLxmYdQg+CEDuQCV8vzkxDLkxYIZmiKu6WqqUB8AsBIPr1
	Y=
X-Google-Smtp-Source: AGHT+IHQVtJLidLyxASN61Xm6FMg/+bIJdJ46eKeS4qEorItMUVCieMcTEZhJVESiNvae2D+WE/W2Q==
X-Received: by 2002:a17:903:298e:b0:28e:b14e:d45 with SMTP id d9443c01a7336-28ec9cd7160mr144560945ad.30.1759997902017;
        Thu, 09 Oct 2025 01:18:22 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f95ecbsm19767995ad.130.2025.10.09.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:18:21 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: vineethr@linux.ibm.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	jianyungao89@gmail.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH v4] sched: Fix some spelling mistakes in the scheduler module
Date: Thu,  9 Oct 2025 16:18:13 +0800
Message-Id: <20251009081813.157037-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "jianyun.gao" <jianyungao89@gmail.com>

The following are some spelling mistakes existing in the scheduler
module. Just fix it!

  slection -> selection
  achitectures -> architectures
  excempt -> exempt
  incorectly -> incorrectly
  litle -> little
  faireness -> fairness
  condtion -> condition
  re-insterted -> re-inserted

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v4:
Change "excempt" to "exempt" and correct "re-insterted" to
"re-inserted".

The previous version is here:

https://lore.kernel.org/lkml/20251009024657.151767-1-jianyungao89@gmail.com/

 kernel/sched/core.c     | 2 +-
 kernel/sched/cputime.c  | 2 +-
 kernel/sched/fair.c     | 8 ++++----
 kernel/sched/wait_bit.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f1e5cb94c53..af5076e40567 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_mode)
 		/*
 		 * We pass task_is_blocked() as the should_block arg
 		 * in order to keep mutex-blocked tasks on the runqueue
-		 * for slection with proxy-exec (without proxy-exec
+		 * for selection with proxy-exec (without proxy-exec
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..2429be5a5e40 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
 	/*
 	 * Because mul_u64_u64_div_u64() can approximate on some
-	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+	 * architectures; enforce the constraint that: a*b/(b+c) <= a.
 	 */
 	if (unlikely(stime > rtime))
 		stime = rtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18a30ae35441..21ab67fd7d76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		bool delay = sleep;
 		/*
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
-		 * states must not suffer spurious wakeups, excempt them.
+		 * states must not suffer spurious wakeups, exempt them.
 		 */
 		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay = false;
@@ -5842,7 +5842,7 @@ static bool enqueue_throttled_task(struct task_struct *p)
 	 * target cfs_rq's limbo list.
 	 *
 	 * Do not do that when @p is current because the following race can
-	 * cause @p's group_node to be incorectly re-insterted in its rq's
+	 * cause @p's group_node to be incorrectly re-inserted in its rq's
 	 * cfs_tasks list, despite being throttled:
 	 *
 	 *     cpuX                       cpuY
@@ -12161,7 +12161,7 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 		 * sched_balance_newidle() bumps the cost whenever newidle
 		 * balance fails, and we don't want things to grow out of
 		 * control.  Use the sysctl_sched_migration_cost as the upper
-		 * limit, plus a litle extra to avoid off by ones.
+		 * limit, plus a little extra to avoid off by ones.
 		 */
 		sd->max_newidle_lb_cost =
 			min(cost, sysctl_sched_migration_cost + 200);
@@ -13176,7 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	 * If a task gets attached to this cfs_rq and before being queued,
 	 * it gets migrated to another CPU due to reasons like affinity
 	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
-	 * that removed load decayed or it can cause faireness problem.
+	 * that removed load decayed or it can cause fairness problem.
 	 */
 	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 1088d3b7012c..47ab3bcd2ebc 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(init_wait_var_entry);
  * given variable to change.  wait_var_event() can be waiting for an
  * arbitrary condition to be true and associates that condition with an
  * address.  Calling wake_up_var() suggests that the condition has been
- * made true, but does not strictly require the condtion to use the
+ * made true, but does not strictly require the condition to use the
  * address given.
  *
  * The wake-up is sent to tasks in a waitqueue selected by hash from a
-- 
2.34.1


