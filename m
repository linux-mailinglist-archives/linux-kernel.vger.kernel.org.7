Return-Path: <linux-kernel+bounces-887918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D1C395CD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83A744F21FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B222E9EB1;
	Thu,  6 Nov 2025 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yt5EBKFL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41922E7BDE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413179; cv=none; b=Pq324lU5183wWzaxG+y75/J5dCritmRnzWOSQg71XmGBKoNm3YCDVACmHEjGjjj/lvn1nI6gyGm2upK3sPbkoYy5h1b2PGvAIV+9G5ZICDgl00d/SWigdvuVwiDS+1QIw931s9l5PEFyp81qOozCR8SZ/HwrWGS2HrEahf83cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413179; c=relaxed/simple;
	bh=Kqri/Alb+V+w7qzG+QBHkhKocG0ET4LkykOzlLyraoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=awvEODDa9Gh9vcsoZUVhqImBrxi6MnFX4FHTKB6puCsKgIh9KmK3FKvXQhqjmU24fGJ6ThRF49DTAWMXfEXc6+u0766n9ixe7gbUnAKLrtanJlWdKCgbUb9X+rWOVlOxCjHLky2Gx+4QDgFm+56iUcSXzaRR/7wyLSG8piwW2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yt5EBKFL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2958c80fcabso3525225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413177; x=1763017977; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78IdArXu/o78rf9RBGlZEphptoytZiyY9nptrqq9n9I=;
        b=Yt5EBKFLBOAOqqgLuo7UCQCYimDu07kWwX4Rxcu0HP0j8THiSUH1cpAQA2s9pCgyiw
         UBBqQpZbHamQ+bhOwmIOlRdp+Y42dxsYltQ6q4XyJIzfjQaprBYvVhhjUA8w2MhOMqIY
         Y08l+7JqHWiKEbg+K1fZfZqSfvwkLceAYZXP4WVzdNJ9QliCq9odxjBL7NuwyfG6bq6h
         yhGNhvxGu0HIWaGadLnOnuMRWEVDDsjwelHoLale2ODBIuudvu0hkzHHykovuPS7zayb
         cSLratj6bwf2DPtYOT173y7/itXWyQfLZi1FZ6tb795fgs+2rBy1R2C0NSMDMVNYqj29
         YGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413177; x=1763017977;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78IdArXu/o78rf9RBGlZEphptoytZiyY9nptrqq9n9I=;
        b=AKhMW9eh+2awPYtp67F0wcwSv8NpjBltchNr27qLs7nIJohXKdxidgZpgIjsrOsCNF
         EUVFW2BehC1nHRFA6nN2Az94QHx+e4y4506jVzezTBguFO5anwNgXzdxzjEnzp6ywKe1
         Fu5iH8ehiqehX3eXLWuDuEblnL4eQYMs8tYm4v6VhS+VHppw8pdVeXFYrUBxM/TP3mgR
         absu66Qa3LXWBECjVEMRO9Q8xiDuWPtvPZ4eofBoehbijGznSJhAOBgiBefTV5GAKyYY
         Cg3atA6f8pihklify7FfKOE7z1Krl+LYcZ9e0piI9SdWKBgqTFGSZp1ha/f3pid+GDU4
         Zi/w==
X-Forwarded-Encrypted: i=1; AJvYcCUlnOLRPSIaYiGKwpwX+4NkRiDmVysX/3pyo1kIEJuVyX3tBM+9Ya6DD1n7u1UmuXldye3VKIRzJS6SZso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6KyIH0Bky2oIhSzfxCM7Xrasl/3Km8fcx25Ym3nQMfc2PZdS
	vhtSpkN8B9YUTNmz0ap9fA2sZVlmMlEmedfJ7v8KSTiFocMLOnST5n8fAekwooAKzaKtBOPyIQ9
	E/f9sg0VqRA==
X-Google-Smtp-Source: AGHT+IHT3qB+8n6x1TMTaVVHCYrNGzGlIQq4aSpq/V8+riLbDRCRUniwFBQiQEuaxOEgRM16X/FJOKJuYGXA
X-Received: from dlbuu5.prod.google.com ([2002:a05:7022:7e85:b0:119:49ca:6ba7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:9303:b0:295:745a:8016
 with SMTP id d9443c01a7336-2962ad079admr63903935ad.11.1762413177013; Wed, 05
 Nov 2025 23:12:57 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:37 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-7-irogers@google.com>
Subject: [PATCH v3 6/9] perf tool_pmu: More accurately set the cpus for tool events
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
index b895e88ff740..03864a8f5e91 100644
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
@@ -12,6 +13,7 @@
 #include <api/fs/fs.h>
 #include <api/io.h>
 #include <internal/threadmap.h>
+#include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
 #include <strings.h>
@@ -106,6 +108,23 @@ const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
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
index d642e7d73910..e95fcbd55384 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -39,6 +39,7 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *resu
 u64 tool_pmu__cpu_slots_per_cycle(void);
 
 bool perf_pmu__is_tool(const struct perf_pmu *pmu);
+struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr);
 
 bool evsel__is_tool(const struct evsel *evsel);
 enum tool_pmu_event evsel__tool_event(const struct evsel *evsel);
-- 
2.51.2.1041.gc1ab5b90ca-goog


