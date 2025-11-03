Return-Path: <linux-kernel+bounces-882981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761DC2C1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5314EB53C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DA26E6F4;
	Mon,  3 Nov 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V0GNWNsz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqE0m0Wl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7922689C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176504; cv=none; b=S2xj8u7yo+QFcdIRgzHwQvlyU7G6Q6CD2Gsgw5PLk9rBSiN/FFCrzPMbxxPThdmRH6XiZE7eprC2b2vxYgSRY6EiU/NnM7THaOUAfYTf5mHO/ZlJMVX/RvDrsQpT3saTkpgz7CYFV12JGQb5Z7RdTskmwlPueP/FkmBHiLt2JX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176504; c=relaxed/simple;
	bh=yAENzopaWNXHMYHOBDUdbRfvnK9r1g9tZlOgg4EqmlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3FpD2AcwMVWL4QZQQ8tW+fYvnPY4Yowz8vkXlRTydtu8R7Js11Im0kEkkPJpVU+OmjO4p3VnE928mSANF+A73pS2QLPdmTzLqg+JHG4k+nacw8AmuV7ytRZnSp2MVbdLiU6m2Oz3acVFWZIeWR/FWj5hpzPdWU040TNE8IAq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V0GNWNsz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqE0m0Wl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Nov 2025 14:28:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762176501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nsewwGRfCF7rZUNal+n9HmccxNHWVyjH99sJShIJVA=;
	b=V0GNWNszvy39GOCY3KJMzWp9RUQNL7ifrgO5tEuVfGzM+OM58FmpAOhasgER618y6a9QJl
	FmLKcb4nB/GVUNK953QAbjmx6XRPf+PVsgbyZQcCqK8+UImpp2oCZfvYu2pjhOMfTnMMn8
	pYLmDxbqrao1JAadUPxaQQYin6nWZwT8CX0+9NduQ6XUrpffm+nIJVXCBpuWZtAucjXZ6u
	d7Z5VuWYvjvrRA+iPx7rEc0cTAgAwoqmJzEdORdoSyhRN8vT5FHt2T3F1FkKhqjckPp9ja
	O8JcYLQD3sbvZw2LDBKuhNaH1yDHdAcI+tzdg43m2pouyorWecsmowikzepzxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762176501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nsewwGRfCF7rZUNal+n9HmccxNHWVyjH99sJShIJVA=;
	b=OqE0m0WlA3YIZKoLaJDaguAaJrN5Swz+omV5Gn/uGJT0dveZ+vjPbfN0ASCjhhUfoSOmFu
	s1j+zDNweUbM0TAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] cpu: Make atomic callbacks run on UP with disabled
 interrupts
Message-ID: <20251103132820.0llS_QPg@linutronix.de>
References: <20251103120354.HU-oB1_z@linutronix.de>
 <20251103124254.GA3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251103124254.GA3245006@noisy.programming.kicks-ass.net>

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
boot process while interrupts are disabled and must not be enabled. The
warnings aligns the function with cpuhp_thread_fun().

Fixes: 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and sche=
duler_ipi()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
 - guard() syntax as suggested by PeterZ plus the warning from
   cpuhp_thread_fun(). This will lead to a warning + bug in the bringup
   case which also happens with the thread on SMP.

 kernel/cpu.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28c..8ab69a891d7ae 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -249,6 +249,14 @@ static int cpuhp_invoke_callback(unsigned int cpu, enu=
m cpuhp_state state,
 	return ret;
 }
=20
+/*
+ * The former STARTING/DYING states, ran with IRQs disabled and must not f=
ail.
+ */
+static bool cpuhp_is_atomic_state(enum cpuhp_state state)
+{
+	return CPUHP_AP_IDLE_DEAD <=3D state && state < CPUHP_AP_ONLINE;
+}
+
 #ifdef CONFIG_SMP
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
@@ -271,14 +279,6 @@ static inline void complete_ap_thread(struct cpuhp_cpu=
_state *st, bool bringup)
 	complete(done);
 }
=20
-/*
- * The former STARTING/DYING states, ran with IRQs disabled and must not f=
ail.
- */
-static bool cpuhp_is_atomic_state(enum cpuhp_state state)
-{
-	return CPUHP_AP_IDLE_DEAD <=3D state && state < CPUHP_AP_ONLINE;
-}
-
 /* Synchronization state management */
 enum cpuhp_sync_state {
 	SYNC_STATE_DEAD,
@@ -2364,7 +2364,16 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_stat=
e state, bool bringup,
 	else
 		ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
 #else
-	ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	if (cpuhp_is_atomic_state(state)) {
+		guard(irqsave)();
+		ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+		/*
+		 * STARTING/DYING must not fail!
+		 */
+		WARN_ON_ONCE(ret);
+	} else {
+		ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	}
 #endif
 	BUG_ON(ret && !bringup);
 	return ret;
--=20
2.51.0


