Return-Path: <linux-kernel+bounces-884111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C0C2F61F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B141189D1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384802D0C76;
	Tue,  4 Nov 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHNYGM1A"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5A2D8780
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234517; cv=none; b=fPoGLTM1DU+dHAvEEBDqNqcnw2Sy3+0V/pGi9KHv033YMBVpNX53RMJwry0ZewfVJwH7T6avvK0nn4mgBfNTNcjHgGexIppGj/5JLQ3YIeXHOuJj1l9La8oJJ42pwgWfO/7VYRJHfG6TxBQ9la1mNrSh027SDDqBT6AskDOo8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234517; c=relaxed/simple;
	bh=08ijCr0uGlsFSbZ/fgqz1ZTZskEhlF1NYYU1LmYJx3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=odGSYzRKVNIAuX59W+VuVPYV11HWyY9JDqIuDdIy6KnmG00c+nfYt5GKt9SVtiTpQDUoa31vEY8wQ7YUabNzW3Do8rygpFzTxX/ELeewsitWjqA9mMPxX2alqSHSbyp7gORYBYAUi3MPASClM4KrQt7MykjdaQjH5Qr47jbxItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHNYGM1A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso5401704a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762234515; x=1762839315; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1KvbIMxbd19M72vJDZRo+HtVoi/M7IAdLRCZTkMiOI=;
        b=NHNYGM1A1PrVZNMOoywzfE3vDgeND22YT/63OSuI4KPyxUVRqVnyRHkiVwh0H/1nuE
         xdy2riuShdHTgbsCcZZc6mrRI3qHzDO32Y+64ZbeSuCifa8jB/TmGgJWx1RFNwyPPkEs
         Co3fYP6CLMCRMuzIxju61zvh2Z/v1L7VJnRYjiJNlOz7uK6Ornqa55Okvp4kHtifbTfW
         XOTrvMIqYpldfQNKodCdIz11yfU69snZ/QMjhA7MmlP+P/Mo79qNcuonc/z3fGnzgckI
         mAv8FfD5LZlfrqGH1byHJfH5Sgn7vxsN8WtyPdGCVzjw6PqAMVOQ8mW2FIiem+OOGbUs
         Dlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234515; x=1762839315;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1KvbIMxbd19M72vJDZRo+HtVoi/M7IAdLRCZTkMiOI=;
        b=Pj1rjZJ5WId2qT1rax8rSg5TE9xXtuaAOOJJmJpQs6xeHl2m3L3V8RD2T053gSaNho
         qvNjriXcShvXeHid1hy+n76Na/xDosLOWjXjDQBG7GUgcnStZVBAA+wyG3faoBuqsRFN
         jTuW1cHUdQYiD32HdBBmyLqBVt0WlPPIzX1MkR4OjO5QnAXBSIFnsDaaR/3KrNfBD60J
         etFDvPLDVHbs2jXVK2rUAnzBDiQdBPG+DZPdoxzPUYIr2PYY+mZgvVHwfJX8TdlCWaKU
         YfnjetrSGEUI92LahLSEMooMZFD9y+AFNTrUItyJ4c9j17RJ0cLeVUSlrvbCdgmxH4Ou
         gURg==
X-Forwarded-Encrypted: i=1; AJvYcCV/8eqceRuT1UdYCywIBFeoyGD0/1OA/CTTvqvDZhtQYaIu8qkRKzQypfxOY3kt0dFAwO+wqohLNOyAuWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/naCFraLxY2SCuhOGv3QtnGrDBA8XtZ3oJO+yd/jnuHf1iuH
	zres/9j+EYNIqKT7RpNhS1k//xCOqSZ0DKXIn90vNlTFc/PDF19XNk3bH64IukTeQY2bK9uelO6
	m9xfpkIyJ2Q==
X-Google-Smtp-Source: AGHT+IHg8vuuK24MUAVn/T8iJAz+pTziBsjHRF/6BK9JjvJ4pGSGVYhCzJOL2/pjhA8JvCw4LkfTl2GieJwB
X-Received: from pjbml3.prod.google.com ([2002:a17:90b:3603:b0:340:5073:f80f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c06:b0:341:2150:4856
 with SMTP id 98e67ed59e1d1-341215049b9mr8725601a91.17.1762234514796; Mon, 03
 Nov 2025 21:35:14 -0800 (PST)
Date: Mon,  3 Nov 2025 21:34:48 -0800
In-Reply-To: <20251104053449.1208800-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104053449.1208800-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104053449.1208800-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf stat-shadow: Read tool events directly
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

When reading time values for metrics don't use the globals updated in
builtin-stat, just read the events as regular events. The only
exception is for time events where nanoseconds need converting to
seconds as metrics assume time metrics are in seconds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 123 +++++++++++++---------------------
 1 file changed, 45 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..9fae3d32a519 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -371,6 +371,18 @@ static void print_nsecs(struct perf_stat_config *config,
 	}
 }
 
+static double tool_pmu__scale_for_metric(const struct evsel *evsel)
+{
+	enum tool_pmu_event event = evsel__tool_event(evsel);
+
+	if (event == TOOL_PMU__EVENT_DURATION_TIME ||
+	    event == TOOL_PMU__EVENT_USER_TIME ||
+	    event == TOOL_PMU__EVENT_SYSTEM_TIME)
+		return 1e-9; /* Scale nanoseconds to seconds. */
+
+	return 1.0;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -382,90 +394,45 @@ static int prepare_metric(const struct metric_expr *mexp,
 
 	for (i = 0; metric_events[i]; i++) {
 		char *n;
-		double val;
+		double val, scale = tool_pmu__scale_for_metric(metric_events[i]);
 		int source_count = 0;
+		struct perf_stat_evsel *ps = metric_events[i]->stats;
+		struct perf_stat_aggr *aggr;
 
-		if (evsel__is_tool(metric_events[i])) {
-			struct stats *stats;
-			double scale;
-
-			switch (evsel__tool_event(metric_events[i])) {
-			case TOOL_PMU__EVENT_DURATION_TIME:
-				stats = &walltime_nsecs_stats;
-				scale = 1e-9;
-				break;
-			case TOOL_PMU__EVENT_USER_TIME:
-				stats = &ru_stats.ru_utime_usec_stat;
-				scale = 1e-6;
-				break;
-			case TOOL_PMU__EVENT_SYSTEM_TIME:
-				stats = &ru_stats.ru_stime_usec_stat;
-				scale = 1e-6;
+		/*
+		 * If there are multiple uncore PMUs and we're not reading the
+		 * leader's stats, determine the stats for the appropriate
+		 * uncore PMU.
+		 */
+		if (evsel && evsel->metric_leader &&
+		    evsel->pmu != evsel->metric_leader->pmu &&
+		    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+			struct evsel *pos;
+
+			evlist__for_each_entry(evsel->evlist, pos) {
+				if (pos->pmu != evsel->pmu)
+					continue;
+				if (pos->metric_leader != mexp->metric_events[i])
+					continue;
+				ps = pos->stats;
+				source_count = 1;
 				break;
-			case TOOL_PMU__EVENT_NONE:
-				pr_err("Invalid tool event 'none'");
-				abort();
-			case TOOL_PMU__EVENT_MAX:
-				pr_err("Invalid tool event 'max'");
-				abort();
-			case TOOL_PMU__EVENT_HAS_PMEM:
-			case TOOL_PMU__EVENT_NUM_CORES:
-			case TOOL_PMU__EVENT_NUM_CPUS:
-			case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
-			case TOOL_PMU__EVENT_NUM_DIES:
-			case TOOL_PMU__EVENT_NUM_PACKAGES:
-			case TOOL_PMU__EVENT_SLOTS:
-			case TOOL_PMU__EVENT_SMT_ON:
-			case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
-			default:
-				pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
-				abort();
 			}
-			val = avg_stats(stats) * scale;
-			source_count = 1;
-		} else {
-			struct perf_stat_evsel *ps = metric_events[i]->stats;
-			struct perf_stat_aggr *aggr;
-
+		}
+		aggr = &ps->aggr[aggr_idx];
+		if (!aggr || !metric_events[i]->supported) {
 			/*
-			 * If there are multiple uncore PMUs and we're not
-			 * reading the leader's stats, determine the stats for
-			 * the appropriate uncore PMU.
+			 * Not supported events will have a count of 0, which
+			 * can be confusing in a metric. Explicitly set the
+			 * value to NAN. Not counted events (enable time of 0)
+			 * are read as 0.
 			 */
-			if (evsel && evsel->metric_leader &&
-			    evsel->pmu != evsel->metric_leader->pmu &&
-			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
-				struct evsel *pos;
-
-				evlist__for_each_entry(evsel->evlist, pos) {
-					if (pos->pmu != evsel->pmu)
-						continue;
-					if (pos->metric_leader != mexp->metric_events[i])
-						continue;
-					ps = pos->stats;
-					source_count = 1;
-					break;
-				}
-			}
-			aggr = &ps->aggr[aggr_idx];
-			if (!aggr)
-				break;
-
-			if (!metric_events[i]->supported) {
-				/*
-				 * Not supported events will have a count of 0,
-				 * which can be confusing in a
-				 * metric. Explicitly set the value to NAN. Not
-				 * counted events (enable time of 0) are read as
-				 * 0.
-				 */
-				val = NAN;
-				source_count = 0;
-			} else {
-				val = aggr->counts.val;
-				if (!source_count)
-					source_count = evsel__source_count(metric_events[i]);
-			}
+			val = NAN;
+			source_count = 0;
+		} else {
+			val = aggr->counts.val * scale;
+			if (!source_count)
+				source_count = evsel__source_count(metric_events[i]);
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.51.2.1006.ga50a493c49-goog


