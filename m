Return-Path: <linux-kernel+bounces-728901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6AB02EA7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E907A853E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293219E96A;
	Sun, 13 Jul 2025 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VFCs5qf8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CABA2D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752383373; cv=none; b=imtxVbzoGYK2kqF/CvSB30eTxIwH3un+Cu40XSbNXCddi4ARFh6Ppg1L8VhtcX0mAZl662X+SC5go6o8gKLjoSj3tbOri3GdkUBw8ALTADiGz8DsAcZoDfhO5TydL7rim6m8/z2lauXqHwQRhL3MEqKJO44tFZzXYUjrqHNbUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752383373; c=relaxed/simple;
	bh=eHQxt3OQgRDSDL+/Kzb0bRPmuzSVSZ5fvf2mWGLEL6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1E+gfDKIln1HnUuPzZNQpzvb25tD8E1+qqDah/4JYw6NnplN6eQscimINLUu14yEqErF9RjEUfcS0t96756F0+U9XuKEJutOCNTGUrWG3MEh4ib22q//r6iBUS0rWX3WrzPqiYN3YtaN8Clnxg5VzkARSfzyDY1PsxnHd5Ghzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VFCs5qf8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a528243636so1783581f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752383368; x=1752988168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ5nFRIqwgqlbPEHr8CpnUbj2DPgbxersP6LBScpX6s=;
        b=VFCs5qf8PjB0Z9Eu6XlZnHqM8535qbkIOS3aUXzxXbPOfooldKWRh6En4YMBAGrSIx
         uzf741iOJvi1CFbL6eilVIOM4GoGYFWYVkVtcyFomS8lWW0eqsc7p1+Q6D4a7Tmla4iX
         27tlvq815SwZdRBxxRK8LERzVNpwjye24Gm4/5jtBL33dO7Gkfko9Gu2+pXIr/iXfgYb
         Q2KAOMWhHp7+LilW+zHOeJB9IePpI0QOXD4adMa3xr3cemHsQ5Zo5VFEj6bloEpf0HwH
         EylCHLI4h6lRqO4oZElmw/IdW6XKsyGJ9ygk7gXEhcQFV0h+W2592yAw2H/De5Lii1pe
         Y49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752383368; x=1752988168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ5nFRIqwgqlbPEHr8CpnUbj2DPgbxersP6LBScpX6s=;
        b=VsrXX+EmZjG5fqAwytpanImXbG2eCR4+7OG5oP9b8haeYZssf32MCQayN5qaXqb9mH
         44xC2pWRGlyOQAKPNTuoKzu3PgG6vnxi5qxqBLvlgL8y4wkWB/VgSB7uujDJ2Ckf7nEI
         wWh5WcbbrH2fP6klrAK890yEnXyIZjJhFru4W62WWdp7pcTbUiTmz2kN2lXdyGyUHros
         x6xKDQdcGzqN3f6LnXdfNkfwnX5lyPDXrWBvMRbCsDwBV64FsOixJ5Z3NnmFoz3fnx4C
         An7BIPqaESd1XccWUwBbfp4i9763Lsf7HVQoQeqaUOSi3zQfxQ/Z8PCAR5R0xayxdXZm
         OXiA==
X-Gm-Message-State: AOJu0Ywrbohfvot2njl7mzONGHsTbcpns54gA1rAELcstMOv7tnBQPxA
	rmNYj1mHZWummqKrdN6RcWbkxjZikHhK4D7Z1ZOU2q+EnJmnnrYSi3Sr/MgS66pB4xk=
X-Gm-Gg: ASbGncs6X9Ll/0v7L6+pzZU9fv7pRypueRScoFv5aCA3zRZ1CuClB9P5UYFGfR6xtXS
	YhGNI44z95jzkpt4sLrzocexjxVZ/mt5qbkagcQssY8x4zrhEg1E1klxMPCihoFYiDvAC/QdYXJ
	QZRaImYIgMD7s7wed3F/kEGk8jQH/8NItgrrHSAAZ8cTdUgC+dZBf5EX8EtEWpBZ/Q/8NssdRmC
	Il1l/WVsNu5bz24h5abqG6nNr6lhAL4yEeEp9KcUHlgOY2avhM6Sn58wZ2BRQwzGWCH2K3AzZ1v
	M5bdLZg6fFZb9tePm3vyonwOe7IY9EQHIguTkKNEVYXc8X4/LgItZ5vlNfYGDAKJtFj7WgHWYjk
	zklW/vI/zOzf0v84y7P4=
X-Google-Smtp-Source: AGHT+IGWIGicBdiZCJidY8N92VCt38Kw2K2NUnXkamozSH7OAMCwpffBE8C4REiahA57ea3QhMxLrQ==
X-Received: by 2002:a05:6000:2c08:b0:3a4:dc2a:924e with SMTP id ffacd0b85a97d-3b5f187b273mr7374858f8f.6.1752383368010;
        Sat, 12 Jul 2025 22:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:828:f400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f210f1sm8125879b3a.88.2025.07.12.22.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:09:27 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sun, 13 Jul 2025 02:09:18 -0300
Subject: [PATCH 1/2] printk: nbcon: Export console_is_usage and other nbcon
 symbols
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-nbcon-kgdboc-v1-1-51eccd9247a8@suse.com>
References: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
In-Reply-To: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752383361; l=6088;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=eHQxt3OQgRDSDL+/Kzb0bRPmuzSVSZ5fvf2mWGLEL6g=;
 b=HagkgsWmd9lg8ADrLcdrGSFoCgjFq3ZjERaj0qqCBFg4CHI0gH+fIHzF6LZWnxaPSO7QK4z2J
 pLQdoDG92ZwBhYeio27lYLvuSOH1/34TV/sWJ3DPE6qUNMCZyU92vSL
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Function nbcon_context_try_acquire, nbcon_context_relase and
console_is_usable are going to be used in the next patch.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h | 41 -----------------------------------------
 kernel/printk/nbcon.c    |  4 ++--
 3 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85bb4536e4b0dda4e8ccbdf87978bbb4a..d5398b4be4f7ce8d1642b919952710431b53a8ad 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -599,19 +599,67 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern bool nbcon_context_try_acquire(struct nbcon_context *ctxt);
+extern void nbcon_context_release(struct nbcon_context *ctxt);
 extern void nbcon_cpu_emergency_enter(void);
 extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
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
+static inline bool nbcon_context_try_acquire(struct nbcon_context *ctxt) { }
+static inline void nbcon_context_release(struct nbcon_context *ctxt) { }
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309db20fdd7419f7aeda68ea7c79fd80..4ad51a98690b43fd2383a0c6e70ac4da68c34da3 100644
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
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..b95030018472493b1019932c3d1d92c1abd044ee 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -568,7 +568,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
+bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
@@ -648,7 +648,7 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
  * nbcon_context_release - Release the console
  * @ctxt:	The nbcon context from nbcon_context_try_acquire()
  */
-static void nbcon_context_release(struct nbcon_context *ctxt)
+void nbcon_context_release(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;

-- 
2.50.0


