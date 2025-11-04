Return-Path: <linux-kernel+bounces-884110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0EBC2F61C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14E54E5FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5132D8DB8;
	Tue,  4 Nov 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWWzU/2W"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F82D3724
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234515; cv=none; b=M+894iO0e1Usw0HyFYikVl92e57eWueSGLqdsPzg7byy/91SJ+Zwat36O51tnKDXaWJL2fDp4n6B/omxaLAj/XwXYmWhzz3WrzXrcQRntYBs8t4fU4AN9NjKLFhUhLDiThQmLvADGw/uNPGWxfVcD7838wcPvz8yvZ5UHZWFauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234515; c=relaxed/simple;
	bh=bJbxS9bBatxeYgFbkEtaODM1/57yTM4qiiWIKLBpyXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=HDfOHInfzDj4wr538LkMURgQPfBQZIFkmKTQgg5WXef3pjrf37eg5nfn7+N9mue9rYibZrQQZcvJpwHOiLR5DalSLP45GSRpI5Rk/ASlMj6HkmU5x5au8XmHJ1Rq/lgYOz8uk7xpMWSPZya7SWT+raY+64kQr0V5B2GYmklRnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWWzU/2W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-78120957aceso67794067b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762234512; x=1762839312; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GDR4fNhLPPj2XAMnNCUJwi9KHHqZBJ1VgCgYtFssSHU=;
        b=WWWzU/2WxHY3AQFPJ8mrOKepfMkL8sZ8CimvDLaEY7/OMnn9pR/3mq1LDwPUUVi5a9
         LAA0qoSz+KB71J0ibwdAQSbK1Qp0J7Kzd1FjEKKjjMqY3y/60lHpN6YjapCGs7UGytyX
         XhlRukWvoYXTok3Pp2sdts8bhJ3Uo9+8bM3cHucvLo9JCC6a+hiuidh9BfIKu+bNfG0G
         IrOndlwE/XzBC66QdZFbpeEwMwf/piG1M9A2aTLo10p1vb6xWr8x8Pgu+VP0vDW1woTf
         zaWnXNf+OpYaEnVCyXqg2z/Oh+IC5P6ze3sKgMYjLWWZb04uhYZHjdx5taxy50bVtDdQ
         hAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234512; x=1762839312;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDR4fNhLPPj2XAMnNCUJwi9KHHqZBJ1VgCgYtFssSHU=;
        b=mQMUbkJs3yhTJdIY/3HxLBjQrM5t+6qsVNkYQkj3al9YDC/30LS3YC3AXukLWw6Ud8
         vC/bwErz9omdYD0UEHfqVidiELTCIwbKWS8oq36ghnL+tGSz8JrbCf26+ijyLB+C0lI6
         vcA0CzBPheHNbJklTCLLuRsnrJTy2pg1V9iBtTajFc2Q1cxFaDTMSejkoRTGyyqTBkNx
         vO5r/yIVSr4S4Y5TQF3EmhMG92KLgKC5QGeoG1COlPk+xNb56ddlswTV9R6IDMTdMDxE
         XVDWjrJ7QNMCTmdIhqdG9PvElojfYp7HonjhWhhne9CsA3Aj/503yYMIK+0yJsU506N4
         RMUw==
X-Forwarded-Encrypted: i=1; AJvYcCUHs/SdnkwJLTf3SN5EPhBkUOzluFfWfv5z1i2t6b91Jc+GdyCO78CqINdieXfth39uum2ASkbbx7mjmBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cW41xszHrXpwnv5RDSO+aXVoFaTV2SGMN0TA+CH+R11UEnnS
	LbMEKYowgITCwes6G5eSzPu0Z7G1IsLfBwXqhBDV4z3cMFSkCyuiaC4FYk7uSGyuhUBmnmypTL8
	sbxCVdZh8UA==
X-Google-Smtp-Source: AGHT+IGLf9vSdc5vSnQtsdaRLp+zVtxiQDICiZ4ZMyUqQ2nwPvlMudYuJtaznKmLhSRYePQNVaVsbqBzGi8J
X-Received: from ywblk8.prod.google.com ([2002:a05:690c:5708:b0:786:98b0:a672])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6a05:b0:786:5be2:d47b
 with SMTP id 00721157ae682-7865be2d836mr93496367b3.1.1762234512317; Mon, 03
 Nov 2025 21:35:12 -0800 (PST)
Date: Mon,  3 Nov 2025 21:34:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104053449.1208800-1-irogers@google.com>
Subject: [PATCH v1 1/3] perf tool_pmu: Use old_count when computing count
 values for time events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When running in interval mode every third count of a time event isn't
showing properly:
```
$ perf stat -e duration_time -a -I 1000
     1.001082862      1,002,290,425      duration_time
     2.004264262      1,003,183,516      duration_time
     3.007381401      <not counted>      duration_time
     4.011160141      1,003,705,631      duration_time
     5.014515385      1,003,290,110      duration_time
     6.018539680      <not counted>      duration_time
     7.022065321      1,003,591,720      duration_time
```
The regression came in with a different fix, found through bisection,
commit 68cb1567439f ("perf tool_pmu: Fix aggregation on
duration_time"). The issue is caused by the enabled and running time
of the event matching the old_count's and creating a delta of 0, which
is indicative of an error.

Fixes: 68cb1567439f ("perf tool_pmu: Fix aggregation on duration_time")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c  | 16 +++++++++--
 tools/perf/util/tool_pmu.c | 59 +++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 886727ae8529..d89fa9468f89 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -282,17 +282,27 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
 	if (err && cpu_map_idx == 0 &&
 	    (evsel__tool_event(counter) == TOOL_PMU__EVENT_USER_TIME ||
 	     evsel__tool_event(counter) == TOOL_PMU__EVENT_SYSTEM_TIME)) {
-		u64 val, *start_time;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu_map_idx, thread);
+		struct perf_counts_values *old_count = NULL;
+		u64 val;
+
+		if (counter->prev_raw_counts)
+			old_count = perf_counts(counter->prev_raw_counts, cpu_map_idx, thread);
 
-		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
 		if (evsel__tool_event(counter) == TOOL_PMU__EVENT_USER_TIME)
 			val = ru_stats.ru_utime_usec_stat.mean;
 		else
 			val = ru_stats.ru_stime_usec_stat.mean;
-		count->ena = count->run = *start_time + val;
+
 		count->val = val;
+		if (old_count) {
+			count->run = old_count->run + 1;
+			count->ena = old_count->ena + 1;
+		} else {
+			count->run++;
+			count->ena++;
+		}
 		return 0;
 	}
 	return err;
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index f075098488ba..b895e88ff740 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -431,16 +431,39 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *resu
 	}
 }
 
+static void perf_counts__update(struct perf_counts_values *count,
+				const struct perf_counts_values *old_count,
+				bool raw, u64 val)
+{
+	/*
+	 * The values of enabled and running must make a ratio of 100%. The
+	 * exact values don't matter as long as they are non-zero to avoid
+	 * issues with evsel__count_has_error.
+	 */
+	if (old_count) {
+		count->val = raw ? val : old_count->val + val;
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+		count->lost = old_count->lost;
+	} else {
+		count->val = val;
+		count->run++;
+		count->ena++;
+		count->lost = 0;
+	}
+}
+
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 *start_time, cur_time, delta_start;
-	u64 val;
-	int fd, err = 0;
+	int err = 0;
 	struct perf_counts_values *count, *old_count = NULL;
 	bool adjust = false;
 	enum tool_pmu_event ev = evsel__tool_event(evsel);
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 
 	switch (ev) {
 	case TOOL_PMU__EVENT_HAS_PMEM:
@@ -451,26 +474,18 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_NUM_PACKAGES:
 	case TOOL_PMU__EVENT_SLOTS:
 	case TOOL_PMU__EVENT_SMT_ON:
-	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
-		if (evsel->prev_raw_counts)
-			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
-		val = 0;
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ: {
+		u64 val = 0;
+
 		if (cpu_map_idx == 0 && thread == 0) {
 			if (!tool_pmu__read_event(ev, evsel, &val)) {
 				count->lost++;
 				val = 0;
 			}
 		}
-		if (old_count) {
-			count->val = old_count->val + val;
-			count->run = old_count->run + 1;
-			count->ena = old_count->ena + 1;
-		} else {
-			count->val = val;
-			count->run++;
-			count->ena++;
-		}
+		perf_counts__update(count, old_count, /*raw=*/false, val);
 		return 0;
+	}
 	case TOOL_PMU__EVENT_DURATION_TIME:
 		/*
 		 * Pretend duration_time is only on the first CPU and thread, or
@@ -486,9 +501,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME: {
 		bool system = evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME;
+		int fd = FD(evsel, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
-		fd = FD(evsel, cpu_map_idx, thread);
 		lseek(fd, SEEK_SET, 0);
 		if (evsel->pid_stat) {
 			/* The event exists solely on 1 CPU. */
@@ -522,17 +537,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (adjust) {
 		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
 
-		delta_start *= 1000000000 / ticks_per_sec;
+		delta_start *= 1e9 / ticks_per_sec;
 	}
-	count->val    = delta_start;
-	count->lost   = 0;
-	/*
-	 * The values of enabled and running must make a ratio of 100%. The
-	 * exact values don't matter as long as they are non-zero to avoid
-	 * issues with evsel__count_has_error.
-	 */
-	count->ena++;
-	count->run++;
+	perf_counts__update(count, old_count, /*raw=*/true, delta_start);
 	return 0;
 }
 
-- 
2.51.2.1006.ga50a493c49-goog


