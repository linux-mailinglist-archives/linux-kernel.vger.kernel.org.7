Return-Path: <linux-kernel+bounces-900026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09526C59659
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBC23B4976
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F435BDC5;
	Thu, 13 Nov 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2K4FzeLW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D635B142
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057159; cv=none; b=bo1HU7Q6jrhyXvaTDBiTK3SYW0IljGk78fkjzdcLNjMMfByjkQwLLxkZdQcgqA7zKjYyLUXIIWvf5NIS2jpbbSqGJr/vGaCycXUjUIInPDQe5P7SE0NCibAGEOX/znIVSRJQjjJM4RGFsznwp7ysUOUvPVNIDtxFy8N9jT4HhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057159; c=relaxed/simple;
	bh=0f1TDzO6H6tB8Sqz0jVLsYxxLfA6IgKxvXEGC+7+pOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HrQGicJR85RysZIojxRWwN7FVGKN0CgwYl6lQKVf/IE6VfkNd7K0E9rK4fkbjHi/cuTisXG3uM00JexXt25yw3p5w2Ugs/yd/mXVqVjPPLutHFD4EfcJt7N1IuQmAViU/TNhKuZbgYe6dmH20tDFwaM24CUNclEloIqk5pGTJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2K4FzeLW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9ceccbd7e8so2363853a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057157; x=1763661957; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuP8PXUqe7Wr/8ISWkGnPVH1SBV8e8BOv5yyhohFapc=;
        b=2K4FzeLWkayKZCudP1am8VPGfIv1ILGf6uTpjQOG64yzus2VyHDMnAQhZBZEN+oW+j
         6NR4ocLpQ8yw4TEko6zG7gLHdxyphyGyCQSeSWgiQ/TxTY7n1AbVoXpS/LbF0/mLBP1H
         csGoPbs0GT2RMPqdcpnKOwwM8axLTzc7O9/qxFq8rli6iLBl6oyebOIsUJgxL4/iS6EI
         aK73wcKuzDTNCQLXIivPuTvTOcQJblKSRiD6lUk6lDfYzzww3uDifMskz4SO61BmZ3eE
         NBDAPSZSTv7GS1DFKJQhtRjWQdXqvyyG6mOWnDC8VkXByZvLCOLixH+uLRKxSyMtBZpP
         4yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057157; x=1763661957;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuP8PXUqe7Wr/8ISWkGnPVH1SBV8e8BOv5yyhohFapc=;
        b=Ecp4mU5hurUJXPbbMQU3mq/h91X8xDXwUgrKl0A+A27wvJr5M7lQFPZz86qpU8kwgw
         TAY6TQ6ISjRtknoM7Vl/lkcpsoc5b+STKvXRft8XpDzYlsc6d23EecA/uvlYu555rtyC
         Q/rZS7WLAC8Jn9A97j40GIfJpMDwj1KEsYpbvUxWlD+Aa0niMCSD3HSRPOtWFeFwra+O
         y+kPDs/f7fDQrdO/yUdzs0GoQdf1mZRZkt8o3TfA7LU1e9BMgGszbVsVx9mHti++O6L9
         wIZWJbGdwVHe5rhFfQG4YF1B1MLvLX4IQj1A8YjSnNGsSEUwRh0XEk86XvvWBerluOk9
         Rsaw==
X-Forwarded-Encrypted: i=1; AJvYcCXpXejE3wl2ChhSjuqkAXh5wTjyzqxwXeWkuSCbJd0YVYno3UWaPjsQjYta1rtd5CV3VPCGg4HAWTg6w8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusbQZhzhwtjWiKBUVJi+y2wrT76YWNEHI5BuUGr33j494q0TN
	rZ0yTpyp+68/3URUcRErxY1GsZp78l7QlIxQoDUoSWEdows9iw8c/Imebp7uYu8QpNT1o0aWGhd
	WyoF3GTuU+w==
X-Google-Smtp-Source: AGHT+IG4tLWQG6Nhx7yV9QcYVY05Ov9bXvi/owMeYul8P75j8HZaUm6CF2k78DeEPMIywkJ59xIfi2JtS0wT
X-Received: from dlbbq19.prod.google.com ([2002:a05:7022:6713:b0:11b:1a9a:d2e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef0f:b0:11b:dff:7830
 with SMTP id a92af1059eb24-11b40fa3490mr182386c88.18.1763057156938; Thu, 13
 Nov 2025 10:05:56 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:13 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-8-irogers@google.com>
Subject: [PATCH v4 07/10] perf tool_pmu: More accurately set the cpus for tool events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

The user and system time events can record on different CPUs, but for
all other events a single CPU map of just CPU 0 makes sense. In
parse-events detect a tool PMU and then pass the perf_event_attr so
that the tool_pmu can return CPUs specific for the event. This avoids
a CPU map of all online CPUs being used for events like
duration_time. Avoiding this avoids the evlist CPUs containing CPUs
for which duration_time just gives 0. Minimizing the evlist CPUs can
remove unnecessary sched_setaffinity syscalls that delay metric
calculations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  9 +++++++--
 tools/perf/util/tool_pmu.c     | 19 +++++++++++++++++++
 tools/perf/util/tool_pmu.h     |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0c0dc20b1c13..7b2422ccb554 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -30,6 +30,7 @@
 #include "util/event.h"
 #include "util/bpf-filter.h"
 #include "util/stat.h"
+#include "util/tool_pmu.h"
 #include "util/util.h"
 #include "tracepoint.h"
 #include <api/fs/tracing_path.h>
@@ -227,8 +228,12 @@ __add_event(struct list_head *list, int *idx,
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
 		pmu_cpus = perf_cpu_map__get(pmu->cpus);
-		if (perf_cpu_map__is_empty(pmu_cpus))
-			pmu_cpus = cpu_map__online();
+		if (perf_cpu_map__is_empty(pmu_cpus)) {
+			if (perf_pmu__is_tool(pmu))
+				pmu_cpus = tool_pmu__cpus(attr);
+			else
+				pmu_cpus = cpu_map__online();
+		}
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 6a9df3dc0e07..37c4eae0bef1 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -2,6 +2,7 @@
 #include "cgroup.h"
 #include "counts.h"
 #include "cputopo.h"
+#include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
 #include "print-events.h"
@@ -13,6 +14,7 @@
 #include <api/fs/fs.h>
 #include <api/io.h>
 #include <internal/threadmap.h>
+#include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
 #include <strings.h>
@@ -109,6 +111,23 @@ const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
 	return tool_pmu__event_to_str(evsel->core.attr.config);
 }
 
+struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr)
+{
+	static struct perf_cpu_map *cpu0_map;
+	enum tool_pmu_event event = (enum tool_pmu_event)attr->config;
+
+	if (event <= TOOL_PMU__EVENT_NONE || event >= TOOL_PMU__EVENT_MAX) {
+		pr_err("Invalid tool PMU event config %llx\n", attr->config);
+		return NULL;
+	}
+	if (event == TOOL_PMU__EVENT_USER_TIME || event == TOOL_PMU__EVENT_SYSTEM_TIME)
+		return cpu_map__online();
+
+	if (!cpu0_map)
+		cpu0_map = perf_cpu_map__new_int(0);
+	return perf_cpu_map__get(cpu0_map);
+}
+
 static bool read_until_char(struct io *io, char e)
 {
 	int c;
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index f1714001bc1d..ea343d1983d3 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -46,6 +46,7 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
 u64 tool_pmu__cpu_slots_per_cycle(void);
 
 bool perf_pmu__is_tool(const struct perf_pmu *pmu);
+struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr);
 
 bool evsel__is_tool(const struct evsel *evsel);
 enum tool_pmu_event evsel__tool_event(const struct evsel *evsel);
-- 
2.51.2.1041.gc1ab5b90ca-goog


