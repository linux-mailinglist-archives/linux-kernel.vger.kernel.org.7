Return-Path: <linux-kernel+bounces-644978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E5AB4717
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 00:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404991B42ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E225C71F;
	Mon, 12 May 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zR51NPhe"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC701AA791
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087427; cv=none; b=HGVrnJV7sH/MaWa+4u95BR1wl5n1l0j2aps4qb5AzoPxzJmDn74TJgZsBHmEuK6215HRwKAWh9+ppd26JcQNfoCORiNGdVwq1Bh9k8GAKV7S1gWd20uUA+oZR0HlHNlVqDOUgxYA5vtnKSd7fU/4QbxivsHUaEx/G0HzCwWW0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087427; c=relaxed/simple;
	bh=Hj/nm8A76G3MFXw6Ae/3lPTg1kcxX0Md4Y1Q1nZBh70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otQfPNJXL60N63rFTB8NE6pTINKCVsW07cAFU2Vm6SId4Vl0RfDiKnCfYU7TiT12ztDv25G+TGy8Cxrr06qmivYJVFEVV+4O7w1VvfjJLG746l0wAva2Wxw3K3lDgK0hNEOvQFAhmB8dfrOPaV3YwWYjd4W2UdLXCgcAV9ZpT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zR51NPhe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7370e73f690so5498260b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747087425; x=1747692225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdHrXwP1BYz6BYlCPxMSIQiAy2f471EG1pg0VXnc4u0=;
        b=zR51NPhexT+xRJnZ/TmAmGJGE3RWP5DtwO33UYY93NsIJk8Xu9E8MPgybp6qd09MQi
         KWrTD0iaM52bQ2yUPsfuPoNCD8Q421ysWIAFALYgr9prbaXPM2M7OVuF3h0xY79rdJg6
         B2wOef9Nf4IdMbj3DZkwVOJ2jiobrFhAhAChsaX2yM5w+MLc2rS8XH5rjKpLQtF/y6zQ
         b31J1g9PQQ2yBSMnLlx2I/mew4LJx171iRzgRh2Hq9JDDaAWCy5fv2YfzJaxcqaK5CNZ
         d4fzzr55xGmwGvRj1+G9xAuOc7rASu3895Jgj7f7sXvhPNFISQcPyTgO57qZ1PMqjmoH
         gJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087425; x=1747692225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdHrXwP1BYz6BYlCPxMSIQiAy2f471EG1pg0VXnc4u0=;
        b=NTuywFz9RB70K6HAGWt8/5dL3rXAOUzY+3usYxrSEyqcijn8llOdUZKUD4xheOEaS7
         aKdUVJhPYN7L+l4uZi6beu60hdP/OM8ut2InQq+94mhn9+REdWG16K7VlXMwOfRdLvbm
         qHUQPSrHQXPtuSY+eKOP31YIfUb50YWlh6D982bE/dFPDT3Obfz1RphbvCD2YOw6XkJq
         Qnrb2F0/Y5iOuOE7kwBcTyzYwME/3gb7cwThTZfSSh9XwreBDu51YHVgvvPtHr1Cixvz
         vn6JWVJBWR9AuojihopP05qqBuacZNziW/dtBa4HtzPXp5tvKXZD0219UbI7wdjPYBfu
         QxWA==
X-Gm-Message-State: AOJu0Ywm8wZj6Hb8yG/ebdgTc/gtMiqGAv1hjRXalf6oHmGhKLNW5tja
	W09q+cAckdVs9Sx3COl/PrcfTU0nUPtNB4omY2EUl7r8XKAQhRNQk9He1Rx4Gr2b6gnow3SK/UA
	pT11elsKIhmLpP3+bXXVmQdH/ouNfF7ufNgmAJX3bjllkzJ1gAZg/ZRmRZ5bNTXfn1rUDw9pOLA
	7NaPBc/dNPur4rGCD1lZyvWHsos6YWrI0mKLjO42vc
X-Google-Smtp-Source: AGHT+IE7Fj1FwAx4EMKwuwz6+MifwQAzwivdwiO4eLPT/ypxdBSCxTkk4rpTq+C/l8HtOkAH3pWwaUa1wIk=
X-Received: from pfbbj11.prod.google.com ([2002:a05:6a00:318b:b0:740:3d9e:4ca4])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4148:b0:740:921a:3cb4
 with SMTP id d2e1a72fcca58-7423bd57d80mr21826445b3a.13.1747087424662; Mon, 12
 May 2025 15:03:44 -0700 (PDT)
Date: Mon, 12 May 2025 14:50:30 -0700
In-Reply-To: <20250512215929.2098240-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512215929.2098240-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512215929.2098240-2-ctshao@google.com>
Subject: [PATCH v3 1/3] perf evlist: Make uniquifying counter names consistent
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

perf stat has different uniquification logic to perf record and perf
top. In the case of perf record and perf top all hybrid event
names are uniquified. Perf stat is more disciplined respecting
name config terms, libpfm4 events, etc. Perf stat will uniquify
hybrid events and the non-core PMU cases shouldn't apply to perf
record or perf top. For consistency, remove the uniquification for
perf record and perf top and reuse the perf stat uniquification,
making the code more globally visible for this.

Fix the detection of cross-PMU for disabling uniquify by correctly
setting last_pmu. When setting uniquify on an evsel, make sure the
PMUs between the 2 considered events differ otherwise the uniquify
isn't adding value.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-record.c    |   7 +-
 tools/perf/builtin-top.c       |   7 +-
 tools/perf/util/evlist.c       |  66 ++++++++++-----
 tools/perf/util/evlist.h       |   3 +-
 tools/perf/util/evsel.c        | 113 +++++++++++++++++++++++++
 tools/perf/util/evsel.h        |   4 +
 tools/perf/util/stat-display.c | 149 +--------------------------------
 7 files changed, 176 insertions(+), 173 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 52cebacc19a7..94d9c97af7b7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -26,6 +26,7 @@
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
+#include "util/stat.h"
 #include "util/symbol.h"
 #include "util/record.h"
 #include "util/cpumap.h"
@@ -2484,7 +2485,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		pr_warning("WARNING: --timestamp-filename option is not available in pipe mode.\n");
 	}
 
-	evlist__uniquify_name(rec->evlist);
+	/*
+	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE
+	 * and hybrid_merge is false.
+	 */
+	evlist__uniquify_evsel_names(rec->evlist, &stat_config);
 
 	evlist__config(rec->evlist, opts, &callchain_param);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f9f31391bddb..7b6cde87d2af 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -35,6 +35,7 @@
 #include "util/mmap.h"
 #include "util/session.h"
 #include "util/thread.h"
+#include "util/stat.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/top.h"
@@ -1309,7 +1310,11 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
-	evlist__uniquify_name(top->evlist);
+	/*
+	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE
+	 * and hybrid_merge is false.
+	 */
+	evlist__uniquify_evsel_names(top->evlist, &stat_config);
 	ret = perf_top__start_counters(top);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05d1f4e8ee22..dcd1130502df 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2565,34 +2565,56 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 	perf_cpu_map__put(user_requested_cpus);
 }
 
-void evlist__uniquify_name(struct evlist *evlist)
+/* Should uniquify be disabled for the evlist? */
+static bool evlist__disable_uniquify(const struct evlist *evlist)
 {
-	char *new_name, empty_attributes[2] = ":", *attributes;
-	struct evsel *pos;
+	struct evsel *counter;
+	struct perf_pmu *last_pmu = NULL;
+	bool first = true;
 
-	if (perf_pmus__num_core_pmus() == 1)
-		return;
+	evlist__for_each_entry(evlist, counter) {
+		/* If PMUs vary then uniquify can be useful. */
+		if (!first && counter->pmu != last_pmu)
+			return false;
+		first = false;
+		if (counter->pmu) {
+			/* Allow uniquify for uncore PMUs. */
+			if (!counter->pmu->is_core)
+				return false;
+			/* Keep hybrid event names uniquified for clarity. */
+			if (perf_pmus__num_core_pmus() > 1)
+				return false;
+		}
+		last_pmu = counter->pmu;
+	}
+	return true;
+}
 
-	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_hybrid(pos))
-			continue;
+static bool evlist__set_needs_uniquify(struct evlist *evlist, const struct perf_stat_config *config)
+{
+	struct evsel *counter;
+	bool needs_uniquify = false;
 
-		if (strchr(pos->name, '/'))
-			continue;
+	if (evlist__disable_uniquify(evlist)) {
+		evlist__for_each_entry(evlist, counter)
+			counter->uniquified_name = true;
+		return false;
+	}
+
+	evlist__for_each_entry(evlist, counter) {
+		if (evsel__set_needs_uniquify(counter, config))
+			needs_uniquify = true;
+	}
+	return needs_uniquify;
+}
 
-		attributes = strchr(pos->name, ':');
-		if (attributes)
-			*attributes = '\0';
-		else
-			attributes = empty_attributes;
+void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_config *config)
+{
+	if (evlist__set_needs_uniquify(evlist, config)) {
+		struct evsel *pos;
 
-		if (asprintf(&new_name, "%s/%s/%s", pos->pmu ? pos->pmu->name : "",
-			     pos->name, attributes + 1)) {
-			free(pos->name);
-			pos->name = new_name;
-		} else {
-			*attributes = ':';
-		}
+		evlist__for_each_entry(evlist, pos)
+			evsel__uniquify_counter(pos);
 	}
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 21f6bff319fd..85859708393e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -19,6 +19,7 @@
 struct pollfd;
 struct thread_map;
 struct perf_cpu_map;
+struct perf_stat_config;
 struct record_opts;
 struct strbuf;
 struct target;
@@ -434,7 +435,7 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
-void evlist__uniquify_name(struct evlist *evlist);
+void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_config *config);
 bool evlist__has_bpf_output(struct evlist *evlist);
 bool evlist__needs_bpf_sb_event(struct evlist *evlist);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c06b191e7398..34409828f8ec 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3954,3 +3954,116 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
 		leader->core.nr_members--;
 	}
 }
+
+bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
+{
+	struct evsel *evsel;
+
+	if (counter->needs_uniquify) {
+		/* Already set. */
+		return true;
+	}
+
+	if (counter->merged_stat) {
+		/* Counter won't be shown. */
+		return false;
+	}
+
+	if (counter->use_config_name || counter->is_libpfm_event) {
+		/* Original name will be used. */
+		return false;
+	}
+
+	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
+		/* Unique hybrid counters necessary. */
+		counter->needs_uniquify = true;
+		return true;
+	}
+
+	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
+		/* Legacy event, don't uniquify. */
+		return false;
+	}
+
+	if (counter->pmu && counter->pmu->is_core &&
+	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
+		/* A sysfs or json event replacing a legacy event, don't uniquify. */
+		return false;
+	}
+
+	if (config->aggr_mode == AGGR_NONE) {
+		/* Always unique with no aggregation. */
+		counter->needs_uniquify = true;
+		return true;
+	}
+
+	/*
+	 * Do other non-merged events in the evlist have the same name? If so
+	 * uniquify is necessary.
+	 */
+	evlist__for_each_entry(counter->evlist, evsel) {
+		if (evsel == counter || evsel->merged_stat || evsel->pmu == counter->pmu)
+			continue;
+
+		if (evsel__name_is(counter, evsel__name(evsel))) {
+			counter->needs_uniquify = true;
+			return true;
+		}
+	}
+	return false;
+}
+
+void evsel__uniquify_counter(struct evsel *counter)
+{
+	const char *name, *pmu_name;
+	char *new_name, *config;
+	int ret;
+
+	/* No uniquification necessary. */
+	if (!counter->needs_uniquify)
+		return;
+
+	/* The evsel was already uniquified. */
+	if (counter->uniquified_name)
+		return;
+
+	/* Avoid checking to uniquify twice. */
+	counter->uniquified_name = true;
+
+	name = evsel__name(counter);
+	pmu_name = counter->pmu->name;
+	/* Already prefixed by the PMU name. */
+	if (!strncmp(name, pmu_name, strlen(pmu_name)))
+		return;
+
+	config = strchr(name, '/');
+	if (config) {
+		int len = config - name;
+
+		if (config[1] == '/') {
+			/* case: event// */
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
+		} else {
+			/* case: event/.../ */
+			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
+		}
+	} else {
+		config = strchr(name, ':');
+		if (config) {
+			/* case: event:.. */
+			int len = config - name;
+
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
+		} else {
+			/* case: event */
+			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
+		}
+	}
+	if (ret > 0) {
+		free(counter->name);
+		counter->name = new_name;
+	} else {
+		/* ENOMEM from asprintf. */
+		counter->uniquified_name = false;
+	}
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3d47d9318d92..df8d2eea0465 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -16,6 +16,7 @@
 struct bpf_object;
 struct cgroup;
 struct perf_counts;
+struct perf_stat_config;
 struct perf_stat_evsel;
 union perf_event;
 struct bpf_counter_ops;
@@ -548,6 +549,9 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel);
 
+bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config);
+void evsel__uniquify_counter(struct evsel *counter);
+
 /*
  * Macro to swap the bit-field postition and size.
  * Used when,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e31d9f64d3ae..c022afb28514 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -915,61 +915,6 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 }
 
-static void evsel__uniquify_counter(struct evsel *counter)
-{
-	const char *name, *pmu_name;
-	char *new_name, *config;
-	int ret;
-
-	/* No uniquification necessary. */
-	if (!counter->needs_uniquify)
-		return;
-
-	/* The evsel was already uniquified. */
-	if (counter->uniquified_name)
-		return;
-
-	/* Avoid checking to uniquify twice. */
-	counter->uniquified_name = true;
-
-	name = evsel__name(counter);
-	pmu_name = counter->pmu->name;
-	/* Already prefixed by the PMU name. */
-	if (!strncmp(name, pmu_name, strlen(pmu_name)))
-		return;
-
-	config = strchr(name, '/');
-	if (config) {
-		int len = config - name;
-
-		if (config[1] == '/') {
-			/* case: event// */
-			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
-		} else {
-			/* case: event/.../ */
-			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
-		}
-	} else {
-		config = strchr(name, ':');
-		if (config) {
-			/* case: event:.. */
-			int len = config - name;
-
-			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
-		} else {
-			/* case: event */
-			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
-		}
-	}
-	if (ret > 0) {
-		free(counter->name);
-		counter->name = new_name;
-	} else {
-		/* ENOMEM from asprintf. */
-		counter->uniquified_name = false;
-	}
-}
-
 /**
  * should_skip_zero_count() - Check if the event should print 0 values.
  * @config: The perf stat configuration (including aggregation mode).
@@ -1060,8 +1005,6 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	if (counter->merged_stat)
 		return;
 
-	evsel__uniquify_counter(counter);
-
 	val = aggr->counts.val;
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
@@ -1636,96 +1579,6 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
-/* Should uniquify be disabled for the evlist? */
-static bool evlist__disable_uniquify(const struct evlist *evlist)
-{
-	struct evsel *counter;
-	struct perf_pmu *last_pmu = NULL;
-	bool first = true;
-
-	evlist__for_each_entry(evlist, counter) {
-		/* If PMUs vary then uniquify can be useful. */
-		if (!first && counter->pmu != last_pmu)
-			return false;
-		first = false;
-		if (counter->pmu) {
-			/* Allow uniquify for uncore PMUs. */
-			if (!counter->pmu->is_core)
-				return false;
-			/* Keep hybrid event names uniquified for clarity. */
-			if (perf_pmus__num_core_pmus() > 1)
-				return false;
-		}
-	}
-	return true;
-}
-
-static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
-{
-	struct evsel *evsel;
-
-	if (counter->merged_stat) {
-		/* Counter won't be shown. */
-		return;
-	}
-
-	if (counter->use_config_name || counter->is_libpfm_event) {
-		/* Original name will be used. */
-		return;
-	}
-
-	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
-		/* Unique hybrid counters necessary. */
-		counter->needs_uniquify = true;
-		return;
-	}
-
-	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
-		/* Legacy event, don't uniquify. */
-		return;
-	}
-
-	if (counter->pmu && counter->pmu->is_core &&
-	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
-		/* A sysfs or json event replacing a legacy event, don't uniquify. */
-		return;
-	}
-
-	if (config->aggr_mode == AGGR_NONE) {
-		/* Always unique with no aggregation. */
-		counter->needs_uniquify = true;
-		return;
-	}
-
-	/*
-	 * Do other non-merged events in the evlist have the same name? If so
-	 * uniquify is necessary.
-	 */
-	evlist__for_each_entry(counter->evlist, evsel) {
-		if (evsel == counter || evsel->merged_stat)
-			continue;
-
-		if (evsel__name_is(counter, evsel__name(evsel))) {
-			counter->needs_uniquify = true;
-			return;
-		}
-	}
-}
-
-static void evlist__set_needs_uniquify(struct evlist *evlist, const struct perf_stat_config *config)
-{
-	struct evsel *counter;
-
-	if (evlist__disable_uniquify(evlist)) {
-		evlist__for_each_entry(evlist, counter)
-			counter->uniquified_name = true;
-		return;
-	}
-
-	evlist__for_each_entry(evlist, counter)
-		evsel__set_needs_uniquify(counter, config);
-}
-
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts,
 			    int argc, const char **argv)
@@ -1737,7 +1590,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
-	evlist__set_needs_uniquify(evlist, config);
+	evlist__uniquify_evsel_names(evlist, config);
 
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
-- 
2.49.0.1045.g170613ef41-goog


