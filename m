Return-Path: <linux-kernel+bounces-752036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE5B170AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBA1AA82BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0962D0C80;
	Thu, 31 Jul 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYIXO5vQ"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989A2C1581
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962724; cv=none; b=N/OYA77ZeoaYPt46qibrfOdZs8W8NL9pIhoqKmiNNP1gmrIuT2O8rJwtT+c8ENziFyUln9F/sj+WXmyfEsqHbzjH3VjiKD0oKzWefPLtkt57VW1wzYXKgWjs/b1ZN4zRUjGzsaFBkEqrqMQ221wBVaBGuQz612rC3wZ6AXUlJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962724; c=relaxed/simple;
	bh=DKlgttxOJoNYs2L2yFu65c8RnXZJeaUFXB1cyr4OjR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4nXFuOWr3RToOZ64Brn1vH7edO1E3kQ60d2Jmhg7C6ONikVva5vMzGUwoWv8R/t2yW0fbDbSg3SfS4UI6UhDefFs2ak5UDnqNp0ShKd3h+vK0t6FKwq0IWKWfqmYu+SeDb4WnrtRa8LCXg69aPMEpsan8lHxKvuBNZ09KPcLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYIXO5vQ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b78c983014so437682f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962720; x=1754567520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PPuLl+jotf/eLqBsrdKJtiuGUESLMuKQyj/jfXbQ+ZY=;
        b=SYIXO5vQ/EEkAwwUb4t0gHY1nIO8BdGYDnrZ2MKb8J6e/gD60ruxX9cSxzLOvbP55c
         FrbKHmDLzKuXdCGVD6n7tkWL/3YbfflW9Vvg1eJbZcw/L1Wmn0Y+O3As5uxtjSvFTwYf
         PU0QbpAwGU69+A+/H4BRxm+j7iou+l8wVj827MoBgmtJPbOGcxqCKGNv/hL7b6g+o2YO
         6RT7kZ12uEQtLEduzpaYZjPodnBNY0Ll0gRjaDksGGawV4oypdlidwFqGhlSe9WWc6b4
         YmZhAR9nIfSqffEwWenK6aBKcAW+VUVyzTNjBUpzrpPERBPWfPiUWj+zqRvXzsG0CHHX
         UtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962720; x=1754567520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPuLl+jotf/eLqBsrdKJtiuGUESLMuKQyj/jfXbQ+ZY=;
        b=WowtMGMmd3/klPi6S3ViPDlg6JYF3BnZ8VzZTNnSUdz2ulAkKgiB9s0NqIvNPVIW+q
         AeZrZr1Ewi8UA9/Bg6/gW/pwHqlbMQcExP0b+btz1NH7bhdAJTI29c7YnkAjlsDBMhWc
         G0Dyd+WhqTFAh1koaHflY0m9XVvAnkzXCKC1dZm/ca7xsTAS4zEcSDzcSA9OfYrnX+WU
         LQLR+p1KIxA/ZAl6HCLdLgwPweL97Ca5aG2rOFwoCTv3Is0weAAfFszGjgGuxCyo+d8s
         NdpUuXC5f/Co8zGXpMqFejGrLbYfwcr9c715mW+TtYdoO4BZXnbitqwHU1rYpR09tZKh
         k38Q==
X-Forwarded-Encrypted: i=1; AJvYcCVobosBp/D6Q1FYLbCjvsZxodg7dEHwCrkaKdn+rBO6xOkkVpnlgL45vjJVeJxlr2CQRCKDEaSW6f00qxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlI5N4aRWVbpUjho1JZx5YG0QWS9yLSTCcTeZ2eWAg7ps6wXh0
	nZD/748LSjzMu8Q1Blh5lxVygrpkZMDSxAShWoF/S56BewSKV6QdW0tLtQgXln8NEk0a+0L6QrY
	LKYqbjw==
X-Google-Smtp-Source: AGHT+IF/sgG0v6dTdYZQ8u2DEGmxrI/1eJJ5Ir2nQ2ymjDVQDFeR79V0Pwb1remmYjUDjxnIelFypZQ5+tU=
X-Received: from wrbfx3.prod.google.com ([2002:a05:6000:2d03:b0:3b7:8216:2015])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2c04:b0:3a5:27ba:47c7
 with SMTP id ffacd0b85a97d-3b79500950cmr5811629f8f.48.1753962720502; Thu, 31
 Jul 2025 04:52:00 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:35 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-7-glider@google.com>
Subject: [PATCH v4 06/10] kcov: add trace and trace_size to struct kcov_state
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Keep kcov_state.area as the pointer to the memory buffer used by
kcov and shared with the userspace. Store the pointer to the trace
(part of the buffer holding sequential events) separately, as we will
be splitting that buffer in multiple parts.
No functional changes so far.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

---
v4:
 - add Reviewed-by: Dmitry Vyukov

v3:
 - Fix a warning detected by the kernel test robot <lkp@intel.com>
 - Address comments by Dmitry Vyukov:
   - s/kcov/KCOV/
   - fix struct initialization style

v2:
 - Address comments by Dmitry Vyukov:
   - tweak commit description
 - Address comments by Marco Elver:
   - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
 - Update code to match the new description of struct kcov_state

Change-Id: I50b5589ef0e0b6726aa0579334093c648f76790a
---
 include/linux/kcov_types.h |  9 ++++++-
 kernel/kcov.c              | 48 +++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/include/linux/kcov_types.h b/include/linux/kcov_types.h
index 53b25b6f0addd..9d38a2020b099 100644
--- a/include/linux/kcov_types.h
+++ b/include/linux/kcov_types.h
@@ -7,9 +7,16 @@
 struct kcov_state {
 	/* Size of the area (in long's). */
 	unsigned int size;
+	/*
+	 * Pointer to user-provided memory used by KCOV. This memory may
+	 * contain multiple buffers.
+	 */
+	void *area;
 
+	/* Size of the trace (in long's). */
+	unsigned int trace_size;
 	/* Buffer for coverage collection, shared with the userspace. */
-	void *area;
+	unsigned long *trace;
 
 	/*
 	 * KCOV sequence number: incremented each time kcov is reenabled, used
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 8154ac1c1622e..2005fc7f578ee 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -194,11 +194,11 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
 	return ip;
 }
 
-static notrace void kcov_append_to_buffer(unsigned long *area, int size,
+static notrace void kcov_append_to_buffer(unsigned long *trace, int size,
 					  unsigned long ip)
 {
 	/* The first 64-bit word is the number of subsequent PCs. */
-	unsigned long pos = READ_ONCE(area[0]) + 1;
+	unsigned long pos = READ_ONCE(trace[0]) + 1;
 
 	if (likely(pos < size)) {
 		/*
@@ -208,9 +208,9 @@ static notrace void kcov_append_to_buffer(unsigned long *area, int size,
 		 * overitten by the recursive __sanitizer_cov_trace_pc().
 		 * Update pos before writing pc to avoid such interleaving.
 		 */
-		WRITE_ONCE(area[0], pos);
+		WRITE_ONCE(trace[0], pos);
 		barrier();
-		area[pos] = ip;
+		trace[pos] = ip;
 	}
 }
 
@@ -224,8 +224,8 @@ void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
 	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
 		return;
 
-	kcov_append_to_buffer(current->kcov_state.area,
-			      current->kcov_state.size,
+	kcov_append_to_buffer(current->kcov_state.trace,
+			      current->kcov_state.trace_size,
 			      canonicalize_ip(_RET_IP_));
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard);
@@ -241,8 +241,8 @@ void notrace __sanitizer_cov_trace_pc(void)
 	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
 		return;
 
-	kcov_append_to_buffer(current->kcov_state.area,
-			      current->kcov_state.size,
+	kcov_append_to_buffer(current->kcov_state.trace,
+			      current->kcov_state.trace_size,
 			      canonicalize_ip(_RET_IP_));
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
@@ -251,9 +251,9 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
 static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 {
-	struct task_struct *t;
-	u64 *area;
 	u64 count, start_index, end_pos, max_pos;
+	struct task_struct *t;
+	u64 *trace;
 
 	t = current;
 	if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
@@ -265,22 +265,22 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 	 * We write all comparison arguments and types as u64.
 	 * The buffer was allocated for t->kcov_state.size unsigned longs.
 	 */
-	area = (u64 *)t->kcov_state.area;
+	trace = (u64 *)t->kcov_state.trace;
 	max_pos = t->kcov_state.size * sizeof(unsigned long);
 
-	count = READ_ONCE(area[0]);
+	count = READ_ONCE(trace[0]);
 
 	/* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
 	start_index = 1 + count * KCOV_WORDS_PER_CMP;
 	end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
 	if (likely(end_pos <= max_pos)) {
 		/* See comment in kcov_append_to_buffer(). */
-		WRITE_ONCE(area[0], count + 1);
+		WRITE_ONCE(trace[0], count + 1);
 		barrier();
-		area[start_index] = type;
-		area[start_index + 1] = arg1;
-		area[start_index + 2] = arg2;
-		area[start_index + 3] = ip;
+		trace[start_index] = type;
+		trace[start_index + 1] = arg1;
+		trace[start_index + 2] = arg2;
+		trace[start_index + 3] = ip;
 	}
 }
 
@@ -381,11 +381,13 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
 
 static void kcov_stop(struct task_struct *t)
 {
+	int saved_sequence = t->kcov_state.sequence;
+
 	WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
 	barrier();
 	t->kcov = NULL;
-	t->kcov_state.size = 0;
-	t->kcov_state.area = NULL;
+	t->kcov_state = (typeof(t->kcov_state)){};
+	t->kcov_state.sequence = saved_sequence;
 }
 
 static void kcov_task_reset(struct task_struct *t)
@@ -734,6 +736,8 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		}
 		kcov->state.area = area;
 		kcov->state.size = size;
+		kcov->state.trace = area;
+		kcov->state.trace_size = size;
 		kcov->mode = KCOV_MODE_INIT;
 		spin_unlock_irqrestore(&kcov->lock, flags);
 		return 0;
@@ -925,10 +929,12 @@ void kcov_remote_start(u64 handle)
 		local_lock_irqsave(&kcov_percpu_data.lock, flags);
 	}
 
-	/* Reset coverage size. */
-	*(u64 *)area = 0;
 	state.area = area;
 	state.size = size;
+	state.trace = area;
+	state.trace_size = size;
+	/* Reset coverage size. */
+	state.trace[0] = 0;
 
 	if (in_serving_softirq()) {
 		kcov_remote_softirq_start(t);
-- 
2.50.1.552.g942d659e1b-goog


