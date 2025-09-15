Return-Path: <linux-kernel+bounces-816753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D01B577F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65B116F132
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E42FF14A;
	Mon, 15 Sep 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XumsmAzt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB072FE587
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935250; cv=none; b=Jrmm28r6TcuQlHkSqxx8r9Y9f/uEZ7iF0VX52ruJ/42hcnAD5QBBMgcgAaMCLIa8Db/gF7YXhiJWmhKNZBc9CJGqKrLpK8/VtSmSmx7HgyIWTEgpRio/TxTrx94ckQa1yULSQFiLO1wvzC8H7oMyb2hfzGy+Xr48UnfAomIrHgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935250; c=relaxed/simple;
	bh=wjvht/yPMwra8hwA29QVWh/qPUkmI/5GG7pvtVwux7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKm/nq4aCXXoFLBJdvJKXbaCxhLGMiYya4utFcelt//BwaxWCcXrhzt+Od02TqFGf06A9LiJYyy0+RVsERBsq1X1Js2bkIRjSmfyXTb3XU/Tk9hDlfXfxBb2LFSbC9uW28tZTgAzkseMbgeCAkvwmprFmJ62dxmA9JGgt8XbGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XumsmAzt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso573195f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757935247; x=1758540047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1PJALyJ3qcEXL7gRw/k9T/2UVdjMGD0bdFK5ZSQn5U=;
        b=XumsmAztYIAjv0MMawedgTkIrSCQ6gQkSob5YlAGyBBdx8YmluQwBOZlJEwFtErwUB
         7PPRJpK+cUkPGP6vkbFCO1qLlRAxTGcMoazM6h681j0mmtU40jHWIz4rDagQ7CLLp+Nr
         ai8O4dY3PwQsEkFIC1Ud3ptViP4JvDC5/23vCYOJ/E+HkYEpaO3cNIKK7JQhpyMD2Pj4
         jhU073cUM2z/5GYgdh+EtKb325ZznY9Ov5W3qCrvFUKeV1bCwGijgoBZYLeVu9GB3YCT
         gIuN+4MTKQizX2DzGCcJ6tyZOhM5fWdLsEv8Nao0tQEOfarLKXSx5750PbHvkhe4Ul5I
         TicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935247; x=1758540047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1PJALyJ3qcEXL7gRw/k9T/2UVdjMGD0bdFK5ZSQn5U=;
        b=k92qNJejeQV6QKsjN9uXq0i1FeqLspoZzkpDmJjj9Z8FzZrUPWShyA0PBbCv9dhEdx
         OLDgk+J4b5ajuVDUOnVf/IHtoI4r1/QFpQURkX12kXomN6DOoTvCz4VAjdV2bkxC2RZl
         7X13ppMDhmsVHyBbUdYUX+OISP+cDMLbTHUqrLvQrG3SEvrVL/0MjP2ZuPCiXc6tx2Dv
         U+b2bS9C9Cjki/pLHE6PV+qlMG+BmdLjvVPg87E1ShNIWCh5XShMd4IrnQdLvOkMsBqW
         cs6+sjuz+bLFt7TBG4FgX4aWTNUka/QD4LbLhox6aB+9bb16RudJAeFQw5FhP7v4rw2j
         RPHw==
X-Gm-Message-State: AOJu0YzEbeW3P5ZcPaV0wbWGPk3y1IZa0UUQIZzkMqYzbpwq7jDeuWHa
	yg01DQHIqLHfPDVanp3pb5754FpXhEeyZKlpCxTiIxKSLqRd8qs/d9XvF5jC86yCsQA=
X-Gm-Gg: ASbGncsDlAfxI8DDmu/FZZ+xSpVwhTNUlZkbPU3/9zqy/sEmpoZ5ABuw26efLNko2sX
	m4Ie/NLcZpSov+db97dXUJdypQcUWCLud+kAV8VKWA+8zhlkFutqMlLlGf6kkQGIqqTR1mJESx2
	s4S3lHl3ZEUd5+ax4owfeEZlESh3cF3vxjuojMcO8gAIdd+IcsJjuknjOAR7Hju3N+uLGq/DkGL
	kQlgp+9tPPp03blfgULV4CpPOJKIlRozjWuJl4KtDNiSXi5Swh81vmXdPpip++GQGI8e+vPKfh6
	RZVYN4Y6N8sJGf5tYC32RE+KX7XOlbN0yTIZy9ZyE4bRboxnFFqA7jrUwhptMLzIthgFSTaYgzH
	QEeMxzpDHyL0hRcsqg/S7cJrp8jA8YwiD/G9P+TN1DUQdhdNvJPjddh0IsAk=
X-Google-Smtp-Source: AGHT+IFtpARcVg8vrxstM4b9k81RNhg6aJgqNSrrhWUa8dkwLRcJgVAqZ42reySIf4i/YnsCfavAbQ==
X-Received: by 2002:a05:6000:2313:b0:3ea:6680:8fa1 with SMTP id ffacd0b85a97d-3ea66809518mr3588229f8f.12.1757935246882;
        Mon, 15 Sep 2025 04:20:46 -0700 (PDT)
Received: from [127.0.0.1] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519f67sm91903345e9.1.2025.09.15.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:20:46 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 15 Sep 2025 08:20:31 -0300
Subject: [PATCH v4 2/5] printk: nbcon: Introduce KDB helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-nbcon-kgdboc-v4-2-e2b6753bb566@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757935236; l=4837;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=wjvht/yPMwra8hwA29QVWh/qPUkmI/5GG7pvtVwux7M=;
 b=S+4E1bP7oQwnkigM23tacsltmvI9jBIlJ++NpBZzlgtJahwBU9G9d2aoD8lRC5nalPqz4bRax
 33oc3OYd24bDoiBUxw+q1oXIqpvIfk8yY/Ns/cVoJ6Bx8sE63yiQYUn
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
index 646801813415f0abe40cabf2f28ca9e30664f028..ff218e95a505fd10521c2c4dfb00ad5ec5773953 100644
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


