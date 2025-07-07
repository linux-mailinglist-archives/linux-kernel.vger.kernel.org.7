Return-Path: <linux-kernel+bounces-719914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DEAFB482
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECDC3AA7FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085A2980B4;
	Mon,  7 Jul 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gzlsbwFh"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53401E22FC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894823; cv=none; b=PbLWiOhaNExHyXOVp/BYLZ5xWRl+TIn3vOf+/TeLFPF3pHQhNYy9vsDihhK1AUrV1keRnDAJC3jIca8LDyzHLjN1CpTLGvZI6BJgbVINVgy3rb3WzC9bPVogk+ZAvI4qKTzRHdXqGh9zoPEG7FBCRUMEhHeZJ/UkdTfiViuD82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894823; c=relaxed/simple;
	bh=3ietx0ofqi6mn1rjSW7Z6012jGl4TXWv2+pakZQ6JGs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=u9stvpOrHpg6brMCgmdi+PWqEmgzDZgdVv6kRCctHy0FPMhCnKqp9CrvxlSLKrjS1wYGiedxKFrjTGN45m1TnVky3Fba18m0f+K5gIiJT+8gZE6u9GIWBRsWU1JTeqvz6Cu2iamKBeHHptc1ftgWkI3+QrFwxj3nnLO9HxCLcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gzlsbwFh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751894819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+sLFlb61uxhm84r2R5IWZpx5sgQHLlxHf5gjLWdiro=;
	b=gzlsbwFhc8xYSQzw4WtIhG0I68RN6NgMJv+398SBvQJMJtZPaCS/qHJA6wPWCUeSq4zMy4
	hn4pGPWliTtg5Qvpgmvmn1jqKWztAsTdileWZx56WYFXhbuPB6ud9CmP7Z4NfrEa7mbsfV
	tLJ1zb4xj4U0IBTnH9Sw3oq1ptrwuiQ=
Date: Mon, 07 Jul 2025 13:26:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: qiang.zhang@linux.dev
Message-ID: <527a257218a02fe85571746d339a4c24f5564d68@linux.dev>
TLS-Required: No
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
To: "Joel Fernandes" <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Josh Triplett" <josh@joshtriplett.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>
Cc: rcu@vger.kernel.org
In-Reply-To: <20250705203918.4149863-1-joelagnelf@nvidia.com>
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>=20
>=20---
>=20
>=20 kernel/rcu/tree.h | 11 ++++++++++-
>=20
>=20 kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>=20
>=20 2 files changed, 32 insertions(+), 8 deletions(-)
>=20
>=20diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>=20
>=20index 3830c19cf2f6..f8f612269e6e 100644
>=20
>=20--- a/kernel/rcu/tree.h
>=20
>=20+++ b/kernel/rcu/tree.h
>=20
>=20@@ -174,6 +174,15 @@ struct rcu_snap_record {
>=20
>=20 unsigned long jiffies; /* Track jiffies value */
>=20
>=20 };
>=20
>=20=20
>=20
> +/*
>=20
>=20+ * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's a=
ttention.
>=20
>=20+ * It can be in one of the following states:
>=20
>=20+ * - DEFER_QS_IDLE: An IRQ work was never scheduled.
>=20
>=20+ * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
>=20
>=20+ */
>=20
>=20+#define DEFER_QS_IDLE 0
>=20
>=20+#define DEFER_QS_PENDING 1
>=20
>=20+
>=20
>=20 /* Per-CPU data for read-copy update. */
>=20
>=20 struct rcu_data {
>=20
>=20 /* 1) quiescent-state and grace-period handling : */
>=20
>=20@@ -192,7 +201,7 @@ struct rcu_data {
>=20
>=20 /* during and after the last grace */
>=20
>=20 /* period it is aware of. */
>=20
>=20 struct irq_work defer_qs_iw; /* Obtain later scheduler attention. */
>=20
>=20- bool defer_qs_iw_pending; /* Scheduler attention pending? */
>=20
>=20+ int defer_qs_iw_pending; /* Scheduler attention pending? */
>=20
>=20 struct work_struct strict_work; /* Schedule readers for strict GPs. =
*/
>=20
>=20=20
>=20
>  /* 2) batch handling */
>=20
>=20diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>=20
>=20index dd1c156c1759..baf57745b42f 100644
>=20
>=20--- a/kernel/rcu/tree_plugin.h
>=20
>=20+++ b/kernel/rcu/tree_plugin.h
>=20
>=20@@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_=
struct *t, unsigned long flags)
>=20
>=20 struct rcu_node *rnp;
>=20
>=20 union rcu_special special;
>=20
>=20=20
>=20
> + rdp =3D this_cpu_ptr(&rcu_data);
>=20
>=20+ if (rdp->defer_qs_iw_pending =3D=3D DEFER_QS_PENDING)
>=20
>=20+ rdp->defer_qs_iw_pending =3D DEFER_QS_IDLE;
>=20
>=20+
>=20
>=20 /*
>=20
>=20 * If RCU core is waiting for this CPU to exit its critical section,
>=20
>=20 * report the fact that it has exited. Because irqs are disabled,
>=20
>=20 * t->rcu_read_unlock_special cannot change.
>=20
>=20 */
>=20
>=20 special =3D t->rcu_read_unlock_special;
>=20
>=20- rdp =3D this_cpu_ptr(&rcu_data);
>=20
>=20 if (!special.s && !rdp->cpu_no_qs.b.exp) {
>=20
>=20 local_irq_restore(flags);
>=20
>=20 return;
>=20
>=20@@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct tas=
k_struct *t)
>=20
>=20 */
>=20
>=20 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>=20
>=20 {
>=20
>=20- unsigned long flags;
>=20
>=20- struct rcu_data *rdp;
>=20
>=20+ volatile unsigned long flags;
>=20
>=20+ struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
>=20
>=20=20
>=20
> - rdp =3D container_of(iwp, struct rcu_data, defer_qs_iw);
>=20
>=20 local_irq_save(flags);
>=20
>=20- rdp->defer_qs_iw_pending =3D false;
>=20
>=20+
>=20
>=20+ /*
>=20
>=20+ * Requeue the IRQ work on next unlock in following situation:
>=20
>=20+ * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
>=20
>=20+ * 2. CPU enters new rcu_read_lock()
>=20
>=20+ * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() =
> 0
>=20
>=20+ * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
>=20
>=20+ * 5. Deferred QS reporting does not happen.
>=20
>=20+ */
>=20
>=20+ if (rcu_preempt_depth() > 0) {


For Preempt-RT kernels, the rcu_preempt_deferred_qs_handler() be invoked
in per-cpu irq_work kthreads, the return value of rcu_preempt_depth()
may always be 0, should we use IRQ_WORK_INIT_HARD() to initialize defer_q=
s_iw?

Thanks
Zqiang



>=20
>=20+ WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
>=20
>=20+ local_irq_restore(flags);
>=20
>=20+ return;
>=20
>=20+ }
>=20
>=20 local_irq_restore(flags);
>=20
>=20 }
>=20
>=20=20
>=20
> @@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_str=
uct *t)
>=20
>=20 set_tsk_need_resched(current);
>=20
>=20 set_preempt_need_resched();
>=20
>=20 if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
>=20
>=20- expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>=20
>=20+ expboost && rdp->defer_qs_iw_pending !=3D DEFER_QS_PENDING && cpu_o=
nline(rdp->cpu)) {
>=20
>=20 // Get scheduler to re-evaluate and call hooks.
>=20
>=20 // If !IRQ_WORK, FQS scan will eventually IPI.
>=20
>=20 if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
>=20
>=20@@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_s=
truct *t)
>=20
>=20 else
>=20
>=20 init_irq_work(&rdp->defer_qs_iw,
>=20
>=20 rcu_preempt_deferred_qs_handler);
>=20
>=20- rdp->defer_qs_iw_pending =3D true;
>=20
>=20+ rdp->defer_qs_iw_pending =3D DEFER_QS_PENDING;
>=20
>=20 irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>=20
>=20 }
>=20
>=20 }
>=20
>=20--=20
>=20
> 2.43.0
>

