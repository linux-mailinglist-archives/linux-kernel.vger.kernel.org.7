Return-Path: <linux-kernel+bounces-897887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB1C53E11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66512345076
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECCB34B413;
	Wed, 12 Nov 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z79+3CX1"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6F34B410
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971370; cv=none; b=WyIrDEU+87rA+wRYdmzSLFA+j71IWgk2O5Uu3FgrpCtKChf3boyQNOM9bgju0NL2guG6BfpE9G/UdGl/x9LJGhkfMyGRJWrMIkclGswNNCc8eKbogd8a+4vp+vHYFgYmPWQKJX3c42VBB8JaT6rMTFoPgeTcATVxGJtgJ5L2pjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971370; c=relaxed/simple;
	bh=bZ5f7VKNxC+0/C5GeCegReD24U8uCAvmmvogIqiUOEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eo5+nw7dr22YV4gQYZQ7/1fMKkSCI9/e8Yaha1O8wXyBWZUZMXzJAAgG4a5DreDXo0XvdUwkWKw9ea/uJr/pCiPESK4sxkuqjBKpHYttiaiXHNzoHgyKpvMaZH0LtRznMMoREm6/1XKtRc3PlrTY7lzC6kTVfbwufuIUgZXf1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z79+3CX1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b994baabfcfso783870a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762971367; x=1763576167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BXYAWhqiBP7C9MS7OCfnRHrIXS0DFjo97IQCwLf0sU=;
        b=Z79+3CX1JInwgvux8GldO/XyLsQGTPWZhH0tBHDwQDOkEMKlyXqADN0/Rp9RmiUj3K
         XmqgSiZ4Cux7lVO7Of4G/wePiL4wzPUxI9J5SInyhjOMZD5olCX3G+6WS5d4JPcBs81h
         n6dPjZ9RcsLOVTqwsS4WZ9k1dMwNSyuTLDMNF7M3UZ/urCIM2lWftvalATF7OMihmg1R
         3chNAjMYxBI7nAHSyTT3KJ4dF736fo3IG6tNeYpPf6zz/MZW6ypEZOH+qhsFVRxYResj
         2NlQFfko0FLkL/0n5hEbmURkKAdpWHpq8G6Cd3IVk/E3kqoNrRkCzSR5ZOEasCBUO5Wr
         SCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971367; x=1763576167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BXYAWhqiBP7C9MS7OCfnRHrIXS0DFjo97IQCwLf0sU=;
        b=G1Z1da9/A6APPJHJI4anrhwF0dVWS+Wd2i2Cg0hjcAeadPx11RR1hwz7z6JjeSrynk
         A02X8d5PrSsIoC2DTbi2cZybJl6kT2JQv/D0HqOT7mBWRQTZ5s9GJBfWGVdBi4g/CQPt
         By52iRyf/ngdR7hFbeetKVz1AvczVTu3/nKLZFMs+epEnQJazoqA6G/sWPTTuzowhI/O
         GXbDZzpzIFqzv2LVlElinoe0Xj+Q6Xb1zv1p2NJzdZOETHXfCjM8J0W6Mezqmv3qAhVw
         6ieCShCCmRKNYI9yG/hZOMHJNeutCclws6CT/UOPLiVnrxJWJpfPz3R9uakM31VhccYq
         QbKg==
X-Gm-Message-State: AOJu0Yzhd3gw7Uak4wU8psSG2Zic0wPgf+4ge4hRYY9TxLE85CNAIOE2
	PCA+EwRZ/0uj4LlgjRHaZhu0hkhL56fOFFCtk7nFFHhBO6wuw9DYlsehFkZnp640D1E=
X-Gm-Gg: ASbGncuFIiUS7ADLP+byO6XaRZ//zBfZEmAtAZvWYCneC3PfkfRwYEb99bS9dAIkBvb
	jTf+7dCPvirIEXiz+gvrPvleCa/e8LUTYnqEgi0OAk+GCiV9aI+Be1N1jN/s6zyfuDgvwLdhfgh
	l5+wRooijWcXFsbXThsQRiRlSo/ZwB7bCpWJUtTDFXLL4N8O0ViSIlGqkQtROrSoRybiItk44+s
	7fT2furarfmg6NLX5HlDgD+vSjJzfVKuSgieyP+nKKIuKTqUCEYiAco0g63jfVR9OjOY4lFDR5d
	2Lth2DlNToGYqGS1F0fk4q84+uMJQmjkQvVJyGcWA4mJg5WtLnxV3jfjAnaY+u0aklL+ysyfWFK
	9irlaZJb7lcUmsDt6oTfea8Xe/jyJn63We4Ka0QFVE3mNUfnS8sdKN+fWvNAyZ1MOU/ZN/j+4rH
	QO2B3ktG76i8CvGiD8mKd6jP8/IQr0NqcSRYvXnKKs9Z7YFw==
X-Google-Smtp-Source: AGHT+IG6AINfZdUCPfzT8AwfhKZBeHvy0VxUpVHCcEUnJ32GxsAJb2So5ds0n6CnLaxeTzOuP7MfSw==
X-Received: by 2002:a17:902:f684:b0:295:8da4:6404 with SMTP id d9443c01a7336-2984eddda7bmr51528655ad.40.1762971367129;
        Wed, 12 Nov 2025 10:16:07 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf0b77sm37110645ad.28.2025.11.12.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:16:06 -0800 (PST)
From: Yongliang Gao <leonylgao@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bigeasy@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: [PATCH v2] trace/pid_list: optimize pid_list->lock contention
Date: Thu, 13 Nov 2025 02:14:56 +0800
Message-ID: <20251112181456.473864-1-leonylgao@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongliang Gao <leonylgao@tencent.com>

When the system has many cores and task switching is frequent,
setting set_ftrace_pid can cause frequent pid_list->lock contention
and high system sys usage.

For example, in a 288-core VM environment, we observed 267 CPUs
experiencing contention on pid_list->lock, with stack traces showing:

 #4 [ffffa6226fb4bc70] native_queued_spin_lock_slowpath at ffffffff99cd4b7e
 #5 [ffffa6226fb4bc90] _raw_spin_lock_irqsave at ffffffff99cd3e36
 #6 [ffffa6226fb4bca0] trace_pid_list_is_set at ffffffff99267554
 #7 [ffffa6226fb4bcc0] trace_ignore_this_task at ffffffff9925c288
 #8 [ffffa6226fb4bcd8] ftrace_filter_pid_sched_switch_probe at ffffffff99246efe
 #9 [ffffa6226fb4bcf0] __schedule at ffffffff99ccd161

Replaces the existing spinlock with a seqlock to allow concurrent readers,
while maintaining write exclusivity.

---
Changes from v1:
- Fixed sleep-in-atomic issues under PREEMPT_RT. [Steven Rostedt]
- Link to v1: https://lore.kernel.org/all/20251015114952.4014352-1-leonylgao@gmail.com
---

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>
---
 kernel/trace/pid_list.c | 77 ++++++++++++++++++++++++++++-------------
 kernel/trace/pid_list.h |  1 +
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 090bb5ea4a19..8921102543ff 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2021 VMware Inc, Steven Rostedt <rostedt@goodmis.org>
  */
-#include <linux/spinlock.h>
+#include <linux/seqlock.h>
 #include <linux/irq_work.h>
 #include <linux/slab.h>
 #include "trace.h"
@@ -126,7 +126,7 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 {
 	union upper_chunk *upper_chunk;
 	union lower_chunk *lower_chunk;
-	unsigned long flags;
+	unsigned int seq;
 	unsigned int upper1;
 	unsigned int upper2;
 	unsigned int lower;
@@ -138,14 +138,16 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return false;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
-	upper_chunk = pid_list->upper[upper1];
-	if (upper_chunk) {
-		lower_chunk = upper_chunk->data[upper2];
-		if (lower_chunk)
-			ret = test_bit(lower, lower_chunk->data);
-	}
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	do {
+		seq = read_seqcount_begin(&pid_list->seqcount);
+		ret = false;
+		upper_chunk = pid_list->upper[upper1];
+		if (upper_chunk) {
+			lower_chunk = upper_chunk->data[upper2];
+			if (lower_chunk)
+				ret = test_bit(lower, lower_chunk->data);
+		}
+	} while (read_seqcount_retry(&pid_list->seqcount, seq));
 
 	return ret;
 }
@@ -178,6 +180,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk) {
 		upper_chunk = get_upper_chunk(pid_list);
@@ -199,6 +202,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	set_bit(lower, lower_chunk->data);
 	ret = 0;
  out:
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return ret;
 }
@@ -230,6 +234,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk)
 		goto out;
@@ -250,6 +255,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		}
 	}
  out:
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return 0;
 }
@@ -271,7 +277,6 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 {
 	union upper_chunk *upper_chunk;
 	union lower_chunk *lower_chunk;
-	unsigned long flags;
 	unsigned int upper1;
 	unsigned int upper2;
 	unsigned int lower;
@@ -282,27 +287,44 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
-	for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
-		upper_chunk = pid_list->upper[upper1];
+	do {
+		unsigned int start_upper1 = upper1;
+		unsigned int start_upper2 = upper2;
+		unsigned int start_lower = lower;
+		unsigned int seq;
 
-		if (!upper_chunk)
-			continue;
+		seq = read_seqcount_begin(&pid_list->seqcount);
 
-		for (; upper2 <= UPPER_MASK; upper2++, lower = 0) {
-			lower_chunk = upper_chunk->data[upper2];
-			if (!lower_chunk)
+		for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
+			upper_chunk = pid_list->upper[upper1];
+
+			if (!upper_chunk)
 				continue;
 
-			lower = find_next_bit(lower_chunk->data, LOWER_MAX,
-					    lower);
-			if (lower < LOWER_MAX)
-				goto found;
+			for (; upper2 <= UPPER_MASK; upper2++, lower = 0) {
+				lower_chunk = upper_chunk->data[upper2];
+				if (!lower_chunk)
+					continue;
+
+				lower = find_next_bit(lower_chunk->data, LOWER_MAX,
+						    lower);
+				if (lower < LOWER_MAX)
+					goto found;
+			}
 		}
-	}
 
+		upper1 = UPPER_MASK + 1; /* Mark as not found */
  found:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+		if (read_seqcount_retry(&pid_list->seqcount, seq)) {
+			/* Retry if write happened during read */
+			upper1 = start_upper1;
+			upper2 = start_upper2;
+			lower = start_lower;
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (upper1 > UPPER_MASK)
 		return -1;
 
@@ -340,8 +362,10 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 
  again:
 	raw_spin_lock(&pid_list->lock);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
 	lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock(&pid_list->lock);
 
 	if (upper_count <= 0 && lower_count <= 0)
@@ -370,6 +394,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	}
 
 	raw_spin_lock(&pid_list->lock);
+	write_seqcount_begin(&pid_list->seqcount);
 	if (upper) {
 		*upper_next = pid_list->upper_list;
 		pid_list->upper_list = upper;
@@ -380,6 +405,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		pid_list->lower_list = lower;
 		pid_list->free_lower_chunks += lcnt;
 	}
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock(&pid_list->lock);
 
 	/*
@@ -419,6 +445,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	init_irq_work(&pid_list->refill_irqwork, pid_list_refill_irq);
 
 	raw_spin_lock_init(&pid_list->lock);
+	seqcount_raw_spinlock_init(&pid_list->seqcount, &pid_list->lock);
 
 	for (i = 0; i < CHUNK_ALLOC; i++) {
 		union upper_chunk *chunk;
diff --git a/kernel/trace/pid_list.h b/kernel/trace/pid_list.h
index 62e73f1ac85f..0b45fb0eadb9 100644
--- a/kernel/trace/pid_list.h
+++ b/kernel/trace/pid_list.h
@@ -76,6 +76,7 @@ union upper_chunk {
 };
 
 struct trace_pid_list {
+	seqcount_raw_spinlock_t		seqcount;
 	raw_spinlock_t			lock;
 	struct irq_work			refill_irqwork;
 	union upper_chunk		*upper[UPPER1_SIZE]; // 1 or 2K in size
-- 
2.43.5


