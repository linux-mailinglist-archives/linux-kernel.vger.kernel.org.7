Return-Path: <linux-kernel+bounces-748238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A889DB13E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A8318C019D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B62274B24;
	Mon, 28 Jul 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnptUpVX"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42C27467B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716376; cv=none; b=MOiIbvz0nyHcXRxsSmcO86ixKQkMPx3NVYf9KCGseya5PZZvs6Zf0zvBMr9ST8Wpfvvsn7+yRQ27HEv8I49IwDzdWSV2OT1ylcYoIQbtjvkBTpdnsjC6GkQv8L2LY8IOk4c+IzEQQHB1wI+TNmdX9iQ9gYs+IcOq35ynTsZFUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716376; c=relaxed/simple;
	bh=r/tZXEP+8eEdZLTTr+icWX3GRDcf5HowPMVmT2pS6NA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hfRk6ZFeysV5lV0X7hwNIwnbf0fBVI9suEVuPSjsJZDF+nwh3sQC8w0Gra2ete7jqD28EnecnXlBBl0gwiq+qPr8DzCT505tJFoabqxJfRUsfR3BzbHGtetkSYWaYUtqddSe/XfROuUuSxJsx8vuBJXdqQYBtLCQIe0nwBevuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnptUpVX; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so2597763f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716372; x=1754321172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWggRk8hyLpW4/M6UT4TQt+tg1m7K6txrnQvGMUPVFM=;
        b=OnptUpVX4VyrrFQ7kFjGwAic2HlmsvaW4oz+0jO3DDaOZALyv83sS5ABpwzHKYWyup
         K6zLeAoMouIbLbJe/J/+u05RoncOb8J45AwSAhYyZY8FPmlJ6azTOeJFMvVMRT8CLvPv
         rintW0d0jNT9ldD2l8MOq8pHwwSuXKcZaNagC0GH9F7oUfyjLp7uyZngEX0dzJbeTjIk
         2kCido1nd8YOSE5DD0P0jTav7/YO8nURmeEmr6XymAl/ch9ws6dca/2cPS3ltbp2kafi
         ETnZ778XnNWzYIkSczZ1kqzfqPczvvvgrUudId6F3J18AkgzNJPXdiAXLFfAOWQKZzXD
         VkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716372; x=1754321172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWggRk8hyLpW4/M6UT4TQt+tg1m7K6txrnQvGMUPVFM=;
        b=Xf90pVgYpYYe4BoeIvvYv3VKm8bALfoJyWBGP1OYGHZNopmSpuIMWLh5BpiCeu8691
         OobezZz23/85zj7ayA2+S32tELBjXZIrkh0ZIfqEByIRNB13sap8YrkHsV5k2u+eRIFG
         sOH8ZK3sCe8T5vE5+FOBlbLHcPern7quT0/nA6RrDys76tjRdxydghnk9NaBCwiOtQ90
         MdI++Z2HelbWIS7P+VvfVCYO1nAcE95h+KQpRQLrf5mQ82jNDCy0Qf0lBroT7dUJFuvn
         pBqxNp+UdQCBNPzgxN2F0U77B5MEXIPUTGUoJ+QvwO8UvXHpCMnA70xVbU7UmAcFRm3K
         osXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTlJZuELaQNmdyN+X7Bo4UwQuHUkCnerBLsB8QTH+2z09nR6Sm1N+HLOfjTGAYwCGjyu1BjNmOeZbW3vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wxseiIeHqpNOtf5LR590tPG+HB0IlAuHKgI3f5J+/TjkpFAV
	UZaU9G4eGRdeYPRS0RQB/mtfJgPdAXmQycn4tMEcWAXV8VtCftWj8fpJvC4D/a2PcTTeWd7591y
	H1S3YVQ==
X-Google-Smtp-Source: AGHT+IGkE7Uuj1VenFYjF3LuEj8c5sOe2muKlKtZ9FwxWlnSIZKVPmai6ALZHafTifUSOHbrJOaZIExUuiE=
X-Received: from wrod15.prod.google.com ([2002:adf:ef8f:0:b0:3b7:7e20:4466])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:adf:a11c:0:b0:3b7:76e8:b9f7
 with SMTP id ffacd0b85a97d-3b776e8bcb3mr7141293f8f.10.1753716372699; Mon, 28
 Jul 2025 08:26:12 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:25:44 +0200
In-Reply-To: <20250728152548.3969143-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250728152548.3969143-7-glider@google.com>
Subject: [PATCH v3 06/10] kcov: add trace and trace_size to struct kcov_state
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Keep kcov_state.area as the pointer to the memory buffer used by
kcov and shared with the userspace. Store the pointer to the trace
(part of the buffer holding sequential events) separately, as we will
be splitting that buffer in multiple parts.
No functional changes so far.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
2.50.1.470.g6ba607880d-goog


