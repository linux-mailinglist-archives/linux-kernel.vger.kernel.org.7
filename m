Return-Path: <linux-kernel+bounces-816752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F1B577F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EC23BB337
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B62FE57C;
	Mon, 15 Sep 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f/Kc0t9R"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E12FD1BC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935247; cv=none; b=Wk04pJcExJ1yizKh9av/dmk5oZyCErO6hNK4beQPfETQr2ml7xrJ0l27zrDwyw76Gjp9iduSeDhjL+QVuSgdwxgKcAl9hAXYD4GjZvoIoJ/g/Sl9fiJVCGNfo1Od9u4tGCyJc7F6tNneY1/BSm4uuLkWWCOCWh1Dimj2Zrh2GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935247; c=relaxed/simple;
	bh=uSwsVcx9vRLURJakPGQPHCsZ1IwrO5LIgYvBgpZcp6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TK8NO6/ZU8SOqKqZ0MIilZHpGTgKqg4Fg218zSriXgOsBQfOkhnDlhI+4qsr1G6XAFBphb3v5+j1I6lQDLUeAEoRxf0XwUnfqzLm2TohnCxR4Feuv2bHxnXROOjnTsFOcIJ4dZwycRSnF5RzLfJhWdAs06YtjI2HZ8jqXzBhSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f/Kc0t9R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso3718225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757935244; x=1758540044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMeqCqBAZa7/mzPAEgv5VH6k7D/J9H6aV4yDqPBtdaU=;
        b=f/Kc0t9RtrGWB+wldfHHoDETcgJTBwIxJ9Xqea4vcFdd+//JRDXNo1Fp9p6QEBw4fN
         CxsRWO13OrZ8jd3qZxTKqmMsGxKGrpU4qaTCLGqoz9iQD5KlW7lttKMAEbgP6aLuaYSD
         jaduGV9QSv6xefUrDFR77qXnx/LLrofrm+pC5oNyBNY+5lqLBiCEUCnm1Mm/JIVYZAqM
         0Cwb6Z7rUAYCjZVE3and1G6tZtb7bqm0lgKat0ZZkbAGTzKMdobgovJQdS5XL7vRhgGr
         g46XlfpmFuXAEmQN91A8FmBVsNtRT6piPoYCFqNE6MQF+tlnJMqed/8POOph+xOj98ft
         gRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935244; x=1758540044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMeqCqBAZa7/mzPAEgv5VH6k7D/J9H6aV4yDqPBtdaU=;
        b=wzP0yRG0wJ+NHHJlBtye5vot4EIcX7cLpXRDc1wdLn/SnzsrVviPj40ZNafaIpikIf
         pphe30RmKLqX7UavfRz2/CkBsAs3ni44mJb1/qA7E9J5njM1BHmJ0lNgI8q0zsx8Mely
         7W0lRu29kFhKXZou4HDaazEUHssJ8iCgRcjZ2EYsyJsVCLKVg8gY7yzM/rPp3QJ7qF85
         XOn5TwvLspap9xxFPMUvpsh1A6t4nE1KFU4Xwl0g2qiHWXZMTrZF0PlCjcxjEW2DTzTl
         knEyZpnDVWkOAeRdmdqyJJ510dBxDb4pZfuY6zR0jzr/YZqcxmqOpljnhoMjuP0ZUyDI
         tIKg==
X-Gm-Message-State: AOJu0YxkUpkt8SUFqzAwjJibFHnB27H58RIQF/c8TI5UvdQqfEwCxIla
	CEUgnXqKc6arqxyahninTwDYCsaiV7sq60IUItTk8BfnsYrKtE4QrtojxUaDY3NES08=
X-Gm-Gg: ASbGncuIe4ppOcxDwemGK7gkJW+3spdo2x65VVgQlDWwiXkGpOWRULrWfWaGn6owrD9
	XM20I9D4P0Xt9p4mWn/zOy+LKgXDlSMXFgQDPa5GU/PNv8d+QYi0L90QRiJT9sohfdmnr0RgdJj
	f3ckSmGntbZ7jh97sLBugscB8MOz7C03ZPO+19QHkYBLkKVm7EVzTPP5BMH0gQAXY7Vb6hWwhjK
	ossZ6CRStfCBU57DE4+QE4EO0puqLdOKcy97sR6wmBrT1EndL5KFS8FsyQZOJoVTOUfta/BMvS+
	Z7qxbgtUyzK1M1RbNcNgtkrzbBk09TS0pUJmEnys7eACn5j+3LMqJMgVxS4iJMOpYk9+Viun/b2
	KIpBHEPJO8+WnyfH0asRpX70eZ8/glzM+jBtUb39KQkaMfEc8
X-Google-Smtp-Source: AGHT+IEHWi7WL8OdfYfER15vRP6YDLTZUO0QyXbTtSufDMqi88cUTTjWU1lz1sk+b7vDTZ57C7XvuA==
X-Received: by 2002:a05:600c:3505:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-45f2843e9dfmr63919985e9.4.1757935243486;
        Mon, 15 Sep 2025 04:20:43 -0700 (PDT)
Received: from [127.0.0.1] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519f67sm91903345e9.1.2025.09.15.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:20:43 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 15 Sep 2025 08:20:30 -0300
Subject: [PATCH v4 1/5] printk: nbcon: Export console_is_usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-nbcon-kgdboc-v4-1-e2b6753bb566@suse.com>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
In-Reply-To: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757935236; l=4883;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=uSwsVcx9vRLURJakPGQPHCsZ1IwrO5LIgYvBgpZcp6s=;
 b=U5xyRJxQBfGyahplGiQO7IoISUiyX6VzLKgFWc0DdbIrRpOz+NpCynDJNnwu/zK7PCjym10bz
 scSEh52H1VWD32nfHu+2z4RSz9xajDKi1FZW0YKAmBvtJuc7PZIHk6l
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The helper will be used on KDB code in the next commits.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h | 44 --------------------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85bb4536e4b0dda4e8ccbdf87978bbb4a..67af483574727c00eea1d5a1eacc994755c92607 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -605,6 +605,48 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
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
@@ -612,6 +654,8 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ef282001f200fdbbacae3171932bf9f049037a85..bef97f2d11793191280bfb46f7f8b13bf2560351 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -112,47 +112,6 @@ bool nbcon_kthread_create(struct console *con);
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
@@ -204,9 +163,6 @@ static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *hand
 static inline void nbcon_kthread_wake(struct console *con) { }
 static inline void nbcon_kthreads_wake(void) { }
 
-static inline bool console_is_usable(struct console *con, short flags,
-				     bool use_atomic) { return false; }
-
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;

-- 
2.51.0


