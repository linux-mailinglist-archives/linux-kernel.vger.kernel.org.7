Return-Path: <linux-kernel+bounces-654674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53DABCB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 00:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A998C5020
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2F21FF47;
	Mon, 19 May 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HI4CSfR+"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C021D3F3
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694816; cv=none; b=l4dFpbP3aMTHA8kF2TkInEzxVLWM61hhGjECI+LCf4Fp90bnuWV/Ca6OhOLeVUucugSzXfhoRg0E91w+t+YLZqhB8/JRP5jqaI+NUylwz7PbNBE2JwZS33UKHm19n6qEL+G3vMJIb0W0WhYoXSWQLMNSQuNQc/jLa5GmuW8bW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694816; c=relaxed/simple;
	bh=y05FfKgWFu3KgBj64UzB40r9UGdYX68inbr1vvi1sS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Bl7OLEqzpXeKPV+HNOVgvHbQK3g7gW9kfugLia1fT94W6ROLcJUOKwQwx/kzrRnJtCAMvyT0vx1ECzrWQhbpdZiTqBRFJol57pUZdtSSAndZjvO/tGY0y1xfvS/+uXP1aysRal3cx3KOJ9zqqgA1XzOqoYzMJzu2qu8gQ2+72oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HI4CSfR+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e73d375aso4871410a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747694814; x=1748299614; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chrPkT8MGy8AVje5FFeicTXRYmDpybHtRMitOIBF0/0=;
        b=HI4CSfR+tORlwqZzxZMw4MHwPrmP+KsbfxBR6j+7DG+cWfNMCgj23w8coSFYUP8er7
         Dq+L5cU4NV3pAK2QaqvbYI+fb8Oxs/r1tOvqVfpMpzcvDyqwtL0myvkNeafd5s6KtsQ4
         qUnaw03LI1fAkmU+4FQtnhhzCPzppXg3tJCz9NfE2Isw0Um9bcbUXAjG72n4AkMjgE4Q
         iVBu9e578++firVediiNKdFonvetMKFRbnBtx1hhOYN1RCauUaHoP5jQNORit4YsuggV
         yxFHQRR0lGo1R3B/9utn2dUkYhd9/r/2SJdGR5fJkNHvnt9LLt30962UXhDMLy6MTa/W
         7vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747694814; x=1748299614;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chrPkT8MGy8AVje5FFeicTXRYmDpybHtRMitOIBF0/0=;
        b=sEUOfp7NHuEZFNc3lXuIykcYELEm2zaZaKmlpGsz5a5YhPuVymvB8ZvmL3y0f/VjE7
         fCOEBA9S51gGFyQyme/4l6NFGqY5IJayQpyVcNXOQ3jMzrp2T4RiJ+ovUoWbyb3p7sbx
         F9fA3jtCNHL1cyjiRFZ/CAnwvGQiXAtxgh5R5vgmvcK3lCOPmLBGwFh2lp12vryI9AxD
         hMHfxZIMUigC9gvd78Do8LJjKBXSYoyPy9JjnV+z30FqZm0+37jv07Cc8e8T7lJv2up9
         4lCuOS69melv81a3NtOsAt0qZLW3J8xNHbgjYg/ik70d3/s5LXfTynDIDmLY7etKG4dc
         6Wfg==
X-Forwarded-Encrypted: i=1; AJvYcCVHhap9YfT34uFckq8jNa7q5pyWYxQ6b6xZEdoxNIcS7omzKBrnQmZYBoGwvPSJRnZqIteSw4frpiXSItM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFSzWEPDRihcDdkM84YTpw0z8uJci67u8Zc9lficOTPo3FODu
	8TODZAlmp2LFS4Pv+UW5Beh1yu/+9g8OMtfkFDJkvykIZHixmySG8V/uS2j6UMBRvXjbWDdE7J0
	E8NgLwTxXFw==
X-Google-Smtp-Source: AGHT+IGyuriEzu2LamxMhi26AQXGJxe9A9HPRgJn5zGx+Wzwu1rWLh0kU0BiA1CKQ9xLPP3PGdahUThWL/Cc
X-Received: from pfbiv22.prod.google.com ([2002:a05:6a00:66d6:b0:740:b061:1007])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9982:b0:215:d611:5d9b
 with SMTP id adf61e73a8af0-2170cb260bfmr19617474637.12.1747694813707; Mon, 19
 May 2025 15:46:53 -0700 (PDT)
Date: Mon, 19 May 2025 15:46:45 -0700
In-Reply-To: <20250519224645.1810891-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519224645.1810891-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519224645.1810891-3-irogers@google.com>
Subject: [PATCH v1 3/3] perf thread: Ensure comm_lock held for comm_list
From: Ian Rogers <irogers@google.com>
To: langfei@huawei.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, James Clark <james.clark@linaro.org>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add thread safety annotations for comm_list and add locking for two
instances where the list is accessed without the lock held (in
contradiction to ____thread__set_comm).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c   |  2 ++
 tools/perf/util/thread.c | 17 +++++++++++++----
 tools/perf/util/thread.h |  9 +++++----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 8aa456d7c2cd..9880247a2c33 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -24,6 +24,7 @@ static struct comm_strs {
 static void comm_strs__remove_if_last(struct comm_str *cs);
 
 static void comm_strs__init(void)
+	NO_THREAD_SAFETY_ANALYSIS /* Inherently single threaded due to pthread_once. */
 {
 	init_rwsem(&_comm_strs.lock);
 	_comm_strs.capacity = 16;
@@ -119,6 +120,7 @@ static void comm_strs__remove_if_last(struct comm_str *cs)
 }
 
 static struct comm_str *__comm_strs__find(struct comm_strs *comm_strs, const char *str)
+	SHARED_LOCKS_REQUIRED(comm_strs->lock)
 {
 	struct comm_str **result;
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 415c0e5d1e75..c202b98b36c2 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -41,6 +41,7 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 }
 
 struct thread *thread__new(pid_t pid, pid_t tid)
+	NO_THREAD_SAFETY_ANALYSIS /* Allocation/creation is inherently single threaded. */
 {
 	RC_STRUCT(thread) *_thread = zalloc(sizeof(*_thread));
 	struct thread *thread;
@@ -202,22 +203,29 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 
 struct comm *thread__comm(struct thread *thread)
 {
-	if (list_empty(thread__comm_list(thread)))
-		return NULL;
+	struct comm *res = NULL;
 
-	return list_first_entry(thread__comm_list(thread), struct comm, list);
+	down_read(thread__comm_lock(thread));
+	if (!list_empty(thread__comm_list(thread)))
+		res = list_first_entry(thread__comm_list(thread), struct comm, list);
+	up_read(thread__comm_lock(thread));
+	return res;
 }
 
 struct comm *thread__exec_comm(struct thread *thread)
 {
 	struct comm *comm, *last = NULL, *second_last = NULL;
 
+	down_read(thread__comm_lock(thread));
 	list_for_each_entry(comm, thread__comm_list(thread), list) {
-		if (comm->exec)
+		if (comm->exec) {
+			up_read(thread__comm_lock(thread));
 			return comm;
+		}
 		second_last = last;
 		last = comm;
 	}
+	up_read(thread__comm_lock(thread));
 
 	/*
 	 * 'last' with no start time might be the parent's comm of a synthesized
@@ -233,6 +241,7 @@ struct comm *thread__exec_comm(struct thread *thread)
 
 static int ____thread__set_comm(struct thread *thread, const char *str,
 				u64 timestamp, bool exec)
+	EXCLUSIVE_LOCKS_REQUIRED(thread__comm_lock(thread))
 {
 	struct comm *new, *curr = thread__comm(thread);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cd574a896418..56e08c8ae005 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -236,14 +236,15 @@ static inline struct rw_semaphore *thread__namespaces_lock(struct thread *thread
 	return &RC_CHK_ACCESS(thread)->namespaces_lock;
 }
 
-static inline struct list_head *thread__comm_list(struct thread *thread)
+static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
 {
-	return &RC_CHK_ACCESS(thread)->comm_list;
+	return &RC_CHK_ACCESS(thread)->comm_lock;
 }
 
-static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
+static inline struct list_head *thread__comm_list(struct thread *thread)
+	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
 {
-	return &RC_CHK_ACCESS(thread)->comm_lock;
+	return &RC_CHK_ACCESS(thread)->comm_list;
 }
 
 static inline u64 thread__db_id(const struct thread *thread)
-- 
2.49.0.1101.gccaa498523-goog


