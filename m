Return-Path: <linux-kernel+bounces-630506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BEBAA7B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D071B66C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BB21A43C;
	Fri,  2 May 2025 20:53:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA220D4F8;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219230; cv=none; b=ql4mbb7gKSaGDzj7yl7j6Mla+5dMXe+Oov+r3x4Iohcd2eX0d1TVXPnk8W8iNYxH3TyVqSrhOpRZAI9cMkrd5rdy6l3f6buHXxdyR6zWiE07+bSwpj3y0QruHLFgYY+gK1AWvht1EYF+hvE2DFTm6oM9WvX0jKVH1/aXzLtmiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219230; c=relaxed/simple;
	bh=KBSu9SzGK7jFP/cW6FtoJKxk4mpVMjFrcGbCGflAdck=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CWtYh/90Twytbr5J2yEkmTcvY/0VWu2keyKAYwiEE1RT3/SVCWcgq1R9DJMEzrbGfttQEHG6EuJuOLHFivsQUlgopUcuweEP90ym9rgtLZYCtpa1CcAzMxAo57QZx3nRoJ6dwSIupdknneD8/ynDzVDuZyN9ntBHxB6/ZideEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617B9C4CEE4;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOH-000000006Ca-0Tst;
	Fri, 02 May 2025 16:53:49 -0400
Message-ID: <20250502205348.972501388@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 07/12] tracing: Do not use per CPU array_buffer.data->disabled for cpumask
References: <20250502205147.283272733@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The per CPU "disabled" value was the original way to disable tracing when
the tracing subsystem was first created. Today, the ring buffer
infrastructure has its own way to disable tracing. In fact, things have
changed so much since 2008 that many things ignore the disable flag.

Do not bother setting the per CPU disabled flag of the array_buffer data
to use to determine what CPUs can write to the buffer and only rely on the
ring buffer code itself to disabled it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bae32778b292..8cee71683fe3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5048,7 +5048,6 @@ int tracing_set_cpumask(struct trace_array *tr,
 		 */
 		if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
-			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
 #ifdef CONFIG_TRACER_MAX_TRACE
 			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
@@ -5056,7 +5055,6 @@ int tracing_set_cpumask(struct trace_array *tr,
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
-			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
 #ifdef CONFIG_TRACER_MAX_TRACE
 			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
-- 
2.47.2



