Return-Path: <linux-kernel+bounces-897551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 280A5C530E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0284E3551AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D30341AAE;
	Wed, 12 Nov 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmhUoiI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098733F8C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960960; cv=none; b=MxJXyehN5yzIGw+XPxEbX2pWRPaKF0JgiN9/B60ZOervp8Lz4lQbhWJRNJU/5NSkYpx8SewdUhX3KkpjDRx0n5r66u4Bk1sfmXDzBviRSMr+VCn6rQIZdH30bp3x8jr8E8GIfPB+z8v7nlA713mtutuFYxxgSnmmf2JEdN9taOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960960; c=relaxed/simple;
	bh=SbQboSdSpbv701LGuN0nEbpX42AA8dCN+v1cOXn5aME=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pe9fWzceG8InBvfgZZnwmaAb4HLRV0H7aq31MJJ19ZW/FsL79fJwISc/wuRDRZFNdyp+UE+BsVO5yQ5/Hb45uze/yj740juD4MhOlzTtclOcO0d+mNyKLKfr36LbpRGqEsmtyGXTwflXimp8UTjqkj3KFaJz2TcP5m/jB4b3JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmhUoiI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A2FC2BCB1;
	Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762960959;
	bh=SbQboSdSpbv701LGuN0nEbpX42AA8dCN+v1cOXn5aME=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WmhUoiI6McD0aPNv0yqzsxrnBZx5gqGk/bPxVDO6RWFhAhHzokDEfl16uPJx66A6e
	 QtGYR/KT4NichZ4G4JpuQhZ6ro2groFyozGNYyrYHlX+Fm1WS2tZQRzP0oOXaSiYud
	 9ou52dLCXsBZKom1nKjOdYdYi+3rTRf6vxP6rCTylhuKdtR2x709yB5eo1Plr4aMfW
	 nGP12eTMl2FkfUZwv99+2P8jYp0bIOVTZpW+eWA/In5ou/7Otn0iszjPmc9YcZr4LN
	 cMMUrsDmrs2ltj//SmvOvJUkjU8BgZuYRyLEkVbb+K971e3auIlo9rYgZSL2sUSiF9
	 2t/cUbzYAzGQg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJCgO-000000018MW-3dOD;
	Wed, 12 Nov 2025 10:22:52 -0500
Message-ID: <20251112152252.716220175@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 10:22:38 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/4] tracing: Have function tracer define options per instance
References: <20251112152235.655878322@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the function tracer's options are saved via a global mask when
it should be per instance. Use the new infrastructure to define a
"default_flags" field in the tracer structure that is used for the top
level instance as well as new ones.

Currently the global mask causes confusion:

  # cd /sys/kernel/tracing
  # mkdir instances/foo
  # echo function > instances/foo/current_tracer
  # echo 1 > options/func-args
  # echo function > current_tracer
  # cat trace
[..]
  <idle>-0       [005] d..3.  1050.656187: rcu_needs_cpu() <-tick_nohz_next_event
  <idle>-0       [005] d..3.  1050.656188: get_next_timer_interrupt(basej=0x10002dbad, basem=0xf45fd7d300) <-tick_nohz_next_event
  <idle>-0       [005] d..3.  1050.656189: _raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
  <idle>-0       [005] d..4.  1050.656190: do_raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
  <idle>-0       [005] d..4.  1050.656191: _raw_spin_lock_nested(lock=0xffff8944bdf5f140, subclass=1) <-__get_next_timer_interrupt
 # cat instances/foo/options/func-args
 1
 # cat instances/foo/trace
[..]
  kworker/4:1-88      [004] ...1.   298.127735: next_zone <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127736: first_online_pgdat <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127738: next_online_pgdat <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127739: fold_diff <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127741: round_jiffies_relative <-vmstat_update
[..]

The above shows that updating the "func-args" option at the top level
instance also updates the "func-args" option in the instance but because
the update is only done by the instance that gets changed (as it should),
it's confusing to see that the option is already set in the other instance.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251111232429.470883736@kernel.org
Fixes: f20a580627f43 ("ftrace: Allow instances to use function tracing")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index d17c18934445..c12795c2fb39 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -154,11 +154,11 @@ static int function_trace_init(struct trace_array *tr)
 	if (!tr->ops)
 		return -ENOMEM;
 
-	func = select_trace_function(func_flags.val);
+	func = select_trace_function(tr->current_trace_flags->val);
 	if (!func)
 		return -EINVAL;
 
-	if (!handle_func_repeats(tr, func_flags.val))
+	if (!handle_func_repeats(tr, tr->current_trace_flags->val))
 		return -ENOMEM;
 
 	ftrace_init_array_ops(tr, func);
@@ -459,14 +459,14 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	u32 new_flags;
 
 	/* Do nothing if already set. */
-	if (!!set == !!(func_flags.val & bit))
+	if (!!set == !!(tr->current_trace_flags->val & bit))
 		return 0;
 
 	/* We can change this flag only when not running. */
 	if (tr->current_trace != &function_trace)
 		return 0;
 
-	new_flags = (func_flags.val & ~bit) | (set ? bit : 0);
+	new_flags = (tr->current_trace_flags->val & ~bit) | (set ? bit : 0);
 	func = select_trace_function(new_flags);
 	if (!func)
 		return -EINVAL;
@@ -491,7 +491,7 @@ static struct tracer function_trace __tracer_data =
 	.init		= function_trace_init,
 	.reset		= function_trace_reset,
 	.start		= function_trace_start,
-	.flags		= &func_flags,
+	.default_flags	= &func_flags,
 	.set_flag	= func_set_flag,
 	.allow_instances = true,
 #ifdef CONFIG_FTRACE_SELFTEST
-- 
2.51.0



