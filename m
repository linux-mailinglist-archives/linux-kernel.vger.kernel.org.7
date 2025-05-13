Return-Path: <linux-kernel+bounces-646655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E3AB5EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 23:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CFB3BE747
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4B1F4C90;
	Tue, 13 May 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgNITqVE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6851FDE0E
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173359; cv=none; b=m8kKHH4ckdN/7F2I9X6iEzd5R2hahMxT/Fc+p13Ks/Fiy5C2Lebq/Uzrgc9qNViAoIWuoGfdFKHTzZC0oJ0VCNvZ2+epmkil/RUoSV4OxiHFFhc0JgUWzgGb6g/hZYrzMPfjh3oaMFCqP81dw71WL4RXiSup5KgVWbN9d8IMYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173359; c=relaxed/simple;
	bh=nR99SUTdqFUuaD5tMttyYWLPU8mWrk364VDXvKYLrwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2IvM8VJKwl3xYSaVe+am0rlsfzc5MRD/i4BxmDePD7oJEtIURUY+hO9v+Qx2a/bD31B+onkF9q2qppVhkWhEqxkDzx/aLLW3MVmvNmWB0RIWyn6wTpY0WkXCE5enZAl0X3VIWWg6rQ/Kn3mfxF+TBAs8HW/5X0E7xS+D3MQ42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgNITqVE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c8c9070d2so5054580a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747173357; x=1747778157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LaJgiZUD9lSlUYeR57pYoh0wIZAElBP/u7f4ylkxeJY=;
        b=IgNITqVErFl8vSrS3EQAbBX0KOowu7+/4FVlVH+LZSWTEhxMYMRBAlXz0MeFRBcLxU
         7g3S20bXp1BN2iA8GBpmQA8APZmgX1ayUTjrNQ6glFEQ4vyprMoXGnqfvA3wbA47tfBa
         LTgcFM5Yk8HcL3SKZC++KJNTCB/W0giLZApJpsihl6IXQpeXCUMdpiB/K7NnS2pTiGNT
         LN7nYb5KD3PHhSS+HN6qbjXlfwZEbRShW9P2tfth5BQSl2kfLCrGZNFn6rKSGKxDY8Hl
         IxOYH3sCDPvmtKraediCcnmoyOkRnpPSqcn69m8w2sjUtZZESN7so0Z+eGQxTzc5w9Gr
         GV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173357; x=1747778157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaJgiZUD9lSlUYeR57pYoh0wIZAElBP/u7f4ylkxeJY=;
        b=U0Wvfkoq8TrQ7VACFSwa3anFVF2FcpDY7X1KkvRqKnglvDYv0rPSAOEP5tNuQgEoj4
         qpaB3Kzq5FqdAVefKRM57/XAYJcr6KcEmwtcOJ0BzC2REC91Vr6IL6XP4+SG6NqmVTV2
         zsWz7gl+gVjPQP4wVTxJ9szT6Gs49frkj4LQR6Rq4H4kfQKSBk2YtUqSGR1Djm7W/UOV
         kzjAYnFEt+bgvp1kmjfStglq3xs6UvZ8FHpa7LsV+5Agz0z7Po1XjkePl0LL50MDs/A9
         1WYzTTzli6uVThtriQl7fj4BaSCCgIeLIrN/vRho+M8XkOHayez60Su1HyeibHl57ORL
         1ZmA==
X-Gm-Message-State: AOJu0YyocTCkm9V7f91YRFA5ZQpEoZh54U6mD2lkwgHJ2OYi2itichnk
	Yjjw9y20EKX+KCFXKLG3dZZya5QKfe7y4NvT70Du5GvMq2StKoogevFdX19RyxAQeYK/ApuaD5J
	QdJWUPT2OBfwcNrPKYLxrRZXMWf4vExF9oyYwlvDa3O3KkQls+ccaQZAj5lzaftXz84+OGxXewR
	zvCLm5fpaQiKgE7XRs7VwwRrR6Vvv7/uymnD2KJpXB
X-Google-Smtp-Source: AGHT+IHJuQHiOfwhBszDwLVdPGoMZ/rtR6mmuuUVP0xSBtoUwnH1WSkCIMc4Qp6eKfgBBgPxbSzq8nT2u68=
X-Received: from pjbee7.prod.google.com ([2002:a17:90a:fc47:b0:2ff:852c:ceb8])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8d:b0:2ff:53ad:a0ec
 with SMTP id 98e67ed59e1d1-30e2e5d1a30mr1609975a91.21.1747173356923; Tue, 13
 May 2025 14:55:56 -0700 (PDT)
Date: Tue, 13 May 2025 14:45:01 -0700
In-Reply-To: <20250513215401.2315949-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513215401.2315949-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513215401.2315949-2-ctshao@google.com>
Subject: [PATCH v4 1/3] perf evlist: Make uniquifying counter names consistent
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	weilin.wang@intel.com, yeoreum.yun@arm.com, linux@treblig.org, 
	ak@linux.intel.com, linux-perf-users@vger.kernel.org
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
 tools/perf/util/parse-events.c |   2 +-
 tools/perf/util/stat-display.c | 149 +--------------------------------
 8 files changed, 177 insertions(+), 174 deletions(-)

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
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 177d045577c4..e4ef8a828ac9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2267,7 +2267,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 		if (verbose > 0) {
 			struct strbuf sb = STRBUF_INIT;
 
-			evlist__uniquify_name(evlist);
+			evlist__uniquify_evsel_names(evlist, &stat_config);
 			evlist__format_evsels(evlist, &sb, 2048);
 			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
 			strbuf_release(&sb);
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


