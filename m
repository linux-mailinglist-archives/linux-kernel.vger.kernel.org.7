Return-Path: <linux-kernel+bounces-899325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E95C576AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E5C3BB83A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036D3502A4;
	Thu, 13 Nov 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="atH/31oK"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547F34DCE0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036603; cv=none; b=Te5Ovz0HgtyaloSwhz4WUjqsR1eCygbIW0WKdEUydF1ztVGtq4ZLiwIoB6OurKLvGLYiYaBXUos455DCbgfKYlb5p5/9cTR0HRkqsKbSxQP7HRstugBpjW7VkwM7t+xkepmAb85nJL75tx11tMtvxJtLx+tY1EOoswbJgGJDFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036603; c=relaxed/simple;
	bh=kFIIvvybEz4k8OUWTJoB9Zel7jb//Xa1to2R3k8Phmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8p59Q6cZirWTaZ/lH+s8RzMYZ5ugNsFSrgnc8UKZcKm9vmp7e9t57eiHKs4x9M0bVjemUc+s/8lN6DpKSWxn6exV463ButEhWXy7P0GiEridVH7YilJDFI/cpn2vTf88rX+/5BLXMy+XcxCywsGjrUGArCmT3Sxl7j/8WImW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=atH/31oK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VIuRL0oXLtNaj3TeYp7lAh4FpV+kGIchTTBPXGDDMw8=; b=atH/31oKYyntT9hil9bMYl84iP
	Bnnv3PLJ5o5GC3EFdLDtp49YDeP7RFsG0LVExeTAB/r3LG+yzawJIzWUoPgtMaZ/sHvfgwbT6fc3l
	FnzX5kafu/sFZPyFV6tEtrLoF86I+xwltUwjP57Ciuvml8oMduOM6P3Jglc1SlnJwvVcZa/qa4vgs
	obfmxW/5bgtrQTFpwYczBOFt6jYo0Kv4fzo6zbzqrSKUftCJaK8czKfaxflhdUQT/FrCY+AprbrCH
	sXXK8MNRGRis9Zui2CndurPaw6HxSp1pzmQP192Ix7wwjCId/r2XYwkb7Jcwua/dykJpEp+D1D+c4
	bfcyX1LA==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vJWM8-0001Gg-51; Thu, 13 Nov 2025 13:23:15 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Ziljstra <peterz@infradead.org>
Subject: [PATCH] sched/psi: Streamline the flow in psi_group_change
Date: Thu, 13 Nov 2025 12:22:54 +0000
Message-ID: <20251113122254.40445-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that psi_group_change() can be called rather frequently from the
scheduler task switching code lets streamline it a bit to reduce the
number of loops and conditionals on the typical invocation.

First thing is that we replace the open coded mask walks with the standard
for_each_set_bit(). This makes the source code a bit more readable and
also enables usage of the efficient CPU specific zero bit skip
instructions.

In doing so we also remove the need to mask out the special TSK_ONCPU bit
from the set and clear masks, since for_each_set_bit() now directly limits
the array index to the safe range.

As the last remaining step we can now easily move the new state mask
computation to only run when required.

End result is hopefully more readable code and a very small but measurable
reduction in task switching CPU overhead.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/psi.c | 48 ++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..fe19aeef8dbd 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -798,39 +798,26 @@ static void psi_group_change(struct psi_group *group, int cpu,
 			     u64 now, bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
-	unsigned int t, m;
+	unsigned long t, m;
 	u32 state_mask;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
-	 * Start with TSK_ONCPU, which doesn't have a corresponding
-	 * task count - it's just a boolean flag directly encoded in
-	 * the state mask. Clear, set, or carry the current state if
-	 * no changes are requested.
+	 * TSK_ONCPU does not have a corresponding task count - it's just a
+	 * boolean flag directly encoded in the state mask. Clear, set, or carry
+	 * the current state if no changes are requested.
+	 *
+	 * The rest of the state mask is calculated based on the task counts.
+	 * Update those first, then construct the mask.
 	 */
-	if (unlikely(clear & TSK_ONCPU)) {
-		state_mask = 0;
-		clear &= ~TSK_ONCPU;
-	} else if (unlikely(set & TSK_ONCPU)) {
-		state_mask = PSI_ONCPU;
-		set &= ~TSK_ONCPU;
-	} else {
-		state_mask = groupc->state_mask & PSI_ONCPU;
-	}
-
-	/*
-	 * The rest of the state mask is calculated based on the task
-	 * counts. Update those first, then construct the mask.
-	 */
-	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
-		if (!(m & (1 << t)))
-			continue;
-		if (groupc->tasks[t]) {
+	m = clear;
+	for_each_set_bit(t, &m, ARRAY_SIZE(groupc->tasks)) {
+		if (likely(groupc->tasks[t])) {
 			groupc->tasks[t]--;
 		} else if (!psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%lu tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
 					groupc->tasks[3], clear, set);
@@ -838,9 +825,9 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		}
 	}
 
-	for (t = 0; set; set &= ~(1 << t), t++)
-		if (set & (1 << t))
-			groupc->tasks[t]++;
+	m = set;
+	for_each_set_bit(t, &m, ARRAY_SIZE(groupc->tasks))
+		groupc->tasks[t]++;
 
 	if (!group->enabled) {
 		/*
@@ -853,6 +840,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (unlikely(groupc->state_mask & (1 << PSI_NONIDLE)))
 			record_times(groupc, now);
 
+		if (unlikely(clear & TSK_ONCPU))
+			state_mask = 0;
+		else if (unlikely(set & TSK_ONCPU))
+			state_mask = PSI_ONCPU;
+		else
+			state_mask = groupc->state_mask & PSI_ONCPU;
+
 		groupc->state_mask = state_mask;
 
 		return;
-- 
2.51.1


