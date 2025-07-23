Return-Path: <linux-kernel+bounces-742757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A50B0F657
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C760016E4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D22F8C5D;
	Wed, 23 Jul 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8N/Qwza"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6222F94BA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282167; cv=none; b=sLYTKjYjvbCoXjh/jgppZOb7ILF2taVQE8hUTfbvClWPm6Iir0d4fyh0eSy55chT2HZcoxD75lgOPET+jiWUB0omfGHhMl+/KpE3AnPufxOkOOHHBLNOwCnMxIu9+8GW8PptiyTciPuS4PCrxHnQ69uJO0MlFmAZxO6OAkoOhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282167; c=relaxed/simple;
	bh=RVU8e3tPxKExebVReo9iYbzkYxmRBIQqTKXARYt+7+k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cN2J3K4NNJj5dRNguLAtgcbkicoI6stoeCO9CZuUxuHgh3EL6FrUSHHeEwI02noYqANFGJl2C6kqxWWco27l+6juYzSumXTfBN1Z0dAWUro382kBQmrE/4vomoruGH6nffkKe+ZFQIsFUbQ8crXBD1K3wRT9RpELXG/U3oIHKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8N/Qwza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E564BC2BCF7;
	Wed, 23 Jul 2025 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282167;
	bh=RVU8e3tPxKExebVReo9iYbzkYxmRBIQqTKXARYt+7+k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=W8N/QwzaX2N7sDL2v8mUi7q7wL6Rar1vnFyKeQTpg6wjwCuyv0pfoX2TdaTSWGezG
	 GwCSQDQUfT4ZValhmtKqqbcpD9/m4E8gBj8KbUOMuE6ntKBtFC8SFp+BXknvNM+0fa
	 ZLMRl9G1mUlihKOhslcRRF6XU66LCocClKnTnEGKSYa8hNflqVFwdklZxs86DAlJIM
	 OFV39a8IyBBCN8S9pX+WVBw1LdYll1mW95XDBcaoIQemmJ5UtZT4oVLQD8GlvFl8MR
	 VTcnf+Yk3k5khVC14N1dURNQOZbV2nsNH0J+Y6QBtlvf54b60+aKO9t7TY+b/OUNmW
	 Ae0icNExAWtrw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueamd-00000000LPj-3QhN;
	Wed, 23 Jul 2025 10:49:27 -0400
Message-ID: <20250723144927.671461904@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [for-next][PATCH 2/8] tracing: Use queue_rcu_work() to free filters
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Freeing of filters requires to wait for both an RCU grace period as well as
a RCU task trace wait period after they have been detached from their
lists. The trace task period can be quite large so the freeing of the
filters was moved to use the call_rcu*() routines. The problem with that is
that the callback functions of call_rcu*() is done from a soft irq and can
cause latencies if the callback takes a bit of time.

The filters are freed per event in a system and the syscalls system
contains an event per system call, which can be over 700 events. Freeing 700
filters in a bottom half is undesirable.

Instead, move the freeing to use queue_rcu_work() which is done in task
context.

Link: https://lore.kernel.org/all/9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250609131732.04fd303b@gandalf.local.home
Fixes: a9d0aab5eb33 ("tracing: Fix regression of filter waiting a long time on RCU synchronization")
Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3885aadc434d..196c8bf34970 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1344,13 +1344,14 @@ struct filter_list {
 
 struct filter_head {
 	struct list_head	list;
-	struct rcu_head		rcu;
+	union {
+		struct rcu_head		rcu;
+		struct rcu_work		rwork;
+	};
 };
 
-
-static void free_filter_list(struct rcu_head *rhp)
+static void free_filter_list(struct filter_head *filter_list)
 {
-	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
 	struct filter_list *filter_item, *tmp;
 
 	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
@@ -1361,9 +1362,20 @@ static void free_filter_list(struct rcu_head *rhp)
 	kfree(filter_list);
 }
 
+static void free_filter_list_work(struct work_struct *work)
+{
+	struct filter_head *filter_list;
+
+	filter_list = container_of(to_rcu_work(work), struct filter_head, rwork);
+	free_filter_list(filter_list);
+}
+
 static void free_filter_list_tasks(struct rcu_head *rhp)
 {
-	call_rcu(rhp, free_filter_list);
+	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
+
+	INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
+	queue_rcu_work(system_wq, &filter_list->rwork);
 }
 
 /*
@@ -1460,7 +1472,7 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 	tracepoint_synchronize_unregister();
 
 	if (head)
-		free_filter_list(&head->rcu);
+		free_filter_list(head);
 
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir || !file->filter)
@@ -2305,7 +2317,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return 0;
  fail:
 	/* No call succeeded */
-	free_filter_list(&filter_list->rcu);
+	free_filter_list(filter_list);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
@@ -2315,7 +2327,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	if (!fail)
 		delay_free_filter(filter_list);
 	else
-		free_filter_list(&filter_list->rcu);
+		free_filter_list(filter_list);
 
 	return -ENOMEM;
 }
-- 
2.47.2



