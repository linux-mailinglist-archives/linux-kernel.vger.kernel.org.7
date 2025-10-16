Return-Path: <linux-kernel+bounces-856372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0ABE4023
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438D1586755
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDD34572F;
	Thu, 16 Oct 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YEVIoOSw"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80153451C7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626095; cv=none; b=qPhzDJMJlFRqEVeU9JddVumQYKelfu9EYJL6ffQmd4c41GQtUXG3F7M8J8XTFeS4HaNjc05AdmJWdRuhA0yrCeHCwotRqL+8sZtI12zsPegSIwpXviNXFLJsUrvkuV2AXDMDCLYzGT6BLXi2Qg6la5vY0g/B/vY5LJgDbeg5opw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626095; c=relaxed/simple;
	bh=QMt0fN+cb78tcvpLQc3o5RloIrix2FlLCC1yGpt3I4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+qQqVoxPFe+ETc9RimPvFfOx4o2ngbBYJFutpUc6d04ff+tL/jNGTvZ0WXrnGhIl8xspKxDBEQRL9yqSDXU4gYvxk3JKpNQwhjqANJKZikmHI4WnAdNuyoiyjovQIExu4ecE+SByRTU5MTQA87fa7wBuRO9CZmQ94+tF4T2Bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YEVIoOSw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426fc536b5dso459889f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626090; x=1761230890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wcV2sJmeqXTy6AVfxXd8m5VMPoWxqFn+yRK4QT9DBU=;
        b=YEVIoOSwdmOf4HzINT/ZPVemGLZ5uy6Xulz61IVKUClzLlvPoMurjhfNh/UufXWRqj
         /foCidh1xvXTvWJzTGSa+lW5MP5vawjt0ZrKyUB1qiOD633vl0visDLxKH2OQ5QlsD5R
         zGRGrasvYhu4emSK2GAKrK14WXfnHdVjfE9h0L8/gzrNqGDJcAk7NTP581CLUMhykEBc
         2ookVOGYyRpRc7dY3O3mTemZPtj5UsPkAirmYHX28EZHMyyt5F9IVfJDfXtJA6843h3b
         qDnHRDV/rtctCPXGVG6Dvr0Rb5DI7fUtODv637D+GR+VOjuwDsfbv3eh8q4/nx+TW1mh
         UW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626090; x=1761230890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wcV2sJmeqXTy6AVfxXd8m5VMPoWxqFn+yRK4QT9DBU=;
        b=ukmcERB0U/QFMGrx0M6L48TrTD3+/mbUlp0SZGi3YrJtshbOBU+SnSIihKF1bQ9daC
         EKv+EZv9olgymay+Ew9X+1nH+I2BKo3Tn/GBmICSIkG+eunPITVR9mLWLJ+D2yNIVXDo
         hROr7IHI5/jrCOEClJgf6U/clDQ7DEjkfG+wmn88vhptryrNLFuVXyZMKHlMRqSAh2Iu
         boS+qjUcrHQeonE1qQ9d4xDLJWzk7Y4Vprjq6lLD5HFkoUrYL3yyV9bY29RcXt0vnwW2
         pSYcqzHolA7JtTU0kZI8vhEIGGPxEkKvqk/6Nce3pK0n4mZq/b8JiURaEnPI4YjfZTxe
         9tPw==
X-Gm-Message-State: AOJu0YzMamOehia2JcXp+prkMaw5ZoWRYSkofsA0XMJdPSJPtP9DE3Ay
	NmkDgZhwfLr97pxd4gc+6ByYCQw7n2v4npUiiAUffgwbtEx8EFhUyEUbRlBrzW/jP6o=
X-Gm-Gg: ASbGncu7fWig+NL2lBTwnlhj40s2zKLagOrB7U/54yKCsUV8Q0CKsDAAGE1NqJaRglY
	FMYxuQzBvDYvY+KUxcrP8A11z7Rl8zWis6QECb3PEzxy6FU1cGw65yPLzD4lRZki+tjltKO7/IM
	AhsdVGFZku7OgZtOTOTs727yKD+QVJ+YB1kiXGzlS/7uP5nBoKmTJi+YGCDW/7k5LT4gRwEUNBA
	parENA7pnuEfWXOGHBQyEe3bjMZWcIp088REt0095dCqtGURgeHIoh3FDPCba1kzL11NzTGHoyR
	Bu/VdWdR+AHauPZTS83wyQsYKs7ickgreSLR34Q9G56D//XOo/kb6qIoJ/p90mxLi7rlGxjarCf
	Bc2LqumP+cku7aXA0DqNzi5yvXdbyUzolsAyZUhVdOk3Bpai3Jk3YYxRUlMtlUJPHSQIv7hfqKv
	5uny3cMCk=
X-Google-Smtp-Source: AGHT+IGmVbScEjUkbk7rVxfi9X+8tUQmzKUJdFfxZApqqKWe9ssd5y7AOOE1nx1NPTqPnECLrcgBcQ==
X-Received: by 2002:a05:6000:2383:b0:426:d5ba:878d with SMTP id ffacd0b85a97d-42704dc76d6mr302678f8f.42.1760626090010;
        Thu, 16 Oct 2025 07:48:10 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm32947795ad.107.2025.10.16.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:09 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 16 Oct 2025 11:47:54 -0300
Subject: [PATCH v6 1/5] printk: nbcon: Export console_is_usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-nbcon-kgdboc-v6-1-866aac60a80e@suse.com>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
In-Reply-To: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760626083; l=5226;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=QMt0fN+cb78tcvpLQc3o5RloIrix2FlLCC1yGpt3I4I=;
 b=NRQ7aPWDBXwgjWf8kzj6nWwUxPP/cun+PmQb9kihr/58YAw811WRbq5jWYgnmdqN+0xE+2fSf
 jV3VU8HjDYFD55ddbpW2JtPq6PAqIMM5a7s++d5UtcibNsHmo+ZcDlr
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The helper will be used on KDB code in the next commits.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h | 45 ---------------------------------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 031a58dc2b91..1fda485ec2fa 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -19,6 +19,7 @@
 #include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/vesa.h>
 
@@ -605,6 +606,48 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
+ * records.
+ */
+static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+{
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (flags & CON_NBCON) {
+		/* The write_atomic() callback is optional. */
+		if (use_atomic && !con->write_atomic)
+			return false;
+
+		/*
+		 * For the !use_atomic case, @printk_kthreads_running is not
+		 * checked because the write_thread() callback is also used
+		 * via the legacy loop when the printer threads are not
+		 * available.
+		 */
+	} else {
+		if (!con->write)
+			return false;
+	}
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -612,6 +655,8 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index f72bbfa266d6..7e3128ec9336 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,7 +3,6 @@
  * internal.h - printk internal definitions
  */
 #include <linux/console.h>
-#include <linux/percpu.h>
 #include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
@@ -112,47 +111,6 @@ bool nbcon_kthread_create(struct console *con);
 void nbcon_kthread_stop(struct console *con);
 void nbcon_kthreads_wake(void);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records. Note that this function does not consider the current context,
- * which can also play a role in deciding if @con can be used to print
- * records.
- */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
-{
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (flags & CON_NBCON) {
-		/* The write_atomic() callback is optional. */
-		if (use_atomic && !con->write_atomic)
-			return false;
-
-		/*
-		 * For the !use_atomic case, @printk_kthreads_running is not
-		 * checked because the write_thread() callback is also used
-		 * via the legacy loop when the printer threads are not
-		 * available.
-		 */
-	} else {
-		if (!con->write)
-			return false;
-	}
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 /**
  * nbcon_kthread_wake - Wake up a console printing thread
  * @con:	Console to operate on
@@ -204,9 +162,6 @@ static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *hand
 static inline void nbcon_kthread_wake(struct console *con) { }
 static inline void nbcon_kthreads_wake(void) { }
 
-static inline bool console_is_usable(struct console *con, short flags,
-				     bool use_atomic) { return false; }
-
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;

-- 
2.51.0


