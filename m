Return-Path: <linux-kernel+bounces-835089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8ADBA63C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4373E17D829
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB623F41A;
	Sat, 27 Sep 2025 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="ACEhUV92"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63D23B605
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759010758; cv=none; b=Nu5oDfwZ3pq4Rulwszby7V6biLyPVBfudc0I8aLMj0RCRQPXVsREkydaRb8q7rtLAXZiPCV52g5HleLrJDyqw38r3nLjpI0VQopAUNIZdEx0cvgS0UWgGRIPU9sZJ8WlSuaYn1e0FO+i8wr8dPkxmVFRCK3g5LqPZeYAcXgedRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759010758; c=relaxed/simple;
	bh=t+Bxs6xl3hHAyQJNynT1qHHn6ausucEiLn8yQOE7E/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syjSdBvXYr7YlDd9HIaqnIu5YEgx2ygX18RXHCq919jz/mmQ3Zu7FKmy2g9yejqQMgyUKIfN4rKyqtMxSKOSJnrklDOeRZFwMWS+PAmJ1mXKEbrPhQJ5+jGLC/j9zPZCd8XDtrodoKMfQAAPsl/WiXGWbaOIFouQPmcINwP2q30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=ACEhUV92; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2114462f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759010755; x=1759615555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yU5Wj1Qjx2YiF/m2kQaKUtVAL4Tj3fTykAgifo+j3OI=;
        b=ACEhUV92PoGYWS9MZW+urdoIUGcYtAiWQT+mhg7v8qtjfdqJZSTUmej/0XHthSSaQL
         /sM4oYbz14e1YRAdVML0WTUPU9Wo5Ej1cNwyUpKdHbKW98rIu3cA2tKSD6DWccz57HZ+
         lN80VFKGCETw4eFSGO4WN0VGXz7y2yuk3sUsj6iNGI4YkH3xkfBzXDfbIG7D/7p1o9MQ
         FjLUPWdkiizVTSL+Goc+F9cTPywkXVUC8E9Fl50RbEdzH2qRJNP24Ays8kYXxPfAEeLu
         3atdNZXFWOImw7zIb5xzig0V6IFZ7WBg0LNkUoiP9I824wRIKBtoEQX384ooQK384ls8
         icaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759010755; x=1759615555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yU5Wj1Qjx2YiF/m2kQaKUtVAL4Tj3fTykAgifo+j3OI=;
        b=KtSDgcPF0FUr+wQoiXVM6qS3Uq5UIZ9Suun3k7yc8qykJ2bZSrIK0LEjUjegHsemG5
         kBACnifmMpSNMTsN910K5ZDgdHQ1dtf0/jtM7n2uSkCrAf403XcTPhdJdWJKY7MkPiFi
         p4cs8irzYuRazkAiYx0abkbpGReCM6SfHMkDKf6rGkxDmoQfxiN5R0fdt6PMYF/uU3qp
         w8G4JcVwS193nE0HGHRMY9vx+oVyDvMh2WVz7YUrENN/mGTE/SO5LHtznQ5qbe5Pk6er
         XVFZmhibxivljX8a77sN5vyTkBXo728r5QH8cyNTc80SfYuPBYo5/BaMRJvDn6bQMVwp
         llMQ==
X-Gm-Message-State: AOJu0YzJy+4MF/EMQfKT5hME5P/OXVpTEMUXX40XO9McRxlORnKVjjUG
	GJ4H/0LjO8//6HQULquSxGtAqMJJcaap8eyEjoPgsilMxLithHopRtQYNYgJKR+Xp06v2WTFGXY
	t+y40PXZBNw==
X-Gm-Gg: ASbGncsOQ/HqapWVPWkGHvbQYcx9/iCzMK92wt7APmPxwZri5MDs5yGfFi6jpZntUPp
	wPjG5LlxhLbbysIgO9o79cHrw5xYFEgceR0InJiTJKengC/ni04IE/J3h5BIw/UEUZw3caaikYk
	C9RRwxRMegfOf8zW44QcKbwqgo5CKdspfqjGpkLmpZYhq8NTjTh/rAj72dFcewJaEPSjLjpiSh8
	ka+ftEqO1exyOGYQHnToixxN13O3etxUmJ0MOyJevjhRpRX9lRVpUdqzp2RqWudd7YoCjFMCn2z
	1KMx3D4XkKVHqcVbR6Oc4qvtXIoroOa8CdAqqbP47uQJwAzKIhVUl5nmu9i2XmbK9xCkof6zXNT
	JHKC5o0rFDI+ekzNZulsWREL3hBaslBD5Wsx2
X-Google-Smtp-Source: AGHT+IHw58eMb61DlUkRD25LT2hGFnvuBmbeG5KtaLpO4n9Z9cmPxTjYvekEsASiE6F4HO0TiiG/+Q==
X-Received: by 2002:a05:6000:601:b0:40e:604:8e29 with SMTP id ffacd0b85a97d-40e4a7113a4mr10980448f8f.15.1759010755030;
        Sat, 27 Sep 2025 15:05:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm12463730f8f.20.2025.09.27.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 15:05:54 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sat, 27 Sep 2025 23:05:36 +0100
Subject: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759010750; l=3077;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=pFb1dkVqvBhpN05SNX7LSOGgtYq0als+P5lj9Ap+u+4=;
 b=t1zB4bpIJ+lBohL3EsvL39EXEhzeQh/sUWplcfhOONZynAeqoA/ubMDqnLhQAo/9RZkXDrEMS
 H2gUS5EE5e+Cv8JVJIm7a2XbsnhP7U1PAj/W0GhLOv7vluQvzxggx0m
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

From: Petr Mladek <pmladek@suse.com>

console_flush_one_record() and console_flush_all() duplicate several
checks. They both want to tell the caller that consoles are not
longer usable in this context because it has lost the lock or
the lock has to be reserved for the panic CPU.

Pass this information by clearing the @any_usable parameter value
which has the same effect.

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 060d4919de320fe21fd7aca73ba497e27c4ff334..e2c1cacdb4164489c60fe38f1e2837eb838107d6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3175,7 +3175,8 @@ static inline void printk_kthreads_check_locked(void) { }
  * console_lock, in which case the caller is no longer holding the
  * console_lock. Otherwise it is set to false.
  *
- * @any_usable will be set to true if there are any usable consoles.
+ * @any_usable will be set to true if there are any usable consoles
+ * in this context.
  *
  * Returns true when there was at least one usable console and a record was
  * flushed. A returned false indicates there were no records to flush for any
@@ -3193,6 +3194,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 	bool any_progress;
 	int cookie;
 
+	*any_usable = false;
 	any_progress = false;
 
 	printk_get_console_flush_type(&ft);
@@ -3229,7 +3231,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		 * is already released.
 		 */
 		if (*handover)
-			return false;
+			goto unusable;
 
 		/* Track the next of the highest seq flushed. */
 		if (printk_seq > *next_seq)
@@ -3241,7 +3243,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 		/* Allow panic_cpu to take over the consoles safely. */
 		if (other_cpu_in_panic())
-			goto abandon;
+			goto unusable_srcu;
 
 		if (do_cond_resched)
 			cond_resched();
@@ -3250,8 +3252,10 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 	return any_progress;
 
-abandon:
+unusable_srcu:
 	console_srcu_read_unlock(cookie);
+unusable:
+	*any_usable = false;
 	return false;
 }
 
@@ -3280,21 +3284,16 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	bool any_usable = false;
+	bool any_usable;
 	bool any_progress;
 
 	*next_seq = 0;
 	*handover = false;
 
 	do {
-		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
-							&any_usable);
+		any_progress = console_flush_one_record(do_cond_resched, next_seq,
+							handover, &any_usable);
 
-		if (*handover)
-			return false;
-
-		if (other_cpu_in_panic())
-			return false;
 	} while (any_progress);
 
 	return any_usable;

-- 
2.34.1


