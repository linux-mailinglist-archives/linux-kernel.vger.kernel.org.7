Return-Path: <linux-kernel+bounces-837974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836CCBAE290
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F57AE307
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A630CB53;
	Tue, 30 Sep 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TZ2CGv4D"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F318A93F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252919; cv=none; b=TExh8LRjDyRX/knxwVNc+cKW97alz2mg26Q0zKtY7ZM+t3zJpDp+SwRsPen3twfeEL5NvoemzOXO6sI23ULZfYnVPgwfMrbbBq6DbdKDggokRHmf7IgpNyL30VYuFYZQeD1LFGlUfbiQnezBEFdfDV+c0MtkkuIEQEKwkZsrYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252919; c=relaxed/simple;
	bh=A3hmoRxz9+3hsHn91K5rMq+MYDBREGaN/U4eB2Zs/HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oewV5lvPCxxQcgpsLzyKTgZUyLMhboxC+nauB3StpITkuey5p/phfmFslg9aiYFGfeIqtC777lq1rrwzTf5ywKCsOlYADi6DO8PphuJS4Nb03htKnPedvkuuqNTiVTj+5hhitS3HZoKi8wdbfo5atGRetqsCLfLpLPPlaDb5+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TZ2CGv4D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso41065945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759252915; x=1759857715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdnfcsEyqTgX9MfItj7Fuu94KdDUV1/v5idkdjyPpFo=;
        b=TZ2CGv4D5fua/InE9MeZdMgVW5GQZgQV3sFYTczEgmWL/rUnyZIjy6QWbFW+Ogsp7H
         U+XRgkhyyX832SZCbsXUTsOpAZEcTUpHUPhHToBP0Fc6nq3f6Z5GSfoAz0VaB1V9ROpA
         2rEifQoprMlAgBWT441HD1X2BsOSJlQ1sgZ8TCwXIQ3YbKPP57352DmInVE18cmt9NhW
         DJ3i3YC5OjSsQdYeg2DWnmSCoULPi9NXk22o3vxOBBepKwEiXQ24oxIy3YTKmjgldVoE
         6/CAhLQUxA2wF+4bnNGc7mJhVOALX/SGFkiQdh6za6/WXAkz7fi6SQzAe1SYm4zA7/I+
         Dh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252915; x=1759857715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdnfcsEyqTgX9MfItj7Fuu94KdDUV1/v5idkdjyPpFo=;
        b=e9aToh7SKtNTkR3Cef+RIDO6NutpSaK/JVJhlI9k8dFS2ckKgfABVeTybi1q8tDiBM
         X5EBe9DCxLOXR+pxbOG2y0NmUty2WMcm8UvOgQiLpmelyNKquATm8xnUUK2SbFv0nLT/
         VMZtrJE0OGumVr6i/PYudYzsO0AdWvQ4TVVnQNlSDZ6Ym5//cIbAkt5zQyLgXmpw3Wv2
         xQOm4/4Ga7UZ5CDz0YF9ZhCmZgZ9gwUXbmPjUlS0K24Wk5HoVUcB0TqViGlVAKLSgbOu
         0XYcF+IFSpHc+mGoaG90gD9cj4ZSIkflDqekU55vz0gAXxWId0E2BHJ6V/Bg7SqfZ5MZ
         o1iw==
X-Gm-Message-State: AOJu0YyYYFefcoEkOK0F8kHOFSLAEsP2n0VRcpohUygWBsSw4cm8DTe3
	CsA2o0fk0jvc5qk93/Y3hi3n7p47URTSD8xuSCy2gUxpZ6P9ZAe+MyEJQ+nOnJp9TIs=
X-Gm-Gg: ASbGncuC/thUFWeat0FhmUbtVic2rmi6P/jYOynN+oXUK6g/Zmo7IFLlB+ZWEeorlHl
	ZQ7CjwzvsFZjPZqfvBzQXvmFHl1MTSdh96l+s7j089eNSV5VGvwgmGMDGzJJkWhGmm4QKfOgLhK
	NQ0LgePukOdf1EuIIorOXSITcVskPX/BiBvsJAGaYKvgjZN0n0u6YVw5kl4boFNjkCZywVVhHgd
	Vha3Y5CvvY2snS7NY2UQJacB/veiHy/QXDntmNPV2HLOX0Fmz3S4gYR3ZNBIrv0La6ciBcyImPn
	hEec3IbLc8nK+5Eep8EIQCBmYJ5qGqtGzmiegPrPBb/GQFbyfT4VBHnKn2KZ3FvLdaIjGBg2auL
	Wayda4HJ8lO/dnDlGOtrc2q2CLj8z7mab/CTD8NFG7mKPNyN622WLaoN5pU6tV0QyIvf4Og==
X-Google-Smtp-Source: AGHT+IFmgBiS1UL82y6u6hi2zoH4rTC6RPOuQxMDlFHnY+ZoDGp5SEAvVOcgnGZeMsIqwwFjTxHosg==
X-Received: by 2002:a05:600c:1912:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-46e6126a662mr5417495e9.21.1759252915275;
        Tue, 30 Sep 2025 10:21:55 -0700 (PDT)
Received: from [127.0.0.1] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a17a0dsm2459465e9.17.2025.09.30.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:21:55 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 30 Sep 2025 14:21:08 -0300
Subject: [PATCH v5 2/5] printk: nbcon: Introduce KDB helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-nbcon-kgdboc-v5-2-8125893cfb4f@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759252905; l=4882;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=A3hmoRxz9+3hsHn91K5rMq+MYDBREGaN/U4eB2Zs/HQ=;
 b=EKmxyrKT4OFERXGWQmYUzKh13DtHdD+KGhy3scNKnf2kqccu+uo4mzWOBRDW8MlE2VywGKf5h
 RJmXpHHrUv/C7d9KgoEkRZldKsrk1h3K67vEmBxREh10IJn9j6nyI9k
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

These helpers will be used when calling console->write_atomic on
KDB code in the next patch. It's basically the same implementation
as nbcon_device_try_acquire, but using NBCON_PRIO_EMERGENCY when
acquiring the context.

If the acquire succeeds, the message and message length are assigned to
nbcon_write_context so ->write_atomic can print the message.

After release try to flush the console since there may be a backlog of
messages in the ringbuffer. The kthread console printers do not get a
chance to run while kdb is active.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  6 +++++
 kernel/printk/nbcon.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 67af483574727c00eea1d5a1eacc994755c92607..b34c5a0b86303e2fb4583fa467d8be43761cf756 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -605,6 +605,9 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+extern bool nbcon_kdb_try_acquire(struct console *con,
+				  struct nbcon_write_context *wctxt);
+extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -654,6 +657,9 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
+static inline bool nbcon_kdb_try_acquire(struct console *con,
+					 struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_kdb_release(struct console *con) { }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 558ef31779760340ce42608294d91d5401239f1d..c23abed5933527cb7c6bcc42057fadbb44a43446 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1855,3 +1855,69 @@ void nbcon_device_release(struct console *con)
 	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
+
+/**
+ * nbcon_kdb_try_acquire - Try to acquire nbcon console, enter unsafe
+ *				section, and initialized nbcon write context
+ * @con:	The nbcon console to acquire
+ * @wctxt:	The nbcon write context to be used on success
+ *
+ * Context:	Under console_srcu_read_lock() for emiting a single kdb message
+ *		using the given con->write_atomic() callback. Can be called
+ *		only when the console is usable at the moment.
+ *
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * kdb emits messages on consoles registered for printk() without
+ * storing them into the ring buffer. It has to acquire the console
+ * ownerhip so that it could call con->write_atomic() callback a safe way.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY
+ * and marks it unsafe for handover/takeover.
+ */
+bool nbcon_kdb_try_acquire(struct console *con,
+			   struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console = con;
+	ctxt->prio    = NBCON_PRIO_EMERGENCY;
+
+	if (!nbcon_context_try_acquire(ctxt, false))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	return true;
+}
+
+/**
+ * nbcon_kdb_release - Exit unsafe section and release the nbcon console
+ *
+ * @wctxt:	The nbcon write context initialized by a successful
+ *		nbcon_kdb_try_acquire()
+ *
+ * Context:	Under console_srcu_read_lock() for emiting a single kdb message
+ *		using the given con->write_atomic() callback. Can be called
+ *		only when the console is usable at the moment.
+ */
+void nbcon_kdb_release(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return;
+
+	nbcon_context_release(ctxt);
+
+	/*
+	 * Flush any new printk() messages added when the console was blocked.
+	 * Only the console used by the given write context was	blocked.
+	 * The console was locked only when the write_atomic() callback
+	 * was usable.
+	 */
+	__nbcon_atomic_flush_pending_con(ctxt->console,
+					 prb_next_reserve_seq(prb), false);
+}

-- 
2.51.0


