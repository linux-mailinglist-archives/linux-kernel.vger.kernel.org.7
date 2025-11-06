Return-Path: <linux-kernel+bounces-889396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC8C3D73D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D703A4E8089
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6206305E14;
	Thu,  6 Nov 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E76R01OU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FD3043CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=LNhqPZJuj2vE1BGQLAwFYoZOxbxRI2WxUyMz5ePkMYDOD6fmyDTwGSwXlbkM8DB/zkIxhcqrJjYhTwKJmRYMwsX0AEzIytaQMus2cOmvYXMs+UkN7W8mLB+2BRoHzPCQOJ3ABG7CsOI+bUzvONYaSuPzJIBM17Ygbx9tDrAsUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=WQdlEZLR91pyM/JJhDRZIhhFahmWBrTK9PMzbl3MwYU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NZyEZ1N78IFO3izmNaS4azpu0tm1aVOEe5KI2h9EhJTCx8k5KOWXFGxClHemJws2u7fO69FQilqS8fxa/SHyrSEzjLxeOhVyihADQvVFL2EG05qGW5DGXaBi6HJ3GPtTgcbxlcbjM3pYRnQgloW/bbpmrXgwiChHsP82U1+d2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E76R01OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E53C113D0;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463038;
	bh=WQdlEZLR91pyM/JJhDRZIhhFahmWBrTK9PMzbl3MwYU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=E76R01OUGuL+5mpBoODiYIyO30KnJH2q0n/cHWwhHpWcadHCSg/1vN7YU/tOKlX5q
	 VcfJdf3YwO11rTUm7Z2aN2YCXPQY+WLUOxmHHPPYNfOvvxXHvIITMSPGB5sArJvhbi
	 PodVB/mD1IVAjupEX5VXHto3whMITxomMne/wt3LNcc7q+8sO9y8VYkLTfgX27veTh
	 rxdwUB3ki2hvNHamTgC+Crl8HJy/PpQ0E1CwtIFylIkVrLCodhAcv9dt37Zh6dDrvM
	 NVcUaV+AYpmGdtJXQLk6SL+xuA73iiNiSgxXQM+a/inHP/Cbmf1wYAnNTuWYPRC8k8
	 u+zIht2spX+Aw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79C-000000008EI-0aa5;
	Thu, 06 Nov 2025 16:03:58 -0500
Message-ID: <20251106210357.996566505@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:38 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 7/7] tracing: Use switch statement instead of ifs in set_tracer_flag()
References: <20251106210331.537317097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The "mask" passed in to set_trace_flag() has a single bit set. The
function then checks if the mask is equal to one of the option masks and
performs the appropriate function associated to that option.

Instead of having a bunch of "if ()" statement, use a "switch ()"
statement instead to make it cleaner and a bit more optimal.

No function changes.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251106003501.890298562@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88234b541b09..0aea9cb84276 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5220,11 +5220,13 @@ int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
 
 int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
-	if ((mask == TRACE_ITER(RECORD_TGID)) ||
-	    (mask == TRACE_ITER(RECORD_CMD)) ||
-	    (mask == TRACE_ITER(TRACE_PRINTK)) ||
-	    (mask == TRACE_ITER(COPY_MARKER)))
+	switch (mask) {
+	case TRACE_ITER(RECORD_TGID):
+	case TRACE_ITER(RECORD_CMD):
+	case TRACE_ITER(TRACE_PRINTK):
+	case TRACE_ITER(COPY_MARKER):
 		lockdep_assert_held(&event_mutex);
+	}
 
 	/* do nothing if flag is already set */
 	if (!!(tr->trace_flags & mask) == !!enabled)
@@ -5235,7 +5237,8 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
 			return -EINVAL;
 
-	if (mask == TRACE_ITER(TRACE_PRINTK)) {
+	switch (mask) {
+	case TRACE_ITER(TRACE_PRINTK):
 		if (enabled) {
 			update_printk_trace(tr);
 		} else {
@@ -5252,9 +5255,9 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 			if (printk_trace == tr)
 				update_printk_trace(&global_trace);
 		}
-	}
+		break;
 
-	if (mask == TRACE_ITER(COPY_MARKER)) {
+	case TRACE_ITER(COPY_MARKER):
 		update_marker_trace(tr, enabled);
 		/* update_marker_trace updates the tr->trace_flags */
 		return 0;
@@ -5265,10 +5268,12 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 	else
 		tr->trace_flags &= ~mask;
 
-	if (mask == TRACE_ITER(RECORD_CMD))
+	switch (mask) {
+	case TRACE_ITER(RECORD_CMD):
 		trace_event_enable_cmd_record(enabled);
+		break;
 
-	if (mask == TRACE_ITER(RECORD_TGID)) {
+	case TRACE_ITER(RECORD_TGID):
 
 		if (trace_alloc_tgid_map() < 0) {
 			tr->trace_flags &= ~TRACE_ITER(RECORD_TGID);
@@ -5276,24 +5281,27 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		}
 
 		trace_event_enable_tgid_record(enabled);
-	}
+		break;
 
-	if (mask == TRACE_ITER(EVENT_FORK))
+	case TRACE_ITER(EVENT_FORK):
 		trace_event_follow_fork(tr, enabled);
+		break;
 
-	if (mask == TRACE_ITER(FUNC_FORK))
+	case TRACE_ITER(FUNC_FORK):
 		ftrace_pid_follow_fork(tr, enabled);
+		break;
 
-	if (mask == TRACE_ITER(OVERWRITE)) {
+	case TRACE_ITER(OVERWRITE):
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_MAX_TRACE
 		ring_buffer_change_overwrite(tr->max_buffer.buffer, enabled);
 #endif
-	}
+		break;
 
-	if (mask == TRACE_ITER(PRINTK)) {
+	case TRACE_ITER(PRINTK):
 		trace_printk_start_stop_comm(enabled);
 		trace_printk_control(enabled);
+		break;
 	}
 
 	return 0;
-- 
2.51.0



