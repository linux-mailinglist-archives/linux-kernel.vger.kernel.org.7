Return-Path: <linux-kernel+bounces-746352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01510B125AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148A35879DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1126B751;
	Fri, 25 Jul 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieQp1JpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45132261595
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475662; cv=none; b=grHcBqIZC+DXysB1G2cOBgJmerY+IdMx22+9oVykIqcYUlCtYL79nxO5d/qaLU17wYVZ4wGqyTTii9f/+72B1EdWDxeeJxthPsrzR9OtLcXLLdJ8PDpHEm6rhh4v86GmPFAP+a4D6l54skAj7gw7NuCwKRRMwAzSSaTAcm/8nRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475662; c=relaxed/simple;
	bh=BgRRGmQ+7MJ1KOKcah+kRc9McDNBvacvKTwrBrrVM6o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Nsm76O67h82RgemByHmPhzsQRByHzBMsD4rXLZOrf8nxr1h5BScfN9HfP4Hx16nHsBZEB8NpuoH/r2zd8zYnJjeCbJH0/cIzxI6IxMqJxkaWyOnTS71tDUE9ppbWgwvvFosR7nFqiqZdl7GhgiLLpR2yB1ZFyfE+0nmnDoqh010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieQp1JpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F71C4CEEF;
	Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475661;
	bh=BgRRGmQ+7MJ1KOKcah+kRc9McDNBvacvKTwrBrrVM6o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ieQp1JpCJojcuvfPJg5oRDmVxpw8aHCBr9WdGIhXWW9YeBlkGTtqjqb3OjIFQdzhI
	 sLJz6a4svLj66r0qAm9z/v28ktbSVB1eIrG5MokkX65swxqBqtYpAfwm+iZwHp9ah+
	 aSlRj+MPNd5WlpPRjQQ6dT38uAFhTvyBvSTQqDBLw0nQMwdar4kiPh4dx3BqTVe6pI
	 6xsFacWVebAVwUjbKK7ApRb1cVj2i+oF/1S8e/PlD9h4+f12OBV6O0tuoq1WQH7VMx
	 4Rp8/yLFLQaXQw5IrKG0Ps+0Iiolke5rjMEX2b35kmPbHguZ0ng+kiQcfFSxFvPQOc
	 w0T0/jNY3gQ8w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7b-00000001Qmr-3JW9;
	Fri, 25 Jul 2025 16:34:27 -0400
Message-ID: <20250725203427.645088485@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 22/25] rv: Merge struct rv_monitor_def into struct rv_monitor
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Each struct rv_monitor has a unique struct rv_monitor_def associated with
it. struct rv_monitor is statically allocated, while struct rv_monitor_def
is dynamically allocated.

This makes the code more complicated than it should be:

  - Lookup is required to get the associated rv_monitor_def from rv_monitor

  - Dynamic memory allocation is required for rv_monitor_def. This is
    harder to get right compared to static memory. For instance, there is
    an existing mistake: rv_unregister_monitor() does not free the memory
    allocated by rv_register_monitor(). This is fortunately not a real
    memory leak problem, as rv_unregister_monitor() is never called.

Simplify and merge rv_monitor_def into rv_monitor.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/194449c00f87945c207aab4c96920c75796a4f53.1753378331.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h            |   8 ++
 kernel/trace/rv/rv.c          | 211 +++++++++++++++-------------------
 kernel/trace/rv/rv.h          |  27 ++---
 kernel/trace/rv/rv_reactors.c |  62 +++++-----
 4 files changed, 140 insertions(+), 168 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 97baf58d88b2..dba53aecdfab 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,6 +7,9 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
+#include <linux/types.h>
+#include <linux/list.h>
+
 #define MAX_DA_NAME_LEN	32
 
 #ifdef CONFIG_RV
@@ -98,8 +101,13 @@ struct rv_monitor {
 	void			(*disable)(void);
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
+	struct rv_reactor_def	*rdef;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
+	bool			reacting;
 #endif
+	struct list_head	list;
+	struct rv_monitor	*parent;
+	struct dentry		*root_d;
 };
 
 bool rv_monitoring_on(void);
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 108429d16ec1..6c0be2fdc52d 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -210,9 +210,9 @@ void rv_put_task_monitor_slot(int slot)
  * Monitors with a parent are nested,
  * Monitors without a parent could be standalone or containers.
  */
-bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
+bool rv_is_nested_monitor(struct rv_monitor *mon)
 {
-	return mdef->parent != NULL;
+	return mon->parent != NULL;
 }
 
 /*
@@ -223,16 +223,16 @@ bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
  * for enable()/disable(). Use this condition to find empty containers.
  * Keep both conditions in case we have some non-compliant containers.
  */
-bool rv_is_container_monitor(struct rv_monitor_def *mdef)
+bool rv_is_container_monitor(struct rv_monitor *mon)
 {
-	struct rv_monitor_def *next;
+	struct rv_monitor *next;
 
-	if (list_is_last(&mdef->list, &rv_monitors_list))
+	if (list_is_last(&mon->list, &rv_monitors_list))
 		return false;
 
-	next = list_next_entry(mdef, list);
+	next = list_next_entry(mon, list);
 
-	return next->parent == mdef->monitor || !mdef->monitor->enable;
+	return next->parent == mon || !mon->enable;
 }
 
 /*
@@ -241,10 +241,10 @@ bool rv_is_container_monitor(struct rv_monitor_def *mdef)
 static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf, size_t count,
 					loff_t *ppos)
 {
-	struct rv_monitor_def *mdef = filp->private_data;
+	struct rv_monitor *mon = filp->private_data;
 	const char *buff;
 
-	buff = mdef->monitor->enabled ? "1\n" : "0\n";
+	buff = mon->enabled ? "1\n" : "0\n";
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
 }
@@ -252,14 +252,14 @@ static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf
 /*
  * __rv_disable_monitor - disabled an enabled monitor
  */
-static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
+static int __rv_disable_monitor(struct rv_monitor *mon, bool sync)
 {
 	lockdep_assert_held(&rv_interface_lock);
 
-	if (mdef->monitor->enabled) {
-		mdef->monitor->enabled = 0;
-		if (mdef->monitor->disable)
-			mdef->monitor->disable();
+	if (mon->enabled) {
+		mon->enabled = 0;
+		if (mon->disable)
+			mon->disable();
 
 		/*
 		 * Wait for the execution of all events to finish.
@@ -273,90 +273,90 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 	return 0;
 }
 
-static void rv_disable_single(struct rv_monitor_def *mdef)
+static void rv_disable_single(struct rv_monitor *mon)
 {
-	__rv_disable_monitor(mdef, true);
+	__rv_disable_monitor(mon, true);
 }
 
-static int rv_enable_single(struct rv_monitor_def *mdef)
+static int rv_enable_single(struct rv_monitor *mon)
 {
 	int retval;
 
 	lockdep_assert_held(&rv_interface_lock);
 
-	if (mdef->monitor->enabled)
+	if (mon->enabled)
 		return 0;
 
-	retval = mdef->monitor->enable();
+	retval = mon->enable();
 
 	if (!retval)
-		mdef->monitor->enabled = 1;
+		mon->enabled = 1;
 
 	return retval;
 }
 
-static void rv_disable_container(struct rv_monitor_def *mdef)
+static void rv_disable_container(struct rv_monitor *mon)
 {
-	struct rv_monitor_def *p = mdef;
+	struct rv_monitor *p = mon;
 	int enabled = 0;
 
 	list_for_each_entry_continue(p, &rv_monitors_list, list) {
-		if (p->parent != mdef->monitor)
+		if (p->parent != mon)
 			break;
 		enabled += __rv_disable_monitor(p, false);
 	}
 	if (enabled)
 		tracepoint_synchronize_unregister();
-	mdef->monitor->enabled = 0;
+	mon->enabled = 0;
 }
 
-static int rv_enable_container(struct rv_monitor_def *mdef)
+static int rv_enable_container(struct rv_monitor *mon)
 {
-	struct rv_monitor_def *p = mdef;
+	struct rv_monitor *p = mon;
 	int retval = 0;
 
 	list_for_each_entry_continue(p, &rv_monitors_list, list) {
-		if (retval || p->parent != mdef->monitor)
+		if (retval || p->parent != mon)
 			break;
 		retval = rv_enable_single(p);
 	}
 	if (retval)
-		rv_disable_container(mdef);
+		rv_disable_container(mon);
 	else
-		mdef->monitor->enabled = 1;
+		mon->enabled = 1;
 	return retval;
 }
 
 /**
  * rv_disable_monitor - disable a given runtime monitor
- * @mdef: Pointer to the monitor definition structure.
+ * @mon: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
-int rv_disable_monitor(struct rv_monitor_def *mdef)
+int rv_disable_monitor(struct rv_monitor *mon)
 {
-	if (rv_is_container_monitor(mdef))
-		rv_disable_container(mdef);
+	if (rv_is_container_monitor(mon))
+		rv_disable_container(mon);
 	else
-		rv_disable_single(mdef);
+		rv_disable_single(mon);
 
 	return 0;
 }
 
 /**
  * rv_enable_monitor - enable a given runtime monitor
- * @mdef: Pointer to the monitor definition structure.
+ * @mon: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */
-int rv_enable_monitor(struct rv_monitor_def *mdef)
+int rv_enable_monitor(struct rv_monitor *mon)
 {
 	int retval;
 
-	if (rv_is_container_monitor(mdef))
-		retval = rv_enable_container(mdef);
+	if (rv_is_container_monitor(mon))
+		retval = rv_enable_container(mon);
 	else
-		retval = rv_enable_single(mdef);
+		retval = rv_enable_single(mon);
 
 	return retval;
 }
@@ -367,7 +367,7 @@ int rv_enable_monitor(struct rv_monitor_def *mdef)
 static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
 					 size_t count, loff_t *ppos)
 {
-	struct rv_monitor_def *mdef = filp->private_data;
+	struct rv_monitor *mon = filp->private_data;
 	int retval;
 	bool val;
 
@@ -378,9 +378,9 @@ static ssize_t monitor_enable_write_data(struct file *filp, const char __user *u
 	mutex_lock(&rv_interface_lock);
 
 	if (val)
-		retval = rv_enable_monitor(mdef);
+		retval = rv_enable_monitor(mon);
 	else
-		retval = rv_disable_monitor(mdef);
+		retval = rv_disable_monitor(mon);
 
 	mutex_unlock(&rv_interface_lock);
 
@@ -399,12 +399,12 @@ static const struct file_operations interface_enable_fops = {
 static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf, size_t count,
 				      loff_t *ppos)
 {
-	struct rv_monitor_def *mdef = filp->private_data;
+	struct rv_monitor *mon = filp->private_data;
 	char buff[256];
 
 	memset(buff, 0, sizeof(buff));
 
-	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor->description);
+	snprintf(buff, sizeof(buff), "%s\n", mon->description);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
 }
@@ -419,37 +419,37 @@ static const struct file_operations interface_desc_fops = {
  * the monitor dir, where the specific options of the monitor
  * are exposed.
  */
-static int create_monitor_dir(struct rv_monitor_def *mdef, struct rv_monitor_def *parent)
+static int create_monitor_dir(struct rv_monitor *mon, struct rv_monitor *parent)
 {
 	struct dentry *root = parent ? parent->root_d : get_monitors_root();
-	const char *name = mdef->monitor->name;
+	const char *name = mon->name;
 	struct dentry *tmp;
 	int retval;
 
-	mdef->root_d = rv_create_dir(name, root);
-	if (!mdef->root_d)
+	mon->root_d = rv_create_dir(name, root);
+	if (!mon->root_d)
 		return -ENOMEM;
 
-	tmp = rv_create_file("enable", RV_MODE_WRITE, mdef->root_d, mdef, &interface_enable_fops);
+	tmp = rv_create_file("enable", RV_MODE_WRITE, mon->root_d, mon, &interface_enable_fops);
 	if (!tmp) {
 		retval = -ENOMEM;
 		goto out_remove_root;
 	}
 
-	tmp = rv_create_file("desc", RV_MODE_READ, mdef->root_d, mdef, &interface_desc_fops);
+	tmp = rv_create_file("desc", RV_MODE_READ, mon->root_d, mon, &interface_desc_fops);
 	if (!tmp) {
 		retval = -ENOMEM;
 		goto out_remove_root;
 	}
 
-	retval = reactor_populate_monitor(mdef);
+	retval = reactor_populate_monitor(mon);
 	if (retval)
 		goto out_remove_root;
 
 	return 0;
 
 out_remove_root:
-	rv_remove(mdef->root_d);
+	rv_remove(mon->root_d);
 	return retval;
 }
 
@@ -458,13 +458,12 @@ static int create_monitor_dir(struct rv_monitor_def *mdef, struct rv_monitor_def
  */
 static int monitors_show(struct seq_file *m, void *p)
 {
-	struct rv_monitor_def *mon_def = p;
+	struct rv_monitor *mon = p;
 
-	if (mon_def->parent)
-		seq_printf(m, "%s:%s\n", mon_def->parent->name,
-			   mon_def->monitor->name);
+	if (mon->parent)
+		seq_printf(m, "%s:%s\n", mon->parent->name, mon->name);
 	else
-		seq_printf(m, "%s\n", mon_def->monitor->name);
+		seq_printf(m, "%s\n", mon->name);
 	return 0;
 }
 
@@ -496,13 +495,13 @@ static void *available_monitors_next(struct seq_file *m, void *p, loff_t *pos)
  */
 static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	struct rv_monitor_def *m_def = p;
+	struct rv_monitor *mon = p;
 
 	(*pos)++;
 
-	list_for_each_entry_continue(m_def, &rv_monitors_list, list) {
-		if (m_def->monitor->enabled)
-			return m_def;
+	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
+		if (mon->enabled)
+			return mon;
 	}
 
 	return NULL;
@@ -510,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor_def *m_def;
+	struct rv_monitor *mon;
 	loff_t l;
 
 	mutex_lock(&rv_interface_lock);
@@ -518,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 	if (list_empty(&rv_monitors_list))
 		return NULL;
 
-	m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
+	mon = list_entry(&rv_monitors_list, struct rv_monitor, list);
 
 	for (l = 0; l <= *pos; ) {
-		m_def = enabled_monitors_next(m, m_def, &l);
-		if (!m_def)
+		mon = enabled_monitors_next(m, mon, &l);
+		if (!mon)
 			break;
 	}
 
-	return m_def;
+	return mon;
 }
 
 /*
@@ -566,13 +565,13 @@ static const struct file_operations available_monitors_ops = {
  */
 static void disable_all_monitors(void)
 {
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 	int enabled = 0;
 
 	mutex_lock(&rv_interface_lock);
 
-	list_for_each_entry(mdef, &rv_monitors_list, list)
-		enabled += __rv_disable_monitor(mdef, false);
+	list_for_each_entry(mon, &rv_monitors_list, list)
+		enabled += __rv_disable_monitor(mon, false);
 
 	if (enabled) {
 		/*
@@ -598,7 +597,7 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 				      size_t count, loff_t *ppos)
 {
 	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 	int retval = -EINVAL;
 	bool enable = true;
 	char *ptr, *tmp;
@@ -633,17 +632,17 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 	if (tmp)
 		ptr = tmp+1;
 
-	list_for_each_entry(mdef, &rv_monitors_list, list) {
-		if (strcmp(ptr, mdef->monitor->name) != 0)
+	list_for_each_entry(mon, &rv_monitors_list, list) {
+		if (strcmp(ptr, mon->name) != 0)
 			continue;
 
 		/*
 		 * Monitor found!
 		 */
 		if (enable)
-			retval = rv_enable_monitor(mdef);
+			retval = rv_enable_monitor(mon);
 		else
-			retval = rv_disable_monitor(mdef);
+			retval = rv_disable_monitor(mon);
 
 		if (!retval)
 			retval = count;
@@ -702,11 +701,11 @@ static void turn_monitoring_off(void)
 
 static void reset_all_monitors(void)
 {
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 
-	list_for_each_entry(mdef, &rv_monitors_list, list) {
-		if (mdef->monitor->enabled && mdef->monitor->reset)
-			mdef->monitor->reset();
+	list_for_each_entry(mon, &rv_monitors_list, list) {
+		if (mon->enabled && mon->reset)
+			mon->reset();
 	}
 }
 
@@ -768,10 +767,10 @@ static const struct file_operations monitoring_on_fops = {
 	.read   = monitoring_on_read_data,
 };
 
-static void destroy_monitor_dir(struct rv_monitor_def *mdef)
+static void destroy_monitor_dir(struct rv_monitor *mon)
 {
-	reactor_cleanup_monitor(mdef);
-	rv_remove(mdef->root_d);
+	reactor_cleanup_monitor(mon);
+	rv_remove(mon->root_d);
 }
 
 /**
@@ -783,7 +782,7 @@ static void destroy_monitor_dir(struct rv_monitor_def *mdef)
  */
 int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 {
-	struct rv_monitor_def *r, *p = NULL;
+	struct rv_monitor *r;
 	int retval = 0;
 
 	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {
@@ -795,49 +794,31 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 	mutex_lock(&rv_interface_lock);
 
 	list_for_each_entry(r, &rv_monitors_list, list) {
-		if (strcmp(monitor->name, r->monitor->name) == 0) {
+		if (strcmp(monitor->name, r->name) == 0) {
 			pr_info("Monitor %s is already registered\n", monitor->name);
 			retval = -EEXIST;
 			goto out_unlock;
 		}
 	}
 
-	if (parent) {
-		list_for_each_entry(r, &rv_monitors_list, list) {
-			if (strcmp(parent->name, r->monitor->name) == 0) {
-				p = r;
-				break;
-			}
-		}
-	}
-
-	if (p && rv_is_nested_monitor(p)) {
+	if (parent && rv_is_nested_monitor(parent)) {
 		pr_info("Parent monitor %s is already nested, cannot nest further\n",
 			parent->name);
 		retval = -EINVAL;
 		goto out_unlock;
 	}
 
-	r = kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
-	if (!r) {
-		retval = -ENOMEM;
-		goto out_unlock;
-	}
-
-	r->monitor = monitor;
-	r->parent = parent;
+	monitor->parent = parent;
 
-	retval = create_monitor_dir(r, p);
-	if (retval) {
-		kfree(r);
-		goto out_unlock;
-	}
+	retval = create_monitor_dir(monitor, parent);
+	if (retval)
+		return retval;
 
 	/* keep children close to the parent for easier visualisation */
-	if (p)
-		list_add(&r->list, &p->list);
+	if (parent)
+		list_add(&monitor->list, &parent->list);
 	else
-		list_add_tail(&r->list, &rv_monitors_list);
+		list_add_tail(&monitor->list, &rv_monitors_list);
 
 out_unlock:
 	mutex_unlock(&rv_interface_lock);
@@ -852,17 +833,11 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
  */
 int rv_unregister_monitor(struct rv_monitor *monitor)
 {
-	struct rv_monitor_def *ptr, *next;
-
 	mutex_lock(&rv_interface_lock);
 
-	list_for_each_entry_safe(ptr, next, &rv_monitors_list, list) {
-		if (strcmp(monitor->name, ptr->monitor->name) == 0) {
-			rv_disable_monitor(ptr);
-			list_del(&ptr->list);
-			destroy_monitor_dir(ptr);
-		}
-	}
+	rv_disable_monitor(monitor);
+	list_del(&monitor->list);
+	destroy_monitor_dir(monitor);
 
 	mutex_unlock(&rv_interface_lock);
 	return 0;
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 873364094402..f039ec1c9156 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -32,34 +32,23 @@ struct rv_reactor_def {
 };
 #endif
 
-struct rv_monitor_def {
-	struct list_head	list;
-	struct rv_monitor	*monitor;
-	struct rv_monitor	*parent;
-	struct dentry		*root_d;
-#ifdef CONFIG_RV_REACTORS
-	struct rv_reactor_def	*rdef;
-	bool			reacting;
-#endif
-};
-
 struct dentry *get_monitors_root(void);
-int rv_disable_monitor(struct rv_monitor_def *mdef);
-int rv_enable_monitor(struct rv_monitor_def *mdef);
-bool rv_is_container_monitor(struct rv_monitor_def *mdef);
-bool rv_is_nested_monitor(struct rv_monitor_def *mdef);
+int rv_disable_monitor(struct rv_monitor *mon);
+int rv_enable_monitor(struct rv_monitor *mon);
+bool rv_is_container_monitor(struct rv_monitor *mon);
+bool rv_is_nested_monitor(struct rv_monitor *mon);
 
 #ifdef CONFIG_RV_REACTORS
-int reactor_populate_monitor(struct rv_monitor_def *mdef);
-void reactor_cleanup_monitor(struct rv_monitor_def *mdef);
+int reactor_populate_monitor(struct rv_monitor *mon);
+void reactor_cleanup_monitor(struct rv_monitor *mon);
 int init_rv_reactors(struct dentry *root_dir);
 #else
-static inline int reactor_populate_monitor(struct rv_monitor_def *mdef)
+static inline int reactor_populate_monitor(struct rv_monitor *mon)
 {
 	return 0;
 }
 
-static inline void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
+static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
 {
 	return;
 }
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 740603670dd1..7cc620a1be1a 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -138,10 +138,10 @@ static const struct file_operations available_reactors_ops = {
  */
 static int monitor_reactor_show(struct seq_file *m, void *p)
 {
-	struct rv_monitor_def *mdef = m->private;
+	struct rv_monitor *mon = m->private;
 	struct rv_reactor_def *rdef = p;
 
-	if (mdef->rdef == rdef)
+	if (mon->rdef == rdef)
 		seq_printf(m, "[%s]\n", rdef->reactor->name);
 	else
 		seq_printf(m, "%s\n", rdef->reactor->name);
@@ -158,41 +158,41 @@ static const struct seq_operations monitor_reactors_seq_ops = {
 	.show	= monitor_reactor_show
 };
 
-static void monitor_swap_reactors_single(struct rv_monitor_def *mdef,
+static void monitor_swap_reactors_single(struct rv_monitor *mon,
 					 struct rv_reactor_def *rdef,
 					 bool reacting, bool nested)
 {
 	bool monitor_enabled;
 
 	/* nothing to do */
-	if (mdef->rdef == rdef)
+	if (mon->rdef == rdef)
 		return;
 
-	monitor_enabled = mdef->monitor->enabled;
+	monitor_enabled = mon->enabled;
 	if (monitor_enabled)
-		rv_disable_monitor(mdef);
+		rv_disable_monitor(mon);
 
 	/* swap reactor's usage */
-	mdef->rdef->counter--;
+	mon->rdef->counter--;
 	rdef->counter++;
 
-	mdef->rdef = rdef;
-	mdef->reacting = reacting;
-	mdef->monitor->react = rdef->reactor->react;
+	mon->rdef = rdef;
+	mon->reacting = reacting;
+	mon->react = rdef->reactor->react;
 
 	/* enable only once if iterating through a container */
 	if (monitor_enabled && !nested)
-		rv_enable_monitor(mdef);
+		rv_enable_monitor(mon);
 }
 
-static void monitor_swap_reactors(struct rv_monitor_def *mdef,
+static void monitor_swap_reactors(struct rv_monitor *mon,
 				  struct rv_reactor_def *rdef, bool reacting)
 {
-	struct rv_monitor_def *p = mdef;
+	struct rv_monitor *p = mon;
 
-	if (rv_is_container_monitor(mdef))
+	if (rv_is_container_monitor(mon))
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
-			if (p->parent != mdef->monitor)
+			if (p->parent != mon)
 				break;
 			monitor_swap_reactors_single(p, rdef, reacting, true);
 		}
@@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct rv_monitor_def *mdef,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mdef, rdef, reacting, false);
+	monitor_swap_reactors_single(mon, rdef, reacting, false);
 }
 
 static ssize_t
@@ -210,7 +210,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 		      size_t count, loff_t *ppos)
 {
 	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 	struct rv_reactor_def *rdef;
 	struct seq_file *seq_f;
 	int retval = -EINVAL;
@@ -237,7 +237,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 	 * See monitor_reactors_open()
 	 */
 	seq_f = file->private_data;
-	mdef = seq_f->private;
+	mon = seq_f->private;
 
 	mutex_lock(&rv_interface_lock);
 
@@ -252,7 +252,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 		else
 			enable = true;
 
-		monitor_swap_reactors(mdef, rdef, enable);
+		monitor_swap_reactors(mon, rdef, enable);
 
 		retval = count;
 		break;
@@ -268,7 +268,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
  */
 static int monitor_reactors_open(struct inode *inode, struct file *file)
 {
-	struct rv_monitor_def *mdef = inode->i_private;
+	struct rv_monitor *mon = inode->i_private;
 	struct seq_file *seq_f;
 	int ret;
 
@@ -284,7 +284,7 @@ static int monitor_reactors_open(struct inode *inode, struct file *file)
 	/*
 	 * Copy the create file "private" data to the seq_file private data.
 	 */
-	seq_f->private = mdef;
+	seq_f->private = mon;
 
 	return 0;
 };
@@ -454,37 +454,37 @@ static const struct file_operations reacting_on_fops = {
 
 /**
  * reactor_populate_monitor - creates per monitor reactors file
- * @mdef:	monitor's definition.
+ * @mon:	The monitor.
  *
  * Returns 0 if successful, error otherwise.
  */
-int reactor_populate_monitor(struct rv_monitor_def *mdef)
+int reactor_populate_monitor(struct rv_monitor *mon)
 {
 	struct dentry *tmp;
 
-	tmp = rv_create_file("reactors", RV_MODE_WRITE, mdef->root_d, mdef, &monitor_reactors_ops);
+	tmp = rv_create_file("reactors", RV_MODE_WRITE, mon->root_d, mon, &monitor_reactors_ops);
 	if (!tmp)
 		return -ENOMEM;
 
 	/*
 	 * Configure as the rv_nop reactor.
 	 */
-	mdef->rdef = get_reactor_rdef_by_name("nop");
-	mdef->rdef->counter++;
-	mdef->reacting = false;
+	mon->rdef = get_reactor_rdef_by_name("nop");
+	mon->rdef->counter++;
+	mon->reacting = false;
 
 	return 0;
 }
 
 /**
  * reactor_cleanup_monitor - cleanup a monitor reference
- * @mdef:       monitor's definition.
+ * @mon:       the monitor.
  */
-void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
+void reactor_cleanup_monitor(struct rv_monitor *mon)
 {
 	lockdep_assert_held(&rv_interface_lock);
-	mdef->rdef->counter--;
-	WARN_ON_ONCE(mdef->rdef->counter < 0);
+	mon->rdef->counter--;
+	WARN_ON_ONCE(mon->rdef->counter < 0);
 }
 
 /*
-- 
2.47.2



