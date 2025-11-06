Return-Path: <linux-kernel+bounces-889502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68906C3DC8D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E54E801B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E85357A23;
	Thu,  6 Nov 2025 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofuV6ObB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09335771B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470953; cv=none; b=We8T76TLgyMM5YiWns+3xJO8uLhkw5GnHFPWZIrj7nY+J2WVtQ3kbb5zKaeQ2OIKMY+g5RRJ2R0TMnLf4fhAHT3WMCrKOXHECytVmxDIgWWR5qSKV3jW1mhjWWs8eOB8Og42vx8kZpyNU5YH44rsdj0ayDFJTbnJ0Sa9w5g52Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470953; c=relaxed/simple;
	bh=cRYjlGXMy8oFKWbC/hWw5ZYHF+VQE/hNjMg+FDceiog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GH0sdKhdEoloP28SL5krY3YOxuaNv5WixwdDUzNCAWGLwLSFuyeM+SVX7E+loXPql2hcRnLDOAn11ZSLy3coCrmW0rRhze4btT5+r4Sk7Ns9xSu2SlpnVmlt4owEDeiIkkl8MWjta/H/ODrvtoQluOmHWmBXTJM7h4+/Kj04NZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofuV6ObB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so2202335ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470950; x=1763075750; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeOSGX6zjeJxTypp9mNQ3u5K3XQByXMA15Am7ZgQNdA=;
        b=ofuV6ObBPPmqWezc9jqmUBwx/D1hdqxpfmswjvGciCrbSodtpoYGeeJA+ITiU3jg1e
         PLQkSysTDfY3Oz2Pzaubu/tTe4oYvlQZUr0UGc4qo9r+Ld+EgfdJpPNl8uS/bRH3B78S
         Cv6eS1KddLsO8ShVrNoj1CHNlLt5JDb9dDN2riH0zJOURKcSw8RSkq+YL+WZNY/3wz5A
         s9XU5qh5IeR+V9TRM7C5J46UxNalFwNkJBwVeG1i2/cLVXIHqr3i5nZEBj7iGOCbk5sh
         5elf69XW72c7JJLvgk7JvytzzbcNKLh0Tz362ok5chu1oivsKUglNQzNOt7JJtTBeTn+
         Ehow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470950; x=1763075750;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeOSGX6zjeJxTypp9mNQ3u5K3XQByXMA15Am7ZgQNdA=;
        b=MiL9+sCqTJrvkiCzpxvWSHE6GmpTWHfm2VKkN2N8PPOX63FkKRrFyindG0C1Qxsz8E
         obAOKBLdote2DXDh6RGBsHllkNgJSPC5dz1y8UkUQh064aMv3QKxiVQbkc/BVH3bKXks
         wN8qY2hN5tdJ0YR91wC1HwiF1t7f+xaV8qpkdKg8VKMiT6Fdc+wKcgK50pS4QTnLsimS
         s2PDsEtYCiG9syMWFUbC8rlrjdbnoLH50dKJhbcV63mpHifUnjQMc6q50ZLaAAsWjPlm
         Z1H1APcWwznHUyRI34oOyvjX5rFtHUK7/kkFCym4OUASQ59Ycr4JGbsDTjmFjNvAZyaq
         CR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqphzXtWj4zzJmiEmY2J8+5dty/GHQlCljKZoTOK5lW/pHTjIrw+oF06Q4Xolew8Hqw1c1OJMeSgv55Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VtrD/pjykoQ3MBUKf47WtKjAKzrgsQDCwLNQW1VJbY2uCSR7
	z8cueS69vJpuFxIYQkWkzeIFCSD0rW/xbJGVsbfxaxFzv0cNVnhcWIAQnbvdZOJMqiqNnjpiCmO
	mmXSjPEQBxA==
X-Google-Smtp-Source: AGHT+IF/UbMhF3+WWa6D4TdUv6rq/CTKUNnCLtxyY13BiT7s7oZAEYlLl9dPSiKMhw4tzrUECRFgGqM8F73X
X-Received: from dlbur20.prod.google.com ([2002:a05:7022:ea54:b0:119:49ca:6b97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e801:b0:295:3eb5:6de8
 with SMTP id d9443c01a7336-297c0386bffmr13308855ad.12.1762470950290; Thu, 06
 Nov 2025 15:15:50 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:56 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-7-irogers@google.com>
Subject: [PATCH v2 06/18] perf script: Change metric format to use json metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The metric format option isn't properly supported. This change
improves that by making the sample events update the counts of an
evsel, where the shadow metric code expects to read the values.  To
support printing metrics, metrics need to be found. This is done on
the first attempt to print a metric. Every metric is parsed and then
the evsels in the metric's evlist compared to those in perf script
using the perf_event_attr type and config. If the metric matches then
it is added for printing. As an event in the perf script's evlist may
have >1 metric id, or different leader for aggregation, the first
metric matched will be displayed in those cases.

An example use is:
```
$ perf record -a -e '{instructions,cpu-cycles}:S' -a -- sleep 1
$ perf script -F period,metric
...
     867817
         metric:    0.30  insn per cycle
     125394
         metric:    0.04  insn per cycle
     313516
         metric:    0.11  insn per cycle
         metric:    1.00  insn per cycle
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 239 ++++++++++++++++++++++++++++++++----
 1 file changed, 217 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8124fcb51da9..e24c3d9e01a8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -33,6 +33,7 @@
 #include "util/path.h"
 #include "util/event.h"
 #include "util/mem-info.h"
+#include "util/metricgroup.h"
 #include "ui/ui.h"
 #include "print_binary.h"
 #include "print_insn.h"
@@ -341,9 +342,6 @@ struct evsel_script {
        char *filename;
        FILE *fp;
        u64  samples;
-       /* For metric output */
-       u64  val;
-       int  gnum;
 };
 
 static inline struct evsel_script *evsel_script(struct evsel *evsel)
@@ -2132,13 +2130,161 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 	fputs("\tmetric: ", mctx->fp);
 }
 
-static void perf_sample__fprint_metric(struct perf_script *script,
-				       struct thread *thread,
+struct script_find_metrics_args {
+	struct evlist *evlist;
+	bool system_wide;
+};
+
+static struct evsel *map_metric_evsel_to_script_evsel(struct evlist *script_evlist,
+						      struct evsel *metric_evsel)
+{
+	struct evsel *script_evsel;
+
+	evlist__for_each_entry(script_evlist, script_evsel) {
+		/* Skip if perf_event_attr differ. */
+		if (metric_evsel->core.attr.type != script_evsel->core.attr.type)
+			continue;
+		if (metric_evsel->core.attr.config != script_evsel->core.attr.config)
+			continue;
+		/* Skip if the script event has a metric_id that doesn't match. */
+		if (script_evsel->metric_id &&
+		    strcmp(evsel__metric_id(metric_evsel), evsel__metric_id(script_evsel))) {
+			pr_debug("Skipping matching evsel due to differing metric ids '%s' vs '%s'\n",
+				 evsel__metric_id(metric_evsel), evsel__metric_id(script_evsel));
+			continue;
+		}
+		return script_evsel;
+	}
+	return NULL;
+}
+
+static int script_find_metrics(const struct pmu_metric *pm,
+			       const struct pmu_metrics_table *table __maybe_unused,
+			       void *data)
+{
+	struct script_find_metrics_args *args = data;
+	struct evlist *script_evlist = args->evlist;
+	struct evlist *metric_evlist = evlist__new();
+	struct evsel *metric_evsel;
+	int ret = metricgroup__parse_groups(metric_evlist,
+					/*pmu=*/"all",
+					pm->metric_name,
+					/*metric_no_group=*/false,
+					/*metric_no_merge=*/false,
+					/*metric_no_threshold=*/true,
+					/*user_requested_cpu_list=*/NULL,
+					args->system_wide,
+					/*hardware_aware_grouping=*/false);
+
+	if (ret) {
+		/* Metric parsing failed but continue the search. */
+		goto out;
+	}
+
+	/*
+	 * Check the script_evlist has an entry for each metric_evlist entry. If
+	 * the script evsel was already set up avoid changing data that may
+	 * break it.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct evsel *script_evsel =
+			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
+		struct evsel *new_metric_leader;
+
+		if (!script_evsel) {
+			pr_debug("Skipping metric '%s' as evsel '%s' / '%s' is missing\n",
+				pm->metric_name, evsel__name(metric_evsel),
+				evsel__metric_id(metric_evsel));
+			goto out;
+		}
+
+		if (script_evsel->metric_leader == NULL)
+			continue;
+
+		if (metric_evsel->metric_leader == metric_evsel) {
+			new_metric_leader = script_evsel;
+		} else {
+			new_metric_leader =
+				map_metric_evsel_to_script_evsel(script_evlist,
+								 metric_evsel->metric_leader);
+		}
+		/* Mismatching evsel leaders. */
+		if (script_evsel->metric_leader != new_metric_leader) {
+			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
+				pm->metric_name, evsel__metric_id(metric_evsel),
+				evsel__metric_id(script_evsel));
+			goto out;
+		}
+	}
+	/*
+	 * Metric events match those in the script evlist, copy metric evsel
+	 * data into the script evlist.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct evsel *script_evsel =
+			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
+		struct metric_event *metric_me = metricgroup__lookup(&metric_evlist->metric_events,
+								     metric_evsel,
+								     /*create=*/false);
+
+		if (script_evsel->metric_id == NULL) {
+			script_evsel->metric_id = metric_evsel->metric_id;
+			metric_evsel->metric_id = NULL;
+		}
+
+		if (script_evsel->metric_leader == NULL) {
+			if (metric_evsel->metric_leader == metric_evsel) {
+				script_evsel->metric_leader = script_evsel;
+			} else {
+				script_evsel->metric_leader =
+					map_metric_evsel_to_script_evsel(script_evlist,
+								       metric_evsel->metric_leader);
+			}
+		}
+
+		if (metric_me) {
+			struct metric_expr *expr;
+			struct metric_event *script_me =
+				metricgroup__lookup(&script_evlist->metric_events,
+						    script_evsel,
+						    /*create=*/true);
+
+			if (!script_me) {
+				/*
+				 * As the metric_expr is created, the only
+				 * failure is a lack of memory.
+				 */
+				goto out;
+			}
+			list_splice_init(&metric_me->head, &script_me->head);
+			list_for_each_entry(expr, &script_me->head, nd) {
+				for (int i = 0; expr->metric_events[i]; i++) {
+					expr->metric_events[i] =
+						map_metric_evsel_to_script_evsel(script_evlist,
+									expr->metric_events[i]);
+				}
+			}
+		}
+	}
+	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
+		 pm->metric_name);
+	evlist__delete(metric_evlist);
+out:
+	return 0;
+}
+
+static struct aggr_cpu_id script_aggr_cpu_id_get(struct perf_stat_config *config __maybe_unused,
+						    struct perf_cpu cpu)
+{
+	return aggr_cpu_id__global(cpu, /*data=*/NULL);
+}
+
+static void perf_sample__fprint_metric(struct thread *thread,
 				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       FILE *fp)
 {
-	struct evsel *leader = evsel__leader(evsel);
+	static bool init_metrics;
 	struct perf_stat_output_ctx ctx = {
 		.print_metric = script_print_metric,
 		.new_line = script_new_line,
@@ -2150,23 +2296,72 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 			 },
 		.force_header = false,
 	};
-	struct evsel *ev2;
-	u64 val;
+	struct perf_counts_values *count, *old_count;
+	int cpu_map_idx, thread_map_idx, aggr_idx;
+	struct evsel *pos;
+
+	if (!init_metrics) {
+		/* One time initialization of stat_config and metric data. */
+		struct script_find_metrics_args args = {
+			.evlist = evsel->evlist,
+			/* TODO: Determine system-wide based on evlist.. */
+			.system_wide = true,
+		};
+		if (!stat_config.output)
+			stat_config.output = stdout;
+
+		if (!stat_config.aggr_map) {
+			/* TODO: currently only global aggregation is supported. */
+			assert(stat_config.aggr_mode == AGGR_GLOBAL);
+			stat_config.aggr_get_id = script_aggr_cpu_id_get;
+			stat_config.aggr_map =
+				cpu_aggr_map__new(evsel->evlist->core.user_requested_cpus,
+						  aggr_cpu_id__global, /*data=*/NULL,
+						  /*needs_sort=*/false);
+		}
 
-	if (!evsel->stats)
-		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
-	if (evsel_script(leader)->gnum++ == 0)
-		perf_stat__reset_shadow_stats();
-	val = sample->period * evsel->scale;
-	evsel_script(evsel)->val = val;
-	if (evsel_script(leader)->gnum == leader->core.nr_members) {
-		for_each_group_member (ev2, leader) {
-			perf_stat__print_shadow_stats(&stat_config, ev2,
-						      evsel_script(ev2)->val,
-						      sample->cpu,
-						      &ctx);
+		metricgroup__for_each_metric(pmu_metrics_table__find(), script_find_metrics, &args);
+		init_metrics = true;
+	}
+
+	if (!evsel->stats) {
+		if (evlist__alloc_stats(&stat_config, evsel->evlist, /*alloc_raw=*/true) < 0)
+			return;
+	}
+	if (!evsel->stats->aggr) {
+		if (evlist__alloc_aggr_stats(evsel->evlist, stat_config.aggr_map->nr) < 0)
+			return;
+	}
+
+	/* Update the evsel's count using the sample's data. */
+	cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){sample->cpu});
+	thread_map_idx = perf_thread_map__idx(evsel->core.threads, sample->tid);
+	if (thread_map_idx < 0) {
+		/* Missing thread, check for any thread. */
+		if (perf_thread_map__pid(evsel->core.threads, /*idx=*/0) == -1) {
+			thread_map_idx = 0;
+		} else {
+			pr_info("Missing thread map entry for thread %d\n", sample->tid);
+			return;
+		}
+	}
+	count = perf_counts(evsel->counts, cpu_map_idx, thread_map_idx);
+	old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread_map_idx);
+	count->val = old_count->val + sample->period;
+	count->run = old_count->run + 1;
+	count->ena = old_count->ena + 1;
+
+	/* Update the aggregated stats. */
+	perf_stat_process_counter(&stat_config, evsel);
+
+	/* Display all metrics. */
+	evlist__for_each_entry(evsel->evlist, pos) {
+		cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
+			perf_stat__print_shadow_stats(&stat_config, pos,
+						count->val,
+						aggr_idx,
+						&ctx);
 		}
-		evsel_script(leader)->gnum = 0;
 	}
 }
 
@@ -2348,7 +2543,7 @@ static void process_event(struct perf_script *script,
 	}
 
 	if (PRINT_FIELD(METRIC))
-		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
+		perf_sample__fprint_metric(thread, evsel, sample, fp);
 
 	if (verbose > 0)
 		fflush(fp);
-- 
2.51.2.1041.gc1ab5b90ca-goog


