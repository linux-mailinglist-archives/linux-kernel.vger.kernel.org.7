Return-Path: <linux-kernel+bounces-848413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E19BBCDB69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40734543F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6002F7AC2;
	Fri, 10 Oct 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6warcY/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486162FAC05
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108616; cv=none; b=CHFHkTB2Tt4a8e3aDMrErFGSTqJuk2l50aGtsw4nio/rvF/U02wziQwCcP08EpkbyZJSIFi9U52YR8ZfP2SQoFnEq4kX9Hca3wlNUinQAwdRIr7fhebFX+sx7W4D6EjozmtbCD1FmsOiHEEGtg+TJYe2T+U2m2GGGvf5yLdwECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108616; c=relaxed/simple;
	bh=A7NZvw6BwM3JH9LFTZM0pkj7MM2Mf/KMJNxtIByaxbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=moxFD0aDz4TL6Ak6EMT7XosPRARdmDFrH3bWUHQDmR8UpUV9EunWWcG0dXbovWztGB1AqaPyA0u2p9ea59EJeH0nHLAG+oNlhGFcG4oMB5vTVVJUvIxi5VNL6kX7qcPiQXZTiHEm2xJutpZ77QnTRuzPxKYpdZPV2eH+eD214ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6warcY/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so2342647b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108613; x=1760713413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=e6warcY/j+AhOFiEH4LxHlRbQra3smYT+AJbRdxXjSayLeYaTRub0OiFUHuEIS52nb
         Mi0FnAxiiAmFgaI8swivggiAWSufyciL59z+wXYbN3JeF3mA7m5g9MRmxqI4f9WbPCda
         ufYyXRiROflhNoEN91DU/Eud0MU+xoPfw/LNgFOp3b5SuNoVOYzKLM8VULC0Ayn0Rp/B
         cuqAy1ztcUNMIqHBSTGaxzCfzwY5FmiBC1kR2R0Gs9BsrWTUXNczFRGZJRaPmBWUEklt
         umGnkTKc1zcC6A4r8p8imJXOURI4ySBbkmIgcgZ8XhDb2ZxtlmfOp7xmzf7AsPcmADGq
         5WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108613; x=1760713413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=O+ZQB2oMiE6wIztndMnM0Nmcw4hZmKiawRuOeP/AnbJulDmhiV3KI6LenSB2Ok0FN/
         Flyr2hthm8VBBAZb5E5+oaV1nFb1ePYa6Aj39TQuEP8FhLDBSsBd8BdO+/dFdrq6viyt
         GArjASpcpsDtbjLpYsLQmEaWKXrjbOIccl4GptmZfL9wDNil4u96NJZm58mDHf3vPc4B
         SPAVvyBq86JK08PdYb+Xc5K8YUWFuf//BitBjGBkIR7NJ2JyR8U9hF+YFw6nrdINv8hW
         2DCgpPGVY1XgXx9+eEE4Kx0dRgu99KpnDaJ5CfEY7hO3q36ESGh2MZUpANg3lkn20wQT
         G9fg==
X-Forwarded-Encrypted: i=1; AJvYcCUIlsoPilZhJF6ANSt3RR61dg9b1roxKxjOHnfcnzYqBc5w3XnP2FpS4nZ1WlSncopFwpVQm2+tmj5T0UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWozs6GcAbNJhuX6+ow/vAjYzgEKG7IDNi730XF4pUmTZVwr8
	a1uRnuG/iNh2UjgMquzW86XNsorYxVFf6e7Y6nc6YqbxovBQQDgiKGEr
X-Gm-Gg: ASbGncuy/LoKk9Q8wIuOLeRINCZxK5UP/yM72J3m+RkXIni7igTObQ3/vi4ycCHynCA
	gkGqRR9kBa1TO8x8mNiARPk6XfKCSgrhuhAQzsa3bctZqv9iFAlAyBsKDnOk1WKkpTiQl+ObEnS
	XcziDIz6AKnsOcZbbtF2yiSfT/F6IDcv4JCGP5bhYWSaalP22os9I7EEgYMql15pvUmTeO+x93J
	0DOgqNbfPhMtoawmNxQGBRIl62ItuLH3n/pXjYEy63x3XghfzGf/qNrjTvnhEz+XHrFPo8g+/SX
	65TGdzdzKXdSNNzWYGIIJ9J9x85blJ9ihKrdUzpFsXAi5tIGcojSgtQhdReG78DCv56x/UGzDn5
	HHCtLD57VG5U8ZUnFBC7QKZTDodRWH5vdxEVc8w07+b/JNFCQHz/LkmfbUqywgQYhoIOg1Gt5yL
	P/4ww=
X-Google-Smtp-Source: AGHT+IFN002D5LEzhcshovKTWIIkwy/kzSyTHAsoxU09irX5bD+tuMRXLGgMawISEMPJETPlzJXvNA==
X-Received: by 2002:a05:6a20:6a22:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-32da8e2ba5cmr14348517637.12.1760108613238;
        Fri, 10 Oct 2025 08:03:33 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:32 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 07/12] timers: Silently ignore timers with a NULL function
Date: Sat, 11 Oct 2025 00:02:47 +0900
Message-Id: <20251010150252.1115788-8-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit d02e382cef06cc73561dd32dfdc171c00dcc416d ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

In preparation for that replace the warnings in the relevant code paths
with checks for timer->function == NULL. If the pointer is NULL, then
discard the rearm request silently.

Add debug_assert_init() instead of the WARN_ON_ONCE(!timer->function)
checks so that debug objects can warn about non-initialized timers.

The warning of debug objects does not warn if timer->function == NULL.  It
warns when timer was not initialized using timer_setup[_on_stack]() or via
DEFINE_TIMER(). If developers fail to enable debug objects and then waste
lots of time to figure out why their non-initialized timer is not firing,
they deserve it. Same for initializing a timer with a NULL function.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/87wn7kdann.ffs@tglx
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 57 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7094b916c854..3b6624cd9507 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,7 +1017,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	unsigned int idx = UINT_MAX;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	debug_assert_init(timer);
 
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1044,6 +1044,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		 * dequeue/enqueue dance.
 		 */
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 
 		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
@@ -1070,6 +1078,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 	} else {
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 	}
 
@@ -1128,8 +1144,12 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
  * mod_timer_pending() is the same for pending timers as mod_timer(), but
  * will not activate inactive timers.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and not modified
+ * * %0 - The timer was inactive and not modified or was in
+ *	  shutdown state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
@@ -1155,8 +1175,12 @@ EXPORT_SYMBOL(mod_timer_pending);
  * same timer, then mod_timer() is the only safe way to modify the timeout,
  * since add_timer() cannot modify an already running timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded. In this case the return value is 0 and meaningless.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires did
  *	  not change the effective expiry time
@@ -1176,8 +1200,12 @@ EXPORT_SYMBOL(mod_timer);
  * modify an enqueued timer if that would reduce the expiration time. If
  * @timer is not enqueued it starts the timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires
  *	  did not change the effective expiry time such that the
@@ -1200,6 +1228,9 @@ EXPORT_SYMBOL(timer_reduce);
  * The @timer->expires and @timer->function fields must be set prior
  * to calling this function.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * If @timer->expires is already in the past @timer will be queued to
  * expire at the next timer tick.
  *
@@ -1228,7 +1259,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(timer_pending(timer) || !timer->function))
+	debug_assert_init(timer);
+
+	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
@@ -1239,6 +1272,13 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 * wrong base locked.  See lock_timer_base().
 	 */
 	base = lock_timer_base(timer, &flags);
+	/*
+	 * Has @timer been shutdown? This needs to be evaluated while
+	 * holding base lock to prevent a race against the shutdown code.
+	 */
+	if (!timer->function)
+		goto out_unlock;
+
 	if (base != new_base) {
 		timer->flags |= TIMER_MIGRATING;
 
@@ -1252,6 +1292,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
+out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
@@ -1541,6 +1582,12 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		fn = timer->function;
 
+		if (WARN_ON_ONCE(!fn)) {
+			/* Should never happen. Emphasis on should! */
+			base->running_timer = NULL;
+			continue;
+		}
+
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
--

