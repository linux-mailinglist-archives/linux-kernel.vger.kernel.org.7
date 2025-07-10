Return-Path: <linux-kernel+bounces-724685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6563AFF5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A0A1BC89D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55167757EA;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA4ynyZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1239461
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107551; cv=none; b=KZSvSyjHzEqrMJfv3SONaxh2pfDGl9RpbeAA3cbpFLfA7UMxY9StoKqWM93KiaYB3EtyYWuRt5oWHJp88GxX7nzVV6fM0pC71HoITMiRDqPVEXvwTxRNMW51NjhTaOwTFA/Q97eW5eGKQfNmPaLLiVUUTHrmiyPzjGcIJZftDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107551; c=relaxed/simple;
	bh=lhMjg7Q3KKmBFsx5QTcDfSesOJ5ulW9KuZmBI84FTvo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ipNjsJ2OQUTGXiRYXSmpvPpeOwufnf5pNKk0G3KgxgVZJH5q9cHsgIHxwYCJjP+EMK+DcL5M8woXw2N+j8XE3vBbkfU74IdYi3YJiAPmRgEfOgSks1gvxhUhwjqcGAyhxPi/L938+6dMxwmUyD+dsxjpN9vPFszi3mvE/KtS0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA4ynyZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB74C4CEF6;
	Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107551;
	bh=lhMjg7Q3KKmBFsx5QTcDfSesOJ5ulW9KuZmBI84FTvo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kA4ynyZ7Ck6EPlGBC7Ev0Jru4GFCrlArpyuFS7DMkOG4nYZnzHMTHshZn9AGzT28e
	 ulBuBYYYmvJh8jycth/ZPsbmI5SO84S+KhbOvz5KZehkphIGhAUCLL+EVfmmUp+Cj0
	 x4fW9iAtlOHH6habEDcc9bAR2SoTkYxlGaNp8N+wYUQwgYY98CYpLmiFdpfrAYibqa
	 WnzLveXSxy7lDsLljptoZfvCdzdhx6KUqfQN5hi6Z+YQQAq2EoqfwujlWLtdsotVej
	 c9jC4cxf5Yhm4HsYbQfsELhYewapzMATEVFJeBd/lJmWTa8R7H4v2zHfyHigDudEA2
	 WLugU1o8R2Y0Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDI-00000001WOm-03os;
	Wed, 09 Jul 2025 20:32:36 -0400
Message-ID: <20250710003235.868462961@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:31:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nam Cao <namcao@linutronix.de>,
 Petr Mladek <pmladek@suse.com>
Subject: [for-next][PATCH 03/12] panic: Add vpanic()
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

vpanic() is useful for implementing runtime verification reactors. Add it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/panic.h |  3 +++
 kernel/panic.c        | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 4adc65766935..0332c6d6771f 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -3,6 +3,7 @@
 #define _LINUX_PANIC_H
 
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 
 struct pt_regs;
@@ -10,6 +11,8 @@ struct pt_regs;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
+__printf(1, 0)
+void vpanic(const char *fmt, va_list args) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560..6a1823c383d0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -309,13 +309,13 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 /**
  * panic - halt the system
  * @fmt: The text string to print
+ * @args: Arguments for the format string
  *
  * Display a message, then perform cleanups. This function never returns.
  */
-void panic(const char *fmt, ...)
+void vpanic(const char *fmt, va_list args)
 {
 	static char buf[1024];
-	va_list args;
 	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
@@ -366,9 +366,7 @@ void panic(const char *fmt, ...)
 
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len = vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
 
 	if (len && buf[len - 1] == '\n')
 		buf[len - 1] = '\0';
@@ -505,7 +503,17 @@ void panic(const char *fmt, ...)
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
+EXPORT_SYMBOL(vpanic);
 
+/* Identical to vpanic(), except it takes variadic arguments instead of va_list */
+void panic(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vpanic(fmt, args);
+	va_end(args);
+}
 EXPORT_SYMBOL(panic);
 
 #define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
-- 
2.47.2



