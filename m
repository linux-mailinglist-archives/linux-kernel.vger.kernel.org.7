Return-Path: <linux-kernel+bounces-648857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB59CAB7CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 06:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3811C1BA527E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 04:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996D1DFD8B;
	Thu, 15 May 2025 04:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QS/jL6+e"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0994B1E64
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747283906; cv=none; b=o4pOwqa9eKTOFbhKB0DSTUq0uswIgwAVnlwOVscxlTdW0sROR21m1Kt0QPcp1qqJ9q2LPbC3xICx/z2BhIxGCVI1qOj66rfC0YJHCUvjr9tNlW9b4EsoOuzRf7UN1RrRi34jK7DtvEAJNPB8uTfO0zqUGnFvnFQiNDkyPTfeuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747283906; c=relaxed/simple;
	bh=BCI+KnRPUXyvaGES9sAE11EgKvIR88AyrKZy+NyGomw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=RbFxpRpjiiehBFNulk9/uVl1T5ShpNVshQMjiLIyYs3+NrkiIEVqGmkouFOIT3UUbp39KFWMWTE8Jg/PTMvpyBnr2RhImJzQjnfjMLc2HcMWAi8ipWkc5UiPgm7aBzSMECE7iFvotB5uqmXJtluBUgMQteBIgScS1hx4eMPajdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QS/jL6+e; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso758395b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 21:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747283903; x=1747888703; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pbqrSEzLVPfD9Ggyo5gmKiNjk02F3GcErehRkTGB7Y=;
        b=QS/jL6+eyX2zcwsquGQnzqP0d8O+uT+wSAWBaE7XM3+EUpLev8UM8qIBeNNXq/XRZJ
         8Tqir5Q7kZajlu5gkmoqEhcZUfBOLxvFvBKV/yBNVn26cBWnqvSmQW5xnK9UqdmqAyAx
         ok5/d77uWdOv9lp07PhjupLWI72U/1w+b8kiruPCbMy6zs3iO8z1MCqlumvOgPEItaWr
         tZjqNwai3c9WRhw8pQ5+cwa6SOO2K08Pq+PLVXr1O3osuYBpFDj+ZBi5Alt4iRoN08zm
         7aq7Wp0uzRk2jjWWkkVOnH47TZO86H97KNOGABIlFeCh2i9inTmA1+XOs2yfq5H3WeKa
         iVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747283903; x=1747888703;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pbqrSEzLVPfD9Ggyo5gmKiNjk02F3GcErehRkTGB7Y=;
        b=NjN5zjlR4ejFQmfKf52wheRsPEsfebGho3+19CXdT52zBe8xrQz7OqB7CVd05orh5S
         WIfSR3y8mI3sb2qenDhcnAYFAuFnSbEvV+9YFSedV9nOJBFKF4xEWUHunBfRzWEW1sEd
         kpPaQqQywvreqafKWzZ41sXpqh5GbdVuZS1AJU279fKZ563AndRKaCNrkY0Nod+xmhw0
         +MSGeJzblnD4ZSH+yLsQ6XJwJoCAe+M7ZBMyDnC+jKwtzRhRBV4obZ0XQuhyhVlMCitk
         FFXF42FfTN3W94MTGsFM/uBLQJ2EMZie0eWKZzzL5AavfUPDHhvJSlgXx4rC5jXuqe7x
         OnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6spMzmdWZDc6ESMx3qp0avVfbLBP7+ymX1w/vQn5G25fEUCyWRGFXpZUhWseKl1odaLxSyMIxuhnLY4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIyeLJKLhw/kRQ3HEm1KdFaCArGPUuf5UZ2w6W4oEWjuI5Fj9
	TW7j4VoHBgJa8TvAk/ldTPSSlZedesZ8u54asMAyIE5tm98D8ZFYDcRSoboBdVUhTJrv/2ujjgX
	ZO7TUIg==
X-Google-Smtp-Source: AGHT+IHePfqB/icEtwp7NAC+XkzW36V7zHOK0wY87og4J6J6R9L0VypwPkQCzTYnC/P9i59cNiA5Wk3PY5n7
X-Received: from pfks12.prod.google.com ([2002:a05:6a00:194c:b0:740:6f6:7346])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a8:b0:740:67ce:1d8b
 with SMTP id d2e1a72fcca58-74289289c70mr7978403b3a.7.1747283903575; Wed, 14
 May 2025 21:38:23 -0700 (PDT)
Date: Wed, 14 May 2025 21:38:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250515043818.236807-1-irogers@google.com>
Subject: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on graniterapids
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On graniterapids the cache home agent (CHA) and memory controller
(IMC) PMUs all have their cpumask set to per-socket information. In
order for per NUMA node aggregation to work correctly the PMUs cpumask
needs to be set to CPUs for the relevant sub-NUMA grouping.

For example, on a 2 socket graniterapids machine with sub NUMA
clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
"0,120" leading to aggregation only on NUMA nodes 0 and 3:
```
$ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1

 Performance counter stats for 'system wide':

N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
N0        1     19,242,894,228      UNC_M_CLOCKTICKS
N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
N3        1     19,240,741,498      UNC_M_CLOCKTICKS

       1.002113847 seconds time elapsed
```

By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
the correctly 6 NUMA node aggregations are achieved:
```
$ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1

 Performance counter stats for 'system wide':

N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
N0        0      6,424,021,142      UNC_M_CLOCKTICKS
N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
N1        1      6,424,308,338      UNC_M_CLOCKTICKS
N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
N2        0      6,424,227,402      UNC_M_CLOCKTICKS
N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
N3        0      6,423,752,086      UNC_M_CLOCKTICKS
N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
N4        1      6,422,393,266      UNC_M_CLOCKTICKS
N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
N5        0      6,421,842,618      UNC_M_CLOCKTICKS

       1.003406645 seconds time elapsed
```

In general, having the perf tool adjust cpumasks isn't desirable as
ideally the PMU driver would be advertising the correct cpumask.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/pmu.c | 259 ++++++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 8712cbbbc712..38c800c6e9c8 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -8,6 +8,8 @@
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
+#include <api/io_dir.h>
+#include <internal/cpumap.h>
 #include <errno.h>
 
 #include "../../../util/intel-pt.h"
@@ -16,7 +18,247 @@
 #include "../../../util/fncache.h"
 #include "../../../util/pmus.h"
 #include "mem-events.h"
+#include "util/debug.h"
 #include "util/env.h"
+#include "util/header.h"
+
+static bool x86__is_intel_graniterapids(void)
+{
+	static bool checked_if_graniterapids;
+	static bool is_graniterapids;
+
+	if (!checked_if_graniterapids) {
+		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
+		char *cpuid = get_cpuid_str((struct perf_cpu){0});
+
+		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
+		free(cpuid);
+		checked_if_graniterapids = true;
+	}
+	return is_graniterapids;
+}
+
+static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
+{
+	struct perf_cpu_map *cpus;
+	char *buf = NULL;
+	size_t buf_len;
+
+	if (sysfs__read_str(sysfs_path, &buf, &buf_len) < 0)
+		return NULL;
+
+	cpus = perf_cpu_map__new(buf);
+	free(buf);
+	return cpus;
+}
+
+static int snc_nodes_per_l3_cache(void)
+{
+	static bool checked_snc;
+	static int snc_nodes;
+
+	if (!checked_snc) {
+		struct perf_cpu_map *node_cpus =
+			read_sysfs_cpu_map("devices/system/node/node0/cpulist");
+		struct perf_cpu_map *cache_cpus =
+			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
+
+		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
+		perf_cpu_map__put(cache_cpus);
+		perf_cpu_map__put(node_cpus);
+		checked_snc = true;
+	}
+	return snc_nodes;
+}
+
+static bool starts_with(const char *str, const char *prefix)
+{
+	return !strncmp(prefix, str, strlen(prefix));
+}
+
+static int num_chas(void)
+{
+	static bool checked_chas;
+	static int num_chas;
+
+	if (!checked_chas) {
+		int fd = perf_pmu__event_source_devices_fd();
+		struct io_dir dir;
+		struct io_dirent64 *dent;
+
+		if (fd < 0)
+			return -1;
+
+		io_dir__init(&dir, fd);
+
+		while ((dent = io_dir__readdir(&dir)) != NULL) {
+			/* Note, dent->d_type will be DT_LNK and so isn't a useful filter. */
+			if (starts_with(dent->d_name, "uncore_cha_"))
+				num_chas++;
+		}
+		close(fd);
+		checked_chas = true;
+	}
+	return num_chas;
+}
+
+#define MAX_SNCS 6
+
+static int uncore_cha_snc(struct perf_pmu *pmu)
+{
+	// CHA SNC numbers are ordered correspond to the CHAs number.
+	unsigned int cha_num;
+	int num_cha, chas_per_node, cha_snc;
+	int snc_nodes = snc_nodes_per_l3_cache();
+
+	if (snc_nodes <= 1)
+		return 0;
+
+	num_cha = num_chas();
+	if (num_cha <= 0) {
+		pr_warning("Unexpected: no CHAs found\n");
+		return 0;
+	}
+
+	/* Compute SNC for PMU. */
+	if (sscanf(pmu->name, "uncore_cha_%u", &cha_num) != 1) {
+		pr_warning("Unexpected: unable to compute CHA number '%s'\n", pmu->name);
+		return 0;
+	}
+	chas_per_node = num_cha / snc_nodes;
+	cha_snc = cha_num / chas_per_node;
+
+	/* Range check cha_snc. for unexpected out of bounds. */
+	return cha_snc >= MAX_SNCS ? 0 : cha_snc;
+}
+
+static int uncore_imc_snc(struct perf_pmu *pmu)
+{
+	// Compute the IMC SNC using lookup tables.
+	unsigned int imc_num;
+	int snc_nodes = snc_nodes_per_l3_cache();
+	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
+	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
+	const u8 *snc_map;
+	size_t snc_map_len;
+
+	switch (snc_nodes) {
+	case 2:
+		snc_map = snc2_map;
+		snc_map_len = ARRAY_SIZE(snc2_map);
+		break;
+	case 3:
+		snc_map = snc3_map;
+		snc_map_len = ARRAY_SIZE(snc3_map);
+		break;
+	default:
+		/* Error or no lookup support for SNC with >3 nodes. */
+		return 0;
+	}
+
+	/* Compute SNC for PMU. */
+	if (sscanf(pmu->name, "uncore_imc_%u", &imc_num) != 1) {
+		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
+		return 0;
+	}
+	if (imc_num >= snc_map_len) {
+		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
+		return 0;
+	}
+	return snc_map[imc_num];
+}
+
+static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
+{
+	static bool checked_cpu_adjust[MAX_SNCS];
+	static int cpu_adjust[MAX_SNCS];
+	struct perf_cpu_map *node_cpus;
+	char node_path[] = "devices/system/node/node0/cpulist";
+
+	/* Was adjust already computed? */
+	if (checked_cpu_adjust[pmu_snc])
+		return cpu_adjust[pmu_snc];
+
+	/* SNC0 doesn't need an adjust. */
+	if (pmu_snc == 0) {
+		cpu_adjust[0] = 0;
+		checked_cpu_adjust[0] = true;
+		return 0;
+	}
+
+	/*
+	 * Use NUMA topology to compute first CPU of the NUMA node, we want to
+	 * adjust CPU 0 to be this and similarly for other CPUs if there is >1
+	 * socket.
+	 */
+	node_path[24] = pmu_snc; // Shift node0 to be node<pmu_snc>.
+	node_cpus = read_sysfs_cpu_map(node_path);
+	cpu_adjust[pmu_snc] = perf_cpu_map__cpu(node_cpus, 0).cpu;
+	checked_cpu_adjust[pmu_snc] = true;
+	perf_cpu_map__put(node_cpus);
+	return cpu_adjust[pmu_snc];
+}
+
+static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+{
+	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
+	// topology. For example, a two socket graniterapids machine may be set
+	// up with 3-way SNC meaning there are 6 NUMA nodes that should be
+	// displayed with --per-node. The cpumask of the CHA and IMC PMUs
+	// reflects per-socket information meaning, for example, uncore_cha_60
+	// on a two socket graniterapids machine with 120 cores per socket will
+	// have a cpumask of "0,120". This cpumask needs adjusting to "40,160"
+	// to reflect that uncore_cha_60 is used for the 2nd SNC of each
+	// socket. Without the adjustment events on uncore_cha_60 will appear in
+	// node 0 and node 3 (in our example 2 socket 3-way set up), but with
+	// the adjustment they will appear in node 1 and node 4. The number of
+	// CHAs is typically larger than the number of cores. The CHA numbers
+	// are assumed to split evenly and inorder wrt core numbers. There are
+	// fewer memory IMC PMUs than cores and mapping is handled using lookup
+	// tables.
+	static struct perf_cpu_map *cha_adjusted[MAX_SNCS];
+	static struct perf_cpu_map *imc_adjusted[MAX_SNCS];
+	struct perf_cpu_map **adjusted = cha ? cha_adjusted : imc_adjusted;
+	int idx, pmu_snc, cpu_adjust;
+	struct perf_cpu cpu;
+	bool alloc;
+
+	// Cpus from the kernel holds first CPU of each socket. e.g. 0,120
+	assert(perf_cpu_map__cpu(pmu->cpus, 0).cpu == 0);
+
+	pmu_snc = cha ? uncore_cha_snc(pmu) : uncore_imc_snc(pmu);
+	if (pmu_snc == 0) {
+		// No adjustment necessary for the first SNC.
+		return;
+	}
+
+	alloc = adjusted[pmu_snc] == NULL;
+	if (alloc) {
+		// Hold onto the perf_cpu_map globally to avoid recomputation.
+		cpu_adjust = uncore_cha_imc_compute_cpu_adjust(pmu_snc);
+		adjusted[pmu_snc] = perf_cpu_map__empty_new(perf_cpu_map__nr(pmu->cpus));
+		if (!adjusted[pmu_snc])
+			return;
+	}
+
+	perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
+		// Compute the new cpu map values or if not allocating, assert
+		// that they match expectations. asserts will be removed to
+		// avoid overhead in NDEBUG builds.
+		if (alloc) {
+			adjusted[pmu_snc]->map[idx].cpu = cpu.cpu + cpu_adjust;
+		} else if (idx == 0) {
+			cpu_adjust = perf_cpu_map__cpu(adjusted[pmu_snc], idx).cpu - cpu.cpu;
+			assert(uncore_cha_imc_compute_cpu_adjust(pmu_snc) == cpu_adjust);
+		} else {
+			assert(perf_cpu_map__cpu(adjusted[pmu_snc], idx).cpu ==
+			       cpu.cpu + cpu_adjust);
+		}
+	}
+
+	perf_cpu_map__put(pmu->cpus);
+	pmu->cpus = perf_cpu_map__get(adjusted[pmu_snc]);
+}
 
 void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
@@ -49,10 +291,17 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 
 		perf_mem_events__loads_ldlat = 0;
 		pmu->mem_events = perf_mem_events_amd_ldlat;
-	} else if (pmu->is_core) {
-		if (perf_pmu__have_event(pmu, "mem-loads-aux"))
-			pmu->mem_events = perf_mem_events_intel_aux;
-		else
-			pmu->mem_events = perf_mem_events_intel;
+	} else {
+		if (pmu->is_core) {
+			if (perf_pmu__have_event(pmu, "mem-loads-aux"))
+				pmu->mem_events = perf_mem_events_intel_aux;
+			else
+				pmu->mem_events = perf_mem_events_intel;
+		} else if (x86__is_intel_graniterapids()) {
+			if (starts_with(pmu->name, "uncore_cha_"))
+				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
+			else if (starts_with(pmu->name, "uncore_imc_"))
+				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
+		}
 	}
 }
-- 
2.49.0.1045.g170613ef41-goog


