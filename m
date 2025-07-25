Return-Path: <linux-kernel+bounces-746354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87CB125AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C46DAC0F24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65AE26B951;
	Fri, 25 Jul 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM4/4AWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB02638AF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475663; cv=none; b=I0sJ0dfGeEK6kVgHYNcieI/2RIl33uNgIbN4PW5J8QDWBFZEDZaElBOb0L+SstNi1+gFLWLmVYzcgI/zNOJds8kGLhbHxppiq2lOtFaNSh4aLIQGsZBkCs45SE2U5n1MxD+AvuPKsUtZEMFJvttM3j9Sce6sg8WDJ5i6EUxfDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475663; c=relaxed/simple;
	bh=o4IL2Ph/MRJs8yCWP6+HvkGSsKELCJPor7WmK/2GjqQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=A5UOT4q5ZmyN4NTauMk5THjHvKCHU0FWmbrTzmD12JFXIwUtmbtQdsl1OdQDH7MdauWFdGta1LL5VaC05qcGoomvJn42Md82+0QznVbsM3CfSlu5mA2bSF/NQ67MbQAd1+eqecedcQmUqE0gTXrGelCHSMCSCVxh4o99uJdzLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM4/4AWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BF2C4CEF6;
	Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475661;
	bh=o4IL2Ph/MRJs8yCWP6+HvkGSsKELCJPor7WmK/2GjqQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oM4/4AWADMzXgZK9NcMQXF8D3Im5yxDclb1oK1ioaF6Ah/+oTNS9miN9mM2szad/N
	 1JjNpOZtRp23ryik+HVl3WCOSfTtTPBAr0baU9kw2gqlxiRhV913oFExIeB0/r9IRV
	 JhwYCOuj201MvWRHGAn6paIijqZ2Snb7XrwBqY97rhRxlPBnWlpMLpGntvqlxiRfjp
	 50PVokGUhqXdv0QIqEiCLH3/HPJWYRxwg5lMjUxOy3pABRI3paZcuHgNikEciTVzwH
	 DmUgn0kvuMAzbKdrJOlKw5ZbPe8YJBP7kN6pDEaWBEEx1GFQmYHCyR68zVxfg0W/4V
	 GrWblTsGTxR5g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7b-00000001QnN-41at;
	Fri, 25 Jul 2025 16:34:27 -0400
Message-ID: <20250725203427.811864815@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:20 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 23/25] rv: Merge struct rv_reactor_def into struct rv_reactor
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Each struct rv_reactor has a unique struct rv_reactor_def associated with
it. struct rv_reactor is statically allocated, while struct rv_reactor_def
is dynamically allocated.

This makes the code more complicated than it should be:

  - Lookup is required to get the associated rv_reactor_def from rv_reactor

  - Dynamic memory allocation is required for rv_reactor_def. This is
    harder to get right compared to static memory. For instance, there is
    an existing mistake: rv_unregister_reactor() does not free the memory
    allocated by rv_register_reactor(). This is fortunately not a real
    memory leak problem as rv_unregister_reactor() is never called.

Simplify and merge rv_reactor_def into rv_reactor.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/71cb91c86cd40df5b8c492b788787f2a73c3eaa3.1753378331.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h            |  5 +-
 kernel/trace/rv/rv.h          |  9 ----
 kernel/trace/rv/rv_reactors.c | 92 +++++++++++++++--------------------
 3 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index dba53aecdfab..c22c9b8c1567 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -90,6 +90,9 @@ struct rv_reactor {
 	const char		*name;
 	const char		*description;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
+	struct list_head	list;
+	/* protected by the monitor interface lock */
+	int			counter;
 };
 #endif
 
@@ -101,7 +104,7 @@ struct rv_monitor {
 	void			(*disable)(void);
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
-	struct rv_reactor_def	*rdef;
+	struct rv_reactor	*reactor;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
 	bool			reacting;
 #endif
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index f039ec1c9156..8c38f9dd41bc 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -23,15 +23,6 @@ struct rv_interface {
 extern struct mutex rv_interface_lock;
 extern struct list_head rv_monitors_list;
 
-#ifdef CONFIG_RV_REACTORS
-struct rv_reactor_def {
-	struct list_head	list;
-	struct rv_reactor	*reactor;
-	/* protected by the monitor interface lock */
-	int			counter;
-};
-#endif
-
 struct dentry *get_monitors_root(void);
 int rv_disable_monitor(struct rv_monitor *mon);
 int rv_enable_monitor(struct rv_monitor *mon);
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 7cc620a1be1a..2c7909e6d0e7 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -70,12 +70,12 @@
  */
 static LIST_HEAD(rv_reactors_list);
 
-static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
+static struct rv_reactor *get_reactor_rdef_by_name(char *name)
 {
-	struct rv_reactor_def *r;
+	struct rv_reactor *r;
 
 	list_for_each_entry(r, &rv_reactors_list, list) {
-		if (strcmp(name, r->reactor->name) == 0)
+		if (strcmp(name, r->name) == 0)
 			return r;
 	}
 	return NULL;
@@ -86,9 +86,9 @@ static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
  */
 static int reactors_show(struct seq_file *m, void *p)
 {
-	struct rv_reactor_def *rea_def = p;
+	struct rv_reactor *reactor = p;
 
-	seq_printf(m, "%s\n", rea_def->reactor->name);
+	seq_printf(m, "%s\n", reactor->name);
 	return 0;
 }
 
@@ -139,12 +139,12 @@ static const struct file_operations available_reactors_ops = {
 static int monitor_reactor_show(struct seq_file *m, void *p)
 {
 	struct rv_monitor *mon = m->private;
-	struct rv_reactor_def *rdef = p;
+	struct rv_reactor *reactor = p;
 
-	if (mon->rdef == rdef)
-		seq_printf(m, "[%s]\n", rdef->reactor->name);
+	if (mon->reactor == reactor)
+		seq_printf(m, "[%s]\n", reactor->name);
 	else
-		seq_printf(m, "%s\n", rdef->reactor->name);
+		seq_printf(m, "%s\n", reactor->name);
 	return 0;
 }
 
@@ -159,13 +159,13 @@ static const struct seq_operations monitor_reactors_seq_ops = {
 };
 
 static void monitor_swap_reactors_single(struct rv_monitor *mon,
-					 struct rv_reactor_def *rdef,
+					 struct rv_reactor *reactor,
 					 bool reacting, bool nested)
 {
 	bool monitor_enabled;
 
 	/* nothing to do */
-	if (mon->rdef == rdef)
+	if (mon->reactor == reactor)
 		return;
 
 	monitor_enabled = mon->enabled;
@@ -173,12 +173,12 @@ static void monitor_swap_reactors_single(struct rv_monitor *mon,
 		rv_disable_monitor(mon);
 
 	/* swap reactor's usage */
-	mon->rdef->counter--;
-	rdef->counter++;
+	mon->reactor->counter--;
+	reactor->counter++;
 
-	mon->rdef = rdef;
+	mon->reactor = reactor;
 	mon->reacting = reacting;
-	mon->react = rdef->reactor->react;
+	mon->react = reactor->react;
 
 	/* enable only once if iterating through a container */
 	if (monitor_enabled && !nested)
@@ -186,7 +186,7 @@ static void monitor_swap_reactors_single(struct rv_monitor *mon,
 }
 
 static void monitor_swap_reactors(struct rv_monitor *mon,
-				  struct rv_reactor_def *rdef, bool reacting)
+				  struct rv_reactor *reactor, bool reacting)
 {
 	struct rv_monitor *p = mon;
 
@@ -194,7 +194,7 @@ static void monitor_swap_reactors(struct rv_monitor *mon,
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
 			if (p->parent != mon)
 				break;
-			monitor_swap_reactors_single(p, rdef, reacting, true);
+			monitor_swap_reactors_single(p, reactor, reacting, true);
 		}
 	/*
 	 * This call enables and disables the monitor if they were active.
@@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct rv_monitor *mon,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mon, rdef, reacting, false);
+	monitor_swap_reactors_single(mon, reactor, reacting, false);
 }
 
 static ssize_t
@@ -211,7 +211,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 {
 	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
 	struct rv_monitor *mon;
-	struct rv_reactor_def *rdef;
+	struct rv_reactor *reactor;
 	struct seq_file *seq_f;
 	int retval = -EINVAL;
 	bool enable;
@@ -243,16 +243,16 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 
 	retval = -EINVAL;
 
-	list_for_each_entry(rdef, &rv_reactors_list, list) {
-		if (strcmp(ptr, rdef->reactor->name) != 0)
+	list_for_each_entry(reactor, &rv_reactors_list, list) {
+		if (strcmp(ptr, reactor->name) != 0)
 			continue;
 
-		if (rdef == get_reactor_rdef_by_name("nop"))
+		if (strcmp(reactor->name, "nop"))
 			enable = false;
 		else
 			enable = true;
 
-		monitor_swap_reactors(mon, rdef, enable);
+		monitor_swap_reactors(mon, reactor, enable);
 
 		retval = count;
 		break;
@@ -299,23 +299,16 @@ static const struct file_operations monitor_reactors_ops = {
 
 static int __rv_register_reactor(struct rv_reactor *reactor)
 {
-	struct rv_reactor_def *r;
+	struct rv_reactor *r;
 
 	list_for_each_entry(r, &rv_reactors_list, list) {
-		if (strcmp(reactor->name, r->reactor->name) == 0) {
+		if (strcmp(reactor->name, r->name) == 0) {
 			pr_info("Reactor %s is already registered\n", reactor->name);
 			return -EINVAL;
 		}
 	}
 
-	r = kzalloc(sizeof(struct rv_reactor_def), GFP_KERNEL);
-	if (!r)
-		return -ENOMEM;
-
-	r->reactor = reactor;
-	r->counter = 0;
-
-	list_add_tail(&r->list, &rv_reactors_list);
+	list_add_tail(&reactor->list, &rv_reactors_list);
 
 	return 0;
 }
@@ -350,26 +343,19 @@ int rv_register_reactor(struct rv_reactor *reactor)
  */
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
-	struct rv_reactor_def *ptr, *next;
 	int ret = 0;
 
 	mutex_lock(&rv_interface_lock);
 
-	list_for_each_entry_safe(ptr, next, &rv_reactors_list, list) {
-		if (strcmp(reactor->name, ptr->reactor->name) == 0) {
-
-			if (!ptr->counter) {
-				list_del(&ptr->list);
-			} else {
-				printk(KERN_WARNING
-				       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
-				       ptr->reactor->name, ptr->counter);
-				printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
-				       ptr->reactor->name);
-				ret = -EBUSY;
-				break;
-			}
-		}
+	if (!reactor->counter) {
+		list_del(&reactor->list);
+	} else {
+		printk(KERN_WARNING
+		       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
+		       reactor->name, reactor->counter);
+		printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
+		       reactor->name);
+		ret = -EBUSY;
 	}
 
 	mutex_unlock(&rv_interface_lock);
@@ -469,8 +455,8 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	/*
 	 * Configure as the rv_nop reactor.
 	 */
-	mon->rdef = get_reactor_rdef_by_name("nop");
-	mon->rdef->counter++;
+	mon->reactor = get_reactor_rdef_by_name("nop");
+	mon->reactor->counter++;
 	mon->reacting = false;
 
 	return 0;
@@ -483,8 +469,8 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 void reactor_cleanup_monitor(struct rv_monitor *mon)
 {
 	lockdep_assert_held(&rv_interface_lock);
-	mon->rdef->counter--;
-	WARN_ON_ONCE(mon->rdef->counter < 0);
+	mon->reactor->counter--;
+	WARN_ON_ONCE(mon->reactor->counter < 0);
 }
 
 /*
-- 
2.47.2



