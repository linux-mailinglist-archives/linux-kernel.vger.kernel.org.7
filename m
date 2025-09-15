Return-Path: <linux-kernel+bounces-816970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B9B57B81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC5A2033A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A56A313262;
	Mon, 15 Sep 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="DgMVzKBt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A730B53C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940204; cv=none; b=jymQ8/Tvz99mL8LQIgV5Il8kXUXiKaY11NJqhBTiRi8oooa3oR3kxC79awJ2rzmrnlCRkt9+gpMQTDwZdTVaSWspW5r7ioSb+ueolm0QTQ/2UiDhWmUCDoEPKK60ykoTovx2Y7lRRXtfnc0aIj1KXvkcDcpyDBbuAK3AxEeDRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940204; c=relaxed/simple;
	bh=HXi0OiBoVt/MYl+ob4qJzSdv2ZXZgwXc6LkbTDn+0cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIqaW8llFJHHSrYusi4mq3cRo1mlon+GT9iefX/7wZmlbG1Y4IpEiLCuhxt0CXCkqkbjlcGGzew74dhQHO0FS1Z8LiOZokrE54mJR3x5rlhe/MwCTyFMIHZl/We8mz756cDI8fjel1JH0c9rRV3py8T3KpBv1Bo10vpAERzjbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=DgMVzKBt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso10390295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757940200; x=1758545000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yslU6u5MFq9rz8jM5cyc8g+IFjlebdZiLBTaCg0Yg3o=;
        b=DgMVzKBtuHtgc7uyXlnqodJWABhP4C9AoTOy+gzLFJ470F0Uk3Y8yulGkRUSCu1OFW
         yYAX+XMHcgJ1SH6fBrfocCrA2P5eClZ6319jZhPOnrYvpNrSw7RoFkb4K1OrgyUka+Bq
         Xi/CYCJ03I75f3cAVVnaA1chquyt7wwRFw97MzY9nxSR8dubzmNmQ7eQ8gh/PuqC96u2
         TdOLkEuSMuASH2ekRu2O2kobMjeP1kJXBIt1cZvjTByVXobZDyU1dEVm0pwjWZ/k4r6m
         TUe7agwpoPsElHatGAkO/3a6UnViDfafAryyVtWtcCP44mncW0vkTvaeuvRKDkkvpIeB
         DIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757940200; x=1758545000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yslU6u5MFq9rz8jM5cyc8g+IFjlebdZiLBTaCg0Yg3o=;
        b=a4XPfWmxbZ+mmI+VOFdElEXxKbjRPT+KXjB3zrEHM+01LQQyZix4neglnJHsarnbJf
         v1bt7Be+/HFh5vffsHVYn30zcga5SdoNKiyLkcw2FJTkf0j9zuMYTq42g7EL2k2p3UET
         QgSDZdDZa5kCzguge4fEKDKhUc5XhUq1ojn4Lfc1IQ51hpfOqsJ5elXQQuaskg01WMU8
         ibTQ8Hc92Lvqz6Qvkce55R7NvB1bppZeq2V5QPsEJcz2F1zQ298XamttqYBrLtphX6eo
         SDHOKuDbHQzN2HXtIOwu8aJHP8m1a3QQobaoaq75XPcNFFzbwMyIKF4anGaZ/cI1OkuY
         bTtw==
X-Gm-Message-State: AOJu0YxKeP/qYPx94FevgI+TtlCC2+QPqUitNPiWoLPzUbKOQRgoO30n
	XlFKxFrzYW2SoFN3JtYk5NLt1W0+bGq1rg2pEamO08b68ypSAB1F2crTGhZFMnSI+cJ44YAawNi
	0D+MPA4c=
X-Gm-Gg: ASbGnctfhT7VQl2+F3pZ4jOEpkto4Ww3yvYa+vaay2ISEEi8s1j+Kw/jO1eStMlATS5
	QAru44rgNWb0HkIZAtMvU5+8TGB4K7tkzSqCxlDmZRT319vDWl2Fi6B/IRLY5qp/oC4r9lbHky2
	5uI8T9EAG8GzKlGiKimpLOK0RYbZaixERCmCeC56dwe8WwjiXJwUVKQAXqS/tumB1h4/Qr5Bgx0
	OKy6/tI+J20o6D0+FdHm4k/ueaZDedK84X9riAQsKdgGO07MjPD3qojsovwBCxmXl8XaYGZGPdX
	CvD9Qw21YJSY8GSnd4Zo3d9IKzJBD7TE6dHbVr8F4Bv3FnSfkPaiurqnNjptqzaXgpZaREc9GT0
	HWy7Is+HsSTtMcf5Q7EbXzbkDUppYp3nXMhJV5gdAU2BWNws=
X-Google-Smtp-Source: AGHT+IGpuI8k+Z7d/BNGCbObra24p5wLy8OlThGhhq7wwrxT5T6D2UkT2IplbxSaN1Hi0Zk1rgFk3Q==
X-Received: by 2002:a05:600c:1546:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-45f211ca9b0mr106143835e9.2.1757940200480;
        Mon, 15 Sep 2025 05:43:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm178839265e9.20.2025.09.15.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:43:20 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 15 Sep 2025 13:43:05 +0100
Subject: [PATCH RFC 1/2] printk: Introduce console_flush_one_record
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-printk_legacy_thread_console_lock-v1-1-f34d42a9bcb3@thegoodpenguin.co.uk>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
In-Reply-To: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757940198; l=6108;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=HXi0OiBoVt/MYl+ob4qJzSdv2ZXZgwXc6LkbTDn+0cA=;
 b=0zZ3JNNWzHw6nt6VC3an/qDkCPZt6o0oAwA2ngEYvjCuBluaU+R1GIQNMpYPGN6dqojtZQbS+
 GJ5Hj7SlL7AC3fLm/ZE/WXgskxiQrmwU2AIVCfhoSwuvGylk38R+eDw
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

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 162 +++++++++++++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 60 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aaba9d8d877df5e4f1db002d3a596bc..75a3c47e9c0e645a3198c5f56e47df2a8d1871e6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3161,6 +3161,101 @@ static inline void printk_kthreads_check_locked(void) { }
 
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
+	*any_usable = false;
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
@@ -3186,77 +3281,24 @@ static inline void printk_kthreads_check_locked(void) { }
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	struct console_flush_type ft;
-	bool any_usable = false;
-	struct console *con;
+	bool any_usable;
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


