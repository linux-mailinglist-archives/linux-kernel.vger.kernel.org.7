Return-Path: <linux-kernel+bounces-738391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0483CB0B7D0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740F27A35FD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999E217730;
	Sun, 20 Jul 2025 18:53:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA37382
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037604; cv=none; b=IEQWwcXpcMAg1nHEmNhbEKKwdsWyhfqgceheORkcl0BSbAfVZLwLZXNcHazAYshw5P1L/srkBDXCP59LiTaub2phFY7FgTzRJJauqMAoplV0hsBdkI+QHENsRj1gBEElQKifcuUZcjovV2xV9FciPWCJdJYVBpc7IPmv/dTjAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037604; c=relaxed/simple;
	bh=QUBzGts9pRFrvrehP0LoI66REJfI5RmliS2gY8+oXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lcNXzDu8tG7xGfIZjiBfhMRjWPxfBXN+BcwtShZtAgWZNGRfPoxmwLrPtAH1lhk8VgXHzTNE5IUPRTMc+kp2E6SI6+q9I8JFtNvgOgnkFoa1+wbth9q4EgONLmElzyckdDepSyMRIlHHmm5osL9RFhSkDyoXy5r355z+O4SYJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 47AD41405A7;
	Sun, 20 Jul 2025 18:53:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 9B57320027;
	Sun, 20 Jul 2025 18:53:11 +0000 (UTC)
Date: Sun, 20 Jul 2025 14:53:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] tracing: Fixes for 6.16
Message-ID: <20250720145339.5f09ac0f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9B57320027
X-Stat-Signature: mcq5ygtz4uqpqhbagydsr1epokst6xrc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Bgq4bNYzZ9FPsBpRu5GnxzjOobS4Qdt0=
X-HE-Tag: 1753037591-521082
X-HE-Meta: U2FsdGVkX1/8OGYjk6eS+A/qJR8j38JZr3d87Jqm5dQt0/60G14Sv5HewsfvlgI9JgtGuF13rYuQ0SI4vmCJFt8PvnlVCWepr5jwSd+dMbqAxcqOuhyYwTzGXSrtWizuX65jydssJHMZk21WIE/eDx7UM1OK3ksT93zHq4mgL7mkKCiWGX/USaX4S8g8E91o777SooeYwf3NshEOo6rhY0gMzQdebKnG8Q428t65Cxye0Y7M28wHB7ItHzpXrq4aDXqmYO3LYe83jdOccnj5gwGgaZUqqEtHvT6Za5dFROXIpa1mCxLEaGT3fH1jcDcxIuGfxOLoCb8I2zAzvILhjMG37p+oG4pW


Linus,

Tracing fixes for 6.16:

- Fix timerlat with use of FORTIFY_SOURCE

  FORTIFY_SOURCE was added to the stack tracer where it compares the
  entry->caller array to having entry->size elements.

  timerlat has the following:

     memcpy(&entry->caller, fstack->calls, size);
     entry->size = size;

  Which triggers FORTIFY_SOURCE as the caller is populated before the
  entry->size is initialized.

  Swap the order to satisfy FORTIFY_SOURCE logic.

- Add down_write(trace_event_sem) when adding trace events in modules

  Trace events being added to the ftrace_events array are protected by
  the trace_event_sem semaphore. But when loading modules that have
  trace events, the addition of the events are not protected by the
  semaphore and loading two modules that have events at the same time
  can corrupt the list.

  Also add a lockdep_assert_held(trace_event_sem) to
  _trace_add_event_dirs() to confirm its held when iterating the list.


Please pull the latest trace-v6.16-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.16-rc5

Tag SHA1: 3fa4ea79493691015e6e08d752e502a80d3364a6
Head SHA1: b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df


Steven Rostedt (1):
      tracing: Add down_write(trace_event_sem) when adding trace event

Tomas Glozar (1):
      tracing/osnoise: Fix crash in timerlat_dump_stack()

----
 kernel/trace/trace_events.c  | 5 +++++
 kernel/trace/trace_osnoise.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..d01e5c910ce1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3136,7 +3136,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	if (ret < 0)
 		return ret;
 
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
 		atomic_set(&call->refcnt, 0);
 	else
@@ -3750,6 +3753,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
 
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret = __trace_add_new_event(call, tr);
 		if (ret < 0)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 6819b93309ce..fd259da0aa64 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -637,8 +637,8 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
 
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = fstack->nr_entries;
+	memcpy(&entry->caller, fstack->calls, size);
 
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }

