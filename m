Return-Path: <linux-kernel+bounces-777317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7894B2D81A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494CF3A9A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932D2DE713;
	Wed, 20 Aug 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVv3uHks"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7F2DE717
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681448; cv=none; b=kJZBjERv2YFkx7XMBYVVOdVb565pwAw9IvA28jRSx+RQ7Z6ruH4pCR5iCP9lLpiSveUTrzYE4f1JI0NDWRgv+0FVkMjMN5S+CY9S5m8Ct7urSLQkwNlHNvhp6DWF6g1Vkf3+xzk5zlEjRmwbVUj0J8cWaW/xa12ym5mSF8F6Yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681448; c=relaxed/simple;
	bh=AVK+ZaTp5UUp5Lbz1n6XQwEHZobaw2Hs/LEN3/YNdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0yJm7gZzQGsxDm8BJfvN50ocqrsqhQ7OVX6ihz9PXh+hU4bZ+NNsA1cxlFKsYKQGc7BBORuRJFzrGKCxV7Kb4vh2tpktSfktJyUd0jBwiJr1MpVM6LJ/pP9K78mue3HkBTF34m5s05l61k4Vwdn9EYXdOoMTvG6k8GTzcf0sJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVv3uHks; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2512701b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681446; x=1756286246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h46g9bpdq/IoFgv9mf+y6IAgS1SeEwgnc058+0D4RE=;
        b=CVv3uHks3nS+KnFOibsGDKEHvSjkhqVwFNsy6gtQMauXf+YBYZvdeu4QRG6rHz265V
         8EM6dDltbUiGgbGDb8mcj9rLd5phnwaialghq0uHFUCG0zmOvNIv2yd/reCnHvok//UY
         cW9ARjIN4B5gNw9e4rSzuzzLNFyydSXS10MWrCGBOJGDeFgT5Zy0DBXwgi6X3g8Zq+1h
         9576UgcIh+zIe5TZH8J4n+rTU2kdHwQJAMbv+gOO9SeDi2VN9v+ga32pwB/bp1+jt65Z
         64uy/bTAAIcpmerl22PYTQL4sbqXD21DQaoBAAhzYPVTI6XGKClVnx9Hryo75cScZg5p
         UIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681446; x=1756286246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h46g9bpdq/IoFgv9mf+y6IAgS1SeEwgnc058+0D4RE=;
        b=S0YdnTOHryJWzPf9O0PN5qLKD1AG2YhkVQyy/1cVEBSjLO1+EjBpUwUJvjqXMQMsYH
         BB3xpCrZcL9NfaknLJQjJhugtgWhVbEEFxx/m+G9k7vF9oz0dBjxoBJRu3LjAj3jGVNb
         MXzapIOGObhZLSaXKrS1SM6aeG2XjIJ402smLk3g4GwrkGQR40ud3Dibxn2QuM5Weyse
         u1IKpHNWp8mZnEajbl6Jgk2Y4e5ogE/wwO2JxXoInCN40M5/oEt+VBEr0wMLD9I25ha5
         ZljJ+xjXZmJ+9IASYAPZz/l9OW0Qulf+ZlDpACz1Dq6zMAA9hrn2upkOAS0Yl2tcSBDY
         NgqQ==
X-Gm-Message-State: AOJu0YxZENd/M7P1Y1A2qrVxdEY+nguiVbcNWpwn0IDa1Is5gi4CtA2c
	sA3fS0etYVUc8trcLmpN3KyVykxlxDiUbIQian6r+e9R85JuwNfkjWVO
X-Gm-Gg: ASbGnctGa1aq1SUtEQvH4BfrJyL8KNuel7Hga/AKNQUj8EDshHt3pR9RScgZ0FTloJb
	LbYmNgkUTlcwkSF1JfJuxXf2L1pCX67yde46uF/iblQ3kZQ8I4bKKafTprKFVUakbx1sgt7Ufm4
	osbOipRgwUm0tazmv02j0O8jCiD6yOfHCARuhp5YbPQEZk9DLqrOiuauC3X0sc3yH94qebQvrPY
	/e5GfOXWRaDXniIwPSrEh4sAgeWZ24lxqic3RhF0R8Js8WXofy6xxgA87xjVn6KCp85PAIaB/b0
	R/FG4eKb1YgljovxZbBbimWy9ACyFRnr1eEMzAHDpIJ925HsYSvQUuN7JQJ6J54N43lKMIl5KJD
	vDRFVHriEo7vACKxgvDJx3nc6SLMB0SDq4OfLErqGXvyz5RB/Pq8IZ+ZSLaC7j1DNQI45jFy/3v
	Q=
X-Google-Smtp-Source: AGHT+IE+5VK7HpgyOBVee5qkfID5Wfr5GaJsoDMz2yt6rAMHvg4zLlJeTHat1yQ0aOUAosVtW5wchw==
X-Received: by 2002:a05:6a00:1a8f:b0:76b:a439:be4a with SMTP id d2e1a72fcca58-76e8dc24dccmr3088341b3a.12.1755681445584;
        Wed, 20 Aug 2025 02:17:25 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:25 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Nam Cao <namcao@linutronix.de>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 1/9] panic: Introduce helper functions for panic state
Date: Wed, 20 Aug 2025 17:14:46 +0800
Message-ID: <20250820091702.512524-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-1-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces four new helper functions to abstract
the management of the panic_cpu variable. These functions
will be used in subsequent patches to refactor existing code.

The direct use of panic_cpu can be error-prone and
ambiguous, as it requires manual checks to determine which
CPU is handling the panic. The new helpers clarify intent:

panic_try_start():
Atomically sets the current CPU as the panicking CPU.

panic_reset():
Reset panic_cpu to PANIC_CPU_INVALID.

panic_in_progress():
Checks if a panic has been triggered.

panic_on_this_cpu():
Returns true if the current CPU is the panic originator.

panic_on_other_cpu():
Returns true if a panic is on another CPU.

This change lays the groundwork for improved code readability
and robustness in the panic handling subsystem.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/panic.h  |  6 +++++
 kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c |  5 ----
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 7be742628c25..6f972a66c13e 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -43,6 +43,12 @@ void abort(void);
 extern atomic_t panic_cpu;
 #define PANIC_CPU_INVALID	-1
 
+bool panic_try_start(void);
+void panic_reset(void);
+bool panic_in_progress(void);
+bool panic_on_this_cpu(void);
+bool panic_on_other_cpu(void);
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..eacb0c972110 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
 
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
+bool panic_try_start(void)
+{
+	int old_cpu, this_cpu;
+
+	/*
+	 * Only one CPU is allowed to execute the crash_kexec() code as with
+	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
+	 * may stop each other.  To exclude them, we use panic_cpu here too.
+	 */
+	old_cpu = PANIC_CPU_INVALID;
+	this_cpu = raw_smp_processor_id();
+
+	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
+}
+EXPORT_SYMBOL(panic_try_start);
+
+void panic_reset(void)
+{
+	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+}
+EXPORT_SYMBOL(panic_reset);
+
+bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+EXPORT_SYMBOL(panic_in_progress);
+
+/* Return true if a panic is in progress on the current CPU. */
+bool panic_on_this_cpu(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
+}
+EXPORT_SYMBOL(panic_on_this_cpu);
+
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool panic_on_other_cpu(void)
+{
+	return (panic_in_progress() && !this_cpu_in_panic());
+}
+EXPORT_SYMBOL(panic_on_other_cpu);
+
 /*
  * A variant of panic() called from NMI context. We return if we've already
  * panicked on this CPU. If another CPU already panicked, loop in
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..5fe35f377b79 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-static bool panic_in_progress(void)
-{
-	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
-}
-
 /* Return true if a panic is in progress on the current CPU. */
 bool this_cpu_in_panic(void)
 {
-- 
2.43.0


