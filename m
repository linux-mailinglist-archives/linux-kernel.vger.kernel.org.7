Return-Path: <linux-kernel+bounces-707396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A69DAEC36E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 02:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7BE5649AA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732891DE885;
	Sat, 28 Jun 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yggATWAc"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC91AF0B5
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069397; cv=none; b=Jawu6VPWqjH5q0qxHxPL6/XU8vVslhbeYYz4vlsJfzAaH0iUc9i29Uqa3TUoFk+b7Iq56NVtFGgYc/c9VpmnUDbWmfdOGoDHkRE4T/pdJXf23tGd5NbpHzW8PWQy1zT53CwglE9OmaGD9SZ4UpA6AVuj9fyWdY2QKPGuoWvT7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069397; c=relaxed/simple;
	bh=OBUnSNyWg9w1qVJi5lsWp0gnwPU6CVGbBfnB2vqpaFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a056fXGQBzwM4IU/32zF02KI8JPuXKPgpqdRZq9N6VKcxY5BAX+MqimOatUIi8bPF03XwOOn3+yD33nvlvPaVs7+FHmV9acTz8XKb0TTm6inCbPCrfskLWk+OGO27qUoeEVNJKseSCXvX2xSXmMNIV/r4Ir2y9O5XD3AM5v4uX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yggATWAc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369261224bso1446875ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069393; x=1751674193; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRGNNr/giRHcF/RZj7awN1PXfLHMVDY5ladq/SDyrWA=;
        b=yggATWAcJr8YQj5FWf6Da+ph7ofd7srkEgajatrCDALWdBG+6ev+f64bWtjPCJtKnH
         ziFnSyAR41HNqs6MKxI/iGNo02TMFplKQLymapoyw8Z/0bMal8fnjWFNm3V2iegUvOwm
         U+rJevW+Yob4kRZdB/QwhG7Zwuk0pw5q/GsTu8Y9VLnWTfpp0z/a+5ni3brZ7VfXWHVg
         +s/m0L4/qbmTIYAqlb0wjOWlQIPNxHJ0XXpc/uh4/yjF2K5D8K0KYxXKAR7y7NkkX9E2
         2TacqrXwdNT6ldElseNEpOi8YGLbRrizZILuzTPaMBVCxEy4poJK3EK3KLbM/3JjnXZo
         PFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069393; x=1751674193;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRGNNr/giRHcF/RZj7awN1PXfLHMVDY5ladq/SDyrWA=;
        b=tsGDWNXLUxwED6/0+AZsKUI/aIMnkX/cibkehGkaccXk+3DyRXPEpXniBaiTnbuqC4
         moJT1XLtHZtbA6MNUEskmPHOMYdQXG3pa7KQ+oxltty8XFvuagmG/egOhyEgJU+zosdv
         q1S/caaTD/hTDWEBzQJMgKeOgGAcMxr3s2jv/veIXlQqoaOZslwB+YJFI3+gAWDwrTYU
         C0VL/su0Vyr1YJaTOUsM9br5y3SycgQD00P85/+E97kEvTIH72iTUjmxUuPnjSxjfdVF
         iKIZTNXq4gyWvPy4mGC2FHJs0G3spA5d0bl+vNXWNLo05GhSA2t+FN7g7XrB7GzxMOvx
         7tKA==
X-Forwarded-Encrypted: i=1; AJvYcCWAiMGQQhOIW1OCrvqyGCGhEhR2i7wMs0DGABg4wj3BSgpGl8Qf5M5LnT1ljphuLiKK35p9O4YdWgivX4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnd9cSur5Q4I93zv4wNX0jlmYOR4fuif2Yi5Gm6Vob0RifFn6
	wYITBmPlJB34uzGZCPomOgWo+qn43rZ0bCgBo0JRoxM9cOKkrjR6n+lWSOIe5CKUMMXrqt52Gg1
	8BxMYgcgkig==
X-Google-Smtp-Source: AGHT+IEKjPmCl2GdnmP0vx6YL3lLsvP3ZqhYNKejhvHojetXyQjKCZnUXElkJyoqNjqNDLOOclOnwtUKti+H
X-Received: from pgns23.prod.google.com ([2002:a63:9257:0:b0:b2f:556f:74a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec89:b0:234:be9b:539a
 with SMTP id d9443c01a7336-23ac4669445mr86349385ad.40.1751069393051; Fri, 27
 Jun 2025 17:09:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:23 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-10-irogers@google.com>
Subject: [PATCH v4 09/15] perf jevents: Add common software event json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add json for software events so that in perf list the events can have
a description.  Common json exists for the tool PMU but it has no
sysfs equivalent. Modify the map_for_pmu code to return the common map
(rather than an architecture specific one) when a PMU with a common
name is being looked for, this allows the events to be found.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/common/common/software.json          |  92 ++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++++++++-------
 tools/perf/pmu-events/jevents.py              |  15 +-
 3 files changed, 264 insertions(+), 109 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json

diff --git a/tools/perf/pmu-events/arch/common/common/software.json b/tools/perf/pmu-events/arch/common/common/software.json
new file mode 100644
index 000000000000..3af2f565a601
--- /dev/null
+++ b/tools/perf/pmu-events/arch/common/common/software.json
@@ -0,0 +1,92 @@
+[
+  {
+    "Unit": "software",
+    "EventName": "cpu-clock",
+    "BriefDescription": "Per-CPU high-resolution timer based event",
+    "ConfigCode": "0"
+  },
+  {
+    "Unit": "software",
+    "EventName": "task-clock",
+    "BriefDescription": "Task based high-resolution timer based event",
+    "ConfigCode": "1"
+  },
+  {
+    "Unit": "software",
+    "EventName": "faults",
+    "BriefDescription": "Number of page faults [This event is an alias of page-faults]",
+    "ConfigCode": "2"
+  },
+  {
+    "Unit": "software",
+    "EventName": "page-faults",
+    "BriefDescription": "Number of page faults [This event is an alias of faults]",
+    "ConfigCode": "2"
+  },
+  {
+    "Unit": "software",
+    "EventName": "context-switches",
+    "BriefDescription": "Number of context switches [This event is an alias of cs]",
+    "ConfigCode": "3"
+  },
+  {
+    "Unit": "software",
+    "EventName": "cs",
+    "BriefDescription": "Number of context switches [This event is an alias of context-switches]",
+    "ConfigCode": "3"
+  },
+  {
+    "Unit": "software",
+    "EventName": "cpu-migrations",
+    "BriefDescription": "Number of times a process has migrated to a new CPU [This event is an alias of migrations]",
+    "ConfigCode": "4"
+  },
+  {
+    "Unit": "software",
+    "EventName": "migrations",
+    "BriefDescription": "Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]",
+    "ConfigCode": "4"
+  },
+  {
+    "Unit": "software",
+    "EventName": "minor-faults",
+    "BriefDescription": "Number of minor page faults. Minor faults don't require I/O to handle",
+    "ConfigCode": "5"
+  },
+  {
+    "Unit": "software",
+    "EventName": "major-faults",
+    "BriefDescription": "Number of major page faults. Major faults require I/O to handle",
+    "ConfigCode": "6"
+  },
+  {
+    "Unit": "software",
+    "EventName": "alignment-faults",
+    "BriefDescription": "Number of kernel handled memory alignment faults",
+    "ConfigCode": "7"
+  },
+  {
+    "Unit": "software",
+    "EventName": "emulation-faults",
+    "BriefDescription": "Number of kernel handled unimplemented instruction faults handled through emulation",
+    "ConfigCode": "8"
+  },
+  {
+    "Unit": "software",
+    "EventName": "dummy",
+    "BriefDescription": "A placeholder event that doesn't count anything",
+    "ConfigCode": "9"
+  },
+  {
+    "Unit": "software",
+    "EventName": "bpf-output",
+    "BriefDescription": "An event used by BPF programs to write to the perf ring buffer",
+    "ConfigCode": "10"
+  },
+  {
+    "Unit": "software",
+    "EventName": "cgroup-switches",
+    "BriefDescription": "Number of context switches to a task in a different cgroup",
+    "ConfigCode": "11"
+  }
+]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index a4569a74db07..7d179d703ab1 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -19,109 +19,147 @@ struct pmu_table_entry {
 };
 
 static const char *const big_c_string =
-/* offset=0 */ "tool\000"
-/* offset=5 */ "duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000"
-/* offset=81 */ "user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000"
-/* offset=151 */ "system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000"
-/* offset=219 */ "has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000"
-/* offset=295 */ "num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000"
-/* offset=440 */ "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000"
-/* offset=543 */ "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000"
-/* offset=660 */ "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000"
-/* offset=736 */ "num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000"
-/* offset=822 */ "slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000"
-/* offset=932 */ "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000"
-/* offset=1039 */ "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000"
-/* offset=1138 */ "default_core\000"
-/* offset=1151 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000"
-/* offset=1213 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000"
-/* offset=1275 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=1373 */ "segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000"
-/* offset=1475 */ "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000"
-/* offset=1608 */ "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000"
-/* offset=1726 */ "hisi_sccl,ddrc\000"
-/* offset=1741 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000"
-/* offset=1811 */ "uncore_cbox\000"
-/* offset=1823 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000"
-/* offset=1977 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000"
-/* offset=2031 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000"
-/* offset=2089 */ "hisi_sccl,l3c\000"
-/* offset=2103 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000"
-/* offset=2171 */ "uncore_imc_free_running\000"
-/* offset=2195 */ "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000"
-/* offset=2275 */ "uncore_imc\000"
-/* offset=2286 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000"
-/* offset=2351 */ "uncore_sys_ddr_pmu\000"
-/* offset=2370 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000"
-/* offset=2446 */ "uncore_sys_ccn_pmu\000"
-/* offset=2465 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=2542 */ "uncore_sys_cmn_pmu\000"
-/* offset=2561 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=2704 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
-/* offset=2726 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000"
-/* offset=2789 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=2955 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3019 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3086 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3157 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3251 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000"
-/* offset=3385 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3449 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3517 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3587 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
-/* offset=3609 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
-/* offset=3631 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3651 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
+/* offset=0 */ "software\000"
+/* offset=9 */ "cpu-clock\000software\000Per-CPU high-resolution timer based event\000config=0\000\00000\000\000\000\000\000"
+/* offset=87 */ "task-clock\000software\000Task based high-resolution timer based event\000config=1\000\00000\000\000\000\000\000"
+/* offset=169 */ "faults\000software\000Number of page faults [This event is an alias of page-faults]\000config=2\000\00000\000\000\000\000\000"
+/* offset=264 */ "page-faults\000software\000Number of page faults [This event is an alias of faults]\000config=2\000\00000\000\000\000\000\000"
+/* offset=359 */ "context-switches\000software\000Number of context switches [This event is an alias of cs]\000config=3\000\00000\000\000\000\000\000"
+/* offset=460 */ "cs\000software\000Number of context switches [This event is an alias of context-switches]\000config=3\000\00000\000\000\000\000\000"
+/* offset=561 */ "cpu-migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of migrations]\000config=4\000\00000\000\000\000\000\000"
+/* offset=693 */ "migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]\000config=4\000\00000\000\000\000\000\000"
+/* offset=825 */ "minor-faults\000software\000Number of minor page faults. Minor faults don't require I/O to handle\000config=5\000\00000\000\000\000\000\000"
+/* offset=934 */ "major-faults\000software\000Number of major page faults. Major faults require I/O to handle\000config=6\000\00000\000\000\000\000\000"
+/* offset=1037 */ "alignment-faults\000software\000Number of kernel handled memory alignment faults\000config=7\000\00000\000\000\000\000\000"
+/* offset=1129 */ "emulation-faults\000software\000Number of kernel handled unimplemented instruction faults handled through emulation\000config=8\000\00000\000\000\000\000\000"
+/* offset=1256 */ "dummy\000software\000A placeholder event that doesn't count anything\000config=9\000\00000\000\000\000\000\000"
+/* offset=1336 */ "bpf-output\000software\000An event used by BPF programs to write to the perf ring buffer\000config=0xa\000\00000\000\000\000\000\000"
+/* offset=1438 */ "cgroup-switches\000software\000Number of context switches to a task in a different cgroup\000config=0xb\000\00000\000\000\000\000\000"
+/* offset=1541 */ "tool\000"
+/* offset=1546 */ "duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000"
+/* offset=1622 */ "user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000"
+/* offset=1692 */ "system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000"
+/* offset=1760 */ "has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000"
+/* offset=1836 */ "num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000"
+/* offset=1981 */ "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000"
+/* offset=2084 */ "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000"
+/* offset=2201 */ "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000"
+/* offset=2277 */ "num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000"
+/* offset=2363 */ "slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000"
+/* offset=2473 */ "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000"
+/* offset=2580 */ "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000"
+/* offset=2679 */ "default_core\000"
+/* offset=2692 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000"
+/* offset=2754 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000"
+/* offset=2816 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000"
+/* offset=2914 */ "segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000"
+/* offset=3016 */ "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000"
+/* offset=3149 */ "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000"
+/* offset=3267 */ "hisi_sccl,ddrc\000"
+/* offset=3282 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000"
+/* offset=3352 */ "uncore_cbox\000"
+/* offset=3364 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000"
+/* offset=3518 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000"
+/* offset=3572 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000"
+/* offset=3630 */ "hisi_sccl,l3c\000"
+/* offset=3644 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000"
+/* offset=3712 */ "uncore_imc_free_running\000"
+/* offset=3736 */ "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000"
+/* offset=3816 */ "uncore_imc\000"
+/* offset=3827 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000"
+/* offset=3892 */ "uncore_sys_ddr_pmu\000"
+/* offset=3911 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000"
+/* offset=3987 */ "uncore_sys_ccn_pmu\000"
+/* offset=4006 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=4083 */ "uncore_sys_cmn_pmu\000"
+/* offset=4102 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=4245 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
+/* offset=4267 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000"
+/* offset=4330 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=4496 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=4560 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=4627 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=4698 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=4792 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000"
+/* offset=4926 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000"
+/* offset=4990 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=5058 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=5128 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
+/* offset=5150 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
+/* offset=5172 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=5192 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
 ;
 
+static const struct compact_pmu_event pmu_events__common_software[] = {
+{ 1037 }, /* alignment-faults\000software\000Number of kernel handled memory alignment faults\000config=7\000\00000\000\000\000\000\000 */
+{ 1336 }, /* bpf-output\000software\000An event used by BPF programs to write to the perf ring buffer\000config=0xa\000\00000\000\000\000\000\000 */
+{ 1438 }, /* cgroup-switches\000software\000Number of context switches to a task in a different cgroup\000config=0xb\000\00000\000\000\000\000\000 */
+{ 359 }, /* context-switches\000software\000Number of context switches [This event is an alias of cs]\000config=3\000\00000\000\000\000\000\000 */
+{ 9 }, /* cpu-clock\000software\000Per-CPU high-resolution timer based event\000config=0\000\00000\000\000\000\000\000 */
+{ 561 }, /* cpu-migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of migrations]\000config=4\000\00000\000\000\000\000\000 */
+{ 460 }, /* cs\000software\000Number of context switches [This event is an alias of context-switches]\000config=3\000\00000\000\000\000\000\000 */
+{ 1256 }, /* dummy\000software\000A placeholder event that doesn't count anything\000config=9\000\00000\000\000\000\000\000 */
+{ 1129 }, /* emulation-faults\000software\000Number of kernel handled unimplemented instruction faults handled through emulation\000config=8\000\00000\000\000\000\000\000 */
+{ 169 }, /* faults\000software\000Number of page faults [This event is an alias of page-faults]\000config=2\000\00000\000\000\000\000\000 */
+{ 934 }, /* major-faults\000software\000Number of major page faults. Major faults require I/O to handle\000config=6\000\00000\000\000\000\000\000 */
+{ 693 }, /* migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]\000config=4\000\00000\000\000\000\000\000 */
+{ 825 }, /* minor-faults\000software\000Number of minor page faults. Minor faults don't require I/O to handle\000config=5\000\00000\000\000\000\000\000 */
+{ 264 }, /* page-faults\000software\000Number of page faults [This event is an alias of faults]\000config=2\000\00000\000\000\000\000\000 */
+{ 87 }, /* task-clock\000software\000Task based high-resolution timer based event\000config=1\000\00000\000\000\000\000\000 */
+};
 static const struct compact_pmu_event pmu_events__common_tool[] = {
-{ 5 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000 */
-{ 219 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000 */
-{ 295 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000 */
-{ 440 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000 */
-{ 543 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000 */
-{ 660 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000 */
-{ 736 }, /* num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000 */
-{ 822 }, /* slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000 */
-{ 932 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000 */
-{ 151 }, /* system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000 */
-{ 1039 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000 */
-{ 81 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000 */
+{ 1546 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000 */
+{ 1760 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000 */
+{ 1836 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000 */
+{ 1981 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000 */
+{ 2084 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000 */
+{ 2201 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000 */
+{ 2277 }, /* num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000 */
+{ 2363 }, /* slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000 */
+{ 2473 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000 */
+{ 1692 }, /* system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000 */
+{ 2580 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000 */
+{ 1622 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000 */
 
 };
 
 const struct pmu_table_entry pmu_events__common[] = {
+{
+     .entries = pmu_events__common_software,
+     .num_entries = ARRAY_SIZE(pmu_events__common_software),
+     .pmu_name = { 0 /* software\000 */ },
+},
 {
      .entries = pmu_events__common_tool,
      .num_entries = ARRAY_SIZE(pmu_events__common_tool),
-     .pmu_name = { 0 /* tool\000 */ },
+     .pmu_name = { 1541 /* tool\000 */ },
 },
 };
 
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_core[] = {
-{ 1151 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000 */
-{ 1213 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000 */
-{ 1475 }, /* dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000 */
-{ 1608 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000 */
-{ 1275 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
-{ 1373 }, /* segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000 */
+{ 2692 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000 */
+{ 2754 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000 */
+{ 3016 }, /* dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000 */
+{ 3149 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000 */
+{ 2816 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
+{ 2914 }, /* segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_ddrc[] = {
-{ 1741 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000 */
+{ 3282 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l3c[] = {
-{ 2103 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000 */
+{ 3644 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox[] = {
-{ 1977 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000 */
-{ 2031 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000 */
-{ 1823 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000 */
+{ 3518 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000 */
+{ 3572 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000 */
+{ 3364 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[] = {
-{ 2286 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000 */
+{ 3827 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_free_running[] = {
-{ 2195 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000 */
+{ 3736 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000 */
 
 };
 
@@ -129,51 +167,51 @@ const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
 {
      .entries = pmu_events__test_soc_cpu_default_core,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
-     .pmu_name = { 1138 /* default_core\000 */ },
+     .pmu_name = { 2679 /* default_core\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name = { 1726 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name = { 3267 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name = { 2089 /* hisi_sccl,l3c\000 */ },
+     .pmu_name = { 3630 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name = { 1811 /* uncore_cbox\000 */ },
+     .pmu_name = { 3352 /* uncore_cbox\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_uncore_imc,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name = { 2275 /* uncore_imc\000 */ },
+     .pmu_name = { 3816 /* uncore_imc\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_running),
-     .pmu_name = { 2171 /* uncore_imc_free_running\000 */ },
+     .pmu_name = { 3712 /* uncore_imc_free_running\000 */ },
 },
 };
 
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_core[] = {
-{ 2704 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 3385 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000 */
-{ 3157 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 3251 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000 */
-{ 3449 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
-{ 3517 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
-{ 2789 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 2726 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000 */
-{ 3651 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000 */
-{ 3587 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 3609 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 3631 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 3086 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
-{ 2955 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
-{ 3019 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
+{ 4245 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 4926 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000 */
+{ 4698 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 4792 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000 */
+{ 4990 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
+{ 5058 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
+{ 4330 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 4267 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000 */
+{ 5192 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000 */
+{ 5128 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 5150 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 5172 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 4627 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
+{ 4496 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
+{ 4560 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
 
 };
 
@@ -181,18 +219,18 @@ const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
 {
      .entries = pmu_metrics__test_soc_cpu_default_core,
      .num_entries = ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
-     .pmu_name = { 1138 /* default_core\000 */ },
+     .pmu_name = { 2679 /* default_core\000 */ },
 },
 };
 
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_ccn_pmu[] = {
-{ 2465 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000 */
+{ 4006 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_cmn_pmu[] = {
-{ 2561 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000 */
+{ 4102 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_ddr_pmu[] = {
-{ 2370 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000 */
+{ 3911 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000 */
 
 };
 
@@ -200,17 +238,17 @@ const struct pmu_table_entry pmu_events__test_soc_sys[] = {
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu),
-     .pmu_name = { 2446 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name = { 3987 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu),
-     .pmu_name = { 2542 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name = { 4083 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu),
-     .pmu_name = { 2351 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name = { 3892 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
 
@@ -632,8 +670,20 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
         struct perf_cpu cpu = {-1};
 
-        if (pmu)
+        if (pmu) {
+                for (size_t i=0; i < ARRAY_SIZE(pmu_events__common); i++) {
+                        const char *pmu_name = &big_c_string[pmu_events__common[i].pmu_name.offset];
+
+                        if (!strcmp(pmu_name, pmu->name)) {
+                                const struct pmu_events_map *map = &pmu_events_map[0];
+
+                                while (strcmp("common", map->arch))
+                                        map++;
+                                return map;
+                        }
+                }
                 cpu = perf_cpu_map__min(pmu->cpus);
+        }
         return map_for_cpu(cpu);
 }
 
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e821155151ec..76c1e7b0bc22 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -295,6 +295,7 @@ class JsonEvent:
           'cpu_atom': 'cpu_atom',
           'ali_drw': 'ali_drw',
           'arm_cmn': 'arm_cmn',
+          'software': 'software',
           'tool': 'tool',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
@@ -1158,8 +1159,20 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
         struct perf_cpu cpu = {-1};
 
-        if (pmu)
+        if (pmu) {
+                for (size_t i=0; i < ARRAY_SIZE(pmu_events__common); i++) {
+                        const char *pmu_name = &big_c_string[pmu_events__common[i].pmu_name.offset];
+
+                        if (!strcmp(pmu_name, pmu->name)) {
+                                const struct pmu_events_map *map = &pmu_events_map[0];
+
+                                while (strcmp("common", map->arch))
+                                        map++;
+                                return map;
+                        }
+                }
                 cpu = perf_cpu_map__min(pmu->cpus);
+        }
         return map_for_cpu(cpu);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


