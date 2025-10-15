Return-Path: <linux-kernel+bounces-854422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F326BDE53D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE005427AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CADF322DD1;
	Wed, 15 Oct 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk/tktpQ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37476322DC1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529000; cv=none; b=cxwjAaH7x5R7QrKwcjBhEdmplYG7rVza5TS2LOc3EQXSAAOF8B0Jw0sg88ZpxvhK3hAhKgd6HXBBLAXzluvsWc9BlAQyPIAaTjHKl1t6ZQN9HmGH7axL79j/j3QDgURYihGSyP9zhAWt4bMaAYN1NWm7SH81uiW0mxlBU+pEuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529000; c=relaxed/simple;
	bh=67bPLpk4XtiM2chNuj/NIzxAtVYUBkPeAY7FycKz6x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeVWoPQfcVdzuZoZqUteo58fQOlJ6JgSvcvo++YHiiJdREUDh1F7FGIQ+2r8qdlF8ySEJvLlb/FkmhpItMuJnxDtUc+a+9QnIsx0bk4z0bm8DFVGXK5GtHxxo0qiRGcconuYpjGUDzjPflQAdbHbyWHe5QTzP7eiY63uikRsJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk/tktpQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3322e63602eso8453341a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528998; x=1761133798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7DX/MsjusdVTQDdPxzEiOw94/h8+AXMbc90Y8BQxVw=;
        b=hk/tktpQXkqqHRT7an5sKJ65tB4T2xXnYJz6ktReFg7+0UR6ndpyr3Ld6K1JnI4YW8
         dKJchGk1WPnPrIkypO2+GG+DYc3xEW/ALRkMgME9b3YOvmy+M+YvQizzCN3DQTNfNfEt
         5fNOHtip/toozfFzzNj9TQum3yED16IFUZkMPZvHypHccBb/8vCNKs/C2Rz0cV5j8H/P
         GIiD+pi8/PuN0httHMaO87M6SPVGw0jnISAoR0+SMWPL7DACV5lmzWmrDh321SDNM1LO
         fwqtTNda8+643ySqhWjBWJrAyk3R0x63PGj1W6fqIYv9DPHZmFVq4K9YRGazVHRXR3pC
         D7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528998; x=1761133798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7DX/MsjusdVTQDdPxzEiOw94/h8+AXMbc90Y8BQxVw=;
        b=fCtHLdyOIGmUWzJeMnOKo4SkDm7XVsZPIiVCQ+nP67KoXQFSsGacXaeCXcOE46FTx+
         Y4doCluk0Ootadk/7SrE1qvZhaBLhDyBIeOSSsBAXbjEYpHshzrm/JEspf+eRlwaa2l6
         O80BNYqjcyNQja3UhXB/Bdv7jNWduozITLdAu2t6DetBsv9ZfqNDmaNi7TKXJJJY+NXg
         mUVy0dTAGD/v9BUJCWKjawy4eGJ/eHe0Nh0ar4JYBBEjAJXhPYXqCMzv5n9X7NURUuYf
         iM7bJU7199ZNqhRTTRJ1l79DK1SZJVJ/cKOERwr7gzsmT5xN3WhDpzW4VOJ0p91QTRsS
         SnzA==
X-Gm-Message-State: AOJu0YzyZQ3tacXNGk3TvGPuWqphkpUNmeCLRSTJSS6JeoNOx3hjScQI
	kMubHY0QbTeWzhOL7LkEClnOiW6uaUm/n7SvVLP+7YXTdZIyLy2V5S3U
X-Gm-Gg: ASbGncth0Vq2OroOWZGsQgg8mgquI+K7mYmCYMCUkdjhYjQ4+KzSeFZ6dbvsGVUREbb
	+MpmS+KUOhsD3jW09oLymycTFKMI5IZouXIr/9tCLVm93MHKez3881ak+of6ta9t7d4Q2Adm+IF
	+wZ7KpSdmUPZ5ugCNkSZvbVSnQROf3vBLoTXxLzWcRE1qBJkGHjl+S3JbMNKT3tASlRsHvz8E+4
	qNolHrQJXRP/759oySgO9/PPt31AXs9v6Sxt8QuLwoIQNLq8aadQo+nlU4Jnu1nPKChZmuNPRkA
	3Eq14a5OclI9YzX53ZczkVqm2EMg39/COKnmifkPY4ukvOvAJKqhg38jZ2x4sFXy/lUY8/ZNrTX
	vnodh8dNqiW5eESFol7JR0Z0GfGR6i2YJXkH5+Mhj8CxxGUV6K1XQjuPKKb3Hi/UzWBYHdqPY1C
	zsM9aijAcLqh3j0NA=
X-Google-Smtp-Source: AGHT+IHA7jmacf+2jyZ8effG47uhvpwUPR/qPm49iok5/wykenkm7y4wr4qNXbSUS6lRbQH9DgwwKA==
X-Received: by 2002:a17:90b:33d1:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-33b51149673mr39484383a91.1.1760528998341;
        Wed, 15 Oct 2025 04:49:58 -0700 (PDT)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a4f8bfsm9632658a91.10.2025.10.15.04.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:49:57 -0700 (PDT)
From: Yongliang Gao <leonylgao@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: [PATCH] trace/pid_list: optimize pid_list->lock contention
Date: Wed, 15 Oct 2025 19:49:52 +0800
Message-ID: <20251015114952.4014352-1-leonylgao@gmail.com>
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

For example, in a vmcore environment with 288 cores, We found 267
CPUs are in pid_list->lock contention.

 #4 [ffffa6226fb4bc70] native_queued_spin_lock_slowpath at ffffffff99cd4b7e
 #5 [ffffa6226fb4bc90] _raw_spin_lock_irqsave at ffffffff99cd3e36
 #6 [ffffa6226fb4bca0] trace_pid_list_is_set at ffffffff99267554
 #7 [ffffa6226fb4bcc0] trace_ignore_this_task at ffffffff9925c288
 #8 [ffffa6226fb4bcd8] ftrace_filter_pid_sched_switch_probe at ffffffff99246efe
 #9 [ffffa6226fb4bcf0] __schedule at ffffffff99ccd161

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>
---
 kernel/trace/pid_list.c | 26 +++++++++++++-------------
 kernel/trace/pid_list.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 090bb5ea4a19..62082a4f60db 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -138,14 +138,14 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return false;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	read_lock_irqsave(&pid_list->lock, flags);
 	upper_chunk = pid_list->upper[upper1];
 	if (upper_chunk) {
 		lower_chunk = upper_chunk->data[upper2];
 		if (lower_chunk)
 			ret = test_bit(lower, lower_chunk->data);
 	}
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	read_unlock_irqrestore(&pid_list->lock, flags);
 
 	return ret;
 }
@@ -177,7 +177,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_lock_irqsave(&pid_list->lock, flags);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk) {
 		upper_chunk = get_upper_chunk(pid_list);
@@ -199,7 +199,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	set_bit(lower, lower_chunk->data);
 	ret = 0;
  out:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	write_unlock_irqrestore(&pid_list->lock, flags);
 	return ret;
 }
 
@@ -229,7 +229,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_lock_irqsave(&pid_list->lock, flags);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk)
 		goto out;
@@ -250,7 +250,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		}
 	}
  out:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	write_unlock_irqrestore(&pid_list->lock, flags);
 	return 0;
 }
 
@@ -282,7 +282,7 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	read_lock_irqsave(&pid_list->lock, flags);
 	for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
 		upper_chunk = pid_list->upper[upper1];
 
@@ -302,7 +302,7 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 	}
 
  found:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	read_unlock_irqrestore(&pid_list->lock, flags);
 	if (upper1 > UPPER_MASK)
 		return -1;
 
@@ -339,10 +339,10 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	int lcnt = 0;
 
  again:
-	raw_spin_lock(&pid_list->lock);
+	write_lock(&pid_list->lock);
 	upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
 	lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
-	raw_spin_unlock(&pid_list->lock);
+	write_unlock(&pid_list->lock);
 
 	if (upper_count <= 0 && lower_count <= 0)
 		return;
@@ -369,7 +369,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		lcnt++;
 	}
 
-	raw_spin_lock(&pid_list->lock);
+	write_lock(&pid_list->lock);
 	if (upper) {
 		*upper_next = pid_list->upper_list;
 		pid_list->upper_list = upper;
@@ -380,7 +380,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		pid_list->lower_list = lower;
 		pid_list->free_lower_chunks += lcnt;
 	}
-	raw_spin_unlock(&pid_list->lock);
+	write_unlock(&pid_list->lock);
 
 	/*
 	 * On success of allocating all the chunks, both counters
@@ -418,7 +418,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 
 	init_irq_work(&pid_list->refill_irqwork, pid_list_refill_irq);
 
-	raw_spin_lock_init(&pid_list->lock);
+	rwlock_init(&pid_list->lock);
 
 	for (i = 0; i < CHUNK_ALLOC; i++) {
 		union upper_chunk *chunk;
diff --git a/kernel/trace/pid_list.h b/kernel/trace/pid_list.h
index 62e73f1ac85f..da200834f4ad 100644
--- a/kernel/trace/pid_list.h
+++ b/kernel/trace/pid_list.h
@@ -76,7 +76,7 @@ union upper_chunk {
 };
 
 struct trace_pid_list {
-	raw_spinlock_t			lock;
+	rwlock_t			lock;
 	struct irq_work			refill_irqwork;
 	union upper_chunk		*upper[UPPER1_SIZE]; // 1 or 2K in size
 	union upper_chunk		*upper_list;
-- 
2.43.5


