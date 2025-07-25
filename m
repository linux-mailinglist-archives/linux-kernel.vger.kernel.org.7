Return-Path: <linux-kernel+bounces-745795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0DDB11EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC42AA2A48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10D2ECD19;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRQ/eVSv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17302EBDC3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447325; cv=none; b=hlwOB9q1QWbg6tO64RoeE4CCWvQnV47nsM8r34hAxSdUXShViuiqQGFNYfgxffZFgNG4ksfisCr4aeJG2dhf2hdhGReOcbWXlqgYg3mpCkPOFmH0nm3qJfneysU44HGCkl5ciy53UWO0UyDU/kk7ZQ+v0vRvdFrOES52omIYtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447325; c=relaxed/simple;
	bh=qcVYPuBO5Z4rgObuJEoioUnNNPKt/VjlMojXOPllFwA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kLpxh6P7ub71ZxGlfXrZYEuer0lG8MJ8XNnkFgNH65Y0JLJDL/ooD6vI7lS7suKEZA/ielS8J2wJW6Wnu/og7WDNxKGmxRNRLxWvNYylOu75W9mxo2eHZf1hKfGNbUzc3Lwuzah5aC9RbU2iihgcPeKqAl4/fK/YfHYRaQmNPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRQ/eVSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB84EC4CEE7;
	Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447325;
	bh=qcVYPuBO5Z4rgObuJEoioUnNNPKt/VjlMojXOPllFwA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=TRQ/eVSvE2wFF1+iGgir8q3XiTYVgd8zGa/r5Ft5pKLOB3TP2vRXt/pzhdmTz+T49
	 YgiOUkdjjr/1rf6F4LJQLGdQb9U+F+OeTZcNVrTVbdat4m85ois3VVFUAcwZkwP1T9
	 6cnvNa6tKD9zjxF1rlYgYqDxpOyUSkv6RdZMoZQpHS6XDaqmtFsmJjOHlGu4WYESRq
	 hUcR2wuBqult8KhpRHjxy3ys/CkbMx499M0VVueqNGEUmDOvXyJF1LwBg8BRlpC45J
	 bL/DMie2ueQVZUmF287vDQHcOhb+diqR2qm8cIw+lImQJ0t+da3q0b6St98oJCbKQg
	 8uxtTZ7JwbmjA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkZ-00000001CuP-0MZN;
	Fri, 25 Jul 2025 08:42:11 -0400
Message-ID: <20250725124210.936089481@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [for-next][PATCH 4/9] PM: tracing: Hide psci_domain_idle events under ARM_PSCI_CPUIDLE
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The events psci_domain_idle_enter and psci_domain_idle_exit events are
only called when CONFIG_ARM_PSCI_CPUIDLE is defined. As each event can
take up to 5K (less for DEFINE_EVENT()) regardless if they are used or
not, it's best not to define them when they are not used. Add #ifdef
around these events when they are not used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/20250612145408.074769245@goodmis.org
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 913181cebfe9..a10ad300d660 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,7 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );
 
+#ifdef CONFIG_ARM_PSCI_CPUIDLE
 DECLARE_EVENT_CLASS(psci_domain_idle,
 
 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
@@ -98,6 +99,7 @@ DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
 
 	TP_ARGS(cpu_id, state, s2idle)
 );
+#endif
 
 TRACE_EVENT(pstate_sample,
 
-- 
2.47.2



