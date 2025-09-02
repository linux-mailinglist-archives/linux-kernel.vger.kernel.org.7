Return-Path: <linux-kernel+bounces-797194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38815B40D39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05B83BD259
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613234DCE2;
	Tue,  2 Sep 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B6hVTgtg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F79345723
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838054; cv=none; b=ekLY7+XwPa3s81h1tPiYNIU+OR4UNWbgIS5RF0V3rlV0+QeZf3IZ1Pj2ims+Te1fBzUMfxb5RsxcMICBTLex0K2pjooPriL2ml6TqinCt9JS4OOrLs1Y02OaAeurYInojilrKYOesW4pOhFme5LK/lMEOWLGxvQoXSrTJ/K8rIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838054; c=relaxed/simple;
	bh=r5zUwQ6GxG1jCUU829+hFTuxN+HS8Xhr4zObCZLsark=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkkWsdwZapenT38J8R6UJqPwCtVsfr4KOF3yWyGCs2XsUAWmUW7CBZtotryXBAypiX8rqu8juHDmrHyRqD3sAEo36m/wFpaXAhj5Ggx7Pxg6b3pvJsE2hBehJ6dIxAAUPJWF9ZZ5YlqWOo7ZHWJfXKVlk7qo4JbZ3eqits+uMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B6hVTgtg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso18668135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756838050; x=1757442850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttbC3r1SK6GKufIVtofaDKxaTS0OI5TigCweNxXtNk4=;
        b=B6hVTgtg4rayLqB+bJKHZhhKL680Oc6bM2JmC+XI5Obm0sQw73cFWc48N3bmiZBI9y
         oI7fYzBzho/4qWSQvnrhwgTjSiOqaQmnIgKy6QJ/yWhdJL+japW5nj6j45lGk+9197eE
         5VPpAg2TtF1J2UzRYKi0qqktPjbIT2mfjx5HM6pWIgWa1Cbv9342P+y3Fwmv5rx7Bmkf
         ITZC6OuSBEwZGy8clRw6I8HlFSCCIZwLDQJ24drd2J3iwGc1Sm+WDh4txqEM8kQgLsYr
         XffRVmcp2OxS186TEU6oBpnlh1wJ2KAxyT8E50WW5FWIahBKOIRd6O1T+g2MTak5kKXr
         EXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838050; x=1757442850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttbC3r1SK6GKufIVtofaDKxaTS0OI5TigCweNxXtNk4=;
        b=vmJEYa4KAHrlZg/3eF81YSOEztSeHwnczsLByD9BJNyxxOoAjDVCsiczzrYh+iVumL
         kOW6NR8aa+4KeAQLwCspdqds0/MUp/OSDNN2OuGeq5zjanTYUz/Gwj2aYuBDvjnnAZih
         gk/5wFCFupGW/bZGbnQFCdChGwc3/C3vgFzERi3xKxshbzdk4TUdi3BgBq2MFo/umiJK
         /pvfDBJ/LaT1MDq8DUSs76t2ZqaZ47H836i2gcxArb7TNc1JfRdxrse6Zf3wTg4Fyc+W
         SLTFY0u1QPwtFsOZ8ZuuLC1HQsXmKZKdM1Z8O0Eo2vujcQtBHSf3ao0lo8bqScNiBQji
         yShQ==
X-Gm-Message-State: AOJu0Yxwyn83tXSqATqGTdVZnT4hnPqqq6oKm+iag/Z/+/4nJddL55fh
	FiMP6XXiPA3W1X40NSOSnPS3GFdQW/ZCbZ9lKcsuPhkbIXvPk6+YfuEKSwF70oO9/os=
X-Gm-Gg: ASbGnctig/3X4BmosrTCv0TGhKbQV73e0HSmN5tuxSGRfhH3DwOhvSe591RbjD+Sh+K
	047TsVWXAIla0aRuwIS/niSl1T2wVdySjIzn1ILyh9h64w3955Ic49UFlkU/iwZ30a3HVAQVnY5
	mOEmY9eW/nol4FSK7USQmYiJ/NgjgmA8IuO3xkfjP1MGqIIMZIJ2n08HfCsE0btujwrvfwkyJDA
	fHbIMT/VLTmappvm3+Ow1ykNyX1cxdxxv/Tf9edSG59VYebEM1OcYWcsuvbZTEOlDU/OBBDs0zK
	emLIyZbUZT6iAq6vLX0sB71Lxtfk6M5KPKqLYt7IdgQlHrQrRgFyO4iEpLm1R0V63OpL9DnsmPH
	QpwBCY5/Nmxnysh6O9dq6IgN3XH1vew==
X-Google-Smtp-Source: AGHT+IGCzUSqvHnAnst5yqD69KVC/ia6+vzcWIQx+WNo5yIeMhcitFEhgO7XQVRUak+laB8Ki2ODiA==
X-Received: by 2002:a05:6000:26ca:b0:3c9:f4a3:f145 with SMTP id ffacd0b85a97d-3d1de89c4efmr10176812f8f.27.1756838050020;
        Tue, 02 Sep 2025 11:34:10 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm14028477b3a.73.2025.09.02.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:34:09 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 02 Sep 2025 15:33:52 -0300
Subject: [PATCH v3 1/4] printk: nbcon: Export console_is_usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-nbcon-kgdboc-v3-1-cd30a8106f1c@suse.com>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
In-Reply-To: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756838042; l=4838;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=r5zUwQ6GxG1jCUU829+hFTuxN+HS8Xhr4zObCZLsark=;
 b=thmhh708ziRAZ1AKoaAMXXM2K8RvBcpU7YNTWqO/pGIUEwoabt4quMFBc7EJl0TqEQcxgSUes
 /8JEUpU3m7gDUyx8npud/FeN8pzBdfLlKR2VuPhcg/Ns+3PV5utwkVK
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The helper will be used on KDB code in the next commits.

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
2.50.0


