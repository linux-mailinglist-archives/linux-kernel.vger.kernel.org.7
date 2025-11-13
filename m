Return-Path: <linux-kernel+bounces-898318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF70C54DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B93AD269
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634DA11CBA;
	Thu, 13 Nov 2025 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZvkB3+o"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB10C8F0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992185; cv=none; b=pq/rYGOaJXzp0DIyTa0cchk5uOHkASmi4wZgXXnG/dMtuV2wlRiFX7bnhGbxFFGjpTHTeU+Oi0Hp6psJxyeP0UzeCli5eiCbTJH73nE/4QVHBEKdaV/L8FmQMMO9bJsgutDqvo7XQDJWNebIWCHqAT6QbQEV9uk6XEPIFcbCFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992185; c=relaxed/simple;
	bh=2d1PmSahrO9i9M6Z1G+BuUB4z0o+2hreIN2UcdEKnzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhA9cOfIbuNTKJGRLpd+Gc1VRJuGeKS9qnej7s68IUVol1GfjaWTVUL1ALCp6GqIopCZOA5B8bt4XQNpQEOp1g4GAjh1yznq67MPU7EmDFqG6ZvdKPrhyb1dBmUyNkeU+dLWgQgZ2Rnwy4It/exTzw1HQnjvQ4kG87Pt1DIm9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZvkB3+o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b4933bc4bbso221408b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762992183; x=1763596983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEj/ojo6JDZMNsfky5JeXpMs3oH+g8HQgGx2nKzX0hI=;
        b=hZvkB3+otxOel1j2H5JrMTWgojzIQHW9Molncfhf3lL+HK7HzA7uFni6TlE8Fpor8E
         sLRO4PNvbRrXD1FDX57Tgk+/UzTU8CAQOBwrCaxfWbafeims3WMoTqiTX+hw88I1/e0x
         mDdZswNUFS2gCJwbCeGSiQ4mlAd27UTyBTnSZ2NS863N61ug+KfaGP5u9DBOMPEiTKB/
         LwwOAEkCBVhcDKK05sQtSEgaOCFDlKu0cDoX/MsUo5o1aWTAFhwTPOk0oyw2gn45Uzvt
         aTUvqksNISPy2rNiMnCJndgaDGpKN//jOee8qWdlJEQphHikoBh8IgEPBfIGfTk0b35P
         raMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992183; x=1763596983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEj/ojo6JDZMNsfky5JeXpMs3oH+g8HQgGx2nKzX0hI=;
        b=GNxg59mR4zj3vBfb9Z0+45ZSMu1wyLyGGBO1f3vU0Tyv6Sa3+BRPmm23gxLnMu2B8n
         Byg8S9jX0s/4d1VprUvyUMNYS4u9FhlmyG4C609KxhNmJDukvzNQkEDa2pQHoYiF2R9x
         y3ueVVKEzhlxnT8aS2L8BFH9lMql3KP7DCK74AxvwuOEhdJb5k/kzMcKPtFyQYSwC8qE
         1urcm351K/g7AzfLJcmU0+ti8QuSZEdRFU7//D/aujLF6xWgqSWSeQraFI99CxouqjYU
         /LqX4D4AHv++jM2A8F8h8bl/sSMpfTX2iBXnrAsGHDznWU38fkZ7U2+0lBRma2ycwRAO
         OJgg==
X-Gm-Message-State: AOJu0YzNzbnpudZ69VLPINBD961yeylHDrXlfMh7H9omKMHSXzJOLB8Y
	y62Ed9WqXY188g1Qyjngxo/b5WW0dDVd2GHsqY9cUcHaOwlzrHlXfWwq
X-Gm-Gg: ASbGnctWwlU9pswMG/1/E/ZeLgQwf/lwPHSBfI0LKFBXQCymzBYKbXiOwToAzsF1i3G
	a31Hqji1kGjwPZOqsNRmlH5moauH6sp5n3RmXT2YZwjr7hGmFktnG1NOJUx2tKMbPlDggJhXKA/
	pTdbGR7/F8orTj5fiuRwAgCorFSMEgxA9gPZNVSUCqHA8r/4flCqfba5PY84AAJCGcczs8tCJnj
	n9eu9TTXz1ERies9UcQ/UE/H5oho1o26rI1WP7EJt5D4a04enX1NyIfe3QhTILlFGgPtDtKm92G
	9+eHtakKtqU9fyHEzfenMYuK7cZnClXSEoeSR8e4pHJByShx8dVaLkMB7sKC0vt+zW5/Wm4a5/R
	UnguNbOINlHZiSdRTShpubjp/JJ8i7up/O+qh+ac7SYQnnb/FDDrAjym7TYUmPsKbalLTPwgi8V
	Sz6Q3LQyJMnFkszV7SyjYsOW04MlRM9gCVPBK5u9OOyHAHtg==
X-Google-Smtp-Source: AGHT+IEnM79BvZyBixnjboboF7WynqTSpPF7hApf/6Tx2azXkKYm6rIu6qmhALR/iDXye9UzL+a+8w==
X-Received: by 2002:a05:6a20:939e:b0:342:1d16:80e with SMTP id adf61e73a8af0-35a4eafc50fmr1438846637.4.1762992183333;
        Wed, 12 Nov 2025 16:03:03 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731a72sm213711b3a.50.2025.11.12.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:03:02 -0800 (PST)
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
Subject: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Date: Thu, 13 Nov 2025 08:02:52 +0800
Message-ID: <20251113000252.1058144-1-leonylgao@gmail.com>
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
Changes from v2:
- Keep trace_pid_list_next() using raw_spin_lock for simplicity. [Steven Rostedt]
- Link to v2: https://lore.kernel.org/all/20251112181456.473864-1-leonylgao@gmail.com
Changes from v1:
- Fixed sleep-in-atomic issues under PREEMPT_RT. [Steven Rostedt]
- Link to v1: https://lore.kernel.org/all/20251015114952.4014352-1-leonylgao@gmail.com
---

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>
---
 kernel/trace/pid_list.c | 30 +++++++++++++++++++++---------
 kernel/trace/pid_list.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 090bb5ea4a19..dbee72d69d0a 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 VMware Inc, Steven Rostedt <rostedt@goodmis.org>
  */
 #include <linux/spinlock.h>
+#include <linux/seqlock.h>
 #include <linux/irq_work.h>
 #include <linux/slab.h>
 #include "trace.h"
@@ -126,7 +127,7 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 {
 	union upper_chunk *upper_chunk;
 	union lower_chunk *lower_chunk;
-	unsigned long flags;
+	unsigned int seq;
 	unsigned int upper1;
 	unsigned int upper2;
 	unsigned int lower;
@@ -138,14 +139,16 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
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
@@ -178,6 +181,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk) {
 		upper_chunk = get_upper_chunk(pid_list);
@@ -199,6 +203,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	set_bit(lower, lower_chunk->data);
 	ret = 0;
  out:
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return ret;
 }
@@ -230,6 +235,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk)
 		goto out;
@@ -250,6 +256,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		}
 	}
  out:
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return 0;
 }
@@ -340,8 +347,10 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 
  again:
 	raw_spin_lock(&pid_list->lock);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
 	lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock(&pid_list->lock);
 
 	if (upper_count <= 0 && lower_count <= 0)
@@ -370,6 +379,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	}
 
 	raw_spin_lock(&pid_list->lock);
+	write_seqcount_begin(&pid_list->seqcount);
 	if (upper) {
 		*upper_next = pid_list->upper_list;
 		pid_list->upper_list = upper;
@@ -380,6 +390,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		pid_list->lower_list = lower;
 		pid_list->free_lower_chunks += lcnt;
 	}
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock(&pid_list->lock);
 
 	/*
@@ -419,6 +430,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
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


