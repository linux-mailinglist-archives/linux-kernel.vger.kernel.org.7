Return-Path: <linux-kernel+bounces-746353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF9B125AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAE1CE69F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E2E26A0A6;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/x613I4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05A2620C6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475662; cv=none; b=YQ/4oD2T0SVMn5olmFI2RWk8FTriyiOhEd/wvylXzejCcq6Z7PsRg+HivOezM/EKdXwOwBz2KpE1lJ6yGQb5KWRQJ1zFyx7DzpWDt/8ZA/keszmWZ8Me75fuaOhwXzlr3+2G3jQCFIchqWwMkXSi8wx4wU5AyqEY5myv57Z9n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475662; c=relaxed/simple;
	bh=5FhrJdRrPXoJDitTnpTHro5cJdUMVk+R5P5dbrBa2Cg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=imzVv2QkZUzDlXr+r62C/5UGZuZmdTTYUBpxpRNzZEHsW3tRl/VcWTl4uhkByu2+47SgoUvNkm1S3voYyAGfzUk0Q4kLXu6VUKXdIbaWOzQ65hPx7ahS4srLMyU9gLLb52Ooeyx3sO2570yUfjocBCUARi5or4vnQMCGvM+U9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/x613I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C37C4CEFA;
	Fri, 25 Jul 2025 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475662;
	bh=5FhrJdRrPXoJDitTnpTHro5cJdUMVk+R5P5dbrBa2Cg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=I/x613I4RGsiR3wFpiWVjaJ4SBVzNEg4djRH9YERWNA6J3E/3Yb37yiS8bCA1jvGB
	 6S5LiV5z1pIoFuFWqrqbeZJZLqiVeg6IAK/h2cT3levApFPnj0cpGOw85y2dA7mTxY
	 8ni28MzV1/YJaC8rVKK1WwCq3D9qUYgmKH+a4HYAZfgZ4oUSigDjfmXkFPOrpF79j7
	 O/OjkWBz8+x2bMa8J/JukqTHOGqiD4o4QixBCtoHtRIePKPb7BIXg0aHOrEm6HSvJw
	 MdRmGF96Bk41rQ/dEPcciL2WnmoAgsimNWedIdGaYRxt50l9rUdA+qv4OVRocPvs3v
	 SKm5HYLy483uw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7c-00000001QoN-1HQK;
	Fri, 25 Jul 2025 16:34:28 -0400
Message-ID: <20250725203428.155244648@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 25/25] rv: Remove struct rv_monitor::reacting
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

The field 'reacting' in struct rv_monitor is set but never used. Delete it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/a6c16f845d2f1a09c4d0934ab83f3cb14478a71d.1753378331.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h            |  1 -
 kernel/trace/rv/rv_reactors.c | 19 +++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 2f867d6f72ba..80731242fe60 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -104,7 +104,6 @@ struct rv_monitor {
 #ifdef CONFIG_RV_REACTORS
 	struct rv_reactor	*reactor;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
-	bool			reacting;
 #endif
 	struct list_head	list;
 	struct rv_monitor	*parent;
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index a8e849e6cd85..106f2c4740f2 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -160,7 +160,7 @@ static const struct seq_operations monitor_reactors_seq_ops = {
 
 static void monitor_swap_reactors_single(struct rv_monitor *mon,
 					 struct rv_reactor *reactor,
-					 bool reacting, bool nested)
+					 bool nested)
 {
 	bool monitor_enabled;
 
@@ -173,7 +173,6 @@ static void monitor_swap_reactors_single(struct rv_monitor *mon,
 		rv_disable_monitor(mon);
 
 	mon->reactor = reactor;
-	mon->reacting = reacting;
 	mon->react = reactor->react;
 
 	/* enable only once if iterating through a container */
@@ -181,8 +180,7 @@ static void monitor_swap_reactors_single(struct rv_monitor *mon,
 		rv_enable_monitor(mon);
 }
 
-static void monitor_swap_reactors(struct rv_monitor *mon,
-				  struct rv_reactor *reactor, bool reacting)
+static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reactor *reactor)
 {
 	struct rv_monitor *p = mon;
 
@@ -190,7 +188,7 @@ static void monitor_swap_reactors(struct rv_monitor *mon,
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
 			if (p->parent != mon)
 				break;
-			monitor_swap_reactors_single(p, reactor, reacting, true);
+			monitor_swap_reactors_single(p, reactor, true);
 		}
 	/*
 	 * This call enables and disables the monitor if they were active.
@@ -198,7 +196,7 @@ static void monitor_swap_reactors(struct rv_monitor *mon,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mon, reactor, reacting, false);
+	monitor_swap_reactors_single(mon, reactor, false);
 }
 
 static ssize_t
@@ -210,7 +208,6 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 	struct rv_reactor *reactor;
 	struct seq_file *seq_f;
 	int retval = -EINVAL;
-	bool enable;
 	char *ptr;
 	int len;
 
@@ -243,12 +240,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 		if (strcmp(ptr, reactor->name) != 0)
 			continue;
 
-		if (strcmp(reactor->name, "nop"))
-			enable = false;
-		else
-			enable = true;
-
-		monitor_swap_reactors(mon, reactor, enable);
+		monitor_swap_reactors(mon, reactor);
 
 		retval = count;
 		break;
@@ -439,7 +431,6 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	 * Configure as the rv_nop reactor.
 	 */
 	mon->reactor = get_reactor_rdef_by_name("nop");
-	mon->reacting = false;
 
 	return 0;
 }
-- 
2.47.2



