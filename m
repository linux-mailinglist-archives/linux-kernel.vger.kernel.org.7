Return-Path: <linux-kernel+bounces-724534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854ACAFF408
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22B75A3B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FB25A320;
	Wed,  9 Jul 2025 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/cMxvvz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB523F40A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097249; cv=none; b=Pb7C9tn3WcDz/KTbDsZwhvmuqcH4OGFxALknpw7mWx8PVPcaHaSFHXr4W5L29ub66+HKMhtz2Q2MiANQ0qy7/NuM6SKgxGvaSzP6frczIQD/SMtH2at0qZHGTZtD0n7cLlG5H3eQ1bM/R+D3Ofsacuae+f4Rc5zt4zZUNvlFvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097249; c=relaxed/simple;
	bh=GzuZ8LUXET7BGYQ2eRqRzJYQa6EtqNPAew8uEpnPOvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PSIrLemF86vt2U3eFubgZP7BdBt62XI2CiV4Vrvi8bSCEaZNQASACrx5RRhqa6Eo0bxkmBNV+ml1tvVpYPHAU3sRz5iWnxj2/xWpn/aNJCz/alNWw3iQ2B+m57C2jS0rtmdTQ9dpODo4/HfM5rEO/khXMA7wtSsS4kkyWCQRm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/cMxvvz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e671316so288439a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097246; x=1752702046; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2539RPpMNpcfZ5HJ4hJiH976Tmx+CPKS+Y0VYmUbAY=;
        b=F/cMxvvz692befqQ+BGveSMmUHc5+cOIDM1cDAC24lZEFX/G924IQA3JVtjfCHTtvD
         PdcRIo3nuejeHNgHY2xjQPYSDRukVApWX1jWAwiW/t1HkH1fsToqS4s3nUb3iCyX0n1C
         OdHS0FHmp4eNJmy3DnmI/tggbn1XuhmFB9aRpmmI5ZpCCirr2rdBXYx5Q/GmBPSrFdIa
         LqxGyAbG7rVmN/YrQgjRsR3T+nJFM6kPh3oB/ChoX/9fuGxTs7W1SW7A2hF+qv82vtoc
         MZWLl4ALViuj4wF3l7Jbtlrrv8/PagJ0d16XwV25cORwyGL0pU24bh5W9CqgBv1Wq+96
         EJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097246; x=1752702046;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2539RPpMNpcfZ5HJ4hJiH976Tmx+CPKS+Y0VYmUbAY=;
        b=UmSAPiPd2e3KGc7ajyhZlHcpN1LGFA7EmoSaPn/mWhBnG0cZTyzxydamP503ZqWJpn
         BNYVJNlBePbAc5lWNvBZNKH2i9Grxi+qibvqNj1iETrL0AAgz2kdsXmbiGDeuuxNyWcR
         vsc2qX8O76kR7pQxkJeU1HkgqsyfUlHnAMzl8IT3et2OlxrFrMYx5NGmK42GAEqxFSUY
         /W6hkuu/FOBHf93HfEOH0vzJF4yNhDmHyAXJi8TtXxgipcl1JPzZVJx4FF1XP1djB4oK
         3UvCtmw84EA5XCw/G6ZCU3tLaxjjH6ZjEmszeziIkzIicxo7b3dO0mvmp+66VpXq4+LR
         V8pA==
X-Forwarded-Encrypted: i=1; AJvYcCXz75moCgKM/OVeJJyPvgoaZNGrnFImD/c0gbO17LrDMeavROj8uxSfRcCt389NdcRGsPvs9lBBYb5fcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KQWAtoeZt4zUwTMbfb83GAT7l0NKQzUrdBc9yW2DfWxqDyPZ
	lD0L0BXZza6HBhRyeLiEVLUP9g6umHavYZwULLl4NdPzIRYHV9EWBmT027DfB1/n/9hfi70z/z+
	lZAGJiVKoRQ==
X-Google-Smtp-Source: AGHT+IFQfemZ2ppOa9hMxLSulWEGp1wnzmPO2ByLfr+dgrEONL6khFd2h8EArFH493ZkLKiWN9jYq9zwASUq
X-Received: from pjcc3.prod.google.com ([2002:a17:90b:5743:b0:31c:160d:e3be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f43:b0:311:a5ab:3d47
 with SMTP id 98e67ed59e1d1-31c3cf3a81dmr1612801a91.1.1752097246030; Wed, 09
 Jul 2025 14:40:46 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:23 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-7-irogers@google.com>
Subject: [PATCH v1 06/12] perf stat: Move metric list from config to evlist
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rblist of metric_event that then have a list of associated
metric_expr is moved out of the stat_config and into the evlist. This
is done as part of refactoring things for python, having the state
split in two places complicates that implementation. The evlist is
doing the harder work of enabling and disabling events, the metrics
are needed to compute a value and it doesn't seem unreasonable to hang
them from the evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c      |  3 +--
 tools/perf/builtin-stat.c        | 25 ++++++++++++-------------
 tools/perf/tests/expand-cgroup.c | 24 +++++++-----------------
 tools/perf/tests/parse-metric.c  | 16 +++++-----------
 tools/perf/tests/pmu-events.c    |  8 ++------
 tools/perf/util/cgroup.c         | 23 ++++++++---------------
 tools/perf/util/cgroup.h         |  3 +--
 tools/perf/util/evlist.c         |  3 +++
 tools/perf/util/evlist.h         |  6 ++++++
 tools/perf/util/metricgroup.c    | 20 ++++++++------------
 tools/perf/util/metricgroup.h    |  7 +++----
 tools/perf/util/python.c         |  4 ++++
 tools/perf/util/stat-display.c   | 16 ++++++----------
 tools/perf/util/stat-shadow.c    | 13 ++++++-------
 tools/perf/util/stat.h           | 12 +++---------
 15 files changed, 75 insertions(+), 108 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4001e621b6cb..271f22962e32 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2136,8 +2136,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 			perf_stat__print_shadow_stats(&stat_config, ev2,
 						      evsel_script(ev2)->val,
 						      sample->cpu,
-						      &ctx,
-						      NULL);
+						      &ctx);
 		}
 		evsel_script(leader)->gnum = 0;
 	}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 50fc53adb7e4..77e2248fa7fc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1863,8 +1863,7 @@ static int add_default_events(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						stat_config.hardware_aware_grouping,
-						&stat_config.metric_events);
+						stat_config.hardware_aware_grouping);
 		goto out;
 	}
 
@@ -1901,8 +1900,7 @@ static int add_default_events(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						stat_config.hardware_aware_grouping,
-						&stat_config.metric_events);
+						stat_config.hardware_aware_grouping);
 		goto out;
 	}
 
@@ -1939,8 +1937,7 @@ static int add_default_events(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						stat_config.hardware_aware_grouping,
-						&stat_config.metric_events) < 0) {
+						stat_config.hardware_aware_grouping) < 0) {
 			ret = -1;
 			goto out;
 		}
@@ -1989,8 +1986,7 @@ static int add_default_events(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
-							stat_config.hardware_aware_grouping,
-							&stat_config.metric_events) < 0) {
+							stat_config.hardware_aware_grouping) < 0) {
 				ret = -1;
 				goto out;
 			}
@@ -1999,6 +1995,9 @@ static int add_default_events(void)
 				evsel->default_metricgroup = true;
 
 			evlist__splice_list_tail(evlist, &metric_evlist->core.entries);
+			metricgroup__copy_metric_events(evlist, /*cgrp=*/NULL,
+							&evlist->metric_events,
+							&metric_evlist->metric_events);
 			evlist__delete(metric_evlist);
 		}
 	}
@@ -2053,6 +2052,9 @@ static int add_default_events(void)
 	}
 	parse_events_error__exit(&err);
 	evlist__splice_list_tail(evsel_list, &evlist->core.entries);
+	metricgroup__copy_metric_events(evsel_list, /*cgrp=*/NULL,
+					&evsel_list->metric_events,
+					&evlist->metric_events);
 	evlist__delete(evlist);
 	return ret;
 }
@@ -2739,8 +2741,7 @@ int cmd_stat(int argc, const char **argv)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						stat_config.hardware_aware_grouping,
-						&stat_config.metric_events);
+						stat_config.hardware_aware_grouping);
 
 		zfree(&metrics);
 		if (ret) {
@@ -2760,8 +2761,7 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 
-		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
-					  &stat_config.metric_events, true) < 0) {
+		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list, true) < 0) {
 			parse_options_usage(stat_usage, stat_options,
 					    "for-each-cgroup", 0);
 			goto out;
@@ -2936,7 +2936,6 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__delete(evsel_list);
 
-	metricgroup__rblist_exit(&stat_config.metric_events);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
 	return status;
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 31966ff856f8..c7b32a220ca1 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -13,8 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-static int test_expand_events(struct evlist *evlist,
-			      struct rblist *metric_events)
+static int test_expand_events(struct evlist *evlist)
 {
 	int i, ret = TEST_FAIL;
 	int nr_events;
@@ -47,7 +46,7 @@ static int test_expand_events(struct evlist *evlist,
 	was_group_event = evsel__is_group_event(evlist__first(evlist));
 	nr_members = evlist__first(evlist)->core.nr_members;
 
-	ret = evlist__expand_cgroup(evlist, cgrp_str, metric_events, false);
+	ret = evlist__expand_cgroup(evlist, cgrp_str, false);
 	if (ret < 0) {
 		pr_debug("failed to expand events for cgroups\n");
 		goto out;
@@ -100,13 +99,11 @@ out:	for (i = 0; i < nr_events; i++)
 static int expand_default_events(void)
 {
 	int ret;
-	struct rblist metric_events;
 	struct evlist *evlist = evlist__new_default();
 
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
-	rblist__init(&metric_events);
-	ret = test_expand_events(evlist, &metric_events);
+	ret = test_expand_events(evlist);
 	evlist__delete(evlist);
 	return ret;
 }
@@ -115,7 +112,6 @@ static int expand_group_events(void)
 {
 	int ret;
 	struct evlist *evlist;
-	struct rblist metric_events;
 	struct parse_events_error err;
 	const char event_str[] = "{cycles,instructions}";
 
@@ -132,8 +128,7 @@ static int expand_group_events(void)
 		goto out;
 	}
 
-	rblist__init(&metric_events);
-	ret = test_expand_events(evlist, &metric_events);
+	ret = test_expand_events(evlist);
 out:
 	parse_events_error__exit(&err);
 	evlist__delete(evlist);
@@ -144,7 +139,6 @@ static int expand_libpfm_events(void)
 {
 	int ret;
 	struct evlist *evlist;
-	struct rblist metric_events;
 	const char event_str[] = "CYCLES";
 	struct option opt = {
 		.value = &evlist,
@@ -166,8 +160,7 @@ static int expand_libpfm_events(void)
 		goto out;
 	}
 
-	rblist__init(&metric_events);
-	ret = test_expand_events(evlist, &metric_events);
+	ret = test_expand_events(evlist);
 out:
 	evlist__delete(evlist);
 	return ret;
@@ -177,25 +170,22 @@ static int expand_metric_events(void)
 {
 	int ret;
 	struct evlist *evlist;
-	struct rblist metric_events;
 	const char metric_str[] = "CPI";
 	const struct pmu_metrics_table *pme_test;
 
 	evlist = evlist__new();
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
-	rblist__init(&metric_events);
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str, &metric_events);
+	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str);
 	if (ret < 0) {
 		pr_debug("failed to parse '%s' metric\n", metric_str);
 		goto out;
 	}
 
-	ret = test_expand_events(evlist, &metric_events);
+	ret = test_expand_events(evlist);
 
 out:
-	metricgroup__rblist_exit(&metric_events);
 	evlist__delete(evlist);
 	return ret;
 }
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 2c28fb50dc24..66a5275917e2 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -45,15 +45,14 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 	}
 }
 
-static double compute_single(struct rblist *metric_events, struct evlist *evlist,
-			     const char *name)
+static double compute_single(struct evlist *evlist, const char *name)
 {
 	struct metric_expr *mexp;
 	struct metric_event *me;
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		me = metricgroup__lookup(metric_events, evsel, false);
+		me = metricgroup__lookup(&evlist->metric_events, evsel, false);
 		if (me != NULL) {
 			list_for_each_entry (mexp, &me->head, nd) {
 				if (strcmp(mexp->metric_name, name))
@@ -69,9 +68,6 @@ static int __compute_metric(const char *name, struct value *vals,
 			    const char *name1, double *ratio1,
 			    const char *name2, double *ratio2)
 {
-	struct rblist metric_events = {
-		.nr_entries = 0,
-	};
 	const struct pmu_metrics_table *pme_test;
 	struct perf_cpu_map *cpus;
 	struct evlist *evlist;
@@ -95,8 +91,7 @@ static int __compute_metric(const char *name, struct value *vals,
 
 	/* Parse the metric into metric_events list. */
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	err = metricgroup__parse_groups_test(evlist, pme_test, name,
-					     &metric_events);
+	err = metricgroup__parse_groups_test(evlist, pme_test, name);
 	if (err)
 		goto out;
 
@@ -109,13 +104,12 @@ static int __compute_metric(const char *name, struct value *vals,
 
 	/* And execute the metric */
 	if (name1 && ratio1)
-		*ratio1 = compute_single(&metric_events, evlist, name1);
+		*ratio1 = compute_single(evlist, name1);
 	if (name2 && ratio2)
-		*ratio2 = compute_single(&metric_events, evlist, name2);
+		*ratio2 = compute_single(evlist, name2);
 
 out:
 	/* ... cleanup. */
-	metricgroup__rblist_exit(&metric_events);
 	evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
 	evlist__delete(evlist);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 815b40097428..8bbe0516ecc0 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -868,9 +868,6 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	struct evlist *evlist;
 	struct perf_cpu_map *cpus;
 	struct evsel *evsel;
-	struct rblist metric_events = {
-		.nr_entries = 0,
-	};
 	int err = 0;
 
 	if (!pm->metric_expr)
@@ -895,7 +892,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
 
-	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name, &metric_events);
+	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name);
 	if (err) {
 		if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
 		    !strcmp(pm->metric_name, "M3")) {
@@ -922,7 +919,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 		k++;
 	}
 	evlist__for_each_entry(evlist, evsel) {
-		struct metric_event *me = metricgroup__lookup(&metric_events, evsel, false);
+		struct metric_event *me = metricgroup__lookup(&evlist->metric_events, evsel, false);
 
 		if (me != NULL) {
 			struct metric_expr *mexp;
@@ -944,7 +941,6 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 		pr_debug("Broken metric %s\n", pm->metric_name);
 
 	/* ... cleanup. */
-	metricgroup__rblist_exit(&metric_events);
 	evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
 	evlist__delete(evlist);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index fbcc0626f9ce..25e2769b5e74 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -413,8 +413,7 @@ static bool has_pattern_string(const char *str)
 	return !!strpbrk(str, "{}[]()|*+?^$");
 }
 
-int evlist__expand_cgroup(struct evlist *evlist, const char *str,
-			  struct rblist *metric_events, bool open_cgroup)
+int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
@@ -440,12 +439,8 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 	evlist__splice_list_tail(orig_list, &evlist->core.entries);
 	evlist->core.nr_entries = 0;
 
-	if (metric_events) {
-		orig_metric_events = *metric_events;
-		rblist__init(metric_events);
-	} else {
-		rblist__init(&orig_metric_events);
-	}
+	orig_metric_events = evlist->metric_events;
+	metricgroup__rblist_init(&evlist->metric_events);
 
 	if (has_pattern_string(str))
 		prefix_len = match_cgroups(str);
@@ -490,12 +485,10 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 		cgroup__put(cgrp);
 		nr_cgroups++;
 
-		if (metric_events) {
-			if (metricgroup__copy_metric_events(tmp_list, cgrp,
-							    metric_events,
-							    &orig_metric_events) < 0)
-				goto out_err;
-		}
+		if (metricgroup__copy_metric_events(tmp_list, cgrp,
+						    &evlist->metric_events,
+						    &orig_metric_events) < 0)
+			goto out_err;
 
 		evlist__splice_list_tail(evlist, &tmp_list->core.entries);
 		tmp_list->core.nr_entries = 0;
@@ -512,7 +505,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 out_err:
 	evlist__delete(orig_list);
 	evlist__delete(tmp_list);
-	rblist__exit(&orig_metric_events);
+	metricgroup__rblist_exit(&orig_metric_events);
 	release_cgroup_list();
 
 	return ret;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index de8882d6e8d3..7b1bda22878c 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -28,8 +28,7 @@ struct rblist;
 
 struct cgroup *cgroup__new(const char *name, bool do_open);
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
-int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
-			  struct rblist *metric_events, bool open_cgroup);
+int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups, bool open_cgroup);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5664ebf6bbc6..995ad5f654d0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -35,6 +35,7 @@
 #include "util/util.h"
 #include "util/env.h"
 #include "util/intel-tpebs.h"
+#include "util/metricgroup.h"
 #include "util/strbuf.h"
 #include <signal.h>
 #include <unistd.h>
@@ -83,6 +84,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->ctl_fd.ack = -1;
 	evlist->ctl_fd.pos = -1;
 	evlist->nr_br_cntr = -1;
+	metricgroup__rblist_init(&evlist->metric_events);
 }
 
 struct evlist *evlist__new(void)
@@ -173,6 +175,7 @@ static void evlist__purge(struct evlist *evlist)
 
 void evlist__exit(struct evlist *evlist)
 {
+	metricgroup__rblist_exit(&evlist->metric_events);
 	event_enable_timer__exit(&evlist->eet);
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 85859708393e..fac1a01ba13f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -12,6 +12,7 @@
 #include <perf/evlist.h>
 #include "events_stats.h"
 #include "evsel.h"
+#include "rblist.h"
 #include <pthread.h>
 #include <signal.h>
 #include <unistd.h>
@@ -86,6 +87,11 @@ struct evlist {
 		int	pos;	/* index at evlist core object to check signals */
 	} ctl_fd;
 	struct event_enable_timer *eet;
+	/**
+	 * @metric_events: A list of struct metric_event which each have a list
+	 * of struct metric_expr.
+	 */
+	struct rblist	metric_events;
 };
 
 struct evsel_str_handler {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ddd5c362d183..3cc6c47402bd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -103,7 +103,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 	free(me);
 }
 
-static void metricgroup__rblist_init(struct rblist *metric_events)
+void metricgroup__rblist_init(struct rblist *metric_events)
 {
 	rblist__init(metric_events);
 	metric_events->node_cmp = metric_event_cmp;
@@ -1323,7 +1323,6 @@ static int parse_groups(struct evlist *perf_evlist,
 			const char *user_requested_cpu_list,
 			bool system_wide,
 			bool fake_pmu,
-			struct rblist *metric_events_list,
 			const struct pmu_metrics_table *table)
 {
 	struct evlist *combined_evlist = NULL;
@@ -1333,8 +1332,6 @@ static int parse_groups(struct evlist *perf_evlist,
 	bool is_default = !strcmp(str, "Default");
 	int ret;
 
-	if (metric_events_list->nr_entries == 0)
-		metricgroup__rblist_init(metric_events_list);
 	ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
 					   user_requested_cpu_list,
 					   system_wide, &metric_list, table);
@@ -1425,7 +1422,8 @@ static int parse_groups(struct evlist *perf_evlist,
 			goto out;
 		}
 
-		me = metricgroup__lookup(metric_events_list, metric_events[0], true);
+		me = metricgroup__lookup(&perf_evlist->metric_events, metric_events[0],
+					 /*create=*/true);
 
 		expr = malloc(sizeof(struct metric_expr));
 		if (!expr) {
@@ -1485,8 +1483,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
-			      bool hardware_aware_grouping,
-			      struct rblist *metric_events)
+			      bool hardware_aware_grouping)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
@@ -1497,13 +1494,12 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
-			    /*fake_pmu=*/false, metric_events, table);
+			    /*fake_pmu=*/false, table);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
-				   const char *str,
-				   struct rblist *metric_events)
+				   const char *str)
 {
 	return parse_groups(evlist, "all", str,
 			    /*metric_no_group=*/false,
@@ -1511,7 +1507,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 			    /*metric_no_threshold=*/false,
 			    /*user_requested_cpu_list=*/NULL,
 			    /*system_wide=*/false,
-			    /*fake_pmu=*/true, metric_events, table);
+			    /*fake_pmu=*/true, table);
 }
 
 struct metricgroup__has_metric_data {
@@ -1596,7 +1592,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 		evsel = evlist__find_evsel(evlist, old_me->evsel->core.idx);
 		if (!evsel)
 			return -EINVAL;
-		new_me = metricgroup__lookup(new_metric_events, evsel, true);
+		new_me = metricgroup__lookup(new_metric_events, evsel, /*create=*/true);
 		if (!new_me)
 			return -ENOMEM;
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 1c07295931c1..324880b2ed8f 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -77,18 +77,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
-			      bool hardware_aware_grouping,
-			      struct rblist *metric_events);
+			      bool hardware_aware_grouping);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
-				   const char *str,
-				   struct rblist *metric_events);
+				   const char *str);
 
 int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				 void *data);
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
+void metricgroup__rblist_init(struct rblist *metric_events);
 void metricgroup__rblist_exit(struct rblist *metric_events);
 
 int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 82666bcd2eda..b5ee9f7a4662 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "thread_map.h"
 #include "trace-event.h"
+#include "metricgroup.h"
 #include "mmap.h"
 #include "util/sample.h"
 #include <internal/lib.h>
@@ -1544,6 +1545,9 @@ static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 
 		evlist__add(&pevlist->evlist, &pevsel->evsel);
 	}
+	metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=*/NULL,
+					&pevlist->evlist.metric_events,
+					&evlist->metric_events);
 	return (PyObject *)pevlist;
 }
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 9cb5245a92aa..a67b991f4e81 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -899,12 +899,11 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 				print_noise(config, os, counter, noise, /*before_metric=*/true);
 				print_running(config, os, run, ena, /*before_metric=*/true);
 				from = perf_stat__print_shadow_stats_metricgroup(config, counter, aggr_idx,
-										 &num, from, &out,
-										 &config->metric_events);
+										 &num, from, &out);
 			} while (from != NULL);
-		} else
-			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
-						      &out, &config->metric_events);
+		} else {
+			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx, &out);
+		}
 	} else {
 		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/NULL, /*val=*/0);
 	}
@@ -1016,7 +1015,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	if (perf_stat__skip_metric_event(counter, &config->metric_events, ena, run))
+	if (perf_stat__skip_metric_event(counter, ena, run))
 		return;
 
 	if (val == 0 && should_skip_zero_counter(config, counter, &id))
@@ -1275,10 +1274,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 		os.evsel = counter;
 
-		perf_stat__print_shadow_stats(config, counter, 0,
-					      0,
-					      &out,
-					      &config->metric_events);
+		perf_stat__print_shadow_stats(config, counter, 0, 0, &out);
 	}
 
 	if (!config->json_output)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index d83bda5824d2..2b4950f56fae 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -15,6 +15,7 @@
 #include <linux/zalloc.h>
 #include "iostat.h"
 #include "util/hashmap.h"
+#include "rblist.h"
 #include "tool_pmu.h"
 
 struct stats walltime_nsecs_stats;
@@ -635,14 +636,14 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 						int aggr_idx,
 						int *num,
 						void *from,
-						struct perf_stat_output_ctx *out,
-						struct rblist *metric_events)
+						struct perf_stat_output_ctx *out)
 {
 	struct metric_event *me;
 	struct metric_expr *mexp = from;
 	void *ctxp = out->ctx;
 	bool header_printed = false;
 	const char *name = NULL;
+	struct rblist *metric_events = &evsel->evlist->metric_events;
 
 	me = metricgroup__lookup(metric_events, evsel, false);
 	if (me == NULL)
@@ -683,8 +684,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int aggr_idx,
-				   struct perf_stat_output_ctx *out,
-				   struct rblist *metric_events)
+				   struct perf_stat_output_ctx *out)
 {
 	typedef void (*stat_print_function_t)(struct perf_stat_config *config,
 					const struct evsel *evsel,
@@ -735,7 +735,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	}
 
 	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
-						  &num, NULL, out, metric_events);
+						  &num, NULL, out);
 
 	if (num == 0) {
 		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN,
@@ -748,7 +748,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
  *				  if it's not running or not the metric event.
  */
 bool perf_stat__skip_metric_event(struct evsel *evsel,
-				  struct rblist *metric_events,
 				  u64 ena, u64 run)
 {
 	if (!evsel->default_metricgroup)
@@ -757,5 +756,5 @@ bool perf_stat__skip_metric_event(struct evsel *evsel,
 	if (!ena || !run)
 		return true;
 
-	return !metricgroup__lookup(metric_events, evsel, false);
+	return !metricgroup__lookup(&evsel->evlist->metric_events, evsel, false);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 1bcd7634bf47..4b0f14ae4e5f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -7,7 +7,6 @@
 #include <sys/types.h>
 #include <sys/resource.h>
 #include "cpumap.h"
-#include "rblist.h"
 #include "counts.h"
 
 struct perf_cpu_map;
@@ -108,7 +107,6 @@ struct perf_stat_config {
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_aggr_map	*cpus_aggr_map;
 	u64			*walltime_run;
-	struct rblist		 metric_events;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
@@ -187,18 +185,14 @@ struct perf_stat_output_ctx {
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int aggr_idx,
-				   struct perf_stat_output_ctx *out,
-				   struct rblist *metric_events);
-bool perf_stat__skip_metric_event(struct evsel *evsel,
-				  struct rblist *metric_events,
-				  u64 ena, u64 run);
+				   struct perf_stat_output_ctx *out);
+bool perf_stat__skip_metric_event(struct evsel *evsel, u64 ena, u64 run);
 void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 						struct evsel *evsel,
 						int aggr_idx,
 						int *num,
 						void *from,
-						struct perf_stat_output_ctx *out,
-						struct rblist *metric_events);
+						struct perf_stat_output_ctx *out);
 
 int evlist__alloc_stats(struct perf_stat_config *config,
 			struct evlist *evlist, bool alloc_raw);
-- 
2.50.0.727.gbf7dc18ff4-goog


