Return-Path: <linux-kernel+bounces-777324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC0B2D824
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11956563881
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555A2E3B03;
	Wed, 20 Aug 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHU/jPqO"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9B2E3AF3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681489; cv=none; b=CiILXsuAUjgFf8TQIXv8njdmDSEYknIbd9mW1D+2UleEUW7yWWHQR6BEKXbMuIhqAzAqo6FZVuiLO1lmc3ciwtpQ44YCcQ4d2yQtboNKUnQ+IZl8lbdHBBC84U/+HuouBCA86drWqBi65Vm2m+jd8qgKOryl42N3/YDBHYdovTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681489; c=relaxed/simple;
	bh=fvpf6gD/xruiPzcHNssl/1iOq8iDBE8RraYBxLIbPtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqM8xiAtSnA1Arov3a+5v32KFuK3/cx+rJnq8urJlZuoktnI0JKvNV0r4ZiZEURt8Dad0v14yYzOF26vMAgU7xO//xCKKAHh6wV1ok2mD+OeDXiqGSJ/YW3PwWVLeOjNEgmp8tppsw4Sr2CsRoWmdZpSZGEhRG+1+aq3aEy5YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHU/jPqO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e7af160f1so1658004b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681487; x=1756286287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk4id58LYwrdHhM1KMFw/JrWQGSX7dxtJHkJKzAUMeI=;
        b=VHU/jPqOJ4rkUUA5sWTA88ZLAQqZKi7GUN4kuda+jLKHhzEIaU2xzqgCO5zJm7WvCd
         NNhYgUSYU5ycD0ysuJFHTVFriybnWZkadEqMTJLbsmkfQ6MOiCcST3N3dlSWfeZ4Omvg
         Jv9KLJFEw/XLhjGOj9Npb3gmmNFnrCuTPXcj8LcmwvhCyQwrJT+pcINIxUGwtEPMOWdD
         mKNSl3NE/NK7VlMzN7URinbBJxv1/swaByLgMBeEs+bkPn6kJK0HLYmE+4lGog/oN3TS
         eBwSES/iUrDJ0HSqmKgxLXlFGmjLI1jpQQEKYFa63/yWLa8CJ8XCMYADqgx8tSWqciil
         seRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681487; x=1756286287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk4id58LYwrdHhM1KMFw/JrWQGSX7dxtJHkJKzAUMeI=;
        b=Jt4IBXYPN/yztP9NyUYPPpGkVpD0Bs7/cZ/JJ72GohGWChqph5bEEyH5+1D9UkLzQu
         xgaF1L/AK2NDWeIsjWGhtntc+sQKrcfs9NepLBNs5wEvzLmKNYKEjzfy6unKDBq231/w
         K1O7sgdgK87+Corge5gIYBkssLHoPR0r1PMgmHm1QZKYh1o/o86rEj7AO0hdUbOgLSzP
         WcHfcnfPZ4n08vgzc9gnv4xmY0s3lhKtJ5EHdaN10Y0eJgj+E9ocg0cBL3CFl1+9199s
         6MpOyYwggaPk0DQlhWq2yxJ5u4znPAL9DXgyb/+DO/L+9atpGc0cp72/rN1zLXzBICJU
         qInQ==
X-Gm-Message-State: AOJu0YzWossKpLDJXZqu2a87/s76M5sNdvsczvvk9KVPMJTXmYFMJ7Lg
	U9ors3jvGwQRqvPCid0Z/efmVyFzNQTim8DIGdfKSDLRFVqtnnPpDoxh
X-Gm-Gg: ASbGncs+Yo0Bn0t8FUdGHOo/CUnzvY5YrWyYx/usOi/8X/hxCWX9Fxrvt3sNCaBb4WN
	u3mbvQW2PGJe6iUmTQZv7iHtVgraGH6SMO0KpvZPbBMajK/YKvd6yWwwh0mdsGnGvihVCpXw2tO
	dQD9VNlUjVRWddZXKhNyRFOxjievRnNdbEboJUPJ60+cCZ00X/WheQrvjIa0eFZ1GUkkk2ibXpf
	dhpH5mwIOCz3xNzHbCpawDMDdgP1XbD/xFpDx883LmsIL3lrpvbwITo/7RcddXxCZHK5VGl4JIZ
	I6xcuq3OSroXH9UZPaseteIA8KXpS54Wg0DiY5517LCDcmmbBFq85PEkur69o6jyRsl9QH3A6xC
	F1RbNwbqdyTqjps5Jp0hGpTI10uk/3TDPzMkBPgwhbWFJ4E7nroHw9lofLWJ83DoWwtNJ3evCiF
	E5ctny
X-Google-Smtp-Source: AGHT+IEWDiz6JAWnPeRzkxcpd38t0vdvL9nqppMRb4d9Cxzipo6xXGDDvceC8KWekpj+k44/+WSi5Q==
X-Received: by 2002:a05:6a00:800d:b0:76b:fb4a:118c with SMTP id d2e1a72fcca58-76e8dd45049mr3124227b3a.18.1755681486400;
        Wed, 20 Aug 2025 02:18:06 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:18:05 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	wangjinchao600@gmail.com,
	namcao@linutronix.de,
	sravankumarlpu@gmail.com
Subject: [PATCH 8/9] panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()
Date: Wed, 20 Aug 2025 17:14:53 +0800
Message-ID: <20250820091702.512524-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-8-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
 <20250820091702.512524-8-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper other_cpu_in_panic() duplicated
logic already provided by panic_on_other_cpu().

Remove other_cpu_in_panic() and update all
users to call panic_on_other_cpu() instead.

This removes redundant code and makes panic
handling consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/printk/internal.h |  1 -
 kernel/printk/nbcon.c    |  8 ++++----
 kernel/printk/printk.c   | 19 ++++---------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ef282001f200..f72bbfa266d6 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -332,7 +332,6 @@ struct printk_message {
 	unsigned long		dropped;
 };
 
-bool other_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c6d1a4a747e9..171480135830 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -255,7 +255,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * opportunity to perform any necessary cleanup if they were
 		 * interrupted by the panic CPU while printing.
 		 */
-		if (other_cpu_in_panic() &&
+		if (panic_on_other_cpu() &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}
@@ -310,7 +310,7 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	 * Event #2 implies the new context is PANIC.
 	 * Event #3 occurs when panic() has flushed the console.
 	 * Event #4 occurs when a non-panic CPU reacquires.
-	 * Event #5 is not possible due to the other_cpu_in_panic() check
+	 * Event #5 is not possible due to the panic_on_other_cpu() check
 	 *          in nbcon_context_try_acquire_handover().
 	 */
 
@@ -349,7 +349,7 @@ static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	/* Note that the caller must still remove the request! */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return -EPERM;
 
 	/*
@@ -447,7 +447,7 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 	 * nbcon_waiter_matches(). In particular, the assumption that
 	 * lower priorities are ignored during panic.
 	 */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return -EPERM;
 
 	/* Handover is not possible on the same CPU. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index faa8b1f0585b..236f03937107 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -346,17 +346,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-/*
- * Return true if a panic is in progress on a remote CPU.
- *
- * On true, the local CPU should immediately release any printing resources
- * that may be needed by the panic CPU.
- */
-bool other_cpu_in_panic(void)
-{
-	return (panic_in_progress() && !panic_on_this_cpu());
-}
-
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2391,7 +2380,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic() &&
+	if (panic_on_other_cpu() &&
 	    !debug_non_panic_cpus &&
 	    !panic_triggering_all_cpu_backtrace)
 		return 0;
@@ -2827,7 +2816,7 @@ void console_lock(void)
 	might_sleep();
 
 	/* On panic, the console_lock must be left to the panic cpu. */
-	while (other_cpu_in_panic())
+	while (panic_on_other_cpu())
 		msleep(1000);
 
 	down_console_sem();
@@ -2847,7 +2836,7 @@ EXPORT_SYMBOL(console_lock);
 int console_trylock(void)
 {
 	/* On panic, the console_lock must be left to the panic cpu. */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
@@ -3227,7 +3216,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (other_cpu_in_panic())
+			if (panic_on_other_cpu())
 				goto abandon;
 
 			if (do_cond_resched)
-- 
2.43.0


