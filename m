Return-Path: <linux-kernel+bounces-889887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D717C3EC32
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB90C188D2C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D32C325F;
	Fri,  7 Nov 2025 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GReEUAi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A17757EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500756; cv=none; b=IPwEPHui4Ie4NHjePlQgetBo8FPaQGoouYxfYG78MC1KWFfgKek/RjwWmk1qQV66e1VxH/A0E9EMXOV/cGTjE8uHjKEQyGCXniqq5iYXkizLR9BmvMtss4WebFEnqchKVHo/rk65+ZTsEV2ko8WchJ8uHtSZ9aTTkEmFV83dKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500756; c=relaxed/simple;
	bh=mDfbrHz9kw8ifW33hcdV9ABO8aMA+nwDDmDrwz/YQns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=euh5IQ+0fsdYHXRCAHzkPT4JOJAjPpG4EGiILiZSob0Fh6VOhLTRhIRIFFYE15UKW+Dedi6UXPtw/LuGQxPvpRC7tKEWIiZ6epUksVwxQ49dqjB4ka7sf+9DqAEpUzPmv0GpJtv9zx5bEQ5QFPdtRD6WmTVZ2Eg6XPJiVY3VPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GReEUAi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F8C4C113D0;
	Fri,  7 Nov 2025 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762500756;
	bh=mDfbrHz9kw8ifW33hcdV9ABO8aMA+nwDDmDrwz/YQns=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GReEUAi6l0mLNeFXwIAtQ+qBRuAiFiIcprY9uOq3Zqa4/dCXqUeWVqGZqI7n4aHBA
	 Z7IJHzkkSC2m6jRd9hi9JPQymm3Ln24E2s4Gu8PZfFttvRB4n6qoAEj1jwl2FYBJS6
	 kFxfcKRfjpMSig6j1cVqah3RnPIGKKPHMT9t7Wre+Fx/FiJ6STrfUgDiXCyB+fUd3O
	 MPdr8oHo9+eLalJwgCWHePzAoOycPmQxmvXo2lSNBqMhgQjOgw1Du6U7dM+4IYSk1A
	 RY4Qp0t7c7E7wm1tzevsK8f+xB/WcsuDn/QpFeD+F97WbzOC88mLkvmvb8hv94n9Wx
	 HvEe1kq596kkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3063ACCF9F8;
	Fri,  7 Nov 2025 07:32:36 +0000 (UTC)
From: Shubhang Kaushik via B4 Relay <devnull+shubhang.os.amperecomputing.com@kernel.org>
Date: Thu, 06 Nov 2025 23:32:02 -0800
Subject: [PATCH RESEND] sched/fair: Add helper to handle leaf cfs_rq
 addition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-20251010_shubhang_os_amperecomputing_com-v1-1-7535957d8ac6@os.amperecomputing.com>
X-B4-Tracking: v=1; b=H4sIAHGgDWkC/x2NwQqDMBBEf0X2bGA30CL9FZGgyVr3oAlZLQXx3
 7v19t4wzJygXIUVXs0JlT+ikjcTahuIy7i92UkyB4/+QYRPdwMSBl2O6d8IWcO4Fq4c81qOXSw
 ycp66lOIU584j2FypPMv3vuqH6/oBb0UK2HoAAAA=
X-Change-ID: 20251106-20251010_shubhang_os_amperecomputing_com-218ddcbcf820
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Aaron Lu <ziqianlu@bytedance.com>, Josh Don <joshdon@google.com>, 
 Ben Segall <bsegall@google.com>, Shubhang Kaushik <sh@gentwo.org>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762500755; l=2695;
 i=shubhang@os.amperecomputing.com; s=20251010; h=from:subject:message-id;
 bh=aKWrfbrWZwZxexxzXXzIOYzVUS/84glWsxcQQQBhEVQ=;
 b=f7GhnM6dkbGAobj4iPP8Pbqq/tKTG2Le/PfAq2IgU5t8nEwTUwhBeTUpu6ZGpqlZTCQbOy8L8
 1G8L4yN8GFTByz2LYufKFG+++ycr/G9YbuZQ36Oq+yhmsRPMrWZyRTp
X-Developer-Key: i=shubhang@os.amperecomputing.com; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=
X-Endpoint-Received: by B4 Relay for
 shubhang@os.amperecomputing.com/20251010 with auth_id=539
X-Original-From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Reply-To: shubhang@os.amperecomputing.com

From: Shubhang Kaushik <shubhang@os.amperecomputing.com>

Refactor the logic for adding a cfs_rq to the leaf list into a helper
function.

The existing code repeated the logic to check if the cfs_rq was
throttled and added it to the leaf list. This change extracts that
logic into the static inline helper `__cfs_rq_maybe_add_leaf()`, which
is a more robust naming convention for an internal helper.

This refactoring removes code duplication and makes the parent function,
`propagate_entity_cfs_rq()`, cleaner and easier to read.

Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
---
 kernel/sched/fair.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb27959bc130d288d5f80677f75f8db8b..13140fab37ce7870f8079e789ff24c409747e27d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13169,6 +13169,18 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+/*
+ * If a task gets attached to this cfs_rq and, before being queued,
+ * it gets migrated to another CPU (e.g., due to reasons like affinity change),
+ * this cfs_rq must remain on leaf cfs_rq list. This allows the
+ * removed load to decay properly; otherwise, it can cause a fairness problem.
+ */
+static inline void __cfs_rq_maybe_add_leaf(struct cfs_rq *cfs_rq)
+{
+	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
+}
+
 /*
  * Propagate the changes of the sched_entity across the tg tree to make it
  * visible to the root
@@ -13177,14 +13189,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	/*
-	 * If a task gets attached to this cfs_rq and before being queued,
-	 * it gets migrated to another CPU due to reasons like affinity
-	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
-	 * that removed load decayed or it can cause faireness problem.
-	 */
-	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
-		list_add_leaf_cfs_rq(cfs_rq);
+	__cfs_rq_maybe_add_leaf(cfs_rq);
 
 	/* Start to propagate at parent */
 	se = se->parent;
@@ -13194,8 +13199,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+		__cfs_rq_maybe_add_leaf(cfs_rq);
 	}
 
 	assert_list_leaf_cfs_rq(rq_of(cfs_rq));

---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251106-20251010_shubhang_os_amperecomputing_com-218ddcbcf820

Best regards,
-- 
Shubhang Kaushik <shubhang@os.amperecomputing.com>



