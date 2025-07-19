Return-Path: <linux-kernel+bounces-737526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E1B0AD95
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59C2588074
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F224C23507A;
	Sat, 19 Jul 2025 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYCQ1zNJ"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01023313E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894364; cv=none; b=X8/LC7/HXjEgs/AyauL6kxlSLOGMVEtoJ6ytUlrU1yH/nCZWIiTiBR6ModS0WJdIrFyCjAOHVwpsc6q6soGySkDeUK2sEFvIZgcDoOyGaG1H+GbfwNvMMUgSzofIS+fKdd9ATlgt2ZDAFh+U62VfBEcwGI6Dw/6kZSzDlaSblAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894364; c=relaxed/simple;
	bh=DANcYFjWFog65lA2TzZsCGmS77SSjwfSoaVllkCywbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZOf+CP0bZazMIrqdSd0E4W0hOJkKm8J2G8RO+5Ta+6o3c7kzs+5buaiYQ9GG1DAUcTieYVpI9owx9CYGPSAgCBaN7ZcrVi9QEMSdNRrHwqHqCZYNJBHPh3s4EGzhnivdyK5emJ7msym47gMFK4FhhJEse6xME9e9P+83bPYEoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYCQ1zNJ; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2f3b9f042a6so2734765fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894361; x=1753499161; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87ygbU8b8rNXhdTHrIi6W+OHuxcL4xxMWjwjqIk1tDg=;
        b=yYCQ1zNJJn62ZjijvzW0htn1cPOve7/0R39uDMGm4al7JKbcwvWBgs1WeCZWWltWzA
         qZUQE8f7/jt8YhJ9Vw3CcIdLc9vH7vGGwYf7WNygoGR7pkY7/Se4ABmOyfD07872MzpN
         /rDuD0DBdrlKXULBA/hLLnt4SZ5qrVPIEcc9tQaM0KK/v1P7iBYHpmRdg04/eA7oz+oG
         70j/L/Ebm+bY+TXoSOc8df2hiVeJV8nM2GrVyDgBX/05bEVz0E4QxKYvc8oA8iPYWQJK
         6wknfjxuq4WJWxr1SodQV1250fpE5+aZBRpO9qu1QQD+TuvDYckmkX5FFKFm33BRoT+W
         I8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894361; x=1753499161;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87ygbU8b8rNXhdTHrIi6W+OHuxcL4xxMWjwjqIk1tDg=;
        b=tzKDX7Isa98l7OOG5o+dZnymON+TbgK7E0pBIXp5bLsVCViTwyUhjaOHDTXf8kAJpL
         7jnjoYaJbLu39QcKvVncVNN6bZktVB7i9HwrxP8902moptTt8qLPZ6cG2EbinHsCVWJN
         rY7V1u9SJJ9Vx2c5aNJtAjWi3OTWa1+0Vai7jO7V81804WSNfu6epRchuTtblDCqSa2D
         R3qoynOUm7u3UulPuJuhy+bqMzwb8w0hl2iwwiwPGd2nRVNrfMnJcm59uKIIcjGHIAVJ
         feKcIHlqr4TUVTjM71na7UPHT2VfvbNWCvFD133jVQtxjjJdXLanFDYYeTu9gA6nzTb5
         xfZA==
X-Forwarded-Encrypted: i=1; AJvYcCWH+TqAb44zA1LYk66aE1p8RzmKkgjBewnNXul7J1fhsmGWvlH2jRNDVTHxVd1M2kezkblEAqn6y2qKos0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfz50GAxIQo1lJHlBzB5zYhl/RswUJYUJRNf3Vdkg36clkcR+Z
	aDoP4pgOVEiq5+UhCkNDew8Lu4t2XN1WRVsVUT2/8JixUB9mCKjE/n3ox8V+e/9WGWX+Y3EiV5H
	22xm9AhsPdw==
X-Google-Smtp-Source: AGHT+IF1zn1v8hKOs29XSjJpG0BiScmrrZ3QjOazEkYYMiDIpN9PpZyK6FC/Hrsm7Uo2yRHmvvdrcHmf9GW3
X-Received: from oabrc11.prod.google.com ([2002:a05:6871:61cb:b0:2ff:9f42:9536])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:c995:b0:2cc:3523:9cd5
 with SMTP id 586e51a60fabf-2ffb22a045amr9659853fac.17.1752894361378; Fri, 18
 Jul 2025 20:06:01 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:17 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-16-irogers@google.com>
Subject: [PATCH v3 15/15] perf metricgroups: Add NO_THRESHOLD_AND_NMI constraint
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thresholds can increase the number of counters a metric needs. The NMI
watchdog can take away a counter (hopefully the buddy watchdog will
become the default and this will no longer be true). Add a new
constraint for the case that a metric and its thresholds would fit in
counters but only if the NMI watchdog isn't enabled. Either the
threshold or the NMI watchdog should be disabled to make the metric
fit. Wire this up into the metric__group_events logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   |  1 +
 tools/perf/pmu-events/pmu-events.h | 14 ++++++++++----
 tools/perf/util/metricgroup.c      | 16 ++++++++++++----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e821155151ec..0abd3cfb15ea 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -235,6 +235,7 @@ class JsonEvent:
           'NO_GROUP_EVENTS_NMI': '2',
           'NO_NMI_WATCHDOG': '2',
           'NO_GROUP_EVENTS_SMT': '3',
+          'NO_THRESHOLD_AND_NMI': '4',
       }
       return metric_constraint_to_enum[metric_constraint]
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index a523936846e0..ea022ea55087 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -25,15 +25,21 @@ enum metric_event_groups {
 	 */
 	MetricNoGroupEvents = 1,
 	/**
-	 * @MetricNoGroupEventsNmi: Don't group events for the metric if the NMI
-	 *                          watchdog is enabled.
+	 * @MetricNoGroupEventsNmi:
+	 * Don't group events for the metric if the NMI watchdog is enabled.
 	 */
 	MetricNoGroupEventsNmi = 2,
 	/**
-	 * @MetricNoGroupEventsSmt: Don't group events for the metric if SMT is
-	 *                          enabled.
+	 * @MetricNoGroupEventsSmt:
+	 * Don't group events for the metric if SMT is enabled.
 	 */
 	MetricNoGroupEventsSmt = 3,
+	/**
+	 * @MetricNoGroupEventsThresholdAndNmi:
+	 * Don't group events for the metric thresholds and if the NMI watchdog
+	 * is enabled.
+	 */
+	MetricNoGroupEventsThresholdAndNmi = 4,
 };
 /*
  * Describe each PMU event. Each CPU has a table of PMU events.
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 3cc6c47402bd..595b83142d2c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -179,7 +179,7 @@ static void metric__watchdog_constraint_hint(const char *name, bool foot)
 		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
 }
 
-static bool metric__group_events(const struct pmu_metric *pm)
+static bool metric__group_events(const struct pmu_metric *pm, bool metric_no_threshold)
 {
 	switch (pm->event_grouping) {
 	case MetricNoGroupEvents:
@@ -191,6 +191,13 @@ static bool metric__group_events(const struct pmu_metric *pm)
 		return false;
 	case MetricNoGroupEventsSmt:
 		return !smt_on();
+	case MetricNoGroupEventsThresholdAndNmi:
+		if (metric_no_threshold)
+			return true;
+		if (!sysctl__nmi_watchdog_enabled())
+			return true;
+		metric__watchdog_constraint_hint(pm->metric_name, /*foot=*/false);
+		return false;
 	case MetricGroupEvents:
 	default:
 		return true;
@@ -212,6 +219,7 @@ static void metric__free(struct metric *m)
 static struct metric *metric__new(const struct pmu_metric *pm,
 				  const char *modifier,
 				  bool metric_no_group,
+				  bool metric_no_threshold,
 				  int runtime,
 				  const char *user_requested_cpu_list,
 				  bool system_wide)
@@ -246,7 +254,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 	}
 	m->pctx->sctx.runtime = runtime;
 	m->pctx->sctx.system_wide = system_wide;
-	m->group_events = !metric_no_group && metric__group_events(pm);
+	m->group_events = !metric_no_group && metric__group_events(pm, metric_no_threshold);
 	m->metric_refs = NULL;
 	m->evlist = NULL;
 
@@ -831,8 +839,8 @@ static int __add_metric(struct list_head *metric_list,
 		 * This metric is the root of a tree and may reference other
 		 * metrics that are added recursively.
 		 */
-		root_metric = metric__new(pm, modifier, metric_no_group, runtime,
-					  user_requested_cpu_list, system_wide);
+		root_metric = metric__new(pm, modifier, metric_no_group, metric_no_threshold,
+					  runtime, user_requested_cpu_list, system_wide);
 		if (!root_metric)
 			return -ENOMEM;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


