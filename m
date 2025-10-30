Return-Path: <linux-kernel+bounces-878983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80EC21E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03DF3BBA50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533328641D;
	Thu, 30 Oct 2025 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js5YTf7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34523D2B8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851977; cv=none; b=ZKOIsp0EXpTXqMfZcSlMb8ZfnG1hON4rY9TmoTv19PNy3bGVEqm8AhqjroFQLr37WFP49atgRz006n8MV4RjfDbUl8C5p/9//hCjijCb76qqZjVDsFG4km7ob4BS1t81FmzkR45V5qSBTnGSYlJlazU9YfkimaVVtWACwBu0NIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851977; c=relaxed/simple;
	bh=JHKd6DU/5hTgK1BijJfe4AHdDoi6TooK29l5u68ZFRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dFx0tKrsI/0Ju1vu1B+L+y0rbYuoWNO4hnlcA/ozUamzc3PqB31Ia78aD4I1sUNusUC5x28ijHL+U4tBmmnK8Jv0Mkw9gjmRC74NOd6H8xL+DJlUPkP3+I+toOLF6AL+FIe1vBclH0/6fqlbbmMYRogGhAMNPfKgVArq7eSY3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js5YTf7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54F3DC4CEF1;
	Thu, 30 Oct 2025 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851977;
	bh=JHKd6DU/5hTgK1BijJfe4AHdDoi6TooK29l5u68ZFRA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=js5YTf7QOGf9fzQOvxE93Vm2FgiUQgNMjffoXVT2rXhlbLoceKTryJSB2ZkmzOewu
	 ySthNw5CLxpW+C1tulNc+/415XAX2VmDiyY04paFH+xVf+Vi+SDbuyYd+kc5aP+uY7
	 JN5zLPH4ElZYuGmXX/qmyzgJ4Kn40mY0exIyCQ0trBtneBNqcBVPFewBPTrZR7a4Db
	 2Q91keZ2R25o8UvdYqRd07qYwfVAy4rJ0yM1gKijSLJbfvFFOzN/cYgYXZMNxkjpXT
	 y3bDF15gsKfrjAZj7cSULKL+HLt5xuc6PSxy4cd8MJuS4obpyUDZv0InnrSvw43X+d
	 WJHxZRrUP3gVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441ECCCF9E3;
	Thu, 30 Oct 2025 19:19:37 +0000 (UTC)
From: Shubhang Kaushik via B4 Relay <devnull+shubhang.os.amperecomputing.com@kernel.org>
Date: Thu, 30 Oct 2025 12:19:29 -0700
Subject: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
X-B4-Tracking: v=1; b=H4sIAEC6A2kC/02Myw6CMBBFf8V07ZDSQoyu/A/joo8pNAGmmRY0I
 fy71ZW5m3sW5+wiI0fM4nbaBeMWc6SlgjqfhBvNMiBEX1koqfpWagm2g0DTRC9YE4Qgte16rY3
 yoiqJMcT3L/d4Vg5MM5SR0fxF2ss3kt2IHlzIUB3jCjEkpmQGUxC2FurQSu96216tvlNuzJyQ0
 dGc1hKXoalPHMcHLdrE38IAAAA=
X-Change-ID: 20251030-b4-follow-up-ff03b4533a2d
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761851978; l=2430;
 i=shubhang@os.amperecomputing.com; s=20251010; h=from:subject:message-id;
 bh=q1httNTq42jPnpET+Sx8sWschV5NJ0NnZZCoUwuq6j4=;
 b=LVoAUrJlhLEI/Uwv5GFzSfwnnGQrFv7lbdagNGPHLpvykljZEFL7Rxiwv3UJIV49hTGokc4sh
 synCF+87bmECw/RLhxZGyqs3O3U+1YMQs38BlLtpLk0OcK+nJWnNvio
X-Developer-Key: i=shubhang@os.amperecomputing.com; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=
X-Endpoint-Received: by B4 Relay for
 shubhang@os.amperecomputing.com/20251010 with auth_id=539
X-Original-From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Reply-To: shubhang@os.amperecomputing.com

From: Shubhang Kaushik <shubhang@os.amperecomputing.com>

When Energy Aware Scheduling (EAS) is enabled, a task waking up on a
sibling CPU might migrate away from its previous CPU even if that CPU
is not overutilized. This sacrifices cache locality and introduces
unnecessary migration overhead.

This patch refines the wakeup heuristic in `select_idle_sibling()`. If
EAS is active and the task's previous CPU (`prev`) is not overutilized,
the scheduler will prioritize waking the task on `prev`, avoiding an
unneeded migration and preserving cache-hotness.

---
v2:
- Addressed reviewer comments to handle this special condition
  within the selection logic, prioritizing the
  previous CPU if not overutilized for EAS.
- Link to v1: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/

Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb27959bc130d288d5f80677f75f8db8b..ac94463627778f09522fb5420f67b903a694ad4d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7847,9 +7847,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
-	/*
-	 * If the previous CPU is cache affine and idle, don't be stupid:
-	 */
+	/* Reschedule on an idle, cache-sharing sibling to preserve affinity: */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
@@ -7861,6 +7859,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		prev_aff = prev;
 	}
 
+	/*
+	 * If the previous CPU is not overutilized, prefer it for cache locality.
+	 * This prevents migration away from a cache-hot CPU that can still
+	 * handle the task without causing an overload.
+	 */
+	if (sched_energy_enabled() && !cpu_overutilized(prev))
+		return prev;
+
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
 	 * kworker thread and the tasks previous CPUs are the same.

---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20251030-b4-follow-up-ff03b4533a2d

Best regards,
-- 
Shubhang Kaushik <shubhang@os.amperecomputing.com>



