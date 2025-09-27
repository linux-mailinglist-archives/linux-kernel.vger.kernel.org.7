Return-Path: <linux-kernel+bounces-835088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6542BA63BD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6204F189CCAE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E23D7D3;
	Sat, 27 Sep 2025 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="Li9oEjdH"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010C223DFF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759010757; cv=none; b=P91JsZWw9qn2beOjy/DCXkCkcsMy3lebGFBqGsed83+1CrpD/ldHHUnM7M5iqvxQm8hmxpuU2oP0PeNqRTSm8ZmY3R+gcl8TEGr/iwZTx83dtd5kfuUQ9SWEIpw6hsq+iaTgl8OfDfdH9w3+aGEd4lv/sbnvmsmso4y0GMIkrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759010757; c=relaxed/simple;
	bh=6Go1DY++PRJ2gacF9TNbqcngs9mSCg4eSNAIAeCDEnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZU2S7yf7jgwUN8k/N3p0LQJaeSd7aZ+47qW6ClgxpzoO65h7rC5m6TCNdD4P42eKLP4DD1YB4HGlju0dTy2yFxYPGUQQaFbh/blo1X5ARRd3L0vf8qCzxnEAgCY5zk3pNPK/w93Vj7O3h9pcBFnmMAkn5hu6+Pw38u+DBtykhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=Li9oEjdH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso5704125e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759010754; x=1759615554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNNxigzaCtAeUeqgqnx1pzvYQdhOYm8sMlkgdnR3ZUE=;
        b=Li9oEjdHggT+97UP9/PuxY9KxIK/1h0N9t3PEsbLEuUAkzqOr6HUa4CHAH9Mo4zAkr
         gvuPZKE0xM+cJLQA9vbkl+4Nn7d4JGz9EdsyhSURpkh6IWMGFxnZSgFdJRoAWXL96wJk
         EXZzjMqZZnToN5LbiKyqawsBckjG77tJB+fi2OeFBfewB8epLRw7/G6cXRoYWrIBUk/6
         kn8vmsdfCfxjm6Wus2QpFTLVwArOdVujopCIaJd9N8t8awX3NTQxpM+jAUTLi1rxmER9
         8avGNAqj1sstyKKNTPDUn3EeHvLaT0cwI2tr9talkAxjDpb5JWHQAM+oZcOBbHGq1aTm
         2oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759010754; x=1759615554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNNxigzaCtAeUeqgqnx1pzvYQdhOYm8sMlkgdnR3ZUE=;
        b=fJ4mAlIdUASu2KGBUmA2NcNv+PCiZUUBx9SA4S0mgAAjupmwTp3FlezdzVIFV6/JYI
         nbTfTkjPlkqPQRcqYjbziI3TT1HP+J7b7s2NfZ1n0OK/QHYRdUx5U0iIBhKjXH6yjomw
         w+NCslyyMAzii8r2xfB5BkZbXZobPV7w9WSmk3eslxVhO+LA6lF/i2eLhTSZeMZIz/V+
         DyS0qISdgeGtT8fsl+x0ZC+iZ7wLeUNKdtA00j8uPzZed/O34s+8NX/pfzMqUYvXJYrw
         jMcXeOACKHnFrsEis6qbRb8uPOIyv//+7Oh8U7B2iesu45l36VKiZnV6FWyOMQb0Hxuv
         rm8w==
X-Gm-Message-State: AOJu0YwC67g2rIhFiK4Q3qpeU3EXuLxTnKFsluWRyXg9rm/lN6yZkYvo
	XwhfDGPI4L6C+TVlbweAi10MEfF+v5VSUXw6j5zhzIu6Os1Yes4ilsBRZOdIxu3F36NSCh/IBwG
	AH7Us03NZmw==
X-Gm-Gg: ASbGncv4ua+dSqNpsgXeTxzKdgNvOnEdZpsgy7sepDKPdIK8jAKg2Jo6oby8LQB+2qt
	r9ZvIBG5vzB4ovicWcg3OpNLYM3UdaFb0kPjxjsNUdWcbS8nuYaaIM/z3NwjbAJKvZOmhWZqlTq
	JsCjLcXIxWkZjc4jBxp4TQhaMuK1YKaIrhDpcRlhHnEFkNTaUrG560Aqm1P1J+TPp0+3tSdU5GA
	rJP1vlT5YgANJQaNJbEv8AYUQTcE11NVExzWg9mcqI3lkiEvDF5ulYJ2Hv7UXLGtef/CFwQg6gC
	PDzn7j+mGThpc6ingJQ8u7MeUUoq1vJ/R+RQyJoeo2JhmMGrfunbeD7FTlmth1Lye9MFI82UeqL
	5+hQRG7X4BL6GUSZsPajo2v+XQJ1Wbv9kYroOAKcsQPJfKaY=
X-Google-Smtp-Source: AGHT+IHVfwdUQZduTyYp0srLmKz2EUN2TeLie06yX3Ae8RYG5ycu94VRa35YSBwNyngA8kmofg3blw==
X-Received: by 2002:a05:600c:3153:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-46e32a58b6amr108455435e9.36.1759010753594;
        Sat, 27 Sep 2025 15:05:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm12463730f8f.20.2025.09.27.15.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 15:05:52 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sat, 27 Sep 2025 23:05:35 +0100
Subject: [PATCH v2 1/3] printk: Introduce console_flush_one_record
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-printk_legacy_thread_console_lock-v2-1-cff9f063071a@thegoodpenguin.co.uk>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759010750; l=6109;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=6Go1DY++PRJ2gacF9TNbqcngs9mSCg4eSNAIAeCDEnQ=;
 b=2oYoZx7JraZ8aiZyWar9PVp+wPe3khVT9VGchN1Ca690MX8lPCiKH3DdiSxhssogCG1Uzju+F
 3ILZhUe1BxzC/RO786MKrlaNblb1EUq9wqDgcJvrTsh0kYXWS1rLRd+
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

console_flush_all prints all remaining records to all usable consoles
whilst its caller holds console_lock. This can result in large waiting
times for those waiting for console_lock especially where there is a
large volume of records or where the console is slow (e.g. serial).

Let's extract the parts of this function which print a single record
into a new function named console_flush_one_record. This can later
be used for functions that will release and reacquire console_lock
between records.

This commit should not change existing functionality.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 159 +++++++++++++++++++++++++++++++------------------
 1 file changed, 100 insertions(+), 59 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aaba9d8d877df5e4f1db002d3a596bc..060d4919de320fe21fd7aca73ba497e27c4ff334 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3161,6 +3161,100 @@ static inline void printk_kthreads_check_locked(void) { }
 
 #endif /* CONFIG_PRINTK */
 
+
+/*
+ * Print out one record for each console.
+ *
+ * @do_cond_resched is set by the caller. It can be true only in schedulable
+ * context.
+ *
+ * @next_seq is set to the sequence number after the last available record.
+ * The value is valid only when this function returns true.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock. Otherwise it is set to false.
+ *
+ * @any_usable will be set to true if there are any usable consoles.
+ *
+ * Returns true when there was at least one usable console and a record was
+ * flushed. A returned false indicates there were no records to flush for any
+ * of the consoles. It may also indicate that there were no usable consoles,
+ * the context has been lost or there is a panic suitation. Regardless the
+ * reason, the caller should assume it is not useful to immediately try again.
+ *
+ * Requires the console_lock.
+ */
+static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
+				     bool *any_usable)
+{
+	struct console_flush_type ft;
+	struct console *con;
+	bool any_progress;
+	int cookie;
+
+	any_progress = false;
+
+	printk_get_console_flush_type(&ft);
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags = console_srcu_read_flags(con);
+		u64 printk_seq;
+		bool progress;
+
+		/*
+		 * console_flush_one_record() is only responsible for
+		 * nbcon consoles when the nbcon consoles cannot print via
+		 * their atomic or threaded flushing.
+		 */
+		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+			continue;
+
+		if (!console_is_usable(con, flags, !do_cond_resched))
+			continue;
+		*any_usable = true;
+
+		if (flags & CON_NBCON) {
+			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
+								 !do_cond_resched);
+			printk_seq = nbcon_seq_read(con);
+		} else {
+			progress = console_emit_next_record(con, handover, cookie);
+			printk_seq = con->seq;
+		}
+
+		/*
+		 * If a handover has occurred, the SRCU read lock
+		 * is already released.
+		 */
+		if (*handover)
+			return false;
+
+		/* Track the next of the highest seq flushed. */
+		if (printk_seq > *next_seq)
+			*next_seq = printk_seq;
+
+		if (!progress)
+			continue;
+		any_progress = true;
+
+		/* Allow panic_cpu to take over the consoles safely. */
+		if (other_cpu_in_panic())
+			goto abandon;
+
+		if (do_cond_resched)
+			cond_resched();
+	}
+	console_srcu_read_unlock(cookie);
+
+	return any_progress;
+
+abandon:
+	console_srcu_read_unlock(cookie);
+	return false;
+}
+
 /*
  * Print out all remaining records to all consoles.
  *
@@ -3186,77 +3280,24 @@ static inline void printk_kthreads_check_locked(void) { }
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	struct console_flush_type ft;
 	bool any_usable = false;
-	struct console *con;
 	bool any_progress;
-	int cookie;
 
 	*next_seq = 0;
 	*handover = false;
 
 	do {
-		any_progress = false;
-
-		printk_get_console_flush_type(&ft);
-
-		cookie = console_srcu_read_lock();
-		for_each_console_srcu(con) {
-			short flags = console_srcu_read_flags(con);
-			u64 printk_seq;
-			bool progress;
+		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
+							&any_usable);
 
-			/*
-			 * console_flush_all() is only responsible for nbcon
-			 * consoles when the nbcon consoles cannot print via
-			 * their atomic or threaded flushing.
-			 */
-			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
-				continue;
-
-			if (!console_is_usable(con, flags, !do_cond_resched))
-				continue;
-			any_usable = true;
-
-			if (flags & CON_NBCON) {
-				progress = nbcon_legacy_emit_next_record(con, handover, cookie,
-									 !do_cond_resched);
-				printk_seq = nbcon_seq_read(con);
-			} else {
-				progress = console_emit_next_record(con, handover, cookie);
-				printk_seq = con->seq;
-			}
-
-			/*
-			 * If a handover has occurred, the SRCU read lock
-			 * is already released.
-			 */
-			if (*handover)
-				return false;
-
-			/* Track the next of the highest seq flushed. */
-			if (printk_seq > *next_seq)
-				*next_seq = printk_seq;
-
-			if (!progress)
-				continue;
-			any_progress = true;
-
-			/* Allow panic_cpu to take over the consoles safely. */
-			if (other_cpu_in_panic())
-				goto abandon;
+		if (*handover)
+			return false;
 
-			if (do_cond_resched)
-				cond_resched();
-		}
-		console_srcu_read_unlock(cookie);
+		if (other_cpu_in_panic())
+			return false;
 	} while (any_progress);
 
 	return any_usable;
-
-abandon:
-	console_srcu_read_unlock(cookie);
-	return false;
 }
 
 static void __console_flush_and_unlock(void)

-- 
2.34.1


