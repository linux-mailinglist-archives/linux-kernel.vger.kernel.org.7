Return-Path: <linux-kernel+bounces-900022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCEC59647
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1CE3AE106
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60B35A12D;
	Thu, 13 Nov 2025 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mri/KYzG"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5D35970C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057151; cv=none; b=otLFuATu70kGtGu07nDHvUvl+s5YMSJgIzL0EoajXYI27Zq7LKikVsQXa49ZguqE7vmlkVFQj+Rv8hLBtzM+c7A/GzBHL2I6k8odVcftYVoqdejIcKtkxMOxp8hh1f8vxBMGAzybcfkp2NKIw91nR6Ts9NWP5LGYW11vbtMdNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057151; c=relaxed/simple;
	bh=74ic2NR19Qj1jkhqoFr5/GAzNGfc9K6j6Uwf4Hjc/ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KYLQJincppqa5OLzqY1o93rAUggqNx+fjWVPfZTps+GwJ8evpA/b2yaInnfUYgXUIL6p6sdkN+V1rhAHD+SPW8gxDQop6h24L9NXmRSkSceTooFVrUuQ1OiuLhiwT369AT7rieysgknoABFDkt/XTCKrKjkadVvoaBVCDljgNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mri/KYzG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99763210e5so1078997a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057149; x=1763661949; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvaqfEqqQj/hZXmBgRInugRb7NiwpIIhCyLsGdqnH4o=;
        b=mri/KYzGgwNibHkgXkR6nA8YW7d7+yF4GCCymoKxubSUAMemno6qhBFsk+x6Ng8MC3
         bo2W5Har5/+mQrt0JDaTCT12rV1YUFBsWYdIjOUcZWi9Vr8NqNt1jtIAdsT8VbTbVaKI
         wacYDUBBMHc4uUPMrwT6nbe3oMhW1J58g8FcHCkYNW4XSsrq6CPQlUzkw6IS3K9Gz6Ol
         LusZ43K+033Pm3IEKJcZQj7FKCCDrEy6p8DU7cS67OECI6hg5VgmZhQl+8yHIanof7Og
         zSbHeeItWQhY4XNFAXabmDIlUSAQBB6yaC85ZRIexyofaEWG2Jb54tWA5F73ztpXbBaF
         dzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057149; x=1763661949;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvaqfEqqQj/hZXmBgRInugRb7NiwpIIhCyLsGdqnH4o=;
        b=goYvWjuP0dw6C5sgn5FPcGCvoy90ZiNwMC9C/tdYmXvu91zIdioJBcyibUf5UQ+Ibk
         CDDcw/y5CbS5Q6j6YxcC3ZfLHdgi6GjgQdmV93tAxJu8hAMEwi+DtJpphawF7At3aF5V
         v7eN1JZnhslrA43Md0CsS2z3Gauxjt67dOEOWcsQzyuQU3BZ0+2Pzss7PgwjXA4Geaoo
         HnFRLdqgFITCzsRb5xlQHWSyZf7M6VMlEJlcTqBXe/qSRz4q+a0Veo5Vp/7DdZEdqWU1
         vH2Fn4g0qVwq64Iq4aGZE2qLr/IS7dzbL909iwwoalUBo4QL/3gNIe4JIu1amXyg5Rr5
         FTcw==
X-Forwarded-Encrypted: i=1; AJvYcCXSV3o6VVMWWuDKhHQRKOGFB+LwX62xlPS4ak99IBJPqNUS/NSZt8x0rTA+TYERIsk7Zdi3Lm0DoN/KdVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCR/EkY2TAZ6HFI0wcpV1zpcelT8X5QR6Au25FakfhCcgijT+9
	GzVK6OTAYjQlTqQf2QcA9KejSb+Zhkfiunu4A0uMvZYs19jsB9PzfqZTqNkP57jXv9hq9rARCBf
	jUTtVeWZ9hw==
X-Google-Smtp-Source: AGHT+IF0NwPOIq3TmGs4pfWbaVyz7eK77f2zPBftHfCowiKCgIk6oaj+NWaIDUfX61uCgGqUhOiGvhsMQt2A
X-Received: from dycne3.prod.google.com ([2002:a05:7301:c83:b0:2a4:51e8:c5c8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bc1a:b0:2a4:3593:6466
 with SMTP id 5a478bee46e88-2a4abb1cf05mr160511eec.22.1763057148729; Thu, 13
 Nov 2025 10:05:48 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:09 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-4-irogers@google.com>
Subject: [PATCH v4 03/10] perf tool_pmu: Use old_count when computing count
 values for time events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
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
index 095016b2209e..654f840f7a2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -283,17 +283,27 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
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
index a72c665ee644..6a9df3dc0e07 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -446,16 +446,39 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
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
@@ -466,12 +489,11 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_NUM_PACKAGES:
 	case TOOL_PMU__EVENT_SLOTS:
 	case TOOL_PMU__EVENT_SMT_ON:
-	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
 	case TOOL_PMU__EVENT_CORE_WIDE:
 	case TOOL_PMU__EVENT_TARGET_CPU:
-		if (evsel->prev_raw_counts)
-			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
-		val = 0;
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ: {
+		u64 val = 0;
+
 		if (cpu_map_idx == 0 && thread == 0) {
 			if (!tool_pmu__read_event(ev, evsel,
 						  stat_config.system_wide,
@@ -481,16 +503,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -506,9 +521,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME: {
 		bool system = evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME;
+		int fd = FD(evsel, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
-		fd = FD(evsel, cpu_map_idx, thread);
 		lseek(fd, SEEK_SET, 0);
 		if (evsel->pid_stat) {
 			/* The event exists solely on 1 CPU. */
@@ -542,17 +557,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
2.51.2.1041.gc1ab5b90ca-goog


