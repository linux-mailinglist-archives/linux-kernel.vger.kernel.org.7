Return-Path: <linux-kernel+bounces-842397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC986BB9AD5
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93B214E5507
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DEB2566D9;
	Sun,  5 Oct 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNkmEH2u"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D841DED64
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688684; cv=none; b=VXtF84cXXwnf5A4Ssz05G/iJPu2CMZE+cEQxzRtRGKPrgGtKDpqkULaIZNUwjisLIK9naunvib8ZNilxBhzJMLiF5sZpP7bFU4rq5xghOuaHZA9EsKpx98WeyZ8zId/PFREonnGtfocFg0t0wCtW7QAxmxc4ximBc35cUgBnGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688684; c=relaxed/simple;
	bh=LrN+4hDPXX+GtU/98CjutcGW3j36vextIPc2khxAmzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GBDALw7XK937jSGcEHmjW7ygcjU/h4LC+CMo1xCKnysK6TY+0g1QsFm8B63i8ZSlGW8dSsSsRLc5wcuqn8kX34Y2Tk0s7lo7TjlYy+uVDEqfLIMs19VpqKBvguOXua3CkqVWdLXd30PpEZsvr1HArD4Mfa1CAOL0omlZ7L4ZKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNkmEH2u; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-77f700d2939so40009287b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688681; x=1760293481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=szcTf0qj1LHK+XIJq0maHOxIgYtxa9WIYEk+l+c5oUQ=;
        b=dNkmEH2unBQ/vQrAe8xeeyhZZ7KjulCeiNO2zKFA1BMhptGrAJqmbvnvArS7uEgDlA
         0Rfrcz/cBLvxf297UbIVX/wCoApitXxhyZokwGd/CYZ0ECIb5HzcW6xHkUcv5OTmthxr
         k3cBHjaZmLH/W3IpsaCxuW1q2R5zScPsE7IufE5L5LOmAoZLqp0Ur/atthkqPHxeOZ/A
         4McbONP7gqwV2cBQxrIggv3PeC6YWtD/5KiNvqjeqqrfO02V5FHny+Of7JaXzG+Pdo97
         qYg2DiNp9WiSX93uVTZvRRXXxm9Q3zdIKMJFOZuT1jUHvlIt8Cu268LxFVxXc1jpKhks
         cljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688681; x=1760293481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szcTf0qj1LHK+XIJq0maHOxIgYtxa9WIYEk+l+c5oUQ=;
        b=huSyA0pdfs+hxMn8dPQVSGHaq7m4wJAdlcz4CY1d7DE+swVR99bGyCfPhSmxG4VUvB
         qSdimdQB5fcXodj59se5QhMXreNp8yi+tP7VLqE2Eo9y0YvhCC5ILaXm/a2u/4APXxPL
         qVLy1g24AqMrTvMl0giXCERRb1Arw0TddTGNzTi/w6kcJUmREhsAjtToK034/3HPsJzg
         8x7d+UL8VsnzUf2hW9Q17mOt3OwcKv+q1dp56yFF+1p/Wo7eWH+6JHWx5FuVc245UDlp
         ZMGx7BhXDFwEQIYDCS+ykSAx6na90LohtFwkrIrIzeCfPrt9mQjtdxLKnmHc/zWumI9v
         x+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVFImX0Q9iw7O7VuB+e0JdenEj5Wgd6fXdmOMwpORswoYrVwoGzH8ezKWJNiIHaytGosNq7pii98V8+KNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCVRdswcH1aNPP8jwXWZBG6jmEq4D1FSEGVPYOflkUZ5mQqvf
	pUxBayNId8s1BXWOsdSprNSZ08YEgV8wNqeArN3XWXPTMu3o6pB+HSO3rKlifgSG3h8mpURgE2P
	zxhRvSbFS6g==
X-Google-Smtp-Source: AGHT+IHEbGpWkpavqsrpglv3FK/V0jUfi5fB3h0wJnJfyBA/F1r28u1Ckq6o3PbSclVWfAiXsLEDwH/S+5eI
X-Received: from ywbkm18.prod.google.com ([2002:a05:690c:5092:b0:765:476:f27b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7206:b0:76e:ff1e:c712
 with SMTP id 00721157ae682-77f94734345mr119211157b3.54.1759688681358; Sun, 05
 Oct 2025 11:24:41 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:06 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-4-irogers@google.com>
Subject: [PATCH v7 03/27] perf stat: Avoid wildcarding PMUs for default events
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Without a PMU perf matches an event against any PMU with the
event. Unfortunately some PMU drivers advertise a "cycles" event which
is typically just a core event. To make perf's behavior consistent,
just look up default events with their designated PMU types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 133 +++++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 84e06ec09cc2..86b99f21aafc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1853,6 +1853,38 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+/* Add given software event to evlist without wildcarding. */
+static int parse_software_event(struct evlist *evlist, const char *event,
+				struct parse_events_error *err)
+{
+	char buf[256];
+
+	snprintf(buf, sizeof(buf), "software/%s,name=%s/", event, event);
+	return parse_events(evlist, buf, err);
+}
+
+/* Add legacy hardware/hardware-cache event to evlist for all core PMUs without wildcarding. */
+static int parse_hardware_event(struct evlist *evlist, const char *event,
+				struct parse_events_error *err)
+{
+	char buf[256];
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		int ret;
+
+		if (perf_pmus__num_core_pmus() == 1)
+			snprintf(buf, sizeof(buf), "%s/%s,name=%s/", pmu->name, event, event);
+		else
+			snprintf(buf, sizeof(buf), "%s/%s/", pmu->name, event);
+
+		ret = parse_events(evlist, buf, err);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /*
  * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1976,26 +2008,31 @@ static int add_default_events(void)
 
 	if (!evlist->core.nr_entries && !evsel_list->core.nr_entries) {
 		/* No events so add defaults. */
-		if (target__has_cpu(&target))
-			ret = parse_events(evlist, "cpu-clock", &err);
-		else
-			ret = parse_events(evlist, "task-clock", &err);
-		if (ret)
-			goto out;
-
-		ret = parse_events(evlist,
-				"context-switches,"
-				"cpu-migrations,"
-				"page-faults,"
-				"instructions,"
-				"cycles,"
-				"stalled-cycles-frontend,"
-				"stalled-cycles-backend,"
-				"branches,"
-				"branch-misses",
-				&err);
-		if (ret)
-			goto out;
+		const char *sw_events[] = {
+			target__has_cpu(&target) ? "cpu-clock" : "task-clock",
+			"context-switches",
+			"cpu-migrations",
+			"page-faults",
+		};
+		const char *hw_events[] = {
+			"instructions",
+			"cycles",
+			"stalled-cycles-frontend",
+			"stalled-cycles-backend",
+			"branches",
+			"branch-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(sw_events); i++) {
+			ret = parse_software_event(evlist, sw_events[i], &err);
+			if (ret)
+				goto out;
+		}
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 
 		/*
 		 * Add TopdownL1 metrics if they exist. To minimize
@@ -2037,35 +2074,53 @@ static int add_default_events(void)
 		 * Detailed stats (-d), covering the L1 and last level data
 		 * caches:
 		 */
-		ret = parse_events(evlist,
-				"L1-dcache-loads,"
-				"L1-dcache-load-misses,"
-				"LLC-loads,"
-				"LLC-load-misses",
-				&err);
+		const char *hw_events[] = {
+			"L1-dcache-loads",
+			"L1-dcache-load-misses",
+			"LLC-loads",
+			"LLC-load-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 	}
 	if (!ret && detailed_run >=  2) {
 		/*
 		 * Very detailed stats (-d -d), covering the instruction cache
 		 * and the TLB caches:
 		 */
-		ret = parse_events(evlist,
-				"L1-icache-loads,"
-				"L1-icache-load-misses,"
-				"dTLB-loads,"
-				"dTLB-load-misses,"
-				"iTLB-loads,"
-				"iTLB-load-misses",
-				&err);
+		const char *hw_events[] = {
+			"L1-icache-loads",
+			"L1-icache-load-misses",
+			"dTLB-loads",
+			"dTLB-load-misses",
+			"iTLB-loads",
+			"iTLB-load-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 	}
 	if (!ret && detailed_run >=  3) {
 		/*
 		 * Very, very detailed stats (-d -d -d), adding prefetch events:
 		 */
-		ret = parse_events(evlist,
-				"L1-dcache-prefetches,"
-				"L1-dcache-prefetch-misses",
-				&err);
+		const char *hw_events[] = {
+			"L1-dcache-prefetches",
+			"L1-dcache-prefetch-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 	}
 out:
 	if (!ret) {
@@ -2074,7 +2129,7 @@ static int add_default_events(void)
 			 * Make at least one event non-skippable so fatal errors are visible.
 			 * 'cycles' always used to be default and non-skippable, so use that.
 			 */
-			if (strcmp("cycles", evsel__name(evsel)))
+			if (!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
 				evsel->skippable = true;
 		}
 	}
-- 
2.51.0.618.g983fd99d29-goog


