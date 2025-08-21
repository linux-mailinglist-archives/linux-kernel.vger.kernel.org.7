Return-Path: <linux-kernel+bounces-778736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01868B2E98B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE5C686BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A31E260C;
	Thu, 21 Aug 2025 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBQX82mx"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A11F4C89
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736980; cv=none; b=DMftfHJ3cLNBakizTCzPIVPh76c+Oh2RyaBFehfWA0/ZAlsWAJaLGr+k4G6pmMlVi6I5rgwmSvtFQs6tH5aX5Ulwrp8W1+C1LY9SI1wwtK8XKCPQ5h/WAJE/wxmhqAbM40+qPP29XO/nSDyeGnJnZNBaNCbv7xwvRulPDiiJ63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736980; c=relaxed/simple;
	bh=sjhaA9PbdBoDlY1RpJKGBmhcFyttPUwGKRyPs1/dR4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GwyXzroFNwT1tSQg58T3/VlMJlHu3HUDbuB+VqriXr8Zl0mDd2f/ARKht0ri9GNfglpWuIWT0eVuzdZWkqeSPnRLQcDptsuXf/38TSYgwWWoXAQWyK8S/L/Y2sUa/dekA+BwfcqZLZDxV9YoskLZgkimoUw+nWYx95ypBr4q6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBQX82mx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47253319b8so246747a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755736978; x=1756341778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEEDFLzdkJxsA5MFxQRzqAGK72ATrZ5Rpvk68XckeHw=;
        b=TBQX82mxYJap+ImMwrlzT4+VOE/XHCjF8KW0b0AOkpK2GRpwdQ9VhecoyGqSS0Pwv1
         iBgih4e39sDs1BrFXIQOOQ8SUQPXsLKGmjvoytK6OugW1RnaD+D5tbg8anhlb7OYV/jl
         wLv8ny8JG70FpW850lwnma+pL7O3gVPJACaBPAO10yvyA+DmbOB418LCAaNNDetEzOtT
         hWIMfNww/Uu2S9xnkjYqkoUjEskEB6I2E+jaY18fsjfQf5exZzVVMU2T9a2zomQckDSQ
         +Tx+G+xKdkLZjcHkL/o2bnXDKll8/psYHz0YA3gt1F1err44KRiR4Gx6fVLdEb3dS1+N
         S+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755736978; x=1756341778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEEDFLzdkJxsA5MFxQRzqAGK72ATrZ5Rpvk68XckeHw=;
        b=fYew5tfN+borKvPeluXNg5fJolk74NdOu1s1NtunIKzsN60cQkCRbM5AOvcRlph4mX
         FWSuiYtuRN1QDYJNtHzxJBc4Ncj283LIwDqtBWccU56BXv4TDeM6smxGBzgyEUVUeIyn
         Z/pCF2i0CwNIxpKjXwhCz4aajWrto2WXBWeN4yx1kY7Ekl8oJ8sUNlBEM6C/ge4kONf7
         FLBWx6xsU64cJzYzfXLF5Cp50RgMlngw7+voJO8mnBFjFp/WtWMnNJw8sh5ZrV55R17S
         n0tZ89aa3WNCkdnrvW3HoC1q+30QCYxtlFffA/f8ocvWW1cJkhqX9HVCFWJuawxFPI65
         54bg==
X-Forwarded-Encrypted: i=1; AJvYcCUMQA4aPo9cHyryHEr3/AIvgq0Uj+BIXYyFee7P90+OQaxmbbZAJs4NkeTEygC3+6kgGdweHLY1IYv8RdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mMDX48ncmafcM/PWlqZ8JCvQiKM0NUZ0vYWQFT/jF2pcWmFq
	ybCwY6f6dfDjXry/dYpRHMvGVzZ4UAL/orGH7jugWWy7vAzoD+XPMyZdCFptUQzh7Y4dsbBU8N4
	md3gq+LBtBdD3lA==
X-Google-Smtp-Source: AGHT+IFRX4CzFsLvpYCXo2bF56Mrj1NmbuOZ6oMEZbAVvMBhPKevVDn1/bBzt5cMhmFdXtqW2LvHc5LTpOh3YQ==
X-Received: from pgou3.prod.google.com ([2002:a63:b543:0:b0:b46:d6fa:dd42])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7488:b0:231:acae:1977 with SMTP id adf61e73a8af0-243307c1a45mr607077637.15.1755736978591;
 Wed, 20 Aug 2025 17:42:58 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:42:34 -0700
In-Reply-To: <20250821004237.2712312-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821004237.2712312-3-wusamuel@google.com>
Subject: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

At the start of suspend, filesystems will sync to save the current state
of the device. However, the long tail of the filesystem sync can take
upwards of 25 seconds. If during this filesystem sync there is some
wakeup or abort signal, it will not be processed until the sync is
complete; from a user's perspective, this looks like the device is
unresponsive to any form of input.

This patch adds functionality to handle a suspend abort signal when in
the filesystem sync phase of suspend. This topic was first discussed by
Saravana Kannan at LPC 2024 [1], where the general consensus was to
allow filesystem sync on a parallel thread.

[1]: https://lpc.events/event/18/contributions/1845/

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/wakeup.c |  8 +++++++
 include/linux/suspend.h     |  2 ++
 kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..af4cf3e6ba44 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 
 	/* Increment the counter of events in progress. */
 	cec = atomic_inc_return(&combined_event_count);
+	/*
+	 * wakeup_source_activate() aborts suspend only if events_check_enabled
+	 * is set (see pm_wakeup_pending()). Similarly, abort suspend during
+	 * fs_sync only if events_check_enabled is set.
+	 */
+	if (events_check_enabled)
+		suspend_abort_fs_sync();
 
 	trace_wakeup_source_activate(ws->name, cec);
 }
@@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 void pm_system_wakeup(void)
 {
 	atomic_inc(&pm_abort_suspend);
+	suspend_abort_fs_sync();
 	s2idle_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..68d2e8a7eeb1 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+extern void suspend_abort_fs_sync(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
 static inline void s2idle_wake(void) {}
+static inline void suspend_abort_fs_sync(void) {}
 #endif /* !CONFIG_SUSPEND */
 
 static inline bool pm_suspend_in_progress(void)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..edacd2a4143b 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
 }
 EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
+static DECLARE_COMPLETION(suspend_fs_sync_complete);
+
+/**
+ * suspend_abort_fs_sync - Abort fs_sync to abort suspend early
+ *
+ * This function aborts the fs_sync stage of suspend so that suspend itself can
+ * be aborted early.
+ */
+void suspend_abort_fs_sync(void)
+{
+	complete(&suspend_fs_sync_complete);
+}
+
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
 	unsigned int sleep_flags;
@@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
 	local_irq_enable();
 }
 
+static void sync_filesystems_fn(struct work_struct *work)
+{
+	ksys_sync_helper();
+	complete(&suspend_fs_sync_complete);
+}
+static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
+
+/**
+ * suspend_fs_sync_with_abort - Trigger fs_sync with ability to abort
+ *
+ * Return 0 on successful file system sync, otherwise returns -EBUSY if file
+ * system sync was aborted.
+ */
+static int suspend_fs_sync_with_abort(void)
+{
+	reinit_completion(&suspend_fs_sync_complete);
+	schedule_work(&sync_filesystems);
+	/*
+	 * Completion is triggered by fs_sync finishing or a suspend abort
+	 * signal, whichever comes first
+	 */
+	wait_for_completion(&suspend_fs_sync_complete);
+	if (pm_wakeup_pending())
+		return -EBUSY;
+
+	return 0;
+}
+
 /**
  * suspend_enter - Make the system enter the given sleep state.
  * @state: System sleep state to enter.
@@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	pm_wakeup_clear(0);
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = suspend_fs_sync_with_abort();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		if (error)
+			goto Unlock;
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-	pm_wakeup_clear(0);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
-- 
2.51.0.261.g7ce5a0a67e-goog


