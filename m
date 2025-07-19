Return-Path: <linux-kernel+bounces-737516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF57B0AD8B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44EF1C41A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A421FF4A;
	Sat, 19 Jul 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0Jh1Hpx"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8521D3E8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894343; cv=none; b=SjRlwHc9dcWbc1DYb1kUzQl0DV71E8DwdpT6/YSD87d2sX38GzIOTJeaf2MyEAhdx8QF4YOqI4AiBdvXoPS+yCYuT1ca94JFoRQNDfH0IkIf6t0LOtdXg4VPNKnA73+QtQZU7nF4ee/JxaPnYezv/IuG7cCva3BSg03P/1sNWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894343; c=relaxed/simple;
	bh=LV19GYynUUF0CjbElgTqMTM8C4erDLHMoiN6xloIXdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=d11JSTgRSnUrftxiDeeZVh9TrWAYrFdbQGXzCNYYhsm9nefqWh2n8TEc8sFACzZCt5B3wz4lwsTKaTbWuk40ir2Vl6/SgC3L1PG5lHgiVKokTK8J+abbXjBLx9u0wUkPpSTQVm0ohcj6DsXcSI27OzlggrHe6/1Cq07//Cpm5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0Jh1Hpx; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2fff642182fso884462fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894340; x=1753499140; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sNed9QLILs+6YAkcENeXJYowIz3bMiJ6NyLJB9+4y0=;
        b=y0Jh1HpxhemVM2zhp9arx4TCzyJkdo1iD0IEWhHRwwTJaJWTo80N8GaBjSflpWZwHz
         fo+aQPWAGiLCBULcpRO9/LwDsE6z0K5i1CutNU9XeHV1rxIf++wRRGRZBRGKvcFYFlFO
         7Xy+315CeciRzG4O3TcJOwQhDDIrIzSHLJ68SCgRDbKM4A2E4Uigw9Ze8UoyvTnd+YNa
         lo/nfEk2tb6xrV3NcPRAjtSYz84ljgLa2EKYnm4EF1e0kSRD4MTUyf8E739Qvdbvv2/Q
         dJx9pvis1Xxhwd95aq9W9lbjj+RIZlVo0+6nnIZCKwu0bfeZNTwqUMeaTYuSPqRJL/+m
         0oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894340; x=1753499140;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sNed9QLILs+6YAkcENeXJYowIz3bMiJ6NyLJB9+4y0=;
        b=BaBIBMsOoL6u4RhDxlOyK6jfRPDgFMgUqi8j1M7HoxD7RuL6voE0C5mL+hXISBiqTM
         Kj3a2jKlkBxh6gGjeJmsb0ALVkvmhMgQCWGHQaegcJ2l5R1egZCco84tQUFfvZr9dUH+
         9iRLfoL5xxOvs5qBcPRfij/w1JLiBcClBfYHjvAWeNd4k/ylV8iwPvOZmQg7D3ZQhCUC
         6WU523UyXBdiwlPYFYUgStX68g6dHUIi3/E60XSqDj56TkXJHFKIjzslGbIJDv2AMDwB
         ryjB9yjoLaOepnawlmtmzhCspAMpcCIdLxM6KwtF6Fh2teg7kA/SEi8HcTpxGsRXgGZP
         7EIA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Gbz8oaqpHPiJiNcw0hWD4wFQZjAtUdmkqFQ9gMTLGVUsqiNU08iCrXv7orkT4yYhclUHXchymrFqb84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBzsNoHUqo/PUpCTFyXIxRomD0se1z3Roe8gwPiDytUrEYA/e
	QfYZVuBYkobx25rYIbPeAwQemtste0reWySLUsTW+wU0N22LymmgUiHeuaRlpIyDnPY2+VRjCcA
	BQTAbvBnSIQ==
X-Google-Smtp-Source: AGHT+IElBNEhl4+hLU6pTgfpv+B/sViki2SWBWUEPxWbT4/x8P6vUwOlzLh2rEGGMDsfWXzficMMbkU1ULbD
X-Received: from oabxm8.prod.google.com ([2002:a05:6870:9f88:b0:2b8:431f:3a1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:f6a6:b0:2ff:9ff8:72c7
 with SMTP id 586e51a60fabf-2ffb24a53e1mr10854216fac.27.1752894339961; Fri, 18
 Jul 2025 20:05:39 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:07 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-6-irogers@google.com>
Subject: [PATCH v3 05/15] perf tool_pmu: Allow num_cpus(_online) to be
 specific to a cpumask
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

For hybrid metrics it is useful to know the number of p-core or e-core
CPUs. If a cpumask is specified for the num_cpus or num_cpus_online
tool events, compute the value relative to the given mask rather than
for the full system.

```
$ sudo /tmp/perf/perf stat -e 'tool/num_cpus/,tool/num_cpus,cpu=cpu_core/,
  tool/num_cpus,cpu=cpu_atom/,tool/num_cpus_online/,tool/num_cpus_online,
  cpu=cpu_core/,tool/num_cpus_online,cpu=cpu_atom/' true

 Performance counter stats for 'true':

                28      tool/num_cpus/
                16      tool/num_cpus,cpu=cpu_core/
                12      tool/num_cpus,cpu=cpu_atom/
                28      tool/num_cpus_online/
                16      tool/num_cpus_online,cpu=cpu_core/
                12      tool/num_cpus_online,cpu=cpu_atom/

       0.000767205 seconds time elapsed

       0.000938000 seconds user
       0.000000000 seconds sys
```

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c     |  2 +-
 tools/perf/util/tool_pmu.c | 56 +++++++++++++++++++++++++++++++++-----
 tools/perf/util/tool_pmu.h |  2 +-
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index ca70a14c7cdf..7fda0ff89c16 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -401,7 +401,7 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	if (ev != TOOL_PMU__EVENT_NONE) {
 		u64 count;
 
-		if (tool_pmu__read_event(ev, &count))
+		if (tool_pmu__read_event(ev, /*evsel=*/NULL, &count))
 			result = count;
 		else
 			pr_err("Failure to read '%s'", literal);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 4630b8cc8e52..7aa4f315b0ac 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -332,7 +332,7 @@ static bool has_pmem(void)
 	return has_pmem;
 }
 
-bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
+bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *result)
 {
 	const struct cpu_topology *topology;
 
@@ -347,18 +347,60 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
 		return true;
 
 	case TOOL_PMU__EVENT_NUM_CPUS:
-		*result = cpu__max_present_cpu().cpu;
+		if (!evsel || perf_cpu_map__is_empty(evsel->core.cpus)) {
+			/* No evsel to be specific to. */
+			*result = cpu__max_present_cpu().cpu;
+		} else if (!perf_cpu_map__has_any_cpu(evsel->core.cpus)) {
+			/* Evsel just has specific CPUs. */
+			*result = perf_cpu_map__nr(evsel->core.cpus);
+		} else {
+			/*
+			 * "Any CPU" event that can be scheduled on any CPU in
+			 * the PMU's cpumask. The PMU cpumask should be saved in
+			 * own_cpus. If not present fall back to max.
+			 */
+			if (!perf_cpu_map__is_empty(evsel->core.own_cpus))
+				*result = perf_cpu_map__nr(evsel->core.own_cpus);
+			else
+				*result = cpu__max_present_cpu().cpu;
+		}
 		return true;
 
 	case TOOL_PMU__EVENT_NUM_CPUS_ONLINE: {
 		struct perf_cpu_map *online = cpu_map__online();
 
-		if (online) {
+		if (!online)
+			return false;
+
+		if (!evsel || perf_cpu_map__is_empty(evsel->core.cpus)) {
+			/* No evsel to be specific to. */
 			*result = perf_cpu_map__nr(online);
-			perf_cpu_map__put(online);
-			return true;
+		} else if (!perf_cpu_map__has_any_cpu(evsel->core.cpus)) {
+			/* Evsel just has specific CPUs. */
+			struct perf_cpu_map *tmp =
+				perf_cpu_map__intersect(online, evsel->core.cpus);
+
+			*result = perf_cpu_map__nr(tmp);
+			perf_cpu_map__put(tmp);
+		} else {
+			/*
+			 * "Any CPU" event that can be scheduled on any CPU in
+			 * the PMU's cpumask. The PMU cpumask should be saved in
+			 * own_cpus, if not present then just the online cpu
+			 * mask.
+			 */
+			if (!perf_cpu_map__is_empty(evsel->core.own_cpus)) {
+				struct perf_cpu_map *tmp =
+					perf_cpu_map__intersect(online, evsel->core.own_cpus);
+
+				*result = perf_cpu_map__nr(tmp);
+				perf_cpu_map__put(tmp);
+			} else {
+				*result = perf_cpu_map__nr(online);
+			}
 		}
-		return false;
+		perf_cpu_map__put(online);
+		return true;
 	}
 	case TOOL_PMU__EVENT_NUM_DIES:
 		topology = online_topology();
@@ -417,7 +459,7 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 		val = 0;
 		if (cpu_map_idx == 0 && thread == 0) {
-			if (!tool_pmu__read_event(ev, &val)) {
+			if (!tool_pmu__read_event(ev, evsel, &val)) {
 				count->lost++;
 				val = 0;
 			}
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index c6ad1dd90a56..d642e7d73910 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -34,7 +34,7 @@ enum tool_pmu_event tool_pmu__str_to_event(const char *str);
 bool tool_pmu__skip_event(const char *name);
 int tool_pmu__num_skip_events(void);
 
-bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result);
+bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *result);
 
 u64 tool_pmu__cpu_slots_per_cycle(void);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


