Return-Path: <linux-kernel+bounces-885591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CDC33696
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B31042805D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA634A3C3;
	Tue,  4 Nov 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE/NIFwn"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAE3491ED
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299724; cv=none; b=JH+z5kG4s5QmkbISxIyKGPcdbZebzA/QWLclp+6LqtCKJDwI9Jy310t4urgeCxihh8iWNDTneCBactHheXMnKvwgGZ/Gi1AjWeQ/tBRIyTTNYfqdA4d4dJiO2Xs0wLnJHkcTIx6BkhF1s7dABlf4UnRKQTnyC4zpxLhMRklofB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299724; c=relaxed/simple;
	bh=kIIlJo2ViHHyHZmJdA2SFQzK5GLkEyElPC+hRtMHrCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SGCYEwG90NlTVzD9MzCim4h7PO5x1+CGtxEsG6LNXuXqcxj07o+kp/Fz0W4qMveFLR9lpY8pDhO7eb1YJE2lh6tEp+Q50iUU15o4RepPrh0oVtyAd0QVAN7Ip+S+ThqfMYu2SOfnY5WSjYylSmPjjoiKVx2kDd1bQX3XgetkauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE/NIFwn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso12985499a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762299722; x=1762904522; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLYd049AVbJIjRBiRUyfzy9PfU46/O34zx5goHeWds4=;
        b=qE/NIFwnTwGDaM5sTklJ+8LGCKVJR6bB8ZakhP4nV6q3A6hjarGKB5yiTgqc55c+tP
         RyrF9b+Zlgn2JIcxEZldQ5O/wRbAsvoV+T4vzmcqvW1WyoCvxRWOzZ8uhZsQ/xCB9/fq
         P9HLxmGajcD5+WkkMJnNvM0+0SFPPzEnrE9Yqwfj7mxuMPjHCQVd7JN8DtKEjndeQRce
         tTNjPpVSuf+iAMZcV4lPKf4ZuZ4hUaFePWpuglG9U4huiYFWDzqn7B0S1s9FMLgLwa2U
         5nkAka5w/TRteOftPb/lnGOovtaQ1UbAEY2en8QBPg5KhR6Hb9Arjqkw+CIsYKgc5Sq9
         Uqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299722; x=1762904522;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLYd049AVbJIjRBiRUyfzy9PfU46/O34zx5goHeWds4=;
        b=sCju0UQUAGlFSSlvw+XVRvqtQ4ah7vZEklRcLq/uY3iW+Ox9JBydgQKeOtSsj2NjfG
         Wl79cCBFUijtidF90OI6OwozMCG8M+sqfMnL3lQkaxi+zHdcyjlLQnrUvp+p0n9FGcpu
         xDCQELN7LA+QkbmJnbgYRp/5AGbT+CnPIKf/fiey6qfbNnbvAS1Zj1wmXUA9MenjxSoJ
         y1kXrcQKoJw1QENAQFs7p3fXHccCNnF4TMPpCBtDY/mVFjHSlbg3F7ghGXZqpK01/6MY
         ArF6PR9tYzOlIM7Gzs5u2y8vTSpmBcwHfVfvGJGiaiLuV2xU794LwFOJEq2X2LBkYTIp
         PdWg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRYn7Lix8DdQRdbYfWQ5u1EJQopvvNoJeSujRUuxm5ZtI77lSqc4Qi0ERFECa9ztGCAIcZ0dkhkk1xyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU58ASt+W6NAgYpnmU/WqWdneIecftASDRhTdNQYZ3AYnIxp2h
	cdGclu0J8wyBqQJlmfdKNUindQQ5RtJvqAYt9ZuQoprDyOHUqR9lKkDW9b/7a2JI1CYpOGtlvq0
	Qrxp5MTpzvA==
X-Google-Smtp-Source: AGHT+IEc9Jy8u31KY584hmhvAtiAz+iS9YsjA7Gk8+92qoDo2rKxi5QR3V/4N9BahDIQYcoSqiTgT8z97RL7
X-Received: from dlbvg27.prod.google.com ([2002:a05:7022:7f1b:b0:119:49ca:6b96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939e:b0:341:ea4:b999
 with SMTP id adf61e73a8af0-34f867f410fmr1274807637.60.1762299722479; Tue, 04
 Nov 2025 15:42:02 -0800 (PST)
Date: Tue,  4 Nov 2025 15:41:48 -0800
In-Reply-To: <20251104234148.3103176-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104234148.3103176-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104234148.3103176-3-irogers@google.com>
Subject: [PATCH v2 3/3] perf stat: Reduce scope of ru_stats
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
2.51.2.1006.ga50a493c49-goog


