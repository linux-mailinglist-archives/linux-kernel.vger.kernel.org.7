Return-Path: <linux-kernel+bounces-887917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD1C395AC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD105350467
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031B2E6CC3;
	Thu,  6 Nov 2025 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0R/icLo"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A352DE1E2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413177; cv=none; b=MO9bkn6p80qC6zDa81Jfm0FjW9MauxlhTCyD3A/tzcopLXhKF65HpfqeavpAlt+6PvhciXkNztz0/33VnWDV8VVCQsvPkU05ms8CinVOjkuCMGoqGiSHpN+DiYHPedwVLWINYmT6RTC9O1wZSPljHsJW5XLIIoqJHpEQquGZORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413177; c=relaxed/simple;
	bh=PsrLYZ63S4/Yl5gUDazBRZIT23aCtdqQCezqcEzmpgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tQOXJ+ruXleVBXRSAYDx43zo3mb4+AWOczH5ZUiDkIZklV2BzPQowa3lx1rR2OCKicyGmMBninbsFClcdR7Iu3b4OdHmIjWlRYdOctBOESBMt/iswUgBBuDIyoy8FanbjdRzRZDCZkFhnNGK7QLuXor4o9NObbLVc+cOE8cDO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0R/icLo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-792722e4ebeso872909b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413175; x=1763017975; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xO1dG1dA38tu5LHgCObN6Aj03K5VCieIjvEPjfcsmMk=;
        b=E0R/icLo3lPx8rGqKs9fHIP0uUTIBJ7PZ4x/5/gQn/gaEhs13+49OAmO1Dl/O3fJOe
         QcJqR9SYepqR9DngbK4BgpSEVyLt4rfLlWyPkvUSfzuS+2WlKA1KpDLN9JWofMZjvdVu
         Adl5mEjx7M4qRHWkY6BAmLcy8wZw9Lo8Ak/I6VwmkgMB0GnsNMovU46nyHC0xPcdVdIL
         M9rf5dgEP31KJ+xZOgJfqWg0IVUg/iLtY4rGKMeFuesDuOIrXtRuQ0IQhLjc9L+uGDCL
         J0R+SjJlk46c6Yvmo8CYMaLMr/H1EoexOeTHhZhM4Ys7OfYl13zrnajNsAX6YmbhAe6M
         ZrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413175; x=1763017975;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xO1dG1dA38tu5LHgCObN6Aj03K5VCieIjvEPjfcsmMk=;
        b=nP932iK+NLkBilRQuQ7q/WcI2ee3D/xxZ46Qd29DfdEdNk5RQaTQ3KjvGAqLGPxds/
         O9345WybXQFVK3u0GD6kRA+iKqJzUhhQ9VH1UFgoXbp5rb/ti5zpeb4QmyQxiGTp+Jqc
         /yIyXn2HixxXWDqObB7PxOsZ9FmJSYnvwPG95wjNmxPcQ47ZXIBXWsLsFueVYtAgi03S
         E9DAszWt8iO7veU6hIrZ1P7RueDywdW9TFyP8rMgrXkfKJ3F4pYChNfHi1BzUd2FLxy/
         ctp2dEUOaXt+g4gsRi88oL++N5lsu3Wn1u1n8T4et7F+GIsLAxaoYtjzz4z4yhf9npfA
         aLqA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKtuwRpC4hHE37b/7dHKX3gibctBNMUOX4ebWn0IgA6X6JU7F39dvs0iC6fwajLhCPbpX08smdY7ZnBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoC7eMwfqr+JN5Qjftvz4ikyK3DIjTnfnx5+NUnr9RGzS21PF
	gNhJaeoOuvTmoby2z2NUOah7xTbQjN5n1eQNcu2nlZwUu2xUMgv+VvLFJXzCtSKSbZ7V1oMc40c
	qOOBVa+UADQ==
X-Google-Smtp-Source: AGHT+IHfNtEmB2vzB5Qgk4FgJ6by0dipPevRra6zzBmqo37BLyLVuIe07shcJ43P7IrSPny8s42SfF6V60Pa
X-Received: from dlad18.prod.google.com ([2002:a05:701b:2212:b0:119:9f33:34af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9989:b0:251:43f5:cad4
 with SMTP id adf61e73a8af0-34f84008799mr8440665637.10.1762413174906; Wed, 05
 Nov 2025 23:12:54 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:36 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-6-irogers@google.com>
Subject: [PATCH v3 5/9] perf stat: Reduce scope of ru_stats
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

The ru_stats are used to capture user and system time stats when a
process exits. These are then applied to user and system time tool
events if their reads fail due to the process terminating. Reduce the
scope now the metric code no longer reads these values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 14 +++++++++++++-
 tools/perf/util/config.c      |  1 -
 tools/perf/util/stat-shadow.c |  2 --
 tools/perf/util/stat.h        | 16 ----------------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d89fa9468f89..3cd663b3b357 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -132,6 +132,7 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static char			*metrics;
+static struct rusage_stats	ru_stats;
 
 struct perf_stat {
 	bool			 record;
@@ -729,6 +730,17 @@ static int create_perf_stat_counter(struct evsel *evsel,
 					      evsel->core.threads);
 }
 
+static void update_rusage_stats(const struct rusage *rusage)
+{
+	const u64 us_to_ns = 1000;
+	const u64 s_to_ns = 1000000000;
+
+	update_stats(&ru_stats.ru_utime_usec_stat,
+		(rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
+	update_stats(&ru_stats.ru_stime_usec_stat,
+		(rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -978,7 +990,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__reset_aggr_stats(evsel_list);
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
-		update_rusage_stats(&ru_stats, &stat_config.ru_data);
+		update_rusage_stats(&stat_config.ru_data);
 	}
 
 	/*
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6f914620c6ff..cc0746f494f4 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -45,7 +45,6 @@ struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
-	.ru_stats		= &ru_stats,
 	.big_num		= true,
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 939ac3269a44..c59578886b4f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -18,7 +18,6 @@
 #include "tool_pmu.h"
 
 struct stats walltime_nsecs_stats;
-struct rusage_stats ru_stats;
 
 enum {
 	CTX_BIT_USER	= 1 << 0,
@@ -74,7 +73,6 @@ static int evsel_context(const struct evsel *evsel)
 void perf_stat__reset_shadow_stats(void)
 {
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
-	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
 static enum stat_type evsel__stat_type(struct evsel *evsel)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 34f30a295f89..5b8b4675883c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -102,7 +102,6 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-	struct rusage_stats		 *ru_stats;
 	struct cpu_aggr_map	*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_aggr_map	*cpus_aggr_map;
@@ -132,25 +131,10 @@ static inline void init_stats(struct stats *stats)
 	stats->max  = 0;
 }
 
-static inline void init_rusage_stats(struct rusage_stats *ru_stats) {
-	init_stats(&ru_stats->ru_utime_usec_stat);
-	init_stats(&ru_stats->ru_stime_usec_stat);
-}
-
-static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rusage* rusage) {
-	const u64 us_to_ns = 1000;
-	const u64 s_to_ns = 1000000000;
-	update_stats(&ru_stats->ru_utime_usec_stat,
-	             (rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
-	update_stats(&ru_stats->ru_stime_usec_stat,
-	             (rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
-}
-
 struct evsel;
 struct evlist;
 
 extern struct stats walltime_nsecs_stats;
-extern struct rusage_stats ru_stats;
 
 enum metric_threshold_classify {
 	METRIC_THRESHOLD_UNKNOWN,
-- 
2.51.2.1041.gc1ab5b90ca-goog


