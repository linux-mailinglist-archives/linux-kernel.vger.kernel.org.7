Return-Path: <linux-kernel+bounces-707100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7DAEBFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE4B7B500A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D3207A0C;
	Fri, 27 Jun 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoIuPbTw"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1042EE5E4
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052287; cv=none; b=Msue8tdecS/V3L5DjDovvcQ7sRpYqF39FXw5UjUUnL7CNcMmW3QWP3M6X4NclWgzz4G1+MsgubGiyAN3gEA2k5i9Ydjf1GGppQ3HeAMrpM7ghgfojy1Lp8SXfMqngur18mx/f3+WMEqPJG9WCWSZB5e0s8NK8Mc7OUKqArft9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052287; c=relaxed/simple;
	bh=M2yPbJ9yDVEQz3yIkcAcoszaWQfbdh8hZW/S1OuH2Ak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NKsoze+qoC3hBg8YOryHN6fIxeUfnWYlxFFbnUisENy89Nlzf3ojKsWO7pFq5YexxAxZeQ6RlSQS78hcgKLdtJwBx7ooRBxzDQF/AYw47ImfEY4zgwmGJTFV5LbcIUvq3K9LPq5ly6b7JOrK4wRr+tA6oSWoYNMAEXSdagWiD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uoIuPbTw; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2d9e7fbfedaso227743fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052285; x=1751657085; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3Q/ULdBEGngG34x3hXr5lFsxJBBvdO44FGsF6UluQg=;
        b=uoIuPbTwlhMZcDR/BtHXSrA3/2+8qMsB1npCXQvVkbFs/ZBNHojc6N2MZAZqp3VWSv
         v3nFoxVVUgqGZv/8CpGKdftMn9l5hWEnpJrvqZEuUHWeYSK5iA5cEaplaDId5g7xpXsl
         nqDvyQPjnc0xix0n8pUh39iUjLyqnYNspuEeicnY0WIU0TIk+3RPZDqM00bU7cppX0hF
         z9bOlwZK8vL5nQG9VJoVeL8xJiOHxgdVNHD3c1uh+2JHU3Nlu/gRGubdRXTK6HtFl2Sd
         R62zFe/gbF4jE8KS0EAOJy/BiHwwh/z4MKspIUgPXWQbDCgWJTRQWb+4b86Aeh1JmmhP
         yLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052285; x=1751657085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3Q/ULdBEGngG34x3hXr5lFsxJBBvdO44FGsF6UluQg=;
        b=cCJQypyaZvpLwQ6lLOjkyCk0hOlI03u2zOORsZlbCb1Z8geYV1p03xW2db5sPloKAy
         Snv8jIlSTVDBg6JE9x5LF98dIH56r1Z1yxtuXY9RlEtx8FVXjlTLRfLdP+6c1sK+i+FL
         ZfkF8ikoUYem7e7Z+RgVlVUQ2TN28qRu3coPMLIhnm0ejrvpwULazmmdyUoseXrpqGgE
         GIQO88kNUhS1SQ98t4sKERtOXehqLk0aZtn6Ycw7ky4N6SHpYymeLtEVzKxvA7AL5GRG
         NiZx2SwPv6LvNS1yj095Kla/qSFpFZskDS6vW2/1Qyl7+u/zYJ5au08hbmpgCNM71nhX
         gqFg==
X-Forwarded-Encrypted: i=1; AJvYcCUtX0SoC5RqPdKWQvSGWvGxuPt2a+kOvkKS1F1y79uGhImVt1b/0Ph3UR0KrrdkUQMpYqv7r/TmoNbNq7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Ee8JWBCp+yjG0lTLzKvAWwMLIW/D0E4LEfJz4mSMaFKhUOZh
	/Jrw9yFhuehrN+5Vs3jgApNHRnlo5wRwm1r17emOcxd6ld8bYJ3naIkb6lmyll3xPje9yWEQTXC
	Kyj2qF9DrMA==
X-Google-Smtp-Source: AGHT+IGlOvwlmutKPb3zybhQz7t5hQULCTe0D0fT//oISF2zt1cNPyANEM+Mirilb3j28Yt4HvL8mqjCW+6a
X-Received: from oabpc15.prod.google.com ([2002:a05:6870:1ecf:b0:2e9:2323:d48f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:e013:b0:29e:4ba5:4ddc
 with SMTP id 586e51a60fabf-2efed684156mr2905508fac.24.1751052284907; Fri, 27
 Jun 2025 12:24:44 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:17 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-13-irogers@google.com>
Subject: [PATCH v1 12/12] perf parse-events: Support user CPUs mixed with threads/processes
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Counting events system-wide with a specified CPU prior to this change worked:
```
$ perf stat -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' -a sleep 1

  Performance counter stats for 'system wide':

     59,393,419,099      msr/tsc/
     33,927,965,927      msr/tsc,cpu=cpu_core/
     25,465,608,044      msr/tsc,cpu=cpu_atom/
```

However, when counting with process the counts became system wide:
```
$ perf stat -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
 10.1: Basic parsing test                                            : Ok
 10.2: Parsing without PMU name                                      : Ok
 10.3: Parsing with PMU name                                         : Ok

 Performance counter stats for 'perf test -F 10':

        59,233,549      msr/tsc/
        59,227,556      msr/tsc,cpu=cpu_core/
        59,224,053      msr/tsc,cpu=cpu_atom/
```

Make the handling of CPU maps with event parsing clearer. When an
event is parsed creating an evsel the cpus should be either the PMU's
cpumask or user specified CPUs.

Update perf_evlist__propagate_maps so that it doesn't clobber the user
specified CPUs. Try to make the behavior clearer, firstly fix up
missing cpumasks. Next, perform sanity checks and adjustments from the
global evlist CPU requests and for the PMU including simplifying to
the "any CPU"(-1) value. Finally remove the event if the cpumask is
empty.

So that events are opened with a CPU and a thread change stat's
create_perf_stat_counter to give both.

With the change things are fixed:
```
$ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
 10.1: Basic parsing test                                            : Ok
 10.2: Parsing without PMU name                                      : Ok
 10.3: Parsing with PMU name                                         : Ok

 Performance counter stats for 'perf test -F 10':

        63,704,975      msr/tsc/
        47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
        16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
```

However, note the "--no-scale" option is used. This is necessary as
the running time for the event on the counter isn't the same as the
enabled time because the thread doesn't necessarily run on the CPUs
specified for the counter. All counter values are scaled with:

  scaled_value = value * time_enabled / time_running

and so without --no-scale the scaled_value becomes very large. This
problem already exists on hybrid systems for the same reason. Here are
2 runs of the same code with an instructions event that counts the
same on both types of core, there is no real multiplexing happening on
the event:

```
$ perf stat -e instructions perf test -F 10
...
 Performance counter stats for 'perf test -F 10':

        87,896,447      cpu_atom/instructions/                       (14.37%)
        98,171,964      cpu_core/instructions/                       (85.63%)
...
$ perf stat --no-scale -e instructions perf test -F 10
...
 Performance counter stats for 'perf test -F 10':

        13,069,890      cpu_atom/instructions/                       (19.32%)
        83,460,274      cpu_core/instructions/                       (80.68%)
...
```
The scaling has inflated per-PMU instruction counts and the overall
count by 2x.

To fix this the kernel needs changing when a task+CPU event (or just
task event on hybrid) is scheduled out. A fix could be that the state
isn't inactive but off for such events, so that time_enabled counts
don't accumulate on them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c        | 118 ++++++++++++++++++++++-----------
 tools/perf/util/parse-events.c |  10 ++-
 tools/perf/util/stat.c         |   6 +-
 3 files changed, 86 insertions(+), 48 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9d9dec21f510..2d2236400220 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -36,49 +36,87 @@ void perf_evlist__init(struct perf_evlist *evlist)
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 					  struct perf_evsel *evsel)
 {
-	if (evsel->system_wide) {
-		/* System wide: set the cpu map of the evsel to all online CPUs. */
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__new_online_cpus();
-	} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
-		/*
-		 * User requested CPUs on a core PMU, ensure the requested CPUs
-		 * are valid by intersecting with those of the PMU.
-		 */
+	if (perf_cpu_map__is_empty(evsel->cpus)) {
+		if (perf_cpu_map__is_empty(evsel->pmu_cpus)) {
+			/*
+			 * Assume the unset PMU cpus were for a system-wide
+			 * event, like a software or tracepoint.
+			 */
+			evsel->pmu_cpus = perf_cpu_map__new_online_cpus();
+		}
+		if (evlist->has_user_cpus && !evsel->system_wide) {
+			/*
+			 * Use the user CPUs unless the evsel is set to be
+			 * system wide, such as the dummy event.
+			 */
+			evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
+		} else {
+			/*
+			 * System wide and other modes, assume the cpu map
+			 * should be set to all PMU CPUs.
+			 */
+			evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
+		}
+	}
+	/*
+	 * Avoid "any CPU"(-1) for uncore and PMUs that require a CPU, even if
+	 * requested.
+	 */
+	if (evsel->requires_cpu && perf_cpu_map__has_any_cpu(evsel->cpus)) {
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->pmu_cpus);
+		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
+	}
 
-		/*
-		 * Empty cpu lists would eventually get opened as "any" so remove
-		 * genuinely empty ones before they're opened in the wrong place.
-		 */
-		if (perf_cpu_map__is_empty(evsel->cpus)) {
-			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
-
-			perf_evlist__remove(evlist, evsel);
-			/* Keep idx contiguous */
-			if (next)
-				list_for_each_entry_from(next, &evlist->entries, node)
-					next->idx--;
+	/*
+	 * Globally requested CPUs replace user requested unless the evsel is
+	 * set to be system wide.
+	 */
+	if (evlist->has_user_cpus && !evsel->system_wide) {
+		assert(!perf_cpu_map__has_any_cpu(evlist->user_requested_cpus));
+		if (!perf_cpu_map__equal(evsel->cpus, evlist->user_requested_cpus)) {
+			perf_cpu_map__put(evsel->cpus);
+			evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 		}
-	} else if (!evsel->pmu_cpus || evlist->has_user_cpus ||
-		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
-		/*
-		 * The PMU didn't specify a default cpu map, this isn't a core
-		 * event and the user requested CPUs or the evlist user
-		 * requested CPUs have the "any CPU" (aka dummy) CPU value. In
-		 * which case use the user requested CPUs rather than the PMU
-		 * ones.
-		 */
+	}
+
+	/* Ensure cpus only references valid PMU CPUs. */
+	if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
+	    !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
+		struct perf_cpu_map *tmp = perf_cpu_map__intersect(evsel->pmu_cpus, evsel->cpus);
+
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
-	} else if (evsel->cpus != evsel->pmu_cpus) {
-		/*
-		 * No user requested cpu map but the PMU cpu map doesn't match
-		 * the evsel's. Reset it back to the PMU cpu map.
-		 */
+		evsel->cpus = tmp;
+	}
+
+	/*
+	 * Was event requested on all the PMU's CPUs but the user requested is
+	 * any CPU (-1)? If so switch to using any CPU (-1) to reduce the number
+	 * of events.
+	 */
+	if (!evsel->system_wide &&
+	    perf_cpu_map__equal(evsel->cpus, evsel->pmu_cpus) &&
+	    perf_cpu_map__has_any_cpu(evlist->user_requested_cpus)) {
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
+		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
+	}
+
+	/* Sanity check assert before the evsel is potentially removed. */
+	assert(!evsel->requires_cpu || !perf_cpu_map__has_any_cpu(evsel->cpus));
+
+	/*
+	 * Empty cpu lists would eventually get opened as "any" so remove
+	 * genuinely empty ones before they're opened in the wrong place.
+	 */
+	if (perf_cpu_map__is_empty(evsel->cpus)) {
+		struct perf_evsel *next = perf_evlist__next(evlist, evsel);
+
+		perf_evlist__remove(evlist, evsel);
+		/* Keep idx contiguous */
+		if (next)
+			list_for_each_entry_from(next, &evlist->entries, node)
+				next->idx--;
+
+		return;
 	}
 
 	if (evsel->system_wide) {
@@ -98,6 +136,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 
 	evlist->needs_map_propagation = true;
 
+	/* Clear the all_cpus set which will be merged into during propagation. */
+	perf_cpu_map__put(evlist->all_cpus);
+	evlist->all_cpus = NULL;
+
 	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4092a43aa84e..0ff7ae75d8f9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -313,20 +313,18 @@ __add_event(struct list_head *list, int *idx,
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
 		pmu_cpus = perf_cpu_map__get(pmu->cpus);
+		if (perf_cpu_map__is_empty(pmu_cpus))
+			pmu_cpus = cpu_map__online();
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
 		pmu_cpus = is_pmu_core ? cpu_map__online() : NULL;
 	}
 
-	if (has_user_cpus) {
+	if (has_user_cpus)
 		cpus = perf_cpu_map__get(user_cpus);
-		/* Existing behavior that pmu_cpus matches the given user ones. */
-		perf_cpu_map__put(pmu_cpus);
-		pmu_cpus = perf_cpu_map__get(user_cpus);
-	} else {
+	else
 		cpus = perf_cpu_map__get(pmu_cpus);
-	}
 
 	if (init_attr)
 		event_attr_init(attr);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 355a7d5c8ab8..8d3bcdb69d37 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -769,8 +769,6 @@ int create_perf_stat_counter(struct evsel *evsel,
 			attr->enable_on_exec = 1;
 	}
 
-	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu_map_idx);
-
-	return evsel__open_per_thread(evsel, evsel->core.threads);
+	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
+					      evsel->core.threads);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


