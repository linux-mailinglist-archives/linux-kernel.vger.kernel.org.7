Return-Path: <linux-kernel+bounces-882813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF14C2B911
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67213349192
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8993081DF;
	Mon,  3 Nov 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ee4GPR1e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5dRqNeCo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B74306B3F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171438; cv=none; b=D22D7ECHoDOR+Bcf+QtlC8AFNOGreod5lI3Uudvej+wgL9pjCE5pypLBiz2dzgDi44KrgL9OzOjdwzjkpTLEoyji9rlJst765nfgTnUEuTetA+81hZuE1UVXHK3Ey+u4iPIGYcbnfFLK/aTxDpf+GlD9Xp2hQSdV57m2DbT+/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171438; c=relaxed/simple;
	bh=Fvns7so7WaV9EG4uo/yySBCYi2X5gGPaL9Yv9Xp0HYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZpEUnX5rYxuKu9c2k2kV0XAkD7TyW6e00csqkyJIhDMGMaaWiUzFhdmmAmSXYXoP+L0xfrnjACzgbsuYF2TdckfBzQQNdzw7zrNkk3XOMCFjev+7SrrzIoNLREUyRix/d4JrsHo8Hb7XJXepChEKSj1GodscBhkGyas90deoUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ee4GPR1e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5dRqNeCo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Nov 2025 13:03:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762171435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=oie4k6X9NIABUpdnzNHEa7Wun2ohz1f1YgQzeCxEKzQ=;
	b=Ee4GPR1eg8P9QuY0GK0Uwn8GG46ZkagGrFh+YcYT4vEOK2wvA2aBhCs/XCqCw3KB3vN66V
	XVs7uccOl7rwnT7flKV3WUJJ8jgWPrMuH7XNDOZ2KSF4c90bxvvUU7+NXLhc+LuOZTTbtG
	aE5R5LkuxiV2kqEWJ3kR71BjvnaF05oIwCRHjhF1yDL0x2qlsEKsWp2qLlPSjQ7A1NtnWQ
	RtG7Ro0Z5cmD4nYJmEVdO0xsyyRj/RFEQRaApVWazm6YpCgyLKRfaLamtsPiS0FI31R9/m
	3DrpiGAD12t8xRfslDymh9JEw4cFKL3olg4e4HFZoM24C5HdGt+lRA2YmnEhLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762171435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=oie4k6X9NIABUpdnzNHEa7Wun2ohz1f1YgQzeCxEKzQ=;
	b=5dRqNeCof/kV/8vRpo7B5wK8P4ri8VlIg7vlHI2mEly9a9qGb3VgR8mSsyckJFHUwXp3Te
	JJs/I4Zu/P1XDFBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] cpu: Make atomic callbacks run on UP with disabled interrupts
Message-ID: <20251103120354.HU-oB1_z@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On SMP callbacks in the "starting" range are invoked while the CPU is
brought up and interrupts are still disabled. Callbacks which are added
later ar invoked via the hotplug-thread on the target CPU and interrupts
are explicitly disabled.
In the UP case callbacks which are added later are invoked "directly"
without the thread. This is okay since there is just one CPU but with
enabled interrupts debug code, such as smp_processor_id(), will issue
warnings.

Disable interrupts before invoking the calback on UP if the state is
atomic and interrupts are expected to be disabled.
The "save" part is required because this is also invoked early in the
boot process while interrupts are disabled and must not be enabled.

Fixes: 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cpu.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28c..a6902646b4933 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -249,6 +249,14 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	return ret;
 }
 
+/*
+ * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
+ */
+static bool cpuhp_is_atomic_state(enum cpuhp_state state)
+{
+	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
+}
+
 #ifdef CONFIG_SMP
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
@@ -271,14 +279,6 @@ static inline void complete_ap_thread(struct cpuhp_cpu_state *st, bool bringup)
 	complete(done);
 }
 
-/*
- * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
- */
-static bool cpuhp_is_atomic_state(enum cpuhp_state state)
-{
-	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
-}
-
 /* Synchronization state management */
 enum cpuhp_sync_state {
 	SYNC_STATE_DEAD,
@@ -2364,7 +2364,15 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
 	else
 		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
 #else
-	ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	if (1) {
+		unsigned long flags = 0;
+
+		if (cpuhp_is_atomic_state(state))
+			local_irq_save(flags);
+		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+		if (cpuhp_is_atomic_state(state))
+			local_irq_restore(flags);
+	}
 #endif
 	BUG_ON(ret && !bringup);
 	return ret;
-- 
2.51.0


