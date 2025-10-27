Return-Path: <linux-kernel+bounces-872075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B660FC0F35A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6375D4FDCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AD93115A2;
	Mon, 27 Oct 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gO5SAdDf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/nTu+t2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B72F6926
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581537; cv=none; b=RfwAuTPfNL2ONdoldAVrqo8C8fm3MS0EF63Y9T5bCRq46RJZ7xHcifN/eiGK0hrIgSD3zOBJ9wCo6gyI69QtWQsI2VmcoTS9lM6NKw9u2PFxVgNtC5DwTeMP/ZDEKVAeOFpuoErn2zAXR1KV9j3jVFU/eYjjNYOB7sQ+Jzs/BGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581537; c=relaxed/simple;
	bh=rN3ZJ6Oqvz6y9b0l4VvkHiMQTpRIyhAf89ziyxwSAvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgFSD61Ef1aNTaZ15JuYbUV+FCI21Xjpr/RNVoHFJfnIe765i6Z3Cm2OjKiY6P2SCmk1umcAPhJP/qfDcsuZDdpQCue1eIdoZpV/v9GTklY6wnsQ+rjWcQL/J5jqiXYZJXQ206kNIsISYnCAGC9arouRY4OZVI7o3o02jhiA21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gO5SAdDf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/nTu+t2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761581533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2ttIHgHfMEsOtMOEhdjSUygzTRteDlwEzhJo6O9OcQ=;
	b=gO5SAdDfpvRYcSMZbuo/DdKDaK3h5+p+4j1vTMuo/juKz2tFEE8dtk1UkaDFW4jkCDILz8
	zL0rQq6TU1QTXSgm6M+cjInKMfTbfZMeNQ8kc3fvcUQ/3Cs8a/ECZOuFLBDY/97ZwLvfaS
	polR6URAGVnqc9DKM4IqKOmVrN81ntvB/S3JZJYbHHJ/4W80cb04rqBAWdekI8UBfA4+sH
	ao+Jt981XW/qf8i/XJT7mGv88On5TfAT9STF4n0DGXvhYxVBn8shkIlndWkjACSmtazWzg
	shUR7Kn3rnmATHOEnfmjf07eBycw3HUcrd9GkAM9KKpgrQipBdnicjnKnwzyuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761581533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2ttIHgHfMEsOtMOEhdjSUygzTRteDlwEzhJo6O9OcQ=;
	b=0/nTu+t2/rDQPuHl8gQ4JyJd2NS3bcbjSNBucbeYrvxGFPVhR1zGwjYqPt1DhJmfdmD8x6
	iH2vZsAKvBDZrsCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>,
	Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic() for panic
Date: Mon, 27 Oct 2025 17:18:03 +0106
Message-ID: <20251027161212.334219-2-john.ogness@linutronix.de>
In-Reply-To: <20251027161212.334219-1-john.ogness@linutronix.de>
References: <20251027161212.334219-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be console drivers that have not yet figured out a way
to implement safe atomic printing (->write_atomic() callback).
These drivers could choose to only implement threaded printing
(->write_thread() callback), but then it is guaranteed that _no_
output will be printed during panic. Not even attempted.

As a result, developers may be tempted to implement unsafe
->write_atomic() callbacks and/or implement some sort of custom
deferred printing trickery to try to make it work. This goes
against the principle intention of the nbcon API as well as
endangers other nbcon drivers that are doing things correctly
(safely).

As a compromise, allow nbcon drivers to implement unsafe
->write_atomic() callbacks by providing a new console flag
CON_NBCON_ATOMIC_UNSAFE. When specified, the ->write_atomic()
callback for that console will _only_ be called during the
final "hope and pray" flush attempt at the end of a panic:
nbcon_atomic_flush_unsafe().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/lkml/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt
---
 include/linux/console.h | 19 ++++++++++++++---
 kernel/printk/nbcon.c   | 45 ++++++++++++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d17f1f525bec9..5f17321ed962b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -186,6 +186,8 @@ static inline void con_debug_leave(void) { }
  *			printing callbacks must not be called.
  * @CON_NBCON:		Console can operate outside of the legacy style console_lock
  *			constraints.
+ * @CON_NBCON_ATOMIC_UNSAFE: The write_atomic() callback is not safe and is
+ *			therefore only used by nbcon_atomic_flush_unsafe().
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -197,6 +199,7 @@ enum cons_flags {
 	CON_EXTENDED		= BIT(6),
 	CON_SUSPENDED		= BIT(7),
 	CON_NBCON		= BIT(8),
+	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
 };
 
 /**
@@ -608,6 +611,7 @@ extern void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+extern bool nbcon_allow_unsafe_takeover(void);
 extern bool nbcon_kdb_try_acquire(struct console *con,
 				  struct nbcon_write_context *wctxt);
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
@@ -627,9 +631,18 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 		return false;
 
 	if (flags & CON_NBCON) {
-		/* The write_atomic() callback is optional. */
-		if (use_atomic && !con->write_atomic)
-			return false;
+		if (use_atomic) {
+			/* The write_atomic() callback is optional. */
+			if (!con->write_atomic)
+				return false;
+
+			/*
+			 * An unsafe write_atomic() callback is only usable
+			 * when unsafe takeovers are allowed.
+			 */
+			if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !nbcon_allow_unsafe_takeover())
+				return false;
+		}
 
 		/*
 		 * For the !use_atomic case, @printk_kthreads_running is not
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fdd1cbebe77d8..254f7b79da5e7 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1408,6 +1408,26 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
+/*
+ * Track if it is allowed to perform unsafe hostile takeovers of console
+ * ownership. When true, console drivers might perform unsafe actions while
+ * printing. It is externally available via nbcon_allow_unsafe_takeover().
+ */
+static bool panic_nbcon_allow_unsafe_takeover;
+
+/**
+ * nbcon_allow_unsafe_takeover - Check if unsafe console takeovers are allowed
+ *
+ * Return:	True, when it is permitted to perform unsafe console printing
+ *
+ * This is also used by console_is_usable() to determine if it is allowed to
+ * call write_atomic() callbacks flagged as unsafe (CON_NBCON_ATOMIC_UNSAFE).
+ */
+bool nbcon_allow_unsafe_takeover(void)
+{
+	return panic_on_this_cpu() && panic_nbcon_allow_unsafe_takeover;
+}
+
 /**
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts
@@ -1478,7 +1498,6 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
- * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
  *		failure.
@@ -1497,8 +1516,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * returned, it cannot be expected that the unfinalized record will become
  * available.
  */
-static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
-					    bool allow_unsafe_takeover)
+static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
@@ -1507,7 +1525,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->console			= con;
 	ctxt->spinwait_max_us		= 2000;
 	ctxt->prio			= nbcon_get_default_prio();
-	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
+	ctxt->allow_unsafe_takeover	= nbcon_allow_unsafe_takeover();
 
 	if (!nbcon_context_try_acquire(ctxt, false))
 		return -EPERM;
@@ -1538,15 +1556,13 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
- * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * This will stop flushing before @stop_seq if another context has ownership.
  * That context is then responsible for the flushing. Likewise, if new records
  * are added while this context was flushing and there is no other context
  * to handle the printing, this context must also flush those records.
  */
-static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
-					   bool allow_unsafe_takeover)
+static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 {
 	struct console_flush_type ft;
 	unsigned long flags;
@@ -1561,7 +1577,7 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	 */
 	local_irq_save(flags);
 
-	err = __nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
+	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
 
 	local_irq_restore(flags);
 
@@ -1593,9 +1609,8 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
  * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
- * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeover)
+static void __nbcon_atomic_flush_pending(u64 stop_seq)
 {
 	struct console *con;
 	int cookie;
@@ -1613,7 +1628,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (nbcon_seq_read(con) >= stop_seq)
 			continue;
 
-		nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
+		nbcon_atomic_flush_pending_con(con, stop_seq);
 	}
 	console_srcu_read_unlock(cookie);
 }
@@ -1629,7 +1644,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
  */
 void nbcon_atomic_flush_pending(void)
 {
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
 }
 
 /**
@@ -1641,7 +1656,9 @@ void nbcon_atomic_flush_pending(void)
  */
 void nbcon_atomic_flush_unsafe(void)
 {
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
+	panic_nbcon_allow_unsafe_takeover = true;
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	panic_nbcon_allow_unsafe_takeover = false;
 }
 
 /**
@@ -1848,7 +1865,7 @@ void nbcon_device_release(struct console *con)
 		 * using the legacy loop.
 		 */
 		if (ft.nbcon_atomic) {
-			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
+			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
 		} else if (ft.legacy_direct) {
 			if (console_trylock())
 				console_unlock();
-- 
2.47.3


