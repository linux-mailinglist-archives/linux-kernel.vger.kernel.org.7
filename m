Return-Path: <linux-kernel+bounces-742829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2DEB0F723
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E4E7A88E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920221F9F70;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/aYE6Tf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5B1F12E0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284962; cv=none; b=skrEzTELSq6/G8taucChWkPdtIBQHllrcydWWuZmMe+DH3VRjGysCVDqb+q6i/BDI2vxui34hlk4hBQ7hkP4aLtcwqh9jgOnQgBonmMswb2Rsucu6b7iHnAYGZebIVGdYaio5bFKCecx3eFL+QG2+Y7QiU8lhR14DmF4+Juaud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284962; c=relaxed/simple;
	bh=mrCVMwB0r4GEpqhegCCAOZeTt67vnx2mLaFmd/ePuwM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aeXqCTAR+aeUnwMiMSUIOjH9Jifm4BJxcg1axslYr+hr74eA+Q9CSDio9olbYvDpkR5HwqEBQ93e1HV/vlVU8KlaEwujXiP/O0464htOFa++KAPrD4PcBu32g9lp3IZRIC/hGIpjBYjEIObT4Ww6ezYou3UEqm43bS1gsJmEApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/aYE6Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662EBC4CEEF;
	Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284962;
	bh=mrCVMwB0r4GEpqhegCCAOZeTt67vnx2mLaFmd/ePuwM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=f/aYE6TfgPyPCzUPq7BSKBSR9n7sbtb5QTQEMIE7wV0UqLiuFeO48h0TIgXr+I+hC
	 I0w6kykXAGketNu+UcQFAgzrQI+BiipFf0Wn+tR8HmtUf1qAdMWCAxkMazADTaSGtH
	 RkTOy2swvFy6XG6fUp8vGejiv7H8Qw3AjfJHXNe4RFk2s360Gw4JG1vf6XUE8gE9yM
	 QMXtN3OXa4MjdmGWjeccO8sQLea5mFxFxMPXlFivXA1QKkK52DIRN4HS81USeW1655
	 JxcrqcvH11ngI+TDVt0rEyt/WJIR1VTbUXPJb59a40XOiBE6gELXM0S6jL082u7TNc
	 QZUuQ8FSArRFQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueame-00000000LRi-224k;
	Wed, 23 Jul 2025 10:49:28 -0400
Message-ID: <20250723144928.341184323@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [for-next][PATCH 6/8] tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When soft disabling of trace events was first created, it needed to have a
way to know if a file had a user that was using it with soft disabled (for
triggers that need to enable or disable events from a context that can not
really enable or disable the event, it would set SOFT_DISABLED to state it
is disabled). The flag SOFT_MODE was used to denote that an event had a
user that would enable or disable it via the SOFT_DISABLED flag.

Commit 1cf4c0732db3c ("tracing: Modify soft-mode only if there's no other
referrer") fixed a bug where if two users were using the SOFT_DISABLED
flag the accounting would get messed up as the SOFT_MODE flag could only
handle one user. That commit added the sm_ref counter which kept track of
how many users were using the event in "soft mode". This made the
SOFT_MODE flag redundant as it should only be set if the sm_ref counter is
non zero.

Remove the SOFT_MODE flag and just use the sm_ref counter to know the
event is in soft mode or not. This makes the code a bit simpler.

Link: https://lore.kernel.org/all/20250702111908.03759998@batman.local.home/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Link: https://lore.kernel.org/20250702143657.18dd1882@batman.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  3 ---
 kernel/trace/trace_events.c  | 24 ++++++++++++------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index fa9cf4292dff..04307a19cde3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -480,7 +480,6 @@ enum {
 	EVENT_FILE_FL_RECORDED_TGID_BIT,
 	EVENT_FILE_FL_FILTERED_BIT,
 	EVENT_FILE_FL_NO_SET_FILTER_BIT,
-	EVENT_FILE_FL_SOFT_MODE_BIT,
 	EVENT_FILE_FL_SOFT_DISABLED_BIT,
 	EVENT_FILE_FL_TRIGGER_MODE_BIT,
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
@@ -618,7 +617,6 @@ extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
  *  RECORDED_TGID - The tgids should be recorded at sched_switch
  *  FILTERED	  - The event has a filter attached
  *  NO_SET_FILTER - Set when filter has error and is to be ignored
- *  SOFT_MODE     - The event is enabled/disabled by SOFT_DISABLED
  *  SOFT_DISABLED - When set, do not trace the event (even though its
  *                   tracepoint may be enabled)
  *  TRIGGER_MODE  - When set, invoke the triggers associated with the event
@@ -633,7 +631,6 @@ enum {
 	EVENT_FILE_FL_RECORDED_TGID	= (1 << EVENT_FILE_FL_RECORDED_TGID_BIT),
 	EVENT_FILE_FL_FILTERED		= (1 << EVENT_FILE_FL_FILTERED_BIT),
 	EVENT_FILE_FL_NO_SET_FILTER	= (1 << EVENT_FILE_FL_NO_SET_FILTER_BIT),
-	EVENT_FILE_FL_SOFT_MODE		= (1 << EVENT_FILE_FL_SOFT_MODE_BIT),
 	EVENT_FILE_FL_SOFT_DISABLED	= (1 << EVENT_FILE_FL_SOFT_DISABLED_BIT),
 	EVENT_FILE_FL_TRIGGER_MODE	= (1 << EVENT_FILE_FL_TRIGGER_MODE_BIT),
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..0980f4def360 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -768,6 +768,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
+	bool soft_mode = atomic_read(&file->sm_ref) != 0;
 	int ret = 0;
 	int disable;
 
@@ -782,7 +783,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 * is set we do not want the event to be enabled before we
 		 * clear the bit.
 		 *
-		 * When soft_disable is not set but the SOFT_MODE flag is,
+		 * When soft_disable is not set but the soft_mode is,
 		 * we do nothing. Do not disable the tracepoint, otherwise
 		 * "soft enable"s (clearing the SOFT_DISABLED bit) wont work.
 		 */
@@ -790,11 +791,11 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_dec_return(&file->sm_ref) > 0)
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
-			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			soft_mode = false;
 			/* Disable use of trace_buffered_event */
 			trace_buffered_event_disable();
 		} else
-			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
+			disable = !soft_mode;
 
 		if (disable && (file->flags & EVENT_FILE_FL_ENABLED)) {
 			clear_bit(EVENT_FILE_FL_ENABLED_BIT, &file->flags);
@@ -812,8 +813,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 
 			WARN_ON_ONCE(ret);
 		}
-		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
-		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
+		/* If in soft mode, just set the SOFT_DISABLE_BIT, else clear it */
+		if (soft_mode)
 			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 		else
 			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
@@ -823,7 +824,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 * When soft_disable is set and enable is set, we want to
 		 * register the tracepoint for the event, but leave the event
 		 * as is. That means, if the event was already enabled, we do
-		 * nothing (but set SOFT_MODE). If the event is disabled, we
+		 * nothing (but set soft_mode). If the event is disabled, we
 		 * set SOFT_DISABLED before enabling the event tracepoint, so
 		 * it still seems to be disabled.
 		 */
@@ -832,7 +833,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		else {
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
-			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			soft_mode = true;
 			/* Enable use of trace_buffered_event */
 			trace_buffered_event_enable();
 		}
@@ -840,7 +841,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
 			bool cmd = false, tgid = false;
 
-			/* Keep the event disabled, when going to SOFT_MODE. */
+			/* Keep the event disabled, when going to soft mode. */
 			if (soft_disable)
 				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 
@@ -1792,8 +1793,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	    !(flags & EVENT_FILE_FL_SOFT_DISABLED))
 		strcpy(buf, "1");
 
-	if (flags & EVENT_FILE_FL_SOFT_DISABLED ||
-	    flags & EVENT_FILE_FL_SOFT_MODE)
+	if (atomic_read(&file->sm_ref) != 0)
 		strcat(buf, "*");
 
 	strcat(buf, "\n");
@@ -3584,7 +3584,7 @@ static int probe_remove_event_call(struct trace_event_call *call)
 			continue;
 		/*
 		 * We can't rely on ftrace_event_enable_disable(enable => 0)
-		 * we are going to do, EVENT_FILE_FL_SOFT_MODE can suppress
+		 * we are going to do, soft mode can suppress
 		 * TRACE_REG_UNREGISTER.
 		 */
 		if (file->flags & EVENT_FILE_FL_ENABLED)
@@ -3997,7 +3997,7 @@ static int free_probe_data(void *data)
 
 	edata->ref--;
 	if (!edata->ref) {
-		/* Remove the SOFT_MODE flag */
+		/* Remove soft mode */
 		__ftrace_event_enable_disable(edata->file, 0, 1);
 		trace_event_put_ref(edata->file->event_call);
 		kfree(edata);
-- 
2.47.2



