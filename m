Return-Path: <linux-kernel+bounces-856374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051FBE402F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D34A587BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605B3469E2;
	Thu, 16 Oct 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z+TKrbBl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83353343D9C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626097; cv=none; b=JsqslvQDLivRefHnz6bz8KhCRVaWYfApKgzxKs40jqaO0UkMLTclW6Yly8XzQromHABI+dmVp0RRhUor2rSE/DreB2+6UBkbYMUBxJwc419z45D/TkFdymMAJ3AXMv8j5aLYpx+7qXID6rFBUZ3B4NQ9z+KGt9kaiwfOV/z5AGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626097; c=relaxed/simple;
	bh=4W7ciJQ7V9RRE3FTBU3fr2wHSfQFLn6hAcKzHmMsRsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QOtp2hQO+ego2aX8YIBT7YeAZjFJ+n2r7WyTYqlVgzFMCYnQZXPtXQE/KDYW+nVI0C1mymJOy96yh1G2IJKPPUR8yuCx3xM5JGGvd5uBLjeCRd3YFGlhQ4fr3stkyln8BYe21PUnTh01H0nc+ac8WjlcUGrv2V9BwBieeF23yaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z+TKrbBl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ece1102998so669254f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626093; x=1761230893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZwrAXHCP96cs4Mc+0ImiEPD2/MYmM0p4dOdWtxHtqc=;
        b=Z+TKrbBlNu8Caj2X7kgeS864fLg54N0kVSG+JJ1ao5x/5P+SpwI4DStQ/eG1tp2uLX
         JDozA2HFFDQjn+SlH83GHmTyUFgk66akIxbQy3v1pqx5C57+L7UeVWAsydEWWTwMs3Qb
         Ax1t8OW1HBF18uJtumsTcrWbn0ROxH6Sop7XoqWi+n1bNn8rLVzSfIQMxGjJrVzpH/3K
         3UzKdAFrXft9VZmBvQn7SKtFvm5pov3zd/CDdIzBWzhqoK3B/aMp17dqz5rSolDxUXqR
         hiLkwLW5/Bw5BJJGmxx+RUZO36cmQ62pXhxge4W7k7oFKJ8eykD3vh5QabHAF6q51lyP
         DQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626093; x=1761230893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZwrAXHCP96cs4Mc+0ImiEPD2/MYmM0p4dOdWtxHtqc=;
        b=FLFpVeyyuhucxd+wkC45SAUyCFrfdHO96maMPMKsZIHoLypO/gwNq08xR2hCJWZCQd
         wgKHO0blriigS7j9S6KWVmJqvcC9+MIDb8i1t4Y9gfXpG+bpzu+16SLqKHcEdCeizm5f
         M15elbEGeASub8w2V+EAM63qSetSHbnPihhDPJEg3YontRvfdHyJ9MeVQhxuMMn3MhXU
         vLfhy9joj+hBY8AnW32m4m7H92TwI8CtxbT7ZvnldZ505uXvjidp4GQdhOP1Qb9tH1r/
         R7k6/IRhGABgTpfViU5gNhliakQwpqv6UiU1QMdNj15aCYa2WaHeSzmU9KwR1psk/tiK
         O80g==
X-Gm-Message-State: AOJu0Yz4eeYOLzxwdIJUE1Vr0NC/vLpSjsopd2lBl5wKO50pPIjkC5Rc
	7DxXwB/PLDhHvGnL4y78OOJ5d9+btz/p/bCcFl8QGXNyKMxmwzZRtbiR0U5eNTnbG2A=
X-Gm-Gg: ASbGncshXpNVrYq5AbPo+sG00YziigXhLXmw0j0Uzv/sIvjAq4avnxltjMQYLDR/NrC
	TfHxdd9njUJpTshAY5A0NSTWjS2dgAxuV/eNT0VrK+5iYXL1jhVf/VhrirAZH0uCLdzalsKcjoA
	lk8f2bITyCQLtDY5POJTFcTkQJ1XoShdXWaihAjHcFFnhtj07+ToO5QlME8RnjYnYcEwrL6fAaX
	RIrwFkT2gFttNsGrWww1zgM+ZIaYX6LranopUgYwhOdO45C5h910oUxhf1CFngeIajHavM+PvBz
	Cs9hTD/kqrYB693AIOdvW1Sxtsh8tSumcTTKa52YA+SMEck8THXNabGAfaCE+MSW8hSm6bqLEU6
	EFmsrjss/zye6k8RVbcr6W/oziWqmfPCLOsuKcbcpKVQJuLMHkwdO7nFu2BfuSVwUxtbe1zQHpH
	bgYxnCFPY=
X-Google-Smtp-Source: AGHT+IEYgAP06AR1dJxuLPdg471qQhscygkPBcFY+U2P5o7ClVB8NBTl8D/larHzQrhIzIteTE+Krg==
X-Received: by 2002:a5d:588f:0:b0:3f9:6657:cdd with SMTP id ffacd0b85a97d-42704db5d5bmr324975f8f.38.1760626093557;
        Thu, 16 Oct 2025 07:48:13 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm32947795ad.107.2025.10.16.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:13 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 16 Oct 2025 11:47:55 -0300
Subject: [PATCH v6 2/5] printk: nbcon: Introduce KDB helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-nbcon-kgdboc-v6-2-866aac60a80e@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760626083; l=4583;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=4W7ciJQ7V9RRE3FTBU3fr2wHSfQFLn6hAcKzHmMsRsU=;
 b=dbU3IXzO8IodGPdGQIFZpS2KWubTjTk6Jond439VVVIUyV/f1QWWbZZX09u0lnjT5MPdvkCWW
 kUJ209h252aC58122EUsBo2D6HRqQCjHbyjTxn6gIMCbuhTkCGOPzUW
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
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  6 +++++
 kernel/printk/nbcon.c   | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 1fda485ec2fa..0d589a933b6b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -606,6 +606,9 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+extern bool nbcon_kdb_try_acquire(struct console *con,
+				  struct nbcon_write_context *wctxt);
+extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -655,6 +658,9 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
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
index 558ef3177976..e1bf5409cb6b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1855,3 +1855,64 @@ void nbcon_device_release(struct console *con)
 	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
+
+/**
+ * nbcon_kdb_try_acquire - Try to acquire nbcon console and enter unsafe
+ *			   section
+ * @con:	The nbcon console to acquire
+ * @wctxt:	The nbcon write context to be used on success
+ *
+ * Context:	Under console_srcu_read_lock() for emitting a single kdb message
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
+	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);
+}

-- 
2.51.0


