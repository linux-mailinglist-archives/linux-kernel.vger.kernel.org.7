Return-Path: <linux-kernel+bounces-861242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDDBF2258
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F8142835B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7B26E161;
	Mon, 20 Oct 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="vK3ATPo5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776591A316E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974698; cv=none; b=B4MbtFN1gfeoLK5uNig5lKrAXIBcdb1jUSlEaYGve0zdu6WRuu83uDT9dMjdQg8kE5ztRbuFY+0ecYWE/9XVZdII5xF+lSVknesjWigJdmHDz1Y/7JHoexFMFyLCapCF1lSo6RofKYDzx/tm/I+P2KMsDgHjCNItCpvnkReu1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974698; c=relaxed/simple;
	bh=aGybOktdhkgeSQs+rX+F7ywh/2yjyEU3TPcl+RFqWQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpRBLChtKqHHkr9NJ0FyTTOU3vlni+xOkrIzmQZzW4va2j4zTWgQGcR5ypkzLF0hcpDAyTCZZdfkj+FcZQEgF2hjSXyUvMK2NRdGASHqT52PhwCa+arwJRbPVKF7Y3p1IdVn00b0V3DWpg0yy8lyM5UlYXd8/f1LeYPVMLHzsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=vK3ATPo5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426fc536b5dso2429522f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1760974694; x=1761579494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyuJNWxnHafy+PPLjmM+EIGmoAJm4KiwAsY+kP7vYUw=;
        b=vK3ATPo5VB3IVnqsPhU49vScodlYrb4LSrd/M5WWhwz3zvE29M9zQDeWjOINPz5Xci
         CZLr3lhLxdxk/Qv/CNyAJShHq04fx1EL6PSmSDQP2bWgTcqyMxv5JQfgNLtHJIg/Yvwu
         H4FyuXiNYnyz6l8/AgE9pjp+Mxg79etLcDcVKDFllMKLrCVVTJMNwHPXu/U7jz75UPzV
         l8EK79197TT1ox1hOeknWvCQ5wkXfN1CEMSUp9DtlrpYWNwwtiFqd9jD4PnHx7VdVIhu
         /fQmErK2L2MJLLoliSRGKqNfXvozYe0+G1lfjWNm5Nl2KJ0pjqi0LdonEIvqbQkTgaCs
         04BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974694; x=1761579494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyuJNWxnHafy+PPLjmM+EIGmoAJm4KiwAsY+kP7vYUw=;
        b=e4mbfB6pjk1+/6quxOknrKmrImVA09HZdUZMozfT6DzWlrqgrMpnKhZZFMFiMcM9hf
         PjPMEwnzln4h4nhgDng+eYbNBVGfTnlLltlb85ckTuwFNWsE0FeBp40gtuWLoHgOlrIZ
         zPxKwam+pUS9fdqMDKYQOXqb5IfipXirpZpfIQI6VqcmDG2le8bHG11hw6hF+PPWeoVo
         iT2XYTLJrYgis1QdhQWffZRZ1F4hEfQsDY4//Td+K1DkCyuF0PQn9UsOl8iGPMNuG0DB
         1M7667o5x+jPgSskzL40/zQ3YX7zNBaPWSk26BOlfp6ahSwMdOCMxS4Oz1GwQpd1c1Qx
         Gedw==
X-Gm-Message-State: AOJu0YzHE0iZI0AHO10V8R4IcCHfFXTtNvSDMe6Df5+KV6827/k2nmby
	CR4jh5qKSCg5/7z10/kz7h1t23Wbxs6r+ZbiMfDxyZfDj5mWFLseYG+HEhF7vxBrj2urAXHl1i2
	tSsML762Oez9i
X-Gm-Gg: ASbGncvul0fbVrTnYMRtcMbgSTBg6v+TRP1CXUQ9b5FXJAbqBIq2aDjV1tvWDOU2G2I
	oGhML5eGdYaresr2rXq45W1uLMiyqIj/6iYqFSUTWfEKLv2/3YzB5p0mlikyxsngnas3d4LmCBz
	yrnoFchWgEIcb7Rsyjg2Nv0t7cI9KWFwsUUjKnusX/Lq9ToDa2z6Z8xf3FkQ5t9pDkNb+Zlg2w0
	VAZguH+GuHG6Rgz/BXmBPmKZjzXv3fXxVNsL0+q54mCHBOFya2paFMTVc5tViRcRNMYWrtGnbIR
	TsZZBw4D0rSXEetDtjWEN1ZklENWkNiyrEpkdP/KiACyJrLc9MB9+TCQSG67UpkjdQorhl0vNey
	4yYOwxKV4ZIfypI/CGW0w0G0ZcQkjo/3TxW81wMPabiYnaUASxTW+FB3e5OVEvbeT7ENhTwrime
	MnJosaiy+cO12tNfp1pDxzbOwb
X-Google-Smtp-Source: AGHT+IGkV4ZKtP7KkxgQHB3S9drQol6zdtqvnkbisQIINbPnlfhd87f1zuu14TLOrLcDBclV2LIrCA==
X-Received: by 2002:a05:6000:4010:b0:425:8502:f8c3 with SMTP id ffacd0b85a97d-42704d7e9e0mr9233918f8f.1.1760974694303;
        Mon, 20 Oct 2025 08:38:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm120631405e9.2.2025.10.20.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:38:13 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 20 Oct 2025 16:38:05 +0100
Subject: [PATCH v3 1/3] printk: Introduce console_flush_one_record
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-printk_legacy_thread_console_lock-v3-1-00f1f0ac055a@thegoodpenguin.co.uk>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760974692; l=6139;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=aGybOktdhkgeSQs+rX+F7ywh/2yjyEU3TPcl+RFqWQg=;
 b=6EMW4r3t5Yx8fh4/AX1u3HHYz+8W9zfUKZ7J5NsH2z6Yf7QzNRSoc9bOumYnAwSkJp5Y04O2X
 CFnM0e8BgjFBAPUICqnJw1bcE7dkTS23HFj9OzL8zQJilsA7ZWA1xWz
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
 kernel/printk/printk.c | 158 +++++++++++++++++++++++++++++++------------------
 1 file changed, 99 insertions(+), 59 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9a5e7bfadb0266a77bfa569e50e51..1c048c66d09919967e57326e1732bd17c10f3c76 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3134,6 +3134,99 @@ static inline void printk_kthreads_check_locked(void) { }
 
 #endif /* CONFIG_PRINTK */
 
+
+/*
+ * Print out one record for each console.
+ *
+ * @do_cond_resched is set by the caller. It can be true only in schedulable
+ * context.
+ *
+ * @next_seq is set to the sequence number after the last available record.
+ * The value is valid only when there is at least one usable console and all
+ * usable consoles were flushed.
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
+	bool any_progress = false;
+	struct console *con;
+	int cookie;
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
+		if (panic_on_other_cpu())
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
@@ -3159,77 +3252,24 @@ static inline void printk_kthreads_check_locked(void) { }
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
+		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
+							&any_usable);
 
-		printk_get_console_flush_type(&ft);
-
-		cookie = console_srcu_read_lock();
-		for_each_console_srcu(con) {
-			short flags = console_srcu_read_flags(con);
-			u64 printk_seq;
-			bool progress;
+		if (*handover)
+			return false;
 
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
-			if (panic_on_other_cpu())
-				goto abandon;
-
-			if (do_cond_resched)
-				cond_resched();
-		}
-		console_srcu_read_unlock(cookie);
+		if (panic_on_other_cpu())
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


