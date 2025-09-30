Return-Path: <linux-kernel+bounces-837973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B11BAE28D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB577AD582
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4D30C617;
	Tue, 30 Sep 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="attz8GDj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46572FF16B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252916; cv=none; b=ndBBjvVhLqsr9JtAAXYdqLSO/ZtOJFB+0R+sNIjDPbqkbe2Coxu6bFJTjSZYroIWTZtMISlmDKPIjDM1N41+2KhRJH9+Y/YsVNALwE6LNmiwMR7ImWW6DKXIP7UjfxIadzxl136nwJw0kNF2KR/9xGrWCbfty0QfxT1fGVcfAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252916; c=relaxed/simple;
	bh=DLgwsYfhwZac7dA2TCtSOnyXfy8NPK0sFcv28xWn99c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c70Bkrzkky3fBFoangYulWcFfu/fxWW8LWAHPF/6aF+MJlQIhoA8nTGadQOgT/3RdeFq3zmuzkm6+bgVKF91Cn5FtaQMmzER1nEl7DtAjgPzcIV8WVPqbP1UYceddDmNBDbKErDAXlPg4/Jp60MpQUMEGc0Oqw5C1qjRm0kClHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=attz8GDj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e542196c7so755215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759252912; x=1759857712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ftkf2tVv2xSCZP+ZYXEg9krsVQMLMgcivCtabJh2XjA=;
        b=attz8GDjJ2L3vZF1rd7VWcEi39IR4pI0Xu/mVNNGkKkgKlh1JgycXuW6BYclS1S0FZ
         56pKsuIAp+3MZRpN5rgUOH8wH8wVimwhj4MPUUtdJVjST7EtgD5hBeEelRSBejoUtc2G
         N18j1wXHOxntUe9FB/vd/I9gfMXF+cqnMZD4y1wb8E+yjwK9hF79WR1a0YA2mJKlZ/4D
         4qCfT6l9frhHNd9NLUuKpgGXHfmKXq65/PX+5rWR7bs34XXtx6SRVzh2tFgRMWWw2ePa
         ykxGsvCPM1ocOK+z21X+L9WsP8YqP6pNNpRB1rAAsoRGDXoHM4vhIGWSs1pEITJw0aWe
         3qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252912; x=1759857712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ftkf2tVv2xSCZP+ZYXEg9krsVQMLMgcivCtabJh2XjA=;
        b=rBzTwZ39prW9pZ8wCvST0JrCPEJnxVwd0xfLVG6Q3VepsAtTN/em7HK54JgzLSnIuH
         i2iPH7m7U18GGfQ/zJ/jMwvd58tltaSXb5FvpI7FKjvF8uluh6yDDIVtDm41PtMz8kLp
         jtAjtT9pzQZHl5+T2dakgQ0kGzBQh47LeEtidn85/Gn4eNdjeV8WwlKE29N0JrUUs/eM
         H/6HwN4O0bn6Gw9w5VQnSexPYa+dqrRO7BaealheVinUQ1eQ9vgzOt1o9UmMcKoZ2IO8
         lAmuZW7gYyFGhFAr88puVYCHIAJDCWyj11CtwOfcwS0tnZo6X+YJA10jwSKcYyacb0TG
         UCng==
X-Gm-Message-State: AOJu0YwM14WKHMxiJxRpfpIDErREkpBZ6H+z6xITbIT3nWsQ0Bz45LIj
	lDsf2oTTdnkQm2g8lozHWLG7+YcvtcRVCB7PY1Sd+liuPRAcQGGaFw7hjmC8gL3jY04=
X-Gm-Gg: ASbGncujxQo4zxUZbProCEur3FxISko1f8wFraItRRYPuaGvh5iDVzjGZfJ8ynX4EKW
	n+spZAU1Og9wg0JVdNciGecxKkvlxcQNXcYtR+KFLXQJs/jzB5auqYAAzUQMt7YYjx6891Uu2Sp
	+wnXRhcfINBWEtjwkbTV1mfv3WC1dkGFTFczwiQRD2UfPn/u/s17ax5Kz/Nq+NdpweghjfTBvuS
	4Gl+cWtMtixlCTqq/d0lkrGMq5/yZDwAsldwOprIXI2G8gFUroS4vup7JNuaqIKqBUMeXXKY4xg
	3pMLCYGOQt+HCsTIrP4ML6O/gwkVPg2uF6ijefmyzcVW9zamoBbJVPU86ij5XWrdI8q0KtbNU3n
	Kq1AQv61k0BmPhbqnWGVq9szFopOvx3kTy1Egwshx24lpUWMr2FrpHCvlPOCnfavOeiBJt3M7ur
	lzNwhF
X-Google-Smtp-Source: AGHT+IGppjyvyPoYLUYqi5E/GBPLAWTf7DaTMD9ogcW+uXjdE6+YxQyMDm9UTCYl9oxXT/grHSsTeA==
X-Received: by 2002:a05:6000:40dd:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-4240fde589fmr4786131f8f.13.1759252911973;
        Tue, 30 Sep 2025 10:21:51 -0700 (PDT)
Received: from [127.0.0.1] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a17a0dsm2459465e9.17.2025.09.30.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:21:51 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 30 Sep 2025 14:21:07 -0300
Subject: [PATCH v5 1/5] printk: nbcon: Export console_is_usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-nbcon-kgdboc-v5-1-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
In-Reply-To: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759252905; l=4883;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=DLgwsYfhwZac7dA2TCtSOnyXfy8NPK0sFcv28xWn99c=;
 b=um2prxMnW/LVY0jlAgoPfFZ6Sf2tSDxxuIIBDv9lNxesBFlhm093g4RpNtMnYEUGRrT/0IC1u
 cEUkYouTNvGCIku7MRuNQRFfvTyfdf66Fl36hs1rVoU7llMoaaSGLQA
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
index f72bbfa266d6c9bbc533661c40386aa5f0df6c8f..7238da161ff9814fe8a22e4836624e50ee5b71d3 100644
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


