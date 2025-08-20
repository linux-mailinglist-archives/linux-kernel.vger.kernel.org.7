Return-Path: <linux-kernel+bounces-777323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F72B2D82B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25EE1C42AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB32E3713;
	Wed, 20 Aug 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBqaZrZx"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC82DF3FD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681484; cv=none; b=gZAIRR0a9FlwavGUixEuGJmj2hC77a74ve0AjOFvwt2GsJpxj7CwDZaa7rRl/k9ijBk5hMdmhfait2Pzf8vDgASteTPgaGbtw1vGmUa0VZXt6V+KIq5PYIpahmV0ybF+IUImKFDtjIi/MTn5Oc/JOacwK7uZuUwkflXMjyiNvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681484; c=relaxed/simple;
	bh=eherwgROF/bZ0pFajBjAOnkkNBnSvT5BnsVn4bkaWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mw2/qNXUheLH0PGrlJivQ+jZrdNBzq2RMMfh9o7ySi9X63Lsp6QRYRXgILW0r7Fr/c5n0SvCe7eIGedau5oFy/XIWN29iNLwsReFnnI+RgsZERjNbTUUUCm8/XGHrg63IUk/UHXkGoOkKs07G0pSht4NJKJXk1SQ6kKD4HeQaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBqaZrZx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e563b25c4so2471154b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681482; x=1756286282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF5w8IoBCci+s9UgwxiAnKZ7VNnUUJeU8csh4BtuMkk=;
        b=MBqaZrZxm7ykgXyXq45M1G/t7+6FiF9LHbSzuyirQyqWHmMbBkCY/Jy/sdQ2qTMxi6
         idVXc/8kxJzHD/8WkW8G3ZQs58mTbnLhY8063JbP8rKSwaSi9Qm7xSSBXhvpwGBxq1Nr
         fidDYrtQXFaLU6ezcloATZx9e/rNJCVNiIbRzqx27Xgas0c3PQlQJgvJ6ctbCDnaaWcX
         AUoSpGL1SPIb8bGE6rfQAu3a5fmasnvDv+ROMfxGDpBDLK8PAZhjji3spc82rbWXXYCy
         j24gii0ZMDcPensOb1WmO2UMIvWFgjRD1MltV4y+MW6sIUVIEujp7D6bLsDtZGRKDdyN
         M5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681482; x=1756286282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF5w8IoBCci+s9UgwxiAnKZ7VNnUUJeU8csh4BtuMkk=;
        b=DbqihBtiEk+XnkmueyqQKdIYgvFSoPL78hTuEfTL0QZogP5ZoVns7g5z0shefwxssZ
         trNNo70hPef+vAqXgD/ox6wAzlv0unH2RqhfxSDRw7rbzOfP66O4E/dyijskbrTKGtGe
         P1RySb8QDDi3uu6klt8V9CZCUC/Ghcsn8UhpIflyvPsA4OQ2FoKCzbSFHikMXe2nMWO5
         OVxPfknAfvValLJaUcD4mgNcQEHDBvmMYQIVeuqHflW7vYPTmIBYeScU7qf3P7wNJ/8v
         634IeOYFXENc7U69O12s8xOHZIeYdTKFBlKxW0ZKxcMFd8784SdVziGBXH+3YvTDmg13
         n6qQ==
X-Gm-Message-State: AOJu0YxsenqjAS4cVbDGI+PSXDeI5bwg4Ty64K2X6ADB8ne6+b/2uamr
	Ut8UAs7rRNFdJooUaHtvs69zReaV4lycNDGFlyHBdfDfJ1dhSFax6BZm
X-Gm-Gg: ASbGncuW5+cAL0VeAuJB8pFOhw4ePJPfmxC8t9PCHxuAtPIhkOPwr16K6mlvf0GYiPU
	JqqpkdmJeudNVtSi8iW2GGBr1cM9zg9gqum3zygz6YDTeRzOklR5pxqA2pzkp6rYrlJHG+AtMBh
	mIawDS1eSwu2UztBL2nN4ERSWN+xYBGoiLdRH/It/8l8kTMdz+Ib1kZ9Z1ZzNUnqul5twLGTuOQ
	5oTFYNUrgP4ly3a42yRBmfm+WVBrxj4jxB5zC45yGc8Nu5xNZxgZ4DZ42C26WEFvIIwc4e5qDA1
	EFAyk1uP7/1eFnrPoA0TPpYvuB97slHRvRIy03PIZ/a5BIJ6kr3a/soo0tcTIP03LcHJE/ihyb3
	u/jISLB+2imXWFBXgiwGZm8qwpmQN0mamjfzDpHsJ67n2J3/VoqA2Av5/SJewGCtiMJoDHMlTPC
	U3SYQ5
X-Google-Smtp-Source: AGHT+IHqynuaHYUfAhx74e8ntdYeAp8cLRcCT02dpBwi3FWdHepd96CQBsFqkqhqXRnErlRzJRsTyA==
X-Received: by 2002:a05:6a00:2d9a:b0:76b:e109:a1f4 with SMTP id d2e1a72fcca58-76e8dc35c5fmr3110910b3a.12.1755681481711;
        Wed, 20 Aug 2025 02:18:01 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:18:01 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
Date: Wed, 20 Aug 2025 17:14:52 +0800
Message-ID: <20250820091702.512524-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-7-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper this_cpu_in_panic() duplicated
logic already provided by panic_on_this_cpu().

Remove this_cpu_in_panic() and switch all
users to panic_on_this_cpu().

This simplifies the code and avoids having
two helpers for the same check.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/printk.h            |  2 --
 kernel/panic.c                    |  2 +-
 kernel/printk/nbcon.c             |  2 +-
 kernel/printk/printk.c            | 15 ++-------------
 kernel/printk/printk_ringbuffer.c |  2 +-
 lib/dump_stack.c                  |  2 +-
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5d22b803f51e..45c663124c9b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -330,8 +330,6 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 
 #endif
 
-bool this_cpu_in_panic(void);
-
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 5266e195f5ac..8415e4073da1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -343,7 +343,7 @@ EXPORT_SYMBOL(panic_on_this_cpu);
  */
 bool panic_on_other_cpu(void)
 {
-	return (panic_in_progress() && !this_cpu_in_panic());
+	return (panic_in_progress() && !panic_on_this_cpu());
 }
 EXPORT_SYMBOL(panic_on_other_cpu);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 7490865e2f44..c6d1a4a747e9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1394,7 +1394,7 @@ enum nbcon_prio nbcon_get_default_prio(void)
 {
 	unsigned int *cpu_emergency_nesting;
 
-	if (this_cpu_in_panic())
+	if (panic_on_this_cpu())
 		return NBCON_PRIO_PANIC;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5fe35f377b79..faa8b1f0585b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -17,6 +17,7 @@
  *	01Mar01 Andrew Morton
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
@@ -345,18 +346,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-/* Return true if a panic is in progress on the current CPU. */
-bool this_cpu_in_panic(void)
-{
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
-}
-
 /*
  * Return true if a panic is in progress on a remote CPU.
  *
@@ -365,7 +354,7 @@ bool this_cpu_in_panic(void)
  */
 bool other_cpu_in_panic(void)
 {
-	return (panic_in_progress() && !this_cpu_in_panic());
+	return (panic_in_progress() && !panic_on_this_cpu());
 }
 
 /*
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67..e2a1b2d34d2b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2143,7 +2143,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() &&
+			if (panic_on_this_cpu() &&
 			    (!debug_non_panic_cpus || legacy_allow_panic_sync) &&
 			    ((*seq + 1) < prb_next_reserve_seq(rb))) {
 				(*seq)++;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index b3a85fe8b673..f0c78b5b5324 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,7 +102,7 @@ static void __dump_stack(const char *log_lvl)
  */
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
-	bool in_panic = this_cpu_in_panic();
+	bool in_panic = panic_on_this_cpu();
 	unsigned long flags;
 
 	/*
-- 
2.43.0


