Return-Path: <linux-kernel+bounces-780123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D22B2FDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C6F3B589E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3626C393;
	Thu, 21 Aug 2025 15:07:30 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF726B756
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788850; cv=none; b=Ed1e4jzO4dAZ1XB8LzyTsNozNF9EvfLsehQi2ZrHc05djbpYYTJIci6oL1rKBnj2T98ltPRKurLvBET9XRoEL8jLf+PHLX2ftamHOX3VDzi7BilQ4ThlUVzarF6r0HwvzXXyMHd5flSVi7Ojeg+s/IGhym+aPatRWIlk817Rz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788850; c=relaxed/simple;
	bh=wLCQfXPnhvLkYuBg8hqLLP00b/P1oOwsU3cSsSqJQ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hXn8g+eU4Xbvhj/3C0B4q0sHEnRP3p8Ek0DdMoUPC3mC6soiAw6MYxkA8PZzxtDW6kUOgMbKRBmd9WnQA7/QFUdf7xlczzhh6lIJ1bMYEXRIyzuT3sSmY1wvyinmA6IHP+00dvObi8Zt4AmiT3gnlgkCOKVPNxHJjF2Rxaxq/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C3159B9730;
	Thu, 21 Aug 2025 15:07:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 06A4B20028;
	Thu, 21 Aug 2025 15:07:18 +0000 (UTC)
Date: Thu, 21 Aug 2025 11:07:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [for-linus][PATCH] fgraph: Copy args in intermediate storage with
 entry
Message-ID: <20250821110723.4395212a@gandalf.local.home>
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
X-Rspamd-Queue-Id: 06A4B20028
X-Stat-Signature: qa14phsgfncffo8hfz7d5f3xyyzqi6ge
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/u3cbP8boSLiSmeOy3ubL+9Hfz1EFcOjU=
X-HE-Tag: 1755788838-548787
X-HE-Meta: U2FsdGVkX1+r7GON3oHQhMXsQgqYxuaDgQ5sZ0ZVYjmTM7OV2ZIYbre+wkjc6dQyjAejQPwEMS2noSKzwGpJD8SkEpLwIa5zyu5JtdO2xpLtelAr2FjBleUaJHYTYDRJHdIftbD4I5HQfPHQGp5qrmdlc2Mmrsuc3iWhGAWaPcACA/vW6IwcDZm/rgDWIc2gSqArrrO4E5/qrTiquNc4k28FJf6bG04DoCZnKUlk2EKd4JLBIyzqBqOUHcdtbPYWm0C3EAEFiwAFusC/Bp6EFC+TtY0ehRrj7tunb7bC81vFUlsjwNhw0nzWKF8AUr+GAgVbeMJXGH9IzbnF2ykUidMDxKy44vIYcTB8L7fjnA6UVIm/WGXRmlNGxdu5SssN5wsIAwcyqX5oXfjKCDpf8aaDrhrf73rJo6yprudKdetWJhywMffadXarcmPp1eqvlojK4AU12pIDLTXqBgI8ZE1+D92x74XpqE+Je6cXMNgp9EK7thnx3a+avVEpYcZ57cnEO3+lnWM=


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: b7b6a20aa4ab811f598793210b4ea62885b40e18


Steven Rostedt (1):
      fgraph: Copy args in intermediate storage with entry

----
 kernel/trace/trace_functions_graph.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)
---------------------------
commit b7b6a20aa4ab811f598793210b4ea62885b40e18
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Wed Aug 20 19:55:22 2025 -0400

    fgraph: Copy args in intermediate storage with entry
    
    The output of the function graph tracer has two ways to display its
    entries. One way for leaf functions with no events recorded within them,
    and the other is for functions with events recorded inside it. As function
    graph has an entry and exit event, to simplify the output of leaf
    functions it combines the two, where as non leaf functions are separate:
    
     2)               |              invoke_rcu_core() {
     2)               |                raise_softirq() {
     2)   0.391 us    |                  __raise_softirq_irqoff();
     2)   1.191 us    |                }
     2)   2.086 us    |              }
    
    The __raise_softirq_irqoff() function above is really two events that were
    merged into one. Otherwise it would have looked like:
    
     2)               |              invoke_rcu_core() {
     2)               |                raise_softirq() {
     2)               |                  __raise_softirq_irqoff() {
     2)   0.391 us    |                  }
     2)   1.191 us    |                }
     2)   2.086 us    |              }
    
    In order to do this merge, the reading of the trace output file needs to
    look at the next event before printing. But since the pointer to the event
    is on the ring buffer, it needs to save the entry event before it looks at
    the next event as the next event goes out of focus as soon as a new event
    is read from the ring buffer. After it reads the next event, it will print
    the entry event with either the '{' (non leaf) or ';' and timestamps (leaf).
    
    The iterator used to read the trace file has storage for this event. The
    problem happens when the function graph tracer has arguments attached to
    the entry event as the entry now has a variable length "args" field. This
    field only gets set when funcargs option is used. But the args are not
    recorded in this temp data and garbage could be printed. The entry field
    is copied via:
    
      data->ent = *curr;
    
    Where "curr" is the entry field. But this method only saves the non
    variable length fields from the structure.
    
    Add a helper structure to the iterator data that adds the max args size to
    the data storage in the iterator. Then simply copy the entire entry into
    this storage (with size protection).
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Link: https://lore.kernel.org/20250820195522.51d4a268@gandalf.local.home
    Reported-by: Sasha Levin <sashal@kernel.org>
    Closes: https://lore.kernel.org/all/aJaxRVKverIjF4a6@lappy/
    Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66e1a527cf1a..a7f4b9a47a71 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -27,14 +27,21 @@ struct fgraph_cpu_data {
 	unsigned long	enter_funcs[FTRACE_RETFUNC_DEPTH];
 };
 
+struct fgraph_ent_args {
+	struct ftrace_graph_ent_entry	ent;
+	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+};
+
 struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
 
 	/* Place to preserve last processed entry. */
 	union {
-		struct ftrace_graph_ent_entry	ent;
+		struct fgraph_ent_args		ent;
+		/* TODO allow retaddr to have args */
 		struct fgraph_retaddr_ent_entry	rent;
-	} ent;
+	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -627,10 +634,13 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT))
-				data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			else
-				data->ent.ent = *curr;
+			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
+				data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
+			} else {
+				int size = min((int)sizeof(data->ent), (int)iter->ent_size);
+
+				memcpy(&data->ent, curr, size);
+			}
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can

