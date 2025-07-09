Return-Path: <linux-kernel+bounces-724533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DAAFF407
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9063B2EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1523D2B6;
	Wed,  9 Jul 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taEcZ6KU"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552025484A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097246; cv=none; b=ZZ/QbVnJ92JuPb9/EwdG4uADuIHfXCAr3NHFbs54ebMfDUvV7BinEbYWITRcM3eq7tMkRgdU6SfMyDNXRQ/i3/6CdeH0hER8ycb6pceThJq4TBLwP/yxwkeW8nQMw6ramqViEM6ub1UaSUNJ+5jocg+t0HigFFJvAEYDgLgTq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097246; c=relaxed/simple;
	bh=w5eNqcWn2O0y6EMKp9jCIupHTttD6lDBxXRkCF1rGCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Mc/QVByY8d8YWu3ZLdCh2XVABQeEglV+tgElkI858pPKXpTpXw3vvKRT80Zot8eJZANQI8DGqygQ9VokMbnDlFF4oA9MzQ+VNpN858sSdT745nm/ahdFPAlNkwHgkZp3Fg1AgRD1NeP6+aSI8mCPYsZ9FjZNhfc52jqa+laGGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=taEcZ6KU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7492da755a1so215216b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097244; x=1752702044; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoNwchClBb7Gcfk0e4XraPQtQcpY/XFOcoy596WayHU=;
        b=taEcZ6KUZWJ9OKaeovOI+2PRWrN1EjFzKt9M3Q5+HgwASQTWSUVl5V0IO36MV7YYHV
         SBo+nNW6oTX1u7LfmhL7DX+sHmAmNbtg2ABQD0rvClXe1pqdZWqIzL4bi5OhGA2CeDwz
         U/9wWt2yAaWPB0nhrTFoSIR9Ga0lkrrVluT9KCrcGHNesVmCQ9HFQtOhl8/FSPcQYnfW
         DB5nPb9Nx5b62M9PHiNot5eb2Yw546PK/QK/k9cZ8KIdhFP9BUKV3XpJh7HghJtXEhbQ
         DaiU/PYHIr277KiEiE/R+T5fAbDCnhBx+34kVs1fV0zPUC/5qBZvd+n7DNg7Hg/O5JuC
         pOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097244; x=1752702044;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoNwchClBb7Gcfk0e4XraPQtQcpY/XFOcoy596WayHU=;
        b=amm3Xm+yWrSBs70QuJlePn2m5oSCbGFRX1nF583PSZO6KL1EuzxzE1zcGCQSWjoQsf
         p3YY13mtKcW3sitDMZM0wLbvuj8xDy/HN4GOo5aPKyjmeTFVmXmTcWh3qliPqDLlRcp2
         HAuZzs13NUvOVx7mwOdgsHHzANadELE4/umtbPdfvYW5jxpCufMtRzTqUPSPXuwi5LHH
         ca29gL9o05nOrOXaCa52nR05fXHNh+KI1QMhwn4U1VadJo4PU2NRZI2pb2WGQkKQLH7p
         ZWEoUPBDZm8JulLfM6guV4FbsfLd7FymOg6Ixa6FcFGNo8m8af3PYswV32HjIhpE+zlD
         yYVA==
X-Forwarded-Encrypted: i=1; AJvYcCWC8+W1n0h4kMtKx/qr01grfNnwcNrd6yv3kl9xSb4JkG+73Guk4tnDavQvYgKzanR0gpHH8YZ5JhQLtfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQbUTiDngZhshcn/DCEUYw+T5gzix4Ifg88o1Fx47vHbW5PKv
	8iZB2Z3sn+if8YWvj8dcLMf91VKyQh888Njge9NkedM8PHaq78SUUWUUNs+Mkvnmr50O8DXMJxk
	E/jnmfxyOAA==
X-Google-Smtp-Source: AGHT+IHbQDBQev54wBPYAaHigKEDot5pz607jOo3YDSKBnzEYxbdvLW+Vqi8za47wrF7vtQtUAhBb2vfXcB1
X-Received: from pgjh9.prod.google.com ([2002:a63:df49:0:b0:b32:1431:4415])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:614e:b0:21f:5aa1:3124
 with SMTP id adf61e73a8af0-230040daa2fmr342549637.13.1752097243758; Wed, 09
 Jul 2025 14:40:43 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:22 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-6-irogers@google.com>
Subject: [PATCH v1 05/12] perf metricgroup: Factor out for-each function and
 move out printing
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

Factor metricgroup__for_each_metric into its own function handling
regular and sys metrics. Make the metric adding and printing code use
it, move the printing code into print-events files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c  | 241 ++++-----------------------------
 tools/perf/util/metricgroup.h  |   3 +-
 tools/perf/util/print-events.c | 133 ++++++++++++++++++
 tools/perf/util/print-events.h |   2 +
 4 files changed, 165 insertions(+), 214 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 43d35f956a33..ddd5c362d183 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -384,107 +384,6 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
 	       match_metric_or_groups(pm->metric_name, metric_or_groups);
 }
 
-/** struct mep - RB-tree node for building printing information. */
-struct mep {
-	/** nd - RB-tree element. */
-	struct rb_node nd;
-	/** @metric_group: Owned metric group name, separated others with ';'. */
-	char *metric_group;
-	const char *metric_name;
-	const char *metric_desc;
-	const char *metric_long_desc;
-	const char *metric_expr;
-	const char *metric_threshold;
-	const char *metric_unit;
-	const char *pmu_name;
-};
-
-static int mep_cmp(struct rb_node *rb_node, const void *entry)
-{
-	struct mep *a = container_of(rb_node, struct mep, nd);
-	struct mep *b = (struct mep *)entry;
-	int ret;
-
-	ret = strcmp(a->metric_group, b->metric_group);
-	if (ret)
-		return ret;
-
-	return strcmp(a->metric_name, b->metric_name);
-}
-
-static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const void *entry)
-{
-	struct mep *me = malloc(sizeof(struct mep));
-
-	if (!me)
-		return NULL;
-
-	memcpy(me, entry, sizeof(struct mep));
-	return &me->nd;
-}
-
-static void mep_delete(struct rblist *rl __maybe_unused,
-		       struct rb_node *nd)
-{
-	struct mep *me = container_of(nd, struct mep, nd);
-
-	zfree(&me->metric_group);
-	free(me);
-}
-
-static struct mep *mep_lookup(struct rblist *groups, const char *metric_group,
-			      const char *metric_name)
-{
-	struct rb_node *nd;
-	struct mep me = {
-		.metric_group = strdup(metric_group),
-		.metric_name = metric_name,
-	};
-	nd = rblist__find(groups, &me);
-	if (nd) {
-		free(me.metric_group);
-		return container_of(nd, struct mep, nd);
-	}
-	rblist__add_node(groups, &me);
-	nd = rblist__find(groups, &me);
-	if (nd)
-		return container_of(nd, struct mep, nd);
-	return NULL;
-}
-
-static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
-					struct rblist *groups)
-{
-	const char *g;
-	char *omg, *mg;
-
-	mg = strdup(pm->metric_group ?: pm->metric_name);
-	if (!mg)
-		return -ENOMEM;
-	omg = mg;
-	while ((g = strsep(&mg, ";")) != NULL) {
-		struct mep *me;
-
-		g = skip_spaces(g);
-		if (strlen(g))
-			me = mep_lookup(groups, g, pm->metric_name);
-		else
-			me = mep_lookup(groups, pm->metric_name, pm->metric_name);
-
-		if (me) {
-			me->metric_desc = pm->desc;
-			me->metric_long_desc = pm->long_desc;
-			me->metric_expr = pm->metric_expr;
-			me->metric_threshold = pm->metric_threshold;
-			me->metric_unit = pm->unit;
-			me->pmu_name = pm->pmu;
-		}
-	}
-	free(omg);
-
-	return 0;
-}
-
 struct metricgroup_iter_data {
 	pmu_metric_iter_fn fn;
 	void *data;
@@ -510,54 +409,22 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 	return 0;
 }
 
-static int metricgroup__add_to_mep_groups_callback(const struct pmu_metric *pm,
-					const struct pmu_metrics_table *table __maybe_unused,
-					void *vdata)
+int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
+				 void *data)
 {
-	struct rblist *groups = vdata;
-
-	return metricgroup__add_to_mep_groups(pm, groups);
-}
-
-void metricgroup__print(const struct print_callbacks *print_cb, void *print_state)
-{
-	struct rblist groups;
-	const struct pmu_metrics_table *table;
-	struct rb_node *node, *next;
+	struct metricgroup_iter_data sys_data = {
+		.fn = fn,
+		.data = data,
+	};
 
-	rblist__init(&groups);
-	groups.node_new = mep_new;
-	groups.node_cmp = mep_cmp;
-	groups.node_delete = mep_delete;
-	table = pmu_metrics_table__find();
 	if (table) {
-		pmu_metrics_table__for_each_metric(table,
-						 metricgroup__add_to_mep_groups_callback,
-						 &groups);
-	}
-	{
-		struct metricgroup_iter_data data = {
-			.fn = metricgroup__add_to_mep_groups_callback,
-			.data = &groups,
-		};
-		pmu_for_each_sys_metric(metricgroup__sys_event_iter, &data);
-	}
+		int ret = pmu_metrics_table__for_each_metric(table, fn, data);
 
-	for (node = rb_first_cached(&groups.entries); node; node = next) {
-		struct mep *me = container_of(node, struct mep, nd);
-
-		print_cb->print_metric(print_state,
-				me->metric_group,
-				me->metric_name,
-				me->metric_desc,
-				me->metric_long_desc,
-				me->metric_expr,
-				me->metric_threshold,
-				me->metric_unit,
-				me->pmu_name);
-		next = rb_next(node);
-		rblist__remove_node(&groups, node);
+		if (ret)
+			return ret;
 	}
+
+	return pmu_for_each_sys_metric(metricgroup__sys_event_iter, &sys_data);
 }
 
 static const char *code_characters = ",-=@";
@@ -1090,29 +957,6 @@ static int add_metric(struct list_head *metric_list,
 	return ret;
 }
 
-static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
-					const struct pmu_metrics_table *table __maybe_unused,
-					void *data)
-{
-	struct metricgroup_add_iter_data *d = data;
-	int ret;
-
-	if (!match_pm_metric_or_groups(pm, d->pmu, d->metric_name))
-		return 0;
-
-	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
-			 d->metric_no_threshold, d->user_requested_cpu_list,
-			 d->system_wide, d->root_metric, d->visited, d->table);
-	if (ret)
-		goto out;
-
-	*(d->has_match) = true;
-
-out:
-	*(d->ret) = ret;
-	return ret;
-}
-
 /**
  * metric_list_cmp - list_sort comparator that sorts metrics with more events to
  *                   the front. tool events are excluded from the count.
@@ -1216,55 +1060,26 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 {
 	LIST_HEAD(list);
 	int ret;
-	bool has_match = false;
-
-	{
-		struct metricgroup__add_metric_data data = {
-			.list = &list,
-			.pmu = pmu,
-			.metric_name = metric_name,
-			.modifier = modifier,
-			.metric_no_group = metric_no_group,
-			.metric_no_threshold = metric_no_threshold,
-			.user_requested_cpu_list = user_requested_cpu_list,
-			.system_wide = system_wide,
-			.has_match = false,
-		};
-		/*
-		 * Iterate over all metrics seeing if metric matches either the
-		 * name or group. When it does add the metric to the list.
-		 */
-		ret = pmu_metrics_table__for_each_metric(table, metricgroup__add_metric_callback,
-						       &data);
-		if (ret)
-			goto out;
+	struct metricgroup__add_metric_data data = {
+		.list = &list,
+		.pmu = pmu,
+		.metric_name = metric_name,
+		.modifier = modifier,
+		.metric_no_group = metric_no_group,
+		.metric_no_threshold = metric_no_threshold,
+		.user_requested_cpu_list = user_requested_cpu_list,
+		.system_wide = system_wide,
+		.has_match = false,
+	};
 
-		has_match = data.has_match;
-	}
-	{
-		struct metricgroup_iter_data data = {
-			.fn = metricgroup__add_metric_sys_event_iter,
-			.data = (void *) &(struct metricgroup_add_iter_data) {
-				.metric_list = &list,
-				.pmu = pmu,
-				.metric_name = metric_name,
-				.modifier = modifier,
-				.metric_no_group = metric_no_group,
-				.user_requested_cpu_list = user_requested_cpu_list,
-				.system_wide = system_wide,
-				.has_match = &has_match,
-				.ret = &ret,
-				.table = table,
-			},
-		};
-
-		pmu_for_each_sys_metric(metricgroup__sys_event_iter, &data);
-	}
-	/* End of pmu events. */
-	if (!has_match)
+	/*
+	 * Iterate over all metrics seeing if metric matches either the
+	 * name or group. When it does add the metric to the list.
+	 */
+	ret = metricgroup__for_each_metric(table, metricgroup__add_metric_callback, &data);
+	if (!ret && !data.has_match)
 		ret = -EINVAL;
 
-out:
 	/*
 	 * add to metric_list so that they can be released
 	 * even if it's failed
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index a04ac1afa6cc..1c07295931c1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -84,7 +84,8 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const char *str,
 				   struct rblist *metric_events);
 
-void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
+int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
+				 void *data);
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 83aaf7cda635..e233bacaa641 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -381,6 +381,139 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 	strlist__delete(evt_name_list);
 }
 
+/** struct mep - RB-tree node for building printing information. */
+struct mep {
+	/** nd - RB-tree element. */
+	struct rb_node nd;
+	/** @metric_group: Owned metric group name, separated others with ';'. */
+	char *metric_group;
+	const char *metric_name;
+	const char *metric_desc;
+	const char *metric_long_desc;
+	const char *metric_expr;
+	const char *metric_threshold;
+	const char *metric_unit;
+	const char *pmu_name;
+};
+
+static int mep_cmp(struct rb_node *rb_node, const void *entry)
+{
+	struct mep *a = container_of(rb_node, struct mep, nd);
+	struct mep *b = (struct mep *)entry;
+	int ret;
+
+	ret = strcmp(a->metric_group, b->metric_group);
+	if (ret)
+		return ret;
+
+	return strcmp(a->metric_name, b->metric_name);
+}
+
+static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const void *entry)
+{
+	struct mep *me = malloc(sizeof(struct mep));
+
+	if (!me)
+		return NULL;
+
+	memcpy(me, entry, sizeof(struct mep));
+	return &me->nd;
+}
+
+static void mep_delete(struct rblist *rl __maybe_unused,
+		       struct rb_node *nd)
+{
+	struct mep *me = container_of(nd, struct mep, nd);
+
+	zfree(&me->metric_group);
+	free(me);
+}
+
+static struct mep *mep_lookup(struct rblist *groups, const char *metric_group,
+			      const char *metric_name)
+{
+	struct rb_node *nd;
+	struct mep me = {
+		.metric_group = strdup(metric_group),
+		.metric_name = metric_name,
+	};
+	nd = rblist__find(groups, &me);
+	if (nd) {
+		free(me.metric_group);
+		return container_of(nd, struct mep, nd);
+	}
+	rblist__add_node(groups, &me);
+	nd = rblist__find(groups, &me);
+	if (nd)
+		return container_of(nd, struct mep, nd);
+	return NULL;
+}
+
+static int metricgroup__add_to_mep_groups_callback(const struct pmu_metric *pm,
+					const struct pmu_metrics_table *table __maybe_unused,
+					void *vdata)
+{
+	struct rblist *groups = vdata;
+	const char *g;
+	char *omg, *mg;
+
+	mg = strdup(pm->metric_group ?: pm->metric_name);
+	if (!mg)
+		return -ENOMEM;
+	omg = mg;
+	while ((g = strsep(&mg, ";")) != NULL) {
+		struct mep *me;
+
+		g = skip_spaces(g);
+		if (strlen(g))
+			me = mep_lookup(groups, g, pm->metric_name);
+		else
+			me = mep_lookup(groups, pm->metric_name, pm->metric_name);
+
+		if (me) {
+			me->metric_desc = pm->desc;
+			me->metric_long_desc = pm->long_desc;
+			me->metric_expr = pm->metric_expr;
+			me->metric_threshold = pm->metric_threshold;
+			me->metric_unit = pm->unit;
+			me->pmu_name = pm->pmu;
+		}
+	}
+	free(omg);
+
+	return 0;
+}
+
+void metricgroup__print(const struct print_callbacks *print_cb, void *print_state)
+{
+	struct rblist groups;
+	struct rb_node *node, *next;
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+
+	rblist__init(&groups);
+	groups.node_new = mep_new;
+	groups.node_cmp = mep_cmp;
+	groups.node_delete = mep_delete;
+
+	metricgroup__for_each_metric(table, metricgroup__add_to_mep_groups_callback, &groups);
+
+	for (node = rb_first_cached(&groups.entries); node; node = next) {
+		struct mep *me = container_of(node, struct mep, nd);
+
+		print_cb->print_metric(print_state,
+				me->metric_group,
+				me->metric_name,
+				me->metric_desc,
+				me->metric_long_desc,
+				me->metric_expr,
+				me->metric_threshold,
+				me->metric_unit,
+				me->pmu_name);
+		next = rb_next(node);
+		rblist__remove_node(&groups, node);
+	}
+}
+
 /*
  * Print the help text for the event symbols:
  */
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 8f19c2bea64a..48682e2d166d 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -37,7 +37,9 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max);
+
 void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
+void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
 #endif /* __PERF_PRINT_EVENTS_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


