Return-Path: <linux-kernel+bounces-869327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C970EC079F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7F1C4331E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488C25DAF0;
	Fri, 24 Oct 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr9kx+Gb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F883491DF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328763; cv=none; b=XBDIRbUdgmXSdZ9fhlKzBhT/tac7b67S3LHCGwM3NLMeOSXm9XYdaWMafnaTZSojE7RnxdQQsxCi3CusfTwjxFy5o64od3DW07AaPml9jyuZNQpdtKPLp/WVxXQcXDx4onZ1WglAAvJWno0WQ7CNxlux99/qOy+Yo4RwmFf4iQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328763; c=relaxed/simple;
	bh=r/jHsAaC5UE+sGy+jk3EvuTBXiW4wqUjs3xLoLTqLMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=luU4x5ohb7f0R+2tv1OT9E8RpzYcvkQLrSXmOqEJiK48qC/mSBBPPOI4TS8hK6bOkky/iSSqwG9k1qNpHVaa0KS2VvU7fEAkbkalvn8bn7n9p65+Y7uGdJtWq2EDQuuIbQjMmXKtHYVFLjBddxHbgTDRAcmEHYwGTCgwyERmtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dr9kx+Gb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1859265a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328760; x=1761933560; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnvrT+AWmZETswd//azIJ9a9kv3HAD8wcWT84bIVDf4=;
        b=Dr9kx+GbFHTPCoD7dfkKf9uZQc/shT6n/1Wd/QaDKHjE2b9c5vQekutwlULvXOwe6k
         byDiag7fVALEgU/t7BL7eQPKN4PMzBYe+GquffT/4ZAogBasQv7GPwSrJfJ+XrXXTRqX
         6RlpdiADykoYfAd94x6K4RUrOhMKMn7w3aZkHCIWDkNmtL1SoZTKug+yvRAnJsIko54a
         hNU20EHV2NRlFEatohdWkFRpyM/IeksstuxdZTBJJo1pUiCU1cbCL4vX4KivXjWARub7
         drmxVWsfhrfRCDOFUnlwR3vfCG9uON2ye3pbrCsDhDdDGWw+CajXBzpzt9kJzRjYfu4S
         OutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328760; x=1761933560;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnvrT+AWmZETswd//azIJ9a9kv3HAD8wcWT84bIVDf4=;
        b=ZBDyyU8uOp4Pe+Yey0UfpdY+m5hEYx0Mjt/b07VzMq/bv6ZWc7Z+No4ufGrPf/F3Lf
         rrvcOls+BJpUfyjZG24WHOSQzPyvcRRTQv+6G3LbM4p6rwjCvy56ix/F/2FG+oL/zL9v
         C2YvbIcK/OwQ3eScfR6Dcoxhl/R5CD8AHPOykHVCP9JLQyGbk1Jhpb2AxZdLf3bPQDu8
         cKYkKvytucAbwK7elI0NQfZ9DGPp1v4/EAUx9eqyhsUajmEV+mq8GQQvkFdayh12OqPV
         6zny2aVzow+C77wkac0rn+jqf4kxKHd5i5CT+Rt5+Kj95l9jhjnRbHmri2CqBTNrrRwH
         6LuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl1AfnZHIajpiePsQUcuO5Ne7GbaKEmyDHK6MV5pIWVggbwxvY8h6ivZiIHajpcqSwb8vNQgj5bvxyDiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsormmLzLRufH0lFkzlj6kSXhx3+TNaPQRH8gN5BPUBK5YkJX
	OkI2ZebWvgBJqulcARx2/kXCCF7NCx+2AJsHFlKEYTMxnQ8p3X0/UkVhsGPOgMuG11SBEf/J3SC
	/L3hhQgopAg==
X-Google-Smtp-Source: AGHT+IH+qJeW3u/TRX9CiHpxJ3HHx0IcJ+LScdQDtg4C2ARG7loHWGNOq+d+OlXTjBEq1CMySYh8OFDYPd7s
X-Received: from pjso22.prod.google.com ([2002:a17:90a:c096:b0:33b:b387:9850])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c7:b0:335:2747:a9b3
 with SMTP id 98e67ed59e1d1-33bcf90e717mr33478679a91.32.1761328760042; Fri, 24
 Oct 2025 10:59:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:44 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-10-irogers@google.com>
Subject: [PATCH v1 09/22] perf jevents: Add metric DefaultShowEvents
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some Default group metrics require their events showing for
consistency with perf's previous behavior. Add a flag to indicate when
this is the case and use it in stat-display.

As events are coming from Default metrics remove that default hardware
and software events from perf stat.

Following this change the default perf stat output on an alderlake looks li=
ke:
```
$ perf stat -a -- sleep 1

 Performance counter stats for 'system wide':

            20,759      context-switches                 #    735.7 cs/sec =
 cs_per_second
             TopdownL1 (cpu_core)                 #      7.8 %  tma_bad_spe=
culation
                                                  #     34.8 %  tma_fronten=
d_bound
             TopdownL1 (cpu_core)                 #     39.0 %  tma_backend=
_bound
                                                  #     18.4 %  tma_retirin=
g
               769      page-faults                      #     27.3 faults/=
sec  page_faults_per_second
       531,102,439      cpu_atom/cpu-cycles/             #      0.0 GHz  cy=
cles_frequency       (49.80%)
       785,144,850      cpu_core/cpu-cycles/             #      0.0 GHz  cy=
cles_frequency
                                                  #     17.6 %  tma_bad_spe=
culation
                                                  #     14.4 %  tma_retirin=
g             (50.20%)
                                                  #     37.0 %  tma_backend=
_bound
                                                  #     31.0 %  tma_fronten=
d_bound       (50.37%)
        47,631,924      cpu_atom/branches/               #      1.7 K/sec  =
branch_frequency     (60.31%)
       138,036,825      cpu_core/branches/               #      4.9 K/sec  =
branch_frequency
               779      cpu-migrations                   #     27.6 migrati=
ons/sec  migrations_per_second
    28,218,162,085      cpu-clock                        #     28.0 CPUs  C=
PUs_utilized
       522,230,152      cpu_atom/cpu-cycles/             #      0.5 instruc=
tions  insn_per_cycle  (60.12%)
       785,133,103      cpu_core/cpu-cycles/             #      1.0 instruc=
tions  insn_per_cycle
         2,541,997      cpu_atom/branch-misses/          #      5.5 %  bran=
ch_miss_rate         (49.63%)
         3,106,064      cpu_core/branch-misses/          #      2.3 %  bran=
ch_miss_rate

       1.007489028 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                     |  42 +------
 .../arch/common/common/metrics.json           |  33 ++++--
 tools/perf/pmu-events/empty-pmu-events.c      | 106 +++++++++---------
 tools/perf/pmu-events/jevents.py              |   7 +-
 tools/perf/pmu-events/pmu-events.h            |   1 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/metricgroup.c                 |  13 +++
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat-shadow.c                 |   2 +-
 9 files changed, 102 insertions(+), 107 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c3188a57016..9c7d63614cab 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1853,16 +1853,6 @@ static int perf_stat_init_aggr_mode_file(struct perf=
_stat *st)
 	return 0;
 }
=20
-/* Add given software event to evlist without wildcarding. */
-static int parse_software_event(struct evlist *evlist, const char *event,
-				struct parse_events_error *err)
-{
-	char buf[256];
-
-	snprintf(buf, sizeof(buf), "software/%s,name=3D%s/", event, event);
-	return parse_events(evlist, buf, err);
-}
-
 /* Add legacy hardware/hardware-cache event to evlist for all core PMUs wi=
thout wildcarding. */
 static int parse_hardware_event(struct evlist *evlist, const char *event,
 				struct parse_events_error *err)
@@ -2007,36 +1997,10 @@ static int add_default_events(void)
 		stat_config.topdown_level =3D 1;
=20
 	if (!evlist->core.nr_entries && !evsel_list->core.nr_entries) {
-		/* No events so add defaults. */
-		const char *sw_events[] =3D {
-			target__has_cpu(&target) ? "cpu-clock" : "task-clock",
-			"context-switches",
-			"cpu-migrations",
-			"page-faults",
-		};
-		const char *hw_events[] =3D {
-			"instructions",
-			"cycles",
-			"stalled-cycles-frontend",
-			"stalled-cycles-backend",
-			"branches",
-			"branch-misses",
-		};
-
-		for (size_t i =3D 0; i < ARRAY_SIZE(sw_events); i++) {
-			ret =3D parse_software_event(evlist, sw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-		for (size_t i =3D 0; i < ARRAY_SIZE(hw_events); i++) {
-			ret =3D parse_hardware_event(evlist, hw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-
 		/*
-		 * Add TopdownL1 metrics if they exist. To minimize
-		 * multiplexing, don't request threshold computation.
+		 * Add Default metrics. To minimize multiplexing, don't request
+		 * threshold computation, but it will be computed if the events
+		 * are present.
 		 */
 		if (metricgroup__has_metric_or_groups(pmu, "Default")) {
 			struct evlist *metric_evlist =3D evlist__new();
diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/=
perf/pmu-events/arch/common/common/metrics.json
index d1e37db18dc6..017bbdede3d7 100644
--- a/tools/perf/pmu-events/arch/common/common/metrics.json
+++ b/tools/perf/pmu-events/arch/common/common/metrics.json
@@ -5,7 +5,8 @@
         "MetricGroup": "Default",
         "MetricName": "CPUs_utilized",
         "ScaleUnit": "1CPUs",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Context switches per CPU second",
@@ -13,7 +14,8 @@
         "MetricGroup": "Default",
         "MetricName": "cs_per_second",
         "ScaleUnit": "1cs/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Process migrations to a new CPU per CPU secon=
d",
@@ -21,7 +23,8 @@
         "MetricGroup": "Default",
         "MetricName": "migrations_per_second",
         "ScaleUnit": "1migrations/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Page faults per CPU second",
@@ -29,7 +32,8 @@
         "MetricGroup": "Default",
         "MetricName": "page_faults_per_second",
         "ScaleUnit": "1faults/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Instructions Per Cycle",
@@ -37,27 +41,31 @@
         "MetricGroup": "Default",
         "MetricName": "insn_per_cycle",
         "MetricThreshold": "insn_per_cycle < 1",
-        "ScaleUnit": "1instructions"
+        "ScaleUnit": "1instructions",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Max front or backend stalls per instruction",
         "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\\=
-backend) / instructions",
         "MetricGroup": "Default",
-        "MetricName": "stalled_cycles_per_instruction"
+        "MetricName": "stalled_cycles_per_instruction",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Frontend stalls per cycle",
         "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
         "MetricGroup": "Default",
         "MetricName": "frontend_cycles_idle",
-        "MetricThreshold": "frontend_cycles_idle > 0.1"
+        "MetricThreshold": "frontend_cycles_idle > 0.1",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Backend stalls per cycle",
         "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
         "MetricGroup": "Default",
         "MetricName": "backend_cycles_idle",
-        "MetricThreshold": "backend_cycles_idle > 0.2"
+        "MetricThreshold": "backend_cycles_idle > 0.2",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Cycles per CPU second",
@@ -65,7 +73,8 @@
         "MetricGroup": "Default",
         "MetricName": "cycles_frequency",
         "ScaleUnit": "1GHz",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Branches per CPU second",
@@ -73,7 +82,8 @@
         "MetricGroup": "Default",
         "MetricName": "branch_frequency",
         "ScaleUnit": "1000K/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Branch miss rate",
@@ -81,6 +91,7 @@
         "MetricGroup": "Default",
         "MetricName": "branch_miss_rate",
         "MetricThreshold": "branch_miss_rate > 0.05",
-        "ScaleUnit": "100%"
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
     }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 83a01ecc625e..71464b1d8afe 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1303,32 +1303,32 @@ static const char *const big_c_string =3D
 /* offset=3D127503 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
 /* offset=3D127580 */ "uncore_sys_cmn_pmu\000"
 /* offset=3D127599 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D127742 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\00001"
-/* offset=3D127927 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
00001"
-/* offset=3D128159 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\00001"
-/* offset=3D128418 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
0001"
-/* offset=3D128648 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\00000"
-/* offset=3D128760 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\00000"
-/* offset=3D128923 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\00000"
-/* offset=3D129052 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\00000"
-/* offset=3D129177 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\00001"
-/* offset=3D129352 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
ec\000\000\000\00001"
-/* offset=3D129531 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\00000"
-/* offset=3D129634 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D129656 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\00000"
-/* offset=3D129719 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=3D129885 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D129949 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D130016 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3D130087 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3D130181 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\00000"
-/* offset=3D130315 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3D130379 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D130447 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D130517 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D130539 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D130561 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3D130581 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\00000"
+/* offset=3D127742 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
+/* offset=3D127928 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
+/* offset=3D128161 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
+/* offset=3D128421 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
+/* offset=3D128652 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
+/* offset=3D128765 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
+/* offset=3D128929 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
+/* offset=3D129059 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
+/* offset=3D129185 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
+/* offset=3D129361 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
ec\000\000\000\000011"
+/* offset=3D129541 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
+/* offset=3D129645 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D129668 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D129732 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D129899 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D129964 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D130104 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D130199 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D130334 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D130399 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D130468 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D130539 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130562 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130585 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D130606 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2615,17 +2615,17 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
-{ 127742 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\00001 */
-{ 129052 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\00000 */
-{ 129352 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\0=
00\000\00001 */
-{ 129531 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
 */
-{ 127927 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 */
-{ 129177 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\00001 */
-{ 128923 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\00000 */
-{ 128648 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\00000 */
-{ 128159 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\00001 */
-{ 128418 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
-{ 128760 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\00000 */
+{ 127742 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
+{ 129059 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
+{ 129361 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\0=
00\000\000011 */
+{ 129541 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
+{ 127928 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
+{ 129185 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 128929 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
+{ 128652 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 128161 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
+{ 128421 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
+{ 128765 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
=20
 };
=20
@@ -2698,21 +2698,21 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 129634 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 130315 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\00000 */
-{ 130087 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 130181 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\00000 */
-{ 130379 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
-{ 130447 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
-{ 129719 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 129656 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\00000 */
-{ 130581 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\00000 */
-{ 130517 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 130539 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 130561 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 130016 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
-{ 129885 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
-{ 129949 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
+{ 129645 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 130334 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 130104 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 130199 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 130399 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 130468 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 129732 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 129668 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 130606 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 130539 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 130562 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 130585 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 129899 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 129964 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
@@ -2894,6 +2894,8 @@ static void decompress_metric(int offset, struct pmu_=
metric *pm)
 	pm->aggr_mode =3D *p - '0';
 	p++;
 	pm->event_grouping =3D *p - '0';
+	p++;
+	pm->default_show_events =3D *p - '0';
 }
=20
 static int pmu_events_table__for_each_event_pmu(const struct pmu_events_ta=
ble *table,
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 5d3f4b44cfb7..3413ee5d0227 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -58,10 +58,12 @@ _json_event_attributes =3D [
 _json_metric_attributes =3D [
     'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
     'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group',
-    'default_metricgroup_name', 'aggr_mode', 'event_grouping'
+    'default_metricgroup_name', 'aggr_mode', 'event_grouping',
+    'default_show_events'
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
-_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', 'p=
erpkg']
+_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', 'p=
erpkg',
+                         'default_show_events']
=20
 def removesuffix(s: str, suffix: str) -> str:
   """Remove the suffix from a string
@@ -356,6 +358,7 @@ class JsonEvent:
     self.metricgroup_no_group =3D jd.get('MetricgroupNoGroup')
     self.default_metricgroup_name =3D jd.get('DefaultMetricgroupName')
     self.event_grouping =3D convert_metric_constraint(jd.get('MetricConstr=
aint'))
+    self.default_show_events =3D jd.get('DefaultShowEvents')
     self.metric_expr =3D None
     if 'MetricExpr' in jd:
       self.metric_expr =3D metric.ParsePerfJson(jd['MetricExpr']).Simplify=
()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu=
-events.h
index 559265a903c8..d3b24014c6ff 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -74,6 +74,7 @@ struct pmu_metric {
 	const char *default_metricgroup_name;
 	enum aggr_mode_class aggr_mode;
 	enum metric_event_groups event_grouping;
+	bool default_show_events;
 };
=20
 struct pmu_events_table;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 71f74c7036ef..3ae4ac8f9a37 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -122,6 +122,7 @@ struct evsel {
 	bool			reset_group;
 	bool			needs_auxtrace_mmap;
 	bool			default_metricgroup; /* A member of the Default metricgroup */
+	bool			default_show_events; /* If a default group member, show the event =
*/
 	bool			needs_uniquify;
 	struct hashmap		*per_pkg_mask;
 	int			err;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e67e04ce01c9..25c75fdbfc52 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -152,6 +152,8 @@ struct metric {
 	 * Should events of the metric be grouped?
 	 */
 	bool group_events;
+	/** Show events even if in the Default metric group. */
+	bool default_show_events;
 	/**
 	 * Parsed events for the metric. Optional as events may be taken from a
 	 * different metric whose group contains all the IDs necessary for this
@@ -255,6 +257,7 @@ static struct metric *metric__new(const struct pmu_metr=
ic *pm,
 	m->pctx->sctx.runtime =3D runtime;
 	m->pctx->sctx.system_wide =3D system_wide;
 	m->group_events =3D !metric_no_group && metric__group_events(pm, metric_n=
o_threshold);
+	m->default_show_events =3D pm->default_show_events;
 	m->metric_refs =3D NULL;
 	m->evlist =3D NULL;
=20
@@ -1513,6 +1516,16 @@ static int parse_groups(struct evlist *perf_evlist,
 			free(metric_events);
 			goto out;
 		}
+		if (m->default_show_events) {
+			struct evsel *pos;
+
+			for (int i =3D 0; metric_events[i]; i++)
+				metric_events[i]->default_show_events =3D true;
+			evlist__for_each_entry(metric_evlist, pos) {
+				if (pos->metric_leader && pos->metric_leader->default_show_events)
+					pos->default_show_events =3D true;
+			}
+		}
 		expr->metric_threshold =3D m->metric_threshold;
 		expr->metric_unit =3D m->metric_unit;
 		expr->metric_events =3D metric_events;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index a67b991f4e81..4d0e353846ea 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -872,7 +872,7 @@ static void printout(struct perf_stat_config *config, s=
truct outstate *os,
 	out.ctx =3D os;
 	out.force_header =3D false;
=20
-	if (!config->metric_only && !counter->default_metricgroup) {
+	if (!config->metric_only && (!counter->default_metricgroup || counter->de=
fault_show_events)) {
 		abs_printout(config, os, os->id, os->aggr_nr, counter, uval, ok);
=20
 		print_noise(config, os, counter, noise, /*before_metric=3D*/true);
@@ -880,7 +880,7 @@ static void printout(struct perf_stat_config *config, s=
truct outstate *os,
 	}
=20
 	if (ok) {
-		if (!config->metric_only && counter->default_metricgroup) {
+		if (!config->metric_only && counter->default_metricgroup && !counter->de=
fault_show_events) {
 			void *from =3D NULL;
=20
 			aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..4df614f8e200 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -665,7 +665,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct =
perf_stat_config *config,
 			if (strcmp(name, mexp->default_metricgroup_name))
 				return (void *)mexp;
 			/* Only print the name of the metricgroup once */
-			if (!header_printed) {
+			if (!header_printed && !evsel->default_show_events) {
 				header_printed =3D true;
 				perf_stat__print_metricgroup_header(config, evsel, ctxp,
 								    name, out);
--=20
2.51.1.821.gb6fe4d2222-goog


