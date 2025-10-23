Return-Path: <linux-kernel+bounces-866917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A69C01043
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCD73A997D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D3E310652;
	Thu, 23 Oct 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuc0QrOX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB13310655
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221552; cv=none; b=VgR0pPwZTpE7GuUk28ERWc4XyY7/XZ4H3qT8X0mkZ18d1DvEvNV+BSzExbJVRuEKnKLk+7nL8Fk+eOx+uTNIctPyVTh7jCfOFjJgUjTXUAaDzLMG0JUnxzlfp48y4JaUsym/g4V3wU4oQPGeDWFep58VLPl6B34gze6azDVWPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221552; c=relaxed/simple;
	bh=VsgPwyAXG6Di5cEPk1U6tOq1ZOt95HONOwup1nZXJKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1tjIedCkBziqH69EmwylMMSMVjtojiWfBQ1I7NQJhmxvq2S+5bgbWUMZU3fwtIVHv5tA81XfdkJGfT+wRiXExT2HAf17ibXlaO9MP2xCyW4zfcUiIQpZgfgDdksrChuyQwwQZn1I5a34xSGBoJls2NsYPk9YvUfoBN+tMVyRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuc0QrOX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29470bc80ceso7043705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761221549; x=1761826349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSApYq4579OVm8EORZPFOPfXzV3GkoocwYa2PV/qFaE=;
        b=Vuc0QrOXNE0uFW6BjZlZmwNYjCwyJTnOyTrhK6tslVeFsBIOQm8/yuhZo46kHqxN0K
         vODZoGGAkukjbsZSmhPKBmMAxHBxlwJkg42lbT61/iCVVlYk8Uyom85E0Y3XZ1DBxgm6
         2pNh2hGLYkg7C+S3rjUq3h61WB39zzEwlVUY0KJqfjtbjJ4b7DIO1PmlZ+X9mQjZbTeM
         oItvj7fUKoBMYtQQFk0MS6JN0sC7Q8wLMVdLh8BVG0U2seO06YbFdHAbNFZ4tMtOEGya
         2W5GL7fTunoqrNVxT2T9hH5ucaoRRtNK+Oghh02mqfzSDw+pdvBcNf11zwfR+DXPzv19
         mt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221549; x=1761826349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSApYq4579OVm8EORZPFOPfXzV3GkoocwYa2PV/qFaE=;
        b=i91jZ9fCQ24Cf1U/nPEXXi1Z+/yqfueP+XjVeupktCTqnf9o0ksZYmXNRlSM66wB3i
         X4KDKs43qx3kNEkyyW8xg+BHQcJTE15gSz1Qh0L+sw+7WZtC+6W6KHkGRkg3YiCnPAc/
         KvidqiY3ualLWQPyo/MffoCPjr7be8lhjyINighFNfWJvXrUboNkRQ+kHesh1au8aTsH
         V9aOpodfXurboNDUByIj08RqIHta69U7KvELnkBnbyOP57+NPkN3cPpzVd/IJqFOMq96
         oC+5CUbhGkibNMfo+I4la/vId/7A6q1eNl7ITBA8LGROjKuOM1eL6kzeaVbx+Iw/Ns/b
         gT+Q==
X-Gm-Message-State: AOJu0YxXOt7834pLIKybNupnZQy/XGR7UPXhuNm/Vp/Uxrm27RX9wYhx
	VYWzn9NtDZ3ilP0Jyd1hdwG+CC8qnPmOLTiPRTEdeqeOwWIJzdGRmR4D
X-Gm-Gg: ASbGncsfOw/Q1OToe6dXoWg5kpPfNqxrjaKYtijjXZKD6XzPuhSTHXmi1VkMHHfubu2
	niI8AYOP5HOX4uVvJz/juaIGxKXu3ApVVP8vCz1QNmjns//Hr/ApOCAICl7mvWBT9skHXEFJNND
	SQyZjH/jcbjA0aKkEus61YegiazhsICnzOkEWjD6QSZorZqC01SJULdqbQasM7eprT2eWN9Q96x
	H3//eIUh0j51OlPuVdY/U9qGC++dt6i7ec9kjdH0JXziDOdiCTEBDVtEbzzpPGJXdiNTC9160X5
	+ph62oo5HiAlzFPYcZrizT51kYqpmAoDc+OvHK/JcnFczwRiye3phsHhbNuFLAW72CT8wuAw66b
	f+WQkLDWarMG8ljDsECO+5KI9YvbJ9liQWRneeiKhfvR4GACGmRzo7UjbcakKcLdF5cekBg21X8
	HZvTS3Vrq6TLm5itPTgVu7HbzH7Ltql9xZFI0JGGyDs9cbbEg6IQ==
X-Google-Smtp-Source: AGHT+IHV8c9vHB40DAaa5KrAYIa0Dawxrouo3wUDXn4r5hA4gZgceyAjDRUQ9BxbOvrHjjaxP6w6Xw==
X-Received: by 2002:a17:903:910:b0:290:d8f0:60be with SMTP id d9443c01a7336-2937b0d23c6mr61484705ad.30.1761221548565;
        Thu, 23 Oct 2025 05:12:28 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1262b3sm21551335ad.96.2025.10.23.05.12.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Oct 2025 05:12:27 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>,
	Aaron Lu <ziqianlu@bytedance.com>
Subject: [PATCH] sched/fair: Fix non-empty throttled_limbo_list warning in tg_throttle_down()
Date: Thu, 23 Oct 2025 20:12:13 +0800
Message-Id: <20251023121213.38282-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Aaron Lu and I hit a non-empty throttled_limbo_list warning in
tg_throttle_down() during testing.

WARNING: kernel/sched/fair.c:5975 at tg_throttle_down+0x2bd/0x2f0, CPU#20: swapper/20/0
Call Trace:
 ? __pfx_tg_nop+0x10/0x10
 walk_tg_tree_from+0x39/0xd0
 ? __pfx_tg_throttle_down+0x10/0x10
 throttle_cfs_rq+0x176/0x1f0
 enqueue_task_fair+0x4f5/0xd30
 ? unthrottle_cfs_rq+0x2f7/0x3a0
 tg_unthrottle_up+0x10c/0x2f0
 ? __pfx_tg_unthrottle_up+0x10/0x10
 walk_tg_tree_from+0x66/0xd0
 ? __pfx_tg_nop+0x10/0x10
 unthrottle_cfs_rq+0x16b/0x3a0
 __cfsb_csd_unthrottle+0x1f0/0x250
 ? __pfx___cfsb_csd_unthrottle+0x10/0x10
 __flush_smp_call_function_queue+0x104/0x440
 ? tick_nohz_account_idle_time+0x4c/0x80
 flush_smp_call_function_queue+0x3b/0x80
 do_idle+0x14f/0x240
 cpu_startup_entry+0x30/0x40
 start_secondary+0x128/0x160
 common_startup_64+0x13e/0x141

cgroup hierarchy:

          root
        /      \
        A*     ...
     /  |  \   ...
        B* ...

Debugging shows the following:
A and B are configured with relatively small quota and large period.

At some point, cfs_rq_A is throttled. Due to the throttling of cfs_rq_A,
the tasks on cfs_rq_B are added to cfs_rq_B's throttled_limbo_list.

Resetting task_group B quota will set cfs_rq_B runtime_remaining to 0 in
tg_set_cfs_bandwidth().
Since task_group A is throttled, Therefore, task on cfs_rq_B cannot run,
and runtime_remaining stays 0. With task_group B has a small quota,
tasks on other CPUs in task_group B quickly consume all of
cfs_b_B->runtime, causing cfs_b_B->runtime to be 0.

When cfs_rq_A is unthrottled later, tg_unthrottle_up(cfs_rq_B) will
re-queues task. However, because cfs_rq_B->runtime_remaining still 0,
and it cannot obtain runtime from cfs_b_B->runtime either. Therefore,
the task will be throttled in
enqueue_task_fair()->enqueue_entity()->check_enqueue_throttle(),
triggering a non-empty throttled_limbo_list warning in tg_throttle_down().

Root Cause:
In unthrottle_cfs_rq(), we only checked cfs_rq_A->runtime_remaining, but
enqueue_task_fair() requires that the runtime_remaining of each cfs_rq
level be greater than 0.

Solution:
One way to fix this warning is to add a runtime_remaining check for
each cfs_rq level of the task in unthrottle_cfs_rq(), but this makes code
strange and complicated.
Another straightforward and simple solution is to add a new enqueue flag
to ensure that enqueue in tg_unthrottle_up() will not immediately trigger
throttling. This may enqueue sched_entity with no remaining runtime, which
is not a big deal because the current kernel also has such situations [1].

We still retain the runtime_remaining check in unthrottle_cfs_rq() for
higher-level cfs_rq to avoid enqueuing many entities with
runtime_remaining < 0.

Also remove the redundant assignment to se in tg_throttle_down().

[1]: https://lore.kernel.org/all/20251015084045.GB35@bytedance

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Reported-by: Aaron Lu <ziqianlu@bytedance.com>
Closes: https://lore.kernel.org/all/20251016065438.GA32@bytedance
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
Reproduction steps:
(1) Create a test.sh script and run it:
#!/bin/bash
set -e
CGP_ROOT="/sys/fs/cgroup/"
if ! mount | grep -q "type cgroup2"; then
	echo "ERROR: Not in cgroup v2 mode."
	exit 1
fi
echo 1 > /sys/kernel/debug/clear_warn_once
mkdir -p ${CGP_ROOT}/test
echo "+cpu +cpuset" > ${CGP_ROOT}/test/cgroup.subtree_control
for i in $(seq 1 2); do
	SUB_DIR=${CGP_ROOT}/test/sub$i
	mkdir -p ${SUB_DIR}
	echo $$ > ${SUB_DIR}/cgroup.procs
	perf bench sched messaging -g 10 -t -l 50000 &
	echo $$ > /sys/fs/cgroup/cgroup.procs
	echo "1000 100000" > ${SUB_DIR}/cpu.max
	echo "Started stress in stress_sub$i"
done
echo "1000 100000" > ${CGP_ROOT}/test/cpu.max

(2) Run the following command multiple times until the warning is triggered:
echo 1000 10000 > /sys/fs/cgroup/test/sub1/cpu.max

 kernel/sched/fair.c  | 15 ++++++++++-----
 kernel/sched/sched.h |  3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b58e696d7ccc..7721466dc8f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5287,7 +5287,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_queued == 1) {
-		check_enqueue_throttle(cfs_rq);
+		if (!(flags & ENQUEUE_THROTTLE))
+			check_enqueue_throttle(cfs_rq);
+
 		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
 		if (cfs_rq->pelt_clock_throttled) {
@@ -5912,7 +5914,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
 		list_del_init(&p->throttle_node);
 		p->throttled = false;
-		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP | ENQUEUE_THROTTLE);
 	}
 
 	/* Add cfs_rq with load or one or more already running entities to the list */
@@ -6029,15 +6031,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * unthrottled us with a positive runtime_remaining but other still
 	 * running entities consumed those runtime before we reached here.
 	 *
-	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
+	 * We can't unthrottle this cfs_rq without any runtime remaining
 	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
 	 * throttle, which is not supposed to happen on unthrottle path.
+	 *
+	 * Although the ENQUEUE_THROTTLE flag ensures that enqueues in
+	 * tg_unthrottle_up() do not trigger a throttle, we still retain the check
+	 * for cfs_rq->runtime_remaining. This prevents the enqueueing of many
+	 * entities whose runtime_remaining is less than 0.
 	 */
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled = 0;
 
 	update_rq_clock(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7718f12bc55..6f45e00d1fc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2368,6 +2368,8 @@ extern const u32		sched_prio_to_wmult[40];
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
  * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
+ * ENQUEUE_THROTTLE  - Called in tg_unthrottle_up() to ensure that
+ *                     task can be enqueued during unthrottle
  *
  * XXX SAVE/RESTORE in combination with CLASS doesn't really make sense, but
  * SCHED_DEADLINE seems to rely on this for now.
@@ -2399,6 +2401,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_MIGRATED	0x00040000
 #define ENQUEUE_INITIAL		0x00080000
 #define ENQUEUE_RQ_SELECTED	0x00100000
+#define ENQUEUE_THROTTLE	0x00200000
 
 #define RETRY_TASK		((void *)-1UL)
 
-- 
2.34.1


