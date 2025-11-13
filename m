Return-Path: <linux-kernel+bounces-898386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF33C552D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05F54EAE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF51DE8BE;
	Thu, 13 Nov 2025 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTmU6g+P"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863B35971
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994736; cv=none; b=BZvzY1X+Pa/bmOC3q1j0MDDGUeGGMsC+JEfatSUDUBBd4aSJD4F4agcWJWuG6JbrHzqSkpvRWA0EYgJKXGlkK70CQLeQ3FUu80EZnXiobk1e1xixM1Ib9q5V8pP8hy2BV57FBiEOAzFLREtC40cl7e9r6HcKmMoxkPbW8yHksWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994736; c=relaxed/simple;
	bh=dM2RW60S0IFI2XhvUpWYR2e7QHATXcfs09M33YXiB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVnXhW/s8Ei0dMStY5qy636NL6MYqS3x0PedNoGY5Mmdv94KIQs29cR1YLk4qyPnmsltQWPGFo6HtEeTKBlA9RiVGI2f0TqxnE83Fo0qvPl1ljekoOX4XgCVFKL0YCPqLT7CeFjZ+Lh6+mJDsTDkMM1Y9TL1WuJrG4BPompmw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTmU6g+P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297ec50477aso1741535ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762994734; x=1763599534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZGbnjbfhbIv2LYue2aZM25xg9oslMd4caKKmXuddUw=;
        b=cTmU6g+PAcuZ0Df5lSqvilePCAYQ1EB7vH70wjb8rwqs2WfrMTsSoHvvmAmH6+H5Rj
         GhcQx/gCA+GxDTqHPRHMuSrNCf3FHtw8tAmWagvklNfZ85qdQH7yrYRTTuGa9abZakLw
         txSgmTj5mt6tnXry3bLZrcst7jSYsYfDDNO82SobnW0YtXDC7qCJxQv9aJnOth5LbhDq
         RDc+jrFnlDv4MXpYopYlRKszyhpUH8Wu6dCbBvCIWXdTPlBjk6wGBYrWMQDXh3c5s47T
         T6JHCU0aZ3kTaD0MVfi73s3pyY+2t/nGv69JPnJ6v9lhymPTwjoH8nYMBuFPyPj7ddXM
         GELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994734; x=1763599534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZGbnjbfhbIv2LYue2aZM25xg9oslMd4caKKmXuddUw=;
        b=vtCv8BguRg4VMVLTHwSoeEeSYgc2ahA33RFeS/fU3rtEysIQtNkvF9o7RoZcWFFjXP
         znPWWVQ+IuQLK+UxHRdGH+51+qxjsf8gPdoZMCL32ZpxmqaM5nCUAyf3xyJRf6K+Fcte
         V/VYVXPgM/i/lNESyJ/BdW1pKfdbm3qtxVvRd682cZJcs9KDsMBWbnsqwZE8rX0iGH7o
         3V4BzoklcSlcJ8n+hUxKFfJfTwSZzrtdb+U4NStOUtPxZgK//po9cIXYYyC9kIsBLnMt
         +qzViWbdm1XhSSjJ4hJolg6j9GJymVWD5IHBCMb8lQ2kces597pmn1ScEdARkNZgx4wA
         9RSQ==
X-Gm-Message-State: AOJu0YxlFOm1GLpEbjNLrjup35NECvoy+DsbQ9eh3waqAKlmWTSxudFv
	DJ4WAvUB5WicWYSemRV3sng9DQEW5VGbwAGucFOKLTI0I75t/F5EVY6KjSq6DtacTWs=
X-Gm-Gg: ASbGnctRV58pYykG8HqNh5s+Aa812hG1IDC9EtULdE/3k34tvj3afjmyZneNRGGkgxu
	mIVEL2tD3/+3Qdf0cIPFqrcOK+Is7hwWxQKDJS6Qvm6MAuzJw2JyMUt+X6AS3WQUcMkTa/OUmAT
	tAINkzKj1aoS3qSC2qbw5GRuVdY/PTO/5yY1fwQpN3OOPmgAfCndejZGl0DLV5fF3ZVBfSfWPrc
	f7kk9gTjkp4pPr9OlbNhMRuuB6FVgI0GYuoQx5olRNZUjU/E552VwcGKI9JVuU3HWDEUDVi6+CM
	2+EvrozyAeVAVN/hpJr+x0MhAnLatJ1Wlbxwq0MZp7vRXCHikcrL4yUAHkRbuOr/MRYawUxN1Kr
	bbYn282NSwJW6bB8Wv237KOM9f41dPGJ2AnfaxBNEL/HUe8i1tU8kJJInBoeol4InPHxBLoRe68
	KQE2RM1W03Yt0jVwd8cpBzc434wGz7Qsi91l3DgWxpyurVQA==
X-Google-Smtp-Source: AGHT+IEKsh4hpv4rhzeMRhpK4KhZeS2wWsRCuXFKcZVxL6hhZruUZ0p/DjwxQesc0TGal9CfU8U3WA==
X-Received: by 2002:a17:903:19d0:b0:297:eafd:5c19 with SMTP id d9443c01a7336-2985a4cf16emr17046055ad.10.1762994733948;
        Wed, 12 Nov 2025 16:45:33 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07d2e4asm3887324a91.18.2025.11.12.16.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:45:33 -0800 (PST)
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
Subject: [PATCH v4] trace/pid_list: optimize pid_list->lock contention
Date: Thu, 13 Nov 2025 08:45:26 +0800
Message-ID: <20251113004526.1129666-1-leonylgao@gmail.com>
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

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>

---
Changes from v3:
- Fixed patch format as per feedback. [Steven Rostedt]
- Link to v3: https://lore.kernel.org/all/20251113000252.1058144-1-leonylgao@gmail.com
Changes from v2:
- Keep trace_pid_list_next() using raw_spin_lock for simplicity. [Steven Rostedt]
- Link to v2: https://lore.kernel.org/all/20251112181456.473864-1-leonylgao@gmail.com
Changes from v1:
- Fixed sleep-in-atomic issues under PREEMPT_RT. [Steven Rostedt]
- Link to v1: https://lore.kernel.org/all/20251015114952.4014352-1-leonylgao@gmail.com
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


