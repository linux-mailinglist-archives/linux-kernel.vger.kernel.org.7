Return-Path: <linux-kernel+bounces-816971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC1B57B87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E701A22895
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC031327E;
	Mon, 15 Sep 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="TWXolt6E"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244D30C606
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940205; cv=none; b=c/fFmJ+Bea4OPZl/9mgbLEVAippTVETJttwKIMVi5P7ee9RTWdmScBZ6HdOn1VCNtvCbvEhy+3nGHEbGJ3a+6EYN9739iX+VlDRmNuc91oVMepVxiG0NeuGpThJ+ZlYhykjaRBScAx30tj7ETQlzfSqKAiakm3HaSLaAb3A4YCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940205; c=relaxed/simple;
	bh=r6OmmV8VA0qAhD2HZu4eWWUgM5ydSUsLWJ0FF7fhTdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtYmOr/gSL1fjtvPI964qv5tqxgtaJ+bLPEb4hO2XQwKPIW2CMWzlxsxa9Kmhmu4y+cqUgSVkyFUKDjPbQ1K4kSKBNgLaM4RQA3TmWF3q2kPhVnl4r9Pz3/YdrVEbvONXCZFDYTqVT2bqwzFvbNCZ17Hmawu+nRfQoRG3lyflvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=TWXolt6E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso43921275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757940201; x=1758545001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGl37ljG3JjOsbZvqjafte0MjItw5JP7BJXGP39K+uk=;
        b=TWXolt6EB6sOjsN2UL/trRJdOxT+UrlTX42LVpD67LIB33xHAs8wsbzzVbAkiA48k1
         VCWPYabkSzN0H4qOIyLF419TaX4dIT5Ur9jd3PKK0oQy05epNPDA2NwPD8/aaq76Ow4e
         Kh+KsCU3wr1gB1bkq/IDhCJ2tZ0SfqB+GQ2ixqLWDs5vRm9miBqR3w2R8SQJy/a4OaCE
         jSlRpVchL5fvo3NCfVb0scr+m+ontHXNxnnx82ubGbmyDdO7y4+NRF8+RD74YMRaJK/5
         0S83PE0Mfj/xDhY5Cfw708x2ePr3DoK3vTifHSzSWDiM37mgMub3Mli/mGNsjl23f4CD
         KsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757940201; x=1758545001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGl37ljG3JjOsbZvqjafte0MjItw5JP7BJXGP39K+uk=;
        b=Xds7RR4/8r0BUjS5juYKymYjzlEMO2nqtsCiUMtgyTQKZkVrmbR609XsZvkK+PihUw
         9eS7MZjN2VddJNLP+igndNX/uqggP5RmGzm+ugnYIlIAmnxnRu7QARnucvfr68vVy1uJ
         J/KgKQBfeE2izTruBaFQZteYpT/t5j70sxQZmfq8HwqA8Z+TS3hEWJn0/HAHaEhhKEYb
         vi0a9PDn0AjPFHsZbi6ubTa5elBbMVnxo1Zw1fPKBDH221AMS4V0XjL8LnszXJuY+oxr
         d4j9kKVKo++TIvJvtqm7pmUFMY1RaI5F91+aqjUWEYMtJEXxUMVo7GFRroM/K+s9rEP2
         VVEQ==
X-Gm-Message-State: AOJu0YxnMzI+9dGJ4QqVO2E7atW/pz9SnPDYsJ5piHFh7/SU6hfJrEzM
	2hdaR77qYv5J47Yjq+Z7GIhaxz0XNatj3DEuHyphgdwTZmS6+WXFphyTW6Adrd/VwUNX1JixxET
	kY0NtJo8=
X-Gm-Gg: ASbGnctGJLWZp9N7W9cuczj2hsmVj42tdmQV+uYupPHYW9N+MD1x1kCpTHVhsHA9gy4
	0IJm9nlcyd5kyNrlGJ9f0CW0uT+DSpybLYTt6U6qSzSOky4qibbkIhqKLegHJhRmc+ufklK/kGf
	0GEuHNfspAJ9efsbrfoWBWmR+2yUuyKsMAh+Du7ytFKToolQAniHLcUqckSnHTo5bKsMV/oECTC
	m436V7xCqCwC229q2bnfbViVVQNa//MbUKjnDM1E6JBIbTXxY4eieeDj/9cPRVt/UGHg0Czdy3y
	YNkgxJpVougTpVr0AImijaGNTn/ZQVdu14gVQJs5wuudvLf2JGHrBOon6ZMKwo134q3ur7v4U06
	lnWZoVWuXElPnkYGhti5zZ3rU6AKcdWmyAoTvNCtw/+cJw2M=
X-Google-Smtp-Source: AGHT+IE7+231bNN2PazsCh3VpLR9h1+kfV0XUqdeqv+XnlFeqNxXS6bZAAM3xauIt/wlyb4FrlgNoA==
X-Received: by 2002:a05:600c:1f8c:b0:45d:e285:c4c6 with SMTP id 5b1f17b1804b1-45f21205125mr114203805e9.37.1757940201304;
        Mon, 15 Sep 2025 05:43:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm178839265e9.20.2025.09.15.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:43:20 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 15 Sep 2025 13:43:06 +0100
Subject: [PATCH RFC 2/2] printk: Use console_flush_one_record for legacy
 printer kthread
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
In-Reply-To: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757940198; l=3321;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=r6OmmV8VA0qAhD2HZu4eWWUgM5ydSUsLWJ0FF7fhTdo=;
 b=5H3EMLmOp53I3myc0TMPerJPHDa933z6CUfN6+AeJ+0Og8aV5HA+LNqUXA94O6SZn1i0uMBmI
 0hmo55MlNteA9pAgHVg8cpZ4b1ZLWtgMwz6f5Mgcj57ZIrkcoCoCCV8
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The legacy printer kthread uses console_lock and
__console_flush_and_unlock to flush records to the console. This
approach results in the console_lock being held for the entire
duration of a flush. This can result in large waiting times for
those waiting for console_lock especially where there is a large
volume of records or where the console is slow (e.g. serial). This
contention is observed during boot, as the call to filp_open in
console_on_rootfs will delay progression to userspace until any
in-flight flush is completed.

Let's instead use __console_flush_unlocked which releases and
reacquires console_lock between records.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 75a3c47e9c0e645a3198c5f56e47df2a8d1871e6..53daab5cdee537c2ff55702104e495005352db1b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3301,6 +3301,46 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	return any_usable;
 }
 
+/*
+ * Print out all remaining records to all consoles.
+ *
+ * @next_seq is set to the sequence number after the last available record.
+ * The value is valid only when this function returns true. It means that all
+ * usable consoles are completely flushed.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock. Otherwise it is set to false.
+ *
+ * Returns true when there was at least one usable console and all messages
+ * were flushed to all usable consoles. A returned false informs the caller
+ * that everything was not flushed (either there were no usable consoles or
+ * another context has taken over printing or it is a panic situation and this
+ * is not the panic CPU). Regardless the reason, the caller should assume it
+ * is not useful to immediately try again.
+ */
+static bool console_flush_all_unlocked(u64 *next_seq, bool *handover)
+{
+	bool any_usable;
+	bool any_progress;
+
+	*next_seq = 0;
+	*handover = false;
+
+	do {
+		console_lock();
+		any_progress = console_flush_one_record(true, next_seq, handover, &any_usable);
+
+		if (*handover)
+			return false;
+
+		__console_unlock();
+
+	} while (any_progress);
+
+	return any_usable;
+}
+
 static void __console_flush_and_unlock(void)
 {
 	bool do_cond_resched;
@@ -3346,6 +3386,17 @@ static void __console_flush_and_unlock(void)
 	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
 }
 
+static void __console_flush_unlocked(void)
+{
+	bool handover;
+	bool flushed;
+	u64 next_seq;
+
+	do {
+		flushed = console_flush_all_unlocked(&next_seq, &handover);
+	} while (flushed && !handover && prb_read_valid(prb, next_seq, NULL));
+}
+
 /**
  * console_unlock - unblock the legacy console subsystem from printing
  *
@@ -3676,8 +3727,7 @@ static int legacy_kthread_func(void *unused)
 		if (kthread_should_stop())
 			break;
 
-		console_lock();
-		__console_flush_and_unlock();
+		__console_flush_unlocked();
 	}
 
 	return 0;

-- 
2.34.1


