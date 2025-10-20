Return-Path: <linux-kernel+bounces-861243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D728BF225B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445404284F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47E26E71E;
	Mon, 20 Oct 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="ZRBKGBK0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741E266576
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974699; cv=none; b=NDhplcICGgDuxKXENAC1va+ZiVZz/V299BdLiGF7SuRM3xzX01kYebdTwvtrDfx0Fa9s8d0wQ1A4PQu5guity6pawWAcxHV286dH1SkiGVu2YPOhyYf3FVd2OeiNUjPr3/el1ddYnZEQ15HxhBZDAkqeC5/glAlgSkWP1KmroMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974699; c=relaxed/simple;
	bh=uGtC4t047/rFjSTLtwDg469HRCpOfVdjh9yBOW3i+JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoBa8t2AZ0u9dHpeljo3MHtFvizkhJhQBgBNm+aHs91TLFMMVsezBxoo8vSyX1xLlRS5YfS03iOkVsrRgMVsb3Aehu9KxwaiEtnDr+dA5Do+gDCDorzeEpkqpSxti0AzbS65HIRHtlNt+9L8zi+Sv4BwueSeEijCPWvw2JlD8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=ZRBKGBK0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46b303f7469so35596505e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1760974695; x=1761579495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEbCrTVr0olcFFDGZoZ0e0aGakadOIG3mUwviakGfVg=;
        b=ZRBKGBK0EO+7957E2EF1F7UIPdRgIj/vGxwZ9PNzMTE1PVa3z3V9fOU53bj9ivSmtn
         vzsQFW/vC2y14Kvj9DhwYfu0mcHUPzM2jW3M/N08ohEggCEI5GxTJQA1uW8tAn1PE8mJ
         s+Chvn8MCBUt2r3B3B1zcFxFDGyoPpi2VadJuHq+kAU8ryk9AFkQqRHHqeu+F58FbC7D
         stEoilb0qIqDLuXV3x4qQ4KVLJhNuITRH0aDQdIOw8DEx4Qy0P40M9x+oQE0FP2wGcM7
         syYbCRGOEtGLZtM37jGk1bZfkAt9SFVQq3sxraybB6QpvNQbflPmyWucSfXhU01UP8bz
         1hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974695; x=1761579495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEbCrTVr0olcFFDGZoZ0e0aGakadOIG3mUwviakGfVg=;
        b=QpBizE23eX2WQTPoiCc/h2c4VvfPRktkG0zFedPQxubnnPNO7nRNvTffN2XZ+Dr99o
         IETY0uRdc12PWoY4en5A7LxGc1tq6vdW3BiGatjKbnW2QYiy+tDZ9xlOCIgi8n/Qi5Kn
         1Hf/h7flHnM3kmIRUdUo+wAXAfovMdYJEDwnLC4aINLGgZRyVbHcqmLc4BABQRMdpU66
         20n/5CS44i9nHpi8e3BFMppLpA1Fg6dKWwzZau9/ovblK6ncweB79K3SwA1O8Hv+mwdk
         6SwlGAlxQ8kHXdNvuUmAKHBlr63q0LSTizZsnyoge426oNAFzebaHkWNM7kZ++Fpy5kT
         Y0Bw==
X-Gm-Message-State: AOJu0YzCt/9w+a8zbrXBcoLZQcuS+BLz3lwyN6/sz8Z8McrvW8nS4XaC
	Nz64rTJ8ELqBUUb+Rbj8VxdrXUa81XJtFipS5QpnHxeXR5pbDwyRtAfCT93gZG+GK2RX3MviO80
	uqze6YKEsbisJ
X-Gm-Gg: ASbGncuTfOrZ6g6c76MVu5imO7z7HVd/BGFJV9h3D9YKrYb4SIPLrg6qJYqFN2btvJT
	O0TwL7UzfgHyyxOZKMuQrBAw0hqgB210jaTVsUIuWaw6iZyZMu81yKKuWoW5gkqgB/ffGQ6t/OX
	3FrFYnlssKD+y2HG7dweR2PCGs9C16K6CnZu3w1JMh+u3LVoQvkaDznqlfv5jQoQRfXffol/GJK
	rpg0xMqMVfla2Jne5iaqC0MBg9QPnXcqna4ixIWCJN9NYjkvn92ZGPPPKOUQZYVKcaTdbAg9ubD
	7UKo2MLnmPigTvZeZQ+zR24FFgGzaJRvCl9UJabIvloN/QrMfQv5QBVw/qqK8OiUoFkDRHn+aqj
	seORso+3NNkUF8WxpsInQ4cUKiXwSISbRs/ECOZ5zQPmXFk7NBcY8rCMBg9p8xS4UNpKGtOyAl5
	MeZ3riG+YdzTr0cFZAOPorkdx1GcDthjZQMVE=
X-Google-Smtp-Source: AGHT+IEseEwR9zmogG0q83EyxVyrhwIyDQNXmGRLK6zRRXD9i/0l4M2Pgeqd9EobHiaWVHycYQt9Hw==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-47117874978mr98326265e9.3.1760974694999;
        Mon, 20 Oct 2025 08:38:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm120631405e9.2.2025.10.20.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:38:14 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 20 Oct 2025 16:38:06 +0100
Subject: [PATCH v3 2/3] printk: console_flush_one_record() code cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-printk_legacy_thread_console_lock-v3-2-00f1f0ac055a@thegoodpenguin.co.uk>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760974692; l=5716;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=/GOC6iFiS3tZ2dCMgEbMJDcl4Mfq8uze6DfWdcXyQ6M=;
 b=k0C67lyt9xBYRmBULFh5sYAEQQazyRVf8xLF1fk/C47cfvBJvU4LcrKZvXr/b9kd85xsk4Y+9
 jeYGGQfFqIyDS5BH8RC1t3AE1pvGY4vqCaC5HOjsNFb/Tyz3h4UI5/9
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

From: Petr Mladek <pmladek@suse.com>

console_flush_one_record() and console_flush_all() duplicate several
checks. They both want to tell the caller that consoles are not
longer usable in this context because it has lost the lock or
the lock has to be reserved for the panic CPU.

Remove the duplication by changing the semantic of the function
console_flush_one_record() return value and parameters.

The function will return true when it is able to do the job. It means
that there is at least one usable console. And the flushing was
not interrupted by a takeover or panic_on_other_cpu().

Also replace the @any_usable parameter with @try_again. The @try_again
parameter will be set to true when the function could do the job
and at least one console made a progress.

Motivation:

The callers need to know when

  + they should continue flushing => @try_again
  + when the console is flushed => can_do_the_job(return) && !@try_again
  + when @next_seq is valid => same as flushed
  + when lost console_lock => @takeover

The proposed change makes it clear when the function can do
the job. It simplifies the answer for the other questions.

Also the return value from console_flush_one_record() can
be used as return value from console_flush_all().

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 59 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1c048c66d09919967e57326e1732bd17c10f3c76..6c846d2d37d9d20bad58c6e3a7caada3be9552ca 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3142,31 +3142,33 @@ static inline void printk_kthreads_check_locked(void) { }
  * context.
  *
  * @next_seq is set to the sequence number after the last available record.
- * The value is valid only when there is at least one usable console and all
- * usable consoles were flushed.
+ * The value is valid only when all usable consoles were flushed. It is
+ * when the function returns true (can do the job) and @try_again parameter
+ * is set to false, see below.
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
  * console_lock. Otherwise it is set to false.
  *
- * @any_usable will be set to true if there are any usable consoles.
+ * @try_again will be set to true when it still makes sense to call this
+ * function again. The function could do the job, see the return value.
+ * And some consoles still make progress.
  *
- * Returns true when there was at least one usable console and a record was
- * flushed. A returned false indicates there were no records to flush for any
- * of the consoles. It may also indicate that there were no usable consoles,
- * the context has been lost or there is a panic suitation. Regardless the
- * reason, the caller should assume it is not useful to immediately try again.
+ * Returns true when the function could do the job. Some consoles are usable,
+ * and there was no takeover and no panic_on_other_cpu().
  *
  * Requires the console_lock.
  */
 static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
-				     bool *any_usable)
+				     bool *try_again)
 {
 	struct console_flush_type ft;
-	bool any_progress = false;
+	int any_usable = false;
 	struct console *con;
 	int cookie;
 
+	*try_again = false;
+
 	printk_get_console_flush_type(&ft);
 
 	cookie = console_srcu_read_lock();
@@ -3185,7 +3187,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 		if (!console_is_usable(con, flags, !do_cond_resched))
 			continue;
-		*any_usable = true;
+		any_usable = true;
 
 		if (flags & CON_NBCON) {
 			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
@@ -3201,7 +3203,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		 * is already released.
 		 */
 		if (*handover)
-			return false;
+			goto fail;
 
 		/* Track the next of the highest seq flushed. */
 		if (printk_seq > *next_seq)
@@ -3209,21 +3211,28 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 		if (!progress)
 			continue;
-		any_progress = true;
+
+		/*
+		 * An usable console made a progress. There might still be
+		 * pending messages.
+		 */
+		*try_again = true;
 
 		/* Allow panic_cpu to take over the consoles safely. */
 		if (panic_on_other_cpu())
-			goto abandon;
+			goto fail_srcu;
 
 		if (do_cond_resched)
 			cond_resched();
 	}
 	console_srcu_read_unlock(cookie);
 
-	return any_progress;
+	return any_usable;
 
-abandon:
+fail_srcu:
 	console_srcu_read_unlock(cookie);
+fail:
+	*try_again = false;
 	return false;
 }
 
@@ -3252,24 +3261,18 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	bool any_usable = false;
-	bool any_progress;
+	bool try_again;
+	bool ret;
 
 	*next_seq = 0;
 	*handover = false;
 
 	do {
-		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
-							&any_usable);
+		ret = console_flush_one_record(do_cond_resched, next_seq,
+					       handover, &try_again);
+	} while (try_again);
 
-		if (*handover)
-			return false;
-
-		if (panic_on_other_cpu())
-			return false;
-	} while (any_progress);
-
-	return any_usable;
+	return ret;
 }
 
 static void __console_flush_and_unlock(void)

-- 
2.34.1


