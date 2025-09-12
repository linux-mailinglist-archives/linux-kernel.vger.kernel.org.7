Return-Path: <linux-kernel+bounces-813956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC010B54D81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99383B9EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A53054FD;
	Fri, 12 Sep 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ifdymclk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2nZeHfA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0850301017
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679537; cv=none; b=YtKX+i+jj4XAyW6uFE+GMiBib+K4PDn2YuR0k17XTrGTFhtCZLYrTUXdgqkOf/c/Gmo1lXww55sd03SWDgo3Zr+zXVPR2JjRd+L1mqPqeX+cCrPUAn+uErxU6M3nIzNvPK9lCoi+LCPhl7LAbgINTfL5Olgrc5pCQOuj56eIz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679537; c=relaxed/simple;
	bh=fyW7GFbsaWOLHeuB9pm9AGz9JXHjUdAAFOul/psXJqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s78mrnHQ6733CquNYTCeACVYPuKLvtlzYsuuup4PBrJ4kEdyHAThENZW9X4jvHaVQaP/rKZ4c3uqESCE8mTXopsWh0GjExaCpfQbpHReimRjfl/WVJRGglRwH4xmuiGGqN7pCPTqSRdxpX+pZ/SCXWQ1qh4NSN0LZwjFkKfnXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ifdymclk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2nZeHfA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757679533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s01I4M7K8KiYxqXAEs+ns3YqA8KspJFEjH/PBqZOSRs=;
	b=Ifdymclk0/onu0KQZ46LaQIzx3pmG4mffHDhZnHD3/GYPXgdLeEW4tESM0Ldir+ksR81dF
	e4y1QAfAxHdbUEBlO/24fFIGba9KYYa6R4ZgsVtu35rFe/WsNQ86vKMu3W2gNWxsnGnHyS
	+0bos8b7h4hJGaVobpzt0fQeqPyjXExjt6DBFxNuIrxzhFZFKJSuhX1iRlK34PuCGYPO2c
	k9p10WB89fdOfUVAPivkURNXWAcfVeD5ZhkHP+D9b6MZT4hfRM1TuVREVLXkUQnmIrBUv1
	Q/yGreHVCecoowMPbjT4RzFblQ75UHHMHgcLDANa6ik1GjxP7RtnVxl998Dmlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757679533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s01I4M7K8KiYxqXAEs+ns3YqA8KspJFEjH/PBqZOSRs=;
	b=w2nZeHfANadT8nO/sggdGLWYUrQcZCzh0DzY+MuBEDx4AdhdAncnSzMt5yOgfBJwYxldj5
	uZTTBEmOOR/tzGDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>,
	Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic() for panic
Date: Fri, 12 Sep 2025 14:24:52 +0206
Message-Id: <20250912121852.2666874-2-john.ogness@linutronix.de>
In-Reply-To: <20250912121852.2666874-1-john.ogness@linutronix.de>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
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
callback for that console will *only* be called during the
final "hope and pray" flush attempt at the end of a panic:
nbcon_atomic_flush_unsafe().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/lkml/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt
---
 include/linux/console.h |  3 +++
 kernel/printk/nbcon.c   | 17 ++++++++++++++---
 kernel/printk/printk.c  | 23 ++++++++++++++++-------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85bb4..ec68ecd13f85 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -185,6 +185,8 @@ static inline void con_debug_leave(void) { }
  *			printing callbacks must not be called.
  * @CON_NBCON:		Console can operate outside of the legacy style console_lock
  *			constraints.
+ * @CON_NBCON_ATOMIC_UNSAFE: The write_atomic() callback is not safe and is
+ *			therefore only used by nbcon_atomic_flush_unsafe().
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -196,6 +198,7 @@ enum cons_flags {
 	CON_EXTENDED		= BIT(6),
 	CON_SUSPENDED		= BIT(7),
 	CON_NBCON		= BIT(8),
+	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
 };
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415..8c2966b85ac3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -972,14 +972,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	/*
 	 * This function should never be called for consoles that have not
 	 * implemented the necessary callback for writing: i.e. legacy
-	 * consoles and, when atomic, nbcon consoles with no write_atomic().
+	 * consoles and, when atomic, nbcon consoles with no write_atomic()
+	 * or an unsafe write_atomic() without allowing unsafe takeovers.
 	 * Handle it as if ownership was lost and try to continue.
 	 *
 	 * Note that for nbcon consoles the write_thread() callback is
 	 * mandatory and was already checked in nbcon_alloc().
 	 */
-	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
-			 !(console_srcu_read_flags(con) & CON_NBCON))) {
+	if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_NBCON) ||
+			 (use_atomic &&
+			  (!con->write_atomic ||
+			   (!ctxt->allow_unsafe_takeover &&
+			    (console_srcu_read_flags(con) & CON_NBCON_ATOMIC_UNSAFE)))))) {
 		nbcon_context_release(ctxt);
 		return false;
 	}
@@ -1606,6 +1610,13 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!console_is_usable(con, flags, true))
 			continue;
 
+		/*
+		 * It is only allowed to use unsafe ->write_atomic() from
+		 * nbcon_atomic_flush_unsafe().
+		 */
+		if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !allow_unsafe_takeover)
+			continue;
+
 		if (nbcon_seq_read(con) >= stop_seq)
 			continue;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..1cfc6801eed0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3206,13 +3206,22 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			u64 printk_seq;
 			bool progress;
 
-			/*
-			 * console_flush_all() is only responsible for nbcon
-			 * consoles when the nbcon consoles cannot print via
-			 * their atomic or threaded flushing.
-			 */
-			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
-				continue;
+			if (flags & CON_NBCON) {
+				/*
+				 * console_flush_all() is only responsible for nbcon
+				 * consoles when the nbcon consoles cannot print via
+				 * their atomic or threaded flushing.
+				 */
+				if (ft.nbcon_atomic || ft.nbcon_offload)
+					continue;
+
+				/*
+				 * It is only allowed to use unsafe ->write_atomic() from
+				 * nbcon_atomic_flush_unsafe().
+				 */
+				if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !do_cond_resched)
+					continue;
+			}
 
 			if (!console_is_usable(con, flags, !do_cond_resched))
 				continue;
-- 
2.39.5


