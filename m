Return-Path: <linux-kernel+bounces-837953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4CBAE1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA432816B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163430DEDE;
	Tue, 30 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8GN/QFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29930C0E3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=rJUW3+ZY70cr1VqqMMudlNtEpO0IgYhd5mBwBiC4w3GPufFJc/JSXzXzau58r1sOIUJob0r9Forbs9Sa7WXQTQTS/An8wJTCZitlbaNDEcBIaAriCfT5gkc1xbZrWSqrGS2/p5FzeRdxDdN+kTJvk6qImaKrIl2KvcN8Gq1n6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=GpMP430l+55Sh3Q11LF7iWsYWpULIusNiLoUA5Q0ahY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p0EJCilnv4Qr1kNdCDbp+ZLldmNovHXR+nFFkZ7zJHhH2IH/OY/nBOekNuo0V0Dxk3LcxrA/G9H7XI0cbCrsdAKp3I63wtgyXL5ljQ1pv2aei59No+VAQzgZJPy4gANzAQ8jCQlqgc5m0f3lrTHUJ7f1/ZkWpVqnSPJ3WjOOyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8GN/QFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673EDC16AAE;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251686;
	bh=GpMP430l+55Sh3Q11LF7iWsYWpULIusNiLoUA5Q0ahY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=h8GN/QFuJ/EGNf6EA8HwjLxKrHWFbRBmmAbxDYjJyk6QR4KSc7qxO/EJs3JYwaqlt
	 IjO/fF7TZC9LUgepAdSq4fT5ScvvQSpJxE0ccrYjTZsyw7tz8brUUUNDyrSZxODQnd
	 CxpgPkllT2EIkSwcHeVEZCyh3RnHBAs4WnVGTKS/bSGtIARGR1zLVrpoFqGMAVhr1E
	 n0qwH1gH9tnpA3dh+JIMO6mfHhzXt13sbLWLK/TaB4yZHYRi6Oe6K6IC2LmejKIUHX
	 2qd2pTQzFWNyH3cJKjXJy+bt1rh1TwCYnCD6AOfq92Ru7r60pUnNcZLpJHrTeRyvSw
	 flb86TQdA0W5Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkk-0000000DIIm-2Bgn;
	Tue, 30 Sep 2025 13:03:02 -0400
Message-ID: <20250930170302.375260552@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>,
 Tejun Heo <tj@kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>
Subject: [for-next][PATCH 07/11] tracing: replace use of system_wq with system_percpu_wq
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Marco Crivellari <marco.crivellari@suse.com>

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/20250905091040.109772-2-marco.crivellari@suse.com
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index af42aaa3d172..3169182229ad 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -835,7 +835,7 @@ void user_event_mm_remove(struct task_struct *t)
 	 * so we use a work queue after call_rcu() to run within.
 	 */
 	INIT_RCU_WORK(&mm->put_rwork, delayed_user_event_mm_put);
-	queue_rcu_work(system_wq, &mm->put_rwork);
+	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
 }
 
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
-- 
2.50.1



