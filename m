Return-Path: <linux-kernel+bounces-858833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28BBEBF72
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605F31AE1114
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA0D2D8DA8;
	Fri, 17 Oct 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQHzYfiJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA954261595
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742067; cv=none; b=cNuu4oAFuWBpGCnn9/O5zKKDzWd2Ftl6COYfRbQpOkbKpKtuzOTnI/adnHFy0CsrP2wa97xWDRFC6as6P/s9vmM5mzAhkO46cDqd3nsRnDZ9IvNOs+7MOQrkHEFESMWaO3ZxlIuVncvMoL9vt8yIE34fuesiP8ib5xba2RJdCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742067; c=relaxed/simple;
	bh=CJgIG1DJKto+c+6fymYZ5shkBYm69Ia0DA4WAhMJWbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YgxcbOkvM6F4LASkoZqIi7E/Pzu9U6duRB2Z8mCn7a+BEFwVDrcW7mzT+hNtuW5q2xJaugDniSC8C8sKJwK0FI0m2sxO/Rt9khqTF19o9pFtYfd2KMSxYIYILzCM5WH383p+va1x3L6G+dsbRjvqOfKtIc49G+VljGUNtIxruo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQHzYfiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A266C4CEE7;
	Fri, 17 Oct 2025 23:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760742066;
	bh=CJgIG1DJKto+c+6fymYZ5shkBYm69Ia0DA4WAhMJWbg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iQHzYfiJDGgpBBx9kbHxiE5m+An96nvSFfCBFLlCBze2VnAkonRo7qoFzH3qS1VAh
	 E6Wz+d/+5M/hfzwqTszoCaNNIlasxTVP6rNYAjV/A/AUcisXrHzhs6/QaxlCmd/1OD
	 Gy1uNtcPo7styGw6TYe4i20E6DdQYlV17HBVXmXQNL/cShIJRNUa427SihvKcVuYQM
	 R/MyNRrlTV8aSTb2KuF/bke6VRx9KkiakDO8DzZjmc+O+pZFBZ5C9BhpCP+6BWI88f
	 IG6cO+a7ezBkiQd3jWX/qC2G1YBqQefHNA7pUqjlZUSKc6blJ8MXCtgFooBGsVw83L
	 bMA55KVewMpjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DACACCD184;
	Fri, 17 Oct 2025 23:01:06 +0000 (UTC)
From: Shubhang Kaushik via B4 Relay <devnull+shubhang.os.amperecomputing.com@kernel.org>
Date: Fri, 17 Oct 2025 16:00:44 -0700
Subject: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
X-B4-Tracking: v=1; b=H4sIAJvK8mgC/x2NQQqDQAwAvyI5N7C7rFT7ldJDGqPm4i6JFEH8e
 xePA8PMCS6m4vDqTjD5qWvZGsRHB7zStgjq1BhSSH0M8YnfjM6rTMizo8lMvBfDaqXSQrtg4kx
 DCuM4UIZWqc3R4z68P9f1ByI6ub1xAAAA
X-Change-ID: 20251017-b4-sched-cfs-refactor-propagate-2c4a820998a4
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Shubhang Kaushik <sh@gentwo.org>, 
 Shijie Huang <Shijie.Huang@amperecomputing.com>, 
 Frank Wang <zwang@amperecomputing.com>
Cc: Christopher Lameter <cl@gentwo.org>, 
 Adam Li <adam.li@amperecomputing.com>, linux-kernel@vger.kernel.org, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760742065; l=2401;
 i=shubhang@os.amperecomputing.com; s=20251010; h=from:subject:message-id;
 bh=mj055oq7WnkP9xwqfOm87rkrgswcSedbXUDF3DZAKlo=;
 b=bJTba887Ti8Qb2WO6yKDozWXzUjJtMwujM4S3dNIgzpHADDvqmk1ZZ9NbcIOjdy2fE3S0QR4p
 oq32R7Aq8eUAM/AMMH9D/h59bRGmdPKGSYXuBiAgSGVgsOrR014ZsyN
X-Developer-Key: i=shubhang@os.amperecomputing.com; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=
X-Endpoint-Received: by B4 Relay for
 shubhang@os.amperecomputing.com/20251010 with auth_id=539
X-Original-From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Reply-To: shubhang@os.amperecomputing.com

From: Shubhang Kaushik <shubhang@os.amperecomputing.com>

Modify the wakeup path in `select_task_rq_fair()` to prioritize cache
locality for waking tasks. The previous fast path always attempted to
find an idle sibling, even if the task's prev CPU was not truly busy.

The original problem was that under some circumstances, this could lead
to unnecessary task migrations away from a cache-hot core, even when
the task's prev CPU was a suitable candidate. The scheduler's internal
mechanism `cpu_overutilized()` provide an evaluation of CPU load.

To address this, the wakeup heuristic is updated to check the status of
the task's `prev_cpu` first:
- If the `prev_cpu` is  not overutilized (as determined by
  `cpu_overutilized()`, via PELT), the task is woken up on
  its previous CPU. This leverages cache locality and avoids
  a potentially unnecessary migration.
- If the `prev_cpu` is considered busy or overutilized, the scheduler
  falls back to the existing behavior of searching for an idle sibling.

Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
---
This patch optimizes the scheduler's wakeup path to prioritize cache 
locality by keeping a task on its previous CPU if it is not overutilized,
falling back to a sibling search only when necessary.
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce8a65d6bbe616953f530f7a02bb619537c..bb0d28d7d9872642cb5a4076caeb3ac9d8fe7bcd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8618,7 +8618,16 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+
+		/*
+		 * Avoid wakeup on an overutilized CPU.
+		 * If the previous CPU is not overloaded, retain the same for cache locality.
+		 * Otherwise, search for an idle sibling.
+		 */
+		if (!cpu_overutilized(prev_cpu))
+			new_cpu = prev_cpu;
+		else
+			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 	}
 	rcu_read_unlock();
 

---
base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
change-id: 20251017-b4-sched-cfs-refactor-propagate-2c4a820998a4

Best regards,
-- 
Shubhang Kaushik <shubhang@os.amperecomputing.com>



