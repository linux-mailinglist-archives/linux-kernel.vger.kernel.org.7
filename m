Return-Path: <linux-kernel+bounces-746351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289CDB125AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AAD587B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930826981C;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs+VwZ48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF30261581
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475662; cv=none; b=UFQ5IItPzkDfKP6Q+ew9PpNpjbWqSnaySpDB5YNJIXOx/lMhRstxpvnx2y0hh/cdeeID/1hKuKzoM9Jgd5pdlG/4YxU0FDD5zEv0frtLB4mMdLfcPPw0KW7XK7EgwHpYpKPIqycc/8+j0Jf/SRUxvjinwlFAQtKOCn99PQyci2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475662; c=relaxed/simple;
	bh=Z6cQujRZpzoUyq30TVQ5FlDuRLcQ+CsV3Q3ydT4Kitg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KUoVl1PraUHsVfu+OQbKxCurmHEAeGDVHUXLxy7cNYctY71M0YRpjx67+3+TEqir5LPmSlDhW7f3nHju2/DqiWyS6OohvtrqmUQ+joOA9UR+Dsf+7SfNZGX+HRLVi0yuXnNlx2DYhZ3fSNmaqO/dKvwmJg1fIjb+sBFjdSllNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs+VwZ48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F60C4CEF4;
	Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475662;
	bh=Z6cQujRZpzoUyq30TVQ5FlDuRLcQ+CsV3Q3ydT4Kitg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=bs+VwZ48/4TLM/FAsSgNTR1sznJQwdqbmUNPN76Gm/5Q3wYWqhcKEoouYnNrW+rKQ
	 6d2y18+LgpkqdNK/GqAvNBmkOJ99yy+pM/5BmB99WXrhr1DjEpbzJ02BNBEq7iYyI2
	 WvymFLV5K/PkMY8ogxACul+IZNiYWeXbUV0oyulVKBgV+Q0xnxpTdNgMxV52qwEfJB
	 JZHuNkx4L/RtSyCKOkewmcOZpBcXpOfT5VulPDQ4xE/BnP8WPnQGC5B1hTGBy+C6Ml
	 tFdw3jO4byMXLB3DoDxuCdD9mvp92NiXbAD4jJuAD3ZTl7VPJzwhDS6VE69IH3/Kz8
	 D5buTryQ8ExuQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7c-00000001Qns-0YbC;
	Fri, 25 Jul 2025 16:34:28 -0400
Message-ID: <20250725203427.982046449@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 24/25] rv: Remove rv_reactors reference counter
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

rv_reactor has a reference counter to ensure it is not removed while
monitors are still using it.

However, this is futile, as __exit functions are not expected to fail and
will proceed normally despite rv_unregister_reactor() returning an error.

At the moment, reactors do not support being built as modules, therefore
they are never removed and the reference counters are not necessary.

If we support building RV reactors as modules in the future, kernel
module's centralized facilities such as try_module_get(), module_put() or
MODULE_SOFTDEP should be used instead of this custom implementation.

Remove this reference counter.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/bb946398436a5e17fb0f5b842ef3313c02291852.1753378331.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h            |  2 --
 kernel/trace/rv/rv.c          |  1 -
 kernel/trace/rv/rv.h          |  6 ------
 kernel/trace/rv/rv_reactors.c | 33 ++-------------------------------
 4 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index c22c9b8c1567..2f867d6f72ba 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -91,8 +91,6 @@ struct rv_reactor {
 	const char		*description;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
 	struct list_head	list;
-	/* protected by the monitor interface lock */
-	int			counter;
 };
 #endif
 
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c0be2fdc52d..6c8498743b98 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -769,7 +769,6 @@ static const struct file_operations monitoring_on_fops = {
 
 static void destroy_monitor_dir(struct rv_monitor *mon)
 {
-	reactor_cleanup_monitor(mon);
 	rv_remove(mon->root_d);
 }
 
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 8c38f9dd41bc..1485a70c1bf4 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -31,7 +31,6 @@ bool rv_is_nested_monitor(struct rv_monitor *mon);
 
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor *mon);
-void reactor_cleanup_monitor(struct rv_monitor *mon);
 int init_rv_reactors(struct dentry *root_dir);
 #else
 static inline int reactor_populate_monitor(struct rv_monitor *mon)
@@ -39,11 +38,6 @@ static inline int reactor_populate_monitor(struct rv_monitor *mon)
 	return 0;
 }
 
-static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
-{
-	return;
-}
-
 static inline int init_rv_reactors(struct dentry *root_dir)
 {
 	return 0;
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2c7909e6d0e7..a8e849e6cd85 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -172,10 +172,6 @@ static void monitor_swap_reactors_single(struct rv_monitor *mon,
 	if (monitor_enabled)
 		rv_disable_monitor(mon);
 
-	/* swap reactor's usage */
-	mon->reactor->counter--;
-	reactor->counter++;
-
 	mon->reactor = reactor;
 	mon->reacting = reacting;
 	mon->react = reactor->react;
@@ -343,23 +339,10 @@ int rv_register_reactor(struct rv_reactor *reactor)
  */
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
-	int ret = 0;
-
 	mutex_lock(&rv_interface_lock);
-
-	if (!reactor->counter) {
-		list_del(&reactor->list);
-	} else {
-		printk(KERN_WARNING
-		       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
-		       reactor->name, reactor->counter);
-		printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
-		       reactor->name);
-		ret = -EBUSY;
-	}
-
+	list_del(&reactor->list);
 	mutex_unlock(&rv_interface_lock);
-	return ret;
+	return 0;
 }
 
 /*
@@ -456,23 +439,11 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	 * Configure as the rv_nop reactor.
 	 */
 	mon->reactor = get_reactor_rdef_by_name("nop");
-	mon->reactor->counter++;
 	mon->reacting = false;
 
 	return 0;
 }
 
-/**
- * reactor_cleanup_monitor - cleanup a monitor reference
- * @mon:       the monitor.
- */
-void reactor_cleanup_monitor(struct rv_monitor *mon)
-{
-	lockdep_assert_held(&rv_interface_lock);
-	mon->reactor->counter--;
-	WARN_ON_ONCE(mon->reactor->counter < 0);
-}
-
 /*
  * Nop reactor register
  */
-- 
2.47.2



