Return-Path: <linux-kernel+bounces-812728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DBB53BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70085B62779
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F9223DD6;
	Thu, 11 Sep 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjTxpxW8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9B2DC79E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616800; cv=none; b=SqNCiPQ/6B8doyjGdwB22yQbsyKTHPgPko4LgmFRzsyef/QnbUY3wDsz2069P3KUgwiTQIA5aAAIwoLcvk0l2CLl5IfrM0FoU6p5WDvhgqPJDMeWvqu/jrrLT2QY0UKOOajAyolx3dY5Oe2BreldlY1cRAYL32qqA8lx3CixMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616800; c=relaxed/simple;
	bh=I+ZaL0GFhXVlh/iPRMuK9rilRvA8hUk6CqIFpq/by4s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PPnH2qGRr61Zg3Kve9JGryt4XBk+fFJdn26qRU/MOAMharvKWfx0IaY9Y7otOTSWYkEix7hciK7OQXWJt3CoQ04rXX97E8RR8bKZd2V2WqCZ7KqZwEWAefj4ZGcgv4MHev1UhMg/qRYJymPRqkHQmJzOEq1vrIg1tG+qL7G7mbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjTxpxW8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c9e2213f8so10797395ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757616798; x=1758221598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbfHHtJJPQLXr57eFwRJeaJKX+PpqcgTGzEsr7kOlM0=;
        b=tjTxpxW8qdtjPzWfB4FG3Vm0FignMzGMbxPXaMu2oMZyD5RXRb1YWOPPC05+ZbDX5Z
         9wfWHB5fG3HdddpBLyPnA1oRJCw6WSK9RusVxjArAIwIZRXEtfk2zwBYB2YQRd/LOLv6
         zBfUu52crLxPIMAFazozPXMR40N7fY2uBxCyFXYGFLUsKFHgbZMDS+4oP4qVzsD7eAoR
         wrwxHdmBRIT8F2q4itE1JV5sXoSyCOIoLr8uVaEkzbTT4r55jJXAbj2dZhxGvD1pZd2u
         FPw2p9AYP05CuJOnyDbh8S9kSV60ZSQ2jZ0Ic1GBUMZhvogGgaU9RlSgtitxBNiBNuYI
         PPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616798; x=1758221598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbfHHtJJPQLXr57eFwRJeaJKX+PpqcgTGzEsr7kOlM0=;
        b=b+2xmzOXoRx0UXH5B/FbNKYGc5WuHNqTK0O66Al57jbjN4DzntWLKhswB3orpGbFKO
         YxrBpBiXMIuBe6lFCENwk1YFd+/C72qNqM/aghI0+FZS94gBC6QEQDYeNum9KXkfGR+k
         t14H4BVfeIWe5Trf/382oRAASJX+4NZ4gpFU/OSuUCNKNqbsUILJ+133iCWV1SaWvhp4
         Hbk0K+6vNHVgwJblGeVHNvTiNzvf2CJMi8qEcvpcA7sP6XIifyatYNeN6bH/BLeSl4Z7
         uZ+GP71oSUxPTvzE+rQKP2Pgg42/DGNULBwXtWtE2SMdPWCCjxaYHJ5SR5P/2639OiTF
         V62g==
X-Forwarded-Encrypted: i=1; AJvYcCWXMI2JuzmN0li1upZAHjqSUCELsvhAAkqumQunpGsb9PiDN7wx4RFvNArBVHd/njTlR1fvulQKNGKVoP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDwx23U9WGflNZ7uoFFelVg3uq200Y71+6joiW/hL++ekxwFo
	SqFlwngm3SwuvwFkvwZvM+vHeonqSQ171akJ2W3UPiCOk4AL81l0dBeM/viVh3GYdgUTKV45U1E
	4Yp5NFX4k7jtKHQ==
X-Google-Smtp-Source: AGHT+IHDdcC7wlpNAANKDP2xoezTHPI0Ss2Dq53dIld4QkKZYC0E5Fr5Gjj5PhRiCRSrvacqTSTGgI4SKueNKg==
X-Received: from plly20.prod.google.com ([2002:a17:902:7c94:b0:24c:829d:8a50])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea09:b0:248:a4e2:e6d6 with SMTP id d9443c01a7336-25d268660d4mr3772315ad.39.1757616797842;
 Thu, 11 Sep 2025 11:53:17 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:53:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911185314.2377124-1-wusamuel@google.com>
Subject: [PATCH v4] PM: Support aborting sleep during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At the start of suspend and hibernate, filesystems will sync to save the
current state of the device. However, the long tail of the filesystem
sync can take upwards of 25 seconds. If during this filesystem sync
there is some wakeup or abort signal, it will not be processed until the
sync is complete; from a user's perspective, this looks like the device
is unresponsive to any form of input.

This patch adds functionality to handle a sleep abort signal when in
the filesystem sync phase of suspend or hibernate. This topic was first
discussed specifically for suspend by Saravana Kannan at LPC 2024 [1],
where the general consensus was to allow filesystem sync on a parallel
thread. The same logic applies to both suspend and hibernate code paths.

There is extra care needed to account for back-to-back sleeps while
still maintaining functionality to immediately abort during the
filesystem sync stage.

This patch handles this by serializing the filesystem sync sequence with
an invariant; a subsequent sleep's filesystem sync operation will only
start when the previous sleep's filesystem sync has finished. While
waiting for the previous sleep's filesystem sync to finish, the
subsequent sleep will still abort early if a wakeup event is triggered,
solving the original issue of filesystem sync blocking abort.

[1]: https://lpc.events/event/18/contributions/1845/

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
Changes in v4:
- Removed patch 1/3 of v3 as it is already picked up on linux-pm
- Squashed patches 2/3 and 3/3 from v3 into this single patch
- Added abort during fs_sync functionality to hibernate in addition to suspend
- Moved variables and functions for abort from power/suspend.c to power/main.c
- Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
- Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
- v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamuel@google.com/

Changes in v3:
- Split v2 patch into 3 patches
- Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condition
- Updated documentation and comments within kernel/power/suspend.c
- v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamuel@google.com/

Changes in v2:
- Added documentation for suspend_abort_fs_sync()
- Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration static
- v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamuel@google.com

 drivers/base/power/wakeup.c |  8 +++++
 include/linux/suspend.h     |  4 +++
 kernel/power/hibernate.c    |  5 ++-
 kernel/power/main.c         | 70 +++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c      |  7 ++--
 5 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..daf07ab7ac3f 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 
 	/* Increment the counter of events in progress. */
 	cec = atomic_inc_return(&combined_event_count);
+	/*
+	 * wakeup_source_activate() aborts sleep only if events_check_enabled
+	 * is set (see pm_wakeup_pending()). Similarly, abort sleep during
+	 * fs_sync only if events_check_enabled is set.
+	 */
+	if (events_check_enabled)
+		abort_sleep_during_fs_sync();
 
 	trace_wakeup_source_activate(ws->name, cec);
 }
@@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 void pm_system_wakeup(void)
 {
 	atomic_inc(&pm_abort_suspend);
+	abort_sleep_during_fs_sync();
 	s2idle_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..c961bdb00bb6 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -444,6 +444,8 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void abort_sleep_during_fs_sync(void);
+extern int pm_sleep_fs_sync(void);
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
 void pm_restrict_gfp_mask(void);
@@ -499,6 +501,8 @@ static inline void pm_restrict_gfp_mask(void) {}
 static inline void pm_restore_gfp_mask(void) {}
 
 static inline void ksys_sync_helper(void) {}
+static inline abort_sleep_during_fs_sync(void) {}
+static inline int pm_sleep_fs_sync(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab453823..651dcd768644 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -811,7 +811,10 @@ int hibernate(void)
 	if (error)
 		goto Restore;
 
-	ksys_sync_helper();
+	error = pm_sleep_fs_sync();
+	if (error)
+		goto Restore;
+
 	if (filesystem_freeze_enabled)
 		filesystems_freeze();
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3cf2d7e72567..38b1de295cfe 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -570,6 +570,76 @@ bool pm_sleep_transition_in_progress(void)
 {
 	return pm_suspend_in_progress() || hibernation_in_progress();
 }
+
+static bool pm_sleep_fs_sync_queued;
+static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
+static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
+
+/**
+ * abort_sleep_during_fs_sync - Abort fs_sync to abort sleep early
+ *
+ * This function aborts the fs_sync stage of suspend/hibernate so that
+ * suspend/hibernate itself can be aborted early.
+ */
+void abort_sleep_during_fs_sync(void)
+{
+	spin_lock(&pm_sleep_fs_sync_lock);
+	complete(&pm_sleep_fs_sync_complete);
+	spin_unlock(&pm_sleep_fs_sync_lock);
+}
+
+static void sync_filesystems_fn(struct work_struct *work)
+{
+	ksys_sync_helper();
+
+	spin_lock(&pm_sleep_fs_sync_lock);
+	pm_sleep_fs_sync_queued = false;
+	complete(&pm_sleep_fs_sync_complete);
+	spin_unlock(&pm_sleep_fs_sync_lock);
+}
+static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
+
+/**
+ * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
+ *
+ * Return 0 on successful file system sync, otherwise returns -EBUSY if file
+ * system sync was aborted.
+ */
+int pm_sleep_fs_sync(void)
+{
+	bool need_pm_sleep_fs_sync_requeue;
+
+Start_fs_sync:
+	spin_lock(&pm_sleep_fs_sync_lock);
+	reinit_completion(&pm_sleep_fs_sync_complete);
+	/*
+	 * Handle the case where a sleep immediately follows a previous sleep
+	 * that was aborted during fs_sync. In this case, wait for the previous
+	 * filesystem sync to finish. Then do another filesystem sync so any
+	 * subsequent filesystem changes are synced before sleeping.
+	 */
+	if (pm_sleep_fs_sync_queued) {
+		need_pm_sleep_fs_sync_requeue = true;
+	} else {
+		need_pm_sleep_fs_sync_requeue = false;
+		pm_sleep_fs_sync_queued = true;
+		schedule_work(&sync_filesystems);
+	}
+	spin_unlock(&pm_sleep_fs_sync_lock);
+
+	/*
+	 * Completion is triggered by fs_sync finishing or an abort sleep
+	 * signal, whichever comes first
+	 */
+	wait_for_completion(&pm_sleep_fs_sync_complete);
+	if (pm_wakeup_pending())
+		return -EBUSY;
+	if (need_pm_sleep_fs_sync_requeue)
+		goto Start_fs_sync;
+
+	return 0;
+}
+
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..c019a4396c1f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -588,14 +589,16 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	pm_wakeup_clear(0);
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = pm_sleep_fs_sync();
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
2.51.0.384.g4c02a37b29-goog


